Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2768433D6FC;
	Thu, 21 May 2026 01:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779325946; cv=none; b=b/3yt2KxuJ3X+4y7nWQYpqvQsGX1BU7Jbrpyj0VgwuDcBdjCE79sOWyRbfrH/gKp78d4s3t7gU0n+Vz1d7+8IBS0iUkhc4c0SftOjoxPAsyImyPbW2+LUjq2tct6Lmzdy/TPPOGEkoh93AVKhfbNSiF1VMydriAA0gRSB78rNIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779325946; c=relaxed/simple;
	bh=KIEkF3EaJz77SDF5mxDrTXlVeJG2dBXvwn8aBmMRo2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QAPKxaxX/oIBk4hcAcMVmuDr2gZ7p6TCcymWX+7SYdq3Xda3zXLbBQ2lyhSHpeArbgNYASH5Fx6eZUerzvNEj8cHIMdaXaZ0qNIFF70jefuekJHfSQVffUX2FJzNiVaETrqiym1LKl0AlXgpx4j5DcrPH9pr01bMx8PZtvjEiSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZ9l3siI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZ9l3siI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21C41F00A3B;
	Thu, 21 May 2026 01:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779325944;
	bh=rS1Jh9K0PvkOY4v1OPA2sgP8wFd1Za7efBuvZ/20nLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KZ9l3siI9JdIcyuR6C2/Qq2j8+Sb9uz23JQuZeNXGH7BF9hfYSbNvsBizghLIr7SK
	 XTzamN/oxYffNaGyNfQZ0cdH+KnFBQh3pqGSbvkfDHqyx/AEXeHW4xZAA+XNx0uAEK
	 JV96AqzIWQRuIH3EEvGo53D+SocJIedfWu+3heRrsnf9M9067+QqtUIWEsfzukmepJ
	 1dkDrrQ4Sf8/coVpL4IoT7baZ7kd9mXmSsmMdlplyy/3P81odFbYjI2Zcej8sFVm8V
	 RsDVjqjLhNfrK0LQCXIJ9xiFmVOHOW3EzlEjV+/jCJQojbIHf2z3bz5Ywb8UvgoV80
	 45+QohRdSy7ww==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	"Claude Opus 4.6 (1M context)" <noreply@anthropic.com>
Subject: [PATCH 27/27] perf test: Add truncated perf.data robustness test
Date: Wed, 20 May 2026 22:10:12 -0300
Message-ID: <20260521011027.622268-28-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521011027.622268-1-acme@kernel.org>
References: <20260521011027.622268-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Add a shell test that verifies perf report handles truncated perf.data
files gracefully — exiting with an error code rather than crashing with
SIGSEGV or SIGABRT.

The test records a simple workload, then truncates the resulting
perf.data at four offsets that exercise different parsing stages:

  8 bytes   — file header magic only
  64 bytes  — partial file header (attr section incomplete)
  256 bytes — into the first events (partial event headers)
  75% size  — mid-stream truncation (partial event data)

For each truncation, perf report is run and the exit code is checked:

- Exit code 0 (success) fails the test — a truncated file should
  never parse without error.

- Crash signals are detected portably via kill -l, which maps the
  signal number to a name on the running system.  This handles
  architectures where signal numbers differ (e.g. SIGBUS is 7 on
  x86/ARM but 10 on MIPS/SPARC).  Core-dump signals (ILL, ABRT,
  BUS, FPE, SEGV, TRAP, SYS) fail the test.

- Higher exit codes (200+) are perf's own negative-errno returns
  (e.g. -EINVAL = 234) and are expected.

This exercises the bounds checking, minimum-size validation, and error
propagation added by the preceding patches in this series.

