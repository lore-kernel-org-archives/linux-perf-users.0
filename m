Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C59C433C1
	for <linux-perf-users@archiver.kernel.org>; Sun, 21 Mar 2021 11:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7CF261934
	for <linux-perf-users@archiver.kernel.org>; Sun, 21 Mar 2021 11:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhCULiR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 21 Mar 2021 07:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhCULhj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 21 Mar 2021 07:37:39 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EED8C061574;
        Sun, 21 Mar 2021 04:37:38 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id bf3so15979829edb.6;
        Sun, 21 Mar 2021 04:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=eGM8sH9hbPyJlvIe05CABpvDFbtWN8GgHR/j75eWBzA=;
        b=vBB+VDfJcusetnAjY3gcjVlwSdRMb2chRwEXmHR1EGWaZoYyWQ/0uYg5k7AxOyMDmN
         VeawBpSSZAWlEBjgqNwKvuXKoRK296xnh3aw6sunpykxCAzmViwFfmzpbSKMRytNW/+b
         D0EznAhQvp1qlhP/6s/ztq9twaImjVkoiuEWq+jYkY8HxaDfd909UA8ICveifrqcyL9h
         DNbQNeF6gH8cNjXdbMR/Fs1pIMJNtayKIju7D+N1xX8Pqidhy5CXVe8AZHKrkWrbOXf8
         8Oe6EaBA4Hsu+Gbfq2O6aO+H1wxYj65wVvVSmQzHHCjk5Z5xurPcl3gmSOBtWSZnh8R+
         PHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=eGM8sH9hbPyJlvIe05CABpvDFbtWN8GgHR/j75eWBzA=;
        b=fjyGkhzx8A70guZQLb9y0oqMvZabpil8kxFU0prs+E3cTjezr2Qdv5TB0SkRz9t2hF
         ReIDEepLO1iG6ZyG3/x6DP9Py3et6v+ZMMsr/qfKtDCQm603ztA+VA8g9tBlOFmkS3iu
         1ECayjxsOyFJZQdONa7YFYPjnkf3qEw+rR3R1Smw68hpxDlFy1NG5U72GCFHkYu0wcJQ
         8DJwMbTD9LoW+Yfff6PQPfbKtZu1v5KYnJGFCt3ZIZP7dDZoWETRrw7tcYy9YLTTO+MN
         7yOi0HY0Wfv9PztVnF3dEchCKYZTy7XW1jIiuFn+9AJLABSEidMD0I1FYyfMsbJGWRV3
         5KnA==
X-Gm-Message-State: AOAM533q1APvTqZ5WnD2/uOTJWQ9D9z9nY/f5aYKypO3/14X0smjyQuf
        wlTWwTYrd9iR/igsbt3K2e0=
X-Google-Smtp-Source: ABdhPJyzJ9ImUfbk1CWbXXQT5CUdCIUXgKhglHXZLDCP9hOYcqNfP6Rm8inGcER113sUorZB7Hj6Fg==
X-Received: by 2002:a50:ef0a:: with SMTP id m10mr20143989eds.261.1616326656760;
        Sun, 21 Mar 2021 04:37:36 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id h2sm6953603ejk.32.2021.03.21.04.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 04:37:36 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 21 Mar 2021 12:37:34 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH] perf tools: Fix various typos in comments
Message-ID: <20210321113734.GA248990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


Fix ~81 single-word typos in the perf tooling code - accumulated over the years.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/perf/Documentation/perf-buildid-cache.txt |  2 +-
 tools/perf/Documentation/perf-report.txt        |  2 +-
 tools/perf/Documentation/perf-top.txt           |  2 +-
 tools/perf/arch/arm/util/cs-etm.c               |  2 +-
 tools/perf/arch/arm64/util/perf_regs.c          |  2 +-
 tools/perf/arch/powerpc/util/kvm-stat.c         |  2 +-
 tools/perf/arch/powerpc/util/utils_header.h     |  2 +-
 tools/perf/arch/x86/tests/bp-modify.c           |  2 +-
 tools/perf/arch/x86/util/perf_regs.c            |  4 ++--
 tools/perf/bench/epoll-wait.c                   |  4 ++--
 tools/perf/bench/numa.c                         |  2 +-
 tools/perf/builtin-annotate.c                   |  2 +-
 tools/perf/builtin-diff.c                       |  2 +-
 tools/perf/builtin-lock.c                       |  2 +-
 tools/perf/builtin-sched.c                      |  2 +-
 tools/perf/builtin-script.c                     |  4 ++--
 tools/perf/builtin-stat.c                       |  4 ++--
 tools/perf/builtin-top.c                        |  2 +-
 tools/perf/jvmti/jvmti_agent.c                  |  4 ++--
 tools/perf/scripts/python/netdev-times.py       |  2 +-
 tools/perf/tests/bp_signal.c                    |  4 ++--
 tools/perf/tests/code-reading.c                 |  2 +-
 tools/perf/tests/hists_cumulate.c               |  4 ++--
 tools/perf/tests/parse-metric.c                 |  2 +-
 tools/perf/tests/topology.c                     |  2 +-
 tools/perf/trace/beauty/include/linux/socket.h  |  2 +-
 tools/perf/ui/browsers/annotate.c               |  2 +-
 tools/perf/ui/browsers/hists.c                  |  2 +-
 tools/perf/util/call-path.h                     |  2 +-
 tools/perf/util/callchain.c                     |  2 +-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c |  2 +-
 tools/perf/util/cs-etm.c                        |  8 ++++----
 tools/perf/util/cs-etm.h                        |  2 +-
 tools/perf/util/data-convert-bt.c               |  2 +-
 tools/perf/util/demangle-java.c                 |  2 +-
 tools/perf/util/dwarf-aux.c                     |  6 +++---
 tools/perf/util/dwarf-aux.h                     |  2 +-
 tools/perf/util/events_stats.h                  |  2 +-
 tools/perf/util/evlist.c                        |  2 +-
 tools/perf/util/evsel.c                         |  2 +-
 tools/perf/util/expr.h                          |  2 +-
 tools/perf/util/header.c                        |  2 +-
 tools/perf/util/levenshtein.c                   |  2 +-
 tools/perf/util/libunwind/arm64.c               |  2 +-
 tools/perf/util/libunwind/x86_32.c              |  2 +-
 tools/perf/util/llvm-utils.c                    |  2 +-
 tools/perf/util/machine.c                       |  6 +++---
 tools/perf/util/mem-events.h                    |  2 +-
 tools/perf/util/metricgroup.c                   |  2 +-
 tools/perf/util/parse-events.c                  |  6 +++---
 tools/perf/util/pmu.c                           |  2 +-
 tools/perf/util/probe-event.c                   |  4 ++--
 tools/perf/util/probe-finder.c                  |  4 ++--
 tools/perf/util/s390-cpumsf.c                   | 10 +++++-----
 tools/perf/util/session.c                       |  2 +-
 tools/perf/util/symbol-elf.c                    |  2 +-
 tools/perf/util/synthetic-events.c              |  4 ++--
 tools/perf/util/unwind-libunwind-local.c        |  2 +-
 58 files changed, 81 insertions(+), 81 deletions(-)

