Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8091D2F12B6;
	Thu,  6 Nov 2025 21:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762466033; cv=none; b=AM9262Vq1yT+qGt2nJ8dWyvpMe4+xnE/2QwymQuKF/OUsru0vnvZcEU7jw93usXPi47NTM7jKzH+AGBVhkvsu60KOkkNVUytZc7G0oeffVbK0vfHXEqU3ZzyEGSi/vTuqTYw8DQtFP8DjsmAeAWjY5cxLAkPNT6NfeHetnku0hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762466033; c=relaxed/simple;
	bh=Ol18uW9AZe2sE+MLKcoV2BiTMrhcNlz8xOacYtfw0oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r8MRvuEp9DXX10KAJgKqW6+mO6GsJqpgHW28zYWJ1/Vy7V5eT2u6Lu6ScduLHGsU3dxxdcimWdqEju8SOMJP/7lcFbDpNI/JMtAlzENbMSut3UuXFm6P5CBl3kU9Zf1hWUeBFZdp6ooZwgV0DvtYt1h4dZf1B05ew6+ogA4lutU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdpXfKmJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NdpXfKmJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6C5C116C6;
	Thu,  6 Nov 2025 21:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762466033;
	bh=Ol18uW9AZe2sE+MLKcoV2BiTMrhcNlz8xOacYtfw0oQ=;
	h=From:To:Cc:Subject:Date:From;
	b=NdpXfKmJDBwoANIh9Y8eXHgyQenpAT2B48h3zV7t70cehmdg1wO4guOlTJL3ziNmR
	 OShNaHBnCOuvE4rY3bbNlj4/qq1NldnEHnKXVt6aduyR+6B4eogv5d7DCZKRb64tjs
	 wJXAaE2M65JzbTMjHaJf52sM01HAP3Vq5jDODDhruEXJgNUVhCSfc1VdkgXJmVjz55
	 B7UbyN8BB1ooaptrPI/N+A8rwnonj9x3cbnHgIlestxzGiZQKET46PHDDOZyHH3dcp
	 TqASMVZYnWC9x667S1Meb3EbOBu+dl/B/dYSkb+6zoRLChtwdopf4yWnhoGvd6Smfh
	 Inob4n3FCxm6w==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf stat: Add ScaleUnit to {cpu,task}-clock JSON description
Date: Thu,  6 Nov 2025 13:53:50 -0800
Message-ID: <20251106215350.1833191-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This changes the output of the event like below.  In fact, that's the
output it used to have before the JSON conversion.

Before:
  $ perf stat -e task-clock true

   Performance counter stats for 'true':

             313,848      task-clock                       #    0.290 CPUs utilized

         0.001081223 seconds time elapsed

         0.001122000 seconds user
         0.000000000 seconds sys

After:
  $ perf stat -e task-clock true

   Performance counter stats for 'true':

                0.36 msec task-clock                       #    0.297 CPUs utilized

         0.001225435 seconds time elapsed

         0.001268000 seconds user
         0.000000000 seconds sys

Fixes: 9957d8c801fe0cb90 ("perf jevents: Add common software event json")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 .../arch/common/common/software.json          |   6 +-
 tools/perf/pmu-events/empty-pmu-events.c      | 312 +++++++++---------
 2 files changed, 160 insertions(+), 158 deletions(-)

diff --git a/tools/perf/pmu-events/arch/common/common/software.json b/tools/perf/pmu-events/arch/common/common/software.json
index f2551f1107fd712c..e6819ae219bb581e 100644
--- a/tools/perf/pmu-events/arch/common/common/software.json
+++ b/tools/perf/pmu-events/arch/common/common/software.json
@@ -3,13 +3,15 @@
     "Unit": "software",
     "EventName": "cpu-clock",
     "BriefDescription": "Per-CPU high-resolution timer based event",
