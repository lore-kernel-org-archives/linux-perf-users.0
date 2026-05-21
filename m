Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4616C3AEB39
	for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 14:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373167; cv=none; b=URw5vEj2V5Ryrt2NAC6zeGjTomkOp80pMQZ8r/L0eq5Vj3vaopWeCCQB/YubVGqiRxZgTQoFj9QFyICY5sEFp7X4l+ZKTWYJM1S2wwUds8chYhWTeOBVyC3H0YihBZJXON2oUPhpo4jVZy3JgcVDeeq6dQMMPZak8Q1hTzvGHJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373167; c=relaxed/simple;
	bh=A7eEBdnZdPJwm3+eW6mcDxil11etOD4xCI25wUGwWno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rl5c4PhKCo5FDKmujEQzORxxAId63Ku98rw/l9OL47zyudVyWTgqMKccakHczdfZmdUNeQySHEBg/R3Fw7KyO//oBABIa6B5DYu2WNddgNM2l1HUHJGtzIx/r7i8bnN6IatJG1EbPsJvtU/pZsGGWw2sgEcxcW7iZLy33ZBzuTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MrH1vOx+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MrH1vOx+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779373164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gwePtgyHfCYA8SF/W9HMlOSyujDMUDE9mFcE6kUigBE=;
	b=MrH1vOx+Hbjj9A7dw/MkXJxOZDIpss6UJr8avpNQw/CbNg8rBo3vzxNBOVqqwKTdvw+dp3
	OksV/PJODeV3cAB+PTs3NPGfLH7w1ZbR4ZOKLrHXUhX3Hwqf/RuSQTf+jUslnEYdAx7VSH
	22J6HslxcyLtJ+DPujirMZgRvl1GxdA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-NzMkp_tHO4CwzQNCV2aKJQ-1; Thu,
 21 May 2026 10:19:06 -0400
X-MC-Unique: NzMkp_tHO4CwzQNCV2aKJQ-1
X-Mimecast-MFC-AGG-ID: NzMkp_tHO4CwzQNCV2aKJQ_1779373142
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D44F19560B0;
	Thu, 21 May 2026 14:19:02 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.109])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3B8441681;
	Thu, 21 May 2026 14:18:59 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: [PATCH v2 6/6] rtla/tests: Add unit tests for CLI option callbacks
Date: Thu, 21 May 2026 16:18:33 +0200
Message-ID: <20260521141833.2353025-7-tglozar@redhat.com>
In-Reply-To: <20260521141833.2353025-1-tglozar@redhat.com>
References: <20260521141833.2353025-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

In addition to testing all tool_parse_args() functions, test also all
callbacks used for parsing custom option formats.

The callbacks represent a middle layer between the parsing functions
and utility functions dedicated to checking specific argument formats,
for example, scheduling class and duration. Callback tests are run
before parsing functions to make sure any issue in the former is
reported before it is encountered through the latter.

Tests verify both successful parsing and proper rejection of invalid
inputs (via exit tests). To enable testing static callbacks, a pragma
once guard is added to timerlat.h for safe inclusion by cli_p.h.

Add dependency of UNIT_TESTS_IN on LIBSUBCMD_INCLUDES, as the new test
file tests/unit/cli_opt_callback.c includes cli_p.h which includes
subcmd/parse-options.h.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/timerlat.h             |   2 +
 tools/tracing/rtla/tests/unit/Build           |   1 +
 tools/tracing/rtla/tests/unit/Makefile.unit   |   2 +-
 .../rtla/tests/unit/cli_opt_callback.c        | 704 ++++++++++++++++++
 tools/tracing/rtla/tests/unit/unit_tests.c    |   2 +
 5 files changed, 710 insertions(+), 1 deletion(-)
 create mode 100644 tools/tracing/rtla/tests/unit/cli_opt_callback.c

