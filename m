Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C9235A925
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Nov 2025 23:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762470977; cv=none; b=pYHYWl7NpdLxvQcGI1huSd+wD4POmuUmYT3sbl5z6+WokTFp9MixBwSxoh9/PsicvCv+qQZJWuOEqd6qhFhBsJaBAsySMJH8n+N2jwq0W1S3HHUU5VkmDzgA7SOOo10dBSXh+CrC7RvEnEc8BEjp6RpN3HCFH8Zqv4/WWZQLEno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762470977; c=relaxed/simple;
	bh=AFcs6+rjxtStyzpkioRSsmyt39X8o4eClMImkcveLCE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=H3Dx1d4vZj8EbwJEAxb5FlWjWV8AtpBsXZt+KZKPmctBuuGgcmM/Kr9sXM0gFkSJkcUOnf5dUoBL1edY3iNDqk+syNdCmRDMO3rUuYF5LqXelPIAcdKJwzub9OUAkQgJSw+DlrrMC2hd1nUeoTgNxrGr/A04pGc1mpJxmMIcgv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c8aL5Xy7; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c8aL5Xy7"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-29555415c09so2108865ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Nov 2025 15:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762470974; x=1763075774; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8cRYA0ERZ0V23DLhAFevtzUM8W7rleEmFjmg1uBWjV8=;
        b=c8aL5Xy7IlaxJtDiDUC8ol5vnCbZomRrcDZd0gJBn28azGDJ4pQHSMekb7TOm+mwIg
         +9eqpmueqbkU+A5ooXV6vILQXUMX2KBF7XfVpwd4LsiO87pte0XZBvTVjlZVg5ISE2m5
         D7RKyL634IlRDjJM4wUbaYS4ocKL+QHE2C6sqRIkFZXijeU64DPqHY4dw6b5hdPh2pCZ
         C0YVCAfps3fZ61Y2EHMJYa0FHnmIrQR+8oxpBEtPUfV4NmogwlmtaErv/RtltnYiC6Nx
         IG255LokArGpPDD6bwWFhJYQoQa+izMW6FbAUo2ytS1knL+lOq4Z0HUMJA5Ue8RDPEeZ
         2ZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762470974; x=1763075774;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8cRYA0ERZ0V23DLhAFevtzUM8W7rleEmFjmg1uBWjV8=;
        b=eEJzQkbTyTBfAfBKoAQpXZmAkrwE023v2ZO/c+J+RWaMfSkBPO0ginac93wc5mQ27E
         9OLnurLbJg5DgvsbRC6muVNVKzJS06AXiu1/SyXS9DlFOzRSxa6kOud+NyUSh+WzfUFK
         e+iWC/WuBsxUFPydqYtUsEH7cLUKDDWn5cCxSpD8uUGG/09yDCFyWVFz95B7HQH69twW
         roCBpj/rbRjBzVrB0gOpFKZ2qf61hI1l5DaobzBwUm9KsV6NCnlDhS1fH2jdC36gIqsh
         wFI65u9R1YdGd/pirS0BdW8orTrjijvDQKAdzHLM0Igcqb0nBS5H24vdSHAkJnthH0MI
         LEtw==
X-Forwarded-Encrypted: i=1; AJvYcCW6M3b/xoYsDY++Cs1YWS75MU+wJ0mMh/APs/w0o+ZtsmdRk+BseuU66Bvi4jVaEb5uqniOrN9c4CjCH5I97uAi@vger.kernel.org
X-Gm-Message-State: AOJu0YzQfSOZqJD5b2CbAI9a2hOh0PqOc2h6R7BfhcO25NaKYuu1l7J1
	+dm6MAfMIhrCRBjJ+nXVpwVP7O+Xf/WVipm8pnCj6qnI2zXK2KnAiMA7eWFW/SOfJaixFyh/0z9
	OLFjO5ju9JQ==
