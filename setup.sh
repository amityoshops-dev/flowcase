#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"
mkdir -p src .github/workflows
cat > package.json <<'EOF_FC_0'
{"name":"flowcase","private":true,"type":"module","scripts":{"dev":"vite","build":"vite build"},"dependencies":{"react":"^18.3.1","react-dom":"^18.3.1"},"devDependencies":{"@vitejs/plugin-react":"^4.3.1","vite":"^5.4.0","vite-plugin-singlefile":"^2.0.2"}}
EOF_FC_0
cat > vite.config.js <<'EOF_FC_1'
import {defineConfig} from 'vite';import react from '@vitejs/plugin-react';import {viteSingleFile} from 'vite-plugin-singlefile';
export default defineConfig({base:'./',plugins:[react(),viteSingleFile()]});
EOF_FC_1
cat > index.html <<'EOF_FC_2'
<!DOCTYPE html><html lang="en"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1,viewport-fit=cover"><title>FlowCase · Neumorphic Payment Dashboard</title></head><body><div id="root"></div><script type="module" src="/src/main.jsx"></script></body></html>
EOF_FC_2
cat > README.md <<'EOF_FC_3'
# FlowCase: Neumorphic Payment Dashboard
React + Vite. Simulated live rails (RTGS, UPI, SWIFT ISO 20022, Escrow, ACH/NACH), case inspection, ledger.

    npm install && npm run dev

Push to main; Settings > Pages > Source: GitHub Actions.
EOF_FC_3
cat > .gitignore <<'EOF_FC_4'
node_modules
dist
EOF_FC_4
cat > .github/workflows/deploy.yml <<'EOF_FC_5'
name: Deploy to GitHub Pages
on: {push: {branches: [main]}, workflow_dispatch: {}}
permissions: {contents: read, pages: write, id-token: write}
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with: {node-version: 20}
      - run: npm install --no-audit --no-fund && npm run build
      - uses: actions/upload-pages-artifact@v3
        with: {path: dist}
  deploy:
    needs: build
    runs-on: ubuntu-latest
    environment: {name: github-pages, url: '${{ steps.d.outputs.page_url }}'}
    steps:
      - id: d
        uses: actions/deploy-pages@v4
