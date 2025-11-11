Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAF134A775
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 04:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762833878; cv=none; b=QjmeVXVSkrPYpP0Ee6Hs8PQQ8fDHq3ZVB3QlHu6u4/bRnyvTnp8+bkQMnzZatHKeBW5Ffc+Trc3daiTp/XFn5aXi0P2uJQ7euUZzvjaKbLBqusYR6aC3nMqEqgAuRZiOjlRh7HRheqmcx5Yq1U2jJ2vO+XVVixbsDJ7uo4QPzw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762833878; c=relaxed/simple;
	bh=R178Ucl3QxqPTa3sc13fEY8U83OM569eeVC6oIADPmM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=dKceYvYxuGF77frfSQetsW0zZ7WDMS8Dm43j31u7SSAwueSZgDSnK6v+v3qofGTyP5xSKC05E477YfXGoO61cQsg+pDOOjvvEQnDm/Mi8HKtReVaOEi5eHK7MWKxl1tk6V/s/V4GsmFMlGObewovaYUhpkHYq/b7KMvr3Pjl08k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l6QOZm2s; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l6QOZm2s"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-297f3710070so70934095ad.2
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Nov 2025 20:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762833875; x=1763438675; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uCCveltFilMzlnQriVXwfyMsINsqp4xDj/nk6J2vWWw=;
        b=l6QOZm2sibfwrFAgYS95HaMyjNIL+bbfjce5loxYpgjrZZhp8u+pgE2JFi2AUPf90w
         GU5ERmmfIdyQgWlAYflIBCpjVRCQZlCNc2m08Sjudcq0799k4FGSXJ/mwhR+KG57kz6S
         7EKYCQTp4lognzf3SwXp6cryuaWdGkKAAmn5l1wJ63FWEIuz0kIwzT7lt2i745zPw5sB
         zM9LK4D5VTejFgC0U8F664pbyvn8AjVPcMSjMMGwJKGbKvubosx936151ytRetAQ6khz
         +ol01brDLqC/qkMfvVvt0Jk2C0RE2Ls5gu/e5ZQz6+wv03qDMRAiJHJC41dnES/up5fJ
         QbOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762833875; x=1763438675;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uCCveltFilMzlnQriVXwfyMsINsqp4xDj/nk6J2vWWw=;
        b=NXZHoNS7iubGPuGrWe4by3GUFj/1O8jFFn3D9oM3cp7TUFA4JnbRWeKw3v8Zq+goGt
         nx6+f4ct+La/8iUIDeASOI2xjRBclwQ3DoSMwohjCHdyTS3EqpgNrIkgkahxeOA7EfbH
         4Q9ZfbfMbh8oqQ5tpARIJLNskr+u/HlszI2Duv/ygFqSMKv98YrmK0uzsGbb8Eou9FyV
         fgi5fv9/2Ecs7Ji7Tin2+R6rx5Fg1cvs7McO+O7mnwUA6mV6oKfPphCOXcADAbBlJGfm
         gF96AW99imO1GwLunOHZLQgeRSn4U6F/6pc8S2yZ4IRyxJzTtHOdMB7f04YxQfT6nzHr
         /uZA==
X-Forwarded-Encrypted: i=1; AJvYcCWhbpS2u4ZG/EVJqpz8sB8V7nwkYm6b5J9qYGS5BQ36r+kObI4ez1t9to+maTMLHrKwZUEoi30M2T7m/03LUuO/@vger.kernel.org
X-Gm-Message-State: AOJu0YyYr9b6nxIDqSesG9tfgpeuY+QUK8EhxBOoL47G2YttEI62iyaP
	s9BLNvma48+srFg0gVsxxTyW2T7/dO1xzVDvV2jDKEDB7yJ6Hl5omb4StLJWpTEYsNamj8uJOsq
	0/P+P+Oj9HA==
