Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C23C13C66F;
	Wed,  5 Jun 2024 05:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717564939; cv=none; b=FmJaklFZ8jTdbu4fXzAwoOOuHNRRVfxKbRR4jyMpWHY58FN4WqH3Pbddtlpe5IdfLeIjXm3op6NQ+gAHgy1B8s6v3F02Ugd2JsYEQkkERPEo0xjNCU2z/zAmDRt+nBBG3FCc2hIQ5Br9ioz9uJUMZeGsMAxtv1q4BOSjDdavAic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717564939; c=relaxed/simple;
	bh=9rfkw6btWnuXeXgwlnlhpR/TPnJa6+KlRHAa2N3kdwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d8QR77Oq0JnbbAtHoMBaedgm/0D/nrxY3t/A1+GaH+AnBDU12TwrCsTGX/Mr/xeFsOpJL4l/Jd4JXLVw6wzgBJjvGPvJ7adh+QU6Je1k/8wUfdc37Ex78bvhgmenNl/yf8NLyr6rhe9cUEihzGFVCmK3J2afCW/q/nICDo65IRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UagKEESO; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UagKEESO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717564938; x=1749100938;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9rfkw6btWnuXeXgwlnlhpR/TPnJa6+KlRHAa2N3kdwo=;
  b=UagKEESO3fRK3VHzAVtf8o01dflbHGiXazAjlikVCAXJ1Xq9oS52fyif
   puBJN1XosWcHMhqZfCfF4CE5khK2JDw07Ywe/eIg/xC5qdZnYhq7b9mtT
   G4anz23IL/6AKC8VTkfDJnsIiv2UJDtD+K0bW0VhRTUh8ELzpfpn7eNk8
   Va3NcQuYAuWctlZrC4YYbc8Lig1biKGHXqX4V6mdVnnjrkNs5AJsv9cEt
   CoPSgxsFuSh/aFSJGVomM4apVCm3sqvPhZAYCm5pq4ZhWc6ene8mJ0kFd
   WJjKjMzY5U57xqQzbqm9CY6W44pIBG6JwZqRG7h0Nv0qbE8BrGg1VybHS
   Q==;
X-CSE-ConnectionGUID: 0SLrcc9mRGezOXmhMraH5Q==
X-CSE-MsgGUID: BTCDpSvcSqSJBDYyV9hBqw==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="25258825"
X-IronPort-AV: E=Sophos;i="6.08,215,1712646000"; 
   d="scan'208";a="25258825"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 22:22:12 -0700
X-CSE-ConnectionGUID: +Sn6OMCPRgqFcpHULvVWJg==
X-CSE-MsgGUID: sxi8NJR2QWepkTSKtAemYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,215,1712646000"; 
   d="scan'208";a="37525767"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by orviesa009.jf.intel.com with ESMTP; 04 Jun 2024 22:22:12 -0700
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
Subject: [RFC PATCH v11 8/8] perf test: Add test for Intel TPEBS counting mode
Date: Wed,  5 Jun 2024 01:21:49 -0400
Message-ID: <20240605052200.4143205-9-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605052200.4143205-1-weilin.wang@intel.com>
References: <20240605052200.4143205-1-weilin.wang@intel.com>
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

