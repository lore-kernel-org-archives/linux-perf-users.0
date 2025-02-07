Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C3B1E3DD7
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Feb 2025 11:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738928490; cv=none; b=Bc7DQrcdIkjhAlhhB3WfXmZImqfecfkLyO99WAuYx1yQySwr7npB2oGoi7KjZYbJB17aRNohELkYXfLV8nG46ANbbuLsdZUXTcGAQRHzl5RG+cTfe4sZSWfvoWgcRUnSLjVasCJaHiRi9J+cuFw+Jw/Cw4c2eG+D+T5jyonAgm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738928490; c=relaxed/simple;
	bh=DW9PtuhIXSe3NUmcIPyOiLbE2OTexJOMDqEI1hjD1MA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=owqnffsyPWxB7qAIxsYR8ow9MSNeyhBZ3QC2JsgiiTNcPN+uxM3X8Kz+UMRi3t7ybSzm35IWi6nri2nwAi2BAuIrgQwe7SSDyFl70f+Y3vkHeeF9sduWZf55vEFk5ihbjesOXYkgy//Hqqp3yEUn77x63d49IYjshPh9eFfoqec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rcX0A59j; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rcX0A59j"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-ab6eecc3221so250457166b.0
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Feb 2025 03:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738928486; x=1739533286; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s4ondbbiTr0y7tpMZReKJJz1JJVDYpBZbDdrR4mmgfY=;
        b=rcX0A59jOZHqW+vlRHGRk30UvyIp0xCK/1PgZzxjr4efC0xMgny8T0dD6lq1aiQT3h
         YgVJCVQkSFElhVN/lATspBkmjLvHp9aoV6bdWfK1tYjjdB9nli03RF1TbU85Q6+iG+nB
         FX5f8cmGa2aJY+Xywe+zIFj3xcTpnW/Sfwfh/FFozSIq5hmEI7Wzbf1Hg8rurChPzHIl
         BmJtCrc7jcKKk/kRdqTimkITYVikRTsP1cc6IJYg63S9VwnTvulp9otnzyRyNVGqnqdi
         KhTtT9ZlRssXolkZHu5f12QaRDhRfE8de532v7kz3JCYf0Z4i2TSOqbLJzrxSkQjNtHu
         7NvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738928486; x=1739533286;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s4ondbbiTr0y7tpMZReKJJz1JJVDYpBZbDdrR4mmgfY=;
        b=rPIXyCnK9A9ECknka0bJ70jPRnAN83V4YRVxiS1L19Msoc6Ir4wu+D3LIlWUGJo2Td
         I2o7bgWPiMQ7SJOs00UINMuQ6l6MQetG54Z9+GIXMH1pOxtSNErMB5rIm0vdLvNKFbeT
         V7QTw/qZrRqD9NX2M9mTxa6SnmGU6SJlRPmOVRc4lbJ/Bjpz2x3izf9AhkIPqngspYX8
         1WkNTELgp8ZbVgNZAVcb7IEI9ejU4G2uIJDXDjvcPCJ5X1J+ZSCXBm0Lup/hHefz1X4b
         7DLwW4pgTLNkHjt7mVewfyTmWCxMigGWQRkeBZQG4Gog2I5iW9y3m+apL3MgmOKpHHl7
         aNxA==
X-Gm-Message-State: AOJu0Yz8iuE58MYkWNwiUfKqruRxPNr+ReHoVmF0UkKQE0HyaWwppQpu
	sbmZCN9PUpQCcaimzxDnbilkfK3NodopFAkZY+Yi3BI9vqPxLDSDa+zOoUDWakpS2c8+O53MfMl
	CXJyNew==
X-Google-Smtp-Source: AGHT+IFYu3Hwi2zoRq+UhjxxDJqRt1mm/ZuqtaHYz6HgRuFTYe7i/n4k+PLvcWatSTRT5a1efLV5svaGQlbT
X-Received: from ejhu10.prod.google.com ([2002:a17:906:1daa:b0:aa6:b175:74eb])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:7f07:b0:aa6:ac9b:6822
 with SMTP id a640c23a62f3a-ab789a6ada9mr240889566b.12.1738928486345; Fri, 07
 Feb 2025 03:41:26 -0800 (PST)
Date: Fri,  7 Feb 2025 12:40:33 +0100
In-Reply-To: <cover.1738928210.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1738928210.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <2f02840baa8e2f9a32ccb4cd545fc8f8813192df.1738928210.git.dvyukov@google.com>
Subject: [PATCH v6 6/9] perf report: Add --latency flag
From: Dmitry Vyukov <dvyukov@google.com>
To: namhyung@kernel.org, irogers@google.com, ak@linux.intel.com
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
Changes in v6:
 - remove latency column in perf_hpp__cancel_latency if
   sort order is specified, but does not include latency

Changes in v5:
 - added description of --latency flag in Documentation flags
---
 tools/perf/Documentation/perf-record.txt |  4 +++
 tools/perf/Documentation/perf-report.txt |  5 +++
 tools/perf/builtin-record.c              | 20 +++++++++++
 tools/perf/builtin-report.c              | 32 +++++++++++++++---
 tools/perf/ui/hist.c                     | 43 +++++++++++++++++++-----
 tools/perf/util/hist.h                   |  1 +
 tools/perf/util/sort.c                   | 33 ++++++++++++++----
 tools/perf/util/sort.h                   |  2 +-
 tools/perf/util/symbol_conf.h            |  4 ++-
 9 files changed, 124 insertions(+), 20 deletions(-)

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
index 2a19abdc869a1..8e064b8bd589d 100644
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
+	if (!symbol_conf.prefer_latency && rep->total_samples &&
+		rep->singlethreaded_samples * 100 / rep->total_samples >= 99)
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
index 6de6309595f9e..0f2ef02004404 100644
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
@@ -701,6 +710,24 @@ void perf_hpp__cancel_cumulate(void)
 	}
 }
 
+void perf_hpp__cancel_latency(void)
+{
+	struct perf_hpp_fmt *fmt, *lat, *acc, *tmp;
+
+	if (is_strict_order(field_order))
+		return;
+	if (sort_order && strstr(sort_order, "latency"))
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
2.48.1.502.g6dc24dfdaf-goog

