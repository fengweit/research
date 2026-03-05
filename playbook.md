# Internet Income Research Playbook
## Multi-Agent Architecture & Execution Framework

> **How to use this doc:** Feed this to an orchestrator agent. It will spawn the correct sub-agents, assign roles, coordinate research passes, and deliver a ranked opportunity report. Repeat on any cadence (weekly, monthly) to catch new market shifts.

---

## 1. The Core Problem This Solves

Manual research into "where to make money online" is:
- Too broad (infinite industries, infinite niches)
- Stale quickly (markets shift, arbitrages close, new platforms emerge)
- Biased (humans gravitate to what they already know)

A multi-agent system solves this by **dividing the research space into parallel lanes**, each with a specialist agent, all coordinated by an orchestrator that synthesizes findings into an actionable, ranked output.

---

## 2. Research Philosophy

Every opportunity on the internet fits one of these **money mechanisms**. Agents should always anchor findings to a mechanism:

| Mechanism | How Money Is Made | Example |
|---|---|---|
| **Arbitrage** | Buy low in market A, sell high in market B | CEX/DEX spread, retail-to-Amazon flip |
| **Automation** | Replace human labor with a bot | AI content farm, data scraping pipeline |
| **Information Edge** | Know something the market doesn't yet | SEC filing alerts, job posting signals |
| **Take-Rate** | Clip % of every transaction through a platform | Marketplace, payment processor |
| **Yield** | Deploy capital, collect passive return | DeFi staking, P2P lending |
| **Attention** | Build audience, monetize via ads/sponsors | YouTube channel, newsletter |
| **Subscription** | Recurring access to tool or data | SaaS, API, signal service |
| **Flip** | Buy undervalued asset, resell at market rate | Domain flipping, sneaker bot |

**Rule:** An opportunity is only worth pursuing if it is (a) automatable, (b) repeatable, and (c) scalable without linear human time input.

---

## 3. Multi-Agent Architecture

### Agent Hierarchy

```
┌─────────────────────────────────────────────────────┐
│                  ORCHESTRATOR AGENT                  │
│  • Assigns tasks to all sub-agents                  │
│  • Tracks progress and handles failures             │
│  • Synthesizes all outputs into final report        │
│  • Scores and ranks opportunities                   │
│  • Decides which ideas pass to Validation layer     │
└──────────────────┬──────────────────────────────────┘
                   │ spawns & coordinates
       ┌───────────┼────────────────┐
       ▼           ▼                ▼
  LAYER 1      LAYER 2          LAYER 3
  Industry     Niche            Validation
  Scouts       Analysts         Agents
  (18 agents)  (180 agents)     (top 20 ideas)
```

### Layer 1 — Industry Scout Agents (18 agents)
**One agent per major internet industry.**

Each agent is responsible for:
- Mapping the full money flow of their industry
- Identifying all sub-niches (target: 8–12 per industry)
- Flagging which niches are currently hot vs saturated
- Estimating total addressable opportunity per niche
- Passing structured niche list to Layer 2

**Industries covered:**
1. FinTech & Financial Services
2. Advertising & AdTech
3. E-Commerce & Retail
4. SaaS & Software
5. Content & Media
6. Data & Analytics
7. Crypto & Web3
8. AI & Machine Learning
9. Marketplaces & Platforms
10. Gaming & Interactive
11. Health & MedTech
12. Education & EdTech
13. Real Estate & PropTech
14. Logistics & Supply Chain
15. Cybersecurity
16. Travel & Hospitality
17. HR & Future of Work
18. Energy & CleanTech

**Prompt template for Industry Scout:**
```
You are an Industry Scout Agent for: [INDUSTRY NAME]

Your job:
1. Describe how money flows through this industry in 2-3 sentences
2. List 10 specific sub-niches within this industry
3. For each niche, rate: Market Size (1-10), Automation Potential (1-10), Current Saturation (1-10, higher = more saturated)
4. Flag the top 3 highest-opportunity niches based on: large market + high automation potential + low saturation

Return structured JSON only.
```

---

### Layer 2 — Niche Analyst Agents (180 agents)
**One agent per niche (18 industries × 10 niches = 180 agents).**

Each agent is responsible for:
- Deep-diving into one specific niche
- Generating exactly 3 concrete, automatable opportunities
- For each opportunity: title, mechanism, how money is made, setup cost, risk score, effort score, profitability score, revenue model, timeframe
- Flagging any unfair advantages or moats (data access, network effects, technical barriers)

