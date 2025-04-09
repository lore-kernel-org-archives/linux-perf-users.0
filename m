Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68952202C3E
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Apr 2025 06:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744179084; cv=none; b=SnM8n15KxIMr5WFORhtNKSIG3+6PfjF6hHgDOOrC859j0+n+mivLj2nOQtYcRTia2SUPz8F1vENZzvZleXFpqGx2EObOSo4bQ6QqC2Na2Z8318N2UsZA7aSS9ulihlW7nU8Jj1Nh9Wi8SCNnyRaeXLYSt//C0xwxUFJdjAdK8b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744179084; c=relaxed/simple;
	bh=SNGiNhl3DrgFCvxGGPb8DnX9crh6HpsqooXUMWzR8Bo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=R53oHD4/OT6DK7gFHSIIj2mA1Emnve4Eb9io6fMDlfzPGaDo+PxHcAKJ7esHv0gGyxLZhMlDmMabZDYsN39xFF2AL/70GotC3M56uHrPrYBEwv49aorJXuHZwO403CISTEAE0l6DGrszLNcLaF27Iwm/OVfslIPyFyicIJ0JAKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CcIh+5Yz; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CcIh+5Yz"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-224192ff68bso59138145ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Apr 2025 23:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744179081; x=1744783881; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DrjE5aMITbrxjK5QqlVnV58r0oh1BWdszMCAScgXzK4=;
        b=CcIh+5Yzn/xmcGyNjrT5cgOHa3XobCwY3jrzbp3n0ZZ+26NDRZ65owkqiftKI3Wami
         6XgHB3ciVFahEzw/QB206XHXUw1Hj2yXjAbQOkb2a7lA0hBw3vnq+d+DP/2+eKWwQG5S
         ogDJ1+CnrULN0bLKUXtzS3vPaUdUrGeHjxNnx+gbaNddYH1YfOelv/mz5zktHDrF1Z/Y
         JS+19j7WFPnxRXj8dWxrJopFpIaQcN41gvQYHFqQWNZMNYFiqNwMwNZKuQ3EyfiCVj8l
         NF+qNG3xDra7OrfT5PyXEY1aVY0tKXaILnulAN6reqBFfGJjSuIfw3qUwFEYuuXziRlP
         JMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744179081; x=1744783881;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DrjE5aMITbrxjK5QqlVnV58r0oh1BWdszMCAScgXzK4=;
        b=EZikEDVqzCpF0c+5kUGmauIhiS4krgmTo8MvzPmHP+jYflM56YfVW13A0x9vCP+upO
         jBkZ7pLVBytqMz+ycdJR/KjsMCZGz7WbLEDy+36fm9pf7AvivlGIpwuk/11dGFK+959K
         JTINymZESJXHPQ20HDxqmftyX0v4rf0pf3bzqEdJtxXmg1vIMeshX5ZQV6LpBQLj5bBD
         l4nF/aqIcgfD2r4r3j/09XzdLgbZ3OlTFdBtuSBUqHTbRcjiJ2MPmLXcqHoz4kKcPhe/
         PlpySzU8STw3ZER4sTWOWA5n6RfMXMix08yOj017H+kwBal+TEbLz8jnjBtODRhPFA6L
         wxYg==
X-Forwarded-Encrypted: i=1; AJvYcCXb44DoMS4ldsdWzCGdmKVpTXbxDbEqwdmYyOKPOVNLama5Mr7QFcCEq8TeENz9aZ2ZcnLbcg+p5cghynbL4spS@vger.kernel.org
X-Gm-Message-State: AOJu0YxkdeLhiaPQQgIA7pNHBiqHOWGEV633LV8rKFjST3j3+PTAIq1h
	czFETvAp5vwxXiS2bMI7Fd7qCzfTj3+qdaZwgHeLP+hhzTEW4cdzKTH1tXl1W4i/iOhW/HI0/01
	4gWx/aQ==
X-Google-Smtp-Source: AGHT+IFcED5nxA10pX8N+h+LgmMXkhVBrKBr592q24ECr6S8Iq911J+gv8Zfx2r6X/w5PA9GSW2yeZEH4CG+
X-Received: from plgp15.prod.google.com ([2002:a17:902:ebcf:b0:223:5c58:1855])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:230b:b0:223:47d9:1964
 with SMTP id d9443c01a7336-22ac2a1df2cmr30079805ad.34.1744179080709; Tue, 08
 Apr 2025 23:11:20 -0700 (PDT)
Date: Tue,  8 Apr 2025 23:10:42 -0700
In-Reply-To: <20250409061043.700792-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250409061043.700792-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250409061043.700792-16-irogers@google.com>
Subject: [PATCH v4 15/16] perf pmu-events: Add retirement latency to JSON
 events inside of perf
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	John Garry <john.g.garry@oracle.com>, Howard Chu <howardchu95@gmail.com>, 
	Levi Yun <yeoreum.yun@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The updated Intel vendor events add retirement latency for
graniterapids:
https://lore.kernel.org/lkml/20250322063403.364981-14-irogers@google.com/
This change makes those values available within an alias/event within
a PMU and saves them into the evsel at event parse time. When no TPEBS
data is available the default values are substituted in for TMA
metrics that are using retirement latency events - currently just
those on graniterapids.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/empty-pmu-events.c | 216 ++++++++++++-----------
 tools/perf/pmu-events/jevents.py         |   6 +
 tools/perf/pmu-events/pmu-events.h       |   3 +
 tools/perf/util/evsel.h                  |   6 +
 tools/perf/util/intel-tpebs.c            |  52 ++++--
 tools/perf/util/parse-events.c           |   4 +
 tools/perf/util/pmu.c                    |  52 +++++-
 tools/perf/util/pmu.h                    |   3 +
 8 files changed, 220 insertions(+), 122 deletions(-)

diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-even=
ts/empty-pmu-events.c
index 0cb7ba7912e8..0361bcc1eb58 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -20,73 +20,73 @@ struct pmu_table_entry {
=20
 static const char *const big_c_string =3D
 /* offset=3D0 */ "tool\000"
-/* offset=3D5 */ "duration_time\000tool\000Wall clock interval time in nan=
oseconds\000config=3D1\000\00000\000\000"
-/* offset=3D78 */ "user_time\000tool\000User (non-kernel) time in nanoseco=
nds\000config=3D2\000\00000\000\000"
-/* offset=3D145 */ "system_time\000tool\000System/kernel time in nanosecon=
ds\000config=3D3\000\00000\000\000"
-/* offset=3D210 */ "has_pmem\000tool\0001 if persistent memory installed o=
therwise 0\000config=3D4\000\00000\000\000"
-/* offset=3D283 */ "num_cores\000tool\000Number of cores. A core consists =
of 1 or more thread, with each thread being associated with a logical Linux=
 CPU\000config=3D5\000\00000\000\000"
-/* offset=3D425 */ "num_cpus\000tool\000Number of logical Linux CPUs. Ther=
e may be multiple such CPUs on a core\000config=3D6\000\00000\000\000"
-/* offset=3D525 */ "num_cpus_online\000tool\000Number of online logical Li=
nux CPUs. There may be multiple such CPUs on a core\000config=3D7\000\00000=
\000\000"
-/* offset=3D639 */ "num_dies\000tool\000Number of dies. Each die has 1 or =
more cores\000config=3D8\000\00000\000\000"
-/* offset=3D712 */ "num_packages\000tool\000Number of packages. Each packa=
ge has 1 or more die\000config=3D9\000\00000\000\000"
-/* offset=3D795 */ "slots\000tool\000Number of functional units that in pa=
rallel can execute parts of an instruction\000config=3D0xa\000\00000\000\00=
0"
-/* offset=3D902 */ "smt_on\000tool\0001 if simultaneous multithreading (ak=
a hyperthreading) is enable otherwise 0\000config=3D0xb\000\00000\000\000"
-/* offset=3D1006 */ "system_tsc_freq\000tool\000The amount a Time Stamp Co=
unter (TSC) increases per second\000config=3D0xc\000\00000\000\000"
-/* offset=3D1102 */ "default_core\000"
-/* offset=3D1115 */ "bp_l1_btb_correct\000branch\000L1 BTB Correction\000e=
vent=3D0x8a\000\00000\000\000"
-/* offset=3D1174 */ "bp_l2_btb_correct\000branch\000L2 BTB Correction\000e=
vent=3D0x8b\000\00000\000\000"
-/* offset=3D1233 */ "l3_cache_rd\000cache\000L3 cache access, read\000even=
t=3D0x40\000\00000\000Attributable Level 3 cache access, read\000"
-/* offset=3D1328 */ "segment_reg_loads.any\000other\000Number of segment r=
egister loads\000event=3D6,period=3D200000,umask=3D0x80\000\00000\000\000"
-/* offset=3D1427 */ "dispatch_blocked.any\000other\000Memory cluster signa=
ls to block micro-op dispatch for any reason\000event=3D9,period=3D200000,u=
mask=3D0x20\000\00000\000\000"
-/* offset=3D1557 */ "eist_trans\000other\000Number of Enhanced Intel Speed=
Step(R) Technology (EIST) transitions\000event=3D0x3a,period=3D200000\000\0=
0000\000\000"
-/* offset=3D1672 */ "hisi_sccl,ddrc\000"
-/* offset=3D1687 */ "uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write co=
mmands\000event=3D2\000\00000\000DDRC write commands\000"
-/* offset=3D1773 */ "uncore_cbox\000"
-/* offset=3D1785 */ "unc_cbo_xsnp_response.miss_eviction\000uncore\000A cr=
oss-core snoop resulted from L3 Eviction which misses in some processor cor=
e\000event=3D0x22,umask=3D0x81\000\00000\000A cross-core snoop resulted fro=
m L3 Eviction which misses in some processor core\000"
-/* offset=3D2016 */ "event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=3D0=
xe0\000\00000\000UNC_CBO_HYPHEN\000"
-/* offset=3D2081 */ "event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=
=3D0xc0\000\00000\000UNC_CBO_TWO_HYPH\000"
-/* offset=3D2152 */ "hisi_sccl,l3c\000"
-/* offset=3D2166 */ "uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total read =
hits\000event=3D7\000\00000\000Total read hits\000"
-/* offset=3D2246 */ "uncore_imc_free_running\000"
-/* offset=3D2270 */ "uncore_imc_free_running.cache_miss\000uncore\000Total=
 cache misses\000event=3D0x12\000\00000\000Total cache misses\000"
-/* offset=3D2365 */ "uncore_imc\000"
-/* offset=3D2376 */ "uncore_imc.cache_hits\000uncore\000Total cache hits\0=
00event=3D0x34\000\00000\000Total cache hits\000"
-/* offset=3D2454 */ "uncore_sys_ddr_pmu\000"
-/* offset=3D2473 */ "sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycle=
s event\000event=3D0x2b\000v8\00000\000\000"
-/* offset=3D2546 */ "uncore_sys_ccn_pmu\000"
-/* offset=3D2565 */ "sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles =
event\000config=3D0x2c\0000x01\00000\000\000"
-/* offset=3D2639 */ "uncore_sys_cmn_pmu\000"
-/* offset=3D2658 */ "sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total =
cache misses in first lookup result (high priority)\000eventid=3D1,type=3D5=
\000(434|436|43c|43a).*\00000\000\000"
-/* offset=3D2798 */ "CPI\000\0001 / IPC\000\000\000\000\000\000\000\00000"
-/* offset=3D2820 */ "IPC\000group1\000inst_retired.any / cpu_clk_unhalted.=
thread\000\000\000\000\000\000\000\00000"
-/* offset=3D2883 */ "Frontend_Bound_SMT\000\000idq_uops_not_delivered.core=
 / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_act=
ive / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\00000"
-/* offset=3D3049 */ "dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_re=
tired.any\000\000\000\000\000\000\000\00000"
-/* offset=3D3113 */ "icache_miss_cycles\000\000l1i\\-loads\\-misses / inst=
_retired.any\000\000\000\000\000\000\000\00000"
-/* offset=3D3180 */ "cache_miss_cycles\000group1\000dcache_miss_cpi + icac=
he_miss_cycles\000\000\000\000\000\000\000\00000"
-/* offset=3D3251 */ "DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit=
 + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\00000"
