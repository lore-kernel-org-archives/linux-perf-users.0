Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DAAC433DB
	for <linux-perf-users@archiver.kernel.org>; Tue, 23 Mar 2021 16:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57E43619BA
	for <linux-perf-users@archiver.kernel.org>; Tue, 23 Mar 2021 16:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbhCWQKm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 23 Mar 2021 12:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbhCWQKO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 23 Mar 2021 12:10:14 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E231EC061765;
        Tue, 23 Mar 2021 09:10:13 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id u9so28019442ejj.7;
        Tue, 23 Mar 2021 09:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ro9jLNPagA+jd1/vjtuU4yyBpuI3c+VoIq6OLLya338=;
        b=vJwqRbxdvoDv5zWNtcpNS04rjEfkpCH30+S/Q66p+sSUrSg8KH561ANNa1Zsf75TrT
         pZmG/7KLsqRFldP+3dnUQgXI3kJSGn8UVh1oBTM2tzmlteFWuSa2HzjLWyvV26h18n0H
         RRWCX+zsDCyPwBxwe8viSfTdIE/KtvbW+sx05R1sNKLVxdDNNcq1aAh7PLZNYQfZ+Vik
         UYb/Kz9v+woQvLScQgIXQJYy9xAt2zx4FdYDTjzJQjTT04Y0Ykd/tFtiSIiZ9bgPXY4+
         snvdLM9q522k8PMLojFA7nD4y0/gsZ/7+9Rrs/xhVQWPzg1hnlq2gVEYucab15SKIqjE
         25Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ro9jLNPagA+jd1/vjtuU4yyBpuI3c+VoIq6OLLya338=;
        b=WN1fdt+q/RUHpQodQ8FQ3h+xLhqh0BQ4qwl7a2gO8OtKyymj3Zv9eDPXue3ZS1laJn
         Cdgfl0D4RKBeKqSOh3oCG07U+k4NAybP+0oxEeA73qXRI1Sgj7ucs9itMjDrIGscGd7u
         oOt/gSZk54qFvi6z+4pTG2uP6/piOeTxZ9HdcB4XbTSItx6uLTIyhWN9jdUNeKzKWDC7
         IAGf6d58gp6JkkxieJCrWwY/DVLdvlL61GOCVBP34N+fuGKS0pu1Whwy371TbpoQsivR
         tvuT31ll6O1ZgOxxy1Y93hxINHaCxLPcG/Z1/0nHgw+vfFRQLpbxTgypYHybtV5WfBE0
         gxhg==
X-Gm-Message-State: AOAM532AbF9YZECLMt7StuR0dXLaEuOfOCG+AXpC8jIQkIi0wHvSmrt5
        +tmsWqfzmCp8v8gysmKiaSE=
X-Google-Smtp-Source: ABdhPJz8Hnv9Ye5JjrMPsxxT2xsY+QW41wRSnBZ66oL1ypE0XCHSUj8ECKsxGeoAfRnl3mALpcZGVw==
X-Received: by 2002:a17:907:3f26:: with SMTP id hq38mr5676065ejc.374.1616515812355;
        Tue, 23 Mar 2021 09:10:12 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id gt37sm11144843ejc.12.2021.03.23.09.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 09:10:11 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 23 Mar 2021 17:10:10 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] perf tools: Fix various typos in comments
Message-ID: <20210323161010.GB61903@gmail.com>
References: <20210321113734.GA248990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210321113734.GA248990@gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


Here's the delta between -v1 and -v2, in case you already have -v1 or 
want to review the changes only:

---
 tools/perf/arch/arm64/util/machine.c                   |  8 ++++----
 tools/perf/examples/bpf/augmented_raw_syscalls.c       |  4 ++--
 tools/perf/pmu-events/arch/powerpc/power8/metrics.json | 12 ++++++------
 tools/perf/pmu-events/arch/powerpc/power9/metrics.json |  2 +-
 tools/perf/pmu-events/jevents.c                        |  2 +-
 tools/perf/tests/bp_signal.c                           |  2 +-
 tools/perf/tests/parse-events.c                        |  2 +-
 tools/perf/util/bpf-loader.c                           |  2 +-
 tools/perf/util/config.c                               |  2 +-
 tools/perf/util/cs-etm.h                               |  3 ++-
 tools/perf/util/demangle-java.c                        |  2 +-
 tools/perf/util/dso.h                                  |  2 +-
 tools/perf/util/evsel.c                                |  2 +-
 tools/perf/util/header.c                               | 16 ++++++++--------
 tools/perf/util/intel-pt.c                             |  2 +-
 tools/perf/util/machine.c                              |  2 +-
 tools/perf/util/map.h                                  |  4 ++--
 tools/perf/util/parse-events.c                         |  4 ++--
 tools/perf/util/pmu.c                                  |  2 +-
 tools/perf/util/probe-finder.c                         |  2 +-
 tools/perf/util/scripting-engines/trace-event-python.c |  2 +-
 tools/perf/util/session.c                              |  2 +-
 tools/perf/util/strbuf.h                               |  2 +-
 tools/perf/util/strfilter.h                            |  4 ++--
 24 files changed, 44 insertions(+), 43 deletions(-)

diff --git a/tools/perf/arch/arm64/util/machine.c b/tools/perf/arch/arm64/util/machine.c
index 40c5e0b5bda8..acdf8dc1189b 100644
--- a/tools/perf/arch/arm64/util/machine.c
+++ b/tools/perf/arch/arm64/util/machine.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/ SPDX-License-Identifier: GPL-2.0
 
 #include <inttypes.h>
 #include <stdio.h>
@@ -6,11 +6,11 @@
 #include "debug.h"
 #include "symbol.h"
 
-/* On arm64, kernel text segment start at high memory address,
+/* On arm64, kernel text segment starts at high memory address,
  * for example 0xffff 0000 8xxx xxxx. Modules start at a low memory
- * address, like 0xffff 0000 00ax xxxx. When only samll amount of
+ * address, like 0xffff 0000 00ax xxxx. When only small amount of
  * memory is used by modules, gap between end of module's text segment
- * and start of kernel text segment may be reach 2G.
+ * and start of kernel text segment may reach 2G.
  * Therefore do not fill this gap and do not assign it to the kernel dso map.
  */
 
diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index b80437971d80..a262dcd020f4 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -262,7 +262,7 @@ int sys_enter(struct syscall_enter_args *args)
 	/*
 	 * Jump to syscall specific augmenter, even if the default one,
 	 * "!raw_syscalls:unaugmented" that will just return 1 to return the
-	 * unagmented tracepoint payload.
+	 * unaugmented tracepoint payload.
 	 */
 	bpf_tail_call(args, &syscalls_sys_enter, augmented_args->args.syscall_nr);
 
