Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957EC2E400;
	Thu,  8 Aug 2024 04:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723092596; cv=none; b=GeymqBjVkXYrXHlcsSFEYjMB/qneFX038vqO3Ws7Z3rQ19Lq7ARWDFmmw83FevPwtB9ODfkNu8J2OEE5//QI1/HmVTsyW+5s/KOKRgm86yD2X6wYr/HYHQONt/0VWQp0W1o8g6ZaaplW4dAzVH3jdTew8lGbDy9jFrqwTrlgeu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723092596; c=relaxed/simple;
	bh=O+vnFHy5XvcbxYXq88CWEnm0lAC3QOOB4d3H/ZTGUvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UQP3txW69nHTgZsHwmTOlyWZkU2hVTh9Wv5FuHRwtf6AS9W0/TADShF0G2V7vSpGhc94UP7BAm7MTo1S/uwmJ3JJTqCmmNeIVbYv2LvQT2a37OX/XlnOOlT3YvdgJR6w7mp7gdFnHf0jrRTvJ/WbgFs2hQefJ2tsbQiYeGtmg0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+9zquKl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+9zquKl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3268C32782;
	Thu,  8 Aug 2024 04:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723092596;
	bh=O+vnFHy5XvcbxYXq88CWEnm0lAC3QOOB4d3H/ZTGUvQ=;
	h=From:To:Cc:Subject:Date:From;
	b=R+9zquKlwpyaOwrsPmyICBbW5BMNZ+8Iw6V2HlTJJs3AOoQ2gGc8cAJKOX05ADNA4
	 JfADQE/YS9MbJ4RjCDSbsKyA4twApYBxEv028KzI5/TJXUH6a68RZiI6NsIOw0X00c
	 r9BxvgDIEgQd3+/DjOc07/nhW2tC8uEeodLp3TwWIIFgeXH5jWQ9U9T1QrtB7wr3Ld
	 iQqeaVrjstDjT8BDGKLwaecHAWRLNC95Y6n0FDsf3O/nG1mNxFhXkgG37ReUFVibRb
	 gpjTGAWw8pFHIK1AIOCFfiVlowb32bF1z2houNOs0Tz9p2SxT9GYz9WHlLIkF0338h
	 ZVxxUR6ttMbYQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] perf test: Add a new shell test for perf ftrace
Date: Wed,  7 Aug 2024 21:49:54 -0700
Message-ID: <20240808044954.1775333-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

  $ sudo ./perf test ftrace -vv
   86: perf ftrace tests:
  --- start ---
  test child forked, pid 1772223
  perf ftrace list test
  syscalls for sleep:
  __x64_sys_nanosleep
  __ia32_sys_nanosleep
  __x64_sys_clock_nanosleep
  __ia32_sys_clock_nanosleep
  perf ftrace list test  [Success]
  perf ftrace trace test
  # tracer: function_graph
  #
  # CPU  DURATION                  FUNCTION CALLS
  # |     |   |                     |   |   |   |
   0)               |  __x64_sys_clock_nanosleep() {
   0)               |    common_nsleep() {
   0)               |      hrtimer_nanosleep() {
   0)               |        do_nanosleep() {
  perf ftrace trace test  [Success]
  perf ftrace latency test
  target function: __x64_sys_clock_nanosleep
  #   DURATION     |      COUNT | GRAPH                                          |
      32 - 64   ms |          1 | ############################################## |
  perf ftrace latency test  [Success]
  perf ftrace profile test
  # Total (us)   Avg (us)   Max (us)      Count   Function
    100136.400 100136.400 100136.400          1   __x64_sys_clock_nanosleep
    100135.200 100135.200 100135.200          1   common_nsleep
    100134.700 100134.700 100134.700          1   hrtimer_nanosleep
    100133.700 100133.700 100133.700          1   do_nanosleep
    100130.600 100130.600 100130.600          1   schedule
       166.868     55.623     80.299          3   scheduler_tick
         5.926      5.926      5.926          1   native_smp_send_reschedule
       301.941    301.941    301.941          1   __x64_sys_execve
       295.786    295.786    295.786          1   do_execveat_common.isra.0
        71.397     35.699     46.403          2   bprm_execve
         2.519      1.260      1.547          2   sched_mm_cid_before_execve
         1.098      0.549      0.686          2   sched_mm_cid_after_execve
  perf ftrace profile test  [Success]
  ---- end(0) ----
   86: perf ftrace tests                                               : Ok

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/ftrace.sh | 84 ++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100755 tools/perf/tests/shell/ftrace.sh

diff --git a/tools/perf/tests/shell/ftrace.sh b/tools/perf/tests/shell/ftrace.sh
new file mode 100755
index 000000000000..b1c36d30559a
--- /dev/null
+++ b/tools/perf/tests/shell/ftrace.sh
@@ -0,0 +1,84 @@
+#!/bin/sh
+# perf ftrace tests
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+# perf ftrace commands only works for root
+if [ "$(id -u)" != 0 ]; then
+    echo "perf ftrace test  [Skipped: no permission]"
+    exit 2
+fi
+
+output=$(mktemp /tmp/__perf_test.ftrace.XXXXXX)
+
+cleanup() {
+  rm -f "${output}"
+
+  trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+  cleanup
+  exit 1
+}
+trap trap_cleanup EXIT TERM INT
+
+# this will be set in test_ftrace_trace()
+target_function=
+
+test_ftrace_list() {
+    echo "perf ftrace list test"
+    perf ftrace -F > "${output}"
+    # this will be used in test_ftrace_trace()
+    sleep_functions=$(grep 'sys_.*sleep$' "${output}")
+    echo "syscalls for sleep:"
+    echo "${sleep_functions}"
+    echo "perf ftrace list test  [Success]"
+}
+
+test_ftrace_trace() {
+    echo "perf ftrace trace test"
+    perf ftrace trace --graph-opts depth=5 sleep 0.1 > "${output}"
+    # it should have some function name contains 'sleep'
+    grep "^#" "${output}"
+    grep -F 'sleep()' "${output}"
+    # find actual syscall function name
+    for FN in ${sleep_functions}; do
+	if grep -q "${FN}" "${output}"; then
+	    target_function="${FN}"
+	    echo "perf ftrace trace test  [Success]"
+	    return
+	fi
+    done
+
+    echo "perf ftrace trace test  [Failure: sleep syscall not found]"
+    exit 1
+}
+
+test_ftrace_latency() {
+    echo "perf ftrace latency test"
+    echo "target function: ${target_function}"
+    perf ftrace latency -T "${target_function}" sleep 0.1 > "${output}"
+    grep "^#" "${output}"
+    grep "###" "${output}"
+    echo "perf ftrace latency test  [Success]"
+}
+
+test_ftrace_profile() {
+    echo "perf ftrace profile test"
+    perf ftrace profile sleep 0.1 > "${output}"
+    grep ^# "${output}"
+    grep sleep "${output}"
+    grep schedule "${output}"
+    grep execve "${output}"
+    echo "perf ftrace profile test  [Success]"
+}
+
+test_ftrace_list
+test_ftrace_trace
+test_ftrace_latency
+test_ftrace_profile
+
+cleanup
+exit 0
-- 
2.46.0.rc2.264.g509ed76dc8-goog

