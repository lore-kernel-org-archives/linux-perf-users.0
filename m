Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8F53B9D9A
	for <linux-perf-users@vger.kernel.org>; Thu, 28 May 2026 10:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779964426; cv=none; b=cHEMOprsbnY2RLq48HMB81GvR1eWPIMzQnDwga3Oi+dTcx3Dkb9+eBL5e5pqEH7BPJ+W/qZ1JkN7frPMUkd8xa/2q8JHjNan08mf+bZqOjC1KqXfYhnhRk9HC4TxrGelqUc1FZv+YdIKCVAcyOp2o7O8lDp93ks3XvwjQQsAfW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779964426; c=relaxed/simple;
	bh=Jvya3ZuBR7T7+GLQKjRyyv37cDSNBtI0Ejw1tNuKJCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ndsBKbvNOCG0iNh27rRkNlf9pcpp2VejnoyKvlWX5afmhvjLPfqnz60b7AiBdulZAu4ibQUh2hihU8CxmmClX20UMvCSUSVAisKBzu0I5VVyxXYlQvz5ppQoMGkuPBlNTCnNYugwTaEeY3iRaVU5K7b1rRaB0uM8hijRfw5rXug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E7xvGV45; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E7xvGV45"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779964421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q0q5TN8aNLEUi6dYvfKTD8Pb49y0VBIbW3CT2wMjCCU=;
	b=E7xvGV45UbAFYn/et6YtGChyCL8HtKQpnE7zSrpeqNL5ybIpBocyEdWvMWUthmaXSkgWRi
	RZS0fWIvWtE+R4KOZ4+T6pd3t2VA9CF6iQN+h5YYaRYpQa512iCGNTOuW6YGYT/5k/vvx9
	2DsX1pj+0AbJjU0TMHL2YUcVPz5Er0c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-SQbgxGs8NQmK9161mXXX3g-1; Thu,
 28 May 2026 06:33:37 -0400
X-MC-Unique: SQbgxGs8NQmK9161mXXX3g-1
X-Mimecast-MFC-AGG-ID: SQbgxGs8NQmK9161mXXX3g_1779964416
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 626F018005BE;
	Thu, 28 May 2026 10:33:36 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.109])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 99E871686;
	Thu, 28 May 2026 10:33:32 +0000 (UTC)
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
Subject: [PATCH v3 5/6] rtla/tests: Add unit tests for _parse_args() functions
Date: Thu, 28 May 2026 12:32:53 +0200
Message-ID: <20260528103254.2990068-6-tglozar@redhat.com>
In-Reply-To: <20260528103254.2990068-1-tglozar@redhat.com>
References: <20260528103254.2990068-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Add a test suite for the _parse_args() function of each tool that checks
the params structures (struct common_params, struct osnoise_params,
struct timerlat_params) returned by them for correctness.

One test case is added per option, as well as a few special cases for
tricky combinations of options. Test cases are ordered the same as the
option arrays and help message to allow easy checking of whether all
options are covered.

This should help clarify what the proper command line behavior of RTLA
is in case there are holes in the documentation and verify that the
intended behavior is implemented correctly.

A few necessary changes to the unit tests were done as part of this
commit:

- Unit tests now also link to libsubcmd and its dependencies.
- A new global variable in_unit_test is added to RTLA's CLI interface,
  causing it to skip check for root if running in unit tests. This
  allows the CLI unit tests to run as non-root, like existing unit
  tests.

There is quite a lot of duplication, some of it is mitigated with macros,
but partially it is intentional so that future changes in behavior are
tracked across tools.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/cli.c                  |   8 +-
 tools/tracing/rtla/src/cli.h                  |   2 +
 tools/tracing/rtla/tests/unit/Build           |   4 +
 tools/tracing/rtla/tests/unit/Makefile.unit   |   2 +-
 .../rtla/tests/unit/cli_params_assert.h       |  68 ++
 .../rtla/tests/unit/osnoise_hist_cli.c        | 557 ++++++++++++++
 .../tracing/rtla/tests/unit/osnoise_top_cli.c | 503 +++++++++++++
 .../rtla/tests/unit/timerlat_hist_cli.c       | 702 ++++++++++++++++++
 .../rtla/tests/unit/timerlat_top_cli.c        | 634 ++++++++++++++++
 tools/tracing/rtla/tests/unit/unit_tests.c    |  11 +
 10 files changed, 2486 insertions(+), 5 deletions(-)
 create mode 100644 tools/tracing/rtla/tests/unit/cli_params_assert.h
 create mode 100644 tools/tracing/rtla/tests/unit/osnoise_hist_cli.c
 create mode 100644 tools/tracing/rtla/tests/unit/osnoise_top_cli.c
 create mode 100644 tools/tracing/rtla/tests/unit/timerlat_hist_cli.c
 create mode 100644 tools/tracing/rtla/tests/unit/timerlat_top_cli.c

diff --git a/tools/tracing/rtla/src/cli.c b/tools/tracing/rtla/src/cli.c
index 7f531519df44..709219341a56 100644
--- a/tools/tracing/rtla/src/cli.c
+++ b/tools/tracing/rtla/src/cli.c
@@ -124,7 +124,7 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 	if (cb_data.trace_output)
 		actions_add_trace_output(&params->common.threshold_actions, cb_data.trace_output);
 
-	if (geteuid())
+	if (geteuid() && !in_unit_test)
 		fatal("osnoise needs root permission");
 
 	return &params->common;
@@ -206,7 +206,7 @@ struct common_params *osnoise_hist_parse_args(int argc, char **argv)
 	if (cb_data.trace_output)
 		actions_add_trace_output(&params->common.threshold_actions, cb_data.trace_output);
 
-	if (geteuid())
+	if (geteuid() && !in_unit_test)
 		fatal("rtla needs root permission");
 
 	if (params->common.hist.no_index && !params->common.hist.with_zeros)
@@ -301,7 +301,7 @@ struct common_params *timerlat_top_parse_args(int argc, char **argv)
 	if (cb_data.trace_output)
 		actions_add_trace_output(&params->common.threshold_actions, cb_data.trace_output);
 
