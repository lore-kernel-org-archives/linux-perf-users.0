Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FA83491D4
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Oct 2025 17:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761328765; cv=none; b=UyVZTaSEQ2fbIrx89w6t+PAQvKwoLIMf2p3FAE7CY2Sh2hRVNHEUtlIceQC91hgiKAD/5XVySOKRDq/B5FPRtllVRPn3mrTeToO3F0uQ3LDaYIWohXHEMtCLXEF41n0FbotEZT73ZB+AAVYEG+t1FA2MmDiM1snen1D9FH9CP+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761328765; c=relaxed/simple;
	bh=klg/sRiJXV3nP1YcezZLBCvFa7NJ8KpQwmE2LhKa4Ow=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=PL8g6K5pWwz3G/bTS4IKB33PyfFeua3mvAS5Pvsz4+cWlo8QdGYrcW3vf3lfneapFqib2yj+19y1OUTCD5ZRlSLJJvX2Ukq7liULgNH5/BA+pFwTJdhtQ6RCGerZl647syrWFmABjo78MwJzR3MbSxaziZGlgJ2SRow0/ghjlGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mZRDdCTQ; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mZRDdCTQ"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-336b9f3b5b0so2344970a91.3
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Oct 2025 10:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761328762; x=1761933562; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kEHLtfcIzQqGzO6BnUeWhjU92+1YZCxiTV0vpMQpKNo=;
        b=mZRDdCTQejntkYDcMDUXfGFWlmvQwKobLOofWloWyo0ysMhEug0EJx3dtOoHkiZm6J
         OYZp1hHr14c6/JlakDIz3OILMFOEhhvtconSpEIQyvb2it6mczk3bCUHrvC3lVCS0Qj4
         8Ue874KIfCjdPvi8TeKIP7PQTPp+J9oBFgd8lj2n3U/Boq4ZiJfTfo/q6CfMQmeamcSM
         FbrZMI93eOCporBJZRKCdutsapmy6C29AtBCF0P6IqnPBGk5wApqUfTGJz+cwb+1Ljk5
         V/PUhNdhBcWXJ00jny6TX5mL6/EWSnFhG1QmC9m26yL/t5+o10mhRNUa6LUqgH27Bn08
         gOuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761328762; x=1761933562;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kEHLtfcIzQqGzO6BnUeWhjU92+1YZCxiTV0vpMQpKNo=;
        b=UClCnP8UmUkZpYCH6nenwMnLauCSyo9qDvOoWhqTVoD4vZ8vmA4dWRAhwvhhHQVdIs
         Hs4myuGn8VbSt9XzOgfwa9n9MtnX64nxCV8JtF10iy2k1flMhEEvYSoxO30+GApMXaCF
         /FVbL5AmajITa9YiYz9UfDNoyiGmWXAXP7tUfKSf6ldJ5aPmZjoQys6IeYo0VIZ6H3Sz
         6Zg9YLd23LDdrVGI0g028R1r4u2Z+L1hqKEC8prWCDOXvYLzuy3fli/dhLkmCWH5Gc7B
         5G7kwYsZIbah6mGGiogBxZ6NO4K6tsl9cQuly6Uu3sKjrXohJu6n7MCT/3DluP7Rgj6e
         scyA==
X-Forwarded-Encrypted: i=1; AJvYcCWisKucd7RTRr16uFe6U8FK733coS18a25qwgXfGIQWNxJxDHUSKmLkt4OnNH4cc15A8xHPUMA1ElMN2CYhV2HU@vger.kernel.org
X-Gm-Message-State: AOJu0YzdNRF8PPykVtOlPM6yEsiRykU/QGJiUJtodTipKe3bOdweSRDl
	l5sr3/xKHNtvdcpMBa0RM0dd5JZabIGauT3mtOkz51f1VLn0e99BvWRP29Ud0szYj9x3Rwg+1im
	6I6n+2jWjyw==
X-Google-Smtp-Source: AGHT+IFdMkRDc8U42R3PJdVmtSsrswXLi2j1en0OfkYtpY5CjwAQCy31p4Fh4bFj7ZlxLryLfONY4mwUuu5F
X-Received: from pjbee13.prod.google.com ([2002:a17:90a:fc4d:b0:33b:caf7:2442])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d646:b0:32e:749d:fcb7
 with SMTP id 98e67ed59e1d1-33fd65fcd1bmr3837587a91.13.1761328762071; Fri, 24
 Oct 2025 10:59:22 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:58:45 -0700
