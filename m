Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4818B435526;
	Tue, 21 Jul 2026 07:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784619262; cv=none; b=PVLCyzAWTcyLjxWhBUZ0flV6vPSVrmLamHjvCfTxw3MBzdTSY76xAnD32SFhMKoWAHocZ1LYOfSfe7DiCHprZGP7z5/TUaY1gfyoIT82JchIrox/OzZ1tIJz3mvV1uSCYgmetcntvbLGGcssfHRRvlicOkSKigBivfQ8uZVGYEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784619262; c=relaxed/simple;
	bh=ZlrKCpd6oTxmFtSiRfBHCacb/aL/7Dj9vR4pzbLssA4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P65z7wglG8VEBvlU+kuUY550vodHBsy6YQN/t9jOEqXMqNRjMsrlUduAufCU0TpSv/DCLa/Hr7lGGUmctvaFE9kDpOTbnJm6VhCjuCdyyzueIA0OMrSqU3WsBc1A0vBwQKHP7y2jvyy90ZbVfjph1shJljyxdEMTRUiUvwVbPqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=emCVxJKN; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="emCVxJKN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784619260; x=1816155260;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZlrKCpd6oTxmFtSiRfBHCacb/aL/7Dj9vR4pzbLssA4=;
  b=emCVxJKNT62ZpGm0KGjuchKq3fWJUFA965CioxycDPSMHtb59685KgND
   G/iCQVdhq82X9doxhNgaxsaDJDHI9k0rpai28z+BwqeDN2GjXgKKqMfbL
   7ccu17RxZ4uG0vKIY6NkOF4g9lmc4YPiOASR+prZwrSEmqBl/CLcVXiRL
   sYYkqLcubftlO+blJaqIkYPfqRCgMka8EuSQ/wPtB0+BoxztiP43u3Nct
   9VgD1ILZtYA33qaFn8JS3gEDPB5ENcOJKZ90MTjEpqB5ww7r5VG1RCf2B
   25dxq/EoUnIfPzKg7Db/iOXN4sFe3sPQzXq6m0lpl1cHw2Cw3UmUADIST
   Q==;
X-CSE-ConnectionGUID: Ja/FY2HSRXy4YE/jg8F3+w==
X-CSE-MsgGUID: 1o+qCETMQ0m+puJ/hZeNPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="84190168"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="84190168"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 00:34:20 -0700
X-CSE-ConnectionGUID: tvAZQ4oFTZCcGCQc7ivBOg==
X-CSE-MsgGUID: cTT8RUj+QyCtRMKd1K/5vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="256484569"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa010.jf.intel.com with ESMTP; 21 Jul 2026 00:34:17 -0700
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
Subject: [Patch v10 09/10] perf tests: Add x86 eGPRs/SSP registers sampling test
Date: Tue, 21 Jul 2026 15:27:06 +0800
Message-Id: <20260721072707.3787848-10-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260721072707.3787848-1-dapeng1.mi@linux.intel.com>
References: <20260721072707.3787848-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Validate that eGPRs (extended general purpose registers) and SSP
(shadow stack pointer) registers can be sampled correctly on x86
platforms with hardware support.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/tests/shell/record.sh | 126 +++++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 625240809fce..3c17f68ceb92 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -127,6 +127,131 @@ test_register_capture() {
   echo "Register capture test [Success]"
 }
 
+has_required_regs() {
+  local regs_output="$1"
+  shift
+
+  for reg in "$@"
+  do
+    if ! echo "${regs_output}" | grep -q -i "${reg}"
+    then
+      return 1
+    fi
+  done
+
+  return 0
+}
+
+validate_gp_reg_sampling() {
+  local regs_opt="$1"
+  local regs_value="$2"
+  local script_field="$3"
+  local sample_output
+  shift 3
+
+  if ! sample_output=$(perf record -o - "${regs_opt}=${regs_value}" \
+    -e br_inst_retired.near_call -c 1000 --per-thread ${testprog} 2> /dev/null \
+    | perf script -F ip,sym,"${script_field}" -i - 2> /dev/null)
+  then
+    return 1
+  fi
+
+  if ! has_required_regs "${sample_output}" "$@"
+  then
+    return 1
+  fi
+
+  return 0
+}
+
+test_egpr_register_capture() {
+  local arch
+  local intr_regs
+  local user_regs
+  local tested=0
+
+  echo "eGPR/SSP register capture test"
+
+  arch=$(uname -m)
+  case ${arch} in
+  x86_64|i386)
+    ;;
+  *)
+    echo "eGPR/SSP register capture test [Skipped non-x86 platform]"
+    return
+    ;;
+  esac
+
+  if ! perf list pmu | grep -q 'br_inst_retired.near_call'
+  then
+    echo "eGPR/SSP register capture test [Skipped missing event]"
+    return
+  fi
+
+  intr_regs=$(perf record --intr-regs=\? 2>&1 || true)
+  user_regs=$(perf record --user-regs=\? 2>&1 || true)
+
+  if has_required_regs "${intr_regs}" R16 R31
+  then
+    if ! validate_gp_reg_sampling "--intr-regs" "r16,r31" "iregs" "R16:" "R31:"
+    then
+      echo "eGPR/SSP register capture test [Failed eGPR intr-regs validation]"
+      err=1
+      return
+    fi
+    tested=1
+  else
+    echo "eGPR/SSP register capture test [Skipped missing eGPR intr-regs (R16/R31)]"
+  fi
+
+  if has_required_regs "${user_regs}" R16 R31
+  then
+    if ! validate_gp_reg_sampling "--user-regs" "r16,r31" "uregs" "R16:" "R31:"
+    then
+      echo "eGPR/SSP register capture test [Failed eGPR user-regs validation]"
+      err=1
+      return
+    fi
+    tested=1
+  else
+    echo "eGPR/SSP register capture test [Skipped missing eGPR user-regs (R16/R31)]"
+  fi
+
+  if has_required_regs "${intr_regs}" SSP
+  then
+    if ! validate_gp_reg_sampling "--intr-regs" "ssp" "iregs" "SSP:"
+    then
+      echo "eGPR/SSP register capture test [Failed SSP intr-regs validation]"
+      err=1
+      return
+    fi
+    tested=1
+  else
+    echo "eGPR/SSP register capture test [Skipped missing SSP intr-regs]"
+  fi
+
+  if has_required_regs "${user_regs}" SSP
+  then
+    if ! validate_gp_reg_sampling "--user-regs" "ssp" "uregs" "SSP:"
+    then
+      echo "eGPR/SSP register capture test [Failed SSP user-regs validation]"
+      err=1
+      return
+    fi
+    tested=1
+  else
+    echo "eGPR/SSP register capture test [Skipped missing SSP user-regs]"
+  fi
+
+  if [ ${tested} -eq 0 ]
+  then
+    echo "eGPR/SSP register capture test [Skipped missing eGPR/SSP registers]"
+    return
+  fi
+
+  echo "eGPR/SSP register capture test [Success]"
+}
+
 check_system_wide() {
   perf report -i "${perfdata}" -q | grep -q "${testsym}"
 }
@@ -491,6 +616,7 @@ fi
 
 test_per_thread
 test_register_capture
+test_egpr_register_capture
 test_system_wide
 test_workload
 test_branch_counter
-- 
2.34.1

