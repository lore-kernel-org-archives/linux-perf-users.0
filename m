Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012D7433055;
	Tue, 21 Jul 2026 07:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784619265; cv=none; b=Oz6Y88plpWtbDDZiDtzAcvd9Q8hUOERhVdH2E5BFKICtdqyxh1jmroiZ3eUviiUYHEs9QykHGjNO8pWfHnV3azLPoAK9bfA2r+Z7Sr6keY8os/elu6Ic28ef6j8zdVYGBgN7Mmcuj5XMWfw0IkUe0DAjUHZ6fx4JVkHYfvlmM/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784619265; c=relaxed/simple;
	bh=GnOvDqHxRNPBZiYmxFmjGmCnqBHFyMvO0RqKNPqgeJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rw4PB44vKj2FXMjKIFlagSHFfMY0ODA9kwR1lHicecL0KYR1lTy93ikl3elZZN4LaTzRGlb8xK5F4SYETVMZlUtansdK+xPXU5pK3TyxNEJ2TqIddhyLBAz32ad5prOGeemZ0Aelq6l2Levez4brGFKWzMb6URhICCkYtYLSdfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bICBtjLt; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bICBtjLt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784619264; x=1816155264;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GnOvDqHxRNPBZiYmxFmjGmCnqBHFyMvO0RqKNPqgeJ4=;
  b=bICBtjLtMgtRhLAMKUVOg5Pv/+z1khwANzWlj4EkTZuzcR2OueOw/Grr
   Km9Gfif/eQ+oKrUsTF+PTs4J8Uj22ALTpGjc5S8zYuOsmCeomyb+YZyXQ
   rg48Uw67mUXISGSeoVpEMHMFgZ84jHbYC2T+xb5OmoY+oA9RbpxLQRdY5
   HyfYx3d4/QrIRHyHDstMSwU0jmvNOyf0dAUr9VtEli4K2XZKbqlY3gv9/
   WjcAT1LKRu2tz+SD45XENJ2D+myWwISS3k4EbjLTrq3V4RKi6KRSJUouo
   8YDd3JgHgklte7hYlF5k9siEOr9nGRM76nMP6SAz97x6Zk5qjMXvxRbER
   w==;
X-CSE-ConnectionGUID: JtpCqE2gRI6rukfBWDM0Lw==
X-CSE-MsgGUID: b/OnRnVfRuCotPU2MiUo2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="84190175"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="84190175"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 00:34:23 -0700
X-CSE-ConnectionGUID: eEQPfHD8Q4KeVn/s6LH11A==
X-CSE-MsgGUID: kme5jQ2DQ4+vPulXe0lcYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="256484586"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa010.jf.intel.com with ESMTP; 21 Jul 2026 00:34:21 -0700
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
Subject: [Patch v10 10/10] perf tests: Add SIMD registers sampling test
Date: Tue, 21 Jul 2026 15:27:07 +0800
Message-Id: <20260721072707.3787848-11-dapeng1.mi@linux.intel.com>
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

Validate that SIMD registers (XMM/YMM/ZMM on x86) can be sampled
correctly with hardware support.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/tests/shell/record.sh | 131 +++++++++++++++++++++++++++++++
 1 file changed, 131 insertions(+)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 3c17f68ceb92..4a8539a65fa8 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -252,6 +252,136 @@ test_egpr_register_capture() {
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
 check_system_wide() {
   perf report -i "${perfdata}" -q | grep -q "${testsym}"
 }
@@ -617,6 +747,7 @@ fi
 test_per_thread
 test_register_capture
 test_egpr_register_capture
+test_simd_register_capture
 test_system_wide
 test_workload
 test_branch_counter
-- 
2.34.1

