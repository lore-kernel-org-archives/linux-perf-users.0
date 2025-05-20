Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580E32874FF;
	Tue, 20 May 2025 18:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747765044; cv=none; b=PfjdLEbEwsVStx9XhKQ9aWBp3GN0LDFT2ftC4WRWFZwp/KGWRoxbXySx7UT3cUNs6U7VmhvkTHWnyUhYm6Z51WQvUgim0d0YOBHO657DlAriC7TTNr33AWbddEsbcEtrzxdKIZV1EzNa8h11hXocSp7uIAG5SSN7DzG87EPzygE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747765044; c=relaxed/simple;
	bh=dbXx+MD2QCNjSXPlgp390XJDfrTSi22QXjpUAVmjpNs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CHwmtvl0lc4wPuKYSsh05IF1/5FEUoIfO4A9bn9fiiFrOu92O76RTFzjEJrkbYpySgbxFNtEk98ly9rwvlw60fLtqQ1GKaWHdHvu4PamK5Trvl3Be5QrpZeryxpjiuFP3aS09PL36t3903gwtX2SF8TATvh4C2RfJruP0a9ccPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IpZya7Sm; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IpZya7Sm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747765043; x=1779301043;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dbXx+MD2QCNjSXPlgp390XJDfrTSi22QXjpUAVmjpNs=;
  b=IpZya7SmFWypX9RyAlKCveoDGsubmB33yj2a2D6vb8C+tgn5mxO5TzTh
   ri1p8ge/aQFoX1zxhQJGknvmOIdzv3yOGKaKaTd/mIwjIJ6jMIv3Q0B7G
   o4LtVm3UGvn/B39dL5xTNiJzquuBFloB58NFzOqZ6ILTVRGf/p/KWstiY
   n4nrUp7x0XhZHhlCqQsT9gW+vTmjxPj6PTM6DpFRIikP7N2arO8XkaJCW
   2kqMAzrVR4q3QRNHQi+SBWwDNnScI+ZCYAHcRTA9Ig/3R7jrd5NHsDJkM
   4y+lALFpqNgIMaxv6fBKZaUSputw/UI5j66GVuIgcfY/SnM5c1bzfAOzj
   Q==;
X-CSE-ConnectionGUID: IVW93gROQYa3hSSb3tXC/Q==
X-CSE-MsgGUID: XQ/Tb4XDRi2ggdpgqqUD6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49848038"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49848038"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 11:17:14 -0700
X-CSE-ConnectionGUID: TrTu6ZqPT6ypv9Q1C4ThIQ==
X-CSE-MsgGUID: 9XXQkyNdQSmcZPyPMEDAQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="144514721"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa003.jf.intel.com with ESMTP; 20 May 2025 11:17:14 -0700
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
Subject: [PATCH V4 13/16] loongarch/perf: Remove driver-specific throttle support
Date: Tue, 20 May 2025 11:16:41 -0700
Message-Id: <20250520181644.2673067-14-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250520181644.2673067-1-kan.liang@linux.intel.com>
References: <20250520181644.2673067-1-kan.liang@linux.intel.com>
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

