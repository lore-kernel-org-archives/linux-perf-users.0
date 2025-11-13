Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A958C35BDBC
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 18:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763057161; cv=none; b=l5YRIes+Q7TnHcbJffVUQNl8nbAPLBG9VkoLLlSOcvKkDCzz8oclooViEY61a4Z8cp5HBLCP8XK2TSeb8BqDokU7a6kkpkqq5UOjM1qL4jmN/tLz4gT+Yl4TPxTrNWJqb7c6okjYfyQJDZkYeW9eivBlo1Oi3N1IdA+0Qov35Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763057161; c=relaxed/simple;
	bh=tOCRp6q8cU4TvS3BW3hxq4YfZFgatWkJuBOP3VOz8ss=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=IXv+WqDnsmCr5h0wCMM0FTHjjuZn4ondXo4osfEIlCaUjgk1TK+J2wiSdgtJx1ypNt7w6jWV9cWPCDPtOLvPu8rQOKbQVD04PwPiRaMtIn8Zj0LZue/+VuGUUDbK/Lmy7ezcBxDZZ3u34kg97mwEP3CxcnZtY9IK1kvVcGrArBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CZd7IqWD; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CZd7IqWD"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-bc0de474d4eso2284673a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 10:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763057159; x=1763661959; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F/LpTxscNWWRbaTmICukfm1cE/Qpboh07gAHjTodIzU=;
        b=CZd7IqWDtAk47dGGHBRcgWmqcprLVaVozudTCTul/QirWcbSX5rofJ5TAEvFAV1PYO
         7C0EGhPjQT90OecaxNQ9AgNv7svHvuzmT39ERFOX9ty6Vfggo9ZAOTtcimjLrp69uZQ8
         OCMdXBQKr1ga64vRpFdZ4AkiRLiULG6VjaYH54bJuTMbT2GsV68hIUZEDwad2HuuAfOl
         XwUtiSqiGdUb4Orv538ZENpggsiw8SZ/BJ/WT9h7rgdvd4T+X2jqPSt0fhid1fq8J4O4
         iZQ+TgxSKUbnK7dcPGOR78fniX8Y0n8k0yZoow4bYQS8WSW7Ym4WeOrKvnayQ6GoNb5x
         Nsag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763057159; x=1763661959;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F/LpTxscNWWRbaTmICukfm1cE/Qpboh07gAHjTodIzU=;
        b=VNrQwfqO/xySJigdiTx3bjDSG2y0edLS65BpYxBgYQo6pZrL9SzgLeGfbKugGnqcRI
         E77WBdFMiVCmzWco9mhG1l3TxwfLBFIGPg5StOQjYeImqk/W4LCtnUOdfGU2gG5lx2jO
         eCCDBZJO4MxSD0WFHppwcM81HLIrnxjLF1hQiRjnFtnr+x7xEqld6pI05ihlSkeLp+I+
         nzR6I6HtGo8rRkNHuiNfZi+NncIy9AmnLguk8FzA9mckAH6TD14Bj+Huj5ah4YiRRDQH
         aCdgvcpt5DrL32J8Nv5IdB2pDDt5ErP15cdshvPX4ezsVg5jDyWICC+/ndlk6b26Tj6l
         s/Ng==
X-Forwarded-Encrypted: i=1; AJvYcCV8Ys2Em024U9ZFG+pMVcELI6IXhRUT7Zj4SIHpGMvPrQi52JbwMVR+BcKJb5rlAarBdyuy11rhV+qVKMK8NJC6@vger.kernel.org
X-Gm-Message-State: AOJu0YyQkNp9how31UlEvHbJZ7V4dULPOuaIzGjFpu4lPgVcvv8mtNF0
	VIUtAhMqiwexnMIfA+g86ZvB3ppX1gDYuY/vFgMui0sKBox+B47GAR032onJifea0/auIYw2b8V
	ndoL67U22gg==
X-Google-Smtp-Source: AGHT+IFbMUItGVTF42dSaK9s8x3Bi3vZ2OPTsK+hudUOLg8fchArlJqAlFXzGG/D1iZ6tcyeB6nMmOxz8k9/
X-Received: from dybma14.prod.google.com ([2002:a05:7301:168e:b0:2a4:4843:eafd])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1288:b0:2a4:3592:cf6f
 with SMTP id 5a478bee46e88-2a4abb0328cmr151599eec.19.1763057159118; Thu, 13
 Nov 2025 10:05:59 -0800 (PST)
Date: Thu, 13 Nov 2025 10:05:14 -0800
In-Reply-To: <20251113180517.44096-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113180517.44096-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251113180517.44096-9-irogers@google.com>
Subject: [PATCH v4 08/10] perf evlist: Reduce affinity use and move into
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>
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
useful is done by per-event in a new PMU benefits from affinity
function.

Fix a bug where when there are no affinities that the CPU map iterator
may reference a CPU not present in the initial evsel. Fix by making
the iterator and non-iterator code common.

Fix a bug where closing events on an evlist wasn't closing TPEBS
events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 128 ++++++++++++++----------------
 tools/perf/util/evlist.c  | 160 ++++++++++++++++++++++++--------------
 tools/perf/util/evlist.h  |  26 +++++--
 tools/perf/util/pmu.c     |  12 +++
 tools/perf/util/pmu.h     |   1 +
 5 files changed, 189 insertions(+), 138 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index ca1c80c141b6..947f11b8b106 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -366,22 +366,14 @@ static int read_counter_cpu(struct evsel *counter, int cpu_map_idx)
 	return 0;
 }
 
-static int read_affinity_counters(void)
+static int read_counters_with_affinity(void)
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
@@ -390,8 +382,6 @@ static int read_affinity_counters(void)
 		if (!counter->err)
 			counter->err = read_counter_cpu(counter, evlist_cpu_itr.cpu_map_idx);
 	}
