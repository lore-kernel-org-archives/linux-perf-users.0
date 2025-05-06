Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98038286882;
	Tue,  6 May 2025 16:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746550100; cv=none; b=Q6zrs0GG+njeXXbY20WbbxWeJzTcJEZd5HfihYYaN0HQj+ourJvJG5/SVEuaFQCR2SeDUezPxAmAfKbbhlxRchHj8lLZzeNu42GQj2ZE59lqb7mpWQ7iFJ6ZfUuJxLwvvdmvo+h7sQIkFBIpQbTShdwSje7jQ6R+DIcn/KzmfTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746550100; c=relaxed/simple;
	bh=NhpvDIFF3RCGCMgFlua6GwCE5WabCIdXhqFSclRzhlI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z+/yydMPnEeod2xXzt+hOIW0KAwIcHy9TWqogmI8VRg8uLeN7HVvxJlabMDvyMY1KsQFfxUOXtbDtMNiohaKUn2Ormsr2n54Ul9pvUd2IpaQUA0NXoTWcbyEvxS2L09sn3BqbPAyCxof+6CDGuyyZAPGPheJnpKil+l3E25L9WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WpEmjktg; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WpEmjktg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746550099; x=1778086099;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NhpvDIFF3RCGCMgFlua6GwCE5WabCIdXhqFSclRzhlI=;
  b=WpEmjktg0kb6+NTNDQ6ru9jCfh/akuRPpeIrAfzjhMpBuuyc8y7Evsyy
   pxNeK9ZsS4h2JgBamvDJB+zdByMqZEFfOKkq1OlPOwzvDFhxFGZ0R2qKu
   9+oPyYOO+jjVeMJEUf9CeaUzMtesoOECW6xooXa0WB9EHZ6C4ynrWiuj4
   trOkozLk/ST/Qa1u7w0z+sd4TSi1V7IDy/ZzuBNpMutDk0re0iqQSKEUd
   2HYeKYePZoPDni2EiciN9B1KCghwtQ9wSpREavsc0LwR6NUATpC1w2Un7
   wmNUwLiA1YOLDC3Z1AkWXoui9Q+2uxVLpqv4OmNMvkoi4O0I1Um+kki/4
   w==;
X-CSE-ConnectionGUID: ZfYFRmwVT0uyzF0tF6P3UQ==
X-CSE-MsgGUID: bHpt9DRjRXuCeJ5TN/MKlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="59595300"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="59595300"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 09:48:18 -0700
X-CSE-ConnectionGUID: 7PwS+b2gSty16kOUsenMog==
X-CSE-MsgGUID: voF3L+7zSRiBnSGzrla8vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="135674881"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa007.fm.intel.com with ESMTP; 06 May 2025 09:48:18 -0700
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
Subject: [RFC PATCH 09/15] alpha/perf: Remove driver-specific throttle support
Date: Tue,  6 May 2025 09:47:34 -0700
Message-Id: <20250506164740.1317237-10-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250506164740.1317237-1-kan.liang@linux.intel.com>
References: <20250506164740.1317237-1-kan.liang@linux.intel.com>
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

