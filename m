Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED5C4594A;
	Fri, 12 Jul 2024 19:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720811390; cv=none; b=NDWaRvblsyrZ90aaq6FjyURjYvQT1GpS0XReFyk+o2BPvg5MdzmNpYJ1hZUmNVn9uFoi5OapTzK04SRyS4SestNRBP1amBVfMMqYJvFgKGyVwSiVKoijKbkaoPO83CR8h61z7Tvd5HIr+QhrZPKQKufIexK9K+qEKuOnTzGjAsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720811390; c=relaxed/simple;
	bh=h3CiMecAoGs/tWA2YFgxmVZXJf3z6TeLninM4DbWi1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aYfXGbXLJexVnlT53afiTg9VfHd+JPWAOhbwhLPt7dyKDN3CUNR58jNAFNSYTckQOfCTvU92bU10zH7+wDUc2eUxmMJrLu94qjfYAmtDp+oWdEogLZIm1CL+RRj/XZrQSC/IdLxohoeX74T+srnokdskxkdFThK3dKSqridSCi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bmcd+G+X; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bmcd+G+X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720811389; x=1752347389;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h3CiMecAoGs/tWA2YFgxmVZXJf3z6TeLninM4DbWi1s=;
  b=bmcd+G+XmJJeKOIDBPSJjHu79sYYMaCrCNY0PKu8ueUsdGF/+eGUrsLh
   VUUjpAokTKZ8aR+l9uho624IcnzkDVLHoT6KW+gsT4+RMRjhPM+B5Ysjv
   iZnfaWTqLe2BxT7eNVxnHbBejFcFpKVP2qbKXiD8VBC0Ik03WZs1/hj+/
   BWhfmKvJKaIrXuXPT3d2DNf4zalAcwax43KSRdkkYNtOiz2D/NkoRzePX
   r2BOovMZ6/RaKBVCuR4sDSFSRnHWGeAJbYrAMVvIzntHn6jHg9UjQCW+P
   f6C3gdl03fV8A30MPuHE67vBHrrd+ruR0MVhMBoctJD9nsNQXHrKSZj43
   A==;
X-CSE-ConnectionGUID: NXjYRiHyRfqKrRRofKRDgw==
X-CSE-MsgGUID: hnPJk7z6Q0ynxlPlFJvVYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="43683049"
X-IronPort-AV: E=Sophos;i="6.09,203,1716274800"; 
   d="scan'208";a="43683049"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 12:09:43 -0700
X-CSE-ConnectionGUID: mgZF7hgUTS+jSJfMYszilg==
X-CSE-MsgGUID: CsjnXAjQSPKWdfOp7T+u/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,203,1716274800"; 
   d="scan'208";a="54187451"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by orviesa004.jf.intel.com with ESMTP; 12 Jul 2024 12:09:43 -0700
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
Subject: [RFC PATCH v17 8/8] perf test: Add test for Intel TPEBS counting mode
Date: Fri, 12 Jul 2024 15:09:30 -0400
Message-ID: <20240712190932.417531-9-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240712190932.417531-1-weilin.wang@intel.com>
References: <20240712190932.417531-1-weilin.wang@intel.com>
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
index 000000000000..773fcc5c35d6
--- /dev/null
+++ b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
@@ -0,0 +1,19 @@
+#!/bin/bash
+# test Intel TPEBS counting mode
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+grep -q GenuineIntel /proc/cpuinfo || { echo Skipping non-Intel; exit 0; }
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

