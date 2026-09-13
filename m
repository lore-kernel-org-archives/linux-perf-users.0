Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A9B377034;
	Sun, 13 Sep 2026 02:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789266913; cv=none; b=L+7+eKxM/AGo5RP9F75E5VoMIVjd9JcXM5R0meJfYed9xdSUIc/SSbSxQylEmk3nm2pTVX2bjZDOx2wSf+6LShNQs9sPopo9RyGhlpVmE/D2GRGI6myaU2F5YEMG8tA8A5KvjEvCXSAy4ltiUwiltfGYebQXz1i+FS7y5kL6E0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789266913; c=relaxed/simple;
	bh=V56pcjVbjnrgiT4Lt3i6Nlu4CZC5Vrc81Cs1aDymu7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=adJyuvMVr+JvrZ8X6Tp6U2srniXHE7RIffaqJYaf067y82/4EySywmzuwTqOiKjqXHG3+tgQeB7zCpes9KMtz2Crttc9m7hL2RKDk9sXWHGvsebX+rI62bUh1BQoja0R/pJc5D3Z9WM7gP9n+PBuGRmQzTuaeLc49a5G8WjWZ0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCsRJOSZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCsRJOSZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AAE21F00893;
	Sun, 13 Sep 2026 02:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789266909;
	bh=40PpvyNz+FTvCz0PJ/eeZnY/X6I0+eLUGCvJDO1X3XQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cCsRJOSZm4GI6feyOC0ZEGGxDHoXU48laBb0QhJtJk48iNsAKPbchyOjQtLritFZv
	 TcdAYrP67+3WUlRH9FEHbg4Np0y9621OZhww3GBvjoyNxlPB4uYRCwq1oxGmhb25uS
	 vaPLWTMb1tN5q0Idt+NZYwNO23Qm2+hyRbHvohDblCoV8FySP0iueNsPVV1JU7hXUu
	 nkiEdbO468bArYFskNTgslKTsQ+Kl2I6ZGjKuce1ljnN+/2TE+XzGutbb934QL8mrK
	 HcAmQcB3PulLD8dr6xW6PDCzEtFTW0KOp/V0cyzAv7YTkxricxxDIt6mWCVaib9pVR
	 scvWxFX0SLvKQ==
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
Subject: [PATCH v1 1/8] perf test: Skip data_type_profiling when the PMU cannot record memory events
Date: Sat, 12 Sep 2026 23:34:52 -0300
Message-ID: <20260913023459.112654-2-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260913023459.112654-1-acme@kernel.org>
References: <20260913023459.112654-1-acme@kernel.org>
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