Testing it:

  root@number:~# perf test truncat
   84: Test that perf report handles truncated perf.data gracefully (no crash, no segfault — clean error exit).: Ok
  root@number:~# perf test -vv truncat
   84: Test that perf report handles truncated perf.data gracefully (no crash, no segfault — clean error exit).:
  --- start ---
  test child forked, pid 62890
  ---- end(0) ----
   84: Test that perf report handles truncated perf.data gracefully (no crash, no segfault — clean error exit).: Ok
  root@number:~#

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
[ Fixed the SPDX on the line where 'perf test' expects the test description, reviewed by Ian Rogers ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/data_validation.sh | 85 +++++++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100755 tools/perf/tests/shell/data_validation.sh

diff --git a/tools/perf/tests/shell/data_validation.sh b/tools/perf/tests/shell/data_validation.sh
new file mode 100755
index 0000000000000000..fa7980c4ddd30954
--- /dev/null
+++ b/tools/perf/tests/shell/data_validation.sh
@@ -0,0 +1,85 @@
+#!/bin/bash
+# Test that perf report handles truncated perf.data gracefully (no crash, no segfault — clean error exit).
+# SPDX-License-Identifier: GPL-2.0
+#
+# Exercises the bounds checking and minimum-size validation added
+# by the perf-data-validation hardening series.
+
+err=0
+
+cleanup() {
+	rm -f "${perfdata}" "${perfdata}.old" "${truncated}" "${stderrfile}"
+	trap - EXIT TERM INT
+}
+trap 'cleanup; exit 1' TERM INT
+trap cleanup EXIT
+
+perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+truncated=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+stderrfile=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+
+# Record a simple workload
+if ! perf record -o "${perfdata}" -- perf test -w noploop 2>/dev/null; then
+	echo "Skip: perf record failed"
+	cleanup
+	exit 2
+fi
+
+file_size=$(stat -c %s "${perfdata}")
+if [ "${file_size}" -lt 512 ]; then
+	echo "Skip: perf.data too small (${file_size} bytes)"
+	cleanup
+	exit 2
+fi
+
+# Test truncation at various offsets that exercise different
+# parsing stages:
+#   8    — file header magic only, no attrs or data
+#   64   — partial file header (attr section incomplete)
+#   256  — into the first events (partial event headers)
+#   75%  — mid-stream truncation (partial event data)
+for cut_at in 8 64 256 $((file_size * 3 / 4)); do
+	if [ "${cut_at}" -ge "${file_size}" ]; then
+		continue
+	fi
+	head -c "${cut_at}" "${perfdata}" > "${truncated}"
+
+	# perf report should exit with an error, not crash.
+	# Capture stderr to detect sanitizer violations.
+	perf report -i "${truncated}" --stdio > /dev/null 2> "${stderrfile}"
+	exit_code=$?
+
+	# A truncated file should never parse successfully
+	if [ ${exit_code} -eq 0 ]; then
+		echo "FAIL: perf report exited 0 (success) on ${cut_at}-byte truncated file — expected an error"
+		err=1
+		continue
+	fi
+
+	# Detect sanitizer violations — ASAN/MSAN/TSAN/UBSAN exit
+	# with code 1 by default, which would otherwise look like a
+	# clean error exit.  Check stderr for their markers.
+	if grep -qE "^(==[0-9]+==ERROR:|SUMMARY: [A-Za-z]*Sanitizer)" "${stderrfile}" 2>/dev/null; then
+		sanitizer=$(grep -oE "(Address|Memory|Thread|UndefinedBehavior)Sanitizer" "${stderrfile}" | head -1)
+		echo "FAIL: perf report triggered ${sanitizer:-sanitizer} on ${cut_at}-byte truncated file"
+		err=1
+		continue
+	fi
+
+	# Detect crash signals portably — signal numbers differ
+	# across architectures (e.g. SIGBUS is 7 on x86/ARM but
+	# 10 on MIPS/SPARC).  Use kill -l to map the number to a
+	# name on the running system.
+	if [ ${exit_code} -gt 128 ] && [ ${exit_code} -lt 200 ]; then
+		sig_name=$(kill -l $((exit_code - 128)) 2>/dev/null)
+		case ${sig_name} in
+		ILL|ABRT|BUS|FPE|SEGV|TRAP|SYS)
+			echo "FAIL: perf report crashed (SIG${sig_name}) on ${cut_at}-byte truncated file"
+			err=1
+			;;
+		esac
+	fi
+done
+
+cleanup
+exit ${err}
-- 
2.54.0

