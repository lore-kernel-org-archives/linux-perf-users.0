Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF17D3CF677;
	Fri, 13 Mar 2026 17:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773424240; cv=none; b=SlbGgyreq6q68821yXmiVNxF4zuCJR0Ak5YDRnCS1zMrkIKflEe/i1Yb4PPUMMpba/CogTdHEH3ZSN3FkasPrgeHkML7qFp9NzanFq9kqXpIhOzQi49BV98iggnB8nWdn9JpVFCiuvLzZfAYQTMJ7VuSK/AmYRVcwkj3YCkG9X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773424240; c=relaxed/simple;
	bh=1x/5si05bd7nTythJOUAy63GznRFw2h1x2WOgG8pzD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CayIvwpxVbRBam55OeqOc/GULCxoW6nx2oJiXimS+7O+zJtJcvRrlETXiUNJaXUv0iwdu2MBKnJT+sel0lOuLuJ/UFXBnLguG6YbD6sh5b8uplsxexU/ZWJM7+p4H5RG57VD4r/1gKZzUg1FyHXOYdzGdD4c+9hAD1liS8k7VWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=meWtOk5F; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="meWtOk5F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773424240; x=1804960240;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1x/5si05bd7nTythJOUAy63GznRFw2h1x2WOgG8pzD8=;
  b=meWtOk5FhcuF7boY7HLDBvR57MgxJjM/NinjAIuvHnW2hgCGz+GZ4RW0
   Xb1BAEI7oU/u6DgJgyzLCpXbGCwNzmKHK5YgHkkkY/pY+QdY+WuQdGHne
   9Wte6sypruF8Kp8w8x9p8+8A3e5jODTaO+lpjfBrYx4TSoRtYzmpCv15w
   H6bZ+X+IeM+2mgB7UEpsKbQ/LQtB5eZyhmiGMCimPXrekyye+QNb02Ju1
   ZObRgXj35Jlb4ztCwscglLOchs53dcciNzzHfcE47stoEnEPWU2f06jYs
   BD9J8INFREMVnzk8kXfVEVA83fkjqor1kxJgTR8xiMmighVPa1qwQxMOr
   Q==;
X-CSE-ConnectionGUID: Ji0AymwIS3yWOgxe9FpDCA==
X-CSE-MsgGUID: XnoC7DT6TTWkrOK7Lt8zxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="74508723"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="74508723"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 10:50:40 -0700
X-CSE-ConnectionGUID: c4FmFMMyQWe4J88d94fMgg==
X-CSE-MsgGUID: ySmtG2KDReqHzh5EmYxD7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="259128538"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 10:50:39 -0700
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
	Markus Elfring <Markus.Elfring@web.de>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH V4 1/4] perf/x86/intel/uncore: Fix iounmap() leak on global_init failure
Date: Fri, 13 Mar 2026 10:40:47 -0700
Message-ID: <20260313174050.171704-2-zide.chen@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313174050.171704-1-zide.chen@intel.com>
References: <20260313174050.171704-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kernel test robot reported:

Unverified Error/Warning (likely false positive, kindly check if
interested):
    arch/x86/events/intel/uncore_discovery.c:293:2-8:
    ERROR: missing iounmap; ioremap on line 288 and execution via
    conditional on line 292

If domain->global_init() fails in __parse_discovery_table(), the
ioremap'ed MMIO region is not released before returning, resulting
in an MMIO mapping leak.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: b575fc0e3357 ("perf/x86/intel/uncore: Add domain global init callback")
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
V2:
- As suggested by Markus, add an `out` label and use goto-based error
  handling to reduce duplicated iounmap() code.
- Add the original warning from the kernel test robot to the commit message.
- Trivial rewording of the commit message.

V4:
- Add Reviewed-by tag.
---
 arch/x86/events/intel/uncore_discovery.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 1b1a6b221048..6a4e892cd525 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -264,6 +264,7 @@ static int __parse_discovery_table(struct uncore_discovery_domain *domain,
 	struct uncore_unit_discovery unit;
 	void __iomem *io_addr;
 	unsigned long size;
+	int ret = 0;
 	int i;
 
 	size = UNCORE_DISCOVERY_GLOBAL_MAP_SIZE;
@@ -273,21 +274,23 @@ static int __parse_discovery_table(struct uncore_discovery_domain *domain,
 
 	/* Read Global Discovery State */
 	memcpy_fromio(&global, io_addr, sizeof(struct uncore_global_discovery));
+	iounmap(io_addr);
+
 	if (uncore_discovery_invalid_unit(global)) {
 		pr_info("Invalid Global Discovery State: 0x%llx 0x%llx 0x%llx\n",
 			global.table1, global.ctl, global.table3);
-		iounmap(io_addr);
 		return -EINVAL;
 	}
-	iounmap(io_addr);
 
 	size = (1 + global.max_units) * global.stride * 8;
 	io_addr = ioremap(addr, size);
 	if (!io_addr)
 		return -ENOMEM;
 
-	if (domain->global_init && domain->global_init(global.ctl))
-		return -ENODEV;
+	if (domain->global_init && domain->global_init(global.ctl)) {
+		ret = -ENODEV;
+		goto out;
+	}
 
 	/* Parsing Unit Discovery State */
 	for (i = 0; i < global.max_units; i++) {
@@ -307,8 +310,10 @@ static int __parse_discovery_table(struct uncore_discovery_domain *domain,
 	}
 
 	*parsed = true;
+
+out:
 	iounmap(io_addr);
-	return 0;
+	return ret;
 }
 
 static int parse_discovery_table(struct uncore_discovery_domain *domain,
-- 
2.53.0

