Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE2A37F019;
	Mon, 20 Apr 2026 02:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776653983; cv=none; b=rShIw0dN/L8D/KEm9V+VFcvmVxfPpXumvO7Bv0stQqRwJQ4N9/SyPgnRTobksxZmWMcCADwKhDUXZpMKJYrBimEuRzmbzLNbetBvRLDwLYXMYcIuSFOp53XaDHCGE3Kw6Y1v0rZGjhwxBXSu1A13j3GsgpNkqKBUaW3W8XEpJz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776653983; c=relaxed/simple;
	bh=DqkRWc3WygNEYGgqfflo17mk11dvg4y9JEzX1+XSlD8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gtcgBWwspI1T2Vl0h2mEXi8Rdlx6uFVk+CwOxWJTDJk+s9nhjfFq/VQd83rQjM5kUFgAOBsezEtXdeFQ9VV/w017a7AUu183/wh2ZRqKm1EEqxRoGpm1TiimHoxyzZwCTSkYjr+CSdvS7Rly7LM0gINxkkfJ+mObPnSRyP0oiwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AstPyYza; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AstPyYza"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776653981; x=1808189981;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DqkRWc3WygNEYGgqfflo17mk11dvg4y9JEzX1+XSlD8=;
  b=AstPyYzavxNk4vI2qrH7hAibGacB4Or4EWTxakQeLPJnwL4GbLxaekHW
   E3TerInaBx29/lBV/OiqKHeY1lYwjZIUM0L/9odGeQbu0lEJdoFB23L2l
   lo5F9ouXoLoGmFrlAQr6JnFfmPKRQaMwLr7ANkircrOirIFIm0W75HasQ
   DLvCENOErwqpEGxhae4UojlAQB9Xf/0vik1wtrG7TvWt2fvuqz2HMymNC
   d/EPAzaAgeA2YoEtxZeDu7/qpOcGdhZqAI5wVhCz+7ozpz3YQmZxoWPcB
   H9QpUb5OG8UC5q+ScRaQlBffndXivabdgaAvZtxopmhF+pRAb9V+vn/nW
   w==;
X-CSE-ConnectionGUID: 2ZOB7WJ3TGWW5N/006t6og==
X-CSE-MsgGUID: ozU8+4zwRDmSRHlymTm94A==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="81170588"
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="81170588"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2026 19:59:41 -0700
X-CSE-ConnectionGUID: Ga/oKMDaQseu2/cZ9Ariew==
X-CSE-MsgGUID: XOqwfAFRS7SRXKu3+GrIZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="231878039"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa007.jf.intel.com with ESMTP; 19 Apr 2026 19:59:37 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v2] perf tests: Add auto counter reload (ACR) sampling test
Date: Mon, 20 Apr 2026 10:55:01 +0800
Message-Id: <20260420025501.2133495-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add auto counter reload sampling test to verify that the intended event
records can be captured and the self-reloaded events won't generate any
records.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---

V2: 1) add ratio_to_prev option test. 2) Adjust sampling period to
better match the "perf test -w thloop" workload
v1: https://lore.kernel.org/all/20260413010920.546501-1-dapeng1.mi@linux.intel.com/

 tools/perf/tests/shell/record.sh | 89 ++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 7cb81cf3444a..a05b0c8b6d6b 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -402,6 +402,94 @@ test_callgraph() {
   echo "Callgraph test [Success]"
 }
 
+test_acr_sampling() {
+  events="{instructions/period=40000,acr_mask=0x2/u,cycles/period=20000,acr_mask=0x3/u}"
+  pebs_events="{instructions/period=40000,acr_mask=0x2/pu,cycles/period=20000,acr_mask=0x3/u}"
+  ratio_events="{instructions:u,cycles/period=20000,ratio-to-prev=0.5/u}"
+  p_core_ratio_events="{cpu_core/instructions/u,cpu_core/cycles,period=20000,ratio-to-prev=0.5/u}"
+  e_core_ratio_events="{cpu_atom/instructions/u,cpu_atom/cycles,period=20000,ratio-to-prev=0.5/u}"
+  echo "Auto counter reload (ACR) sampling test"
+  if ! perf record -o "${perfdata}" -e "${events}" ${testprog} 2> /dev/null
+  then
+    echo "Auto counter reload sampling [Skipped not supported]"
+    return
+  fi
+  if ! perf script -i "${perfdata}" -F event | grep -q "instructions"
+  then
+    echo "Auto counter reload sampling [Failed missing instructions event]"
+    err=1
+    return
+  fi
+  if perf script -i "${perfdata}" -F event | grep -q "cycles"
+  then
+    echo "Auto counter reload sampling [Failed cycles event shouldn't be sampled]"
+    err=1
+    return
+  fi
+  if ! perf record -o "${perfdata}" -e "${pebs_events}" ${testprog} 2> /dev/null
+  then
+    echo "Auto counter reload PEBS sampling [Skipped not supported]"
+    return
+  fi
+  if ! perf script -i "${perfdata}" -F event | grep -q "instructions"
+  then
+    echo "Auto counter reload PEBS sampling [Failed missing instructions event]"
+    err=1
+    return
+  fi
+  if perf script -i "${perfdata}" -F event | grep -q "cycles"
+  then
+    echo "Auto counter reload PEBS sampling [Failed cycles event shouldn't be sampled]"
+    err=1
+    return
+  fi
+
+  ratio_err=0
+  do_ratio_to_prev_test() {
+    local events=$1
+    local cpu=$2
+    if ! perf record -o "${perfdata}" -e "${events}" ${testprog} 2> /dev/null
+    then
+      echo "Auto counter reload ${cpu} ratio-to-prev sampling [Failed not supported]"
+      ratio_err=1
+      return
+    fi
+    if ! perf script -i "${perfdata}" -F event | grep -q "instructions"
+    then
+      echo "Auto counter reload ${cpu} ratio-to-prev sampling [Failed missing instructions event]"
+      ratio_err=1
+      return
+    fi
+    if perf script -i "${perfdata}" -F event | grep -q "cycles"
+    then
+      echo "Auto counter reload ${cpu} ratio-to-prev sampling [Failed cycles event shouldn't be sampled]"
+      ratio_err=1
+      return
+    fi
+  }
+
+  # ratio-to-prev sampling would fallback to normal sampling if ACR sampling
+  # is not supported, so acr_mask must be checked before testing ratio-to-prev sampling.
+  if [ -e /sys/bus/event_source/devices/cpu/format/acr_mask ]
+  then
+    do_ratio_to_prev_test "${ratio_events}" ""
+  fi
+  if [ -e /sys/bus/event_source/devices/cpu_core/format/acr_mask ]
+  then
+    do_ratio_to_prev_test "${p_core_ratio_events}" "P-core"
+  fi
+  if [ -e /sys/bus/event_source/devices/cpu_atom/format/acr_mask ]
+  then
+    do_ratio_to_prev_test "${e_core_ratio_events}" "E-core"
+  fi
+  if test "$ratio_err" -eq 0
+  then
+    echo "Auto counter reload sampling [Success]"
+  else
+    err="${ratio_err}"
+  fi
+}
+
 test_ratio_to_prev() {
   echo "ratio-to-prev test"
   if ! perf record -o /dev/null -e "{instructions, cycles/period=100000,ratio-to-prev=0.5/}" \
@@ -458,6 +546,7 @@ test_topdown_leader_sampling
 test_precise_max
 test_callgraph
 test_ratio_to_prev
+test_acr_sampling
 
 # restore the default value
 ulimit -Sn $default_fd_limit
-- 
2.34.1

