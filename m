Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DFD280A2E;
	Fri, 16 May 2025 18:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747420171; cv=none; b=tnvUzM0TmCz5JF/p+g59WFJ0QaMbI0wC6OrEl1KhkhtlaBoCdwWMLeaiL9C983VlBq0xcrDLmly5QjMDN/3BVU3zPCI0j35Xyoe2VwDGQAB6Vp63ieHYSH1CiOxkcoUNXYGUAxF+omnyt7m96u1efkQvx1ITPBl7NjPDz4t0kqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747420171; c=relaxed/simple;
	bh=dbXx+MD2QCNjSXPlgp390XJDfrTSi22QXjpUAVmjpNs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lo6yS67T+iYxZGtHl8N6+VRG8p4X3G020F5sKHkbjqiJM6S+i4YVdTvKhVNiZT/jufsZ7aJw+EoT/x7CsF8JYNP9EYMN2O2mj2vCMgvSuUW4zBsnE+aSmoCCg5dZJqlcRtGRCRl9dALv1J6fK2XjQTzZrHngjJV1ClsRAEKcGLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SYfNRJW1; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SYfNRJW1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747420170; x=1778956170;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dbXx+MD2QCNjSXPlgp390XJDfrTSi22QXjpUAVmjpNs=;
  b=SYfNRJW1aYriORB6kuTI/9NibzAJHMNX1TD/o1ZxSqjcGnAnX+O939su
   TrDcBSQFdZ4qqrzaXC8L974NpV4MIWPCC6qTR1pJtrfR7rG+tyuro7pG+
   aphCNFtPej02BSlx7AZAsRX8GTa/1jfMgHjSicSIgyH/qvB2dGACOPKKd
   Vrj1iN6Mfat64MuO5w97Iy5OfyQC48dyaTweFbBPlrmKFaMGj0ibB7cH0
   JElVuJ/mBMDV7dQdjWbrYv4oBvo+7B1E2gixnp4QJklmNknpgF07wlxJa
   4/lp01fK3FHPFV2eEJr/Vcks8wanW1PZwDMQG8zWPmeAZO/y+LuxXfRp3
   w==;
X-CSE-ConnectionGUID: p1PG1uWhQEKJL4W9o1syvw==
X-CSE-MsgGUID: KHOKhgQkRy+GXnF+c9+Caw==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="49328892"
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="49328892"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 11:29:25 -0700
X-CSE-ConnectionGUID: 2mfqUfHSQ9WU4ftQ6Yo07Q==
X-CSE-MsgGUID: HyEO6Qh3TJu/Eqdx6PeuxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="169802623"
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
	Bibo Mao <maobibo@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>,
	loongarch@lists.linux.dev
Subject: [PATCH V3 13/16] loongarch/perf: Remove driver-specific throttle support
Date: Fri, 16 May 2025 11:28:50 -0700
Message-Id: <20250516182853.2610284-14-kan.liang@linux.intel.com>
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
Cc: Bibo Mao <maobibo@loongson.cn>
Cc: Huacai Chen <chenhuacai@loongson.cn>
Cc: loongarch@lists.linux.dev
---
 arch/loongarch/kernel/perf_event.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/loongarch/kernel/perf_event.c b/arch/loongarch/kernel/perf_event.c
index f86a4b838dd7..8ad098703488 100644
--- a/arch/loongarch/kernel/perf_event.c
+++ b/arch/loongarch/kernel/perf_event.c
@@ -479,8 +479,7 @@ static void handle_associated_event(struct cpu_hw_events *cpuc, int idx,
 	if (!loongarch_pmu_event_set_period(event, hwc, idx))
 		return;
 
-	if (perf_event_overflow(event, data, regs))
-		loongarch_pmu_disable_event(idx);
+	perf_event_overflow(event, data, regs);
 }
 
 static irqreturn_t pmu_handle_irq(int irq, void *dev)
-- 
2.38.1

