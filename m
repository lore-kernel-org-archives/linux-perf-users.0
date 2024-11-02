Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A31158DC4;
	Sat,  2 Nov 2024 23:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730589423; cv=none; b=DWqxnxUfMLj51lCwDwqZUbt3eYK0jCIdp2zig/QcW4+NPn93r2m3y/YT/JXNURSilglfUE3NXSXi6MmemEOFquaYrgjvTRJ1++3GQ6BLo5BycDo2J0xpGJ2QK9kIre1mRySLQU/diAdTfz8otVGsVfy1O3cYEnCs0WxNNkaKNXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730589423; c=relaxed/simple;
	bh=eEg3isoD7ffRGFMGsGtmaBSbYq6g0XL8HcV4izxpnt0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WVrNV+ZngMv6CK2gd8RNdWWz+xxj88dTxOMjfGAsYRXLlcG0gH8/kN4wkyffFWJmmibf3zZEqnjbTITt9aLRWWGXf27RfuTJQKMKCdLe5f+aWmYEAGxPTcdYYNQU8Y6pGRb49IlgE7vt3R7253lxGW7uVsNAOsIpBxwhi9r6bHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2yw35eR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2yw35eR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC7ABC4CEC3;
	Sat,  2 Nov 2024 23:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730589423;
	bh=eEg3isoD7ffRGFMGsGtmaBSbYq6g0XL8HcV4izxpnt0=;
	h=From:To:Cc:Subject:Date:From;
	b=V2yw35eRAs+i+oCuuXMX0tDMEOXf2N32eBIa9B87z++SHv099Mmy17US7jmYd+2UG
	 s7JN0sZ27HhJwFaIFie0xPdzeZEQLR6o2xrteOkZjEE9YUVxSg4uaLYCMu9+5VxtGF
	 L+EZfnmN5XRlIQbKDOlkUBuSaeAAn3qvMFQtJcoOqhZiz4bR+AErDZhil4F8HhhcQe
	 v7tzKtdUEOVkMN9NFkOireysKG/NrqmoJpzvmiA/k42ZARUXGXYIwADhgtVkZ0x2N9
	 +8k/tSnibJkGlrC0Lp0CQ0gdBg5Znq6Wux/FH+HVjp2/f+b0gNYamHDC8FSXEKah4J
	 n3Vy34MHSLRfA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf test: Fix ftrace test with regex patterns
Date: Sat,  2 Nov 2024 16:17:02 -0700
Message-ID: <20241102231702.2262258-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During the parallel testing, I've noticed some ftrace test failures.  It
seems the regex pattern checks 100 msec of nanosleep with the error
range of 10 msec.  But sometimes it's affected by other processes and
resulted in more time in the syscall.

The following output shows that it took more than 120 msec and failed.
Let's update the regex pattern so that it can allow more drifts.

  perf ftrace profile test
  # Total (us)   Avg (us)   Max (us)      Count   Function
    121279.500 121279.500 121279.500          1   __x64_sys_clock_nanosleep
    121278.400 121278.400 121278.400          1   common_nsleep
    121277.800 121277.800 121277.800          1   hrtimer_nanosleep
    121277.100 121277.100 121277.100          1   do_nanosleep
    341760.289  56960.048 121273.400          6   schedule
       176.200     25.171     31.616          7   scheduler_tick
         0.923      0.923      0.923          1   native_smp_send_reschedule
    345522.360  69104.472 345320.600          5   __x64_sys_execve
    345486.585  69097.317 345312.700          5   do_execveat_common.isra.0
    340730.300 340730.300 340730.300          1   bprm_execve
         1.758      0.879      0.883          2   sched_mm_cid_before_execve
         1.112      1.112      1.112          1   sched_mm_cid_after_execve
  ---- end(-1) ----
   81: perf ftrace tests                                               : FAILED!

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/ftrace.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/ftrace.sh b/tools/perf/tests/shell/ftrace.sh
index a6ee740f0d7eca07..11010711efa193b3 100755
--- a/tools/perf/tests/shell/ftrace.sh
+++ b/tools/perf/tests/shell/ftrace.sh
@@ -72,7 +72,7 @@ test_ftrace_profile() {
     grep sleep "${output}"
     grep schedule "${output}"
     grep execve "${output}"
-    time_re="[[:space:]]+10[[:digit:]]{4}\.[[:digit:]]{3}"
+    time_re="[[:space:]]+1[[:digit:]]{5}\.[[:digit:]]{3}"
     # 100283.000 100283.000 100283.000          1   __x64_sys_clock_nanosleep
     # Check for one *clock_nanosleep line with a Count of just 1 that takes a bit more than 0.1 seconds
     # Strip the _x64_sys part to work with other architectures
-- 
2.47.0.163.g1226f6d8fa-goog

