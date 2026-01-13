Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EF8187346;
	Tue, 13 Jan 2026 00:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768264503; cv=none; b=tzOdqU3Ci712Y+I8tLPpmpiSLR1ZaUvHPt2dB7ezkkWNJHlOyybGa4LZhXBP1uGRDO0z/sXVvZL/cDPtXfL9PL2jyM65eopgQ4R27WaKI+z4IwD/f7MVFsX/0xkcM29ZtC14Wg0YD5y71YIgsX0jD+4paGZ1glu+6Z8pV0c/9mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768264503; c=relaxed/simple;
	bh=TdW3vME4AfAKwciZgrstHQlLZPppKr56IAtPk+Rtsjc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t2Rkdn6DA4TK4fwAl1XCDOVu89Hq/E0HUAGoEFYvBDLrfGWCaFudlkALfy6nnP3+vFQ/+My8hBD7k1MOFFyuFiyMQJbexG8DXx8QnLmIRFoJ4Y6RGP50vIGTqnjzdDSAY2ipESghNlW8QmuVk0q9ITWipqW6qUvpWnmZeztOAz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YFAnyOHV; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YFAnyOHV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768264502; x=1799800502;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TdW3vME4AfAKwciZgrstHQlLZPppKr56IAtPk+Rtsjc=;
  b=YFAnyOHVlnevmHTv5WOo1LUFQvNlI3UlZiISaSBKD3M2Sw7/cPAWIXRM
   nCJ58N3qjWIm8PdcnLXQki0caIDodnIZG5ogXcw9L+OWJKpFlrDfnPO0a
   N6mXAT/P7uqsjc2L7bF4uzyA1wmKxFnL7w4i35OV6Pgc+SoBbvlABZQjZ
   CnIP7TO2Yku5JUnfzbBcIeH0D7C/ELPth5549ykZmSneFux/HOT11oJ+s
   9Pb2J4GmBJkxcKOMi7aXYGVcAFczxQPzVLfErPqfho8VdpUUikQjOOGVS
   hUhmXda5ha7SG1nylbGBDrCglDMrfz+ZJAS6cGzxUsAmXVwY/sq6aJO6F
   g==;
X-CSE-ConnectionGUID: ZO2cf14ATxa/FC/kincNFg==
X-CSE-MsgGUID: vOWX4pxrQCaYE32K2yM7Nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="68754913"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="68754913"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 16:35:01 -0800
X-CSE-ConnectionGUID: 9sSruPWsTymFOfsfpI2OOQ==
X-CSE-MsgGUID: TiRdqHVsQQiwF6zoTo4row==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="241757126"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 16:35:01 -0800
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
	kernel test robot <lkp@intel.com>
Subject: [PATCH] perf/x86/intel/uncore: Fix iounmap() leak on global_init failure
Date: Mon, 12 Jan 2026 16:25:39 -0800
Message-ID: <20260113002539.408943-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If domain->global_init() fails in __parse_discovery_table(), the
mapped MMIO region is not released before returning, resulting in
an iounmap() leak.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: b575fc0e3357 ("perf/x86/intel/uncore: Add domain global init callback")
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/events/intel/uncore_discovery.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 0e414cecb6f2..f64661ad56b2 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -286,8 +286,10 @@ static int __parse_discovery_table(struct uncore_discovery_domain *domain,
 	if (!io_addr)
 		return -ENOMEM;
 
-	if (domain->global_init && domain->global_init(global.ctl))
+	if (domain->global_init && domain->global_init(global.ctl)) {
+		iounmap(io_addr);
 		return -ENODEV;
+	}
 
 	/* Parsing Unit Discovery State */
 	for (i = 0; i < global.max_units; i++) {
-- 
2.52.0

