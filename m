Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76782208CA;
	Mon, 22 Jul 2024 21:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721682423; cv=none; b=Y/vwEsWI28SewuNjWkTwU7SJVWiPUYaX29P0Y8F6s+7GIK5AKA7Zt+Z0aDMiyKRytf462pB/QzBIBcD7gTHBdRN2hZf6Axr9xu9S3JYkdgHTB6scP47Q5KiSpM6uGvLv2ndw7pe9+Ik9Dx8y+BgivKXrJyOOSIu/GlN6rfWp4zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721682423; c=relaxed/simple;
	bh=cLNPe9dx4bBLrxya/4PwK4euVFfE/6NBva4Wj7GDAqc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bowv+VCVbCwwkjjadtuwjcm6La33QVozylGJ/zuNmpFIml8JoITmoO3Oy6rXS8eox7akW/N5Vk0J2nHa1Rafmz7oleUHqbxO9QcInVABR7alhyr8EAbSg2WyQpkvOJ63YHFJxkYwp7CFINfWREjoQFt0s9Js2AU3j7K5D5c2I9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hVl6w3CR; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hVl6w3CR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721682421; x=1753218421;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cLNPe9dx4bBLrxya/4PwK4euVFfE/6NBva4Wj7GDAqc=;
  b=hVl6w3CRhSeb3w/klci3UKv2UFZ8glPTdpROGvDfUu4f/yURXARNuVXv
   lCjfoWnGGg58oYYOE+JBn1nwarg9BJa26fnel1t9j7ntwc4KFoYHS5C+h
   +xIbYbNG83jK4aSegUcjAljoBgVqvJil55/0T60SqOxQ5v8wJcVX/Q0Jw
   1fxfD/Ev9B9fx/OBKW3WiDQy2pbZhMmcdJBVWHfp3y39DBIUlc47XoSOV
   oX+qzeSgtE2YxJ8tskRnUCcTm/B3pIPhcXJ839zBXsHd9LMR0SK6G90VF
   N1HBOyKEAdrwCC1n0SYZgmATdX/tFFJaxpd46RVYHtNRiIPVSgdcganKZ
   g==;
X-CSE-ConnectionGUID: ++nwJ62ySNyazcmW8PFF/Q==
X-CSE-MsgGUID: BTOu+5X3R5G4drH/j9QCug==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="30428289"
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; 
   d="scan'208";a="30428289"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 14:07:00 -0700
X-CSE-ConnectionGUID: ZHmecsDgS3euI2nR5IUSvg==
X-CSE-MsgGUID: OAAxfdpqQkmvkBkUg97pwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; 
   d="scan'208";a="51653263"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 14:06:59 -0700
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: intel-gfx@lists.freedesktop.org,
	linux-perf-users@vger.kernel.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	dri-devel@lists.freedesktop.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 0/7] Fix i915 pmu on bind/unbind
Date: Mon, 22 Jul 2024 14:06:41 -0700
Message-ID: <20240722210648.80892-1-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is intended to fix the pmu integration in i915 when the device
unbinds. I don't have the hardware to test, but I belive a similar issue
occurs with any driver using perf_pmu_unregister() if they can unbind
from the device - in drm subsystem, that would be the amd driver.

Previous attempts I could find:
1) https://lore.kernel.org/lkml/20240115170120.662220-1-tvrtko.ursulin@linux.intel.com/
2) https://lore.kernel.org/all/20240213180302.47266-1-umesh.nerlige.ramappa@intel.com/

I think (2) is a no-go as it tries to do everything from the i915 side
by force-closing the fd.

I believe this series is simpler* than (1), but that could could also be
a good alternative if we want to go with that approach.

First patch is to perf. The rest is to i915 that builds on that and
moves the unregister bit by bit to be done later, after the last
reference to i915 is dropped.  Peter/Ingo, could I get your opinion on
this or if (1) would be a good alternative? Thanks.

* simpler, but see downside mentioned in patch 6

Lucas De Marchi (7):
  perf/core: Add pmu get/put
  drm/i915/pmu: Fix crash due to use-after-free
  drm/i915/pmu: Use event_to_pmu()
  drm/i915/pmu: Drop is_igp()
  drm/i915/pmu: Let resource survive unbind
  drm/i915/pmu: Lazy unregister
  drm/i915/pmu: Do not set event_init to NULL

 drivers/gpu/drm/i915/i915_pmu.c | 103 ++++++++++++++++----------------
 include/linux/perf_event.h      |   3 +
 kernel/events/core.c            |  32 ++++++++--
 3 files changed, 81 insertions(+), 57 deletions(-)

-- 
2.43.0

