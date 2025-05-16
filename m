Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E867A27AC4D;
	Fri, 16 May 2025 18:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747420171; cv=none; b=dEo/lb45YDKj/cE46BtycnaX1aoZ+Tl1J3TwqEAXhwB3A8dlmAh5ZuyLwS4dGTQgcQoOBfyB5k0ZJkDc2Y4I671VcU/8FZa+M8T7lKgn5J29gTbEdYwwEaKNM48vshKSYJdbMjvGLzD/D+SiLHlQ53QWMBUgM6SKCri5WkvGh8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747420171; c=relaxed/simple;
	bh=rrfPQWQxUpl+1TbJT7SuB/unJ120m8U+rV6GjI5dzKk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sumlo0PW3LyZVohNJPK0PRqCS4e3Jg15LklScmB/HrdRfqzRbrp2GSHqTmAbX3N8HMmwZNr47YA0dUeNuRyJ87jkTJuoDaRB+QhRaJkGYq39K8UmZwpjLxRMR6aiGRyn9waaeHKVmpVgZMNcWly1BjswisIy5q98/2RvbMZVbz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YGJ5sR8w; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YGJ5sR8w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747420169; x=1778956169;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rrfPQWQxUpl+1TbJT7SuB/unJ120m8U+rV6GjI5dzKk=;
  b=YGJ5sR8wF/UzJ9iCWR9ltnypemNTkBkqJ9FBfCzsAIMC5uNTdZ+qk3Yd
   t0gkqH37tXsdY2XFK0ox8SKDSSrUw1tbS6Ws7k5aua3yCdkyKcqtnWS3h
   7fJDDh5gsW/2ob8K8kBe2HsD4F5EEoY4kSRjctuSlniXZpS0t1x8jBZXG
   IM7RK0VrIg+BcfNRmG/BEc749Vbt/Iwv6CHBDZFusCBQvu81TtaEUAlkZ
   ccJoEPFsLjCEygUa2hS8IxtbtBBPpcJDYx89/LIn1QHbYq5ten93+xTI/
   UwqnpZApEIjAfLcHCN7tBFDMZYjCuVpvediph3NG7RqTOqGEZHE9018bz
   g==;
X-CSE-ConnectionGUID: Kd8ALGHrTZWLRwyh095PCw==
X-CSE-MsgGUID: EapHDjHVTZq6peo+QpUNBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="49328884"
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="49328884"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 11:29:24 -0700
X-CSE-ConnectionGUID: b9INNUNXTxm5M/F446xQug==
X-CSE-MsgGUID: HTzrRv8lTLa9qlfqYLfWLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="169802619"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa001.fm.intel.com with ESMTP; 16 May 2025 11:29:24 -0700
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
	Guo Ren <guoren@kernel.org>,
	Mao Han <han_mao@c-sky.com>,
	Guo Ren <ren_guo@c-sky.com>,
	linux-csky@vger.kernel.org
Subject: [PATCH V3 12/16] csky/perf: Remove driver-specific throttle support
Date: Fri, 16 May 2025 11:28:49 -0700
Message-Id: <20250516182853.2610284-13-kan.liang@linux.intel.com>
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

Acked-by: Guo Ren <guoren@kernel.org>
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

