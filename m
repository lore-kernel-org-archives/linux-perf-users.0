Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDFF213253
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jan 2025 17:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736529626; cv=none; b=SOBjQGe7tXKXyQDOinXamPgp3h+TFTs6VzLPMVNW21gtg+NEPmQTKyOE9hgjq9PkH9Dn5NBo913CLzcp2oYiwkXiKaZ3iyzl1ng9F3ySC1zlM6b+T9652mpk5+c+H6vJpe/P9F9Tq45OIevQw2j/JUjewFvwOq6iBOD8/RfOTsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736529626; c=relaxed/simple;
	bh=rEIh5obhHNvX/8oIMccuWKtWNDjr/LAtj7PLqij0czo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Ru9BZR7pSLX2vf+vnLRtyObsceuicqyvBdH+fM5bUnBOwYlHXckVW3B6FSEm/08f1r9LV6E7lNq2fPZ82QPy7ntODncLzBp6TcL4oWe19eO35prpmxG2BKVMfCLHSlyU1aeXid1cjJb7zB40AqsitFAbqisn31ewyv8dvhCypGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c8vxhH1K; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c8vxhH1K"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e48beea5778so5282270276.1
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Jan 2025 09:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736529619; x=1737134419; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W384YSXgiC40eevE+kcvD6mugiN5fIDfqa+bgF4iPAI=;
        b=c8vxhH1KVFewNUEI9a2u337uOLgir5q1ZnOzc9Hsv45t/B3r+zJkzMzxhduN2iqME6
         Q++bCGPcal6oD0K6oBbN/Ei6073DLUWdBZfHxJisiHwfOOIq0xC6PB8ic5KTtFBC+2za
         XkqogTFC03Te+XQ/dPIdZf8Q0IYDcTT69iGxr52jJ+cEcA61ERcz3SNerNA1iYeB5exH
         TjTLljdJjcx/uqSMwcs1fvedzwMe0tOL+CSmez4O8RXozaqq99xVUlkerLiEHJxyGG5q
         gz058UgpyxXWAsnZqOPPs2ullfQhSvlymHdyJstwZCrOrotigGsi3TscrWVlHkTTqfki
         ZTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736529619; x=1737134419;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W384YSXgiC40eevE+kcvD6mugiN5fIDfqa+bgF4iPAI=;
        b=mRsIsBkhGOfAahmdkssCcCMckkvA4vjuLEF7SetyNxBd8lYO5MeDOjgUfFirXS9JdD
         Ofp94dn6aPZBFW1vBLpqwBQsNeVxnzIUHjgWeTQT4n4Q80s9IJUKmM6qbzHfdOvDXLb4
         K+r4VTgvozzqSkFJlBa4WHvONsDs9kfDaoAM2D18tKWiNy5S9PvaDnU39buENXEgpQGt
         9LWUWtC5w0ZZQJ0v7c8BLlr+Lx1CBBX0F4lige17JEAknR34auJPfVqE+gVOqSv9F4Hf
         18/5GKv+lXBodoKj9n0sSgNXEC9aMio6U4Yo9t9ZSBNTk/w7GXbNhEX918twsrPlijMN
         BLMA==
X-Forwarded-Encrypted: i=1; AJvYcCVUdK7gzu3RqT52RtK7XBz8ZNT3n7dcSHR2JF3P95TwkFz9VpfowjK23MGPIKBfrdsKkSyqQuxbGlOFurRC0Jk5@vger.kernel.org
X-Gm-Message-State: AOJu0YygIDwiglV5dcfM758ThDSzSlWjISyUNUxeEIdD8wHdah7HtA8F
	CEdrjg0IFUqyngvNj/6BB1tLCw4pXjz32toCs5q6b3+lsxdVoSit+ZFHksMNJF/cUMW1rlM1wxw
	EE3EZ7A==
X-Google-Smtp-Source: AGHT+IFn3JnGSqVh0xePbEReUhfwt0BF2DYqbWfitERDzlmdOBSsYeS2CNlyyEL+XKo4U5ogF7LvpbXOx7rz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:7ea3:d1e5:495a:9a4f])
 (user=irogers job=sendgmr) by 2002:a81:d20c:0:b0:6e7:e493:2db6 with SMTP id
 00721157ae682-6f5312d8264mr260817b3.3.1736529619597; Fri, 10 Jan 2025
 09:20:19 -0800 (PST)
Date: Fri, 10 Jan 2025 09:20:06 -0800
In-Reply-To: <20250110172006.680753-1-irogers@google.com>
Message-Id: <20250110172006.680753-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250110172006.680753-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1 2/2] perf vendor events arm64: Add V3 events/metrics
From: Ian Rogers <irogers@google.com>
To: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	Nick Forrington <nick.forrington@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Using the scripts at:
https://gitlab.arm.com/telemetry-solution/telemetry-solution/