X-Google-Smtp-Source: AGHT+IFdTKUAS6WYxt2C4e7TqdsnhKDOsbLsGRxI4yLl1GdrDbKAchrEq0IfPfe/abPEUXfObwO8JuLlYn42
X-Received: from dycue1.prod.google.com ([2002:a05:7300:81:b0:2a4:6577:68f1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:fad:b0:297:dade:456e
 with SMTP id d9443c01a7336-297e56dc6ccmr129898955ad.44.1762833875320; Mon, 10
 Nov 2025 20:04:35 -0800 (PST)
Date: Mon, 10 Nov 2025 20:04:04 -0800
In-Reply-To: <20251111040417.270945-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111040417.270945-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251111040417.270945-6-irogers@google.com>
Subject: [PATCH v3 05/18] perf stat: Add detail -d,-dd,-ddd metrics
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

            18,446      context-switches                 #    653.0 cs/sec =
 cs_per_second
             TopdownL1 (cpu_core)                 #      6.8 %  tma_bad_spe=
culation
                                                  #     37.0 %  tma_fronten=
d_bound       (30.32%)
             TopdownL1 (cpu_core)                 #     40.1 %  tma_backend=
_bound
                                                  #     16.1 %  tma_retirin=
g             (30.32%)
               177      page-faults                      #      6.3 faults/=
sec  page_faults_per_second
       472,170,922      cpu_atom/cpu-cycles/             #      0.0 GHz  cy=
cles_frequency       (28.57%)
       656,868,742      cpu_core/cpu-cycles/             #      0.0 GHz  cy=
cles_frequency       (38.24%)
                                                  #     22.2 %  tma_bad_spe=
culation
                                                  #     12.2 %  tma_retirin=
g             (28.55%)
                                                  #     32.4 %  tma_backend=
_bound
                                                  #     33.1 %  tma_fronten=
d_bound       (35.71%)
        43,583,604      cpu_atom/branches/               #      1.5 K/sec  =
branch_frequency     (42.85%)
        87,140,541      cpu_core/branches/               #      3.1 K/sec  =
branch_frequency     (54.09%)
               493      cpu-migrations                   #     17.5 migrati=
ons/sec  migrations_per_second
    28,247,893,219      cpu-clock                        #     28.0 CPUs  C=
PUs_utilized
       445,297,600      cpu_atom/cpu-cycles/             #      0.4 instruc=
tions  insn_per_cycle  (42.87%)
       642,323,993      cpu_core/cpu-cycles/             #      0.8 instruc=
tions  insn_per_cycle  (62.01%)
         2,126,311      cpu_atom/branch-misses/          #      6.8 %  bran=
ch_miss_rate         (35.73%)
         2,172,775      cpu_core/branch-misses/          #      2.5 %  bran=
ch_miss_rate         (62.36%)
         1,855,042      cpu_atom/LLC-loads/              #      0.0 %  llc_=
miss_rate            (28.56%)
         2,671,549      cpu_core/LLC-loads/              #     32.5 %  llc_=
miss_rate            (46.31%)
         8,440,231      cpu_core/L1-dcache-load-misses/  #      nan %  l1d_=
miss_rate            (37.99%)
        10,823,925      cpu_atom/L1-icache-load-misses/  #     19.0 %  l1i_=
miss_rate            (21.43%)
        22,602,344      cpu_atom/dTLB-loads/             #      2.0 %  dtlb=
_miss_rate           (21.44%)
       136,524,528      cpu_core/dTLB-loads/             #      0.3 %  dtlb=
_miss_rate           (15.06%)

       1.007665494 seconds time elapsed
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
index 017bbdede3d7..89d1d9f61014 100644
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
index bdf02b667f94..6fc490b96a02 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -1314,21 +1314,27 @@ static const char *const big_c_string =3D
 /* offset=3D129201 */ "cycles_frequency\000Default\000cpu\\-cycles / (soft=
ware@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\=
\-clock\\,name\\=3Dtask\\-clock@)\000\000Cycles per CPU second\000\0001GHz\=
000\000\000\000011"
 /* offset=3D129377 */ "branch_frequency\000Default\000branches / (software=
@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-cl=
ock\\,name\\=3Dtask\\-clock@)\000\000Branches per CPU second\000\0001000K/s=
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

