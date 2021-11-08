Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A06DC433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB81561505
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239991AbhKHNkx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:40:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53740 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237229AbhKHNkw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:40:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=699z+7N3yq1Cc2ShSnO7rwgEd1LjbiWlM7HYT4bGA+M=;
        b=aSlsvvJGm79F3MExWYXmNeAaQA3qQnGltSFzkrmXq9Ii8J+XbWbnf5r5QIfoL1V8A0mXMD
        4lPzAv+IJ+ocy8lNR96R2wjTfLlbt7lT62oxDNjICN+ajR+ecEAubg+mWjCJLa7haqOyu4
        f4amRSWVA8Kjwxwr6faGjG8xZ37EZLk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-MhcnOn0YP4KXB60w_Xc3xw-1; Mon, 08 Nov 2021 08:38:06 -0500
X-MC-Unique: MhcnOn0YP4KXB60w_Xc3xw-1
Received: by mail-wm1-f70.google.com with SMTP id k5-20020a7bc3050000b02901e081f69d80so6211490wmj.8
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:38:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=699z+7N3yq1Cc2ShSnO7rwgEd1LjbiWlM7HYT4bGA+M=;
        b=45ViS8/qnwD4hfXkjXHwbyAhBU4XoNmxSpuznLuIfXmXYVYy+Qv1TlBjdlNms4HAp2
         ufKMWledHY8Wh8e/kp7cCMr5I7xk3AUF21WB2uXk2vteDX5t3q+hagmOfGW3pR+yKxCF
         5hT++qUp0C1yk9FKnb9cPXbN6R3pj4HpsmEzcRfw2nktwFcLrVUqAxnikrR7fsVWGGxv
         zT6SpIFXV+cTTLC9wmhrrUxjOtsUCa7rQA/K9x/c6IKokj+4pquT2DoH1HVTKo68PQXT
         GbAA/72mMTlT9UZ7SV6O+k7q9022twoLp53lQu/h7tDYfYX5QNRt4ipWA7Dzewm4v+/S
         Y6BA==
X-Gm-Message-State: AOAM531JZ4H2wafOLCMnZnPDYfiyUk0dDAHOgecBeIwjlaQD8Y/8oelz
        PrsPKhSWzYSF8+MLpzmNjg19O5IZ0jexecaIvn8djqnE0ujz3EvS06CwVW05EuyIK1AnMLcV38B
        CjkWjZ+1J9xkf85NJ+Eg2h5JmTSqSfw==
X-Received: by 2002:adf:f201:: with SMTP id p1mr65923239wro.243.1636378684361;
        Mon, 08 Nov 2021 05:38:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx+VvSTF92qx17NaPPWIiovzZWoN4QJzNjkyMhXdeQ4NkZF8ybzUvbXqs+OdQtSywqWQIhX5g==
X-Received: by 2002:adf:f201:: with SMTP id p1mr65923188wro.243.1636378684011;
        Mon, 08 Nov 2021 05:38:04 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id n7sm16628016wra.37.2021.11.08.05.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:38:03 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 07/59] libperf: Move name to perf_evsel
Date:   Mon,  8 Nov 2021 14:36:18 +0100
Message-Id: <20211108133710.1352822-8-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Moving name to perf_evsel struct.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/include/internal/evsel.h |  9 ++++++
 tools/perf/arch/x86/util/kvm-stat.c     |  8 +++---
 tools/perf/builtin-kvm.c                |  6 ++--
 tools/perf/builtin-record.c             |  8 +++---
 tools/perf/builtin-stat.c               | 10 +++----
 tools/perf/builtin-trace.c              | 12 ++++----
 tools/perf/tests/evsel-tp-sched.c       |  6 ++--
 tools/perf/tests/expand-cgroup.c        |  6 ++--
 tools/perf/tests/parse-events.c         | 12 ++++----
 tools/perf/tests/parse-metric.c         |  4 +--
 tools/perf/util/arm-spe.c               |  6 ++--
 tools/perf/util/evlist-hybrid.c         |  2 +-
 tools/perf/util/evlist.c                | 14 ++++-----
 tools/perf/util/evsel.c                 | 38 ++++++++++++-------------
 tools/perf/util/evsel.h                 |  1 -
 tools/perf/util/header.c                | 22 +++++++-------
 tools/perf/util/intel-pt.c              |  6 ++--
 tools/perf/util/metricgroup.c           | 10 +++----
 tools/perf/util/parse-events.c          |  8 +++---
 tools/perf/util/sort.c                  |  6 ++--
 tools/perf/util/stat-display.c          | 16 +++++------
 tools/perf/util/stat-shadow.c           | 14 ++++-----
 tools/perf/util/synthetic-events.c      |  4 +--
 tools/perf/util/trace-event-info.c      |  6 ++--
 24 files changed, 121 insertions(+), 113 deletions(-)

diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
index 1f3eacbad2e8..808720b4cf77 100644
--- a/tools/lib/perf/include/internal/evsel.h
+++ b/tools/lib/perf/include/internal/evsel.h
@@ -51,6 +51,15 @@ struct perf_evsel {
 	int			 nr_members;
 	bool			 system_wide;
 	int			 idx;
+
+	/*
+	 * These fields can be set in the parse-events code or similar.
+	 * Please check evsel__clone() to copy them properly so that
+	 * they can be released properly.
+	 */
+        struct {
+                char			*name;
+	};
 };
 
 void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr,
diff --git a/tools/perf/arch/x86/util/kvm-stat.c b/tools/perf/arch/x86/util/kvm-stat.c
index c5dd54f6ef5e..3c0e0c1cf663 100644
--- a/tools/perf/arch/x86/util/kvm-stat.c
+++ b/tools/perf/arch/x86/util/kvm-stat.c
@@ -47,7 +47,7 @@ static bool mmio_event_begin(struct evsel *evsel,
 		return true;
 
 	/* MMIO write begin event in kernel. */
-	if (!strcmp(evsel->name, "kvm:kvm_mmio") &&
+	if (!strcmp(evsel->core.name, "kvm:kvm_mmio") &&
 	    evsel__intval(evsel, sample, "type") == KVM_TRACE_MMIO_WRITE) {
 		mmio_event_get_key(evsel, sample, key);
 		return true;
@@ -64,7 +64,7 @@ static bool mmio_event_end(struct evsel *evsel, struct perf_sample *sample,
 		return true;
 
 	/* MMIO read end event in kernel.*/
-	if (!strcmp(evsel->name, "kvm:kvm_mmio") &&
+	if (!strcmp(evsel->core.name, "kvm:kvm_mmio") &&
 	    evsel__intval(evsel, sample, "type") == KVM_TRACE_MMIO_READ) {
 		mmio_event_get_key(evsel, sample, key);
 		return true;
@@ -102,7 +102,7 @@ static bool ioport_event_begin(struct evsel *evsel,
 			       struct perf_sample *sample,
 			       struct event_key *key)
 {
-	if (!strcmp(evsel->name, "kvm:kvm_pio")) {
+	if (!strcmp(evsel->core.name, "kvm:kvm_pio")) {
 		ioport_event_get_key(evsel, sample, key);
 		return true;
 	}
@@ -146,7 +146,7 @@ static bool msr_event_begin(struct evsel *evsel,
 			       struct perf_sample *sample,
 			       struct event_key *key)
 {
-	if (!strcmp(evsel->name, "kvm:kvm_msr")) {
+	if (!strcmp(evsel->core.name, "kvm:kvm_msr")) {
 		msr_event_get_key(evsel, sample, key);
 		return true;
 	}
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index c6f352ee57e6..0c582500363e 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -74,7 +74,7 @@ void exit_event_get_key(struct evsel *evsel,
 
 bool kvm_exit_event(struct evsel *evsel)
 {
-	return !strcmp(evsel->name, kvm_exit_trace);
+	return !strcmp(evsel->core.name, kvm_exit_trace);
 }
 
 bool exit_event_begin(struct evsel *evsel,
@@ -90,7 +90,7 @@ bool exit_event_begin(struct evsel *evsel,
 
 bool kvm_entry_event(struct evsel *evsel)
 {
-	return !strcmp(evsel->name, kvm_entry_trace);
+	return !strcmp(evsel->core.name, kvm_entry_trace);
 }
 
 bool exit_event_end(struct evsel *evsel,
@@ -305,7 +305,7 @@ static bool is_child_event(struct perf_kvm_stat *kvm,
 		return false;
 
 	for (; child_ops->name; child_ops++) {
-		if (!strcmp(evsel->name, child_ops->name)) {
+		if (!strcmp(evsel->core.name, child_ops->name)) {
 			child_ops->get_key(evsel, sample, key);
 			return true;
 		}
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 0f7440351842..d5b899b235be 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1606,14 +1606,14 @@ static void record__uniquify_name(struct record *rec)
 		if (!evsel__is_hybrid(pos))
 			continue;
 
-		if (strchr(pos->name, '/'))
+		if (strchr(pos->core.name, '/'))
 			continue;
 
 		ret = asprintf(&new_name, "%s/%s/",
-			       pos->pmu_name, pos->name);
+			       pos->pmu_name, pos->core.name);
 		if (ret) {
-			free(pos->name);
-			pos->name = new_name;
+			free(pos->core.name);
+			pos->core.name = new_name;
 		}
 	}
 }
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 4157faf03b2e..f7fda777f122 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -265,9 +265,9 @@ static void evlist__check_cpu_maps(struct evlist *evlist)
 
 		if (verbose) {
 			cpu_map__snprint(leader->core.cpus, buf, sizeof(buf));
-			pr_warning("     %s: %s\n", leader->name, buf);
+			pr_warning("     %s: %s\n", leader->core.name, buf);
 			cpu_map__snprint(evsel->core.cpus, buf, sizeof(buf));
-			pr_warning("     %s: %s\n", evsel->name, buf);
+			pr_warning("     %s: %s\n", evsel->core.name, buf);
 		}
 
 		for_each_group_evsel(pos, leader) {
@@ -466,9 +466,9 @@ static void read_counters(struct timespec *rs)
 
 	evlist__for_each_entry(evsel_list, counter) {
 		if (counter->err)
-			pr_debug("failed to read counter %s\n", counter->name);
+			pr_debug("failed to read counter %s\n", counter->core.name);
 		if (counter->err == 0 && perf_stat_process_counter(&stat_config, counter))
-			pr_warning("failed to process counter %s\n", counter->name);
+			pr_warning("failed to process counter %s\n", counter->core.name);
 		counter->err = 0;
 	}
 }
@@ -2205,7 +2205,7 @@ static void setup_system_wide(int forks)
 
 		evlist__for_each_entry(evsel_list, counter) {
 			if (!counter->core.system_wide &&
-			    strcmp(counter->name, "duration_time")) {
+			    strcmp(counter->core.name, "duration_time")) {
 				return;
 			}
 		}
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 2f1d20553a0a..5c8df351083f 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2647,7 +2647,7 @@ static int trace__sched_stat_runtime(struct trace *trace, struct evsel *evsel,
 
 out_dump:
 	fprintf(trace->output, "%s: comm=%s,pid=%u,runtime=%" PRIu64 ",vruntime=%" PRIu64 ")\n",
-	       evsel->name,
+	       evsel->core.name,
 	       evsel__strval(evsel, sample, "comm"),
 	       (pid_t)evsel__intval(evsel, sample, "pid"),
 	       runtime,
@@ -2814,7 +2814,7 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
 		 */
 	}
 
-	fprintf(trace->output, "%s(", evsel->name);
+	fprintf(trace->output, "%s(", evsel->core.name);
 
 	if (evsel__is_bpf_output(evsel)) {
 		bpf_output__fprintf(trace, sample);
@@ -3842,7 +3842,7 @@ static int trace__expand_filter(struct trace *trace __maybe_unused, struct evsel
 			fmt = evsel__find_syscall_arg_fmt_by_name(evsel, arg);
 			if (fmt == NULL) {
 				pr_err("\"%s\" not found in \"%s\", can't set filter \"%s\"\n",
-				       arg, evsel->name, evsel->filter);
+				       arg, evsel->core.name, evsel->filter);
 				return -1;
 			}
 
@@ -3873,12 +3873,12 @@ static int trace__expand_filter(struct trace *trace __maybe_unused, struct evsel
 					new_filter = n;
 				} else {
 					pr_err("\"%.*s\" not found for \"%s\" in \"%s\", can't set filter \"%s\"\n",
-					       right_size, right, arg, evsel->name, evsel->filter);
+					       right_size, right, arg, evsel->core.name, evsel->filter);
 					return -1;
 				}
 			} else {
 				pr_err("No resolver (strtoul) for \"%s\" in \"%s\", can't set filter \"%s\"\n",
-				       arg, evsel->name, evsel->filter);
+				       arg, evsel->core.name, evsel->filter);
 				return -1;
 			}
 
@@ -3889,7 +3889,7 @@ static int trace__expand_filter(struct trace *trace __maybe_unused, struct evsel
 	}
 
 	if (new_filter != evsel->filter) {
-		pr_debug("New filter for %s: %s\n", evsel->name, new_filter);
+		pr_debug("New filter for %s: %s\n", evsel->core.name, new_filter);
 		evsel__set_filter(evsel, new_filter);
 		free(new_filter);
 	}
diff --git a/tools/perf/tests/evsel-tp-sched.c b/tools/perf/tests/evsel-tp-sched.c
index f9e34bd26cf3..2ded86bee563 100644
--- a/tools/perf/tests/evsel-tp-sched.c
+++ b/tools/perf/tests/evsel-tp-sched.c
@@ -12,20 +12,20 @@ static int evsel__test_field(struct evsel *evsel, const char *name, int size, bo
 	int ret = 0;
 
 	if (field == NULL) {
-		pr_debug("%s: \"%s\" field not found!\n", evsel->name, name);
+		pr_debug("%s: \"%s\" field not found!\n", evsel->core.name, name);
 		return -1;
 	}
 
 	is_signed = !!(field->flags & TEP_FIELD_IS_SIGNED);
 	if (should_be_signed && !is_signed) {
 		pr_debug("%s: \"%s\" signedness(%d) is wrong, should be %d\n",
-			 evsel->name, name, is_signed, should_be_signed);
+			 evsel->core.name, name, is_signed, should_be_signed);
 		ret = -1;
 	}
 
 	if (field->size != size) {
 		pr_debug("%s: \"%s\" size (%d) should be %d!\n",
-			 evsel->name, name, field->size, size);
+			 evsel->core.name, name, field->size, size);
 		ret = -1;
 	}
 
diff --git a/tools/perf/tests/expand-cgroup.c b/tools/perf/tests/expand-cgroup.c
index 61dec9783a1e..cb57365e6288 100644
--- a/tools/perf/tests/expand-cgroup.c
+++ b/tools/perf/tests/expand-cgroup.c
@@ -36,7 +36,7 @@ static int test_expand_events(struct evlist *evlist,
 	}
 	i = 0;
 	evlist__for_each_entry(evlist, evsel) {
-		ev_name[i] = strdup(evsel->name);
+		ev_name[i] = strdup(evsel->core.name);
 		if (ev_name[i] == NULL) {
 			pr_debug("memory allocation failure\n");
 			goto out;
@@ -61,10 +61,10 @@ static int test_expand_events(struct evlist *evlist,
 
 	i = 0;
 	evlist__for_each_entry(evlist, evsel) {
-		if (strcmp(evsel->name, ev_name[i % nr_events])) {
+		if (strcmp(evsel->core.name, ev_name[i % nr_events])) {
 			pr_debug("event name doesn't match:\n");
 			pr_debug("  evsel[%d]: %s\n  expected: %s\n",
-				 i, evsel->name, ev_name[i % nr_events]);
+				 i, evsel->core.name, ev_name[i % nr_events]);
 			goto out;
 		}
 		if (strcmp(evsel->cgrp->name, cgrp_name[i / nr_events])) {
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index d39aaeeaad0f..c06cc2c155fd 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1380,7 +1380,7 @@ static int test__checkevent_config_symbol(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "insn") == 0);
+	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->core.name, "insn") == 0);
 	return 0;
 }
 
@@ -1388,7 +1388,7 @@ static int test__checkevent_config_raw(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "rawpmu") == 0);
+	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->core.name, "rawpmu") == 0);
 	return 0;
 }
 
@@ -1396,7 +1396,7 @@ static int test__checkevent_config_num(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "numpmu") == 0);
+	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->core.name, "numpmu") == 0);
 	return 0;
 }
 
@@ -1404,7 +1404,7 @@ static int test__checkevent_config_cache(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "cachepmu") == 0);
+	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->core.name, "cachepmu") == 0);
 	return 0;
 }
 
@@ -1417,7 +1417,7 @@ static int test__intel_pt(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "intel_pt//u") == 0);
+	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->core.name, "intel_pt//u") == 0);
 	return 0;
 }
 
