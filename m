Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6933F1A9FAB;
	Fri,  3 Apr 2026 17:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775237393; cv=none; b=EF3diUc/UZXoREihlvSxUNvPYIOj5Alh5eEiNmufqYvAf0QDR9KLsljuxlY9DKiY+cd1LWBtqZ7bpGGyQkno6dtqFrjO5iIJY67JdS9vSw31i/JI4wnuagR3pNtXbiAwvsSgCjO8qYGJ0Mn+us+sDV8XyxLNQdSScdSnsBf1Qa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775237393; c=relaxed/simple;
	bh=bptTC34Orrt8y4UNTuh3XaUCQrFtvCfv0mpea/iiyKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EWjBb/ae4pgAYY4WlsLzf1hTDaXR6iPHMYXmu/56jPgYvilJ9rMihcN+ZEE3Z/uD0WzRg/2e7V+Um/u4qyDuESlNtN4jDaOnjux3ltoqDMyVUbOF2Nxpmd2TscQno7X/p5Y1pR1Z9V72T7178b46MLl2CvxQIlCY5ekmerkiDhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ebhFCwOl; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ebhFCwOl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775237393; x=1806773393;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bptTC34Orrt8y4UNTuh3XaUCQrFtvCfv0mpea/iiyKE=;
  b=ebhFCwOlDhc/B4hh4GgeF/zYjdzYyE3yEPrw7wM1bCY1ly3VKKwRo5xI
   hRegBq6e23Fasl6VqtQu1wcTXjQ5XuiK8Qwetstt4BubAgueIYi8bFKpW
   D7GN+EK2KcTR4umIQHKdVbuwM1A1c6dHY4bHak2yk1mcDmLr3RibFzuCl
   2Cgn0d5AxZuZrE3pWqWvM8h0kC2BrFftQqOw8LTfgSVMzn6y8aDjvGCbi
   99dUKHTR2BKqTmybdEVAAmWmZqRcolNBrAYL0UdaT59QPBibs7VD42ci5
   ILtIZ4EZObAhxM/mash8MKEA63gcXzAB19vu/NhrJCMQimvuArj3LjDKu
   w==;
X-CSE-ConnectionGUID: f/HwNhu8TUypHQqqgWqxPQ==
X-CSE-MsgGUID: 3zUI9CsQQVShzxjxGH7d0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="93693304"
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="93693304"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 10:29:52 -0700
X-CSE-ConnectionGUID: L3DgGVh3SNGGwZb4Zze1Zg==
X-CSE-MsgGUID: JSfv6PN/QByI4NG4T0zB5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="250525256"
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
	Markus Elfring <Markus.Elfring@web.de>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH V7 1/4] perf/x86/intel/uncore: Fix iounmap() leak on global_init failure
Date: Fri,  3 Apr 2026 10:21:43 -0700
Message-ID: <20260403172146.158172-2-zide.chen@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403172146.158172-1-zide.chen@intel.com>
References: <20260403172146.158172-1-zide.chen@intel.com>
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
index 12e259a988dd..427939be2fb4 100644
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

