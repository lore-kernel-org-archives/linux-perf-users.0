Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20B428001A;
	Fri, 16 May 2025 18:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747420169; cv=none; b=cPWRogs4alNswZZ5zzLWlBA/cC3D+mmq87i9NYtbcrpNEqFN1eFeljD2CDbR0agoyXEhnrX/yqy8FQWDkNNzpVpFF2xZJzLAMlkRHcSo2diLKL3fYqacCDAHu7yihctd0IUju+RQPBAIJOauvWWWLNJXS2X+qgdaMuKOL3A14jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747420169; c=relaxed/simple;
	bh=NhpvDIFF3RCGCMgFlua6GwCE5WabCIdXhqFSclRzhlI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OCebro64Qm+qYG0oh71MefdxU9DpupTF8bhOiCTAaLI5u3i1JIyUzzCBI+JORyrqHkfGkwK47owmy0Br/srM+6O+6PaWuY6fedNhh1A23vxqVLYWiPmUJnvniGKkBJqR/7NtuHa+ynatcVo45yrbwAHWEFZ53kaejeTGkbncGTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZTsHu32M; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZTsHu32M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747420168; x=1778956168;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NhpvDIFF3RCGCMgFlua6GwCE5WabCIdXhqFSclRzhlI=;
  b=ZTsHu32MakuoMjSWefbwXDRjrm+BTmvTQE7vYZxuHJ+Hsjuxfm5JzL33
   NDkc846/fKXYhXWF7lS/YEv/LRg57B9DUsPIkfXn30v1WPK2nd4Cwdv9a
   V5BoA+A7QYuBlf7xsx48eI+iSsQR27OMrEoTIDdb0jKAUMagxi7/FGoCS
   DO9POy+DRgph0fFTbErPTtKIrxCqPmbQVJgFV7uJFV3T/6YitaPIcP5Ux
   uSlTBKX7/NzYNmMWcQT1nM4PThbx/Gd1LV1L7MCx6D30w/6Y2Az3gqhWH
   c4z7f2gwQH7WbezZEmDWk+tqN7LxoA5cKDnhTXlS0gbEv4fn2f4Ul0ihM
   g==;
X-CSE-ConnectionGUID: jflZxhgEQDGcAnj1TC75WQ==
X-CSE-MsgGUID: iN/dxF/WSOm4Z3MDwLI0Ew==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="49328866"
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="49328866"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 11:29:23 -0700
X-CSE-ConnectionGUID: Sn8H+58qRoiqv15RcJK9eg==
X-CSE-MsgGUID: UTh6VnOpSGKQDwwaF8/Anw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="169802617"
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
	linux-alpha@vger.kernel.org
Subject: [PATCH V3 10/16] alpha/perf: Remove driver-specific throttle support
Date: Fri, 16 May 2025 11:28:47 -0700
Message-Id: <20250516182853.2610284-11-kan.liang@linux.intel.com>
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