-/* offset=3D3345 */ "DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_dat=
a_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_mi=
ss\000\000\000\000\000\000\000\00000"
-/* offset=3D3479 */ "DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_A=
ll_Miss\000\000\000\000\000\000\000\00000"
-/* offset=3D3543 */ "DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCa=
che_L2_All)\000\000\000\000\000\000\000\00000"
-/* offset=3D3611 */ "DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, D=
Cache_L2_All)\000\000\000\000\000\000\000\00000"
-/* offset=3D3681 */ "M1\000\000ipc + M2\000\000\000\000\000\000\000\00000"
-/* offset=3D3703 */ "M2\000\000ipc + M1\000\000\000\000\000\000\000\00000"
-/* offset=3D3725 */ "M3\000\0001 / M3\000\000\000\000\000\000\000\00000"
-/* offset=3D3745 */ "L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 /=
 duration_time\000\000\000\000\000\000\000\00000"
+/* offset=3D5 */ "duration_time\000tool\000Wall clock interval time in nan=
oseconds\000config=3D1\000\00000\000\000\000\000\000"
+/* offset=3D81 */ "user_time\000tool\000User (non-kernel) time in nanoseco=
nds\000config=3D2\000\00000\000\000\000\000\000"
+/* offset=3D151 */ "system_time\000tool\000System/kernel time in nanosecon=
ds\000config=3D3\000\00000\000\000\000\000\000"
+/* offset=3D219 */ "has_pmem\000tool\0001 if persistent memory installed o=
therwise 0\000config=3D4\000\00000\000\000\000\000\000"
+/* offset=3D295 */ "num_cores\000tool\000Number of cores. A core consists =
of 1 or more thread, with each thread being associated with a logical Linux=
 CPU\000config=3D5\000\00000\000\000\000\000\000"
+/* offset=3D440 */ "num_cpus\000tool\000Number of logical Linux CPUs. Ther=
e may be multiple such CPUs on a core\000config=3D6\000\00000\000\000\000\0=
00\000"
+/* offset=3D543 */ "num_cpus_online\000tool\000Number of online logical Li=
nux CPUs. There may be multiple such CPUs on a core\000config=3D7\000\00000=
\000\000\000\000\000"
+/* offset=3D660 */ "num_dies\000tool\000Number of dies. Each die has 1 or =
more cores\000config=3D8\000\00000\000\000\000\000\000"
+/* offset=3D736 */ "num_packages\000tool\000Number of packages. Each packa=
ge has 1 or more die\000config=3D9\000\00000\000\000\000\000\000"
+/* offset=3D822 */ "slots\000tool\000Number of functional units that in pa=
rallel can execute parts of an instruction\000config=3D0xa\000\00000\000\00=
0\000\000\000"
+/* offset=3D932 */ "smt_on\000tool\0001 if simultaneous multithreading (ak=
a hyperthreading) is enable otherwise 0\000config=3D0xb\000\00000\000\000\0=
00\000\000"
+/* offset=3D1039 */ "system_tsc_freq\000tool\000The amount a Time Stamp Co=
unter (TSC) increases per second\000config=3D0xc\000\00000\000\000\000\000\=
000"
+/* offset=3D1138 */ "default_core\000"
+/* offset=3D1151 */ "bp_l1_btb_correct\000branch\000L1 BTB Correction\000e=
vent=3D0x8a\000\00000\000\000\000\000\000"
+/* offset=3D1213 */ "bp_l2_btb_correct\000branch\000L2 BTB Correction\000e=
vent=3D0x8b\000\00000\000\000\000\000\000"
+/* offset=3D1275 */ "l3_cache_rd\000cache\000L3 cache access, read\000even=
t=3D0x40\000\00000\000\000\000\000Attributable Level 3 cache access, read\0=
00"
+/* offset=3D1373 */ "segment_reg_loads.any\000other\000Number of segment r=
egister loads\000event=3D6,period=3D200000,umask=3D0x80\000\00000\000\000\0=
00\000\000"
+/* offset=3D1475 */ "dispatch_blocked.any\000other\000Memory cluster signa=
ls to block micro-op dispatch for any reason\000event=3D9,period=3D200000,u=
mask=3D0x20\000\00000\000\000\000\000\000"
+/* offset=3D1608 */ "eist_trans\000other\000Number of Enhanced Intel Speed=
Step(R) Technology (EIST) transitions\000event=3D0x3a,period=3D200000\000\0=
0000\000\000\000\000\000"
+/* offset=3D1726 */ "hisi_sccl,ddrc\000"
+/* offset=3D1741 */ "uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write co=
mmands\000event=3D2\000\00000\000\000\000\000DDRC write commands\000"
+/* offset=3D1830 */ "uncore_cbox\000"
+/* offset=3D1842 */ "unc_cbo_xsnp_response.miss_eviction\000uncore\000A cr=
oss-core snoop resulted from L3 Eviction which misses in some processor cor=
e\000event=3D0x22,umask=3D0x81\000\00000\000\000\000\000A cross-core snoop =
resulted from L3 Eviction which misses in some processor core\000"
+/* offset=3D2076 */ "event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=3D0=
xe0\000\00000\000\000\000\000UNC_CBO_HYPHEN\000"
+/* offset=3D2144 */ "event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=
=3D0xc0\000\00000\000\000\000\000UNC_CBO_TWO_HYPH\000"
+/* offset=3D2218 */ "hisi_sccl,l3c\000"
+/* offset=3D2232 */ "uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total read =
hits\000event=3D7\000\00000\000\000\000\000Total read hits\000"
+/* offset=3D2315 */ "uncore_imc_free_running\000"
+/* offset=3D2339 */ "uncore_imc_free_running.cache_miss\000uncore\000Total=
 cache misses\000event=3D0x12\000\00000\000\000\000\000Total cache misses\0=
