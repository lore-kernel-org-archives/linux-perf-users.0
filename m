Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95641FECBB
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Jan 2025 09:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737971972; cv=none; b=CIxvXHgiktxugZEX1837+X+OhiPzCb/LJRAsbhhsoQKBBQqw5UBhJyoB5htZZCKVhfY/un0eOzMRZ09Ij12j0o5ewYVhtUU8a8WsoWo2uiWDdiGfp6MqXETq7mShm3TPxro0CpMxYZjeaG/O0pA+8FBJ/qmJOKtSc7ppf6ypMnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737971972; c=relaxed/simple;
	bh=gJY4RlMRBrOEWOCFxqwDKzJS4qwdZRHORGp141d42RY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bfCENC93ZtEHcG4BgGroHtBQQLQVagUCF8cAAldYXlscNcjL8tdwhSkfa1beWVNXlS77A7IjXC5vq87zmV2x/1GM4VClmF3mDIvMjwWXKmR4iyhusvCZH11aAhK+/XBDASEvKhyMltnN9PkjdntIkK5kHP1JD848OXFOvXUbQAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0I88LPs2; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0I88LPs2"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5d43ec75bc4so3593265a12.2
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Jan 2025 01:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737971969; x=1738576769; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UI3PFDbizjPUwB2DpjyDkLXCl+QfdgHXUWI6TUxru0M=;
        b=0I88LPs25Qi/RVm7K+IweqGHc149g8jWZ+kFaZ2b76vKYRzCvoSi2erR7Yb9biTuoH
         BlJnp5SqXphNQqkQo7XdRlpN9JQwhgdHpWsu3mMpQ06r8vRErBO8mtQZeFAFaB5w2f9X
         VVvPeAbKTQQbIpRj6JaJq/9L7A2WJ79r1jWOE5V1fwPUTBCqeYJX6uDCSkqaN1HJE5af
         jKJfY+5ifCAzgHz5ZFOpwMO3x5Un/Xv6aTllDkmINqA88wLR9e8L0WW9BNQWt9o4P1Lv
         jMR0MHeHumbtcaN6JeC34BLzNL9bGFq3vtcwAIenWfH9qLElnTA/5bKGgbZxZfCWBJUa
         ugTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737971969; x=1738576769;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UI3PFDbizjPUwB2DpjyDkLXCl+QfdgHXUWI6TUxru0M=;
        b=NTAdwMhfJXG8dLetjuNY33R2VESWuGo0byQvJVo7as69OvgB+6SPyOYcy1ZsrHSlf3
         /5As3cYposmuPqvJCr+WWiG3jfr1QW36fORM7ZwWFMYGdKP0J4gSDyRl64ZeCHezPiC3
         vZGbOks31ORWKipQ64miPz78cHeBDmiur/aGYMohpZpf7JnCXR9zzFlZ0cPU65mbHloj
         1EAHYYQW5Rj7hlrAd+P+deT2puzsBEVv+mxEBWD9zhmRSFSbFGN76reyqGPinkarUQCr
         UVyV2W/yn7U4yBJbzwuvEtry1WfTZ8HVm1we3aXLzj4wdCCxAwturMUmJowco5hqoKdN
         6DRQ==
X-Gm-Message-State: AOJu0Yy0R2gk+/xkYviOWgL1PbbnQSEE1OAfZv9n0fdwc+5wq66QWyH3
	aYvE1/vRuclddvgLpfN243izF5E+6QdSQKcEEDRL7oTbUUXb5IHjEsKchzbKEuzlMYBfnSZOHYx
	dsDJ+kg==
X-Google-Smtp-Source: AGHT+IEhlV2/ER+QtAqm2OOo088+LKyzKDZ+VjLfP4b1dzl6eLVAbobMqR3MNBDd9gaBqRYsowO8H3dIKejs
X-Received: from edze7.prod.google.com ([2002:a05:6402:1907:b0:5d8:ab23:4682])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:35d2:b0:5dc:6c1:816c
 with SMTP id 4fb4d7f45d1cf-5dc06c182e4mr13088466a12.1.1737971969229; Mon, 27
 Jan 2025 01:59:29 -0800 (PST)
