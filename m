Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCC1292929;
	Tue, 15 Apr 2025 08:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744705470; cv=none; b=lhb72jTOnAmosvwiDCJnqvSPdxcj/ffiDUxVm6x+Us46cxNSSWsHuQ1+UUOH2LxtUmIsu83lAP3dLarowOaTbz/O+OkDyfzXGKjz/opymFU7Krw2oCLHiDlrBfPVHkzGchfShRsJZ15HXxWa8Biz+17J5V9DvpQ8Eta3BIWErYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744705470; c=relaxed/simple;
	bh=K0PCFpqXR+BoZPRcggrk+ij0mfJByFEiMMV0vPkyapU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qfw0ajrMgg5vPpRBOcBitVYWyiobMsoSOrG8jvM0pQ8s7wfoBWJdc8kknsE6J726Ny2E8ZN6nK7xjlnbY1P9TDkEBKgsFRgPHtFlXcUSz3LLDSGIv/gRaA3vgpy51yKj1pKem3/MkrKaeYWn+EYa4N4tWpcBUCt0sZr1XlzReDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CnPGop0P; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CnPGop0P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744705470; x=1776241470;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K0PCFpqXR+BoZPRcggrk+ij0mfJByFEiMMV0vPkyapU=;
  b=CnPGop0PyLV5WMZ2JW31uRnxixmiB5KQZ9X0Ai/AKzBtxoZiNRuO8g9+
   ez4tLwnPtxNPnGfQXiJsTxagYtkNIgA7/L+agE7uDG7P2dTCvQHWD/2iF
   QO0JQrI8bo4a3bSGuN01eYeV3breAr3gKxxOiSG/HDxC+3M50PIVl0Ohp
   kahINo1rTHqF6Kro9nR31qhGOY/fS+9122G66Y9roK2czW0IyViUc8Q0q
   JlMzspxz7hnfymGprBQDcmVniahaZZI0osRuq/SaXoC74s1lYxfNsltr0
   xbIwpwkuV2VmR4sz0ili9t3h8QXmEuTUnPVtt2WKHtd67IZ3YsUfk9jsv
   A==;
X-CSE-ConnectionGUID: UYyPPPsdRc+Rmc31Qyrt6w==
X-CSE-MsgGUID: iwlnnQEYSp6EB5AZ84JPPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="46116255"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="46116255"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 01:24:29 -0700
X-CSE-ConnectionGUID: J+C/4w8mTbaacM+yta7nPw==
X-CSE-MsgGUID: sChUOHhzTiqcxunNh4+LMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="130055727"
Received: from emr.sh.intel.com ([10.112.229.56])
  by fmviesa007.fm.intel.com with ESMTP; 15 Apr 2025 01:24:25 -0700
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
Subject: [Patch v3 22/22] perf tools/tests: Add vector registers PEBS sampling test
Date: Tue, 15 Apr 2025 11:44:28 +0000
Message-Id: <20250415114428.341182-23-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250415114428.341182-1-dapeng1.mi@linux.intel.com>
References: <20250415114428.341182-1-dapeng1.mi@linux.intel.com>
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
index ba8d873d3ca7..d85aab09902b 100755
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
+  if ! perf record --intr-regs=\? 2>&1 | grep -q 'YMM0'
+  then
+    echo "Vector register capture test [Skipped missing YMM registers]"
+    return
+  fi
+  if ! perf record -o - --intr-regs=ymm0 -e instructions:p \
+    -c 100000 ${testprog} 2> /dev/null \
+    | perf script -F ip,sym,iregs -i - 2> /dev/null \
+    | grep -q "YMM0:"
+  then
+    echo "Vector register capture test [Failed missing YMM output]"
+    err=1
+    return
+  fi
+  echo "Vector registe (YMM) capture test [Success]"
+  if ! perf record --intr-regs=\? 2>&1 | grep -q 'ZMM0'
+  then
+    echo "Vector register capture test [Skipped missing ZMM registers]"
+    return
+  fi
+  if ! perf record -o - --intr-regs=zmm0 -e instructions:p \
+    -c 100000 ${testprog} 2> /dev/null \
+    | perf script -F ip,sym,iregs -i - 2> /dev/null \
+    | grep -q "ZMM0:"
+  then
+    echo "Vector register capture test [Failed missing ZMM output]"
+    err=1
+    return
+  fi
+  echo "Vector register (ZMM) capture test [Success]"
+}
+
 test_system_wide() {
   echo "Basic --system-wide mode test"
   if ! perf record -aB --synth=no -o "${perfdata}" ${testprog} 2> /dev/null
@@ -318,6 +372,7 @@ fi
 
 test_per_thread
 test_register_capture
+test_vec_register_capture
 test_system_wide
 test_workload
 test_branch_counter
-- 
2.40.1

