Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8E63596F8;
	Sun, 13 Sep 2026 03:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789270009; cv=none; b=Ya3x2awO4LbLGlgu7/AxGNVundePPpaZXg44s6w1hMj7Qpx8EgyAlVaJdeCZkNl5gLPqEUzaoTkROSZdXH4uB1axsaUrGh4CTCY8C1WuF7zc1ZqTuh905nhP6BlZtvA8tdYrfeuf89y56L6mE2IeEFHPjV4U4t6ch2utpZxoZkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789270009; c=relaxed/simple;
	bh=V56pcjVbjnrgiT4Lt3i6Nlu4CZC5Vrc81Cs1aDymu7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A0dfd72NYX+zZzdfzBL+60LmFJCrT0frqTsIlNKyqC3Jm7SEEwZcDPW5fV/eMJQQW8+hdDHbV4A4e13WgviFlm9WPFLyLrPF1LSX9XlDw0GuDH9w007ID/EIlE58q9zZEEfCde1Oz963d8k/ZJaIXY1d+TJnXDO4X2qn6JOShNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLW+PvVI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLW+PvVI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9985D1F00893;
	Sun, 13 Sep 2026 03:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789270005;
	bh=40PpvyNz+FTvCz0PJ/eeZnY/X6I0+eLUGCvJDO1X3XQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aLW+PvVIeOxeu3cx/PfgYv/dG3+P+rMCwNOwXylQZLI33O5gjqsCNczlPD2/wqmMg
	 98KnFb89fhz5x4/wTZ8coY4IoNOIJzjS88K30XuPi+XqORbc7180RHrcCeB6/uRTPL
	 vTUCnN4TUY5K4XGs5vaNtaVm3EzJzRlN5zHlhX7IplW25WARdW+1VvUiDo0gNcqsfu
	 3USmuRURHmcbsT79smWFfKI4vBX7tGW5DlxKkCRERQ0ix6IGiu9C0PfEMQiAK4so+1
	 KFDo6y8TtFNu8d5/rfLBMZ5KUFlxvUw8Lz9dQTAaYB4Z/iZswcAS+8ebmAWiDa9be3
	 +6vx+sMT9HmxA==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v2 1/8] perf test: Skip data_type_profiling when the PMU cannot record memory events
Date: Sun, 13 Sep 2026 00:26:21 -0300
Message-ID: <20260913032632.116277-2-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260913032632.116277-1-acme@kernel.org>
References: <20260913032632.116277-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The test records with 'perf mem record' in per-thread mode and its only
guard matches one specific message:

  perf mem record -o /dev/null -- true 2>&1 | \
        grep -q "failed: no PMU supports the memory events" && exit 2

A PMU that has memory events but refuses them per-thread falls through
it, and AMD IBS does:

  $ perf mem record -o /dev/null -- true
  Error:
  Failure to open event 'ibs_op/ldlat=0/u' on PMU 'ibs_op' which will be removed.
  Invalid event (ibs_op/ldlat=0/u) in per-thread mode, enable system wide with '-a'.
  Error:
  Failure to open any events for recording.

What follows is not a skip either.  The script runs under 'set -e', so
the bare 'perf mem record' in test_basic_annotate() aborts it through the
EXIT trap, which reports a signal that never happened and exits 1:

  Basic Rust perf annotate test
  Unexpected signal in test_basic_annotate

so 'perf test' turns "this PMU cannot record these events" into a test
failure:

  $ perf test "data type profiling"
   87: perf data type profiling tests             : FAILED!

The 'if [ "x$?" != "x0" ]' right below the record was meant to report
"[Failed: perf record]" and carry on with the other cases, but under
'set -e' it is dead code: the shell is gone before it is reached.  The
same goes for the 'perf annotate' call below it.

Skip when a trivial per-thread 'perf mem record' fails, and put both
commands in the condition of an 'if', where 'set -e' leaves them alone,
so that the
reporting works for the cases where only one workload cannot be recorded
or annotated:

  $ perf test "data type profiling"
   87: perf data type profiling tests             : Skip

and, with just the new skip guard disabled on the same box, every case
reports its failure instead of the first one aborting the run:

  Basic Rust perf annotate test
  Basic annotate [Failed: perf record]
  Pipe Rust perf annotate test
  Pipe annotate [Failed: perf record]
  Basic C perf annotate test
  Basic annotate [Failed: perf record]
  Pipe C perf annotate test
  Pipe annotate [Failed: perf record]

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/data_type_profiling.sh | 46 +++++++++++++++----
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/tools/perf/tests/shell/data_type_profiling.sh b/tools/perf/tests/shell/data_type_profiling.sh
index eca694600a0478d2..a916c410274aa888 100755
--- a/tools/perf/tests/shell/data_type_profiling.sh
+++ b/tools/perf/tests/shell/data_type_profiling.sh
@@ -19,6 +19,15 @@ perfout=$(mktemp /tmp/__perf_test.perf.out.XXXXX)
 perf mem record -o /dev/null -- true  2>&1 | \
   		grep -q "failed: no PMU supports the memory events" && exit 2
 
+# Skip if per-thread mem record is not supported on this PMU (e.g. AMD IBS
+# needs system-wide '-a'): it is what the test records with below, and a
+# failing record must not be reported as a test failure.
+if ! perf mem record -o /dev/null -- true 2>/dev/null
+then
+  echo "Skip: cannot record memory events on this PMU"
+  exit 2
+fi
+
 cleanup() {
   rm -rf "${perfdata}" "${perfout}"
   rm -rf "${perfdata}".old
@@ -52,25 +61,42 @@ test_basic_annotate() {
     index=1 ;;
   esac
 
+  # Under 'set -e' a bare failing command aborts the script through the EXIT
+  # trap, so the commands that report a failure have to be the condition of
+  # an 'if' for that reporting to ever happen.
   if [ "x${mode}" == "xBasic" ]
   then
-    perf mem record -o "${perfdata}" ${testprogs[$index]} 2> /dev/null
+    if ! perf mem record -o "${perfdata}" ${testprogs[$index]} 2> /dev/null
+    then
+      echo "${mode} annotate [Failed: perf record]"
+      err=1
+      return
+    fi
   else
-    perf mem record -o - ${testprogs[$index]} 2> /dev/null > "${perfdata}"
-  fi
-  if [ "x$?" != "x0" ]
-  then
-    echo "${mode} annotate [Failed: perf record]"
-    err=1
-    return
+    if ! perf mem record -o - ${testprogs[$index]} 2> /dev/null > "${perfdata}"
+    then
+      echo "${mode} annotate [Failed: perf record]"
+      err=1
+      return
+    fi
   fi
 
   # Generate the annotated output file
   if [ "x${mode}" == "xBasic" ]
   then
-    perf annotate --code-with-type -i "${perfdata}" --stdio --percent-limit 1 2> /dev/null > "${perfout}"
+    if ! perf annotate --code-with-type -i "${perfdata}" --stdio --percent-limit 1 2> /dev/null > "${perfout}"
+    then
+      echo "${mode} annotate [Failed: perf annotate]"
+      err=1
+      return
+    fi
   else
-    perf annotate --code-with-type -i - --stdio 2> /dev/null --percent-limit 1 < "${perfdata}" > "${perfout}"
+    if ! perf annotate --code-with-type -i - --stdio 2> /dev/null --percent-limit 1 < "${perfdata}" > "${perfout}"
+    then
+      echo "${mode} annotate [Failed: perf annotate]"
+      err=1
+      return
+    fi
   fi
 
   # check if it has the target data type
-- 
2.55.0

