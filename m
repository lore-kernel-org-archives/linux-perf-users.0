Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC7E3E4508;
	Wed, 24 Jun 2026 20:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782334747; cv=none; b=GDWt584k7qTv2PuIjZzkIU6Wr5eKITgvlFFgbGHL5K3M4BeRCzhwChGXE8uQ+1kOTA5E7deMnbx0wv+nOTPAs/voeKSomn9XRNepEN9Spw7CymWafDzSpMhvhvEstpd7plhV3xq3veZLebWnhxsjDszjZwEZNiEFi0fGgenuzvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782334747; c=relaxed/simple;
	bh=0rymhOv9L/NUKQUxWthx76O8ck7wDyLHmzxYbP5/Ves=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RqJKSG2eCl4besBLwJ0oC8H8wW8M/cHa6bHAO7tBADlUSgARG7JyQXCwS5eLoA0Qwl47xcGkIe/8DXbf1gyYtVVYLORxd2qJg5cmsjz2rc5wge+xMVCQjzIB20EXwFOBBwDW1UcuPxEVJ7mh1UV1VBAcF6dOGVTe5W3MLkjxWTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+8aFZWg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+8aFZWg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852601F00ACF;
	Wed, 24 Jun 2026 20:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782334745;
	bh=wLM6722Lccgvgv5qWTPKiduZTfmz2wLK5I1Ej7XqWtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B+8aFZWg2heKiMiPHWrVt58YaYxy3rIvD9RjmCqbqFbueBcCWfiJYEMxoj8icHGBe
	 4V7yuTjogBYRdM+HCGoHylqFOLJLvW4i7GxP9hrF4juT8y8fSGcOXjzUw4Nlwpr6GQ
	 5sevLAw7TJKSxgkTEljWt1Ve7R4oD18tEdUzHFycijj8B1W+Add9vqNJvNkxzznLq0
	 cwkUhaElZuNyow3sx4nzH+ty4yObtmoBbW6YbDTTJ41UC7LNpdno84++UxQ+3DtMxq
	 XZ/iuF9u06GMCNGXm0ly7KLJ7EU9fsbgaVVCCZkMpZ2CeyKaMLmj17FvmROcEqmtaq
	 CJzdt3hHwukeQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v3 8/8] perf test: Update perf timechart test
Date: Wed, 24 Jun 2026 13:58:34 -0700
Message-ID: <20260624205852.3864874-9-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260624205852.3864874-1-namhyung@kernel.org>
References: <20260624205852.3864874-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To include IO-only and backtrace modes to test different code paths.

  $ sudo perf test -vv timechart
  135: perf timechart tests                        : Running
  135: perf timechart tests:
  ---- start ----
  test child forked, pid 2413665
  perf timechart Basic test
  perf timechart Basic test [Success]
  perf timechart IO-only test
  perf timechart IO-only test [Success]
  perf timechart Backtrace test
  perf timechart Backtrace test [Success]
  ---- end(0) ----
  135: perf timechart tests                        : Ok

  === Test Summary ===
  Passed main tests : 1
  Passed subtests   : 0
  Skipped tests     : 0
  Failed tests      : 0

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/timechart.sh | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/tools/perf/tests/shell/timechart.sh b/tools/perf/tests/shell/timechart.sh
index b14b3472c2846b32..40072b32171a9a1c 100755
--- a/tools/perf/tests/shell/timechart.sh
+++ b/tools/perf/tests/shell/timechart.sh
@@ -9,7 +9,7 @@ perfdata=$(mktemp /tmp/__perf_timechart_test.perf.data.XXXXX)
 output=$(mktemp /tmp/__perf_timechart_test.output.XXXXX.svg)
 
 cleanup() {
-	rm -f "${perfdata}"
+	rm -f "${perfdata}"*
 	rm -f "${output}"
 	trap - EXIT TERM INT
 }
@@ -22,38 +22,41 @@ trap_cleanup() {
 trap trap_cleanup EXIT TERM INT
 
 test_timechart() {
-	echo "Basic perf timechart test"
+	NAME=$1
+	OPTION=$2
+
+	echo "perf timechart ${NAME} test"
 
 	# Try to record timechart data.
 	# perf timechart record uses system-wide recording and specific tracepoints.
 	# If it fails (e.g. permissions, missing tracepoints), skip the test.
-	if ! perf timechart record -o "${perfdata}" true > /dev/null 2>&1; then
-		echo "Basic perf timechart test [Skipped: perf timechart record failed (permissions/events?)]"
+	if ! perf timechart record -o "${perfdata}" ${OPTION} true > /dev/null 2>&1; then
+		echo "perf timechart ${NAME} test [Skipped: perf timechart record failed (permissions/events?)]"
 		return
 	fi
 
 	# Generate the timechart
 	if ! perf timechart -i "${perfdata}" -o "${output}" > /dev/null 2>&1; then
-		echo "Basic perf timechart test [Failed: perf timechart command failed]"
+		echo "perf timechart ${NAME} test [Failed: perf timechart command failed]"
 		err=1
 		return
 	fi
 
 	# Check if output file exists and is not empty
 	if [ ! -s "${output}" ]; then
-		echo "Basic perf timechart test [Failed: output file is empty or missing]"
+		echo "perf timechart ${NAME} test [Failed: output file is empty or missing]"
 		err=1
 		return
 	fi
 
 	# Check if it looks like an SVG
 	if ! grep -q "svg" "${output}"; then
-		echo "Basic perf timechart test [Failed: output doesn't look like SVG]"
+		echo "perf timechart ${NAME} test [Failed: output doesn't look like SVG]"
 		err=1
 		return
 	fi
 
-	echo "Basic perf timechart test [Success]"
+	echo "perf timechart ${NAME} test [Success]"
 }
 
 if ! perf check feature -q libtraceevent ; then
@@ -62,6 +65,9 @@ if ! perf check feature -q libtraceevent ; then
 	exit 2
 fi
 
-test_timechart
+test_timechart "Basic" ""
+test_timechart "IO-only" "-I"
+test_timechart "Backtrace" "-g"
+
 cleanup
 exit $err
-- 
2.55.0.rc0.799.gd6f94ed593-goog