-	if (affinity)
-		affinity__cleanup(&saved_affinity);
 
 	return 0;
 }
@@ -414,12 +404,18 @@ static int read_bpf_map_counters(void)
 
 static int read_counters(void)
 {
-	if (!stat_config.stop_read_counter) {
-		if (read_bpf_map_counters() ||
-		    read_affinity_counters())
-			return -1;
-	}
-	return 0;
+	int ret;
+
+	if (stat_config.stop_read_counter)
+		return 0;
+
+	// Read all BPF counters first.
+	ret = read_bpf_map_counters();
+	if (ret)
+		return ret;
+
+	// Read non-BPF and non-tool counters next.
+	return read_counters_with_affinity();
 }
 
 static void process_counters(void)
@@ -760,7 +756,6 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	const bool forks = (argc > 0);
 	bool is_pipe = STAT_RECORD ? perf_stat.data.is_pipe : false;
 	struct evlist_cpu_iterator evlist_cpu_itr;
-	struct affinity saved_affinity, *affinity = NULL;
 	int err, open_err = 0;
 	bool second_pass = false, has_supported_counters;
 
@@ -772,14 +767,6 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
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
@@ -792,49 +779,48 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 
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
@@ -842,7 +828,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		 */
 
 		/* First close errored or weak retry */
-		evlist__for_each_cpu(evlist_cpu_itr, evsel_list, affinity) {
+		evlist__for_each_cpu(evlist_cpu_itr, evsel_list) {
 			counter = evlist_cpu_itr.evsel;
 
 			if (!counter->reset_group && counter->supported)
@@ -851,7 +837,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 			perf_evsel__close_cpu(&counter->core, evlist_cpu_itr.cpu_map_idx);
 		}
 		/* Now reopen weak */
-		evlist__for_each_cpu(evlist_cpu_itr, evsel_list, affinity) {
+		evlist__for_each_cpu(evlist_cpu_itr, evsel_list) {
 			counter = evlist_cpu_itr.evsel;
 
 			if (!counter->reset_group)
@@ -860,17 +846,18 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
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
@@ -1021,7 +1008,6 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	if (forks)
 		evlist__cancel_workload(evsel_list);
 
-	affinity__cleanup(affinity);
 	return err;
 }
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index e8217efdda53..b6df81b8a236 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -358,36 +358,111 @@ int evlist__add_newtp(struct evlist *evlist, const char *sys, const char *name,
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
@@ -417,14 +492,11 @@ void evlist_cpu_iterator__next(struct evlist_cpu_iterator *evlist_cpu_itr)
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
@@ -452,19 +524,11 @@ static void __evlist__disable(struct evlist *evlist, char *evsel_name, bool excl
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
@@ -482,7 +546,6 @@ static void __evlist__disable(struct evlist *evlist, char *evsel_name, bool excl
 			break;
 	}
 
-	affinity__cleanup(affinity);
 	evlist__for_each_entry(evlist, pos) {
 		if (evsel__strcmp(pos, evsel_name))
 			continue;
@@ -522,16 +585,8 @@ static void __evlist__enable(struct evlist *evlist, char *evsel_name, bool excl_
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
@@ -541,7 +596,6 @@ static void __evlist__enable(struct evlist *evlist, char *evsel_name, bool excl_
 			continue;
 		evsel__enable_cpu(pos, evlist_cpu_itr.cpu_map_idx);
 	}
-	affinity__cleanup(affinity);
 	evlist__for_each_entry(evlist, pos) {
 		if (evsel__strcmp(pos, evsel_name))
 			continue;
@@ -1338,28 +1392,14 @@ void evlist__close(struct evlist *evlist)
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
+		if (evlist_cpu_itr.cpu_map_idx == 0 && evsel__is_retire_lat(evlist_cpu_itr.evsel))
+			evsel__tpebs_close(evlist_cpu_itr.evsel);
 		perf_evsel__close_cpu(&evlist_cpu_itr.evsel->core,
 				      evlist_cpu_itr.cpu_map_idx);
 	}
 
-	affinity__cleanup(&affinity);
 	evlist__for_each_entry_reverse(evlist, evsel) {
 		perf_evsel__free_fd(&evsel->core);
 		perf_evsel__free_id(&evsel->core);
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 5e71e3dc6042..b4604c3f03d6 100644
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
@@ -361,6 +362,8 @@ struct evlist_cpu_iterator {
 	struct perf_cpu cpu;
 	/** If present, used to set the affinity when switching between CPUs. */
 	struct affinity *affinity;
+	/** Maybe be used to hold affinity state prior to iterating. */
+	struct affinity saved_affinity;
 };
 
 /**
@@ -368,22 +371,31 @@ struct evlist_cpu_iterator {
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
index f14f2a12d061..e300a3b71bd6 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -2410,6 +2410,18 @@ bool perf_pmu__is_software(const struct perf_pmu *pmu)
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
index 1ebcf0242af8..87e12a9a0e67 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -259,6 +259,7 @@ bool perf_pmu__name_no_suffix_match(const struct perf_pmu *pmu, const char *to_m
  *                        perf_sw_context in the kernel?
  */
 bool perf_pmu__is_software(const struct perf_pmu *pmu);
+bool perf_pmu__benefits_from_affinity(struct perf_pmu *pmu);
 
 FILE *perf_pmu__open_file(const struct perf_pmu *pmu, const char *name);
 FILE *perf_pmu__open_file_at(const struct perf_pmu *pmu, int dirfd, const char *name);
-- 
2.51.2.1041.gc1ab5b90ca-goog