@@ -1425,7 +1425,7 @@ static int test__checkevent_complex_name(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong complex name parsing", strcmp(evsel->name, "COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks") == 0);
+	TEST_ASSERT_VAL("wrong complex name parsing", strcmp(evsel->core.name, "COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks") == 0);
 	return 0;
 }
 
diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index 23ed50c26368..83f769ce1517 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -110,9 +110,9 @@ static void load_runtime_stat(struct runtime_stat *st, struct evlist *evlist,
 	u64 count;
 
 	evlist__for_each_entry(evlist, evsel) {
-		count = find_value(evsel->name, vals);
+		count = find_value(evsel->core.name, vals);
 		perf_stat__update_shadow_stats(evsel, count, 0, st);
-		if (!strcmp(evsel->name, "duration_time"))
+		if (!strcmp(evsel->core.name, "duration_time"))
 			update_stats(&walltime_nsecs_stats, count);
 	}
 }
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 58b7069c5a5f..d57b8c0372c4 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -879,9 +879,9 @@ static void arm_spe_set_event_name(struct evlist *evlist, u64 id,
 
 	evlist__for_each_entry(evlist, evsel) {
 		if (evsel->core.id && evsel->core.id[0] == id) {
-			if (evsel->name)
-				zfree(&evsel->name);
-			evsel->name = strdup(name);
+			if (evsel->core.name)
+				zfree(&evsel->core.name);
+			evsel->core.name = strdup(name);
 			break;
 		}
 	}
diff --git a/tools/perf/util/evlist-hybrid.c b/tools/perf/util/evlist-hybrid.c
index 67c53acfaa29..8dc0776b89f7 100644
--- a/tools/perf/util/evlist-hybrid.c
+++ b/tools/perf/util/evlist-hybrid.c
@@ -136,7 +136,7 @@ int evlist__fix_hybrid_cpus(struct evlist *evlist, const char *cpu_list)
 			if (unmatched_cpus->nr > 0) {
 				cpu_map__snprint(matched_cpus, buf1, sizeof(buf1));
 				pr_warning("WARNING: use %s in '%s' for '%s', skip other cpus in list.\n",
-					   buf1, pmu->name, evsel->name);
+					   buf1, pmu->name, evsel->core.name);
 			}
 		}
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 5f92319ce258..8a2da1365666 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -315,7 +315,7 @@ struct evsel *evlist__find_tracepoint_by_name(struct evlist *evlist, const char
 
 	evlist__for_each_entry(evlist, evsel) {
 		if ((evsel->core.attr.type == PERF_TYPE_TRACEPOINT) &&
-		    (strcmp(evsel->name, name) == 0))
+		    (strcmp(evsel->core.name, name) == 0))
 			return evsel;
 	}
 
