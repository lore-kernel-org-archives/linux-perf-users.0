Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A601422AD;
	Fri, 28 Jun 2024 06:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719557570; cv=none; b=OqRVIpo92N8RotZigtjoTSlzs8/NGlByM4X5egQhbf8GJzYeJw6SBIQ4XMPsy84/lsUQc7AbFRLk7U5lgWpYw4dlQFF8AdiW6Eb9OowybnXNASd5Q/QS+eZ6DqI4u2bwN05e27rwtcy8S+Std2WcJZhiQnqoj+CcckZXh4V14PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719557570; c=relaxed/simple;
	bh=T3lYCZNDTOox5kJQOOR6Dbvex/BUJB0U27xJgGtdjGk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DXz3BHjLD+afDLPngIuMQ7yNxACrzZw4Tfm51w4YqwmhaDBrLYs52rjBGchhDu7Gx/CMAxkF4pqb1MK5kTpiVeKGysvFQjFgUbDXI1WCHzWvLEbGrXAs3FvKNYUdsMoh7T0Ua0yjbTmQgYD/dVLius1uyjugKCItTNCvf0hziRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=beQaqVMI; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="beQaqVMI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719557569; x=1751093569;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T3lYCZNDTOox5kJQOOR6Dbvex/BUJB0U27xJgGtdjGk=;
  b=beQaqVMIYhS7Y9d/EAJk4ZmXsquiBpdeYV654UJ1iZ3Qtag7d+7hIN+j
   1iPpe0wlkZ5xdYOXuPOuHfGBmvR4TM7JtkOz9b8O+nn6OX5Qgtaz7Dalq
   OkO/gr6+dhpJohX5FVLwhVJDrvv4+jbqqPDXWzRzcUuquZmO2m3svzGFX
   izDhnoK7D/6M8inYqNMWmBiqt7/oPYWnEdh1gb+caJXXiT2BKf6nsu43Q
   3kyHvp6BKtKezbMueT6mY6WCCCiSErRlVlHcsAz9ukmwl0EyGjoRAFrb3
   32iJnoU77J6TxOB2/6m6kR4PAT4+HOmt98HuEfFFi11XkQ1LiyptEFBcY
   g==;
X-CSE-ConnectionGUID: Zd+kpprNTl+QD4DpTHIlrQ==
X-CSE-MsgGUID: S81UhgB2SJKLn4Sz+4+CsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16857297"
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="16857297"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 23:52:47 -0700
X-CSE-ConnectionGUID: DrufGUwaQPOYEdcNzMZCYQ==
X-CSE-MsgGUID: MBME6hPKQbmI3zRCAiqadw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="75386750"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.246.49.253])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 23:52:41 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Will Deacon <will@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Andi Kleen <ak@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH V8 12/12] perf intel-pt: Add a test for pause / resume
Date: Fri, 28 Jun 2024 09:51:11 +0300
Message-Id: <20240628065111.59718-13-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628065111.59718-1-adrian.hunter@intel.com>
References: <20240628065111.59718-1-adrian.hunter@intel.com>
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
index 723ec501f99a..e359db0d0ff2 100755
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
2.34.1

