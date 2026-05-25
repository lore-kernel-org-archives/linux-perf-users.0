Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D253D2F069D;
	Mon, 25 May 2026 01:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779671271; cv=none; b=CF+XQdbGn/R+jv4eStdNBdq8eXGbkugw+cL5HcsgyluBbQ7eneRoBWUDiaXvCNvr8SCT6jHgD8LnQD6gK65H+Y3pQ7hBZUBL3N7KSbetkskRk9sMVTZbbPGq0L3UZNRZHgH+dyRaryrobWEm0eoXhg8RwxCg2r0xHCEbva09YO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779671271; c=relaxed/simple;
	bh=ZtrW+WoSyUYMkRDcoNRU7CDxqnijO3ULdR81H38eEDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XwdzPXOndw3nktlLUjWHZxsVgE5RzE7sqBlBLm6sgHytj4dLrx+QrKRFdEKuNgqMRaEF7D9Q7QzET+Yrm4o+l1Cdz1BqoFH5bGDE112mEdfxPfcp0+Z8oB25aC08n/et6lPV8GEd8eGEjFJq9TxorKu+9P8WUkqmMVd7k4FubYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OnDpAhAb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnDpAhAb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C946E1F000E9;
	Mon, 25 May 2026 01:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779671269;
	bh=ckdEd7h4Bs1FgfAoEx6vjUROO/k+cf4Jdpc6WLh3LU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OnDpAhAbWYeRgstOaD92eeUL64hgrcCJvskbs80Uct3wwUUukKwYPfvMFD5PfIon0
	 U3Ark/BOlpExL+g76fVOd0i5eswLowRa6ldbgSyAUQnkMsY7eVaexTkjd4ryVD/FKt
	 h3wwNly5sLexzihADtbqYIAniD7u1Qjw3SztSCGJSB3e74j2aZIFap+t+r/QwX9tYH
	 VGgoIJw5twCo7vc0IZ8FNodYnURz5TmUSobW6OKNfhacxRfjXa4+si7jSVTqJIjwPM
	 ea2g7iv/xUdnEazIOKirkokHDhkctaLx8S1skJS52yArskKoj4qGcBfvo17ttOZAuQ
	 zHMrV46+DsnwQ==
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
Subject: [PATCH 29/29] perf test: Add truncated perf.data robustness test
Date: Sun, 24 May 2026 22:05:49 -0300
Message-ID: <20260525010550.1100375-30-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525010550.1100375-1-acme@kernel.org>
References: <20260525010550.1100375-1-acme@kernel.org>
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
  x86/ARM but 10 on MIPS/SPARC).  Core-dump and fatal signals
  (KILL, ILL, ABRT, BUS, FPE, SEGV, TRAP, SYS) fail the test.

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

Changes in v2:
- Add SIGKILL to the list of fatal signals so OOM kills from
  resource exhaustion bugs are detected (Reported-by: sashiko-bot@kernel.org)

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
index 0000000000000000..36b3ba508e4f2753
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
+file_size=$(wc -c < "${perfdata}")
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
+	dd if="${perfdata}" of="${truncated}" bs=1 count="${cut_at}" 2>/dev/null
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
+		KILL|ILL|ABRT|BUS|FPE|SEGV|TRAP|SYS)
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

