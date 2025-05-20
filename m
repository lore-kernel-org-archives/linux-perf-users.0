Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C80928466B;
	Tue, 20 May 2025 18:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747765042; cv=none; b=J4u1l8dMEqWDOTexQcEF90cIMMonp2XcENBJW0zoXvubpcs8qj/YZw9ZHitJW8tsZXtF4fTWe1nzUO8lccmAbQIY/7M8KGEbdagbmYT0lDRUMEpMGDgdGc43NHySrm9iL5+gthelGuweX9rwQaf+1IE+QopfA0w76cQSDjbG9/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747765042; c=relaxed/simple;
	bh=NhpvDIFF3RCGCMgFlua6GwCE5WabCIdXhqFSclRzhlI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V5Bkz32A25pHQimOgooQcyqLAiquUfiGedcaazEFOB1XY+ylDpdwQvhgBy1Tx5wBOM8loAqkv5rSYGAfF9d/b2A+lIWrXEPl9FkhXlqkFND5H8qG10WNtPcw/QEW2woW/aKf1E4V2Xvy0F/fqROwzzTEPYGyjmBqjY7kjWrz9h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N32/zIx/; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N32/zIx/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747765041; x=1779301041;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NhpvDIFF3RCGCMgFlua6GwCE5WabCIdXhqFSclRzhlI=;
  b=N32/zIx/CAE9z1ENwja9kgXEDfxUlAYWfmdFizS3GvDih2Bi2KCcb/F7
   414AgZk1Dl/Yalcs9g8sgypHjaJdtt68EaPlMiHTeRj74C6+RivkVk3+R
   l82g5e6pod6J+/A1AdTkAkExzmiaGQ2ClvNoXw5gZKuyV8fteTXVwy5vQ
   ngKGdZFg0NUyVi2BjPoSpUyVcCPBrsjOir1q+WJiUAaJW+QP3w6nMpi9v
   +/lRVu6MSlgghyA8yg8bL0uVwP0E6DjrXaTrV4PYvDsRaTUCzjz+p4u7l
   mZni0KFVlW5M8Dg64ZnjRbAAiX1UsVKwf3zDfpCQbGA7+9av5QOYShHFl
   w==;
X-CSE-ConnectionGUID: 240JnDbiTKux5NQAjwHgnQ==
X-CSE-MsgGUID: kXwvUSl3Q62BcDNaUxnl7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49848018"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49848018"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 11:17:14 -0700
X-CSE-ConnectionGUID: MWQgPnHHT9GHVVXzrxai1A==
X-CSE-MsgGUID: eUInIzdbQdqyPrIvWSagIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="144514718"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa003.jf.intel.com with ESMTP; 20 May 2025 11:17:13 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	namhyung@kernel.org,
	irogers@google.com,
	mark.rutland@arm.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: eranian@google.com,
	ctshao@google.com,
	tmricht@linux.ibm.com,
	leo.yan@arm.com,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-alpha@vger.kernel.org
Subject: [PATCH V4 10/16] alpha/perf: Remove driver-specific throttle support
Date: Tue, 20 May 2025 11:16:38 -0700
Message-Id: <20250520181644.2673067-11-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250520181644.2673067-1-kan.liang@linux.intel.com>
References: <20250520181644.2673067-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The throttle support has been added in the generic code. Remove
the driver-specific throttle support.

Besides the throttle, perf_event_overflow may return true because of
event_limit. It already does an inatomic event disable. The pmu->stop
is not required either.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: linux-alpha@vger.kernel.org
---
 arch/alpha/kernel/perf_event.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_event.c
index 1f0eb4f25c0f..a3eaab094ece 100644
--- a/arch/alpha/kernel/perf_event.c
+++ b/arch/alpha/kernel/perf_event.c
@@ -852,14 +852,9 @@ static void alpha_perf_event_irq_handler(unsigned long la_ptr,
 	alpha_perf_event_update(event, hwc, idx, alpha_pmu->pmc_max_period[idx]+1);
 	perf_sample_data_init(&data, 0, hwc->last_period);
 
-	if (alpha_perf_event_set_period(event, hwc, idx)) {
-		if (perf_event_overflow(event, &data, regs)) {
-			/* Interrupts coming too quickly; "throttle" the
-			 * counter, i.e., disable it for a little while.
-			 */
-			alpha_pmu_stop(event, 0);
-		}
-	}
+	if (alpha_perf_event_set_period(event, hwc, idx))
+		perf_event_overflow(event, &data, regs);
+
 	wrperfmon(PERFMON_CMD_ENABLE, cpuc->idx_mask);
 
 	return;
-- 
2.38.1

