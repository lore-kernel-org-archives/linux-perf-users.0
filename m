Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6293B0AFE;
	Tue, 24 Mar 2026 21:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774389497; cv=none; b=IChIlP0Wu5AH3/ndXfcd4qNCEWLS1N8aEfI2cZJZgWbNpDbh1Z9LdEEruodCHeIjxpvgb12QbYNINM0bdKst9B7rSkWxBep1Elkf5h0X3SCWgXz3SQ+I2Fypx2ROvN1XV4PmqUbBNcg7pFvXuF/bC6wUuWclQxacy+pjur4c7s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774389497; c=relaxed/simple;
	bh=p07OTvs2s/16DR9y67MP/bu4X9ZuzXNW/US1NhrGGh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XkjtD6sg8I9OsL/SXppb/pMUv8/fnlakSVJpT6B5TIYLcoM04sJr7jcl758r0qmTYiubVdxijQpqCiorkuOpDlJavOk5Ulbet6UJkqIEVpv06CXOYghEYKWYD9M+VgjEPwiA8lc61cOEdkGNVBBjJllFx9DtKnPZ6528MMrm5K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DnEq6NXe; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DnEq6NXe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774389495; x=1805925495;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p07OTvs2s/16DR9y67MP/bu4X9ZuzXNW/US1NhrGGh0=;
  b=DnEq6NXeAMcq17OB9aKVSG4O/amUTCYG43QlW/pKgmFroGMb/IBky1DU
   R0u64J4IdNWiQWbTC775Mi42US2Tmy94xyUJ/GwUeJZ06zzGDHk8mgZuA
   /MGockv4JE0lvTf2bOzyumawdWMxn5UA4u3NvRN/3Qlj+D+kU5+WL+9+m
   xmYSHB2gh/gfqfDmOTnE3c/iiMWvyY9Z97R+jlpgn+pos/7G99vhVASTq
   DYqEl0NiF6Wug198l8VYsDF+yY/C7TChRmC1AHlMTVVMG3U7CXeFEOG0E
   HGZ58wyfdq0wMS2PpU+f5QXskJkPajDNOw/08srLxhTj1qdq+6IQWrjR7
   Q==;
X-CSE-ConnectionGUID: IKULHZSiRQugGaSiUNYVrA==
X-CSE-MsgGUID: Ng+lKo14RfyhBQbLMdr/1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="100866094"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="100866094"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 14:58:14 -0700
X-CSE-ConnectionGUID: tUuy9E43RSCapt/ju5OdaQ==
X-CSE-MsgGUID: rrEzvnS4SC21bxP0A9dVGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="224496718"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 14:58:14 -0700
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
Subject: [PATCH V5 1/4] perf/x86/intel/uncore: Fix iounmap() leak on global_init failure
Date: Tue, 24 Mar 2026 14:49:29 -0700
Message-ID: <20260324214932.10068-2-zide.chen@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324214932.10068-1-zide.chen@intel.com>
References: <20260324214932.10068-1-zide.chen@intel.com>
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

V3:
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

