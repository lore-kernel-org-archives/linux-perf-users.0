Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3A9280039;
	Fri, 16 May 2025 18:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747420170; cv=none; b=iYRylZ54x93FKpWeoPkRM6fjd+xCAlRyvDe6Yls+I5Z7JGCYVcO2EKeM9IjOkex7nJ0FkxZEh/P+oI9pa1l6XtNmIhkNjOYMzvKVWrQyZmEsuVd2h9CMTcbcH8x/jqGF12kPt91izvRKYvGdDnMwS9zs/ubVzib/jiHU/IrY81A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747420170; c=relaxed/simple;
	bh=F4Te9Lur/xFSTBMdpmhCbCj26jVQpoawEm3xShr4VJE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=us4gSFHKNk6bR7zeSVB8NPJSnb6d9a8755ue7IJ5q2HV5uF8Mcakcm1pHpgK260xkgkSB9VHH/SNPcL5x/Drp5SnyZ/A8mhrp355a098SC1yDtSjivBysVF0MHB8SbwVDxnCU9BUqqjI3ChWqSwcgZfoVJUbxxO76HLFlttxR58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hXFpkhA0; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hXFpkhA0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747420168; x=1778956168;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F4Te9Lur/xFSTBMdpmhCbCj26jVQpoawEm3xShr4VJE=;
  b=hXFpkhA0hlRzIM3NXe/XNc2YowFRz+qiRQbV1jG+/I9PJ1xxConSDkJ2
   8ZLNIOgVdGAcM9HxGCAkC+2r/Oy4hnxlVOOW9dZakgBnshRVCHemMzLjO
   K+1Fd5Y7FjsSN0OMvjib3tlJZUEyiPGzJQw8CD5r0xOyvs+4qfJ+V+7Y/
   C9GwdOAXjyOw5ZJKv1XGGdO5oIMWuDRGnF+c6MSeBkiQA8mpKQ6jD9ebj
   NCopKABNOwDOoOULKleXd0qK+1R/EdiQqVO/RppnshuGyEQvBQf1KOvLU
   z3cvPDSbVoXD9I8X8a4Lw8vxpvX4rp1ZiQnbVienRbNPxw6gpbsWEU/c6
   g==;
X-CSE-ConnectionGUID: N0alcjjMRlC3y+h/xNEgiQ==
X-CSE-MsgGUID: jg5YishDSCW6ba2UBcsi7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="49328874"
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="49328874"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 11:29:24 -0700
X-CSE-ConnectionGUID: UBs/ihSUS9CKF92ke3GkYA==
X-CSE-MsgGUID: jZ7zldPVSQqDVnoqwuidxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="169802618"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa001.fm.intel.com with ESMTP; 16 May 2025 11:29:23 -0700
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
	Vineet Gupta <vgupta@ikernel.org>,
	linux-snps-arc@lists.infradead.org
Subject: [PATCH V3 11/16] arc/perf: Remove driver-specific throttle support
Date: Fri, 16 May 2025 11:28:48 -0700
Message-Id: <20250516182853.2610284-12-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250516182853.2610284-1-kan.liang@linux.intel.com>
References: <20250516182853.2610284-1-kan.liang@linux.intel.com>
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
Cc: Vineet Gupta <vgupta@ikernel.org>
Cc: linux-snps-arc@lists.infradead.org
---
 arch/arc/kernel/perf_event.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arc/kernel/perf_event.c b/arch/arc/kernel/perf_event.c
index 6e5a651cd75c..ed6d4f0cd621 100644
--- a/arch/arc/kernel/perf_event.c
+++ b/arch/arc/kernel/perf_event.c
@@ -599,10 +599,8 @@ static irqreturn_t arc_pmu_intr(int irq, void *dev)
 
 		arc_perf_event_update(event, &event->hw, event->hw.idx);
 		perf_sample_data_init(&data, 0, hwc->last_period);
-		if (arc_pmu_event_set_period(event)) {
-			if (perf_event_overflow(event, &data, regs))
-				arc_pmu_stop(event, 0);
-		}
+		if (arc_pmu_event_set_period(event))
+			perf_event_overflow(event, &data, regs);
 
 		active_ints &= ~BIT(idx);
 	} while (active_ints);
-- 
2.38.1