**Prompt template for Niche Analyst:**
```
You are a Niche Analyst Agent specializing in: [NICHE] within [INDUSTRY]

Money flow context: [From Layer 1 output]

Your job: Generate exactly 3 highly specific, automated or semi-automated opportunities to make money in this niche.

Rules:
- Must be realistic and executable today
- Must be automatable (bot, script, AI system, or passive setup)
- Must be specific (not "start a blog" — instead "build a programmatic SEO site targeting [specific keyword cluster] monetized with [specific affiliate program]")

For each opportunity return:
{
  "title": "short name",
  "mechanism": "which of: Arbitrage / Automation / Information Edge / Take-Rate / Yield / Attention / Subscription / Flip",
  "how_money_is_made": "2-3 sentences, very specific",
  "revenue_potential": "realistic monthly range e.g. $500-$3,000/mo",
  "setup_cost": "cost to start",
  "setup_time": "days/weeks to launch",
  "profitability_score": 1-10,
  "risk_score": 1-10,
  "effort_score": 1-10,
  "timeframe": "24/7 / passive / market hours / event-driven",
  "moat": "what makes this defensible or repeatable"
}
```

---

### Layer 3 — Validation Agents (up to 20 agents)
**Spawned only for top-scoring ideas from Layer 2.**

The Orchestrator selects the top 20 opportunities by risk-adjusted score and assigns one Validation Agent to each.

Each Validation Agent is responsible for:
- Stress-testing the opportunity (what kills this idea?)
- Estimating realistic competition level
- Checking if the mechanism still works today (is the arbitrage still open? is the platform still accessible?)
- Estimating realistic ramp-up timeline to profitability
- Producing a final GO / NO-GO / NEEDS MORE RESEARCH verdict with reasoning

**Prompt template for Validation Agent:**
```
You are a Validation Agent. You've been given this opportunity to stress-test:

[OPPORTUNITY JSON from Layer 2]

Your job is to pressure-test this idea rigorously. Answer:

1. COMPETITION: How saturated is this specific approach? Who is already doing this at scale?
2. EXECUTION RISK: What are the top 3 ways this fails?
3. PLATFORM RISK: Does this depend on a platform that could change its API, terms, or pricing?
4. CAPITAL RISK: What is the realistic worst-case loss scenario?
5. TIME TO FIRST DOLLAR: Realistic estimate to first revenue?
6. DEFENSIBILITY: Can a competitor easily copy this once it works?
7. VERDICT: GO / NO-GO / NEEDS MORE RESEARCH
8. IF GO: What is the single most important first step?

Return structured JSON.
```

---

### Supporting Agents (always-on)

These agents run in parallel throughout the full research cycle:

| Agent | Role | Always Running |
|---|---|---|
| **Trend Watcher** | Monitors Twitter/X, HN, Reddit for emerging opportunities mentioned in the last 7 days | Yes |
| **Failure Analyst** | Researches why similar ideas have failed historically. Prevents repeating known mistakes | Yes |
| **Regulation Scanner** | Flags legal/TOS risks for any idea involving platforms, financial instruments, or data | Yes |
| **Competitive Intel** | Searches for who is already doing each validated idea and at what scale | Yes |
| **Stack Recommender** | For each GO idea, recommends the exact tech stack to build it (tools, APIs, infra) | On-demand |

---

## 4. Research Execution Flow

### Phase 1 — Industry Mapping (run Layer 1)
**Duration:** ~10–15 minutes  
**Agents active:** 18 Industry Scouts  
**Output:** Structured JSON of all industries → niches → opportunity ratings

```
Orchestrator → spawn 18 Industry Scout agents in parallel
             → collect structured niche maps
             → deduplicate overlapping niches across industries
             → rank niches by (market size × automation potential) / saturation
             → pass top 180 niches to Phase 2
```

---

### Phase 2 — Opportunity Discovery (run Layer 2)
**Duration:** ~20–40 minutes (batched, 3 agents at a time to avoid rate limits)  
**Agents active:** Up to 180 Niche Analysts  
**Output:** Up to 540 raw opportunities with scores

```
Orchestrator → spawn Niche Analyst agents in batches of 3
             → 700ms pause between batches
             → collect all opportunities as they complete
             → apply scoring formula:
               risk_adjusted_score = profitability - (risk × 0.35) - (effort × 0.15)
             → sort descending by risk_adjusted_score
             → pass top 20 to Phase 3
```

**Scoring formula:**
```
risk_adjusted_score = profitability_score
                    - (risk_score × 0.35)
                    - (effort_score × 0.15)

# Weights rationale:
# Profitability is the primary driver
# Risk penalized more than effort (can hire help, can't undo losses)
# Effort matters but less — automation compresses it over time
```

---

### Phase 3 — Validation (run Layer 3)
**Duration:** ~10–20 minutes  
**Agents active:** Up to 20 Validation Agents (one per top idea)  
**Output:** Final GO / NO-GO verdicts with detailed reasoning

```
Orchestrator → take top 20 by risk_adjusted_score from Phase 2
             → spawn 20 Validation Agents in parallel
             → collect verdicts
             → filter to GO ideas only
             → sort by risk_adjusted_score within GO set
```

---

### Phase 4 — Synthesis (Orchestrator only)
**Duration:** ~2–3 minutes  
**Output:** Final ranked report