diff --git a/tools/tracing/rtla/src/timerlat.h b/tools/tracing/rtla/src/timerlat.h
index 37a808f1611e..38ab6b41a15e 100644
--- a/tools/tracing/rtla/src/timerlat.h
+++ b/tools/tracing/rtla/src/timerlat.h
@@ -1,4 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
+#pragma once
+
 #include "osnoise.h"
 
 /*
diff --git a/tools/tracing/rtla/tests/unit/Build b/tools/tracing/rtla/tests/unit/Build
index 16139f17ea1f..d5a0f13922be 100644
--- a/tools/tracing/rtla/tests/unit/Build
+++ b/tools/tracing/rtla/tests/unit/Build
@@ -5,3 +5,4 @@ unit_tests-y += osnoise_top_cli.o
 unit_tests-y += osnoise_hist_cli.o
 unit_tests-y += timerlat_top_cli.o
 unit_tests-y += timerlat_hist_cli.o
+unit_tests-y += cli_opt_callback.o
diff --git a/tools/tracing/rtla/tests/unit/Makefile.unit b/tools/tracing/rtla/tests/unit/Makefile.unit
index 8c33a9583c30..839abda64b76 100644
--- a/tools/tracing/rtla/tests/unit/Makefile.unit
+++ b/tools/tracing/rtla/tests/unit/Makefile.unit
@@ -6,7 +6,7 @@ UNIT_TESTS_IN := $(UNIT_TESTS)-in.o
 $(UNIT_TESTS): $(UNIT_TESTS_IN) $(RTLA_IN) $(LIBSUBCMD) $(LIB_STRING) $(LIB_STR_ERROR_R)
 	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $@ $^ $(EXTLIBS) -lcheck
 
-$(UNIT_TESTS_IN): fixdep
+$(UNIT_TESTS_IN): fixdep $(LIBSUBCMD_INCLUDES)
 	make $(build)=unit_tests
 
 unit-tests: FORCE
diff --git a/tools/tracing/rtla/tests/unit/cli_opt_callback.c b/tools/tracing/rtla/tests/unit/cli_opt_callback.c
new file mode 100644
index 000000000000..01647f4227d1
--- /dev/null
+++ b/tools/tracing/rtla/tests/unit/cli_opt_callback.c
@@ -0,0 +1,704 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <check.h>
+
+#define RTLA_ALLOW_CLI_P_H
+#include "../../src/cli_p.h"
+#include "cli_params_assert.h"
+
+#define TEST_CALLBACK(value, cb) OPT_CALLBACK('t', "test", value, "test value", "test help", cb)
+
+START_TEST(test_opt_llong_callback_simple)
+{
+	long long test_value = 0;
+	const struct option opt = TEST_CALLBACK(&test_value, opt_llong_callback);
+
+	ck_assert_int_eq(opt_llong_callback(&opt, "1234567890", 0), 0);
+	ck_assert_int_eq(test_value, 1234567890);
+}
+END_TEST
+
+START_TEST(test_opt_llong_callback_max)
+{
+	long long test_value = 0;
+	const struct option opt = TEST_CALLBACK(&test_value, opt_llong_callback);
+
+	ck_assert_int_eq(opt_llong_callback(&opt, "9223372036854775807", 0), 0);
+	ck_assert_int_eq(test_value, 9223372036854775807LL);
+}
+END_TEST
+
+START_TEST(test_opt_llong_callback_min)
+{
+	long long test_value = 0;
+	const struct option opt = TEST_CALLBACK(&test_value, opt_llong_callback);
+
+	ck_assert_int_eq(opt_llong_callback(&opt, "-9223372036854775808", 0), 0);
+	ck_assert_int_eq(test_value, ~9223372036854775807LL);
+}
+END_TEST
+
+START_TEST(test_opt_int_callback_simple)
+{
+	int test_value = 0;
+	const struct option opt = TEST_CALLBACK(&test_value, opt_int_callback);
+
+	ck_assert_int_eq(opt_int_callback(&opt, "1234567890", 0), 0);
+	ck_assert_int_eq(test_value, 1234567890);
+}
+END_TEST
+
+START_TEST(test_opt_int_callback_max)
+{
+	int test_value = 0;
+	const struct option opt = TEST_CALLBACK(&test_value, opt_int_callback);
+
+	ck_assert_int_eq(opt_int_callback(&opt, "2147483647", 0), 0);
+	ck_assert_int_eq(test_value, 2147483647);
+}
+END_TEST
+
+START_TEST(test_opt_int_callback_min)
+{
+	int test_value = 0;
+	const struct option opt = TEST_CALLBACK(&test_value, opt_int_callback);
+
+	ck_assert_int_eq(opt_int_callback(&opt, "-2147483648", 0), 0);
+	ck_assert_int_eq(test_value, -2147483648);
+}
+END_TEST
+
+START_TEST(test_opt_int_callback_non_numeric)
+{
+	int test_value = 0;
+	const struct option opt = TEST_CALLBACK(&test_value, opt_int_callback);
+
+	ck_assert_int_eq(opt_int_callback(&opt, "abc", 0), -1);
+	ck_assert_int_eq(test_value, 0);
+}
+END_TEST
+
+START_TEST(test_opt_int_callback_non_numeric_suffix)
+{
+	int test_value = 0;
+	const struct option opt = TEST_CALLBACK(&test_value, opt_int_callback);
+
+	ck_assert_int_eq(opt_int_callback(&opt, "1234567890abc", 0), -1);
+	ck_assert_int_eq(test_value, 0);
+}
+END_TEST
+
+START_TEST(test_opt_cpus_cb)
+{
+	struct common_params params = {0};
+	const struct option opt = TEST_CALLBACK(&params, opt_cpus_cb);
+
+	nr_cpus = 4;
+	ck_assert_int_eq(opt_cpus_cb(&opt, "0-3", 0), 0);
+	ck_assert_str_eq(params.cpus, "0-3");
+}
+END_TEST
+
+START_TEST(test_opt_cpus_cb_invalid)
+{
+	struct common_params params = {0};
+	const struct option opt = TEST_CALLBACK(&params, opt_cpus_cb);
+
+	nr_cpus = 4;
+	assert(freopen("/dev/null", "w", stderr));
+	opt_cpus_cb(&opt, "0-3,5", 0);
+}
+END_TEST
+
+START_TEST(test_opt_cgroup_cb)
+{
+	struct common_params params = {0};
+	const struct option opt = TEST_CALLBACK(&params, opt_cgroup_cb);
+
+	ck_assert_int_eq(opt_cgroup_cb(&opt, "cgroup", 0), 0);
+	ck_assert_int_eq(params.cgroup, 1);
+	ck_assert_str_eq(params.cgroup_name, "cgroup");
+}
+END_TEST
+
+START_TEST(test_opt_cgroup_cb_equals)
+{
+	struct common_params params = {0};
+	const struct option opt = TEST_CALLBACK(&params, opt_cgroup_cb);
+
+	ck_assert_int_eq(opt_cgroup_cb(&opt, "=cgroup", 0), 0);
+	ck_assert_int_eq(params.cgroup, 1);
+	ck_assert_str_eq(params.cgroup_name, "cgroup");
+}
+END_TEST
+
+START_TEST(test_opt_duration_cb)
+{
+	struct common_params params = {0};
+	const struct option opt = TEST_CALLBACK(&params, opt_duration_cb);
+
+	ck_assert_int_eq(opt_duration_cb(&opt, "1m", 0), 0);
+	ck_assert_int_eq(params.duration, 60);
+}
+END_TEST
+
+START_TEST(test_opt_duration_cb_invalid)
+{
+	struct common_params params = {0};
+	const struct option opt = TEST_CALLBACK(&params, opt_duration_cb);
+
+	assert(freopen("/dev/null", "w", stderr));
+	opt_duration_cb(&opt, "abc", 0);
+}
+END_TEST
+
+START_TEST(test_opt_event_cb)
+{
+	struct trace_events *events = NULL;
+	const struct option opt = TEST_CALLBACK(&events, opt_event_cb);
+
+	ck_assert_int_eq(opt_event_cb(&opt, "sched:sched_switch", 0), 0);
+	ck_assert_str_eq(events->system, "sched");
+	ck_assert_str_eq(events->event, "sched_switch");
+	ck_assert_ptr_eq(events->next, NULL);
+}
+END_TEST
+
+START_TEST(test_opt_event_cb_multiple)
+{
+	struct trace_events *events = NULL;
+	const struct option opt = TEST_CALLBACK(&events, opt_event_cb);
+
+	ck_assert_int_eq(opt_event_cb(&opt, "sched:sched_switch", 0), 0);
+	ck_assert_int_eq(opt_event_cb(&opt, "sched:sched_wakeup", 0), 0);
+	ck_assert_str_eq(events->system, "sched");
+	ck_assert_str_eq(events->event, "sched_wakeup");
+	ck_assert_str_eq(events->next->system, "sched");
+	ck_assert_str_eq(events->next->event, "sched_switch");
+	ck_assert_ptr_eq(events->next->next, NULL);
+}
+END_TEST
+
+START_TEST(test_opt_housekeeping_cb)
+{
+	struct common_params __params = {0};
+	struct common_params *params = &__params;
+	const struct option opt = TEST_CALLBACK(params, opt_housekeeping_cb);
+
+	nr_cpus = 4;
+	ck_assert_int_eq(opt_housekeeping_cb(&opt, "0-3", 0), 0);
+	ck_assert_int_eq(params->hk_cpus, 1);
+	CLI_ASSERT_CPUSET(hk_cpu_set, 0, 1, 2, 3);
+}
+END_TEST
+
+START_TEST(test_opt_housekeeping_cb_invalid)
+{
+	struct common_params params = {0};
+	const struct option opt = TEST_CALLBACK(&params, opt_housekeeping_cb);
+
+	nr_cpus = 4;
+	assert(freopen("/dev/null", "w", stderr));
+	opt_housekeeping_cb(&opt, "0-3,5", 0);
+}
+END_TEST
+
+START_TEST(test_opt_priority_cb)
+{
+	struct common_params params = {0};
+	const struct option opt = TEST_CALLBACK(&params, opt_priority_cb);
+
+	ck_assert_int_eq(opt_priority_cb(&opt, "f:95", 0), 0);
+	ck_assert_int_eq(params.sched_param.sched_policy, SCHED_FIFO);
+	ck_assert_int_eq(params.sched_param.sched_priority, 95);
+}
+END_TEST
+
+START_TEST(test_opt_priority_cb_invalid)
+{
+	struct common_params params = {0};
+	const struct option opt = TEST_CALLBACK(&params, opt_priority_cb);
+
+	assert(freopen("/dev/null", "w", stderr));
+	opt_priority_cb(&opt, "abc", 0);
+}
+END_TEST
+
+START_TEST(test_opt_trigger_cb)
+{
+	struct trace_events *events = trace_event_alloc("sched:sched_switch");
+	const struct option opt = TEST_CALLBACK(&events, opt_trigger_cb);
+
+	ck_assert_int_eq(opt_trigger_cb(&opt, "stacktrace", 0), 0);
+	ck_assert_str_eq(events->trigger, "stacktrace");
+}
+END_TEST
+
+START_TEST(test_opt_trigger_cb_no_event)
+{
+	struct trace_events *events = NULL;
+	const struct option opt = TEST_CALLBACK(&events, opt_trigger_cb);
+
+	assert(freopen("/dev/null", "w", stderr));
+	opt_trigger_cb(&opt, "stacktrace", 0);
+}
+END_TEST
+
+START_TEST(test_opt_filter_cb)
+{
+	struct trace_events *events = trace_event_alloc("sched:sched_switch");
+	const struct option opt = TEST_CALLBACK(&events, opt_filter_cb);
+
+	ck_assert_int_eq(opt_filter_cb(&opt, "comm ~ \"rtla\"", 0), 0);
+	ck_assert_str_eq(events->filter, "comm ~ \"rtla\"");
+}
+END_TEST
+
+START_TEST(test_opt_filter_cb_no_event)
+{
+	struct trace_events *events = NULL;
+	const struct option opt = TEST_CALLBACK(&events, opt_filter_cb);
+
+	assert(freopen("/dev/null", "w", stderr));
+	opt_filter_cb(&opt, "comm ~ \"rtla\"", 0);
+}
+END_TEST
+
+START_TEST(test_opt_osnoise_auto_cb)
+{
+	struct osnoise_params params = {0};
+	struct osnoise_cb_data cb_data = {&params};
+	const struct option opt = TEST_CALLBACK(&cb_data, opt_osnoise_auto_cb);
+
+	ck_assert_int_eq(opt_osnoise_auto_cb(&opt, "10", 0), 0);
+	ck_assert_int_eq(params.common.stop_us, 10);
+	ck_assert_int_eq(params.threshold, 1);
+	ck_assert_str_eq(cb_data.trace_output, "osnoise_trace.txt");
+}
+END_TEST
+
+START_TEST(test_opt_osnoise_period_cb)
+{
+	unsigned long long period = 0;
+	const struct option opt = TEST_CALLBACK(&period, opt_osnoise_period_cb);
+
+	ck_assert_int_eq(opt_osnoise_period_cb(&opt, "1000000", 0), 0);
+	ck_assert_int_eq(period, 1000000);
+}
+END_TEST
+
+START_TEST(test_opt_osnoise_period_cb_invalid)
+{
+	unsigned long long period = 0;
+	const struct option opt = TEST_CALLBACK(&period, opt_osnoise_period_cb);
+
+	assert(freopen("/dev/null", "w", stderr));
+	opt_osnoise_period_cb(&opt, "10000001", 0);
+}
+END_TEST
+
+START_TEST(test_opt_osnoise_runtime_cb)
+{
+	unsigned long long runtime = 0;
+	const struct option opt = TEST_CALLBACK(&runtime, opt_osnoise_runtime_cb);
+
+	ck_assert_int_eq(opt_osnoise_runtime_cb(&opt, "900000", 0), 0);
+	ck_assert_int_eq(runtime, 900000);
+}
+END_TEST
+
+START_TEST(test_opt_osnoise_runtime_cb_invalid)
+{
+	unsigned long long runtime = 0;
+	const struct option opt = TEST_CALLBACK(&runtime, opt_osnoise_runtime_cb);
+
+	assert(freopen("/dev/null", "w", stderr));
+	opt_osnoise_runtime_cb(&opt, "99", 0);
+}
+END_TEST
+
+START_TEST(test_opt_osnoise_trace_output_cb)
+{
+	const char *trace_output = NULL;
+	const struct option opt = TEST_CALLBACK(&trace_output, opt_osnoise_trace_output_cb);
+
+	ck_assert_int_eq(opt_osnoise_trace_output_cb(&opt, "trace.txt", 0), 0);
+	ck_assert_str_eq(trace_output, "trace.txt");
+}
+END_TEST
+
+START_TEST(test_opt_osnoise_trace_output_cb_noarg)
+{
+	const char *trace_output = NULL;
+	const struct option opt = TEST_CALLBACK(&trace_output, opt_osnoise_trace_output_cb);
+
+	ck_assert_int_eq(opt_osnoise_trace_output_cb(&opt, NULL, 0), 0);
+	ck_assert_str_eq(trace_output, "osnoise_trace.txt");
+}
+END_TEST
+
+START_TEST(test_opt_osnoise_on_threshold_cb)
+{
+	struct actions actions = {0};
+	const struct option opt = TEST_CALLBACK(&actions, opt_osnoise_on_threshold_cb);
+
+	ck_assert_int_eq(opt_osnoise_on_threshold_cb(&opt, "trace", 0), 0);
+	ck_assert_int_eq(actions.len, 1);
+	ck_assert_int_eq(actions.list[0].type, ACTION_TRACE_OUTPUT);
+	ck_assert_str_eq(actions.list[0].trace_output, "osnoise_trace.txt");
+}
+END_TEST
+
+START_TEST(test_opt_osnoise_on_threshold_cb_invalid)
+{
+	struct actions actions = {0};
+	const struct option opt = TEST_CALLBACK(&actions, opt_osnoise_on_threshold_cb);
+
+	assert(freopen("/dev/null", "w", stderr));
+	opt_osnoise_on_threshold_cb(&opt, "abc", 0);
+}
+END_TEST
+
+START_TEST(test_opt_osnoise_on_end_cb)
+{
+	struct actions actions = {0};
+	const struct option opt = TEST_CALLBACK(&actions, opt_osnoise_on_end_cb);
+
+	ck_assert_int_eq(opt_osnoise_on_end_cb(&opt, "trace", 0), 0);
+	ck_assert_int_eq(actions.len, 1);
+	ck_assert_int_eq(actions.list[0].type, ACTION_TRACE_OUTPUT);
+	ck_assert_str_eq(actions.list[0].trace_output, "osnoise_trace.txt");
+}
+END_TEST
+
+START_TEST(test_opt_osnoise_on_end_cb_invalid)
+{
+	struct actions actions = {0};
+	const struct option opt = TEST_CALLBACK(&actions, opt_osnoise_on_end_cb);
+
+	assert(freopen("/dev/null", "w", stderr));
+	opt_osnoise_on_end_cb(&opt, "abc", 0);
+}
+END_TEST
+
+START_TEST(test_opt_timerlat_period_cb)
+{
+	long long period = 0;
+	const struct option opt = TEST_CALLBACK(&period, opt_timerlat_period_cb);
+
+	ck_assert_int_eq(opt_timerlat_period_cb(&opt, "1000", 0), 0);
+	ck_assert_int_eq(period, 1000);
+}
+END_TEST
+
+START_TEST(test_opt_timerlat_period_cb_invalid)
+{
+	long long period = 0;
+	const struct option opt = TEST_CALLBACK(&period, opt_timerlat_period_cb);
+
+	assert(freopen("/dev/null", "w", stderr));
+	opt_timerlat_period_cb(&opt, "1000001", 0);
+}
+END_TEST
+
+START_TEST(test_opt_timerlat_auto_cb)
+{
+	struct timerlat_params params = {0};
+	struct timerlat_cb_data cb_data = {&params};
+	const struct option opt = TEST_CALLBACK(&cb_data, opt_timerlat_auto_cb);
+
+	ck_assert_int_eq(opt_timerlat_auto_cb(&opt, "10", 0), 0);
+	ck_assert_int_eq(params.common.stop_us, 10);
+	ck_assert_int_eq(params.common.stop_total_us, 10);
+	ck_assert_int_eq(params.print_stack, 10);
+	ck_assert_str_eq(cb_data.trace_output, "timerlat_trace.txt");
+}
+END_TEST
+
+START_TEST(test_opt_dma_latency_cb)
+{
+	int dma_latency = 0;
+	const struct option opt = TEST_CALLBACK(&dma_latency, opt_dma_latency_cb);
+
+	ck_assert_int_eq(opt_dma_latency_cb(&opt, "1000", 0), 0);
+	ck_assert_int_eq(dma_latency, 1000);
+}
+END_TEST
+
+START_TEST(test_opt_dma_latency_cb_min)
+{
+	int dma_latency = 0;
+	const struct option opt = TEST_CALLBACK(&dma_latency, opt_dma_latency_cb);
+
+	assert(freopen("/dev/null", "w", stderr));
+	opt_dma_latency_cb(&opt, "-1", 0);
+}
+END_TEST
+
+START_TEST(test_opt_dma_latency_cb_max)
+{
+	int dma_latency = 0;
+	const struct option opt = TEST_CALLBACK(&dma_latency, opt_dma_latency_cb);
+
+	assert(freopen("/dev/null", "w", stderr));
+	opt_dma_latency_cb(&opt, "10001", 0);
+}
+END_TEST
+
+START_TEST(test_opt_aa_only_cb)
+{
+	struct timerlat_params params = {0};
+	const struct option opt = TEST_CALLBACK(&params, opt_aa_only_cb);
+
+	ck_assert_int_eq(opt_aa_only_cb(&opt, "10", 0), 0);
+	ck_assert_int_eq(params.common.stop_us, 10);
+	ck_assert_int_eq(params.common.stop_total_us, 10);
+	ck_assert_int_eq(params.print_stack, 10);
+	ck_assert_int_eq(params.common.aa_only, 1);
+}
+END_TEST
+
+START_TEST(test_opt_timerlat_trace_output_cb)
+{
+	const char *trace_output = NULL;
+	const struct option opt = TEST_CALLBACK(&trace_output, opt_timerlat_trace_output_cb);
+
+	ck_assert_int_eq(opt_timerlat_trace_output_cb(&opt, "trace.txt", 0), 0);
+	ck_assert_str_eq(trace_output, "trace.txt");
+}
+END_TEST
+
+START_TEST(test_opt_timerlat_trace_output_cb_noarg)
+{
+	const char *trace_output = NULL;
+	const struct option opt = TEST_CALLBACK(&trace_output, opt_timerlat_trace_output_cb);
+
+	ck_assert_int_eq(opt_timerlat_trace_output_cb(&opt, NULL, 0), 0);
+	ck_assert_str_eq(trace_output, "timerlat_trace.txt");
+}
+END_TEST
+
+START_TEST(test_opt_timerlat_on_threshold_cb)
+{
+	struct actions actions = {0};
+	const struct option opt = TEST_CALLBACK(&actions, opt_timerlat_on_threshold_cb);
+
+	ck_assert_int_eq(opt_timerlat_on_threshold_cb(&opt, "trace", 0), 0);
+	ck_assert_int_eq(actions.len, 1);
+	ck_assert_int_eq(actions.list[0].type, ACTION_TRACE_OUTPUT);
+	ck_assert_str_eq(actions.list[0].trace_output, "timerlat_trace.txt");
+}
+END_TEST
+
+START_TEST(test_opt_timerlat_on_threshold_cb_invalid)
+{
+	struct actions actions = {0};
+	const struct option opt = TEST_CALLBACK(&actions, opt_timerlat_on_threshold_cb);
+
+	assert(freopen("/dev/null", "w", stderr));
+	opt_timerlat_on_threshold_cb(&opt, "abc", 0);
+}
+END_TEST
+
+START_TEST(test_opt_timerlat_on_end_cb)
+{
+	struct actions actions = {0};
+	const struct option opt = TEST_CALLBACK(&actions, opt_timerlat_on_end_cb);
+
+	ck_assert_int_eq(opt_timerlat_on_end_cb(&opt, "trace", 0), 0);
+	ck_assert_int_eq(actions.len, 1);
+	ck_assert_int_eq(actions.list[0].type, ACTION_TRACE_OUTPUT);
+	ck_assert_str_eq(actions.list[0].trace_output, "timerlat_trace.txt");
+}
+END_TEST
+
+START_TEST(test_opt_timerlat_on_end_cb_invalid)
+{
+	struct actions actions = {0};
+	const struct option opt = TEST_CALLBACK(&actions, opt_timerlat_on_end_cb);
+
+	assert(freopen("/dev/null", "w", stderr));
+	opt_timerlat_on_end_cb(&opt, "abc", 0);
+}
+END_TEST
+
+START_TEST(test_opt_user_threads_cb)
+{
+	struct timerlat_params params = {0};
+	const struct option opt = TEST_CALLBACK(&params, opt_user_threads_cb);
+
+	ck_assert_int_eq(opt_user_threads_cb(&opt, NULL, 0), 0);
+	ck_assert_int_eq(params.common.user_workload, 1);
+	ck_assert_int_eq(params.common.user_data, 1);
+}
+END_TEST
+
+START_TEST(test_opt_nano_cb)
+{
+	struct timerlat_params params = {0};
+	const struct option opt = TEST_CALLBACK(&params, opt_nano_cb);
+
+	ck_assert_int_eq(opt_nano_cb(&opt, NULL, 0), 0);
+	ck_assert_int_eq(params.common.output_divisor, 1);
+}
+END_TEST
+
+START_TEST(test_opt_stack_format_cb)
+{
+	int stack_format = 0;
+	const struct option opt = TEST_CALLBACK(&stack_format, opt_stack_format_cb);
+
+	ck_assert_int_eq(opt_stack_format_cb(&opt, "full", 0), 0);
+	ck_assert_int_eq(stack_format, STACK_FORMAT_FULL);
+}
+END_TEST
+
+START_TEST(test_opt_stack_format_cb_invalid)
+{
+	int stack_format = 0;
+	const struct option opt = TEST_CALLBACK(&stack_format, opt_stack_format_cb);
+
+	assert(freopen("/dev/null", "w", stderr));
+	opt_stack_format_cb(&opt, "abc", 0);
+}
+END_TEST
+
+START_TEST(test_opt_bucket_size_cb)
+{
+	int bucket_size = 0;
+	const struct option opt = TEST_CALLBACK(&bucket_size, opt_bucket_size_cb);
+
+	ck_assert_int_eq(opt_bucket_size_cb(&opt, "100", 0), 0);
+	ck_assert_int_eq(bucket_size, 100);
+}
+END_TEST
+
+START_TEST(test_opt_bucket_size_min)
+{
+	int bucket_size = 0;
+	const struct option opt = TEST_CALLBACK(&bucket_size, opt_bucket_size_cb);
+
+	assert(freopen("/dev/null", "w", stderr));
+	opt_bucket_size_cb(&opt, "0", 0);
+}
+END_TEST
+
+START_TEST(test_opt_bucket_size_max)
+{
+	int bucket_size = 0;
+	const struct option opt = TEST_CALLBACK(&bucket_size, opt_bucket_size_cb);
+
+	assert(freopen("/dev/null", "w", stderr));
+	opt_bucket_size_cb(&opt, "1000001", 0);
+}
+END_TEST
+
+START_TEST(test_opt_entries_cb)
+{
+	int entries = 0;
+	const struct option opt = TEST_CALLBACK(&entries, opt_entries_cb);
+
+	ck_assert_int_eq(opt_entries_cb(&opt, "100", 0), 0);
+	ck_assert_int_eq(entries, 100);
+}
+END_TEST
+
+START_TEST(test_opt_entries_min)
+{
+	int entries = 0;
+	const struct option opt = TEST_CALLBACK(&entries, opt_entries_cb);
+
+	assert(freopen("/dev/null", "w", stderr));
+	opt_entries_cb(&opt, "9", 0);
+}
+END_TEST
+
+START_TEST(test_opt_entries_max)
+{
+	int entries = 0;
+	const struct option opt = TEST_CALLBACK(&entries, opt_entries_cb);
+
+	assert(freopen("/dev/null", "w", stderr));
+	opt_entries_cb(&opt, "10000000", 0);
+}
+END_TEST
+
+Suite *cli_opt_callback_suite(void)
+{
+	Suite *s = suite_create("cli_opt_callback");
+	TCase *tc;
+
+	tc = tcase_create("common");
+	tcase_add_test(tc, test_opt_llong_callback_simple);
+	tcase_add_test(tc, test_opt_llong_callback_max);
+	tcase_add_test(tc, test_opt_llong_callback_min);
+	tcase_add_test(tc, test_opt_int_callback_simple);
+	tcase_add_test(tc, test_opt_int_callback_max);
+	tcase_add_test(tc, test_opt_int_callback_min);
+	tcase_add_test(tc, test_opt_int_callback_non_numeric);
+	tcase_add_test(tc, test_opt_int_callback_non_numeric_suffix);
+	tcase_add_test(tc, test_opt_cpus_cb);
+	tcase_add_exit_test(tc, test_opt_cpus_cb_invalid, EXIT_FAILURE);
+	tcase_add_test(tc, test_opt_cgroup_cb);
+	tcase_add_test(tc, test_opt_cgroup_cb_equals);
+	tcase_add_test(tc, test_opt_duration_cb);
+	tcase_add_exit_test(tc, test_opt_duration_cb_invalid, EXIT_FAILURE);
+	tcase_add_test(tc, test_opt_event_cb);
+	tcase_add_test(tc, test_opt_event_cb_multiple);
+	tcase_add_test(tc, test_opt_housekeeping_cb);
+	tcase_add_exit_test(tc, test_opt_housekeeping_cb_invalid, EXIT_FAILURE);
+	tcase_add_test(tc, test_opt_priority_cb);
+	tcase_add_exit_test(tc, test_opt_priority_cb_invalid, EXIT_FAILURE);
+	tcase_add_test(tc, test_opt_trigger_cb);
+	tcase_add_exit_test(tc, test_opt_trigger_cb_no_event, EXIT_FAILURE);
+	tcase_add_test(tc, test_opt_filter_cb);
+	tcase_add_exit_test(tc, test_opt_filter_cb_no_event, EXIT_FAILURE);
+	suite_add_tcase(s, tc);
+
+	tc = tcase_create("osnoise");
+	tcase_add_test(tc, test_opt_osnoise_auto_cb);
+	tcase_add_test(tc, test_opt_osnoise_period_cb);
+	tcase_add_exit_test(tc, test_opt_osnoise_period_cb_invalid, EXIT_FAILURE);
+	tcase_add_test(tc, test_opt_osnoise_runtime_cb);
+	tcase_add_exit_test(tc, test_opt_osnoise_runtime_cb_invalid, EXIT_FAILURE);
+	tcase_add_test(tc, test_opt_osnoise_trace_output_cb);
+	tcase_add_test(tc, test_opt_osnoise_trace_output_cb_noarg);
+	tcase_add_test(tc, test_opt_osnoise_on_threshold_cb);
+	tcase_add_exit_test(tc, test_opt_osnoise_on_threshold_cb_invalid, EXIT_FAILURE);
+	tcase_add_test(tc, test_opt_osnoise_on_end_cb);
+	tcase_add_exit_test(tc, test_opt_osnoise_on_end_cb_invalid, EXIT_FAILURE);
+	suite_add_tcase(s, tc);
+
+	tc = tcase_create("timerlat");
+	tcase_add_test(tc, test_opt_timerlat_period_cb);
+	tcase_add_exit_test(tc, test_opt_timerlat_period_cb_invalid, EXIT_FAILURE);
+	tcase_add_test(tc, test_opt_timerlat_auto_cb);
+	tcase_add_test(tc, test_opt_dma_latency_cb);
+	tcase_add_exit_test(tc, test_opt_dma_latency_cb_min, EXIT_FAILURE);
+	tcase_add_exit_test(tc, test_opt_dma_latency_cb_max, EXIT_FAILURE);
+	tcase_add_test(tc, test_opt_aa_only_cb);
+	tcase_add_test(tc, test_opt_timerlat_trace_output_cb);
+	tcase_add_test(tc, test_opt_timerlat_trace_output_cb_noarg);
+	tcase_add_test(tc, test_opt_timerlat_on_threshold_cb);
+	tcase_add_exit_test(tc, test_opt_timerlat_on_threshold_cb_invalid, EXIT_FAILURE);
+	tcase_add_test(tc, test_opt_timerlat_on_end_cb);
+	tcase_add_exit_test(tc, test_opt_timerlat_on_end_cb_invalid, EXIT_FAILURE);
+	tcase_add_test(tc, test_opt_user_threads_cb);
+	tcase_add_test(tc, test_opt_nano_cb);
+	tcase_add_test(tc, test_opt_stack_format_cb);
+	tcase_add_exit_test(tc, test_opt_stack_format_cb_invalid, EXIT_FAILURE);
+	suite_add_tcase(s, tc);
+
+	tc = tcase_create("histogram");
+	tcase_add_test(tc, test_opt_bucket_size_cb);
+	tcase_add_exit_test(tc, test_opt_bucket_size_min, EXIT_FAILURE);
+	tcase_add_exit_test(tc, test_opt_bucket_size_max, EXIT_FAILURE);
+	tcase_add_test(tc, test_opt_entries_cb);
+	tcase_add_exit_test(tc, test_opt_entries_min, EXIT_FAILURE);
+	tcase_add_exit_test(tc, test_opt_entries_max, EXIT_FAILURE);
+	suite_add_tcase(s, tc);
+
+	return s;
+}
diff --git a/tools/tracing/rtla/tests/unit/unit_tests.c b/tools/tracing/rtla/tests/unit/unit_tests.c
index 64884f6cbdeb..75ca813f81ca 100644
--- a/tools/tracing/rtla/tests/unit/unit_tests.c
+++ b/tools/tracing/rtla/tests/unit/unit_tests.c
@@ -13,6 +13,7 @@ Suite *osnoise_top_cli_suite(void);
 Suite *osnoise_hist_cli_suite(void);
 Suite *timerlat_top_cli_suite(void);
 Suite *timerlat_hist_cli_suite(void);
+Suite *cli_opt_callback_suite(void);
 
 int main(int argc, char *argv[])
 {
@@ -22,6 +23,7 @@ int main(int argc, char *argv[])
 	in_unit_test = true;
 
 	sr = srunner_create(utils_suite());
+	srunner_add_suite(sr, cli_opt_callback_suite());
 	srunner_add_suite(sr, actions_suite());
 	srunner_add_suite(sr, osnoise_top_cli_suite());
 	srunner_add_suite(sr, osnoise_hist_cli_suite());
-- 
2.54.0