Generate perf json for neoverse-n3 using the following command:
```
$ telemetry-solution/tools/perf_json_generator/generate.py \
  tools/perf/ --telemetry-files \
  telemetry-solution/data/pmu/cpu/neoverse/neoverse-v3.json:neoverse-v3
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arm64/arm/neoverse-v3/core-imp-def.json   | 1068 +++++++++++++++++
 .../arch/arm64/arm/neoverse-v3/metrics.json   |  471 ++++++++
 .../arch/arm64/common-and-microarch.json      |  216 ++++
 tools/perf/pmu-events/arch/arm64/mapfile.csv  |    1 +
 4 files changed, 1756 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/core-i=
mp-def.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/metric=
s.json

diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/core-imp-def.=
json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/core-imp-def.json
new file mode 100644
index 000000000000..cb24c9561ab7
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/core-imp-def.json
@@ -0,0 +1,1068 @@
+[
+    {
+        "ArchStdEvent": "SW_INCR",
+        "PublicDescription": "Counts software writes to the PMSWINC_EL0 (s=
oftware PMU increment) register. The PMSWINC_EL0 register is a manually upd=
ated counter for use by application software.\n\nThis event could be used t=
o measure any user program event, such as accesses to a particular data str=
ucture (by writing to the PMSWINC_EL0 register each time the data structure=
 is accessed).\n\nTo use the PMSWINC_EL0 register and event, developers mus=
t insert instructions that write to the PMSWINC_EL0 register into the sourc=
e code.\n\nSince the SW_INCR event records writes to the PMSWINC_EL0 regist=
er, there is no need to do a read/increment/write sequence to the PMSWINC_E=
L0 register."
+    },
+    {
+        "ArchStdEvent": "L1I_CACHE_REFILL",
+        "PublicDescription": "Counts cache line refills in the level 1 ins=
truction cache caused by a missed instruction fetch. Instruction fetches ma=
y include accessing multiple instructions, but the single cache line alloca=
tion is counted once."
+    },
+    {
+        "ArchStdEvent": "L1I_TLB_REFILL",
+        "PublicDescription": "Counts level 1 instruction TLB refills from =
any Instruction fetch. If there are multiple misses in the TLB that are res=
olved by the refill, then this event only counts once. This event will not =
count if the translation table walk results in a fault (such as a translati=
on or access fault), since there is no new translation created for the TLB.=
"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL",
+        "PublicDescription": "Counts level 1 data cache refills caused by =
speculatively executed load or store operations that missed in the level 1 =
data cache. This event only counts one event per cache line."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE",
+        "PublicDescription": "Counts level 1 data cache accesses from any =
load/store operations. Atomic operations that resolve in the CPUs caches (n=
ear atomic operations) counts as both a write access and read access. Each =
access to a cache line is counted including the multiple accesses caused by=
 single instructions such as LDM or STM. Each access to other level 1 data =
or unified memory structures, for example refill buffers, write buffers, an=
d write-back buffers, are also counted."
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_REFILL",
+        "PublicDescription": "Counts level 1 data TLB accesses that result=
ed in TLB refills. If there are multiple misses in the TLB that are resolve=
d by the refill, then this event only counts once. This event counts for re=
fills caused by preload instructions or hardware prefetch accesses. This ev=
ent counts regardless of whether the miss hits in L2 or results in a transl=
ation table walk. This event will not count if the translation table walk r=
esults in a fault (such as a translation or access fault), since there is n=
o new translation created for the TLB. This event will not count on an acce=
ss from an AT(address translation) instruction."
+    },
+    {
+        "ArchStdEvent": "INST_RETIRED",
+        "PublicDescription": "Counts instructions that have been architect=
urally executed."
+    },
+    {
+        "ArchStdEvent": "EXC_TAKEN",
+        "PublicDescription": "Counts any taken architecturally visible exc=
eptions such as IRQ, FIQ, SError, and other synchronous exceptions. Excepti=
ons are counted whether or not they are taken locally."
+    },
+    {
+        "ArchStdEvent": "EXC_RETURN",
+        "PublicDescription": "Counts any architecturally executed exceptio=
n return instructions. For example: AArch64: ERET"
+    },
+    {
+        "ArchStdEvent": "CID_WRITE_RETIRED",
+        "PublicDescription": "Counts architecturally executed writes to th=
e CONTEXTIDR_EL1 register, which usually contain the kernel PID and can be =
output with hardware trace."
+    },
+    {
+        "ArchStdEvent": "BR_IMMED_RETIRED",
+        "PublicDescription": "Counts architecturally executed direct branc=
hes."
+    },
+    {
+        "ArchStdEvent": "BR_RETURN_RETIRED",
+        "PublicDescription": "Counts architecturally executed procedure re=
turns."
+    },
+    {
+        "ArchStdEvent": "BR_MIS_PRED",
+        "PublicDescription": "Counts branches which are speculatively exec=
uted and mispredicted."
+    },
+    {
+        "ArchStdEvent": "CPU_CYCLES",
+        "PublicDescription": "Counts CPU clock cycles (not timer cycles). =
The clock measured by this event is defined as the physical clock driving t=
he CPU logic."
+    },
+    {
+        "ArchStdEvent": "BR_PRED",
+        "PublicDescription": "Counts all speculatively executed branches."
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS",
+        "PublicDescription": "Counts memory accesses issued by the CPU loa=
d store unit, where those accesses are issued due to load or store operatio=
ns. This event counts memory accesses no matter whether the data is receive=
d from any level of cache hierarchy or external memory. If memory accesses =
are broken up into smaller transactions than what were specified in the loa=
d or store instructions, then the event counts those smaller memory transac=
tions."
+    },
+    {
+        "ArchStdEvent": "L1I_CACHE",
+        "PublicDescription": "Counts instruction fetches which access the =
level 1 instruction cache. Instruction cache accesses caused by cache maint=
enance operations are not counted."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WB",
+        "PublicDescription": "Counts write-backs of dirty data from the L1=
 data cache to the L2 cache. This occurs when either a dirty cache line is =
evicted from L1 data cache and allocated in the L2 cache or dirty data is w=
ritten to the L2 and possibly to the next level of cache. This event counts=
 both victim cache line evictions and cache write-backs from snoops or cach=
e maintenance operations. The following cache operations are not counted:\n=
\n1. Invalidations which do not result in data being transferred out of the=
 L1 (such as evictions of clean data),\n2. Full line writes which write to =
L2 without writing L1, such as write streaming mode."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE",
+        "PublicDescription": "Counts accesses to the level 2 cache due to =
data accesses. Level 2 cache is a unified cache for data and instruction ac=
cesses. Accesses are for misses in the first level data cache or translatio=
n resolutions due to accesses. This event also counts write back of dirty d=
ata from level 1 data cache to the L2 cache."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_REFILL",
+        "PublicDescription": "Counts cache line refills into the level 2 c=
ache. Level 2 cache is a unified cache for data and instruction accesses. A=
ccesses are for misses in the level 1 data cache or translation resolutions=
 due to accesses."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WB",
+        "PublicDescription": "Counts write-backs of data from the L2 cache=
 to outside the CPU. This includes snoops to the L2 (from other CPUs) which=
 return data even if the snoops cause an invalidation. L2 cache line invali=
dations which do not write data outside the CPU and snoops which return dat=
a from an L1 cache are not counted. Data would not be written outside the c=
ache when invalidating a clean cache line."
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS",
+        "PublicDescription": "Counts memory transactions issued by the CPU=
 to the external bus, including snoop requests and snoop responses. Each be=
at of data is counted individually."
+    },
+    {
+        "ArchStdEvent": "MEMORY_ERROR",
+        "PublicDescription": "Counts any detected correctable or uncorrect=
able physical memory errors (ECC or parity) in protected CPUs RAMs. On the =
core, this event counts errors in the caches (including data and tag rams).=
 Any detected memory error (from either a speculative and abandoned access,=
 or an architecturally executed access) is counted. Note that errors are on=
ly detected when the actual protected memory is accessed by an operation."
+    },
+    {
+        "ArchStdEvent": "INST_SPEC",
+        "PublicDescription": "Counts operations that have been speculative=
ly executed."
+    },
+    {
+        "ArchStdEvent": "TTBR_WRITE_RETIRED",
+        "PublicDescription": "Counts architectural writes to TTBR0/1_EL1. =
If virtualization host extensions are enabled (by setting the HCR_EL2.E2H b=
it to 1), then accesses to TTBR0/1_EL1 that are redirected to TTBR0/1_EL2, =
or accesses to TTBR0/1_EL12, are counted. TTBRn registers are typically upd=
ated when the kernel is swapping user-space threads or applications."
+    },
+    {
+        "ArchStdEvent": "BUS_CYCLES",
+        "PublicDescription": "Counts bus cycles in the CPU. Bus cycles rep=
resent a clock cycle in which a transaction could be sent or received on th=
e interface from the CPU to the external bus. Since that interface is drive=
n at the same clock speed as the CPU, this event is a duplicate of CPU_CYCL=
ES."
+    },
+    {
+        "ArchStdEvent": "BR_RETIRED",
+        "PublicDescription": "Counts architecturally executed branches, wh=
ether the branch is taken or not. Instructions that explicitly write to the=
 PC are also counted. Note that exception generating instructions, exceptio=
n return instructions and context synchronization instructions are not coun=
ted."
+    },
+    {
+        "ArchStdEvent": "BR_MIS_PRED_RETIRED",
+        "PublicDescription": "Counts branches counted by BR_RETIRED which =
were mispredicted and caused a pipeline flush."
+    },
+    {
+        "ArchStdEvent": "STALL_FRONTEND",
+        "PublicDescription": "Counts cycles when frontend could not send a=
ny micro-operations to the rename stage because of frontend resource stalls=
 caused by fetch memory latency or branch prediction flow stalls. STALL_FRO=
NTEND_SLOTS counts SLOTS during the cycle when this event counts."
+    },
+    {
+        "ArchStdEvent": "STALL_BACKEND",
+        "PublicDescription": "Counts cycles whenever the rename unit is un=
able to send any micro-operations to the backend of the pipeline because of=
 backend resource constraints. Backend resource constraints can include iss=
ue stage fullness, execution stage fullness, or other internal pipeline res=
ource fullness. All the backend slots were empty during the cycle when this=
 event counts."
+    },
+    {
+        "ArchStdEvent": "L1D_TLB",
+        "PublicDescription": "Counts level 1 data TLB accesses caused by a=
ny memory load or store operation. Note that load or store instructions can=
 be broken up into multiple memory operations. This event does not count TL=
B maintenance operations."
+    },
+    {
+        "ArchStdEvent": "L1I_TLB",
+        "PublicDescription": "Counts level 1 instruction TLB accesses, whe=
ther the access hits or misses in the TLB. This event counts both demand ac=
cesses and prefetch or preload generated accesses."
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_REFILL",
+        "PublicDescription": "Counts level 2 TLB refills caused by memory =
operations from both data and instruction fetch, except for those caused by=
 TLB maintenance operations and hardware prefetches."
+    },
+    {
+        "ArchStdEvent": "L2D_TLB",
+        "PublicDescription": "Counts level 2 TLB accesses except those cau=
sed by TLB maintenance operations."
+    },
+    {
+        "ArchStdEvent": "REMOTE_ACCESS",
+        "PublicDescription": "Counts accesses to another chip, which is im=
plemented as a different CMN mesh in the system. If the CHI bus response ba=
ck to the core indicates that the data source is from another chip (mesh), =
then the counter is updated. If no data is returned, even if the system sno=
ops another chip/mesh, then the counter is not updated."
+    },
+    {
+        "ArchStdEvent": "DTLB_WALK",
+        "PublicDescription": "Counts number of demand data translation tab=
le walks caused by a miss in the L2 TLB and performing at least one memory =
access. Translation table walks are counted even if the translation ended u=
p taking a translation fault for reasons different than EPD, E0PD and NFD. =
Note that partial translations that cause a translation table walk are also=
 counted. Also note that this event counts walks triggered by software prel=
oads, but not walks triggered by hardware prefetchers, and that this event =
does not count walks triggered by TLB maintenance operations."
+    },
+    {
+        "ArchStdEvent": "ITLB_WALK",
+        "PublicDescription": "Counts number of instruction translation tab=
le walks caused by a miss in the L2 TLB and performing at least one memory =
access. Translation table walks are counted even if the translation ended u=
p taking a translation fault for reasons different than EPD, E0PD and NFD. =
Note that partial translations that cause a translation table walk are also=
 counted. Also note that this event does not count walks triggered by TLB m=
aintenance operations."
+    },
+    {
+        "ArchStdEvent": "LL_CACHE_RD",
+        "PublicDescription": "Counts read transactions that were returned =
from outside the core cluster. This event counts for external last level ca=
che  when the system register CPUECTLR.EXTLLC bit is set, otherwise it coun=
ts for the L3 cache. This event counts read transactions returned from outs=
ide the core if those transactions are either hit in the system level cache=
 or missed in the SLC and are returned from any other external sources."
+    },
+    {
+        "ArchStdEvent": "LL_CACHE_MISS_RD",
+        "PublicDescription": "Counts read transactions that were returned =
from outside the core cluster but missed in the system level cache. This ev=
ent counts for external last level cache when the system register CPUECTLR.=
EXTLLC bit is set, otherwise it counts for L3 cache. This event counts read=
 transactions returned from outside the core if those transactions are miss=
ed in the System level Cache. The data source of the transaction is indicat=
ed by a field in the CHI transaction returning to the CPU. This event does =
not count reads caused by cache maintenance operations."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_LMISS_RD",
+        "PublicDescription": "Counts cache line refills into the level 1 d=
ata cache from any memory read operations, that incurred additional latency=
."
+    },
+    {
+        "ArchStdEvent": "OP_RETIRED",
+        "PublicDescription": "Counts micro-operations that are architectur=
ally executed. This is a count of number of micro-operations retired from t=
he commit queue in a single cycle."
+    },
+    {
+        "ArchStdEvent": "OP_SPEC",
+        "PublicDescription": "Counts micro-operations speculatively execut=
ed. This is the count of the number of micro-operations dispatched in a cyc=
le."
+    },
+    {
+        "ArchStdEvent": "STALL",
+        "PublicDescription": "Counts cycles when no operations are sent to=
 the rename unit from the frontend or from the rename unit to the backend f=
or any reason (either frontend or backend stall). This event is the sum of =
STALL_FRONTEND and STALL_BACKEND"
+    },
+    {
+        "ArchStdEvent": "STALL_SLOT_BACKEND",
+        "PublicDescription": "Counts slots per cycle in which no operation=
s are sent from the rename unit to the backend due to backend resource cons=
traints. STALL_BACKEND counts during the cycle when STALL_SLOT_BACKEND coun=
ts at least 1."
+    },
+    {
+        "ArchStdEvent": "STALL_SLOT_FRONTEND",
+        "PublicDescription": "Counts slots per cycle in which no operation=
s are sent to the rename unit from the frontend due to frontend resource co=
nstraints."
+    },
+    {
+        "ArchStdEvent": "STALL_SLOT",
+        "PublicDescription": "Counts slots per cycle in which no operation=
s are sent to the rename unit from the frontend or from the rename unit to =
the backend for any reason (either frontend or backend stall). STALL_SLOT i=
s the sum of STALL_SLOT_FRONTEND and STALL_SLOT_BACKEND."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_RD",
+        "PublicDescription": "Counts level 1 data cache accesses from any =
load operation. Atomic load operations that resolve in the CPUs caches coun=
ts as both a write access and read access."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WR",
+        "PublicDescription": "Counts level 1 data cache accesses generated=
 by store operations. This event also counts accesses caused by a DC ZVA (d=
ata cache zero, specified by virtual address) instruction. Near atomic oper=
ations that resolve in the CPUs caches count as a write access and read acc=
ess."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_RD",
+        "PublicDescription": "Counts level 1 data cache refills caused by =
speculatively executed load instructions where the memory read operation mi=
sses in the level 1 data cache. This event only counts one event per cache =
line."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_WR",
+        "PublicDescription": "Counts level 1 data cache refills caused by =
speculatively executed store instructions where the memory write operation =
misses in the level 1 data cache. This event only counts one event per cach=
e line."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_INNER",
+        "PublicDescription": "Counts level 1 data cache refills where the =
cache line data came from caches inside the immediate cluster of the core."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_OUTER",
+        "PublicDescription": "Counts level 1 data cache refills for which =
the cache line data came from outside the immediate cluster of the core, li=
ke an SLC in the system interconnect or DRAM."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WB_VICTIM",
+        "PublicDescription": "Counts dirty cache line evictions from the l=
evel 1 data cache caused by a new cache line allocation. This event does no=
t count evictions caused by cache maintenance operations."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WB_CLEAN",
+        "PublicDescription": "Counts write-backs from the level 1 data cac=
he that are a result of a coherency operation made by another CPU. Event co=
unt includes cache maintenance operations."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_INVAL",
+        "PublicDescription": "Counts each explicit invalidation of a cache=
 line in the level 1 data cache caused by:\n\n- Cache Maintenance Operation=
s (CMO) that operate by a virtual address.\n- Broadcast cache coherency ope=
rations from another CPU in the system.\n\nThis event does not count for th=
e following conditions:\n\n1. A cache refill invalidates a cache line.\n2. =
A CMO which is executed on that CPU and invalidates a cache line specified =
by set/way.\n\nNote that CMOs that operate by set/way cannot be broadcast f=
rom one CPU to another."
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_REFILL_RD",
+        "PublicDescription": "Counts level 1 data TLB refills caused by me=
mory read operations. If there are multiple misses in the TLB that are reso=
lved by the refill, then this event only counts once. This event counts for=
 refills caused by preload instructions or hardware prefetch accesses. This=
 event counts regardless of whether the miss hits in L2 or results in a tra=
nslation table walk. This event will not count if the translation table wal=
k results in a fault (such as a translation or access fault), since there i=
s no new translation created for the TLB. This event will not count on an a=
ccess from an Address Translation (AT) instruction."
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_REFILL_WR",
+        "PublicDescription": "Counts level 1 data TLB refills caused by da=
ta side memory write operations. If there are multiple misses in the TLB th=
at are resolved by the refill, then this event only counts once. This event=
 counts for refills caused by preload instructions or hardware prefetch acc=
esses. This event counts regardless of whether the miss hits in L2 or resul=
ts in a translation table walk. This event will not count if the table walk=
 results in a fault (such as a translation or access fault), since there is=
 no new translation created for the TLB. This event will not count with an =
access from an Address Translation (AT) instruction."
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_RD",
+        "PublicDescription": "Counts level 1 data TLB accesses caused by m=
emory read operations. This event counts whether the access hits or misses =
in the TLB. This event does not count TLB maintenance operations."
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_WR",
+        "PublicDescription": "Counts any L1 data side TLB accesses caused =
by memory write operations. This event counts whether the access hits or mi=
sses in the TLB. This event does not count TLB maintenance operations."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_RD",
+        "PublicDescription": "Counts level 2 data cache accesses due to me=
mory read operations. Level 2 cache is a unified cache for data and instruc=
tion accesses, accesses are for misses in the level 1 data cache or transla=
tion resolutions due to accesses."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WR",
+        "PublicDescription": "Counts level 2 cache accesses due to memory =
write operations. Level 2 cache is a unified cache for data and instruction=
 accesses, accesses are for misses in the level 1 data cache or translation=
 resolutions due to accesses."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_REFILL_RD",
+        "PublicDescription": "Counts refills for memory accesses due to me=
mory read operation counted by L2D_CACHE_RD. Level 2 cache is a unified cac=
he for data and instruction accesses, accesses are for misses in the level =
1 data cache or translation resolutions due to accesses."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_REFILL_WR",
+        "PublicDescription": "Counts refills for memory accesses due to me=
mory write operation counted by L2D_CACHE_WR. Level 2 cache is a unified ca=
che for data and instruction accesses, accesses are for misses in the level=
 1 data cache or translation resolutions due to accesses."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WB_VICTIM",
+        "PublicDescription": "Counts evictions from the level 2 cache beca=
use of a line being allocated into the L2 cache."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WB_CLEAN",
+        "PublicDescription": "Counts write-backs from the level 2 cache th=
at are a result of either:\n\n1. Cache maintenance operations,\n\n2. Snoop =
responses or,\n\n3. Direct cache transfers to another CPU due to a forwardi=
ng snoop request."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_INVAL",
+        "PublicDescription": "Counts each explicit invalidation of a cache=
 line in the level 2 cache by cache maintenance operations that operate by =
a virtual address, or by external coherency operations. This event does not=
 count if either:\n\n1. A cache refill invalidates a cache line or,\n2. A C=
ache Maintenance Operation (CMO), which invalidates a cache line specified =
by set/way, is executed on that CPU.\n\nCMOs that operate by set/way cannot=
 be broadcast from one CPU to another."
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_REFILL_RD",
+        "PublicDescription": "Counts level 2 TLB refills caused by memory =
read operations from both data and instruction fetch except for those cause=
d by TLB maintenance operations or hardware prefetches."
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_REFILL_WR",
+        "PublicDescription": "Counts level 2 TLB refills caused by memory =
write operations from both data and instruction fetch except for those caus=
ed by TLB maintenance operations."
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_RD",
+        "PublicDescription": "Counts level 2 TLB accesses caused by memory=
 read operations from both data and instruction fetch except for those caus=
ed by TLB maintenance operations."
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_WR",
+        "PublicDescription": "Counts level 2 TLB accesses caused by memory=
 write operations from both data and instruction fetch except for those cau=
sed by TLB maintenance operations."
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS_RD",
+        "PublicDescription": "Counts memory read transactions seen on the =
external bus. Each beat of data is counted individually."
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS_WR",
+        "PublicDescription": "Counts memory write transactions seen on the=
 external bus. Each beat of data is counted individually."
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_RD",
+        "PublicDescription": "Counts memory accesses issued by the CPU due=
 to load operations. The event counts any memory load access, no matter whe=
ther the data is received from any level of cache hierarchy or external mem=
ory. The event also counts atomic load operations. If memory accesses are b=
roken up by the load/store unit into smaller transactions that are issued b=
y the bus interface, then the event counts those smaller transactions."
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_WR",
+        "PublicDescription": "Counts memory accesses issued by the CPU due=
 to store operations. The event counts any memory store access, no matter w=
hether the data is located in any level of cache or external memory. The ev=
ent also counts atomic load and store operations. If memory accesses are br=
oken up by the load/store unit into smaller transactions that are issued by=
 the bus interface, then the event counts those smaller transactions."
+    },
+    {
+        "ArchStdEvent": "UNALIGNED_LD_SPEC",
+        "PublicDescription": "Counts unaligned memory read operations issu=
ed by the CPU. This event counts unaligned accesses (as defined by the actu=
al instruction), even if they are subsequently issued as multiple aligned a=
ccesses. The event does not count preload operations (PLD, PLI)."
+    },
+    {
+        "ArchStdEvent": "UNALIGNED_ST_SPEC",
+        "PublicDescription": "Counts unaligned memory write operations iss=
ued by the CPU. This event counts unaligned accesses (as defined by the act=
ual instruction), even if they are subsequently issued as multiple aligned =
accesses."
+    },
+    {
+        "ArchStdEvent": "UNALIGNED_LDST_SPEC",
+        "PublicDescription": "Counts unaligned memory operations issued by=
 the CPU. This event counts unaligned accesses (as defined by the actual in=
struction), even if they are subsequently issued as multiple aligned access=
es."
+    },
+    {
+        "ArchStdEvent": "LDREX_SPEC",
+        "PublicDescription": "Counts Load-Exclusive operations that have b=
een speculatively executed. For example: LDREX, LDX"
+    },
+    {
+        "ArchStdEvent": "STREX_PASS_SPEC",
+        "PublicDescription": "Counts store-exclusive operations that have =
been speculatively executed and have successfully completed the store opera=
tion."
+    },
+    {
+        "ArchStdEvent": "STREX_FAIL_SPEC",
+        "PublicDescription": "Counts store-exclusive operations that have =
been speculatively executed and have not successfully completed the store o=
peration."
+    },
+    {
+        "ArchStdEvent": "STREX_SPEC",
+        "PublicDescription": "Counts store-exclusive operations that have =
been speculatively executed."
+    },
+    {
+        "ArchStdEvent": "LD_SPEC",
+        "PublicDescription": "Counts speculatively executed load operation=
s including Single Instruction Multiple Data (SIMD) load operations."
+    },
+    {
+        "ArchStdEvent": "ST_SPEC",
+        "PublicDescription": "Counts speculatively executed store operatio=
ns including Single Instruction Multiple Data (SIMD) store operations."
+    },
+    {
+        "ArchStdEvent": "LDST_SPEC",
+        "PublicDescription": "Counts load and store operations that have b=
een speculatively executed."
+    },
+    {
+        "ArchStdEvent": "DP_SPEC",
+        "PublicDescription": "Counts speculatively executed logical or ari=
thmetic instructions such as MOV/MVN operations."
+    },
+    {
+        "ArchStdEvent": "ASE_SPEC",
+        "PublicDescription": "Counts speculatively executed Advanced SIMD =
operations excluding load, store and move micro-operations that move data t=
o or from SIMD (vector) registers."
+    },
+    {
+        "ArchStdEvent": "VFP_SPEC",
+        "PublicDescription": "Counts speculatively executed floating point=
 operations. This event does not count operations that move data to or from=
 floating point (vector) registers."
+    },
+    {
+        "ArchStdEvent": "PC_WRITE_SPEC",
+        "PublicDescription": "Counts speculatively executed operations whi=
ch cause software changes of the PC. Those operations include all taken bra=
nch operations."
+    },
+    {
+        "ArchStdEvent": "CRYPTO_SPEC",
+        "PublicDescription": "Counts speculatively executed cryptographic =
operations except for PMULL and VMULL operations."
+    },
+    {
+        "ArchStdEvent": "BR_IMMED_SPEC",
+        "PublicDescription": "Counts direct branch operations which are sp=
eculatively executed."
+    },
+    {
+        "ArchStdEvent": "BR_RETURN_SPEC",
+        "PublicDescription": "Counts procedure return operations (RET, RET=
AA and RETAB) which are speculatively executed."
+    },
+    {
+        "ArchStdEvent": "BR_INDIRECT_SPEC",
+        "PublicDescription": "Counts indirect branch operations including =
procedure returns, which are speculatively executed. This includes operatio=
ns that force a software change of the PC, other than exception-generating =
operations and direct branch instructions. Some examples of the instruction=
s counted by this event include BR Xn, RET, etc..."
+    },
+    {
+        "ArchStdEvent": "ISB_SPEC",
+        "PublicDescription": "Counts ISB operations that are executed."
+    },
+    {
+        "ArchStdEvent": "DSB_SPEC",
+        "PublicDescription": "Counts DSB operations that are speculatively=
 issued to Load/Store unit in the CPU."
+    },
+    {
+        "ArchStdEvent": "DMB_SPEC",
+        "PublicDescription": "Counts DMB operations that are speculatively=
 issued to the Load/Store unit in the CPU. This event does not count implie=
d barriers from load acquire/store release operations."
+    },
+    {
+        "ArchStdEvent": "EXC_UNDEF",
+        "PublicDescription": "Counts the number of synchronous exceptions =
which are taken locally that are due to attempting to execute an instructio=
n that is UNDEFINED. Attempting to execute instruction bit patterns that ha=
ve not been allocated. Attempting to execute instructions when they are dis=
abled. Attempting to execute instructions at an inappropriate Exception lev=
el. Attempting to execute an instruction when the value of PSTATE.IL is 1."
+    },
+    {
+        "ArchStdEvent": "EXC_SVC",
+        "PublicDescription": "Counts SVC exceptions taken locally."
+    },
+    {
+        "ArchStdEvent": "EXC_PABORT",
+        "PublicDescription": "Counts synchronous exceptions that are taken=
 locally and caused by Instruction Aborts."
+    },
+    {
+        "ArchStdEvent": "EXC_DABORT",
+        "PublicDescription": "Counts exceptions that are taken locally and=
 are caused by data aborts or SErrors. Conditions that could cause those ex=
ceptions are attempting to read or write memory where the MMU generates a f=
ault, attempting to read or write memory with a misaligned address, interru=
pts from the nSEI inputs and internally generated SErrors."
+    },
+    {
+        "ArchStdEvent": "EXC_IRQ",
+        "PublicDescription": "Counts IRQ exceptions including the virtual =
IRQs that are taken locally."
+    },
+    {
+        "ArchStdEvent": "EXC_FIQ",
+        "PublicDescription": "Counts FIQ exceptions including the virtual =
FIQs that are taken locally."
+    },
+    {
+        "ArchStdEvent": "EXC_SMC",
+        "PublicDescription": "Counts SMC exceptions take to EL3."
+    },
+    {
+        "ArchStdEvent": "EXC_HVC",
+        "PublicDescription": "Counts HVC exceptions taken to EL2."
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_PABORT",
+        "PublicDescription": "Counts exceptions which are traps not taken =
locally and are caused by Instruction Aborts. For example, attempting to ex=
ecute an instruction with a misaligned PC."
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_DABORT",
+        "PublicDescription": "Counts exceptions which are traps not taken =
locally and are caused by Data Aborts or SError interrupts. Conditions that=
 could cause those exceptions are:\n\n1. Attempting to read or write memory=
 where the MMU generates a fault,\n2. Attempting to read or write memory wi=
th a misaligned address,\n3. Interrupts from the SEI input.\n4. internally =
generated SErrors."
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_OTHER",
+        "PublicDescription": "Counts the number of synchronous trap except=
ions which are not taken locally and are not SVC, SMC, HVC, data aborts, In=
struction Aborts, or interrupts."
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_IRQ",
+        "PublicDescription": "Counts IRQ exceptions including the virtual =
IRQs that are not taken locally."
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_FIQ",
+        "PublicDescription": "Counts FIQs which are not taken locally but =
taken from EL0, EL1,\n or EL2 to EL3 (which would be the normal behavior fo=
r FIQs when not executing\n in EL3)."
+    },
+    {
+        "ArchStdEvent": "RC_LD_SPEC",
+        "PublicDescription": "Counts any load acquire operations that are =
speculatively executed. For example: LDAR, LDARH, LDARB"
+    },
+    {
+        "ArchStdEvent": "RC_ST_SPEC",
+        "PublicDescription": "Counts any store release operations that are=
 speculatively executed. For example: STLR, STLRH, STLRB"
+    },
+    {
+        "PublicDescription": "Counts level 2 cache refills due to instruct=
ion fetches.",
+        "EventCode": "0x108",
+        "EventName": "IMP_L2_CACHE_IF_REFILL",
+        "BriefDescription": "Counts level 2 cache refills due to instructi=
on fetches."
+    },
+    {
+        "PublicDescription": "Counts late level 2 cache prefetch requests.=
",
+        "EventCode": "0x10B",
+        "EventName": "IMP_L2_CACHE_PF_LATE_REFILL",
+        "BriefDescription": "Counts late level 2 cache prefetch requests."
+    },
+    {
+        "PublicDescription": "Counts flushes including architectural, micr=
oarchitectural, and branch redirects.",
+        "EventCode": "0x120",
+        "EventName": "IMP_CT_FLUSH",
+        "BriefDescription": "Counts flushes including architectural, micro=
architectural, and branch redirects."
+    },
+    {
+        "PublicDescription": "Counts flushes due to memory hazards.",
+        "EventCode": "0x121",
+        "EventName": "IMP_CT_FLUSH_MEM",
+        "BriefDescription": "Counts flushes due to memory hazards."
+    },
+    {
+        "PublicDescription": "Counts flushes due to non-branch instruction=
s predicted as a branch.",
+        "EventCode": "0x122",
+        "EventName": "IMP_CT_FLUSH_BAD_BRANCH",
+        "BriefDescription": "Counts flushes due to non-branch instructions=
 predicted as a branch."
+    },
+    {
+        "PublicDescription": "Counts flushes due to bad predecode.",
+        "EventCode": "0x123",
+        "EventName": "IMP_CT_FLUSH_PREDECODE_ERR",
+        "BriefDescription": "Counts flushes due to bad predecode."
+    },
+    {
+        "PublicDescription": "Counts flushes due to ISB or similar side-ef=
fects.",
+        "EventCode": "0x124",
+        "EventName": "IMP_CT_FLUSH_ISB",
+        "BriefDescription": "Counts flushes due to ISB or similar side-eff=
ects."
+    },
+    {
+        "PublicDescription": "Counts flushes due to other hazards.",
+        "EventCode": "0x125",
+        "EventName": "IMP_CT_FLUSH_OTHER",
+        "BriefDescription": "Counts flushes due to other hazards."
+    },
+    {
+        "PublicDescription": "Counts load/store detected nuke due to read-=
after-read ordering hazard.",
+        "EventCode": "0x127",
+        "EventName": "IMP_LS_RAR",
+        "BriefDescription": "Counts load/store detected nuke due to read-a=
fter-read ordering hazard."
+    },
+    {
+        "PublicDescription": "Counts load/store detected nuke due to read-=
after-write ordering hazard.",
+        "EventCode": "0x128",
+        "EventName": "IMP_LS_RAW",
+        "BriefDescription": "Counts load/store detected nuke due to read-a=
fter-write ordering hazard."
+    },
+    {
+        "PublicDescription": "Counts backend stalls due to unavailable fla=
g registers.",
+        "EventCode": "0x158",
+        "EventName": "IMP_STALL_BACKEND_RENAME_FRF",
+        "BriefDescription": "Counts backend stalls due to unavailable flag=
 registers."
+    },
+    {
+        "PublicDescription": "Counts backend stalls due to unavailable gen=
eral registers.",
+        "EventCode": "0x159",
+        "EventName": "IMP_STALL_BACKEND_RENAME_GRF",
+        "BriefDescription": "Counts backend stalls due to unavailable gene=
ral registers."
+    },
+    {
+        "PublicDescription": "Counts backend stalls due to unavailable vec=
tor registers.",
+        "EventCode": "0x15A",
+        "EventName": "IMP_STALL_BACKEND_RENAME_VRF",
+        "BriefDescription": "Counts backend stalls due to unavailable vect=
or registers."
+    },
+    {
+        "PublicDescription": "Counts cycles counted by STALL_BACKEND_BUSY =
when the backend could not accept any micro-operations\nbecause the simple =
integer issue queues are full to take any operations for execution.",
+        "EventCode": "0x15C",
+        "EventName": "DISPATCH_STALL_IQ_SX",
+        "BriefDescription": "Counts cycles counted by STALL_BACKEND_BUSY w=
hen the backend could not accept any micro-operations\nbecause the simple i=
nteger issue queues are full to take any operations for execution."
+    },
+    {
+        "PublicDescription": "Counts cycles counted by STALL_BACKEND_BUSY =
when the backend could not accept any micro-operations\nbecause the complex=
 integer issue queues are full and can not take any operations for executio=
n.",
+        "EventCode": "0x15D",
+        "EventName": "DISPATCH_STALL_IQ_MX",
+        "BriefDescription": "Counts cycles counted by STALL_BACKEND_BUSY w=
hen the backend could not accept any micro-operations\nbecause the complex =
integer issue queues are full and can not take any operations for execution=
."
+    },
+    {
+        "PublicDescription": "Counts cycles when the backend could not acc=
ept any micro-operations\nbecause the load/store issue queues are full and =
can not take any operations for execution.",
+        "EventCode": "0x15E",
+        "EventName": "DISPATCH_STALL_IQ_LS",
+        "BriefDescription": "Counts cycles when the backend could not acce=
pt any micro-operations\nbecause the load/store issue queues are full and c=
an not take any operations for execution."
+    },
+    {
+        "PublicDescription": "Counts cycles counted by STALL_BACKEND_BUSY =
when the backend could not accept any micro-operations\nbecause the vector =
issue queues are full and can not take any operations for execution.",
+        "EventCode": "0x15F",
+        "EventName": "DISPATCH_STALL_IQ_VX",
+        "BriefDescription": "Counts cycles counted by STALL_BACKEND_BUSY w=
hen the backend could not accept any micro-operations\nbecause the vector i=
ssue queues are full and can not take any operations for execution."
+    },
+    {
+        "PublicDescription": "Counts cycles counted by STALL_BACKEND_BUSY =
when the backend could not accept any micro-operations\nbecause the commit =
queue is full and can not take any operations for execution.",
+        "EventCode": "0x160",
+        "EventName": "DISPATCH_STALL_MCQ",
+        "BriefDescription": "Counts cycles counted by STALL_BACKEND_BUSY w=
hen the backend could not accept any micro-operations\nbecause the commit q=
ueue is full and can not take any operations for execution."
+    },
+    {
+        "PublicDescription": "Counts near atomics compare and swap operati=
ons.",
+        "EventCode": "0x17B",
+        "EventName": "IMP_NEAR_CAS",
+        "BriefDescription": "Counts near atomics compare and swap operatio=
ns."
+    },
+    {
+        "PublicDescription": "Counts passing near atomic compare and swap =
operations.",
+        "EventCode": "0x17C",
+        "EventName": "IMP_NEAR_CAS_PASS",
+        "BriefDescription": "Counts passing near atomic compare and swap o=
perations."
+    },
+    {
+        "PublicDescription": "Count of RXDAT or RXRSP responses received w=
ith indication completer fullness indicator set to 0",
+        "EventCode": "0x198",
+        "EventName": "L2_CHI_CBUSY0",
+        "BriefDescription": "Count of RXDAT or RXRSP responses received wi=
th indication completer fullness indicator set to 0"
+    },
+    {
+        "PublicDescription": "Count of RXDAT or RXRSP responses received w=
ith indication completer fullness indicator set to 1",
+        "EventCode": "0x199",
+        "EventName": "L2_CHI_CBUSY1",
+        "BriefDescription": "Count of RXDAT or RXRSP responses received wi=
th indication completer fullness indicator set to 1"
+    },
+    {
+        "PublicDescription": "Count of RXDAT or RXRSP responses received w=
ith indication completer fullness indicator set to 2",
+        "EventCode": "0x19A",
+        "EventName": "L2_CHI_CBUSY2",
+        "BriefDescription": "Count of RXDAT or RXRSP responses received wi=
th indication completer fullness indicator set to 2"
+    },
+    {
+        "PublicDescription": "Count of RXDAT or RXRSP responses received w=
ith indication completer fullness indicator set to 3",
+        "EventCode": "0x19B",
+        "EventName": "L2_CHI_CBUSY3",
+        "BriefDescription": "Count of RXDAT or RXRSP responses received wi=
th indication completer fullness indicator set to 3"
+    },
+    {
+        "PublicDescription": "Count of RXDAT or RXRSP responses received w=
ith indication completer indicating multiple cores actively making requests=
",
+        "EventCode": "0x19C",
+        "EventName": "L2_CHI_CBUSY_MT",
+        "BriefDescription": "Count of RXDAT or RXRSP responses received wi=
th indication completer indicating multiple cores actively making requests"
+    },
+    {
+        "PublicDescription": "Counts level 2 cache accesses due to level 1=
 data cache hardware prefetcher.",
+        "EventCode": "0x1B8",
+        "EventName": "L2D_CACHE_L1HWPRF",
+        "BriefDescription": "Counts level 2 cache accesses due to level 1 =
data cache hardware prefetcher."
+    },
+    {
+        "PublicDescription": "Counts level 2 cache refills where the cache=
 line is requested by a level 1 data cache hardware prefetcher.",
+        "EventCode": "0x1B9",
+        "EventName": "L2D_CACHE_REFILL_L1HWPRF",
+        "BriefDescription": "Counts level 2 cache refills where the cache =
line is requested by a level 1 data cache hardware prefetcher."
+    },
+    {
+        "ArchStdEvent": "SAMPLE_POP",
+        "PublicDescription": "Counts statistical profiling sample populati=
on, the count of all operations that could be sampled but may or may not be=
 chosen for sampling."
+    },
+    {
+        "ArchStdEvent": "SAMPLE_FEED",
+        "PublicDescription": "Counts statistical profiling samples taken f=
or sampling."
+    },
+    {
+        "ArchStdEvent": "SAMPLE_FILTRATE",
+        "PublicDescription": "Counts statistical profiling samples taken w=
hich are not removed by filtering."
+    },
+    {
+        "ArchStdEvent": "SAMPLE_COLLISION",
+        "PublicDescription": "Counts statistical profiling samples that ha=
ve collided with a previous sample and so therefore not taken."
+    },
+    {
+        "ArchStdEvent": "CNT_CYCLES",
+        "PublicDescription": "Increments at a constant frequency equal to =
the rate of increment of the System Counter, CNTPCT_EL0."
+    },
+    {
+        "ArchStdEvent": "STALL_BACKEND_MEM",
+        "PublicDescription": "Counts cycles when the backend is stalled be=
cause there is a pending demand load request in progress in the last level =
core cache."
+    },
+    {
+        "ArchStdEvent": "L1I_CACHE_LMISS",
+        "PublicDescription": "Counts cache line refills into the level 1 i=
nstruction cache, that incurred additional latency."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_LMISS_RD",
+        "PublicDescription": "Counts cache line refills into the level 2 u=
nified cache from any memory read operations that incurred additional laten=
cy."
+    },
+    {
+        "ArchStdEvent": "LDST_ALIGN_LAT",
+        "PublicDescription": "Counts the number of memory read and write a=
ccesses in a cycle that incurred additional latency, due to the alignment o=
f the address and the size of data being accessed, which results in store c=
rossing a single cache line."
+    },
+    {
+        "ArchStdEvent": "LD_ALIGN_LAT",
+        "PublicDescription": "Counts the number of memory read accesses in=
 a cycle that incurred additional latency, due to the alignment of the addr=
ess and size of data being accessed, which results in load crossing a singl=
e cache line."
+    },
+    {
+        "ArchStdEvent": "ST_ALIGN_LAT",
+        "PublicDescription": "Counts the number of memory write access in =
a cycle that incurred additional latency, due to the alignment of the addre=
ss and size of data being accessed incurred additional latency."
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_CHECKED",
+        "PublicDescription": "Counts the number of memory read and write a=
ccesses counted by MEM_ACCESS that are tag checked by the Memory Tagging Ex=
tension (MTE). This event is implemented as the sum of MEM_ACCESS_CHECKED_R=
D and MEM_ACCESS_CHECKED_WR"
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_CHECKED_RD",
+        "PublicDescription": "Counts the number of memory read accesses in=
 a cycle that are tag checked by the Memory Tagging Extension (MTE)."
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_CHECKED_WR",
+        "PublicDescription": "Counts the number of memory write accesses i=
n a cycle that is tag checked by the Memory Tagging Extension (MTE)."
+    },
+    {
+        "ArchStdEvent": "SIMD_INST_SPEC",
+        "PublicDescription": "Counts speculatively executed operations tha=
t are SIMD or SVE vector operations or Advanced SIMD non-scalar operations.=
"
+    },
+    {
+        "ArchStdEvent": "ASE_INST_SPEC",
+        "PublicDescription": "Counts speculatively executed Advanced SIMD =
operations."
+    },
+    {
+        "ArchStdEvent": "SVE_INST_SPEC",
+        "PublicDescription": "Counts speculatively executed operations tha=
t are SVE operations."
+    },
+    {
+        "ArchStdEvent": "FP_HP_SPEC",
+        "PublicDescription": "Counts speculatively executed half precision=
 floating point operations."
+    },
+    {
+        "ArchStdEvent": "FP_SP_SPEC",
+        "PublicDescription": "Counts speculatively executed single precisi=
on floating point operations."
+    },
+    {
+        "ArchStdEvent": "FP_DP_SPEC",
+        "PublicDescription": "Counts speculatively executed double precisi=
on floating point operations."
+    },
+    {
+        "ArchStdEvent": "INT_SPEC",
+        "PublicDescription": "Counts speculatively executed integer arithm=
etic operations."
+    },
+    {
+        "ArchStdEvent": "SVE_PRED_SPEC",
+        "PublicDescription": "Counts speculatively executed predicated SVE=
 operations."
+    },
+    {
+        "ArchStdEvent": "SVE_PRED_EMPTY_SPEC",
+        "PublicDescription": "Counts speculatively executed predicated SVE=
 operations with no active predicate elements."
+    },
+    {
+        "ArchStdEvent": "SVE_PRED_FULL_SPEC",
+        "PublicDescription": "Counts speculatively executed predicated SVE=
 operations with all predicate elements active."
+    },
+    {
+        "ArchStdEvent": "SVE_PRED_PARTIAL_SPEC",
+        "PublicDescription": "Counts speculatively executed predicated SVE=
 operations with at least one but not all active predicate elements."
+    },
+    {
+        "ArchStdEvent": "SVE_PRED_NOT_FULL_SPEC",
+        "PublicDescription": "Counts speculatively executed predicated SVE=
 operations with at least one non active predicate elements."
+    },
+    {
+        "ArchStdEvent": "PRF_SPEC",
+        "PublicDescription": "Counts speculatively executed operations tha=
t prefetch memory. For example: Scalar: PRFM, SVE: PRFB, PRFD, PRFH, or PRF=
W."
+    },
+    {
+        "ArchStdEvent": "SVE_LDFF_SPEC",
+        "PublicDescription": "Counts speculatively executed SVE first faul=
t or non-fault load operations."
+    },
+    {
+        "ArchStdEvent": "SVE_LDFF_FAULT_SPEC",
+        "PublicDescription": "Counts speculatively executed SVE first faul=
t or non-fault load operations that clear at least one bit in the FFR."
+    },
+    {
+        "ArchStdEvent": "FP_SCALE_OPS_SPEC",
+        "PublicDescription": "Counts speculatively executed scalable singl=
e precision floating point operations."
+    },
+    {
+        "ArchStdEvent": "FP_FIXED_OPS_SPEC",
+        "PublicDescription": "Counts speculatively executed non-scalable s=
ingle precision floating point operations."
+    },
+    {
+        "ArchStdEvent": "ASE_SVE_INT8_SPEC",
+        "PublicDescription": "Counts speculatively executed Advanced SIMD =
or SVE integer operations with the largest data type an 8-bit integer."
+    },
+    {
+        "ArchStdEvent": "ASE_SVE_INT16_SPEC",
+        "PublicDescription": "Counts speculatively executed Advanced SIMD =
or SVE integer operations with the largest data type a 16-bit integer."
+    },
+    {
+        "ArchStdEvent": "ASE_SVE_INT32_SPEC",
+        "PublicDescription": "Counts speculatively executed Advanced SIMD =
or SVE integer operations with the largest data type a 32-bit integer."
+    },
+    {
+        "ArchStdEvent": "ASE_SVE_INT64_SPEC",
+        "PublicDescription": "Counts speculatively executed Advanced SIMD =
or SVE integer operations with the largest data type a 64-bit integer."
+    },
+    {
+        "ArchStdEvent": "BR_INDNR_TAKEN_RETIRED",
+        "PublicDescription": "Counts architecturally executed indirect bra=
nches excluding procedure returns that were taken."
+    },
+    {
+        "ArchStdEvent": "BR_IMMED_PRED_RETIRED",
+        "PublicDescription": "Counts architecturally executed direct branc=
hes that were correctly predicted."
+    },
+    {
+        "ArchStdEvent": "BR_IMMED_MIS_PRED_RETIRED",
+        "PublicDescription": "Counts architecturally executed direct branc=
hes that were mispredicted and caused a pipeline flush."
+    },
+    {
+        "ArchStdEvent": "BR_IND_PRED_RETIRED",
+        "PublicDescription": "Counts architecturally executed indirect bra=
nches including procedure returns that were correctly predicted."
+    },
+    {
+        "ArchStdEvent": "BR_IND_MIS_PRED_RETIRED",
+        "PublicDescription": "Counts architecturally executed indirect bra=
nches including procedure returns that were mispredicted and caused a pipel=
ine flush."
+    },
+    {
+        "ArchStdEvent": "BR_RETURN_PRED_RETIRED",
+        "PublicDescription": "Counts architecturally executed procedure re=
turns that were correctly predicted."
+    },
+    {
+        "ArchStdEvent": "BR_RETURN_MIS_PRED_RETIRED",
+        "PublicDescription": "Counts architecturally executed procedure re=
turns that were mispredicted and caused a pipeline flush."
+    },
+    {
+        "ArchStdEvent": "BR_INDNR_PRED_RETIRED",
+        "PublicDescription": "Counts architecturally executed indirect bra=
nches excluding procedure returns that were correctly predicted."
+    },
+    {
+        "ArchStdEvent": "BR_INDNR_MIS_PRED_RETIRED",
+        "PublicDescription": "Counts architecturally executed indirect bra=
nches excluding procedure returns that were mispredicted and caused a pipel=
ine flush."
+    },
+    {
+        "ArchStdEvent": "BR_TAKEN_PRED_RETIRED",
+        "PublicDescription": "Counts architecturally executed branches tha=
t were taken and were correctly predicted."
+    },
+    {
+        "ArchStdEvent": "BR_TAKEN_MIS_PRED_RETIRED",
+        "PublicDescription": "Counts architecturally executed branches tha=
t were taken and were mispredicted causing a pipeline flush."
+    },
+    {
+        "ArchStdEvent": "BR_SKIP_PRED_RETIRED",
+        "PublicDescription": "Counts architecturally executed branches tha=
t were not taken and were correctly predicted."
+    },
+    {
+        "ArchStdEvent": "BR_SKIP_MIS_PRED_RETIRED",
+        "PublicDescription": "Counts architecturally executed branches tha=
t were not taken and were mispredicted causing a pipeline flush."
+    },
+    {
+        "ArchStdEvent": "BR_PRED_RETIRED",
+        "PublicDescription": "Counts branch instructions counted by BR_RET=
IRED which were correctly predicted."
+    },
+    {
+        "ArchStdEvent": "BR_IND_RETIRED",
+        "PublicDescription": "Counts architecturally executed indirect bra=
nches including procedure returns."
+    },
+    {
+        "ArchStdEvent": "BRB_FILTRATE",
+        "PublicDescription": "Counts branch records captured which are not=
 removed by filtering."
+    },
+    {
+        "ArchStdEvent": "INST_FETCH_PERCYC",
+        "PublicDescription": "Counts number of instruction fetches outstan=
ding per cycle, which will provide an average latency of instruction fetch.=
"
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_RD_PERCYC",
+        "PublicDescription": "Counts the number of outstanding loads or me=
mory read accesses per cycle."
+    },
+    {
+        "ArchStdEvent": "INST_FETCH",
+        "PublicDescription": "Counts Instruction memory accesses that the =
PE makes."
+    },
+    {
+        "ArchStdEvent": "DTLB_WALK_PERCYC",
+        "PublicDescription": "Counts the number of data translation table =
walks in progress per cycle."
+    },
+    {
+        "ArchStdEvent": "ITLB_WALK_PERCYC",
+        "PublicDescription": "Counts the number of instruction translation=
 table walks in progress per cycle."
+    },
+    {
+        "ArchStdEvent": "SAMPLE_FEED_BR",
+        "PublicDescription": "Counts statistical profiling samples taken w=
hich are branches."
+    },
+    {
+        "ArchStdEvent": "SAMPLE_FEED_LD",
+        "PublicDescription": "Counts statistical profiling samples taken w=
hich are loads or load atomic operations."
+    },
+    {
+        "ArchStdEvent": "SAMPLE_FEED_ST",
+        "PublicDescription": "Counts statistical profiling samples taken w=
hich are stores or store atomic operations."
+    },
+    {
+        "ArchStdEvent": "SAMPLE_FEED_OP",
+        "PublicDescription": "Counts statistical profiling samples taken w=
hich are matching any operation type filters supported."
+    },
+    {
+        "ArchStdEvent": "SAMPLE_FEED_EVENT",
+        "PublicDescription": "Counts statistical profiling samples taken w=
hich are matching event packet filter constraints."
+    },
+    {
+        "ArchStdEvent": "SAMPLE_FEED_LAT",
+        "PublicDescription": "Counts statistical profiling samples taken w=
hich are exceeding minimum latency set by operation latency filter constrai=
nts."
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_RW",
+        "PublicDescription": "Counts level 1 data TLB demand accesses caus=
ed by memory read or write operations. This event counts whether the access=
 hits or misses in the TLB. This event does not count TLB maintenance opera=
tions."
+    },
+    {
+        "ArchStdEvent": "L1I_TLB_RD",
+        "PublicDescription": "Counts level 1 instruction TLB demand access=
es whether the access hits or misses in the TLB."
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_PRFM",
+        "PublicDescription": "Counts level 1 data TLB accesses generated b=
y software prefetch or preload memory accesses. Load or store instructions =
can be broken into multiple memory operations. This event does not count TL=
B maintenance operations."
+    },
+    {
+        "ArchStdEvent": "L1I_TLB_PRFM",
+        "PublicDescription": "Counts level 1 instruction TLB accesses gene=
rated by software preload or prefetch instructions. This event counts wheth=
er the access hits or misses in the TLB. This event does not count TLB main=
tenance operations."
+    },
+    {
+        "ArchStdEvent": "DTLB_HWUPD",
+        "PublicDescription": "Counts number of memory accesses triggered b=
y a data translation table walk and performing an update of a translation t=
able entry. Memory accesses are counted even if the translation ended up ta=
king a translation fault for reasons different than EPD, E0PD and NFD. Note=
 that this event counts accesses triggered by software preloads, but not ac=
cesses triggered by hardware prefetchers."
+    },
+    {
+        "ArchStdEvent": "ITLB_HWUPD",
+        "PublicDescription": "Counts number of memory accesses triggered b=
y an instruction translation table walk and performing an update of a trans=
lation table entry. Memory accesses are counted even if the translation end=
ed up taking a translation fault for reasons different than EPD, E0PD and N=
FD."
+    },
+    {
+        "ArchStdEvent": "DTLB_STEP",
+        "PublicDescription": "Counts number of memory accesses triggered b=
y a demand data translation table walk and performing a read of a translati=
on table entry. Memory accesses are counted even if the translation ended u=
p taking a translation fault for reasons different than EPD, E0PD and NFD. =
Note that this event counts accesses triggered by software preloads, but no=
t accesses triggered by hardware prefetchers."
+    },
+    {
+        "ArchStdEvent": "ITLB_STEP",
+        "PublicDescription": "Counts number of memory accesses triggered b=
y an instruction translation table walk and performing a read of a translat=
ion table entry. Memory accesses are counted even if the translation ended =
up taking a translation fault for reasons different than EPD, E0PD and NFD.=
"
+    },
+    {
+        "ArchStdEvent": "DTLB_WALK_LARGE",
+        "PublicDescription": "Counts number of demand data translation tab=
le walks caused by a miss in the L2 TLB and yielding a large page. The set =
of large pages is defined as all pages with a final size higher than or equ=
al to 2MB. Translation table walks that end up taking a translation fault a=
re not counted, as the page size would be undefined in that case. If DTLB_W=
ALK_BLOCK is implemented, then it is an alias for this event in this family=
. Note that partial translations that cause a translation table walk are al=
so counted. Also note that this event counts walks triggered by software pr=
eloads, but not walks triggered by hardware prefetchers, and that this even=
t does not count walks triggered by TLB maintenance operations."
+    },
+    {
+        "ArchStdEvent": "ITLB_WALK_LARGE",
+        "PublicDescription": "Counts number of instruction translation tab=
le walks caused by a miss in the L2 TLB and yielding a large page. The set =
of large pages is defined as all pages with a final size higher than or equ=
al to 2MB. Translation table walks that end up taking a translation fault a=
re not counted, as the page size would be undefined in that case. In this f=
amily, this is equal to ITLB_WALK_BLOCK event. Note that partial translatio=
ns that cause a translation table walk are also counted. Also note that thi=
s event does not count walks triggered by TLB maintenance operations."
+    },
+    {
+        "ArchStdEvent": "DTLB_WALK_SMALL",
+        "PublicDescription": "Counts number of data translation table walk=
s caused by a miss in the L2 TLB and yielding a small page. The set of smal=
l pages is defined as all pages with a final size lower than 2MB. Translati=
on table walks that end up taking a translation fault are not counted, as t=
he page size would be undefined in that case. If DTLB_WALK_PAGE event is im=
plemented, then it is an alias for this event in this family. Note that par=
tial translations that cause a translation table walk are also counted. Als=
o note that this event counts walks triggered by software preloads, but not=
 walks triggered by hardware prefetchers, and that this event does not coun=
t walks triggered by TLB maintenance operations."
+    },
+    {
+        "ArchStdEvent": "ITLB_WALK_SMALL",
+        "PublicDescription": "Counts number of instruction translation tab=
le walks caused by a miss in the L2 TLB and yielding a small page. The set =
of small pages is defined as all pages with a final size lower than 2MB. Tr=
anslation table walks that end up taking a translation fault are not counte=
d, as the page size would be undefined in that case. In this family, this i=
s equal to ITLB_WALK_PAGE event. Note that partial translations that cause =
a translation table walk are also counted. Also note that this event does n=
ot count walks triggered by TLB maintenance operations."
+    },
+    {
+        "ArchStdEvent": "DTLB_WALK_RW",
+        "PublicDescription": "Counts number of demand data translation tab=
le walks caused by a miss in the L2 TLB and performing at least one memory =
access. Translation table walks are counted even if the translation ended u=
p taking a translation fault for reasons different than EPD, E0PD and NFD. =
Note that partial translations that cause a translation table walk are also=
 counted. Also note that this event does not count walks triggered by TLB m=
aintenance operations."
+    },
+    {
+        "ArchStdEvent": "ITLB_WALK_RD",
+        "PublicDescription": "Counts number of demand instruction translat=
ion table walks caused by a miss in the L2 TLB and performing at least one =
memory access. Translation table walks are counted even if the translation =
ended up taking a translation fault for reasons different than EPD, E0PD an=
d NFD. Note that partial translations that cause a translation table walk a=
re also counted. Also note that this event does not count walks triggered b=
y TLB maintenance operations."
+    },
+    {
+        "ArchStdEvent": "DTLB_WALK_PRFM",
+        "PublicDescription": "Counts number of software prefetches or prel=
oads generated data translation table walks caused by a miss in the L2 TLB =
and performing at least one memory access. Translation table walks are coun=
ted even if the translation ended up taking a translation fault for reasons=
 different than EPD, E0PD and NFD. Note that partial translations that caus=
e a translation table walk are also counted. Also note that this event does=
 not count walks triggered by TLB maintenance operations."
+    },
+    {
+        "ArchStdEvent": "ITLB_WALK_PRFM",
+        "PublicDescription": "Counts number of software prefetches or prel=
oads generated instruction translation table walks caused by a miss in the =
L2 TLB and performing at least one memory access. Translation table walks a=
re counted even if the translation ended up taking a translation fault for =
reasons different than EPD, E0PD and NFD. Note that partial translations th=
at cause a translation table walk are also counted. Also note that this eve=
nt does not count walks triggered by TLB maintenance operations."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_RW",
+        "PublicDescription": "Counts level 1 data demand cache accesses fr=
om any load or store operation. Near atomic operations that resolve in the =
CPUs caches counts as both a write access and read access."
+    },
+    {
+        "ArchStdEvent": "L1I_CACHE_RD",
+        "PublicDescription": "Counts demand instruction fetches which acce=
ss the level 1 instruction cache."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_PRFM",
+        "PublicDescription": "Counts level 1 data cache accesses from soft=
ware preload or prefetch instructions."
+    },
+    {
+        "ArchStdEvent": "L1I_CACHE_PRFM",
+        "PublicDescription": "Counts instruction fetches generated by soft=
ware preload or prefetch instructions which access the level 1 instruction =
cache."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_MISS",
+        "PublicDescription": "Counts cache line misses in the level 1 data=
 cache."
+    },
+    {
+        "ArchStdEvent": "L1I_CACHE_HWPRF",
+        "PublicDescription": "Counts instruction fetches which access the =
level 1 instruction cache generated by the hardware prefetcher."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_PRFM",
+        "PublicDescription": "Counts level 1 data cache refills where the =
cache line access was generated by software preload or prefetch instruction=
s."
+    },
+    {
+        "ArchStdEvent": "L1I_CACHE_REFILL_PRFM",
+        "PublicDescription": "Counts cache line refills in the level 1 ins=
truction cache caused by a missed instruction fetch generated by software p=
reload or prefetch instructions. Instruction fetches may include accessing =
multiple instructions, but the single cache line allocation is counted once=
."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_RW",
+        "PublicDescription": "Counts level 2 cache demand accesses from an=
y load/store operations. Level 2 cache is a unified cache for data and inst=
ruction accesses, accesses are for misses in the level 1 data cache or tran=
slation resolutions due to accesses."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_PRFM",
+        "PublicDescription": "Counts level 2 data cache accesses generated=
 by software preload or prefetch instructions."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_MISS",
+        "PublicDescription": "Counts cache line misses in the level 2 cach=
e. Level 2 cache is a unified cache for data and instruction accesses. Acce=
sses are for misses in the level 1 data cache or translation resolutions du=
e to accesses."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_REFILL_PRFM",
+        "PublicDescription": "Counts refills due to accesses generated as =
a result of software preload or prefetch instructions as counted by L2D_CAC=
HE_PRFM."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_HWPRF",
+        "PublicDescription": "Counts level 1 data cache accesses from any =
load/store operations generated by the hardware prefetcher."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_HWPRF",
+        "PublicDescription": "Counts level 2 data cache accesses generated=
 by L2D hardware prefetchers."
+    },
+    {
+        "ArchStdEvent": "STALL_FRONTEND_MEMBOUND",
+        "PublicDescription": "Counts cycles when the frontend could not se=
nd any micro-operations to the rename stage due to resource constraints in =
the memory resources."
+    },
+    {
+        "ArchStdEvent": "STALL_FRONTEND_L1I",
+        "PublicDescription": "Counts cycles when the frontend is stalled b=
ecause there is an instruction fetch request pending in the level 1 instruc=
tion cache."
+    },
+    {
+        "ArchStdEvent": "STALL_FRONTEND_MEM",
+        "PublicDescription": "Counts cycles when the frontend is stalled b=
ecause there is an instruction fetch request pending in the last level core=
 cache."
+    },
+    {
+        "ArchStdEvent": "STALL_FRONTEND_TLB",
+        "PublicDescription": "Counts when the frontend is stalled on any T=
LB misses being handled. This event also counts the TLB accesses made by ha=
rdware prefetches."
+    },
+    {
+        "ArchStdEvent": "STALL_FRONTEND_CPUBOUND",
+        "PublicDescription": "Counts cycles when the frontend could not se=
nd any micro-operations to the rename stage due to resource constraints in =
the CPU resources excluding memory resources."
+    },
+    {
+        "ArchStdEvent": "STALL_FRONTEND_FLOW",
+        "PublicDescription": "Counts cycles when the frontend could not se=
nd any micro-operations to the rename stage due to resource constraints in =
the branch prediction unit."
+    },
+    {
+        "ArchStdEvent": "STALL_FRONTEND_FLUSH",
+        "PublicDescription": "Counts cycles when the frontend could not se=
nd any micro-operations to the rename stage as the frontend is recovering f=
rom a machine flush or resteer. Example scenarios that cause a flush includ=
e branch mispredictions, taken exceptions, micro-architectural flush etc."
+    },
+    {
+        "ArchStdEvent": "STALL_BACKEND_MEMBOUND",
+        "PublicDescription": "Counts cycles when the backend could not acc=
ept any micro-operations due to resource constraints in the memory resource=
s."
+    },
+    {
+        "ArchStdEvent": "STALL_BACKEND_L1D",
+        "PublicDescription": "Counts cycles when the backend is stalled be=
cause there is a pending demand load request in progress in the level 1 dat=
a cache."
+    },
+    {
+        "ArchStdEvent": "STALL_BACKEND_L2D",
+        "PublicDescription": "Counts cycles when the backend is stalled be=
cause there is a pending demand load request in progress in the level 2 dat=
a cache."
+    },
+    {
+        "ArchStdEvent": "STALL_BACKEND_TLB",
+        "PublicDescription": "Counts cycles when the backend is stalled on=
 any demand TLB misses being handled."
+    },
+    {
+        "ArchStdEvent": "STALL_BACKEND_ST",
+        "PublicDescription": "Counts cycles when the backend is stalled an=
d there is a store that has not reached the pre-commit stage."
+    },
+    {
+        "ArchStdEvent": "STALL_BACKEND_CPUBOUND",
+        "PublicDescription": "Counts cycles when the backend could not acc=
ept any micro-operations due to any resource constraints in the CPU excludi=
ng memory resources."
+    },
+    {
+        "ArchStdEvent": "STALL_BACKEND_BUSY",
+        "PublicDescription": "Counts cycles when the backend could not acc=
ept any micro-operations because the issue queues are full to take any oper=
ations for execution."
+    },
+    {
+        "ArchStdEvent": "STALL_BACKEND_ILOCK",
+        "PublicDescription": "Counts cycles when the backend could not acc=
ept any micro-operations due to resource constraints imposed by input depen=
dency."
+    },
+    {
+        "ArchStdEvent": "STALL_BACKEND_RENAME",
+        "PublicDescription": "Counts cycles when backend is stalled even w=
hen operations are available from the frontend but at least one is not read=
y to be sent to the backend because no rename register is available."
+    },
+    {
+        "ArchStdEvent": "L1I_CACHE_HIT_RD",
+        "PublicDescription": "Counts demand instruction fetches that acces=
s the level 1 instruction cache and hit in the L1 instruction cache."
+    },
+    {
+        "ArchStdEvent": "L1I_CACHE_HIT_RD_FPRFM",
+        "PublicDescription": "Counts demand instruction fetches that acces=
s the level 1 instruction cache that hit in the L1 instruction cache and th=
e line was requested by a software prefetch."
+    },
+    {
+        "ArchStdEvent": "L1I_CACHE_HIT_RD_FHWPRF",
+        "PublicDescription": "Counts demand instruction fetches generated =
by hardware prefetch that access the level 1 instruction cache and hit in t=
he L1 instruction cache."
+    },
+    {
+        "ArchStdEvent": "L1I_CACHE_HIT",
+        "PublicDescription": "Counts instruction fetches that access the l=
evel 1 instruction cache and hit in the level 1 instruction cache. Instruct=
ion cache accesses caused by cache maintenance operations are not counted."
+    },
+    {
+        "ArchStdEvent": "L1I_CACHE_HIT_PRFM",
+        "PublicDescription": "Counts instruction fetches generated by soft=
ware preload or prefetch instructions that access the level 1 instruction c=
ache and hit in the level 1 instruction cache."
+    },
+    {
+        "ArchStdEvent": "L1I_LFB_HIT_RD",
+        "PublicDescription": "Counts demand instruction fetches that acces=
s the level 1 instruction cache and hit in a line that is in the process of=
 being loaded into the level 1 instruction cache."
+    },
+    {
+        "ArchStdEvent": "L1I_LFB_HIT_RD_FPRFM",
+        "PublicDescription": "Counts demand instruction fetches generated =
by software prefetch instructions that access the level 1 instruction cache=
 and hit in a line that is in the process of being loaded into the level 1 =
instruction cache."
+    },
+    {
+        "ArchStdEvent": "L1I_LFB_HIT_RD_FHWPRF",
+        "PublicDescription": "Counts demand instruction fetches generated =
by hardware prefetch that access the level 1 instruction cache and hit in a=
 line that is in the process of being loaded into the level 1 instruction c=
ache."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/metrics.json =
b/tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/metrics.json
new file mode 100644
index 000000000000..d1bfbc4a5f65
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/metrics.json
@@ -0,0 +1,471 @@
+[
+    {
+        "MetricName": "backend_bound",
+        "MetricExpr": "STALL_SLOT_BACKEND / (10 * CPU_CYCLES) * 100",
+        "BriefDescription": "This metric is the percentage of total slots =
that were stalled due to resource constraints in the backend of the process=
or.",
+        "MetricGroup": "TopdownL1",
+        "ScaleUnit": "1percent of slots"
+    },
+    {
+        "MetricName": "backend_busy_bound",
+        "MetricExpr": "STALL_BACKEND_BUSY / STALL_BACKEND * 100",
+        "BriefDescription": "This metric is the percentage of total cycles=
 stalled in the backend due to issue queues being full to accept operations=
 for execution.",
+        "MetricGroup": "Topdown_Backend",
+        "ScaleUnit": "1percent of cycles"
+    },
+    {
+        "MetricName": "backend_cache_l1d_bound",
+        "MetricExpr": "STALL_BACKEND_L1D / (STALL_BACKEND_L1D + STALL_BACK=
END_MEM) * 100",
+        "BriefDescription": "This metric is the percentage of total cycles=
 stalled in the backend due to memory access latency issues caused by level=
 1 data cache misses.",
+        "MetricGroup": "Topdown_Backend",
+        "ScaleUnit": "1percent of cycles"
+    },
+    {
+        "MetricName": "backend_cache_l2d_bound",
+        "MetricExpr": "STALL_BACKEND_MEM / (STALL_BACKEND_L1D + STALL_BACK=
END_MEM) * 100",
+        "BriefDescription": "This metric is the percentage of total cycles=
 stalled in the backend due to memory access latency issues caused by level=
 2 data cache misses.",
+        "MetricGroup": "Topdown_Backend",
+        "ScaleUnit": "1percent of cycles"
+    },
+    {
+        "MetricName": "backend_core_bound",
+        "MetricExpr": "STALL_BACKEND_CPUBOUND / STALL_BACKEND * 100",
+        "BriefDescription": "This metric is the percentage of total cycles=
 stalled in the backend due to backend core resource constraints not relate=
d to instruction fetch latency issues caused by memory access components.",
+        "MetricGroup": "Topdown_Backend",
+        "ScaleUnit": "1percent of cycles"
+    },
+    {
+        "MetricName": "backend_core_rename_bound",
+        "MetricExpr": "STALL_BACKEND_RENAME / STALL_BACKEND_CPUBOUND * 100=
",
+        "BriefDescription": "This metric is the percentage of total cycles=
 stalled in the backend as the rename unit registers are unavailable.",
+        "MetricGroup": "Topdown_Backend",
+        "ScaleUnit": "1percent of cycles"
+    },
+    {
+        "MetricName": "backend_mem_bound",
+        "MetricExpr": "STALL_BACKEND_MEMBOUND / STALL_BACKEND * 100",
+        "BriefDescription": "This metric is the percentage of total cycles=
 stalled in the backend due to backend core resource constraints related to=
 memory access latency issues caused by memory access components.",
+        "MetricGroup": "Topdown_Backend",
+        "ScaleUnit": "1percent of cycles"
+    },
+    {
+        "MetricName": "backend_mem_cache_bound",
+        "MetricExpr": "(STALL_BACKEND_L1D + STALL_BACKEND_MEM) / STALL_BAC=
KEND_MEMBOUND * 100",
+        "BriefDescription": "This metric is the percentage of total cycles=
 stalled in the backend due to memory latency issues caused by data cache m=
isses.",
+        "MetricGroup": "Topdown_Backend",
+        "ScaleUnit": "1percent of cycles"
+    },
+    {
+        "MetricName": "backend_mem_store_bound",
+        "MetricExpr": "STALL_BACKEND_ST / STALL_BACKEND_MEMBOUND * 100",
+        "BriefDescription": "This metric is the percentage of total cycles=
 stalled in the frontend due to memory write pending caused by stores stall=
ed in the pre-commit stage.",
+        "MetricGroup": "Topdown_Backend",
+        "ScaleUnit": "1percent of cycles"
+    },
+    {
+        "MetricName": "backend_mem_tlb_bound",
+        "MetricExpr": "STALL_BACKEND_TLB / STALL_BACKEND_MEMBOUND * 100",
+        "BriefDescription": "This metric is the percentage of total cycles=
 stalled in the backend due to memory access latency issues caused by data =
TLB misses.",
+        "MetricGroup": "Topdown_Backend",
+        "ScaleUnit": "1percent of cycles"
+    },
+    {
+        "MetricName": "backend_stalled_cycles",
+        "MetricExpr": "STALL_BACKEND / CPU_CYCLES * 100",
+        "BriefDescription": "This metric is the percentage of cycles that =
were stalled due to resource constraints in the backend unit of the process=
or.",
+        "MetricGroup": "Cycle_Accounting",
+        "ScaleUnit": "1percent of cycles"
+    },
+    {
+        "MetricName": "bad_speculation",
+        "MetricExpr": "(1 - STALL_SLOT / (10 * CPU_CYCLES)) * (1 - OP_RETI=
RED / OP_SPEC) * 100 + STALL_FRONTEND_FLUSH / CPU_CYCLES * 100",
+        "BriefDescription": "This metric is the percentage of total slots =
that executed operations and didn't retire due to a pipeline flush.\nThis i=
ndicates cycles that were utilized but inefficiently.",
+        "MetricGroup": "TopdownL1",
+        "ScaleUnit": "1percent of slots"
+    },
+    {
+        "MetricName": "barrier_percentage",
+        "MetricExpr": "(ISB_SPEC + DSB_SPEC + DMB_SPEC) / INST_SPEC * 100"=
,
+        "BriefDescription": "This metric measures instruction and data bar=
rier operations as a percentage of operations speculatively executed.",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "1percent of operations"
+    },
+    {
+        "MetricName": "branch_direct_ratio",
+        "MetricExpr": "BR_IMMED_RETIRED / BR_RETIRED",
+        "BriefDescription": "This metric measures the ratio of direct bran=
ches retired to the total number of branches architecturally executed.",
+        "MetricGroup": "Branch_Effectiveness",
+        "ScaleUnit": "1per branch"
+    },
+    {
+        "MetricName": "branch_indirect_ratio",
+        "MetricExpr": "BR_IND_RETIRED / BR_RETIRED",
+        "BriefDescription": "This metric measures the ratio of indirect br=
anches retired, including function returns, to the total number of branches=
 architecturally executed.",
+        "MetricGroup": "Branch_Effectiveness",
+        "ScaleUnit": "1per branch"
+    },
+    {
+        "MetricName": "branch_misprediction_ratio",
+        "MetricExpr": "BR_MIS_PRED_RETIRED / BR_RETIRED",
+        "BriefDescription": "This metric measures the ratio of branches mi=
spredicted to the total number of branches architecturally executed. This g=
ives an indication of the effectiveness of the branch prediction unit.",
+        "MetricGroup": "Miss_Ratio;Branch_Effectiveness",
+        "ScaleUnit": "100percent of branches"
+    },
+    {
+        "MetricName": "branch_mpki",
+        "MetricExpr": "BR_MIS_PRED_RETIRED / INST_RETIRED * 1000",
+        "BriefDescription": "This metric measures the number of branch mis=
predictions per thousand instructions executed.",
+        "MetricGroup": "MPKI;Branch_Effectiveness",
+        "ScaleUnit": "1MPKI"
+    },
+    {
+        "MetricName": "branch_percentage",
+        "MetricExpr": "(BR_IMMED_SPEC + BR_INDIRECT_SPEC) / INST_SPEC * 10=
0",
+        "BriefDescription": "This metric measures branch operations as a p=
ercentage of operations speculatively executed.",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "1percent of operations"
+    },
+    {
+        "MetricName": "branch_return_ratio",
+        "MetricExpr": "BR_RETURN_RETIRED / BR_RETIRED",
+        "BriefDescription": "This metric measures the ratio of branches re=
tired that are function returns to the total number of branches architectur=
ally executed.",
+        "MetricGroup": "Branch_Effectiveness",
+        "ScaleUnit": "1per branch"
+    },
+    {
+        "MetricName": "crypto_percentage",
+        "MetricExpr": "CRYPTO_SPEC / INST_SPEC * 100",
+        "BriefDescription": "This metric measures crypto operations as a p=
ercentage of operations speculatively executed.",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "1percent of operations"
+    },
+    {
+        "MetricName": "dtlb_mpki",
+        "MetricExpr": "DTLB_WALK / INST_RETIRED * 1000",
+        "BriefDescription": "This metric measures the number of data TLB W=
alks per thousand instructions executed.",
+        "MetricGroup": "MPKI;DTLB_Effectiveness",
+        "ScaleUnit": "1MPKI"
+    },
+    {
+        "MetricName": "dtlb_walk_ratio",
+        "MetricExpr": "DTLB_WALK / L1D_TLB",
+        "BriefDescription": "This metric measures the ratio of data TLB Wa=
lks to the total number of data TLB accesses. This gives an indication of t=
he effectiveness of the data TLB accesses.",
+        "MetricGroup": "Miss_Ratio;DTLB_Effectiveness",
+        "ScaleUnit": "100percent of TLB accesses"
+    },
+    {
+        "MetricName": "fp16_percentage",
+        "MetricExpr": "FP_HP_SPEC / INST_SPEC * 100",
+        "BriefDescription": "This metric measures half-precision floating =
point operations as a percentage of operations speculatively executed.",
+        "MetricGroup": "FP_Precision_Mix",
+        "ScaleUnit": "1percent of operations"
+    },
+    {
+        "MetricName": "fp32_percentage",
+        "MetricExpr": "FP_SP_SPEC / INST_SPEC * 100",
+        "BriefDescription": "This metric measures single-precision floatin=
g point operations as a percentage of operations speculatively executed.",
+        "MetricGroup": "FP_Precision_Mix",
+        "ScaleUnit": "1percent of operations"
+    },
+    {
+        "MetricName": "fp64_percentage",
+        "MetricExpr": "FP_DP_SPEC / INST_SPEC * 100",
+        "BriefDescription": "This metric measures double-precision floatin=
g point operations as a percentage of operations speculatively executed.",
+        "MetricGroup": "FP_Precision_Mix",
+        "ScaleUnit": "1percent of operations"
+    },
+    {
+        "MetricName": "fp_ops_per_cycle",
+        "MetricExpr": "(FP_SCALE_OPS_SPEC + FP_FIXED_OPS_SPEC) / CPU_CYCLE=
",
+        "BriefDescription": "This metric measures floating point operation=
s per cycle in any precision performed by any instruction. Operations are c=
ounted by computation and by vector lanes, fused computations such as multi=
ply-add count as twice per vector lane for example.",
+        "MetricGroup": "FP_Arithmetic_Intensity",
+        "ScaleUnit": "1operations per cycle"
+    },
+    {
+        "MetricName": "frontend_bound",
+        "MetricExpr": "(STALL_SLOT_FRONTEND / (10 * CPU_CYCLES) - STALL_FR=
ONTEND_FLUSH / CPU_CYCLES) * 100",
+        "BriefDescription": "This metric is the percentage of total slots =
that were stalled due to resource constraints in the frontend of the proces=
sor.",
+        "MetricGroup": "TopdownL1",
+        "ScaleUnit": "1percent of slots"
+    },
+    {
+        "MetricName": "frontend_cache_l1i_bound",
+        "MetricExpr": "STALL_FRONTEND_L1I / (STALL_FRONTEND_L1I + STALL_FR=
ONTEND_MEM) * 100",
+        "BriefDescription": "This metric is the percentage of total cycles=
 stalled in the frontend due to memory access latency issues caused by leve=
l 1 instruction cache misses.",
+        "MetricGroup": "Topdown_Frontend",
+        "ScaleUnit": "1percent of cycles"
+    },
+    {
+        "MetricName": "frontend_cache_l2i_bound",
+        "MetricExpr": "STALL_FRONTEND_MEM / (STALL_FRONTEND_L1I + STALL_FR=
ONTEND_MEM) * 100",
+        "BriefDescription": "This metric is the percentage of total cycles=
 stalled in the frontend due to memory access latency issues caused by leve=
l 2 instruction cache misses.",
+        "MetricGroup": "Topdown_Frontend",
+        "ScaleUnit": "1percent of cycles"
+    },
+    {
+        "MetricName": "frontend_core_bound",
+        "MetricExpr": "STALL_FRONTEND_CPUBOUND / STALL_FRONTEND * 100",
+        "BriefDescription": "This metric is the percentage of total cycles=
 stalled in the frontend due to frontend core resource constraints not rela=
ted to instruction fetch latency issues caused by memory access components.=
",
+        "MetricGroup": "Topdown_Frontend",
+        "ScaleUnit": "1percent of cycles"
+    },
+    {
+        "MetricName": "frontend_core_flow_bound",
+        "MetricExpr": "STALL_FRONTEND_FLOW / STALL_FRONTEND_CPUBOUND * 100=
",
+        "BriefDescription": "This metric is the percentage of total cycles=
 stalled in the frontend as the decode unit is awaiting input from the bran=
ch prediction unit.",
+        "MetricGroup": "Topdown_Frontend",
+        "ScaleUnit": "1percent of cycles"
+    },
+    {
+        "MetricName": "frontend_core_flush_bound",
+        "MetricExpr": "STALL_FRONTEND_FLUSH / STALL_FRONTEND_CPUBOUND * 10=
0",
+        "BriefDescription": "This metric is the percentage of total cycles=
 stalled in the frontend as the processor is recovering from a pipeline flu=
sh caused by bad speculation or other machine resteers.",
+        "MetricGroup": "Topdown_Frontend",
+        "ScaleUnit": "1percent of cycles"
+    },
+    {
+        "MetricName": "frontend_mem_bound",
+        "MetricExpr": "STALL_FRONTEND_MEMBOUND / STALL_FRONTEND * 100",
+        "BriefDescription": "This metric is the percentage of total cycles=
 stalled in the frontend due to frontend core resource constraints related =
to the instruction fetch latency issues caused by memory access components.=
",
+        "MetricGroup": "Topdown_Frontend",
+        "ScaleUnit": "1percent of cycles"
+    },
+    {
+        "MetricName": "frontend_mem_cache_bound",
+        "MetricExpr": "(STALL_FRONTEND_L1I + STALL_FRONTEND_MEM) / STALL_F=
RONTEND_MEMBOUND * 100",
+        "BriefDescription": "This metric is the percentage of total cycles=
 stalled in the frontend due to instruction fetch latency issues caused by =
instruction cache misses.",
+        "MetricGroup": "Topdown_Frontend",
+        "ScaleUnit": "1percent of cycles"
+    },
+    {
+        "MetricName": "frontend_mem_tlb_bound",
+        "MetricExpr": "STALL_FRONTEND_TLB / STALL_FRONTEND_MEMBOUND * 100"=
,
+        "BriefDescription": "This metric is the percentage of total cycles=
 stalled in the frontend due to instruction fetch latency issues caused by =
instruction TLB misses.",
+        "MetricGroup": "Topdown_Frontend",
+        "ScaleUnit": "1percent of cycles"
+    },
+    {
+        "MetricName": "frontend_stalled_cycles",
+        "MetricExpr": "STALL_FRONTEND / CPU_CYCLES * 100",
+        "BriefDescription": "This metric is the percentage of cycles that =
were stalled due to resource constraints in the frontend unit of the proces=
sor.",
+        "MetricGroup": "Cycle_Accounting",
+        "ScaleUnit": "1percent of cycles"
+    },
+    {
+        "MetricName": "integer_dp_percentage",
+        "MetricExpr": "DP_SPEC / INST_SPEC * 100",
+        "BriefDescription": "This metric measures scalar integer operation=
s as a percentage of operations speculatively executed.",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "1percent of operations"
+    },
+    {
+        "MetricName": "ipc",
+        "MetricExpr": "INST_RETIRED / CPU_CYCLES",
+        "BriefDescription": "This metric measures the number of instructio=
ns retired per cycle.",
+        "MetricGroup": "General",
+        "ScaleUnit": "1per cycle"
+    },
+    {
+        "MetricName": "itlb_mpki",
+        "MetricExpr": "ITLB_WALK / INST_RETIRED * 1000",
+        "BriefDescription": "This metric measures the number of instructio=
n TLB Walks per thousand instructions executed.",
+        "MetricGroup": "MPKI;ITLB_Effectiveness",
+        "ScaleUnit": "1MPKI"
+    },
+    {
+        "MetricName": "itlb_walk_ratio",
+        "MetricExpr": "ITLB_WALK / L1I_TLB",
+        "BriefDescription": "This metric measures the ratio of instruction=
 TLB Walks to the total number of instruction TLB accesses. This gives an i=
ndication of the effectiveness of the instruction TLB accesses.",
+        "MetricGroup": "Miss_Ratio;ITLB_Effectiveness",
+        "ScaleUnit": "100percent of TLB accesses"
+    },
+    {
+        "MetricName": "l1d_cache_miss_ratio",
+        "MetricExpr": "L1D_CACHE_REFILL / L1D_CACHE",
+        "BriefDescription": "This metric measures the ratio of level 1 dat=
a cache accesses missed to the total number of level 1 data cache accesses.=
 This gives an indication of the effectiveness of the level 1 data cache.",
+        "MetricGroup": "Miss_Ratio;L1D_Cache_Effectiveness",
+        "ScaleUnit": "100percent of cache accesses"
+    },
+    {
+        "MetricName": "l1d_cache_mpki",
+        "MetricExpr": "L1D_CACHE_REFILL / INST_RETIRED * 1000",
+        "BriefDescription": "This metric measures the number of level 1 da=
ta cache accesses missed per thousand instructions executed.",
+        "MetricGroup": "MPKI;L1D_Cache_Effectiveness",
+        "ScaleUnit": "1MPKI"
+    },
+    {
+        "MetricName": "l1d_tlb_miss_ratio",
+        "MetricExpr": "L1D_TLB_REFILL / L1D_TLB",
+        "BriefDescription": "This metric measures the ratio of level 1 dat=
a TLB accesses missed to the total number of level 1 data TLB accesses. Thi=
s gives an indication of the effectiveness of the level 1 data TLB.",
+        "MetricGroup": "Miss_Ratio;DTLB_Effectiveness",
+        "ScaleUnit": "100percent of TLB accesses"
+    },
+    {
+        "MetricName": "l1d_tlb_mpki",
+        "MetricExpr": "L1D_TLB_REFILL / INST_RETIRED * 1000",
+        "BriefDescription": "This metric measures the number of level 1 da=
ta TLB accesses missed per thousand instructions executed.",
+        "MetricGroup": "MPKI;DTLB_Effectiveness",
+        "ScaleUnit": "1MPKI"
+    },
+    {
+        "MetricName": "l1i_cache_miss_ratio",
+        "MetricExpr": "L1I_CACHE_REFILL / L1I_CACHE",
+        "BriefDescription": "This metric measures the ratio of level 1 ins=
truction cache accesses missed to the total number of level 1 instruction c=
ache accesses. This gives an indication of the effectiveness of the level 1=
 instruction cache.",
+        "MetricGroup": "Miss_Ratio;L1I_Cache_Effectiveness",
+        "ScaleUnit": "100percent of cache accesses"
+    },
+    {
+        "MetricName": "l1i_cache_mpki",
+        "MetricExpr": "L1I_CACHE_REFILL / INST_RETIRED * 1000",
+        "BriefDescription": "This metric measures the number of level 1 in=
struction cache accesses missed per thousand instructions executed.",
+        "MetricGroup": "MPKI;L1I_Cache_Effectiveness",
+        "ScaleUnit": "1MPKI"
+    },
+    {
+        "MetricName": "l1i_tlb_miss_ratio",
+        "MetricExpr": "L1I_TLB_REFILL / L1I_TLB",
+        "BriefDescription": "This metric measures the ratio of level 1 ins=
truction TLB accesses missed to the total number of level 1 instruction TLB=
 accesses. This gives an indication of the effectiveness of the level 1 ins=
truction TLB.",
+        "MetricGroup": "Miss_Ratio;ITLB_Effectiveness",
+        "ScaleUnit": "100percent of TLB accesses"
+    },
+    {
+        "MetricName": "l1i_tlb_mpki",
+        "MetricExpr": "L1I_TLB_REFILL / INST_RETIRED * 1000",
+        "BriefDescription": "This metric measures the number of level 1 in=
struction TLB accesses missed per thousand instructions executed.",
+        "MetricGroup": "MPKI;ITLB_Effectiveness",
+        "ScaleUnit": "1MPKI"
+    },
+    {
+        "MetricName": "l2_cache_miss_ratio",
+        "MetricExpr": "L2D_CACHE_REFILL / L2D_CACHE",
+        "BriefDescription": "This metric measures the ratio of level 2 cac=
he accesses missed to the total number of level 2 cache accesses. This give=
s an indication of the effectiveness of the level 2 cache, which is a unifi=
ed cache that stores both data and instruction. Note that cache accesses in=
 this cache are either data memory access or instruction fetch as this is a=
 unified cache.",
+        "MetricGroup": "Miss_Ratio;L2_Cache_Effectiveness",
+        "ScaleUnit": "100percent of cache accesses"
+    },
+    {
+        "MetricName": "l2_cache_mpki",
+        "MetricExpr": "L2D_CACHE_REFILL / INST_RETIRED * 1000",
+        "BriefDescription": "This metric measures the number of level 2 un=
ified cache accesses missed per thousand instructions executed. Note that c=
ache accesses in this cache are either data memory access or instruction fe=
tch as this is a unified cache.",
+        "MetricGroup": "MPKI;L2_Cache_Effectiveness",
+        "ScaleUnit": "1MPKI"
+    },
+    {
+        "MetricName": "l2_tlb_miss_ratio",
+        "MetricExpr": "L2D_TLB_REFILL / L2D_TLB",
+        "BriefDescription": "This metric measures the ratio of level 2 uni=
fied TLB accesses missed to the total number of level 2 unified TLB accesse=
s. This gives an indication of the effectiveness of the level 2 TLB.",
+        "MetricGroup": "Miss_Ratio;ITLB_Effectiveness;DTLB_Effectiveness",
+        "ScaleUnit": "100percent of TLB accesses"
+    },
+    {
+        "MetricName": "l2_tlb_mpki",
+        "MetricExpr": "L2D_TLB_REFILL / INST_RETIRED * 1000",
+        "BriefDescription": "This metric measures the number of level 2 un=
ified TLB accesses missed per thousand instructions executed.",
+        "MetricGroup": "MPKI;ITLB_Effectiveness;DTLB_Effectiveness",
+        "ScaleUnit": "1MPKI"
+    },
+    {
+        "MetricName": "ll_cache_read_hit_ratio",
+        "MetricExpr": "(LL_CACHE_RD - LL_CACHE_MISS_RD) / LL_CACHE_RD",
+        "BriefDescription": "This metric measures the ratio of last level =
cache read accesses hit in the cache to the total number of last level cach=
e accesses. This gives an indication of the effectiveness of the last level=
 cache for read traffic. Note that cache accesses in this cache are either =
data memory access or instruction fetch as this is a system level cache.",
+        "MetricGroup": "LL_Cache_Effectiveness",
+        "ScaleUnit": "100percent of cache accesses"
+    },
+    {
+        "MetricName": "ll_cache_read_miss_ratio",
+        "MetricExpr": "LL_CACHE_MISS_RD / LL_CACHE_RD",
+        "BriefDescription": "This metric measures the ratio of last level =
cache read accesses missed to the total number of last level cache accesses=
. This gives an indication of the effectiveness of the last level cache for=
 read traffic. Note that cache accesses in this cache are either data memor=
y access or instruction fetch as this is a system level cache.",
+        "MetricGroup": "Miss_Ratio;LL_Cache_Effectiveness",
+        "ScaleUnit": "100percent of cache accesses"
+    },
+    {
+        "MetricName": "ll_cache_read_mpki",
+        "MetricExpr": "LL_CACHE_MISS_RD / INST_RETIRED * 1000",
+        "BriefDescription": "This metric measures the number of last level=
 cache read accesses missed per thousand instructions executed.",
+        "MetricGroup": "MPKI;LL_Cache_Effectiveness",
+        "ScaleUnit": "1MPKI"
+    },
+    {
+        "MetricName": "load_percentage",
+        "MetricExpr": "LD_SPEC / INST_SPEC * 100",
+        "BriefDescription": "This metric measures load operations as a per=
centage of operations speculatively executed.",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "1percent of operations"
+    },
+    {
+        "MetricName": "nonsve_fp_ops_per_cycle",
+        "MetricExpr": "FP_FIXED_OPS_SPEC / CPU_CYCLE",
+        "BriefDescription": "This metric measures floating point operation=
s per cycle in any precision performed by an instruction that is not an SVE=
 instruction. Operations are counted by computation and by vector lanes, fu=
sed computations such as multiply-add count as twice per vector lane for ex=
ample.",
+        "MetricGroup": "FP_Arithmetic_Intensity",
+        "ScaleUnit": "1operations per cycle"
+    },
+    {
+        "MetricName": "retiring",
+        "MetricExpr": "(1 - STALL_SLOT / (CPU_CYCLES * 10)) * (OP_RETIRED =
/ OP_SPEC) * 100",
+        "BriefDescription": "This metric is the percentage of total slots =
that retired operations, which indicates cycles that were utilized efficien=
tly.",
+        "MetricGroup": "TopdownL1",
+        "ScaleUnit": "1percent of slots"
+    },
+    {
+        "MetricName": "scalar_fp_percentage",
+        "MetricExpr": "VFP_SPEC / INST_SPEC * 100",
+        "BriefDescription": "This metric measures scalar floating point op=
erations as a percentage of operations speculatively executed.",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "1percent of operations"
+    },
+    {
+        "MetricName": "simd_percentage",
+        "MetricExpr": "ASE_SPEC / INST_SPEC * 100",
+        "BriefDescription": "This metric measures advanced SIMD operations=
 as a percentage of total operations speculatively executed.",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "1percent of operations"
+    },
+    {
+        "MetricName": "store_percentage",
+        "MetricExpr": "ST_SPEC / INST_SPEC * 100",
+        "BriefDescription": "This metric measures store operations as a pe=
rcentage of operations speculatively executed.",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "1percent of operations"
+    },
+    {
+        "MetricName": "sve_all_percentage",
+        "MetricExpr": "SVE_INST_SPEC / INST_SPEC * 100",
+        "BriefDescription": "This metric measures scalable vector operatio=
ns, including loads and stores, as a percentage of operations speculatively=
 executed.",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "1percent of operations"
+    },
+    {
+        "MetricName": "sve_fp_ops_per_cycle",
+        "MetricExpr": "FP_SCALE_OPS_SPEC / CPU_CYCLE",
+        "BriefDescription": "This metric measures floating point operation=
s per cycle in any precision performed by SVE instructions. Operations are =
counted by computation and by vector lanes, fused computations such as mult=
iply-add count as twice per vector lane for example.",
+        "MetricGroup": "FP_Arithmetic_Intensity",
+        "ScaleUnit": "1operations per cycle"
+    },
+    {
+        "MetricName": "sve_predicate_empty_percentage",
+        "MetricExpr": "SVE_PRED_EMPTY_SPEC / SVE_PRED_SPEC * 100",
+        "BriefDescription": "This metric measures scalable vector operatio=
ns with no active predicates as a percentage of sve predicated operations s=
peculatively executed.",
+        "MetricGroup": "SVE_Effectiveness",
+        "ScaleUnit": "1percent of operations"
+    },
+    {
+        "MetricName": "sve_predicate_full_percentage",
+        "MetricExpr": "SVE_PRED_FULL_SPEC / SVE_PRED_SPEC * 100",
+        "BriefDescription": "This metric measures scalable vector operatio=
ns with all active predicates as a percentage of sve predicated operations =
speculatively executed.",
+        "MetricGroup": "SVE_Effectiveness",
+        "ScaleUnit": "1percent of operations"
+    },
+    {
+        "MetricName": "sve_predicate_partial_percentage",
+        "MetricExpr": "SVE_PRED_PARTIAL_SPEC / SVE_PRED_SPEC * 100",
+        "BriefDescription": "This metric measures scalable vector operatio=
ns with at least one active predicates as a percentage of sve predicated op=
erations speculatively executed.",
+        "MetricGroup": "SVE_Effectiveness",
+        "ScaleUnit": "1percent of operations"
+    },
+    {
+        "MetricName": "sve_predicate_percentage",
+        "MetricExpr": "SVE_PRED_SPEC / INST_SPEC * 100",
+        "BriefDescription": "This metric measures scalable vector operatio=
ns with predicates as a percentage of operations speculatively executed.",
+        "MetricGroup": "SVE_Effectiveness",
+        "ScaleUnit": "1percent of operations"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/common-and-microarch.json b/t=
ools/perf/pmu-events/arch/arm64/common-and-microarch.json
index 3409e39bb8df..4885b8ccd765 100644
--- a/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
+++ b/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
@@ -551,6 +551,12 @@
         "EventName": "SVE_INST_RETIRED",
         "BriefDescription": "Instruction architecturally executed, SVE."
     },
+    {
+        "PublicDescription": "Counts speculatively executed operations tha=
t are SIMD or SVE vector operations or Advanced SIMD non-scalar operations.=
",
+        "EventCode": "0x8004",
+        "EventName": "SIMD_INST_SPEC",
+        "BriefDescription": "Counts speculatively executed operations that=
 are SIMD or SVE vector operations or Advanced SIMD non-scalar operations."
+    },
     {
         "PublicDescription": "ASE operations speculatively executed",
         "EventCode": "0x8005",
@@ -617,6 +623,12 @@
         "EventName": "FP_CVT_SPEC",
         "BriefDescription": "floating-point convert Operations speculative=
ly executed."
     },
+    {
+        "PublicDescription": "Counts speculatively executed integer arithm=
etic operations.",
+        "EventCode": "0x8040",
+        "EventName": "INT_SPEC",
+        "BriefDescription": "Counts speculatively executed integer arithme=
tic operations."
+    },
     {
         "PublicDescription": "Advanced SIMD and SVE integer Operations spe=
culatively executed.",
         "EventCode": "0x8043",
@@ -899,6 +911,30 @@
         "EventName": "BR_INDNR_MIS_PRED_RETIRED",
         "BriefDescription": "Counts architecturally executed indirect bran=
ches excluding procedure returns that were mispredicted and caused a pipeli=
ne flush."
     },
+    {
+        "PublicDescription": "Counts architecturally executed branches tha=
t were taken and were correctly predicted.",
+        "EventCode": "0x8118",
+        "EventName": "BR_TAKEN_PRED_RETIRED",
+        "BriefDescription": "Counts architecturally executed branches that=
 were taken and were correctly predicted."
+    },
+    {
+        "PublicDescription": "Counts architecturally executed branches tha=
t were taken and were mispredicted causing a pipeline flush.",
+        "EventCode": "0x8119",
+        "EventName": "BR_TAKEN_MIS_PRED_RETIRED",
+        "BriefDescription": "Counts architecturally executed branches that=
 were taken and were mispredicted causing a pipeline flush."
+    },
+    {
+        "PublicDescription": "Counts architecturally executed branches tha=
t were not taken and were correctly predicted.",
+        "EventCode": "0x811A",
+        "EventName": "BR_SKIP_PRED_RETIRED",
+        "BriefDescription": "Counts architecturally executed branches that=
 were not taken and were correctly predicted."
+    },
+    {
+        "PublicDescription": "Counts architecturally executed branches tha=
t were not taken and were mispredicted causing a pipeline flush.",
+        "EventCode": "0x811B",
+        "EventName": "BR_SKIP_MIS_PRED_RETIRED",
+        "BriefDescription": "Counts architecturally executed branches that=
 were not taken and were mispredicted causing a pipeline flush."
+    },
     {
         "PublicDescription": "Counts branch instructions counted by BR_RET=
IRED which were correctly predicted.",
         "EventCode": "0x811C",
@@ -911,6 +947,12 @@
         "EventName": "BR_IND_RETIRED",
         "BriefDescription": "Counts architecturally executed indirect bran=
ches including procedure returns."
     },
+    {
+        "PublicDescription": "Counts branch records captured which are not=
 removed by filtering.",
+        "EventCode": "0x811F",
+        "EventName": "BRB_FILTRATE",
+        "BriefDescription": "Counts branch records captured which are not =
removed by filtering."
+    },
     {
         "PublicDescription": "Counts number of instruction fetches outstan=
ding per cycle, which will provide an average latency of instruction fetch.=
",
         "EventCode": "0x8120",
@@ -977,6 +1019,30 @@
         "EventName": "SAMPLE_FEED_LAT",
         "BriefDescription": "Counts statistical profiling samples taken wh=
ich are exceeding minimum latency set by operation latency filter constrain=
ts."
     },
+    {
+        "PublicDescription": "Counts level 1 data TLB demand accesses caus=
ed by memory read or write operations. This event counts whether the access=
 hits or misses in the TLB. This event does not count TLB maintenance opera=
tions.",
+        "EventCode": "0x8130",
+        "EventName": "L1D_TLB_RW",
+        "BriefDescription": "Counts level 1 data TLB demand accesses cause=
d by memory read or write operations. This event counts whether the access =
hits or misses in the TLB. This event does not count TLB maintenance operat=
ions."
+    },
+    {
+        "PublicDescription": "Counts level 1 instruction TLB demand access=
es whether the access hits or misses in the TLB.",
+        "EventCode": "0x8131",
+        "EventName": "L1I_TLB_RD",
+        "BriefDescription": "Counts level 1 instruction TLB demand accesse=
s whether the access hits or misses in the TLB."
+    },
+    {
+        "PublicDescription": "Counts level 1 data TLB accesses generated b=
y software prefetch or preload memory accesses. Load or store instructions =
can be broken into multiple memory operations. This event does not count TL=
B maintenance operations.",
+        "EventCode": "0x8132",
+        "EventName": "L1D_TLB_PRFM",
+        "BriefDescription": "Counts level 1 data TLB accesses generated by=
 software prefetch or preload memory accesses. Load or store instructions c=
an be broken into multiple memory operations. This event does not count TLB=
 maintenance operations."
+    },
+    {
+        "PublicDescription": "Counts level 1 instruction TLB accesses gene=
rated by software preload or prefetch instructions. This event counts wheth=
er the access hits or misses in the TLB. This event does not count TLB main=
tenance operations.",
+        "EventCode": "0x8133",
+        "EventName": "L1I_TLB_PRFM",
+        "BriefDescription": "Counts level 1 instruction TLB accesses gener=
ated by software preload or prefetch instructions. This event counts whethe=
r the access hits or misses in the TLB. This event does not count TLB maint=
enance operations."
+    },
     {
         "PublicDescription": "Counts number of memory accesses triggered b=
y a data translation table walk and performing an update of a translation t=
able entry. Memory accesses are counted even if the translation ended up ta=
king a translation fault for reasons different than EPD, E0PD and NFD. Note=
 that this event counts accesses triggered by software preloads, but not ac=
cesses triggered by hardware prefetchers.",
         "EventCode": "0x8134",
@@ -1025,12 +1091,78 @@
         "EventName": "ITLB_WALK_SMALL",
         "BriefDescription": "Counts number of instruction translation tabl=
e walks caused by a miss in the L2 TLB and yielding a small page. The set o=
f small pages is defined as all pages with a final size lower than 2MB. Tra=
nslation table walks that end up taking a translation fault are not counted=
, as the page size would be undefined in that case. In this family, this is=
 equal to ITLB_WALK_PAGE event. Note that partial translations that cause a=
 translation table walk are also counted. Also note that this event does no=
t count walks triggered by TLB maintenance operations."
     },
+    {
+        "PublicDescription": "Counts number of demand data translation tab=
le walks caused by a miss in the L2 TLB and performing at least one memory =
access. Translation table walks are counted even if the translation ended u=
p taking a translation fault for reasons different than EPD, E0PD and NFD. =
Note that partial translations that cause a translation table walk are also=
 counted. Also note that this event does not count walks triggered by TLB m=
aintenance operations.",
+        "EventCode": "0x813C",
+        "EventName": "DTLB_WALK_RW",
+        "BriefDescription": "Counts number of demand data translation tabl=
e walks caused by a miss in the L2 TLB and performing at least one memory a=
ccess. Translation table walks are counted even if the translation ended up=
 taking a translation fault for reasons different than EPD, E0PD and NFD. N=
ote that partial translations that cause a translation table walk are also =
counted. Also note that this event does not count walks triggered by TLB ma=
intenance operations."
+    },
+    {
+        "PublicDescription": "Counts number of demand instruction translat=
ion table walks caused by a miss in the L2 TLB and performing at least one =
memory access. Translation table walks are counted even if the translation =
ended up taking a translation fault for reasons different than EPD, E0PD an=
d NFD. Note that partial translations that cause a translation table walk a=
re also counted. Also note that this event does not count walks triggered b=
y TLB maintenance operations.",
+        "EventCode": "0x813D",
+        "EventName": "ITLB_WALK_RD",
+        "BriefDescription": "Counts number of demand instruction translati=
on table walks caused by a miss in the L2 TLB and performing at least one m=
emory access. Translation table walks are counted even if the translation e=
nded up taking a translation fault for reasons different than EPD, E0PD and=
 NFD. Note that partial translations that cause a translation table walk ar=
e also counted. Also note that this event does not count walks triggered by=
 TLB maintenance operations."
+    },
+    {
+        "PublicDescription": "Counts number of software prefetches or prel=
oads generated data translation table walks caused by a miss in the L2 TLB =
and performing at least one memory access. Translation table walks are coun=
ted even if the translation ended up taking a translation fault for reasons=
 different than EPD, E0PD and NFD. Note that partial translations that caus=
e a translation table walk are also counted. Also note that this event does=
 not count walks triggered by TLB maintenance operations.",
+        "EventCode": "0x813E",
+        "EventName": "DTLB_WALK_PRFM",
+        "BriefDescription": "Counts number of software prefetches or prelo=
ads generated data translation table walks caused by a miss in the L2 TLB a=
nd performing at least one memory access. Translation table walks are count=
ed even if the translation ended up taking a translation fault for reasons =
different than EPD, E0PD and NFD. Note that partial translations that cause=
 a translation table walk are also counted. Also note that this event does =
not count walks triggered by TLB maintenance operations."
+    },
+    {
+        "PublicDescription": "Counts number of software prefetches or prel=
oads generated instruction translation table walks caused by a miss in the =
L2 TLB and performing at least one memory access. Translation table walks a=
re counted even if the translation ended up taking a translation fault for =
reasons different than EPD, E0PD and NFD. Note that partial translations th=
at cause a translation table walk are also counted. Also note that this eve=
nt does not count walks triggered by TLB maintenance operations.",
+        "EventCode": "0x813F",
+        "EventName": "ITLB_WALK_PRFM",
+        "BriefDescription": "Counts number of software prefetches or prelo=
ads generated instruction translation table walks caused by a miss in the L=
2 TLB and performing at least one memory access. Translation table walks ar=
e counted even if the translation ended up taking a translation fault for r=
easons different than EPD, E0PD and NFD. Note that partial translations tha=
t cause a translation table walk are also counted. Also note that this even=
t does not count walks triggered by TLB maintenance operations."
+    },
     {
         "PublicDescription": "Counts level 1 data demand cache accesses fr=
om any load or store operation. Near atomic operations that resolve in the =
CPUs caches counts as both a write access and read access.",
         "EventCode": "0x8140",
         "EventName": "L1D_CACHE_RW",
         "BriefDescription": "Counts level 1 data demand cache accesses fro=
m any load or store operation. Near atomic operations that resolve in the C=
PUs caches counts as both a write access and read access."
     },
+    {
+        "PublicDescription": "Counts demand instruction fetches which acce=
ss the level 1 instruction cache.",
+        "EventCode": "0x8141",
+        "EventName": "L1I_CACHE_RD",
+        "BriefDescription": "Counts demand instruction fetches which acces=
s the level 1 instruction cache."
+    },
+    {
+        "PublicDescription": "Counts level 1 data cache accesses from soft=
ware preload or prefetch instructions.",
+        "EventCode": "0x8142",
+        "EventName": "L1D_CACHE_PRFM",
+        "BriefDescription": "Counts level 1 data cache accesses from softw=
are preload or prefetch instructions."
+    },
+    {
+        "PublicDescription": "Counts instruction fetches generated by soft=
ware preload or prefetch instructions which access the level 1 instruction =
cache.",
+        "EventCode": "0x8143",
+        "EventName": "L1I_CACHE_PRFM",
+        "BriefDescription": "Counts instruction fetches generated by softw=
are preload or prefetch instructions which access the level 1 instruction c=
ache."
+    },
+    {
+        "PublicDescription": "Counts cache line misses in the level 1 data=
 cache.",
+        "EventCode": "0x8144",
+        "EventName": "L1D_CACHE_MISS",
+        "BriefDescription": "Counts cache line misses in the level 1 data =
cache."
+    },
+    {
+        "PublicDescription": "Counts instruction fetches which access the =
level 1 instruction cache generated by the hardware prefetcher.",
+        "EventCode": "0x8145",
+        "EventName": "L1I_CACHE_HWPRF",
+        "BriefDescription": "Counts instruction fetches which access the l=
evel 1 instruction cache generated by the hardware prefetcher."
+    },
+    {
+        "PublicDescription": "Counts level 1 data cache refills where the =
cache line access was generated by software preload or prefetch instruction=
s.",
+        "EventCode": "0x8146",
+        "EventName": "L1D_CACHE_REFILL_PRFM",
+        "BriefDescription": "Counts level 1 data cache refills where the c=
ache line access was generated by software preload or prefetch instructions=
."
+    },
+    {
+        "PublicDescription": "Counts cache line refills in the level 1 ins=
truction cache caused by a missed instruction fetch generated by software p=
reload or prefetch instructions. Instruction fetches may include accessing =
multiple instructions, but the single cache line allocation is counted once=
.",
+        "EventCode": "0x8147",
+        "EventName": "L1I_CACHE_REFILL_PRFM",
+        "BriefDescription": "Counts cache line refills in the level 1 inst=
ruction cache caused by a missed instruction fetch generated by software pr=
eload or prefetch instructions. Instruction fetches may include accessing m=
ultiple instructions, but the single cache line allocation is counted once.=
"
+    },
     {
         "PublicDescription": "Counts level 2 cache demand accesses from an=
y load/store operations. Level 2 cache is a unified cache for data and inst=
ruction accesses, accesses are for misses in the level 1 data cache or tran=
slation resolutions due to accesses.",
         "EventCode": "0x8148",
@@ -1043,6 +1175,24 @@
         "EventName": "L2I_CACHE_RD",
         "BriefDescription": "Counts level 2 cache accesses that are due to=
 a demand instruction cache access."
     },
+    {
+        "PublicDescription": "Counts level 2 data cache accesses generated=
 by software preload or prefetch instructions.",
+        "EventCode": "0x814A",
+        "EventName": "L2D_CACHE_PRFM",
+        "BriefDescription": "Counts level 2 data cache accesses generated =
by software preload or prefetch instructions."
+    },
+    {
+        "PublicDescription": "Counts cache line misses in the level 2 cach=
e. Level 2 cache is a unified cache for data and instruction accesses. Acce=
sses are for misses in the level 1 data cache or translation resolutions du=
e to accesses.",
+        "EventCode": "0x814C",
+        "EventName": "L2D_CACHE_MISS",
+        "BriefDescription": "Counts cache line misses in the level 2 cache=
. Level 2 cache is a unified cache for data and instruction accesses. Acces=
ses are for misses in the level 1 data cache or translation resolutions due=
 to accesses."
+    },
+    {
+        "PublicDescription": "Counts refills due to accesses generated as =
a result of software preload or prefetch instructions as counted by L2D_CAC=
HE_PRFM.",
+        "EventCode": "0x814E",
+        "EventName": "L2D_CACHE_REFILL_PRFM",
+        "BriefDescription": "Counts refills due to accesses generated as a=
 result of software preload or prefetch instructions as counted by L2D_CACH=
E_PRFM."
+    },
     {
         "PublicDescription": "Counts level 3 cache accesses that missed in=
 the level 3 cache.",
         "EventCode": "0x8152",
@@ -1055,6 +1205,12 @@
         "EventName": "L1D_CACHE_HWPRF",
         "BriefDescription": "Counts level 1 data cache accesses from any l=
oad/store operations generated by the hardware prefetcher."
     },
+    {
+        "PublicDescription": "Counts level 2 data cache accesses generated=
 by L2D hardware prefetchers.",
+        "EventCode": "0x8155",
+        "EventName": "L2D_CACHE_HWPRF",
+        "BriefDescription": "Counts level 2 data cache accesses generated =
by L2D hardware prefetchers."
+    },
     {
         "PublicDescription": "Counts cycles when the frontend could not se=
nd any micro-operations to the rename stage due to resource constraints in =
the memory resources.",
         "EventCode": "0x8158",
@@ -1109,6 +1265,12 @@
         "EventName": "STALL_BACKEND_L1D",
         "BriefDescription": "Counts cycles when the backend is stalled bec=
ause there is a pending demand load request in progress in the level 1 data=
 cache."
     },
+    {
+        "PublicDescription": "Counts cycles when the backend is stalled be=
cause there is a pending demand load request in progress in the level 2 dat=
a cache.",
+        "EventCode": "0x8166",
+        "EventName": "STALL_BACKEND_L2D",
+        "BriefDescription": "Counts cycles when the backend is stalled bec=
ause there is a pending demand load request in progress in the level 2 data=
 cache."
+    },
     {
         "PublicDescription": "Counts cycles when the backend is stalled on=
 any demand TLB misses being handled.",
         "EventCode": "0x8167",
@@ -1133,6 +1295,12 @@
         "EventName": "STALL_BACKEND_BUSY",
         "BriefDescription": "Counts cycles when the backend could not acce=
pt any micro-operations because the issue queues are full to take any opera=
tions for execution."
     },
+    {
+        "PublicDescription": "Counts cycles when the backend could not acc=
ept any micro-operations due to resource constraints imposed by input depen=
dency.",
+        "EventCode": "0x816C",
+        "EventName": "STALL_BACKEND_ILOCK",
+        "BriefDescription": "Counts cycles when the backend could not acce=
pt any micro-operations due to resource constraints imposed by input depend=
ency."
+    },
     {
         "PublicDescription": "Counts cycles when backend is stalled even w=
hen operations are available from the frontend but at least one is not read=
y to be sent to the backend because no rename register is available.",
         "EventCode": "0x816D",
@@ -1163,6 +1331,54 @@
         "EventName": "L1D_CACHE_REFILL_HWPRF",
         "BriefDescription": "Counts level 1 data cache refills where the c=
ache line is requested by a hardware prefetcher."
     },
+    {
+        "PublicDescription": "Counts demand instruction fetches that acces=
s the level 1 instruction cache and hit in the L1 instruction cache.",
+        "EventCode": "0x81C0",
+        "EventName": "L1I_CACHE_HIT_RD",
+        "BriefDescription": "Counts demand instruction fetches that access=
 the level 1 instruction cache and hit in the L1 instruction cache."
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches that acces=
s the level 1 instruction cache that hit in the L1 instruction cache and th=
e line was requested by a software prefetch.",
+        "EventCode": "0x81D0",
+        "EventName": "L1I_CACHE_HIT_RD_FPRFM",
+        "BriefDescription": "Counts demand instruction fetches that access=
 the level 1 instruction cache that hit in the L1 instruction cache and the=
 line was requested by a software prefetch."
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches generated =
by hardware prefetch that access the level 1 instruction cache and hit in t=
he L1 instruction cache.",
+        "EventCode": "0x81E0",
+        "EventName": "L1I_CACHE_HIT_RD_FHWPRF",
+        "BriefDescription": "Counts demand instruction fetches generated b=
y hardware prefetch that access the level 1 instruction cache and hit in th=
e L1 instruction cache."
+    },
+    {
+        "PublicDescription": "Counts instruction fetches that access the l=
evel 1 instruction cache and hit in the level 1 instruction cache. Instruct=
ion cache accesses caused by cache maintenance operations are not counted."=
,
+        "EventCode": "0x8200",
+        "EventName": "L1I_CACHE_HIT",
+        "BriefDescription": "Counts instruction fetches that access the le=
vel 1 instruction cache and hit in the level 1 instruction cache. Instructi=
on cache accesses caused by cache maintenance operations are not counted."
+    },
+    {
+        "PublicDescription": "Counts instruction fetches generated by soft=
ware preload or prefetch instructions that access the level 1 instruction c=
ache and hit in the level 1 instruction cache.",
+        "EventCode": "0x8208",
+        "EventName": "L1I_CACHE_HIT_PRFM",
+        "BriefDescription": "Counts instruction fetches generated by softw=
are preload or prefetch instructions that access the level 1 instruction ca=
che and hit in the level 1 instruction cache."
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches that acces=
s the level 1 instruction cache and hit in a line that is in the process of=
 being loaded into the level 1 instruction cache.",
+        "EventCode": "0x8240",
+        "EventName": "L1I_LFB_HIT_RD",
+        "BriefDescription": "Counts demand instruction fetches that access=
 the level 1 instruction cache and hit in a line that is in the process of =
being loaded into the level 1 instruction cache."
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches generated =
by software prefetch instructions that access the level 1 instruction cache=
 and hit in a line that is in the process of being loaded into the level 1 =
instruction cache.",
+        "EventCode": "0x8250",
+        "EventName": "L1I_LFB_HIT_RD_FPRFM",
+        "BriefDescription": "Counts demand instruction fetches generated b=
y software prefetch instructions that access the level 1 instruction cache =
and hit in a line that is in the process of being loaded into the level 1 i=
nstruction cache."
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches generated =
by hardware prefetch that access the level 1 instruction cache and hit in a=
 line that is in the process of being loaded into the level 1 instruction c=
ache.",
+        "EventCode": "0x8260",
+        "EventName": "L1I_LFB_HIT_RD_FHWPRF",
+        "BriefDescription": "Counts demand instruction fetches generated b=
y hardware prefetch that access the level 1 instruction cache and hit in a =
line that is in the process of being loaded into the level 1 instruction ca=
che."
+    },
     {
         "PublicDescription": "Counts level 2 data cache accesses from soft=
ware preload or prefetch instructions or hardware prefetcher.",
         "EventCode": "0x8285",
diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-=
events/arch/arm64/mapfile.csv
index 7ef4ecbeb6ed..843fbd8c0503 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -36,6 +36,7 @@
 0x00000000410fd480,v1,arm/cortex-x2,core
 0x00000000410fd490,v1,arm/neoverse-n2-v2,core
 0x00000000410fd4f0,v1,arm/neoverse-n2-v2,core
+0x00000000410fd830,v1,arm/neoverse-v3,core
 0x00000000410fd8e0,v1,arm/neoverse-n3,core
 0x00000000420f5160,v1,cavium/thunderx2,core
 0x00000000430f0af0,v1,cavium/thunderx2,core
--=20
2.47.1.613.gc27f4b7a9f-goog