```
Orchestrator → compile all GO ideas into final report
             → for each idea: include full detail + validation notes + stack recommendation
             → group by: mechanism type, setup cost tier, timeframe
             → highlight top 5 "start immediately" picks
             → flag top 3 "high-potential but needs validation" picks
             → output as structured markdown report
```

---

## 5. Scoring & Ranking System

### Primary Score (for sorting)
```
risk_adjusted_score = profitability - (risk × 0.35) - (effort × 0.15)
```

### Tier Classification
| Tier | Score Range | Label |
|---|---|---|
| S | 8.0+ | Start immediately |
| A | 7.0–7.9 | Strong opportunity, needs setup |
| B | 6.0–6.9 | Worth pursuing if resources allow |
| C | < 6.0 | Low priority or high risk |

### Filtering Dimensions
Agents should always output enough metadata to allow filtering by:
- **Setup cost tier:** Bootstrap ($0–$500) / Low ($500–$5k) / Medium ($5k–$50k) / High ($50k+)
- **Timeframe:** 24/7 passive / Market hours / Event-driven / Scheduled
- **Mechanism type:** (see Section 2)
- **Time to first revenue:** < 1 week / 1–4 weeks / 1–3 months / 3+ months
- **Industry**
- **Niche**

---

## 6. Repeat Cadence

This research loop should be re-run on a schedule because:
- Arbitrage opportunities close (competitors enter, platforms patch gaps)
- New platforms launch (new arbitrage surfaces)
- AI tools improve (new automation becomes possible)
- Regulations change (some ideas get killed, others unlock)

| Frequency | What to Re-Run |
|---|---|
| **Weekly** | Trend Watcher agent only — surface new platforms, threads, opportunities |
| **Monthly** | Full Phase 1 → 4 research cycle |
| **Quarterly** | Re-validate all currently-active GO ideas — are they still working? |
| **On trigger** | Re-run Validation Agent for any idea when a major platform/market event occurs |

---

## 7. Output Format

The final report produced by the Orchestrator should always contain:

```markdown
# Income Opportunity Report
Generated: [DATE]
Cycle: [run number]

## Executive Summary
- Total niches researched: X
- Total opportunities evaluated: X
- GO verdicts: X
- Top mechanism this cycle: [e.g. Arbitrage]

## Top 5 Start-Immediately Picks
[ranked list with full detail]

## Full Ranked GO List
[all GO ideas sorted by risk_adjusted_score]

## Watchlist (NEEDS MORE RESEARCH)
[ideas that passed Layer 2 but need more validation]

## Killed Ideas (NO-GO with reasoning)
[what was rejected and why — useful to avoid re-researching]
```

---

## 8. Agent Failure Handling

Agents will sometimes fail (timeout, API error, bad output). The Orchestrator must handle this:

```
if agent returns empty or malformed output:
  → retry once after 5 second delay
  → if retry fails: mark niche as "skipped"
  → log skipped niches for manual review
  → do not block other agents — continue batch

if >20% of agents in a batch fail:
  → pause 60 seconds (likely rate limit)
  → reduce batch size from 3 to 2
  → resume
```

---

## 9. Quick-Start Prompt for Orchestrator

Copy this prompt to start a full research run:

```
You are the Orchestrator Agent for an Internet Income Research System.

Your job is to coordinate a multi-agent research pipeline that identifies the best automated income opportunities across all major internet industries.

Follow this execution plan:

PHASE 1: Spawn 18 Industry Scout agents (one per industry listed in the playbook). Collect their niche maps.

PHASE 2: For each niche returned, spawn a Niche Analyst agent. Run in batches of 3. Collect all opportunities.

PHASE 3: Take the top 20 opportunities by risk-adjusted score. Spawn Validation agents for each. Collect GO/NO-GO verdicts.

PHASE 4: Compile all GO ideas into a final ranked report.

Throughout all phases:
- Always use scoring formula: risk_adjusted_score = profitability - (risk × 0.35) - (effort × 0.15)
- Pause 700ms between batches
- Retry failed agents once before skipping
- Output structured JSON at each phase boundary

Begin Phase 1 now.
```

---

## 10. Key Principles for All Agents

1. **Be specific, not generic.** "Start an Amazon FBA business" is not an opportunity. "Use Jungle Scout to find products with <30 reviews, >$25 price, and <10 sellers, source from Alibaba at <20% of listing price" is an opportunity.

2. **Anchor to mechanism.** Every idea must clearly state how money moves from one party to another and why you capture a piece of it.

3. **Assume automation.** If a human needs to be involved more than 2 hours per week to run it, it's not a target opportunity for this system.

4. **Surface moats.** Opportunities with data advantages, network effects, or technical barriers are more valuable than open arbitrages that will close.

5. **Kill bad ideas fast.** A decisive NO-GO with clear reasoning is as valuable as a GO. Do not hedge.

6. **Score conservatively.** If unsure whether profitability is 7 or 8, score 7. Optimism bias kills execution.