@@ -380,7 +380,7 @@ static int evsel__strcmp(struct evsel *pos, char *evsel_name)
 		return 0;
 	if (evsel__is_dummy_event(pos))
 		return 1;
-	return strcmp(pos->name, evsel_name);
+	return strcmp(pos->core.name, evsel_name);
 }
 
 static int evlist__is_enabled(struct evlist *evlist)
@@ -1647,9 +1647,9 @@ struct evsel *evlist__find_evsel_by_str(struct evlist *evlist, const char *str)
 	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel) {
-		if (!evsel->name)
+		if (!evsel->core.name)
 			continue;
-		if (strcmp(str, evsel->name) == 0)
+		if (strcmp(str, evsel->core.name) == 0)
 			return evsel;
 	}
 
@@ -1748,7 +1748,7 @@ struct evsel *evlist__reset_weak_group(struct evlist *evsel_list, struct evsel *
 	leader = evsel__leader(evsel);
 
 	pr_debug("Weak group for %s/%d failed\n",
-			leader->name, leader->core.nr_members);
+			leader->core.name, leader->core.nr_members);
 
 	/*
 	 * for_each_group_member doesn't work here because it doesn't
@@ -2016,7 +2016,7 @@ static int evlist__ctlfd_enable(struct evlist *evlist, char *cmd_data, bool enab
 				evlist__enable_evsel(evlist, name);
 			else
 				evlist__disable_evsel(evlist, name);
-			pr_info("Event %s %s\n", evsel->name,
+			pr_info("Event %s %s\n", evsel->core.name,
 				enable ? "enabled" : "disabled");
 		} else {
 			pr_info("failed: can't find '%s' event\n", name);
@@ -2161,7 +2161,7 @@ void evlist__check_mem_load_aux(struct evlist *evlist)
 		if (leader == evsel)
 			continue;
 
-		if (leader->name && strstr(leader->name, "mem-loads-aux")) {
+		if (leader->core.name && strstr(leader->core.name, "mem-loads-aux")) {
 			for_each_group_evsel(pos, leader) {
 				evsel__set_leader(pos, pos);
 				pos->core.nr_members = 0;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d1e580c88be7..b737f1c60721 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -230,8 +230,8 @@ bool evsel__is_function_event(struct evsel *evsel)
 {
 #define FUNCTION_EVENT "ftrace:function"
 
-	return evsel->name &&
-	       !strncmp(FUNCTION_EVENT, evsel->name, sizeof(FUNCTION_EVENT));
+	return evsel->core.name &&
+	       !strncmp(FUNCTION_EVENT, evsel->core.name, sizeof(FUNCTION_EVENT));
 
 #undef FUNCTION_EVENT
 }
@@ -320,7 +320,7 @@ struct evsel *evsel__new_cycles(bool precise, __u32 type, __u64 config)
 	evsel->precise_max = true;
 
 	/* use asprintf() because free(evsel) assumes name is allocated */
