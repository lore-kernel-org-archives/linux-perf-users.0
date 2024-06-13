Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3E113699F;
	Thu, 13 Jun 2024 03:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718249806; cv=none; b=jtdmgiEX4L5QPNHLOwUpsrw3jezsv+eXTJ8PCDLp5SzzIEQX9a02rYtSoi06qJ/G40NSg0HtE5ff1WFGlwfaAgIATvsyqNhRq88WYO3iitG/o3Pa7vIVT0E3f3NTj+TdTLc0EGHIvbhOSlgTGq3tqeCB08F9X3LWonrZPZ97tK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718249806; c=relaxed/simple;
	bh=9rfkw6btWnuXeXgwlnlhpR/TPnJa6+KlRHAa2N3kdwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rsAHXp3rOM8u+xTpARDX8IKEIFsN/hda+f9lCoXM82Kd+TjpYh9iABGoh7tJU+3mzM7A7RC3TETsO7Wbz2owUvpIQtObpC1iYwEZ2Qg2UJ4ZYWJqbQzLtTVVGKznuI9YL6sa6DHvdaxnm6L7sib2hYx5Op1nQikj39VmeekPG+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OepWpT60; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OepWpT60"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718249804; x=1749785804;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9rfkw6btWnuXeXgwlnlhpR/TPnJa6+KlRHAa2N3kdwo=;
  b=OepWpT60531roSXS1+cDyS350oQIYDxpkPm2+v9ocJEJnzB/f+JIAeNf
   CYxu3MME4BFCRByXbyQ812+gUj/mf46YWwoutXsLT2u0FphNDVrbXx9Lg
   j39PMr5Zgy+DOlf6U5HC4mSRMAIrUMyZflxDQY+dg/ntXWJT4tDAaFZj5
   BHB17V1Np7Tqx5DKN5UhRbG1UfMeGKGTcIUsevNf5kMjch21VF9/OVIzZ
   vKbo8f6N7ObLaVsiwxcgy6NvYkvkKfin75oq8/iHo7LGa4Cuhsb8sEP3E
   3on3yC4GYX+swAndPPcdrZM/n2aquQECPdDRZ8mrArDylbcjYgr2wS6mD
   Q==;
X-CSE-ConnectionGUID: 5///vJUfTUqdAgYYYBLfQw==
X-CSE-MsgGUID: ataGyAsURPCLVIavggmqRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="12046742"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="12046742"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 20:36:39 -0700
X-CSE-ConnectionGUID: iZP3pu1DSS6owU4OTge4IA==
X-CSE-MsgGUID: 1Jo8Ykk8SLWnSuA8zxp6XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="40100370"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by fmviesa009.fm.intel.com with ESMTP; 12 Jun 2024 20:36:39 -0700
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
Subject: [RFC PATCH v13 9/9] perf test: Add test for Intel TPEBS counting mode
Date: Wed, 12 Jun 2024 23:36:29 -0400
Message-ID: <20240613033631.199800-10-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240613033631.199800-1-weilin.wang@intel.com>
References: <20240613033631.199800-1-weilin.wang@intel.com>
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
index 000000000000..3c8763b39bd4
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
+[[ "$result" =~ "$e" ]] || exit 1
+
+# In platforms that do not support TPEBS, it should execute without error.
+echo "Testing with --enable-tpebs-recording"
+result=$(perf stat -e "$e" --enable-tpebs-recording -a sleep 0.01 2>&1)
+[[ "$result" =~ "perf record" && "$result" =~ "$e" ]] || exit 1
-- 
2.43.0

