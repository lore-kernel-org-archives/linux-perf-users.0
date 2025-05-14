Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795702749F1;
	Wed, 14 May 2025 15:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747235693; cv=none; b=ayL1G2ifggn/E/mfaSO+Em09P4OFl3B99RfQWn9lCss2m/iAXmnXR4qwQcPEAVJXVfv0JgQGy3+hLr3lOeuVw9do8rmSYXFL3N4Qrl4wVM9S9QCWYceuEj+L/qxfUyKehQ32Nc2ZVMpsS1rrupAHV+qGSRjpIjlGUIBOA50jlqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747235693; c=relaxed/simple;
	bh=UsduOhasYm/HfIIj9WN3RQZEbqTT0MBS3lHLGt9ZIsE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZVnT18/aEBfPiwoM3Fs7/okANg05bBtVN/xWnobiAK9FwslCAw+JjqYuK0nvjZVcNiMgJc3Iy1cUGGABsYFv1Wucv4lZl0ORV2GuDyjynMWg9PXMhBWF7OcOYQZdVCWVNuxdoh4F30zQzbRTMoiR2Z2eFRRoIDKAr/pMFt9BceE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IT4W/YU8; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IT4W/YU8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747235691; x=1778771691;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UsduOhasYm/HfIIj9WN3RQZEbqTT0MBS3lHLGt9ZIsE=;
  b=IT4W/YU81HnNynSQ6sbg/u9hROl17aQAl+wjUWzEBO0E3YtnYNH+iJjH
   v0vOF6kBn2DPfwHY+yQN7mBWElNBZeXGZFOyA3V/CVKGeafYqhbRZpAS2
   lR1z3O5N1XnFARNnnPVXT0T+jyaDQEe1kcuslzqsdK6A2Hyae9eN2SQ94
   47tC8IypOXBfTwY6eEBKfqtT7kAiTjpvxotzwpSi8bHh80IZsYyNqrWZX
   kzUhzUYDb2HQTPFsbofY+FwlicnpRYmo952p25KKvjeBf3FE/yI33JOjh
   9Q3BB1S3266mU+L391RPx7QtuqTfr8Hsy3sn5CJ2BqtBpHXrgtdRVf0Rp
   A==;
X-CSE-ConnectionGUID: fOJn6xEaTZ+PBbySguwSbA==
X-CSE-MsgGUID: WmMpWnuhTT6ECc8iGF0syQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="49072782"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="49072782"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 08:14:47 -0700
X-CSE-ConnectionGUID: 2sZf2b5/RXG+mXmpRA20iw==
X-CSE-MsgGUID: tembz7sPSrmxQ6jxfscfVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="142939175"
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
	Mao Han <han_mao@c-sky.com>,
	Guo Ren <ren_guo@c-sky.com>,
	linux-csky@vger.kernel.org
Subject: [PATCH V2 11/15] csky/perf: Remove driver-specific throttle support
Date: Wed, 14 May 2025 08:13:57 -0700
Message-Id: <20250514151401.2547932-12-kan.liang@linux.intel.com>
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
Cc: Mao Han <han_mao@c-sky.com>
Cc: Guo Ren <ren_guo@c-sky.com>
Cc: linux-csky@vger.kernel.org
---
 arch/csky/kernel/perf_event.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/csky/kernel/perf_event.c b/arch/csky/kernel/perf_event.c
index e5f18420ce64..e0a36acd265b 100644
--- a/arch/csky/kernel/perf_event.c
+++ b/arch/csky/kernel/perf_event.c
@@ -1139,8 +1139,7 @@ static irqreturn_t csky_pmu_handle_irq(int irq_num, void *dev)
 		perf_sample_data_init(&data, 0, hwc->last_period);
 		csky_pmu_event_set_period(event);
 
-		if (perf_event_overflow(event, &data, regs))
-			csky_pmu_stop_event(event);
+		perf_event_overflow(event, &data, regs);
 	}
 
 	csky_pmu_enable(&csky_pmu.pmu);
-- 
2.38.1

