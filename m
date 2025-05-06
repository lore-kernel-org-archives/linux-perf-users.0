Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21F928751A;
	Tue,  6 May 2025 16:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746550104; cv=none; b=FkDRmmAURWtZbhhUwJLKwf0YXe2NK0GK/U4duMfkFLHromQeyUtRXM0Nfi+7eMqiwWk/cDFKMalBQoIu6isyRyoP51iQbjwh9Xb3kFWDkZ7LcQE/h6APjKluYGLKa/4RuQcOotD7nPUAuOeRnzdNdSzfEQbSuFiozBEhm39p000=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746550104; c=relaxed/simple;
	bh=4mpX1YmJsKhiwoN8Qz2qbRy/2tQafGlzgwM0Wm9azSo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dVWhynAWt0ogKqX0KZ/BVCmIZe4xWmURWKIHsIrMsRMBj04KmknWW5XyymzVy41H7EUMEDOGFhvMVfML2JlyiVRxrB7RvNcZvy+EpFuV2v9rWkoeXbyFDstvQ0fZYlW2EXisKNR+lcfthj7Bjav+f2wzj2qL0chLJwdyK+qhmjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=isnW4O+e; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="isnW4O+e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746550103; x=1778086103;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4mpX1YmJsKhiwoN8Qz2qbRy/2tQafGlzgwM0Wm9azSo=;
  b=isnW4O+eQweU3B7x9FnMHUrrwxNWPDhE9XVBK7aTPp732rmOSqD1XPcD
   yH6q7eDWVPuJL4C5mHm9XyGzFGLdatnIN0hnRA2UpRWQCBkf+Dhlhsom+
   BbfJSU5VzHodc+ivKJrZsRY6rp0jjiUyrSdtg1I+yvc7Mc76ZkaRuUZ67
   dOs6/CaVNFLTWyplm35tsExfq51k9Z4Clr9ORxvJgUJOotdmo+JhDw+VF
   HY/haMDysLqcmQ8ry/tXfZacdG9apBRCkaRJw9qtkuVSO6g31fIJ6NIdG
   1YPKnySYjIXMPO4KfmJjUAQgLOINqZI6KnODXpjUgaQoSg0VdsBONuYfu
   A==;
X-CSE-ConnectionGUID: vNhQZMsWQGS4aWmnMXgn+A==
X-CSE-MsgGUID: wsObRy7CQNS6q+bZpqzxgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="59595341"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="59595341"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 09:48:22 -0700
X-CSE-ConnectionGUID: MnshmrgQQDq73z9YdAaT8Q==
X-CSE-MsgGUID: wLLBYeL+TkS20ZXm+AXRqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="135674904"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa007.fm.intel.com with ESMTP; 06 May 2025 09:48:22 -0700
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
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [RFC PATCH 14/15] xtensa/perf: Remove driver-specific throttle support
Date: Tue,  6 May 2025 09:47:39 -0700
Message-Id: <20250506164740.1317237-15-kan.liang@linux.intel.com>
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

