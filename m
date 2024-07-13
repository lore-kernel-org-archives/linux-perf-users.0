Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ABD13BAC8
	for <linux-perf-users@vger.kernel.org>; Sat, 13 Jul 2024 15:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720886092; cv=none; b=jmO80tLsNxEdL9rP4TR7/3B1N+4R/latzxByCwqj2dxbBvmcqoPLmDWSpuwGhxAZooaArfVRI9qc3Tkp+jj2CvalJNIauTKenRwY81vvHxyHkPkMINIYyUCwba8Z9EH7ZHi7fd1gOCi1IRJ4c3U9tRInyPWMpt445RPqsU0q+pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720886092; c=relaxed/simple;
	bh=/tcKJ1C1eResv+EgzDrPPOUOPvdU1vznAyaWlg6YFiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pmRiSJffrEVrQq2KiTSxR36XakfiDwJBTTVnc3x7l/waWJoQGZF1ZGh/zHsiVfkiejO1INAoEjJhVJPCU2iEfxb8NAsrHeM2cDsViwqS1YZQvjFa4I7psPec74IgtE88VhfgOX3ZBMhzao9zEkY47sJfkS7u+ghg2uYOxoWZ4GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MEPmgrxJ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MEPmgrxJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720886091; x=1752422091;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/tcKJ1C1eResv+EgzDrPPOUOPvdU1vznAyaWlg6YFiU=;
  b=MEPmgrxJGwiCQVvXmHPTpoHNpmUCuHqGo1ULQSSsG+vjJRnoHo48Ad6C
   6sgAtCCw6h5LTlgleCFUYsK+zjrhdfm/Kw9jOtKy4Drc7Nls9p8/i7Nff
   87UEcjAxkCRtLV6Jf1k5uC25CO5ysRhZ4GfrhczT5GfTd2Yb9gF9/bCzF
   PZ18L+0RyMibrMklud52nFJQSugSNsyWBdW+Hup16GmTie2NrgcpqY/WO
   YGEzYG50ygEWinVBwBfrTL12S7o/gnxRcbrVCMBvJ9164k6iYV3i5WjgG
   VneW9M5w2/q6/l55Ey7GhhTa8z4X+BR9GNKe4Ja0k1PBT1T4278PS4uGZ
   g==;
X-CSE-ConnectionGUID: 8IPdvnApSIWTpU1lH3Xxng==
X-CSE-MsgGUID: PMV46YFKRoCUIRmi4fAt/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11132"; a="18130078"
X-IronPort-AV: E=Sophos;i="6.09,206,1716274800"; 
   d="scan'208";a="18130078"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2024 08:54:49 -0700
X-CSE-ConnectionGUID: QTGV6i/7T/qtJ34V0cJtdg==
X-CSE-MsgGUID: sR1b6CCCQa2GLSC2SQMZjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,206,1716274800"; 
   d="scan'208";a="48920634"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2024 08:54:48 -0700
From: Andi Kleen <ak@linux.intel.com>
To: namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v5 2/2] Add a test case for perf script -F +metric
Date: Sat, 13 Jul 2024 08:54:43 -0700
Message-ID: <20240713155443.1665378-2-ak@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240713155443.1665378-1-ak@linux.intel.com>
References: <20240713155443.1665378-1-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just a simple test

Signed-off-by: Andi Kleen <ak@linux.intel.com>

----

v2: Avoid bashisms. Use noploop
v3: Avoid false positive in shellcheck
---
 tools/perf/tests/shell/script.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/perf/tests/shell/script.sh b/tools/perf/tests/shell/script.sh
index c1a603653662..5e080e40b390 100755
--- a/tools/perf/tests/shell/script.sh
+++ b/tools/perf/tests/shell/script.sh
@@ -7,6 +7,7 @@ set -e
 temp_dir=$(mktemp -d /tmp/perf-test-script.XXXXXXXXXX)
 
 perfdatafile="${temp_dir}/perf.data"
+scriptoutput="${temp_dir}/script"
 db_test="${temp_dir}/db_test.py"
 
 err=0
@@ -88,8 +89,21 @@ test_parallel_perf()
 	echo "parallel-perf test [Success]"
 }
 
+test_metric()
+{
+	echo "script metric test"
+	if ! perf list | grep -q cycles ; then return ; fi
+	if ! perf list | grep -q instructions ; then return ; fi
+	perf record -e '{cycles,instructions}' -o "${perfdatafile}" perf test -w noploop
+	perf script -i "${perfdatafile}" -F +metric  > $scriptoutput
+	test "`grep -c metric $scriptoutput`" -gt 5
+	grep metric $scriptoutput | head
+	echo "script metric test [Success]"
+}
+
 test_db
 test_parallel_perf
+test_metric
 
 cleanup
 
-- 
2.45.2