In-Reply-To: <20251024175857.808401-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251024175857.808401-1-irogers@google.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251024175857.808401-11-irogers@google.com>
Subject: [PATCH v1 10/22] perf stat: Add detail -d,-dd,-ddd metrics
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
	linux-perf-users@vger.kernel.org
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
index 9c7d63614cab..c00d84a04593 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1853,28 +1853,6 @@ static int perf_stat_init_aggr_mode_file(struct perf=
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
@@ -2002,22 +1980,34 @@ static int add_default_events(void)
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
@@ -2030,62 +2020,6 @@ static int add_default_events(void)
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
index 71464b1d8afe..e882c645fbbe 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -1314,21 +1314,27 @@ static const char *const big_c_string =3D
 /* offset=3D129185 */ "cycles_frequency\000Default\000cpu\\-cycles / (soft=
ware@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\=
\-clock\\,name\\=3Dtask\\-clock@)\000\000Cycles per CPU second\000\0001GHz\=
000\000\000\000011"
 /* offset=3D129361 */ "branch_frequency\000Default\000branches / (software=
@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-cl=
ock\\,name\\=3Dtask\\-clock@)\000\000Branches per CPU second\000\0001000K/s=
ec\000\000\000\000011"
 /* offset=3D129541 */ "branch_miss_rate\000Default\000branch\\-misses / br=
anches\000branch_miss_rate > 0.05\000Branch miss rate\000\000100%\000\000\0=
00\000001"
-/* offset=3D129645 */ "CPI\000\0001 / IPC\000\000\000\000\000\000\000\0000=
00"
-/* offset=3D129668 */ "IPC\000group1\000inst_retired.any / cpu_clk_unhalte=
d.thread\000\000\000\000\000\000\000\000000"
-/* offset=3D129732 */ "Frontend_Bound_SMT\000\000idq_uops_not_delivered.co=
re / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_a=
ctive / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\000000"
-/* offset=3D129899 */ "dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_=
retired.any\000\000\000\000\000\000\000\000000"
-/* offset=3D129964 */ "icache_miss_cycles\000\000l1i\\-loads\\-misses / in=
st_retired.any\000\000\000\000\000\000\000\000000"
-/* offset=3D130032 */ "cache_miss_cycles\000group1\000dcache_miss_cpi + ic=
ache_miss_cycles\000\000\000\000\000\000\000\000000"
-/* offset=3D130104 */ "DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_h=
it + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\000000"
-/* offset=3D130199 */ "DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_d=
ata_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_=
miss\000\000\000\000\000\000\000\000000"
-/* offset=3D130334 */ "DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2=
_All_Miss\000\000\000\000\000\000\000\000000"
-/* offset=3D130399 */ "DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, D=
Cache_L2_All)\000\000\000\000\000\000\000\000000"
-/* offset=3D130468 */ "DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss,=
 DCache_L2_All)\000\000\000\000\000\000\000\000000"
-/* offset=3D130539 */ "M1\000\000ipc + M2\000\000\000\000\000\000\000\0000=
00"
-/* offset=3D130562 */ "M2\000\000ipc + M1\000\000\000\000\000\000\000\0000=
00"
-/* offset=3D130585 */ "M3\000\0001 / M3\000\000\000\000\000\000\000\000000=
"
-/* offset=3D130606 */ "L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9=
 / duration_time\000\000\000\000\000\000\000\000000"
