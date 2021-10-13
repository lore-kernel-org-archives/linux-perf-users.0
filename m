Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B1EC4332F
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Oct 2021 17:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0341F610C9
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Oct 2021 17:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238133AbhJMRsb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Oct 2021 13:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234305AbhJMRsa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Oct 2021 13:48:30 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26898C061746
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Oct 2021 10:46:27 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id p8-20020a056902114800b005bad2571fbeso3882539ybu.23
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Oct 2021 10:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=i/zTZxvx8/aJHpd2+1mkyCJW//7bmomDEIu/oyMfODE=;
        b=PD9QeP/HlWEcKr060uEvtFHc6GhDUFsQdO86G842MvQS89MIHzA4UoA4qhe2oTDX7F
         e+add/qA+GpmFd8HsNCzcMrjHCboRlZjxPB7i5BbrBdG6tp90tLxlsDKfIkFeECgaTd4
         nD4j8uGS1L+zDH96U10g6VqabmStJM6P38UQl4R2y5bJQgDCh8U1lWlPcFHhIWYd0Fl5
         kcq9TxwSXJjh0ttluj1O9cngMqHm1VBpD5HaUoDLwOmmW+8Xo80Aruc7C0r2z6vSj+B6
         f5wCr8Jr2OBgvl55RJL47d4CUF/kUfMslSyG6X578yPtOcKGvZk1f/5CoADWSHsc97x8
         RAMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=i/zTZxvx8/aJHpd2+1mkyCJW//7bmomDEIu/oyMfODE=;
        b=6ELzcwRpmjZv+u3iDSqgx4jaKw0LHWdjXWi0Gn1SRKMoDDglTqgx7axyztOJQcxAOI
         mL/onmr+tqPn607YA2uiGLDvres7BCK4nUkR+Ug/aSu9ZhFYxZ1aayCAd8xDr7wtk4z6
         HTW53WKnlS1c3/Atv+ZIV0yVbErs9aBy+RZaEBWxrKVNlMvIKu40Pm8PVShjZs+pTAmW
         ZRC1OFoi2VeiE/4tAVYUfIM6Nw7nBj7l4P6r/CY78Lnx8dD4ikZZEhMYySsZcE1pg60s
         kyBvTcNSQtyFpid/vsvBYrjzKOWyAxtP+4LueJIx3Hu6CQc8+HKO/BBxl0fIwxrE87Ww
         mFpA==
X-Gm-Message-State: AOAM532v2Olcgyegd+/lmyFwSgCprFjrDcV/st/UeBEX+f33Zdvcjha0
        LCK+hlSaz3lfgLMynnxEWoY7XT6TzN2r
X-Google-Smtp-Source: ABdhPJyQ44rmwX7SNN0mcbkVRmLg8HM69x6Dp60zI9daRlEGn5F3tbpYeISWmEhJ1vyS1MZB7xb41w/GgHDT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:aeaf:8e9e:3df2:aad9])
 (user=irogers job=sendgmr) by 2002:a25:be0c:: with SMTP id
 h12mr819681ybk.29.1634147186376; Wed, 13 Oct 2021 10:46:26 -0700 (PDT)
Date:   Wed, 13 Oct 2021 10:45:44 -0700
In-Reply-To: <20211013174604.747276-1-irogers@google.com>
Message-Id: <20211013174604.747276-3-irogers@google.com>
Mime-Version: 1.0
References: <20211013174604.747276-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v2 02/22] perf test: Use macro for "suite" definitions
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add a macro to simplify later refactoring. No functional change.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 479 ++++++++++----------------------
 1 file changed, 149 insertions(+), 330 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index da7dc5e45d0c..820fc1ae2210 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -36,337 +36,156 @@ struct test __weak arch_tests[] = {
 	},
 };
 
