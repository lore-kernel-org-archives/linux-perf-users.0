Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6E421D587;
	Mon,  7 Jul 2025 20:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751919528; cv=none; b=HnqzuTlk0TFIaKVo0zBORCSFsrVAlCNH9Y4KeDiqq6aw4Zx99V7uvfrUIXr11u8c5WFD8R9ehgmWeBIuB7oIiA5JqV1k3WaCpLHQ3rm2MYiHthrLPlrxQYc19JNSD/FMALze1MXbJ8sotGG2OwCzl1h5QyTaZoeseUhlHDDPepg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751919528; c=relaxed/simple;
	bh=J/tpyNMIY8MwiYNS7WD49SghFlV/J5ALM6CNukixufY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eYoUkCgHEdgiKWwYs0KmwsBQdr6N49DPWnscbCVlxpuS25IopgCkWehRifOXstL+BIf/mTwwxld0fhC8ZV4WXBS2G1KSAncOJ1lZ2zxidxwZNkYYfFbQwVjI6n0ICunMmV4e7uvCMUFPl2JcpWVq2hqNxZoTRHaApRgQ6nw609E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TFJrv+cq; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TFJrv+cq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751919527; x=1783455527;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J/tpyNMIY8MwiYNS7WD49SghFlV/J5ALM6CNukixufY=;
  b=TFJrv+cqlt2Teb6txZifO0k+ta2h2hD0C9JVGQ4xnx8OQbDHINStTkg6
   DpOb16SCVCoclSO+15c4Q1+zDM97TNjyJnX5iLXqtD03ouAgNnN0XL6mw
   oJ5sosaP3l0p3sReZcrZKrx0xUncb2hBVzwfgrTsTZZ4zmWQL4C+kIYku
   0FuqQrZ/LObFxShNkUCj+N3u36WEufEoSBfQjQIwDVqht27TKgs62bLvT
   1zOdLG1Py7vnJDyAdhNTboFg/bX1hvknKJB53zprm3Qi52om+BGOHf/yc
   69qiLi1W7XUNPzxNCt3nA0XBL47JLk/2Ac2ffEXelnBsL04zkfu/HrB2h
   w==;
X-CSE-ConnectionGUID: /V2cvSGwT6+QVBLJIvNFyw==
X-CSE-MsgGUID: FZ+WNinLTmGR6efguSPKFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="53362326"
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="53362326"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 13:18:45 -0700
X-CSE-ConnectionGUID: 517HcFLGSWCsqGohDgqzFg==
X-CSE-MsgGUID: Zvuu4Yo8THWtOn2udTZunA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="159343676"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa003.fm.intel.com with ESMTP; 07 Jul 2025 13:18:44 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: dapeng1.mi@linux.intel.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 4/4] perf/x86/intel/uncore: Add iMC freerunning for Panther Lake
Date: Mon,  7 Jul 2025 13:17:50 -0700
Message-Id: <20250707201750.616527-5-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250707201750.616527-1-kan.liang@linux.intel.com>
References: <20250707201750.616527-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

PTL uncore imc freerunning counters are the same as the previous HW.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore_snb.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 817dddc1454d..a8c4afc9cdff 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -1905,9 +1905,17 @@ static struct intel_uncore_type *ptl_uncores[UNCORE_PTL_MAX_NUM_UNCORE_TYPES] =
 	[UNCORE_PTL_TYPE_HBO] = &ptl_uncore_hbo,
 };
 
+#define UNCORE_PTL_MMIO_EXTRA_UNCORES		1
+
+static struct intel_uncore_type *ptl_mmio_extra_uncores[UNCORE_PTL_MMIO_EXTRA_UNCORES] = {
+	&adl_uncore_imc_free_running,
+};
+
 void ptl_uncore_mmio_init(void)
 {
-	uncore_mmio_uncores = uncore_get_uncores(UNCORE_ACCESS_MMIO, 0, NULL,
+	uncore_mmio_uncores = uncore_get_uncores(UNCORE_ACCESS_MMIO,
+						 UNCORE_PTL_MMIO_EXTRA_UNCORES,
+						 ptl_mmio_extra_uncores,
 						 UNCORE_PTL_MAX_NUM_UNCORE_TYPES,
 						 ptl_uncores);
 }
-- 
2.38.1

