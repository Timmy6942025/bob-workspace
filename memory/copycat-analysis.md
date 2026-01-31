# CopyCat Analysis - AI Copy Trading Bot

**Date:** January 31, 2026  
**Status:** Deep exploration in progress  
**Files:** 1,669 Python files, 481+ tests

## What is CopyCat?

An intelligent copy trading system for prediction markets (Polymarket) that:
1. **Discovers** profitable traders via historical analysis
2. **Filters out bots** (HFT, arbitrage) to avoid copying machines
3. **Scores traders** using multi-factor analysis (Sharpe ratio, drawdown, growth)
4. **Copies trades** automatically in sandbox or live mode
5. **Optimizes** with 8 speed features for maximum growth

## Architecture

### Core Components

| Component | Location | Purpose |
|-----------|----------|---------|
| **Orchestrator** | `orchestrator/engine.py` (1,284 lines) | Main coordination - ⚠️ God class |
| **Trader ID** | `trader_identification/` | Growth-based trader discovery |
| **Bot Filter** | `bot_filtering/` | HFT/arbitrage detection |
| **Sandbox** | `sandbox/` | Paper trading simulation |
| **Live Trading** | `live_trading/` | Real-money execution |
| **Dashboard** | `dashboard/app.py` | Flask web UI on :5000 |

### Key Classes

- `CopyCatOrchestrator` - Main coordinator (god class)
- `SandboxRunner` - Virtual trading engine
- `TraderIdentificationEngine` - Growth-based selection
- `BotFilter` - Automated trading detection
- `VirtualPortfolioManager` - Position tracking

## Special Modes

### Micro Mode ($10-$100 accounts)
4-tier auto-transition system:
- **NANO** ($0-$15): 75% position size, 30% max drawdown
- **MICRO** ($15-$25): 60% position size, 25% max drawdown
- **MINI** ($25-$50): 50% position size, 20% max drawdown
- **BALANCED** ($50-$200): 40% position size, 18% max drawdown

Features:
- Circuit breaker protection
- Milestone notifications (Discord)
- Bootstrap trading (26 hardcoded profitable traders)
- Quick resolve prioritization (skip long markets)

### Speed Mode (8 Optimizations)
1. Tiered copying (performance-based position sizing)
2. Momentum trading (trend following)
3. Event-based trading (news catalysts)
4. Hedging strategies (risk mitigation)
5. Portfolio optimizer (Kelly criterion)
6. Adaptive allocation (dynamic rebalancing)
7. Bootstrap mode (quick-start with known traders)
8. Speed optimizer (execution latency)

### Basket Trading (New)
Topic-based wallet baskets for consensus-driven strategies:
- Group wallets by expertise (geopolitics, crypto, sports)
- 80%+ basket agreement triggers trades
- Price band filtering (5% max spread)
- Copycat cluster detection (exclude correlated wallets)

## Bot Detection Algorithms

The bot filtering uses multiple heuristics:
- **HFT Detection**: High trade frequency patterns
- **Arbitrage Detection**: Cross-market price exploitation
- **Position Sizing Anomalies**: Unusual bet sizing patterns
- **Trading Hours Analysis**: 24/7 vs human trading patterns
- **Micro-Trade Detection**: Thousands of tiny trades per day

## Trader Scoring

Multi-factor analysis:
- **Growth-First**: Account growth over win rate
- **Sharpe Ratio**: Risk-adjusted returns
- **Max Drawdown**: Peak-to-trough decline
- **Profit Factor**: Gross profit / gross loss
- **Consistency**: Win rate stability
- **Recent Performance**: 7d/30d weighted higher than all-time

## Technical Stack

- **Python 3.11+** with asyncio
- **Polymarket API** (CLOB, Gamma, Data)
- **Pandas/Numpy** for analysis
- **Rich** for CLI output
- **Flask** for dashboard
- **pytest** for testing (481+ tests)

## Anti-Patterns (Noted in AGENTS.md)

❌ God class: `orchestrator/engine.py` (1,284 lines)
❌ Config proliferation: 14+ overlapping config files
❌ Hardcoded values: Trader addresses, thresholds in code
❌ Data model duplication: Order types defined multiple places
❌ State mutation: Direct state modification everywhere

## Strengths

✅ Zero anti-patterns in source (no TODO/FIXME/HACK)
✅ 28% test coverage with 480+ tests
✅ Modern Python (dataclasses, async, type hints)
✅ Clear domain boundaries
✅ Parallel analysis (asyncio.gather for 10-50x speedup)

