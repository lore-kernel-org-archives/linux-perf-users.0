Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6CA42983F;
	Wed, 27 May 2026 15:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779895403; cv=none; b=DCJt8ZmJR9KWQBB5my+QRAtG3SPLlcP7YSAq8fvVeNVu6eZTXP1cgbkmWp4Co8DoRcpw6kNzr4ukHT4PV2B6fpi16RicayHjrY+v32N0XU55dgnWtItUZE+7hCYn2EeDFECz+phtUcjc1u8+n4X1uWQQG1MsVYm1FfrcUUL5lVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779895403; c=relaxed/simple;
	bh=dSHbHvZG3p7/g67zJ/H5Ga3AP9OeDKvrj5MYOEh4LXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BfeUqQlOZ558fX0uOkVmFF1cf2MF/ZLNn/l2Rr7K664M84g978NI7fMfYgJuyuMft8HAxMhJRyBEg/5SFT7MMKt1lkyI2+Ymrru1yzmQ0CTrm9S6HgkJ7oJp6CagLd1VoS8S0fNBiA/i+IsGMNypD+3fJiRtLoSpdbF4GQ6ym78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dhkJtl3+; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dhkJtl3+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779895401; x=1811431401;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dSHbHvZG3p7/g67zJ/H5Ga3AP9OeDKvrj5MYOEh4LXM=;
  b=dhkJtl3+On/7f8LXcotzKLj9tdJkCbNp48lOFbWdkpY9j/TiIOykaBda
   toN2zUpWkdvZafahmX7XpIauE0jCx6xWTLLv2B7QS1G0tEAQiphy5S2y1
   tVqrmkW4Yl3xXwcMNb7C+Q4nnw6RegIX5dNleyjmo7lmzjDlryR1rpKXj
   t+Wj3d3aJnhiw/vxvw2CTMLyY3hHGBIsNBsEIY2S/29U+qmsQUD/fvrFl
   sDpmyByffcocy9NNeOhcn4Bf+HpiJs1trmsIrEkBqwKb6T+Oewe5AcOqY
   mb5oOZY38JU3vRJ9tnlgVgrB75kDXBFCrmovlEuFwOZBg9xp3Mts4VwQ7
   w==;
X-CSE-ConnectionGUID: xfmHrJ2bShCcK8xd9oGT8A==
X-CSE-MsgGUID: pPxax1WzQLm83NfqtG/W+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="98149881"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="98149881"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 08:23:20 -0700
X-CSE-ConnectionGUID: QpQxKwcfSRihpaRMwff46w==
X-CSE-MsgGUID: VNfTQnNeTXWzUz1l/n6chw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="241232217"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 08:23:19 -0700
From: Zide Chen <zide.chen@intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Zide Chen <zide.chen@intel.com>
Subject: [PATCH V2 0/7] perf/x86/intel/uncore: Bug fixes and cleanups
Date: Wed, 27 May 2026 08:14:46 -0700
Message-ID: <20260527151446.130540-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series includes bug fixes and cleanups for the Intel uncore PMU
driver.

- Patch 1 fixes a theoretical bug in discovery unit lookup on multi-die
  systems.
- Patch 2 guards against an invalid box control address.
- Patch 3 fixes a PCI device refcount leak in UPI topology discovery.
- Patch 4 works around a hardware issue on Raptor Cove CPUs.
- Patches 5-7 implement a global MSR init callback for GNR/GRR/SRF/CWF
  uncore.

Changes in v2:
- Add patch 2 to guard against invalid box control address (Sashiko)
- Remove WARN_ON_ONCE() from patch 1
- Move cpus_read_{lock,unlock}() out of uncore_die_to_cpu() (Sashiko)

Zide Chen (7):
  perf/x86/intel/uncore: Fix discovery unit lookup for multi-die systems
  perf/x86/intel/uncore: Guard against invalid box control address
  perf/x86/intel/uncore: Fix PCI device refcount leak in UPI discovery
  perf/x86/intel/uncore: Defer ADL global PMON enable to enable_box()
  perf/x86/intel/uncore: Move die_to_cpu() to uncore.c
  perf/x86/intel/uncore: Fix uncore_die_to_cpu() for offline dies
  perf/x86/intel/uncore: Implement global init callback for GNR uncore

 arch/x86/events/intel/uncore.c           | 32 ++++++++++++++++++-
 arch/x86/events/intel/uncore.h           |  3 +-
 arch/x86/events/intel/uncore_discovery.c | 40 +++++++++++++++++-------
 arch/x86/events/intel/uncore_snb.c       |  7 -----
 arch/x86/events/intel/uncore_snbep.c     | 36 +++++++--------------
 5 files changed, 74 insertions(+), 44 deletions(-)

-- 
2.54.0

