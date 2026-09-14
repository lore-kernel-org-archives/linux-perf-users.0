Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399622FE074;
	Mon, 14 Sep 2026 01:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789350498; cv=none; b=iB2Lw9xdPrDBC3I90TcK/8DvkS0Uo2LHF+M9yddSpWcQUc5dQd031yWg5H2lfznBohIyuXEMyTWPYLM1ssYXrd2HnS6PTaM2ObGk0st0bJGTd0eJF8EDlhO1S99+mZG/NsHEOyYwjYJ6JFQFAG91YWqL0hyw4eOXv1+C1bMgR/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789350498; c=relaxed/simple;
	bh=3kFg9Qpz7u59REwfaQSuPRHtJv7hZafpOxBAJnX5ADA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HlJtyr+A6XslTaSBWnCxo4IWC1pNJO8qbc+o70tytNmFxjbjdTCJa/p0cWvEIY2o0KifNhC3fCMSrwoqca2pRGuf0ys0SLMlgdJqB1cLb7kkQ402/FwI7Q+XbPzbSmYw0DVhvFH2mPaOx5kqUpd+eAvWNaRHy6wU5RVFEeOuUXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V8lotReU; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V8lotReU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789350497; x=1820886497;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3kFg9Qpz7u59REwfaQSuPRHtJv7hZafpOxBAJnX5ADA=;
  b=V8lotReUdrWpdZKwV+OZAxPDsg/5v9cM6S7E6CPkDA33k/C5FQ3FgXMJ
   nvWNfksGTiYPG2coV6q2ELaQE/2aZRK1xXlRH1MmQ7y3SoyIn2SZNZv/K
   CL+gHb0oCVggzptnFJbNIdUmhM5plsoNOYBtLX+0j0kwM4YmbiDL2cKvt
   mc70otuyd1OL9D2ILX8QqdLSmx9uqUch3F3tCCXIC0S8wVw7bEfa18Ms7
   hqnx0mzoYjZ8AUnd4iauOsbWxNVDsrqNM0PQGcvurluE0BeH+1abhEMIL
   ZZstA6cwQF27TTKty8Pzb5AcwWe46gmG53zSvWkRiUVzVj9QK6Fool/4o
   w==;
X-CSE-ConnectionGUID: uS7kDkVOS26H2kvgTrA2fQ==
X-CSE-MsgGUID: c1DME0MdRZ2smMgSVBbOog==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="93530688"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="93530688"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2026 18:48:17 -0700
X-CSE-ConnectionGUID: iSt2LkgZTaeaazQyk1VSYQ==
X-CSE-MsgGUID: PZ/rz66tRlqG+LzlZ1Y9aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="276664245"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa005.jf.intel.com with ESMTP; 13 Sep 2026 18:48:13 -0700
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
Subject: [Patch v11 10/10] perf tests: Add SIMD registers sampling test
Date: Mon, 14 Sep 2026 09:40:49 +0800
Message-Id: <20260914014049.2061519-11-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914014049.2061519-1-dapeng1.mi@linux.intel.com>
References: <20260914014049.2061519-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Validate that SIMD registers (XMM/YMM/ZMM/OPMASK on x86) can be sampled
correctly with hardware support.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/tests/shell/record.sh | 138 +++++++++++++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 770a546f8d45..4a4931cb5ba9 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -249,6 +249,143 @@ test_extd_register_capture() {
   echo "Extended register capture test [Success]"
 }
 
