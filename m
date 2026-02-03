Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0A537D108
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Feb 2026 22:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770159113; cv=none; b=khaUPv0eAtmf7qyvj6knkzIj3TCvmuXMUvvvsLLFqZTYhq3uOVZfUtOF5PAiULyE1KnXtyjHErMkRLFKrpnFzdTfo70L+fwbuQgQ0TR7cuC1VuwXtoxyE6PGsBxc1wBTnoTqPqIqPl7g6EXUWgZ/SekR6WakSAJJP96BUGxxLU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770159113; c=relaxed/simple;
	bh=nMCvD9FhHWv6QXJohgSpbLwo660AjijJtxk2b8JgbNs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=F3g7kMh+WWFYI7gtdM8rCYZR3CsnoTgt5SgDAyYnVdETdyxoPl2mVgbu2JW0597ko9AOt/kqBeQH7PYP8FoV3TFu8HGejRGRE00f1/Zflz+sUxbS/Nk8C86UCL8TU6tqQk3Z7rgu4l+WWnrmjfEGqctjqnQ4XOr9K+us/dg0nNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z/BEwuDT; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z/BEwuDT"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-124a95d580cso1903702c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Feb 2026 14:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770159111; x=1770763911; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LBr6QtiTmPDnDtdThT9x1EHn8qfDN4a5mvSafr0ZxaM=;
        b=Z/BEwuDTBHurfLXQQL8lkHFoPTVyHkK/ksWU+BHWDxbOL2Z0sa1sVG4GVwnuufw8DN
         9KNFyeZiE4MerUm0iRdXIAHgQeIIPwSR5G5759KFkGy7EezmGT+aXKjBLdQ6EkEMCfzM
         layXprS7p/5plsvzFFQajzR47pnZt/XbpcuM/6BwXTdzVnQ0SXwuaM1x/C2hHErXf/Ma
         +z9Ogl0aEu8MX2IoWBC5Lk5Z289cXnnjZUv2pYbq/qAJoTbXL9FAnOUQN8otGi659LDM
         S8ZWo3vAfvd+k4sqAuMWW5Jy59I5hRdCx56Nc/4nZ0hDtuCRI8USxItNFIhSHaB0p00l
         8TSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770159111; x=1770763911;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LBr6QtiTmPDnDtdThT9x1EHn8qfDN4a5mvSafr0ZxaM=;
        b=EHM6wJdJaMRKkaSjckgXRJkY+ZuCp9KV17S6YsWBggvtPPRhAQEabykmYdBc2dIKmo
         Gi99dHNpl2fCISA2me11FLA0gJHTau1wKc2qxcp5JuiIn9tsOx7MWhd78S60lNWoYUjN
         0yLmZT58zU4jViJHG0vUOURGVitegIvchOcEkPyrk0LIsJQIhNPSV6be/OrvdS0nIRXb
         jQsdeqEW3DRHw4BIOBWv7hPxsuh0cbNbf1J2d/39RMd+8YsT+LP2p904p3M4EZqNhzh5
         suMuoT/ySmkcRoZhIRsQlpSd9HhGxC1lqFVlWwK3qFwbsgSv3bfIcKlmcrLMRj5Mbq3m
         /QVA==
X-Forwarded-Encrypted: i=1; AJvYcCVnqmOIVVoVk/E5/5/RgIqydM+u7orY8jg9QfHRrYE+AsBm0hHI8tn6eGvBVtEXHE6ixtPqJrXYhh2CR5s/HhEy@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5CtdpXv9/Qg/h4DU7slxXaEGFOcJY4Y+apE54tazRouxP/Nua
	ehEpnO+a474QzvJtPT8ZHj/oIEXpt7LXo4x7fOwBWwTT9zsYiQbmbiNU0/SGNiHcPILIRCACa3n
	oKalRrES1BQ==
