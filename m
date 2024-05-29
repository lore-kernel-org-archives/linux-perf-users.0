Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274FC167D90;
	Wed, 29 May 2024 06:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716965022; cv=none; b=UpHn1JTxMm7FW9VPjUcIg7atbE0UD58TevRN0ZxKQ+FOr2DOdg8gZczKJq1/RZxO8L99D2udxWFqkhFSD5561T3qHe/kaZt6bCU9unFQYSmA6QEJWZqxnZ0MXnd6ss+glIxpaLADn8VI7Pa56/qWxH+wjV7C515D2cBWSOZVDDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716965022; c=relaxed/simple;
	bh=ZJYI/Pn9c1nDzAxqFDHF0oN1xE02kbwoHSmmnVXOVVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rvkwTAy46nwNiqUXAGHG2ANssD0bh6uXpklk+vOMyvMJtsCezhJzZbFGMZi/pW2YVhUERx7bMVO41d9Y9nvT75ahfrm5K63RLIuptN1jh3PpzExvvd/4LHge/rmrUWuVMwCLMWaPPRDniu+QnRLhTjUVZ52nos8IRmkgmH4Kcrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C7sPyWma; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C7sPyWma"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716965021; x=1748501021;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZJYI/Pn9c1nDzAxqFDHF0oN1xE02kbwoHSmmnVXOVVo=;
  b=C7sPyWmaTMfIvXJUdiC9I/A0+Vkj3PIP3reRlM4Shj3s89Xa3Kn0C5rU
   dCHZNuEreN1CDGRGrdz3O7Ar7EOt3tY8y4TjfCRRTdW+2DUWG8fGVzrfH
   B6q3urbJZM8XYfNcWNtCSjLhN2VAZqfINLkzg0ntgAuPH+NtOsNX8HXhz
   xynZ8EKJdoXqRsAUAfP6WIr+6jVwkESRYnYCTSR5ia97JRFINicZ30sVT
   e+RtjbHF8kkujR1AWE/GtQSJ7AeWZqC/Eo3miXcMHFtQkS8jr5HQFgnNY
   hy1P2s72dUtyevLfJOTooTP/IC4EwqNmFTZ+r6FVJ6HOy+NqKWCQZZFnx
   Q==;
X-CSE-ConnectionGUID: bQ6Gk1cFRJKawu/SsGWQ9Q==
X-CSE-MsgGUID: FPfEC3pfSbmlkhoYF42EbA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="16298017"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="16298017"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 23:43:37 -0700
X-CSE-ConnectionGUID: DcOZIanSRICRnKUFnk4nSg==
X-CSE-MsgGUID: D6hk+r77R7O/YtI8vqsDhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="39759336"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by fmviesa005.fm.intel.com with ESMTP; 28 May 2024 23:43:36 -0700
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
Subject: [RFC PATCH v10 8/8] perf test: Add test for Intel TPEBS counting mode
Date: Wed, 29 May 2024 02:43:24 -0400
Message-ID: <20240529064327.4080674-9-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240529064327.4080674-1-weilin.wang@intel.com>
References: <20240529064327.4080674-1-weilin.wang@intel.com>
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
 .../perf/tests/shell/test_stat_intel_tpebs.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_stat_intel_tpebs.sh

diff --git a/tools/perf/tests/shell/test_stat_intel_tpebs.sh b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
new file mode 100755
index 000000000000..43f75055fee4
--- /dev/null
+++ b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
@@ -0,0 +1,19 @@
+#!/bin/bash
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
+[[ "$result" =~ "$e" ]] || exit 1
+
+# In platforms that do not support TPEBS, it should execute without error.
+echo "Testing with --enable-tpebs-recording"
+result=$(perf stat -e "$e" --enable-tpebs-recording -a sleep 0.01 2>&1)
+[[ "$result" =~ "perf record" && "$result" =~ "$e" ]] || exit 1
-- 
2.43.0

