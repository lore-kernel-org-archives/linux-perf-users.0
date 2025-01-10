Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3568C567D
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jan 2025 17:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736529623; cv=none; b=q4NTXNxwkf0kDYNzl6XkMsUcGupMJu7VRQr2UwThT7txHCMfGoiigmcgwNxk2PspqNHU+Yk8IK7yOlWcDfN4/cWlXTJCpLnVbSKwogqZy8ma5x2WxXkJI0nk6PH45xHkvsVYwP6MqkrGFrrJKNr9qxyK+Qno6FxpkuGPuxLr/HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736529623; c=relaxed/simple;
	bh=AEpQvNbbAMYK0heXmm0joYwy0KNfLUHEYgQN2/HNFHU=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=nwpk+mRX4TytjtjEkGTxGARR5N+7rB25RiHEIfw9pM6OiWrHIrlV9lWpFQVupVJuBFsQN0emxLm6hf7P3+RFKhSuw08vYxIPeDPt9Ca7K7TrWvjeDRNz6kGCojKXnjDEzuI7Nj1qTgotz0i8DZL49T1DDrPx9tvCPOf2TJqQwYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ceGafUub; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ceGafUub"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e3a0d165daeso5255171276.1
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Jan 2025 09:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736529617; x=1737134417; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:mime-version:message-id
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SAN2Wzrgtf+PBr2noCz+rdTCjzON6nO5DjoZ7oyiBLY=;
        b=ceGafUubZVu8A7SR/4veu5Q8zHUDptmY6ZKsU1CZnoReObo026uNdu0Wgtm431EQBJ
         OtUd+eDtBJmawz7AaO6JpgTiK1qlXvET4DO2LJ0XtNkfqY4FyfYiZhfHBhDuKVvV8KBz
         QLVTf6trONdw/jYTyYIRiMiIq4nO7YPnISt2o2+TeA+o0VfO860x2raZEieYy6Wg9aZZ
         3a6a6zlBGKkbmMhqVyUmbyE0PfVgfKKFBC5HMOQG6kH2QKA6/4x1xrui/Ncjm/2pQ6Hl
         +lWcJIh7J9pUMpwShpAn995q8eqmx0hICKmoecpDt8oWBoAZn8gKZcjAlwu3x/5HXJfQ
         Cz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736529617; x=1737134417;
        h=content-transfer-encoding:to:from:subject:mime-version:message-id
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SAN2Wzrgtf+PBr2noCz+rdTCjzON6nO5DjoZ7oyiBLY=;
        b=cgPJvPulCAW3lSNZ7ZMDtEFVq4QuwpMe/rGI/aFgUepBPGDmCnD4bOXXD8XGlLm+6U
         WmC8XOkwZS2Nm8CqaqBswXFneJBLOUi2KLqb82iF6Eit0FvyfzPFDMUDdoeivMo3h/uU
         jqkaMoe6/T6kGBCC6H6XrGs5EDwSJhvdbiT5Nl3fI6xe8n9m712RF2dzBr4mkZjfgLBQ
         hS6s5IcQxuqkolPhL/6G46j+ejjIsjzThQdSxP0bpAYmG1WPLs4K/C6Qcj/Fxy/TWliP
         IfnJqfOcS3MyJkTp3eCDAEDJGtaXYWmvkqZQxWrqGbmpowpGg01vXLkZT/HjFKs8U9zx
         ZPRg==
X-Forwarded-Encrypted: i=1; AJvYcCWcBpjBdNpI2+4XkWYlhZEo1iMhkZWxHenOM3Je3G/iJdfoLAGmNs3lAM55VYhRXPR8G+qBU5/72rE0xsuIU2cc@vger.kernel.org
X-Gm-Message-State: AOJu0YxOcXLq5a9xje9gGklnACxXFK1p2GD2SRWTXxGH1K4hHj2z56aW
	GASc4GgDcLPkqUSeHY8ki9wWc0UcYguy0apWm6ReSwHn3z2gEXbVOumTOAJ5ujfmxfZwozjsiKr
	qiZ+XgA==
X-Google-Smtp-Source: AGHT+IHh4YHA2qMp/3/881s97Atl/WEBEALoV/gf8doutWK8ZF2q56eR1FC5WwmINj2mYPv5Nym0CTGyogbm
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:7ea3:d1e5:495a:9a4f])
 (user=irogers job=sendgmr) by 2002:a25:acdd:0:b0:e39:74d9:af96 with SMTP id
 3f1490d57ef6-e54ee22d806mr23489276.7.1736529617071; Fri, 10 Jan 2025 09:20:17
 -0800 (PST)
Date: Fri, 10 Jan 2025 09:20:05 -0800
Message-Id: <20250110172006.680753-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1 1/2] perf vendor events arm64: Add N3 events/metrics
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
  telemetry-solution/data/pmu/cpu/neoverse/neoverse-n3.json:neoverse-n3
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arm64/arm/neoverse-n3/core-imp-def.json   | 930 ++++++++++++++++++
 .../arch/arm64/arm/neoverse-n3/metrics.json   | 471 +++++++++
 .../arch/arm64/common-and-microarch.json      | 372 +++++++
 tools/perf/pmu-events/arch/arm64/mapfile.csv  |   1 +
 4 files changed, 1774 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/core-i=
mp-def.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/metric=
s.json

diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/core-imp-def.=
json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/core-imp-def.json
new file mode 100644
index 000000000000..995c49111e78
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/core-imp-def.json
@@ -0,0 +1,930 @@
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
+        "ArchStdEvent": "PC_WRITE_RETIRED",
+        "PublicDescription": "Counts branch instructions that caused a cha=
nge of Program Counter, which effectively causes a change in the control fl=
ow of the program."
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
+        "ArchStdEvent": "L2D_CACHE_ALLOCATE",
+        "PublicDescription": "Counts level 2 cache line allocates that do =
not fetch data from outside the level 2 data or unified cache."
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
+        "ArchStdEvent": "L2I_CACHE",
+        "PublicDescription": "Counts accesses to the level 2 cache due to =
instruction accesses. Level 2 cache is a unified cache for data and instruc=
tion accesses. Accesses are for misses in the first level instruction cache=
."
+    },
+    {
+        "ArchStdEvent": "L2I_CACHE_REFILL",
+        "PublicDescription": "Counts cache line refills into the level 2 c=
ache. Level 2 cache is a unified cache for data and instruction accesses. A=
ccesses are for misses in the level 1 instruction cache."
+    },
+    {
+        "ArchStdEvent": "L3D_CACHE_ALLOCATE",
+        "PublicDescription": "Counts level 3 cache line allocates that do =
not fetch data from outside the level 3 data or unified cache. For example,=
 allocates due to streaming stores."
+    },
+    {
+        "ArchStdEvent": "L3D_CACHE_REFILL",
+        "PublicDescription": "Counts level 3 accesses that receive data fr=
om outside the L3 cache."
+    },
+    {
+        "ArchStdEvent": "L3D_CACHE",
+        "PublicDescription": "Counts level 3 cache accesses. Level 3 cache=
 is a unified cache for data and instruction accesses. Accesses are for mis=
ses in the lower level caches or translation resolutions due to accesses."
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
+        "ArchStdEvent": "LL_CACHE",
+        "PublicDescription": "Counts transactions that were returned from =
outside the core cluster. This event counts transactions for external last =
level cache when the system register CPUECTLR.EXTLLC bit is set, otherwise =
it counts transactions for L3 cache."
+    },
+    {
+        "ArchStdEvent": "LL_CACHE_MISS",
+        "PublicDescription": "Counts transactions that were returned from =
outside the core cluster and missed in the last level cache"
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
+        "ArchStdEvent": "L3D_CACHE_RD",
+        "PublicDescription": "Counts level 3 cache accesses caused by any =
memory read operation. Level 3 cache is a unified cache for data and instru=
ction accesses. Accesses are for misses in the lower level caches or transl=
ation resolutions due to accesses."
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
+        "PublicDescription": "Counts each cycle counted by STALL_BACKEND_B=
USY where the backend is stalled due to the SX IQ being full",
+        "EventCode": "0x15C",
+        "EventName": "IMP_STALL_BACKEND_IQ_SX",
+        "BriefDescription": "Counts each cycle counted by STALL_BACKEND_BU=
SY where the backend is stalled due to the SX IQ being full"
+    },
+    {
+        "PublicDescription": "Counts each cycle counted by STALL_BACKEND_B=
USY where the backend is stalled due to the MX IQ being full",
+        "EventCode": "0x15D",
+        "EventName": "IMP_STALL_BACKEND_IQ_MX",
+        "BriefDescription": "Counts each cycle counted by STALL_BACKEND_BU=
SY where the backend is stalled due to the MX IQ being full"
+    },
+    {
+        "PublicDescription": "Counts each cycle counted by STALL_BACKEND_B=
USY where the backend is stalled due to the LS IQ being full",
+        "EventCode": "0x15E",
+        "EventName": "IMP_STALL_BACKEND_IQ_LS",
+        "BriefDescription": "Counts each cycle counted by STALL_BACKEND_BU=
SY where the backend is stalled due to the LS IQ being full"
+    },
+    {
+        "PublicDescription": "Counts each cycle counted by STALL_BACKEND_B=
USY where the backend is stalled due to the VX IQ being full",
+        "EventCode": "0x15F",
+        "EventName": "IMP_STALL_BACKEND_IQ_VX",
+        "BriefDescription": "Counts each cycle counted by STALL_BACKEND_BU=
SY where the backend is stalled due to the VX IQ being full"
+    },
+    {
+        "PublicDescription": "Counts each cycle counted by STALL_BACKEND_C=
PUBOUND where the backend is stalled due to the MCQ being full",
+        "EventCode": "0x160",
+        "EventName": "IMP_STALL_BACKEND_MCQ",
+        "BriefDescription": "Counts each cycle counted by STALL_BACKEND_CP=
UBOUND where the backend is stalled due to the MCQ being full"
+    },
+    {
+        "PublicDescription": "Count of RXDAT or RXRSP responses received w=
ith indication completer fullness indicator set to 0",
+        "EventCode": "0x198",
+        "EventName": "IMP_L2_CHI_CBUSY0",
+        "BriefDescription": "Count of RXDAT or RXRSP responses received wi=
th indication completer fullness indicator set to 0"
+    },
+    {
+        "PublicDescription": "Count of RXDAT or RXRSP responses received w=
ith indication completer fullness indicator set to 1",
+        "EventCode": "0x199",
+        "EventName": "IMP_L2_CHI_CBUSY1",
+        "BriefDescription": "Count of RXDAT or RXRSP responses received wi=
th indication completer fullness indicator set to 1"
+    },
+    {
+        "PublicDescription": "Count of RXDAT or RXRSP responses received w=
ith indication completer fullness indicator set to 2",
+        "EventCode": "0x19A",
+        "EventName": "IMP_L2_CHI_CBUSY2",
+        "BriefDescription": "Count of RXDAT or RXRSP responses received wi=
th indication completer fullness indicator set to 2"
+    },
+    {
+        "PublicDescription": "Count of RXDAT or RXRSP responses received w=
ith indication completer fullness indicator set to 3",
+        "EventCode": "0x19B",
+        "EventName": "IMP_L2_CHI_CBUSY3",
+        "BriefDescription": "Count of RXDAT or RXRSP responses received wi=
th indication completer fullness indicator set to 3"
+    },
+    {
+        "PublicDescription": "Count of RXDAT or RXRSP responses received w=
ith indication completer indicating multiple cores actively making requests=
",
+        "EventCode": "0x19C",
+        "EventName": "IMP_L2_CHI_CBUSY_MT",
+        "BriefDescription": "Count of RXDAT or RXRSP responses received wi=
th indication completer indicating multiple cores actively making requests"
+    },
+    {
+        "PublicDescription": "Counts each cycle counted by STALL_BACKEND_C=
PUBOUND where the backend is stalled due to the PCRF being full",
+        "EventCode": "0x1003",
+        "EventName": "IMP_STALL_BACKEND_PCRF",
+        "BriefDescription": "Counts each cycle counted by STALL_BACKEND_CP=
UBOUND where the backend is stalled due to the PCRF being full"
+    },
+    {
+        "PublicDescription": "Counts each cycle counted by STALL_BACKEND_C=
PUBOUND where the backend is stalled due to the return stack being full",
+        "EventCode": "0x1005",
+        "EventName": "IMP_STALL_BACKEND_RSTACK",
+        "BriefDescription": "Counts each cycle counted by STALL_BACKEND_CP=
UBOUND where the backend is stalled due to the return stack being full"
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
+        "ArchStdEvent": "L2I_CACHE_LMISS",
+        "PublicDescription": "Counts cache line refills into the level 2 u=
nified cache from any instruction read operations that incurred additional =
latency."
+    },
+    {
+        "ArchStdEvent": "L3D_CACHE_LMISS_RD",
+        "PublicDescription": "Counts any cache line refill into the level =
3 cache from memory read operations that incurred additional latency."
+    },
+    {
+        "ArchStdEvent": "TRB_WRAP",
+        "PublicDescription": "This event is generated each time the curren=
t write pointer is wrapped to the base pointer."
+    },
+    {
+        "ArchStdEvent": "TRB_TRIG",
+        "PublicDescription": "This event is generated when a Trace Buffer =
Extension Trigger Event occurs."
+    },
+    {
+        "ArchStdEvent": "TRCEXTOUT0",
+        "PublicDescription": "This event is generated each time an event i=
s signaled by ETE external event 0."
+    },
+    {
+        "ArchStdEvent": "TRCEXTOUT1",
+        "PublicDescription": "This event is generated each time an event i=
s signaled by ETE external event 1."
+    },
+    {
+        "ArchStdEvent": "TRCEXTOUT2",
+        "PublicDescription": "This event is generated each time an event i=
s signaled by ETE external event 2."
+    },
+    {
+        "ArchStdEvent": "TRCEXTOUT3",
+        "PublicDescription": "This event is generated each time an event i=
s signaled by ETE external event 3."
+    },
+    {
+        "ArchStdEvent": "CTI_TRIGOUT4",
+        "PublicDescription": "This event is generated each time an event i=
s signaled on CTI output trigger 4."
+    },
+    {
+        "ArchStdEvent": "CTI_TRIGOUT5",
+        "PublicDescription": "This event is generated each time an event i=
s signaled on CTI output trigger 5."
+    },
+    {
+        "ArchStdEvent": "CTI_TRIGOUT6",
+        "PublicDescription": "This event is generated each time an event i=
s signaled on CTI output trigger 6."
+    },
+    {
+        "ArchStdEvent": "CTI_TRIGOUT7",
+        "PublicDescription": "This event is generated each time an event i=
s signaled on CTI output trigger 7."
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
+        "ArchStdEvent": "BR_IMMED_TAKEN_RETIRED",
+        "PublicDescription": "Counts architecturally executed direct branc=
hes that were taken."
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
+        "ArchStdEvent": "L1D_CACHE_RW",
+        "PublicDescription": "Counts level 1 data demand cache accesses fr=
om any load or store operation. Near atomic operations that resolve in the =
CPUs caches counts as both a write access and read access."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_RW",
+        "PublicDescription": "Counts level 2 cache demand accesses from an=
y load/store operations. Level 2 cache is a unified cache for data and inst=
ruction accesses, accesses are for misses in the level 1 data cache or tran=
slation resolutions due to accesses."
+    },
+    {
+        "ArchStdEvent": "L2I_CACHE_RD",
+        "PublicDescription": "Counts level 2 cache accesses that are due t=
o a demand instruction cache access."
+    },
+    {
+        "ArchStdEvent": "L3D_CACHE_MISS",
+        "PublicDescription": "Counts level 3 cache accesses that missed in=
 the level 3 cache."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_HWPRF",
+        "PublicDescription": "Counts level 1 data cache accesses from any =
load/store operations generated by the hardware prefetcher."
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
+        "ArchStdEvent": "STALL_BACKEND_RENAME",
+        "PublicDescription": "Counts cycles when backend is stalled even w=
hen operations are available from the frontend but at least one is not read=
y to be sent to the backend because no rename register is available."
+    },
+    {
+        "ArchStdEvent": "CAS_NEAR_PASS",
+        "PublicDescription": "Counts compare and swap instructions that ex=
ecuted locally to the PE and updated the location accessed."
+    },
+    {
+        "ArchStdEvent": "CAS_NEAR_SPEC",
+        "PublicDescription": "Counts compare and swap instructions that ex=
ecuted locally to the PE."
+    },
+    {
+        "ArchStdEvent": "CAS_FAR_SPEC",
+        "PublicDescription": "Counts compare and swap instructions that di=
d not execute locally to the PE."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_HWPRF",
+        "PublicDescription": "Counts level 1 data cache refills where the =
cache line is requested by a hardware prefetcher."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_PRF",
+        "PublicDescription": "Counts level 2 data cache accesses from soft=
ware preload or prefetch instructions or hardware prefetcher."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_REFILL_PRF",
+        "PublicDescription": "Counts refills due to accesses generated as =
a result of prefetches."
+    },
+    {
+        "ArchStdEvent": "LL_CACHE_REFILL",
+        "PublicDescription": "Counts last level accesses that receive data=
 from outside the last level cache."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/metrics.json =
b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/metrics.json
new file mode 100644
index 000000000000..5265c7749fe8
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/metrics.json
@@ -0,0 +1,471 @@
+[
+    {
+        "MetricName": "backend_bound",
+        "MetricExpr": "STALL_SLOT_BACKEND / (5 * CPU_CYCLES) * 100",
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
+        "MetricExpr": "(1 - STALL_SLOT / (5 * CPU_CYCLES)) * (1 - OP_RETIR=
ED / OP_SPEC) * 100 + STALL_FRONTEND_FLUSH / CPU_CYCLES * 100",
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
+        "MetricExpr": "PC_WRITE_SPEC / INST_SPEC * 100",
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
+        "MetricExpr": "(STALL_SLOT_FRONTEND / (5 * CPU_CYCLES) - STALL_FRO=
NTEND_FLUSH / CPU_CYCLES) * 100",
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
+        "MetricExpr": "(DP_SPEC - DSB_SPEC) / INST_SPEC * 100",
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
+        "MetricExpr": "(1 - STALL_SLOT / (CPU_CYCLES * 5)) * (OP_RETIRED /=
 OP_SPEC) * 100",
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
index 492083b99256..3409e39bb8df 100644
--- a/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
+++ b/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
@@ -227,6 +227,18 @@
         "EventName": "L1I_TLB",
         "BriefDescription": "Attributable Level 1 instruction TLB access"
     },
