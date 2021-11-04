Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06375C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Nov 2021 06:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFF7F604DA
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Nov 2021 06:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbhKDGo4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 Nov 2021 02:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhKDGoz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 Nov 2021 02:44:55 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B504C06127A
        for <linux-perf-users@vger.kernel.org>; Wed,  3 Nov 2021 23:42:17 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v133-20020a25c58b000000b005c20153475dso7433255ybe.17
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Nov 2021 23:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Thv7Uohz9wsGmAyO5CG5J0tYLFAqW43j/wiPvPMw4I0=;
        b=YNDdfNbltfYKMfZfBkVBRbJKCW9g7a67TZiri49mduiTnOk6bDFD3wHMZAL2USnqzr
         rug2IY023pNmwCxOGXCqbdzZ8XNTwfiFyFTLh+tNZQATPsvICKzgBUdLmMQHkSfEO14x
         VwzOS6WpNo7SKf0MoeGoqrvLK8R7zqq2yJSQeZtud+zybVbzE0cuTs+aMQW89ToZRWpL
         NinP6ImK9MkwmH3W476TtiHVA8QE5UIEFKvDFMpCXJVYpdcomEPADt6Z6/IjdfKahyE9
         sOQdIuTd5KfgxsQjcR2vRasyVKthQ4+Irye5Blj7DlrjDOGFX+S/96rfXbZUk09w+ULy
         u2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Thv7Uohz9wsGmAyO5CG5J0tYLFAqW43j/wiPvPMw4I0=;
        b=fiA42rbfPOdEKdTp4OMT1hGov0iu8sB+vt1d+bRQVTaA6C3/zF+aCDA2TMPiiLlOoZ
         ZFGitEHspifZjhuQs73IvoaxqoU2w+dBIPve3fR8Hh8db5ZoadZ0TQ5qa0LTFskHQLvg
         eaQsvakxY6HDSMpcQ/K+uMth2htJO1P+v3XSmQEfyB3NLybt1GK3/epaLbMWrEr4GxQt
         y+mcBO1qIYVJgdtqx8AcgApuSlMOO5GcDtI6U8C5xGY163E6wMrgBySVwqC4LCgZ1G/Q
         hABOADFCXZSs1NqO2njyNMzQFmOmtwjt8IuRW90NUcp35xS/AY7k11prxa/U4eHOk4I0
         5Hag==
X-Gm-Message-State: AOAM530aoO0dnwXVWRFV1yTWctq0IVwRUCG9u+Xrj4rHxmN/SN/dxIlt
        TPDJRMDPIbPVDYhktwKHvltTxHtwXD3x
X-Google-Smtp-Source: ABdhPJwU93iz2jbvzrTSy3ECXhTWvIaV1qUi/BpHA3zN7CIgaXno9kI9MnMXw7htW9HPH/rYir+n8ukfRbPF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:8ce:af84:2510:3f29])
 (user=irogers job=sendgmr) by 2002:a05:6902:4f4:: with SMTP id
 w20mr18396267ybs.421.1636008136669; Wed, 03 Nov 2021 23:42:16 -0700 (PDT)
Date:   Wed,  3 Nov 2021 23:41:47 -0700
In-Reply-To: <20211104064208.3156807-1-irogers@google.com>
Message-Id: <20211104064208.3156807-2-irogers@google.com>
Mime-Version: 1.0
References: <20211104064208.3156807-1-irogers@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v3 01/22] perf test: Use macro for "suite" declarations
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

Currently tests are setup in builtin-test with function pointers. Kunit
exposes tests as a kunit_suite with a null terminated array of test
cases. Use a macro to aid transition from one to the other in later
changes.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/tests.h | 151 ++++++++++++++++++++-------------------
 1 file changed, 77 insertions(+), 74 deletions(-)

diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index fe1306f58495..0846f66d67f9 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -40,94 +40,97 @@ struct test {
 	void *priv;
 };
 
+#define DECLARE_SUITE(name) \
+	int test__##name(struct test *test, int subtest)
+
 /* Tests */