-static struct test generic_tests[] = {
-	{
-		.desc = "vmlinux symtab matches kallsyms",
-		.func = test__vmlinux_matches_kallsyms,
-	},
-	{
-		.desc = "Detect openat syscall event",
-		.func = test__openat_syscall_event,
-	},
-	{
-		.desc = "Detect openat syscall event on all cpus",
-		.func = test__openat_syscall_event_on_all_cpus,
-	},
-	{
-		.desc = "Read samples using the mmap interface",
-		.func = test__basic_mmap,
-	},
-	{
-		.desc = "Test data source output",
-		.func = test__mem,
-	},
-	{
-		.desc = "Parse event definition strings",
-		.func = test__parse_events,
-	},
-	{
-		.desc = "Simple expression parser",
-		.func = test__expr,
-	},
-	{
-		.desc = "PERF_RECORD_* events & perf_sample fields",
-		.func = test__PERF_RECORD,
-	},
-	{
-		.desc = "Parse perf pmu format",
-		.func = test__pmu,
-	},
-	{
-		.desc = "PMU events",
-		.func = test__pmu_events,
-		.subtest = {
-			.skip_if_fail	= false,
-			.get_nr		= test__pmu_events_subtest_get_nr,
-			.get_desc	= test__pmu_events_subtest_get_desc,
-			.skip_reason	= test__pmu_events_subtest_skip_reason,
-		},
-
-	},
-	{
-		.desc = "DSO data read",
-		.func = test__dso_data,
-	},
-	{
-		.desc = "DSO data cache",
-		.func = test__dso_data_cache,
-	},
-	{
-		.desc = "DSO data reopen",
-		.func = test__dso_data_reopen,
-	},
-	{
-		.desc = "Roundtrip evsel->name",
-		.func = test__perf_evsel__roundtrip_name_test,
-	},
-	{
-		.desc = "Parse sched tracepoints fields",
-		.func = test__perf_evsel__tp_sched_test,
-	},
-	{
-		.desc = "syscalls:sys_enter_openat event fields",
-		.func = test__syscall_openat_tp_fields,
-	},
-	{
-		.desc = "Setup struct perf_event_attr",
-		.func = test__attr,
-	},
-	{
-		.desc = "Match and link multiple hists",
-		.func = test__hists_link,
-	},
-	{
-		.desc = "'import perf' in python",
-		.func = test__python_use,
-	},
-	{
-		.desc = "Breakpoint overflow signal handler",
-		.func = test__bp_signal,
-		.is_supported = test__bp_signal_is_supported,
-	},
-	{
-		.desc = "Breakpoint overflow sampling",
-		.func = test__bp_signal_overflow,
-		.is_supported = test__bp_signal_is_supported,
-	},
-	{
-		.desc = "Breakpoint accounting",
-		.func = test__bp_accounting,
-		.is_supported = test__bp_account_is_supported,
-	},
-	{
-		.desc = "Watchpoint",
-		.func = test__wp,
-		.is_supported = test__wp_is_supported,
-		.subtest = {
-			.skip_if_fail	= false,
-			.get_nr		= test__wp_subtest_get_nr,
-			.get_desc	= test__wp_subtest_get_desc,
-			.skip_reason    = test__wp_subtest_skip_reason,
-		},
-	},
-	{
-		.desc = "Number of exit events of a simple workload",
-		.func = test__task_exit,
-	},
-	{
-		.desc = "Software clock events period values",
-		.func = test__sw_clock_freq,
-	},
-	{
-		.desc = "Object code reading",
-		.func = test__code_reading,
-	},
-	{
-		.desc = "Sample parsing",
-		.func = test__sample_parsing,
-	},
-	{
-		.desc = "Use a dummy software event to keep tracking",
-		.func = test__keep_tracking,
-	},
-	{
-		.desc = "Parse with no sample_id_all bit set",
-		.func = test__parse_no_sample_id_all,
-	},
-	{
-		.desc = "Filter hist entries",
-		.func = test__hists_filter,
-	},
-	{
-		.desc = "Lookup mmap thread",
-		.func = test__mmap_thread_lookup,
-	},
-	{
-		.desc = "Share thread maps",
-		.func = test__thread_maps_share,
-	},
-	{
-		.desc = "Sort output of hist entries",
-		.func = test__hists_output,
-	},
-	{
-		.desc = "Cumulate child hist entries",
-		.func = test__hists_cumulate,
-	},
-	{
-		.desc = "Track with sched_switch",
-		.func = test__switch_tracking,
-	},
-	{
-		.desc = "Filter fds with revents mask in a fdarray",
-		.func = test__fdarray__filter,
-	},
-	{
-		.desc = "Add fd to a fdarray, making it autogrow",
-		.func = test__fdarray__add,
-	},
-	{
-		.desc = "kmod_path__parse",
-		.func = test__kmod_path__parse,
-	},
-	{
-		.desc = "Thread map",
-		.func = test__thread_map,
-	},
-	{
-		.desc = "LLVM search and compile",
-		.func = test__llvm,
-		.subtest = {
-			.skip_if_fail	= true,
-			.get_nr		= test__llvm_subtest_get_nr,
-			.get_desc	= test__llvm_subtest_get_desc,
-		},
-	},
-	{
-		.desc = "Session topology",
-		.func = test__session_topology,
-	},
-	{
-		.desc = "BPF filter",
-		.func = test__bpf,
-		.subtest = {
-			.skip_if_fail	= true,
-			.get_nr		= test__bpf_subtest_get_nr,
-			.get_desc	= test__bpf_subtest_get_desc,
-		},
-	},
-	{
-		.desc = "Synthesize thread map",
-		.func = test__thread_map_synthesize,
-	},
-	{
-		.desc = "Remove thread map",
-		.func = test__thread_map_remove,
-	},
-	{
-		.desc = "Synthesize cpu map",
-		.func = test__cpu_map_synthesize,
-	},
-	{
-		.desc = "Synthesize stat config",
-		.func = test__synthesize_stat_config,
-	},
-	{
-		.desc = "Synthesize stat",
-		.func = test__synthesize_stat,
-	},
-	{
-		.desc = "Synthesize stat round",
-		.func = test__synthesize_stat_round,
-	},
-	{
-		.desc = "Synthesize attr update",
-		.func = test__event_update,
-	},
-	{
-		.desc = "Event times",
-		.func = test__event_times,
-	},
-	{
-		.desc = "Read backward ring buffer",
-		.func = test__backward_ring_buffer,
-	},
-	{
-		.desc = "Print cpu map",
-		.func = test__cpu_map_print,
-	},
-	{
-		.desc = "Merge cpu map",
-		.func = test__cpu_map_merge,
-	},
+#define DEFINE_SUITE(description, name)		\
+	{					\
+		.desc = description,		\
+		.func = test__##name,		\
+	}
 
-	{
-		.desc = "Probe SDT events",
-		.func = test__sdt_event,
-	},
-	{
-		.desc = "is_printable_array",
-		.func = test__is_printable_array,
-	},
-	{
-		.desc = "Print bitmap",
-		.func = test__bitmap_print,
-	},
-	{
-		.desc = "perf hooks",
-		.func = test__perf_hooks,
-	},
-	{
-		.desc = "builtin clang support",
-		.func = test__clang,
-		.subtest = {
-			.skip_if_fail	= true,
-			.get_nr		= test__clang_subtest_get_nr,
-			.get_desc	= test__clang_subtest_get_desc,
-		}
-	},
-	{
-		.desc = "unit_number__scnprintf",
-		.func = test__unit_number__scnprint,
-	},
-	{
-		.desc = "mem2node",
-		.func = test__mem2node,
-	},
-	{
-		.desc = "time utils",
-		.func = test__time_utils,
-	},
-	{
-		.desc = "Test jit_write_elf",
-		.func = test__jit_write_elf,
-	},
-	{
-		.desc = "Test libpfm4 support",
-		.func = test__pfm,
-		.subtest = {
-			.skip_if_fail	= true,
-			.get_nr		= test__pfm_subtest_get_nr,
-			.get_desc	= test__pfm_subtest_get_desc,
-		}
-	},
-	{
-		.desc = "Test api io",
-		.func = test__api_io,
-	},
-	{
-		.desc = "maps__merge_in",
-		.func = test__maps__merge_in,
-	},
-	{
-		.desc = "Demangle Java",
-		.func = test__demangle_java,
-	},
-	{
-		.desc = "Demangle OCaml",
-		.func = test__demangle_ocaml,
-	},
-	{
-		.desc = "Parse and process metrics",
-		.func = test__parse_metric,
-	},
-	{
-		.desc = "PE file support",
-		.func = test__pe_file_parsing,
-	},
-	{
-		.desc = "Event expansion for cgroups",
-		.func = test__expand_cgroup_events,
-	},
-	{
-		.desc = "Convert perf time to TSC",
-		.func = test__perf_time_to_tsc,
-		.is_supported = test__tsc_is_supported,
-	},
-	{
-		.desc = "dlfilter C API",
-		.func = test__dlfilter,
-	},
-	{
-		.func = NULL,
-	},
+static struct test generic_tests[] = {
+DEFINE_SUITE("vmlinux symtab matches kallsyms", vmlinux_matches_kallsyms),
+DEFINE_SUITE("Detect openat syscall event", openat_syscall_event),
+DEFINE_SUITE("Detect openat syscall event on all cpus", openat_syscall_event_on_all_cpus),
+DEFINE_SUITE("Read samples using the mmap interface", basic_mmap),
+DEFINE_SUITE("Test data source output", mem),
+DEFINE_SUITE("Parse event definition strings", parse_events),
+DEFINE_SUITE("Simple expression parser", expr),
+DEFINE_SUITE("PERF_RECORD_* events & perf_sample fields", PERF_RECORD),
+DEFINE_SUITE("Parse perf pmu format", pmu),
+{
+	.desc = "PMU events",
+	.func = test__pmu_events,
+	.subtest = {
+		.skip_if_fail	= false,
+		.get_nr		= test__pmu_events_subtest_get_nr,
+		.get_desc	= test__pmu_events_subtest_get_desc,
+		.skip_reason	= test__pmu_events_subtest_skip_reason,
+	},
+
+},
+DEFINE_SUITE("DSO data read", dso_data),
+DEFINE_SUITE("DSO data cache", dso_data_cache),
+DEFINE_SUITE("DSO data reopen", dso_data_reopen),
+DEFINE_SUITE("Roundtrip evsel->name", perf_evsel__roundtrip_name_test),
+DEFINE_SUITE("Parse sched tracepoints fields", perf_evsel__tp_sched_test),
+DEFINE_SUITE("syscalls:sys_enter_openat event fields", syscall_openat_tp_fields),
+DEFINE_SUITE("Setup struct perf_event_attr", attr),
+DEFINE_SUITE("Match and link multiple hists", hists_link),
+DEFINE_SUITE("'import perf' in python", python_use),
+{
+	.desc = "Breakpoint overflow signal handler",
+	.func = test__bp_signal,
+	.is_supported = test__bp_signal_is_supported,
+},
+{
+	.desc = "Breakpoint overflow sampling",
+	.func = test__bp_signal_overflow,
+	.is_supported = test__bp_signal_is_supported,
+},
+{
+	.desc = "Breakpoint accounting",
+	.func = test__bp_accounting,
+	.is_supported = test__bp_account_is_supported,
+},
+{
+	.desc = "Watchpoint",
+	.func = test__wp,
+	.is_supported = test__wp_is_supported,
+	.subtest = {
+		.skip_if_fail	= false,
+		.get_nr		= test__wp_subtest_get_nr,
+		.get_desc	= test__wp_subtest_get_desc,
+		.skip_reason    = test__wp_subtest_skip_reason,
+	},
+},
+DEFINE_SUITE("Number of exit events of a simple workload", task_exit),
+DEFINE_SUITE("Software clock events period values", sw_clock_freq),
+DEFINE_SUITE("Object code reading", code_reading),
+DEFINE_SUITE("Sample parsing", sample_parsing),
+DEFINE_SUITE("Use a dummy software event to keep tracking", keep_tracking),
+DEFINE_SUITE("Parse with no sample_id_all bit set", parse_no_sample_id_all),
+DEFINE_SUITE("Filter hist entries", hists_filter),
+DEFINE_SUITE("Lookup mmap thread", mmap_thread_lookup),
+DEFINE_SUITE("Share thread maps", thread_maps_share),
+DEFINE_SUITE("Sort output of hist entries", hists_output),
+DEFINE_SUITE("Cumulate child hist entries", hists_cumulate),
+DEFINE_SUITE("Track with sched_switch", switch_tracking),
+DEFINE_SUITE("Filter fds with revents mask in a fdarray", fdarray__filter),
+DEFINE_SUITE("Add fd to a fdarray, making it autogrow", fdarray__add),
+DEFINE_SUITE("kmod_path__parse", kmod_path__parse),
+DEFINE_SUITE("Thread map", thread_map),
+{
+	.desc = "LLVM search and compile",
+	.func = test__llvm,
+	.subtest = {
+		.skip_if_fail	= true,
+		.get_nr		= test__llvm_subtest_get_nr,
+		.get_desc	= test__llvm_subtest_get_desc,
+	},
+},
+DEFINE_SUITE("Session topology", session_topology),
+{
+	.desc = "BPF filter",
+	.func = test__bpf,
+	.subtest = {
+		.skip_if_fail	= true,
+		.get_nr		= test__bpf_subtest_get_nr,
+		.get_desc	= test__bpf_subtest_get_desc,
+	},
+},
+DEFINE_SUITE("Synthesize thread map", thread_map_synthesize),
+DEFINE_SUITE("Remove thread map", thread_map_remove),
+DEFINE_SUITE("Synthesize cpu map", cpu_map_synthesize),
+DEFINE_SUITE("Synthesize stat config", synthesize_stat_config),
+DEFINE_SUITE("Synthesize stat", synthesize_stat),
+DEFINE_SUITE("Synthesize stat round", synthesize_stat_round),
+DEFINE_SUITE("Synthesize attr update", event_update),
+DEFINE_SUITE("Event times", event_times),
+DEFINE_SUITE("Read backward ring buffer", backward_ring_buffer),
+DEFINE_SUITE("Print cpu map", cpu_map_print),
+DEFINE_SUITE("Merge cpu map", cpu_map_merge),
+DEFINE_SUITE("Probe SDT events", sdt_event),
+DEFINE_SUITE("is_printable_array", is_printable_array),
+DEFINE_SUITE("Print bitmap", bitmap_print),
+DEFINE_SUITE("perf hooks", perf_hooks),
+{
+	.desc = "builtin clang support",
+	.func = test__clang,
+	.subtest = {
+		.skip_if_fail	= true,
+		.get_nr		= test__clang_subtest_get_nr,
+		.get_desc	= test__clang_subtest_get_desc,
+	}
+},
+DEFINE_SUITE("unit_number__scnprintf", unit_number__scnprint),
+DEFINE_SUITE("mem2node", mem2node),
+DEFINE_SUITE("time utils", time_utils),
+DEFINE_SUITE("Test jit_write_elf", jit_write_elf),
+{
+	.desc = "Test libpfm4 support",
+	.func = test__pfm,
+	.subtest = {
+		.skip_if_fail	= true,
+		.get_nr		= test__pfm_subtest_get_nr,
+		.get_desc	= test__pfm_subtest_get_desc,
+	}
+},
+DEFINE_SUITE("Test api io", api_io),
+DEFINE_SUITE("maps__merge_in", maps__merge_in),
+DEFINE_SUITE("Demangle Java", demangle_java),
+DEFINE_SUITE("Demangle OCaml", demangle_ocaml),
+DEFINE_SUITE("Parse and process metrics", parse_metric),
+DEFINE_SUITE("PE file support", pe_file_parsing),
+DEFINE_SUITE("Event expansion for cgroups", expand_cgroup_events),
+{
+	.desc = "Convert perf time to TSC",
+	.func = test__perf_time_to_tsc,
+	.is_supported = test__tsc_is_supported,
+},
+DEFINE_SUITE("dlfilter C API", dlfilter),
+{
+	.func = NULL,
+},
 };
 
 static struct test *tests[] = {
-- 
2.33.0.882.g93a45727a2-goog

