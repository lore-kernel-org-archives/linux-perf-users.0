Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409E2C433FE
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Nov 2021 06:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29BEB604DA
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Nov 2021 06:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhKDGo6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 Nov 2021 02:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbhKDGo5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 Nov 2021 02:44:57 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A60C06127A
        for <linux-perf-users@vger.kernel.org>; Wed,  3 Nov 2021 23:42:19 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v133-20020a25c58b000000b005c20153475dso7433395ybe.17
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Nov 2021 23:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iGY+bzlDkdxl1sPcBbGPuMwugO0z2kYSKr2fRX1RCdw=;
        b=Mxyotuj6/6L6ImGYQTLfEqe90PApOVyXoO32BfAP+DyvL0fbFsWIC5SD1N4KYVW6Jq
         tQYqK25zt1wco9ipAjuxxig0cnNr+exO6ETOaqjQRs4vMCCD4lqbCu12dgEggEwzlUi1
         xAyXc9UGNoWMPTVwuBeAvHQYRMVCbhfwN9OxZqmfFRbO5Mi78XAyVPAx580llGu1C8cF
         xB7tumMF1WdDJvEEuA3QDBYrKmU9gZKfd6zzD7PQimW2wTRQrRa/ELekfVSgaUNIfr8d
         oIztXLMN64xyKbY+dF9hrRNeXPehUI/YxUUQJpxsmtVpP2RJXxWwEIt+eoIAr8zjql1O
         +g+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iGY+bzlDkdxl1sPcBbGPuMwugO0z2kYSKr2fRX1RCdw=;
        b=ZWEpNbkJgb2CgDKovr7ZtKVaEDrAB7rcUSoAlcig3C2zrV3afcttl/eZb9QlVzY3wI
         FdAeBX9exLjGEAyEHbjBBhLCnsN/gMXYyNmMuU0u8YXNVDUCPJRyZOjI5kMmQPL1yC5G
         Exo59KACdozUXtzEsEHh14DsIcuew0efoClrRKZXY0JBmviK5oBK+CNrnmH0I8s4s22Q
         FDeq6wbSAl3K2rXsEsqhbqCiB3yKDokwY5orI+OJ5P/pimqkFizg7vwOxMK6ExgNO89h
         5GOgoDOGc4QV1kA5j/PIpt5M4UxTLQWOARGJNId171Ze0m2NcEhmfnDcO/2nO/k91gt2
         fQDA==
X-Gm-Message-State: AOAM533sE2UFax5ahEjdAc04pPqDlhqw22ucvl7s4ZmBAE+5wPuNPKLi
        88xzPJXsTXPtgPGcBqpt4QoNzpnDg6Xv
X-Google-Smtp-Source: ABdhPJxDh533hKvWxcmCB4K2NJft6vPzOy6NHNtii22F7T48pTkIL021tal0Fe84af2/FzXvNV8f5xcmndMq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:8ce:af84:2510:3f29])
 (user=irogers job=sendgmr) by 2002:a25:6b4e:: with SMTP id
 o14mr26152143ybm.86.1636008139149; Wed, 03 Nov 2021 23:42:19 -0700 (PDT)
Date:   Wed,  3 Nov 2021 23:41:48 -0700
In-Reply-To: <20211104064208.3156807-1-irogers@google.com>
Message-Id: <20211104064208.3156807-3-irogers@google.com>
Mime-Version: 1.0
References: <20211104064208.3156807-1-irogers@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v3 02/22] perf test: Use macro for "suite" definitions
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
        David Gow <davidgow@google.com>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>
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
2.33.1.1089.g2158813163f-goog