X-Google-Smtp-Source: AGHT+IF6plEej6OlCU/kCAZQl6PR6TsZQAaYuBXrN9z+AncmSBmk5WknCrMJ0N+I06n2TLUteFZEdWBtsc68
X-Received: from dlf6.prod.google.com ([2002:a05:7022:406:b0:119:b185:ea6d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1585:b0:295:589a:d12a
 with SMTP id d9443c01a7336-297c0380fc3mr11675455ad.8.1762470973640; Thu, 06
 Nov 2025 15:16:13 -0800 (PST)
Date: Thu,  6 Nov 2025 15:15:08 -0800
In-Reply-To: <20251106231508.448793-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106231508.448793-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106231508.448793-19-irogers@google.com>
Subject: [PATCH v2 18/18] perf tool_pmu: Make core_wide and target_cpu json events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For the sake of better documentation, add core_wide and target_cpu to
the tool.json. When the values of system_wide and
user_requested_cpu_list are unknown, use the values from the global
stat_config.

Example output showing how '-a' modifies the values in `perf stat`:
```
$ perf stat -e core_wide,target_cpu true

 Performance counter stats for 'true':

                 0      core_wide
                 0      target_cpu

       0.000993787 seconds time elapsed

       0.001128000 seconds user
       0.000000000 seconds sys

$ perf stat -e core_wide,target_cpu -a true

 Performance counter stats for 'system wide':

                 1      core_wide
                 1      target_cpu

       0.002271723 seconds time elapsed

$ perf list
...
tool:
  core_wide
       [1 if not SMT,if SMT are events being gathered on all SMT threads 1 =
otherwise 0. Unit: tool]
...
  target_cpu
       [1 if CPUs being analyzed,0 if threads/processes. Unit: tool]
...
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/common/common/tool.json   |  12 +
 tools/perf/pmu-events/empty-pmu-events.c      | 228 +++++++++---------
 tools/perf/util/expr.c                        |  11 +-
 tools/perf/util/stat-shadow.c                 |   2 +
 tools/perf/util/tool_pmu.c                    |  24 +-
 tools/perf/util/tool_pmu.h                    |   9 +-
 6 files changed, 163 insertions(+), 123 deletions(-)

diff --git a/tools/perf/pmu-events/arch/common/common/tool.json b/tools/per=
f/pmu-events/arch/common/common/tool.json
index 12f2ef1813a6..14d0d60a1976 100644
--- a/tools/perf/pmu-events/arch/common/common/tool.json
+++ b/tools/perf/pmu-events/arch/common/common/tool.json
@@ -70,5 +70,17 @@
     "EventName": "system_tsc_freq",
     "BriefDescription": "The amount a Time Stamp Counter (TSC) increases p=
er second",
     "ConfigCode": "12"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "core_wide",
+    "BriefDescription": "1 if not SMT, if SMT are events being gathered on=
 all SMT threads 1 otherwise 0",
+    "ConfigCode": "13"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "target_cpu",
+    "BriefDescription": "1 if CPUs being analyzed, 0 if threads/processes"=
,
+    "ConfigCode": "14"
   }
 ]
diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-even=
ts/empty-pmu-events.c
index e882c645fbbe..be904c243f80 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -1279,62 +1279,64 @@ static const char *const big_c_string =3D
 /* offset=3D125873 */ "slots\000tool\000Number of functional units that in=
 parallel can execute parts of an instruction\000config=3D0xa\000\00000\000=
\000\000\000\000"
 /* offset=3D125983 */ "smt_on\000tool\0001 if simultaneous multithreading =
(aka hyperthreading) is enable otherwise 0\000config=3D0xb\000\00000\000\00=
0\000\000\000"
 /* offset=3D126090 */ "system_tsc_freq\000tool\000The amount a Time Stamp =
Counter (TSC) increases per second\000config=3D0xc\000\00000\000\000\000\00=
0\000"
-/* offset=3D126189 */ "bp_l1_btb_correct\000branch\000L1 BTB Correction\00=
0event=3D0x8a\000\00000\000\000\000\000\000"
-/* offset=3D126251 */ "bp_l2_btb_correct\000branch\000L2 BTB Correction\00=
0event=3D0x8b\000\00000\000\000\000\000\000"
-/* offset=3D126313 */ "l3_cache_rd\000cache\000L3 cache access, read\000ev=
ent=3D0x40\000\00000\000\000\000\000Attributable Level 3 cache access, read=
\000"
-/* offset=3D126411 */ "segment_reg_loads.any\000other\000Number of segment=
 register loads\000event=3D6,period=3D200000,umask=3D0x80\000\00000\000\000=
\000\000\000"
-/* offset=3D126513 */ "dispatch_blocked.any\000other\000Memory cluster sig=
nals to block micro-op dispatch for any reason\000event=3D9,period=3D200000=
,umask=3D0x20\000\00000\000\000\000\000\000"
-/* offset=3D126646 */ "eist_trans\000other\000Number of Enhanced Intel Spe=
edStep(R) Technology (EIST) transitions\000event=3D0x3a,period=3D200000\000=
\00000\000\000\000\000\000"
-/* offset=3D126764 */ "hisi_sccl,ddrc\000"
-/* offset=3D126779 */ "uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write =
commands\000event=3D2\000\00000\000\000\000\000\000"
-/* offset=3D126849 */ "uncore_cbox\000"
-/* offset=3D126861 */ "unc_cbo_xsnp_response.miss_eviction\000uncore\000A =
cross-core snoop resulted from L3 Eviction which misses in some processor c=
ore\000event=3D0x22,umask=3D0x81\000\00000\000\000\000\000\000"
-/* offset=3D127015 */ "event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=
=3D0xe0\000\00000\000\000\000\000\000"
-/* offset=3D127069 */ "event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000eve=
nt=3D0xc0\000\00000\000\000\000\000\000"
-/* offset=3D127127 */ "hisi_sccl,l3c\000"
-/* offset=3D127141 */ "uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total rea=
d hits\000event=3D7\000\00000\000\000\000\000\000"
-/* offset=3D127209 */ "uncore_imc_free_running\000"
-/* offset=3D127233 */ "uncore_imc_free_running.cache_miss\000uncore\000Tot=
al cache misses\000event=3D0x12\000\00000\000\000\000\000\000"
-/* offset=3D127313 */ "uncore_imc\000"
-/* offset=3D127324 */ "uncore_imc.cache_hits\000uncore\000Total cache hits=
\000event=3D0x34\000\00000\000\000\000\000\000"
-/* offset=3D127389 */ "uncore_sys_ddr_pmu\000"
-/* offset=3D127408 */ "sys_ddr_pmu.write_cycles\000uncore\000ddr write-cyc=
les event\000event=3D0x2b\000v8\00000\000\000\000\000\000"
-/* offset=3D127484 */ "uncore_sys_ccn_pmu\000"
-/* offset=3D127503 */ "sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycle=
s event\000config=3D0x2c\0000x01\00000\000\000\000\000\000"
-/* offset=3D127580 */ "uncore_sys_cmn_pmu\000"
-/* offset=3D127599 */ "sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts tota=
l cache misses in first lookup result (high priority)\000eventid=3D1,type=
=3D5\000(434|436|43c|43a).*\00000\000\000\000\000\000"
-/* offset=3D127742 */ "CPUs_utilized\000Default\000(software@cpu\\-clock\\=
,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=
=3Dtask\\-clock@) / (duration_time * 1e9)\000\000Average CPU utilization\00=
0\0001CPUs\000\000\000\000011"
-/* offset=3D127928 */ "cs_per_second\000Default\000software@context\\-swit=
ches\\,name\\=3Dcontext\\-switches@ * 1e9 / (software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@)\000\000Context switches per CPU second\000\0001cs/sec\000\000\000\=
000011"
-/* offset=3D128161 */ "migrations_per_second\000Default\000software@cpu\\-=
migrations\\,name\\=3Dcpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\,nam=
e\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtas=
k\\-clock@)\000\000Process migrations to a new CPU per CPU second\000\0001m=
igrations/sec\000\000\000\000011"
-/* offset=3D128421 */ "page_faults_per_second\000Default\000software@page\=
\-faults\\,name\\=3Dpage\\-faults@ * 1e9 / (software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@)\000\000Page faults per CPU second\000\0001faults/sec\000\000\000\0=
00011"
-/* offset=3D128652 */ "insn_per_cycle\000Default\000instructions / cpu\\-c=
ycles\000insn_per_cycle < 1\000Instructions Per Cycle\000\0001instructions\=
000\000\000\000001"
-/* offset=3D128765 */ "stalled_cycles_per_instruction\000Default\000max(st=
alled\\-cycles\\-frontend, stalled\\-cycles\\-backend) / instructions\000\0=
00Max front or backend stalls per instruction\000\000\000\000\000\000001"
-/* offset=3D128929 */ "frontend_cycles_idle\000Default\000stalled\\-cycles=
\\-frontend / cpu\\-cycles\000frontend_cycles_idle > 0.1\000Frontend stalls=
 per cycle\000\000\000\000\000\000001"
-/* offset=3D129059 */ "backend_cycles_idle\000Default\000stalled\\-cycles\=
\-backend / cpu\\-cycles\000backend_cycles_idle > 0.2\000Backend stalls per=
 cycle\000\000\000\000\000\000001"
-/* offset=3D129185 */ "cycles_frequency\000Default\000cpu\\-cycles / (soft=
ware@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\=
\-clock\\,name\\=3Dtask\\-clock@)\000\000Cycles per CPU second\000\0001GHz\=
000\000\000\000011"
-/* offset=3D129361 */ "branch_frequency\000Default\000branches / (software=
@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-cl=
ock\\,name\\=3Dtask\\-clock@)\000\000Branches per CPU second\000\0001000K/s=
ec\000\000\000\000011"
-/* offset=3D129541 */ "branch_miss_rate\000Default\000branch\\-misses / br=
anches\000branch_miss_rate > 0.05\000Branch miss rate\000\000100%\000\000\0=
00\000001"
-/* offset=3D129645 */ "l1d_miss_rate\000Default2\000L1\\-dcache\\-load\\-m=
isses / L1\\-dcache\\-loads\000l1d_miss_rate > 0.05\000L1D  miss rate\000\0=
00100%\000\000\000\000001"
-/* offset=3D129761 */ "llc_miss_rate\000Default2\000LLC\\-load\\-misses / =
LLC\\-loads\000llc_miss_rate > 0.05\000LLC miss rate\000\000100%\000\000\00=
0\000001"
-/* offset=3D129862 */ "l1i_miss_rate\000Default3\000L1\\-icache\\-load\\-m=
isses / L1\\-icache\\-loads\000l1i_miss_rate > 0.05\000L1I miss rate\000\00=
0100%\000\000\000\000001"
-/* offset=3D129977 */ "dtlb_miss_rate\000Default3\000dTLB\\-load\\-misses =
/ dTLB\\-loads\000dtlb_miss_rate > 0.05\000dTLB miss rate\000\000100%\000\0=
00\000\000001"
-/* offset=3D130083 */ "itlb_miss_rate\000Default3\000iTLB\\-load\\-misses =
/ iTLB\\-loads\000itlb_miss_rate > 0.05\000iTLB miss rate\000\000100%\000\0=
00\000\000001"
-/* offset=3D130189 */ "l1_prefetch_miss_rate\000Default4\000L1\\-dcache\\-=
prefetch\\-misses / L1\\-dcache\\-prefetches\000l1_prefetch_miss_rate > 0.0=
5\000L1 prefetch miss rate\000\000100%\000\000\000\000001"
-/* offset=3D130337 */ "CPI\000\0001 / IPC\000\000\000\000\000\000\000\0000=
00"
-/* offset=3D130360 */ "IPC\000group1\000inst_retired.any / cpu_clk_unhalte=
d.thread\000\000\000\000\000\000\000\000000"
-/* offset=3D130424 */ "Frontend_Bound_SMT\000\000idq_uops_not_delivered.co=
re / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_a=
ctive / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\000000"
-/* offset=3D130591 */ "dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_=
retired.any\000\000\000\000\000\000\000\000000"
-/* offset=3D130656 */ "icache_miss_cycles\000\000l1i\\-loads\\-misses / in=
st_retired.any\000\000\000\000\000\000\000\000000"
-/* offset=3D130724 */ "cache_miss_cycles\000group1\000dcache_miss_cpi + ic=
ache_miss_cycles\000\000\000\000\000\000\000\000000"
-/* offset=3D130796 */ "DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_h=
it + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\000000"
-/* offset=3D130891 */ "DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_d=
ata_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_=
miss\000\000\000\000\000\000\000\000000"
-/* offset=3D131026 */ "DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2=
_All_Miss\000\000\000\000\000\000\000\000000"
-/* offset=3D131091 */ "DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, D=
Cache_L2_All)\000\000\000\000\000\000\000\000000"
-/* offset=3D131160 */ "DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss,=
 DCache_L2_All)\000\000\000\000\000\000\000\000000"
-/* offset=3D131231 */ "M1\000\000ipc + M2\000\000\000\000\000\000\000\0000=
00"
-/* offset=3D131254 */ "M2\000\000ipc + M1\000\000\000\000\000\000\000\0000=
00"
-/* offset=3D131277 */ "M3\000\0001 / M3\000\000\000\000\000\000\000\000000=
"
-/* offset=3D131298 */ "L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9=
 / duration_time\000\000\000\000\000\000\000\000000"
+/* offset=3D126189 */ "core_wide\000tool\0001 if not SMT, if SMT are event=
s being gathered on all SMT threads 1 otherwise 0\000config=3D0xd\000\00000=
\000\000\000\000\000"
+/* offset=3D126303 */ "target_cpu\000tool\0001 if CPUs being analyzed, 0 i=
f threads/processes\000config=3D0xe\000\00000\000\000\000\000\000"
+/* offset=3D126387 */ "bp_l1_btb_correct\000branch\000L1 BTB Correction\00=
0event=3D0x8a\000\00000\000\000\000\000\000"
+/* offset=3D126449 */ "bp_l2_btb_correct\000branch\000L2 BTB Correction\00=
0event=3D0x8b\000\00000\000\000\000\000\000"
+/* offset=3D126511 */ "l3_cache_rd\000cache\000L3 cache access, read\000ev=
ent=3D0x40\000\00000\000\000\000\000Attributable Level 3 cache access, read=
\000"
+/* offset=3D126609 */ "segment_reg_loads.any\000other\000Number of segment=
 register loads\000event=3D6,period=3D200000,umask=3D0x80\000\00000\000\000=
\000\000\000"
+/* offset=3D126711 */ "dispatch_blocked.any\000other\000Memory cluster sig=
nals to block micro-op dispatch for any reason\000event=3D9,period=3D200000=
,umask=3D0x20\000\00000\000\000\000\000\000"
+/* offset=3D126844 */ "eist_trans\000other\000Number of Enhanced Intel Spe=
edStep(R) Technology (EIST) transitions\000event=3D0x3a,period=3D200000\000=
\00000\000\000\000\000\000"
+/* offset=3D126962 */ "hisi_sccl,ddrc\000"
+/* offset=3D126977 */ "uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write =
commands\000event=3D2\000\00000\000\000\000\000\000"
+/* offset=3D127047 */ "uncore_cbox\000"
+/* offset=3D127059 */ "unc_cbo_xsnp_response.miss_eviction\000uncore\000A =
cross-core snoop resulted from L3 Eviction which misses in some processor c=
ore\000event=3D0x22,umask=3D0x81\000\00000\000\000\000\000\000"
+/* offset=3D127213 */ "event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=
=3D0xe0\000\00000\000\000\000\000\000"
+/* offset=3D127267 */ "event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000eve=
nt=3D0xc0\000\00000\000\000\000\000\000"
+/* offset=3D127325 */ "hisi_sccl,l3c\000"
+/* offset=3D127339 */ "uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total rea=
d hits\000event=3D7\000\00000\000\000\000\000\000"
+/* offset=3D127407 */ "uncore_imc_free_running\000"
+/* offset=3D127431 */ "uncore_imc_free_running.cache_miss\000uncore\000Tot=
al cache misses\000event=3D0x12\000\00000\000\000\000\000\000"
+/* offset=3D127511 */ "uncore_imc\000"
+/* offset=3D127522 */ "uncore_imc.cache_hits\000uncore\000Total cache hits=
\000event=3D0x34\000\00000\000\000\000\000\000"
+/* offset=3D127587 */ "uncore_sys_ddr_pmu\000"
+/* offset=3D127606 */ "sys_ddr_pmu.write_cycles\000uncore\000ddr write-cyc=
les event\000event=3D0x2b\000v8\00000\000\000\000\000\000"
+/* offset=3D127682 */ "uncore_sys_ccn_pmu\000"
+/* offset=3D127701 */ "sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycle=
s event\000config=3D0x2c\0000x01\00000\000\000\000\000\000"
+/* offset=3D127778 */ "uncore_sys_cmn_pmu\000"
+/* offset=3D127797 */ "sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts tota=
l cache misses in first lookup result (high priority)\000eventid=3D1,type=
=3D5\000(434|436|43c|43a).*\00000\000\000\000\000\000"
+/* offset=3D127940 */ "CPUs_utilized\000Default\000(software@cpu\\-clock\\=
,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=
=3Dtask\\-clock@) / (duration_time * 1e9)\000\000Average CPU utilization\00=
0\0001CPUs\000\000\000\000011"
+/* offset=3D128126 */ "cs_per_second\000Default\000software@context\\-swit=
ches\\,name\\=3Dcontext\\-switches@ * 1e9 / (software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@)\000\000Context switches per CPU second\000\0001cs/sec\000\000\000\=
000011"
+/* offset=3D128359 */ "migrations_per_second\000Default\000software@cpu\\-=
migrations\\,name\\=3Dcpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\,nam=
e\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtas=
k\\-clock@)\000\000Process migrations to a new CPU per CPU second\000\0001m=
igrations/sec\000\000\000\000011"
+/* offset=3D128619 */ "page_faults_per_second\000Default\000software@page\=
\-faults\\,name\\=3Dpage\\-faults@ * 1e9 / (software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@)\000\000Page faults per CPU second\000\0001faults/sec\000\000\000\0=
00011"
+/* offset=3D128850 */ "insn_per_cycle\000Default\000instructions / cpu\\-c=
ycles\000insn_per_cycle < 1\000Instructions Per Cycle\000\0001instructions\=
000\000\000\000001"
+/* offset=3D128963 */ "stalled_cycles_per_instruction\000Default\000max(st=
alled\\-cycles\\-frontend, stalled\\-cycles\\-backend) / instructions\000\0=
00Max front or backend stalls per instruction\000\000\000\000\000\000001"
+/* offset=3D129127 */ "frontend_cycles_idle\000Default\000stalled\\-cycles=
\\-frontend / cpu\\-cycles\000frontend_cycles_idle > 0.1\000Frontend stalls=
 per cycle\000\000\000\000\000\000001"
+/* offset=3D129257 */ "backend_cycles_idle\000Default\000stalled\\-cycles\=
\-backend / cpu\\-cycles\000backend_cycles_idle > 0.2\000Backend stalls per=
 cycle\000\000\000\000\000\000001"
+/* offset=3D129383 */ "cycles_frequency\000Default\000cpu\\-cycles / (soft=
ware@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\=
\-clock\\,name\\=3Dtask\\-clock@)\000\000Cycles per CPU second\000\0001GHz\=
000\000\000\000011"
+/* offset=3D129559 */ "branch_frequency\000Default\000branches / (software=
@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-cl=
ock\\,name\\=3Dtask\\-clock@)\000\000Branches per CPU second\000\0001000K/s=
ec\000\000\000\000011"
+/* offset=3D129739 */ "branch_miss_rate\000Default\000branch\\-misses / br=
anches\000branch_miss_rate > 0.05\000Branch miss rate\000\000100%\000\000\0=
00\000001"
+/* offset=3D129843 */ "l1d_miss_rate\000Default2\000L1\\-dcache\\-load\\-m=
isses / L1\\-dcache\\-loads\000l1d_miss_rate > 0.05\000L1D  miss rate\000\0=
00100%\000\000\000\000001"
+/* offset=3D129959 */ "llc_miss_rate\000Default2\000LLC\\-load\\-misses / =
LLC\\-loads\000llc_miss_rate > 0.05\000LLC miss rate\000\000100%\000\000\00=
0\000001"
+/* offset=3D130060 */ "l1i_miss_rate\000Default3\000L1\\-icache\\-load\\-m=
isses / L1\\-icache\\-loads\000l1i_miss_rate > 0.05\000L1I miss rate\000\00=
0100%\000\000\000\000001"
+/* offset=3D130175 */ "dtlb_miss_rate\000Default3\000dTLB\\-load\\-misses =
/ dTLB\\-loads\000dtlb_miss_rate > 0.05\000dTLB miss rate\000\000100%\000\0=
00\000\000001"
+/* offset=3D130281 */ "itlb_miss_rate\000Default3\000iTLB\\-load\\-misses =
/ iTLB\\-loads\000itlb_miss_rate > 0.05\000iTLB miss rate\000\000100%\000\0=
00\000\000001"
+/* offset=3D130387 */ "l1_prefetch_miss_rate\000Default4\000L1\\-dcache\\-=
prefetch\\-misses / L1\\-dcache\\-prefetches\000l1_prefetch_miss_rate > 0.0=
5\000L1 prefetch miss rate\000\000100%\000\000\000\000001"
+/* offset=3D130535 */ "CPI\000\0001 / IPC\000\000\000\000\000\000\000\0000=
00"
+/* offset=3D130558 */ "IPC\000group1\000inst_retired.any / cpu_clk_unhalte=
d.thread\000\000\000\000\000\000\000\000000"
+/* offset=3D130622 */ "Frontend_Bound_SMT\000\000idq_uops_not_delivered.co=
re / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_a=
ctive / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\000000"
+/* offset=3D130789 */ "dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_=
retired.any\000\000\000\000\000\000\000\000000"
+/* offset=3D130854 */ "icache_miss_cycles\000\000l1i\\-loads\\-misses / in=
st_retired.any\000\000\000\000\000\000\000\000000"
+/* offset=3D130922 */ "cache_miss_cycles\000group1\000dcache_miss_cpi + ic=
ache_miss_cycles\000\000\000\000\000\000\000\000000"
+/* offset=3D130994 */ "DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_h=
it + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\000000"
+/* offset=3D131089 */ "DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_d=
ata_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_=
miss\000\000\000\000\000\000\000\000000"
+/* offset=3D131224 */ "DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2=
_All_Miss\000\000\000\000\000\000\000\000000"
+/* offset=3D131289 */ "DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, D=
Cache_L2_All)\000\000\000\000\000\000\000\000000"
+/* offset=3D131358 */ "DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss,=
 DCache_L2_All)\000\000\000\000\000\000\000\000000"
+/* offset=3D131429 */ "M1\000\000ipc + M2\000\000\000\000\000\000\000\0000=
00"
+/* offset=3D131452 */ "M2\000\000ipc + M1\000\000\000\000\000\000\000\0000=
00"
+/* offset=3D131475 */ "M3\000\0001 / M3\000\000\000\000\000\000\000\000000=
"
+/* offset=3D131496 */ "L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9=
 / duration_time\000\000\000\000\000\000\000\000000"
 ;
=20
 static const struct compact_pmu_event pmu_events__common_default_core[] =
=3D {
@@ -2587,6 +2589,7 @@ static const struct compact_pmu_event pmu_events__com=
mon_software[] =3D {
 { 123599 }, /* task-clock\000software\000Per-task high-resolution timer ba=
sed event\000config=3D1\000\00000\000\000\000\000\000 */
 };
 static const struct compact_pmu_event pmu_events__common_tool[] =3D {
+{ 126189 }, /* core_wide\000tool\0001 if not SMT, if SMT are events being =
gathered on all SMT threads 1 otherwise 0\000config=3D0xd\000\00000\000\000=
\000\000\000 */
 { 125056 }, /* duration_time\000tool\000Wall clock interval time in nanose=
conds\000config=3D1\000\00000\000\000\000\000\000 */
 { 125270 }, /* has_pmem\000tool\0001 if persistent memory installed otherw=
ise 0\000config=3D4\000\00000\000\000\000\000\000 */
 { 125346 }, /* num_cores\000tool\000Number of cores. A core consists of 1 =
or more thread, with each thread being associated with a logical Linux CPU\=
000config=3D5\000\00000\000\000\000\000\000 */
@@ -2598,6 +2601,7 @@ static const struct compact_pmu_event pmu_events__com=
mon_tool[] =3D {
 { 125983 }, /* smt_on\000tool\0001 if simultaneous multithreading (aka hyp=
erthreading) is enable otherwise 0\000config=3D0xb\000\00000\000\000\000\00=
0\000 */
 { 125202 }, /* system_time\000tool\000System/kernel time in nanoseconds\00=
0config=3D3\000\00000\000\000\000\000\000 */
 { 126090 }, /* system_tsc_freq\000tool\000The amount a Time Stamp Counter =
(TSC) increases per second\000config=3D0xc\000\00000\000\000\000\000\000 */
+{ 126303 }, /* target_cpu\000tool\0001 if CPUs being analyzed, 0 if thread=
s/processes\000config=3D0xe\000\00000\000\000\000\000\000 */
 { 125132 }, /* user_time\000tool\000User (non-kernel) time in nanoseconds\=
000config=3D2\000\00000\000\000\000\000\000 */
=20
 };
@@ -2621,23 +2625,23 @@ static const struct pmu_table_entry pmu_events__com=
mon[] =3D {
 };
=20
 static const struct compact_pmu_event pmu_metrics__common_default_core[] =
=3D {
-{ 127742 }, /* CPUs_utilized\000Default\000(software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@) / (duration_time * 1e9)\000\000Average CPU utilization\000\0001CPU=
s\000\000\000\000011 */
-{ 129059 }, /* backend_cycles_idle\000Default\000stalled\\-cycles\\-backen=
d / cpu\\-cycles\000backend_cycles_idle > 0.2\000Backend stalls per cycle\0=
00\000\000\000\000\000001 */
-{ 129361 }, /* branch_frequency\000Default\000branches / (software@cpu\\-c=
lock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,na=
me\\=3Dtask\\-clock@)\000\000Branches per CPU second\000\0001000K/sec\000\0=
00\000\000011 */
-{ 129541 }, /* branch_miss_rate\000Default\000branch\\-misses / branches\0=
00branch_miss_rate > 0.05\000Branch miss rate\000\000100%\000\000\000\00000=
1 */
-{ 127928 }, /* cs_per_second\000Default\000software@context\\-switches\\,n=
ame\\=3Dcontext\\-switches@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-=
clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\=
000\000Context switches per CPU second\000\0001cs/sec\000\000\000\000011 */
-{ 129185 }, /* cycles_frequency\000Default\000cpu\\-cycles / (software@cpu=
\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\=
\,name\\=3Dtask\\-clock@)\000\000Cycles per CPU second\000\0001GHz\000\000\=
000\000011 */
-{ 129977 }, /* dtlb_miss_rate\000Default3\000dTLB\\-load\\-misses / dTLB\\=
-loads\000dtlb_miss_rate > 0.05\000dTLB miss rate\000\000100%\000\000\000\0=
00001 */
-{ 128929 }, /* frontend_cycles_idle\000Default\000stalled\\-cycles\\-front=
end / cpu\\-cycles\000frontend_cycles_idle > 0.1\000Frontend stalls per cyc=
le\000\000\000\000\000\000001 */
-{ 128652 }, /* insn_per_cycle\000Default\000instructions / cpu\\-cycles\00=
0insn_per_cycle < 1\000Instructions Per Cycle\000\0001instructions\000\000\=
000\000001 */
-{ 130083 }, /* itlb_miss_rate\000Default3\000iTLB\\-load\\-misses / iTLB\\=
-loads\000itlb_miss_rate > 0.05\000iTLB miss rate\000\000100%\000\000\000\0=
00001 */
-{ 130189 }, /* l1_prefetch_miss_rate\000Default4\000L1\\-dcache\\-prefetch=
\\-misses / L1\\-dcache\\-prefetches\000l1_prefetch_miss_rate > 0.05\000L1 =
prefetch miss rate\000\000100%\000\000\000\000001 */
-{ 129645 }, /* l1d_miss_rate\000Default2\000L1\\-dcache\\-load\\-misses / =
L1\\-dcache\\-loads\000l1d_miss_rate > 0.05\000L1D  miss rate\000\000100%\0=
00\000\000\000001 */
-{ 129862 }, /* l1i_miss_rate\000Default3\000L1\\-icache\\-load\\-misses / =
L1\\-icache\\-loads\000l1i_miss_rate > 0.05\000L1I miss rate\000\000100%\00=
0\000\000\000001 */
-{ 129761 }, /* llc_miss_rate\000Default2\000LLC\\-load\\-misses / LLC\\-lo=
ads\000llc_miss_rate > 0.05\000LLC miss rate\000\000100%\000\000\000\000001=
 */
-{ 128161 }, /* migrations_per_second\000Default\000software@cpu\\-migratio=
ns\\,name\\=3Dcpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcp=
u\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-cloc=
k@)\000\000Process migrations to a new CPU per CPU second\000\0001migration=
s/sec\000\000\000\000011 */
-{ 128421 }, /* page_faults_per_second\000Default\000software@page\\-faults=
\\,name\\=3Dpage\\-faults@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-c=
lock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\0=
00\000Page faults per CPU second\000\0001faults/sec\000\000\000\000011 */
-{ 128765 }, /* stalled_cycles_per_instruction\000Default\000max(stalled\\-=
cycles\\-frontend, stalled\\-cycles\\-backend) / instructions\000\000Max fr=
ont or backend stalls per instruction\000\000\000\000\000\000001 */
+{ 127940 }, /* CPUs_utilized\000Default\000(software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@) / (duration_time * 1e9)\000\000Average CPU utilization\000\0001CPU=
s\000\000\000\000011 */
+{ 129257 }, /* backend_cycles_idle\000Default\000stalled\\-cycles\\-backen=
d / cpu\\-cycles\000backend_cycles_idle > 0.2\000Backend stalls per cycle\0=
00\000\000\000\000\000001 */
+{ 129559 }, /* branch_frequency\000Default\000branches / (software@cpu\\-c=
lock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,na=
me\\=3Dtask\\-clock@)\000\000Branches per CPU second\000\0001000K/sec\000\0=
00\000\000011 */
+{ 129739 }, /* branch_miss_rate\000Default\000branch\\-misses / branches\0=
00branch_miss_rate > 0.05\000Branch miss rate\000\000100%\000\000\000\00000=
1 */
+{ 128126 }, /* cs_per_second\000Default\000software@context\\-switches\\,n=
ame\\=3Dcontext\\-switches@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-=
clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\=
000\000Context switches per CPU second\000\0001cs/sec\000\000\000\000011 */
+{ 129383 }, /* cycles_frequency\000Default\000cpu\\-cycles / (software@cpu=
\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\=
\,name\\=3Dtask\\-clock@)\000\000Cycles per CPU second\000\0001GHz\000\000\=
000\000011 */
+{ 130175 }, /* dtlb_miss_rate\000Default3\000dTLB\\-load\\-misses / dTLB\\=
-loads\000dtlb_miss_rate > 0.05\000dTLB miss rate\000\000100%\000\000\000\0=
00001 */
+{ 129127 }, /* frontend_cycles_idle\000Default\000stalled\\-cycles\\-front=
end / cpu\\-cycles\000frontend_cycles_idle > 0.1\000Frontend stalls per cyc=
le\000\000\000\000\000\000001 */
+{ 128850 }, /* insn_per_cycle\000Default\000instructions / cpu\\-cycles\00=
0insn_per_cycle < 1\000Instructions Per Cycle\000\0001instructions\000\000\=
000\000001 */
+{ 130281 }, /* itlb_miss_rate\000Default3\000iTLB\\-load\\-misses / iTLB\\=
-loads\000itlb_miss_rate > 0.05\000iTLB miss rate\000\000100%\000\000\000\0=
00001 */
+{ 130387 }, /* l1_prefetch_miss_rate\000Default4\000L1\\-dcache\\-prefetch=
\\-misses / L1\\-dcache\\-prefetches\000l1_prefetch_miss_rate > 0.05\000L1 =
prefetch miss rate\000\000100%\000\000\000\000001 */
+{ 129843 }, /* l1d_miss_rate\000Default2\000L1\\-dcache\\-load\\-misses / =
L1\\-dcache\\-loads\000l1d_miss_rate > 0.05\000L1D  miss rate\000\000100%\0=
00\000\000\000001 */
+{ 130060 }, /* l1i_miss_rate\000Default3\000L1\\-icache\\-load\\-misses / =
L1\\-icache\\-loads\000l1i_miss_rate > 0.05\000L1I miss rate\000\000100%\00=
0\000\000\000001 */
+{ 129959 }, /* llc_miss_rate\000Default2\000LLC\\-load\\-misses / LLC\\-lo=
ads\000llc_miss_rate > 0.05\000LLC miss rate\000\000100%\000\000\000\000001=
 */
+{ 128359 }, /* migrations_per_second\000Default\000software@cpu\\-migratio=
ns\\,name\\=3Dcpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcp=
u\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-cloc=
k@)\000\000Process migrations to a new CPU per CPU second\000\0001migration=
s/sec\000\000\000\000011 */
+{ 128619 }, /* page_faults_per_second\000Default\000software@page\\-faults=
\\,name\\=3Dpage\\-faults@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-c=
lock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\0=
00\000Page faults per CPU second\000\0001faults/sec\000\000\000\000011 */
+{ 128963 }, /* stalled_cycles_per_instruction\000Default\000max(stalled\\-=
cycles\\-frontend, stalled\\-cycles\\-backend) / instructions\000\000Max fr=
ont or backend stalls per instruction\000\000\000\000\000\000001 */
=20
 };
=20
@@ -2650,29 +2654,29 @@ static const struct pmu_table_entry pmu_metrics__co=
mmon[] =3D {
 };
=20
 static const struct compact_pmu_event pmu_events__test_soc_cpu_default_cor=
e[] =3D {
-{ 126189 }, /* bp_l1_btb_correct\000branch\000L1 BTB Correction\000event=
=3D0x8a\000\00000\000\000\000\000\000 */
-{ 126251 }, /* bp_l2_btb_correct\000branch\000L2 BTB Correction\000event=
=3D0x8b\000\00000\000\000\000\000\000 */
-{ 126513 }, /* dispatch_blocked.any\000other\000Memory cluster signals to =
block micro-op dispatch for any reason\000event=3D9,period=3D200000,umask=
=3D0x20\000\00000\000\000\000\000\000 */
-{ 126646 }, /* eist_trans\000other\000Number of Enhanced Intel SpeedStep(R=
) Technology (EIST) transitions\000event=3D0x3a,period=3D200000\000\00000\0=
00\000\000\000\000 */
-{ 126313 }, /* l3_cache_rd\000cache\000L3 cache access, read\000event=3D0x=
40\000\00000\000\000\000\000Attributable Level 3 cache access, read\000 */
-{ 126411 }, /* segment_reg_loads.any\000other\000Number of segment registe=
r loads\000event=3D6,period=3D200000,umask=3D0x80\000\00000\000\000\000\000=
\000 */
+{ 126387 }, /* bp_l1_btb_correct\000branch\000L1 BTB Correction\000event=
=3D0x8a\000\00000\000\000\000\000\000 */
+{ 126449 }, /* bp_l2_btb_correct\000branch\000L2 BTB Correction\000event=
=3D0x8b\000\00000\000\000\000\000\000 */
+{ 126711 }, /* dispatch_blocked.any\000other\000Memory cluster signals to =
block micro-op dispatch for any reason\000event=3D9,period=3D200000,umask=
=3D0x20\000\00000\000\000\000\000\000 */
+{ 126844 }, /* eist_trans\000other\000Number of Enhanced Intel SpeedStep(R=
) Technology (EIST) transitions\000event=3D0x3a,period=3D200000\000\00000\0=
00\000\000\000\000 */
+{ 126511 }, /* l3_cache_rd\000cache\000L3 cache access, read\000event=3D0x=
40\000\00000\000\000\000\000Attributable Level 3 cache access, read\000 */
+{ 126609 }, /* segment_reg_loads.any\000other\000Number of segment registe=
r loads\000event=3D6,period=3D200000,umask=3D0x80\000\00000\000\000\000\000=
\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_hisi_sccl_d=
drc[] =3D {
-{ 126779 }, /* uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write commands=
\000event=3D2\000\00000\000\000\000\000\000 */
+{ 126977 }, /* uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write commands=
\000event=3D2\000\00000\000\000\000\000\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_hisi_sccl_l=
3c[] =3D {
-{ 127141 }, /* uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total read hits\0=
00event=3D7\000\00000\000\000\000\000\000 */
+{ 127339 }, /* uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total read hits\0=
00event=3D7\000\00000\000\000\000\000\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_cbox=
[] =3D {
-{ 127015 }, /* event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=3D0xe0\00=
0\00000\000\000\000\000\000 */
-{ 127069 }, /* event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=3D0xc=
0\000\00000\000\000\000\000\000 */
-{ 126861 }, /* unc_cbo_xsnp_response.miss_eviction\000uncore\000A cross-co=
re snoop resulted from L3 Eviction which misses in some processor core\000e=
vent=3D0x22,umask=3D0x81\000\00000\000\000\000\000\000 */
+{ 127213 }, /* event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=3D0xe0\00=
0\00000\000\000\000\000\000 */
+{ 127267 }, /* event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=3D0xc=
0\000\00000\000\000\000\000\000 */
+{ 127059 }, /* unc_cbo_xsnp_response.miss_eviction\000uncore\000A cross-co=
re snoop resulted from L3 Eviction which misses in some processor core\000e=
vent=3D0x22,umask=3D0x81\000\00000\000\000\000\000\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_imc[=
] =3D {
-{ 127324 }, /* uncore_imc.cache_hits\000uncore\000Total cache hits\000even=
t=3D0x34\000\00000\000\000\000\000\000 */
+{ 127522 }, /* uncore_imc.cache_hits\000uncore\000Total cache hits\000even=
t=3D0x34\000\00000\000\000\000\000\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_imc_=
free_running[] =3D {
-{ 127233 }, /* uncore_imc_free_running.cache_miss\000uncore\000Total cache=
 misses\000event=3D0x12\000\00000\000\000\000\000\000 */
+{ 127431 }, /* uncore_imc_free_running.cache_miss\000uncore\000Total cache=
 misses\000event=3D0x12\000\00000\000\000\000\000\000 */
=20
 };
=20
@@ -2685,46 +2689,46 @@ static const struct pmu_table_entry pmu_events__tes=
t_soc_cpu[] =3D {
 {
      .entries =3D pmu_events__test_soc_cpu_hisi_sccl_ddrc,
      .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_hisi_sccl_ddrc),
-     .pmu_name =3D { 126764 /* hisi_sccl,ddrc\000 */ },
+     .pmu_name =3D { 126962 /* hisi_sccl,ddrc\000 */ },
 },
 {
      .entries =3D pmu_events__test_soc_cpu_hisi_sccl_l3c,
      .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_hisi_sccl_l3c),
-     .pmu_name =3D { 127127 /* hisi_sccl,l3c\000 */ },
+     .pmu_name =3D { 127325 /* hisi_sccl,l3c\000 */ },
 },
 {
      .entries =3D pmu_events__test_soc_cpu_uncore_cbox,
      .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_cbox),
-     .pmu_name =3D { 126849 /* uncore_cbox\000 */ },
+     .pmu_name =3D { 127047 /* uncore_cbox\000 */ },
 },
 {
      .entries =3D pmu_events__test_soc_cpu_uncore_imc,
      .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_imc),
-     .pmu_name =3D { 127313 /* uncore_imc\000 */ },
+     .pmu_name =3D { 127511 /* uncore_imc\000 */ },
 },
 {
      .entries =3D pmu_events__test_soc_cpu_uncore_imc_free_running,
      .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_imc_free_=
running),
-     .pmu_name =3D { 127209 /* uncore_imc_free_running\000 */ },
+     .pmu_name =3D { 127407 /* uncore_imc_free_running\000 */ },
 },
 };
=20
 static const struct compact_pmu_event pmu_metrics__test_soc_cpu_default_co=
re[] =3D {
-{ 130337 }, /* CPI\000\0001 / IPC\000\000\000\000\000\000\000\000000 */
-{ 131026 }, /* DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Mis=
s\000\000\000\000\000\000\000\000000 */
-{ 130796 }, /* DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_=
rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\000000 */
-{ 130891 }, /* DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd -=
 l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\000=
\000\000\000\000\000\000\000000 */
-{ 131091 }, /* DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2=
_All)\000\000\000\000\000\000\000\000000 */
-{ 131160 }, /* DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_=
L2_All)\000\000\000\000\000\000\000\000000 */
-{ 130424 }, /* Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 =
* (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active / =
cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\000000 */
-{ 130360 }, /* IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread=
\000\000\000\000\000\000\000\000000 */
-{ 131298 }, /* L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / durat=
ion_time\000\000\000\000\000\000\000\000000 */
-{ 131231 }, /* M1\000\000ipc + M2\000\000\000\000\000\000\000\000000 */
-{ 131254 }, /* M2\000\000ipc + M1\000\000\000\000\000\000\000\000000 */
-{ 131277 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\000000 */
-{ 130724 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_mis=
s_cycles\000\000\000\000\000\000\000\000000 */
-{ 130591 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.=
any\000\000\000\000\000\000\000\000000 */
-{ 130656 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retir=
ed.any\000\000\000\000\000\000\000\000000 */
+{ 130535 }, /* CPI\000\0001 / IPC\000\000\000\000\000\000\000\000000 */
+{ 131224 }, /* DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Mis=
s\000\000\000\000\000\000\000\000000 */
+{ 130994 }, /* DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_=
rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\000000 */
+{ 131089 }, /* DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd -=
 l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\000=
\000\000\000\000\000\000\000000 */
+{ 131289 }, /* DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2=
_All)\000\000\000\000\000\000\000\000000 */
+{ 131358 }, /* DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_=
L2_All)\000\000\000\000\000\000\000\000000 */
+{ 130622 }, /* Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 =
* (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active / =
cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\000000 */
+{ 130558 }, /* IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread=
\000\000\000\000\000\000\000\000000 */
+{ 131496 }, /* L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / durat=
ion_time\000\000\000\000\000\000\000\000000 */
+{ 131429 }, /* M1\000\000ipc + M2\000\000\000\000\000\000\000\000000 */
+{ 131452 }, /* M2\000\000ipc + M1\000\000\000\000\000\000\000\000000 */
+{ 131475 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\000000 */
+{ 130922 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_mis=
s_cycles\000\000\000\000\000\000\000\000000 */
+{ 130789 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.=
any\000\000\000\000\000\000\000\000000 */
+{ 130854 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retir=
ed.any\000\000\000\000\000\000\000\000000 */
=20
 };
=20
@@ -2737,13 +2741,13 @@ static const struct pmu_table_entry pmu_metrics__te=
st_soc_cpu[] =3D {
 };
=20
 static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sys_=
ccn_pmu[] =3D {
-{ 127503 }, /* sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles event\=
000config=3D0x2c\0000x01\00000\000\000\000\000\000 */
+{ 127701 }, /* sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles event\=
000config=3D0x2c\0000x01\00000\000\000\000\000\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sys_=
cmn_pmu[] =3D {
-{ 127599 }, /* sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total cache =
misses in first lookup result (high priority)\000eventid=3D1,type=3D5\000(4=
34|436|43c|43a).*\00000\000\000\000\000\000 */
+{ 127797 }, /* sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total cache =
misses in first lookup result (high priority)\000eventid=3D1,type=3D5\000(4=
34|436|43c|43a).*\00000\000\000\000\000\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sys_=
ddr_pmu[] =3D {
-{ 127408 }, /* sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycles even=
t\000event=3D0x2b\000v8\00000\000\000\000\000\000 */
+{ 127606 }, /* sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycles even=
t\000event=3D0x2b\000v8\00000\000\000\000\000\000 */
=20
 };
=20
@@ -2751,17 +2755,17 @@ static const struct pmu_table_entry pmu_events__tes=
t_soc_sys[] =3D {
 {
      .entries =3D pmu_events__test_soc_sys_uncore_sys_ccn_pmu,
      .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_ccn_p=
mu),
-     .pmu_name =3D { 127484 /* uncore_sys_ccn_pmu\000 */ },
+     .pmu_name =3D { 127682 /* uncore_sys_ccn_pmu\000 */ },
 },
 {
      .entries =3D pmu_events__test_soc_sys_uncore_sys_cmn_pmu,
      .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_cmn_p=
mu),
-     .pmu_name =3D { 127580 /* uncore_sys_cmn_pmu\000 */ },
+     .pmu_name =3D { 127778 /* uncore_sys_cmn_pmu\000 */ },
 },
 {
      .entries =3D pmu_events__test_soc_sys_uncore_sys_ddr_pmu,
      .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_ddr_p=
mu),
-     .pmu_name =3D { 127389 /* uncore_sys_ddr_pmu\000 */ },
+     .pmu_name =3D { 127587 /* uncore_sys_ddr_pmu\000 */ },
 },
 };
=20
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 4df56f2b283d..465fe2e9bbbe 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -401,17 +401,12 @@ double expr__get_literal(const char *literal, const s=
truct expr_scanner_ctx *ctx
 	if (ev !=3D TOOL_PMU__EVENT_NONE) {
 		u64 count;
=20
-		if (tool_pmu__read_event(ev, /*evsel=3D*/NULL, &count))
+		if (tool_pmu__read_event(ev, /*evsel=3D*/NULL,
+					 ctx->system_wide, ctx->user_requested_cpu_list,
+					 &count))
 			result =3D count;
 		else
 			pr_err("Failure to read '%s'", literal);
-
-	} else if (!strcmp("#core_wide", literal)) {
-		result =3D core_wide(ctx->system_wide, ctx->user_requested_cpu_list)
-			? 1.0 : 0.0;
-	} else if (!strcmp("#target_cpu", literal)) {
-		result =3D (ctx->system_wide || ctx->user_requested_cpu_list)
-			? 1.0 : 0.0;
 	} else {
 		pr_err("Unrecognized literal '%s'", literal);
 	}
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index c1547128c396..b3b482e1808f 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -72,6 +72,8 @@ static int prepare_metric(const struct metric_expr *mexp,
 			case TOOL_PMU__EVENT_SLOTS:
 			case TOOL_PMU__EVENT_SMT_ON:
 			case TOOL_PMU__EVENT_SYSTEM_TSC_FREQ:
+			case TOOL_PMU__EVENT_CORE_WIDE:
+			case TOOL_PMU__EVENT_TARGET_CPU:
 			default:
 				pr_err("Unexpected tool event '%s'", evsel__name(metric_events[i]));
 				abort();
diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
index f075098488ba..a72c665ee644 100644
--- a/tools/perf/util/tool_pmu.c
+++ b/tools/perf/util/tool_pmu.c
@@ -6,6 +6,7 @@
 #include "pmu.h"
 #include "print-events.h"
 #include "smt.h"
+#include "stat.h"
 #include "time-utils.h"
 #include "tool_pmu.h"
 #include "tsc.h"
@@ -30,6 +31,8 @@ static const char *const tool_pmu__event_names[TOOL_PMU__=
EVENT_MAX] =3D {
 	"slots",
 	"smt_on",
 	"system_tsc_freq",
+	"core_wide",
+	"target_cpu",
 };
=20
 bool tool_pmu__skip_event(const char *name __maybe_unused)
@@ -329,7 +332,11 @@ static bool has_pmem(void)
 	return has_pmem;
 }
=20
-bool tool_pmu__read_event(enum tool_pmu_event ev, struct evsel *evsel, u64=
 *result)
+bool tool_pmu__read_event(enum tool_pmu_event ev,
+			  struct evsel *evsel,
+			  bool system_wide,
+			  const char *user_requested_cpu_list,
+			  u64 *result)
 {
 	const struct cpu_topology *topology;
=20
@@ -421,6 +428,14 @@ bool tool_pmu__read_event(enum tool_pmu_event ev, stru=
ct evsel *evsel, u64 *resu
 		*result =3D arch_get_tsc_freq();
 		return true;
=20
+	case TOOL_PMU__EVENT_CORE_WIDE:
+		*result =3D core_wide(system_wide, user_requested_cpu_list) ? 1 : 0;
+		return true;
+
+	case TOOL_PMU__EVENT_TARGET_CPU:
+		*result =3D system_wide || (user_requested_cpu_list !=3D NULL) ? 1 : 0;
+		return true;
+
 	case TOOL_PMU__EVENT_NONE:
 	case TOOL_PMU__EVENT_DURATION_TIME:
 	case TOOL_PMU__EVENT_USER_TIME:
@@ -452,11 +467,16 @@ int evsel__tool_pmu_read(struct evsel *evsel, int cpu=
_map_idx, int thread)
 	case TOOL_PMU__EVENT_SLOTS:
 	case TOOL_PMU__EVENT_SMT_ON:
 	case TOOL_PMU__EVENT_SYSTEM_TSC_FREQ:
+	case TOOL_PMU__EVENT_CORE_WIDE:
+	case TOOL_PMU__EVENT_TARGET_CPU:
 		if (evsel->prev_raw_counts)
 			old_count =3D perf_counts(evsel->prev_raw_counts, cpu_map_idx, thread);
 		val =3D 0;
 		if (cpu_map_idx =3D=3D 0 && thread =3D=3D 0) {
-			if (!tool_pmu__read_event(ev, evsel, &val)) {
+			if (!tool_pmu__read_event(ev, evsel,
+						  stat_config.system_wide,
+						  stat_config.user_requested_cpu_list,
+						  &val)) {
 				count->lost++;
 				val =3D 0;
 			}
diff --git a/tools/perf/util/tool_pmu.h b/tools/perf/util/tool_pmu.h
index d642e7d73910..f1714001bc1d 100644
--- a/tools/perf/util/tool_pmu.h
+++ b/tools/perf/util/tool_pmu.h
@@ -22,6 +22,8 @@ enum tool_pmu_event {
 	TOOL_PMU__EVENT_SLOTS,
 	TOOL_PMU__EVENT_SMT_ON,
 	TOOL_PMU__EVENT_SYSTEM_TSC_FREQ,
+	TOOL_PMU__EVENT_CORE_WIDE,
+	TOOL_PMU__EVENT_TARGET_CPU,
=20
 	TOOL_PMU__EVENT_MAX,
 };
@@ -34,7 +36,12 @@ enum tool_pmu_event tool_pmu__str_to_event(const char *s=
tr);
 bool tool_pmu__skip_event(const char *name);
 int tool_pmu__num_skip_events(void);
=20
-bool tool_pmu__read_event(enum tool_pmu_event ev, struct evsel *evsel, u64=
 *result);
+bool tool_pmu__read_event(enum tool_pmu_event ev,
+			  struct evsel *evsel,
+			  bool system_wide,
+			  const char *user_requested_cpu_list,
+			  u64 *result);
+
=20
 u64 tool_pmu__cpu_slots_per_cycle(void);
=20
--=20
2.51.2.1041.gc1ab5b90ca-goog

