Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BD2D2FB;
	Mon, 11 Aug 2025 09:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754902889; cv=none; b=q7UgGrgZn0rwadYyjGhJ1Zh7OUYSi/+eRYOpZZMuIEbgXYd4BCYr3CeOKbyWeGYmFbKqeKREXTcPOaIhg484e9OIQobOM4BwhJiXjILQe5tb4z8w9Ib/9cUHEs2rmZo3rT9pnZKnyvIjVNzwMnmZwarCX6dWq3MDCGmhvZbLRWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754902889; c=relaxed/simple;
	bh=aWRd2C8SzdRTfWZmOcRUh9tD3eV1ngnpS1vqbHZIKEk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qG7YK8lRtOP2DlK+jh9p7kwW2NW+8msoQtKmuuq9+goV2zEFoCHuJjb7mobu6FQIKFs5Y5Kj8Bi8hK3f5GMWSKSvaEvq983xY4DI7x58OqxUq1GKbozty5HIte+LDABgKawur6W7YoyKpSGescHPLZDZzQ/mDswQpICkKZPgh9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RyUxMQ+M; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RyUxMQ+M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754902888; x=1786438888;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aWRd2C8SzdRTfWZmOcRUh9tD3eV1ngnpS1vqbHZIKEk=;
  b=RyUxMQ+Mz3Hq45REqsZ/x/GiRU3AKz9IM/tSoGg/q+q/RcK3Qwukg1rE
   W46hyU4ciGbvV2k+Dun6O48WRszjPFPcB5JnzfftfPk8p0ogLxvpzXXId
   Loi6hmWif/HJLG8dJPAyFgogjQk1QrTwiKRaFfE+57fh6Krde4csm0OMO
   ykQAvH6N9CwwbKvDX4R8iVVN6Op1LapMJ8KPUGq8eVnpfoHkvzqD1AfG3
   x1+70/2aLswKoEPRt6H++fIwkT+pAYMJzUW3yYkMXn8ZtIXH+NVy90ZdZ
   fw109Jq3pTK/JxOawAoEPhPGy/EqjuRlJpjxIlIECoYmBsEYAc80EATli
   w==;
X-CSE-ConnectionGUID: 7yapY3zgTJSAkrxx/qJXOQ==
X-CSE-MsgGUID: XjOQ9Bp6Q6WTjHREXKBQBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="57107296"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="57107296"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 02:01:28 -0700
X-CSE-ConnectionGUID: kyfpxhLhSaOzOJTW7nS1Jw==
X-CSE-MsgGUID: dPoHHEtvSjyNiVhmR1lOTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="166219811"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa009.fm.intel.com with ESMTP; 11 Aug 2025 02:01:25 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v2 0/6] x86 perf bug fixes and optimization
Date: Mon, 11 Aug 2025 17:00:28 +0800
Message-Id: <20250811090034.51249-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch-set aggregates previously sent individual perf/x86 patches to
make the review more convenient. The patches 1-3/6 fix 3 x86 perf issues
and the last 3 patches enhance/optimize x86 perf code.

Changes:
  v1 -> v2:
  * Rebase to 6.17-rc1.
  * No code changes.

Tests:
  * Run perf stats/record commands on Intel Sapphire Rapids platform, no
    issue is found.

History:
  V1:
  * Patch 1/6: https://lore.kernel.org/all/20250606111606.84350-1-dapeng1.mi@linux.intel.com/
  * Patch 2/6: https://lore.kernel.org/all/20250529080236.2552247-1-dapeng1.mi@linux.intel.com/
  * Patch 3/6: https://lore.kernel.org/all/20250718062602.21444-1-dapeng1.mi@linux.intel.com/
  * Patches 4-6/6: https://lore.kernel.org/all/20250717090302.11316-1-dapeng1.mi@linux.intel.com/

Dapeng Mi (6):
  perf/x86/intel: Use early_initcall() to hook bts_init()
  perf/x86/intel: Fix IA32_PMC_x_CFG_B MSRs access error
  perf/x86: Check if cpuc->events[*] pointer exists before accessing it
  perf/x86: Add PERF_CAP_PEBS_TIMING_INFO flag
  perf/x86/intel: Change macro GLOBAL_CTRL_EN_PERF_METRICS to
    BIT_ULL(48)
  perf/x86/intel: Add ICL_FIXED_0_ADAPTIVE bit into
    INTEL_FIXED_BITS_MASK

 arch/x86/events/core.c                 |  3 +++
 arch/x86/events/intel/bts.c            |  2 +-
 arch/x86/events/intel/core.c           | 27 +++++++++++++-------------
 arch/x86/events/intel/ds.c             | 13 ++++++-------
 arch/x86/include/asm/msr-index.h       | 14 +++++++------
 arch/x86/include/asm/perf_event.h      |  8 ++++++--
 arch/x86/kvm/pmu.h                     |  2 +-
 tools/arch/x86/include/asm/msr-index.h | 14 +++++++------
 8 files changed, 47 insertions(+), 36 deletions(-)


base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.34.1

