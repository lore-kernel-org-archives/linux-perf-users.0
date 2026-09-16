Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DB63EC815
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 06:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541591; cv=none; b=rA/Zi9UaYwKifeCu+UTqmG+6J4oPKLxSspUUnkP1KmVG0OI18I27vUQMe1pe5YT4w2RLnG5vPsGcSsUgfyoP/4GP+H+9EMukGI9VewKGHj0IaRFdGcZVE8PPpMMagWHLAPjOJcKGLk0FJldVuWolbNU1+MgRCuFYjeX1gguBPSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541591; c=relaxed/simple;
	bh=MnfriMbE6Pyf9x4mcx9SZSv1OoeUtUoRh6muJaAxPLY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xt/KNnzkR80YB2XjH/r35aSHl7cJ9hCAPavOf/FaA82ymK+7d3VH2Wk33VLo+qqtH/j0vmH+6Y6a4R+++FrBZHl0SDw7aiUNGQrjFxDu8uBkb4+caU+UJ2uMf5qbuIU4jTcPRzTTuYYiecFFHWOQsncS6pM7kerBRKxFDZ8VABM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kaCJ8dfR; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kaCJ8dfR"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cbee6bb8408so6459049a12.3
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 23:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789541589; x=1790146389; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jOVbLGMCvCpN51+CLDC7/0/G7Gf4edygheAcdqNnU5E=;
        b=kaCJ8dfRe2YZfmdNgRwXfSxGKrOKCFiGd0qwZLsWmFPBkn3gWK1cYUXXAeN5UwZ0SR
         cmFEx1kqyhdSjXDZgO4kbV8Z1LzYTHaIgAc+y2w3Vfb6mUUCYxa1HrC8zHuavlWon7Id
         CwKbpxv4d5PbVQFCYtoUuqt87GlKUdD7A35yykHkEh3ZTERZVZgbpa79ZSsxkHyJZ/XV
         myggikAtsih74fQsWRlKhDHOv96CDWnX8xJcb9IyvnY7vuecf6SstS7Z1CLngJ+KWH1V
         dFEmEowkabcNi4r7mhY/La3nSdDVxaDEBzaBeg5lu1VjotPSGR5kg0laXR7G1NtWsceU
         m/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789541589; x=1790146389;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jOVbLGMCvCpN51+CLDC7/0/G7Gf4edygheAcdqNnU5E=;
        b=uA3Rfi0rK4RYUahQoJtVqvAqFDyQ/zrv5pDqEkFWIyMU1sg1YIKmsozg68TGIwk0Ii
         SAcp2pc/1H8AYcoDqSeDVjxCz4DV+w02a76ZOZMqTzE2Hqc4y4IesKZ8WOvVcY01n376
         sfihoa0tvJvmIw/uEviH1yI1+cwlxZb1bWZVOYRMPvEJp1TFMIlpb6DiK0pE2fp1VpJk
         hAp/h1jMMl4hplw4hWWqTiuJxcgjoOujEqDw7baUqIQ5qEQafg/93kVKsEZq6kUl4q7y
         upkWwhqoTJXTkdfW0db/mOjyiZGq6felDgTsu1echIhveAVZ65N8VrUgYU7iravmvzmE
         c9cA==
X-Gm-Message-State: AFuF++lRVs6BPJaGowGiqP1zUGrBcbHSo3pVYFek/8kCnUQ36FbITDEy
	e1dv5MMitXnYXEY7mDqb5oKJ0MBlltFE6CnjRApHzATWKktXgRoeUegi5Pges/oNQOvuPYQ+9ZP
	N8mm2XEgNgA==
