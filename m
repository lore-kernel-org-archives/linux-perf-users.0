Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F4B1FDA62
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Feb 2025 16:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738772923; cv=none; b=IbDU2yAevi/od/JhqbYxE+1N9e0Ef1SOLrHwx+MxTn0T0ycptKNyDCCBxq+KaO/oNs3a/62M62fZlACCAaHecoIcRxLCHSQvdoMFZQf3BMR2tbAV9m02hoYJcUu+aJgn2m8Y0CS1IiTaNzbbZrrGlAtxfNCmUj/UKJcRCeS31H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738772923; c=relaxed/simple;
	bh=dOVc+itszKKkOfDlci8dbywMo54VagfJRFZO3eL/wbY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jnBx+VRVO90Q3ZR1EwddA0jEULwLCPPb/fMmWERbSY83ykX3PgGvooaldRFo26TFxYr+bDWv/24n1ZLHvXDrKHXdd4DmC83qOQtC1A+aRbevSVMwyK6YZzRAVQs46ZULt9Q4AD0X1zBUzooU9GTFRecPDFVpfY/q+fFvw/egInY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JGDk8RFd; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JGDk8RFd"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-ab547c18515so381424866b.2
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Feb 2025 08:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738772920; x=1739377720; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t7TyZuyl/AeG18zK/V93iU9kTHIQBgFkYCI/kX9uwuw=;
        b=JGDk8RFdlvrJ8Y3+lnMnLbhcmbGR/jN0QkXi8LHQfdfYcKqXTJ6kQHMZVqUl97ObfD
         PtnrH4NzjtHbsehgHiwR+RGP+xvHFp/I9T4x0+3FLiQ8sd/hHRhNoVUawnlC0jqog0jy
         YbUKDxktSc+QyY7EY1CzsIfrPIOOXg2IddBQEZoKjWfv61dosUYTz4MIqX6HY/4AJE/z
         2ps3uTl53QZsabEMF4LR9PEbMZrq6isfkfAkPSEPjFI4WfO/WWTHB4ajcKOT5wyhcRl0
         Jvn6jK6xTK1IZI96R7o1+2wmQPV0FTcpY2HRD+v5gyq+id0NHrAStKtb1OJRejfAiYIo
         pNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738772920; x=1739377720;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t7TyZuyl/AeG18zK/V93iU9kTHIQBgFkYCI/kX9uwuw=;
        b=FpihKc0/kDKsCp0blABPtIZSuYSc8Lcu7GyfC5J0UC0NnHJr521fGHhwA37wpvlH7W
         I8mDgseRuQR4u8UOHUqTdTtGAKNyvEPd9BuxXfRWUcZmOUbOR3v53FiLXdIb1ueWc558
         XA6P1G3GW7rfmu2R+gt3j7+uJaqORmXC/HeY/Uq2Y6AkmgyHzCrhvfb71izaMrSzvM3p
         OdjAaI3PwZPwBru9UHgCvt2/Y4AwEBcxynBAxUrA+BU3Mb4U4ua08YQU6f7WuJ+XN3qG
         cbxlaBQcMZ4ned+xVinVr5PhQQjl+UQ5ledqAbm55hn3RC1c63CRb2iDp8W2YpemzzMS
         WHJA==
X-Gm-Message-State: AOJu0YyNuWr6qte543kJ81LSXXJoKILbcHmic1oMQczEy7Q8H9WWsDmy
	1ZFsW3ZtUAVABrkvLPDVqngI8w5HV4SKVtVTfqzkf4IKEB6goldtmQa6J+d2SMOE6ArUV04zkLZ
	7y2iS6Q==
X-Google-Smtp-Source: AGHT+IHhyG9EWRUKlMwjXsfBAGL7gIj7zO9HfAPatAw5LoxI5JqvG/mEBHjBPlM0Yj3ttYVt176JSZM7zoAM
X-Received: from edcg8.prod.google.com ([2002:a05:6402:4288:b0:5d8:a186:ff11])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:f590:b0:aab:d8de:217e
 with SMTP id a640c23a62f3a-ab75e25e8c2mr317377666b.26.1738772920071; Wed, 05
 Feb 2025 08:28:40 -0800 (PST)
Date: Wed,  5 Feb 2025 17:27:45 +0100
In-Reply-To: <cover.1738772628.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1738772628.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <eb32b9b13856b0d508836b61b3e8377aef9163a3.1738772628.git.dvyukov@google.com>
Subject: [PATCH v5 6/8] perf report: Add --latency flag
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
Changes in v5:
 - added description of --latency flag in Documentation flags
---
 tools/perf/Documentation/perf-record.txt |  4 +++
 tools/perf/Documentation/perf-report.txt |  5 +++
 tools/perf/builtin-record.c              | 20 ++++++++++++
 tools/perf/builtin-report.c              | 32 +++++++++++++++---
 tools/perf/ui/hist.c                     | 41 +++++++++++++++++++-----
 tools/perf/util/hist.h                   |  1 +
 tools/perf/util/sort.c                   | 33 +++++++++++++++----
 tools/perf/util/sort.h                   |  2 +-
 tools/perf/util/symbol_conf.h            |  4 ++-
 9 files changed, 122 insertions(+), 20 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 80686d590de24..c7fc1ba265e27 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -227,6 +227,10 @@ OPTIONS
 	'--filter' exists, the new filter expression will be combined with
 	them by '&&'.
 
+--latency::
+	Enable data collection for latency profiling.
+	Use perf report --latency for latency-centric profile.
+
 -a::
 --all-cpus::
         System-wide collection from all CPUs (default if no target is specified).
diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 87f8645194062..66794131aec48 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -68,6 +68,11 @@ OPTIONS
 --hide-unresolved::
         Only display entries resolved to a symbol.
 
+--latency::
+        Show latency-centric profile rather than the default
+        CPU-consumption-centric profile
+        (requires perf record --latency flag).
+
 -s::
 --sort=::
 	Sort histogram entries by given key(s) - multiple keys can be specified
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
index 6de6309595f9e..b453f8eb579cc 100644
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
2.48.1.362.g079036d154-goog

