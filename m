Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795743503;
	b=zbY+Hj9/vHHJLdmqLT/EXhcThnOCz2vdUXSvcrAIHDEk8enUx10w3gHT/e4jqlBR4sD1
	 y6pPh5bjCh6psFQO7Oe4O5BP8zKN5dv0NZcB4HFmkPPH4j231W3W6NH9TuxVSSst9niCy
	 KX5DR2YaCtF28DKJhP6WPyUiJNANVS0BgQ04IhU3XaH5448/vyRFfHd5X4h0sxYezt5YR
	 /W0JOfUz5zQUynzqTL8X3Xl06VRLuY5iOgOLpOTj1uBSXBgor5kS8DbPyfOUms8TRcGVL
	 iejF8Im4u50LvUpDc8C1o7PIXov8i3vDKTLd+n+0wgxm3t4d0WrDJXhQg+AdFIUVW8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795743503;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=awr+qVHlvyEZd+Ke5cIiyEZenVnchesxiniGZQ1vCkg=;
	b=HMsdhXngWhGfygTEzj13ECX9jTGu/7jwA5JPLmlQh5vPDzq39HDSteNZpq77ZI2sDW2k
	 fAxSHm6W4NpjTNr0sq1Mvuz7s0OY7DmshV5+RWWdFh588u4r0nfaDCN/KzU/S+FIhDGFp
	 n/qk7QeopehG/FgSoOjlrJD++ueHr9iDdit+DjXHQ9gY7f9Ow9liLxzfPEd9ofvX1UQFT
	 DZijp2kfT05zJeybbVBlMMc694JSFBcY1EdoAvNA2iCwbL3NOGba+7aTIwSapzXPHCsCg
	 XMc8/omNq1ycorFGD1BEcepkYhim7JMVUHWJJCKNSZCyZ5b6tBNPVz1Gq48sdQj8+Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M9ZyQTR3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D986606A31E
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Nov 2026 01:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M9ZyQTR3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313821F000C1;
	Fri, 27 Nov 2026 01:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795743503;
	bh=awr+qVHlvyEZd+Ke5cIiyEZenVnchesxiniGZQ1vCkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M9ZyQTR3d6VwiE3GVkFpz4ue2mRIaa/b9Z+EJk0YuCwElanYJeRR4he96nIHSxdEh
	 ENqn9qITJ79ZxTj3h3Fd4RP6xfQl/ZmGQv5dDf+ikX/JjeI+CwiLY41Za0m2/dqA5T
	 vpQObY494pb/D74rie+qKeMiTZ6Lv4W/cWJV4brxastl7JMFmzFGBR3ivBUvtWV6s7
	 L9YEa6P1y0eVgWVQaQGtd80xxHyXXO5q98jSQmbBCs/39TlP1NUW3ArL76PsliArZ6
	 QB5vqtJazzqeRYEfvkUCHMybM0HwCG4ZKHHiVwt8FuTyWPvX1fR7jaNiDkOVDXokok
	 KWkUoJ1yR9BJw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v2 03/18] perf tests sched: Exercise the sched views and options
Date: Thu, 26 Nov 2026 22:37:46 -0300
Message-ID: <20261127013801.14841-4-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261127013801.14841-1-acme@kernel.org>
References: <20261127013801.14841-1-acme@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The test pipes the map, latency and timehist output to grep, which
stops reading at the first match, so the command is killed by
SIGPIPE before it produces the rest of its output.  It also passes
--no-inherit, a no-op since perf sched record always records CPU
wide and inherit is cleared for CPU wide targets.

Capture the output first, drop --no-inherit and add the map,
latency and timehist options along with schedstat record, report and
diff coverage.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/sched.sh | 164 +++++++++++++++++++++++---------
 1 file changed, 121 insertions(+), 43 deletions(-)

diff --git a/tools/perf/tests/shell/sched.sh b/tools/perf/tests/shell/sched.sh
index 113df962a51c878f..cc7b4d1191877771 100755
--- a/tools/perf/tests/shell/sched.sh
+++ b/tools/perf/tests/shell/sched.sh
@@ -11,12 +11,17 @@ fi
 
 err=0
 perfdata=$(mktemp /tmp/__perf_test_sched.perf.data.XXXXX)
