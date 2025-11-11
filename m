Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E4632695D
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 21:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762896150; cv=none; b=XIwPh3JjgypT4v507Wf211vA9SZG0M6QxIqTXfFfinNnfnuRork+rCb+BqeMt48t3jWMRJ84KVUSC1Je52GfQ7x73TW2rdK7cCRIy3di/6rQF1btwiwl2cPt2ShchwbOt6GXHy4b2uwhLvV5eXQt+6eigIJJx6Hea48LR3s8meM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762896150; c=relaxed/simple;
	bh=sjOtu+U7NKstW5zT4oN/9hBFS+nPGQ07DD2yHYs0HGY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=M4/mZnbTDa6OLh4P8BuRnCe2j1IqEUhud4J0IyfkrmNu89D27s0ts/iH1oC/ox8VrU9cZ/g5ALp2gyIt3OSxT886364lbbvEuvd7J8DVTLb+Mvil75XOtvbCFmDanWyzfM7tOZ3YOtcKBX3W90pFzVQrzxwY9VxPp5q4+aXfg2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=grEYWq3g; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="grEYWq3g"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2956f09f382so647245ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 13:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762896148; x=1763500948; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1tdVHqWz9ziKHDUGfJq3b8gItWYm7hePLYAw8kx7dB4=;
        b=grEYWq3gcJisVUrIsyPWq4Su2sOfp4BY/qzsA+8OU+Xmu4Df9G71uKnpstmrygL3H9
         apPwPjiHiwdY4NkmBReByW3VfISZW1cDhVn+Ip+n2EzsUhsxDoPOi0yVo8YUAKF0ZXE7
         sB55sVkqHBAXce/GKwkFG6N6wUMXUWNCtx4wA6Puf6kiXgnRwdx7IMYmorblcPDXhlve
         bIOWbFPA+ED2htESLbb5CECkDtSD27FRUp6i9BAb2MALZbQ4R28ToFfXZ/F8pXauwH1B
         XZDTO/TiCaquVZKJh1phm0ZgiP0VUTxYd844y1yHqFQr9cDC8W9a88itArvEcg2Jm9A/
         lP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762896148; x=1763500948;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1tdVHqWz9ziKHDUGfJq3b8gItWYm7hePLYAw8kx7dB4=;
        b=Nhmbl4vujYir0OJxOKu+f/AEV0Eenr+MOT5flSDGMxU/xPwu5BF33Xa7u/Uoy65315
         F2dzWXzk4n/c7Er6Gw63md9jo7DFHlnx6TiN8bVUSJOzlRN+Qg+9UFE8YqpkL00fcwF4
         PGMfVbOJeApAtuxJJ8WK17x6/HilKbKLichozYh4QJ1IIIDiqfLAk477dPj6cxqQBCze
         4GCXc9H8Hn9i2l/mVmgdCYEOTrKqCXklw99axaHyvuN5kT7Yj/n/PmvoUzEFRcMkuZvH
         fKLk2Iv7yQ2L9lmF3r+VbqryXNuqYbmNcjqsxftBlHAPzUEKt8YoBfx8NJg9rkct1IYV
         1ApQ==
X-Forwarded-Encrypted: i=1; AJvYcCWx+T6i6m1TdI/P731ORd2nFRTcgI+1KfU/8UxG+aBjD2qrq2o645LleqaK1hoBekUwHjvgh3i/PAqYe+pxr0gZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwLvictQeXP6SWs++dmH2FL1C2pG3JZ0xi975hb8aD68ptEuEGs
	uFOZMJgyDbiEbsAnMFlf7AdvdWXb3fCyW5ylBc4DKp0dOumjp1vLa0VjXY/rHLAGZ/vho4Zz1jR
	yGztkmgRjrA==
X-Google-Smtp-Source: AGHT+IEgHd6IcFCvNNQyVKbtw6X8pS139pfpwhEjxMCKxAxIWZMo/DXR3nt0RWmC+EX51kYB3TI0amFhRZh9
X-Received: from dlbur6-n2.prod.google.com ([2002:a05:7022:ea46:20b0:119:78ff:fe15])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e5ce:b0:297:eafd:5c19
 with SMTP id d9443c01a7336-298407daf8fmr56121315ad.10.1762896147653; Tue, 11
 Nov 2025 13:22:27 -0800 (PST)