Date: Mon, 27 Jan 2025 10:58:53 +0100
In-Reply-To: <cover.1737971364.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1737971364.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <70523ae7dd5d5c41d2d954324297d9d2cfad1b1f.1737971364.git.dvyukov@google.com>
Subject: [PATCH v3 6/7] perf report: Add --latency flag
From: Dmitry Vyukov <dvyukov@google.com>
To: namhyung@kernel.org, irogers@google.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Vyukov <dvyukov@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Add record/report --latency flag that allows to capture and show
latency-centric profiles rather than the default CPU-consumption-centric
profiles. For latency profiles record captures context switch events,
and report shows Latency as the first column.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 tools/perf/builtin-record.c   | 20 +++++++++++++++++
 tools/perf/builtin-report.c   | 32 +++++++++++++++++++++++----
 tools/perf/ui/hist.c          | 41 ++++++++++++++++++++++++++++-------
 tools/perf/util/hist.h        |  1 +
 tools/perf/util/sort.c        | 33 +++++++++++++++++++++++-----
 tools/perf/util/sort.h        |  2 +-
 tools/perf/util/symbol_conf.h |  4 +++-
 7 files changed, 113 insertions(+), 20 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 5db1aedf48df9..e219639ac401b 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -161,6 +161,7 @@ struct record {
 	struct evlist		*sb_evlist;
 	pthread_t		thread_id;
 	int			realtime_prio;
+	bool			latency;
 	bool			switch_output_event_set;
 	bool			no_buildid;
 	bool			no_buildid_set;
@@ -3371,6 +3372,9 @@ static struct option __record_options[] = {
 		     parse_events_option),
 	OPT_CALLBACK(0, "filter", &record.evlist, "filter",
 		     "event filter", parse_filter),
+	OPT_BOOLEAN(0, "latency", &record.latency,
+		    "Enable data collection for latency profiling.\n"
+		    "\t\t\t  Use perf report --latency for latency-centric profile."),
 	OPT_CALLBACK_NOOPT(0, "exclude-perf", &record.evlist,
 			   NULL, "don't record events from perf itself",
 			   exclude_perf),
@@ -4017,6 +4021,22 @@ int cmd_record(int argc, const char **argv)
 
 	}
 
+	if (record.latency) {
+		/*
+		 * There is no fundamental reason why latency profiling
+		 * can't work for system-wide mode, but exact semantics
+		 * and details are to be defined.
+		 * See the following thread for details:
+		 * https://lore.kernel.org/all/Z4XDJyvjiie3howF@google.com/
+		 */
+		if (record.opts.target.system_wide) {
+			pr_err("Failed: latency profiling is not supported with system-wide collection.\n");
+			err = -EINVAL;
+			goto out_opts;
+		}
+		record.opts.record_switch_events = true;
+	}
+
 	if (rec->buildid_mmap) {
 		if (!perf_can_record_build_id()) {
 			pr_err("Failed: no support to record build id in mmap events, update your kernel.\n");
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 2a19abdc869a1..69de6dbefecfa 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -112,6 +112,8 @@ struct report {
 	u64			nr_entries;
 	u64			queue_size;
 	u64			total_cycles;
+	u64			total_samples;
+	u64			singlethreaded_samples;
 	int			socket_filter;
 	DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
 	struct branch_type_stat	brtype_stat;
@@ -331,6 +333,10 @@ static int process_sample_event(const struct perf_tool *tool,
 				     &rep->total_cycles, evsel);
 	}
 
+	rep->total_samples++;
+	if (al.parallelism == 1)
+		rep->singlethreaded_samples++;
+
 	ret = hist_entry_iter__add(&iter, &al, rep->max_stack, rep);
 	if (ret < 0)
 		pr_debug("problem adding hist entry, skipping event\n");
@@ -1079,6 +1085,11 @@ static int __cmd_report(struct report *rep)
 		return ret;
 	}
 
+	/* Don't show Latency column for non-parallel profiles by default. */
+	if (rep->singlethreaded_samples * 100 / rep->total_samples >= 99 &&
+			!symbol_conf.prefer_latency)
+		perf_hpp__cancel_latency();
+
 	evlist__check_mem_load_aux(session->evlist);
 
 	if (rep->stats_mode)
@@ -1468,6 +1479,10 @@ int cmd_report(int argc, const char **argv)
 		    "Disable raw trace ordering"),
 	OPT_BOOLEAN(0, "skip-empty", &report.skip_empty,
 		    "Do not display empty (or dummy) events in the output"),
+	OPT_BOOLEAN(0, "latency", &symbol_conf.prefer_latency,
+		    "Show latency-centric profile rather than the default\n"
+		    "\t\t\t  CPU-consumption-centric profile\n"
+		    "\t\t\t  (requires perf record --latency flag)."),
 	OPT_END()
 	};
 	struct perf_data data = {
@@ -1722,16 +1737,25 @@ int cmd_report(int argc, const char **argv)
 		symbol_conf.annotate_data_sample = true;
 	}
 