+statsdata=$(mktemp /tmp/__perf_test_sched.stats.XXXXX)
+schedout=$(mktemp /tmp/__perf_test_sched.out.XXXXX)
 PID1=0
 PID2=0
 
 cleanup() {
   rm -f "${perfdata}"
   rm -f "${perfdata}".old
+  rm -f "${statsdata}"
+  rm -f "${statsdata}".old
+  rm -f "${schedout}"
 
   trap - EXIT TERM INT
 }
@@ -56,90 +61,163 @@ cleanup_noploops() {
   kill "$PID1" "$PID2" || true
 }
 
+run_sched() {
+  local desc="$1" expect="$2"
+
+  shift 2
+  echo "Sched ${desc}"
+  if ! perf sched "$@" > "${schedout}" 2>&1
+  then
+    echo "Sched ${desc} [Failed: perf sched failed]"
+    cat "${schedout}"
+    err=1
+    return
+  fi
+  if [ -n "${expect}" ] && ! grep -q "${expect}" "${schedout}"
+  then
+    echo "Sched ${desc} [Failed: missing '${expect}']"
+    cat "${schedout}"
+    err=1
+    return
+  fi
+  echo "Sched ${desc} [Success]"
+}
+
 test_sched_record() {
   echo "Sched record"
 
   start_noploops
 
-  perf sched record --no-inherit -o "${perfdata}" sleep 1
+  if ! perf sched record -o "${perfdata}" sleep 1
+  then
+    echo "Sched record [Failed: perf sched record failed]"
+    err=1
+  fi
 
   cleanup_noploops
 }
 
 test_sched_latency() {
-  echo "Sched latency"
-
-  if ! perf sched latency -i "${perfdata}" | grep -q perf-noploop
-  then
-    echo "Sched latency [Failed missing output]"
-    err=1
-  fi
+  run_sched "latency" "perf-noploop" latency -i "${perfdata}"
 }
 
 test_sched_latency_histogram() {
-  echo "Sched latency histogram"
+  run_sched "latency histogram" "Latency Distribution Histogram" \
+    latency -H -i "${perfdata}"
+  run_sched "latency linear histogram" "Latency Distribution Histogram" \
+    latency --histogram --hist-mode linear -i "${perfdata}"
+}
 
-  if ! perf sched latency -H -i "${perfdata}" | grep -q "Latency Distribution Histogram"
-  then
-    echo "Sched latency histogram [Failed missing log histogram]"
-    err=1
-  fi
+test_sched_latency_options() {
+  run_sched "latency sort" "perf-noploop" latency -s max -i "${perfdata}"
+  run_sched "latency per pid" "perf-noploop" latency -p -i "${perfdata}"
+  run_sched "latency cpu filter" "" latency -C 0 -i "${perfdata}"
+  run_sched "latency time filter" "perf-noploop" latency --time 0, -i "${perfdata}"
+}
 
-  if ! perf sched latency --histogram --hist-mode linear -i "${perfdata}" | grep -q "Latency Distribution Histogram"
-  then
-    echo "Sched latency histogram [Failed missing linear histogram]"
-    err=1
-  fi
+test_sched_script() {
+  run_sched "script" "perf-noploop" script -i "${perfdata}"
 }
 