diff --git a/tools/perf/Documentation/perf-buildid-cache.txt b/tools/perf/Documentation/perf-buildid-cache.txt
index bb167e32a1d7..cd8ce6e8ec12 100644
--- a/tools/perf/Documentation/perf-buildid-cache.txt
+++ b/tools/perf/Documentation/perf-buildid-cache.txt
@@ -57,7 +57,7 @@ OPTIONS
 -u::
 --update=::
 	Update specified file of the cache. Note that this doesn't remove
-	older entires since those may be still needed for annotating old
+	older entries since those may be still needed for annotating old
 	(or remote) perf.data. Only if there is already a cache which has
 	exactly same build-id, that is replaced by new one. It can be used
 	to update kallsyms and kernel dso to vmlinux in order to support
diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index f546b5e9db05..d2d2a8d8f8f5 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -472,7 +472,7 @@ OPTIONS
 	but probably we'll make the default not to show the switch-on/off events
         on the --group mode and if there is only one event besides the off/on ones,
 	go straight to the histogram browser, just like 'perf report' with no events
-	explicitely specified does.
+	explicitly specified does.
 
 --itrace::
 	Options for decoding instruction tracing data. The options are:
diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index ee2024691d46..bba5ffb05463 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -317,7 +317,7 @@ Default is to monitor all CPUS.
 	but probably we'll make the default not to show the switch-on/off events
         on the --group mode and if there is only one event besides the off/on ones,
 	go straight to the histogram browser, just like 'perf top' with no events
-	explicitely specified does.
+	explicitly specified does.
 
 --stitch-lbr::
 	Show callgraph with stitched LBRs, which may have more complete
diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index c25c878fd06c..bd632349ade2 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -343,7 +343,7 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 			opts->auxtrace_mmap_pages = roundup_pow_of_two(sz);
 		}
 
-		/* Snapshost size can't be bigger than the auxtrace area */
+		/* Snapshot size can't be bigger than the auxtrace area */
 		if (opts->auxtrace_snapshot_size >
 				opts->auxtrace_mmap_pages * (size_t)page_size) {
 			pr_err("Snapshot size %zu must not be greater than AUX area tracing mmap size %zu\n",
diff --git a/tools/perf/arch/arm64/util/perf_regs.c b/tools/perf/arch/arm64/util/perf_regs.c
index 2518cde18b34..476b037eea1c 100644
--- a/tools/perf/arch/arm64/util/perf_regs.c
+++ b/tools/perf/arch/arm64/util/perf_regs.c
@@ -108,7 +108,7 @@ int arch_sdt_arg_parse_op(char *old_op, char **new_op)
 		/* [sp], [sp, NUM] or [sp,NUM] */
 		new_len = 7;	/* + ( % s p ) NULL */
 
-		/* If the arugment is [sp], need to fill offset '0' */
+		/* If the argument is [sp], need to fill offset '0' */
 		if (rm[2].rm_so == -1)
 			new_len += 1;
 		else
diff --git a/tools/perf/arch/powerpc/util/kvm-stat.c b/tools/perf/arch/powerpc/util/kvm-stat.c
index eed9e5a42935..16510686c138 100644
--- a/tools/perf/arch/powerpc/util/kvm-stat.c
+++ b/tools/perf/arch/powerpc/util/kvm-stat.c
@@ -176,7 +176,7 @@ int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid __maybe_unused)
 }
 
 /*
- * Incase of powerpc architecture, pmu registers are programmable
+ * In case of powerpc architecture, pmu registers are programmable
  * by guest kernel. So monitoring guest via host may not provide
  * valid samples with default 'cycles' event. It is better to use
  * 'trace_imc/trace_cycles' event for guest profiling, since it
diff --git a/tools/perf/arch/powerpc/util/utils_header.h b/tools/perf/arch/powerpc/util/utils_header.h
index 5788eb1f1fe3..2baeb1c1ae85 100644
--- a/tools/perf/arch/powerpc/util/utils_header.h
+++ b/tools/perf/arch/powerpc/util/utils_header.h
@@ -10,6 +10,6 @@
 
 #define SPRN_PVR        0x11F   /* Processor Version Register */
 #define PVR_VER(pvr)    (((pvr) >>  16) & 0xFFFF) /* Version field */
-#define PVR_REV(pvr)    (((pvr) >>   0) & 0xFFFF) /* Revison field */
+#define PVR_REV(pvr)    (((pvr) >>   0) & 0xFFFF) /* Revision field */
 
 #endif /* __PERF_UTIL_HEADER_H */
