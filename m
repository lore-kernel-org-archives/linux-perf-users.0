Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEE4174ECA;
	Tue, 11 Jun 2024 05:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718083452; cv=none; b=mcIYZOPoAryccl5Jo6bSZGv198Zdx0h1XhMaekZhVByVZ+yGQTfYtV/vxmp/DHqNs31nz5S9oQKr9wt6xvASF2m5W8U9h00xYPLh8px0rl/wm1KhC+7lYdU145d1uAzbRELEv/KF4WjMgZ1/muo+nrFU5cM5FG5F4wuaxr1BN10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718083452; c=relaxed/simple;
	bh=9rfkw6btWnuXeXgwlnlhpR/TPnJa6+KlRHAa2N3kdwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rZ2ClyHXI8g1EsrHGS7tRi55y84wztYbBclMo8JKioKBTdUH1HEROqaE7eqKj/aoDKUjfeetrVwoqr8VveCYASNg/xN1L5YzBOWvdsyf0Sccr2cPlwlMgx129kqDOzXENkB+jPmC4hBzPteYUWrPubsJhaDd7MUIN6plL/m+MMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=erUY1Ey8; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="erUY1Ey8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718083450; x=1749619450;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9rfkw6btWnuXeXgwlnlhpR/TPnJa6+KlRHAa2N3kdwo=;
  b=erUY1Ey801haGp6Rd596TALdZtRnVbYOqIoP2/KPXhf3FVvPQ4vbzGgJ
   pxbvbD7YTfl0l1r9uhb5qtlR7IbJ5CQXr6+IX+kO3sIokfsqsThxg7Ox2
   qn8gsZkNvlnNyFmu8Kzs/X5qPc6VRFUOFWC1Y8bSNgMkBjJUYPxRy1bIu
   /2Q8e+2+693KsH6Tr3sU46pUkpGzf/zSrIPL8WeWITq29KnRasSwq9MG+
   ANLhjE1oTb1E0pH7jU9Z+1PYhThS4FP9lBvX1hjfQk11fx1mo+5uY1JAj
   jU+y02d71NcZJlfUjwR8e2Y3mJMVUORWD5v90h0AJ+AjNuFmcDh1KLsjl
   A==;
X-CSE-ConnectionGUID: 4SZvCM27SZiaRXBIS4ldxQ==
X-CSE-MsgGUID: BlGf2WdGT9ySHIR2C3+RWg==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="14651158"
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="14651158"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 22:24:04 -0700
X-CSE-ConnectionGUID: +iOstIDST+a/9CsVe1bLeA==
X-CSE-MsgGUID: zpTAIMa0QfOplUwsnNIuTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="44441213"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by orviesa004.jf.intel.com with ESMTP; 10 Jun 2024 22:24:05 -0700
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
Subject: [RFC PATCH v12 8/8] perf test: Add test for Intel TPEBS counting mode
Date: Tue, 11 Jun 2024 01:23:27 -0400
Message-ID: <20240611052331.85715-9-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240611052331.85715-1-weilin.wang@intel.com>
References: <20240611052331.85715-1-weilin.wang@intel.com>
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