-	if (geteuid())
+	if (geteuid() && !in_unit_test)
 		fatal("rtla needs root permission");
 
 	/*
@@ -427,7 +427,7 @@ struct common_params *timerlat_hist_parse_args(int argc, char **argv)
 	if (cb_data.trace_output)
 		actions_add_trace_output(&params->common.threshold_actions, cb_data.trace_output);
 
-	if (geteuid())
+	if (geteuid() && !in_unit_test)
 		fatal("rtla needs root permission");
 
 	if (params->common.hist.no_irq && params->common.hist.no_thread)
diff --git a/tools/tracing/rtla/src/cli.h b/tools/tracing/rtla/src/cli.h
index c49ccb3e92f5..633a2322cf89 100644
--- a/tools/tracing/rtla/src/cli.h
+++ b/tools/tracing/rtla/src/cli.h
@@ -5,3 +5,5 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv);
 struct common_params *osnoise_hist_parse_args(int argc, char **argv);
 struct common_params *timerlat_top_parse_args(int argc, char **argv);
 struct common_params *timerlat_hist_parse_args(int argc, char **argv);
+
+extern bool in_unit_test;
diff --git a/tools/tracing/rtla/tests/unit/Build b/tools/tracing/rtla/tests/unit/Build
index 2749f4cf202a..16139f17ea1f 100644
--- a/tools/tracing/rtla/tests/unit/Build
+++ b/tools/tracing/rtla/tests/unit/Build
@@ -1,3 +1,7 @@
 unit_tests-y += utils.o
 unit_tests-y += actions.o
 unit_tests-y += unit_tests.o
+unit_tests-y += osnoise_top_cli.o
+unit_tests-y += osnoise_hist_cli.o
+unit_tests-y += timerlat_top_cli.o
+unit_tests-y += timerlat_hist_cli.o
diff --git a/tools/tracing/rtla/tests/unit/Makefile.unit b/tools/tracing/rtla/tests/unit/Makefile.unit
index bacb00164e46..8c33a9583c30 100644
--- a/tools/tracing/rtla/tests/unit/Makefile.unit
+++ b/tools/tracing/rtla/tests/unit/Makefile.unit
@@ -3,7 +3,7 @@
 UNIT_TESTS := $(OUTPUT)unit_tests
 UNIT_TESTS_IN := $(UNIT_TESTS)-in.o
 
-$(UNIT_TESTS): $(UNIT_TESTS_IN) $(RTLA_IN)
+$(UNIT_TESTS): $(UNIT_TESTS_IN) $(RTLA_IN) $(LIBSUBCMD) $(LIB_STRING) $(LIB_STR_ERROR_R)
 	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $@ $^ $(EXTLIBS) -lcheck
 
 $(UNIT_TESTS_IN): fixdep
diff --git a/tools/tracing/rtla/tests/unit/cli_params_assert.h b/tools/tracing/rtla/tests/unit/cli_params_assert.h
new file mode 100644
index 000000000000..4bc7d582fcf4
--- /dev/null
+++ b/tools/tracing/rtla/tests/unit/cli_params_assert.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#pragma once
+
+#include "../../src/timerlat.h"
+
+/* Tracing Options */
+
+#define CLI_ASSERT_SINGLE_EVENT(_system, _event) do {\
+	ck_assert_ptr_nonnull(params->events);\
+	ck_assert_str_eq(params->events->system, _system);\
+	ck_assert_str_eq(params->events->event, _event);\
+	ck_assert_ptr_null(params->events->next);\
+} while (0)
+
+#define CLI_ASSERT_SINGLE_FILTER(_filter) do {\
+	ck_assert_ptr_nonnull(params->events);\
+	ck_assert_str_eq(params->events->filter, _filter);\
+	ck_assert_ptr_null(params->events->next);\
+} while (0)
+
+#define CLI_ASSERT_SINGLE_TRIGGER(_trigger) do {\
+	ck_assert_ptr_nonnull(params->events);\
+	ck_assert_str_eq(params->events->trigger, _trigger);\
+	ck_assert_ptr_null(params->events->next);\
+} while (0)
+
+/* CPU Configuration */
+
+#define CLI_ASSERT_CPUSET(_field, ...) do {\
+	int n;\
+	int cpus[] = { __VA_ARGS__ };\
+	for (n = 0; n < sizeof(cpus) / sizeof(int); n++)\
+		ck_assert(CPU_ISSET(cpus[n], &params->_field));\
+	ck_assert_int_eq(CPU_COUNT(&params->_field), n);\
+} while (0)
+
+/* Auto Analysis and Actions */
+
+#define CLI_OSNOISE_ASSERT_AUTO(_stop) do {\
+	ck_assert_int_eq(params->stop_us, _stop);\
+	ck_assert_int_eq(osn_params->threshold, 1);\
+	ck_assert_int_eq(params->threshold_actions.len, 1);\
+	ck_assert_int_eq(params->threshold_actions.list[0].type, ACTION_TRACE_OUTPUT);\
+	ck_assert_str_eq(params->threshold_actions.list[0].trace_output, "osnoise_trace.txt");\
+} while (0)
+
+#define CLI_TIMERLAT_ASSERT_AUTO(_threshold) do {\
+	ck_assert_int_eq(params->stop_us, _threshold);\
+	ck_assert_int_eq(params->stop_total_us, _threshold);\
+	ck_assert_int_eq(tlat_params->print_stack, _threshold);\
+	ck_assert_int_eq(params->threshold_actions.len, 1);\
+	ck_assert_int_eq(params->threshold_actions.list[0].type, ACTION_TRACE_OUTPUT);\
+	ck_assert_str_eq(params->threshold_actions.list[0].trace_output, "timerlat_trace.txt");\
+} while (0)
+
+#define CLI_TIMERLAT_ASSERT_AA_ONLY(_threshold) do {\
+	ck_assert_int_eq(params->stop_us, _threshold);\
+	ck_assert_int_eq(params->stop_total_us, _threshold);\
+	ck_assert_int_eq(tlat_params->print_stack, _threshold);\
+	ck_assert_int_eq(params->threshold_actions.len, 0);\
+	ck_assert(params->aa_only);\
+} while (0)
+
+#define CLI_ASSERT_SINGLE_ACTION(_actions, _type, _arg, _valtype, _value) do {\
+	ck_assert_int_eq(params->_actions.len, 1);\
+	ck_assert_int_eq(params->_actions.list[0].type, _type);\
+	ck_assert_##_valtype##_eq(params->_actions.list[0]._arg, _value);\
+} while (0)
diff --git a/tools/tracing/rtla/tests/unit/osnoise_hist_cli.c b/tools/tracing/rtla/tests/unit/osnoise_hist_cli.c
new file mode 100644
index 000000000000..3661529f93dc
--- /dev/null
+++ b/tools/tracing/rtla/tests/unit/osnoise_hist_cli.c
@@ -0,0 +1,557 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <check.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sched.h>
+#include <limits.h>
+#include <unistd.h>
+#include <sys/sysinfo.h>
+
+#include "cli_params_assert.h"
+#include "../../src/cli.h"
+
+#define PARSE_ARGS(...) char *argv[] = { __VA_ARGS__, NULL  };\
+			int argc = sizeof(argv) / sizeof(char *) - 1;\
+			struct common_params *params =\
+				osnoise_hist_parse_args(argc, argv);\
+			struct osnoise_params *osn_params __maybe_unused =\
+				to_osnoise_params(params)
+
+/* Tracing Options */
+
+START_TEST(test_period_short)
+{
+	PARSE_ARGS("osnoise", "hist", "-p", "100000");
+
+	ck_assert_int_eq(osn_params->period, 100000);
+}
+END_TEST
+
+START_TEST(test_period_long)
+{
+	PARSE_ARGS("osnoise", "hist", "--period", "100000");
+
+	ck_assert_int_eq(osn_params->period, 100000);
+}
+END_TEST
+
+START_TEST(test_runtime_short)
+{
+	PARSE_ARGS("osnoise", "hist", "-r", "95000");
+
+	ck_assert_int_eq(osn_params->runtime, 95000);
+}
+END_TEST
+
+START_TEST(test_runtime_long)
+{
+	PARSE_ARGS("osnoise", "hist", "--runtime", "95000");
+
+	ck_assert_int_eq(osn_params->runtime, 95000);
+}
+END_TEST
+
+START_TEST(test_stop_short)
+{
+	PARSE_ARGS("osnoise", "hist", "-s", "20");
+
+	ck_assert_int_eq(params->stop_us, 20);
+}
+END_TEST
+
+START_TEST(test_stop_long)
+{
+	PARSE_ARGS("osnoise", "hist", "--stop", "20");
+
+	ck_assert_int_eq(params->stop_us, 20);
+}
+END_TEST
+
+START_TEST(test_stop_total_short)
+{
+	PARSE_ARGS("osnoise", "hist", "-S", "20");
+
+	ck_assert_int_eq(params->stop_total_us, 20);
+}
+END_TEST
+
+START_TEST(test_stop_total_long)
+{
+	PARSE_ARGS("osnoise", "hist", "--stop-total", "20");
+
+	ck_assert_int_eq(params->stop_total_us, 20);
+}
+END_TEST
+
+START_TEST(test_threshold_short)
+{
+	PARSE_ARGS("osnoise", "hist", "-T", "5");
+
+	ck_assert_int_eq(osn_params->threshold, 5);
+}
+END_TEST
+
+START_TEST(test_threshold_long)
+{
+	PARSE_ARGS("osnoise", "hist", "--threshold", "5");
+
+	ck_assert_int_eq(osn_params->threshold, 5);
+}
+END_TEST
+
+START_TEST(test_trace_short_noarg)
+{
+	PARSE_ARGS("osnoise", "hist", "-t");
+
+	CLI_ASSERT_SINGLE_ACTION(threshold_actions, ACTION_TRACE_OUTPUT, trace_output, str,
+				 "osnoise_trace.txt");
+}
+END_TEST
+
+START_TEST(test_trace_short_followarg)
+{
+	PARSE_ARGS("osnoise", "hist", "-t", "-d", "20");
+
+	CLI_ASSERT_SINGLE_ACTION(threshold_actions, ACTION_TRACE_OUTPUT, trace_output, str,
+				 "osnoise_trace.txt");
+	ck_assert_int_eq(params->duration, 20); /* check if next argument is read correctly */
+}
+END_TEST
+
+START_TEST(test_trace_short_space)
+{
+	PARSE_ARGS("osnoise", "hist", "-t", "tracefile");
+
+	CLI_ASSERT_SINGLE_ACTION(threshold_actions, ACTION_TRACE_OUTPUT, trace_output, str,
+				 "tracefile");
+}
+END_TEST
+
+START_TEST(test_trace_short_equals)
+{
+	PARSE_ARGS("osnoise", "hist", "-t=tracefile");
+
+	CLI_ASSERT_SINGLE_ACTION(threshold_actions, ACTION_TRACE_OUTPUT, trace_output, str,
+				 "tracefile");
+}
+END_TEST
+
+START_TEST(test_trace_long_noarg)
+{
+	PARSE_ARGS("osnoise", "hist", "--trace");
+
+	CLI_ASSERT_SINGLE_ACTION(threshold_actions, ACTION_TRACE_OUTPUT, trace_output, str,
+				 "osnoise_trace.txt");
+}
+END_TEST
+
+START_TEST(test_trace_long_followarg)
+{
+	PARSE_ARGS("osnoise", "hist", "--trace", "-d", "20");
+
+	CLI_ASSERT_SINGLE_ACTION(threshold_actions, ACTION_TRACE_OUTPUT, trace_output, str,
+				 "osnoise_trace.txt");
+	ck_assert_int_eq(params->duration, 20); /* check if next argument is read correctly */
+}
+END_TEST
+
+START_TEST(test_trace_long_space)
+{
+	PARSE_ARGS("osnoise", "hist", "--trace", "tracefile");
+
+	CLI_ASSERT_SINGLE_ACTION(threshold_actions, ACTION_TRACE_OUTPUT, trace_output, str,
+				 "tracefile");
+}
+END_TEST
+
+START_TEST(test_trace_long_equals)
+{
+	PARSE_ARGS("osnoise", "hist", "--trace=tracefile");
+
+	CLI_ASSERT_SINGLE_ACTION(threshold_actions, ACTION_TRACE_OUTPUT, trace_output, str,
+				 "tracefile");
+}
+END_TEST
+
+/* Event Configuration */
+
+START_TEST(test_event_short)
+{
+	PARSE_ARGS("osnoise", "hist", "-e", "system:event");
+
+	CLI_ASSERT_SINGLE_EVENT("system", "event");
+}
+END_TEST
+
+START_TEST(test_event_long)
+{
+	PARSE_ARGS("osnoise", "hist", "--event", "system:event");
+
+	CLI_ASSERT_SINGLE_EVENT("system", "event");
+}
+END_TEST
+
+START_TEST(test_filter)
+{
+	PARSE_ARGS("osnoise", "hist", "-e", "system:event", "--filter", "filter");
+
+	CLI_ASSERT_SINGLE_FILTER("filter");
+}
+END_TEST
+
+START_TEST(test_trigger)
+{
+	PARSE_ARGS("osnoise", "hist", "-e", "system:event", "--trigger", "trigger");
+
+	CLI_ASSERT_SINGLE_TRIGGER("trigger");
+}
+END_TEST
+
+/* CPU Configuration */
+
+START_TEST(test_cpus_short)
+{
+	nr_cpus = 4;
+
+	PARSE_ARGS("osnoise", "hist", "-c", "0-1,3");
+
+	ck_assert_str_eq(params->cpus, "0-1,3");
+	CLI_ASSERT_CPUSET(monitored_cpus, 0, 1, 3);
+}
+END_TEST
+
+START_TEST(test_cpus_long)
+{
+	nr_cpus = 4;
+
+	PARSE_ARGS("osnoise", "hist", "--cpus", "0-1,3");
+
+	ck_assert_str_eq(params->cpus, "0-1,3");
+	CLI_ASSERT_CPUSET(monitored_cpus, 0, 1, 3);
+}
+END_TEST
+
+START_TEST(test_housekeeping_short)
+{
+	nr_cpus = 4;
+
+	PARSE_ARGS("osnoise", "hist", "-H", "0-1,3");
+
+	CLI_ASSERT_CPUSET(hk_cpu_set, 0, 1, 3);
+}
+END_TEST
+
+START_TEST(test_housekeeping_long)
+{
+	nr_cpus = 4;
+
+	PARSE_ARGS("osnoise", "hist", "--house-keeping", "0-1,3");
+
+	CLI_ASSERT_CPUSET(hk_cpu_set, 0, 1, 3);
+}
+END_TEST
+
+/* Thread Configuration */
+
+START_TEST(test_cgroup_short_noarg)
+{
+	PARSE_ARGS("osnoise", "hist", "-C");
+
+	ck_assert(params->cgroup);
+	ck_assert_ptr_null(params->cgroup_name);
+}
+END_TEST
+
+START_TEST(test_cgroup_short_space)
+{
+	PARSE_ARGS("osnoise", "hist", "-C", "cgroup");
+
+	ck_assert(params->cgroup);
+	ck_assert_str_eq(params->cgroup_name, "cgroup");
+}
+END_TEST
+
+START_TEST(test_cgroup_short_equals)
+{
+	PARSE_ARGS("osnoise", "hist", "-C=cgroup");
+
+	ck_assert(params->cgroup);
+	ck_assert_str_eq(params->cgroup_name, "cgroup");
+}
+END_TEST
+
+START_TEST(test_cgroup_long_noarg)
+{
+	PARSE_ARGS("osnoise", "hist", "--cgroup");
+
+	ck_assert(params->cgroup);
+	ck_assert_ptr_null(params->cgroup_name);
+}
+END_TEST
+
+START_TEST(test_cgroup_long_space)
+{
+	PARSE_ARGS("osnoise", "hist", "--cgroup", "cgroup");
+
+	ck_assert(params->cgroup);
+	ck_assert_str_eq(params->cgroup_name, "cgroup");
+}
+END_TEST
+
+START_TEST(test_cgroup_long_equals)
+{
+	PARSE_ARGS("osnoise", "hist", "--cgroup=cgroup");
+
+	ck_assert(params->cgroup);
+	ck_assert_str_eq(params->cgroup_name, "cgroup");
+}
+END_TEST
+
+START_TEST(test_priority_short)
+{
+	PARSE_ARGS("osnoise", "hist", "-P", "f:95");
+
+	ck_assert_int_eq(params->sched_param.sched_policy, SCHED_FIFO);
+	ck_assert_int_eq(params->sched_param.sched_priority, 95);
+}
+END_TEST
+
+START_TEST(test_priority_long)
+{
+	PARSE_ARGS("osnoise", "hist", "--priority", "f:95");
+
+	ck_assert_int_eq(params->sched_param.sched_policy, SCHED_FIFO);
+	ck_assert_int_eq(params->sched_param.sched_priority, 95);
+}
+END_TEST
+
+/* Histogram Options */
+
+START_TEST(test_bucket_size_short)
+{
+	PARSE_ARGS("osnoise", "hist", "-b", "2");
+
+	ck_assert_int_eq(params->hist.bucket_size, 2);
+}
+END_TEST
+
+START_TEST(test_bucket_size_long)
+{
+	PARSE_ARGS("osnoise", "hist", "--bucket-size", "2");
+
+	ck_assert_int_eq(params->hist.bucket_size, 2);
+}
+END_TEST
+
+START_TEST(test_entries_short)
+{
+	PARSE_ARGS("osnoise", "hist", "-E", "512");
+
+	ck_assert_int_eq(params->hist.entries, 512);
+}
+END_TEST
+
+START_TEST(test_entries_long)
+{
+	PARSE_ARGS("osnoise", "hist", "--entries", "512");
+
+	ck_assert_int_eq(params->hist.entries, 512);
+}
+END_TEST
+
+START_TEST(test_no_header)
+{
+	PARSE_ARGS("osnoise", "hist", "--no-header");
+
+	ck_assert(params->hist.no_header);
+}
+END_TEST
+
+START_TEST(test_no_index)
+{
+	PARSE_ARGS("osnoise", "hist", "--with-zeros", "--no-index");
+
+	ck_assert(params->hist.no_index);
+}
+END_TEST
+
+START_TEST(test_no_summary)
+{
+	PARSE_ARGS("osnoise", "hist", "--no-summary");
+
+	ck_assert(params->hist.no_summary);
+}
+END_TEST
+
+START_TEST(test_with_zeros)
+{
+	PARSE_ARGS("osnoise", "hist", "--with-zeros");
+
+	ck_assert(params->hist.with_zeros);
+}
+END_TEST
+
+/* System Tuning */
+
+START_TEST(test_trace_buffer_size)
+{
+	PARSE_ARGS("osnoise", "hist", "--trace-buffer-size", "200");
+
+	ck_assert_int_eq(params->buffer_size, 200);
+}
+END_TEST
+
+START_TEST(test_warm_up)
+{
+	PARSE_ARGS("osnoise", "hist", "--warm-up", "5");
+
+	ck_assert_int_eq(params->warmup, 5);
+}
+END_TEST
+
+/* Auto Analysis and Actions */
+
+START_TEST(test_auto)
+{
+	PARSE_ARGS("osnoise", "hist", "-a", "20");
+
+	CLI_OSNOISE_ASSERT_AUTO(20);
+}
+END_TEST
+
+START_TEST(test_on_end)
+{
+	PARSE_ARGS("osnoise", "hist", "--on-end", "trace");
+
+	CLI_ASSERT_SINGLE_ACTION(end_actions, ACTION_TRACE_OUTPUT, trace_output, str,
+				 "osnoise_trace.txt");
+}
+END_TEST
+
+START_TEST(test_on_threshold)
+{
+	PARSE_ARGS("osnoise", "hist", "--on-threshold", "trace");
+
+	CLI_ASSERT_SINGLE_ACTION(threshold_actions, ACTION_TRACE_OUTPUT, trace_output, str,
+				 "osnoise_trace.txt");
+}
+END_TEST
+
+/* General */
+
+START_TEST(test_debug_short)
+{
+	PARSE_ARGS("osnoise", "hist", "-D");
+
+	ck_assert(config_debug);
+}
+END_TEST
+
+START_TEST(test_debug_long)
+{
+	PARSE_ARGS("osnoise", "hist", "--debug");
+
+	ck_assert(config_debug);
+}
+END_TEST
+
+START_TEST(test_duration_short)
+{
+	PARSE_ARGS("osnoise", "hist", "-d", "1m");
+
+	ck_assert_int_eq(params->duration, 60);
+}
+END_TEST
+
+START_TEST(test_duration_long)
+{
+	PARSE_ARGS("osnoise", "hist", "--duration", "1m");
+
+	ck_assert_int_eq(params->duration, 60);
+}
+END_TEST
+
+Suite *osnoise_hist_cli_suite(void)
+{
+	Suite *s = suite_create("osnoise_hist_cli");
+	TCase *tc;
+
+	tc = tcase_create("tracing_options");
+	tcase_add_test(tc, test_period_short);
+	tcase_add_test(tc, test_period_long);
+	tcase_add_test(tc, test_runtime_short);
+	tcase_add_test(tc, test_runtime_long);
+	tcase_add_test(tc, test_stop_short);
+	tcase_add_test(tc, test_stop_long);
+	tcase_add_test(tc, test_stop_total_short);
+	tcase_add_test(tc, test_stop_total_long);
+	tcase_add_test(tc, test_threshold_short);
+	tcase_add_test(tc, test_threshold_long);
+	tcase_add_test(tc, test_trace_short_noarg);
+	tcase_add_test(tc, test_trace_short_followarg);
+	tcase_add_test(tc, test_trace_short_space);
+	tcase_add_test(tc, test_trace_short_equals);
+	tcase_add_test(tc, test_trace_long_noarg);
+	tcase_add_test(tc, test_trace_long_followarg);
+	tcase_add_test(tc, test_trace_long_space);
+	tcase_add_test(tc, test_trace_long_equals);
+	suite_add_tcase(s, tc);
+
+	tc = tcase_create("event_configuration");
+	tcase_add_test(tc, test_event_short);
+	tcase_add_test(tc, test_event_long);
+	tcase_add_test(tc, test_filter);
+	tcase_add_test(tc, test_trigger);
+	suite_add_tcase(s, tc);
+
+	tc = tcase_create("cpu_configuration");
+	tcase_add_test(tc, test_cpus_short);
+	tcase_add_test(tc, test_cpus_long);
+	tcase_add_test(tc, test_housekeeping_short);
+	tcase_add_test(tc, test_housekeeping_long);
+	suite_add_tcase(s, tc);
+
+	tc = tcase_create("thread_configuration");
+	tcase_add_test(tc, test_cgroup_short_noarg);
+	tcase_add_test(tc, test_cgroup_short_space);
+	tcase_add_test(tc, test_cgroup_short_equals);
+	tcase_add_test(tc, test_cgroup_long_noarg);
+	tcase_add_test(tc, test_cgroup_long_space);
+	tcase_add_test(tc, test_cgroup_long_equals);
+	tcase_add_test(tc, test_priority_short);
+	tcase_add_test(tc, test_priority_long);
+	suite_add_tcase(s, tc);
+
+	tc = tcase_create("histogram_options");
+	tcase_add_test(tc, test_bucket_size_short);
+	tcase_add_test(tc, test_bucket_size_long);
+	tcase_add_test(tc, test_entries_short);
+	tcase_add_test(tc, test_entries_long);
+	tcase_add_test(tc, test_no_header);
+	tcase_add_test(tc, test_no_index);
+	tcase_add_test(tc, test_no_summary);
+	tcase_add_test(tc, test_with_zeros);
+	suite_add_tcase(s, tc);
+
+	tc = tcase_create("system_tuning");
+	tcase_add_test(tc, test_trace_buffer_size);
+	tcase_add_test(tc, test_warm_up);
+	suite_add_tcase(s, tc);
+
+	tc = tcase_create("aa_actions");
+	tcase_add_test(tc, test_auto);
+	tcase_add_test(tc, test_on_end);
+	tcase_add_test(tc, test_on_threshold);
+	suite_add_tcase(s, tc);
+
+	tc = tcase_create("general");
+	tcase_add_test(tc, test_debug_short);
+	tcase_add_test(tc, test_debug_long);
+	tcase_add_test(tc, test_duration_short);
+	tcase_add_test(tc, test_duration_long);
+	suite_add_tcase(s, tc);
+
+	return s;
+}
diff --git a/tools/tracing/rtla/tests/unit/osnoise_top_cli.c b/tools/tracing/rtla/tests/unit/osnoise_top_cli.c
new file mode 100644
index 000000000000..f3a8633cc84e
--- /dev/null
+++ b/tools/tracing/rtla/tests/unit/osnoise_top_cli.c
@@ -0,0 +1,503 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <check.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sched.h>
+#include <limits.h>
+#include <unistd.h>
+#include <sys/sysinfo.h>
+
+#include "cli_params_assert.h"
+#include "../../src/cli.h"
+
+#define PARSE_ARGS(...) char *argv[] = { __VA_ARGS__, NULL  };\
+			int argc = sizeof(argv) / sizeof(char *) - 1;\
+			struct common_params *params =\
+				osnoise_top_parse_args(argc, argv);\
+			struct osnoise_params *osn_params __maybe_unused =\
+				to_osnoise_params(params)
+
+/* Tracing Options */
+
+START_TEST(test_period_short)
+{
+	PARSE_ARGS("osnoise", "top", "-p", "100000");
+
+	ck_assert_int_eq(osn_params->period, 100000);
+}
+END_TEST
+
+START_TEST(test_period_long)
+{
+	PARSE_ARGS("osnoise", "top", "--period", "100000");
+
+	ck_assert_int_eq(osn_params->period, 100000);
+}
+END_TEST
+
+START_TEST(test_runtime_short)
+{
+	PARSE_ARGS("osnoise", "top", "-r", "95000");
+
+	ck_assert_int_eq(osn_params->runtime, 95000);
+}
+END_TEST
+
+START_TEST(test_runtime_long)
+{
+	PARSE_ARGS("osnoise", "top", "--runtime", "95000");
+
+	ck_assert_int_eq(osn_params->runtime, 95000);
+}
+END_TEST
+
+START_TEST(test_stop_short)
+{
+	PARSE_ARGS("osnoise", "top", "-s", "20");
+
+	ck_assert_int_eq(params->stop_us, 20);
+}
+END_TEST
+
+START_TEST(test_stop_long)
+{
+	PARSE_ARGS("osnoise", "top", "--stop", "20");
+
+	ck_assert_int_eq(params->stop_us, 20);
+}
+END_TEST
+
+START_TEST(test_stop_total_short)
+{
+	PARSE_ARGS("osnoise", "top", "-S", "20");
+
+	ck_assert_int_eq(params->stop_total_us, 20);
+}
+END_TEST
+
+START_TEST(test_stop_total_long)
+{
+	PARSE_ARGS("osnoise", "top", "--stop-total", "20");
+
+	ck_assert_int_eq(params->stop_total_us, 20);
+}
+END_TEST
+
+START_TEST(test_threshold_short)
+{
+	PARSE_ARGS("osnoise", "top", "-T", "5");
+
+	ck_assert_int_eq(osn_params->threshold, 5);
+}
+END_TEST
+
+START_TEST(test_threshold_long)
+{
+	PARSE_ARGS("osnoise", "top", "--threshold", "5");
+
+	ck_assert_int_eq(osn_params->threshold, 5);
+}
+END_TEST
+
+START_TEST(test_trace_short_noarg)
+{
+	PARSE_ARGS("osnoise", "top", "-t");
+
+	CLI_ASSERT_SINGLE_ACTION(threshold_actions, ACTION_TRACE_OUTPUT, trace_output, str,
+				 "osnoise_trace.txt");
+}
+END_TEST
+
+START_TEST(test_trace_short_followarg)
+{
+	PARSE_ARGS("osnoise", "top", "-t", "-d", "20");
+
+	CLI_ASSERT_SINGLE_ACTION(threshold_actions, ACTION_TRACE_OUTPUT, trace_output, str,
+				 "osnoise_trace.txt");
+	ck_assert_int_eq(params->duration, 20); /* check if next argument is read correctly */
+}
+END_TEST
+
+START_TEST(test_trace_short_space)
+{
+	PARSE_ARGS("osnoise", "top", "-t", "tracefile");
+
+	CLI_ASSERT_SINGLE_ACTION(threshold_actions, ACTION_TRACE_OUTPUT, trace_output, str,
+				 "tracefile");
+}
+END_TEST
+
+START_TEST(test_trace_short_equals)
+{
+	PARSE_ARGS("osnoise", "top", "-t=tracefile");
+
+	CLI_ASSERT_SINGLE_ACTION(threshold_actions, ACTION_TRACE_OUTPUT, trace_output, str,
+				 "tracefile");
+}
+END_TEST
+
+START_TEST(test_trace_long_noarg)
+{
+	PARSE_ARGS("osnoise", "top", "--trace");
+
+	CLI_ASSERT_SINGLE_ACTION(threshold_actions, ACTION_TRACE_OUTPUT, trace_output, str,
+				 "osnoise_trace.txt");
+}
+END_TEST
+
+START_TEST(test_trace_long_followarg)
+{
+	PARSE_ARGS("osnoise", "top", "--trace", "-d", "20");
+
+	CLI_ASSERT_SINGLE_ACTION(threshold_actions, ACTION_TRACE_OUTPUT, trace_output, str,
+				 "osnoise_trace.txt");
+	ck_assert_int_eq(params->duration, 20); /* check if next argument is read correctly */
+}
+END_TEST
+
+START_TEST(test_trace_long_space)
+{
+	PARSE_ARGS("osnoise", "top", "--trace", "tracefile");
+
+	CLI_ASSERT_SINGLE_ACTION(threshold_actions, ACTION_TRACE_OUTPUT, trace_output, str,
+				 "tracefile");
+}
+END_TEST
+
+START_TEST(test_trace_long_equals)
+{
+	PARSE_ARGS("osnoise", "top", "--trace=tracefile");
+
+	CLI_ASSERT_SINGLE_ACTION(threshold_actions, ACTION_TRACE_OUTPUT, trace_output, str,
+				 "tracefile");
+}
+END_TEST
+
+/* Event Configuration */
+
+START_TEST(test_event_short)
+{
+	PARSE_ARGS("osnoise", "top", "-e", "system:event");
+
+	CLI_ASSERT_SINGLE_EVENT("system", "event");
+}
+END_TEST
+
+START_TEST(test_event_long)
+{
+	PARSE_ARGS("osnoise", "top", "--event", "system:event");
+
+	CLI_ASSERT_SINGLE_EVENT("system", "event");
+}
+END_TEST
+
+START_TEST(test_filter)
+{
+	PARSE_ARGS("osnoise", "top", "-e", "system:event", "--filter", "filter");
+
+	CLI_ASSERT_SINGLE_FILTER("filter");
+}
+END_TEST
+
+START_TEST(test_trigger)
+{
+	PARSE_ARGS("osnoise", "top", "-e", "system:event", "--trigger", "trigger");
+
+	CLI_ASSERT_SINGLE_TRIGGER("trigger");
+}
+END_TEST
+
+/* CPU Configuration */
+
+START_TEST(test_cpus_short)
+{
+	nr_cpus = 4;
+
+	PARSE_ARGS("osnoise", "top", "-c", "0-1,3");
+
+	ck_assert_str_eq(params->cpus, "0-1,3");
+	CLI_ASSERT_CPUSET(monitored_cpus, 0, 1, 3);
+}
+END_TEST
+
+START_TEST(test_cpus_long)
+{
+	nr_cpus = 4;
+
+	PARSE_ARGS("osnoise", "top", "--cpus", "0-1,3");
+
+	ck_assert_str_eq(params->cpus, "0-1,3");
+	CLI_ASSERT_CPUSET(monitored_cpus, 0, 1, 3);
+}
+END_TEST
+
+START_TEST(test_housekeeping_short)
+{
+	nr_cpus = 4;
+
+	PARSE_ARGS("osnoise", "top", "-H", "0-1,3");
+
+	CLI_ASSERT_CPUSET(hk_cpu_set, 0, 1, 3);
+}
+END_TEST
+
+START_TEST(test_housekeeping_long)
+{
+	nr_cpus = 4;
+
+	PARSE_ARGS("osnoise", "top", "--house-keeping", "0-1,3");
+
+	CLI_ASSERT_CPUSET(hk_cpu_set, 0, 1, 3);
+}
+END_TEST
+
+/* Thread Configuration */
+
+START_TEST(test_cgroup_short_noarg)
+{
+	PARSE_ARGS("osnoise", "top", "-C");
+
+	ck_assert(params->cgroup);
+	ck_assert_ptr_null(params->cgroup_name);
+}
+END_TEST
+
+START_TEST(test_cgroup_short_space)
+{
+	PARSE_ARGS("osnoise", "top", "-C", "cgroup");
+
+	ck_assert(params->cgroup);
+	ck_assert_str_eq(params->cgroup_name, "cgroup");
+}
+END_TEST
+
+START_TEST(test_cgroup_short_equals)
+{
+	PARSE_ARGS("osnoise", "top", "-C=cgroup");
+
+	ck_assert(params->cgroup);
+	ck_assert_str_eq(params->cgroup_name, "cgroup");
+}
+END_TEST
+
+START_TEST(test_cgroup_long_noarg)
+{
+	PARSE_ARGS("osnoise", "top", "--cgroup");
+
+	ck_assert(params->cgroup);
+	ck_assert_ptr_null(params->cgroup_name);
+}
+END_TEST
+
+START_TEST(test_cgroup_long_space)
+{
+	PARSE_ARGS("osnoise", "top", "--cgroup", "cgroup");
+
+	ck_assert(params->cgroup);
+	ck_assert_str_eq(params->cgroup_name, "cgroup");
+}
+END_TEST
+
+START_TEST(test_cgroup_long_equals)
+{
+	PARSE_ARGS("osnoise", "top", "--cgroup=cgroup");
+
+	ck_assert(params->cgroup);
+	ck_assert_str_eq(params->cgroup_name, "cgroup");
+}
+END_TEST
+
+START_TEST(test_priority_short)
+{
+	PARSE_ARGS("osnoise", "top", "-P", "f:95");
+
+	ck_assert_int_eq(params->sched_param.sched_policy, SCHED_FIFO);
+	ck_assert_int_eq(params->sched_param.sched_priority, 95);
+}
+END_TEST
+
+START_TEST(test_priority_long)
+{
+	PARSE_ARGS("osnoise", "top", "--priority", "f:95");
+
+	ck_assert_int_eq(params->sched_param.sched_policy, SCHED_FIFO);
+	ck_assert_int_eq(params->sched_param.sched_priority, 95);
+}
+END_TEST
+
+/* Output */
+
+START_TEST(test_quiet_short)
+{
+	PARSE_ARGS("osnoise", "top", "-q");
+
+	ck_assert(params->quiet);
+}
+END_TEST
+
+START_TEST(test_quiet_long)
+{
+	PARSE_ARGS("osnoise", "top", "--quiet");
+
+	ck_assert(params->quiet);
+}
+END_TEST
+
+/* Auto Analysis and Actions */
+
+START_TEST(test_auto)
+{
+	PARSE_ARGS("osnoise", "top", "-a", "20");
+
+	CLI_OSNOISE_ASSERT_AUTO(20);
+}
+END_TEST
+
+START_TEST(test_on_end)
+{
+	PARSE_ARGS("osnoise", "top", "--on-end", "trace");
+
+	CLI_ASSERT_SINGLE_ACTION(end_actions, ACTION_TRACE_OUTPUT, trace_output, str,
+				 "osnoise_trace.txt");
+}
+END_TEST
+
+START_TEST(test_on_threshold)
+{
+	PARSE_ARGS("osnoise", "top", "--on-threshold", "trace");
+
+	CLI_ASSERT_SINGLE_ACTION(threshold_actions, ACTION_TRACE_OUTPUT, trace_output, str,
+				 "osnoise_trace.txt");
+}
+END_TEST
+
+/* System Tuning */
+
+START_TEST(test_trace_buffer_size)
+{
+	PARSE_ARGS("osnoise", "top", "--trace-buffer-size", "200");
+
+	ck_assert_int_eq(params->buffer_size, 200);
+}
+END_TEST
+
+START_TEST(test_warm_up)
+{
+	PARSE_ARGS("osnoise", "top", "--warm-up", "5");
+
+	ck_assert_int_eq(params->warmup, 5);
+}
+END_TEST
+
+/* General */
+
+START_TEST(test_debug_short)
+{
+	PARSE_ARGS("osnoise", "top", "-D");
+
+	ck_assert(config_debug);
+}
+END_TEST
+
+START_TEST(test_debug_long)
+{
+	PARSE_ARGS("osnoise", "top", "--debug");
+
+	ck_assert(config_debug);
+}
+END_TEST
+
+START_TEST(test_duration_short)
+{
+	PARSE_ARGS("osnoise", "top", "-d", "1m");
+
+	ck_assert_int_eq(params->duration, 60);
+}
+END_TEST
+
+START_TEST(test_duration_long)
+{
+	PARSE_ARGS("osnoise", "top", "--duration", "1m");
+
+	ck_assert_int_eq(params->duration, 60);
+}
+END_TEST
+
+Suite *osnoise_top_cli_suite(void)
+{
+	Suite *s = suite_create("osnoise_top_cli");
+	TCase *tc;
+
+	tc = tcase_create("tracing_options");
+	tcase_add_test(tc, test_period_short);
+	tcase_add_test(tc, test_period_long);
+	tcase_add_test(tc, test_runtime_short);
+	tcase_add_test(tc, test_runtime_long);
+	tcase_add_test(tc, test_stop_short);
+	tcase_add_test(tc, test_stop_long);
+	tcase_add_test(tc, test_stop_total_short);
+	tcase_add_test(tc, test_stop_total_long);
+	tcase_add_test(tc, test_threshold_short);
+	tcase_add_test(tc, test_threshold_long);
+	tcase_add_test(tc, test_trace_short_noarg);
+	tcase_add_test(tc, test_trace_short_followarg);
+	tcase_add_test(tc, test_trace_short_space);
+	tcase_add_test(tc, test_trace_short_equals);
+	tcase_add_test(tc, test_trace_long_noarg);
+	tcase_add_test(tc, test_trace_long_followarg);
+	tcase_add_test(tc, test_trace_long_space);
+	tcase_add_test(tc, test_trace_long_equals);
+	suite_add_tcase(s, tc);
+
+	tc = tcase_create("event_configuration");
+	tcase_add_test(tc, test_event_short);
+	tcase_add_test(tc, test_event_long);
+	tcase_add_test(tc, test_filter);
+	tcase_add_test(tc, test_trigger);
+	suite_add_tcase(s, tc);
+
+	tc = tcase_create("cpu_configuration");
+	tcase_add_test(tc, test_cpus_short);
+	tcase_add_test(tc, test_cpus_long);
+	tcase_add_test(tc, test_housekeeping_short);
+	tcase_add_test(tc, test_housekeeping_long);
+	suite_add_tcase(s, tc);
+
+	tc = tcase_create("thread_configuration");
+	tcase_add_test(tc, test_cgroup_short_noarg);
+	tcase_add_test(tc, test_cgroup_short_space);
+	tcase_add_test(tc, test_cgroup_short_equals);
+	tcase_add_test(tc, test_cgroup_long_noarg);
+	tcase_add_test(tc, test_cgroup_long_space);
+	tcase_add_test(tc, test_cgroup_long_equals);
+	tcase_add_test(tc, test_priority_short);
+	tcase_add_test(tc, test_priority_long);
+	suite_add_tcase(s, tc);
+
+	tc = tcase_create("output");
+	tcase_add_test(tc, test_quiet_short);
+	tcase_add_test(tc, test_quiet_long);
+	suite_add_tcase(s, tc);
+
+	tc = tcase_create("system_tuning");
+	tcase_add_test(tc, test_trace_buffer_size);
+	tcase_add_test(tc, test_warm_up);
+	suite_add_tcase(s, tc);
+
+	tc = tcase_create("aa_actions");
+	tcase_add_test(tc, test_auto);
+	tcase_add_test(tc, test_on_end);
+	tcase_add_test(tc, test_on_threshold);
+	suite_add_tcase(s, tc);
+
+	tc = tcase_create("general");
+	tcase_add_test(tc, test_debug_short);
+	tcase_add_test(tc, test_debug_long);
+	tcase_add_test(tc, test_duration_short);
+	tcase_add_test(tc, test_duration_long);
+	suite_add_tcase(s, tc);
+
+	return s;
+}
diff --git a/tools/tracing/rtla/tests/unit/timerlat_hist_cli.c b/tools/tracing/rtla/tests/unit/timerlat_hist_cli.c
new file mode 100644
index 000000000000..81dc04596cd1
--- /dev/null
+++ b/tools/tracing/rtla/tests/unit/timerlat_hist_cli.c
@@ -0,0 +1,702 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <check.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sched.h>
+#include <limits.h>
+#include <unistd.h>
+#include <sys/sysinfo.h>
+
+#include <linux/container_of.h>
+
+#include "cli_params_assert.h"
+#include "../../src/cli.h"
+
+#define PARSE_ARGS(...) char *argv[] = { __VA_ARGS__, NULL  };\
+			int argc = sizeof(argv) / sizeof(char *) - 1;\
+			struct common_params *params =\
+				timerlat_hist_parse_args(argc, argv);\
+			struct timerlat_params *tlat_params __maybe_unused =\
+				to_timerlat_params(params)
+
+/* Tracing Options */
+
+START_TEST(test_irq_short)
+{
+	PARSE_ARGS("timerlat", "hist", "-i", "20");
+
+	ck_assert_int_eq(params->stop_us, 20);
+}
+END_TEST
+
+START_TEST(test_irq_long)
+{
+	PARSE_ARGS("timerlat", "hist", "--irq", "20");
+
+	ck_assert_int_eq(params->stop_us, 20);
+}
+END_TEST
+
+START_TEST(test_period_short)
+{
+	PARSE_ARGS("timerlat", "hist", "-p", "200");
+
+	ck_assert_int_eq(tlat_params->timerlat_period_us, 200);
+}
+END_TEST
+
+START_TEST(test_period_long)
+{
+	PARSE_ARGS("timerlat", "hist", "--period", "200");
+
+	ck_assert_int_eq(tlat_params->timerlat_period_us, 200);
+}
+END_TEST
+
+START_TEST(test_stack_short)
+{
+	PARSE_ARGS("timerlat", "hist", "-s", "20");
+
+	ck_assert_int_eq(tlat_params->print_stack, 20);
+}
+END_TEST
+
+START_TEST(test_stack_long)
+{
+	PARSE_ARGS("timerlat", "hist", "--stack", "20");
+
+	ck_assert_int_eq(tlat_params->print_stack, 20);
+}
+END_TEST
+
+START_TEST(test_thread_short)
+{
+	PARSE_ARGS("timerlat", "hist", "-T", "20");
+
+	ck_assert_int_eq(params->stop_total_us, 20);
+}
+END_TEST
+
+START_TEST(test_thread_long)
+{
+	PARSE_ARGS("timerlat", "hist", "--thread", "20");
+
+	ck_assert_int_eq(params->stop_total_us, 20);
+}
+END_TEST
+
+START_TEST(test_trace_short_noarg)
+{
+	PARSE_ARGS("timerlat", "hist", "-t");
+
+	CLI_ASSERT_SINGLE_ACTION(threshold_actions, ACTION_TRACE_OUTPUT, trace_output, str,
+				 "timerlat_trace.txt");
+}
+END_TEST
+
+START_TEST(test_trace_short_followarg)
+{
+	PARSE_ARGS("timerlat", "hist", "-t", "-d", "20");
+
+	CLI_ASSERT_SINGLE_ACTION(threshold_actions, ACTION_TRACE_OUTPUT, trace_output, str,
+				 "timerlat_trace.txt");
+	ck_assert_int_eq(params->duration, 20); /* check if next argument is read correctly */
+}
+END_TEST
+
+START_TEST(test_trace_short_space)
+{
+	PARSE_ARGS("timerlat", "hist", "-t", "tracefile");
+
+	CLI_ASSERT_SINGLE_ACTION(threshold_actions, ACTION_TRACE_OUTPUT, trace_output, str,
+				 "tracefile");
+}
+END_TEST
+
+START_TEST(test_trace_short_equals)
+{
+	PARSE_ARGS("timerlat", "hist", "-t=tracefile");
+
+	CLI_ASSERT_SINGLE_ACTION(threshold_actions, ACTION_TRACE_OUTPUT, trace_output, str,
+				 "tracefile");
+}
+END_TEST
+
+START_TEST(test_trace_long_noarg)
+{
+	PARSE_ARGS("timerlat", "hist", "--trace");
+
+	CLI_ASSERT_SINGLE_ACTION(threshold_actions, ACTION_TRACE_OUTPUT, trace_output, str,
+				 "timerlat_trace.txt");
+}
+END_TEST
+
+START_TEST(test_trace_long_followarg)
+{
+	PARSE_ARGS("timerlat", "hist", "--trace", "-d", "20");
+
+	CLI_ASSERT_SINGLE_ACTION(threshold_actions, ACTION_TRACE_OUTPUT, trace_output, str,
+				 "timerlat_trace.txt");
+	ck_assert_int_eq(params->duration, 20); /* check if next argument is read correctly */
+}
+END_TEST
+
+START_TEST(test_trace_long_space)
+{
+	PARSE_ARGS("timerlat", "hist", "--trace", "tracefile");
+
+	CLI_ASSERT_SINGLE_ACTION(threshold_actions, ACTION_TRACE_OUTPUT, trace_output, str,
+				 "tracefile");
+}
+END_TEST
+
+START_TEST(test_trace_long_equals)
+{
+	PARSE_ARGS("timerlat", "hist", "--trace=tracefile");
+
+	CLI_ASSERT_SINGLE_ACTION(threshold_actions, ACTION_TRACE_OUTPUT, trace_output, str,
+				 "tracefile");
+}
+END_TEST
+
+/* Event Configuration */
+
+START_TEST(test_event_short)
+{
+	PARSE_ARGS("timerlat", "hist", "-e", "system:event");
+
+	CLI_ASSERT_SINGLE_EVENT("system", "event");
+}
+END_TEST
+
+START_TEST(test_event_long)
+{
+	PARSE_ARGS("timerlat", "hist", "--event", "system:event");
+
+	CLI_ASSERT_SINGLE_EVENT("system", "event");
+}
+END_TEST
+
+START_TEST(test_filter)
+{
+	PARSE_ARGS("timerlat", "hist", "-e", "system:event", "--filter", "filter");
+
+	CLI_ASSERT_SINGLE_FILTER("filter");
+}
+END_TEST
+
+START_TEST(test_trigger)
+{
+	PARSE_ARGS("timerlat", "hist", "-e", "system:event", "--trigger", "trigger");
+
+	CLI_ASSERT_SINGLE_TRIGGER("trigger");
+}
+END_TEST
+
+/* CPU Configuration */
+
+START_TEST(test_cpus_short)
+{
+	nr_cpus = 4;
+
+	PARSE_ARGS("timerlat", "hist", "-c", "0-1,3");
+
+	ck_assert_str_eq(params->cpus, "0-1,3");
+	CLI_ASSERT_CPUSET(monitored_cpus, 0, 1, 3);
+}
+END_TEST
+
+START_TEST(test_cpus_long)
+{
+	nr_cpus = 4;
+
+	PARSE_ARGS("timerlat", "hist", "--cpus", "0-1,3");
+
+	ck_assert_str_eq(params->cpus, "0-1,3");
+	CLI_ASSERT_CPUSET(monitored_cpus, 0, 1, 3);
+}
+END_TEST
+
+START_TEST(test_housekeeping_short)
+{
+	nr_cpus = 4;
+
+	PARSE_ARGS("timerlat", "hist", "-H", "0-1,3");
+
+	CLI_ASSERT_CPUSET(hk_cpu_set, 0, 1, 3);
+}
+END_TEST
+
+START_TEST(test_housekeeping_long)
+{
+	nr_cpus = 4;
+
+	PARSE_ARGS("timerlat", "hist", "--house-keeping", "0-1,3");
+
+	CLI_ASSERT_CPUSET(hk_cpu_set, 0, 1, 3);
+}
+END_TEST
+
+/* Thread Configuration */
+
+START_TEST(test_cgroup_short_noarg)
+{
+	PARSE_ARGS("timerlat", "hist", "-C");
+
+	ck_assert(params->cgroup);
+	ck_assert_ptr_null(params->cgroup_name);
+}
+END_TEST
+
+START_TEST(test_cgroup_short_space)
+{
+	PARSE_ARGS("timerlat", "hist", "-C", "cgroup");
+
+	ck_assert(params->cgroup);
+	ck_assert_str_eq(params->cgroup_name, "cgroup");
+}
+END_TEST
+
+START_TEST(test_cgroup_short_equals)
+{
+	PARSE_ARGS("timerlat", "hist", "-C=cgroup");
+
+	ck_assert(params->cgroup);
+	ck_assert_str_eq(params->cgroup_name, "cgroup");
+}
+END_TEST
+
+START_TEST(test_cgroup_long_noarg)
+{
+	PARSE_ARGS("timerlat", "hist", "--cgroup");
+
+	ck_assert(params->cgroup);
+	ck_assert_ptr_null(params->cgroup_name);
+}
+END_TEST
+
+START_TEST(test_cgroup_long_space)
+{
+	PARSE_ARGS("timerlat", "hist", "--cgroup", "cgroup");
+
+	ck_assert(params->cgroup);
+	ck_assert_str_eq(params->cgroup_name, "cgroup");
+}
+END_TEST
+
+START_TEST(test_cgroup_long_equals)
+{
+	PARSE_ARGS("timerlat", "hist", "--cgroup=cgroup");
+
+	ck_assert(params->cgroup);
+	ck_assert_str_eq(params->cgroup_name, "cgroup");
+}
+END_TEST
+
+START_TEST(test_kernel_threads_short)
+{
+	PARSE_ARGS("timerlat", "hist", "-k");
+
+	ck_assert(params->kernel_workload);
+	ck_assert(!params->user_workload);
+	ck_assert(!params->user_data);
+}
+END_TEST
+
+START_TEST(test_kernel_threads_long)
+{
+	PARSE_ARGS("timerlat", "hist", "--kernel-threads");
+
+	ck_assert(params->kernel_workload);
+	ck_assert(!params->user_workload);
+	ck_assert(!params->user_data);
+}
+END_TEST
+
+START_TEST(test_priority_short)
+{
+	PARSE_ARGS("timerlat", "hist", "-P", "f:95");
+
+	ck_assert_int_eq(params->sched_param.sched_policy, SCHED_FIFO);
+	ck_assert_int_eq(params->sched_param.sched_priority, 95);
+}
+END_TEST
+
+START_TEST(test_priority_long)
+{
+	PARSE_ARGS("timerlat", "hist", "--priority", "f:95");
+
+	ck_assert_int_eq(params->sched_param.sched_policy, SCHED_FIFO);
+	ck_assert_int_eq(params->sched_param.sched_priority, 95);
+}
+END_TEST
+
+START_TEST(test_user_load_short)
+{
+	PARSE_ARGS("timerlat", "hist", "-U");
+
+	ck_assert(!params->kernel_workload);
+	ck_assert(!params->user_workload);
+	ck_assert(params->user_data);
+}
+END_TEST
+
+START_TEST(test_user_load_long)
+{
+	PARSE_ARGS("timerlat", "hist", "--user-load");
+
+	ck_assert(!params->kernel_workload);
+	ck_assert(!params->user_workload);
+	ck_assert(params->user_data);
+}
+END_TEST
+
+START_TEST(test_user_threads_short)
+{
+	PARSE_ARGS("timerlat", "hist", "-u");
+
+	ck_assert(!params->kernel_workload);
+	ck_assert(params->user_workload);
+	ck_assert(params->user_data);
+}
+END_TEST
+
+START_TEST(test_user_threads_long)
+{
+	PARSE_ARGS("timerlat", "hist", "--user-threads");
+
+	ck_assert(!params->kernel_workload);
+	ck_assert(params->user_workload);
+	ck_assert(params->user_data);
+}
+END_TEST
+
+/* Histogram Options */
+
+START_TEST(test_bucket_size_short)
+{
+	PARSE_ARGS("timerlat", "hist", "-b", "2");
+
+	ck_assert_int_eq(params->hist.bucket_size, 2);
+}
+END_TEST
+
+START_TEST(test_bucket_size_long)
+{
+	PARSE_ARGS("timerlat", "hist", "--bucket-size", "2");
+
+	ck_assert_int_eq(params->hist.bucket_size, 2);
+}
+END_TEST
+
+START_TEST(test_entries_short)
+{
+	PARSE_ARGS("timerlat", "hist", "-E", "512");
+
+	ck_assert_int_eq(params->hist.entries, 512);
+}
+END_TEST
+
+START_TEST(test_entries_long)
+{
+	PARSE_ARGS("timerlat", "hist", "--entries", "512");
+
+	ck_assert_int_eq(params->hist.entries, 512);
+}
+END_TEST
+
+START_TEST(test_no_header)
+{
+	PARSE_ARGS("timerlat", "hist", "--no-header");
+
+	ck_assert(params->hist.no_header);
+}
+END_TEST
+
+START_TEST(test_no_index)
+{
+	PARSE_ARGS("timerlat", "hist", "--with-zeros", "--no-index");
+
+	ck_assert(params->hist.no_index);
+}
+END_TEST
+
+START_TEST(test_no_irq)
+{
+	PARSE_ARGS("timerlat", "hist", "--no-irq");
+
+	ck_assert(params->hist.no_irq);
+}
+END_TEST
+
+START_TEST(test_no_summary)
+{
+	PARSE_ARGS("timerlat", "hist", "--no-summary");
+
+	ck_assert(params->hist.no_summary);
+}
+END_TEST
+
+START_TEST(test_no_thread)
+{
+	PARSE_ARGS("timerlat", "hist", "--no-thread");
+
+	ck_assert(params->hist.no_thread);
+}
+END_TEST
+
+START_TEST(test_with_zeros)
+{
+	PARSE_ARGS("timerlat", "hist", "--with-zeros");
+
+	ck_assert(params->hist.with_zeros);
+}
+END_TEST
+
+/* Output */
+
+START_TEST(test_nano_short)
+{
+	PARSE_ARGS("timerlat", "hist", "-n");
+
+	ck_assert_int_eq(params->output_divisor, 1);
+}
+END_TEST
+
+START_TEST(test_nano_long)
+{
+	PARSE_ARGS("timerlat", "hist", "--nano");
+
+	ck_assert_int_eq(params->output_divisor, 1);
+}
+END_TEST
+
+/* System Tuning */
+
+START_TEST(test_deepest_idle_state)
+{
+	PARSE_ARGS("timerlat", "hist", "--deepest-idle-state", "1");
+
+	ck_assert_int_eq(tlat_params->deepest_idle_state, 1);
+}
+END_TEST
+
+START_TEST(test_dma_latency)
+{
+	PARSE_ARGS("timerlat", "hist", "--dma-latency", "10");
+
+	ck_assert_int_eq(tlat_params->dma_latency, 10);
+}
+END_TEST
+
+START_TEST(test_trace_buffer_size)
+{
+	PARSE_ARGS("timerlat", "hist", "--trace-buffer-size", "200");
+
+	ck_assert_int_eq(params->buffer_size, 200);
+}
+END_TEST
+
+START_TEST(test_warm_up)
+{
+	PARSE_ARGS("timerlat", "hist", "--warm-up", "5");
+
+	ck_assert_int_eq(params->warmup, 5);
+}
+END_TEST
+
+/* Auto Analysis and Actions */
+
+START_TEST(test_auto)
+{
+	PARSE_ARGS("timerlat", "hist", "-a", "20");
+
+	CLI_TIMERLAT_ASSERT_AUTO(20);
+}
+END_TEST
+
+START_TEST(test_bpf_action)
+{
+	PARSE_ARGS("timerlat", "hist", "--bpf-action", "program");
+
+	ck_assert_str_eq(tlat_params->bpf_action_program, "program");
+}
+END_TEST
+
+START_TEST(test_dump_tasks)
+{
+	PARSE_ARGS("timerlat", "hist", "--dump-tasks");
+
+	ck_assert(tlat_params->dump_tasks);
+}
+END_TEST
+
+START_TEST(test_no_aa)
+{
+	PARSE_ARGS("timerlat", "hist", "--no-aa");
+
+	ck_assert(tlat_params->no_aa);
+}
+END_TEST
+
+START_TEST(test_on_end)
+{
+	PARSE_ARGS("timerlat", "hist", "--on-end", "trace");
+
+	CLI_ASSERT_SINGLE_ACTION(end_actions, ACTION_TRACE_OUTPUT, trace_output, str,
+				 "timerlat_trace.txt");
+}
+END_TEST
+
+START_TEST(test_on_threshold)
+{
+	PARSE_ARGS("timerlat", "hist", "--on-threshold", "trace");
+
+	CLI_ASSERT_SINGLE_ACTION(threshold_actions, ACTION_TRACE_OUTPUT, trace_output, str,
+				 "timerlat_trace.txt");
+}
+END_TEST
+
+START_TEST(test_stack_format)
+{
+	PARSE_ARGS("timerlat", "hist", "--stack-format", "truncate");
+
+	ck_assert_int_eq(tlat_params->stack_format, STACK_FORMAT_TRUNCATE);
+}
+END_TEST
+
+/* General */
+
+START_TEST(test_debug_short)
+{
+	PARSE_ARGS("timerlat", "hist", "-D");
+
+	ck_assert(config_debug);
+}
+END_TEST
+
+START_TEST(test_debug_long)
+{
+	PARSE_ARGS("timerlat", "hist", "--debug");
+
+	ck_assert(config_debug);
+}
+END_TEST
+
+START_TEST(test_duration_short)
+{
+	PARSE_ARGS("timerlat", "hist", "-d", "1m");
+
+	ck_assert_int_eq(params->duration, 60);
+}
+END_TEST
+
+START_TEST(test_duration_long)
+{
+	PARSE_ARGS("timerlat", "hist", "--duration", "1m");
+
+	ck_assert_int_eq(params->duration, 60);
+}
+END_TEST
+
+Suite *timerlat_hist_cli_suite(void)
+{
+	Suite *s = suite_create("timerlat_hist_cli");
+	TCase *tc;
+
+	tc = tcase_create("tracing_options");
+	tcase_add_test(tc, test_irq_short);
+	tcase_add_test(tc, test_irq_long);
+	tcase_add_test(tc, test_period_short);
+	tcase_add_test(tc, test_period_long);
+	tcase_add_test(tc, test_stack_short);
+	tcase_add_test(tc, test_stack_long);
+	tcase_add_test(tc, test_thread_short);
+	tcase_add_test(tc, test_thread_long);
+	tcase_add_test(tc, test_trace_short_noarg);
+	tcase_add_test(tc, test_trace_short_followarg);
+	tcase_add_test(tc, test_trace_short_space);
+	tcase_add_test(tc, test_trace_short_equals);
+	tcase_add_test(tc, test_trace_long_noarg);
+	tcase_add_test(tc, test_trace_long_followarg);
+	tcase_add_test(tc, test_trace_long_space);
+	tcase_add_test(tc, test_trace_long_equals);
+	suite_add_tcase(s, tc);
+
+	tc = tcase_create("event_configuration");
+	tcase_add_test(tc, test_event_short);
+	tcase_add_test(tc, test_event_long);
+	tcase_add_test(tc, test_filter);
+	tcase_add_test(tc, test_trigger);
+	suite_add_tcase(s, tc);
+
+	tc = tcase_create("cpu_configuration");
+	tcase_add_test(tc, test_cpus_short);
+	tcase_add_test(tc, test_cpus_long);
+	tcase_add_test(tc, test_housekeeping_short);
+	tcase_add_test(tc, test_housekeeping_long);
+	suite_add_tcase(s, tc);
+
+	tc = tcase_create("thread_configuration");
+	tcase_add_test(tc, test_cgroup_short_noarg);
+	tcase_add_test(tc, test_cgroup_short_space);
+	tcase_add_test(tc, test_cgroup_short_equals);
+	tcase_add_test(tc, test_cgroup_long_noarg);
+	tcase_add_test(tc, test_cgroup_long_space);
+	tcase_add_test(tc, test_cgroup_long_equals);
+	tcase_add_test(tc, test_kernel_threads_short);
+	tcase_add_test(tc, test_kernel_threads_long);
+	tcase_add_test(tc, test_priority_short);
+	tcase_add_test(tc, test_priority_long);
+	tcase_add_test(tc, test_user_load_short);
+	tcase_add_test(tc, test_user_load_long);
+	tcase_add_test(tc, test_user_threads_short);
+	tcase_add_test(tc, test_user_threads_long);
+	suite_add_tcase(s, tc);
+
+	tc = tcase_create("histogram_options");
+	tcase_add_test(tc, test_bucket_size_short);
+	tcase_add_test(tc, test_bucket_size_long);
+	tcase_add_test(tc, test_entries_short);
+	tcase_add_test(tc, test_entries_long);
+	tcase_add_test(tc, test_no_header);
+	tcase_add_test(tc, test_no_index);
+	tcase_add_test(tc, test_no_irq);
+	tcase_add_test(tc, test_no_summary);
+	tcase_add_test(tc, test_no_thread);
+	tcase_add_test(tc, test_with_zeros);
+	suite_add_tcase(s, tc);
+
+	tc = tcase_create("output");
+	tcase_add_test(tc, test_nano_short);
+	tcase_add_test(tc, test_nano_long);
+	suite_add_tcase(s, tc);
+
+	tc = tcase_create("system_tuning");
+	tcase_add_test(tc, test_deepest_idle_state);
+	tcase_add_test(tc, test_dma_latency);
+	tcase_add_test(tc, test_trace_buffer_size);
+	tcase_add_test(tc, test_warm_up);
+	suite_add_tcase(s, tc);
+
+	tc = tcase_create("aa_actions");
+	tcase_add_test(tc, test_auto);
+	tcase_add_test(tc, test_bpf_action);
+	tcase_add_test(tc, test_dump_tasks);
+	tcase_add_test(tc, test_no_aa);
+	tcase_add_test(tc, test_on_end);
+	tcase_add_test(tc, test_on_threshold);
+	tcase_add_test(tc, test_stack_format);
+	suite_add_tcase(s, tc);
+
+	tc = tcase_create("general");
+	tcase_add_test(tc, test_debug_short);
+	tcase_add_test(tc, test_debug_long);
+	tcase_add_test(tc, test_duration_short);
+	tcase_add_test(tc, test_duration_long);
+	suite_add_tcase(s, tc);
+
+	return s;
+}
diff --git a/tools/tracing/rtla/tests/unit/timerlat_top_cli.c b/tools/tracing/rtla/tests/unit/timerlat_top_cli.c
new file mode 100644
index 000000000000..1c39008564c5
--- /dev/null
+++ b/tools/tracing/rtla/tests/unit/timerlat_top_cli.c
@@ -0,0 +1,634 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <check.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sched.h>
+#include <limits.h>
+#include <unistd.h>
+#include <sys/sysinfo.h>
+
+#include <linux/container_of.h>
+
+#include "cli_params_assert.h"
+#include "../../src/cli.h"
+
+#define PARSE_ARGS(...) char *argv[] = { __VA_ARGS__, NULL  };\
+			int argc = sizeof(argv) / sizeof(char *) - 1;\
+			struct common_params *params =\
+				timerlat_top_parse_args(argc, argv);\
+			struct timerlat_params *tlat_params __maybe_unused =\
+				to_timerlat_params(params)
+
+/* Tracing Options */
+
+START_TEST(test_irq_short)
+{
+	PARSE_ARGS("timerlat", "top", "-i", "20");
+
+	ck_assert_int_eq(params->stop_us, 20);
+}
+END_TEST
+
+START_TEST(test_irq_long)
+{
+	PARSE_ARGS("timerlat", "top", "--irq", "20");
+
+	ck_assert_int_eq(params->stop_us, 20);
+}
+END_TEST
+
+START_TEST(test_period_short)
+{
+	PARSE_ARGS("timerlat", "top", "-p", "200");
+
+	ck_assert_int_eq(tlat_params->timerlat_period_us, 200);
+}
+END_TEST
+
+START_TEST(test_period_long)
+{
+	PARSE_ARGS("timerlat", "top", "--period", "200");
+
+	ck_assert_int_eq(tlat_params->timerlat_period_us, 200);
+}
+END_TEST
+
+START_TEST(test_stack_short)
+{
+	PARSE_ARGS("timerlat", "top", "-s", "20");
+
+	ck_assert_int_eq(tlat_params->print_stack, 20);
+}
+END_TEST
+
+START_TEST(test_stack_long)
+{
+	PARSE_ARGS("timerlat", "top", "--stack", "20");
+
+	ck_assert_int_eq(tlat_params->print_stack, 20);
+}
+END_TEST
+
+START_TEST(test_thread_short)
+{
+	PARSE_ARGS("timerlat", "top", "-T", "20");
+
+	ck_assert_int_eq(params->stop_total_us, 20);
+}
+END_TEST
+
+START_TEST(test_thread_long)
+{
+	PARSE_ARGS("timerlat", "top", "--thread", "20");
+
+	ck_assert_int_eq(params->stop_total_us, 20);
+}
+END_TEST
+
+/* Event Configuration */
+
+START_TEST(test_event_short)
+{
+	PARSE_ARGS("timerlat", "top", "-e", "system:event");
+
+	CLI_ASSERT_SINGLE_EVENT("system", "event");
+}
+END_TEST
+
+START_TEST(test_event_long)
+{
+	PARSE_ARGS("timerlat", "top", "--event", "system:event");
+
+	CLI_ASSERT_SINGLE_EVENT("system", "event");
+}
+END_TEST
+
+START_TEST(test_filter)
+{
+	PARSE_ARGS("timerlat", "top", "-e", "system:event", "--filter", "filter");
+
+	CLI_ASSERT_SINGLE_FILTER("filter");
+}
+END_TEST
+
+START_TEST(test_trigger)
+{
+	PARSE_ARGS("timerlat", "top", "-e", "system:event", "--trigger", "trigger");
+
+	CLI_ASSERT_SINGLE_TRIGGER("trigger");
+}
+END_TEST
+
+START_TEST(test_trace_short_noarg)
+{
+	PARSE_ARGS("timerlat", "top", "-t");
+
+	CLI_ASSERT_SINGLE_ACTION(threshold_actions, ACTION_TRACE_OUTPUT, trace_output, str,
+				 "timerlat_trace.txt");
+}
+END_TEST
+
+START_TEST(test_trace_short_followarg)
+{
+	PARSE_ARGS("timerlat", "top", "-t", "-d", "20");
+
+	CLI_ASSERT_SINGLE_ACTION(threshold_actions, ACTION_TRACE_OUTPUT, trace_output, str,
+				 "timerlat_trace.txt");
+	ck_assert_int_eq(params->duration, 20); /* check if next argument is read correctly */
+}
+END_TEST
+
+START_TEST(test_trace_short_space)
+{
+	PARSE_ARGS("timerlat", "top", "-t", "tracefile");
+
+	CLI_ASSERT_SINGLE_ACTION(threshold_actions, ACTION_TRACE_OUTPUT, trace_output, str,
+				 "tracefile");
+}
+END_TEST
+
+START_TEST(test_trace_short_equals)
+{
+	PARSE_ARGS("timerlat", "top", "-t=tracefile");
+
+	CLI_ASSERT_SINGLE_ACTION(threshold_actions, ACTION_TRACE_OUTPUT, trace_output, str,
+				 "tracefile");
+}
+END_TEST
+
+START_TEST(test_trace_long_noarg)
+{
+	PARSE_ARGS("timerlat", "top", "--trace");
+
+	CLI_ASSERT_SINGLE_ACTION(threshold_actions, ACTION_TRACE_OUTPUT, trace_output, str,
+				 "timerlat_trace.txt");
+}
+END_TEST
+
+START_TEST(test_trace_long_followarg)
+{
+	PARSE_ARGS("timerlat", "top", "--trace", "-d", "20");
+
+	CLI_ASSERT_SINGLE_ACTION(threshold_actions, ACTION_TRACE_OUTPUT, trace_output, str,
+				 "timerlat_trace.txt");
+	ck_assert_int_eq(params->duration, 20); /* check if next argument is read correctly */
+}
+END_TEST
+
+START_TEST(test_trace_long_space)
+{
+	PARSE_ARGS("timerlat", "top", "--trace", "tracefile");
+
+	CLI_ASSERT_SINGLE_ACTION(threshold_actions, ACTION_TRACE_OUTPUT, trace_output, str,
+				 "tracefile");
+}
+END_TEST
+
+START_TEST(test_trace_long_equals)
+{
+	PARSE_ARGS("timerlat", "top", "--trace=tracefile");
+
+	CLI_ASSERT_SINGLE_ACTION(threshold_actions, ACTION_TRACE_OUTPUT, trace_output, str,
+				 "tracefile");
+}
+END_TEST
+
+/* CPU Configuration */
+
+START_TEST(test_cpus_short)
+{
+	nr_cpus = 4;
+
+	PARSE_ARGS("timerlat", "top", "-c", "0-1,3");
+
+	ck_assert_str_eq(params->cpus, "0-1,3");
+	CLI_ASSERT_CPUSET(monitored_cpus, 0, 1, 3);
+}
+END_TEST
+
+START_TEST(test_cpus_long)
+{
+	nr_cpus = 4;
+
+	PARSE_ARGS("timerlat", "top", "--cpus", "0-1,3");
+
+	ck_assert_str_eq(params->cpus, "0-1,3");
+	CLI_ASSERT_CPUSET(monitored_cpus, 0, 1, 3);
+}
+END_TEST
+
+START_TEST(test_housekeeping_short)
+{
+	nr_cpus = 4;
+
+	PARSE_ARGS("timerlat", "top", "-H", "0-1,3");
+
+	CLI_ASSERT_CPUSET(hk_cpu_set, 0, 1, 3);
+}
+END_TEST
+
+START_TEST(test_housekeeping_long)
+{
+	nr_cpus = 4;
+
+	PARSE_ARGS("timerlat", "top", "--house-keeping", "0-1,3");
+
+	CLI_ASSERT_CPUSET(hk_cpu_set, 0, 1, 3);
+}
+END_TEST
+
+/* Thread Configuration */
+
+START_TEST(test_cgroup_short_noarg)
+{
+	PARSE_ARGS("timerlat", "top", "-C");
+
+	ck_assert(params->cgroup);
+	ck_assert_ptr_null(params->cgroup_name);
+}
+END_TEST
+
+START_TEST(test_cgroup_short_space)
+{
+	PARSE_ARGS("timerlat", "top", "-C", "cgroup");
+
+	ck_assert(params->cgroup);
+	ck_assert_str_eq(params->cgroup_name, "cgroup");
+}
+END_TEST
+
+START_TEST(test_cgroup_short_equals)
+{
+	PARSE_ARGS("timerlat", "top", "-C=cgroup");
+
+	ck_assert(params->cgroup);
+	ck_assert_str_eq(params->cgroup_name, "cgroup");
+}
+END_TEST
+
+START_TEST(test_cgroup_long_noarg)
+{
+	PARSE_ARGS("timerlat", "top", "--cgroup");
+
+	ck_assert(params->cgroup);
+	ck_assert_ptr_null(params->cgroup_name);
+}
+END_TEST
+
+START_TEST(test_cgroup_long_space)
+{
+	PARSE_ARGS("timerlat", "top", "--cgroup", "cgroup");
+
+	ck_assert(params->cgroup);
+	ck_assert_str_eq(params->cgroup_name, "cgroup");
+}
+END_TEST
+
+START_TEST(test_cgroup_long_equals)
+{
+	PARSE_ARGS("timerlat", "top", "--cgroup=cgroup");
+
+	ck_assert(params->cgroup);
+	ck_assert_str_eq(params->cgroup_name, "cgroup");
+}
+END_TEST
+
+START_TEST(test_kernel_threads_short)
+{
+	PARSE_ARGS("timerlat", "top", "-k");
+
+	ck_assert(params->kernel_workload);
+	ck_assert(!params->user_workload);
+	ck_assert(!params->user_data);
+}
+END_TEST
+
+START_TEST(test_kernel_threads_long)
+{
+	PARSE_ARGS("timerlat", "top", "--kernel-threads");
+
+	ck_assert(params->kernel_workload);
+	ck_assert(!params->user_workload);
+	ck_assert(!params->user_data);
+}
+END_TEST
+
+START_TEST(test_priority_short)
+{
+	PARSE_ARGS("timerlat", "top", "-P", "f:95");
+
+	ck_assert_int_eq(params->sched_param.sched_policy, SCHED_FIFO);
+	ck_assert_int_eq(params->sched_param.sched_priority, 95);
+}
+END_TEST
+
+START_TEST(test_priority_long)
+{
+	PARSE_ARGS("timerlat", "top", "--priority", "f:95");
+
+	ck_assert_int_eq(params->sched_param.sched_policy, SCHED_FIFO);
+	ck_assert_int_eq(params->sched_param.sched_priority, 95);
+}
+END_TEST
+
+START_TEST(test_user_load_short)
+{
+	PARSE_ARGS("timerlat", "top", "-U");
+
+	ck_assert(!params->kernel_workload);
+	ck_assert(!params->user_workload);
+	ck_assert(params->user_data);
+}
+END_TEST
+
+START_TEST(test_user_load_long)
+{
+	PARSE_ARGS("timerlat", "top", "--user-load");
+
+	ck_assert(!params->kernel_workload);
+	ck_assert(!params->user_workload);
+	ck_assert(params->user_data);
+}
+END_TEST
+
+START_TEST(test_user_threads_short)
+{
+	PARSE_ARGS("timerlat", "top", "-u");
+
+	ck_assert(!params->kernel_workload);
+	ck_assert(params->user_workload);
+	ck_assert(params->user_data);
+}
+END_TEST
+
+START_TEST(test_user_threads_long)
+{
+	PARSE_ARGS("timerlat", "top", "--user-threads");
+
+	ck_assert(!params->kernel_workload);
+	ck_assert(params->user_workload);
+	ck_assert(params->user_data);
+}
+END_TEST
+
+/* Output */
+
+START_TEST(test_nano_short)
+{
+	PARSE_ARGS("timerlat", "top", "-n");
+
+	ck_assert_int_eq(params->output_divisor, 1);
+}
+END_TEST
+
+START_TEST(test_nano_long)
+{
+	PARSE_ARGS("timerlat", "top", "--nano");
+
+	ck_assert_int_eq(params->output_divisor, 1);
+}
+END_TEST
+
+START_TEST(test_quiet_short)
+{
+	PARSE_ARGS("timerlat", "top", "-q");
+
+	ck_assert(params->quiet);
+}
+END_TEST
+
+START_TEST(test_quiet_long)
+{
+	PARSE_ARGS("timerlat", "top", "--quiet");
+
+	ck_assert(params->quiet);
+}
+END_TEST
+
+/* System Tuning */
+
+START_TEST(test_deepest_idle_state)
+{
+	PARSE_ARGS("timerlat", "top", "--deepest-idle-state", "1");
+
+	ck_assert_int_eq(tlat_params->deepest_idle_state, 1);
+}
+END_TEST
+
+START_TEST(test_dma_latency)
+{
+	PARSE_ARGS("timerlat", "top", "--dma-latency", "10");
+
+	ck_assert_int_eq(tlat_params->dma_latency, 10);
+}
+END_TEST
+
+START_TEST(test_trace_buffer_size)
+{
+	PARSE_ARGS("timerlat", "top", "--trace-buffer-size", "200");
+
+	ck_assert_int_eq(params->buffer_size, 200);
+}
+END_TEST
+
+START_TEST(test_warm_up)
+{
+	PARSE_ARGS("timerlat", "top", "--warm-up", "5");
+
+	ck_assert_int_eq(params->warmup, 5);
+}
+END_TEST
+
+/* Auto Analysis and Actions */
+
+START_TEST(test_auto)
+{
+	PARSE_ARGS("timerlat", "top", "-a", "20");
+
+	CLI_TIMERLAT_ASSERT_AUTO(20);
+}
+END_TEST
+
+START_TEST(test_aa_only)
+{
+	PARSE_ARGS("timerlat", "top", "--aa-only", "20");
+
+	CLI_TIMERLAT_ASSERT_AA_ONLY(20);
+}
+END_TEST
+
+START_TEST(test_bpf_action)
+{
+	PARSE_ARGS("timerlat", "top", "--bpf-action", "program");
+
+	ck_assert_str_eq(tlat_params->bpf_action_program, "program");
+}
+END_TEST
+
+START_TEST(test_dump_tasks)
+{
+	PARSE_ARGS("timerlat", "top", "--dump-tasks");
+
+	ck_assert(tlat_params->dump_tasks);
+}
+END_TEST
+
+START_TEST(test_no_aa)
+{
+	PARSE_ARGS("timerlat", "top", "--no-aa");
+
+	ck_assert(tlat_params->no_aa);
+}
+END_TEST
+
+START_TEST(test_on_end)
+{
+	PARSE_ARGS("timerlat", "top", "--on-end", "trace");
+
+	CLI_ASSERT_SINGLE_ACTION(end_actions, ACTION_TRACE_OUTPUT, trace_output, str,
+				 "timerlat_trace.txt");
+}
+END_TEST
+
+START_TEST(test_on_threshold)
+{
+	PARSE_ARGS("timerlat", "top", "--on-threshold", "trace");
+
+	CLI_ASSERT_SINGLE_ACTION(threshold_actions, ACTION_TRACE_OUTPUT, trace_output, str,
+				 "timerlat_trace.txt");
+}
+END_TEST
+
+START_TEST(test_stack_format)
+{
+	PARSE_ARGS("timerlat", "top", "--stack-format", "truncate");
+
+	ck_assert_int_eq(tlat_params->stack_format, STACK_FORMAT_TRUNCATE);
+}
+END_TEST
+
+/* General */
+
+START_TEST(test_debug_short)
+{
+	PARSE_ARGS("timerlat", "top", "-D");
+
+	ck_assert(config_debug);
+}
+END_TEST
+
+START_TEST(test_debug_long)
+{
+	PARSE_ARGS("timerlat", "top", "--debug");
+
+	ck_assert(config_debug);
+}
+END_TEST
+
+START_TEST(test_duration_short)
+{
+	PARSE_ARGS("timerlat", "top", "-d", "1m");
+
+	ck_assert_int_eq(params->duration, 60);
+}
+END_TEST
+
+START_TEST(test_duration_long)
+{
+	PARSE_ARGS("timerlat", "top", "--duration", "1m");
+
+	ck_assert_int_eq(params->duration, 60);
+}
+END_TEST
+
+Suite *timerlat_top_cli_suite(void)
+{
+	Suite *s = suite_create("timerlat_top_cli");
+	TCase *tc;
+
+	tc = tcase_create("tracing_options");
+	tcase_add_test(tc, test_irq_short);
+	tcase_add_test(tc, test_irq_long);
+	tcase_add_test(tc, test_period_short);
+	tcase_add_test(tc, test_period_long);
+	tcase_add_test(tc, test_stack_short);
+	tcase_add_test(tc, test_stack_long);
+	tcase_add_test(tc, test_thread_short);
+	tcase_add_test(tc, test_thread_long);
+	tcase_add_test(tc, test_trace_short_noarg);
+	tcase_add_test(tc, test_trace_short_followarg);
+	tcase_add_test(tc, test_trace_short_space);
+	tcase_add_test(tc, test_trace_short_equals);
+	tcase_add_test(tc, test_trace_long_noarg);
+	tcase_add_test(tc, test_trace_long_followarg);
+	tcase_add_test(tc, test_trace_long_space);
+	tcase_add_test(tc, test_trace_long_equals);
+	suite_add_tcase(s, tc);
+
+	tc = tcase_create("event_configuration");
+	tcase_add_test(tc, test_event_short);
+	tcase_add_test(tc, test_event_long);
+	tcase_add_test(tc, test_filter);
+	tcase_add_test(tc, test_trigger);
+	suite_add_tcase(s, tc);
+
+	tc = tcase_create("cpu_configuration");
+	tcase_add_test(tc, test_cpus_short);
+	tcase_add_test(tc, test_cpus_long);
+	tcase_add_test(tc, test_housekeeping_short);
+	tcase_add_test(tc, test_housekeeping_long);
+	suite_add_tcase(s, tc);
+
+	tc = tcase_create("thread_configuration");
+	tcase_add_test(tc, test_cgroup_short_noarg);
+	tcase_add_test(tc, test_cgroup_short_space);
+	tcase_add_test(tc, test_cgroup_short_equals);
+	tcase_add_test(tc, test_cgroup_long_noarg);
+	tcase_add_test(tc, test_cgroup_long_space);
+	tcase_add_test(tc, test_cgroup_long_equals);
+	tcase_add_test(tc, test_kernel_threads_short);
+	tcase_add_test(tc, test_kernel_threads_long);
+	tcase_add_test(tc, test_priority_short);
+	tcase_add_test(tc, test_priority_long);
+	tcase_add_test(tc, test_user_load_short);
+	tcase_add_test(tc, test_user_load_long);
+	tcase_add_test(tc, test_user_threads_short);
+	tcase_add_test(tc, test_user_threads_long);
+	suite_add_tcase(s, tc);
+
+	tc = tcase_create("output");
+	tcase_add_test(tc, test_nano_short);
+	tcase_add_test(tc, test_nano_long);
+	tcase_add_test(tc, test_quiet_short);
+	tcase_add_test(tc, test_quiet_long);
+	suite_add_tcase(s, tc);
+
+	tc = tcase_create("system_tuning");
+	tcase_add_test(tc, test_deepest_idle_state);
+	tcase_add_test(tc, test_dma_latency);
+	tcase_add_test(tc, test_trace_buffer_size);
+	tcase_add_test(tc, test_warm_up);
+	suite_add_tcase(s, tc);
+
+	tc = tcase_create("aa_actions");
+	tcase_add_test(tc, test_auto);
+	tcase_add_test(tc, test_aa_only);
+	tcase_add_test(tc, test_bpf_action);
+	tcase_add_test(tc, test_dump_tasks);
+	tcase_add_test(tc, test_no_aa);
+	tcase_add_test(tc, test_on_end);
+	tcase_add_test(tc, test_on_threshold);
+	tcase_add_test(tc, test_stack_format);
+	suite_add_tcase(s, tc);
+
+	tc = tcase_create("general");
+	tcase_add_test(tc, test_debug_short);
+	tcase_add_test(tc, test_debug_long);
+	tcase_add_test(tc, test_duration_short);
+	tcase_add_test(tc, test_duration_long);
+	suite_add_tcase(s, tc);
+
+	return s;
+}
diff --git a/tools/tracing/rtla/tests/unit/unit_tests.c b/tools/tracing/rtla/tests/unit/unit_tests.c
index f87d761f9b12..64884f6cbdeb 100644
--- a/tools/tracing/rtla/tests/unit/unit_tests.c
+++ b/tools/tracing/rtla/tests/unit/unit_tests.c
@@ -5,17 +5,28 @@
 #include <stdbool.h>
 
 #include "../../src/utils.h"
+#include "../../src/cli.h"
 
 Suite *utils_suite(void);
 Suite *actions_suite(void);
+Suite *osnoise_top_cli_suite(void);
+Suite *osnoise_hist_cli_suite(void);
+Suite *timerlat_top_cli_suite(void);
+Suite *timerlat_hist_cli_suite(void);
 
 int main(int argc, char *argv[])
 {
 	int num_failed;
 	SRunner *sr;
 
+	in_unit_test = true;
+
 	sr = srunner_create(utils_suite());
 	srunner_add_suite(sr, actions_suite());
+	srunner_add_suite(sr, osnoise_top_cli_suite());
+	srunner_add_suite(sr, osnoise_hist_cli_suite());
+	srunner_add_suite(sr, timerlat_top_cli_suite());
+	srunner_add_suite(sr, timerlat_hist_cli_suite());
 
 	srunner_run_all(sr, CK_VERBOSE);
 	num_failed = srunner_ntests_failed(sr);
-- 
2.54.0

