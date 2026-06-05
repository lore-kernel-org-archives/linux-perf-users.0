Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A873940B36C;
	Fri,  5 Jun 2026 23:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780701119; cv=none; b=ZaPAajoVjxYyJKb1tVUsi+AYeSQY+dvAlpwSwFhEbMLxKTSLQAQL3dWO047Ngymz42uaGFa2nrkC78BceAHWz5XlMILa/kfVhjJtU1+02AENA7yJDf6tmyMP6E0t0Sf6V6QdSokIYRXivZhJZKWSvmYzr1cCE9/r5H7P+mZiU70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780701119; c=relaxed/simple;
	bh=z3w19A16NH7NdvirA4opVoS2O6lRMszvIMrx9KkbOWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hQV8zFbyUMw0NWXmdsyfp/YCn6maVm7kINt2SwRXALo5zDuodM1+Rhk9jFIWFhjgjG2H3DpLIKxDQfitc9bS+BsbbUVLOiofLD9Xh+tirtjKooAFt0Lm2F5eKzxTbCvpreM0q6DsQzWshFhbz4uTZe2fjbUadYnO2wZ0EhzzfGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sd6sxBSO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sd6sxBSO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C221F00893;
	Fri,  5 Jun 2026 23:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780701117;
	bh=/4otRSM6EtEjjXJGLXf1QzGjALVdbnQQ4hssMzx/+os=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Sd6sxBSORFKKyuwdZPKu+0b9VYic9HQY/zMeFi2J9QYgQ1tQ/mn+aydIojywe+J3z
	 KxT8jajpi3nZLSpOLedxUV3WKADJy5xFmyr3Hjmy/lRapvhrQTUbV9i4B9yTnle2Q8
	 UEhPXhcbYgcr0J1+W9YYWHV52kMVygY5mj1ZjTW0j5EDDFHTq43Mi0EtcMy2M0e7mE
	 pEedrr9HybXBoh1qsjXOi/ZJD5od52FS3ifN/40Pb4CWcGCg8l/vpE66JqCE7AW4qC
	 gAXj6vkatbtEW6P7naM1gQrx4DGr0sOamWK35Lc3FKSZ9tGzJ+h1C9P+HSUDQCInvV
	 LfR0W/XnQv9Aw==
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
Subject: [PATCH 4/4] perf test: Update perf timechart test
Date: Fri,  5 Jun 2026 16:11:55 -0700
Message-ID: <20260605231155.2415760-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
In-Reply-To: <20260605231155.2415760-1-namhyung@kernel.org>
References: <20260605231155.2415760-1-namhyung@kernel.org>
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
2.54.0.1032.g2f8565e1d1-goog

