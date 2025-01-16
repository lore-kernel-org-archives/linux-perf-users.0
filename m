Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0099A22CF02
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jan 2025 23:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737068866; cv=none; b=fDbB1Ztc64a0DwsJQTNv1TIKgu+67VXtbXrq257r0pXv6oXg+vdYcVPe53HWSmydZJfiGVBV2tUoBaqkDnOH9kurzVDVgF4kpda2glWlg2NH/Amwm3WYssRbB4Kpx63aaZRBAFTa2A2EnZdkKhL8ZZ72RmkKnLsnwH6m1mZrNDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737068866; c=relaxed/simple;
	bh=u7TvqDRwRMY6AHEBtwgMJ/J4HU6CT2rk5v9qE/XEagw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a8obBeoMRMIsg+QlU02s4AL9qBttlzsKQ2hzfZ7SQ58eaDH52KJcUjeysL+tvUOaBtf7DrKH0ki7XFIIWxLatrCLmLxDhMOvrtmEWb3z1HCjks6oD2Z423Z1XILlHuHjmzJcLSEBfxF+3A1mY7AB7/6VOEIp4SmsKjhHsiKaNU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GuTS9hIb; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GuTS9hIb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737068865; x=1768604865;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=u7TvqDRwRMY6AHEBtwgMJ/J4HU6CT2rk5v9qE/XEagw=;
  b=GuTS9hIbFWuk2xljpXdpA8rvDwIfNp9nCXZGTL7LYznZvID1po41Yx3p
   FM0/NZhAcAd0K6/T1QHuknctu+G3B0ZJmrHwNv2jctzX7erpZO5q9JW5v
   6EEZGbjNRooivsg8Qlz58PdCD2RlGid4trXkM3rxGluZEzDBobL7eOxL9
   ZdXbzlotok9g9eD5sN/zcOQDqVykIjPIfxXggCmxjiraqA1Iu8BImZVlB
   KOyD3Vf+Y3KcrAH8wcQc5dh0Arr2nmLaq5Hz6agg9FKLdj+OcwpMpI9B7
   yROKXRjlHf62Jw4LP59uSHApd8ZfsGAeYtnRDp1bx6DfgYIfcq3tCuHiJ
   A==;
X-CSE-ConnectionGUID: yxFlyFglTXiovzch6PwF8A==
X-CSE-MsgGUID: XvOnaMf+QQS8f6udWgWLAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="37364112"
X-IronPort-AV: E=Sophos;i="6.13,210,1732608000"; 
   d="scan'208";a="37364112"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 15:07:41 -0800
X-CSE-ConnectionGUID: 4mJVAkaHRpS6ab4OvDjaGg==
X-CSE-MsgGUID: VniDnga6Rw6+RYykEG2rTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,210,1732608000"; 
   d="scan'208";a="136474342"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 15:07:41 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <intel-xe@lists.freedesktop.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH v13 0/7] drm/xe/pmu: PMU interface for Xe
Date: Thu, 16 Jan 2025 15:07:11 -0800
Message-ID: <20250116230718.82460-1-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previous versions: https://patchwork.freedesktop.org/series/139121/

For perf/core: first patch adds a new macro in include/linux/perf_event.h.
If it's ok, I'd like to merge it through the drm branch so we can add the
pmu implementation to the xe driver. I'm also Cc'ing you on the other
patches to show its usage.

For "drm/xe/pmu: Enable PMU interface", previously from several authors,
I squashed several changes I suggested in the past to clean it up and
reduce boilerplate code that resulted from copy-paste from i915. More
detailed changes can be found at
https://gitlab.freedesktop.org/demarchi/xe/-/tags/tip-xe-pmu-v13

Compared to v12 this only has 1 event as Vinay said he will rebase the
frequency event on top. I tested this on Lunar Lake with and without
workload running and the c6 residency seems reasonable.

Lucas De Marchi (4):
  perf/core: Add PMU_EVENT_ATTR_ID_STRING
  drm/xe/pmu: Assert max gt
  drm/xe/pmu: Extract xe_pmu_event_update()
  drm/xe/pmu: Add attribute skeleton

Vinay Belgaumkar (3):
  drm/xe/pmu: Enable PMU interface
  drm/xe/pmu: Hook up gt suspend notification
  drm/xe/pmu: Add GT C6 events

 drivers/gpu/drm/xe/Makefile          |   2 +
 drivers/gpu/drm/xe/xe_device.c       |   3 +
 drivers/gpu/drm/xe/xe_device_types.h |   4 +
 drivers/gpu/drm/xe/xe_gt.c           |   3 +
 drivers/gpu/drm/xe/xe_pmu.c          | 408 +++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_pmu.h          |  22 ++
 drivers/gpu/drm/xe/xe_pmu_types.h    |  51 ++++
 include/linux/perf_event.h           |   7 +-
 8 files changed, 498 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/xe/xe_pmu.c
 create mode 100644 drivers/gpu/drm/xe/xe_pmu.h
 create mode 100644 drivers/gpu/drm/xe/xe_pmu_types.h

-- 
2.48.0

