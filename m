Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795545978;
	b=NgM63PAI4UUzdAm/37Tn2ZfBosJRxjLaSPdKAFnymAuyMqw8qyMdIubfFEfwXxDQF6Cq
	 6S29ek2h8zyE3ltPU9DLvWv0RaAyxCk1o9ZLB0dVqhd14yJN5313M03TSaSWlCUZ1lYse
	 XIGxaRirb6vbcf5KhvegGnpeJ7uPPv94nGGX/C4mlwXDSQF8q6DWJEP9C8L5En4XOaWhq
	 0lgS4bxYIdBZIAwHNV1RXPOPe7Hq1HOCZpb5/qc8MY3OSy0DUcYVUGszf+1/SvPDUFAPL
	 UK4e1PATH0ToLCcg2GTqahcvZGaRP4l14BiBkIRC4KFIlWSZps0Ol5OrGisxi+MdNXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795545978;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZNZC2iVOxra61FTUdamR91yXdhcxatI09J3OZPQjbEQ=;
	b=fIPMCs+xXDfjdSJGbhDXoUh+ioWu6qHApPuDHOaYzajkxdxHt1EabgcclIkaF1/q8+KB
	 BKagOL1ko7maEheevG6J0PNODagC7fu7QHC4goZ8IJOi3u9mHewMwIPqlW4BBKFvYQrSb
	 ATn+/ZzfdOAb9MybG9E++eitIhfvSx89rH4kxajqGSHMejaW3nTKx/jyg/Oa6MkKerZWa
	 TF5ayOUNrN0M6MYlHlGfy9cMFG5GwtD6bo8z9SKmQ8x6Ps02zu6kYEyiI1pF7npBsv6zG
	 dNKRFE9aWbGN9kEmbpyvpfEqC3YPK8mLJwOxE3AHHaCl+W0dmKLVO7QSqucqwz87V1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xwqq3O39;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9412606A33D;
	Tue, 24 Nov 2026 18:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xwqq3O39
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3DC81F000C4;
	Tue, 24 Nov 2026 18:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795545978;
	bh=ZNZC2iVOxra61FTUdamR91yXdhcxatI09J3OZPQjbEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xwqq3O39eQzWNks8Yop6TihtJBrgIxwzW2gWHjleoICgykNhUom3UdWuRlM74PyUD
	 IsGXspuc1Z5UhZ/Cm6AfnNJQDjaFKlKHwnK2Tif8aEHbIuVrZLdmfKs9TqK1a1a9Th
	 u9FOGjadBE6BXrFNXoCNAYKOcaclbgSvZWslGJTH5J72/VZOAyu/GjFpudlOoq58MO
	 6+z+0NtMu9oGimMn/3tm9bUD3uwDIF9AELmuZuzH6lk8bxvTlXH2BxoftCYlm8a1xG
	 93soPAPsJwWMkVDNLkGL3eD/mfTqS1qxxSbofwYsXKp/w9fem7a/WePDZOyDlUUvVf
	 1CE1HEEZi/fWw==
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
Subject: [PATCH v1 02/17] perf tests sched: Exercise the sched views and options
Date: Tue, 24 Nov 2026 15:45:49 -0300
Message-ID: <20261124184604.24983-3-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124184604.24983-1-acme@kernel.org>
References: <20261124184604.24983-1-acme@kernel.org>
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
 tools/perf/tests/shell/sched.sh | 154 +++++++++++++++++++++++---------
 1 file changed, 111 insertions(+), 43 deletions(-)

diff --git a/tools/perf/tests/shell/sched.sh b/tools/perf/tests/shell/sched.sh
index 113df962a51c878f..e1aa8570b21f4ad9 100755
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
@@ -56,90 +61,153 @@ cleanup_noploops() {
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
+  run_sched "timehist migrations" "migrated:" timehist -M -i "${perfdata}"
+  run_sched "timehist idle" "Idle-time summary" timehist -I --summary -i "${perfdata}"
+  run_sched "timehist state" "sch delay" \
+    timehist --state --show-prio -V -P -i "${perfdata}"
+  run_sched "timehist call graph" "" timehist -g --max-stack 3 -i "${perfdata}"
+  run_sched "timehist pid filter" "" timehist -p "${PID1}" -i "${perfdata}"
+  run_sched "timehist prio filter" "" timehist --show-prio --prio 0 -i "${perfdata}"
+  run_sched "timehist with summary" "perf-noploop" timehist -S -i "${perfdata}"
+}
+
+test_sched_stats_live() {
+  echo "Sched stats live"
 
-  if ! perf sched script -i "${perfdata}" | grep -q perf-noploop
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
+test_sched_stats_live
+test_sched_stats_record
+test_sched_stats_report
+test_sched_stats_diff
 
 cleanup
 exit $err
-
-- 
2.56.0