00"
+/* offset=3D2437 */ "uncore_imc\000"
+/* offset=3D2448 */ "uncore_imc.cache_hits\000uncore\000Total cache hits\0=
00event=3D0x34\000\00000\000\000\000\000Total cache hits\000"
+/* offset=3D2529 */ "uncore_sys_ddr_pmu\000"
+/* offset=3D2548 */ "sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycle=
s event\000event=3D0x2b\000v8\00000\000\000\000\000\000"
+/* offset=3D2624 */ "uncore_sys_ccn_pmu\000"
+/* offset=3D2643 */ "sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles =
event\000config=3D0x2c\0000x01\00000\000\000\000\000\000"
+/* offset=3D2720 */ "uncore_sys_cmn_pmu\000"
+/* offset=3D2739 */ "sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total =
cache misses in first lookup result (high priority)\000eventid=3D1,type=3D5=
\000(434|436|43c|43a).*\00000\000\000\000\000\000"
+/* offset=3D2882 */ "CPI\000\0001 / IPC\000\000\000\000\000\000\000\00000"
+/* offset=3D2904 */ "IPC\000group1\000inst_retired.any / cpu_clk_unhalted.=
thread\000\000\000\000\000\000\000\00000"
+/* offset=3D2967 */ "Frontend_Bound_SMT\000\000idq_uops_not_delivered.core=
 / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_act=
ive / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\00000"
+/* offset=3D3133 */ "dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_re=
tired.any\000\000\000\000\000\000\000\00000"
+/* offset=3D3197 */ "icache_miss_cycles\000\000l1i\\-loads\\-misses / inst=
_retired.any\000\000\000\000\000\000\000\00000"
+/* offset=3D3264 */ "cache_miss_cycles\000group1\000dcache_miss_cpi + icac=
he_miss_cycles\000\000\000\000\000\000\000\00000"
+/* offset=3D3335 */ "DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit=
 + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\00000"
+/* offset=3D3429 */ "DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_dat=
a_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_mi=
ss\000\000\000\000\000\000\000\00000"
+/* offset=3D3563 */ "DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_A=
ll_Miss\000\000\000\000\000\000\000\00000"
+/* offset=3D3627 */ "DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCa=
che_L2_All)\000\000\000\000\000\000\000\00000"
+/* offset=3D3695 */ "DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, D=
Cache_L2_All)\000\000\000\000\000\000\000\00000"
+/* offset=3D3765 */ "M1\000\000ipc + M2\000\000\000\000\000\000\000\00000"
+/* offset=3D3787 */ "M2\000\000ipc + M1\000\000\000\000\000\000\000\00000"
+/* offset=3D3809 */ "M3\000\0001 / M3\000\000\000\000\000\000\000\00000"
+/* offset=3D3829 */ "L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 /=
 duration_time\000\000\000\000\000\000\000\00000"
 ;
=20
 static const struct compact_pmu_event pmu_events__common_tool[] =3D {
-{ 5 }, /* duration_time\000tool\000Wall clock interval time in nanoseconds=
\000config=3D1\000\00000\000\000 */
-{ 210 }, /* has_pmem\000tool\0001 if persistent memory installed otherwise=
 0\000config=3D4\000\00000\000\000 */
-{ 283 }, /* num_cores\000tool\000Number of cores. A core consists of 1 or =
more thread, with each thread being associated with a logical Linux CPU\000=
config=3D5\000\00000\000\000 */
-{ 425 }, /* num_cpus\000tool\000Number of logical Linux CPUs. There may be=
 multiple such CPUs on a core\000config=3D6\000\00000\000\000 */
-{ 525 }, /* num_cpus_online\000tool\000Number of online logical Linux CPUs=
. There may be multiple such CPUs on a core\000config=3D7\000\00000\000\000=
 */
-{ 639 }, /* num_dies\000tool\000Number of dies. Each die has 1 or more cor=
es\000config=3D8\000\00000\000\000 */
-{ 712 }, /* num_packages\000tool\000Number of packages. Each package has 1=
 or more die\000config=3D9\000\00000\000\000 */
-{ 795 }, /* slots\000tool\000Number of functional units that in parallel c=
an execute parts of an instruction\000config=3D0xa\000\00000\000\000 */
-{ 902 }, /* smt_on\000tool\0001 if simultaneous multithreading (aka hypert=
hreading) is enable otherwise 0\000config=3D0xb\000\00000\000\000 */
-{ 145 }, /* system_time\000tool\000System/kernel time in nanoseconds\000co=
nfig=3D3\000\00000\000\000 */
-{ 1006 }, /* system_tsc_freq\000tool\000The amount a Time Stamp Counter (T=
SC) increases per second\000config=3D0xc\000\00000\000\000 */
-{ 78 }, /* user_time\000tool\000User (non-kernel) time in nanoseconds\000c=
onfig=3D2\000\00000\000\000 */
+{ 5 }, /* duration_time\000tool\000Wall clock interval time in nanoseconds=
\000config=3D1\000\00000\000\000\000\000\000 */
+{ 219 }, /* has_pmem\000tool\0001 if persistent memory installed otherwise=
 0\000config=3D4\000\00000\000\000\000\000\000 */
+{ 295 }, /* num_cores\000tool\000Number of cores. A core consists of 1 or =
more thread, with each thread being associated with a logical Linux CPU\000=
config=3D5\000\00000\000\000\000\000\000 */
+{ 440 }, /* num_cpus\000tool\000Number of logical Linux CPUs. There may be=
 multiple such CPUs on a core\000config=3D6\000\00000\000\000\000\000\000 *=
/
+{ 543 }, /* num_cpus_online\000tool\000Number of online logical Linux CPUs=
. There may be multiple such CPUs on a core\000config=3D7\000\00000\000\000=
\000\000\000 */
+{ 660 }, /* num_dies\000tool\000Number of dies. Each die has 1 or more cor=
es\000config=3D8\000\00000\000\000\000\000\000 */
+{ 736 }, /* num_packages\000tool\000Number of packages. Each package has 1=
 or more die\000config=3D9\000\00000\000\000\000\000\000 */
+{ 822 }, /* slots\000tool\000Number of functional units that in parallel c=
an execute parts of an instruction\000config=3D0xa\000\00000\000\000\000\00=
0\000 */
+{ 932 }, /* smt_on\000tool\0001 if simultaneous multithreading (aka hypert=
hreading) is enable otherwise 0\000config=3D0xb\000\00000\000\000\000\000\0=
00 */
+{ 151 }, /* system_time\000tool\000System/kernel time in nanoseconds\000co=
nfig=3D3\000\00000\000\000\000\000\000 */
+{ 1039 }, /* system_tsc_freq\000tool\000The amount a Time Stamp Counter (T=
SC) increases per second\000config=3D0xc\000\00000\000\000\000\000\000 */
+{ 81 }, /* user_time\000tool\000User (non-kernel) time in nanoseconds\000c=
onfig=3D2\000\00000\000\000\000\000\000 */
=20
 };
