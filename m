Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D424128850A;
	Wed, 14 May 2025 15:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747235692; cv=none; b=jF04u2u/lhZGtMSHFjKyGAhDBxEicuTVB+ZD46lOS67eWxLN3l6SdLnk9iDJzo7hTQvNds/LZBOF4sBH7WUdE8IrC1Z+Fes50b3ijgKrdzFE/ZbrrI34elboUmSrfJ1qs5Sp02JAGINnJ+H8M1ZPDy/+1MuyIFbdx1EwtpVPD34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747235692; c=relaxed/simple;
	bh=F4Te9Lur/xFSTBMdpmhCbCj26jVQpoawEm3xShr4VJE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NEWQJRqs9PpHt9iOOZWtwpNX/HQpng7DUrdkXuFxDBf8orTwdt2rnGMkkvCK9D13EGY5nhpL3dSoXdW5EcwNHn+Pt6bfFyQCfrpyl0jM3jRYQQv5hpoAZPQp4k50404XNfKnOAKhG+rEMEqTLCqAlM3xscol5Zc9zCFIswUa5SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GHVWe1sM; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GHVWe1sM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747235691; x=1778771691;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F4Te9Lur/xFSTBMdpmhCbCj26jVQpoawEm3xShr4VJE=;
  b=GHVWe1sMv7Qj8jO2fAqivp+1jeDL2/PEw2BB5MDZlcHCJg9zgEVXbtgI
   u3WPIT7MnM9X5Qg0Ipns/f4Z4WqB38qpsMEl1HqQ9nlRbqztXoA4oZN/h
   ilBHGQl/PhY0v9Z5fgPLtQFEHouQlkQSNDVIQspcpTqkQM9dVGH4rUBh4
   IJvmpLgQko092pRWL/IDDPRreTXCoAk0XyZoejrYDZ2s3zeDVtWVBISWj
   i+SEUht6rAfioNHLi3jap3Tf/RKxmyS9LzGRAzpNsiElxfABepU5MJ6K2
   Y5D9j3CbrMsw8nFGO1+DA+w3rtJ0QW8skThp6xSO7RcjvHYSFHLdrVd0e
   Q==;
X-CSE-ConnectionGUID: mvJaTH+4RkigJDLk8rZSNA==
X-CSE-MsgGUID: JXn+umZ8RZynA76hCEkyyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="49072773"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="49072773"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 08:14:46 -0700
X-CSE-ConnectionGUID: ZPSRUvmATVmhHNzzC6m1BA==
X-CSE-MsgGUID: vN5sn9IBR5Ke/vVIvDfstQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="142939174"
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
	Vineet Gupta <vgupta@ikernel.org>,
	linux-snps-arc@lists.infradead.org
Subject: [PATCH V2 10/15] arc/perf: Remove driver-specific throttle support
Date: Wed, 14 May 2025 08:13:56 -0700
Message-Id: <20250514151401.2547932-11-kan.liang@linux.intel.com>
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

