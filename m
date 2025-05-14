Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09282882D6;
	Wed, 14 May 2025 15:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747235692; cv=none; b=UFRdDmaT6ENc0wq1OnewGw9HaaWnFkJueIPmZKhia3ANo0AVDO/v+08U2m62Ks9nJUVbn0FI6TXc/SBHcVo4H4l4dL/IPZRSCWEWPsBtSYBQZA1mfZeYRUZ+4lFnYl3ugh0LElgJV2fGl4SmIjOTXb4xokHqYNU6TIgzZT9TqQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747235692; c=relaxed/simple;
	bh=NhpvDIFF3RCGCMgFlua6GwCE5WabCIdXhqFSclRzhlI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z7fLj/lw0BwFZamsKJlFrY7hoWQTjtinPMOjxDs5LzrKZeKrg+RZzhx9+XEFKncxHAQkKWoS1AqB0HeoMA4K7eBD1LrlTZ5kHMOQq/4Hpqu7UpyWaN96FNHRkK5cLVJJP3wSbx6Fe8AUDMHFIJjvfDT+Yrc6I9MOZHoav+isxoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Snfak2FR; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Snfak2FR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747235691; x=1778771691;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NhpvDIFF3RCGCMgFlua6GwCE5WabCIdXhqFSclRzhlI=;
  b=Snfak2FRQTTNEv02yZuXd9UI0Rnov3u8vn40QYa9crEgQlPeTsxcOt4D
   FYz03DTBuWT9vzVbHRY3ctypNUc6pwt/RTcBjs7br0QT/cY9L4B5Clij2
   nbxJhCAF4RrJ/SCwdVQzFyh1QtFAk2fvRygFUHxm2UMwvF1mvOPae5Xxw
   5pMt/AoirExAGhAjwrXLWCNjC/uSoVBMu38vKdBMHjVGiEeBz/+KJ8IzT
   xJA7YicXivuynRjCnil68LBNpUl9t0+iRsywzVdKq/YkrvbOpDCmF87Pa
   vMnWW9A5ItYipioFSpw29sNTj+Vw1+3lkAhNWrhYNqaBr9j4BpAeypqar
   w==;
X-CSE-ConnectionGUID: rxRJj5EgRy6AzG7fUlzwIA==
X-CSE-MsgGUID: dbC7JQHiRR2SVNahh+Uw9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="49072766"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="49072766"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 08:14:46 -0700
X-CSE-ConnectionGUID: Z7MrihvETrqWO9x0Bqm68Q==
X-CSE-MsgGUID: mwVaS7OrS2eDOd8QyPEg6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="142939173"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa005.fm.intel.com with ESMTP; 14 May 2025 08:14:46 -0700
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
	Kan Liang <kan.liang@linux.intel.com>,
	linux-alpha@vger.kernel.org
Subject: [PATCH V2 09/15] alpha/perf: Remove driver-specific throttle support
Date: Wed, 14 May 2025 08:13:55 -0700
Message-Id: <20250514151401.2547932-10-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250514151401.2547932-1-kan.liang@linux.intel.com>
References: <20250514151401.2547932-1-kan.liang@linux.intel.com>
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

