Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5C33AE187;
	Tue, 21 Jul 2026 06:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784615538; cv=none; b=eFHSDv63GRlKcJqip2AbUc/opR1tfIG2d3TrzcFD3ZNeTCUp9cyzmXQekeIw7dZ839GG4fZB/07QHYCtNAvZAP9iQSLLQGtYl8wbqLdBuuj8+C+1hAKZjC4Fw6LP/omd3yec+nE2XXCBXh6luT8cFiMEETcg8c4H1zZIX5+P1Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784615538; c=relaxed/simple;
	bh=8cpKhrCK9gw82VF0FFxZYauT4DDIOkEo40eB+1f6qpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RXMJSmGDBLoYHpSZYDxNASllI6R9arxzmI4N7AHyTuW5F8cGuo7lVo66rxXpZ00V1oGSfqEMerxoN7Xt4s4+w3HlBnHSaZNnTr2TUNQ4HiK+gR0lqv66qW+ebaEpBSrWyb1XRHa5jZ1zNSGjED3cVHRWtD9NBPNzqgGA+PbNP4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UswFzRvA; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UswFzRvA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784615536; x=1816151536;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8cpKhrCK9gw82VF0FFxZYauT4DDIOkEo40eB+1f6qpo=;
  b=UswFzRvAp+VATwYJ+5mLTw6xRWCMcBZpnVF9vSi5VpcfRku/+CquiH4N
   du+5K/Qc+pkfV4t+0hjZhGFVHO75RHtj0N4CqY8YT+G2WJeAh+xTOi0TW
   yJ2qiH3J+YDlZcTymGWaygPT/Eo4ZGGkQ+E/PPCk1YIxMDdYGOh+pj55E
   V/0TFy67FNA0P5VbXQ5t7Ge0I8RFAPuDT9TDw0Z6nwU3RxSXDZHkDk1EL
   E7s1p0oSFJUvU+NL9VMDIKdMCMQDfxg6kxXiplp1iwl5Y7HD38+FgGIPx
   WyJG7LcOFFpeE6OGw+4kZbanEe7I+NmEA8i/rQoWR/nbu2WOev8jaPJpk
   A==;
X-CSE-ConnectionGUID: gAhrw5+zTWuyb9kuMJJzNA==
X-CSE-MsgGUID: DswhrpQEQaiRlPU0M1wjBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="72740264"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="72740264"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 23:32:16 -0700
X-CSE-ConnectionGUID: fPDG/F9USCumxgOt9CCiOQ==
X-CSE-MsgGUID: Z4AlacV9SrGIiYjKWCAihg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="259655650"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa004.fm.intel.com with ESMTP; 20 Jul 2026 23:32:09 -0700
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
Subject: [Patch v10 01/23] perf/x86: Move hybrid PMU initialization before x86_pmu_starting_cpu()
Date: Tue, 21 Jul 2026 14:24:44 +0800
Message-Id: <20260721062506.3745816-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260721062506.3745816-1-dapeng1.mi@linux.intel.com>
References: <20260721062506.3745816-1-dapeng1.mi@linux.intel.com>
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