-	if (asprintf(&evsel->name, "cycles%s%s%.*s",
+	if (asprintf(&evsel->core.name, "cycles%s%s%.*s",
 		     (attr.precise_ip || attr.exclude_kernel) ? ":" : "",
 		     attr.exclude_kernel ? "u" : "",
 		     attr.precise_ip ? attr.precise_ip + 1 : 0, "ppp") < 0)
@@ -390,9 +390,9 @@ struct evsel *evsel__clone(struct evsel *orig)
 	evsel->core.nr_members = orig->core.nr_members;
 	evsel->core.system_wide = orig->core.system_wide;
 
-	if (orig->name) {
-		evsel->name = strdup(orig->name);
-		if (evsel->name == NULL)
+	if (orig->core.name) {
+		evsel->core.name = strdup(orig->core.name);
+		if (evsel->core.name == NULL)
 			goto out_err;
 	}
 	if (orig->group_name) {
@@ -465,7 +465,7 @@ struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx)
 					  PERF_SAMPLE_CPU | PERF_SAMPLE_PERIOD),
 		};
 
-		if (asprintf(&evsel->name, "%s:%s", sys, name) < 0)
+		if (asprintf(&evsel->core.name, "%s:%s", sys, name) < 0)
 			goto out_free;
 
 		evsel->tp_format = trace_event__tp_format(sys, name);
@@ -483,7 +483,7 @@ struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx)
 	return evsel;
 
 out_free:
-	zfree(&evsel->name);
+	zfree(&evsel->core.name);
 	free(evsel);
 out_err:
 	return ERR_PTR(err);
@@ -739,8 +739,8 @@ const char *evsel__name(struct evsel *evsel)
 	if (!evsel)
 		goto out_unknown;
 
-	if (evsel->name)
-		return evsel->name;
+	if (evsel->core.name)
+		return evsel->core.name;
 
 	switch (evsel->core.attr.type) {
 	case PERF_TYPE_RAW:
@@ -776,10 +776,10 @@ const char *evsel__name(struct evsel *evsel)
 		break;
 	}
 
-	evsel->name = strdup(bf);
+	evsel->core.name = strdup(bf);
 
-	if (evsel->name)
-		return evsel->name;
+	if (evsel->core.name)
+		return evsel->core.name;
 out_unknown:
 	return "unknown";
 }
