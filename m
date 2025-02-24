Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D5E158520;
	Mon, 24 Feb 2025 01:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740361390; cv=none; b=foDlpodlQLg3nbzVjeWhIu5c2fUP7n0VXPWTh3qjR1LGoec1c9eQNkwEP2EhjxZ7UIglyfgnM5Ka82YG10rSPw+sYcMM7x++vQp1Xw7wTJa/Z6rtInXKGXtbNbSgTNL90EEJWPOAyHaTzmQAezxFCa+vxbe+uDh7IKkYaK4lrEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740361390; c=relaxed/simple;
	bh=s8sv5qb6pgFnrR0f38MWn2U4qzSyEbnuVcoxEpRBLmM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pmXvTSHEV4SmJ13/B1ExYBTZNuBEuJNXsmnwdLP4ra9eOQs/TRftGogQOYqeVifky4iDAT1dqzLsZJZYgcHhxdvlydqihsmfCBvI2IyHCCGagank3VDbo6BX3Jh4c+SO5F0rW8uPDOeuuY5ecfUwbAZzEzSWOF1M5VSxj1++9f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QiP6zlkq; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QiP6zlkq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740361388; x=1771897388;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s8sv5qb6pgFnrR0f38MWn2U4qzSyEbnuVcoxEpRBLmM=;
  b=QiP6zlkq3inKnoE/vUku18IVO/WCzpHtMVWQJqngHLU1aSQEQJhkHC4s
   XB67cJjlGTHYWY4zqA+OyavF9Pkki1BY4agDy2+XNBqJqsIywjsToP6gl
   e38hkqWSAH10EyZyVSYp5t5shdxNGtLOOaEfqfRLBEhpN9KGuZ+vfRcuS
   zDmEdpZDCh2H1/pi3QX83caLIHD9bk0dWEiMj2uLmmz7/gpJDGaE2Ifrt
   MCUCiJcN1tWGgM6Qaifjl/E8/X1VpqyngUNx7ouM0t2+ztBsUu1/XZ8Em
   W28V0RLw5D45CihRW6zJoGkZtsK6Iy/zRk2Y5fTTJI6cKxeaTft3sy+jP
   Q==;
X-CSE-ConnectionGUID: D93yo9rlRtiBrJD0nPsFfQ==
X-CSE-MsgGUID: 5x1hqogVQ/yO05vMerhRHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="40293798"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="40293798"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 17:43:08 -0800
X-CSE-ConnectionGUID: eFE4hpiCR/K1rk5C9Q+wJw==
X-CSE-MsgGUID: 4dp0fR39TUmc2iMIf6gykA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="115892919"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa006.jf.intel.com with ESMTP; 23 Feb 2025 17:43:05 -0800
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 2/2] perf tools/tests: Fix topdown groups test on hybrid platforms
Date: Mon, 24 Feb 2025 08:33:06 +0000
Message-Id: <20250224083306.71813-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250224083306.71813-1-dapeng1.mi@linux.intel.com>
References: <20250224083306.71813-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running topdown groups test on hybrid platforms like LNL/ARL, we
see the following 2 commands fail.

perf stat $cputype -e '{instructions,slots},topdown-retiring' true
perf stat $cputype -e '{instructions,slots},{topdown-retiring}' true

Take the 1st command as an example, 5 events are created on hybrid
platform. They are cpu_atom/instructions/, cpu_core/instructions/,
cpu_core/slots/, cpu_atom/topdown-retiring/ and
cpu_core/topdown-retiring/ events. The former 3 events are in a group
and the latter 2 topdown-retiring events are independent events.

As the limitation of current implementation, the
cpu_core/topdown-retiring/ event can't be moved into previous group as
long as there are other events before it. That's the reason why we see
the failure.

Thus add "--cputype core" option to limit only P-core events are tested.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/arch/x86/util/evlist.c | 26 +++++++++++++++++++++++---
 tools/perf/tests/shell/stat.sh    | 20 ++++++++++++++++++--
 2 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
