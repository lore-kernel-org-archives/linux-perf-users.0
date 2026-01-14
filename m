Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B558130CD99;
	Wed, 14 Jan 2026 19:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768419955; cv=none; b=fcgOWqc+Uf1bU65mKFB4iCAkk9/nhO8vHcWjCbL2nScVfWdF3F1inPFxQkJJya72i0nmjf/bQCE18ApS5dkInlJ4KorLXhO1CHFnqU876GbGbjJzOBfO6QND+Ll8hx7Uo7BvwbSZoTfDpF0XjtZjqwFopQ4vCiKLwDI97u4Z1RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768419955; c=relaxed/simple;
	bh=OiqTM85cAmjwGZPZp8nX20zN8JsJ+Dko06e83VQTGfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h7QqzSq+USsN6VdDo4xhNb8n15xfaCrVAndMIrjSkPz4VRLvDDOKP+DX8biHDjXWM3mEmBebExdyKOc03KP9+Wk2Y4hJguJH5GzSziZFlbfGrx/62ZRdPlM68qijTqm0/XtW3OWSlFXtyRn1fWSaE4DM8urgG0HYihxPo5XKC7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GuXUny4j; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GuXUny4j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768419954; x=1799955954;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OiqTM85cAmjwGZPZp8nX20zN8JsJ+Dko06e83VQTGfQ=;
  b=GuXUny4jpqS7f3bgMC/TLgkj3S/AkT62hYS+JjbY6uIjmJGgeBbYbZ/G
   RlDIhrpEMsuC/a2YsntGU35/sLTxp9gGr6cb9rmfMs0/KcTbgHr2NexxR
   tq8ULBRxdixkxCJvn0wjadHglIYfDWwtJKmLhkwZMOTppfxIw0jhwEpGV
   AmDrm1IMxlWlXAJ0ZdXxPK8l+llAqBYq0kLPM1AqqFc8WtpLcRI7Muk46
   zUhSAelJnmjY7y1H0CK039UT3M6Fe/aW8JqWiZ+RlZP7JJ95Xz6OXsGLq
   9guDzuVVD77DGBTBYbH6oMapdiPl6x4Ni2CqUlBJCd3v/Y1JPHSly6pkf
   w==;
X-CSE-ConnectionGUID: itDEobY6TtaUCxqMxWlmMA==
X-CSE-MsgGUID: YN9UxgNBRAasZ0h4bXanDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69812696"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="69812696"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 11:45:53 -0800
X-CSE-ConnectionGUID: VXcTa8loTjKI8dUHyOeAfA==
X-CSE-MsgGUID: ytJ6RwxvQbSD+1eyYRkPrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="204552363"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 11:45:52 -0800
From: Zide Chen <zide.chen@intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>,
	Markus Elfring <Markus.Elfring@web.de>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH V2] perf/x86/intel/uncore: Fix iounmap() leak on global_init failure
Date: Wed, 14 Jan 2026 11:38:25 -0800
Message-ID: <20260114193825.17973-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.52.0
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
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/events/intel/uncore_discovery.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 0e414cecb6f2..efd1fc99a908 100644
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
2.52.0

