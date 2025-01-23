Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7175CDF1
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Jan 2025 04:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737605991; cv=none; b=pRKzxKfZQM0x5u9HHQKF4k6dDYp6UjT0cXkAwspHpzUSRA01qIWNua4YhU0gZehlXJBKKyEVL62bCTfM43TSfIVNc0zLUAXf0zFissxq+4zWP68iN8ND5lwGW9c8ERZzVyGQyn3Tf7q9rMIAEAoHaYg4xZkkKhgvRlDzPOEPy60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737605991; c=relaxed/simple;
	bh=wpfQQiDwPkBcGzVllHiTFJefl9ehIU88uIp2X8dLiG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nlxRvUSfIT5A3ySKoXBma07vTfapB+tCEbV5N+fVoPEywAM1ismdJCjde96mJuuY5HmEqTnFYHjblvsFwZGz1e6zkjrFWzmMENuFMjDXv6kVa50KKmGPgu1ZdskUeUFS+MiJ/h2JG1J+kOBvHIEAztCXRjCz+glVqzWTg9s4Dcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IX9k/5Uo; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IX9k/5Uo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737605991; x=1769141991;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wpfQQiDwPkBcGzVllHiTFJefl9ehIU88uIp2X8dLiG8=;
  b=IX9k/5Uog3CXUe/+OvIGcgE/a4s7NKR5yJaRKInWJt2l0c00em0EYXGc
   AGFbMpkWSJd32/4amps9EA8A3vNTjznCVJhgfYXIdZoxlOC4uIluRreCu
   NFhrb6jXXdFzxFYwIcydeZ9HvJMNsMrO49xTvS6OfTZ+r2IweQkZPKfPR
   2ptXL/XfnHvBlk4K0sd5cOY0Ar0rionn8m/4VNT5NAHAx5boU2eqoq21K
   VBZ2TlGeck2+SfZFPVLe5AEBCE4u5FcJopZ9/IlXNz1vw3hznFjVzPw5s
   sSdZHmYOVdrTdUHWY1k+1xRBTRDYHLVvGcv/4Wn91BJBwMxcIud+9FohS
   w==;
X-CSE-ConnectionGUID: XWt8a6UbQ/SAsAjPKH75oQ==
X-CSE-MsgGUID: 3LbHefh0Tbm/JIbjhlHN2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="37971638"
X-IronPort-AV: E=Sophos;i="6.13,227,1732608000"; 
   d="scan'208";a="37971638"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 20:19:48 -0800
X-CSE-ConnectionGUID: UK1W15HGSQa66UztOFj5Qg==
X-CSE-MsgGUID: r4jxoB5KQ6uR+oHhAb5xRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="107202052"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 20:19:47 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <intel-xe@lists.freedesktop.org>
Cc: Vinay Belgaumkar <vinay.belgaumkar@intel.com>,
	Riana Tauro <riana.tauro@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH v15 0/6] drm/xe/pmu: PMU interface for Xe
Date: Wed, 22 Jan 2025 20:19:17 -0800
Message-ID: <20250123041923.1892837-1-lucas.demarchi@intel.com>
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

I tested this on Lunar Lake and ADL with and without workload running
and the gt-c6 residency seems reasonable.

v13: this only has 1 event as Vinay said he will rebase the
frequency event on top.

v14
  - simplify the gt-c6 event: no more estimate based on suspend time
since we can't take the spinlock. A simpler version is to get runtime pm
when initializing the event and putting it back when it's done.  In
future we can come back with fancier things that don´t block the runtime
pm.

v15:
  - clean up no longer needed include files
  - drop no longer needed struct members
  - drop patch adding PMU_EVENT_ATTR_ID_STRING: this can be done later
    on top if desired, converting more drivers. There's no pressure need
    to be different than the other drivers. Instead, do the attributes
    similarly to drivers/iommu/intel/perfmon.c, but still keep a single
    macro to define both event, scale and event group

Lucas De Marchi (4):
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
 drivers/gpu/drm/xe/xe_pmu.c          | 361 +++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_pmu.h          |  18 ++
 drivers/gpu/drm/xe/xe_pmu_types.h    |  39 +++
 6 files changed, 427 insertions(+)
 create mode 100644 drivers/gpu/drm/xe/xe_pmu.c
 create mode 100644 drivers/gpu/drm/xe/xe_pmu.h
 create mode 100644 drivers/gpu/drm/xe/xe_pmu_types.h

-- 
2.48.0