=20
@@ -99,29 +99,29 @@ const struct pmu_table_entry pmu_events__common[] =3D {
 };
=20
 static const struct compact_pmu_event pmu_events__test_soc_cpu_default_cor=
e[] =3D {
-{ 1115 }, /* bp_l1_btb_correct\000branch\000L1 BTB Correction\000event=3D0=
x8a\000\00000\000\000 */
-{ 1174 }, /* bp_l2_btb_correct\000branch\000L2 BTB Correction\000event=3D0=
x8b\000\00000\000\000 */
-{ 1427 }, /* dispatch_blocked.any\000other\000Memory cluster signals to bl=
ock micro-op dispatch for any reason\000event=3D9,period=3D200000,umask=3D0=
x20\000\00000\000\000 */
-{ 1557 }, /* eist_trans\000other\000Number of Enhanced Intel SpeedStep(R) =
Technology (EIST) transitions\000event=3D0x3a,period=3D200000\000\00000\000=
\000 */
-{ 1233 }, /* l3_cache_rd\000cache\000L3 cache access, read\000event=3D0x40=
\000\00000\000Attributable Level 3 cache access, read\000 */
-{ 1328 }, /* segment_reg_loads.any\000other\000Number of segment register =
loads\000event=3D6,period=3D200000,umask=3D0x80\000\00000\000\000 */
+{ 1151 }, /* bp_l1_btb_correct\000branch\000L1 BTB Correction\000event=3D0=
x8a\000\00000\000\000\000\000\000 */
+{ 1213 }, /* bp_l2_btb_correct\000branch\000L2 BTB Correction\000event=3D0=
x8b\000\00000\000\000\000\000\000 */
+{ 1475 }, /* dispatch_blocked.any\000other\000Memory cluster signals to bl=
ock micro-op dispatch for any reason\000event=3D9,period=3D200000,umask=3D0=
x20\000\00000\000\000\000\000\000 */
+{ 1608 }, /* eist_trans\000other\000Number of Enhanced Intel SpeedStep(R) =
Technology (EIST) transitions\000event=3D0x3a,period=3D200000\000\00000\000=
\000\000\000\000 */
+{ 1275 }, /* l3_cache_rd\000cache\000L3 cache access, read\000event=3D0x40=
\000\00000\000\000\000\000Attributable Level 3 cache access, read\000 */
+{ 1373 }, /* segment_reg_loads.any\000other\000Number of segment register =
loads\000event=3D6,period=3D200000,umask=3D0x80\000\00000\000\000\000\000\0=
00 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_hisi_sccl_d=
drc[] =3D {
-{ 1687 }, /* uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write commands\0=
00event=3D2\000\00000\000DDRC write commands\000 */
+{ 1741 }, /* uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write commands\0=
00event=3D2\000\00000\000\000\000\000DDRC write commands\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_hisi_sccl_l=
3c[] =3D {
-{ 2166 }, /* uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total read hits\000=
event=3D7\000\00000\000Total read hits\000 */
+{ 2232 }, /* uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total read hits\000=
event=3D7\000\00000\000\000\000\000Total read hits\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_cbox=
[] =3D {
-{ 2016 }, /* event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=3D0xe0\000\=
00000\000UNC_CBO_HYPHEN\000 */
-{ 2081 }, /* event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=3D0xc0\=
000\00000\000UNC_CBO_TWO_HYPH\000 */
-{ 1785 }, /* unc_cbo_xsnp_response.miss_eviction\000uncore\000A cross-core=
 snoop resulted from L3 Eviction which misses in some processor core\000eve=
nt=3D0x22,umask=3D0x81\000\00000\000A cross-core snoop resulted from L3 Evi=
ction which misses in some processor core\000 */
+{ 2076 }, /* event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=3D0xe0\000\=
00000\000\000\000\000UNC_CBO_HYPHEN\000 */
+{ 2144 }, /* event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=3D0xc0\=
000\00000\000\000\000\000UNC_CBO_TWO_HYPH\000 */
+{ 1842 }, /* unc_cbo_xsnp_response.miss_eviction\000uncore\000A cross-core=
 snoop resulted from L3 Eviction which misses in some processor core\000eve=
nt=3D0x22,umask=3D0x81\000\00000\000\000\000\000A cross-core snoop resulted=
 from L3 Eviction which misses in some processor core\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_imc[=
] =3D {
-{ 2376 }, /* uncore_imc.cache_hits\000uncore\000Total cache hits\000event=
=3D0x34\000\00000\000Total cache hits\000 */
+{ 2448 }, /* uncore_imc.cache_hits\000uncore\000Total cache hits\000event=
=3D0x34\000\00000\000\000\000\000Total cache hits\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_imc_=
free_running[] =3D {
-{ 2270 }, /* uncore_imc_free_running.cache_miss\000uncore\000Total cache m=
isses\000event=3D0x12\000\00000\000Total cache misses\000 */
+{ 2339 }, /* uncore_imc_free_running.cache_miss\000uncore\000Total cache m=
isses\000event=3D0x12\000\00000\000\000\000\000Total cache misses\000 */
=20
 };