## Recent Commits (Active Development)

1. Security, data integrity, architecture improvements
2. Topic-based wallet basket trading
3. Quick resolve prioritization
4. Auto mode transition in orchestrator
5. Micro Mode with full sandbox/live parity
6. Micro Mode for $10 starting capital
7. Boost Mode for aggressive growth
8. Removed Kalshi, now Polymarket-only

## Bot Detection Algorithms (Deep Dive)

### HFT Detection
- **Hold Time**: <1 second = HFT indicator
- **Trade Frequency**: >5 trades/minute = sustained HFT
- **Scoring**:
  - >50% HFT ratio: +0.5 score
  - >20% HFT ratio: +0.2 score
  - Sustained activity: +0.3 score
  - Extreme (>80% + sustained): +0.2 score

### Arbitrage Detection
- **Small Profits**: <0.5% profit per trade (consistent arbitrage pattern)
- **Multi-Market**: Trading across multiple markets simultaneously
- **Consistent Timing**: Low variance in hold times
- **Scoring**:
  - >70% small-trade ratio: +0.5 score
  - Multi-market trading: +0.2 score
  - Consistent timing: +0.2 score

### Pattern Bot Detection
- **Consistent Timing**: Low variance in trade intervals
- **Fixed Sizing**: Low variance in position sizes
- **24/7 Trading**: Activity outside human hours

## Trader Scoring Algorithm

### Performance Metrics
- **Win Rate**: len(winning_trades) / total_trades
- **Profit Factor**: gross_profits / gross_losses (0 if no losses)
- **Sharpe Ratio**: Risk-adjusted returns (simplified, 0% risk-free)
- **Max Drawdown**: Peak-to-trough decline
- **Average Hold Time**: Mean of all hold times
- **Total P&L**: Sum of all trade P&Ls

### Insider Trading Detection
- **Early Position Score**: Entering before price moves
- **Event Correlation Score**: Trading before news/events
- **Category Expertise Score**: Consistent wins in specific markets
- **Flags**: Early positions + event correlation = likely insider

### Reputation Score Calculation
Combines:
- Performance metrics (weighted)
- Inverse insider score (penalty for suspicious activity)
- Inverse bot score (penalty for automated patterns)
- Trade count confidence (more trades = higher confidence)

## Micro Mode Architecture

### 3-Tier System
| Level | Balance | Position Size | Kelly | Max Drawdown |
|-------|---------|---------------|-------|--------------|
| **NANO** | $10-$15 | 75% | 0.75 | 30% |
| **MICRO** | $15-$25 | 60% | 0.75 | 25% |
| **MINI** | $25-$50 | 50% | 0.50 | 20% |
| **BALANCED** | $50-$200 | 40% | 0.40 | 18% |

### Key Optimizations
- **10-second trading cycles** (30x faster than default)
- **50-75% position sizes** (maximize capital utilization)
- **Bootstrap trading** (26 hardcoded profitable traders for instant start)
- **No hedging** (100% growth capital)
- **High Kelly fraction** (2x-3x standard)
- **Lenient qualification** (faster trader discovery)

### Feature Toggles by Mode
| Feature | NANO/MICRO | Reason |
|---------|------------|--------|
| Tiered Copying | ON | Performance-based sizing |
| Momentum Filter | OFF | Too restrictive |
| Event Focus | ON | News catalysts |
| Hedging | OFF | Need 100% growth capital |
| Optimizer | ON | Kelly criterion sizing |
| Bootstrap | ON | Critical for fast start |
| Boost Mode | ON | Always on for micro |

## Circuit Breaker Protection

Mode-specific drawdown thresholds trigger auto-stop:
- NANO: 30% max drawdown
- MICRO: 25% max drawdown
- MINI: 20% max drawdown
- BALANCED: 18% max drawdown

Auto-transition between modes as balance grows with Discord notifications at $20, $50, $100 milestones.

## My Assessment

This is a sophisticated, production-ready trading system. Timmy's not just experimenting—he's building something that could actually generate returns. The micro mode for $10 accounts is particularly clever (aggressive growth with circuit breakers). The basket trading feature shows he's thinking about diversification and consensus strategies.

The god class and config fragmentation are technical debt, but the test coverage and async architecture are solid. This is serious work.

**Next:** Explore basket trading system and quick resolve prioritization.
