Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B7114884C;
	Fri,  3 Apr 2026 17:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775237392; cv=none; b=hVbLu/17yrSa4ePq4k1Rv3ztBNWs0h890NEG5hQVTHIAD5LLhjAManYDCCza7w7UVhNeiL6CNKIYE3Tp5o+FkTr+NLwYKRGtm8I3VYzbrgzl1mDo7YNslMMU3Q4jQ8igt/K+M+8dyZmcG/VWz+DpYr3FrhTTAHoaFAr4UBSMNZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775237392; c=relaxed/simple;
	bh=xeJ2KKONdP/QnMMb/ANbjUYcA0F3u+MW+yp6IbNe6xg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ucpf0kU9a5jMK1kL4M62SJA3UHYFo9L2Hw7MwpWyj+ojoOkpe3ICupwTQZ3KcehqwEdqwzPS5d4m3V2dw8OgdNFyFqqFDNF7RGe4tgz/qhvCVeCpwP/9E60zBIzRGTPxl9vz/JAeWDawzzS8KA3ZYqT/AI6GMI56xZE2wxhMEHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CI/YfubD; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CI/YfubD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775237392; x=1806773392;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xeJ2KKONdP/QnMMb/ANbjUYcA0F3u+MW+yp6IbNe6xg=;
  b=CI/YfubDM8t4L6FrlnuL2tqWsa6y4Q95dP4m+1ISi4isxYbe/WPEpuH3
   ceEnZ1+uLMFVI3yc1abkmwkbkhxUUgHOZbfQTucgu/Rs032pMY6yVqBSW
   lojSgaWkxKZIrr9pxTB9QzQ8NqhrqMArpAqive0z6RtMEDMmjXF1y/1eK
   Q91qgsjpmWCODjij+1x/ZMEPa3n1z/On5SNqTFqxc/zfNVizITkik0JoH
   bLu1S3lC+I/CrLbzk8JD0lxC68eoRT6dOikmgTreR3lZ9WGtgP4A/+ig2
   rJw33YOD4MVKh54a2FCQ6/tvOu2jjiTnZ0KgZVt/Lab1X5uMkeKxUxXKL
   A==;
X-CSE-ConnectionGUID: JNvPS0zKRdu8djwmm4yLCw==
X-CSE-MsgGUID: UeczYgOfRG6lIiDwW/3brA==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="93693296"
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="93693296"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 10:29:51 -0700
X-CSE-ConnectionGUID: 1N2K3nhDTbaNcivUs19obQ==
X-CSE-MsgGUID: c3pyEwmIRIKaVmHOUo7K7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="250525251"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 10:29:50 -0700
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
	Steve Wahl <steve.wahl@hpe.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH V7 0/7] Miscellaneous Intel uncore patches
Date: Fri,  3 Apr 2026 10:21:42 -0700
Message-ID: <20260403172146.158172-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I grouped these patches together for the convenience of the maintainers
and bumped the whole series to V7.

Changes since v6:
- Drop patch v6 4/5: perf/x86/intel/uncore: Fix PMON enumeration with
  NUMA disabled

Changes since v5:
- Split patch v5 3/4 into two patches for clearer scope.
- Patch 2/5: Add changelog to clarify that it doesn't support die ID gaps.
- Patch 3/5: Change title and changelog to reflect the reduced scope.
- Patch 4/5: New patch. Remove redundant snbep_pci2phy_map_init() calls.

Changes since v4:
- Remove unused die_id variable from patch 3.

V6:
https://lore.kernel.org/lkml/20260330212444.117325-1-zide.chen@intel.com/

Previous versions:
https://lore.kernel.org/lkml/cda9ab9b-4581-409f-a9bb-0e8a67ad3530@web.de/T/
https://lore.kernel.org/lkml/20260116031113.45098-1-zide.chen@intel.com/
https://lore.kernel.org/lkml/20260206231203.11760-1-zide.chen@intel.com/

Zide Chen (4):
  perf/x86/intel/uncore: Fix iounmap() leak on global_init failure
  perf/x86/intel/uncore: Skip discovery table for offline dies
  perf/x86/intel/uncore: Do not treat -1 die_id as error during UBOX
    scan
  perf/x86/intel/uncore: Remove extra double quote mark

 arch/x86/events/intel/uncore_discovery.c | 17 ++++---
 arch/x86/events/intel/uncore_snbep.c     | 57 +++++++++++-------------
 2 files changed, 37 insertions(+), 37 deletions(-)

-- 
2.53.0

