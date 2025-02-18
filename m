Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5C423FC40;
	Tue, 18 Feb 2025 08:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866518; cv=none; b=Iznkf2m/AjH+655o2u80cWYtLFWsaNY8JAuSLIeXJ9SAHAdUOHcaK5ZgjgAkuicqccMGuJFQmN1ZhauFwXR3UugyPk3wZxYb5Ow/ZM8DptVcbfpyShfYYgPxy4122Hoz3GXGddnKPKAf0LPASdb7B2iuipsmorUpTsPNv47oEvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866518; c=relaxed/simple;
	bh=z8tAD9zaxuzIlqzE32+Zvrc3lbsY4IkgS8q2NB9ON2M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HFKdEw+SqB1Kpf/eS+DZZychnqW3jj+KUP9oaFq1KxbqlU3nabeq5F+FpdcIuAKo5U0c5PFwWY/VxFklnIGeSwz5DG7vMsmnYpEC+YzcotfTHf8BdwU4T6zyGscn2hAmq1oiqPWQ1TMDEO80Bk5P8rMXvYlQMCowulMHDqwfZv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h4YjUHAu; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h4YjUHAu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739866518; x=1771402518;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z8tAD9zaxuzIlqzE32+Zvrc3lbsY4IkgS8q2NB9ON2M=;
  b=h4YjUHAuxFib2iwwC90e1nt7Nbj2hHweYbxHnXGnOxS8+CODOBUwp5Z6
   XYwkfLlSCvv0C2gQepcARkYxexXDp/EXimYilFlSDHgrNEAoir0MPC7Vm
   iesD5bifazu9lEyk1x8t/BVPhgW/zJYtpb3SssaZLB9oQvTE8YHV7rf92
   pDBQMxhWroxvxYApTi8E1r2wi9OZiWaZykANyrXfXd4DYr1pk1BUpEv+O
   QqyD+M5QckGfog+SUANApZuyxN28Y7s7cxZb5eKoJNvJaaB61lR64o6PC
   56giJ47WiBuioZW/sEkqKn0Ma92SZcq0b3GFeEHrs/TdwoswzUOOD6pQZ
   A==;
X-CSE-ConnectionGUID: /jYUgfoTS6Ok3KxL0jZ7+w==
X-CSE-MsgGUID: jZNeb/kiTZ+DRC6zqW0Omg==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44200904"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="44200904"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 00:15:18 -0800
X-CSE-ConnectionGUID: pRx7/tIUR0ypaRNxm4jbNw==
X-CSE-MsgGUID: swntbCNAQYS2yVwSPrh6OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="145166372"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa002.jf.intel.com with ESMTP; 18 Feb 2025 00:15:13 -0800
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v2 23/24] perf tools/tests: Add vector registers PEBS sampling test
Date: Tue, 18 Feb 2025 15:28:17 +0000
Message-Id: <20250218152818.158614-24-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
References: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current adaptive PEBS supports to capture some vector registers like XMM
register, and arch-PEBS supports to capture wider vector registers like
YMM and ZMM registers. This patch adds a perf test case to verify these
vector registers can be captured correctly.

Suggested-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/tests/shell/record.sh | 55 ++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 0fc7a909ae9b..521eaa1972f9 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -116,6 +116,60 @@ test_register_capture() {
   echo "Register capture test [Success]"
 }
 
+test_vec_register_capture() {
+  echo "Vector register capture test"
+  if ! perf record -o /dev/null --quiet -e instructions:p true 2> /dev/null
+  then
+    echo "Vector register capture test [Skipped missing event]"
+    return
+  fi
+  if ! perf record --intr-regs=\? 2>&1 | grep -q 'XMM0'
+  then
+    echo "Vector register capture test [Skipped missing XMM registers]"
+    return
+  fi
+  if ! perf record -o - --intr-regs=xmm0 -e instructions:p \
+    -c 100000 ${testprog} 2> /dev/null \
+    | perf script -F ip,sym,iregs -i - 2> /dev/null \
+    | grep -q "XMM0:"
+  then
+    echo "Vector register capture test [Failed missing XMM output]"
+    err=1
+    return
+  fi
+  echo "Vector registe (XMM) capture test [Success]"
+  if ! perf record --intr-regs=\? 2>&1 | grep -q 'YMMH0'
+  then
+    echo "Vector register capture test [Skipped missing YMM registers]"
+    return
+  fi
+  if ! perf record -o - --intr-regs=ymmh0 -e instructions:p \
+    -c 100000 ${testprog} 2> /dev/null \
+    | perf script -F ip,sym,iregs -i - 2> /dev/null \
+    | grep -q "YMMH0:"
+  then
+    echo "Vector register capture test [Failed missing YMMH output]"
+    err=1
+    return
+  fi
+  echo "Vector registe (YMM) capture test [Success]"
+  if ! perf record --intr-regs=\? 2>&1 | grep -q 'ZMMH0'
+  then
+    echo "Vector register capture test [Skipped missing ZMM registers]"
+    return
+  fi
+  if ! perf record -o - --intr-regs=zmmh0 -e instructions:p \
+    -c 100000 ${testprog} 2> /dev/null \
+    | perf script -F ip,sym,iregs -i - 2> /dev/null \
+    | grep -q "ZMMH0:"
+  then
+    echo "Vector register capture test [Failed missing ZMMH output]"
+    err=1
+    return
+  fi
+  echo "Vector registe (ZMM) capture test [Success]"
+}
+
 test_system_wide() {
   echo "Basic --system-wide mode test"
   if ! perf record -aB --synth=no -o "${perfdata}" ${testprog} 2> /dev/null
@@ -303,6 +357,7 @@ fi
 
 test_per_thread
 test_register_capture
+test_vec_register_capture
 test_system_wide
 test_workload
 test_branch_counter
-- 
2.40.1