EOF_FC_5
cat > src/main.jsx <<'EOF_FC_6'
import {createRoot} from 'react-dom/client';import './s.css';import App from './App.jsx';createRoot(document.getElementById('root')).render(<App/>);
EOF_FC_6
cat > src/s.css <<'EOF_FC_7'
:root{--bg:#E0E5EC;--sd:rgba(163,177,198,.65);--sl:rgba(255,255,255,.8);--pr:#4D79FF;--ok:#28A745;--er:#DC3545;--tx:#4A5568;--mu:#6b7a90;--r:8px 8px 16px var(--sd),-8px -8px 16px var(--sl);--rs:4px 4px 10px var(--sd),-4px -4px 10px var(--sl);--i:inset 5px 5px 10px var(--sd),inset -5px -5px 10px var(--sl);--is:inset 3px 3px 6px var(--sd),inset -3px -3px 6px var(--sl)}
*{box-sizing:border-box;margin:0;padding:0;font-family:Inter,system-ui,sans-serif}body{background:var(--bg);color:var(--tx);padding:max(20px,env(safe-area-inset-top)) 20px 30px;display:flex;justify-content:center}
.app{width:100%;max-width:1200px;display:flex;flex-direction:column;gap:24px}.nav{display:flex;align-items:center;justify-content:space-between;gap:12px;flex-wrap:wrap;padding:14px 24px;border-radius:20px;box-shadow:var(--r)}
.brand{display:flex;align-items:center;gap:12px;font-weight:700;font-size:20px}.logo{width:36px;height:36px;border-radius:10px;box-shadow:var(--rs);display:grid;place-items:center;color:var(--pr);font-weight:800}
.links{display:flex;gap:8px;flex-wrap:wrap}.lk{padding:8px 16px;border:0;background:none;border-radius:12px;font:600 14px Inter;cursor:pointer;color:var(--mu)}.lk.on{color:var(--pr);box-shadow:var(--is)}
.right{display:flex;align-items:center;gap:12px}.srch{background:var(--bg);border:0;outline:0;padding:10px 16px;border-radius:12px;box-shadow:var(--is);color:var(--tx);font-size:14px;width:190px}
.ib{height:40px;min-width:40px;padding:0 12px;border-radius:20px;border:0;background:var(--bg);box-shadow:var(--rs);cursor:pointer;font:600 13px Inter;color:var(--tx)}.ib:active,.ib.on{box-shadow:var(--is)}
.g{display:grid;gap:20px}.g4{grid-template-columns:repeat(auto-fit,minmax(200px,1fr))}.g2{grid-template-columns:2fr 1fr}@media(max-width:860px){.g2{grid-template-columns:1fr}}
.c{background:var(--bg);border-radius:18px;padding:22px;box-shadow:var(--r);min-width:0}.c h3{font-size:17px;margin-bottom:12px}.k{font-size:12px;color:var(--mu);font-weight:600;text-transform:uppercase;letter-spacing:.5px}.kv{font-size:27px;font-weight:700;margin-top6px}
.kv{margin-top:6px}.p{display:inline-block;font-size:12px;padding:3px 8px;border-radius:6px;font-weight:600;margin-top:6px}.p.ok{background:rgba(40,167,69,.15);color:#1e7e34}.p.er{background:rgba(220,53,69,.13);color:#b02a37}.p.bl{background:rgba(77,121,255,.15);color:#2f56d6}.p.wa{background:rgba(255,193,7,.22);color:#7a5b00}
.btn{border:0;outline:0;padding:11px 18px;border-radius:12px;background:var(--bg);box-shadow:var(--rs);color:var(--pr);font:600 14px Inter;cursor:pointer;width:100%}.btn:active,.btn.on{box-shadow:var(--is);transform:translateY(1px)}.btn.d{color:var(--er)}.btn.s{width:auto}
.in{box-shadow:var(--i);border-radius:12px;padding:14px}.row{display:flex;justify-content:space-between;align-items:center;gap:10px;padding:10px 0;border-bottom:1px solid rgba(163,177,198,.3);cursor:pointer}.row:last-child{border:0}.row.on{color:var(--pr)}
.flow{display:flex;gap:10px;overflow-x:auto;padding:12px 4px 18px}.nd{flex:1 0 130px;border-radius:14px;padding:12px;font-size:12.5px;text-align:center;position:relative;background:var(--bg)}.nd b{display:block;font-size:13px;margin:6px 0 2px}
.nd.verified{box-shadow:var(--rs)}.nd.processing,.nd.pending{box-shadow:var(--is)}.nd.processing{outline:2px solid var(--pr);animation:pu 1s infinite}.nd.pending{opacity:.6}@keyframes pu{50%{outline-color:transparent}}
.dot{width:26px;height:26px;border-radius:50%;margin:0 auto;display:grid;place-items:center;font-size:12px;font-weight:700;box-shadow:var(--is)}.verified .dot{color:var(--ok)}.processing .dot{color:var(--pr)}
table{width:100%;border-collapse:collapse;font-size:13.5px}td,th{padding:9px 8px;text-align:left;border-bottom:1px solid rgba(163,177,198,.3)}th{font-size:11px;color:var(--mu);text-transform:uppercase}.r{text-align:right;font-variant-numeric:tabular-nums}
select{background:var(--bg);border:0;box-shadow:var(--is);border-radius:10px;padding:9px 12px;color:var(--tx);font:600 13px Inter}pre{font:12px/1.5 ui-monospace,monospace;white-space:pre-wrap;word-break:break-all}.bar{height:12px;border-radius:8px;box-shadow:var(--is);overflow:hidden;margin:6px 0 12px}.bar i{display:block;height:100%;background:var(--pr);border-radius:8px}
.lg{font:11.5px ui-monospace,monospace;padding:6px 0;border-bottom:1px dashed rgba(163,177,198,.5);word-break:break-all}.note{font-size:12px;color:var(--mu);line-height:1.5}.tb{display:flex;gap:10px;flex-wrap:wrap;align-items:center}
EOF_FC_7
cat > src/App.jsx <<'EOF_FC_8'
import {useState,useEffect,useMemo} from 'react';
const R=[
{id:'rtgs',n:'RTGS / Fedwire',lat:'~0.9 s',fee:.0004,up:'99.99%',d:'High-value gross settlement: each payment settles individually and finally.',nodes:['Initiate','Sender bank','Gross clearing engine','Central-bank ledger','Beneficiary credit']},
{id:'upi',n:'UPI / RTP',lat:'<180 ms',fee:0,up:'99.95%',d:'Instant account-to-account rail; PSP switch and PIN authorisation.',nodes:['Collect request','PSP switch','mPIN auth','Beneficiary bank','Credit']},
{id:'swift',n:'SWIFT ISO 20022',lat:'~4 min',fee:.0012,up:'99.97%',d:'Cross-border pacs.008 credit transfer tracked end to end by a UETR.',nodes:['pain.001 in','Screening','gpi hub','Correspondent','pacs.008 credit']},
{id:'escrow',n:'Smart Escrow',lat:'milestone',fee:.0025,up:'99.90%',d:'Funds held under dual-key control and released when milestones are met.',nodes:['Fund hold','Dual-key lock','Milestone check','Release','Credit']},
{id:'ach',n:'ACH / NACH batch',lat:'T+1',fee:.0003,up:'99.98%',d:'Batch file rail with cut-off windows and a return period.',nodes:['File submit','Cut-off window','Batch clearing','Return window','Credit']}];
const RM=Object.fromEntries(R.map(r=>[r.id,r]));
const C0=[[1023,'Acme Corp Invoice',4200,'upi',5],[1022,'Globex Payroll',1150,'ach',2],[1021,'Initech Supplier',890,'rtgs',5],[1020,'Umbrella Import',18500,'swift',3],[1019,'Hooli Milestone',32000,'escrow',2]].map(([id,client,amt,rail,step])=>({id,client,amt,rail,step,log:[]}));
const $=n=>'$'+n.toLocaleString('en-US',{minimumFractionDigits:2,maximumFractionDigits:2});
const hash=s=>{let h=5381;for(const c of s)h=(h*33^c.charCodeAt(0))>>>0;return h.toString(16).padStart(8,'0')};
const uuid=()=>crypto.randomUUID?crypto.randomUUID():'0000-demo';
const Stepper=({nodes,pk})=><div className="flow">{nodes.map((n,j)=>{const s=j<pk?'verified':j==pk?'processing':'pending';return <div key={n} className={'nd '+s}><div className="dot">{s=='verified'?'✓':s=='processing'?'●':j+1}</div><b>{n}</b><span>{s}</span></div>})}</div>;
function Area({s}){const w=500,h=100,lo=3700,hi=4200,pts=s.map((v,i)=>[i/(s.length-1)*w,h-(v-lo)/(hi-lo)*h]);const L=pts.map((p,i)=>(i?'L':'M')+p[0].toFixed(1)+','+p[1].toFixed(1)).join('');
return <div className="in"><svg viewBox={`0 0 ${w} ${h}`} width="100%" height="130" preserveAspectRatio="none"><defs><linearGradient id="g" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stopColor="#4D79FF" stopOpacity=".35"/><stop offset="1" stopColor="#4D79FF" stopOpacity="0"/></linearGradient></defs><path d={L+`L${w},${h}L0,${h}Z`} fill="url(#g)"/><path d={L} fill="none" stroke="#4D79FF" strokeWidth="3" vectorEffect="non-scaling-stroke"/></svg></div>}
export default function App(){
const [v,setV]=useState('dash'),[pause,setP]=useState(false),[t,setT]=useState(0),[ser,setSer]=useState(()=>Array(30).fill(3950)),[vol,setVol]=useState({rtgs:1.82,upi:.64,swift:.97,escrow:.41,ach:1.26}),[rid,setRid]=useState('rtgs'),[cs,setCs]=useState(C0),[cid,setCid]=useState(1020),[q,setQ]=useState(''),[xml,setXml]=useState(false),[pk0,setPk0]=useState(0),[uet,setUet]=useState(uuid());
useEffect(()=>{if(pause)return;const i=setInterval(()=>{setT(x=>x+1);setSer(s=>[...s.slice(1),3800+Math.round(Math.random()*300)]);setVol(o=>Object.fromEntries(Object.entries(o).map(([k,x])=>[k,+(x+Math.random()*.01).toFixed(3)])))},1000);return()=>clearInterval(i)},[pause]);
const upd=(id,f,m)=>setCs(a=>a.map(c=>{if(c.id!=id)return c;const n=f(c),prev=c.log.at(-1)?.h||'genesis';return {...n,log:[...c.log,{t:new Date().toLocaleTimeString(),m,h:hash(prev+m+c.log.length)}]}}));
const cur=cs.find(c=>c.id==cid)||cs[0],rail=RM[rid],pk=(t+pk0)%6,tps=ser.at(-1);
const shown=cs.filter(c=>(c.client+c.id).toLowerCase().includes(q.toLowerCase()));
const settled=cs.filter(c=>c.step>=5);
const led=useMemo(()=>settled.flatMap(c=>{const r=RM[c.rail],f=+(c.amt*r.fee).toFixed(2),e=[{c:c.id,dr:'Clearing · '+r.n,cr:'Receivable · '+c.client,a:c.amt}];if(f)e.push({c:c.id,dr:'Fee expense',cr:'Clearing · '+r.n,a:f});return e}),[cs]);
const tot=led.reduce((s,e)=>s+e.a,0),tv=Object.values(vol).reduce((a,b)=>a+b,0);
const csv=()=>{const b=new Blob(['case,debit,credit,amount\n'+led.map(e=>[e.c,e.dr,e.cr,e.a].join(',')).join('\n')],{type:'text/csv'}),a=document.createElement('a');a.href=URL.createObjectURL(b);a.download='ledger.csv';a.click()};
const add=()=>{const id=Math.max(...cs.map(c=>c.id))+1;setCs([{id,client:['Stark Ind.','Wayne Ent.','Pied Piper','Wonka Co.'][id%4]+' Invoice',amt:500+(id*737)%9000,rail:'upi',step:0,log:[{t:new Date().toLocaleTimeString(),m:'Case created',h:hash('genesis'+id)}]},...cs]);setCid(id);setV('cases')};
const Case=({c,on,go})=><div className={'row'+(on?' on':'')} onClick={go}><div><b>Case #{c.id}</b><div className="note">{c.client} · {RM[c.rail].n}</div></div><div style={{textAlign:'right'}}><b>{$(c.amt)}</b><br/><span className={'p '+(c.step>=5?'ok':'wa')}>{c.step>=5?'Settled':'In flight'}</span></div></div>;
const NV=[['dash','Dashboard'],['rails','Rails'],['cases','Cases'],['ledger','Ledger']];
return <div className="app">
<header className="nav"><div className="brand"><div className="logo">F</div>FlowCase</div><div className="links">{NV.map(([k,n])=><button key={k} className={'lk'+(v==k?' on':'')} onClick={()=>setV(k)}>{n}</button>)}</div>
<div className="right"><input className="srch" placeholder="Search cases, ref…" value={q} onChange={e=>{setQ(e.target.value);if(e.target.value)setV('cases')}}/><button className={'ib'+(pause?' on':'')} onClick={()=>setP(!pause)}>{pause?'▶ Resume':'⏸ Pause'}</button><span className="p wa" style={{margin:0}}>{cs.filter(c=>c.step<5).length} in flight</span></div></header>
{v=='dash'&&<><div className="g g4">
<div className="c"><div className="k">Net volume (sim.)</div><div className="kv">${tv.toFixed(2)}M</div><span className="p ok">↑ live</span></div>
<div className="c"><div className="k">Live throughput</div><div className="kv">{tps.toLocaleString()} msg/s</div><span className="p bl">{pause?'paused':'streaming'}</span></div>
<div className="c"><div className="k">Settled cases</div><div className="kv">{settled.length}</div><span className="p ok">{$(settled.reduce((s,c)=>s+c.amt,0))}</span></div>
<div className="c"><div className="k">Pending cases</div><div className="kv">{cs.length-settled.length}</div><span className="p bl">review in Cases</span></div></div>
<div className="g g2"><div className="g"><div className="c"><h3>Live message throughput</h3><Area s={ser}/><p className="note" style={{marginTop:8}}>Simulated stream, last 30 seconds.</p></div>
<div className="c"><h3>Rail distribution (volume, $M)</h3>{R.map(r=><div key={r.id}><div className="tb" style={{justifyContent:'space-between'}}><b style={{fontSize:13}}>{r.n}</b><span className="note">{vol[r.id].toFixed(2)}</span></div><div className="bar"><i style={{width:vol[r.id]/tv*100+'%'}}/></div></div>)}</div></div>
<div className="g"><div className="c"><h3>Quick actions</h3><div className="g" style={{gap:12}}><button className="btn" onClick={add}>+ New Case</button><button className="btn" onClick={csv}>Export ledger CSV</button><button className="btn" onClick={()=>setV('rails')}>Open rail monitor</button></div></div>
<div className="c"><h3>Recent cases</h3>{cs.slice(0,4).map(c=><Case key={c.id} c={c} go={()=>{setCid(c.id);setV('cases')}}/>)}</div></div></div></>}
{v=='rails'&&<div className="g"><div className="c"><div className="tb">{R.map(r=><button key={r.id} className={'btn s'+(rid==r.id?' on':'')} onClick={()=>{setRid(r.id);setPk0(-t%6);setXml(false)}}>{r.n}</button>)}</div></div>
<div className="g g4"><div className="c"><div className="k">Latency</div><div className="kv">{rail.lat}</div></div><div className="c"><div className="k">Volume</div><div className="kv">${vol[rid].toFixed(2)}M</div></div><div className="c"><div className="k">Uptime (sim.)</div><div className="kv">{rail.up}</div></div><div className="c"><div className="k">Fee model</div><div className="kv">{(rail.fee*100).toFixed(2)}%</div></div></div>
<div className="c"><h3>{rail.n}: live node topology</h3><p className="note">{rail.d}</p><Stepper nodes={rail.nodes} pk={pk}/><div className="tb"><button className="btn s" onClick={()=>{setPk0(-t%6);setUet(uuid())}}>Send test packet</button>{rid=='swift'&&<button className={'btn s'+(xml?' on':'')} onClick={()=>setXml(!xml)}>pacs.008 inspector</button>}</div>
{xml&&<div className="in" style={{marginTop:14}}><pre>{`<FIToFICstmrCdtTrf>\n <GrpHdr><MsgId>FC${t}</MsgId><NbOfTxs>1</NbOfTxs></GrpHdr>\n <CdtTrfTxInf>\n  <PmtId><UETR>${uet}</UETR></PmtId>\n  <IntrBkSttlmAmt Ccy="USD">18500.00</IntrBkSttlmAmt>\n </CdtTrfTxInf>\n</FIToFICstmrCdtTrf>`}</pre></div>}</div></div>}
{v=='cases'&&<div className="g g2"><div className="c"><h3>Cases</h3>{shown.map(c=><Case key={c.id} c={c} on={c.id==cur.id} go={()=>setCid(c.id)}/>)}{!shown.length&&<p className="note">No match.</p>}</div>
<div className="c"><div className="tb" style={{justifyContent:'space-between'}}><h3>Case #{cur.id} · {cur.client}</h3><span className={'p '+(cur.step>=5?'ok':'wa')}>{cur.step>=5?'Settled':'In flight'}</span></div>
<Stepper nodes={RM[cur.rail].nodes} pk={cur.step}/><div className="tb"><button className="btn s" disabled={cur.step>=5} onClick={()=>upd(cur.id,c=>({...c,step:c.step+1}),'Node verified: '+RM[cur.rail].nodes[cur.step])}>Advance step</button><button className="btn s" onClick={()=>upd(cur.id,c=>({...c,step:5}),'Instant settlement (simulation)')}>Settle now</button>
<select value={cur.rail} disabled={cur.step>=5} onChange={e=>upd(cur.id,c=>({...c,rail:e.target.value,step:0}),'Re-routed to '+RM[e.target.value].n)}>{R.map(r=><option key={r.id} value={r.id}>Route: {r.n}</option>)}</select></div>
<p className="note" style={{margin:'10px 0'}}>Amount {$(cur.amt)} · est. fee {$(cur.amt*RM[cur.rail].fee)} · ETA {RM[cur.rail].lat}. Re-routing restarts the rail.</p>
<h3>Audit log (hash-chained)</h3><div className="in">{cur.log.length?cur.log.map((l,i)=><div key={i} className="lg">{l.t} · {l.m} · #{l.h}</div>):<span className="note">No events yet. Advance or re-route to write the log.</span>}</div></div></div>}
{v=='ledger'&&<div className="c"><div className="tb" style={{justifyContent:'space-between'}}><h3>Settlement ledger (double entry)</h3><button className="btn s" onClick={csv}>Export CSV</button></div>
<table><thead><tr><th>Case</th><th>Debit</th><th>Credit</th><th className="r">Amount</th></tr></thead><tbody>{led.map((e,i)=><tr key={i}><td>#{e.c}</td><td>{e.dr}</td><td>{e.cr}</td><td className="r">{$(e.a)}</td></tr>)}<tr><td colSpan="3"><b>Total debits = total credits</b></td><td className="r"><b>{$(tot)}</b></td></tr></tbody></table><p className="note" style={{marginTop:10}}>Entries post when a case settles. Try “Settle now” on an in-flight case.</p></div>}
<p className="note">Simulation for case-study and portfolio use: all figures, latencies, uptime and cases are illustrative, not live payment data. Standards named (Fedwire, UPI, ISO 20022, ACH/NACH) are real; their use here is a model.</p></div>}
EOF_FC_8
echo "== files written =="; ls src
npm install --no-audit --no-fund
npm run build
echo "== build OK =="
if git rev-parse --git-dir >/dev/null 2>&1; then git add -A && git commit -m "feat: FlowCase React source" && git push; fi
echo "== DONE. Now: Settings > Pages > Source: GitHub Actions. Preview: npm run dev -- --host =="