diff --git a/tools/perf/arch/x86/tests/bp-modify.c b/tools/perf/arch/x86/tests/bp-modify.c
index adcacf1b6609..dffcf9b52153 100644
--- a/tools/perf/arch/x86/tests/bp-modify.c
+++ b/tools/perf/arch/x86/tests/bp-modify.c
@@ -73,7 +73,7 @@ static int bp_modify1(void)
 	/*
 	 * The parent does following steps:
 	 *  - creates a new breakpoint (id 0) for bp_2 function
-	 *  - changes that breakponit to bp_1 function
+	 *  - changes that breakpoint to bp_1 function
 	 *  - waits for the breakpoint to hit and checks
 	 *    it has proper rip of bp_1 function
 	 *  - detaches the child
diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
index fca81b39b09f..207c56805c55 100644
--- a/tools/perf/arch/x86/util/perf_regs.c
+++ b/tools/perf/arch/x86/util/perf_regs.c
@@ -165,7 +165,7 @@ static int sdt_init_op_regex(void)
 /*
  * Max x86 register name length is 5(ex: %r15d). So, 6th char
  * should always contain NULL. This helps to find register name
- * length using strlen, insted of maintaing one more variable.
+ * length using strlen, instead of maintaining one more variable.
  */
 #define SDT_REG_NAME_SIZE  6
 
@@ -207,7 +207,7 @@ int arch_sdt_arg_parse_op(char *old_op, char **new_op)
 	 * and displacement 0 (Both sign and displacement 0 are
 	 * optional so it may be empty). Use one more character
 	 * to hold last NULL so that strlen can be used to find
-	 * prefix length, instead of maintaing one more variable.
+	 * prefix length, instead of maintaining one more variable.
 	 */
 	char prefix[3] = {0};
 
diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-wait.c
index 0a0ff1247c83..79d13dbc0a47 100644
--- a/tools/perf/bench/epoll-wait.c
+++ b/tools/perf/bench/epoll-wait.c
@@ -17,7 +17,7 @@
  * While the second model, enabled via --multiq option, uses multiple
  * queueing (which refers to one epoll instance per worker). For example,
  * short lived tcp connections in a high throughput httpd server will
- * ditribute the accept()'ing  connections across CPUs. In this case each
+ * distribute the accept()'ing  connections across CPUs. In this case each
  * worker does a limited  amount of processing.
  *
  *             [queue A]  ---> [worker]
