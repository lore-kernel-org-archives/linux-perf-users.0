Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F24D281357;
	Fri, 16 May 2025 18:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747420173; cv=none; b=HOkMNhPwkkz6yq9iAnLK4kN/bBFIL7/V5Ws58+g6LcbKcTyxCYh9o6LvWhxmv6NX37Tlk7SI6HlKZNyLVSDEDqkodeBNP1J7JzlrKKG9mrvAOL+XWMS8zYe3ssgt+8otXSozq5Ui4IUF9d9amS5GNkvkGBI4iZcD3kpoOoCpI18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747420173; c=relaxed/simple;
	bh=NOF3NytMVQIJq/xAjPCxlMah7ql+VhgMWECiQmo4kho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pHYenEbQCBBwbh3Mvo8JQtNgYJh4480TVxmkMm7XVCrElzO2VvCNAg51bZkS3We6akgC9tMfwPT/YD941PZafbw+gOO9BaxYfB0I8AduRluuksMolAQDpWUjsp0DUSh4/7+2wyU9IVe+0szxerxEG2nBSw/yCnXjM6+jxlZW/7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=efgOvHrO; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="efgOvHrO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747420171; x=1778956171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NOF3NytMVQIJq/xAjPCxlMah7ql+VhgMWECiQmo4kho=;
  b=efgOvHrOBKrR7+oXEx/FxLh01T1US29sY0EsNQOt5rcxIvw0k5r/pnZx
   IZx9qTUqqwZ+g8jIKnFZbR2S+Qn4FJVn2vB4cBNbI58bYEYdjjYOBLRCl
   6g0shnws3nmp8Zib2NNy5svCRc0AZWkj5ssSXXBS1S+qaXTIe5hFnHUOS
   fvwoybtFtz/iig0PWglJh8xUBgZafK/leCnCxGSHhn8sjjK1T5CdoKR+v
   iTPHGCyGJoyGx/cD1Zg+P2k9QGcDfx9J+BxV4quWsIlEk08mSchSVui04
   XtGojNos7BSFzuQ4uUXhsexQqb7nxSMX16MZgN7QrjiWyYgs1Xuf3WER3
   g==;
X-CSE-ConnectionGUID: oInPfugZTjaBzrioztxFcw==
X-CSE-MsgGUID: PDhVRxpuRQG7qvLHmXf/Wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="49328911"
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="49328911"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 11:29:25 -0700
X-CSE-ConnectionGUID: x2noIWp5S3K8I9LViob1CA==
X-CSE-MsgGUID: kBEGDkyFR6uJrDXQsAnDpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="169802626"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa001.fm.intel.com with ESMTP; 16 May 2025 11:29:25 -0700
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
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH V3 15/16] xtensa/perf: Remove driver-specific throttle support
Date: Fri, 16 May 2025 11:28:52 -0700
Message-Id: <20250516182853.2610284-16-kan.liang@linux.intel.com>
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

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/kernel/perf_event.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/xtensa/kernel/perf_event.c b/arch/xtensa/kernel/perf_event.c
index 183618090d05..223f1d452310 100644
--- a/arch/xtensa/kernel/perf_event.c
+++ b/arch/xtensa/kernel/perf_event.c
@@ -388,8 +388,7 @@ irqreturn_t xtensa_pmu_irq_handler(int irq, void *dev_id)
 			struct pt_regs *regs = get_irq_regs();
 
 			perf_sample_data_init(&data, 0, last_period);
-			if (perf_event_overflow(event, &data, regs))
-				xtensa_pmu_stop(event, 0);
+			perf_event_overflow(event, &data, regs);
 		}
 
 		rc = IRQ_HANDLED;
-- 
2.38.1