+	symbol_conf.enable_latency = true;
 	if (report.disable_order || !perf_session__has_switch_events(session)) {
 		if (symbol_conf.parallelism_list_str ||
-				(sort_order && strstr(sort_order, "parallelism")) ||
-				(field_order && strstr(field_order, "parallelism"))) {
+			symbol_conf.prefer_latency ||
+			(sort_order && (strstr(sort_order, "latency") ||
+				strstr(sort_order, "parallelism"))) ||
+			(field_order && (strstr(field_order, "latency") ||
+				strstr(field_order, "parallelism")))) {
 			if (report.disable_order)
-				ui__error("Use of parallelism is incompatible with --disable-order.\n");
+				ui__error("Use of latency profile or parallelism is incompatible with --disable-order.\n");
 			else
-				ui__error("Use of parallelism requires --switch-events during record.\n");
+				ui__error("Use of latency profile or parallelism requires --latency flag during record.\n");
 			return -1;
 		}
+		/*
+		 * If user did not ask for anything related to
+		 * latency/parallelism explicitly, just don't show it.
+		 */
+		symbol_conf.enable_latency = false;
 	}
 
 	if (sort_order && strstr(sort_order, "ipc")) {
diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index 22e31d835301e..d87046052b432 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -632,27 +632,36 @@ void perf_hpp__init(void)
 		return;
 
 	if (symbol_conf.cumulate_callchain) {
-		hpp_dimension__add_output(PERF_HPP__OVERHEAD_ACC);
+		/* Use idempotent addition to avoid more complex logic. */
+		if (symbol_conf.prefer_latency)
+			hpp_dimension__add_output(PERF_HPP__LATENCY_ACC, true);
+		hpp_dimension__add_output(PERF_HPP__OVERHEAD_ACC, true);
+		if (symbol_conf.enable_latency)
+			hpp_dimension__add_output(PERF_HPP__LATENCY_ACC, true);
 		perf_hpp__format[PERF_HPP__OVERHEAD].name = "Self";
 	}
 
-	hpp_dimension__add_output(PERF_HPP__OVERHEAD);
+	if (symbol_conf.prefer_latency)
+		hpp_dimension__add_output(PERF_HPP__LATENCY, true);
+	hpp_dimension__add_output(PERF_HPP__OVERHEAD, true);
+	if (symbol_conf.enable_latency)
+		hpp_dimension__add_output(PERF_HPP__LATENCY, true);
 
 	if (symbol_conf.show_cpu_utilization) {
-		hpp_dimension__add_output(PERF_HPP__OVERHEAD_SYS);
-		hpp_dimension__add_output(PERF_HPP__OVERHEAD_US);
+		hpp_dimension__add_output(PERF_HPP__OVERHEAD_SYS, false);
+		hpp_dimension__add_output(PERF_HPP__OVERHEAD_US, false);
 
 		if (perf_guest) {
-			hpp_dimension__add_output(PERF_HPP__OVERHEAD_GUEST_SYS);
-			hpp_dimension__add_output(PERF_HPP__OVERHEAD_GUEST_US);
+			hpp_dimension__add_output(PERF_HPP__OVERHEAD_GUEST_SYS, false);
+			hpp_dimension__add_output(PERF_HPP__OVERHEAD_GUEST_US, false);
 		}
 	}
 
 	if (symbol_conf.show_nr_samples)
-		hpp_dimension__add_output(PERF_HPP__SAMPLES);
+		hpp_dimension__add_output(PERF_HPP__SAMPLES, false);
 
 	if (symbol_conf.show_total_period)
-		hpp_dimension__add_output(PERF_HPP__PERIOD);
+		hpp_dimension__add_output(PERF_HPP__PERIOD, false);
 }
 
 void perf_hpp_list__column_register(struct perf_hpp_list *list,
@@ -701,6 +710,22 @@ void perf_hpp__cancel_cumulate(void)
 	}
 }
 