+    {
+        "PublicDescription": "Counts accesses to the level 2 cache due to =
instruction accesses. Level 2 cache is a unified cache for data and instruc=
tion accesses. Accesses are for misses in the first level instruction cache=
.",
+        "EventCode": "0x27",
+        "EventName": "L2I_CACHE",
+        "BriefDescription": "Counts accesses to the level 2 cache due to i=
nstruction accesses. Level 2 cache is a unified cache for data and instruct=
ion accesses. Accesses are for misses in the first level instruction cache.=
"
+    },
+    {
+        "PublicDescription": "Counts cache line refills into the level 2 c=
ache. Level 2 cache is a unified cache for data and instruction accesses. A=
ccesses are for misses in the level 1 instruction cache.",
+        "EventCode": "0x28",
+        "EventName": "L2I_CACHE_REFILL",
+        "BriefDescription": "Counts cache line refills into the level 2 ca=
che. Level 2 cache is a unified cache for data and instruction accesses. Ac=
cesses are for misses in the level 1 instruction cache."
+    },
     {
         "PublicDescription": "Attributable Level 3 data cache allocation w=
ithout refill",
         "EventCode": "0x29",
@@ -275,6 +287,18 @@
         "EventName": "REMOTE_ACCESS",
         "BriefDescription": "Access to another socket in a multi-socket sy=
stem"
     },
