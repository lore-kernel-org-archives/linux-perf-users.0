Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85EC2EEE9E;
	Mon, 14 Sep 2026 01:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789350494; cv=none; b=DYd/feD7nzM0427qz9ixUqtgd0C0GLgD5jNCACsUtk2EmRAdQYoDJLzpKJgNgFZfOlMQEXjZOyyMSLNYXW1Tm6FIn/ut0t5hRpIZZkehxGsspAhK87R4jXiW64xz3aFLNAccRnUE971CIlafNn2L0GaMGS9ygsgHYeYmz0PsV58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789350494; c=relaxed/simple;
	bh=3k4dHHAQgRhnz/MSVa2Gpp3owSU0q+6cQsAxOo2vevc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z3v6ohcyVPibvOp9lrN8RApM91m2Mf+TK16D4GbYOx9LrpyBa600l7quNIyTbr6rurHUMruTVbcqA1fXV/c2c1AJMFL4zVvPXyBTNtbsHdNVkkrxp5ofKZeQK8K1PebmQLZO2gSRGXuLj9Do1rxwbOTYjh9eovjdX9k9OEKYti4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SC4YDcaQ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SC4YDcaQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789350493; x=1820886493;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3k4dHHAQgRhnz/MSVa2Gpp3owSU0q+6cQsAxOo2vevc=;
  b=SC4YDcaQwIq8FQNb1kKiItunGXtyzao8e7qhp+PaGX2tr+Tdmeh6hyc7
   Ge4U7SveXxXbpRlyGWkfwvQ9HHD4f4iKqgrW7bSLj97159YJ4javlzIvI
   lZuYaqgrjzExwNPUUA9MUwiaCqSVB9fOIr86i4OCUopm0AUwadCdoYDfs
   Dl8ubwu2puXglRJEWxf1vGiYTk4qD6ndaqKKOjxFoVEusAxIXK6UbbByw
   azpAO3VVNbSxWUGGjtPXIPDDi55PhpVpRXuae6PTeaXE+0Zy+Lm0qwSvh
   Fyl9MqkKvNPuJEu4/Jm01YJFHrJh9jpaB6er58KWWV1kevh6hPnI8GR17
   Q==;
X-CSE-ConnectionGUID: hvUI2amwRPC3uNJr7ga8Vw==
X-CSE-MsgGUID: SIFC9qOSQSOQb8EDsxm+4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="93530681"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="93530681"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2026 18:48:12 -0700
X-CSE-ConnectionGUID: piGOGha+T2SG28pvNsw47Q==
X-CSE-MsgGUID: wChlE/zRTgaVxm+rvA6DNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="276664237"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa005.jf.intel.com with ESMTP; 13 Sep 2026 18:48:08 -0700
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
Subject: [Patch v11 09/10] perf tests: Add x86 eGPRs/SSP registers sampling test
Date: Mon, 14 Sep 2026 09:40:48 +0800
Message-Id: <20260914014049.2061519-10-dapeng1.mi@linux.intel.com>
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

Validate that eGPRs (extended general purpose registers) and SSP
(shadow stack pointer) registers can be sampled correctly on x86
platforms.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/tests/shell/record.sh | 119 +++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 625240809fce..770a546f8d45 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -131,6 +131,124 @@ check_system_wide() {
   perf report -i "${perfdata}" -q | grep -q "${testsym}"
 }
 
+check_ext_reg_capture() {
+  local script_field="$1"
+  local ext_reg="$2"
+
+  perf script -F ip,sym,"${script_field}" -i "${perfdata}" 2>/dev/null | \
+  grep -q -i "${ext_reg}:"
+}
+
+get_x86_extended_regs() {
+  local advertised_ext_regs="$1"
+  local ext_regs=""
+
+  if echo "${advertised_ext_regs}" | grep -q -i R16
+  then
+    ext_regs="${ext_regs} R16"
+  fi
+  if echo "${advertised_ext_regs}" | grep -q -i R31
+  then
+    ext_regs="${ext_regs} R31"
+  fi
+  if echo "${advertised_ext_regs}" | grep -q -i SSP
+  then
+    ext_regs="${ext_regs} SSP"
+  fi
+
+  echo "${ext_regs}" | xargs
+}
+
+validate_extd_regs_sampling() {
+  local regs_opt="$1"
+  local extd_regs="$2"
+  local script_field="$3"
+  local ret=0
+  local reg
+
+  for reg in ${extd_regs}
+  do
+    perf_record_with_retry "${perfdata}" \
+      "check_ext_reg_capture ${script_field} ${reg}" "perf test -w thloop" \
+      -e br_inst_retired.near_call ${regs_opt}=${reg} -c 1000 \
+      --per-thread || ret=$?
+
+    if [ $ret -ne 0 ]
+    then
+      echo "Extended register capture test [Failed record ${regs_opt}=${reg}]"
+      return 1
+    fi
+  done
+
+  return 0
+}
+
+test_extd_register_capture() {
+  local arch
+  local intr_regs
+  local user_regs
+  local intr_ext_regs
+  local user_ext_regs
+  local tested=0
+
+  echo "Extended register capture test"
+  if ! perf list pmu | grep -q 'br_inst_retired.near_call'
+  then
+    echo "Extended register capture test [Skipped missing event]"
+    return
+  fi
+
+  intr_regs=$(perf record --intr-regs=\? 2>&1 || true)
+  user_regs=$(perf record --user-regs=\? 2>&1 || true)
+
+  intr_ext_regs=""
+  user_ext_regs=""
+
+  arch=$(uname -m)
+  case ${arch} in
+  x86_64|i386)
+    intr_ext_regs=$(get_x86_extended_regs "${intr_regs}")
+    user_ext_regs=$(get_x86_extended_regs "${user_regs}")
+    ;;
+  *)
+    echo "Extended register capture test [Skipped non-x86 platform]"
+    return
+    ;;
+  esac
+
+  if [ -z "${intr_ext_regs}" ]
+  then
+    echo "Extended register capture test [Skipped missing intr extended registers]"
+  elif ! validate_extd_regs_sampling "--intr-regs" "${intr_ext_regs}" "iregs"
+  then
+    echo "Extended register capture test [Failed intr extended register sampling]"
+    err=1
+    return
+  else
+    tested=1
+  fi
+
+  if [ -z "${user_ext_regs}" ]
+  then
+    echo "Extended register capture test [Skipped missing user extended registers]"
+  elif ! validate_extd_regs_sampling "--user-regs" "${user_ext_regs}" "uregs"
+  then
+    echo "Extended register capture test [Failed user extended register sampling]"
+    err=1
+    return
+  else
+    tested=1
+  fi
+
+  if [ ${tested} -eq 0 ]
+  then
+    echo "Extended register capture test [Skipped missing extended registers]"
+    return
+  fi
+
+  echo "Extended register capture test [Success]"
+}
+
 test_system_wide() {
   echo "Basic --system-wide mode test"
   local ret=0
@@ -491,6 +609,7 @@ fi
 
 test_per_thread
 test_register_capture
+test_extd_register_capture
 test_system_wide
 test_workload
 test_branch_counter
-- 
2.34.1

