Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9B31B423F
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2025 06:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737527056; cv=none; b=Ceyq4o9aOrMpPxtcL/9/moBLE93Imn5E+Rdjbw79iRxnr7ATz6dCXvIItA26ut4ZHsr58B5uoa4/3O5D2uoLYEmTAmzMHGQvnQLNdt/NNXJFlq4a6NSv4MF/ScxcMPeP6SM/kXM7mAc0LM2GmtTGEyeSOaGCa+bfvCrCsSRfmTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737527056; c=relaxed/simple;
	bh=qIzMmMXdqNF/U4P/jcOg61H5rcc17JRCY5BvaYXB8dg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Zvz+uC83afDwEpN/pzBQEz7zOjCn4gwdK9sFfWAtErD8jYKjyL9yVVEC/JZd21jj/h09jRbGq3NxGN5xYs7y4HGVvT2ts6orUSZwErhH9NHVnXzEyhJJTiyCsFi0+RNFOfZNVQiCZ0XTcwkiLRkX6ELWBf7aMJyJAgrcRJsKQ6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d/iC/8/i; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d/iC/8/i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737527055; x=1769063055;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qIzMmMXdqNF/U4P/jcOg61H5rcc17JRCY5BvaYXB8dg=;
  b=d/iC/8/iRYurT87tKNV20NCm3h09wsdN1p75XL6mU2gCjTMkNUNVlUdq
   uCo6zM2MTxrjALyRz+yllQT0Y+6XBVB6WEgqZAJwd9WaF2FMFd17oJekK
   vmDNqPBhzBPiI/9Fnr6nMpdznminzlDA/0/51EwzoYbxrxYPT7xmwVri1
   zu13DtzaTRH8RNVm1ez0214zcgF2O+zQclDbZC/I/IkD+0nfs45A4nzvp
   hahdojep+xHfpoU5P04kYYL1Y+LefI5iV4rLe0qXW9axa/v2FWrEldigR
   TtogcCGCCRF5a49Ta/5POudWkaAXCN9/K1iwsmaCjGK/xR9T2kUHJDZSf
   g==;
X-CSE-ConnectionGUID: eG26o0/ETyOEhiYl5QKQKQ==
X-CSE-MsgGUID: TB0tQVMiSdWJ2Cu7FCGFGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="41643289"
X-IronPort-AV: E=Sophos;i="6.13,224,1732608000"; 
   d="scan'208";a="41643289"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 22:24:12 -0800
X-CSE-ConnectionGUID: 5yjvBXH5RGS/VyqGr8NX6w==
X-CSE-MsgGUID: PbfQ74WkSOKmcetZIe0vGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="112015649"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 22:24:11 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <intel-xe@lists.freedesktop.org>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Vinay Belgaumkar <vinay.belgaumkar@intel.com>,
	Riana Tauro <riana.tauro@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH v14 0/7] drm/xe/pmu: PMU interface for Xe
Date: Tue, 21 Jan 2025 22:23:34 -0800
Message-ID: <20250122062341.1100173-1-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Previous versions: https://patchwork.freedesktop.org/series/139121/

For perf/core: first patch adds a new macro in include/linux/perf_event.h.
If it's ok, I'd like to merge it through the drm branch so we can add the
pmu implementation to the xe driver. I'm also Cc'ing linux-perf-users@vger.kernel.org
on the other patches to show its usage.

For "drm/xe/pmu: Enable PMU interface", previously from several authors,
I squashed several changes I suggested in the past to clean it up and
reduce boilerplate code that resulted from copy-paste from i915. More
detailed changes can be found at
https://gitlab.freedesktop.org/demarchi/xe/-/tags/tip-xe-pmu-v13

Compared to v12 this only has 1 event as Vinay said he will rebase the
frequency event on top. I tested this on Lunar Lake and ADL with and
without workload running and the gt-c6 residency seems reasonable.

v14 simplifies the gt-c6 event: no more estimate based on suspend time
since we can't take the spinlock. A simpler version is to get runtime pm
when initializing the event and putting it back when it's done.  In
future we can come back with fancier things that don´t block the runtime
pm.

Lucas De Marchi (5):
  perf/core: Add PMU_EVENT_ATTR_ID_STRING
  drm/xe/pmu: Assert max gt
  drm/xe/pmu: Extract xe_pmu_event_update()
  drm/xe/pmu: Add attribute skeleton
  drm/xe/pmu: Get/put runtime pm on event init

Vinay Belgaumkar (2):
  drm/xe/pmu: Enable PMU interface
  drm/xe/pmu: Add GT C6 events

 drivers/gpu/drm/xe/Makefile          |   2 +
 drivers/gpu/drm/xe/xe_device.c       |   3 +
 drivers/gpu/drm/xe/xe_device_types.h |   4 +
 drivers/gpu/drm/xe/xe_pmu.c          | 360 +++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_pmu.h          |  20 ++
 drivers/gpu/drm/xe/xe_pmu_types.h    |  47 ++++
 include/linux/perf_event.h           |   7 +-
 7 files changed, 441 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/xe/xe_pmu.c
 create mode 100644 drivers/gpu/drm/xe/xe_pmu.h
 create mode 100644 drivers/gpu/drm/xe/xe_pmu_types.h

-- 
2.48.0