X-Received: from dlzz28.prod.google.com ([2002:a05:7022:49c:b0:124:9694:5535])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:10d:b0:11b:88a7:e1b0
 with SMTP id a92af1059eb24-126f47bd1e8mr462228c88.26.1770159110756; Tue, 03
 Feb 2026 14:51:50 -0800 (PST)
Date: Tue,  3 Feb 2026 14:51:28 -0800
In-Reply-To: <20260203225129.4077140-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260203225129.4077140-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260203225129.4077140-6-irogers@google.com>
Subject: [PATCH v7 5/6] perf evlist: Reduce affinity use and move into
 iterator, fix no affinity
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Yang Li <yang.lee@linux.alibaba.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Andres Freund <andres@anarazel.de>
Content-Type: text/plain; charset="UTF-8"

The evlist__for_each_cpu iterator will call sched_setaffitinity when
moving between CPUs to avoid IPIs. If only 1 IPI is saved then this
may be unprofitable as the delay to get scheduled may be
considerable. This may be particularly true if reading an event group
in `perf stat` in interval mode.

Move the affinity handling completely into the iterator so that a
single evlist__use_affinity can determine whether CPU affinities will
be used. For `perf record` the change is minimal as the dummy event
and the real event will always make the use of affinities the thing to
do. In `perf stat`, tool events are ignored and affinities only used
if >1 event on the same CPU occur. Determining if affinities are
useful is done by evlist__use_affinity which tests per-event whether
the event's PMU benefits from affinity use - it is assumed only perf
event using PMUs do.

Fix a bug where when there are no affinities that the CPU map iterator
may reference a CPU not present in the initial evsel. Fix by making
the iterator and non-iterator code common.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 108 +++++++++++---------------
 tools/perf/util/evlist.c  | 158 +++++++++++++++++++++++---------------
 tools/perf/util/evlist.h  |  26 +++++--
 tools/perf/util/pmu.c     |  12 +++
 tools/perf/util/pmu.h     |   1 +
 5 files changed, 174 insertions(+), 131 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 2895b809607f..c1bb40b99176 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -369,19 +369,11 @@ static int read_counter_cpu(struct evsel *counter, int cpu_map_idx)
 static int read_counters_with_affinity(void)
 {
 	struct evlist_cpu_iterator evlist_cpu_itr;
-	struct affinity saved_affinity, *affinity;
 
 	if (all_counters_use_bpf)
 		return 0;
 
-	if (!target__has_cpu(&target) || target__has_per_thread(&target))
-		affinity = NULL;
-	else if (affinity__setup(&saved_affinity) < 0)
-		return -1;
-	else
-		affinity = &saved_affinity;
-
-	evlist__for_each_cpu(evlist_cpu_itr, evsel_list, affinity) {
+	evlist__for_each_cpu(evlist_cpu_itr, evsel_list) {
 		struct evsel *counter = evlist_cpu_itr.evsel;
 
 		if (evsel__is_bpf(counter))
@@ -393,8 +385,6 @@ static int read_counters_with_affinity(void)
 		if (!counter->err)
 			counter->err = read_counter_cpu(counter, evlist_cpu_itr.cpu_map_idx);
 	}
-	if (affinity)
-		affinity__cleanup(&saved_affinity);
 
 	return 0;
 }
@@ -793,7 +783,6 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	const bool forks = (argc > 0);
 	bool is_pipe = STAT_RECORD ? perf_stat.data.is_pipe : false;
 	struct evlist_cpu_iterator evlist_cpu_itr;
-	struct affinity saved_affinity, *affinity = NULL;
 	int err, open_err = 0;
 	bool second_pass = false, has_supported_counters;
 
@@ -805,14 +794,6 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		child_pid = evsel_list->workload.pid;
 	}
 