+/* offset=3D129645 */ "l1d_miss_rate\000Default2\000L1\\-dcache\\-load\\-m=
isses / L1\\-dcache\\-loads\000l1d_miss_rate > 0.05\000L1D  miss rate\000\0=
00100%\000\000\000\000001"
+/* offset=3D129761 */ "llc_miss_rate\000Default2\000LLC\\-load\\-misses / =
LLC\\-loads\000llc_miss_rate > 0.05\000LLC miss rate\000\000100%\000\000\00=
0\000001"
+/* offset=3D129862 */ "l1i_miss_rate\000Default3\000L1\\-icache\\-load\\-m=
isses / L1\\-icache\\-loads\000l1i_miss_rate > 0.05\000L1I miss rate\000\00=
0100%\000\000\000\000001"
+/* offset=3D129977 */ "dtlb_miss_rate\000Default3\000dTLB\\-load\\-misses =
/ dTLB\\-loads\000dtlb_miss_rate > 0.05\000dTLB miss rate\000\000100%\000\0=
00\000\000001"
+/* offset=3D130083 */ "itlb_miss_rate\000Default3\000iTLB\\-load\\-misses =
/ iTLB\\-loads\000itlb_miss_rate > 0.05\000iTLB miss rate\000\000100%\000\0=
00\000\000001"
+/* offset=3D130189 */ "l1_prefetch_miss_rate\000Default4\000L1\\-dcache\\-=
prefetch\\-misses / L1\\-dcache\\-prefetches\000l1_prefetch_miss_rate > 0.0=
5\000L1 prefetch miss rate\000\000100%\000\000\000\000001"
+/* offset=3D130337 */ "CPI\000\0001 / IPC\000\000\000\000\000\000\000\0000=
00"
+/* offset=3D130360 */ "IPC\000group1\000inst_retired.any / cpu_clk_unhalte=
d.thread\000\000\000\000\000\000\000\000000"
+/* offset=3D130424 */ "Frontend_Bound_SMT\000\000idq_uops_not_delivered.co=
re / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_a=
ctive / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\000000"
+/* offset=3D130591 */ "dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_=
retired.any\000\000\000\000\000\000\000\000000"
+/* offset=3D130656 */ "icache_miss_cycles\000\000l1i\\-loads\\-misses / in=
st_retired.any\000\000\000\000\000\000\000\000000"
+/* offset=3D130724 */ "cache_miss_cycles\000group1\000dcache_miss_cpi + ic=
ache_miss_cycles\000\000\000\000\000\000\000\000000"
+/* offset=3D130796 */ "DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_h=
it + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\000000"
+/* offset=3D130891 */ "DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_d=
ata_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_=
miss\000\000\000\000\000\000\000\000000"
+/* offset=3D131026 */ "DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2=
_All_Miss\000\000\000\000\000\000\000\000000"
+/* offset=3D131091 */ "DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, D=
Cache_L2_All)\000\000\000\000\000\000\000\000000"
+/* offset=3D131160 */ "DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss,=
 DCache_L2_All)\000\000\000\000\000\000\000\000000"
+/* offset=3D131231 */ "M1\000\000ipc + M2\000\000\000\000\000\000\000\0000=
00"
+/* offset=3D131254 */ "M2\000\000ipc + M1\000\000\000\000\000\000\000\0000=
00"
+/* offset=3D131277 */ "M3\000\0001 / M3\000\000\000\000\000\000\000\000000=
"
+/* offset=3D131298 */ "L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9=
 / duration_time\000\000\000\000\000\000\000\000000"
 ;
=20
 static const struct compact_pmu_event pmu_events__common_default_core[] =