@@ -198,7 +198,7 @@ static void *workerfn(void *arg)
 
 	do {
 		/*
-		 * Block undefinitely waiting for the IN event.
+		 * Block indefinitely waiting for the IN event.
 		 * In order to stress the epoll_wait(2) syscall,
 		 * call it event per event, instead of a larger
 		 * batch (max)limit.
diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index 20b87e29c96f..f2640179ada9 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -42,7 +42,7 @@
 #endif
 
 /*
- * Regular printout to the terminal, supressed if -q is specified:
+ * Regular printout to the terminal, suppressed if -q is specified:
  */
 #define tprintf(x...) do { if (g && g->p.show_details >= 0) printf(x); } while (0)
 
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index a23ba6bb99b6..0f3a196e5d6e 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -239,7 +239,7 @@ static int evsel__add_sample(struct evsel *evsel, struct perf_sample *sample,
 	}
 
 	/*
-	 * XXX filtered samples can still have branch entires pointing into our
+	 * XXX filtered samples can still have branch entries pointing into our
 	 * symbol and are missed.
 	 */
 	process_branch_stack(sample->branch_stack, al, sample);
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 878e04b1fab7..f52b3a799e76 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -1796,7 +1796,7 @@ static int ui_init(void)
 	data__for_each_file(i, d) {
 
 		/*
-		 * Baseline or compute realted columns:
+		 * Baseline or compute related columns:
 		 *
 		 *   PERF_HPP_DIFF__BASELINE
 		 *   PERF_HPP_DIFF__DELTA
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index a2f1e53f37a7..01326e370009 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -49,7 +49,7 @@ struct lock_stat {
 
 	/*
 	 * FIXME: evsel__intval() returns u64,
-	 * so address of lockdep_map should be dealed as 64bit.
+	 * so address of lockdep_map should be treated as 64bit.
 	 * Is there more better solution?
 	 */
 	void			*addr;		/* address of lockdep_map, used as ID */
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 69c769b04a61..954ce2f594e9 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -1712,7 +1712,7 @@ static int perf_sched__process_fork_event(struct perf_tool *tool,
 {
 	struct perf_sched *sched = container_of(tool, struct perf_sched, tool);
 
-	/* run the fork event through the perf machineruy */
+	/* run the fork event through the perf machinery */
 	perf_event__process_fork(tool, event, sample, machine);
 
 	/* and then run additional processing needed for this command */
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 5915f19cee55..8b02d8a51656 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2488,7 +2488,7 @@ static int perf_script__fopen_per_event_dump(struct perf_script *script)
 		/*
 		 * Already setup? I.e. we may be called twice in cases like
 		 * Intel PT, one for the intel_pt// and dummy events, then
-		 * for the evsels syntheized from the auxtrace info.
+		 * for the evsels synthesized from the auxtrace info.
 		 *
 		 * Ses perf_script__process_auxtrace_info.
 		 */
@@ -3085,7 +3085,7 @@ static int list_available_scripts(const struct option *opt __maybe_unused,
  *
  * Fixme: All existing "xxx-record" are all in good formats "-e event ",
  * which is covered well now. And new parsing code should be added to
- * cover the future complexing formats like event groups etc.
+ * cover the future complex formats like event groups etc.
  */
 static int check_ev_match(char *dir_name, char *scriptname,
 			struct perf_session *session)
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 2e2e4a8345ea..d140ffbb5b34 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1705,7 +1705,7 @@ static int add_default_attributes(void)
 	bzero(&errinfo, sizeof(errinfo));
 	if (transaction_run) {
 		/* Handle -T as -M transaction. Once platform specific metrics
-		 * support has been added to the json files, all archictures
+		 * support has been added to the json files, all architectures
 		 * will use this approach. To determine transaction support
 		 * on an architecture test for such a metric name.
 		 */
@@ -2459,7 +2459,7 @@ int cmd_stat(int argc, const char **argv)
 		/*
 		 * We synthesize the kernel mmap record just so that older tools
 		 * don't emit warnings about not being able to resolve symbols
-		 * due to /proc/sys/kernel/kptr_restrict settings and instear provide
+		 * due to /proc/sys/kernel/kptr_restrict settings and instead provide
 		 * a saner message about no samples being in the perf.data file.
 		 *
 		 * This also serves to suppress a warning about f_header.data.size == 0
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 3673c04d16b6..173ace43f845 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1607,7 +1607,7 @@ int cmd_top(int argc, const char **argv)
 	if (status) {
 		/*
 		 * Some arches do not provide a get_cpuid(), so just use pr_debug, otherwise
-		 * warn the user explicitely.
+		 * warn the user explicitly.
 		 */
 		eprintf(status == ENOSYS ? 1 : 0, verbose,
 			"Couldn't read the cpuid for this machine: %s\n",
diff --git a/tools/perf/jvmti/jvmti_agent.c b/tools/perf/jvmti/jvmti_agent.c
index 88108598d6e9..526dcaf9f079 100644
--- a/tools/perf/jvmti/jvmti_agent.c
+++ b/tools/perf/jvmti/jvmti_agent.c
@@ -390,7 +390,7 @@ jvmti_write_code(void *agent, char const *sym,
 		rec.p.total_size += size;
 
 	/*
-	 * If JVM is multi-threaded, nultiple concurrent calls to agent
+	 * If JVM is multi-threaded, multiple concurrent calls to agent
 	 * may be possible, so protect file writes
 	 */
 	flockfile(fp);
@@ -457,7 +457,7 @@ jvmti_write_debug_info(void *agent, uint64_t code,
 	rec.p.total_size = size;
 
 	/*
-	 * If JVM is multi-threaded, nultiple concurrent calls to agent
+	 * If JVM is multi-threaded, multiple concurrent calls to agent
 	 * may be possible, so protect file writes
 	 */
 	flockfile(fp);
diff --git a/tools/perf/scripts/python/netdev-times.py b/tools/perf/scripts/python/netdev-times.py
index ea0c8b90a783..a0cfc7fe5908 100644
--- a/tools/perf/scripts/python/netdev-times.py
+++ b/tools/perf/scripts/python/netdev-times.py
@@ -356,7 +356,7 @@ def handle_irq_softirq_exit(event_info):
 		return
 	rec_data = {'sirq_ent_t':sirq_ent_t, 'sirq_ext_t':time,
 			'irq_list':irq_list, 'event_list':event_list}
-	# merge information realted to a NET_RX softirq
+	# merge information related to a NET_RX softirq
 	receive_hunk_list.append(rec_data)
 
 def handle_napi_poll(event_info):
diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
index cc9fbcedb364..ded580f8f657 100644
--- a/tools/perf/tests/bp_signal.c
+++ b/tools/perf/tests/bp_signal.c
@@ -225,7 +225,7 @@ int test__bp_signal(struct test *test __maybe_unused, int subtest __maybe_unused
 	 *
 	 * The test case check following error conditions:
 	 * - we get stuck in signal handler because of debug
-	 *   exception being triggered receursively due to
+	 *   exception being triggered recursively due to
 	 *   the wrong RF EFLAG management
 	 *
 	 * - we never trigger the sig_handler breakpoint due
@@ -242,7 +242,7 @@ int test__bp_signal(struct test *test __maybe_unused, int subtest __maybe_unused
 	ioctl(fd3, PERF_EVENT_IOC_ENABLE, 0);
 
 	/*
-	 * Kick off the test by trigering 'fd1'
+	 * Kick off the test by triggering 'fd1'
 	 * breakpoint.
 	 */
 	test_function();
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 2fdc7b2f996e..9866cddebf23 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -658,7 +658,7 @@ static int do_test_code_reading(bool try_kcore)
 				/*
 				 * Both cpus and threads are now owned by evlist
 				 * and will be freed by following perf_evlist__set_maps
-				 * call. Getting refference to keep them alive.
+				 * call. Getting reference to keep them alive.
 				 */
 				perf_cpu_map__get(cpus);
 				perf_thread_map__get(threads);
diff --git a/tools/perf/tests/hists_cumulate.c b/tools/perf/tests/hists_cumulate.c
index 3f2e1a581247..890cb1f5bf53 100644
--- a/tools/perf/tests/hists_cumulate.c
+++ b/tools/perf/tests/hists_cumulate.c
@@ -47,7 +47,7 @@ static struct sample fake_samples[] = {
 };
 
 /*
- * Will be casted to struct ip_callchain which has all 64 bit entries
+ * Will be cast to struct ip_callchain which has all 64 bit entries
  * of nr and ips[].
  */
 static u64 fake_callchains[][10] = {
@@ -297,7 +297,7 @@ static int test1(struct evsel *evsel, struct machine *machine)
 	return err;
 }
 
-/* callcain + NO children */
+/* callchain + NO children */
 static int test2(struct evsel *evsel, struct machine *machine)
 {
 	int err;
diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index 6dc1db1626ad..abb1e979c1a4 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -186,7 +186,7 @@ static int __compute_metric(const char *name, struct value *vals,
 		*ratio2 = compute_single(&metric_events, evlist, &st, name2);
 
 out:
-	/* ... clenup. */
+	/* ... cleanup. */
 	metricgroup__rblist_exit(&metric_events);
 	runtime_stat__exit(&st);
 	evlist__free_stats(evlist);
diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index 74748ed75b2c..050489807a47 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -80,7 +80,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 	 *   CPU 1 is on core_id 1 and physical_package_id 3
 	 *
 	 *   Core_id and physical_package_id are platform and architecture
-	 *   dependend and might have higher numbers than the CPU id.
+	 *   dependent and might have higher numbers than the CPU id.
 	 *   This actually depends on the configuration.
 	 *
 	 *  In this case process_cpu_topology() prints error message:
diff --git a/tools/perf/trace/beauty/include/linux/socket.h b/tools/perf/trace/beauty/include/linux/socket.h
index 385894b4a8bb..b8fc5c53ba6f 100644
--- a/tools/perf/trace/beauty/include/linux/socket.h
+++ b/tools/perf/trace/beauty/include/linux/socket.h
@@ -85,7 +85,7 @@ struct mmsghdr {
 
 /*
  *	POSIX 1003.1g - ancillary data object information
- *	Ancillary data consits of a sequence of pairs of
+ *	Ancillary data consists of a sequence of pairs of
  *	(cmsghdr, cmsg_data[])
  */
 
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 35b82caf8090..376c21728e72 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -398,7 +398,7 @@ static int sym_title(struct symbol *sym, struct map *map, char *title,
 }
 
 /*
- * This can be called from external jumps, i.e. jumps from one functon
+ * This can be called from external jumps, i.e. jumps from one function
  * to another, like from the kernel's entry_SYSCALL_64 function to the
  * swapgs_restore_regs_and_return_to_usermode() function.
  *
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 3b9818ee9546..bcfd0a45953b 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -117,7 +117,7 @@ static void hist_browser__update_rows(struct hist_browser *hb)
 	browser->rows -= browser->extra_title_lines;
 	/*
 	 * Verify if we were at the last line and that line isn't
-	 * visibe because we now show the header line(s).
+	 * visible because we now show the header line(s).
 	 */
 	index_row = browser->index - browser->top_idx;
 	if (index_row >= browser->rows)
diff --git a/tools/perf/util/call-path.h b/tools/perf/util/call-path.h
index 6b3229106f16..5875cfc8106e 100644
--- a/tools/perf/util/call-path.h
+++ b/tools/perf/util/call-path.h
@@ -23,7 +23,7 @@
  * @children: tree of call paths of functions called
  *
  * In combination with the call_return structure, the call_path structure
- * defines a context-sensitve call-graph.
+ * defines a context-sensitive call-graph.
  */
 struct call_path {
 	struct call_path *parent;
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 1b60985690bb..8e2777133bd9 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -877,7 +877,7 @@ append_chain_children(struct callchain_node *root,
 	if (!node)
 		return -1;
 
-	/* lookup in childrens */
+	/* lookup in children */
 	while (*p) {
 		enum match_result ret;
 
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 3f4bc4050477..de467beb9574 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -316,7 +316,7 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
 	 * This is the first timestamp we've seen since the beginning of traces
 	 * or a discontinuity.  Since timestamps packets are generated *after*
 	 * range packets have been generated, we need to estimate the time at
-	 * which instructions started by substracting the number of instructions
+	 * which instructions started by subtracting the number of instructions
 	 * executed to the timestamp.
 	 */
 	packet_queue->timestamp = elem->timestamp - packet_queue->instr_count;
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index a2a369e2fbb6..190713e35b61 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -160,7 +160,7 @@ void cs_etm__etmq_set_traceid_queue_timestamp(struct cs_etm_queue *etmq,
 					      u8 trace_chan_id)
 {
 	/*
-	 * Wnen a timestamp packet is encountered the backend code
+	 * When a timestamp packet is encountered the backend code
 	 * is stopped so that the front end has time to process packets
 	 * that were accumulated in the traceID queue.  Since there can
 	 * be more than one channel per cs_etm_queue, we need to specify
@@ -1655,7 +1655,7 @@ static bool cs_etm__is_svc_instr(struct cs_etm_queue *etmq, u8 trace_chan_id,
 		 * | 1 1 0 1 1 1 1 1 |  imm8  |
 		 * +-----------------+--------+
 		 *
-		 * According to the specifiction, it only defines SVC for T32
+		 * According to the specification, it only defines SVC for T32
 		 * with 16 bits instruction and has no definition for 32bits;
 		 * so below only read 2 bytes as instruction size for T32.
 		 */
@@ -1887,7 +1887,7 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq,
 
 		/*
 		 * If the previous packet is an exception return packet
-		 * and the return address just follows SVC instuction,
+		 * and the return address just follows SVC instruction,
 		 * it needs to calibrate the previous packet sample flags
 		 * as PERF_IP_FLAG_SYSCALLRET.
 		 */
@@ -1961,7 +1961,7 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq,
 		 * contain exception type related info so we cannot decide
 		 * the exception type purely based on exception return packet.
 		 * If we record the exception number from exception packet and
-		 * reuse it for excpetion return packet, this is not reliable
+		 * reuse it for exception return packet, this is not reliable
 		 * due the trace can be discontinuity or the interrupt can
 		 * be nested, thus the recorded exception number cannot be
 		 * used for exception return packet for these two cases.
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index 4ad925d6d799..cc3c9e11a8e3 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -57,7 +57,7 @@ enum {
 
 /*
  * ETMv3 exception encoding number:
- * See Embedded Trace Macrocell spcification (ARM IHI 0014Q)
+ * See Embedded Trace Macrocell specification (ARM IHI 0014Q)
  * table 7-12 Encoding of Exception[3:0] for non-ARMv7-M processors.
  */
 enum {
diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index 8b67bd97d122..a9c375e63e73 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -949,7 +949,7 @@ static char *change_name(char *name, char *orig_name, int dup)
 	/*
 	 * Add '_' prefix to potential keywork.  According to
 	 * Mathieu Desnoyers (https://lore.kernel.org/lkml/1074266107.40857.1422045946295.JavaMail.zimbra@efficios.com),
-	 * futher CTF spec updating may require us to use '$'.
+	 * further CTF spec updating may require us to use '$'.
 	 */
 	if (dup < 0)
 		len = strlen(name) + sizeof("_");
diff --git a/tools/perf/util/demangle-java.c b/tools/perf/util/demangle-java.c
index 39c05200ed65..090d9face27a 100644
--- a/tools/perf/util/demangle-java.c
+++ b/tools/perf/util/demangle-java.c
@@ -147,7 +147,7 @@ __demangle_java_sym(const char *str, const char *end, char *buf, int maxlen, int
  * Demangle Java function signature (openJDK, not GCJ)
  * input:
  * 	str: string to parse. String is not modified
- *    flags: comobination of JAVA_DEMANGLE_* flags to modify demangling
+ *    flags: combination of JAVA_DEMANGLE_* flags to modify demangling
  * return:
  *	if input can be demangled, then a newly allocated string is returned.
  *	if input cannot be demangled, then NULL is returned
diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 7b2d471a6419..b2f4920e19a6 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -91,7 +91,7 @@ static Dwarf_Line *cu_getsrc_die(Dwarf_Die *cu_die, Dwarf_Addr addr)
 			return NULL;
 	} while (laddr == addr);
 	l++;
-	/* Going foward to find the statement line */
+	/* Going forward to find the statement line */
 	do {
 		line = dwarf_onesrcline(lines, l++);
 		if (!line || dwarf_lineaddr(line, &laddr) != 0 ||
@@ -177,7 +177,7 @@ int cu_walk_functions_at(Dwarf_Die *cu_die, Dwarf_Addr addr,
  * die_get_linkage_name - Get the linkage name of the object
  * @dw_die: A DIE of the object
  *
- * Get the linkage name attiribute of given @dw_die.
+ * Get the linkage name attribute of given @dw_die.
  * For C++ binary, the linkage name will be the mangled symbol.
  */
 const char *die_get_linkage_name(Dwarf_Die *dw_die)
@@ -739,7 +739,7 @@ static int __die_walk_instances_cb(Dwarf_Die *inst, void *data)
  * @data: user data
  *
  * Walk on the instances of give @in_die. @in_die must be an inlined function
- * declartion. This returns the return value of @callback if it returns
+ * declaration. This returns the return value of @callback if it returns
  * non-zero value, or -ENOENT if there is no instance.
  */
 int die_walk_instances(Dwarf_Die *or_die, int (*callback)(Dwarf_Die *, void *),
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index 506006e0cf66..cb99646843a9 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -22,7 +22,7 @@ const char *cu_get_comp_dir(Dwarf_Die *cu_die);
 int cu_find_lineinfo(Dwarf_Die *cudie, unsigned long addr,
 		     const char **fname, int *lineno);
 
-/* Walk on funcitons at given address */
+/* Walk on functions at given address */
 int cu_walk_functions_at(Dwarf_Die *cu_die, Dwarf_Addr addr,
 			 int (*callback)(Dwarf_Die *, void *), void *data);
 
diff --git a/tools/perf/util/events_stats.h b/tools/perf/util/events_stats.h
index 859cb34fcff2..631a4af2ed86 100644
--- a/tools/perf/util/events_stats.h
+++ b/tools/perf/util/events_stats.h
@@ -21,7 +21,7 @@
  * all struct perf_record_lost_samples.lost fields reported.
  *
  * The total_period is needed because by default auto-freq is used, so
- * multipling nr_events[PERF_EVENT_SAMPLE] by a frequency isn't possible to get
+ * multiplying nr_events[PERF_EVENT_SAMPLE] by a frequency isn't possible to get
  * the total number of low level events, it is necessary to to sum all struct
  * perf_record_sample.period and stash the result in total_period.
  */
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 882cd1f721d9..414f4b6a0dbf 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1209,7 +1209,7 @@ bool evlist__valid_read_format(struct evlist *evlist)
 		}
 	}
 
-	/* PERF_SAMPLE_READ imples PERF_FORMAT_ID. */
+	/* PERF_SAMPLE_READ implies PERF_FORMAT_ID. */
 	if ((sample_type & PERF_SAMPLE_READ) &&
 	    !(read_format & PERF_FORMAT_ID)) {
 		return false;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 7ecbc8e2fbfa..b072ee5d5008 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -621,7 +621,7 @@ const char *evsel__hw_cache_result[PERF_COUNT_HW_CACHE_RESULT_MAX][EVSEL__MAX_AL
 #define COP(x)		(1 << x)
 
 /*
- * cache operartion stat
+ * cache operation stat
  * L1I : Read and prefetch only
  * ITLB and BPU : Read-only
  */
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index dcf8d19b83c8..85df3e4771e4 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -3,7 +3,7 @@
 #define PARSE_CTX_H 1
 
 // There are fixes that need to land upstream before we can use libbpf's headers,
-// for now use our copy uncoditionally, since the data structures at this point
+// for now use our copy unconditionally, since the data structures at this point
 // are exactly the same, no problem.
 //#ifdef HAVE_LIBBPF_SUPPORT
 //#include <bpf/hashmap.h>
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 20effdff76ce..4572aa981db5 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3485,7 +3485,7 @@ static const size_t attr_pipe_abi_sizes[] = {
  * between host recording the samples, and host parsing the samples is the
  * same. This is not always the case given that the pipe output may always be
  * redirected into a file and analyzed on a different machine with possibly a
- * different endianness and perf_event ABI revsions in the perf tool itself.
+ * different endianness and perf_event ABI revisions in the perf tool itself.
  */
 static int try_all_pipe_abis(uint64_t hdr_sz, struct perf_header *ph)
 {
diff --git a/tools/perf/util/levenshtein.c b/tools/perf/util/levenshtein.c
index a217ecf0359d..6a6712635aa4 100644
--- a/tools/perf/util/levenshtein.c
+++ b/tools/perf/util/levenshtein.c
@@ -30,7 +30,7 @@
  *
  * It does so by calculating the costs of the path ending in characters
  * i (in string1) and j (in string2), respectively, given that the last
- * operation is a substition, a swap, a deletion, or an insertion.
+ * operation is a substitution, a swap, a deletion, or an insertion.
  *
  * This implementation allows the costs to be weighted:
  *
diff --git a/tools/perf/util/libunwind/arm64.c b/tools/perf/util/libunwind/arm64.c
index 6b4e5a0892f8..c397be0c2e32 100644
--- a/tools/perf/util/libunwind/arm64.c
+++ b/tools/perf/util/libunwind/arm64.c
@@ -4,7 +4,7 @@
  * generic one.
  *
  * The function 'LIBUNWIND__ARCH_REG_ID' name is set according to arch
- * name and the defination of this function is included directly from
+ * name and the definition of this function is included directly from
  * 'arch/arm64/util/unwind-libunwind.c', to make sure that this function
  * is defined no matter what arch the host is.
  *
diff --git a/tools/perf/util/libunwind/x86_32.c b/tools/perf/util/libunwind/x86_32.c
index 21c216c40a3b..b2b92d030aef 100644
--- a/tools/perf/util/libunwind/x86_32.c
+++ b/tools/perf/util/libunwind/x86_32.c
@@ -4,7 +4,7 @@
  * generic one.
  *
  * The function 'LIBUNWIND__ARCH_REG_ID' name is set according to arch
- * name and the defination of this function is included directly from
+ * name and the definition of this function is included directly from
  * 'arch/x86/util/unwind-libunwind.c', to make sure that this function
  * is defined no matter what arch the host is.
  *
diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
index dbdffb6673fe..3ceaf7ef3301 100644
--- a/tools/perf/util/llvm-utils.c
+++ b/tools/perf/util/llvm-utils.c
@@ -471,7 +471,7 @@ int llvm__compile_bpf(const char *path, void **p_obj_buf,
 
 	/*
 	 * This is an optional work. Even it fail we can continue our
-	 * work. Needn't to check error return.
+	 * work. Needn't check error return.
 	 */
 	llvm__get_kbuild_opts(&kbuild_dir, &kbuild_include_opts);
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index b5c2d8be4144..0450032b4a3e 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -905,7 +905,7 @@ static struct map *machine__addnew_module_map(struct machine *machine, u64 start
 
 	maps__insert(&machine->kmaps, map);
 
-	/* Put the map here because maps__insert alread got it */
+	/* Put the map here because maps__insert already got it */
 	map__put(map);
 out:
 	/* put the dso here, corresponding to  machine__findnew_module_dso */
@@ -1952,7 +1952,7 @@ int machine__process_fork_event(struct machine *machine, union perf_event *event
 	 * maps because that is what the kernel just did.
 	 *
 	 * But when synthesizing, this should not be done.  If we do, we end up
-	 * with overlapping maps as we process the sythesized MMAP2 events that
+	 * with overlapping maps as we process the synthesized MMAP2 events that
 	 * get delivered shortly thereafter.
 	 *
 	 * Use the FORK event misc flags in an internal way to signal this
@@ -2588,7 +2588,7 @@ static bool alloc_lbr_stitch(struct thread *thread, unsigned int max_lbr)
 }
 
 /*
- * Recolve LBR callstack chain sample
+ * Resolve LBR callstack chain sample
  * Return:
  * 1 on success get LBR callchain information
  * 0 no available LBR callchain information, should try fp
diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
index 755cef7e0625..63dd383b6ce2 100644
--- a/tools/perf/util/mem-events.h
+++ b/tools/perf/util/mem-events.h
@@ -81,7 +81,7 @@ struct c2c_stats {
 	u32	rmt_dram;            /* count of loads miss to remote DRAM */
 	u32	blk_data;            /* count of loads blocked by data */
 	u32	blk_addr;            /* count of loads blocked by address conflict */
-	u32	nomap;               /* count of load/stores with no phys adrs */
+	u32	nomap;               /* count of load/stores with no phys addrs */
 	u32	noparse;             /* count of unparsable data sources */
 };
 
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 26c990e32378..6acb44ad439b 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -181,7 +181,7 @@ static bool evsel_same_pmu(struct evsel *ev1, struct evsel *ev2)
  * @pctx: the parse context for the metric expression.
  * @metric_no_merge: don't attempt to share events for the metric with other
  * metrics.
- * @has_constraint: is there a contraint on the group of events? In which case
+ * @has_constraint: is there a constraint on the group of events? In which case
  * the events won't be grouped.
  * @metric_events: out argument, null terminated array of evsel's associated
  * with the metric.
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 42c84adeb2fb..ff7b17543879 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -843,9 +843,9 @@ split_bpf_config_terms(struct list_head *evt_head_config,
 	struct parse_events_term *term, *temp;
 
 	/*
-	 * Currectly, all possible user config term
+	 * Currently, all possible user config term
 	 * belong to bpf object. parse_events__is_hardcoded_term()
-	 * happends to be a good flag.
+	 * happens to be a good flag.
 	 *
 	 * See parse_events_config_bpf() and
 	 * config_term_tracepoint().
@@ -895,7 +895,7 @@ int parse_events_load_bpf(struct parse_events_state *parse_state,
 
 	/*
 	 * Caller doesn't know anything about obj_head_config,
-	 * so combine them together again before returnning.
+	 * so combine them together again before returning.
 	 */
 	if (head_config)
 		list_splice_tail(&obj_head_config, head_config);
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 44ef28302fc7..6ffc6bb20de6 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1408,7 +1408,7 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct list_head *head_terms,
 	}
 
 	/*
-	 * if no unit or scale foundin aliases, then
+	 * if no unit or scale found in aliases, then
 	 * set defaults as for evsel
 	 * unit cannot left to NULL
 	 */
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index a9cff3a50ddf..a78c8d59a555 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -3228,7 +3228,7 @@ static int try_to_find_absolute_address(struct perf_probe_event *pev,
 	return err;
 }
 
-/* Concatinate two arrays */
+/* Concatenate two arrays */
 static void *memcat(void *a, size_t sz_a, void *b, size_t sz_b)
 {
 	void *ret;
@@ -3258,7 +3258,7 @@ concat_probe_trace_events(struct probe_trace_event **tevs, int *ntevs,
 	if (*ntevs + ntevs2 > probe_conf.max_probes)
 		ret = -E2BIG;
 	else {
-		/* Concatinate the array of probe_trace_event */
+		/* Concatenate the array of probe_trace_event */
 		new_tevs = memcat(*tevs, (*ntevs) * sizeof(**tevs),
 				  *tevs2, ntevs2 * sizeof(**tevs2));
 		if (!new_tevs)
diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 1b118c9c86a6..954c63570181 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -164,7 +164,7 @@ static struct probe_trace_arg_ref *alloc_trace_arg_ref(long offs)
 /*
  * Convert a location into trace_arg.
  * If tvar == NULL, this just checks variable can be converted.
- * If fentry == true and vr_die is a parameter, do huristic search
+ * If fentry == true and vr_die is a parameter, do heuristic search
  * for the location fuzzed by function entry mcount.
  */
 static int convert_variable_location(Dwarf_Die *vr_die, Dwarf_Addr addr,
@@ -1832,7 +1832,7 @@ static int line_range_walk_cb(const char *fname, int lineno,
 	    (lf->lno_s > lineno || lf->lno_e < lineno))
 		return 0;
 
-	/* Make sure this line can be reversable */
+	/* Make sure this line can be reversible */
 	if (cu_find_lineinfo(&lf->cu_die, addr, &__fname, &__lineno) > 0
 	    && (lineno != __lineno || strcmp(fname, __fname)))
 		return 0;
diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index 078a71773565..8130b56aa04b 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -45,7 +45,7 @@
  * the data portion is mmap()'ed.
  *
  * To sort the queues in chronological order, all queue access is controlled
- * by the auxtrace_heap. This is basicly a stack, each stack element has two
+ * by the auxtrace_heap. This is basically a stack, each stack element has two
  * entries, the queue number and a time stamp. However the stack is sorted by
  * the time stamps. The highest time stamp is at the bottom the lowest
  * (nearest) time stamp is at the top. That sort order is maintained at all
@@ -65,11 +65,11 @@
  * stamp of the last processed entry of the auxtrace_buffer replaces the
  * current auxtrace_heap top.
  *
- * 3. Auxtrace_queues might run of out data and are feeded by the
+ * 3. Auxtrace_queues might run of out data and are fed by the
  * PERF_RECORD_AUXTRACE handling, see s390_cpumsf_process_auxtrace_event().
  *
  * Event Generation
- * Each sampling-data entry in the auxilary trace data generates a perf sample.
+ * Each sampling-data entry in the auxiliary trace data generates a perf sample.
  * This sample is filled
  * with data from the auxtrace such as PID/TID, instruction address, CPU state,
  * etc. This sample is processed with perf_session__deliver_synth_event() to
@@ -575,7 +575,7 @@ static unsigned long long get_trailer_time(const unsigned char *buf)
  * pointer to the queue, the second parameter is the time stamp. This
  * is the time stamp:
  * - of the event that triggered this processing.
- * - or the time stamp when the last proccesing of this queue stopped.
+ * - or the time stamp when the last processing of this queue stopped.
  *   In this case it stopped at a 4KB page boundary and record the
  *   position on where to continue processing on the next invocation
  *   (see buffer->use_data and buffer->use_size).
@@ -640,7 +640,7 @@ static int s390_cpumsf_samples(struct s390_cpumsf_queue *sfq, u64 *ts)
 			goto out;
 		}
 
-		pos += dsdes;	/* Skip diagnositic entry */
+		pos += dsdes;	/* Skip diagnostic entry */
 
 		/* Check for trailer entry */
 		if (!s390_cpumsf_reached_trailer(bsdes + dsdes, pos)) {
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 859832a82496..f5becf67c350 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1069,7 +1069,7 @@ static void callchain__lbr_callstack_printf(struct perf_sample *sample)
 		 * in "to" register.
 		 * For example, there is a call stack
 		 * "A"->"B"->"C"->"D".
-		 * The LBR registers will recorde like
+		 * The LBR registers will be recorded like
 		 * "C"->"D", "B"->"C", "A"->"B".
 		 * So only the first "to" register and all "from"
 		 * registers are needed to construct the whole stack.
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 6dff843fd883..4c56aa837434 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1058,7 +1058,7 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 		curr_dso->symtab_type = dso->symtab_type;
 		maps__insert(kmaps, curr_map);
 		/*
-		 * Add it before we drop the referece to curr_map, i.e. while
+		 * Add it before we drop the reference to curr_map, i.e. while
 		 * we still are sure to have a reference to this DSO via
 		 * *curr_map->dso.
 		 */
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index b698046ec2db..49c9353ff9fc 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1210,7 +1210,7 @@ static size_t mask_size(struct perf_cpu_map *map, int *max)
 	*max = 0;
 
 	for (i = 0; i < map->nr; i++) {
-		/* bit possition of the cpu is + 1 */
+		/* bit position of the cpu is + 1 */
 		int bit = map->map[i] + 1;
 
 		if (bit > *max)
@@ -1236,7 +1236,7 @@ void *cpu_map_data__alloc(struct perf_cpu_map *map, size_t *size, u16 *type, int
 	 *   mask  = size of 'struct perf_record_record_cpu_map' +
 	 *           maximum cpu bit converted to size of longs
 	 *
-	 * and finaly + the size of 'struct perf_record_cpu_map_data'.
+	 * and finally + the size of 'struct perf_record_cpu_map_data'.
 	 */
 	size_cpus = cpus_size(map);
 	size_mask = mask_size(map, max);
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index 9aededc0bc06..71a353349181 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -82,7 +82,7 @@ UNW_OBJ(dwarf_find_debug_frame) (int found, unw_dyn_info_t *di_debug,
 #define DW_EH_PE_funcrel	0x40	/* start-of-procedure-relative */
 #define DW_EH_PE_aligned	0x50	/* aligned pointer */
 
-/* Flags intentionaly not handled, since they're not needed:
+/* Flags intentionally not handled, since they're not needed:
  * #define DW_EH_PE_indirect      0x80
  * #define DW_EH_PE_uleb128       0x01
  * #define DW_EH_PE_udata2        0x02
