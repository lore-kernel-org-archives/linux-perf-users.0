Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BCF285C91;
	Sun, 10 May 2026 03:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778384232; cv=none; b=JfHNFkap20Z+W36nE1vTwiPsGssisSda0sbhbYSaHBuQvZ1npAQeRNLR7sPYbBHslIz5hsDARZk5LCn4oL/00ldFvwThMO3Gk9ayqitUWZR9CcAr94v8jfPxZxaafVgiht2mqC0yNrSaiTnXoBrumogn4kfyH9feUY6Py+Or7PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778384232; c=relaxed/simple;
	bh=wKm9pBbrA1i3JaTJIYZEX4eG4AJGGFGH3JN/bXXlmTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uirfMHo5HtmYpyMpHAlCq5ZlShomQIip8VKZAThszeiW5XPeDTa1ERIXWEaUCpD0RuMfXHxPpGwtf9nKvN7m3RxAqaxR5snum8fkOkK8IM3ZPL6jnpkk/VgD7Yod7oG8+gdSCylZRRH40MZ0k/9UUSoXioi8x6l9ulf1LFUbg18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQUX/zNO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQUX/zNO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E70E6C2BCB8;
	Sun, 10 May 2026 03:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778384232;
	bh=wKm9pBbrA1i3JaTJIYZEX4eG4AJGGFGH3JN/bXXlmTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QQUX/zNOhK66zBeoTgfsuUpjfpt9hTIU+1IfmsMd99Onu9jwo2h0nlkL/r7oFrNkh
	 089n/psYvXV+NIqw5c8K4fuINWweMhZOC4+v0w5bLqtADMksIDOW6Ui2QQ8d0JKTXZ
	 Zs71twjLV59ZhsPa9M20V950RE3yIORIlboPcVw9/fiqkGs7lahElau6dvNXLo/GFU
	 Z3UNR7xDrPyGXGHEjinUkfI1h+PG4ADCgjdkQFCxt76mWDzknjv09ECcVJhB+sL2pS
	 73LmxlZB4UaLiabZmhOx9gpNU+yRDP3Ub2KuBx1bvnnAD0W5zVotht0rXOSnZ7Ky61
	 qrqj/mP0uGMaQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	"Claude Opus 4.6 (1M context)" <noreply@anthropic.com>
Subject: [PATCH 28/28] perf test: Add truncated perf.data robustness test
Date: Sun, 10 May 2026 00:34:19 -0300
Message-ID: <20260510033424.255812-29-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260510033424.255812-1-acme@kernel.org>
References: <20260510033424.255812-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Add a shell test that verifies perf report handles truncated
perf.data files gracefully — exiting with an error code rather
than crashing with SIGSEGV or SIGABRT.

The test records a simple workload, then truncates the resulting
perf.data at four offsets that exercise different parsing stages:

  8 bytes   — file header magic only
  64 bytes  — partial file header (attr section incomplete)
  256 bytes — into the first events (partial event headers)
  75% size  — mid-stream truncation (partial event data)

For each truncation, perf report is run and the exit code is
checked.  Signal-based exits (128+signal) in the range 134-159
indicate a crash and fail the test.  Non-zero exits from normal
error handling are expected and acceptable.

This exercises the bounds checking, minimum-size validation,
and error propagation added by the preceding patches in this
series.

Cc: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/data_validation.sh | 59 +++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100755 tools/perf/tests/shell/data_validation.sh

diff --git a/tools/perf/tests/shell/data_validation.sh b/tools/perf/tests/shell/data_validation.sh
new file mode 100755
index 0000000000000000..649f71b6cdb93202
--- /dev/null
+++ b/tools/perf/tests/shell/data_validation.sh
@@ -0,0 +1,59 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Test that perf report handles truncated perf.data gracefully
+# (no crash, no segfault — clean error exit).
+#
+# Exercises the bounds checking and minimum-size validation added
+# by the perf-data-validation hardening series.
+
+err=0
+
+cleanup() {
+	rm -f "${perfdata}" "${truncated}"
+	trap - EXIT TERM INT
+}
+trap cleanup EXIT TERM INT
+
+perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+truncated=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
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
+	# Suppress stdout/stderr — we only care about the exit code.
+	perf report -i "${truncated}" --stdio > /dev/null 2>&1
+	exit_code=$?
+
+	# 139 = SIGSEGV, 134 = SIGABRT, 136 = SIGFPE
+	if [ ${exit_code} -ge 134 ] && [ ${exit_code} -le 159 ]; then
+		echo "FAIL: perf report crashed (signal $((exit_code - 128))) on ${cut_at}-byte truncated file"
+		err=1
+	fi
+done
+
+cleanup
+exit ${err}
-- 
2.54.0

