Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793249249;
	b=C4abTWf3yxvlvw8O9foV7Uy5hxyebU89iRPOO2eip9XhPsMgtQEhMwl5vRb6dCHp2DSr
	 VGvVQL47/K5TXzdPMynQZcWYLak+cQqaTHALy0spvCTc73cfZDOEiinGhmLNUhGzcN6QZ
	 m5LRaq87TXsefKI0x+TX1BiK+b9nBStUB6aVl+MTK0UxB/3hWMQgibv44pj7Q07iD+omA
	 H620MNf3slPQlf0ttwAtIPhjAGdDrHIgZf/lJ9RzvbAETb9PCZmZQx7ilohDVQI33tcYi
	 169+XPPNklIs3YZkXznBR2CSSRVkn3rAjCD9p7cYQtPXLTI0tcZG0zCiul1tFGpFrjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793249249;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rhF0hOAcK88C/MykjTgxlRUkbiBoI+Si4GyKJ+b5wXM=;
	b=w/SqLKufp/2Td0Sy6KCzTYi1qtVk/mwWURLTN5Imlu3FSpGswF5LhKMpOJI/nItGAwrJ
	 itZJbi51uoo4GwLjhiz2myDbjsWUNxpYlh/HhXLPYMMqfI1/46cFxe4MJ5lTMdiELWJGl
	 xDOgue4dHwWq9OdHOlk5OJRclPcqBmWh8kT09zP9K/k+2eaOdxJlfBOQK+Sk82L/lRq8w
	 GlUEvJPmWko/ftQdDcE/SfJSVEa1AEunyPSmeZUgASsi7K2P6UYU5SMS9DT7w1zgXrUit
	 LSn1c3Dy+zpR4nASkxdr2R7neu/PwlvQBdhGKnIT79o0LpG/jxX12nkTHTEoLIRc9DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=D9Z69R7n;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8321606A31A;
	Thu, 29 Oct 2026 04:47:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8321606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=D9Z69R7n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793249244; x=1824785244;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VgPductCixKyyLnawAt3h/GvmGBemN4aJPABfWH1+Pw=;
  b=D9Z69R7nTGhGgnYiVdexz9jSWfAosYg/Qf3dueqdivBZz0tp4XfzTtG8
   Sjqk0ed6wYv7ij4wmGL/2UJv+hWByaMASozdNj5ymTY8tlPPmM5Iu/Nnv
   ugAIDt5Qs+PBHRetm4OA/w6vLVFuLnFsJ9Q1iTYs6B5/ZgxUT37HV89y/
   g295VgyPutA6Kq2Ulcili26GbP+PLLSOLljgukkjvar6fgxZEba752YzK
   ALiq/cCCmaBqSHRZ0k3wHl5ctVbyW1+au155eg61dC+QhtS5zw0qrygE7
   TQ+4Peq6BT4K4awHjryMji+mxdBj+7uLb0RysD6gwpQvnWhjkeS2OZaOW
   w==;
X-CSE-ConnectionGUID: H3j8nIt4TJ+YEqAMk3b+nA==
X-CSE-MsgGUID: fvwhEo5bQH6ovqyStfNa8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1986295"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1986295"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 21:47:24 -0700
X-CSE-ConnectionGUID: RSBU0PIjRBuzJpFWthAhLA==
X-CSE-MsgGUID: 6pM7sjjzTi+x3B6QfriLhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="5420474"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa007.fm.intel.com with ESMTP; 28 Oct 2026 21:47:19 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [Patch v5 09/18] perf/x86/intel: Keep LBR frozen throughout PMI handling
Date: Thu, 29 Oct 2026 12:39:05 +0800
Message-Id: <20261029043914.1395147-10-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
References: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the platforms which has 4+ PMU version, streamline LBR freeze is
supported. The PERF_GLOBAL_STATUS.LBR_FRZ bit is set to freeze LBR once
a PMU counter overflow. However, the current PMI handler clears the LBR
freeze bit too early, allowing branch operations that occur during PMI
handling to be recorded into the LBR stack.

This can pollute or overwrite the intended branch snapshot, especially
when bpf_get_branch_snapshot() is invoked from bpf_overflow_handler().
In that case, branches recorded while processing the PMI are mixed into
the original LBR data.

Defer unfreezing until after PMI handling completes so the LBR remains
frozen for the entire PMI path and no branch activity from the handler
is recorded.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-179823@kernel.org/
Fixes: 425507fa5f32 ("perf/x86/intel/lbr: Optimize v4 LBR unfreezing")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 15dcf8b78de9..a67297148bb6 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4062,7 +4062,13 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
 	loops = 0;
 again:
 	intel_pmu_lbr_read();
-	intel_pmu_ack_status(status);
+
+	/*
+	 * Do not clear the LBR frozen status here; keep LBR frozen
+	 * throughout PMI handling.
+	 */
+	intel_pmu_ack_status(status & ~GLOBAL_STATUS_LBRS_FROZEN);
+
 	if (++loops > 100) {
 		static bool warned;
 
@@ -4081,10 +4087,13 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
 	 * Repeat if there is more work to be done:
 	 */
 	status = intel_pmu_get_status();
-	if (status)
+	if (status & ~GLOBAL_STATUS_LBRS_FROZEN)
 		goto again;
 
 done:
+	if (status & GLOBAL_STATUS_LBRS_FROZEN)
+		intel_pmu_ack_status(status & GLOBAL_STATUS_LBRS_FROZEN);
+
 	if (mid_ack)
 		apic_write(APIC_LVTPC, APIC_DM_NMI);
 	/* Only restore PMU state when it's active. See x86_pmu_disable(). */
-- 
2.34.1

