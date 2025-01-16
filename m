Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE561ADC81
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jan 2025 23:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737068866; cv=none; b=Tm0gJq9c1wxh8PwvIOb2HwP5ojxwPXzG2yJ36Q2FjXZrcrUpb4jeEt8Dm+iiqrGrpgjlRtxcbq5CO2owfBX5MA7uW140iXuDF2CsDkILL/sW4sKULukk+V0Lwk9UDLL+KMBIUIjpQFB+oWjhCDvoq5wkri2T8OH9aojl6ajGJ5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737068866; c=relaxed/simple;
	bh=V6aklTnNRjyy3hx1cVBJla1fNTKIoJtFZGS5jbt8x98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1mYNUcVFROfSUDWKEG5tppbNoNgQy7tFJMu8F0NAoMYtCBiaVbiBggo4p6RaLPloNW49Ela05+P3EJY8Ci1+kSp8ztUiaI8QmGz3WUtEcExjoywPhkU2/yx4ZupVInz36gY5DapkBt780oCtOYkasONYkm+2tksdYhdDln94sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f8ZjHWGC; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f8ZjHWGC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737068865; x=1768604865;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V6aklTnNRjyy3hx1cVBJla1fNTKIoJtFZGS5jbt8x98=;
  b=f8ZjHWGCaNx+OqLuF+uiRKzgKVJpjGCrozlcJQtZ3WFF/5gwI0MkXyRs
   32BOeVJUnmn6lHF++BzmklSZKwPCVzwJoeQlX7f4rChYxe5y60PKDXymG
   zqFsc9cjYrYYbQVIgTpuJNwZchTSuXVXJuvp3hcQworPJeOEk33N0yvbO
   0ZGcv/t/p1wpVavCSwUGYs61T6fm370XjpypzCdHAAtWjk7TQCbfuYAA5
   DKNBlRXkGFAuJfq4YEDuODhoDIkuZ4drxnoxx30b9WjZarE1x74qEqo0/
   J1qL4ieksG+BmSx0SrrxtRAnloVw0s3mFOs0P6Qv7mp4zMMT/lKTR21Lo
   g==;
X-CSE-ConnectionGUID: whvmjzNHQs6ucXJRc7wZ3w==
X-CSE-MsgGUID: Q70XmAnCTLSlT9ZppgA6gA==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="37364119"
X-IronPort-AV: E=Sophos;i="6.13,210,1732608000"; 
   d="scan'208";a="37364119"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 15:07:41 -0800
X-CSE-ConnectionGUID: Lfj59kN+T3WCCs33KtJ65g==
X-CSE-MsgGUID: ZIa//T25QXCZN/LxLGRpkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,210,1732608000"; 
   d="scan'208";a="136474351"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 15:07:41 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <intel-xe@lists.freedesktop.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH v13 3/7] drm/xe/pmu: Assert max gt
Date: Thu, 16 Jan 2025 15:07:14 -0800
Message-ID: <20250116230718.82460-4-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250116230718.82460-1-lucas.demarchi@intel.com>
References: <20250116230718.82460-1-lucas.demarchi@intel.com>
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

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/xe_pmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_pmu.c b/drivers/gpu/drm/xe/xe_pmu.c
index b63f819c54d02..2312c73a3ee16 100644
--- a/drivers/gpu/drm/xe/xe_pmu.c
+++ b/drivers/gpu/drm/xe/xe_pmu.c
@@ -258,6 +258,8 @@ int xe_pmu_register(struct xe_pmu *pmu)
 	int ret = -ENOMEM;
 	char *name;
 
+	BUILD_BUG_ON(XE_MAX_GT_PER_TILE != XE_PMU_MAX_GT);
+
 	if (IS_SRIOV_VF(xe))
 		return 0;
 
-- 
2.48.0