-int test__vmlinux_matches_kallsyms(struct test *test, int subtest);
-int test__openat_syscall_event(struct test *test, int subtest);
-int test__openat_syscall_event_on_all_cpus(struct test *test, int subtest);
-int test__basic_mmap(struct test *test, int subtest);
-int test__PERF_RECORD(struct test *test, int subtest);
-int test__perf_evsel__roundtrip_name_test(struct test *test, int subtest);
-int test__perf_evsel__tp_sched_test(struct test *test, int subtest);
-int test__syscall_openat_tp_fields(struct test *test, int subtest);
-int test__pmu(struct test *test, int subtest);
-int test__pmu_events(struct test *test, int subtest);
+DECLARE_SUITE(vmlinux_matches_kallsyms);
+DECLARE_SUITE(openat_syscall_event);
+DECLARE_SUITE(openat_syscall_event_on_all_cpus);
+DECLARE_SUITE(basic_mmap);
+DECLARE_SUITE(PERF_RECORD);
+DECLARE_SUITE(perf_evsel__roundtrip_name_test);
+DECLARE_SUITE(perf_evsel__tp_sched_test);
+DECLARE_SUITE(syscall_openat_tp_fields);
+DECLARE_SUITE(pmu);
+DECLARE_SUITE(pmu_events);
 const char *test__pmu_events_subtest_get_desc(int subtest);
 const char *test__pmu_events_subtest_skip_reason(int subtest);
 int test__pmu_events_subtest_get_nr(void);
-int test__attr(struct test *test, int subtest);
-int test__dso_data(struct test *test, int subtest);
-int test__dso_data_cache(struct test *test, int subtest);
-int test__dso_data_reopen(struct test *test, int subtest);
-int test__parse_events(struct test *test, int subtest);
-int test__hists_link(struct test *test, int subtest);
-int test__python_use(struct test *test, int subtest);
-int test__bp_signal(struct test *test, int subtest);
-int test__bp_signal_overflow(struct test *test, int subtest);
-int test__bp_accounting(struct test *test, int subtest);
-int test__wp(struct test *test, int subtest);
+DECLARE_SUITE(attr);
+DECLARE_SUITE(dso_data);
+DECLARE_SUITE(dso_data_cache);
+DECLARE_SUITE(dso_data_reopen);
+DECLARE_SUITE(parse_events);
+DECLARE_SUITE(hists_link);
+DECLARE_SUITE(python_use);
+DECLARE_SUITE(bp_signal);
+DECLARE_SUITE(bp_signal_overflow);
+DECLARE_SUITE(bp_accounting);
+DECLARE_SUITE(wp);
 const char *test__wp_subtest_get_desc(int subtest);
 const char *test__wp_subtest_skip_reason(int subtest);
 int test__wp_subtest_get_nr(void);
-int test__task_exit(struct test *test, int subtest);
-int test__mem(struct test *test, int subtest);
-int test__sw_clock_freq(struct test *test, int subtest);
-int test__code_reading(struct test *test, int subtest);
-int test__sample_parsing(struct test *test, int subtest);
-int test__keep_tracking(struct test *test, int subtest);
-int test__parse_no_sample_id_all(struct test *test, int subtest);
-int test__dwarf_unwind(struct test *test, int subtest);
-int test__expr(struct test *test, int subtest);
-int test__hists_filter(struct test *test, int subtest);
-int test__mmap_thread_lookup(struct test *test, int subtest);
-int test__thread_maps_share(struct test *test, int subtest);
-int test__hists_output(struct test *test, int subtest);
-int test__hists_cumulate(struct test *test, int subtest);
-int test__switch_tracking(struct test *test, int subtest);
-int test__fdarray__filter(struct test *test, int subtest);
-int test__fdarray__add(struct test *test, int subtest);
-int test__kmod_path__parse(struct test *test, int subtest);
-int test__thread_map(struct test *test, int subtest);
-int test__llvm(struct test *test, int subtest);
+DECLARE_SUITE(task_exit);
+DECLARE_SUITE(mem);
+DECLARE_SUITE(sw_clock_freq);
+DECLARE_SUITE(code_reading);
+DECLARE_SUITE(sample_parsing);
+DECLARE_SUITE(keep_tracking);
+DECLARE_SUITE(parse_no_sample_id_all);
+DECLARE_SUITE(dwarf_unwind);
+DECLARE_SUITE(expr);
+DECLARE_SUITE(hists_filter);
+DECLARE_SUITE(mmap_thread_lookup);
+DECLARE_SUITE(thread_maps_share);
+DECLARE_SUITE(hists_output);
+DECLARE_SUITE(hists_cumulate);
+DECLARE_SUITE(switch_tracking);
+DECLARE_SUITE(fdarray__filter);
+DECLARE_SUITE(fdarray__add);
+DECLARE_SUITE(kmod_path__parse);
+DECLARE_SUITE(thread_map);
+DECLARE_SUITE(llvm);
 const char *test__llvm_subtest_get_desc(int subtest);
 int test__llvm_subtest_get_nr(void);