index 447a734e591c..0a71ba975871 100644
--- a/tools/perf/arch/x86/util/evlist.c
+++ b/tools/perf/arch/x86/util/evlist.c
@@ -9,7 +9,7 @@ int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
 {
 	/*
 	 * Currently the following topdown events sequence are supported to
-	 * move and regroup correctly.
+	 * move and regroup correctly on non-hybrid platforms.
 	 *
 	 * a. all events in a group
 	 *    perf stat -e "{instructions,topdown-retiring,slots}" -C0 sleep 1
@@ -44,7 +44,7 @@ int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
 	 * topdown metrics events must be first event after the slots event group,
 	 * otherwise topdown metrics events can't be regrouped correctly, e.g.
 	 *
-	 * a. perf stat -e "{instructions,slots},cycles,topdown-retiring" -C0 sleep 1
+	 * e. perf stat -e "{instructions,slots},cycles,topdown-retiring" -C0 sleep 1
 	 *    WARNING: events were regrouped to match PMUs
 	 *     Performance counter stats for 'CPU(s) 0':
 	 *         17,923,134      slots
@@ -56,11 +56,31 @@ int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
 	 * has topdown metrics events must contain only the topdown metrics event,
 	 * otherwise topdown metrics event can't be regrouped correctly as well, e.g.
 	 *
-	 * a. perf stat -e "{instructions,slots},{topdown-retiring,cycles}" -C0 sleep 1
+	 * f. perf stat -e "{instructions,slots},{topdown-retiring,cycles}" -C0 sleep 1
 	 *    WARNING: events were regrouped to match PMUs
 	 *    Error:
 	 *    The sys_perf_event_open() syscall returned with 22 (Invalid argument) for
 	 *    event (topdown-retiring)
+	 *
+	 * For hybrid platforms, the sequences 'c' and 'd' are not supported as well
+	 * besides above sequences 'e' and 'f'.
+	 *
+	 *    perf stat -e "{instructions,slots},topdown-retiring" -C0 sleep 1
+	 *    perf stat -e "{instructions,slots},{topdown-retiring}" -C0 sleep 1
+	 *
+	 * On hybrid platforms each event would create an instance on all types of PMU
+	 * if the event can be supported by the PMU, i.e., the "topdown-retiring" event
+	 * would create two instances on hybrid platforms with P-cores and E-cores,
+	 * "cpu_core/topdown-retiring/" and "cpu_atom/topdown_retiring".
+	 *
+	 * Take the first command as an example, the events list would be converted to
+	 * below list in fact.
+	 *
+	 * "{cpu_atom/instructions/,cpu_core/instructions/,cpu_core/slots/},
+	 *  cpu_atom/topdown-retiring/,cpu_core/topdown-retiring/"
+	 *
+	 * This is actually same with event list in case 'e', "cpu_core/topdown-retiring/"
+	 * event can't be moved into previous events group.
 	 */
 	if (topdown_sys_has_perf_metrics() &&
 	    (arch_evsel__must_be_in_group(lhs) || arch_evsel__must_be_in_group(rhs))) {
diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index 68323d636fb7..cdfe27c25528 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -5,6 +5,16 @@
 set -e
 
 err=0
+is_hybrid=false
+
+check_hybrid_platform() {
+  pmus=$(ls /sys/bus/event_source/devices/*/cpus 2>/dev/null | wc -l)
+  if [ "$pmus" -gt 1 ]
+  then
+    is_hybrid=true
+  fi
+}
+
 test_default_stat() {
   echo "Basic stat command test"
   if ! perf stat true 2>&1 | grep -E -q "Performance counter stats for 'true':"
@@ -62,6 +72,11 @@ test_topdown_groups() {
   # Topdown events must be grouped with the slots event first. Test that
   # parse-events reorders this.
   echo "Topdown event group test"
+  cputype=""
+  if $is_hybrid
+  then
+    cputype="--cputype core"
+  fi
   if ! perf stat -e '{slots,topdown-retiring}' true > /dev/null 2>&1
   then
     echo "Topdown event group test [Skipped event parsing failed]"
@@ -85,13 +100,13 @@ test_topdown_groups() {
     err=1
     return
   fi
-  if perf stat -e '{instructions,slots},topdown-retiring' true 2>&1 | grep -E -q "<not supported>"
+  if perf stat $cputype -e '{instructions,slots},topdown-retiring' true 2>&1 | grep -E -q "<not supported>"
   then
     echo "Topdown event group test [Failed topdown metrics event not move into slots group]"
     err=1
     return
   fi
-  if perf stat -e '{instructions,slots},{topdown-retiring}' true 2>&1 | grep -E -q "<not supported>"
+  if perf stat $cputype -e '{instructions,slots},{topdown-retiring}' true 2>&1 | grep -E -q "<not supported>"
   then
     echo "Topdown event group test [Failed topdown metrics group not merge into slots group]"
     err=1
@@ -200,6 +215,7 @@ test_hybrid() {
   echo "hybrid test [Success]"
 }
 
+check_hybrid_platform
 test_default_stat
 test_stat_record_report
 test_stat_record_script
-- 
2.40.1

