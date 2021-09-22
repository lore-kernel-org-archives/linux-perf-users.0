Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94551C433FE
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 08:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A28B6113E
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 08:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbhIVIVh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 22 Sep 2021 04:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233756AbhIVIVg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Sep 2021 04:21:36 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A3CC061756
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Sep 2021 01:20:07 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id az30-20020a05620a171e00b00432eb71d467so7786539qkb.18
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Sep 2021 01:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jhtmBJ6Dc/tyF1h7HVlvMIPOJAIqW+/3wSXrZ6EDJkw=;
        b=mY5WQJ3imda4F5EgsCfyLnnoZl+iJiJvNzmirryxnF2X+WYis286hsRFsGAOg4cZy+
         BO1lIeYbDYm6qN1H/xIqWS+HWI2hbD2wuteRaorJWIOA/K2hmSUlWfSjYDtaA3FhzV9p
         qqoHyuPyazhbAl6Z36rpzeZ09xU/ljmFcPKrokPE7S1r0srAdjGIBHYYERKZgopGsNsM
         /F18qsZHcQhiHAb0cZ0ZtERVdmn6NGVbd8uHmRfWZoINZtC9OeI2ryUlZ85LwltjeOCC
         tGqIpYkAjJ3/gZH7b1E9wgD1ILZg2J27iN6ddBhvWmBQpZMnhwgnpO2vUwoI0r/GwL3S
         jGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jhtmBJ6Dc/tyF1h7HVlvMIPOJAIqW+/3wSXrZ6EDJkw=;
        b=wOwm5EBOLoVF3DpHSuFUf7ObZzmxVUJEnYjqJ2FdgRWziAdvgRzYoBN6cATerl1Jtr
         voFFv9gTq2f/cSo5k89Rd4npKADdFx/mo732uftODwBZ28dYZ03xwI8/XVePK8x6fGqS
         1TkzbPibMPkFa9N0qCe4KcQ90z0QNQFyuGuzB0lVn4v3HreuAs8cPhLfNk1Ycl+mzZSm
         RH+RriIEuLDh3T7hwwnvXO6V7pdUXvYTVpp+bmDm3YnIcUSLwYv4+9jo6U/2sNR9mCY/
         O8VwQyWcl9MQPUTTF+qsmg+DNTxCvQw84nVFPy8yfv611eNPENAcJCIzu54YDHxShq3T
         MQ7A==
X-Gm-Message-State: AOAM530v1zELbauEY5VJgqSpKXirI1TMaqQNSMqYP+LSr0UaIEJsWJeI
        sl3Kj2nxrS0AWrpxXx0MpWayw6f3gjlM
X-Google-Smtp-Source: ABdhPJwXkiqK/VcswL+wbPj4KeaKc0cC/bXybc3E4rflhrxj7cXk825nJ9xs1rXna29j22Eb31/jj0zj6k0l
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:dffa:819a:f0e2:47e])
 (user=irogers job=sendgmr) by 2002:a05:6214:13a3:: with SMTP id
 h3mr35401554qvz.26.1632298806171; Wed, 22 Sep 2021 01:20:06 -0700 (PDT)
Date:   Wed, 22 Sep 2021 01:19:54 -0700
In-Reply-To: <20210922081959.390059-1-irogers@google.com>
Message-Id: <20210922081959.390059-2-irogers@google.com>
Mime-Version: 1.0
References: <20210922081959.390059-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [RFC PATCH 1/5] perf test: Use macro for "suite" declarations
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

Currently tests are setup in builtin-test with function pointers. Kunit
exposes tests as a kunit_suite with a null terminated array of test
cases. Use a macro to aid transition from one to the other in later changes.

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
2.33.0.464.g1972c5931b-goog

