Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B751494BE;
	Tue, 21 May 2024 17:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716313205; cv=none; b=hCnTNJu489cPfRx8KBDdn7a4JhnBNz/UtUWmQFuLnH0JnpB/2OXTmtsVR4zWmoqVTMFUuJxmAphRTiVFqYrxG5xIiK0GXVbv0TbEty3XYZsdnz06alwxr9uOPizG91X3N7JHA+u9FS6pFa5AC5cJZNUm8q0/k2x8KjVroihoH3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716313205; c=relaxed/simple;
	bh=PiFk/rDzdb0k9fXo1Z/4A46tpxk4GHQ+W7cQvXeUXoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i4frittgsRUgtkwpwLKtI8Yjp3kpeF7zAGhaOyhOf//imsIPx+78cICvUy2nkLaXVGvE8ic84pO1oaDGsUCKtjqv4S4SNBTaSrCjcbECrxAyTTFM+vO23N6e74ggL6AXXMQ1WF9/h0Zg+RyGVXxTWRxCSz+YXKyapfswjKugUz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gK3/DEUl; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gK3/DEUl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716313204; x=1747849204;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PiFk/rDzdb0k9fXo1Z/4A46tpxk4GHQ+W7cQvXeUXoE=;
  b=gK3/DEUlJxt6n2obSkrUdC3iAxAIhvdWxrikKpP/L/XEBZ0M0uP0sAOJ
   Xl6mLYDNruRyOPWygtAVc4J2yB3ljVuP7Zkp/kuk0NLNERZBpvaCs2xN7
   5eOKS7R5vxsTtSuXruEbV7m0AEdwECRXGHFGI/EQlyLhgwr6hf1bHlKWE
   dmyGLmeyT7zmvesB34RXWZFC92Dh0PyUSY5SYiq37unRL3u2Lm0f+wAJ3
   ClcD4yu30XnNZB3Et5roazmVGRrwUPS4qi7mpPSvfYYtzaij2QKpw/7wf
   WlC1MDDKYjtA4Zp0kk2dZyhTzbxEGa7/0gY3M2kfvejVS/6XzM8tUuKb0
   w==;
X-CSE-ConnectionGUID: ENQiNvWXTHC8AqA3J27QQg==
X-CSE-MsgGUID: lOuyWQ//TTSIkgaTCCZ0HQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="12317692"
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="12317692"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 10:40:00 -0700
X-CSE-ConnectionGUID: dGowoYrIQSO46GNnnfXyag==
X-CSE-MsgGUID: gbfxm/k0SEq6AJfmRnLO1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="32924981"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by fmviesa007.fm.intel.com with ESMTP; 21 May 2024 10:39:59 -0700
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
Subject: [RFC PATCH v9 7/7] perf test: Add test for Intel TPEBS counting mode
Date: Tue, 21 May 2024 13:39:35 -0400
Message-ID: <20240521173952.3397644-8-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240521173952.3397644-1-weilin.wang@intel.com>
References: <20240521173952.3397644-1-weilin.wang@intel.com>
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
 .../perf/tests/shell/test_stat_intel_tpebs.sh | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_stat_intel_tpebs.sh

diff --git a/tools/perf/tests/shell/test_stat_intel_tpebs.sh b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
new file mode 100755
index 000000000000..4cb749d84367
--- /dev/null
+++ b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
@@ -0,0 +1,27 @@
+#!/bin/sh
+# test Intel TPEBS counting mode
+# SPDX-License-Identifier: GPL-2.0
+
+set e
+err=0
+
+# Use this event for testing because it should exist in all platforms
+e=cache-misses:R
+
+# Without this cmd option, default value or zero is returned
+echo "Testing without --enable-tpebs-recording"
+result=$(perf stat -e "$e" true 2>&1)
+[[ "$result" =~ "$e" ]] && err=0 || err=1
+
+if [[ "$err" == 1 ]]
+then
+	exit "$err"
+fi
+
+# In platforms that do not support TPEBS, it should execute without error.
+echo "Testing with --enable-tpebs-recording"
+result=$(perf stat -e "$e" --enable-tpebs-recording -a sleep 0.01 2>&1)
+[[ "$result" =~ "perf record" && "$result" =~ "$e" ]] && err=0 || err=1
+
+
+exit "$err"
-- 
2.43.0