@@ -282,7 +282,7 @@ int sys_exit(struct syscall_exit_args *args)
 	/*
 	 * Jump to syscall specific return augmenter, even if the default one,
 	 * "!raw_syscalls:unaugmented" that will just return 1 to return the
-	 * unagmented tracepoint payload.
+	 * unaugmented tracepoint payload.
 	 */
 	bpf_tail_call(args, &syscalls_sys_exit, exit_args.syscall_nr);
 	/*
diff --git a/tools/perf/pmu-events/arch/powerpc/power8/metrics.json b/tools/perf/pmu-events/arch/powerpc/power8/metrics.json
index fc4aa6c2ddc9..4e25525b7da6 100644
--- a/tools/perf/pmu-events/arch/powerpc/power8/metrics.json
+++ b/tools/perf/pmu-events/arch/powerpc/power8/metrics.json
@@ -885,37 +885,37 @@
         "MetricName": "flush_rate_percent"
     },
     {
-        "BriefDescription": "GCT slot utilization (11 to 14) as a % of cycles this thread had atleast 1 slot valid",
+        "BriefDescription": "GCT slot utilization (11 to 14) as a % of cycles this thread had at least 1 slot valid",
         "MetricExpr": "PM_GCT_UTIL_11_14_ENTRIES / ( PM_RUN_CYC - PM_GCT_NOSLOT_CYC) * 100",
         "MetricGroup": "general",
         "MetricName": "gct_util_11to14_slots_percent"
     },
     {
-        "BriefDescription": "GCT slot utilization (15 to 17) as a % of cycles this thread had atleast 1 slot valid",
+        "BriefDescription": "GCT slot utilization (15 to 17) as a % of cycles this thread had at least 1 slot valid",
         "MetricExpr": "PM_GCT_UTIL_15_17_ENTRIES / ( PM_RUN_CYC - PM_GCT_NOSLOT_CYC) * 100",
         "MetricGroup": "general",
         "MetricName": "gct_util_15to17_slots_percent"
     },
     {
-        "BriefDescription": "GCT slot utilization 18+ as a % of cycles this thread had atleast 1 slot valid",
+        "BriefDescription": "GCT slot utilization 18+ as a % of cycles this thread had at least 1 slot valid",
         "MetricExpr": "PM_GCT_UTIL_18_ENTRIES / ( PM_RUN_CYC - PM_GCT_NOSLOT_CYC) * 100",
         "MetricGroup": "general",
         "MetricName": "gct_util_18plus_slots_percent"
     },
     {
-        "BriefDescription": "GCT slot utilization (1 to 2) as a % of cycles this thread had atleast 1 slot valid",
+        "BriefDescription": "GCT slot utilization (1 to 2) as a % of cycles this thread had at least 1 slot valid",
         "MetricExpr": "PM_GCT_UTIL_1_2_ENTRIES /  ( PM_RUN_CYC - PM_GCT_NOSLOT_CYC) * 100",
         "MetricGroup": "general",
         "MetricName": "gct_util_1to2_slots_percent"
     },
     {
-        "BriefDescription": "GCT slot utilization (3 to 6) as a % of cycles this thread had atleast 1 slot valid",
+        "BriefDescription": "GCT slot utilization (3 to 6) as a % of cycles this thread had at least 1 slot valid",
         "MetricExpr": "PM_GCT_UTIL_3_6_ENTRIES / ( PM_RUN_CYC - PM_GCT_NOSLOT_CYC) * 100",
         "MetricGroup": "general",
         "MetricName": "gct_util_3to6_slots_percent"
     },
     {
-        "BriefDescription": "GCT slot utilization (7 to 10) as a % of cycles this thread had atleast 1 slot valid",
+        "BriefDescription": "GCT slot utilization (7 to 10) as a % of cycles this thread had at least 1 slot valid",
         "MetricExpr": "PM_GCT_UTIL_7_10_ENTRIES / ( PM_RUN_CYC - PM_GCT_NOSLOT_CYC) * 100",
         "MetricGroup": "general",
         "MetricName": "gct_util_7to10_slots_percent"
diff --git a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
index f8784c608479..9eadef7f0677 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
@@ -1823,7 +1823,7 @@
         "MetricName": "custom_secs"
     },
     {
-        "BriefDescription": "Percentage Cycles atleast one instruction dispatched",
+        "BriefDescription": "Percentage Cycles at least one instruction dispatched",
         "MetricExpr": "PM_1PLUS_PPC_DISP / PM_CYC * 100",
         "MetricName": "cycles_atleast_one_inst_dispatched_percent"
     },
diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index e1f3f5c8c550..33aa3c885eaf 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -1149,7 +1149,7 @@ static int process_one_file(const char *fpath, const struct stat *sb,
 	 * and directory tree could result in build failure due to table
 	 * names not being found.
 	 *
-	 * Atleast for now, be strict with processing JSON file names.
+	 * At least for now, be strict with processing JSON file names.
 	 * i.e. if JSON file name cannot be mapped to C-style table name,
 	 * fail.
 	 */
diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
index ded580f8f657..ef37353636d8 100644
--- a/tools/perf/tests/bp_signal.c
+++ b/tools/perf/tests/bp_signal.c
@@ -229,7 +229,7 @@ int test__bp_signal(struct test *test __maybe_unused, int subtest __maybe_unused
 	 *   the wrong RF EFLAG management
 	 *
 	 * - we never trigger the sig_handler breakpoint due
-	 *   to the rong RF EFLAG management
+	 *   to the wrong RF EFLAG management
 	 *
 	 */
 
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index a7f6661e6112..026c54743311 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -20,7 +20,7 @@
 
 #if defined(__s390x__)
 /* Return true if kvm module is available and loaded. Test this
- * and retun success when trace point kvm_s390_create_vm
+ * and return success when trace point kvm_s390_create_vm
  * exists. Otherwise this test always fails.
  */
 static bool kvm_s390_create_vm_valid(void)
diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 9087f1bffd3d..fbb3c4057c30 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -671,7 +671,7 @@ int bpf__probe(struct bpf_object *obj)
 		 * After probing, let's consider prologue, which
 		 * adds program fetcher to BPF programs.
 		 *
-		 * hook_load_preprocessorr() hooks pre-processor
+		 * hook_load_preprocessor() hooks pre-processor
 		 * to bpf_program, let it generate prologue
 		 * dynamically during loading.
 		 */
diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 6984c77068a3..2daeaa9a4a24 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -699,7 +699,7 @@ static int collect_config(const char *var, const char *value,
 	/* perf_config_set can contain both user and system config items.
 	 * So we should know where each value is from.
 	 * The classification would be needed when a particular config file
-	 * is overwrited by setting feature i.e. set_config().
+	 * is overwritten by setting feature i.e. set_config().
 	 */
 	if (strcmp(config_file_name, perf_etc_perfconfig()) == 0) {
 		section->from_system_config = true;
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index cc3c9e11a8e3..0045457fb96a 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -12,7 +12,8 @@
 
 struct perf_session;
 
-/* Versionning header in case things need tro change in the future.  That way
+/*
+ * Versioning header in case things need to change in the future.  That way
  * decoding of old snapshot is still possible.
  */
 enum {
diff --git a/tools/perf/util/demangle-java.c b/tools/perf/util/demangle-java.c
index 090d9face27a..ddf33d58bcd3 100644
--- a/tools/perf/util/demangle-java.c
+++ b/tools/perf/util/demangle-java.c
@@ -164,7 +164,7 @@ java_demangle_sym(const char *str, int flags)
 	if (!str)
 		return NULL;
 
-	/* find start of retunr type */
+	/* find start of return type */
 	p = strrchr(str, ')');
 	if (!p)
 		return NULL;
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index cd2fe64a3c5d..52e7101c5609 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -216,7 +216,7 @@ struct dso {
 
 /* dso__for_each_symbol - iterate over the symbols of given type
  *
- * @dso: the 'struct dso *' in which symbols itereated
+ * @dso: the 'struct dso *' in which symbols are iterated
  * @pos: the 'struct symbol *' to use as a loop cursor
  * @n: the 'struct rb_node *' to use as a temporary storage
  */
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index b072ee5d5008..2d2614eeaa20 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2275,7 +2275,7 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		/*
 		 * Undo swap of u64, then swap on individual u32s,
 		 * get the size of the raw area and undo all of the
-		 * swap. The pevent interface handles endianity by
+		 * swap. The pevent interface handles endianness by
 		 * itself.
 		 */
 		if (swapped) {
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 4572aa981db5..aa1e42518d37 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -127,7 +127,7 @@ static int __do_write_buf(struct feat_fd *ff,  const void *buf, size_t size)
 	return 0;
 }
 
-/* Return: 0 if succeded, -ERR if failed. */
+/* Return: 0 if succeeded, -ERR if failed. */
 int do_write(struct feat_fd *ff, const void *buf, size_t size)
 {
 	if (!ff->buf)
@@ -135,7 +135,7 @@ int do_write(struct feat_fd *ff, const void *buf, size_t size)
 	return __do_write_buf(ff, buf, size);
 }
 
-/* Return: 0 if succeded, -ERR if failed. */
+/* Return: 0 if succeeded, -ERR if failed. */
 static int do_write_bitmap(struct feat_fd *ff, unsigned long *set, u64 size)
 {
 	u64 *p = (u64 *) set;
@@ -154,7 +154,7 @@ static int do_write_bitmap(struct feat_fd *ff, unsigned long *set, u64 size)
 	return 0;
 }
 
-/* Return: 0 if succeded, -ERR if failed. */
+/* Return: 0 if succeeded, -ERR if failed. */
 int write_padded(struct feat_fd *ff, const void *bf,
 		 size_t count, size_t count_aligned)
 {
@@ -170,7 +170,7 @@ int write_padded(struct feat_fd *ff, const void *bf,
 #define string_size(str)						\
 	(PERF_ALIGN((strlen(str) + 1), NAME_ALIGN) + sizeof(u32))
 
-/* Return: 0 if succeded, -ERR if failed. */
+/* Return: 0 if succeeded, -ERR if failed. */
 static int do_write_string(struct feat_fd *ff, const char *str)
 {
 	u32 len, olen;
@@ -266,7 +266,7 @@ static char *do_read_string(struct feat_fd *ff)
 	return NULL;
 }
 
-/* Return: 0 if succeded, -ERR if failed. */
+/* Return: 0 if succeeded, -ERR if failed. */
 static int do_read_bitmap(struct feat_fd *ff, unsigned long **pset, u64 *psize)
 {
 	unsigned long *set;
@@ -2874,7 +2874,7 @@ static int process_bpf_prog_info(struct feat_fd *ff, void *data __maybe_unused)
 	int err = -1;
 
 	if (ff->ph->needs_swap) {
-		pr_warning("interpreting bpf_prog_info from systems with endianity is not yet supported\n");
+		pr_warning("interpreting bpf_prog_info from systems with endianness is not yet supported\n");
 		return 0;
 	}
 
@@ -2942,7 +2942,7 @@ static int process_bpf_btf(struct feat_fd *ff, void *data __maybe_unused)
 	int err = -1;
 
 	if (ff->ph->needs_swap) {
-		pr_warning("interpreting btf from systems with endianity is not yet supported\n");
+		pr_warning("interpreting btf from systems with endianness is not yet supported\n");
 		return 0;
 	}
 
@@ -3481,7 +3481,7 @@ static const size_t attr_pipe_abi_sizes[] = {
 };
 
 /*
- * In the legacy pipe format, there is an implicit assumption that endiannesss
+ * In the legacy pipe format, there is an implicit assumption that endianness
  * between host recording the samples, and host parsing the samples is the
  * same. This is not always the case given that the pipe output may always be
  * redirected into a file and analyzed on a different machine with possibly a
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index f6e28ac231b7..8658d42ce57a 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -3569,7 +3569,7 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 	/*
 	 * Since this thread will not be kept in any rbtree not in a
 	 * list, initialize its list node so that at thread__put() the
-	 * current thread lifetime assuption is kept and we don't segfault
+	 * current thread lifetime assumption is kept and we don't segfault
 	 * at list_del_init().
 	 */
 	INIT_LIST_HEAD(&pt->unknown_thread->node);
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 0450032b4a3e..4abe630e9f67 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2518,7 +2518,7 @@ static bool has_stitched_lbr(struct thread *thread,
 
 	/*
 	 * Check if there are identical LBRs between two samples.
-	 * Identicall LBRs must have same from, to and flags values. Also,
+	 * Identical LBRs must have same from, to and flags values. Also,
 	 * they have to be saved in the same LBR registers (same physical
 	 * index).
 	 *
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 9f32825c98d8..d32f5b28c1fb 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -75,7 +75,7 @@ struct thread;
 
 /* map__for_each_symbol - iterate over the symbols in the given map
  *
- * @map: the 'struct map *' in which symbols itereated
+ * @map: the 'struct map *' in which symbols are iterated
  * @pos: the 'struct symbol *' to use as a loop cursor
  * @n: the 'struct rb_node *' to use as a temporary storage
  * Note: caller must ensure map->dso is not NULL (map is loaded).
@@ -86,7 +86,7 @@ struct thread;
 /* map__for_each_symbol_with_name - iterate over the symbols in the given map
  *                                  that have the given name
  *
- * @map: the 'struct map *' in which symbols itereated
+ * @map: the 'struct map *' in which symbols are iterated
  * @sym_name: the symbol name
  * @pos: the 'struct symbol *' to use as a loop cursor
  */
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index ff7b17543879..9ecb45bea948 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1182,10 +1182,10 @@ do {									   \
 	}
 
 	/*
-	 * Check term availbility after basic checking so
+	 * Check term availability after basic checking so
 	 * PARSE_EVENTS__TERM_TYPE_USER can be found and filtered.
 	 *
-	 * If check availbility at the entry of this function,
+	 * If check availability at the entry of this function,
 	 * user will see "'<sysfs term>' is not usable in 'perf stat'"
 	 * if an invalid config term is provided for legacy events
 	 * (for example, instructions/badterm/...), which is confusing.
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 6ffc6bb20de6..88da5cf6aee8 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1069,7 +1069,7 @@ int perf_pmu__format_type(struct list_head *formats, const char *name)
 
 /*
  * Sets value based on the format definition (format parameter)
- * and unformated value (value parameter).
+ * and unformatted value (value parameter).
  */
 static void pmu_format_value(unsigned long *format, __u64 value, __u64 *v,
 			     bool zero)
diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 954c63570181..866f2d514d72 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -498,7 +498,7 @@ static int convert_variable_fields(Dwarf_Die *vr_die, const char *varname,
 			       " nor array.\n", varname);
 			return -EINVAL;
 		}
-		/* While prcessing unnamed field, we don't care about this */
+		/* While processing unnamed field, we don't care about this */
 		if (field->ref && dwarf_diename(vr_die)) {
 			pr_err("Semantic error: %s must be referred by '.'\n",
 			       field->name);
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index c83c2c6564e0..4e4aa4c97ac5 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -1531,7 +1531,7 @@ static void set_table_handlers(struct tables *tables)
 		 * Attempt to use the call path root from the call return
 		 * processor, if the call return processor is in use. Otherwise,
 		 * we allocate a new call path root. This prevents exporting
-		 * duplicate call path ids when both are in use simultaniously.
+		 * duplicate call path ids when both are in use simultaneously.
 		 */
 		if (tables->dbe.crp)
 			tables->dbe.cpr = tables->dbe.crp->cpr;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index f5becf67c350..9a8808507bd9 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1584,7 +1584,7 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 		return tool->event_update(tool, event, &session->evlist);
 	case PERF_RECORD_HEADER_EVENT_TYPE:
 		/*
-		 * Depreceated, but we need to handle it for sake
+		 * Deprecated, but we need to handle it for sake
 		 * of old data files create in pipe mode.
 		 */
 		return 0;
diff --git a/tools/perf/util/strbuf.h b/tools/perf/util/strbuf.h
index ea94d8628980..be94d7046fa0 100644
--- a/tools/perf/util/strbuf.h
+++ b/tools/perf/util/strbuf.h
@@ -12,7 +12,7 @@
  *    build complex strings/buffers whose final size isn't easily known.
  *
  *    It is NOT legal to copy the ->buf pointer away.
- *    `strbuf_detach' is the operation that detachs a buffer from its shell
+ *    `strbuf_detach' is the operation that detaches a buffer from its shell
  *    while keeping the shell valid wrt its invariants.
  *
  * 2. the ->buf member is a byte array that has at least ->len + 1 bytes
diff --git a/tools/perf/util/strfilter.h b/tools/perf/util/strfilter.h
index e0c25a40f796..c05aca9ca582 100644
--- a/tools/perf/util/strfilter.h
+++ b/tools/perf/util/strfilter.h
@@ -8,8 +8,8 @@
 
 /* A node of string filter */
 struct strfilter_node {
-	struct strfilter_node *l;	/* Tree left branche (for &,|) */
-	struct strfilter_node *r;	/* Tree right branche (for !,&,|) */
+	struct strfilter_node *l;	/* Tree left branch (for &,|) */
+	struct strfilter_node *r;	/* Tree right branch (for !,&,|) */
 	const char *p;		/* Operator or rule */
 };
 
