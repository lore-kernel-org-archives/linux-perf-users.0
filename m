Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D75B352FA5
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 21:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762896149; cv=none; b=bVLcDReRJK9IKNhp7wwwEE+SYOpMG0RBlRN54Qi/sSSFpqDTecA5cnGoICzwECT2uBrDl/9kp0u9UuVbwvYpYiJS3Ll6G4Dpw33RLIR3uOdwA3QXEoizo5OXT3TI2bhLJw1zFHxyxaL+UI1n8lmwFCZXdJMEjByOSLCXyMMNuwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762896149; c=relaxed/simple;
	bh=VGsC40ZfoLrWeX6Y7608d7sp+kqfuKgbOi1QSq3kNzM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=bXE3mn3ALBRt3kBWQtJLKubuolM66QOIxlPg2j7WyGr4qPhU35E0gZk6yO4eQ1i7LrKpXNF7d186njf20hp66Lq7fX4ihrDfXhaDVu3Ez3bQm5xgo1lGkyqHJgLtDKU0C4jstzCQly+e3vBoB930nr81IB6XmhLj9BPYuArl5kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D7Pp0esP; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D7Pp0esP"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2982dec5ccbso3110885ad.3
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 13:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762896146; x=1763500946; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VR3nVLTOvGUu9EaNHrflvWdPKq/hmYtX3HdzBBdfmOg=;
        b=D7Pp0esPHlfcoFsddotYPJtxuEauPqcNKpEG3Aa6IizBAviC0qvCS6GRkuAUUQtna+
         W8d8Bk7+DuOoizNrxDfgeSdoP5Wtvt/iv/H+nq3jIee/PB2x5NYMumOd3UnI7Z/EiER2
         lSZwQcvkTBuOGK/rHVJqWPtY5sM35hk6E7c1GpQv7YI3EMjtY5bz3QKW4M2tniWOGGHM
         cTuZsxNzI9HsvJy22UNwIBJWVR93ZF4ruxNfEChlfQp9nTEcrnwSHQJlxsUoqGffRc7t
         UG4RAxw94zNuilHXHkVmEbo+JOHNSC/WC1/1ERbKZHyWHXEwSB01IUGAY3wBrHksD0z2
         NZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762896146; x=1763500946;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VR3nVLTOvGUu9EaNHrflvWdPKq/hmYtX3HdzBBdfmOg=;
        b=OtFRbDvp0iYjZMKdErz3gFE9kre1OLMmSMJhHgDyy2/x3Oui7U/rLJufS7IMut46Bb
         czJXgIURcVRyrYJVUjPdkPkwMWTB9iyK2LjmE5tW/CQKD3yd2O8C9ANGXJ/KTN5IL7Y3
         s2FjvHXtBTCUWnLQI7Jkg84NXs4z8pR6+d54bbCmvaMsIkIY8cAWFSqG/UNiBUb2F1wM
         KCDDCQ6QhHOGtz8SyTQnOMBZ9TxQlRtPsunuR1rhL5o+5X/kEz/il2sNtlj5pPEeyLsU
         i4L34Zr3KMJ/2UTn5/Gz3xGE0RkmJTjQ3FrYlNv9BPe7FNLP+gTo2EadNX/pPesjiEqi
         5HgQ==
X-Forwarded-Encrypted: i=1; AJvYcCX30Vmt6XzdnsHpX/E+bxTgzFJ+T54IE0JcD1PNMjItBZeEVY/etLGwiAqO1ZUSsw5cYvpw7HKxEXaM/nhYeVxC@vger.kernel.org
X-Gm-Message-State: AOJu0YyPshIweHek0yofkAZ17yH9KKhb2yg8ECJqyyLBuVqK61/dsxjD
	ACvge8F7GyId4qxy6k3pXXK2ba0ixE9uMFAucLsC2j0nohoGNRAECXwyJmE9XCX2FHP2zs71h+L
	DNkowK6z1DA==