+void perf_hpp__cancel_latency(void)
+{
+	struct perf_hpp_fmt *fmt, *lat, *acc, *tmp;
+
+	if (is_strict_order(field_order) || is_strict_order(sort_order))
+		return;
+
+	lat = &perf_hpp__format[PERF_HPP__LATENCY];
+	acc = &perf_hpp__format[PERF_HPP__LATENCY_ACC];
+
+	perf_hpp_list__for_each_format_safe(&perf_hpp_list, fmt, tmp) {
+		if (fmt_equal(lat, fmt) || fmt_equal(acc, fmt))
+			perf_hpp__column_unregister(fmt);
+	}
+}
+
 void perf_hpp__setup_output_field(struct perf_hpp_list *list)
 {
 	struct perf_hpp_fmt *fmt;
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 91159f16c60b2..29d4c7a3d1747 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -582,6 +582,7 @@ enum {
 
 void perf_hpp__init(void);
 void perf_hpp__cancel_cumulate(void);
+void perf_hpp__cancel_latency(void);
 void perf_hpp__setup_output_field(struct perf_hpp_list *list);
 void perf_hpp__reset_output_field(struct perf_hpp_list *list);
 void perf_hpp__append_sort_keys(struct perf_hpp_list *list);
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index bc4c3acfe7552..2b6023de7a53a 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -2622,6 +2622,7 @@ struct hpp_dimension {
 	const char		*name;
 	struct perf_hpp_fmt	*fmt;
 	int			taken;
+	int			was_taken;
 };
 
 #define DIM(d, n) { .name = n, .fmt = &perf_hpp__format[d], }
@@ -3513,6 +3514,7 @@ static int __hpp_dimension__add(struct hpp_dimension *hd,
 		return -1;
 
 	hd->taken = 1;
+	hd->was_taken = 1;
 	perf_hpp_list__register_sort_field(list, fmt);
 	return 0;
 }
@@ -3547,10 +3549,15 @@ static int __hpp_dimension__add_output(struct perf_hpp_list *list,
 	return 0;
 }
 
-int hpp_dimension__add_output(unsigned col)
+int hpp_dimension__add_output(unsigned col, bool implicit)
 {
+	struct hpp_dimension *hd;
+
 	BUG_ON(col >= PERF_HPP__MAX_INDEX);
-	return __hpp_dimension__add_output(&perf_hpp_list, &hpp_sort_dimensions[col]);
+	hd = &hpp_sort_dimensions[col];
+	if (implicit && !hd->was_taken)
+		return 0;
+	return __hpp_dimension__add_output(&perf_hpp_list, hd);
 }
 
 int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
@@ -3809,10 +3816,24 @@ static char *setup_overhead(char *keys)
 	if (sort__mode == SORT_MODE__DIFF)
 		return keys;
 
-	keys = prefix_if_not_in("overhead", keys);
-
-	if (symbol_conf.cumulate_callchain)
-		keys = prefix_if_not_in("overhead_children", keys);
+	if (symbol_conf.prefer_latency) {
+		keys = prefix_if_not_in("overhead", keys);
+		keys = prefix_if_not_in("latency", keys);
+		if (symbol_conf.cumulate_callchain) {
+			keys = prefix_if_not_in("overhead_children", keys);
+			keys = prefix_if_not_in("latency_children", keys);
+		}
+	} else if (!keys || (!strstr(keys, "overhead") &&
+			!strstr(keys, "latency"))) {
+		if (symbol_conf.enable_latency)
+			keys = prefix_if_not_in("latency", keys);
+		keys = prefix_if_not_in("overhead", keys);
+		if (symbol_conf.cumulate_callchain) {
+			if (symbol_conf.enable_latency)
+				keys = prefix_if_not_in("latency_children", keys);
+			keys = prefix_if_not_in("overhead_children", keys);
+		}
+	}
 
 	return keys;
 }
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 11fb15f914093..180d36a2bea35 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -141,7 +141,7 @@ int report_parse_ignore_callees_opt(const struct option *opt, const char *arg, i
 
 bool is_strict_order(const char *order);
 
-int hpp_dimension__add_output(unsigned col);
+int hpp_dimension__add_output(unsigned col, bool implicit);
 void reset_dimensions(void);
 int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
 			struct evlist *evlist,
diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
index c5b2e56127e22..cd9aa82c7d5ad 100644
--- a/tools/perf/util/symbol_conf.h
+++ b/tools/perf/util/symbol_conf.h
@@ -49,7 +49,9 @@ struct symbol_conf {
 			keep_exited_threads,
 			annotate_data_member,
 			annotate_data_sample,
-			skip_empty;
+			skip_empty,
+			enable_latency,
+			prefer_latency;
 	const char	*vmlinux_name,
 			*kallsyms_name,
 			*source_prefix,
-- 
2.48.1.262.g85cc9f2d1e-goog

