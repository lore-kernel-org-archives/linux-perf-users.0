Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3020910A01;
	Sat, 20 Jul 2024 06:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721456477; cv=none; b=E0qEucsIMLz+i53fRoNnO9Ukn84k9pbJk9h21fSBU0Ve4jY0O8hDEoHbVm2Sv290gcFgDJW+BUVifRv3lpVQejCN9c0u7SVrFP2x8+VK86d7QhY2wpIADqh0LmejXaY4XYRz+yE1LBCovDvO6lA1ysbq/PqLrDMmaQoBumVsZ6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721456477; c=relaxed/simple;
	bh=y8dIjepJgtrIJo05/YH+wrjH1xq5Xs3dSpvMjsAAJxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=db/wdqoXZ+j8edar+ogqDOltVjWt9c9HIX3GHy85K5lFZ+fEA8/TgB4lFon1bKb627va7ui1f0hxSuhIlqaIYs66sWJCxeVQjzkifg/UxH75Nrc77OfdkfGw0E6SLdzl/FhpFfGCDvCrDhHd5WjoDX1PeLpBnj+73WxhPS4C+p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kPFD95pw; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kPFD95pw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721456476; x=1752992476;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y8dIjepJgtrIJo05/YH+wrjH1xq5Xs3dSpvMjsAAJxQ=;
  b=kPFD95pwZcYlS3alvR3cdowzZ/g5lMy6q2wWVlCMV5AMtAg4zskDse6U
   2OZd3mOeKOvHMDljYa4YSWFb2xGi8ng1VVQ9FWPPXpfGHnc44+32gzfqT
   C8xWhBePsWnwqZXwX8DKJU1qmYet0B1j6pkm/EXnbqs9lZ9ZI1IxmDiSN
   LVq1i8no09mkRVqF6cCItypfqXFBAGOMmgqJbOHqG7Ed2vol7qD2j0WKq
   vLpV+Rad7pG9WlvCklXaqWkww8Gf1qc7IrnmtrCr9SMwb1CMIMEW9NX4u
   pG48mTmwb8D6sfvMzNB6rjVJZ6txcHgry8rTbX5p3nDZUio/Oej5i7VjC
   g==;
X-CSE-ConnectionGUID: /StvIFHpSUiTlUri39jVDA==
X-CSE-MsgGUID: achZZVJoRT64uUBABlzpKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11138"; a="12630509"
X-IronPort-AV: E=Sophos;i="6.09,222,1716274800"; 
   d="scan'208";a="12630509"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 23:21:15 -0700
X-CSE-ConnectionGUID: g/ilG1LGTTS0SHsezo/Cvw==
X-CSE-MsgGUID: PT2PmZllSuSG9H9xTznu7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,222,1716274800"; 
   d="scan'208";a="51403606"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by fmviesa010.fm.intel.com with ESMTP; 19 Jul 2024 23:21:14 -0700
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
Subject: [RFC PATCH v18 8/8] perf test: Add test for Intel TPEBS counting mode
Date: Sat, 20 Jul 2024 02:21:01 -0400
Message-ID: <20240720062102.444578-9-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240720062102.444578-1-weilin.wang@intel.com>
References: <20240720062102.444578-1-weilin.wang@intel.com>
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
calculation. This test checks the counting mode code on Intel platforms.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 .../perf/tests/shell/test_stat_intel_tpebs.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_stat_intel_tpebs.sh

diff --git a/tools/perf/tests/shell/test_stat_intel_tpebs.sh b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
new file mode 100755
index 000000000000..c60b29add980
--- /dev/null
+++ b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
@@ -0,0 +1,19 @@
+#!/bin/bash
+# test Intel TPEBS counting mode
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+grep -q GenuineIntel /proc/cpuinfo || { echo Skipping non-Intel; exit 2; }
+
+# Use this event for testing because it should exist in all platforms
+event=cache-misses:R
+
+# Without this cmd option, default value or zero is returned
+echo "Testing without --record-tpebs"
+result=$(perf stat -e "$event" true 2>&1)
+[[ "$result" =~ $event ]] || exit 1
+
+# In platforms that do not support TPEBS, it should execute without error.
+echo "Testing with --record-tpebs"
+result=$(perf stat -e "$event" --record-tpebs -a sleep 0.01 2>&1)
+[[ "$result" =~ "perf record" && "$result" =~ $event ]] || exit 1
-- 
2.43.0