X-Google-Smtp-Source: AGHT+IHW/PUvAKjTNjgusauMgIBKKBEJl9anrN1cDNyr2YjOZbXLe3SuBBep0VgeYBw1u5tJdlK/xSGVO+OF
X-Received: from dyce11.prod.google.com ([2002:a05:7300:724b:b0:2a4:6577:68f1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:15cc:b0:290:2a14:2ed5
 with SMTP id d9443c01a7336-2984ed33eeemr8491255ad.4.1762896145681; Tue, 11
 Nov 2025 13:22:25 -0800 (PST)
Date: Tue, 11 Nov 2025 13:21:52 -0800
In-Reply-To: <20251111212206.631711-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111212206.631711-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251111212206.631711-5-irogers@google.com>
Subject: [PATCH v4 04/18] perf jevents: Add metric DefaultShowEvents
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

Some Default group metrics require their events showing for
consistency with perf's previous behavior. Add a flag to indicate when
this is the case and use it in stat-display.

As events are coming from Default metrics remove that default hardware
and software events from perf stat.

Following this change the default perf stat output on an alderlake looks li=
ke:
```
$ perf stat -a -- sleep 1

 Performance counter stats for 'system wide':

            20,550      context-switches                 #      nan cs/sec =
 cs_per_second
             TopdownL1 (cpu_core)                 #      9.0 %  tma_bad_spe=
culation
                                                  #     28.1 %  tma_fronten=
d_bound
             TopdownL1 (cpu_core)                 #     29.2 %  tma_backend=
_bound
                                                  #     33.7 %  tma_retirin=
g
             6,685      page-faults                      #      nan faults/=
sec  page_faults_per_second
       790,091,064      cpu_atom/cpu-cycles/
                                                  #      nan GHz  cycles_fr=
equency       (49.83%)
     2,563,918,366      cpu_core/cpu-cycles/
                                                  #      nan GHz  cycles_fr=
equency
                                                  #     12.3 %  tma_bad_spe=
culation
                                                  #     14.5 %  tma_retirin=
g             (50.20%)
                                                  #     33.8 %  tma_fronten=
d_bound       (50.24%)
        76,390,322      cpu_atom/branches/               #      nan M/sec  =
branch_frequency     (60.20%)
     1,015,173,047      cpu_core/branches/               #      nan M/sec  =
branch_frequency
             1,325      cpu-migrations                   #      nan migrati=
ons/sec  migrations_per_second
                                                  #     39.3 %  tma_backend=
_bound        (60.17%)
              0.00 msec cpu-clock                        #    0.000 CPUs ut=
ilized
                                                  #      0.0 CPUs  CPUs_uti=
lized
       554,347,072      cpu_atom/instructions/           #    0.64  insn pe=
r cycle
                                                  #      0.6 instructions  =
insn_per_cycle  (60.14%)
     5,228,931,991      cpu_core/instructions/           #    2.04  insn pe=
r cycle
                                                  #      2.0 instructions  =
insn_per_cycle
         4,308,874      cpu_atom/branch-misses/          #    5.65% of all =
branches
                                                  #      5.6 %  branch_miss=
_rate         (49.76%)
         9,890,606      cpu_core/branch-misses/          #    0.97% of all =
branches
                                                  #      1.0 %  branch_miss=
_rate

       1.005477803 seconds time elapsed
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c                     |  42 +------
 .../arch/common/common/metrics.json           |  33 ++++--
 tools/perf/pmu-events/empty-pmu-events.c      | 106 +++++++++---------
 tools/perf/pmu-events/jevents.py              |   7 +-
 tools/perf/pmu-events/pmu-events.h            |   1 +
 tools/perf/util/evsel.h                       |   1 +
 tools/perf/util/metricgroup.c                 |  13 +++
 tools/perf/util/stat-display.c                |   4 +-
 tools/perf/util/stat-shadow.c                 |   2 +-
 9 files changed, 102 insertions(+), 107 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 3c46b92a53ab..31c762695d4b 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1857,16 +1857,6 @@ static int perf_stat_init_aggr_mode_file(struct perf=
_stat *st)
 	return 0;
 }
=20
-/* Add given software event to evlist without wildcarding. */
-static int parse_software_event(struct evlist *evlist, const char *event,
-				struct parse_events_error *err)
-{
-	char buf[256];
-
-	snprintf(buf, sizeof(buf), "software/%s,name=3D%s/", event, event);
-	return parse_events(evlist, buf, err);
-}
-
 /* Add legacy hardware/hardware-cache event to evlist for all core PMUs wi=
thout wildcarding. */
 static int parse_hardware_event(struct evlist *evlist, const char *event,
 				struct parse_events_error *err)
@@ -2011,36 +2001,10 @@ static int add_default_events(void)
 		stat_config.topdown_level =3D 1;
=20
 	if (!evlist->core.nr_entries && !evsel_list->core.nr_entries) {
-		/* No events so add defaults. */
-		const char *sw_events[] =3D {
-			target__has_cpu(&target) ? "cpu-clock" : "task-clock",
-			"context-switches",
-			"cpu-migrations",
-			"page-faults",
-		};
-		const char *hw_events[] =3D {
-			"instructions",
-			"cycles",
-			"stalled-cycles-frontend",
-			"stalled-cycles-backend",
-			"branches",
-			"branch-misses",
-		};
-
-		for (size_t i =3D 0; i < ARRAY_SIZE(sw_events); i++) {
-			ret =3D parse_software_event(evlist, sw_events[i], &err);
-			if (ret)
-				goto out;
-		}
-		for (size_t i =3D 0; i < ARRAY_SIZE(hw_events); i++) {
-			ret =3D parse_hardware_event(evlist, hw_events[i], &err);
-			if (ret)
-				goto out;
-		}
-
 		/*
-		 * Add TopdownL1 metrics if they exist. To minimize
-		 * multiplexing, don't request threshold computation.
+		 * Add Default metrics. To minimize multiplexing, don't request
+		 * threshold computation, but it will be computed if the events
+		 * are present.
 		 */
 		if (metricgroup__has_metric_or_groups(pmu, "Default")) {
 			struct evlist *metric_evlist =3D evlist__new();
diff --git a/tools/perf/pmu-events/arch/common/common/metrics.json b/tools/=
perf/pmu-events/arch/common/common/metrics.json
index d915be51e300..d6ea967a4045 100644
--- a/tools/perf/pmu-events/arch/common/common/metrics.json
+++ b/tools/perf/pmu-events/arch/common/common/metrics.json
@@ -5,7 +5,8 @@
         "MetricGroup": "Default",
         "MetricName": "CPUs_utilized",
         "ScaleUnit": "1CPUs",
-        "MetricConstraint": "NO_GROUP_EVENTS"
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "DefaultShowEvents": "1"
     },
     {
         "BriefDescription": "Context switches per CPU second",
@@ -13,7 +14,8 @@
         "MetricGroup": "Default",
         "MetricName": "cs_per_second",
         "ScaleUnit": "1cs/sec",
-        "MetricConstraint": "NO_GROUP_EVENTS"
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "DefaultShowEvents": "1"
     },
     {
         "BriefDescription": "Process migrations to a new CPU per CPU secon=
d",
@@ -21,7 +23,8 @@
         "MetricGroup": "Default",
         "MetricName": "migrations_per_second",
         "ScaleUnit": "1migrations/sec",
-        "MetricConstraint": "NO_GROUP_EVENTS"
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "DefaultShowEvents": "1"
     },
     {
         "BriefDescription": "Page faults per CPU second",
@@ -29,7 +32,8 @@
         "MetricGroup": "Default",
         "MetricName": "page_faults_per_second",
         "ScaleUnit": "1faults/sec",
-        "MetricConstraint": "NO_GROUP_EVENTS"
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "DefaultShowEvents": "1"
     },
     {
         "BriefDescription": "Instructions Per Cycle",
@@ -37,27 +41,31 @@
         "MetricGroup": "Default",
         "MetricName": "insn_per_cycle",
         "MetricThreshold": "insn_per_cycle < 1",
-        "ScaleUnit": "1instructions"
+        "ScaleUnit": "1instructions",
+        "DefaultShowEvents": "1"
     },
     {
         "BriefDescription": "Max front or backend stalls per instruction",
         "MetricExpr": "max(stalled\\-cycles\\-frontend, stalled\\-cycles\\=
-backend) / instructions",
         "MetricGroup": "Default",
-        "MetricName": "stalled_cycles_per_instruction"
+        "MetricName": "stalled_cycles_per_instruction",
+        "DefaultShowEvents": "1"
     },
     {
         "BriefDescription": "Frontend stalls per cycle",
         "MetricExpr": "stalled\\-cycles\\-frontend / cpu\\-cycles",
         "MetricGroup": "Default",
         "MetricName": "frontend_cycles_idle",
-        "MetricThreshold": "frontend_cycles_idle > 0.1"
+        "MetricThreshold": "frontend_cycles_idle > 0.1",
+        "DefaultShowEvents": "1"
     },
     {
         "BriefDescription": "Backend stalls per cycle",
         "MetricExpr": "stalled\\-cycles\\-backend / cpu\\-cycles",
         "MetricGroup": "Default",
         "MetricName": "backend_cycles_idle",
-        "MetricThreshold": "backend_cycles_idle > 0.2"
+        "MetricThreshold": "backend_cycles_idle > 0.2",
+        "DefaultShowEvents": "1"
     },
     {
         "BriefDescription": "Cycles per CPU second",
@@ -65,7 +73,8 @@
         "MetricGroup": "Default",
         "MetricName": "cycles_frequency",
         "ScaleUnit": "1GHz",
-        "MetricConstraint": "NO_GROUP_EVENTS"
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "DefaultShowEvents": "1"
     },
     {
         "BriefDescription": "Branches per CPU second",
@@ -73,7 +82,8 @@
         "MetricGroup": "Default",
         "MetricName": "branch_frequency",
         "ScaleUnit": "1000M/sec",
-        "MetricConstraint": "NO_GROUP_EVENTS"
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "DefaultShowEvents": "1"
     },
     {
         "BriefDescription": "Branch miss rate",
@@ -81,6 +91,7 @@
         "MetricGroup": "Default",
         "MetricName": "branch_miss_rate",
         "MetricThreshold": "branch_miss_rate > 0.05",
-        "ScaleUnit": "100%"
+        "ScaleUnit": "100%",
+        "DefaultShowEvents": "1"
     }
 ]
diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-even=
ts/empty-pmu-events.c
index e4d00f6b2b5d..333a44930910 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -1303,32 +1303,32 @@ static const char *const big_c_string =3D
 /* offset=3D127519 */ "sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycle=
s event\000config=3D0x2c\0000x01\00000\000\000\000\000\000"
 /* offset=3D127596 */ "uncore_sys_cmn_pmu\000"
 /* offset=3D127615 */ "sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts tota=
l cache misses in first lookup result (high priority)\000eventid=3D1,type=
=3D5\000(434|436|43c|43a).*\00000\000\000\000\000\000"
-/* offset=3D127758 */ "CPUs_utilized\000Default\000(software@cpu\\-clock\\=
,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=
=3Dtask\\-clock@) / (duration_time * 1e9)\000\000Average CPU utilization\00=
0\0001CPUs\000\000\000\00001"
-/* offset=3D127943 */ "cs_per_second\000Default\000software@context\\-swit=
ches\\,name\\=3Dcontext\\-switches@ * 1e9 / (software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@)\000\000Context switches per CPU second\000\0001cs/sec\000\000\000\=
00001"
-/* offset=3D128175 */ "migrations_per_second\000Default\000software@cpu\\-=
migrations\\,name\\=3Dcpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\,nam=
e\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtas=
k\\-clock@)\000\000Process migrations to a new CPU per CPU second\000\0001m=
igrations/sec\000\000\000\00001"
-/* offset=3D128434 */ "page_faults_per_second\000Default\000software@page\=
\-faults\\,name\\=3Dpage\\-faults@ * 1e9 / (software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@)\000\000Page faults per CPU second\000\0001faults/sec\000\000\000\0=
0001"
-/* offset=3D128664 */ "insn_per_cycle\000Default\000instructions / cpu\\-c=
ycles\000insn_per_cycle < 1\000Instructions Per Cycle\000\0001instructions\=
000\000\000\00000"
-/* offset=3D128776 */ "stalled_cycles_per_instruction\000Default\000max(st=
alled\\-cycles\\-frontend, stalled\\-cycles\\-backend) / instructions\000\0=
00Max front or backend stalls per instruction\000\000\000\000\000\00000"
-/* offset=3D128939 */ "frontend_cycles_idle\000Default\000stalled\\-cycles=
\\-frontend / cpu\\-cycles\000frontend_cycles_idle > 0.1\000Frontend stalls=
 per cycle\000\000\000\000\000\00000"
-/* offset=3D129068 */ "backend_cycles_idle\000Default\000stalled\\-cycles\=
\-backend / cpu\\-cycles\000backend_cycles_idle > 0.2\000Backend stalls per=
 cycle\000\000\000\000\000\00000"
-/* offset=3D129193 */ "cycles_frequency\000Default\000cpu\\-cycles / (soft=
ware@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\=
\-clock\\,name\\=3Dtask\\-clock@)\000\000Cycles per CPU second\000\0001GHz\=
000\000\000\00001"
-/* offset=3D129368 */ "branch_frequency\000Default\000branches / (software=
@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-cl=
ock\\,name\\=3Dtask\\-clock@)\000\000Branches per CPU second\000\0001000M/s=
ec\000\000\000\00001"
-/* offset=3D129547 */ "branch_miss_rate\000Default\000branch\\-misses / br=
anches\000branch_miss_rate > 0.05\000Branch miss rate\000\000100%\000\000\0=
00\00000"
-/* offset=3D129650 */ "CPI\000\0001 / IPC\000\000\000\000\000\000\000\0000=
0"
-/* offset=3D129672 */ "IPC\000group1\000inst_retired.any / cpu_clk_unhalte=
d.thread\000\000\000\000\000\000\000\00000"
-/* offset=3D129735 */ "Frontend_Bound_SMT\000\000idq_uops_not_delivered.co=
re / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_a=
ctive / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\00000"
-/* offset=3D129901 */ "dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_=
retired.any\000\000\000\000\000\000\000\00000"
-/* offset=3D129965 */ "icache_miss_cycles\000\000l1i\\-loads\\-misses / in=
st_retired.any\000\000\000\000\000\000\000\00000"
-/* offset=3D130032 */ "cache_miss_cycles\000group1\000dcache_miss_cpi + ic=
ache_miss_cycles\000\000\000\000\000\000\000\00000"
-/* offset=3D130103 */ "DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_h=
it + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\00000"
-/* offset=3D130197 */ "DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_d=
ata_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_=
miss\000\000\000\000\000\000\000\00000"
-/* offset=3D130331 */ "DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2=
_All_Miss\000\000\000\000\000\000\000\00000"
-/* offset=3D130395 */ "DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, D=
Cache_L2_All)\000\000\000\000\000\000\000\00000"
-/* offset=3D130463 */ "DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss,=
 DCache_L2_All)\000\000\000\000\000\000\000\00000"
-/* offset=3D130533 */ "M1\000\000ipc + M2\000\000\000\000\000\000\000\0000=
0"
-/* offset=3D130555 */ "M2\000\000ipc + M1\000\000\000\000\000\000\000\0000=
0"
-/* offset=3D130577 */ "M3\000\0001 / M3\000\000\000\000\000\000\000\00000"
-/* offset=3D130597 */ "L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9=
 / duration_time\000\000\000\000\000\000\000\00000"
+/* offset=3D127758 */ "CPUs_utilized\000Default\000(software@cpu\\-clock\\=
,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=
=3Dtask\\-clock@) / (duration_time * 1e9)\000\000Average CPU utilization\00=
0\0001CPUs\000\000\000\000011"
+/* offset=3D127944 */ "cs_per_second\000Default\000software@context\\-swit=
ches\\,name\\=3Dcontext\\-switches@ * 1e9 / (software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@)\000\000Context switches per CPU second\000\0001cs/sec\000\000\000\=
000011"
+/* offset=3D128177 */ "migrations_per_second\000Default\000software@cpu\\-=
migrations\\,name\\=3Dcpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\,nam=
e\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtas=
k\\-clock@)\000\000Process migrations to a new CPU per CPU second\000\0001m=
igrations/sec\000\000\000\000011"
+/* offset=3D128437 */ "page_faults_per_second\000Default\000software@page\=
\-faults\\,name\\=3Dpage\\-faults@ * 1e9 / (software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@)\000\000Page faults per CPU second\000\0001faults/sec\000\000\000\0=
00011"
+/* offset=3D128668 */ "insn_per_cycle\000Default\000instructions / cpu\\-c=
ycles\000insn_per_cycle < 1\000Instructions Per Cycle\000\0001instructions\=
000\000\000\000001"
+/* offset=3D128781 */ "stalled_cycles_per_instruction\000Default\000max(st=
alled\\-cycles\\-frontend, stalled\\-cycles\\-backend) / instructions\000\0=
00Max front or backend stalls per instruction\000\000\000\000\000\000001"
+/* offset=3D128945 */ "frontend_cycles_idle\000Default\000stalled\\-cycles=
\\-frontend / cpu\\-cycles\000frontend_cycles_idle > 0.1\000Frontend stalls=
 per cycle\000\000\000\000\000\000001"
+/* offset=3D129075 */ "backend_cycles_idle\000Default\000stalled\\-cycles\=
\-backend / cpu\\-cycles\000backend_cycles_idle > 0.2\000Backend stalls per=
 cycle\000\000\000\000\000\000001"
+/* offset=3D129201 */ "cycles_frequency\000Default\000cpu\\-cycles / (soft=
ware@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\=
\-clock\\,name\\=3Dtask\\-clock@)\000\000Cycles per CPU second\000\0001GHz\=
000\000\000\000011"
+/* offset=3D129377 */ "branch_frequency\000Default\000branches / (software=
@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-cl=
ock\\,name\\=3Dtask\\-clock@)\000\000Branches per CPU second\000\0001000M/s=
ec\000\000\000\000011"
+/* offset=3D129557 */ "branch_miss_rate\000Default\000branch\\-misses / br=
anches\000branch_miss_rate > 0.05\000Branch miss rate\000\000100%\000\000\0=
00\000001"
+/* offset=3D129661 */ "CPI\000\0001 / IPC\000\000\000\000\000\000\000\0000=
00"
+/* offset=3D129684 */ "IPC\000group1\000inst_retired.any / cpu_clk_unhalte=
d.thread\000\000\000\000\000\000\000\000000"
+/* offset=3D129748 */ "Frontend_Bound_SMT\000\000idq_uops_not_delivered.co=
re / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_a=
ctive / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\000000"
+/* offset=3D129915 */ "dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_=
retired.any\000\000\000\000\000\000\000\000000"
+/* offset=3D129980 */ "icache_miss_cycles\000\000l1i\\-loads\\-misses / in=
st_retired.any\000\000\000\000\000\000\000\000000"
+/* offset=3D130048 */ "cache_miss_cycles\000group1\000dcache_miss_cpi + ic=
ache_miss_cycles\000\000\000\000\000\000\000\000000"
+/* offset=3D130120 */ "DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_h=
it + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\000000"
+/* offset=3D130215 */ "DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_d=
ata_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_=
miss\000\000\000\000\000\000\000\000000"
+/* offset=3D130350 */ "DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2=
_All_Miss\000\000\000\000\000\000\000\000000"
+/* offset=3D130415 */ "DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, D=
Cache_L2_All)\000\000\000\000\000\000\000\000000"
+/* offset=3D130484 */ "DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss,=
 DCache_L2_All)\000\000\000\000\000\000\000\000000"
+/* offset=3D130555 */ "M1\000\000ipc + M2\000\000\000\000\000\000\000\0000=
00"
+/* offset=3D130578 */ "M2\000\000ipc + M1\000\000\000\000\000\000\000\0000=
00"
+/* offset=3D130601 */ "M3\000\0001 / M3\000\000\000\000\000\000\000\000000=
"
+/* offset=3D130622 */ "L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9=
 / duration_time\000\000\000\000\000\000\000\000000"
 ;
=20
 static const struct compact_pmu_event pmu_events__common_default_core[] =
=3D {
@@ -2615,17 +2615,17 @@ static const struct pmu_table_entry pmu_events__com=
mon[] =3D {
 };
=20
 static const struct compact_pmu_event pmu_metrics__common_default_core[] =
=3D {
-{ 127758 }, /* CPUs_utilized\000Default\000(software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@) / (duration_time * 1e9)\000\000Average CPU utilization\000\0001CPU=
s\000\000\000\00001 */
-{ 129068 }, /* backend_cycles_idle\000Default\000stalled\\-cycles\\-backen=
d / cpu\\-cycles\000backend_cycles_idle > 0.2\000Backend stalls per cycle\0=
00\000\000\000\000\00000 */
-{ 129368 }, /* branch_frequency\000Default\000branches / (software@cpu\\-c=
lock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,na=
me\\=3Dtask\\-clock@)\000\000Branches per CPU second\000\0001000M/sec\000\0=
00\000\00001 */
-{ 129547 }, /* branch_miss_rate\000Default\000branch\\-misses / branches\0=
00branch_miss_rate > 0.05\000Branch miss rate\000\000100%\000\000\000\00000=
 */
-{ 127943 }, /* cs_per_second\000Default\000software@context\\-switches\\,n=
ame\\=3Dcontext\\-switches@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-=
clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\=
000\000Context switches per CPU second\000\0001cs/sec\000\000\000\00001 */
-{ 129193 }, /* cycles_frequency\000Default\000cpu\\-cycles / (software@cpu=
\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\=
\,name\\=3Dtask\\-clock@)\000\000Cycles per CPU second\000\0001GHz\000\000\=
000\00001 */
-{ 128939 }, /* frontend_cycles_idle\000Default\000stalled\\-cycles\\-front=
end / cpu\\-cycles\000frontend_cycles_idle > 0.1\000Frontend stalls per cyc=
le\000\000\000\000\000\00000 */
-{ 128664 }, /* insn_per_cycle\000Default\000instructions / cpu\\-cycles\00=
0insn_per_cycle < 1\000Instructions Per Cycle\000\0001instructions\000\000\=
000\00000 */
-{ 128175 }, /* migrations_per_second\000Default\000software@cpu\\-migratio=
ns\\,name\\=3Dcpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcp=
u\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-cloc=
k@)\000\000Process migrations to a new CPU per CPU second\000\0001migration=
s/sec\000\000\000\00001 */
-{ 128434 }, /* page_faults_per_second\000Default\000software@page\\-faults=
\\,name\\=3Dpage\\-faults@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-c=
lock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\0=
00\000Page faults per CPU second\000\0001faults/sec\000\000\000\00001 */
-{ 128776 }, /* stalled_cycles_per_instruction\000Default\000max(stalled\\-=
cycles\\-frontend, stalled\\-cycles\\-backend) / instructions\000\000Max fr=
ont or backend stalls per instruction\000\000\000\000\000\00000 */
+{ 127758 }, /* CPUs_utilized\000Default\000(software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@) / (duration_time * 1e9)\000\000Average CPU utilization\000\0001CPU=
s\000\000\000\000011 */
+{ 129075 }, /* backend_cycles_idle\000Default\000stalled\\-cycles\\-backen=
d / cpu\\-cycles\000backend_cycles_idle > 0.2\000Backend stalls per cycle\0=
00\000\000\000\000\000001 */
+{ 129377 }, /* branch_frequency\000Default\000branches / (software@cpu\\-c=
lock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,na=
me\\=3Dtask\\-clock@)\000\000Branches per CPU second\000\0001000M/sec\000\0=
00\000\000011 */
+{ 129557 }, /* branch_miss_rate\000Default\000branch\\-misses / branches\0=
00branch_miss_rate > 0.05\000Branch miss rate\000\000100%\000\000\000\00000=
1 */
+{ 127944 }, /* cs_per_second\000Default\000software@context\\-switches\\,n=
ame\\=3Dcontext\\-switches@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-=
clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\=
000\000Context switches per CPU second\000\0001cs/sec\000\000\000\000011 */
+{ 129201 }, /* cycles_frequency\000Default\000cpu\\-cycles / (software@cpu=
\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\=
\,name\\=3Dtask\\-clock@)\000\000Cycles per CPU second\000\0001GHz\000\000\=
000\000011 */
+{ 128945 }, /* frontend_cycles_idle\000Default\000stalled\\-cycles\\-front=
end / cpu\\-cycles\000frontend_cycles_idle > 0.1\000Frontend stalls per cyc=
le\000\000\000\000\000\000001 */
+{ 128668 }, /* insn_per_cycle\000Default\000instructions / cpu\\-cycles\00=
0insn_per_cycle < 1\000Instructions Per Cycle\000\0001instructions\000\000\=
000\000001 */
+{ 128177 }, /* migrations_per_second\000Default\000software@cpu\\-migratio=
ns\\,name\\=3Dcpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcp=
u\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-cloc=
k@)\000\000Process migrations to a new CPU per CPU second\000\0001migration=
s/sec\000\000\000\000011 */
+{ 128437 }, /* page_faults_per_second\000Default\000software@page\\-faults=
\\,name\\=3Dpage\\-faults@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-c=
lock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\0=
00\000Page faults per CPU second\000\0001faults/sec\000\000\000\000011 */
+{ 128781 }, /* stalled_cycles_per_instruction\000Default\000max(stalled\\-=
cycles\\-frontend, stalled\\-cycles\\-backend) / instructions\000\000Max fr=
ont or backend stalls per instruction\000\000\000\000\000\000001 */
=20
 };
=20
@@ -2698,21 +2698,21 @@ static const struct pmu_table_entry pmu_events__tes=
t_soc_cpu[] =3D {
 };
=20
 static const struct compact_pmu_event pmu_metrics__test_soc_cpu_default_co=
re[] =3D {
-{ 129650 }, /* CPI\000\0001 / IPC\000\000\000\000\000\000\000\00000 */
-{ 130331 }, /* DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Mis=
s\000\000\000\000\000\000\000\00000 */
-{ 130103 }, /* DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_=
rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\00000 */
-{ 130197 }, /* DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd -=
 l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\000=
\000\000\000\000\000\000\00000 */
-{ 130395 }, /* DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2=
_All)\000\000\000\000\000\000\000\00000 */
-{ 130463 }, /* DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_=
L2_All)\000\000\000\000\000\000\000\00000 */
-{ 129735 }, /* Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 =
* (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active / =
cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\00000 */
-{ 129672 }, /* IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread=
\000\000\000\000\000\000\000\00000 */
-{ 130597 }, /* L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / durat=
ion_time\000\000\000\000\000\000\000\00000 */
-{ 130533 }, /* M1\000\000ipc + M2\000\000\000\000\000\000\000\00000 */
-{ 130555 }, /* M2\000\000ipc + M1\000\000\000\000\000\000\000\00000 */
-{ 130577 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\00000 */
-{ 130032 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_mis=
s_cycles\000\000\000\000\000\000\000\00000 */
-{ 129901 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.=
any\000\000\000\000\000\000\000\00000 */
-{ 129965 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retir=
ed.any\000\000\000\000\000\000\000\00000 */
+{ 129661 }, /* CPI\000\0001 / IPC\000\000\000\000\000\000\000\000000 */
+{ 130350 }, /* DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Mis=
s\000\000\000\000\000\000\000\000000 */
+{ 130120 }, /* DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_=
rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\000000 */
+{ 130215 }, /* DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd -=
 l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\000=
\000\000\000\000\000\000\000000 */
+{ 130415 }, /* DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2=
_All)\000\000\000\000\000\000\000\000000 */
+{ 130484 }, /* DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_=
L2_All)\000\000\000\000\000\000\000\000000 */
+{ 129748 }, /* Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 =
* (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active / =
cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\000000 */
+{ 129684 }, /* IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread=
\000\000\000\000\000\000\000\000000 */
+{ 130622 }, /* L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / durat=
ion_time\000\000\000\000\000\000\000\000000 */
+{ 130555 }, /* M1\000\000ipc + M2\000\000\000\000\000\000\000\000000 */
+{ 130578 }, /* M2\000\000ipc + M1\000\000\000\000\000\000\000\000000 */
+{ 130601 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\000000 */
+{ 130048 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_mis=
s_cycles\000\000\000\000\000\000\000\000000 */
+{ 129915 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.=
any\000\000\000\000\000\000\000\000000 */
+{ 129980 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retir=
ed.any\000\000\000\000\000\000\000\000000 */
=20
 };
=20
@@ -2894,6 +2894,8 @@ static void decompress_metric(int offset, struct pmu_=
metric *pm)
 	pm->aggr_mode =3D *p - '0';
 	p++;
 	pm->event_grouping =3D *p - '0';
+	p++;
+	pm->default_show_events =3D *p - '0';
 }
=20
 static int pmu_events_table__for_each_event_pmu(const struct pmu_events_ta=
ble *table,
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jeven=
ts.py
index 5d3f4b44cfb7..3413ee5d0227 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -58,10 +58,12 @@ _json_event_attributes =3D [
 _json_metric_attributes =3D [
     'metric_name', 'metric_group', 'metric_expr', 'metric_threshold',
     'desc', 'long_desc', 'unit', 'compat', 'metricgroup_no_group',
-    'default_metricgroup_name', 'aggr_mode', 'event_grouping'
+    'default_metricgroup_name', 'aggr_mode', 'event_grouping',
+    'default_show_events'
 ]
 # Attributes that are bools or enum int values, encoded as '0', '1',...
-_json_enum_attributes =3D ['aggr_mode', 'deprecated', 'event_grouping', 'p=
erpkg']
+_json_enum_attributes =3D ['aggr_mode', 'deprecated', 'event_grouping', 'p=
erpkg',
+                         'default_show_events']
=20
 def removesuffix(s: str, suffix: str) -> str:
   """Remove the suffix from a string
@@ -356,6 +358,7 @@ class JsonEvent:
     self.metricgroup_no_group =3D jd.get('MetricgroupNoGroup')
     self.default_metricgroup_name =3D jd.get('DefaultMetricgroupName')
     self.event_grouping =3D convert_metric_constraint(jd.get('MetricConstr=
aint'))
+    self.default_show_events =3D jd.get('DefaultShowEvents')
     self.metric_expr =3D None
     if 'MetricExpr' in jd:
       self.metric_expr =3D metric.ParsePerfJson(jd['MetricExpr']).Simplify=
()
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu=
-events.h
index 559265a903c8..d3b24014c6ff 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -74,6 +74,7 @@ struct pmu_metric {
 	const char *default_metricgroup_name;
 	enum aggr_mode_class aggr_mode;
 	enum metric_event_groups event_grouping;
+	bool default_show_events;
 };
=20
 struct pmu_events_table;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 71f74c7036ef..3ae4ac8f9a37 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -122,6 +122,7 @@ struct evsel {
 	bool			reset_group;
 	bool			needs_auxtrace_mmap;
 	bool			default_metricgroup; /* A member of the Default metricgroup */
+	bool			default_show_events; /* If a default group member, show the event =
*/
 	bool			needs_uniquify;
 	struct hashmap		*per_pkg_mask;
 	int			err;
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index e67e04ce01c9..25c75fdbfc52 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -152,6 +152,8 @@ struct metric {
 	 * Should events of the metric be grouped?
 	 */
 	bool group_events;
+	/** Show events even if in the Default metric group. */
+	bool default_show_events;
 	/**
 	 * Parsed events for the metric. Optional as events may be taken from a
 	 * different metric whose group contains all the IDs necessary for this
@@ -255,6 +257,7 @@ static struct metric *metric__new(const struct pmu_metr=
ic *pm,
 	m->pctx->sctx.runtime =3D runtime;
 	m->pctx->sctx.system_wide =3D system_wide;
 	m->group_events =3D !metric_no_group && metric__group_events(pm, metric_n=
o_threshold);
+	m->default_show_events =3D pm->default_show_events;
 	m->metric_refs =3D NULL;
 	m->evlist =3D NULL;
=20
@@ -1513,6 +1516,16 @@ static int parse_groups(struct evlist *perf_evlist,
 			free(metric_events);
 			goto out;
 		}
+		if (m->default_show_events) {
+			struct evsel *pos;
+
+			for (int i =3D 0; metric_events[i]; i++)
+				metric_events[i]->default_show_events =3D true;
+			evlist__for_each_entry(metric_evlist, pos) {
+				if (pos->metric_leader && pos->metric_leader->default_show_events)
+					pos->default_show_events =3D true;
+			}
+		}
 		expr->metric_threshold =3D m->metric_threshold;
 		expr->metric_unit =3D m->metric_unit;
 		expr->metric_events =3D metric_events;
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.=
c
index a67b991f4e81..4d0e353846ea 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -872,7 +872,7 @@ static void printout(struct perf_stat_config *config, s=
truct outstate *os,
 	out.ctx =3D os;
 	out.force_header =3D false;
=20
-	if (!config->metric_only && !counter->default_metricgroup) {
+	if (!config->metric_only && (!counter->default_metricgroup || counter->de=
fault_show_events)) {
 		abs_printout(config, os, os->id, os->aggr_nr, counter, uval, ok);
=20
 		print_noise(config, os, counter, noise, /*before_metric=3D*/true);
@@ -880,7 +880,7 @@ static void printout(struct perf_stat_config *config, s=
truct outstate *os,
 	}
=20
 	if (ok) {
-		if (!config->metric_only && counter->default_metricgroup) {
+		if (!config->metric_only && counter->default_metricgroup && !counter->de=
fault_show_events) {
 			void *from =3D NULL;
=20
 			aggr_printout(config, os, os->evsel, os->id, os->aggr_nr);
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index abaf6b579bfc..4df614f8e200 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -665,7 +665,7 @@ void *perf_stat__print_shadow_stats_metricgroup(struct =
perf_stat_config *config,
 			if (strcmp(name, mexp->default_metricgroup_name))
 				return (void *)mexp;
 			/* Only print the name of the metricgroup once */
-			if (!header_printed) {
+			if (!header_printed && !evsel->default_show_events) {
 				header_printed =3D true;
 				perf_stat__print_metricgroup_header(config, evsel, ctxp,
 								    name, out);
--=20
2.51.2.1041.gc1ab5b90ca-goog