-test_sched_latency_time() {
-  echo "Sched latency time filter"
+test_sched_map() {
+  run_sched "map" "perf-noploop" map -i "${perfdata}"
+}
 
-  if ! perf sched latency --time 0, -i "${perfdata}" | grep -q perf-noploop
-  then
-    echo "Sched latency time filter [Failed missing output]"
-    err=1
-  fi
+test_sched_map_options() {
+  run_sched "map compact" "" map --compact -i "${perfdata}"
+  run_sched "map color" "" map --color-pids "${PID1}" --color-cpus 0 \
+    --cpus 0 -i "${perfdata}"
+  run_sched "map task name" "" map --task-name perf-noploop -i "${perfdata}"
+  run_sched "map fuzzy name" "" map --task-name noploop --fuzzy-name \
+    -i "${perfdata}"
 }
 
-test_sched_script() {
-  echo "Sched script"
+test_sched_timehist() {
+  run_sched "timehist" "perf-noploop" timehist -i "${perfdata}"
+}
+
+test_sched_timehist_options() {
+  run_sched "timehist summary" "Runtime summary" timehist --summary -i "${perfdata}"
+  run_sched "timehist wakeups" "awakened:" timehist -w -i "${perfdata}"
+  # Both noploop workloads are pinned to CPU 0, so no migration event
+  # is guaranteed to be recorded; just check that -M runs.
+  run_sched "timehist migrations" "" timehist -M -i "${perfdata}"
+  run_sched "timehist idle" "Idle-time summary" timehist -I --summary -i "${perfdata}"
+  run_sched "timehist state" "sch delay" \
+    timehist --state --show-prio -V -P -i "${perfdata}"
+  run_sched "timehist call graph" "" timehist -g --max-stack 3 -i "${perfdata}"
+  run_sched "timehist pid filter" "" timehist -p "${PID1}" -i "${perfdata}"
+  run_sched "timehist prio filter" "" timehist --show-prio --prio 0 -i "${perfdata}"
+  run_sched "timehist with summary" "perf-noploop" timehist -S -i "${perfdata}"
+}
 
-  if ! perf sched script -i "${perfdata}" | grep -q perf-noploop
+test_sched_stats_live() {
+  echo "Sched stats live"
+
+  ret=0
+  timeout -s INT -k 5 3 perf sched stats > "${schedout}" 2>&1 || ret=$?
+  if [ "${ret}" != 0 ] && [ "${ret}" != 124 ]
   then
-    echo "Sched script [Failed missing output]"
+    echo "Sched stats live [Failed: perf sched stats failed]"
+    cat "${schedout}"
     err=1
+    return
   fi
-}
 
-test_sched_map() {
-  echo "Sched map"
-
-  if ! perf sched map -i "${perfdata}" | grep -q perf-noploop
+  if ! grep -q "Description" "${schedout}"
   then
-    echo "Sched map [Failed missing output]"
+    echo "Sched stats live [Failed missing output]"
     err=1
+    return
   fi
+  echo "Sched stats live [Success]"
 }
 
-test_sched_timehist() {
-  echo "Sched timehist"
-
-  if ! perf sched timehist -i "${perfdata}" | grep -q perf-noploop
+test_sched_stats_record() {
+  if ! perf sched stats record -o "${statsdata}" sleep 1
+  then
+    echo "Sched stats record [Failed: perf sched stats record failed]"
+    err=1
+    return
+  fi
+  if [ ! -s "${statsdata}" ]
   then
-    echo "Sched timehist [Failed missing output]"
+    echo "Sched stats record [Failed: no data file]"
     err=1
+    return
   fi
+  echo "Sched stats record [Success]"
+}
+
+test_sched_stats_report() {
+  run_sched "stats report" "Description" stats report -i "${statsdata}" -C 0 -v
+}
+
+test_sched_stats_diff() {
+  run_sched "stats diff" "" stats diff "${statsdata}" "${statsdata}"
 }
 
 test_sched_record
 test_sched_latency
 test_sched_latency_histogram
-test_sched_latency_time
+test_sched_latency_options
 test_sched_script
 test_sched_map
+test_sched_map_options
 test_sched_timehist
+test_sched_timehist_options
+
+# perf sched stats needs /proc/schedstat, which CONFIG_SCHEDSTATS=n
+# kernels do not expose; the record path checks for it but the stats
+# commands do not.
+if [ -r /proc/schedstat ]; then
+  test_sched_stats_live
+  test_sched_stats_record
+  test_sched_stats_report
+  test_sched_stats_diff
+else
+  echo "Sched stats [Skipped: no /proc/schedstat]"
+fi
 
 cleanup
 exit $err
-
-- 
2.56.0

