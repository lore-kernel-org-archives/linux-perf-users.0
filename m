Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22EE3AC0C6;
	Mon,  6 Jul 2026 02:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783305685; cv=none; b=WOoB0ZZBaA8qzUOo+tp7jNTPRzJTeoTWaCOjjMIv05/gSEbaZb44hxPGCLPK5BoEjwqSeOZGtSCglvc5Srbf/TmW7xIuAmRzauyvD2oGL3hkODoumpZU59d20jrDGrnJpq6Zk6yD8g9KhvstoXJu9E/u+EbV2ukc90kO9/3lShQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783305685; c=relaxed/simple;
	bh=eGurDYf/D5z9eZ/1LtNwffYr/Apbq/wVscCnbbSgTls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UmAEBzPW9f6DGg1Q8EOYbS+ZleJo8lLB1YoJAs5L3REBHMjPyDu5B+n+dzXnfAFCd2D2sPNW6UGvgqYjHNqRdHZMEGhwsGP+doXsZZ+128oR5mtTtd4RYJz5ep53VjmI9eJtDNi4A9mryOWMTO04i1xdLdoy3U6ZFXXmEcVoxns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bxSzzBv8; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bxSzzBv8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783305684; x=1814841684;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eGurDYf/D5z9eZ/1LtNwffYr/Apbq/wVscCnbbSgTls=;
  b=bxSzzBv8L6ZQGB0dAnfE9eP5AKhl+LVg8JDLtY7RwzKR8KTtZDM6ySge
   1N0SMA88BKuOVF0/qbYqmZbT7mE1uV4M1Z+ksWx4z7Ln8pXGlRnt5xPIi
   j67MhqQ4j9M5bv7BahCNTXJxGgChCYjea/4yBDq1D0AZbzOIdK6A0zwaB
   Ozyb7f1fLsO5kHqY4kmis4/Uz31C+k0trfyPlGVLfTDxX3tzwxAhDjaO7
   SXN+VcsxZhu4Yf/dawZPMw6BM7wuhqMEDYUgyiFrEfjV+E3Tn/fF/O/Ph
   Dz5Yyken7CLymm+Oi6tiJOKaRImG3Rbw2DpX2kdhlGp/U1HBIWEzhUyLP
   g==;
X-CSE-ConnectionGUID: iUOBFqF0T3ejB9WJQhqLFQ==
X-CSE-MsgGUID: dR9AeKQvRBmnZ9HoTB6BXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="87614080"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="87614080"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2026 19:41:24 -0700
X-CSE-ConnectionGUID: e/T/4JTuRFqX1dRB5x5pDw==
X-CSE-MsgGUID: +zBW605sQHGHwtkXWKIFxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="253716751"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa007.jf.intel.com with ESMTP; 05 Jul 2026 19:41:20 -0700
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
Subject: [Patch v9 10/10] perf tests: Add SIMD registers sampling test
Date: Mon,  6 Jul 2026 10:34:44 +0800
Message-Id: <20260706023444.3067660-11-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706023444.3067660-1-dapeng1.mi@linux.intel.com>
References: <20260706023444.3067660-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Validate that SIMD registers (XMM/YMM/ZMM on x86) can be sampled
correctly with hardware support.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/tests/shell/record.sh | 131 +++++++++++++++++++++++++++++++
 1 file changed, 131 insertions(+)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 48c722e563e2..c98d8028d0b7 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -256,6 +256,136 @@ test_egpr_register_capture() {
   echo "eGPR/SSP register capture test [Success]"
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
+validate_simd_sampling_mode() {
+  local regs_opt="$1"
+  local simd_classes="$2"
+  local script_field="$3"
+  local simd_class
+  local sample_output
+
+  for simd_class in ${simd_classes}
+  do
+    if ! sample_output=$(perf record -o - "${regs_opt}=${simd_class}" \
+      -e br_inst_retired.near_call -c 1000 --per-thread ${testprog} 2> /dev/null \
+      | perf script -F ip,sym,"${script_field}" -i - 2> /dev/null)
+    then
+      echo "SIMD register capture test [Failed record ${regs_opt}=${simd_class}]"
+      return 1
+    fi
+
+    if ! has_required_regs "${sample_output}" "${simd_class}"
+    then
+      echo "SIMD register capture test [Failed missing ${simd_class} sampling data]"
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
+    ;;
+  esac
+
+  if [ -z "${simd_classes}" ]
+  then
+    echo "SIMD register capture test [Skipped missing intr SIMD registers]"
+  elif ! validate_simd_sampling_mode "--intr-regs" "${simd_classes}" "iregs"
+  then
+    echo "SIMD register capture test [Failed missing intr SIMD register sampling data]"
+    err=1
+    return
+  else
+    tested=1
+  fi
+
+  if [ -z "${user_simd_classes}" ]
+  then
+    echo "SIMD register capture test [Skipped missing user SIMD registers]"
+  elif ! validate_simd_sampling_mode "--user-regs" "${user_simd_classes}" "uregs"
+  then
+    echo "SIMD register capture test [Failed missing user SIMD register sampling data]"
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
@@ -575,6 +705,7 @@ fi
 test_per_thread
 test_register_capture
 test_egpr_register_capture
+test_simd_register_capture
 test_system_wide
 test_workload
 test_branch_counter
-- 
2.34.1