+    {
+        "PublicDescription": "Counts transactions that were returned from =
outside the core cluster. This event counts transactions for external last =
level cache when the system register CPUECTLR.EXTLLC bit is set, otherwise =
it counts transactions for L3 cache.",
+        "EventCode": "0x32",
+        "EventName": "LL_CACHE",
+        "BriefDescription": "Counts transactions that were returned from o=
utside the core cluster. This event counts transactions for external last l=
evel cache when the system register CPUECTLR.EXTLLC bit is set, otherwise i=
t counts transactions for L3 cache."
+    },
+    {
+        "PublicDescription": "Counts transactions that were returned from =
outside the core cluster and missed in the last level cache",
+        "EventCode": "0x33",
+        "EventName": "LL_CACHE_MISS",
+        "BriefDescription": "Counts transactions that were returned from o=
utside the core cluster and missed in the last level cache"
+    },
     {
         "PublicDescription": "Access to data TLB causes a translation tabl=
e walk",
         "EventCode": "0x34",
@@ -395,6 +419,12 @@
         "EventName": "L2D_CACHE_LMISS_RD",
         "BriefDescription": "Level 2 data cache long-latency read miss"
     },
+    {
+        "PublicDescription": "Counts cache line refills into the level 2 u=
nified cache from any instruction read operations that incurred additional =
latency.",
+        "EventCode": "0x400A",
+        "EventName": "L2I_CACHE_LMISS",
+        "BriefDescription": "Counts cache line refills into the level 2 un=
ified cache from any instruction read operations that incurred additional l=
atency."
+    },
     {
         "PublicDescription": "Level 3 data cache long-latency read miss.  =
The counter counts each memory read access counted by L3D_CACHE that incurs=
 additional latency because it returns data from outside the Level 3 data o=
r unified cache of this processing element.  The event indicates to softwar=
e that the access missed in the Level 3 data or unified cache and might hav=
e a significant performance impact compared to the latency of an access tha=
t hits in the Level 3 data or unified cache.",
         "EventCode": "0x400B",
@@ -808,5 +838,347 @@
         "EventCode": "0x80EF",
         "EventName": "ASE_SVE_INT64_SPEC",
         "BriefDescription": "Advanced SIMD and SVE 64-bit integer operatio=
ns speculatively executed"
+    },
+    {
+        "PublicDescription": "Counts architecturally executed direct branc=
hes that were taken.",
+        "EventCode": "0x8108",
+        "EventName": "BR_IMMED_TAKEN_RETIRED",
+        "BriefDescription": "Counts architecturally executed direct branch=
es that were taken."
+    },
+    {
+        "PublicDescription": "Counts architecturally executed indirect bra=
nches excluding procedure returns that were taken.",
+        "EventCode": "0x810C",
+        "EventName": "BR_INDNR_TAKEN_RETIRED",
+        "BriefDescription": "Counts architecturally executed indirect bran=
ches excluding procedure returns that were taken."
+    },
+    {
+        "PublicDescription": "Counts architecturally executed direct branc=
hes that were correctly predicted.",
+        "EventCode": "0x8110",
+        "EventName": "BR_IMMED_PRED_RETIRED",
+        "BriefDescription": "Counts architecturally executed direct branch=
es that were correctly predicted."
+    },
+    {
+        "PublicDescription": "Counts architecturally executed direct branc=
hes that were mispredicted and caused a pipeline flush.",
+        "EventCode": "0x8111",
+        "EventName": "BR_IMMED_MIS_PRED_RETIRED",
+        "BriefDescription": "Counts architecturally executed direct branch=
es that were mispredicted and caused a pipeline flush."
+    },
+    {
+        "PublicDescription": "Counts architecturally executed indirect bra=
nches including procedure returns that were correctly predicted.",
+        "EventCode": "0x8112",
+        "EventName": "BR_IND_PRED_RETIRED",
+        "BriefDescription": "Counts architecturally executed indirect bran=
ches including procedure returns that were correctly predicted."
+    },
+    {
+        "PublicDescription": "Counts architecturally executed indirect bra=
nches including procedure returns that were mispredicted and caused a pipel=
ine flush.",
+        "EventCode": "0x8113",
+        "EventName": "BR_IND_MIS_PRED_RETIRED",
+        "BriefDescription": "Counts architecturally executed indirect bran=
ches including procedure returns that were mispredicted and caused a pipeli=
ne flush."
+    },
+    {
+        "PublicDescription": "Counts architecturally executed procedure re=
turns that were correctly predicted.",
+        "EventCode": "0x8114",
+        "EventName": "BR_RETURN_PRED_RETIRED",
+        "BriefDescription": "Counts architecturally executed procedure ret=
urns that were correctly predicted."
+    },
+    {
+        "PublicDescription": "Counts architecturally executed procedure re=
turns that were mispredicted and caused a pipeline flush.",
+        "EventCode": "0x8115",
+        "EventName": "BR_RETURN_MIS_PRED_RETIRED",
+        "BriefDescription": "Counts architecturally executed procedure ret=
urns that were mispredicted and caused a pipeline flush."
+    },
+    {
+        "PublicDescription": "Counts architecturally executed indirect bra=
nches excluding procedure returns that were correctly predicted.",
+        "EventCode": "0x8116",
+        "EventName": "BR_INDNR_PRED_RETIRED",
+        "BriefDescription": "Counts architecturally executed indirect bran=
ches excluding procedure returns that were correctly predicted."
+    },
+    {
+        "PublicDescription": "Counts architecturally executed indirect bra=
nches excluding procedure returns that were mispredicted and caused a pipel=
ine flush.",
+        "EventCode": "0x8117",
+        "EventName": "BR_INDNR_MIS_PRED_RETIRED",
+        "BriefDescription": "Counts architecturally executed indirect bran=
ches excluding procedure returns that were mispredicted and caused a pipeli=
ne flush."
+    },
+    {
+        "PublicDescription": "Counts branch instructions counted by BR_RET=
IRED which were correctly predicted.",
+        "EventCode": "0x811C",
+        "EventName": "BR_PRED_RETIRED",
+        "BriefDescription": "Counts branch instructions counted by BR_RETI=
RED which were correctly predicted."
+    },
+    {
+        "PublicDescription": "Counts architecturally executed indirect bra=
nches including procedure returns.",
+        "EventCode": "0x811D",
+        "EventName": "BR_IND_RETIRED",
+        "BriefDescription": "Counts architecturally executed indirect bran=
ches including procedure returns."
+    },
+    {
+        "PublicDescription": "Counts number of instruction fetches outstan=
ding per cycle, which will provide an average latency of instruction fetch.=
",
+        "EventCode": "0x8120",
+        "EventName": "INST_FETCH_PERCYC",
+        "BriefDescription": "Counts number of instruction fetches outstand=
ing per cycle, which will provide an average latency of instruction fetch."
+    },
+    {
+        "PublicDescription": "Counts the number of outstanding loads or me=
mory read accesses per cycle.",
+        "EventCode": "0x8121",
+        "EventName": "MEM_ACCESS_RD_PERCYC",
+        "BriefDescription": "Counts the number of outstanding loads or mem=
ory read accesses per cycle."
+    },
+    {
+        "PublicDescription": "Counts Instruction memory accesses that the =
PE makes.",
+        "EventCode": "0x8124",
+        "EventName": "INST_FETCH",
+        "BriefDescription": "Counts Instruction memory accesses that the P=
E makes."
+    },
+    {
+        "PublicDescription": "Counts the number of data translation table =
walks in progress per cycle.",
+        "EventCode": "0x8128",
+        "EventName": "DTLB_WALK_PERCYC",
+        "BriefDescription": "Counts the number of data translation table w=
alks in progress per cycle."
+    },
+    {
+        "PublicDescription": "Counts the number of instruction translation=
 table walks in progress per cycle.",
+        "EventCode": "0x8129",
+        "EventName": "ITLB_WALK_PERCYC",
+        "BriefDescription": "Counts the number of instruction translation =
table walks in progress per cycle."
+    },
+    {
+        "PublicDescription": "Counts statistical profiling samples taken w=
hich are branches.",
+        "EventCode": "0x812A",
+        "EventName": "SAMPLE_FEED_BR",
+        "BriefDescription": "Counts statistical profiling samples taken wh=
ich are branches."
+    },
+    {
+        "PublicDescription": "Counts statistical profiling samples taken w=
hich are loads or load atomic operations.",
+        "EventCode": "0x812B",
+        "EventName": "SAMPLE_FEED_LD",
+        "BriefDescription": "Counts statistical profiling samples taken wh=
ich are loads or load atomic operations."
+    },
+    {
+        "PublicDescription": "Counts statistical profiling samples taken w=
hich are stores or store atomic operations.",
+        "EventCode": "0x812C",
+        "EventName": "SAMPLE_FEED_ST",
+        "BriefDescription": "Counts statistical profiling samples taken wh=
ich are stores or store atomic operations."
+    },
+    {
+        "PublicDescription": "Counts statistical profiling samples taken w=
hich are matching any operation type filters supported.",
+        "EventCode": "0x812D",
+        "EventName": "SAMPLE_FEED_OP",
+        "BriefDescription": "Counts statistical profiling samples taken wh=
ich are matching any operation type filters supported."
+    },
+    {
+        "PublicDescription": "Counts statistical profiling samples taken w=
hich are matching event packet filter constraints.",
+        "EventCode": "0x812E",
+        "EventName": "SAMPLE_FEED_EVENT",
+        "BriefDescription": "Counts statistical profiling samples taken wh=
ich are matching event packet filter constraints."
+    },
+    {
+        "PublicDescription": "Counts statistical profiling samples taken w=
hich are exceeding minimum latency set by operation latency filter constrai=
nts.",
+        "EventCode": "0x812F",
+        "EventName": "SAMPLE_FEED_LAT",
+        "BriefDescription": "Counts statistical profiling samples taken wh=
ich are exceeding minimum latency set by operation latency filter constrain=
ts."
+    },
+    {
+        "PublicDescription": "Counts number of memory accesses triggered b=
y a data translation table walk and performing an update of a translation t=
able entry. Memory accesses are counted even if the translation ended up ta=
king a translation fault for reasons different than EPD, E0PD and NFD. Note=
 that this event counts accesses triggered by software preloads, but not ac=
cesses triggered by hardware prefetchers.",
+        "EventCode": "0x8134",
+        "EventName": "DTLB_HWUPD",
+        "BriefDescription": "Counts number of memory accesses triggered by=
 a data translation table walk and performing an update of a translation ta=
ble entry. Memory accesses are counted even if the translation ended up tak=
ing a translation fault for reasons different than EPD, E0PD and NFD. Note =
that this event counts accesses triggered by software preloads, but not acc=
esses triggered by hardware prefetchers."
+    },
+    {
+        "PublicDescription": "Counts number of memory accesses triggered b=
y an instruction translation table walk and performing an update of a trans=
lation table entry. Memory accesses are counted even if the translation end=
ed up taking a translation fault for reasons different than EPD, E0PD and N=
FD.",
+        "EventCode": "0x8135",
+        "EventName": "ITLB_HWUPD",
+        "BriefDescription": "Counts number of memory accesses triggered by=
 an instruction translation table walk and performing an update of a transl=
ation table entry. Memory accesses are counted even if the translation ende=
d up taking a translation fault for reasons different than EPD, E0PD and NF=
D."
+    },
+    {
+        "PublicDescription": "Counts number of memory accesses triggered b=
y a demand data translation table walk and performing a read of a translati=
on table entry. Memory accesses are counted even if the translation ended u=
p taking a translation fault for reasons different than EPD, E0PD and NFD. =
Note that this event counts accesses triggered by software preloads, but no=
t accesses triggered by hardware prefetchers.",
+        "EventCode": "0x8136",
+        "EventName": "DTLB_STEP",
+        "BriefDescription": "Counts number of memory accesses triggered by=
 a demand data translation table walk and performing a read of a translatio=
n table entry. Memory accesses are counted even if the translation ended up=
 taking a translation fault for reasons different than EPD, E0PD and NFD. N=
ote that this event counts accesses triggered by software preloads, but not=
 accesses triggered by hardware prefetchers."
+    },
+    {
+        "PublicDescription": "Counts number of memory accesses triggered b=
y an instruction translation table walk and performing a read of a translat=
ion table entry. Memory accesses are counted even if the translation ended =
up taking a translation fault for reasons different than EPD, E0PD and NFD.=
",
+        "EventCode": "0x8137",
+        "EventName": "ITLB_STEP",
+        "BriefDescription": "Counts number of memory accesses triggered by=
 an instruction translation table walk and performing a read of a translati=
on table entry. Memory accesses are counted even if the translation ended u=
p taking a translation fault for reasons different than EPD, E0PD and NFD."
+    },
+    {
+        "PublicDescription": "Counts number of demand data translation tab=
le walks caused by a miss in the L2 TLB and yielding a large page. The set =
of large pages is defined as all pages with a final size higher than or equ=
al to 2MB. Translation table walks that end up taking a translation fault a=
re not counted, as the page size would be undefined in that case. If DTLB_W=
ALK_BLOCK is implemented, then it is an alias for this event in this family=
. Note that partial translations that cause a translation table walk are al=
so counted. Also note that this event counts walks triggered by software pr=
eloads, but not walks triggered by hardware prefetchers, and that this even=
t does not count walks triggered by TLB maintenance operations.",
+        "EventCode": "0x8138",
+        "EventName": "DTLB_WALK_LARGE",
+        "BriefDescription": "Counts number of demand data translation tabl=
e walks caused by a miss in the L2 TLB and yielding a large page. The set o=
f large pages is defined as all pages with a final size higher than or equa=
l to 2MB. Translation table walks that end up taking a translation fault ar=
e not counted, as the page size would be undefined in that case. If DTLB_WA=
LK_BLOCK is implemented, then it is an alias for this event in this family.=
 Note that partial translations that cause a translation table walk are als=
o counted. Also note that this event counts walks triggered by software pre=
loads, but not walks triggered by hardware prefetchers, and that this event=
 does not count walks triggered by TLB maintenance operations."
+    },
+    {
+        "PublicDescription": "Counts number of instruction translation tab=
le walks caused by a miss in the L2 TLB and yielding a large page. The set =
of large pages is defined as all pages with a final size higher than or equ=
al to 2MB. Translation table walks that end up taking a translation fault a=
re not counted, as the page size would be undefined in that case. In this f=
amily, this is equal to ITLB_WALK_BLOCK event. Note that partial translatio=
ns that cause a translation table walk are also counted. Also note that thi=
s event does not count walks triggered by TLB maintenance operations.",
+        "EventCode": "0x8139",
+        "EventName": "ITLB_WALK_LARGE",
+        "BriefDescription": "Counts number of instruction translation tabl=
e walks caused by a miss in the L2 TLB and yielding a large page. The set o=
f large pages is defined as all pages with a final size higher than or equa=
l to 2MB. Translation table walks that end up taking a translation fault ar=
e not counted, as the page size would be undefined in that case. In this fa=
mily, this is equal to ITLB_WALK_BLOCK event. Note that partial translation=
s that cause a translation table walk are also counted. Also note that this=
 event does not count walks triggered by TLB maintenance operations."
+    },
+    {
+        "PublicDescription": "Counts number of data translation table walk=
s caused by a miss in the L2 TLB and yielding a small page. The set of smal=
l pages is defined as all pages with a final size lower than 2MB. Translati=
on table walks that end up taking a translation fault are not counted, as t=
he page size would be undefined in that case. If DTLB_WALK_PAGE event is im=
plemented, then it is an alias for this event in this family. Note that par=
tial translations that cause a translation table walk are also counted. Als=
o note that this event counts walks triggered by software preloads, but not=
 walks triggered by hardware prefetchers, and that this event does not coun=
t walks triggered by TLB maintenance operations.",
+        "EventCode": "0x813A",
+        "EventName": "DTLB_WALK_SMALL",
+        "BriefDescription": "Counts number of data translation table walks=
 caused by a miss in the L2 TLB and yielding a small page. The set of small=
 pages is defined as all pages with a final size lower than 2MB. Translatio=
n table walks that end up taking a translation fault are not counted, as th=
e page size would be undefined in that case. If DTLB_WALK_PAGE event is imp=
lemented, then it is an alias for this event in this family. Note that part=
ial translations that cause a translation table walk are also counted. Also=
 note that this event counts walks triggered by software preloads, but not =
walks triggered by hardware prefetchers, and that this event does not count=
 walks triggered by TLB maintenance operations."
+    },
+    {
+        "PublicDescription": "Counts number of instruction translation tab=
le walks caused by a miss in the L2 TLB and yielding a small page. The set =
of small pages is defined as all pages with a final size lower than 2MB. Tr=
anslation table walks that end up taking a translation fault are not counte=
d, as the page size would be undefined in that case. In this family, this i=
s equal to ITLB_WALK_PAGE event. Note that partial translations that cause =
a translation table walk are also counted. Also note that this event does n=
ot count walks triggered by TLB maintenance operations.",
+        "EventCode": "0x813B",
+        "EventName": "ITLB_WALK_SMALL",
+        "BriefDescription": "Counts number of instruction translation tabl=
e walks caused by a miss in the L2 TLB and yielding a small page. The set o=
f small pages is defined as all pages with a final size lower than 2MB. Tra=
nslation table walks that end up taking a translation fault are not counted=
, as the page size would be undefined in that case. In this family, this is=
 equal to ITLB_WALK_PAGE event. Note that partial translations that cause a=
 translation table walk are also counted. Also note that this event does no=
t count walks triggered by TLB maintenance operations."
+    },
+    {
+        "PublicDescription": "Counts level 1 data demand cache accesses fr=
om any load or store operation. Near atomic operations that resolve in the =
CPUs caches counts as both a write access and read access.",
+        "EventCode": "0x8140",
+        "EventName": "L1D_CACHE_RW",
+        "BriefDescription": "Counts level 1 data demand cache accesses fro=
m any load or store operation. Near atomic operations that resolve in the C=
PUs caches counts as both a write access and read access."
+    },
+    {
+        "PublicDescription": "Counts level 2 cache demand accesses from an=
y load/store operations. Level 2 cache is a unified cache for data and inst=
ruction accesses, accesses are for misses in the level 1 data cache or tran=
slation resolutions due to accesses.",
+        "EventCode": "0x8148",
+        "EventName": "L2D_CACHE_RW",
+        "BriefDescription": "Counts level 2 cache demand accesses from any=
 load/store operations. Level 2 cache is a unified cache for data and instr=
uction accesses, accesses are for misses in the level 1 data cache or trans=
lation resolutions due to accesses."
+    },
+    {
+        "PublicDescription": "Counts level 2 cache accesses that are due t=
o a demand instruction cache access.",
+        "EventCode": "0x8149",
+        "EventName": "L2I_CACHE_RD",
+        "BriefDescription": "Counts level 2 cache accesses that are due to=
 a demand instruction cache access."
+    },
+    {
+        "PublicDescription": "Counts level 3 cache accesses that missed in=
 the level 3 cache.",
+        "EventCode": "0x8152",
+        "EventName": "L3D_CACHE_MISS",
+        "BriefDescription": "Counts level 3 cache accesses that missed in =
the level 3 cache."
+    },
+    {
+        "PublicDescription": "Counts level 1 data cache accesses from any =
load/store operations generated by the hardware prefetcher.",
+        "EventCode": "0x8154",
+        "EventName": "L1D_CACHE_HWPRF",
+        "BriefDescription": "Counts level 1 data cache accesses from any l=
oad/store operations generated by the hardware prefetcher."
+    },
+    {
+        "PublicDescription": "Counts cycles when the frontend could not se=
nd any micro-operations to the rename stage due to resource constraints in =
the memory resources.",
+        "EventCode": "0x8158",
+        "EventName": "STALL_FRONTEND_MEMBOUND",
+        "BriefDescription": "Counts cycles when the frontend could not sen=
d any micro-operations to the rename stage due to resource constraints in t=
he memory resources."
+    },
+    {
+        "PublicDescription": "Counts cycles when the frontend is stalled b=
ecause there is an instruction fetch request pending in the level 1 instruc=
tion cache.",
+        "EventCode": "0x8159",
+        "EventName": "STALL_FRONTEND_L1I",
+        "BriefDescription": "Counts cycles when the frontend is stalled be=
cause there is an instruction fetch request pending in the level 1 instruct=
ion cache."
+    },
+    {
+        "PublicDescription": "Counts cycles when the frontend is stalled b=
ecause there is an instruction fetch request pending in the last level core=
 cache.",
+        "EventCode": "0x815B",
+        "EventName": "STALL_FRONTEND_MEM",
+        "BriefDescription": "Counts cycles when the frontend is stalled be=
cause there is an instruction fetch request pending in the last level core =
cache."
+    },
+    {
+        "PublicDescription": "Counts when the frontend is stalled on any T=
LB misses being handled. This event also counts the TLB accesses made by ha=
rdware prefetches.",
+        "EventCode": "0x815C",
+        "EventName": "STALL_FRONTEND_TLB",
+        "BriefDescription": "Counts when the frontend is stalled on any TL=
B misses being handled. This event also counts the TLB accesses made by har=
dware prefetches."
+    },
+    {
+        "PublicDescription": "Counts cycles when the frontend could not se=
nd any micro-operations to the rename stage due to resource constraints in =
the CPU resources excluding memory resources.",
+        "EventCode": "0x8160",
+        "EventName": "STALL_FRONTEND_CPUBOUND",
+        "BriefDescription": "Counts cycles when the frontend could not sen=
d any micro-operations to the rename stage due to resource constraints in t=
he CPU resources excluding memory resources."
+    },
+    {
+        "PublicDescription": "Counts cycles when the frontend could not se=
nd any micro-operations to the rename stage due to resource constraints in =
the branch prediction unit.",
+        "EventCode": "0x8161",
+        "EventName": "STALL_FRONTEND_FLOW",
+        "BriefDescription": "Counts cycles when the frontend could not sen=
d any micro-operations to the rename stage due to resource constraints in t=
he branch prediction unit."
+    },
+    {
+        "PublicDescription": "Counts cycles when the frontend could not se=
nd any micro-operations to the rename stage as the frontend is recovering f=
rom a machine flush or resteer. Example scenarios that cause a flush includ=
e branch mispredictions, taken exceptions, micro-architectural flush etc.",
+        "EventCode": "0x8162",
+        "EventName": "STALL_FRONTEND_FLUSH",
+        "BriefDescription": "Counts cycles when the frontend could not sen=
d any micro-operations to the rename stage as the frontend is recovering fr=
om a machine flush or resteer. Example scenarios that cause a flush include=
 branch mispredictions, taken exceptions, micro-architectural flush etc."
+    },
+    {
+        "PublicDescription": "Counts cycles when the backend could not acc=
ept any micro-operations due to resource constraints in the memory resource=
s.",
+        "EventCode": "0x8164",
+        "EventName": "STALL_BACKEND_MEMBOUND",
+        "BriefDescription": "Counts cycles when the backend could not acce=
pt any micro-operations due to resource constraints in the memory resources=
."
+    },
+    {
+        "PublicDescription": "Counts cycles when the backend is stalled be=
cause there is a pending demand load request in progress in the level 1 dat=
a cache.",
+        "EventCode": "0x8165",
+        "EventName": "STALL_BACKEND_L1D",
+        "BriefDescription": "Counts cycles when the backend is stalled bec=
ause there is a pending demand load request in progress in the level 1 data=
 cache."
+    },
+    {
+        "PublicDescription": "Counts cycles when the backend is stalled on=
 any demand TLB misses being handled.",
+        "EventCode": "0x8167",
+        "EventName": "STALL_BACKEND_TLB",
+        "BriefDescription": "Counts cycles when the backend is stalled on =
any demand TLB misses being handled."
+    },
+    {
+        "PublicDescription": "Counts cycles when the backend is stalled an=
d there is a store that has not reached the pre-commit stage.",
+        "EventCode": "0x8168",
+        "EventName": "STALL_BACKEND_ST",
+        "BriefDescription": "Counts cycles when the backend is stalled and=
 there is a store that has not reached the pre-commit stage."
+    },
+    {
+        "PublicDescription": "Counts cycles when the backend could not acc=
ept any micro-operations due to any resource constraints in the CPU excludi=
ng memory resources.",
+        "EventCode": "0x816A",
+        "EventName": "STALL_BACKEND_CPUBOUND",
+        "BriefDescription": "Counts cycles when the backend could not acce=
pt any micro-operations due to any resource constraints in the CPU excludin=
g memory resources."
+    },
+    {
+        "PublicDescription": "Counts cycles when the backend could not acc=
ept any micro-operations because the issue queues are full to take any oper=
ations for execution.",
+        "EventCode": "0x816B",
+        "EventName": "STALL_BACKEND_BUSY",
+        "BriefDescription": "Counts cycles when the backend could not acce=
pt any micro-operations because the issue queues are full to take any opera=
tions for execution."
+    },
+    {
+        "PublicDescription": "Counts cycles when backend is stalled even w=
hen operations are available from the frontend but at least one is not read=
y to be sent to the backend because no rename register is available.",
+        "EventCode": "0x816D",
+        "EventName": "STALL_BACKEND_RENAME",
+        "BriefDescription": "Counts cycles when backend is stalled even wh=
en operations are available from the frontend but at least one is not ready=
 to be sent to the backend because no rename register is available."
+    },
+    {
+        "PublicDescription": "Counts compare and swap instructions that ex=
ecuted locally to the PE and updated the location accessed.",
+        "EventCode": "0x8171",
+        "EventName": "CAS_NEAR_PASS",
+        "BriefDescription": "Counts compare and swap instructions that exe=
cuted locally to the PE and updated the location accessed."
+    },
+    {
+        "PublicDescription": "Counts compare and swap instructions that ex=
ecuted locally to the PE.",
+        "EventCode": "0x8172",
+        "EventName": "CAS_NEAR_SPEC",
+        "BriefDescription": "Counts compare and swap instructions that exe=
cuted locally to the PE."
+    },
+    {
+        "PublicDescription": "Counts compare and swap instructions that di=
d not execute locally to the PE.",
+        "EventCode": "0x8173",
+        "EventName": "CAS_FAR_SPEC",
+        "BriefDescription": "Counts compare and swap instructions that did=
 not execute locally to the PE."
+    },
+    {
+        "PublicDescription": "Counts level 1 data cache refills where the =
cache line is requested by a hardware prefetcher.",
+        "EventCode": "0x81BC",
+        "EventName": "L1D_CACHE_REFILL_HWPRF",
+        "BriefDescription": "Counts level 1 data cache refills where the c=
ache line is requested by a hardware prefetcher."
+    },
+    {
+        "PublicDescription": "Counts level 2 data cache accesses from soft=
ware preload or prefetch instructions or hardware prefetcher.",
+        "EventCode": "0x8285",
+        "EventName": "L2D_CACHE_PRF",
+        "BriefDescription": "Counts level 2 data cache accesses from softw=
are preload or prefetch instructions or hardware prefetcher."
+    },
+    {
+        "PublicDescription": "Counts refills due to accesses generated as =
a result of prefetches.",
+        "EventCode": "0x828D",
+        "EventName": "L2D_CACHE_REFILL_PRF",
+        "BriefDescription": "Counts refills due to accesses generated as a=
 result of prefetches."
+    },
+    {
+        "PublicDescription": "Counts last level accesses that receive data=
 from outside the last level cache.",
+        "EventCode": "0x829A",
+        "EventName": "LL_CACHE_REFILL",
+        "BriefDescription": "Counts last level accesses that receive data =
from outside the last level cache."
     }
 ]
diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-=
events/arch/arm64/mapfile.csv
index f4d1ca4d1493..7ef4ecbeb6ed 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -36,6 +36,7 @@
 0x00000000410fd480,v1,arm/cortex-x2,core
 0x00000000410fd490,v1,arm/neoverse-n2-v2,core
 0x00000000410fd4f0,v1,arm/neoverse-n2-v2,core
+0x00000000410fd8e0,v1,arm/neoverse-n3,core
 0x00000000420f5160,v1,cavium/thunderx2,core
 0x00000000430f0af0,v1,cavium/thunderx2,core
 0x00000000460f0010,v1,fujitsu/a64fx,core
--=20
2.47.1.613.gc27f4b7a9f-goog

