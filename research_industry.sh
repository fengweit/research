#!/bin/zsh
# Usage: ./research_industry.sh <industry_index> <industry_name> <output_file>

INDUSTRY="$2"
OUTPUT="$3"
LOG="/Users/yuqi/research/findings/logs/$(basename $OUTPUT .json).log"

mkdir -p /Users/yuqi/research/findings/logs

echo "[$(date)] Starting research: $INDUSTRY" | tee "$LOG"

PROMPT="You are an Industry Scout + Niche Analyst Agent. Research industry: $INDUSTRY

Today's date is 2026-03-04. Focus on AI-agent and solo-entrepreneur opportunities.

Your task:
1. Describe how money flows through this industry in 2-3 sentences
2. List 10 specific sub-niches with ratings: market_size (1-10), automation_potential (1-10), saturation (1-10, higher=more saturated)
3. Pick the TOP 3 niches (high market size, high automation potential, low saturation)
4. For each top niche, generate 3 SPECIFIC automatable money-making opportunities

Scoring formula: risk_adjusted_score = profitability_score - (risk_score × 0.35) - (effort_score × 0.15)

Be EXTREMELY specific. Not 'build an app' but 'build a Plaid-powered interest rate arbitrage monitor that alerts users when HYSA rates diverge >0.5% and auto-suggests optimal cash placement'.

Focus on what a SOLO ENTREPRENEUR can build with AI agents in 2026.

Return ONLY valid JSON in this exact format:
{
  \"industry\": \"$INDUSTRY\",
  \"money_flow_summary\": \"...\",
  \"niches\": [
    {
      \"name\": \"...\",
      \"market_size\": 1-10,
      \"automation_potential\": 1-10,
      \"saturation\": 1-10,
      \"opportunity_score\": computed_float
    }
  ],
  \"top_opportunities\": [
    {
      \"title\": \"...\",
      \"niche\": \"...\",
      \"mechanism\": \"one of: Arbitrage/Automation/Information Edge/Take-Rate/Yield/Attention/Subscription/Flip\",
      \"how_money_is_made\": \"specific 2-3 sentence description\",
      \"revenue_potential\": \"\$X-\$Y/mo\",
      \"setup_cost\": \"\$...\",
      \"setup_time\": \"...\",
      \"profitability_score\": number,
      \"risk_score\": number,
      \"effort_score\": number,
      \"risk_adjusted_score\": computed_float,
      \"timeframe\": \"24/7 passive|market hours|event-driven|scheduled\",
      \"moat\": \"...\",
      \"first_step\": \"single most important first action\",
      \"ai_agent_angle\": \"how AI agents specifically enable or amplify this opportunity\"
    }
  ]
}"

/Users/yuqi/.local/bin/claude -p "$PROMPT" --output-format json 2>>"$LOG" | python3 -c "
import sys, json
data = sys.stdin.read()
# Try to extract JSON from the response
import re
# Find JSON content
match = re.search(r'\{.*\}', data, re.DOTALL)
if match:
    try:
        parsed = json.loads(match.group())
        print(json.dumps(parsed, indent=2))
    except:
        print(data)
else:
    print(data)
" > "$OUTPUT" 2>>"$LOG"

echo "[$(date)] Completed research: $INDUSTRY -> $OUTPUT" | tee -a "$LOG"
