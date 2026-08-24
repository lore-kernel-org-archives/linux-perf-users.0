Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC233CFF6C;
	Mon, 24 Aug 2026 08:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560459; cv=none; b=TzTYOjuM1/XyUmRrQNsqEK51kglvDmt61PEU6bKuIdB+uKz9Jp8QYNQQghje8O4lYf/MEKjbMCOgv2COsq7bOtzpFQJKuhl294yr2baqzCdUEf1XKFulESDY5P7/b30cfNgU0jZChw4bDgVe3jMC+jqmnqD8db2nFFWGhyjePLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560459; c=relaxed/simple;
	bh=8cpKhrCK9gw82VF0FFxZYauT4DDIOkEo40eB+1f6qpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uMrXwxkevp+qgdy/6DP/3anfgWASyaTrjlDj+0BdcCNv18BnldkiqsgODTSNWLXXVJg2DGW8XD6ycS0VihSNvIYttNmuycwpGk5kfHa/J0z1dP9tdygGQyuax17k3Y2PPIoDlFPyy3J0bbPhDQGc8TiV9uRDpi39PBT65TkTlyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k67+AC3X; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k67+AC3X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787560456; x=1819096456;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8cpKhrCK9gw82VF0FFxZYauT4DDIOkEo40eB+1f6qpo=;
  b=k67+AC3Xwpe1bEppCaK1PmBarl38OJLTxVJL9dSn/bltNPrD+e+rAkDA
   YoDdqfuEwqphPPqVWSyIfiVmlDtgsjc+6Fkg+xJTYspklLok4IU2BNUnD
   JbBp21XMAsv07sXSCWcsNIwNuc+Y7gytQwxgCZW9B8tO38AUSL3fXqzA4
   Z14Wa4PGnmnZIAR0jwdYIRSRaKVPhiZL8/rkEGOxwDasmyUdfEN8nzct3
   U826xpRwLDa/mnMY6rFW/SqSQAXwsD2aUvbWosid9jjyKMwP11zY6iz3a
   tXwrE6uWyA9WTw0fKUkKlIvCBUO5SroI8WxN7tcy8hmzpUohmODSOcvGV
   w==;
X-CSE-ConnectionGUID: 0NQjvneESgG/hAGSbQA/WQ==
X-CSE-MsgGUID: qhwETdFfRn2MEdF+5xDz6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="98598658"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="98598658"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 01:34:15 -0700
X-CSE-ConnectionGUID: ManrVOg1R7GTkbmZdbST5A==
X-CSE-MsgGUID: 5jMVm1TeTDaVN8Ztg2JNAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="264325881"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 24 Aug 2026 01:34:10 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	broonie@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [RESEND Patch v10 01/23] perf/x86: Move hybrid PMU initialization before x86_pmu_starting_cpu()
Date: Mon, 24 Aug 2026 16:27:09 +0800
Message-Id: <20260824082731.1013973-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
References: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current approach initializes hybrid PMU structures immediately before
registering them. This is risky as it can lead to key fields, such as
'capabilities', being inadvertently overwritten.

Although no issues have arisen so far, this method is not ideal. It makes
the PMU structure fields susceptible to being overwritten, especially with
future changes that might initialize fields like 'capabilities' within
init_hybrid_pmu() called by x86_pmu_starting_cpu().

To mitigate this potential problem, move the default hybrid structure
initialization before calling x86_pmu_starting_cpu().

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 8b3ea0adb965..75358a297222 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2218,8 +2218,20 @@ static int __init init_hw_perf_events(void)
 
 	pmu.attr_update = x86_pmu.attr_update;
 
-	if (!is_hybrid())
+	if (!is_hybrid()) {
 		x86_pmu_show_pmu_cap(NULL);
+	} else {
+		int i;
+
+		/*
+		 * Init default ops.
+		 * Must be called before registering x86_pmu_starting_cpu(),
+		 * otherwise some key PMU fields, e.g., capabilities
+		 * initialized in x86_pmu_starting_cpu(), would be overwritten.
+		 */
+		for (i = 0; i < x86_pmu.num_hybrid_pmus; i++)
+			x86_pmu.hybrid_pmu[i].pmu = pmu;
+	}
 
 	if (!x86_pmu.read)
 		x86_pmu.read = _x86_pmu_read;
@@ -2266,7 +2278,6 @@ static int __init init_hw_perf_events(void)
 		for (i = 0; i < x86_pmu.num_hybrid_pmus; i++) {
 			hybrid_pmu = &x86_pmu.hybrid_pmu[i];
 
-			hybrid_pmu->pmu = pmu;
 			hybrid_pmu->pmu.type = -1;
 			hybrid_pmu->pmu.attr_update = x86_pmu.attr_update;
 			hybrid_pmu->pmu.capabilities |= PERF_PMU_CAP_EXTENDED_HW_TYPE;
-- 
2.34.1