Date: Tue, 11 Nov 2025 13:21:53 -0800
In-Reply-To: <20251111212206.631711-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111212206.631711-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251111212206.631711-6-irogers@google.com>
Subject: [PATCH v4 05/18] perf stat: Add detail -d,-dd,-ddd metrics
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

Add metrics for the stat-shadow -d, -dd and -ddd events and hard coded
metrics. Remove the events as these now come from the metrics.

Following this change a detailed perf stat output looks like:
```
$ perf stat -a -ddd -- sleep 1
 Performance counter stats for 'system wide':

            21,089      context-switches                 #      nan cs/sec =
 cs_per_second
             TopdownL1 (cpu_core)                 #     14.1 %  tma_bad_spe=
culation
                                                  #     27.3 %  tma_fronten=
d_bound       (30.56%)
             TopdownL1 (cpu_core)                 #     31.5 %  tma_backend=
_bound
                                                  #     27.2 %  tma_retirin=
g             (30.56%)
             6,302      page-faults                      #      nan faults/=
sec  page_faults_per_second
       928,495,163      cpu_atom/cpu-cycles/
                                                  #      nan GHz  cycles_fr=
equency       (28.41%)
     1,841,409,834      cpu_core/cpu-cycles/
                                                  #      nan GHz  cycles_fr=
equency       (38.51%)
                                                  #     14.5 %  tma_bad_spe=
culation
                                                  #     16.0 %  tma_retirin=
g             (28.41%)
                                                  #     36.8 %  tma_fronten=
d_bound       (35.57%)
       100,859,118      cpu_atom/branches/               #      nan M/sec  =
branch_frequency     (42.73%)
       572,657,734      cpu_core/branches/               #      nan M/sec  =
branch_frequency     (54.43%)
             1,527      cpu-migrations                   #      nan migrati=
ons/sec  migrations_per_second
                                                  #     32.7 %  tma_backend=
_bound        (42.73%)
              0.00 msec cpu-clock                        #    0.000 CPUs ut=
ilized
                                                  #      0.0 CPUs  CPUs_uti=
lized
       498,668,509      cpu_atom/instructions/           #    0.57  insn pe=
r cycle
                                                  #      0.6 instructions  =
insn_per_cycle  (42.97%)
     3,281,762,225      cpu_core/instructions/           #    1.84  insn pe=
r cycle
                                                  #      1.8 instructions  =
insn_per_cycle  (62.20%)
         4,919,511      cpu_atom/branch-misses/          #    5.43% of all =
branches
                                                  #      5.4 %  branch_miss=
_rate         (35.80%)
         7,431,776      cpu_core/branch-misses/          #    1.39% of all =
branches
                                                  #      1.4 %  branch_miss=
_rate         (62.20%)
         2,517,007      cpu_atom/LLC-loads/              #      0.1 %  llc_=
miss_rate            (28.62%)
         3,931,318      cpu_core/LLC-loads/              #     40.4 %  llc_=
miss_rate            (45.98%)
        14,918,674      cpu_core/L1-dcache-load-misses/  #    2.25% of all =
L1-dcache accesses
                                                  #      nan %  l1d_miss_ra=
te            (37.80%)
        27,067,264      cpu_atom/L1-icache-load-misses/  #   15.92% of all =
L1-icache accesses
                                                  #     15.9 %  l1i_miss_ra=
te            (21.47%)
       116,848,994      cpu_atom/dTLB-loads/             #      0.8 %  dtlb=
_miss_rate           (21.47%)
       764,870,407      cpu_core/dTLB-loads/             #      0.1 %  dtlb=
_miss_rate           (15.12%)

       1.006181526 seconds time elapsed
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c                     | 100 +++---------------
 .../arch/common/common/metrics.json           |  54 ++++++++++
 tools/perf/pmu-events/empty-pmu-events.c      |  72 +++++++------
 3 files changed, 113 insertions(+), 113 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 31c762695d4b..7862094b93c8 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1857,28 +1857,6 @@ static int perf_stat_init_aggr_mode_file(struct perf=
_stat *st)
 	return 0;
 }
=20
-/* Add legacy hardware/hardware-cache event to evlist for all core PMUs wi=
thout wildcarding. */
-static int parse_hardware_event(struct evlist *evlist, const char *event,
-				struct parse_events_error *err)
-{
-	char buf[256];
-	struct perf_pmu *pmu =3D NULL;
-
-	while ((pmu =3D perf_pmus__scan_core(pmu)) !=3D NULL) {
-		int ret;
-
-		if (perf_pmus__num_core_pmus() =3D=3D 1)
-			snprintf(buf, sizeof(buf), "%s/%s,name=3D%s/", pmu->name, event, event)=
;
-		else
-			snprintf(buf, sizeof(buf), "%s/%s/", pmu->name, event);
-
-		ret =3D parse_events(evlist, buf, err);
-		if (ret)
-			return ret;
-	}
-	return 0;
-}
-
 /*
  * Add default events, if there were no attributes specified or
  * if -d/--detailed, -d -d or -d -d -d is used:
@@ -2006,22 +1984,34 @@ static int add_default_events(void)
 		 * threshold computation, but it will be computed if the events
 		 * are present.
 		 */
-		if (metricgroup__has_metric_or_groups(pmu, "Default")) {
-			struct evlist *metric_evlist =3D evlist__new();
+		const char *default_metricgroup_names[] =3D {
+			"Default", "Default2", "Default3", "Default4",
+		};
+
+		for (size_t i =3D 0; i < ARRAY_SIZE(default_metricgroup_names); i++) {
+			struct evlist *metric_evlist;
+
+			if (!metricgroup__has_metric_or_groups(pmu, default_metricgroup_names[i=
]))
+				continue;
+
+			if ((int)i > detailed_run)
+				break;
=20
+			metric_evlist =3D evlist__new();
 			if (!metric_evlist) {
 				ret =3D -ENOMEM;
-				goto out;
+				break;
 			}
-			if (metricgroup__parse_groups(metric_evlist, pmu, "Default",
+			if (metricgroup__parse_groups(metric_evlist, pmu, default_metricgroup_n=
ames[i],
 							/*metric_no_group=3D*/false,
 							/*metric_no_merge=3D*/false,
 							/*metric_no_threshold=3D*/true,
 							stat_config.user_requested_cpu_list,
 							stat_config.system_wide,
 							stat_config.hardware_aware_grouping) < 0) {
+				evlist__delete(metric_evlist);
 				ret =3D -1;
-				goto out;
+				break;
 			}
=20
 			evlist__for_each_entry(metric_evlist, evsel)
@@ -2034,62 +2024,6 @@ static int add_default_events(void)
 			evlist__delete(metric_evlist);
 		}
 	}
-
-	/* Detailed events get appended to the event list: */
-
-	if (!ret && detailed_run >=3D  1) {
-		/*
-		 * Detailed stats (-d), covering the L1 and last level data
-		 * caches:
-		 */
-		const char *hw_events[] =3D {
-			"L1-dcache-loads",
-			"L1-dcache-load-misses",
-			"LLC-loads",
-			"LLC-load-misses",
-		};
-
-		for (size_t i =3D 0; i < ARRAY_SIZE(hw_events); i++) {
-			ret =3D parse_hardware_event(evlist, hw_events[i], &err);
-			if (ret)
-				goto out;
-		}
-	}
-	if (!ret && detailed_run >=3D  2) {
-		/*
-		 * Very detailed stats (-d -d), covering the instruction cache
-		 * and the TLB caches:
-		 */
-		const char *hw_events[] =3D {
-			"L1-icache-loads",
-			"L1-icache-load-misses",
-			"dTLB-loads",
-			"dTLB-load-misses",
-			"iTLB-loads",
-			"iTLB-load-misses",
-		};
-
-		for (size_t i =3D 0; i < ARRAY_SIZE(hw_events); i++) {
-			ret =3D parse_hardware_event(evlist, hw_events[i], &err);
-			if (ret)
-				goto out;
-		}
-	}
-	if (!ret && detailed_run >=3D  3) {
-		/*
-		 * Very, very detailed stats (-d -d -d), adding prefetch events:
-		 */
-		const char *hw_events[] =3D {
-			"L1-dcache-prefetches",
-			"L1-dcache-prefetch-misses",
-		};
-
-		for (size_t i =3D 0; i < ARRAY_SIZE(hw_events); i++) {
-			ret =3D parse_hardware_event(evlist, hw_events[i], &err);
-			if (ret)
-				goto out;
-		}
-	}
 out:
 	if (!ret) {
 		evlist__for_each_entry(evlist, evsel) {
diff --git a/tools/perf/pmu-events/arch/common/common/metrics.json b/tools/=
perf/pmu-events/arch/common/common/metrics.json
index d6ea967a4045..0d010b3ebc6d 100644
--- a/tools/perf/pmu-events/arch/common/common/metrics.json
+++ b/tools/perf/pmu-events/arch/common/common/metrics.json
@@ -93,5 +93,59 @@
         "MetricThreshold": "branch_miss_rate > 0.05",
         "ScaleUnit": "100%",
         "DefaultShowEvents": "1"
+    },
+    {
+        "BriefDescription": "L1D  miss rate",
+        "MetricExpr": "L1\\-dcache\\-load\\-misses / L1\\-dcache\\-loads",
+        "MetricGroup": "Default2",
+        "MetricName": "l1d_miss_rate",
+        "MetricThreshold": "l1d_miss_rate > 0.05",
+        "ScaleUnit": "100%",
+        "DefaultShowEvents": "1"
+    },
+    {
+        "BriefDescription": "LLC miss rate",
+        "MetricExpr": "LLC\\-load\\-misses / LLC\\-loads",
+        "MetricGroup": "Default2",
+        "MetricName": "llc_miss_rate",
+        "MetricThreshold": "llc_miss_rate > 0.05",
+        "ScaleUnit": "100%",
+        "DefaultShowEvents": "1"
+    },
+    {
+        "BriefDescription": "L1I miss rate",
+        "MetricExpr": "L1\\-icache\\-load\\-misses / L1\\-icache\\-loads",
+        "MetricGroup": "Default3",
+        "MetricName": "l1i_miss_rate",
+        "MetricThreshold": "l1i_miss_rate > 0.05",
+        "ScaleUnit": "100%",
+        "DefaultShowEvents": "1"
+    },
+    {
+        "BriefDescription": "dTLB miss rate",
+        "MetricExpr": "dTLB\\-load\\-misses / dTLB\\-loads",
+        "MetricGroup": "Default3",
+        "MetricName": "dtlb_miss_rate",
+        "MetricThreshold": "dtlb_miss_rate > 0.05",
+        "ScaleUnit": "100%",
+        "DefaultShowEvents": "1"
+    },
+    {
+        "BriefDescription": "iTLB miss rate",
+        "MetricExpr": "iTLB\\-load\\-misses / iTLB\\-loads",
+        "MetricGroup": "Default3",
+        "MetricName": "itlb_miss_rate",
+        "MetricThreshold": "itlb_miss_rate > 0.05",
+        "ScaleUnit": "100%",
+        "DefaultShowEvents": "1"
+    },
+    {
+        "BriefDescription": "L1 prefetch miss rate",
+        "MetricExpr": "L1\\-dcache\\-prefetch\\-misses / L1\\-dcache\\-pre=
fetches",
+        "MetricGroup": "Default4",
+        "MetricName": "l1_prefetch_miss_rate",
+        "MetricThreshold": "l1_prefetch_miss_rate > 0.05",
+        "ScaleUnit": "100%",
+        "DefaultShowEvents": "1"
     }
 ]
diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-even=
ts/empty-pmu-events.c
index 333a44930910..7fa42f13300f 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -1314,21 +1314,27 @@ static const char *const big_c_string =3D
 /* offset=3D129201 */ "cycles_frequency\000Default\000cpu\\-cycles / (soft=
ware@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\=
\-clock\\,name\\=3Dtask\\-clock@)\000\000Cycles per CPU second\000\0001GHz\=
000\000\000\000011"
 /* offset=3D129377 */ "branch_frequency\000Default\000branches / (software=
@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-cl=
ock\\,name\\=3Dtask\\-clock@)\000\000Branches per CPU second\000\0001000M/s=
ec\000\000\000\000011"
 /* offset=3D129557 */ "branch_miss_rate\000Default\000branch\\-misses / br=
anches\000branch_miss_rate > 0.05\000Branch miss rate\000\000100%\000\000\0=
00\000001"
-/* offset=3D129661 */ "CPI\000\0001 / IPC\000\000\000\000\000\000\000\0000=
00"
-/* offset=3D129684 */ "IPC\000group1\000inst_retired.any / cpu_clk_unhalte=
d.thread\000\000\000\000\000\000\000\000000"
-/* offset=3D129748 */ "Frontend_Bound_SMT\000\000idq_uops_not_delivered.co=
re / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_a=
ctive / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\000000"
-/* offset=3D129915 */ "dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_=
retired.any\000\000\000\000\000\000\000\000000"
-/* offset=3D129980 */ "icache_miss_cycles\000\000l1i\\-loads\\-misses / in=
st_retired.any\000\000\000\000\000\000\000\000000"
-/* offset=3D130048 */ "cache_miss_cycles\000group1\000dcache_miss_cpi + ic=
ache_miss_cycles\000\000\000\000\000\000\000\000000"
-/* offset=3D130120 */ "DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_h=
it + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\000000"
-/* offset=3D130215 */ "DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_d=
ata_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_=
miss\000\000\000\000\000\000\000\000000"
-/* offset=3D130350 */ "DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2=
_All_Miss\000\000\000\000\000\000\000\000000"
-/* offset=3D130415 */ "DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, D=
Cache_L2_All)\000\000\000\000\000\000\000\000000"
-/* offset=3D130484 */ "DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss,=
 DCache_L2_All)\000\000\000\000\000\000\000\000000"
-/* offset=3D130555 */ "M1\000\000ipc + M2\000\000\000\000\000\000\000\0000=
00"
-/* offset=3D130578 */ "M2\000\000ipc + M1\000\000\000\000\000\000\000\0000=
00"
-/* offset=3D130601 */ "M3\000\0001 / M3\000\000\000\000\000\000\000\000000=
"
-/* offset=3D130622 */ "L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9=
 / duration_time\000\000\000\000\000\000\000\000000"
+/* offset=3D129661 */ "l1d_miss_rate\000Default2\000L1\\-dcache\\-load\\-m=
isses / L1\\-dcache\\-loads\000l1d_miss_rate > 0.05\000L1D  miss rate\000\0=
00100%\000\000\000\000001"
+/* offset=3D129777 */ "llc_miss_rate\000Default2\000LLC\\-load\\-misses / =
LLC\\-loads\000llc_miss_rate > 0.05\000LLC miss rate\000\000100%\000\000\00=
0\000001"
+/* offset=3D129878 */ "l1i_miss_rate\000Default3\000L1\\-icache\\-load\\-m=
isses / L1\\-icache\\-loads\000l1i_miss_rate > 0.05\000L1I miss rate\000\00=
0100%\000\000\000\000001"
+/* offset=3D129993 */ "dtlb_miss_rate\000Default3\000dTLB\\-load\\-misses =
/ dTLB\\-loads\000dtlb_miss_rate > 0.05\000dTLB miss rate\000\000100%\000\0=
00\000\000001"
+/* offset=3D130099 */ "itlb_miss_rate\000Default3\000iTLB\\-load\\-misses =
/ iTLB\\-loads\000itlb_miss_rate > 0.05\000iTLB miss rate\000\000100%\000\0=
00\000\000001"
+/* offset=3D130205 */ "l1_prefetch_miss_rate\000Default4\000L1\\-dcache\\-=
prefetch\\-misses / L1\\-dcache\\-prefetches\000l1_prefetch_miss_rate > 0.0=
5\000L1 prefetch miss rate\000\000100%\000\000\000\000001"
+/* offset=3D130353 */ "CPI\000\0001 / IPC\000\000\000\000\000\000\000\0000=
00"
+/* offset=3D130376 */ "IPC\000group1\000inst_retired.any / cpu_clk_unhalte=
d.thread\000\000\000\000\000\000\000\000000"
+/* offset=3D130440 */ "Frontend_Bound_SMT\000\000idq_uops_not_delivered.co=
re / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_a=
ctive / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\000000"
+/* offset=3D130607 */ "dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_=
retired.any\000\000\000\000\000\000\000\000000"
+/* offset=3D130672 */ "icache_miss_cycles\000\000l1i\\-loads\\-misses / in=
st_retired.any\000\000\000\000\000\000\000\000000"
+/* offset=3D130740 */ "cache_miss_cycles\000group1\000dcache_miss_cpi + ic=
ache_miss_cycles\000\000\000\000\000\000\000\000000"
+/* offset=3D130812 */ "DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_h=
it + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\000000"
+/* offset=3D130907 */ "DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_d=
ata_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_=
miss\000\000\000\000\000\000\000\000000"
+/* offset=3D131042 */ "DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2=
_All_Miss\000\000\000\000\000\000\000\000000"
+/* offset=3D131107 */ "DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, D=
Cache_L2_All)\000\000\000\000\000\000\000\000000"
+/* offset=3D131176 */ "DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss,=
 DCache_L2_All)\000\000\000\000\000\000\000\000000"
+/* offset=3D131247 */ "M1\000\000ipc + M2\000\000\000\000\000\000\000\0000=
00"
+/* offset=3D131270 */ "M2\000\000ipc + M1\000\000\000\000\000\000\000\0000=
00"
+/* offset=3D131293 */ "M3\000\0001 / M3\000\000\000\000\000\000\000\000000=
"
+/* offset=3D131314 */ "L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9=
 / duration_time\000\000\000\000\000\000\000\000000"
 ;
=20
 static const struct compact_pmu_event pmu_events__common_default_core[] =
=3D {
@@ -2621,8 +2627,14 @@ static const struct compact_pmu_event pmu_metrics__c=
ommon_default_core[] =3D {
 { 129557 }, /* branch_miss_rate\000Default\000branch\\-misses / branches\0=
00branch_miss_rate > 0.05\000Branch miss rate\000\000100%\000\000\000\00000=
1 */
 { 127944 }, /* cs_per_second\000Default\000software@context\\-switches\\,n=
ame\\=3Dcontext\\-switches@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-=
clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\=
000\000Context switches per CPU second\000\0001cs/sec\000\000\000\000011 */
 { 129201 }, /* cycles_frequency\000Default\000cpu\\-cycles / (software@cpu=
\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\=
\,name\\=3Dtask\\-clock@)\000\000Cycles per CPU second\000\0001GHz\000\000\=
000\000011 */
+{ 129993 }, /* dtlb_miss_rate\000Default3\000dTLB\\-load\\-misses / dTLB\\=
-loads\000dtlb_miss_rate > 0.05\000dTLB miss rate\000\000100%\000\000\000\0=
00001 */
 { 128945 }, /* frontend_cycles_idle\000Default\000stalled\\-cycles\\-front=
end / cpu\\-cycles\000frontend_cycles_idle > 0.1\000Frontend stalls per cyc=
le\000\000\000\000\000\000001 */
 { 128668 }, /* insn_per_cycle\000Default\000instructions / cpu\\-cycles\00=
0insn_per_cycle < 1\000Instructions Per Cycle\000\0001instructions\000\000\=
000\000001 */
+{ 130099 }, /* itlb_miss_rate\000Default3\000iTLB\\-load\\-misses / iTLB\\=
-loads\000itlb_miss_rate > 0.05\000iTLB miss rate\000\000100%\000\000\000\0=
00001 */
+{ 130205 }, /* l1_prefetch_miss_rate\000Default4\000L1\\-dcache\\-prefetch=
\\-misses / L1\\-dcache\\-prefetches\000l1_prefetch_miss_rate > 0.05\000L1 =
prefetch miss rate\000\000100%\000\000\000\000001 */
+{ 129661 }, /* l1d_miss_rate\000Default2\000L1\\-dcache\\-load\\-misses / =
L1\\-dcache\\-loads\000l1d_miss_rate > 0.05\000L1D  miss rate\000\000100%\0=
00\000\000\000001 */
+{ 129878 }, /* l1i_miss_rate\000Default3\000L1\\-icache\\-load\\-misses / =
L1\\-icache\\-loads\000l1i_miss_rate > 0.05\000L1I miss rate\000\000100%\00=
0\000\000\000001 */
+{ 129777 }, /* llc_miss_rate\000Default2\000LLC\\-load\\-misses / LLC\\-lo=
ads\000llc_miss_rate > 0.05\000LLC miss rate\000\000100%\000\000\000\000001=
 */
 { 128177 }, /* migrations_per_second\000Default\000software@cpu\\-migratio=
ns\\,name\\=3Dcpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcp=
u\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-cloc=
k@)\000\000Process migrations to a new CPU per CPU second\000\0001migration=
s/sec\000\000\000\000011 */
 { 128437 }, /* page_faults_per_second\000Default\000software@page\\-faults=
\\,name\\=3Dpage\\-faults@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-c=
lock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\0=
00\000Page faults per CPU second\000\0001faults/sec\000\000\000\000011 */
 { 128781 }, /* stalled_cycles_per_instruction\000Default\000max(stalled\\-=
cycles\\-frontend, stalled\\-cycles\\-backend) / instructions\000\000Max fr=
ont or backend stalls per instruction\000\000\000\000\000\000001 */
@@ -2698,21 +2710,21 @@ static const struct pmu_table_entry pmu_events__tes=
t_soc_cpu[] =3D {
 };
=20
 static const struct compact_pmu_event pmu_metrics__test_soc_cpu_default_co=
re[] =3D {
-{ 129661 }, /* CPI\000\0001 / IPC\000\000\000\000\000\000\000\000000 */
-{ 130350 }, /* DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Mis=
s\000\000\000\000\000\000\000\000000 */
-{ 130120 }, /* DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_=
rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\000000 */
-{ 130215 }, /* DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd -=
 l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\000=
\000\000\000\000\000\000\000000 */
-{ 130415 }, /* DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2=
_All)\000\000\000\000\000\000\000\000000 */
-{ 130484 }, /* DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_=
L2_All)\000\000\000\000\000\000\000\000000 */
-{ 129748 }, /* Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 =
* (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active / =
cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\000000 */
-{ 129684 }, /* IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread=
\000\000\000\000\000\000\000\000000 */
-{ 130622 }, /* L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / durat=
ion_time\000\000\000\000\000\000\000\000000 */
-{ 130555 }, /* M1\000\000ipc + M2\000\000\000\000\000\000\000\000000 */
-{ 130578 }, /* M2\000\000ipc + M1\000\000\000\000\000\000\000\000000 */
-{ 130601 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\000000 */
-{ 130048 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_mis=
s_cycles\000\000\000\000\000\000\000\000000 */
-{ 129915 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.=
any\000\000\000\000\000\000\000\000000 */
-{ 129980 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retir=
ed.any\000\000\000\000\000\000\000\000000 */
+{ 130353 }, /* CPI\000\0001 / IPC\000\000\000\000\000\000\000\000000 */
+{ 131042 }, /* DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Mis=
s\000\000\000\000\000\000\000\000000 */
+{ 130812 }, /* DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_=
rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\000000 */
+{ 130907 }, /* DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd -=
 l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\000=
\000\000\000\000\000\000\000000 */
+{ 131107 }, /* DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2=
_All)\000\000\000\000\000\000\000\000000 */
+{ 131176 }, /* DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_=
L2_All)\000\000\000\000\000\000\000\000000 */
+{ 130440 }, /* Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 =
* (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active / =
cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\000000 */
+{ 130376 }, /* IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread=
\000\000\000\000\000\000\000\000000 */
+{ 131314 }, /* L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / durat=
ion_time\000\000\000\000\000\000\000\000000 */
+{ 131247 }, /* M1\000\000ipc + M2\000\000\000\000\000\000\000\000000 */
+{ 131270 }, /* M2\000\000ipc + M1\000\000\000\000\000\000\000\000000 */
+{ 131293 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\000000 */
+{ 130740 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_mis=
s_cycles\000\000\000\000\000\000\000\000000 */
+{ 130607 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.=
any\000\000\000\000\000\000\000\000000 */
+{ 130672 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retir=
ed.any\000\000\000\000\000\000\000\000000 */
=20
 };
=20
--=20
2.51.2.1041.gc1ab5b90ca-goog

