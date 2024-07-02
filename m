Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521A01AEFD3;
	Tue,  2 Jul 2024 22:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719958093; cv=none; b=E9YNRPcq3yPGN9MS70uz0dPmouAHtQ6XSqNZoTz8Uedw7kHY0FbRjWQS/0hEvzVRKM0frEA4N6H57Mzm4eOJXSz9tpOTlOLQ+XSYfe7H11Ttf3WC+DLRAPkn9xBncG/gK1omM8wgELFhxHcPD0TcoxQo3EMPnt1XWKk3WKYHNF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719958093; c=relaxed/simple;
	bh=gPZ9MRVCe+ydnxFJBiXRGAGx/gI/Iro+2CmPLl5yGWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pWusGXfU0Ik1lToVAiYCqebCmVMmlWptTl0f/yhHFdJkZEr9R2o4FiVUpbGMIdpnJYT6O2Uylu/5C0GS/X9xYzn/wS3LFWNcXV/HN0IwF+h6+UxZl/WXl1krQ+5mkXPpO3dOqA5x23qacHR5MP7Y/J0tBPfHI3cB+QuPouU8sYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jQgqFDM4; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jQgqFDM4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719958092; x=1751494092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gPZ9MRVCe+ydnxFJBiXRGAGx/gI/Iro+2CmPLl5yGWs=;
  b=jQgqFDM4d4kpW/IRMqEMGkNsbNKBjZgrfYkh+fTgtISecvJrmZ0xsDoo
   PzyHXmfipz7YRwzNCQ/0KhFGqZRgkjqfA3HkurFJ5bbSHDOS+YPnXTyZJ
   gU+ATzRPcRyYYniwlV3R0Plw9+g2qsgnoRPirVAq4jwwC6lL59nZnzQf3
   dwYAzHfSNjMXh7lU0GICbtvIjI2jmlzvmzCmcWLnzAlhIyPLALn75/UTA
   hUUf98Qz2HBLZrTQxUZZJOvduaJJSqIX1es/WiYgktFS+kUOCWhubjpAe
   +SY9U7IBSB9LZTc443FPUHadD9fmkAxCw2jlJjRjmtVMlf/9eGk0nkyfq
   w==;
X-CSE-ConnectionGUID: sLEvxFjoTB6jKtOWlAxztg==
X-CSE-MsgGUID: BBr/e/fAR9KvhMBqa7yd/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17296928"
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="17296928"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 15:08:05 -0700
X-CSE-ConnectionGUID: 8WDt+1FASaS0lp1FOvNc1g==
X-CSE-MsgGUID: fG6LpUGCSBe3dWVJhlExCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="50888215"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by orviesa003.jf.intel.com with ESMTP; 02 Jul 2024 15:08:05 -0700
From: weilin.wang@intel.com
To: weilin.wang@intel.com,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>
Subject: [RFC PATCH v15 8/8] perf test: Add test for Intel TPEBS counting mode
Date: Tue,  2 Jul 2024 18:07:55 -0400
Message-ID: <20240702220757.262825-9-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240702220757.262825-1-weilin.wang@intel.com>
References: <20240702220757.262825-1-weilin.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weilin Wang <weilin.wang@intel.com>

Intel TPEBS sampling mode is supported through perf record. The counting mode
code uses perf record to capture retire_latency value and use it in metric
calculation. This test checks the counting mode code.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 .../perf/tests/shell/test_stat_intel_tpebs.sh  | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_stat_intel_tpebs.sh

diff --git a/tools/perf/tests/shell/test_stat_intel_tpebs.sh b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
new file mode 100755
index 000000000000..220b830eac61
--- /dev/null
+++ b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
@@ -0,0 +1,18 @@
+#!/bin/bash
+# test Intel TPEBS counting mode
+# SPDX-License-Identifier: GPL-2.0
+
+set e
+
+# Use this event for testing because it should exist in all platforms
+e=cache-misses:R
+
+# Without this cmd option, default value or zero is returned
+echo "Testing without --enable-tpebs-recording"
+result=$(perf stat -e "$e" true 2>&1)
+[[ "$result" =~ $e ]] || exit 1
+
+# In platforms that do not support TPEBS, it should execute without error.
+echo "Testing with --enable-tpebs-recording"
+result=$(perf stat -e "$e" --enable-tpebs-recording -a sleep 0.01 2>&1)
+[[ "$result" =~ "perf record" && "$result" =~ $e ]] || exit 1
-- 
2.43.0