=20
@@ -129,51 +129,51 @@ const struct pmu_table_entry pmu_events__test_soc_cpu=
[] =3D {
 {
      .entries =3D pmu_events__test_soc_cpu_default_core,
      .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_default_core),
-     .pmu_name =3D { 1102 /* default_core\000 */ },
+     .pmu_name =3D { 1138 /* default_core\000 */ },
 },
 {
      .entries =3D pmu_events__test_soc_cpu_hisi_sccl_ddrc,
      .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_hisi_sccl_ddrc),
-     .pmu_name =3D { 1672 /* hisi_sccl,ddrc\000 */ },
+     .pmu_name =3D { 1726 /* hisi_sccl,ddrc\000 */ },
 },
 {
      .entries =3D pmu_events__test_soc_cpu_hisi_sccl_l3c,
      .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_hisi_sccl_l3c),
-     .pmu_name =3D { 2152 /* hisi_sccl,l3c\000 */ },
+     .pmu_name =3D { 2218 /* hisi_sccl,l3c\000 */ },
 },
 {
      .entries =3D pmu_events__test_soc_cpu_uncore_cbox,
      .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_cbox),
-     .pmu_name =3D { 1773 /* uncore_cbox\000 */ },
+     .pmu_name =3D { 1830 /* uncore_cbox\000 */ },
 },
 {
      .entries =3D pmu_events__test_soc_cpu_uncore_imc,
      .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_imc),
-     .pmu_name =3D { 2365 /* uncore_imc\000 */ },
+     .pmu_name =3D { 2437 /* uncore_imc\000 */ },
 },
 {
      .entries =3D pmu_events__test_soc_cpu_uncore_imc_free_running,
      .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_imc_free_=
running),
-     .pmu_name =3D { 2246 /* uncore_imc_free_running\000 */ },
+     .pmu_name =3D { 2315 /* uncore_imc_free_running\000 */ },
 },
 };
=20
 static const struct compact_pmu_event pmu_metrics__test_soc_cpu_default_co=