-	if (!cpu_map__is_dummy(evsel_list->core.user_requested_cpus)) {
-		if (affinity__setup(&saved_affinity) < 0) {
-			err = -1;
-			goto err_out;
-		}
-		affinity = &saved_affinity;
-	}
-
 	evlist__for_each_entry(evsel_list, counter) {
 		counter->reset_group = false;
 		if (bpf_counter__load(counter, &target)) {
@@ -825,49 +806,48 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 
 	evlist__reset_aggr_stats(evsel_list);
 
-	evlist__for_each_cpu(evlist_cpu_itr, evsel_list, affinity) {
-		counter = evlist_cpu_itr.evsel;
+	/*
+	 * bperf calls evsel__open_per_cpu() in bperf__load(), so
+	 * no need to call it again here.
+	 */
+	if (!target.use_bpf) {
+		evlist__for_each_cpu(evlist_cpu_itr, evsel_list) {
+			counter = evlist_cpu_itr.evsel;
 
-		/*
-		 * bperf calls evsel__open_per_cpu() in bperf__load(), so
-		 * no need to call it again here.
-		 */
-		if (target.use_bpf)
-			break;
+			if (counter->reset_group || !counter->supported)
+				continue;
+			if (evsel__is_bperf(counter))
+				continue;
 
-		if (counter->reset_group || !counter->supported)
-			continue;
-		if (evsel__is_bperf(counter))
-			continue;
+			while (true) {
+				if (create_perf_stat_counter(counter, &stat_config,
+							      evlist_cpu_itr.cpu_map_idx) == 0)
+					break;
 
-		while (true) {
-			if (create_perf_stat_counter(counter, &stat_config,
-						     evlist_cpu_itr.cpu_map_idx) == 0)
-				break;
+				open_err = errno;
+				/*
+				 * Weak group failed. We cannot just undo this
+				 * here because earlier CPUs might be in group
+				 * mode, and the kernel doesn't support mixing
+				 * group and non group reads. Defer it to later.
+				 * Don't close here because we're in the wrong
+				 * affinity.
+				 */
+				if ((open_err == EINVAL || open_err == EBADF) &&
+					evsel__leader(counter) != counter &&
+					counter->weak_group) {
+					evlist__reset_weak_group(evsel_list, counter, false);
+					assert(counter->reset_group);
+					counter->supported = true;
+					second_pass = true;
+					break;
+				}
 
-			open_err = errno;
-			/*
-			 * Weak group failed. We cannot just undo this here
-			 * because earlier CPUs might be in group mode, and the kernel
-			 * doesn't support mixing group and non group reads. Defer
-			 * it to later.
-			 * Don't close here because we're in the wrong affinity.
-			 */
-			if ((open_err == EINVAL || open_err == EBADF) &&
-				evsel__leader(counter) != counter &&
-				counter->weak_group) {
-				evlist__reset_weak_group(evsel_list, counter, false);
-				assert(counter->reset_group);
-				counter->supported = true;
-				second_pass = true;
-				break;
+				if (stat_handle_error(counter, open_err) != COUNTER_RETRY)
+					break;
 			}
-
-			if (stat_handle_error(counter, open_err) != COUNTER_RETRY)
-				break;
 		}
 	}
-
 	if (second_pass) {
 		/*
 		 * Now redo all the weak group after closing them,
@@ -875,7 +855,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		 */
 
 		/* First close errored or weak retry */
-		evlist__for_each_cpu(evlist_cpu_itr, evsel_list, affinity) {
+		evlist__for_each_cpu(evlist_cpu_itr, evsel_list) {
 			counter = evlist_cpu_itr.evsel;
 
 			if (!counter->reset_group && counter->supported)
@@ -884,7 +864,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 			perf_evsel__close_cpu(&counter->core, evlist_cpu_itr.cpu_map_idx);
 		}
 		/* Now reopen weak */
-		evlist__for_each_cpu(evlist_cpu_itr, evsel_list, affinity) {
+		evlist__for_each_cpu(evlist_cpu_itr, evsel_list) {
 			counter = evlist_cpu_itr.evsel;
 
 			if (!counter->reset_group)
@@ -893,17 +873,18 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 			while (true) {
 				pr_debug2("reopening weak %s\n", evsel__name(counter));
 				if (create_perf_stat_counter(counter, &stat_config,
-							     evlist_cpu_itr.cpu_map_idx) == 0)
+							     evlist_cpu_itr.cpu_map_idx) == 0) {
+					evlist_cpu_iterator__exit(&evlist_cpu_itr);
 					break;
-
+				}
 				open_err = errno;
-				if (stat_handle_error(counter, open_err) != COUNTER_RETRY)
+				if (stat_handle_error(counter, open_err) != COUNTER_RETRY) {
+					evlist_cpu_iterator__exit(&evlist_cpu_itr);
 					break;
+				}
 			}
 		}
 	}
-	affinity__cleanup(affinity);
-	affinity = NULL;
 
 	has_supported_counters = false;
 	evlist__for_each_entry(evsel_list, counter) {
@@ -1065,7 +1046,6 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	if (forks)
 		evlist__cancel_workload(evsel_list);
 
-	affinity__cleanup(affinity);
 	return err;
 }
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 3abc2215e790..45833244daf3 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -359,36 +359,111 @@ int evlist__add_newtp(struct evlist *evlist, const char *sys, const char *name,
 }
 #endif
 
-struct evlist_cpu_iterator evlist__cpu_begin(struct evlist *evlist, struct affinity *affinity)
+/*
+ * Should sched_setaffinity be used with evlist__for_each_cpu? Determine if
+ * migrating the thread will avoid possibly numerous IPIs.
+ */
+static bool evlist__use_affinity(struct evlist *evlist)
+{
+	struct evsel *pos;
+	struct perf_cpu_map *used_cpus = NULL;
+	bool ret = false;
+
+	/*
+	 * With perf record core.user_requested_cpus is usually NULL.
+	 * Use the old method to handle this for now.
+	 */
+	if (!evlist->core.user_requested_cpus ||
+	    cpu_map__is_dummy(evlist->core.user_requested_cpus))
+		return false;
+
+	evlist__for_each_entry(evlist, pos) {
+		struct perf_cpu_map *intersect;
+
+		if (!perf_pmu__benefits_from_affinity(pos->pmu))
+			continue;
+
+		if (evsel__is_dummy_event(pos)) {
+			/*
+			 * The dummy event is opened on all CPUs so assume >1
+			 * event with shared CPUs.
+			 */
+			ret = true;
+			break;
+		}
+		if (evsel__is_retire_lat(pos)) {
+			/*
+			 * Retirement latency events are similar to tool ones in
+			 * their implementation, and so don't require affinity.
+			 */
+			continue;
+		}
+		if (perf_cpu_map__is_empty(used_cpus)) {
+			/* First benefitting event, we want >1 on a common CPU. */
+			used_cpus = perf_cpu_map__get(pos->core.cpus);
+			continue;
+		}
+		if ((pos->core.attr.read_format & PERF_FORMAT_GROUP) &&
+		    evsel__leader(pos) != pos) {
+			/* Skip members of the same sample group. */
+			continue;
+		}
+		intersect = perf_cpu_map__intersect(used_cpus, pos->core.cpus);
+		if (!perf_cpu_map__is_empty(intersect)) {
+			/* >1 event with shared CPUs. */
+			perf_cpu_map__put(intersect);
+			ret = true;
+			break;
+		}
+		perf_cpu_map__put(intersect);
+		perf_cpu_map__merge(&used_cpus, pos->core.cpus);
+	}
+	perf_cpu_map__put(used_cpus);
+	return ret;
+}
+
+void evlist_cpu_iterator__init(struct evlist_cpu_iterator *itr, struct evlist *evlist)
 {
-	struct evlist_cpu_iterator itr = {
+	*itr = (struct evlist_cpu_iterator){
 		.container = evlist,
 		.evsel = NULL,
 		.cpu_map_idx = 0,
 		.evlist_cpu_map_idx = 0,
 		.evlist_cpu_map_nr = perf_cpu_map__nr(evlist->core.all_cpus),
 		.cpu = (struct perf_cpu){ .cpu = -1},
-		.affinity = affinity,
+		.affinity = NULL,
 	};
 
 	if (evlist__empty(evlist)) {
 		/* Ensure the empty list doesn't iterate. */
-		itr.evlist_cpu_map_idx = itr.evlist_cpu_map_nr;
-	} else {
-		itr.evsel = evlist__first(evlist);
-		if (itr.affinity) {
-			itr.cpu = perf_cpu_map__cpu(evlist->core.all_cpus, 0);
-			affinity__set(itr.affinity, itr.cpu.cpu);
-			itr.cpu_map_idx = perf_cpu_map__idx(itr.evsel->core.cpus, itr.cpu);
-			/*
-			 * If this CPU isn't in the evsel's cpu map then advance
-			 * through the list.
-			 */
-			if (itr.cpu_map_idx == -1)
-				evlist_cpu_iterator__next(&itr);
-		}
+		itr->evlist_cpu_map_idx = itr->evlist_cpu_map_nr;
+		return;
 	}
-	return itr;
+
+	if (evlist__use_affinity(evlist)) {
+		if (affinity__setup(&itr->saved_affinity) == 0)
+			itr->affinity = &itr->saved_affinity;
+	}
+	itr->evsel = evlist__first(evlist);
+	itr->cpu = perf_cpu_map__cpu(evlist->core.all_cpus, 0);
+	if (itr->affinity)
+		affinity__set(itr->affinity, itr->cpu.cpu);
+	itr->cpu_map_idx = perf_cpu_map__idx(itr->evsel->core.cpus, itr->cpu);
+	/*
+	 * If this CPU isn't in the evsel's cpu map then advance
+	 * through the list.
+	 */
+	if (itr->cpu_map_idx == -1)
+		evlist_cpu_iterator__next(itr);
+}
+
+void evlist_cpu_iterator__exit(struct evlist_cpu_iterator *itr)
+{
+	if (!itr->affinity)
+		return;
+
+	affinity__cleanup(itr->affinity);
+	itr->affinity = NULL;
 }
 
 void evlist_cpu_iterator__next(struct evlist_cpu_iterator *evlist_cpu_itr)
@@ -418,14 +493,11 @@ void evlist_cpu_iterator__next(struct evlist_cpu_iterator *evlist_cpu_itr)
 		 */
 		if (evlist_cpu_itr->cpu_map_idx == -1)
 			evlist_cpu_iterator__next(evlist_cpu_itr);
+	} else {
+		evlist_cpu_iterator__exit(evlist_cpu_itr);
 	}
 }
 
-bool evlist_cpu_iterator__end(const struct evlist_cpu_iterator *evlist_cpu_itr)
-{
-	return evlist_cpu_itr->evlist_cpu_map_idx >= evlist_cpu_itr->evlist_cpu_map_nr;
-}
-
 static int evsel__strcmp(struct evsel *pos, char *evsel_name)
 {
 	if (!evsel_name)
@@ -453,19 +525,11 @@ static void __evlist__disable(struct evlist *evlist, char *evsel_name, bool excl
 {
 	struct evsel *pos;
 	struct evlist_cpu_iterator evlist_cpu_itr;
-	struct affinity saved_affinity, *affinity = NULL;
 	bool has_imm = false;
 
-	// See explanation in evlist__close()
-	if (!cpu_map__is_dummy(evlist->core.user_requested_cpus)) {
-		if (affinity__setup(&saved_affinity) < 0)
-			return;
-		affinity = &saved_affinity;
-	}
-
 	/* Disable 'immediate' events last */
 	for (int imm = 0; imm <= 1; imm++) {
-		evlist__for_each_cpu(evlist_cpu_itr, evlist, affinity) {
+		evlist__for_each_cpu(evlist_cpu_itr, evlist) {
 			pos = evlist_cpu_itr.evsel;
 			if (evsel__strcmp(pos, evsel_name))
 				continue;
@@ -483,7 +547,6 @@ static void __evlist__disable(struct evlist *evlist, char *evsel_name, bool excl
 			break;
 	}
 
-	affinity__cleanup(affinity);
 	evlist__for_each_entry(evlist, pos) {
 		if (evsel__strcmp(pos, evsel_name))
 			continue;
@@ -523,16 +586,8 @@ static void __evlist__enable(struct evlist *evlist, char *evsel_name, bool excl_
 {
 	struct evsel *pos;
 	struct evlist_cpu_iterator evlist_cpu_itr;
-	struct affinity saved_affinity, *affinity = NULL;
 
-	// See explanation in evlist__close()
-	if (!cpu_map__is_dummy(evlist->core.user_requested_cpus)) {
-		if (affinity__setup(&saved_affinity) < 0)
-			return;
-		affinity = &saved_affinity;
-	}
-
-	evlist__for_each_cpu(evlist_cpu_itr, evlist, affinity) {
+	evlist__for_each_cpu(evlist_cpu_itr, evlist) {
 		pos = evlist_cpu_itr.evsel;
 		if (evsel__strcmp(pos, evsel_name))
 			continue;
@@ -542,7 +597,6 @@ static void __evlist__enable(struct evlist *evlist, char *evsel_name, bool excl_
 			continue;
 		evsel__enable_cpu(pos, evlist_cpu_itr.cpu_map_idx);
 	}
-	affinity__cleanup(affinity);
 	evlist__for_each_entry(evlist, pos) {
 		if (evsel__strcmp(pos, evsel_name))
 			continue;
@@ -1339,30 +1393,14 @@ void evlist__close(struct evlist *evlist)
 {
 	struct evsel *evsel;
 	struct evlist_cpu_iterator evlist_cpu_itr;
-	struct affinity affinity;
-
-	/*
-	 * With perf record core.user_requested_cpus is usually NULL.
-	 * Use the old method to handle this for now.
-	 */
-	if (!evlist->core.user_requested_cpus ||
-	    cpu_map__is_dummy(evlist->core.user_requested_cpus)) {
-		evlist__for_each_entry_reverse(evlist, evsel)
-			evsel__close(evsel);
-		return;
-	}
-
-	if (affinity__setup(&affinity) < 0)
-		return;
 
-	evlist__for_each_cpu(evlist_cpu_itr, evlist, &affinity) {
+	evlist__for_each_cpu(evlist_cpu_itr, evlist) {
 		if (evlist_cpu_itr.cpu_map_idx == 0 && evsel__is_retire_lat(evlist_cpu_itr.evsel))
 			evsel__tpebs_close(evlist_cpu_itr.evsel);
 		perf_evsel__close_cpu(&evlist_cpu_itr.evsel->core,
 				      evlist_cpu_itr.cpu_map_idx);
 	}
 
-	affinity__cleanup(&affinity);
 	evlist__for_each_entry_reverse(evlist, evsel) {
 		perf_evsel__free_fd(&evsel->core);
 		perf_evsel__free_id(&evsel->core);
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 911834ae7c2a..30dff7484d3c 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -10,6 +10,7 @@
 #include <internal/evlist.h>
 #include <internal/evsel.h>
 #include <perf/evlist.h>
+#include "affinity.h"
 #include "events_stats.h"
 #include "evsel.h"
 #include "rblist.h"
@@ -363,6 +364,8 @@ struct evlist_cpu_iterator {
 	struct perf_cpu cpu;
 	/** If present, used to set the affinity when switching between CPUs. */
 	struct affinity *affinity;
+	/** Maybe be used to hold affinity state prior to iterating. */
+	struct affinity saved_affinity;
 };
 
 /**
@@ -370,22 +373,31 @@ struct evlist_cpu_iterator {
  *                        affinity, iterate over all CPUs and then the evlist
  *                        for each evsel on that CPU. When switching between
  *                        CPUs the affinity is set to the CPU to avoid IPIs
- *                        during syscalls.
+ *                        during syscalls. The affinity is set up and removed
+ *                        automatically, if the loop is broken a call to
+ *                        evlist_cpu_iterator__exit is necessary.
  * @evlist_cpu_itr: the iterator instance.
  * @evlist: evlist instance to iterate.
- * @affinity: NULL or used to set the affinity to the current CPU.
  */
-#define evlist__for_each_cpu(evlist_cpu_itr, evlist, affinity)		\
-	for ((evlist_cpu_itr) = evlist__cpu_begin(evlist, affinity);	\
+#define evlist__for_each_cpu(evlist_cpu_itr, evlist)			\
+	for (evlist_cpu_iterator__init(&(evlist_cpu_itr), evlist);	\
 	     !evlist_cpu_iterator__end(&evlist_cpu_itr);		\
 	     evlist_cpu_iterator__next(&evlist_cpu_itr))
 
-/** Returns an iterator set to the first CPU/evsel of evlist. */
-struct evlist_cpu_iterator evlist__cpu_begin(struct evlist *evlist, struct affinity *affinity);
+/** Setup an iterator set to the first CPU/evsel of evlist. */
+void evlist_cpu_iterator__init(struct evlist_cpu_iterator *itr, struct evlist *evlist);
+/**
+ * Cleans up the iterator, automatically done by evlist_cpu_iterator__next when
+ * the end of the list is reached. Multiple calls are safe.
+ */
+void evlist_cpu_iterator__exit(struct evlist_cpu_iterator *itr);
 /** Move to next element in iterator, updating CPU, evsel and the affinity. */
 void evlist_cpu_iterator__next(struct evlist_cpu_iterator *evlist_cpu_itr);
 /** Returns true when iterator is at the end of the CPUs and evlist. */
-bool evlist_cpu_iterator__end(const struct evlist_cpu_iterator *evlist_cpu_itr);
+static inline bool evlist_cpu_iterator__end(const struct evlist_cpu_iterator *evlist_cpu_itr)
+{
+	return evlist_cpu_itr->evlist_cpu_map_idx >= evlist_cpu_itr->evlist_cpu_map_nr;
+}
 
 struct evsel *evlist__get_tracking_event(struct evlist *evlist);
 void evlist__set_tracking_event(struct evlist *evlist, struct evsel *tracking_evsel);
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 81ab74681c9b..5cdd350e8885 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -2375,6 +2375,18 @@ bool perf_pmu__is_software(const struct perf_pmu *pmu)
 	return false;
 }
 
+bool perf_pmu__benefits_from_affinity(struct perf_pmu *pmu)
+{
+	if (!pmu)
+		return true; /* Assume is core. */
+
+	/*
+	 * All perf event PMUs should benefit from accessing the perf event
+	 * contexts on the local CPU.
+	 */
+	return pmu->type <= PERF_PMU_TYPE_PE_END;
+}
+
 FILE *perf_pmu__open_file(const struct perf_pmu *pmu, const char *name)
 {
 	char path[PATH_MAX];
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 41c21389f393..0d9f3c57e8e8 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -303,6 +303,7 @@ bool perf_pmu__name_no_suffix_match(const struct perf_pmu *pmu, const char *to_m
  *                        perf_sw_context in the kernel?
  */
 bool perf_pmu__is_software(const struct perf_pmu *pmu);
+bool perf_pmu__benefits_from_affinity(struct perf_pmu *pmu);
 
 FILE *perf_pmu__open_file(const struct perf_pmu *pmu, const char *name);
 FILE *perf_pmu__open_file_at(const struct perf_pmu *pmu, int dirfd, const char *name);
-- 
2.53.0.rc2.204.g2597b5adb4-goog

