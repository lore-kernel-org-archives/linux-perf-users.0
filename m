Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8240258EE9;
	Fri, 16 Jan 2026 03:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768533518; cv=none; b=XwGrJEWWxHqA8vQtlmR2Fm+q1g1SN4seSCWqc8NyZwRtdShfI9zqwJULb1ftoxgW2RYq24kVnfxrnfcwBxjyN0GxW3eBcoKsA0EKnbMGOHtThKJzt1TI0Y2fX4v3qpk2dr2gJGeAw55VQ3duFH4XzDKd3lS1q5tM+aR3VfmW7Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768533518; c=relaxed/simple;
	bh=FcKzKfvNcf1RroF1nPb91tQNCPl+JbISX3J5tK/bku8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LqcZJLAP997J44xy7DAh8Ppjq7HXsYV4aY6mGmEOa2K7MaEe6bH5qCEJuNptKRvcr7rDOp/UaIguXLOX4mpQZTpdoh12aavzfWqWIrAxoO20e1K3r/L11HDqeLNJAQTdutYW2lNZeKAJu5VyhWHwd7/DRC3UPU6GiH3XFMuLFSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m/mpIJZ3; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m/mpIJZ3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768533516; x=1800069516;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FcKzKfvNcf1RroF1nPb91tQNCPl+JbISX3J5tK/bku8=;
  b=m/mpIJZ3te8P1WR+A9XRFmICgiitfh1xjURQVO+8V36m8+OeZor9yVlE
   iBKGk7wPemAWLQN02uPGo2leSUh4vlI04LViwfIBRfb5/6CJ2iR7Q4dbq
   PU0Ddfc8rweYshbtw+MA/AokhkWw5L9AaZFpXwQrQEPopGvehT6VJQF5R
   zgwCyTRQIXS8l3+g2Al4JjGdfCnwN0QsmGPMJU9UvpkxQoczvj1oH0+/1
   kRAy56Yj9aEIPiuKNDeqB/WBJYHdn4lOulwwKbFHR0LVFcjTfwnJfTY0p
   P8z+EJrP0KxtE4Ahzwg7XiHf8dgl4EoNWWD2ipx6zDr/O7cFOEbKlnmFe
   A==;
X-CSE-ConnectionGUID: X9XE9AfjQyGhlPebgOy54A==
X-CSE-MsgGUID: 4+qCMJ13S4a+3qdZU+iKJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="80154232"
X-IronPort-AV: E=Sophos;i="6.21,230,1763452800"; 
   d="scan'208";a="80154232"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 19:18:36 -0800
X-CSE-ConnectionGUID: TrCU2tP8SS2iaqH+gAe97Q==
X-CSE-MsgGUID: VqgIdyetSjCKUPkgiB3TCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,230,1763452800"; 
   d="scan'208";a="209614076"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 19:18:35 -0800
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
	Falcon Thomas <thomas.falcon@intel.com>,
	Steve Wahl <steve.wahl@hpe.com>
Subject: [PATCH V3 1/2] perf/x86/intel/uncore: Skip discovery table for offline dies
Date: Thu, 15 Jan 2026 19:11:12 -0800
Message-ID: <20260116031113.45098-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This warning can be triggered if NUMA is disabled and the system
boots with fewer CPUs than the number of CPUs in die 0.

WARNING: CPU: 9 PID: 7257 at uncore.c:1157 uncore_pci_pmu_register+0x136/0x160 [intel_uncore]

Currently, the discovery table continues to be parsed even if all CPUs
in the associated die are offline.  This can lead to an array overflow
at "pmu->boxes[die] = box" in uncore_pci_pmu_register(), which may
trigger the warning above or cause other issues.

Reported-by: Steve Wahl <steve.wahl@hpe.com>
Tested-by: Steve Wahl <steve.wahl@hpe.com>
Fixes: edae1f06c2cd ("perf/x86/intel/uncore: Parse uncore discovery tables")
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
V2:
- Add the Tested-by tag
- Rebase onto perf/core (base commit: a491c02c2770)

V3:
- Remove the overly cautious WARN_ON()

 arch/x86/events/intel/uncore_discovery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index b46575254dbe..0e414cecb6f2 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -366,7 +366,7 @@ static bool uncore_discovery_pci(struct uncore_discovery_domain *domain)
 				     (val & UNCORE_DISCOVERY_DVSEC2_BIR_MASK) * UNCORE_DISCOVERY_BIR_STEP;
 
 			die = get_device_die_id(dev);
-			if (die < 0)
+			if ((die < 0) || (die >= uncore_max_dies()))
 				continue;
 
 			parse_discovery_table(domain, dev, die, bar_offset, &parsed);
-- 
2.52.0