-int test__bpf(struct test *test, int subtest);
+DECLARE_SUITE(bpf);
 const char *test__bpf_subtest_get_desc(int subtest);
 int test__bpf_subtest_get_nr(void);
-int test__session_topology(struct test *test, int subtest);
-int test__thread_map_synthesize(struct test *test, int subtest);
-int test__thread_map_remove(struct test *test, int subtest);
-int test__cpu_map_synthesize(struct test *test, int subtest);
-int test__synthesize_stat_config(struct test *test, int subtest);
-int test__synthesize_stat(struct test *test, int subtest);
-int test__synthesize_stat_round(struct test *test, int subtest);
-int test__event_update(struct test *test, int subtest);
-int test__event_times(struct test *test, int subtest);
-int test__backward_ring_buffer(struct test *test, int subtest);
-int test__cpu_map_print(struct test *test, int subtest);
-int test__cpu_map_merge(struct test *test, int subtest);
-int test__sdt_event(struct test *test, int subtest);
-int test__is_printable_array(struct test *test, int subtest);
-int test__bitmap_print(struct test *test, int subtest);
-int test__perf_hooks(struct test *test, int subtest);
-int test__clang(struct test *test, int subtest);
+DECLARE_SUITE(session_topology);
+DECLARE_SUITE(thread_map_synthesize);
+DECLARE_SUITE(thread_map_remove);
+DECLARE_SUITE(cpu_map_synthesize);
+DECLARE_SUITE(synthesize_stat_config);
+DECLARE_SUITE(synthesize_stat);
+DECLARE_SUITE(synthesize_stat_round);
+DECLARE_SUITE(event_update);
+DECLARE_SUITE(event_times);
+DECLARE_SUITE(backward_ring_buffer);
+DECLARE_SUITE(cpu_map_print);
+DECLARE_SUITE(cpu_map_merge);
+DECLARE_SUITE(sdt_event);
+DECLARE_SUITE(is_printable_array);
+DECLARE_SUITE(bitmap_print);
+DECLARE_SUITE(perf_hooks);
+DECLARE_SUITE(clang);
 const char *test__clang_subtest_get_desc(int subtest);
 int test__clang_subtest_get_nr(void);
-int test__unit_number__scnprint(struct test *test, int subtest);
-int test__mem2node(struct test *t, int subtest);
-int test__maps__merge_in(struct test *t, int subtest);
-int test__time_utils(struct test *t, int subtest);
-int test__jit_write_elf(struct test *test, int subtest);
-int test__api_io(struct test *test, int subtest);
-int test__demangle_java(struct test *test, int subtest);
-int test__demangle_ocaml(struct test *test, int subtest);
-int test__pfm(struct test *test, int subtest);
+DECLARE_SUITE(unit_number__scnprint);
+DECLARE_SUITE(mem2node);
+DECLARE_SUITE(maps__merge_in);
+DECLARE_SUITE(time_utils);
+DECLARE_SUITE(jit_write_elf);
+DECLARE_SUITE(api_io);
+DECLARE_SUITE(demangle_java);
+DECLARE_SUITE(demangle_ocaml);
+DECLARE_SUITE(pfm);
 const char *test__pfm_subtest_get_desc(int subtest);
 int test__pfm_subtest_get_nr(void);
-int test__parse_metric(struct test *test, int subtest);
-int test__pe_file_parsing(struct test *test, int subtest);
-int test__expand_cgroup_events(struct test *test, int subtest);
-int test__perf_time_to_tsc(struct test *test, int subtest);
-int test__dlfilter(struct test *test, int subtest);
+DECLARE_SUITE(parse_metric);
+DECLARE_SUITE(pe_file_parsing);
+DECLARE_SUITE(expand_cgroup_events);
+DECLARE_SUITE(perf_time_to_tsc);
+DECLARE_SUITE(dlfilter);
 
 bool test__bp_signal_is_supported(void);
 bool test__bp_account_is_supported(void);
@@ -142,7 +145,7 @@ int test__arch_unwind_sample(struct perf_sample *sample,
 #endif
 
 #if defined(__arm__)
-int test__vectors_page(struct test *test, int subtest);
+DECLARE_SUITE(vectors_page);
 #endif
 
 #endif /* TESTS_H */
-- 
2.33.1.1089.g2158813163f-goog