-    "ConfigCode": "0"
+    "ConfigCode": "0",
+    "ScaleUnit": "1e-6msec"
   },
   {
     "Unit": "software",
     "EventName": "task-clock",
     "BriefDescription": "Per-task high-resolution timer based event",
-    "ConfigCode": "1"
+    "ConfigCode": "1",
+    "ScaleUnit": "1e-6msec"
   },
   {
     "Unit": "software",
diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index 83a01ecc625e9a59..d78c1857ac4bb816 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -1251,84 +1251,84 @@ static const char *const big_c_string =
 /* offset=123247 */ "idle-cycles-backend\000legacy hardware\000Stalled cycles during retirement [This event is an alias of stalled-cycles-backend]\000legacy-hardware-config=8\000\00000\000\000\000\000\000"
 /* offset=123400 */ "ref-cycles\000legacy hardware\000Total cycles; not affected by CPU frequency scaling\000legacy-hardware-config=9\000\00000\000\000\000\000\000"
 /* offset=123512 */ "software\000"
-/* offset=123521 */ "cpu-clock\000software\000Per-CPU high-resolution timer based event\000config=0\000\00000\000\000\000\000\000"
-/* offset=123599 */ "task-clock\000software\000Per-task high-resolution timer based event\000config=1\000\00000\000\000\000\000\000"
-/* offset=123679 */ "faults\000software\000Number of page faults [This event is an alias of page-faults]\000config=2\000\00000\000\000\000\000\000"
-/* offset=123774 */ "page-faults\000software\000Number of page faults [This event is an alias of faults]\000config=2\000\00000\000\000\000\000\000"
-/* offset=123869 */ "context-switches\000software\000Number of context switches [This event is an alias of cs]\000config=3\000\00000\000\000\000\000\000"
-/* offset=123970 */ "cs\000software\000Number of context switches [This event is an alias of context-switches]\000config=3\000\00000\000\000\000\000\000"
-/* offset=124071 */ "cpu-migrations\000software\000Number of times a process has migrated to a new CPU [This event is an alias of migrations]\000config=4\000\00000\000\000\000\000\000"
-/* offset=124203 */ "migrations\000software\000Number of times a process has migrated to a new CPU [This event is an alias of cpu-migrations]\000config=4\000\00000\000\000\000\000\000"
-/* offset=124335 */ "minor-faults\000software\000Number of minor page faults. Minor faults don't require I/O to handle\000config=5\000\00000\000\000\000\000\000"
-/* offset=124444 */ "major-faults\000software\000Number of major page faults. Major faults require I/O to handle\000config=6\000\00000\000\000\000\000\000"
-/* offset=124547 */ "alignment-faults\000software\000Number of kernel handled memory alignment faults\000config=7\000\00000\000\000\000\000\000"
-/* offset=124639 */ "emulation-faults\000software\000Number of kernel handled unimplemented instruction faults handled through emulation\000config=8\000\00000\000\000\000\000\000"
-/* offset=124766 */ "dummy\000software\000A placeholder event that doesn't count anything\000config=9\000\00000\000\000\000\000\000"
-/* offset=124846 */ "bpf-output\000software\000An event used by BPF programs to write to the perf ring buffer\000config=0xa\000\00000\000\000\000\000\000"
-/* offset=124948 */ "cgroup-switches\000software\000Number of context switches to a task in a different cgroup\000config=0xb\000\00000\000\000\000\000\000"
-/* offset=125051 */ "tool\000"
-/* offset=125056 */ "duration_time\000tool\000Wall clock interval time in nanoseconds\000config=1\000\00000\000\000\000\000\000"
-/* offset=125132 */ "user_time\000tool\000User (non-kernel) time in nanoseconds\000config=2\000\00000\000\000\000\000\000"
-/* offset=125202 */ "system_time\000tool\000System/kernel time in nanoseconds\000config=3\000\00000\000\000\000\000\000"
-/* offset=125270 */ "has_pmem\000tool\0001 if persistent memory installed otherwise 0\000config=4\000\00000\000\000\000\000\000"
-/* offset=125346 */ "num_cores\000tool\000Number of cores. A core consists of 1 or more thread, with each thread being associated with a logical Linux CPU\000config=5\000\00000\000\000\000\000\000"
-/* offset=125491 */ "num_cpus\000tool\000Number of logical Linux CPUs. There may be multiple such CPUs on a core\000config=6\000\00000\000\000\000\000\000"
-/* offset=125594 */ "num_cpus_online\000tool\000Number of online logical Linux CPUs. There may be multiple such CPUs on a core\000config=7\000\00000\000\000\000\000\000"
-/* offset=125711 */ "num_dies\000tool\000Number of dies. Each die has 1 or more cores\000config=8\000\00000\000\000\000\000\000"
-/* offset=125787 */ "num_packages\000tool\000Number of packages. Each package has 1 or more die\000config=9\000\00000\000\000\000\000\000"
-/* offset=125873 */ "slots\000tool\000Number of functional units that in parallel can execute parts of an instruction\000config=0xa\000\00000\000\000\000\000\000"
-/* offset=125983 */ "smt_on\000tool\0001 if simultaneous multithreading (aka hyperthreading) is enable otherwise 0\000config=0xb\000\00000\000\000\000\000\000"
-/* offset=126090 */ "system_tsc_freq\000tool\000The amount a Time Stamp Counter (TSC) increases per second\000config=0xc\000\00000\000\000\000\000\000"
-/* offset=126189 */ "bp_l1_btb_correct\000branch\000L1 BTB Correction\000event=0x8a\000\00000\000\000\000\000\000"
-/* offset=126251 */ "bp_l2_btb_correct\000branch\000L2 BTB Correction\000event=0x8b\000\00000\000\000\000\000\000"
-/* offset=126313 */ "l3_cache_rd\000cache\000L3 cache access, read\000event=0x40\000\00000\000\000\000\000Attributable Level 3 cache access, read\000"
-/* offset=126411 */ "segment_reg_loads.any\000other\000Number of segment register loads\000event=6,period=200000,umask=0x80\000\00000\000\000\000\000\000"
-/* offset=126513 */ "dispatch_blocked.any\000other\000Memory cluster signals to block micro-op dispatch for any reason\000event=9,period=200000,umask=0x20\000\00000\000\000\000\000\000"
-/* offset=126646 */ "eist_trans\000other\000Number of Enhanced Intel SpeedStep(R) Technology (EIST) transitions\000event=0x3a,period=200000\000\00000\000\000\000\000\000"
-/* offset=126764 */ "hisi_sccl,ddrc\000"
-/* offset=126779 */ "uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write commands\000event=2\000\00000\000\000\000\000\000"
-/* offset=126849 */ "uncore_cbox\000"
-/* offset=126861 */ "unc_cbo_xsnp_response.miss_eviction\000uncore\000A cross-core snoop resulted from L3 Eviction which misses in some processor core\000event=0x22,umask=0x81\000\00000\000\000\000\000\000"
-/* offset=127015 */ "event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=0xe0\000\00000\000\000\000\000\000"
-/* offset=127069 */ "event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=0xc0\000\00000\000\000\000\000\000"
-/* offset=127127 */ "hisi_sccl,l3c\000"
-/* offset=127141 */ "uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total read hits\000event=7\000\00000\000\000\000\000\000"
-/* offset=127209 */ "uncore_imc_free_running\000"
-/* offset=127233 */ "uncore_imc_free_running.cache_miss\000uncore\000Total cache misses\000event=0x12\000\00000\000\000\000\000\000"
-/* offset=127313 */ "uncore_imc\000"
-/* offset=127324 */ "uncore_imc.cache_hits\000uncore\000Total cache hits\000event=0x34\000\00000\000\000\000\000\000"
-/* offset=127389 */ "uncore_sys_ddr_pmu\000"
-/* offset=127408 */ "sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycles event\000event=0x2b\000v8\00000\000\000\000\000\000"
-/* offset=127484 */ "uncore_sys_ccn_pmu\000"
-/* offset=127503 */ "sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles event\000config=0x2c\0000x01\00000\000\000\000\000\000"
-/* offset=127580 */ "uncore_sys_cmn_pmu\000"
-/* offset=127599 */ "sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total cache misses in first lookup result (high priority)\000eventid=1,type=5\000(434|436|43c|43a).*\00000\000\000\000\000\000"
-/* offset=127742 */ "CPUs_utilized\000Default\000(software@cpu\\-clock\\,name\\=cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=task\\-clock@) / (duration_time * 1e9)\000\000Average CPU utilization\000\0001CPUs\000\000\000\00001"
-/* offset=127927 */ "cs_per_second\000Default\000software@context\\-switches\\,name\\=context\\-switches@ * 1e9 / (software@cpu\\-clock\\,name\\=cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=task\\-clock@)\000\000Context switches per CPU second\000\0001cs/sec\000\000\000\00001"
-/* offset=128159 */ "migrations_per_second\000Default\000software@cpu\\-migrations\\,name\\=cpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\,name\\=cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=task\\-clock@)\000\000Process migrations to a new CPU per CPU second\000\0001migrations/sec\000\000\000\00001"
-/* offset=128418 */ "page_faults_per_second\000Default\000software@page\\-faults\\,name\\=page\\-faults@ * 1e9 / (software@cpu\\-clock\\,name\\=cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=task\\-clock@)\000\000Page faults per CPU second\000\0001faults/sec\000\000\000\00001"
-/* offset=128648 */ "insn_per_cycle\000Default\000instructions / cpu\\-cycles\000insn_per_cycle < 1\000Instructions Per Cycle\000\0001instructions\000\000\000\00000"
-/* offset=128760 */ "stalled_cycles_per_instruction\000Default\000max(stalled\\-cycles\\-frontend, stalled\\-cycles\\-backend) / instructions\000\000Max front or backend stalls per instruction\000\000\000\000\000\00000"
-/* offset=128923 */ "frontend_cycles_idle\000Default\000stalled\\-cycles\\-frontend / cpu\\-cycles\000frontend_cycles_idle > 0.1\000Frontend stalls per cycle\000\000\000\000\000\00000"
-/* offset=129052 */ "backend_cycles_idle\000Default\000stalled\\-cycles\\-backend / cpu\\-cycles\000backend_cycles_idle > 0.2\000Backend stalls per cycle\000\000\000\000\000\00000"
-/* offset=129177 */ "cycles_frequency\000Default\000cpu\\-cycles / (software@cpu\\-clock\\,name\\=cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=task\\-clock@)\000\000Cycles per CPU second\000\0001GHz\000\000\000\00001"
-/* offset=129352 */ "branch_frequency\000Default\000branches / (software@cpu\\-clock\\,name\\=cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=task\\-clock@)\000\000Branches per CPU second\000\0001000K/sec\000\000\000\00001"
-/* offset=129531 */ "branch_miss_rate\000Default\000branch\\-misses / branches\000branch_miss_rate > 0.05\000Branch miss rate\000\000100%\000\000\000\00000"
-/* offset=129634 */ "CPI\000\0001 / IPC\000\000\000\000\000\000\000\00000"
-/* offset=129656 */ "IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread\000\000\000\000\000\000\000\00000"
-/* offset=129719 */ "Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\00000"
-/* offset=129885 */ "dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.any\000\000\000\000\000\000\000\00000"
-/* offset=129949 */ "icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retired.any\000\000\000\000\000\000\000\00000"
-/* offset=130016 */ "cache_miss_cycles\000group1\000dcache_miss_cpi + icache_miss_cycles\000\000\000\000\000\000\000\00000"
-/* offset=130087 */ "DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\00000"
-/* offset=130181 */ "DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\000\000\000\000\000\000\000\00000"
-/* offset=130315 */ "DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Miss\000\000\000\000\000\000\000\00000"
-/* offset=130379 */ "DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2_All)\000\000\000\000\000\000\000\00000"
-/* offset=130447 */ "DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_L2_All)\000\000\000\000\000\000\000\00000"
-/* offset=130517 */ "M1\000\000ipc + M2\000\000\000\000\000\000\000\00000"
-/* offset=130539 */ "M2\000\000ipc + M1\000\000\000\000\000\000\000\00000"
-/* offset=130561 */ "M3\000\0001 / M3\000\000\000\000\000\000\000\00000"
-/* offset=130581 */ "L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / duration_time\000\000\000\000\000\000\000\00000"
+/* offset=123521 */ "cpu-clock\000software\000Per-CPU high-resolution timer based event\000config=0\000\000001e-6msec\000\000\000\000\000"
+/* offset=123607 */ "task-clock\000software\000Per-task high-resolution timer based event\000config=1\000\000001e-6msec\000\000\000\000\000"
+/* offset=123695 */ "faults\000software\000Number of page faults [This event is an alias of page-faults]\000config=2\000\00000\000\000\000\000\000"
+/* offset=123790 */ "page-faults\000software\000Number of page faults [This event is an alias of faults]\000config=2\000\00000\000\000\000\000\000"
+/* offset=123885 */ "context-switches\000software\000Number of context switches [This event is an alias of cs]\000config=3\000\00000\000\000\000\000\000"
+/* offset=123986 */ "cs\000software\000Number of context switches [This event is an alias of context-switches]\000config=3\000\00000\000\000\000\000\000"
+/* offset=124087 */ "cpu-migrations\000software\000Number of times a process has migrated to a new CPU [This event is an alias of migrations]\000config=4\000\00000\000\000\000\000\000"
+/* offset=124219 */ "migrations\000software\000Number of times a process has migrated to a new CPU [This event is an alias of cpu-migrations]\000config=4\000\00000\000\000\000\000\000"
+/* offset=124351 */ "minor-faults\000software\000Number of minor page faults. Minor faults don't require I/O to handle\000config=5\000\00000\000\000\000\000\000"
+/* offset=124460 */ "major-faults\000software\000Number of major page faults. Major faults require I/O to handle\000config=6\000\00000\000\000\000\000\000"
+/* offset=124563 */ "alignment-faults\000software\000Number of kernel handled memory alignment faults\000config=7\000\00000\000\000\000\000\000"
+/* offset=124655 */ "emulation-faults\000software\000Number of kernel handled unimplemented instruction faults handled through emulation\000config=8\000\00000\000\000\000\000\000"
+/* offset=124782 */ "dummy\000software\000A placeholder event that doesn't count anything\000config=9\000\00000\000\000\000\000\000"
+/* offset=124862 */ "bpf-output\000software\000An event used by BPF programs to write to the perf ring buffer\000config=0xa\000\00000\000\000\000\000\000"
+/* offset=124964 */ "cgroup-switches\000software\000Number of context switches to a task in a different cgroup\000config=0xb\000\00000\000\000\000\000\000"
+/* offset=125067 */ "tool\000"
+/* offset=125072 */ "duration_time\000tool\000Wall clock interval time in nanoseconds\000config=1\000\00000\000\000\000\000\000"
+/* offset=125148 */ "user_time\000tool\000User (non-kernel) time in nanoseconds\000config=2\000\00000\000\000\000\000\000"
+/* offset=125218 */ "system_time\000tool\000System/kernel time in nanoseconds\000config=3\000\00000\000\000\000\000\000"
+/* offset=125286 */ "has_pmem\000tool\0001 if persistent memory installed otherwise 0\000config=4\000\00000\000\000\000\000\000"
+/* offset=125362 */ "num_cores\000tool\000Number of cores. A core consists of 1 or more thread, with each thread being associated with a logical Linux CPU\000config=5\000\00000\000\000\000\000\000"
+/* offset=125507 */ "num_cpus\000tool\000Number of logical Linux CPUs. There may be multiple such CPUs on a core\000config=6\000\00000\000\000\000\000\000"
+/* offset=125610 */ "num_cpus_online\000tool\000Number of online logical Linux CPUs. There may be multiple such CPUs on a core\000config=7\000\00000\000\000\000\000\000"
+/* offset=125727 */ "num_dies\000tool\000Number of dies. Each die has 1 or more cores\000config=8\000\00000\000\000\000\000\000"
+/* offset=125803 */ "num_packages\000tool\000Number of packages. Each package has 1 or more die\000config=9\000\00000\000\000\000\000\000"
+/* offset=125889 */ "slots\000tool\000Number of functional units that in parallel can execute parts of an instruction\000config=0xa\000\00000\000\000\000\000\000"
+/* offset=125999 */ "smt_on\000tool\0001 if simultaneous multithreading (aka hyperthreading) is enable otherwise 0\000config=0xb\000\00000\000\000\000\000\000"
+/* offset=126106 */ "system_tsc_freq\000tool\000The amount a Time Stamp Counter (TSC) increases per second\000config=0xc\000\00000\000\000\000\000\000"
+/* offset=126205 */ "bp_l1_btb_correct\000branch\000L1 BTB Correction\000event=0x8a\000\00000\000\000\000\000\000"
+/* offset=126267 */ "bp_l2_btb_correct\000branch\000L2 BTB Correction\000event=0x8b\000\00000\000\000\000\000\000"
+/* offset=126329 */ "l3_cache_rd\000cache\000L3 cache access, read\000event=0x40\000\00000\000\000\000\000Attributable Level 3 cache access, read\000"
+/* offset=126427 */ "segment_reg_loads.any\000other\000Number of segment register loads\000event=6,period=200000,umask=0x80\000\00000\000\000\000\000\000"
+/* offset=126529 */ "dispatch_blocked.any\000other\000Memory cluster signals to block micro-op dispatch for any reason\000event=9,period=200000,umask=0x20\000\00000\000\000\000\000\000"
+/* offset=126662 */ "eist_trans\000other\000Number of Enhanced Intel SpeedStep(R) Technology (EIST) transitions\000event=0x3a,period=200000\000\00000\000\000\000\000\000"
+/* offset=126780 */ "hisi_sccl,ddrc\000"
+/* offset=126795 */ "uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write commands\000event=2\000\00000\000\000\000\000\000"
+/* offset=126865 */ "uncore_cbox\000"
+/* offset=126877 */ "unc_cbo_xsnp_response.miss_eviction\000uncore\000A cross-core snoop resulted from L3 Eviction which misses in some processor core\000event=0x22,umask=0x81\000\00000\000\000\000\000\000"
+/* offset=127031 */ "event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=0xe0\000\00000\000\000\000\000\000"
+/* offset=127085 */ "event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=0xc0\000\00000\000\000\000\000\000"
+/* offset=127143 */ "hisi_sccl,l3c\000"
+/* offset=127157 */ "uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total read hits\000event=7\000\00000\000\000\000\000\000"
+/* offset=127225 */ "uncore_imc_free_running\000"
+/* offset=127249 */ "uncore_imc_free_running.cache_miss\000uncore\000Total cache misses\000event=0x12\000\00000\000\000\000\000\000"
+/* offset=127329 */ "uncore_imc\000"
+/* offset=127340 */ "uncore_imc.cache_hits\000uncore\000Total cache hits\000event=0x34\000\00000\000\000\000\000\000"
+/* offset=127405 */ "uncore_sys_ddr_pmu\000"
+/* offset=127424 */ "sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycles event\000event=0x2b\000v8\00000\000\000\000\000\000"
+/* offset=127500 */ "uncore_sys_ccn_pmu\000"
+/* offset=127519 */ "sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles event\000config=0x2c\0000x01\00000\000\000\000\000\000"
+/* offset=127596 */ "uncore_sys_cmn_pmu\000"
+/* offset=127615 */ "sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total cache misses in first lookup result (high priority)\000eventid=1,type=5\000(434|436|43c|43a).*\00000\000\000\000\000\000"
+/* offset=127758 */ "CPUs_utilized\000Default\000(software@cpu\\-clock\\,name\\=cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=task\\-clock@) / (duration_time * 1e9)\000\000Average CPU utilization\000\0001CPUs\000\000\000\00001"
+/* offset=127943 */ "cs_per_second\000Default\000software@context\\-switches\\,name\\=context\\-switches@ * 1e9 / (software@cpu\\-clock\\,name\\=cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=task\\-clock@)\000\000Context switches per CPU second\000\0001cs/sec\000\000\000\00001"
+/* offset=128175 */ "migrations_per_second\000Default\000software@cpu\\-migrations\\,name\\=cpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\,name\\=cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=task\\-clock@)\000\000Process migrations to a new CPU per CPU second\000\0001migrations/sec\000\000\000\00001"
+/* offset=128434 */ "page_faults_per_second\000Default\000software@page\\-faults\\,name\\=page\\-faults@ * 1e9 / (software@cpu\\-clock\\,name\\=cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=task\\-clock@)\000\000Page faults per CPU second\000\0001faults/sec\000\000\000\00001"
+/* offset=128664 */ "insn_per_cycle\000Default\000instructions / cpu\\-cycles\000insn_per_cycle < 1\000Instructions Per Cycle\000\0001instructions\000\000\000\00000"
+/* offset=128776 */ "stalled_cycles_per_instruction\000Default\000max(stalled\\-cycles\\-frontend, stalled\\-cycles\\-backend) / instructions\000\000Max front or backend stalls per instruction\000\000\000\000\000\00000"
+/* offset=128939 */ "frontend_cycles_idle\000Default\000stalled\\-cycles\\-frontend / cpu\\-cycles\000frontend_cycles_idle > 0.1\000Frontend stalls per cycle\000\000\000\000\000\00000"
+/* offset=129068 */ "backend_cycles_idle\000Default\000stalled\\-cycles\\-backend / cpu\\-cycles\000backend_cycles_idle > 0.2\000Backend stalls per cycle\000\000\000\000\000\00000"
+/* offset=129193 */ "cycles_frequency\000Default\000cpu\\-cycles / (software@cpu\\-clock\\,name\\=cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=task\\-clock@)\000\000Cycles per CPU second\000\0001GHz\000\000\000\00001"
+/* offset=129368 */ "branch_frequency\000Default\000branches / (software@cpu\\-clock\\,name\\=cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=task\\-clock@)\000\000Branches per CPU second\000\0001000K/sec\000\000\000\00001"
+/* offset=129547 */ "branch_miss_rate\000Default\000branch\\-misses / branches\000branch_miss_rate > 0.05\000Branch miss rate\000\000100%\000\000\000\00000"
+/* offset=129650 */ "CPI\000\0001 / IPC\000\000\000\000\000\000\000\00000"
+/* offset=129672 */ "IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread\000\000\000\000\000\000\000\00000"
+/* offset=129735 */ "Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\00000"
+/* offset=129901 */ "dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.any\000\000\000\000\000\000\000\00000"
+/* offset=129965 */ "icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retired.any\000\000\000\000\000\000\000\00000"
+/* offset=130032 */ "cache_miss_cycles\000group1\000dcache_miss_cpi + icache_miss_cycles\000\000\000\000\000\000\000\00000"
+/* offset=130103 */ "DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\00000"
+/* offset=130197 */ "DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\000\000\000\000\000\000\000\00000"
+/* offset=130331 */ "DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Miss\000\000\000\000\000\000\000\00000"
+/* offset=130395 */ "DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2_All)\000\000\000\000\000\000\000\00000"
+/* offset=130463 */ "DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_L2_All)\000\000\000\000\000\000\000\00000"
+/* offset=130533 */ "M1\000\000ipc + M2\000\000\000\000\000\000\000\00000"
+/* offset=130555 */ "M2\000\000ipc + M1\000\000\000\000\000\000\000\00000"
+/* offset=130577 */ "M3\000\0001 / M3\000\000\000\000\000\000\000\00000"
+/* offset=130597 */ "L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / duration_time\000\000\000\000\000\000\000\00000"
 ;
 
 static const struct compact_pmu_event pmu_events__common_default_core[] = {
@@ -2564,35 +2564,35 @@ static const struct compact_pmu_event pmu_events__common_default_core[] = {
 { 122795 }, /* stalled-cycles-frontend\000legacy hardware\000Stalled cycles during issue [This event is an alias of idle-cycles-frontend]\000legacy-hardware-config=7\000\00000\000\000\000\000\000 */
 };
 static const struct compact_pmu_event pmu_events__common_software[] = {
-{ 124547 }, /* alignment-faults\000software\000Number of kernel handled memory alignment faults\000config=7\000\00000\000\000\000\000\000 */
-{ 124846 }, /* bpf-output\000software\000An event used by BPF programs to write to the perf ring buffer\000config=0xa\000\00000\000\000\000\000\000 */
-{ 124948 }, /* cgroup-switches\000software\000Number of context switches to a task in a different cgroup\000config=0xb\000\00000\000\000\000\000\000 */
-{ 123869 }, /* context-switches\000software\000Number of context switches [This event is an alias of cs]\000config=3\000\00000\000\000\000\000\000 */
-{ 123521 }, /* cpu-clock\000software\000Per-CPU high-resolution timer based event\000config=0\000\00000\000\000\000\000\000 */
-{ 124071 }, /* cpu-migrations\000software\000Number of times a process has migrated to a new CPU [This event is an alias of migrations]\000config=4\000\00000\000\000\000\000\000 */
-{ 123970 }, /* cs\000software\000Number of context switches [This event is an alias of context-switches]\000config=3\000\00000\000\000\000\000\000 */
-{ 124766 }, /* dummy\000software\000A placeholder event that doesn't count anything\000config=9\000\00000\000\000\000\000\000 */
-{ 124639 }, /* emulation-faults\000software\000Number of kernel handled unimplemented instruction faults handled through emulation\000config=8\000\00000\000\000\000\000\000 */
-{ 123679 }, /* faults\000software\000Number of page faults [This event is an alias of page-faults]\000config=2\000\00000\000\000\000\000\000 */
-{ 124444 }, /* major-faults\000software\000Number of major page faults. Major faults require I/O to handle\000config=6\000\00000\000\000\000\000\000 */
-{ 124203 }, /* migrations\000software\000Number of times a process has migrated to a new CPU [This event is an alias of cpu-migrations]\000config=4\000\00000\000\000\000\000\000 */
-{ 124335 }, /* minor-faults\000software\000Number of minor page faults. Minor faults don't require I/O to handle\000config=5\000\00000\000\000\000\000\000 */
-{ 123774 }, /* page-faults\000software\000Number of page faults [This event is an alias of faults]\000config=2\000\00000\000\000\000\000\000 */
-{ 123599 }, /* task-clock\000software\000Per-task high-resolution timer based event\000config=1\000\00000\000\000\000\000\000 */
+{ 124563 }, /* alignment-faults\000software\000Number of kernel handled memory alignment faults\000config=7\000\00000\000\000\000\000\000 */
+{ 124862 }, /* bpf-output\000software\000An event used by BPF programs to write to the perf ring buffer\000config=0xa\000\00000\000\000\000\000\000 */
+{ 124964 }, /* cgroup-switches\000software\000Number of context switches to a task in a different cgroup\000config=0xb\000\00000\000\000\000\000\000 */
+{ 123885 }, /* context-switches\000software\000Number of context switches [This event is an alias of cs]\000config=3\000\00000\000\000\000\000\000 */
+{ 123521 }, /* cpu-clock\000software\000Per-CPU high-resolution timer based event\000config=0\000\000001e-6msec\000\000\000\000\000 */
+{ 124087 }, /* cpu-migrations\000software\000Number of times a process has migrated to a new CPU [This event is an alias of migrations]\000config=4\000\00000\000\000\000\000\000 */
+{ 123986 }, /* cs\000software\000Number of context switches [This event is an alias of context-switches]\000config=3\000\00000\000\000\000\000\000 */
+{ 124782 }, /* dummy\000software\000A placeholder event that doesn't count anything\000config=9\000\00000\000\000\000\000\000 */
+{ 124655 }, /* emulation-faults\000software\000Number of kernel handled unimplemented instruction faults handled through emulation\000config=8\000\00000\000\000\000\000\000 */
+{ 123695 }, /* faults\000software\000Number of page faults [This event is an alias of page-faults]\000config=2\000\00000\000\000\000\000\000 */
+{ 124460 }, /* major-faults\000software\000Number of major page faults. Major faults require I/O to handle\000config=6\000\00000\000\000\000\000\000 */
+{ 124219 }, /* migrations\000software\000Number of times a process has migrated to a new CPU [This event is an alias of cpu-migrations]\000config=4\000\00000\000\000\000\000\000 */
+{ 124351 }, /* minor-faults\000software\000Number of minor page faults. Minor faults don't require I/O to handle\000config=5\000\00000\000\000\000\000\000 */
+{ 123790 }, /* page-faults\000software\000Number of page faults [This event is an alias of faults]\000config=2\000\00000\000\000\000\000\000 */
+{ 123607 }, /* task-clock\000software\000Per-task high-resolution timer based event\000config=1\000\000001e-6msec\000\000\000\000\000 */
 };
 static const struct compact_pmu_event pmu_events__common_tool[] = {
-{ 125056 }, /* duration_time\000tool\000Wall clock interval time in nanoseconds\000config=1\000\00000\000\000\000\000\000 */
-{ 125270 }, /* has_pmem\000tool\0001 if persistent memory installed otherwise 0\000config=4\000\00000\000\000\000\000\000 */
-{ 125346 }, /* num_cores\000tool\000Number of cores. A core consists of 1 or more thread, with each thread being associated with a logical Linux CPU\000config=5\000\00000\000\000\000\000\000 */
-{ 125491 }, /* num_cpus\000tool\000Number of logical Linux CPUs. There may be multiple such CPUs on a core\000config=6\000\00000\000\000\000\000\000 */
-{ 125594 }, /* num_cpus_online\000tool\000Number of online logical Linux CPUs. There may be multiple such CPUs on a core\000config=7\000\00000\000\000\000\000\000 */
-{ 125711 }, /* num_dies\000tool\000Number of dies. Each die has 1 or more cores\000config=8\000\00000\000\000\000\000\000 */
-{ 125787 }, /* num_packages\000tool\000Number of packages. Each package has 1 or more die\000config=9\000\00000\000\000\000\000\000 */
-{ 125873 }, /* slots\000tool\000Number of functional units that in parallel can execute parts of an instruction\000config=0xa\000\00000\000\000\000\000\000 */
-{ 125983 }, /* smt_on\000tool\0001 if simultaneous multithreading (aka hyperthreading) is enable otherwise 0\000config=0xb\000\00000\000\000\000\000\000 */
-{ 125202 }, /* system_time\000tool\000System/kernel time in nanoseconds\000config=3\000\00000\000\000\000\000\000 */
-{ 126090 }, /* system_tsc_freq\000tool\000The amount a Time Stamp Counter (TSC) increases per second\000config=0xc\000\00000\000\000\000\000\000 */
-{ 125132 }, /* user_time\000tool\000User (non-kernel) time in nanoseconds\000config=2\000\00000\000\000\000\000\000 */
+{ 125072 }, /* duration_time\000tool\000Wall clock interval time in nanoseconds\000config=1\000\00000\000\000\000\000\000 */
+{ 125286 }, /* has_pmem\000tool\0001 if persistent memory installed otherwise 0\000config=4\000\00000\000\000\000\000\000 */
+{ 125362 }, /* num_cores\000tool\000Number of cores. A core consists of 1 or more thread, with each thread being associated with a logical Linux CPU\000config=5\000\00000\000\000\000\000\000 */
+{ 125507 }, /* num_cpus\000tool\000Number of logical Linux CPUs. There may be multiple such CPUs on a core\000config=6\000\00000\000\000\000\000\000 */
+{ 125610 }, /* num_cpus_online\000tool\000Number of online logical Linux CPUs. There may be multiple such CPUs on a core\000config=7\000\00000\000\000\000\000\000 */
+{ 125727 }, /* num_dies\000tool\000Number of dies. Each die has 1 or more cores\000config=8\000\00000\000\000\000\000\000 */
+{ 125803 }, /* num_packages\000tool\000Number of packages. Each package has 1 or more die\000config=9\000\00000\000\000\000\000\000 */
+{ 125889 }, /* slots\000tool\000Number of functional units that in parallel can execute parts of an instruction\000config=0xa\000\00000\000\000\000\000\000 */
+{ 125999 }, /* smt_on\000tool\0001 if simultaneous multithreading (aka hyperthreading) is enable otherwise 0\000config=0xb\000\00000\000\000\000\000\000 */
+{ 125218 }, /* system_time\000tool\000System/kernel time in nanoseconds\000config=3\000\00000\000\000\000\000\000 */
+{ 126106 }, /* system_tsc_freq\000tool\000The amount a Time Stamp Counter (TSC) increases per second\000config=0xc\000\00000\000\000\000\000\000 */
+{ 125148 }, /* user_time\000tool\000User (non-kernel) time in nanoseconds\000config=2\000\00000\000\000\000\000\000 */
 
 };
 
@@ -2610,22 +2610,22 @@ static const struct pmu_table_entry pmu_events__common[] = {
 {
      .entries = pmu_events__common_tool,
      .num_entries = ARRAY_SIZE(pmu_events__common_tool),
-     .pmu_name = { 125051 /* tool\000 */ },
+     .pmu_name = { 125067 /* tool\000 */ },
 },
 };
 
 static const struct compact_pmu_event pmu_metrics__common_default_core[] = {
-{ 127742 }, /* CPUs_utilized\000Default\000(software@cpu\\-clock\\,name\\=cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=task\\-clock@) / (duration_time * 1e9)\000\000Average CPU utilization\000\0001CPUs\000\000\000\00001 */
-{ 129052 }, /* backend_cycles_idle\000Default\000stalled\\-cycles\\-backend / cpu\\-cycles\000backend_cycles_idle > 0.2\000Backend stalls per cycle\000\000\000\000\000\00000 */
-{ 129352 }, /* branch_frequency\000Default\000branches / (software@cpu\\-clock\\,name\\=cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=task\\-clock@)\000\000Branches per CPU second\000\0001000K/sec\000\000\000\00001 */
-{ 129531 }, /* branch_miss_rate\000Default\000branch\\-misses / branches\000branch_miss_rate > 0.05\000Branch miss rate\000\000100%\000\000\000\00000 */
-{ 127927 }, /* cs_per_second\000Default\000software@context\\-switches\\,name\\=context\\-switches@ * 1e9 / (software@cpu\\-clock\\,name\\=cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=task\\-clock@)\000\000Context switches per CPU second\000\0001cs/sec\000\000\000\00001 */
-{ 129177 }, /* cycles_frequency\000Default\000cpu\\-cycles / (software@cpu\\-clock\\,name\\=cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=task\\-clock@)\000\000Cycles per CPU second\000\0001GHz\000\000\000\00001 */
-{ 128923 }, /* frontend_cycles_idle\000Default\000stalled\\-cycles\\-frontend / cpu\\-cycles\000frontend_cycles_idle > 0.1\000Frontend stalls per cycle\000\000\000\000\000\00000 */
-{ 128648 }, /* insn_per_cycle\000Default\000instructions / cpu\\-cycles\000insn_per_cycle < 1\000Instructions Per Cycle\000\0001instructions\000\000\000\00000 */
-{ 128159 }, /* migrations_per_second\000Default\000software@cpu\\-migrations\\,name\\=cpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\,name\\=cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=task\\-clock@)\000\000Process migrations to a new CPU per CPU second\000\0001migrations/sec\000\000\000\00001 */
-{ 128418 }, /* page_faults_per_second\000Default\000software@page\\-faults\\,name\\=page\\-faults@ * 1e9 / (software@cpu\\-clock\\,name\\=cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=task\\-clock@)\000\000Page faults per CPU second\000\0001faults/sec\000\000\000\00001 */
-{ 128760 }, /* stalled_cycles_per_instruction\000Default\000max(stalled\\-cycles\\-frontend, stalled\\-cycles\\-backend) / instructions\000\000Max front or backend stalls per instruction\000\000\000\000\000\00000 */
+{ 127758 }, /* CPUs_utilized\000Default\000(software@cpu\\-clock\\,name\\=cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=task\\-clock@) / (duration_time * 1e9)\000\000Average CPU utilization\000\0001CPUs\000\000\000\00001 */
+{ 129068 }, /* backend_cycles_idle\000Default\000stalled\\-cycles\\-backend / cpu\\-cycles\000backend_cycles_idle > 0.2\000Backend stalls per cycle\000\000\000\000\000\00000 */
+{ 129368 }, /* branch_frequency\000Default\000branches / (software@cpu\\-clock\\,name\\=cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=task\\-clock@)\000\000Branches per CPU second\000\0001000K/sec\000\000\000\00001 */
+{ 129547 }, /* branch_miss_rate\000Default\000branch\\-misses / branches\000branch_miss_rate > 0.05\000Branch miss rate\000\000100%\000\000\000\00000 */
+{ 127943 }, /* cs_per_second\000Default\000software@context\\-switches\\,name\\=context\\-switches@ * 1e9 / (software@cpu\\-clock\\,name\\=cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=task\\-clock@)\000\000Context switches per CPU second\000\0001cs/sec\000\000\000\00001 */
+{ 129193 }, /* cycles_frequency\000Default\000cpu\\-cycles / (software@cpu\\-clock\\,name\\=cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=task\\-clock@)\000\000Cycles per CPU second\000\0001GHz\000\000\000\00001 */
+{ 128939 }, /* frontend_cycles_idle\000Default\000stalled\\-cycles\\-frontend / cpu\\-cycles\000frontend_cycles_idle > 0.1\000Frontend stalls per cycle\000\000\000\000\000\00000 */
+{ 128664 }, /* insn_per_cycle\000Default\000instructions / cpu\\-cycles\000insn_per_cycle < 1\000Instructions Per Cycle\000\0001instructions\000\000\000\00000 */
+{ 128175 }, /* migrations_per_second\000Default\000software@cpu\\-migrations\\,name\\=cpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\,name\\=cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=task\\-clock@)\000\000Process migrations to a new CPU per CPU second\000\0001migrations/sec\000\000\000\00001 */
+{ 128434 }, /* page_faults_per_second\000Default\000software@page\\-faults\\,name\\=page\\-faults@ * 1e9 / (software@cpu\\-clock\\,name\\=cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=task\\-clock@)\000\000Page faults per CPU second\000\0001faults/sec\000\000\000\00001 */
+{ 128776 }, /* stalled_cycles_per_instruction\000Default\000max(stalled\\-cycles\\-frontend, stalled\\-cycles\\-backend) / instructions\000\000Max front or backend stalls per instruction\000\000\000\000\000\00000 */
 
 };
 
@@ -2638,29 +2638,29 @@ static const struct pmu_table_entry pmu_metrics__common[] = {
 };
 
 static const struct compact_pmu_event pmu_events__test_soc_cpu_default_core[] = {
-{ 126189 }, /* bp_l1_btb_correct\000branch\000L1 BTB Correction\000event=0x8a\000\00000\000\000\000\000\000 */
-{ 126251 }, /* bp_l2_btb_correct\000branch\000L2 BTB Correction\000event=0x8b\000\00000\000\000\000\000\000 */
-{ 126513 }, /* dispatch_blocked.any\000other\000Memory cluster signals to block micro-op dispatch for any reason\000event=9,period=200000,umask=0x20\000\00000\000\000\000\000\000 */
-{ 126646 }, /* eist_trans\000other\000Number of Enhanced Intel SpeedStep(R) Technology (EIST) transitions\000event=0x3a,period=200000\000\00000\000\000\000\000\000 */
-{ 126313 }, /* l3_cache_rd\000cache\000L3 cache access, read\000event=0x40\000\00000\000\000\000\000Attributable Level 3 cache access, read\000 */
-{ 126411 }, /* segment_reg_loads.any\000other\000Number of segment register loads\000event=6,period=200000,umask=0x80\000\00000\000\000\000\000\000 */
+{ 126205 }, /* bp_l1_btb_correct\000branch\000L1 BTB Correction\000event=0x8a\000\00000\000\000\000\000\000 */
+{ 126267 }, /* bp_l2_btb_correct\000branch\000L2 BTB Correction\000event=0x8b\000\00000\000\000\000\000\000 */
+{ 126529 }, /* dispatch_blocked.any\000other\000Memory cluster signals to block micro-op dispatch for any reason\000event=9,period=200000,umask=0x20\000\00000\000\000\000\000\000 */
+{ 126662 }, /* eist_trans\000other\000Number of Enhanced Intel SpeedStep(R) Technology (EIST) transitions\000event=0x3a,period=200000\000\00000\000\000\000\000\000 */
+{ 126329 }, /* l3_cache_rd\000cache\000L3 cache access, read\000event=0x40\000\00000\000\000\000\000Attributable Level 3 cache access, read\000 */
+{ 126427 }, /* segment_reg_loads.any\000other\000Number of segment register loads\000event=6,period=200000,umask=0x80\000\00000\000\000\000\000\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_hisi_sccl_ddrc[] = {
-{ 126779 }, /* uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write commands\000event=2\000\00000\000\000\000\000\000 */
+{ 126795 }, /* uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write commands\000event=2\000\00000\000\000\000\000\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_hisi_sccl_l3c[] = {
-{ 127141 }, /* uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total read hits\000event=7\000\00000\000\000\000\000\000 */
+{ 127157 }, /* uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total read hits\000event=7\000\00000\000\000\000\000\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_cbox[] = {
-{ 127015 }, /* event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=0xe0\000\00000\000\000\000\000\000 */
-{ 127069 }, /* event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=0xc0\000\00000\000\000\000\000\000 */
-{ 126861 }, /* unc_cbo_xsnp_response.miss_eviction\000uncore\000A cross-core snoop resulted from L3 Eviction which misses in some processor core\000event=0x22,umask=0x81\000\00000\000\000\000\000\000 */
+{ 127031 }, /* event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=0xe0\000\00000\000\000\000\000\000 */
+{ 127085 }, /* event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=0xc0\000\00000\000\000\000\000\000 */
+{ 126877 }, /* unc_cbo_xsnp_response.miss_eviction\000uncore\000A cross-core snoop resulted from L3 Eviction which misses in some processor core\000event=0x22,umask=0x81\000\00000\000\000\000\000\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_imc[] = {
-{ 127324 }, /* uncore_imc.cache_hits\000uncore\000Total cache hits\000event=0x34\000\00000\000\000\000\000\000 */
+{ 127340 }, /* uncore_imc.cache_hits\000uncore\000Total cache hits\000event=0x34\000\00000\000\000\000\000\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_imc_free_running[] = {
-{ 127233 }, /* uncore_imc_free_running.cache_miss\000uncore\000Total cache misses\000event=0x12\000\00000\000\000\000\000\000 */
+{ 127249 }, /* uncore_imc_free_running.cache_miss\000uncore\000Total cache misses\000event=0x12\000\00000\000\000\000\000\000 */
 
 };
 
@@ -2673,46 +2673,46 @@ static const struct pmu_table_entry pmu_events__test_soc_cpu[] = {
 {
      .entries = pmu_events__test_soc_cpu_hisi_sccl_ddrc,
      .num_entries = ARRAY_SIZE(pmu_events__test_soc_cpu_hisi_sccl_ddrc),
-     .pmu_name = { 126764 /* hisi_sccl,ddrc\000 */ },
+     .pmu_name = { 126780 /* hisi_sccl,ddrc\000 */ },
 },
 {
      .entries = pmu_events__test_soc_cpu_hisi_sccl_l3c,
      .num_entries = ARRAY_SIZE(pmu_events__test_soc_cpu_hisi_sccl_l3c),
-     .pmu_name = { 127127 /* hisi_sccl,l3c\000 */ },
+     .pmu_name = { 127143 /* hisi_sccl,l3c\000 */ },
 },
 {
      .entries = pmu_events__test_soc_cpu_uncore_cbox,
      .num_entries = ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_cbox),
-     .pmu_name = { 126849 /* uncore_cbox\000 */ },
+     .pmu_name = { 126865 /* uncore_cbox\000 */ },
 },
 {
      .entries = pmu_events__test_soc_cpu_uncore_imc,
      .num_entries = ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_imc),
-     .pmu_name = { 127313 /* uncore_imc\000 */ },
+     .pmu_name = { 127329 /* uncore_imc\000 */ },
 },
 {
      .entries = pmu_events__test_soc_cpu_uncore_imc_free_running,
      .num_entries = ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_imc_free_running),
-     .pmu_name = { 127209 /* uncore_imc_free_running\000 */ },
+     .pmu_name = { 127225 /* uncore_imc_free_running\000 */ },
 },
 };
 
 static const struct compact_pmu_event pmu_metrics__test_soc_cpu_default_core[] = {
-{ 129634 }, /* CPI\000\0001 / IPC\000\000\000\000\000\000\000\00000 */
-{ 130315 }, /* DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Miss\000\000\000\000\000\000\000\00000 */
-{ 130087 }, /* DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\00000 */
-{ 130181 }, /* DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\000\000\000\000\000\000\000\00000 */
-{ 130379 }, /* DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2_All)\000\000\000\000\000\000\000\00000 */
-{ 130447 }, /* DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_L2_All)\000\000\000\000\000\000\000\00000 */
-{ 129719 }, /* Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\00000 */
-{ 129656 }, /* IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread\000\000\000\000\000\000\000\00000 */
-{ 130581 }, /* L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / duration_time\000\000\000\000\000\000\000\00000 */
-{ 130517 }, /* M1\000\000ipc + M2\000\000\000\000\000\000\000\00000 */
-{ 130539 }, /* M2\000\000ipc + M1\000\000\000\000\000\000\000\00000 */
-{ 130561 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\00000 */
-{ 130016 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_miss_cycles\000\000\000\000\000\000\000\00000 */
-{ 129885 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.any\000\000\000\000\000\000\000\00000 */
-{ 129949 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retired.any\000\000\000\000\000\000\000\00000 */
+{ 129650 }, /* CPI\000\0001 / IPC\000\000\000\000\000\000\000\00000 */
+{ 130331 }, /* DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Miss\000\000\000\000\000\000\000\00000 */
+{ 130103 }, /* DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\00000 */
+{ 130197 }, /* DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\000\000\000\000\000\000\000\00000 */
+{ 130395 }, /* DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2_All)\000\000\000\000\000\000\000\00000 */
+{ 130463 }, /* DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_L2_All)\000\000\000\000\000\000\000\00000 */
+{ 129735 }, /* Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\00000 */
+{ 129672 }, /* IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread\000\000\000\000\000\000\000\00000 */
+{ 130597 }, /* L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / duration_time\000\000\000\000\000\000\000\00000 */
+{ 130533 }, /* M1\000\000ipc + M2\000\000\000\000\000\000\000\00000 */
+{ 130555 }, /* M2\000\000ipc + M1\000\000\000\000\000\000\000\00000 */
+{ 130577 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\00000 */
+{ 130032 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_miss_cycles\000\000\000\000\000\000\000\00000 */
+{ 129901 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.any\000\000\000\000\000\000\000\00000 */
+{ 129965 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retired.any\000\000\000\000\000\000\000\00000 */
 
 };
 
@@ -2725,13 +2725,13 @@ static const struct pmu_table_entry pmu_metrics__test_soc_cpu[] = {
 };
 
 static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sys_ccn_pmu[] = {
-{ 127503 }, /* sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles event\000config=0x2c\0000x01\00000\000\000\000\000\000 */
+{ 127519 }, /* sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles event\000config=0x2c\0000x01\00000\000\000\000\000\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sys_cmn_pmu[] = {
-{ 127599 }, /* sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total cache misses in first lookup result (high priority)\000eventid=1,type=5\000(434|436|43c|43a).*\00000\000\000\000\000\000 */
+{ 127615 }, /* sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total cache misses in first lookup result (high priority)\000eventid=1,type=5\000(434|436|43c|43a).*\00000\000\000\000\000\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sys_ddr_pmu[] = {
-{ 127408 }, /* sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycles event\000event=0x2b\000v8\00000\000\000\000\000\000 */
+{ 127424 }, /* sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycles event\000event=0x2b\000v8\00000\000\000\000\000\000 */
 
 };
 
@@ -2739,17 +2739,17 @@ static const struct pmu_table_entry pmu_events__test_soc_sys[] = {
 {
      .entries = pmu_events__test_soc_sys_uncore_sys_ccn_pmu,
      .num_entries = ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_ccn_pmu),
-     .pmu_name = { 127484 /* uncore_sys_ccn_pmu\000 */ },
+     .pmu_name = { 127500 /* uncore_sys_ccn_pmu\000 */ },
 },
 {
      .entries = pmu_events__test_soc_sys_uncore_sys_cmn_pmu,
      .num_entries = ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_cmn_pmu),
-     .pmu_name = { 127580 /* uncore_sys_cmn_pmu\000 */ },
+     .pmu_name = { 127596 /* uncore_sys_cmn_pmu\000 */ },
 },
 {
      .entries = pmu_events__test_soc_sys_uncore_sys_ddr_pmu,
      .num_entries = ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_ddr_pmu),
-     .pmu_name = { 127389 /* uncore_sys_ddr_pmu\000 */ },
+     .pmu_name = { 127405 /* uncore_sys_ddr_pmu\000 */ },
 },
 };
 
-- 
2.51.2.1041.gc1ab5b90ca-goog

