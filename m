Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3658D1FEFBE;
	Thu, 14 Nov 2024 10:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731579468; cv=none; b=S+o1Ci25e1fT3E+Goyp9LbJenjzzOQHyhIl40ydpYrhRAHFmMj4JFMsKe90L0O0pVQR2627N80actR1OtPGcp5r2I04SNXw9YwNDrJG6Gbkz03ZYeRvEL9h8nYbzs0lUWucfcUi3fVSQatLoQ3HssHWpbhjv5R4bt10Tj4hfVtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731579468; c=relaxed/simple;
	bh=8P7g3If911f0PrtJhj9QLr/GhMEjTmsK8A98libHOKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uxKC/CeP2HycDPDaqnghRrPdHMFxbvDY6JdyFK107J5yD4oGVvRMsc6mK+HGGZ7H4zss+gNLy2FP/BKZt+FPhSYXqXx2hXGrHxg9kJnQiLKwHKNsxl32QueLE7Pd3OMGDvFxBzphHJDfVJh2W5eslzTSTz8UVRIxP/gwNoe1lXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YChD05Su; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YChD05Su"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731579468; x=1763115468;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8P7g3If911f0PrtJhj9QLr/GhMEjTmsK8A98libHOKQ=;
  b=YChD05SuVnIiyKdQYZKbHtz6xosBIvuDMF9mIjU06Wk0i4TgadaXkRl5
   VfA7yy4drEP+4/7TBW0fC9c/+MqniTGob1+dTVMybOWfOJi6ASO01oHrJ
   kuZZXksp4lBP7kf5OlhpolGbsiCKk1sHsuWPfyGmwRTyLDD8UfLq1kSyg
   9gVpBIUnXUD1eTSXNbBb25OCVvuJhrsNu3FOKzyS133Du9QsoioH0fajC
   jrlAKQZHAJNRAQ7twRy9Ghfnw6Bzt0Lsoc+QInt+9SwJN3Dknqj1G98qj
   /EJuxw1HHP1USTywokKrab+F/5M7HYjt6rmGQBL15xikrS8GkWs9v6SR5
   A==;
X-CSE-ConnectionGUID: Gy9cA/9jQ5eQOeUYjd4B6g==
X-CSE-MsgGUID: ChhDPTaWQpGa4A9gvrz+yQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31290570"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31290570"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 02:17:47 -0800
X-CSE-ConnectionGUID: IbJzKyjNSkm6BojqsmVn3Q==
X-CSE-MsgGUID: mPK15GQHSkqc5hWfShBq/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="88588040"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.ger.corp.intel.com) ([10.245.99.46])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 02:17:44 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Leo Yan <leo.yan@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH V15 7/7] perf intel-pt: Add a test for pause / resume
Date: Thu, 14 Nov 2024 12:17:10 +0200
Message-ID: <20241114101711.34987-8-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114101711.34987-1-adrian.hunter@intel.com>
References: <20241114101711.34987-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Add a simple sub-test to the "Miscellaneous Intel PT testing" test to
check pause / resume.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Ian Rogers <irogers@google.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/tests/shell/test_intel_pt.sh | 28 +++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
index e6f0070975f6..f3a9a040bacc 100755
--- a/tools/perf/tests/shell/test_intel_pt.sh
+++ b/tools/perf/tests/shell/test_intel_pt.sh
@@ -644,6 +644,33 @@ test_pipe()
 	return 0
 }
 
+test_pause_resume()
+{
+	echo "--- Test with pause / resume ---"
+	if ! perf_record_no_decode -o "${perfdatafile}" -e intel_pt/aux-action=start-paused/u uname ; then
+		echo "SKIP: pause / resume is not supported"
+		return 2
+	fi
+	if ! perf_record_no_bpf -o "${perfdatafile}" \
+			-e intel_pt/aux-action=start-paused/u \
+			-e instructions/period=50000,aux-action=resume,name=Resume/u \
+			-e instructions/period=100000,aux-action=pause,name=Pause/u uname  ; then
+		echo "perf record with pause / resume failed"
+		return 1
+	fi
+	if ! perf script -i "${perfdatafile}" --itrace=b -Fperiod,event | \
+			awk 'BEGIN {paused=1;branches=0}
+			     /Resume/ {paused=0}
+			     /branches/ {if (paused) exit 1;branches=1}
+			     /Pause/ {paused=1}
+			     END {if (!branches) exit 1}' ; then
+		echo "perf record with pause / resume failed"
+		return 1
+	fi
+	echo OK
+	return 0
+}
+
 count_result()
 {
 	if [ "$1" -eq 2 ] ; then
@@ -672,6 +699,7 @@ test_power_event			|| ret=$? ; count_result $ret ; ret=0
 test_no_tnt				|| ret=$? ; count_result $ret ; ret=0
 test_event_trace			|| ret=$? ; count_result $ret ; ret=0
 test_pipe				|| ret=$? ; count_result $ret ; ret=0
+test_pause_resume			|| ret=$? ; count_result $ret ; ret=0
 
 cleanup
 
-- 
2.43.0

