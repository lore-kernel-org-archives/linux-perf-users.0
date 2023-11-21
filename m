Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TmuvYQsK"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADBF97
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Nov 2023 16:04:24 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5c994880223so30990657b3.0
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Nov 2023 16:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700525064; x=1701129864; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZCOnJaz0EAvoHbURgEibZw+mVElLQgmjJxMJmfh1m6s=;
        b=TmuvYQsKAJQJZzDkHKjz+BV8Uwe24eNYQq+mK8B1oFZb3bG8+WdF3roTc3A5wVLGg8
         rFTIrFK0j1iT8C83sRGVp+HrVkolOui2sCcsl698CTEQt31HcygZ9OpSC33at5h8Um0/
         0W8kZ9bzno0NJTQXj2PcC/2QWkui1DrTaXpjc8iUp+1XchkQExJAQqSJmRtxud1/heh5
         iAmv59qMd/rWDxqlNnlF+kcU97V30zNLoyt5nQTPak6uywMRKNINORT1sTfUTWNrk5PQ
         sCiq10qlcdkK1kEPRyek1XTt9Zz49VC9ayVhNjYNIpqd/BkN67LKgf6QmJ6tvishLVnB
         2iRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700525064; x=1701129864;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZCOnJaz0EAvoHbURgEibZw+mVElLQgmjJxMJmfh1m6s=;
        b=puVdZYAJKblBTW7qMfwmgkEzIU/l3l74ZqHb5cGEiLvPtnyF42BFnZtvfXRMRZ/Bf4
         AVEc3wQ0vVVjCTAKWKR4uv6mdYPvf/qMLkmYri6fudDlfVmkdoMAG1EexZ5fLrWUiymO
         LksPX8I/Br0E+zy++nPqLvQ+7Hv/bWsT1APt3P9vIwwt9FMuy8RwDaFIA0hPeAvpSjDH
         0V7xzwzR3d93rnWJ4RgOb2EGj4XH1ntF/WC8LhwMIU9tlL2D02boQyGc8vyR9l2mjcIh
         6UrPFe6Z+sRn4aqBIFjELOU/iy1LCguWx1kAtgN0UZS2jJJl74s5p8+eN/USG2bnbeXL
         O6aw==
X-Gm-Message-State: AOJu0YyM218+5Gy3YugyXpraSHWebSCWNFpYVWorsqYScZ/x0JN1zxWr
	RQkUYfpWgyqNIFrI8tcUPsJddlo22JIi
X-Google-Smtp-Source: AGHT+IGZuQayuCjQP5dz/h24rjY1hkIw1a8Z19AVZJreAbOPUa3gynFThusK5ZvC3dGpVbHo8Ov07h9bIRaB
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:9c08:6dab:5948:ab06])
 (user=irogers job=sendgmr) by 2002:a0d:c981:0:b0:59b:c811:a709 with SMTP id
 l123-20020a0dc981000000b0059bc811a709mr270383ywd.0.1700525063964; Mon, 20 Nov
 2023 16:04:23 -0800 (PST)
Date: Mon, 20 Nov 2023 16:04:20 -0800
Message-Id: <20231121000420.368075-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [RFC PATCH v2] perf evsel: Fallback to task-clock when not system wide
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Leo Yan <leo.yan@linaro.org>, 
	Sandipan Das <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ajay Kaher <akaher@vmware.com>, Alexey Makhalov <amakhalov@vmware.com>
Content-Type: text/plain; charset="UTF-8"

When the cycles event isn't available evsel will fallback to the
cpu-clock software event. task-clock is similar to cpu-clock but only
runs when the process is running. Falling back to cpu-clock when not
system wide leads to confusion, by falling back to task-clock it is
hoped the confusion is less.

Pass the target to determine if task-clock is more appropriate. Update
a nearby comment and debug string for the change.

