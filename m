Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7205B67A;
	Wed, 31 Dec 2025 22:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767221381; cv=none; b=P6SNrYGtIsmX5Rd6fr1VwRS7IqkGqIqn6W9I0y3zwyT5AAGlos+B9KaJ9y36LM9xcc27zT+FUfhMSpftlR9T5fUv7lEFByarXmiiCjboALt2oaJZJtut6ikieDgo/woHPvm6h5CAMQUnfwyNJq0kqFe5ib9bdidVQNWLtWQyn4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767221381; c=relaxed/simple;
	bh=WnQYwr01uFtJp/lb65gGjbx7ZL5KYU5JS2Sf4YS5p48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EaakhtbaOVN6BJ85pUXOeWSxVKXD87i6kBWaAlPLCg49FL5gvgjgb3KM+JosvBp8Q7SQs3gDocjr01fjlE9RhsDTCRh38RqJ+XvTEr2/a29X2yIrtcmAxLoI+l7d6Vxe7P3ynuZ88mwcfbVGZueV20B86sOs+tnyoNhSuQQCsxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lBj7yPgq; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lBj7yPgq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767221380; x=1798757380;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WnQYwr01uFtJp/lb65gGjbx7ZL5KYU5JS2Sf4YS5p48=;
  b=lBj7yPgqpmzm5Hj7zNwfEt5YvzGbBeMMWih7VOQwfDaY1k251HK6XtJZ
   zOXoi7KphURp9rNdoZ9sedRxyBWF8gxAzd9R1ObYkbgRiNDy/+a4liXmw
   HeWu2Gws1a6X8n/Wy86nBv5vRr3laX7oRY2eZCBU5KYmFm4U+12A7f0wd
   sErAz1AvEiwqNanDWdcFt7Z6r9FwFw5J7IJsIvbfRRu/nkcj5yVhDhxKy
   RmThJtg1qvqAzZCu8+GUzUKKtXcyvcua7G+IVD12i4ydp/iy4BncZO19c
   lBACXwVC5hG444DVGBZ86YZ/YOfZ8UooZ4vxxso2deqmfYFsnEG0VWSoj
   A==;
X-CSE-ConnectionGUID: geWHEbrXTkS7VzygFhGxrQ==
X-CSE-MsgGUID: yS7GGGJIR8e+fVPcnzBpow==
X-IronPort-AV: E=McAfee;i="6800,10657,11658"; a="68816598"
X-IronPort-AV: E=Sophos;i="6.21,193,1763452800"; 
   d="scan'208";a="68816598"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2025 14:49:39 -0800
X-CSE-ConnectionGUID: SHyImkrrTae5l7R46jncFg==
X-CSE-MsgGUID: gY/b9wZ2SCGagsHVdQIoEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,193,1763452800"; 
   d="scan'208";a="232611001"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2025 14:49:39 -0800
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
	Zide Chen <zide.chen@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>
Subject: [PATCH V2 00/13] Add DMR/NVL and missing PTL uncore support
Date: Wed, 31 Dec 2025 14:42:17 -0800
Message-ID: <20251231224233.113839-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Similar to Sapphire Rapids, Diamond Rapids (DMR) relies on discovery
tables for uncore enumeration. Key differences and additions include:

- DMR may have two Integrated I/O and Memory Hub (IMH) dies, separate
  from the compute tile (CBB) dies.  Each CBB and each IMH die has its
  own discovery domain.

- Unlike prior CPUs that retrieve the global discovery table portal
  exclusively via PCI or MSR, DMR uses PCI for IMH PMON discovery and
  MSR for CBB PMON discovery.

- DMR introduces several new PMON types: SCA, HAMVF, D2D_ULA, UBR,
  PCIE4, CRS, CPC, ITC, OTC, CMS, and PCIE6.

- IIO free-running counters in DMR are MMIO-based, unlike SPR.

The uncore driver currently does not clear the freeze_all bit in the
Global Control Register.  On platforms where it is set at power-on,
some units may not be enabled if they lack a per-unit enable bit.

Patch series overview:
- Patch 1–3, 7, 9: Cleanup or preparatory patches
- Patch 4–6, 8, 10–11: DMR uncore support
- Patch 12: Add missing PTL PMON units
- Patch 13: NVL uncore support

V2:
- Introduce struct uncore_discovery_domain[] to allow multiple
  discovery base, and each could be either an MSR or a PCI device.
- Add global_init() callback.
- Add missing format_attr_umask in dmr_imc_uncore_formats_attr[].
- Address Dapeng’s comments.
- Add new patches for PTL and NVL uncore support.

V1: https://lore.kernel.org/linux-perf-users/20251212210007.13986-1-zide.chen@intel.com/

Zide Chen (13):
  perf/x86/intel/uncore: Move uncore discovery init struct to header
  perf/x86/intel/uncore: Support per-platform discovery base devices
  perf/x86/intel/uncore: Remove has_generic_discovery_table()
  perf/x86/intel/uncore: Add IMH PMON support for Diamond Rapids
  perf/x86/intel/uncore: Add CBB PMON support for Diamond Rapids
  perf/x86/intel/uncore: Add domain global init callback
  perf/x86/intel/uncore: Add freerunning event descriptor helper macro
  perf/x86/intel/uncore: Support IIO free-running counters on DMR
  perf/x86/intel/uncore: Support uncore constraint ranges
  perf/x86/intel/uncore: Update DMR uncore constraints preliminarily
  perf pmu: Relax uncore wildcard matching to allow numeric suffix
  perf/x86/intel/uncore: Add missing PMON units for Panther Lake
  perf/x86/intel/uncore: Add Nova Lake support

 arch/x86/events/intel/uncore.c           | 142 +++--
 arch/x86/events/intel/uncore.h           |  26 +
 arch/x86/events/intel/uncore_discovery.c |  78 ++-
 arch/x86/events/intel/uncore_discovery.h |   8 +-
 arch/x86/events/intel/uncore_snb.c       |  85 +++
 arch/x86/events/intel/uncore_snbep.c     | 690 ++++++++++++++++-------
 tools/perf/util/pmu.c                    |  14 +-
 7 files changed, 735 insertions(+), 308 deletions(-)

-- 
2.52.0

