Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D91B136351;
	Thu, 26 Sep 2024 14:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727361648; cv=none; b=kZWypkSZcpAZo5wwtADkBKFxfHaCj8Q7P+fVRZOCGo9bM9eDNCGG+DP6kkkpfY3e+sC2LBtTifuPLLhTZFHaJLxrvl2SA79hyTq684WNjBjRG7NFbuYkZM3SgT89JvI/WpIwuk9Hf4mKVwmDln4MqlB5Xr3+hq3c4ZQkPrY9QHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727361648; c=relaxed/simple;
	bh=pknfYkT8okNZTzbNPB88s3NvEtJEVv1Ulvk5zmWu/Yg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WPeXFGHB9XChuHfM/IAxCiQovAk2CQ96UHu5WctnGvBbYIN3hAudxe3ouRXJw8MnGpSFjXuQJ1dbK0O+1RGATbi/I0pwQ5oXxxOdRaoOxSDG+UoYRuffF7Uv8/TB23bESwRHmsXjt/z8EqL+/ZMr97bYdq+a+F2SVQB3Yz1MopA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RvFdbkse; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RvFdbkse"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727361647; x=1758897647;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pknfYkT8okNZTzbNPB88s3NvEtJEVv1Ulvk5zmWu/Yg=;
  b=RvFdbkse9JUCOMjWPuKTKfiaEGGJBkTdLk4BfLuSYbJ8Odf5FMugBAz5
   PX/m/cswYb8HeNRID3VpYLaomWW41qrciToxdlh+gBx2x1Bpx37+g4rjz
   ToIF3grNGDRW+SZVmgNaQdWiZZEi10mIf6TWkBU79fr9yq/PRsRXC1oR7
   7V9/2393xT1RR9meg6LQMBU/QK5wp0+LT9vgEpTNTpDAT6KKSA8BLxoRJ
   Inq0hb2/Ui5tXUzYQ/HXk8PnP11lHpMmVh1S1N1+uFvZhSywuqaSJnYE5
   +OISAbeSaM/O2+sTUuBJAMr0MEFvuhEwi3BfKWsYG9UDI+u8wP2aaTlci
   w==;
X-CSE-ConnectionGUID: jGRJVx+uQ8KpteXOTRLuFg==
X-CSE-MsgGUID: klyPx00wQASuwCZKysoXxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="37820200"
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="37820200"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 07:40:44 -0700
X-CSE-ConnectionGUID: 2mMNJqo/RI6kaK9eNMw8KA==
X-CSE-MsgGUID: 1s87KLgASbCSyYlPfWO8sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="72975051"
Received: from tfalcon-desk.amr.corp.intel.com (HELO tfalcon-desk.intel.com) ([10.124.222.28])
  by orviesa008.jf.intel.com with ESMTP; 26 Sep 2024 07:40:42 -0700
From: Thomas Falcon <thomas.falcon@intel.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	leo.yan@arm.com,
	Thomas Falcon <thomas.falcon@intel.com>
Subject: [PATCH v2] perf mem: Fix printing PERF_MEM_LVLNUM_{L2_MHB|MSC}
Date: Thu, 26 Sep 2024 09:40:40 -0500
Message-ID: <20240926144040.77897-1-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With commit 8ec9497d3ef34 ("tools/include: Sync uapi/linux/perf.h
with the kernel sources"), 'perf mem report' gives an incorrect memory
access string.
...
0.02%	1	3644	L5 hit	[.] 0x0000000000009b0e	mlc	[.] 0x00007fce43f59480
...

This occurs because, if no entry exists in mem_lvlnum, perf_mem__lvl_scnprintf
will default to 'L%d, lvl', which in this case for PERF_MEM_LVLNUM_L2_MHB is 0x05.
Add entries for PERF_MEM_LVLNUM_L2_MHB and PERF_MEM_LVLNUM_MSC to mem_lvlnum,
so that the correct strings are printed.
...
0.02%	1	3644	L2 MHB hit	[.] 0x0000000000009b0e	mlc	[.] 0x00007fce43f59480
...

Fixes: 8ec9497d3ef34 ("tools/include: Sync uapi/linux/perf.h with the kernel sources")
Suggested-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
v2: Leo Yan suggested adding PERF_MEM_LVLNUM_L{1-4} to mem_lvlnum
    and printing a clearer message in the case of an unknown level
    to more easily catch similar issues in the future
---
 tools/perf/util/mem-events.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 051feb93ed8d..bf5090f5220b 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -366,6 +366,12 @@ static const char * const mem_lvl[] = {
 };
 
 static const char * const mem_lvlnum[] = {
+	[PERF_MEM_LVLNUM_L1] = "L1",
+	[PERF_MEM_LVLNUM_L2] = "L2",
+	[PERF_MEM_LVLNUM_L3] = "L3",
+	[PERF_MEM_LVLNUM_L4] = "L4",
+	[PERF_MEM_LVLNUM_L2_MHB] = "L2 MHB",
+	[PERF_MEM_LVLNUM_MSC] = "Memory-side Cache",
 	[PERF_MEM_LVLNUM_UNC] = "Uncached",
 	[PERF_MEM_LVLNUM_CXL] = "CXL",
 	[PERF_MEM_LVLNUM_IO] = "I/O",
@@ -448,7 +454,7 @@ int perf_mem__lvl_scnprintf(char *out, size_t sz, const struct mem_info *mem_inf
 		if (mem_lvlnum[lvl])
 			l += scnprintf(out + l, sz - l, mem_lvlnum[lvl]);
 		else
-			l += scnprintf(out + l, sz - l, "L%d", lvl);
+			l += scnprintf(out + l, sz - l, "Unknown level %d", lvl);
 
 		l += scnprintf(out + l, sz - l, " %s", hit_miss);
 		return l;
-- 
2.46.0