=3D {
@@ -2621,8 +2627,14 @@ static const struct compact_pmu_event pmu_metrics__c=
ommon_default_core[] =3D {
 { 129541 }, /* branch_miss_rate\000Default\000branch\\-misses / branches\0=
00branch_miss_rate > 0.05\000Branch miss rate\000\000100%\000\000\000\00000=
1 */
 { 127928 }, /* cs_per_second\000Default\000software@context\\-switches\\,n=
ame\\=3Dcontext\\-switches@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-=
clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\=
000\000Context switches per CPU second\000\0001cs/sec\000\000\000\000011 */
 { 129185 }, /* cycles_frequency\000Default\000cpu\\-cycles / (software@cpu=
\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\=
\,name\\=3Dtask\\-clock@)\000\000Cycles per CPU second\000\0001GHz\000\000\=
000\000011 */
+{ 129977 }, /* dtlb_miss_rate\000Default3\000dTLB\\-load\\-misses / dTLB\\=
-loads\000dtlb_miss_rate > 0.05\000dTLB miss rate\000\000100%\000\000\000\0=
00001 */
 { 128929 }, /* frontend_cycles_idle\000Default\000stalled\\-cycles\\-front=
end / cpu\\-cycles\000frontend_cycles_idle > 0.1\000Frontend stalls per cyc=
le\000\000\000\000\000\000001 */
 { 128652 }, /* insn_per_cycle\000Default\000instructions / cpu\\-cycles\00=
0insn_per_cycle < 1\000Instructions Per Cycle\000\0001instructions\000\000\=
000\000001 */
+{ 130083 }, /* itlb_miss_rate\000Default3\000iTLB\\-load\\-misses / iTLB\\=
-loads\000itlb_miss_rate > 0.05\000iTLB miss rate\000\000100%\000\000\000\0=
00001 */
+{ 130189 }, /* l1_prefetch_miss_rate\000Default4\000L1\\-dcache\\-prefetch=
\\-misses / L1\\-dcache\\-prefetches\000l1_prefetch_miss_rate > 0.05\000L1 =
prefetch miss rate\000\000100%\000\000\000\000001 */
+{ 129645 }, /* l1d_miss_rate\000Default2\000L1\\-dcache\\-load\\-misses / =
L1\\-dcache\\-loads\000l1d_miss_rate > 0.05\000L1D  miss rate\000\000100%\0=
00\000\000\000001 */
+{ 129862 }, /* l1i_miss_rate\000Default3\000L1\\-icache\\-load\\-misses / =
L1\\-icache\\-loads\000l1i_miss_rate > 0.05\000L1I miss rate\000\000100%\00=
0\000\000\000001 */
+{ 129761 }, /* llc_miss_rate\000Default2\000LLC\\-load\\-misses / LLC\\-lo=
ads\000llc_miss_rate > 0.05\000LLC miss rate\000\000100%\000\000\000\000001=
 */
 { 128161 }, /* migrations_per_second\000Default\000software@cpu\\-migratio=
ns\\,name\\=3Dcpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcp=
u\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-cloc=
k@)\000\000Process migrations to a new CPU per CPU second\000\0001migration=
s/sec\000\000\000\000011 */
 { 128421 }, /* page_faults_per_second\000Default\000software@page\\-faults=
\\,name\\=3Dpage\\-faults@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-c=
lock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\0=
00\000Page faults per CPU second\000\0001faults/sec\000\000\000\000011 */
 { 128765 }, /* stalled_cycles_per_instruction\000Default\000max(stalled\\-=
cycles\\-frontend, stalled\\-cycles\\-backend) / instructions\000\000Max fr=
ont or backend stalls per instruction\000\000\000\000\000\000001 */
@@ -2698,21 +2710,21 @@ static const struct pmu_table_entry pmu_events__tes=
t_soc_cpu[] =3D {
 };
=20
 static const struct compact_pmu_event pmu_metrics__test_soc_cpu_default_co=
re[] =3D {
-{ 129645 }, /* CPI\000\0001 / IPC\000\000\000\000\000\000\000\000000 */
-{ 130334 }, /* DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Mis=
s\000\000\000\000\000\000\000\000000 */
-{ 130104 }, /* DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_=
rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\000000 */
-{ 130199 }, /* DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd -=
 l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\000=
\000\000\000\000\000\000\000000 */
-{ 130399 }, /* DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2=
_All)\000\000\000\000\000\000\000\000000 */
-{ 130468 }, /* DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_=
L2_All)\000\000\000\000\000\000\000\000000 */
-{ 129732 }, /* Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 =
* (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active / =
cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\000000 */
-{ 129668 }, /* IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread=
\000\000\000\000\000\000\000\000000 */
-{ 130606 }, /* L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / durat=
ion_time\000\000\000\000\000\000\000\000000 */
-{ 130539 }, /* M1\000\000ipc + M2\000\000\000\000\000\000\000\000000 */
-{ 130562 }, /* M2\000\000ipc + M1\000\000\000\000\000\000\000\000000 */
-{ 130585 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\000000 */
-{ 130032 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_mis=
s_cycles\000\000\000\000\000\000\000\000000 */
-{ 129899 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.=
any\000\000\000\000\000\000\000\000000 */
-{ 129964 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retir=
ed.any\000\000\000\000\000\000\000\000000 */
+{ 130337 }, /* CPI\000\0001 / IPC\000\000\000\000\000\000\000\000000 */
+{ 131026 }, /* DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Mis=
s\000\000\000\000\000\000\000\000000 */
+{ 130796 }, /* DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_=
rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\000000 */
+{ 130891 }, /* DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd -=
 l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\000=
\000\000\000\000\000\000\000000 */
+{ 131091 }, /* DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2=
_All)\000\000\000\000\000\000\000\000000 */
+{ 131160 }, /* DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_=
L2_All)\000\000\000\000\000\000\000\000000 */
+{ 130424 }, /* Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 =
* (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active / =
cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\000000 */
+{ 130360 }, /* IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread=
\000\000\000\000\000\000\000\000000 */
+{ 131298 }, /* L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / durat=
ion_time\000\000\000\000\000\000\000\000000 */
+{ 131231 }, /* M1\000\000ipc + M2\000\000\000\000\000\000\000\000000 */
+{ 131254 }, /* M2\000\000ipc + M1\000\000\000\000\000\000\000\000000 */
+{ 131277 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\000000 */
+{ 130724 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_mis=
s_cycles\000\000\000\000\000\000\000\000000 */
+{ 130591 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.=
any\000\000\000\000\000\000\000\000000 */
+{ 130656 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retir=
ed.any\000\000\000\000\000\000\000\000000 */
=20
 };
=20
--=20
2.51.1.821.gb6fe4d2222-goog

