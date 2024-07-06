Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F0213E8B0;
	Sat,  6 Jul 2024 23:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720308614; cv=none; b=JORqs5ee61+zywVhj7XKUYgmQ8iNW0EKs6nS6RM3JtSbFnSJuT7mNYoPlDuWe6TH1gPqcnLMd2DMiLjq1EQBIDaU9QkvEC15gEjpm2TFtvGkwm9qAIQv53GcrM+/j2vdxDcStSs+OOL5h3dX7JAUA6dSgZQWtwWZPZJ1ybVUd5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720308614; c=relaxed/simple;
	bh=+tmzYMTvFVj8szy9dMX4jlxt/bz5tZkdG+1qu5Nrg9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=phVjK65cj1MM6uBSoEyIIAfcfCyiudfpdOQMX5qvWBUkUSPc9J4RayZn9uZgvxeytClFRc/aoFGTaOObH09Wx46y+7NqVWqLpj7KW95EjxHbW+cQPLKGFK1c7sdOm2SFvNYCnhtMNO+wmo29lJeYenEVZwer0M2CwWfXWol41Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=npX2HATN; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="npX2HATN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720308610; x=1751844610;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+tmzYMTvFVj8szy9dMX4jlxt/bz5tZkdG+1qu5Nrg9k=;
  b=npX2HATNCp99/P40cRozyAFxD6gfMLqS/qf1MqTvalheOvwWnG4pi8hw
   CApLM9xLfLIwHLZR0/HuWzE5FA9KsV1zNbek2Ci05j+R9XUkCmNbu5pwW
   v5AkjHL+jnGWm2CBi+t962cLeQPkdR49rhDcJoq5y6sgkueH0fziHpJb1
   jU100wy4F3aDrv13YLipO3l9dUL43ouskh6KQ5zFYvR8XAlJ2sPPPRxCK
   CH9paSOwqSnBH0RJQCEOxAcZ8u4NzNf7WXzMiazQATgn3faIVAUFWPG2r
   5JGoCTo64nTZfu9iFEndgu/EJBrOmkGgELp27WNS/YsLDGmLN2S5TWI4U
   w==;
X-CSE-ConnectionGUID: NIlbRyP+TVuVbXKuxOr9Vg==
X-CSE-MsgGUID: lYpW+Eo+SyGXFMwnK/Ienw==
X-IronPort-AV: E=McAfee;i="6700,10204,11125"; a="42971673"
X-IronPort-AV: E=Sophos;i="6.09,188,1716274800"; 
   d="scan'208";a="42971673"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2024 16:30:07 -0700
X-CSE-ConnectionGUID: TVJRx0V2TfqiGgbhksXvGg==
X-CSE-MsgGUID: TkM0EsgfSG+FnhFFDDrOpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,188,1716274800"; 
   d="scan'208";a="78294882"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by fmviesa001.fm.intel.com with ESMTP; 06 Jul 2024 16:30:07 -0700
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
Subject: [RFC PATCH v16 8/8] perf test: Add test for Intel TPEBS counting mode
Date: Sat,  6 Jul 2024 19:29:55 -0400
Message-ID: <20240706232956.304944-9-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240706232956.304944-1-weilin.wang@intel.com>
References: <20240706232956.304944-1-weilin.wang@intel.com>
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
index 000000000000..fea8cb1b8367
--- /dev/null
+++ b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
@@ -0,0 +1,18 @@
+#!/bin/bash
+# test Intel TPEBS counting mode
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
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