re[] =3D {
-{ 2798 }, /* CPI\000\0001 / IPC\000\000\000\000\000\000\000\00000 */
-{ 3479 }, /* DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Miss\=
000\000\000\000\000\000\000\00000 */
-{ 3251 }, /* DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_rq=
sts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\00000 */
-{ 3345 }, /* DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd - l=
2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\000\0=
00\000\000\000\000\000\00000 */
-{ 3543 }, /* DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2_A=
ll)\000\000\000\000\000\000\000\00000 */
-{ 3611 }, /* DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_L2=
_All)\000\000\000\000\000\000\000\00000 */
-{ 2883 }, /* Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 * =
(cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active / cp=
u_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\00000 */
-{ 2820 }, /* IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread\0=
00\000\000\000\000\000\000\00000 */
-{ 3745 }, /* L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / duratio=
n_time\000\000\000\000\000\000\000\00000 */
-{ 3681 }, /* M1\000\000ipc + M2\000\000\000\000\000\000\000\00000 */
-{ 3703 }, /* M2\000\000ipc + M1\000\000\000\000\000\000\000\00000 */
-{ 3725 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\00000 */
-{ 3180 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_miss_=
cycles\000\000\000\000\000\000\000\00000 */
-{ 3049 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.an=
y\000\000\000\000\000\000\000\00000 */
-{ 3113 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retired=
.any\000\000\000\000\000\000\000\00000 */
+{ 2882 }, /* CPI\000\0001 / IPC\000\000\000\000\000\000\000\00000 */
+{ 3563 }, /* DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Miss\=
000\000\000\000\000\000\000\00000 */
+{ 3335 }, /* DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_rq=
sts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\00000 */
+{ 3429 }, /* DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd - l=
2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\000\0=
00\000\000\000\000\000\00000 */
+{ 3627 }, /* DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2_A=
ll)\000\000\000\000\000\000\000\00000 */
+{ 3695 }, /* DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_L2=
_All)\000\000\000\000\000\000\000\00000 */
+{ 2967 }, /* Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 * =
(cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active / cp=
u_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\00000 */
+{ 2904 }, /* IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread\0=
00\000\000\000\000\000\000\00000 */
+{ 3829 }, /* L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / duratio=
n_time\000\000\000\000\000\000\000\00000 */
+{ 3765 }, /* M1\000\000ipc + M2\000\000\000\000\000\000\000\00000 */
+{ 3787 }, /* M2\000\000ipc + M1\000\000\000\000\000\000\000\00000 */
+{ 3809 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\00000 */
+{ 3264 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_miss_=
cycles\000\000\000\000\000\000\000\00000 */
+{ 3133 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.an=
y\000\000\000\000\000\000\000\00000 */
+{ 3197 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retired=
.any\000\000\000\000\000\000\000\00000 */
=20
 };
=20
@@ -181,18 +181,18 @@ const struct pmu_table_entry pmu_metrics__test_soc_cp=
u[] =3D {
 {
      .entries =3D pmu_metrics__test_soc_cpu_default_core,
      .num_entries =3D ARRAY_SIZE(pmu_metrics__test_soc_cpu_default_core),
-     .pmu_name =3D { 1102 /* default_core\000 */ },
+     .pmu_name =3D { 1138 /* default_core\000 */ },
 },
 };
=20
 static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sys_=
ccn_pmu[] =3D {
-{ 2565 }, /* sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles event\00=
0config=3D0x2c\0000x01\00000\000\000 */
+{ 2643 }, /* sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles event\00=
0config=3D0x2c\0000x01\00000\000\000\000\000\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sys_=
cmn_pmu[] =3D {
-{ 2658 }, /* sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total cache mi=
sses in first lookup result (high priority)\000eventid=3D1,type=3D5\000(434=
|436|43c|43a).*\00000\000\000 */
+{ 2739 }, /* sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total cache mi=
sses in first lookup result (high priority)\000eventid=3D1,type=3D5\000(434=
|436|43c|43a).*\00000\000\000\000\000\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sys_=
ddr_pmu[] =3D {
-{ 2473 }, /* sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycles event\=
000event=3D0x2b\000v8\00000\000\000 */
+{ 2548 }, /* sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycles event\=
000event=3D0x2b\000v8\00000\000\000\000\000\000 */
=20
 };
=20
@@ -200,17 +200,17 @@ const struct pmu_table_entry pmu_events__test_soc_sys=
[] =3D {
 {
      .entries =3D pmu_events__test_soc_sys_uncore_sys_ccn_pmu,
      .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_ccn_p=
mu),
-     .pmu_name =3D { 2546 /* uncore_sys_ccn_pmu\000 */ },
+     .pmu_name =3D { 2624 /* uncore_sys_ccn_pmu\000 */ },
 },
 {
      .entries =3D pmu_events__test_soc_sys_uncore_sys_cmn_pmu,
      .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_cmn_p=
mu),
-     .pmu_name =3D { 2639 /* uncore_sys_cmn_pmu\000 */ },
+     .pmu_name =3D { 2720 /* uncore_sys_cmn_pmu\000 */ },
 },
 {
      .entries =3D pmu_events__test_soc_sys_uncore_sys_ddr_pmu,
      .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_ddr_p=
mu),
-     .pmu_name =3D { 2454 /* uncore_sys_ddr_pmu\000 */ },
+     .pmu_name =3D { 2529 /* uncore_sys_ddr_pmu\000 */ },
 },
 };
=20
@@ -316,6 +316,12 @@ static void decompress_event(int offset, struct pmu_ev=
ent *pe)
 	p++;
 	pe->unit =3D (*p =3D=3D '\0' ? NULL : p);
 	while (*p++);
+	pe->retirement_latency_mean =3D (*p =3D=3D '\0' ? NULL : p);
+	while (*p++);
+	pe->retirement_latency_min =3D (*p =3D=3D '\0' ? NULL : p);
+	while (*p++);
+	pe->retirement_latency_max =3D (*p =3D=3D '\0' ? NULL : p);
+	while (*p++);
 	pe->long_desc =3D (*p =3D=3D '\0' ? NULL : p);
 }
=20
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jeven=
ts.py
index 7499a35bfadd..e3a55486c08e 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -47,6 +47,9 @@ _json_event_attributes =3D [
     'event',
     # Short things in alphabetical order.
     'compat', 'deprecated', 'perpkg', 'unit',
+    # Retirement latency specific to Intel granite rapids currently.
+    'retirement_latency_mean', 'retirement_latency_min',
+    'retirement_latency_max',
     # Longer things (the last won't be iterated over during decompress).
     'long_desc'
 ]
@@ -341,6 +344,9 @@ class JsonEvent:
     self.perpkg =3D jd.get('PerPkg')
     self.aggr_mode =3D convert_aggr_mode(jd.get('AggregationMode'))
     self.deprecated =3D jd.get('Deprecated')
+    self.retirement_latency_mean =3D jd.get('RetirementLatencyMean')
+    self.retirement_latency_min =3D jd.get('RetirementLatencyMin')
+    self.retirement_latency_max =3D jd.get('RetirementLatencyMax')
     self.metric_name =3D jd.get('MetricName')
     self.metric_group =3D jd.get('MetricGroup')
     self.metricgroup_no_group =3D jd.get('MetricgroupNoGroup')
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu=
-events.h
index 675562e6f770..a95fee561622 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -47,6 +47,9 @@ struct pmu_event {
 	const char *long_desc;
 	const char *pmu;
 	const char *unit;
+	const char *retirement_latency_mean;
+	const char *retirement_latency_min;
+	const char *retirement_latency_max;
 	bool perpkg;
 	bool deprecated;
 };
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index aae431d63d64..42dcadfef8ce 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -177,6 +177,12 @@ struct evsel {
 	/* For tool events */
 	/* Beginning time subtracted when the counter is read. */
 	union {
+		/* Defaults for retirement latency events. */
+		struct _retirement_latency {
+			double mean;
+			double min;
+			double max;
+		} retirement_latency;
 		/* duration_time is a single global time. */
 		__u64 start_time;
 		/*
diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index 6b00bd5b0af1..467d990d09ce 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -514,27 +514,49 @@ int evsel__tpebs_read(struct evsel *evsel, int cpu_ma=
p_idx, int thread)
 	 * process. Allow the sample reader a chance to read by releasing and
 	 * reacquiring the lock.
 	 */
-	if (&t->nd =3D=3D tpebs_results.next) {
+	if (t && &t->nd =3D=3D tpebs_results.next) {
 		ret =3D tpebs_send_record_cmd(EVLIST_CTL_CMD_PING_TAG);
 		mutex_unlock(tpebs_mtx_get());
 		if (ret)
 			return ret;
 		mutex_lock(tpebs_mtx_get());
 	}
-	switch (tpebs_mode) {
-	case TPEBS_MODE__MIN:
-		val =3D rint(t->stats.min);
-		break;
-	case TPEBS_MODE__MAX:
-		val =3D rint(t->stats.max);
-		break;
-	case TPEBS_MODE__LAST:
-		val =3D t->last;
-		break;
-	default:
-	case TPEBS_MODE__MEAN:
-		val =3D rint(t->stats.mean);
-		break;
+	if (t =3D=3D NULL || t->stats.n =3D=3D 0) {
+		/* No sample data, use default. */
+		if (tpebs_recording) {
+			pr_warning_once(
+				"Using precomputed retirement latency data as no samples\n");
+		}
+		val =3D 0;
+		switch (tpebs_mode) {
+		case TPEBS_MODE__MIN:
+			val =3D rint(evsel->retirement_latency.min);
+			break;
+		case TPEBS_MODE__MAX:
+			val =3D rint(evsel->retirement_latency.max);
+			break;
+		default:
+		case TPEBS_MODE__LAST:
+		case TPEBS_MODE__MEAN:
+			val =3D rint(evsel->retirement_latency.mean);
+			break;
+		}
+	} else {
+		switch (tpebs_mode) {
+		case TPEBS_MODE__MIN:
+			val =3D t->stats.min;
+			break;
+		case TPEBS_MODE__MAX:
+			val =3D t->stats.max;
+			break;
+		case TPEBS_MODE__LAST:
+			val =3D t->last;
+			break;
+		default:
+		case TPEBS_MODE__MEAN:
+			val =3D rint(t->stats.mean);
+			break;
+		}
 	}
 	mutex_unlock(tpebs_mtx_get());
=20
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.=
c
index 5152fd5a6ead..89708d1769c8 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1539,6 +1539,10 @@ static int parse_events_add_pmu(struct parse_events_=
state *parse_state,
 	evsel->scale =3D info.scale;
 	evsel->per_pkg =3D info.per_pkg;
 	evsel->snapshot =3D info.snapshot;
+	evsel->retirement_latency.mean =3D info.retirement_latency_mean;
+	evsel->retirement_latency.min =3D info.retirement_latency_min;
+	evsel->retirement_latency.max =3D info.retirement_latency_max;
+
 	return 0;
 }
=20
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index b7ebac5ab1d1..bbb906bb2159 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -77,6 +77,12 @@ struct perf_pmu_alias {
 	char unit[UNIT_MAX_LEN+1];
 	/** @scale: Value to scale read counter values by. */
 	double scale;
+	/** @retirement_latency_mean: Value to be given for unsampled retirement =
latency mean. */
+	double retirement_latency_mean;
+	/** @retirement_latency_min: Value to be given for unsampled retirement l=
atency min. */
+	double retirement_latency_min;
+	/** @retirement_latency_max: Value to be given for unsampled retirement l=
atency max. */
+	double retirement_latency_max;
 	/**
 	 * @per_pkg: Does the file
 	 * <sysfs>/bus/event_source/devices/<pmu_name>/events/<name>.per-pkg or
@@ -257,7 +263,7 @@ static int pmu_format(struct perf_pmu *pmu, int dirfd, =
const char *name, bool ea
 	return 0;
 }
=20
-int perf_pmu__convert_scale(const char *scale, char **end, double *sval)
+static int parse_double(const char *scale, char **end, double *sval)
 {
 	char *lc;
 	int ret =3D 0;
@@ -294,6 +300,11 @@ int perf_pmu__convert_scale(const char *scale, char **=
end, double *sval)
 	return ret;
 }
=20
+int perf_pmu__convert_scale(const char *scale, char **end, double *sval)
+{
+	return parse_double(scale, end, sval);
+}
+
 static int perf_pmu__parse_scale(struct perf_pmu *pmu, struct perf_pmu_ali=
as *alias)
 {
 	struct stat st;
@@ -525,6 +536,18 @@ static int update_alias(const struct pmu_event *pe,
 		if (!ret)
 			snprintf(data->alias->unit, sizeof(data->alias->unit), "%s", unit);
 	}
+	if (!ret && pe->retirement_latency_mean) {
+		ret =3D parse_double(pe->retirement_latency_mean, NULL,
+					      &data->alias->retirement_latency_mean);
+	}
+	if (!ret && pe->retirement_latency_min) {
+		ret =3D parse_double(pe->retirement_latency_min, NULL,
+					      &data->alias->retirement_latency_min);
+	}
+	if (!ret && pe->retirement_latency_max) {
+		ret =3D parse_double(pe->retirement_latency_max, NULL,
+					      &data->alias->retirement_latency_max);
+	}
 	return ret;
 }
=20
@@ -533,7 +556,7 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, co=
nst char *name,
 			        const struct pmu_event *pe, enum event_source src)
 {
 	struct perf_pmu_alias *alias;
-	int ret;
+	int ret =3D 0;
 	const char *long_desc =3D NULL, *topic =3D NULL, *unit =3D NULL, *pmu_nam=
e =3D NULL;
 	bool deprecated =3D false, perpkg =3D false;
=20
@@ -562,6 +585,24 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, c=
onst char *name,
 	alias->per_pkg =3D perpkg;
 	alias->snapshot =3D false;
 	alias->deprecated =3D deprecated;
+	alias->retirement_latency_mean =3D 0.0;
+	alias->retirement_latency_min =3D 0.0;
+	alias->retirement_latency_max =3D 0.0;
+
+	if (!ret && pe && pe->retirement_latency_mean) {
+		ret =3D parse_double(pe->retirement_latency_mean, NULL,
+				   &alias->retirement_latency_mean);
+	}
+	if (!ret && pe && pe->retirement_latency_min) {
+		ret =3D parse_double(pe->retirement_latency_min, NULL,
+				   &alias->retirement_latency_min);
+	}
+	if (!ret && pe && pe->retirement_latency_max) {
+		ret =3D parse_double(pe->retirement_latency_max, NULL,
+				   &alias->retirement_latency_max);
+	}
+	if (ret)
+		return ret;
=20
 	ret =3D parse_events_terms(&alias->terms, val, val_fd);
 	if (ret) {
@@ -1678,6 +1719,9 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struc=
t parse_events_terms *head_
 	info->unit     =3D NULL;
 	info->scale    =3D 0.0;
 	info->snapshot =3D false;
+	info->retirement_latency_mean =3D 0.0;
+	info->retirement_latency_min =3D 0.0;
+	info->retirement_latency_max =3D 0.0;
=20
 	if (perf_pmu__is_hwmon(pmu)) {
 		ret =3D hwmon_pmu__check_alias(head_terms, info, err);
@@ -1711,6 +1755,10 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, stru=
ct parse_events_terms *head_
 		if (term->alternate_hw_config)
 			*alternate_hw_config =3D term->val.num;
=20
+		info->retirement_latency_mean =3D alias->retirement_latency_mean;
+		info->retirement_latency_min =3D alias->retirement_latency_min;
+		info->retirement_latency_max =3D alias->retirement_latency_max;
+
 		list_del_init(&term->list);
 		parse_events_term__delete(term);
 	}
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index b93014cc3670..13dd3511f504 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -194,6 +194,9 @@ struct perf_pmu {
 struct perf_pmu_info {
 	const char *unit;
 	double scale;
+	double retirement_latency_mean;
+	double retirement_latency_min;
+	double retirement_latency_max;
 	bool per_pkg;
 	bool snapshot;
 };
--=20
2.49.0.504.g3bcea36a83-goog