X-Received: from dlah18.prod.google.com ([2002:a05:701b:2612:b0:143:7746:f4a7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1c04:b0:39e:d2a:e25a
 with SMTP id 98e67ed59e1d1-39e1e45f28cmr3440108a91.13.1789541588845; Tue, 15
 Sep 2026 23:53:08 -0700 (PDT)
Date: Tue, 15 Sep 2026 23:52:47 -0700
In-Reply-To: <20260916065248.3153556-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916065248.3153556-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260916065248.3153556-9-irogers@google.com>
Subject: [PATCH v2 8/9] perf test: Expand tests for --hybrid-merge
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, ak@kernel.org, ak@linux.intel.com, 
	andi@firstfloor.org, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a "Hybrid event merging" test that checks evlist__can_merge_hybrid()
and evlist__merge_hybrid() directly, covering the events a wildcard
expanded to over two core PMUs, the same over three, and events that
must not be merged.

Add a report_hybrid_merge.sh shell test that records and then reports
with --hybrid-merge, and extend top.sh to cover perf top with it.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.1-pro
---
 tools/perf/tests/Build                        |   1 +
 tools/perf/tests/builtin-test.c               |   1 +
 tools/perf/tests/hybrid-merge.c               | 206 ++++++++++++++++++
 tools/perf/tests/shell/report_hybrid_merge.sh | 121 ++++++++++
 tools/perf/tests/shell/top.sh                 |  73 ++++++-
 tools/perf/tests/tests.h                      |   1 +
 6 files changed, 392 insertions(+), 11 deletions(-)
 create mode 100644 tools/perf/tests/hybrid-merge.c
 create mode 100755 tools/perf/tests/shell/report_hybrid_merge.sh

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 66944a4f4968..406e48eed1c8 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -65,6 +65,7 @@ perf-test-y += perf-time-to-tsc.o
 perf-test-y += dlfilter-test.o
 perf-test-y += sigtrap.o
 perf-test-y += event_groups.o
+perf-test-y += hybrid-merge.o
 perf-test-y += symbols.o
 perf-test-y += util.o
 perf-test-y += hwmon_pmu.o
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 4d0784b16723..6293b37266cf 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -149,6 +149,7 @@ static struct test_suite *generic_tests[] = {
 	&suite__dlfilter,
 	&suite__sigtrap,
 	&suite__event_groups,
+	&suite__hybrid_merge,
 	&suite__symbols,
 	&suite__util,
 	&suite__subcmd_help,
diff --git a/tools/perf/tests/hybrid-merge.c b/tools/perf/tests/hybrid-merge.c
new file mode 100644
index 000000000000..426b1d09618e
--- /dev/null
+++ b/tools/perf/tests/hybrid-merge.c
@@ -0,0 +1,206 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdlib.h>
+#include <string.h>
+#include <linux/perf_event.h>
+#include "debug.h"
+#include "env.h"
+#include "evlist.h"
+#include "evsel.h"
+#include "tests.h"
+
+/* A hybrid machine with 2 core PMUs, as read from a perf.data file. */
+static struct hybrid_node two_core_pmus[] = {
+	{ .pmu_name = (char *)"cpu_atom", .cpus = (char *)"0-3", },
+	{ .pmu_name = (char *)"cpu_core", .cpus = (char *)"4-7", },
+};
+
+/* A machine with more than 2 kinds of core, like some Arm big.LITTLE. */
+static struct hybrid_node three_core_pmus[] = {
+	{ .pmu_name = (char *)"cpu_atom", .cpus = (char *)"0-3", },
+	{ .pmu_name = (char *)"cpu_core", .cpus = (char *)"4-7", },
+	{ .pmu_name = (char *)"cpu_lowpower", .cpus = (char *)"8", },
+};
+
+static struct evsel *test_evsel__new(struct evlist *evlist, const char *name)
+{
+	struct perf_event_attr attr = {
+		.type = PERF_TYPE_RAW,
+		.size = sizeof(attr),
+		.config = 0x3c,
+	};
+	struct evsel *evsel = evsel__new(&attr);
+
+	if (!evsel)
+		return NULL;
+
+	evsel->name = strdup(name);
+	if (!evsel->name) {
+		evsel__put(evsel);
+		return NULL;
+	}
+	evlist__add(evlist, evsel);
+	return evsel;
+}
+
+/*
+ * The assertions are in helpers taking an already allocated evlist, so that the
+ * caller can release the evlist however an assertion fails.
+ */
+static int check_merge_events(struct evlist *evlist, struct perf_env *env)
+{
+	struct evsel *atom_cycles, *core_cycles, *atom_insns, *core_insns, *pos;
+
+	/* As if "perf record -e cycles,instructions" ran on a hybrid machine. */
+	atom_cycles = test_evsel__new(evlist, "cpu_atom/cycles/");
+	core_cycles = test_evsel__new(evlist, "cpu_core/cycles/");
+	atom_insns = test_evsel__new(evlist, "cpu_atom/instructions/");
+	core_insns = test_evsel__new(evlist, "cpu_core/instructions/");
+	TEST_ASSERT_VAL("failed to allocate evsels",
+			atom_cycles && core_cycles && atom_insns && core_insns);
+
+	TEST_ASSERT_VAL("events should be mergeable",
+			evlist__can_merge_hybrid(evlist, env));
+
+	/* Testing for merging must not alter the evlist. */
+	evlist__for_each_entry(evlist, pos) {
+		TEST_ASSERT_VAL("evlist modified by evlist__can_merge_hybrid",
+				!pos->first_wildcard_match);
+	}
+
+	evlist__merge_hybrid(evlist, env);
+
+	TEST_ASSERT_VAL("cycles not merged",
+			core_cycles->first_wildcard_match == atom_cycles);
+	/* All the events must be merged, not just the first pair found. */
+	TEST_ASSERT_VAL("instructions not merged",
+			core_insns->first_wildcard_match == atom_insns);
+	TEST_ASSERT_VAL("wrong cycles leader",
+			evsel__leader(core_cycles) == atom_cycles);
+	TEST_ASSERT_VAL("wrong instructions leader",
+			evsel__leader(core_insns) == atom_insns);
+	TEST_ASSERT_VAL("wrong cycles group size", atom_cycles->core.nr_members == 2);
+	TEST_ASSERT_VAL("wrong instructions group size", atom_insns->core.nr_members == 2);
+
+	return TEST_OK;
+}
+
+static int test__hybrid_merge_events(struct test_suite *test __maybe_unused,
+				     int subtest __maybe_unused)
+{
+	struct perf_env env = {
+		.nr_hybrid_nodes = ARRAY_SIZE(two_core_pmus),
+		.hybrid_nodes = two_core_pmus,
+	};
+	struct evlist *evlist = evlist__new();
+	int ret;
+
+	TEST_ASSERT_VAL("failed to allocate evlist", evlist);
+
+	ret = check_merge_events(evlist, &env);
+	evlist__put(evlist);
+	return ret;
+}
+
+static int check_merge_3_core_pmus(struct evlist *evlist, struct perf_env *env)
+{
+	struct evsel *atom_cycles, *core_cycles, *lowpower_cycles;
+
+	atom_cycles = test_evsel__new(evlist, "cpu_atom/cycles/");
+	core_cycles = test_evsel__new(evlist, "cpu_core/cycles/");
+	lowpower_cycles = test_evsel__new(evlist, "cpu_lowpower/cycles/");
+	TEST_ASSERT_VAL("failed to allocate evsels",
+			atom_cycles && core_cycles && lowpower_cycles);
+
+	evlist__merge_hybrid(evlist, env);
+
+	TEST_ASSERT_VAL("second core PMU not merged",
+			core_cycles->first_wildcard_match == atom_cycles);
+	TEST_ASSERT_VAL("third core PMU not merged",
+			lowpower_cycles->first_wildcard_match == atom_cycles);
+	TEST_ASSERT_VAL("wrong group size", atom_cycles->core.nr_members == 3);
+
+	return TEST_OK;
+}
+
+static int test__hybrid_merge_3_core_pmus(struct test_suite *test __maybe_unused,
+					  int subtest __maybe_unused)
+{
+	struct perf_env env = {
+		.nr_hybrid_nodes = ARRAY_SIZE(three_core_pmus),
+		.hybrid_nodes = three_core_pmus,
+	};
+	struct evlist *evlist = evlist__new();
+	int ret;
+
+	TEST_ASSERT_VAL("failed to allocate evlist", evlist);
+
+	ret = check_merge_3_core_pmus(evlist, &env);
+	evlist__put(evlist);
+	return ret;
+}
+
+static int check_unmergeable_core_events(struct evlist *evlist, struct perf_env *env)
+{
+	/* A single event has nothing to merge with. */
+	TEST_ASSERT_VAL("failed to allocate evsel",
+			test_evsel__new(evlist, "cpu_core/cycles/"));
+	TEST_ASSERT_VAL("a single event shouldn't merge",
+			!evlist__can_merge_hybrid(evlist, env));
+
+	/* Events of different names shouldn't merge. */
+	TEST_ASSERT_VAL("failed to allocate evsel",
+			test_evsel__new(evlist, "cpu_atom/instructions/"));
+	TEST_ASSERT_VAL("events with different names shouldn't merge",
+			!evlist__can_merge_hybrid(evlist, env));
+
+	return TEST_OK;
+}
+
+static int check_unmergeable_uncore_events(struct evlist *evlist, struct perf_env *env)
+{
+	/* Matching events on non-core PMUs shouldn't merge. */
+	TEST_ASSERT_VAL("failed to allocate evsels",
+			test_evsel__new(evlist, "uncore_imc_0/clockticks/") &&
+			test_evsel__new(evlist, "uncore_imc_1/clockticks/"));
+	TEST_ASSERT_VAL("uncore events shouldn't merge",
+			!evlist__can_merge_hybrid(evlist, env));
+
+	return TEST_OK;
+}
+
+static int test__hybrid_merge_unmergeable(struct test_suite *test __maybe_unused,
+					  int subtest __maybe_unused)
+{
+	struct perf_env env = {
+		.nr_hybrid_nodes = ARRAY_SIZE(two_core_pmus),
+		.hybrid_nodes = two_core_pmus,
+	};
+	struct evlist *evlist = evlist__new();
+	int ret;
+
+	TEST_ASSERT_VAL("failed to allocate evlist", evlist);
+
+	ret = check_unmergeable_core_events(evlist, &env);
+	evlist__put(evlist);
+	if (ret != TEST_OK)
+		return ret;
+
+	evlist = evlist__new();
+	TEST_ASSERT_VAL("failed to allocate evlist", evlist);
+
+	ret = check_unmergeable_uncore_events(evlist, &env);
+	evlist__put(evlist);
+	return ret;
+}
+
+static struct test_case tests__hybrid_merge[] = {
+	TEST_CASE("Merge events of 2 core PMUs", hybrid_merge_events),
+	TEST_CASE("Merge events of 3 core PMUs", hybrid_merge_3_core_pmus),
+	TEST_CASE("Events that shouldn't merge", hybrid_merge_unmergeable),
+	{	.name = NULL, }
+};
+
+struct test_suite suite__hybrid_merge = {
+	.desc = "Hybrid event merging",
+	.test_cases = tests__hybrid_merge,
+};
diff --git a/tools/perf/tests/shell/report_hybrid_merge.sh b/tools/perf/tests/shell/report_hybrid_merge.sh
new file mode 100755
index 000000000000..aca5d16c6c9d
--- /dev/null
+++ b/tools/perf/tests/shell/report_hybrid_merge.sh
@@ -0,0 +1,121 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# perf report hybrid merge tests
+
+set -e
+
+err=0
+log_dir=$(mktemp -d /tmp/__perf_test.report_hybrid_merge.XXXXXX)
+perf_data="${log_dir}/perf.data"
+perf_out="${log_dir}/perf.out"
+perf_config="${log_dir}/perfconfig"
+
+cleanup() {
+	rm -rf "${log_dir}"
+	trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+	echo "Unexpected signal in ${FUNCNAME[1]}"
+	cleanup
+	exit 1
+}
+trap trap_cleanup EXIT TERM INT
+
+# Record 2 events so that all the events of a hybrid machine must be merged,
+# not just the first pair found.
+events=""
+record_events() {
+	for try in "cycles,instructions" "cpu-clock,task-clock"; do
+		if perf record -o "${perf_data}" -e "${try}" -- \
+		   perf test -w thloop 1 >/dev/null 2>&1; then
+			events="${try//,/ }"
+			return 0
+		fi
+	done
+	return 1
+}
+
+test_hybrid_merge_report() {
+	echo "Perf report hybrid merge test"
+
+	# Test with multiple fields to ensure formatting alignment doesn't hide members
+	if ! perf report -i "${perf_data}" --hybrid-merge \
+			 -F comm,overhead --stdio > "${perf_out}" 2>&1; then
+		echo "Perf report hybrid merge test [Failed: run err]"
+		err=1
+		return
+	fi
+
+	# Check if the output actually contains the 'comm' and 'overhead' headers correctly
+	if ! grep -qi "Overhead" "${perf_out}"; then
+		echo "Perf report hybrid merge test [Failed: missing overhead header]"
+		err=1
+		return
+	fi
+
+	if ! grep -qi "Command" "${perf_out}"; then
+		echo "Perf report hybrid merge test [Failed: missing comm header]"
+		err=1
+		return
+	fi
+
+	# Every recorded event must be displayed, merged into a group on a
+	# hybrid machine and separately elsewhere.
+	if ! perf report -i "${perf_data}" --hybrid-merge --stdio \
+			 > "${perf_out}" 2>&1; then
+		echo "Perf report hybrid merge test [Failed: run err]"
+		err=1
+		return
+	fi
+	for event in ${events}; do
+		if ! grep -q -- "${event}" "${perf_out}"; then
+			echo "Perf report hybrid merge test [Failed: missing event ${event}]"
+			cat "${perf_out}"
+			err=1
+			return
+		fi
+	done
+
+	echo "Perf report hybrid merge test [Success]"
+}
+
+test_hybrid_merge_config() {
+	echo "Perf report hybrid merge config test"
+
+	cat <<EOF > "${perf_config}"
+[core]
+	hybrid-merge = true
+EOF
+
+	# Merging from the config file is a default, it must give way to an
+	# explicitly requested --hierarchy rather than failing.
+	if ! PERF_CONFIG="${perf_config}" perf report -i "${perf_data}" \
+	     --hierarchy --stdio > "${perf_out}" 2>&1; then
+		echo "Perf report hybrid merge config test [Failed: --hierarchy]"
+		cat "${perf_out}"
+		err=1
+		return
+	fi
+
+	# Asking for both on the command line remains an error.
+	if PERF_CONFIG="${perf_config}" perf report -i "${perf_data}" \
+	   --hierarchy --hybrid-merge --stdio > "${perf_out}" 2>&1; then
+		echo "Perf report hybrid merge config test [Failed: no error for both]"
+		err=1
+		return
+	fi
+
+	echo "Perf report hybrid merge config test [Success]"
+}
+
+if ! record_events; then
+	echo "Perf report hybrid merge test [Skipped: perf record failed]"
+	cleanup
+	exit 2
+fi
+
+test_hybrid_merge_report
+test_hybrid_merge_config
+cleanup
+exit $err
diff --git a/tools/perf/tests/shell/top.sh b/tools/perf/tests/shell/top.sh
index ad7fccd09025..3d52677ccb5f 100755
--- a/tools/perf/tests/shell/top.sh
+++ b/tools/perf/tests/shell/top.sh
@@ -35,21 +35,22 @@ test_basic_perf_top() {
 	# Use -d 1 to avoid flooding output
 	# Use -e cpu-clock to ensure we get samples
 	# Use sleep to keep stdin open but silent, preventing EOF loop or interactive spam
-	if ! sleep 10 | timeout 5s perf top --stdio -d 1 -e cpu-clock -p $PID > "${log_file}" 2>&1; then
-		retval=$?
-		if [ $retval -ne 124 ] && [ $retval -ne 0 ]; then
-			echo "Basic perf top test [Failed: perf top failed to start or run (ret=$retval)]"
-			head -n 50 "${log_file}"
-			kill $PID
-			wait $PID 2>/dev/null || true
-			err=1
-			return
-		fi
+	retval=0
+	sleep 10 | timeout 5s perf top --stdio -d 1 -e cpu-clock \
+		-p $PID > "${log_file}" 2>&1 || retval=$?
+	if [ "${retval:-0}" -ne 124 ] && [ "${retval:-0}" -ne 0 ]; then
+		echo "Basic perf top test [Failed: perf top failed to start or run (ret=$retval)]"
+		head -n 50 "${log_file}"
+		kill $PID 2>/dev/null || true
+		wait $PID 2>/dev/null || true
+		err=1
+		return
 	fi
 
-	kill $PID
+	kill $PID 2>/dev/null || true
 	wait $PID 2>/dev/null || true
 
+
 	# Check for some sample data (percentage)
 	if ! grep -E -q "[0-9]+\.[0-9]+%" "${log_file}"; then
 		echo "Basic perf top test [Failed: no sample percentage found]"
@@ -69,6 +70,56 @@ test_basic_perf_top() {
 	echo "Basic perf top test [Success]"
 }
 
+test_hybrid_merge_perf_top() {
+	echo "Perf top hybrid merge test"
+
+	perf test -w thloop 20 &
+	PID=$!
+
+	# Allow it to start
+	sleep 0.1
+
+	# Run without explicitly requesting -e cycles so heavily virtualized
+	# environments can seamlessly fall back to cpu-clock while real
+	# hybrid hardware will naturally cover the merge logic.
+	retval=0
+	sleep 10 | timeout 5s perf top \
+			--stdio --hybrid-merge -d 1 -p $PID > "${log_file}" 2>&1 || retval=$?
+	if [ "${retval:-0}" -ne 124 ] && [ "${retval:-0}" -ne 0 ]; then
+		echo "Perf top hybrid merge test [Failed: run err=$retval]"
+		head -n 50 "${log_file}"
+		kill $PID 2>/dev/null || true
+		wait $PID 2>/dev/null || true
+		err=1
+		return
+	fi
+
+	kill $PID 2>/dev/null || true
+	wait $PID 2>/dev/null || true
+
+	# Wait a tiny bit for the file system to catch up on the logs
+	sleep 0.1
+
+	# Check for some sample data (percentage)
+	if ! grep -E -q "[0-9]+\.[0-9]+%" "${log_file}"; then
+		echo "Perf top hybrid merge test [Failed: no sample percentage found]"
+		head -n 50 "${log_file}"
+		err=1
+		return
+	fi
+
+	# Check for the test loop symbol to ensure attribution worked
+	if ! grep -q "test_loop" "${log_file}"; then
+		echo "Perf top hybrid merge test [Failed: test_loop symbol not found]"
+		head -n 50 "${log_file}"
+		err=1
+		return
+	fi
+
+	echo "Perf top hybrid merge test [Success]"
+}
+
 test_basic_perf_top
+test_hybrid_merge_perf_top
 cleanup
 exit $err
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index cee9e6b62dcc..9c96f33483d1 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -177,6 +177,7 @@ DECLARE_SUITE(perf_time_to_tsc);
 DECLARE_SUITE(dlfilter);
 DECLARE_SUITE(sigtrap);
 DECLARE_SUITE(event_groups);
+DECLARE_SUITE(hybrid_merge);
 DECLARE_SUITE(symbols);
 DECLARE_SUITE(util);
 DECLARE_SUITE(uncore_event_sorting);
-- 
2.55.0.1032.g73a4cd73de-goog

