Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D981417D8A3;
	Wed, 12 Jun 2024 14:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718201015; cv=none; b=J6XK26aPExL0dI5icWlFyUiNXuhBdrugMdvi9kgH0bQmlirbrYpEWYjin6LREQ1+RzIafoQPAIC5N2Beu4RUNy5vBinFF4iN3BqDs6H7MGPa9ZyORIjX8eb+vEMKnDhV3+rj7MMr4DOcWpO7yzZB5/O91OMHWQa+3mbG+GERSlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718201015; c=relaxed/simple;
	bh=Z8v6VN3VTXwQnLuxWiCD7XiHXxTlypzscfkEhk+/2RU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GIYHCyDXOEh1PfzzWMPk608LCvyB6Xu7EhD5v4jiCH1KTsO5b8SR7JsXfHlltyGDJG9/qt4Ta2Ap7fvuA+6lxIu9R6iusgz4zAdsVrnxaxqxzezusPrqm5j1UOhRjvsRjeilBAWEuJ1zsL/1AkLlFWGa3fPtDCypcaad4j3GkmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B448D367;
	Wed, 12 Jun 2024 07:03:57 -0700 (PDT)
Received: from e127643.broadband (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E43413F64C;
	Wed, 12 Jun 2024 07:03:30 -0700 (PDT)
From: James Clark <james.clark@arm.com>
To: linux-perf-users@vger.kernel.org
Cc: James Clark <james.clark@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Spoorthy S <spoorts2@in.ibm.com>,
	German Gomez <german.gomez@arm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf test: Make test_arm_callgraph_fp.sh more robust
Date: Wed, 12 Jun 2024 15:03:14 +0100
Message-Id: <20240612140316.3006660-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 2 second sleep can cause the test to fail on very slow network file
systems because Perf ends up being killed before it finishes starting
up.

Fix it by making the leafloop workload end after a fixed time like the
other workloads so there is no need to kill it after 2 seconds.

Also remove the 1 second start sampling delay because it is similarly
fragile. Instead, search through all samples for a matching one, rather
than just checking the first sample and hoping it's in the right place.

Fixes: cd6382d82752 ("perf test arm64: Test unwinding using fame-pointer (fp) mode")
Signed-off-by: James Clark <james.clark@arm.com>
---
 .../perf/tests/shell/test_arm_callgraph_fp.sh | 27 +++++++------------
 tools/perf/tests/workloads/leafloop.c         | 20 +++++++++++---
 2 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/tools/perf/tests/shell/test_arm_callgraph_fp.sh b/tools/perf/tests/shell/test_arm_callgraph_fp.sh
index 61898e256616..9caa36130175 100755
--- a/tools/perf/tests/shell/test_arm_callgraph_fp.sh
+++ b/tools/perf/tests/shell/test_arm_callgraph_fp.sh
@@ -28,28 +28,21 @@ cleanup_files()
 
 trap cleanup_files EXIT TERM INT
 
-# Add a 1 second delay to skip samples that are not in the leaf() function
 # shellcheck disable=SC2086
-perf record -o "$PERF_DATA" --call-graph fp -e cycles//u -D 1000 --user-callchains -- $TEST_PROGRAM 2> /dev/null &
-PID=$!
+perf record -o "$PERF_DATA" --call-graph fp -e cycles//u --user-callchains -- $TEST_PROGRAM
 
-echo " + Recording (PID=$PID)..."
-sleep 2
-echo " + Stopping perf-record..."
-
-kill $PID
-wait $PID
+# Try opening the file so any immediate errors are visible in the log
+perf script -i "$PERF_DATA" -F comm,ip,sym | head -n4
 
-# expected perf-script output:
+# expected perf-script output if 'leaf' has been inserted correctly:
 #
-# program
+# perf
 # 	728 leaf
 # 	753 parent
 # 	76c leafloop
-# ...
+# ... remaining stack to main() ...
 
-perf script -i "$PERF_DATA" -F comm,ip,sym | head -n4
-perf script -i "$PERF_DATA" -F comm,ip,sym | head -n4 | \
-	awk '{ if ($2 != "") sym[i++] = $2 } END { if (sym[0] != "leaf" ||
-						       sym[1] != "parent" ||
-						       sym[2] != "leafloop") exit 1 }'
+# Each frame is separated by a tab, some spaces and an address
+SEP="[[:space:]]+ [[:xdigit:]]+"
+perf script -i "$PERF_DATA" -F comm,ip,sym | tr '\n' ' ' | \
+	grep -E -q "perf $SEP leaf $SEP parent $SEP leafloop"
diff --git a/tools/perf/tests/workloads/leafloop.c b/tools/perf/tests/workloads/leafloop.c
index 1bf5cc97649b..f7561767e32c 100644
--- a/tools/perf/tests/workloads/leafloop.c
+++ b/tools/perf/tests/workloads/leafloop.c
@@ -1,6 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#include <signal.h>
 #include <stdlib.h>
 #include <linux/compiler.h>
+#include <unistd.h>
 #include "../tests.h"
 
 /* We want to check these symbols in perf script */
@@ -8,10 +10,16 @@ noinline void leaf(volatile int b);
 noinline void parent(volatile int b);
 
 static volatile int a;
+static volatile sig_atomic_t done;
+
+static void sighandler(int sig __maybe_unused)
+{
+	done = 1;
+}
 
 noinline void leaf(volatile int b)
 {
-	for (;;)
+	while (!done)
 		a += b;
 }
 
@@ -22,12 +30,16 @@ noinline void parent(volatile int b)
 
 static int leafloop(int argc, const char **argv)
 {
-	int c = 1;
+	int sec = 1;
 
 	if (argc > 0)
-		c = atoi(argv[0]);
+		sec = atoi(argv[0]);
+
+	signal(SIGINT, sighandler);
+	signal(SIGALRM, sighandler);
+	alarm(sec);
 
-	parent(c);
+	parent(sec);
 	return 0;
 }
 
-- 
2.34.1