@@ -1018,7 +1018,7 @@ static void evsel__apply_config_terms(struct evsel *evsel,
 				if (parse_callchain_record(callgraph_buf, &param)) {
 					pr_err("per-event callgraph setting for %s failed. "
 					       "Apply callgraph global setting for it\n",
-					       evsel->name);
+					       evsel->core.name);
 					return;
 				}
 				if (param.record_mode == CALLCHAIN_DWARF)
@@ -1437,7 +1437,7 @@ void evsel__exit(struct evsel *evsel)
 	perf_cpu_map__put(evsel->core.own_cpus);
 	perf_thread_map__put(evsel->core.threads);
 	zfree(&evsel->group_name);
-	zfree(&evsel->name);
+	zfree(&evsel->core.name);
 	zfree(&evsel->pmu_name);
 	zfree(&evsel->metric_id);
 	evsel__zero_per_pkg(evsel);
@@ -2762,7 +2762,7 @@ bool evsel__fallback(struct evsel *evsel, int err, char *msg, size_t msgsize)
 		evsel->core.attr.type   = PERF_TYPE_SOFTWARE;
 		evsel->core.attr.config = PERF_COUNT_SW_CPU_CLOCK;
 
-		zfree(&evsel->name);
+		zfree(&evsel->core.name);
 		return true;
 	} else if (err == EACCES && !evsel->core.attr.exclude_kernel &&
 		   (paranoid = perf_event_paranoid()) > 1) {
@@ -2782,9 +2782,9 @@ bool evsel__fallback(struct evsel *evsel, int err, char *msg, size_t msgsize)
 		if (asprintf(&new_name, "%s%su", name, sep) < 0)
 			return false;
 
-		if (evsel->name)
-			free(evsel->name);
-		evsel->name = new_name;
+		if (evsel->core.name)
+			free(evsel->core.name);
+		evsel->core.name = new_name;
 		scnprintf(msg, msgsize, "kernel.perf_event_paranoid=%d, trying "
 			  "to fall back to excluding kernel and hypervisor "
 			  " samples", paranoid);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 846c827934de..de6ed7b258ca 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -59,7 +59,6 @@ struct evsel {
 	 * they can be released properly.
 	 */
 	struct {
-		char			*name;
 		char			*group_name;
 		const char		*pmu_name;
 		struct tep_event	*tp_format;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 971ae4744895..949d24da7000 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1773,7 +1773,7 @@ static void free_event_desc(struct evsel *events)
 		return;
 
 	for (evsel = events; evsel->core.attr.size; evsel++) {
-		zfree(&evsel->name);
+		zfree(&evsel->core.name);
 		zfree(&evsel->core.id);
 	}
 
@@ -1867,8 +1867,8 @@ static struct evsel *read_event_desc(struct feat_fd *ff)
 		if (ff->ph->needs_swap)
 			evsel->needs_swap = true;
 
-		evsel->name = do_read_string(ff);
-		if (!evsel->name)
+		evsel->core.name = do_read_string(ff);
+		if (!evsel->core.name)
 			goto error;
 
 		if (!nr)
@@ -1918,7 +1918,7 @@ static void print_event_desc(struct feat_fd *ff, FILE *fp)
 	}
 
 	for (evsel = events; evsel->core.attr.size; evsel++) {
-		fprintf(fp, "# event : name = %s, ", evsel->name);
+		fprintf(fp, "# event : name = %s, ", evsel->core.name);
 
 		if (evsel->core.ids) {
 			fprintf(fp, ", id = {");
@@ -2390,17 +2390,17 @@ static void evlist__set_event_name(struct evlist *evlist, struct evsel *event)
 {
 	struct evsel *evsel;
 
-	if (!event->name)
+	if (!event->core.name)
 		return;
 
 	evsel = evlist__find_by_index(evlist, event->core.idx);
 	if (!evsel)
 		return;
 
-	if (evsel->name)
+	if (evsel->core.name)
 		return;
 
-	evsel->name = strdup(event->name);
+	evsel->core.name = strdup(event->core.name);
 }
 
 static int
@@ -3971,10 +3971,10 @@ static int evsel__prepare_tracepoint_event(struct evsel *evsel, struct tep_handl
 		return -1;
 	}
 
-	if (!evsel->name) {
+	if (!evsel->core.name) {
 		snprintf(bf, sizeof(bf), "%s:%s", event->system, event->name);
-		evsel->name = strdup(bf);
-		if (evsel->name == NULL)
+		evsel->core.name = strdup(bf);
+		if (evsel->core.name == NULL)
 			return -1;
 	}
 
@@ -4259,7 +4259,7 @@ int perf_event__process_event_update(struct perf_tool *tool __maybe_unused,
 		evsel->unit = strdup(ev->data);
 		break;
 	case PERF_EVENT_UPDATE__NAME:
-		evsel->name = strdup(ev->data);
+		evsel->core.name = strdup(ev->data);
 		break;
 	case PERF_EVENT_UPDATE__SCALE:
 		ev_scale = (struct perf_record_event_update_scale *)ev->data;
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 556a893508da..80bf68ddb8a9 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -3276,9 +3276,9 @@ static void intel_pt_set_event_name(struct evlist *evlist, u64 id,
 
 	evlist__for_each_entry(evlist, evsel) {
 		if (evsel->core.id && evsel->core.id[0] == id) {
-			if (evsel->name)
-				zfree(&evsel->name);
-			evsel->name = strdup(name);
+			if (evsel->core.name)
+				zfree(&evsel->core.name);
+			evsel->core.name = strdup(name);
 			break;
 		}
 	}
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 4a533740c939..b54856cb14d0 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -690,10 +690,10 @@ static int decode_all_metric_ids(struct evlist *perf_evlist, const char *modifie
 		 * If the name is just the parsed event, use the metric-id to
 		 * give a more friendly display version.
 		 */
-		if (strstr(ev->name, "metric-id=")) {
+		if (strstr(ev->core.name, "metric-id=")) {
 			bool has_slash = false;
 
-			free(ev->name);
+			free(ev->core.name);
 			for (cur = strchr(sb.buf, '@') ; cur; cur = strchr(++cur, '@')) {
 				*cur = '/';
 				has_slash = true;
@@ -709,8 +709,8 @@ static int decode_all_metric_ids(struct evlist *perf_evlist, const char *modifie
 				if (ret)
 					break;
 			}
-			ev->name = strdup(sb.buf);
-			if (!ev->name) {
+			ev->core.name = strdup(sb.buf);
+			if (!ev->core.name) {
 				ret = -ENOMEM;
 				break;
 			}
@@ -1565,7 +1565,7 @@ int metricgroup__copy_metric_events(struct evlist *evlist, struct cgroup *cgrp,
 			return -ENOMEM;
 
 		pr_debug("copying metric event for cgroup '%s': %s (idx=%d)\n",
-			 cgrp ? cgrp->name : "root", evsel->name, evsel->core.idx);
+			 cgrp ? cgrp->name : "root", evsel->core.name, evsel->core.idx);
 
 		list_for_each_entry(old_expr, &old_me->head, nd) {
 			new_expr = malloc(sizeof(*new_expr));
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 84c4ef32034b..072ff971e32f 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -387,7 +387,7 @@ __add_event(struct list_head *list, int *idx,
 	evsel->auto_merge_stats = auto_merge_stats;
 
 	if (name)
-		evsel->name = strdup(name);
+		evsel->core.name = strdup(name);
 
 	if (metric_id)
 		evsel->metric_id = strdup(metric_id);
@@ -1653,7 +1653,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 	if (!evsel)
 		return -ENOMEM;
 
-	if (evsel->name)
+	if (evsel->core.name)
 		evsel->use_config_name = true;
 
 	evsel->pmu_name = name ? strdup(name) : NULL;
@@ -2069,8 +2069,8 @@ int parse_events_name(struct list_head *list, const char *name)
 	struct evsel *evsel;
 
 	__evlist__for_each_entry(list, evsel) {
-		if (!evsel->name)
-			evsel->name = strdup(name);
+		if (!evsel->core.name)
+			evsel->core.name = strdup(name);
 	}
 
 	return 0;
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 568a88c001c6..9ef8b6733acb 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -2543,13 +2543,13 @@ static struct evsel *find_evsel(struct evlist *evlist, char *event_name)
 	full_name = !!strchr(event_name, ':');
 	evlist__for_each_entry(evlist, pos) {
 		/* case 2 */
-		if (full_name && !strcmp(pos->name, event_name))
+		if (full_name && !strcmp(pos->core.name, event_name))
 			return pos;
 		/* case 3 */
-		if (!full_name && strstr(pos->name, event_name)) {
+		if (!full_name && strstr(pos->core.name, event_name)) {
 			if (evsel) {
 				pr_debug("'%s' event is ambiguous: it can be %s or %s\n",
-					 event_name, evsel->name, pos->name);
+					 event_name, evsel->core.name, pos->core.name);
 				return NULL;
 			}
 			evsel = pos;
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index e3ffc084cb09..9a685b347041 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -546,29 +546,29 @@ static void uniquify_event_name(struct evsel *counter)
 	int ret = 0;
 
 	if (counter->uniquified_name || counter->use_config_name ||
-	    !counter->pmu_name || !strncmp(counter->name, counter->pmu_name,
+	    !counter->pmu_name || !strncmp(counter->core.name, counter->pmu_name,
 					   strlen(counter->pmu_name)))
 		return;
 
-	config = strchr(counter->name, '/');
+	config = strchr(counter->core.name, '/');
 	if (config) {
 		if (asprintf(&new_name,
 			     "%s%s", counter->pmu_name, config) > 0) {
-			free(counter->name);
-			counter->name = new_name;
+			free(counter->core.name);
+			counter->core.name = new_name;
 		}
 	} else {
 		if (perf_pmu__has_hybrid()) {
 			ret = asprintf(&new_name, "%s/%s/",
-				       counter->pmu_name, counter->name);
+				       counter->pmu_name, counter->core.name);
 		} else {
 			ret = asprintf(&new_name, "%s [%s]",
-				       counter->name, counter->pmu_name);
+				       counter->core.name, counter->pmu_name);
 		}
 
 		if (ret) {
-			free(counter->name);
-			counter->name = new_name;
+			free(counter->core.name);
+			counter->core.name = new_name;
 		}
 	}
 
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 69f3cf3b4a44..cd8898d4b363 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -361,7 +361,7 @@ static struct evsel *perf_stat__find_event(struct evlist *evsel_list,
 	struct evsel *c2;
 
 	evlist__for_each_entry (evsel_list, c2) {
-		if (!strcasecmp(c2->name, name) && !c2->collect_stat)
+		if (!strcasecmp(c2->core.name, name) && !c2->collect_stat)
 			return c2;
 	}
 	return NULL;
@@ -393,7 +393,7 @@ void perf_stat__collect_metric_expr(struct evlist *evsel_list)
 		metric_events = counter->metric_events;
 		if (!metric_events) {
 			if (expr__find_ids(counter->metric_expr,
-					   counter->name,
+					   counter->core.name,
 					   ctx) < 0)
 				continue;
 
@@ -414,7 +414,7 @@ void perf_stat__collect_metric_expr(struct evlist *evsel_list)
 			if (leader) {
 				/* Search in group */
 				for_each_group_member (oc, leader) {
-					if (!strcasecmp(oc->name,
+					if (!strcasecmp(oc->core.name,
 							metric_name) &&
 						!oc->collect_stat) {
 						found = true;
@@ -443,7 +443,7 @@ void perf_stat__collect_metric_expr(struct evlist *evsel_list)
 					fprintf(stderr,
 						"Add %s event to groups to get metric expression for %s\n",
 						metric_name,
-						counter->name);
+						counter->core.name);
 					printed = strdup(metric_name);
 				}
 				invalid = true;
@@ -829,7 +829,7 @@ static int prepare_metric(struct evsel **metric_events,
 		struct stats *stats;
 		u64 metric_total = 0;
 
-		if (!strcmp(metric_events[i]->name, "duration_time")) {
+		if (!strcmp(metric_events[i]->core.name, "duration_time")) {
 			stats = &walltime_nsecs_stats;
 			scale = 1e-9;
 		} else {
@@ -1275,7 +1275,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 				core_bound * 100.);
 	} else if (evsel->metric_expr) {
 		generic_metric(config, evsel->metric_expr, evsel->metric_events, NULL,
-				evsel->name, evsel->metric_name, NULL, 1, cpu, out, st);
+				evsel->core.name, evsel->metric_name, NULL, 1, cpu, out, st);
 	} else if (runtime_stat_n(st, STAT_NSECS, cpu, &rsd) != 0) {
 		char unit = ' ';
 		char unit_buf[10] = "/sec";
@@ -1300,7 +1300,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 			if (num++ > 0)
 				out->new_line(config, ctxp);
 			generic_metric(config, mexp->metric_expr, mexp->metric_events,
-					mexp->metric_refs, evsel->name, mexp->metric_name,
+					mexp->metric_refs, evsel->core.name, mexp->metric_name,
 					mexp->metric_unit, mexp->runtime, cpu, out, st);
 		}
 	}
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 198982109f0f..2528c22792be 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1860,14 +1860,14 @@ int perf_event__synthesize_event_update_name(struct perf_tool *tool, struct evse
 					     perf_event__handler_t process)
 {
 	struct perf_record_event_update *ev;
-	size_t len = strlen(evsel->name);
+	size_t len = strlen(evsel->core.name);
 	int err;
 
 	ev = event_update_event__new(len + 1, PERF_EVENT_UPDATE__NAME, evsel->core.id[0]);
 	if (ev == NULL)
 		return -ENOMEM;
 
-	strlcpy(ev->data, evsel->name, len + 1);
+	strlcpy(ev->data, evsel->core.name, len + 1);
 	err = process(tool, (union perf_event *)ev, NULL, NULL);
 	free(ev);
 	return err;
diff --git a/tools/perf/util/trace-event-info.c b/tools/perf/util/trace-event-info.c
index a65f65d0857e..b00d83b4163d 100644
--- a/tools/perf/util/trace-event-info.c
+++ b/tools/perf/util/trace-event-info.c
@@ -412,12 +412,12 @@ get_tracepoints_path(struct list_head *pattrs)
 			continue;
 		++nr_tracepoints;
 
-		if (pos->name) {
-			ppath->next = tracepoint_name_to_path(pos->name);
+		if (pos->core.name) {
+			ppath->next = tracepoint_name_to_path(pos->core.name);
 			if (ppath->next)
 				goto next;
 
-			if (strchr(pos->name, ':') == NULL)
+			if (strchr(pos->core.name, ':') == NULL)
 				goto try_id;
 
 			goto error;
-- 
2.31.1

