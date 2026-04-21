Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FFB29B764;
	Tue, 21 Apr 2026 04:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776747593; cv=none; b=WFR62quY3oj0XCbk2oj6kfqiMZ6jNKZPAIzg0kdy6eQXsAA7NYLRY94W5kRjYdmlTZDKgmctelZEi/Um/un9neab5JkIQ391wNMxJ6j7B3EuO+cKxDZuL/mv+szR4SEo4ywrjtC4c8NNy7PSSvEzjQti2RwS8IwyuP1R7tSxL9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776747593; c=relaxed/simple;
	bh=pMEhY5pchgg3oj5SAPs5y6BH35Qkhkz4ykk6XhyYFEE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cwDTTpvo3/uWOJSyZbiFA7OxMlGus2KC6p8oVK9RPO57uCHlk3zRxSmaygld/MtPkISTvwJq0Sl2bPVHaguOcElvTxYWw83P8yh+JwUnO43EwlVOHS49TPISw5S9ygks5IgCbK4TBK5wpzjfy7bRIuEFBY8LEK76U0wKoTnHt7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dMnSVA5D; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dMnSVA5D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776747592; x=1808283592;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pMEhY5pchgg3oj5SAPs5y6BH35Qkhkz4ykk6XhyYFEE=;
  b=dMnSVA5DHbXbgDZZr231V3PjbvEUL71f/biHQQB0nu+mUdr3/zLz2LOn
   xhZyp3m8vUQRSKE/uBn4Fpsai/oawGnb3TPGEdoSIkBVzbYB/vQae2xCN
   guj2iqOQA0dYhQ+ekfCW3CNG452AJcFw3qJQ1LIoQuNwBy/FB6tFEczrx
   GrNALwjB2Ny245UjMB+eeCRPEL4+VjZcOb621KYmlDMtfR/PImKQJEbAE
   ryCp2Am5qY0RFrEP/dCrnxNESVRRPll4o4X2NZPyoBIsp1HZUY+9SVfsB
   KDK3YVVo9kyKzdwIQ2kWKB+wDKLgbuzkaHZg5MIfgwxPpiMCa4s7rV5gB
   g==;
X-CSE-ConnectionGUID: TUOnEoqRQGCfnhGN1jOX6g==
X-CSE-MsgGUID: +iF9qogrR7G5A7MWfaCO1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="87975698"
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="87975698"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 21:59:51 -0700
X-CSE-ConnectionGUID: U+3NeBHLR0W/d0HZgACDXg==
X-CSE-MsgGUID: gC0b50VkRuOKVUxqGQBcvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="227287215"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa006.fm.intel.com with ESMTP; 20 Apr 2026 21:59:48 -0700
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
Subject: [Patch v3] perf tests: Add auto counter reload (ACR) sampling test
Date: Tue, 21 Apr 2026 12:55:11 +0800
Message-Id: <20260421045511.2401316-1-dapeng1.mi@linux.intel.com>
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

Additionally, enhance ratio_to_prev test to verify ACR sampling as well
if ACR is supported.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---

V3: Move ratio-to-prev ACR sampling test into ratio_to_prev test.
V2: https://lore.kernel.org/all/20260420025501.2133495-1-dapeng1.mi@linux.intel.com/
v1: https://lore.kernel.org/all/20260413010920.546501-1-dapeng1.mi@linux.intel.com/

 tools/perf/tests/shell/record.sh | 92 +++++++++++++++++++++++++++++++-
 1 file changed, 91 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 7cb81cf3444a..091d8b0a998b 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -402,7 +402,52 @@ test_callgraph() {
   echo "Callgraph test [Success]"
 }
 
+test_acr_sampling() {
+  events="{instructions/period=40000,acr_mask=0x2/u,cycles/period=20000,acr_mask=0x3/u}"
+  pebs_events="{instructions/period=40000,acr_mask=0x2/pu,cycles/period=20000,acr_mask=0x3/u}"
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
+    echo "Auto counter reload sampling [Success]"
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
+  echo "Auto counter reload sampling [Success]"
+}
+
 test_ratio_to_prev() {
+  ratio_events="{instructions:u,cycles/period=20000,ratio-to-prev=0.5/u}"
+  p_core_ratio_events="{cpu_core/instructions/u,cpu_core/cycles,period=20000,ratio-to-prev=0.5/u}"
+  e_core_ratio_events="{cpu_atom/instructions/u,cpu_atom/cycles,period=20000,ratio-to-prev=0.5/u}"
   echo "ratio-to-prev test"
   if ! perf record -o /dev/null -e "{instructions, cycles/period=100000,ratio-to-prev=0.5/}" \
      true 2> /dev/null
@@ -438,7 +483,51 @@ test_ratio_to_prev() {
     err=1
     return
   fi
-  echo "Basic ratio-to-prev record test [Success]"
+
+  ratio_err=0
+  do_ratio_to_prev_test() {
+    local events=$1
+    local cpu=$2
+    if ! perf record -o "${perfdata}" -e "${events}" ${testprog} 2> /dev/null
+    then
+      echo "Auto counter reload ${cpu} ratio-to-prev sampling [Failed sampling]"
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
+    echo "Basic ratio-to-prev record test [Success]"
+  else
+    err="${ratio_err}"
+  fi
 }
 
 # raise the limit of file descriptors to minimum
@@ -457,6 +546,7 @@ test_leader_sampling
 test_topdown_leader_sampling
 test_precise_max
 test_callgraph
+test_acr_sampling
 test_ratio_to_prev
 
 # restore the default value
-- 
2.34.1

