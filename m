Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F03F1B4236
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2025 06:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737527057; cv=none; b=Wx9kEDn+77zE1favPbYfwF1rsJTmWSAy0xJcl5l4bsIBTA97iN6nV+ZzWF/LYmfgzgOFOUb2Jfjo3Kzf5wUNWC5HboHoea1AytZKaFQQfZ7aPokuZ7VGJJfVtEmctQd4PS+Fb1LDN6dVHuYJu50iaK3hDV8xlV4rtPmTycxGeIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737527057; c=relaxed/simple;
	bh=34LHGO3ngg2rmxY3f/BTXoLwenK+i3H1vfkXaKKAQyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c3JQnyPfz6DmS8ugLU607sQuK/S/l4ppU3r3WX5zLI+49vR9k4Tah+QQsXQmgTaqKhIRTwOLIBgO7Li/sbWlUxdHB6fNKLupBJD8zl/qaRxc0BFWPsDRSMcf8vqfQvoXB0fOfzo9YqwrGK44nhLtFQ1Qtw7s33k+VBTfVqT6YyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e6GFHjfA; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e6GFHjfA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737527055; x=1769063055;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=34LHGO3ngg2rmxY3f/BTXoLwenK+i3H1vfkXaKKAQyk=;
  b=e6GFHjfAPmrKKT/o3Xl8UWTS9Dz8ywimh3ZfkJ31oLoP3SBhGVEbSZ7D
   5A6UMSI1p2LcYu1LcII7yZ0x1CQil4dHmhzBbuKf0BXKw7yboGDA1I64N
   YLHhbS+M8dYa6S0ekjVfPwC/5/7eJkcRKsFUUpeIOK1rbE9cM+tvttdTq
   Rx29CWOyr6etOzBX8ms0hihmBgjf56vPiPkNmLuu2xTf3MpnVzFhQUSn+
   hg6bOvNV9VYm+mS9DCZVb091+6vGp5MXvSyFi/R3YdzIFyhGfZLD5Cyd/
   y88EiMIDc4pqf60rkp2GUAyLfJxOYbF+tOV3a8ZMFfL6mOb6SKaju8wOg
   g==;
X-CSE-ConnectionGUID: +T1dgL8QRsukVlzYNIDKbQ==
X-CSE-MsgGUID: SDaTjpgVS/2eL/wpyQpSlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="41643295"
X-IronPort-AV: E=Sophos;i="6.13,224,1732608000"; 
   d="scan'208";a="41643295"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 22:24:12 -0800
X-CSE-ConnectionGUID: ktczvc4WSvywtqLLZW3I0Q==
X-CSE-MsgGUID: 0ELW1TDVQp+BP/eTUM/IJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="112015661"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 22:24:12 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <intel-xe@lists.freedesktop.org>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Vinay Belgaumkar <vinay.belgaumkar@intel.com>,
	Riana Tauro <riana.tauro@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH v14 3/7] drm/xe/pmu: Assert max gt
Date: Tue, 21 Jan 2025 22:23:37 -0800
Message-ID: <20250122062341.1100173-4-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250122062341.1100173-1-lucas.demarchi@intel.com>
References: <20250122062341.1100173-1-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

XE_PMU_MAX_GT needs to be used due to a circular dependency, but we
should make sure it doesn't go out of sync with XE_PMU_MAX_GT. Add a
compile check for that.

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/xe_pmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_pmu.c b/drivers/gpu/drm/xe/xe_pmu.c
index c5641af6e9a91..bd2d709453257 100644
--- a/drivers/gpu/drm/xe/xe_pmu.c
+++ b/drivers/gpu/drm/xe/xe_pmu.c
@@ -257,6 +257,8 @@ int xe_pmu_register(struct xe_pmu *pmu)
 	int ret = -ENOMEM;
 	char *name;
 
+	BUILD_BUG_ON(XE_MAX_GT_PER_TILE != XE_PMU_MAX_GT);
+
 	if (IS_SRIOV_VF(xe))
 		return 0;
 
-- 
2.48.0