+extract_x86_advertised_simd_classes() {
+  local regs_output="$1"
+
+  echo "${regs_output}" \
+    | grep -oE '(ZMM|YMM|XMM|OPMASK)[0-9]+-[0-9]+' \
+    | sed -E 's/[0-9]+-[0-9]+$//' \
+    | tr '[:upper:]' '[:lower:]' \
+    | sort -u
+}
+
+ordered_x86_simd_classes() {
+  local advertised_classes="$1"
+  local simd_classes=""
+
+  if echo "${advertised_classes}" | grep -qw zmm
+  then
+    simd_classes="${simd_classes} zmm"
+  fi
+  if echo "${advertised_classes}" | grep -qw ymm
+  then
+    simd_classes="${simd_classes} ymm"
+  fi
+  if echo "${advertised_classes}" | grep -qw xmm
+  then
+    simd_classes="${simd_classes} xmm"
+  fi
+  if echo "${advertised_classes}" | grep -qw opmask
+  then
+    simd_classes="${simd_classes} opmask"
+  fi
+
+  echo "${simd_classes}" | xargs
+}
+
+check_simd_reg_capture() {
+  local script_field="$1"
+  local simd_reg="$2"
+
+  perf script -F ip,sym,"${script_field}" -i "${perfdata}" 2>/dev/null | \
+  grep -q -i "${simd_reg}\["
+}
+
+validate_simd_regs_sampling() {
+  local regs_opt="$1"
+  local simd_classes="$2"
+  local script_field="$3"
+  local simd_class
+  local ret=0
+
+  for simd_class in ${simd_classes}
+  do
+    perf_record_with_retry "${perfdata}" \
+      "check_simd_reg_capture ${script_field} ${simd_class}" "perf test -w thloop" \
+      -e br_inst_retired.near_call ${regs_opt}=${simd_class} -c 1000 \
+      --per-thread || ret=$?
+
+    if [ $ret -ne 0 ]
+    then
+      echo "SIMD register capture test [Failed record ${regs_opt}=${simd_class}]"
+      return 1
+    fi
+  done
+
+  return 0
+}
+
+test_simd_register_capture() {
+  local arch
+  local intr_regs
+  local user_regs
+  local simd_classes
+  local user_simd_classes
+  local advertised_intr_classes
+  local advertised_user_classes
+  local tested=0
+
+  echo "SIMD register capture test"
+  if ! perf list pmu | grep -q 'br_inst_retired.near_call'
+  then
+    echo "SIMD register capture test [Skipped missing event]"
+    return
+  fi
+
+  intr_regs=$(perf record --intr-regs=\? 2>&1 || true)
+  user_regs=$(perf record --user-regs=\? 2>&1 || true)
+
+  simd_classes=""
+  user_simd_classes=""
+
+  arch=$(uname -m)
+  case ${arch} in
+  x86_64|i386)
+    advertised_intr_classes=$(extract_x86_advertised_simd_classes "${intr_regs}")
+    advertised_user_classes=$(extract_x86_advertised_simd_classes "${user_regs}")
+
+    simd_classes=$(ordered_x86_simd_classes "${advertised_intr_classes}")
+    user_simd_classes=$(ordered_x86_simd_classes "${advertised_user_classes}")
+    ;;
+  *)
+    echo "SIMD register capture test [Skipped non-x86 platform]"
+    return
+    ;;
+  esac
+
+  if [ -z "${simd_classes}" ]
+  then
+    echo "SIMD register capture test [Skipped missing intr SIMD registers]"
+  elif ! validate_simd_regs_sampling "--intr-regs" "${simd_classes}" "iregs"
+  then
+    echo "SIMD register capture test [Failed intr SIMD register sampling]"
+    err=1
+    return
+  else
+    tested=1
+  fi
+
+  if [ -z "${user_simd_classes}" ]
+  then
+    echo "SIMD register capture test [Skipped missing user SIMD registers]"
+  elif ! validate_simd_regs_sampling "--user-regs" "${user_simd_classes}" "uregs"
+  then
+    echo "SIMD register capture test [Failed user SIMD register sampling]"
+    err=1
+    return
+  else
+    tested=1
+  fi
+
+  if [ ${tested} -eq 0 ]
+  then
+    echo "SIMD register capture test [Skipped missing SIMD registers]"
+    return
+  fi
+
+  echo "SIMD register capture test [Success]"
+}
+
 test_system_wide() {
   echo "Basic --system-wide mode test"
   local ret=0
@@ -610,6 +747,7 @@ fi
 test_per_thread
 test_register_capture
 test_extd_register_capture
+test_simd_register_capture
 test_system_wide
 test_workload
 test_branch_counter
-- 
2.34.1