---
v2. Use target__has_cpu as suggested by Namhyung.
https://lpc.events/event/17/contributions/1556/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c |  2 +-
 tools/perf/builtin-stat.c   |  2 +-
 tools/perf/builtin-top.c    |  2 +-
 tools/perf/util/evsel.c     | 18 ++++++++++--------
 tools/perf/util/evsel.h     |  3 ++-
 5 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 8ec818568662..d8bb59511fdd 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1350,7 +1350,7 @@ static int record__open(struct record *rec)
 	evlist__for_each_entry(evlist, pos) {
 try_again:
 		if (evsel__open(pos, pos->core.cpus, pos->core.threads) < 0) {
-			if (evsel__fallback(pos, errno, msg, sizeof(msg))) {
+			if (evsel__fallback(pos, &opts->target, errno, msg, sizeof(msg))) {
 				if (verbose > 0)
 					ui__warning("%s\n", msg);
 				goto try_again;
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index a3af805a1d57..d8e5d6f7a87a 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -653,7 +653,7 @@ static enum counter_recovery stat_handle_error(struct evsel *counter)
 		if ((evsel__leader(counter) != counter) ||
 		    !(counter->core.leader->nr_members > 1))
 			return COUNTER_SKIP;
-	} else if (evsel__fallback(counter, errno, msg, sizeof(msg))) {
+	} else if (evsel__fallback(counter, &target, errno, msg, sizeof(msg))) {
 		if (verbose > 0)
 			ui__warning("%s\n", msg);
 		return COUNTER_RETRY;
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index ea8c7eca5eee..1e42bd1c7d5a 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1044,7 +1044,7 @@ static int perf_top__start_counters(struct perf_top *top)
 			    perf_top_overwrite_fallback(top, counter))
 				goto try_again;
 
-			if (evsel__fallback(counter, errno, msg, sizeof(msg))) {
+			if (evsel__fallback(counter, &opts->target, errno, msg, sizeof(msg))) {
 				if (verbose > 0)
 					ui__warning("%s\n", msg);
 				goto try_again;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index a5da74e3a517..532f34d9fcb5 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2853,7 +2853,8 @@ u64 evsel__intval_common(struct evsel *evsel, struct perf_sample *sample, const
 
 #endif
 
-bool evsel__fallback(struct evsel *evsel, int err, char *msg, size_t msgsize)
+bool evsel__fallback(struct evsel *evsel, struct target *target, int err,
+		     char *msg, size_t msgsize)
 {
 	int paranoid;
 
@@ -2861,18 +2862,19 @@ bool evsel__fallback(struct evsel *evsel, int err, char *msg, size_t msgsize)
 	    evsel->core.attr.type   == PERF_TYPE_HARDWARE &&
 	    evsel->core.attr.config == PERF_COUNT_HW_CPU_CYCLES) {
 		/*
-		 * If it's cycles then fall back to hrtimer based
-		 * cpu-clock-tick sw counter, which is always available even if
-		 * no PMU support.
+		 * If it's cycles then fall back to hrtimer based cpu-clock sw
+		 * counter, which is always available even if no PMU support.
 		 *
 		 * PPC returns ENXIO until 2.6.37 (behavior changed with commit
 		 * b0a873e).
 		 */
-		scnprintf(msg, msgsize, "%s",
-"The cycles event is not supported, trying to fall back to cpu-clock-ticks");
-
 		evsel->core.attr.type   = PERF_TYPE_SOFTWARE;
-		evsel->core.attr.config = PERF_COUNT_SW_CPU_CLOCK;
+		evsel->core.attr.config = target__has_cpu(target)
+			? PERF_COUNT_SW_CPU_CLOCK
+			: PERF_COUNT_SW_TASK_CLOCK;
+		scnprintf(msg, msgsize,
+			"The cycles event is not supported, trying to fall back to %s",
+			target__has_cpu(target) ? "cpu-clock" : "task-clock");
 
 		zfree(&evsel->name);
 		return true;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index f19ac9f027ef..efbb6e848287 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -460,7 +460,8 @@ static inline bool evsel__is_clock(const struct evsel *evsel)
 	       evsel__match(evsel, SOFTWARE, SW_TASK_CLOCK);
 }
 
-bool evsel__fallback(struct evsel *evsel, int err, char *msg, size_t msgsize);
+bool evsel__fallback(struct evsel *evsel, struct target *target, int err,
+		     char *msg, size_t msgsize);
 int evsel__open_strerror(struct evsel *evsel, struct target *target,
 			 int err, char *msg, size_t size);
 
-- 
2.43.0.rc1.413.gea7ed67945-goog

