Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3114063CB;
	Thu,  3 Oct 2024 00:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727915076; cv=none; b=M9UFQbNj8V5Zepaao8lju+Lu0aeDzsWu8zQEMhbNm+KVikI0QHYBZYG7maYwoFFz7Qh1HKEm/gUIEA2xontAhEV1UwtV8hZFXI3+g6p62xQ8ILmAQmPfH2C7WJ+LBmRyzewSAR2UEN1Z36bH81SP9+kXGfCQu+hQ+UqqYsKmF1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727915076; c=relaxed/simple;
	bh=xL4ljROcU0VbrL9Otp98O8uaxbzfyrWiYGf9p6HJ9/Y=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=nrG6pMzeI+lFi+p4evhMhaNzZkK30c3E4RmmugHFlwl80sxXV0erFKEcUdDc3cO1XPIxWzG5w97bFkZ0AsuD07tBis/453yATsVUd47VLwqfQJbCxGTyoUtp/z05YKwi53veUrPnQtZfbfnrJPG4RDRQ/f1gSR3LeZ3atVfTxWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=mqUzFXZx; arc=none smtp.client-ip=139.138.36.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="mqUzFXZx"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1727915074; x=1759451074;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xL4ljROcU0VbrL9Otp98O8uaxbzfyrWiYGf9p6HJ9/Y=;
  b=mqUzFXZxyT6pq2JuUh2ORDx8oQshCXcsMuEvIIPf2V2maoXKokXphMWJ
   ntNhBk1cG8vo5QbeR985LGygOMpbR7vUNVk/b5xT9vsBFjgT8l7wgmb7G
   RSuS3hBTvIpN40wWLwW+8sLXb6+mqfn8Rda1n7uf84KmmVGDM5LEpCwiP
   N3RAJmib+hOqQTo8RFm4zWCvK4hBFxq75RSdXYD/cCtvrCq1w+JnMy30B
   cvXmsyt9mSpk//nJ3u1U0C+hNwAU/zBEg03mlnqudCqlPR5PMZ84itRI8
   dmjU1bIyg+JV/dZCaf2otkKIIxN6rHNkDYg/LuLZq768GPi5P33+AKtSe
   A==;
X-CSE-ConnectionGUID: KITXSKGASSyyOjDzj5dM2w==
X-CSE-MsgGUID: KKLTwZsJQ42B+1hb0qmejQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="162922413"
X-IronPort-AV: E=Sophos;i="6.11,173,1725289200"; 
   d="scan'208";a="162922413"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 09:24:31 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 8D258D64AF;
	Thu,  3 Oct 2024 09:24:29 +0900 (JST)
Received: from yto-om2.fujitsu.com (yto-om2.o.css.fujitsu.com [10.128.89.163])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id BCD51D9CDC;
	Thu,  3 Oct 2024 09:24:26 +0900 (JST)
Received: from sm-x86-mem01.ssoft.mng.com (sm-x86-stp01.soft.fujitsu.com [10.124.178.20])
	by yto-om2.fujitsu.com (Postfix) with ESMTP id 4E5F2400578EA;
	Thu,  3 Oct 2024 09:24:26 +0900 (JST)
From: Yoshihiro Furudera <fj5100bi@fujitsu.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Weilin Wang <weilin.wang@intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yoshihiro Furudera <fj5100bi@fujitsu.com>
Subject: [PATCH] perf list: update option desc in man page
Date: Thu,  3 Oct 2024 00:24:04 +0000
Message-Id: <20241003002404.2592094-1-fj5100bi@fujitsu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00

There is a difference between the SYNOPSIS section of the help message
and the man page (tools/perf/Documentation/perf-list.txt) for the perf
list command. After checking, we found that the help message reflected
the latest specifications. Therefore, revised the SYNOPSIS section of
the man page to match the help message.

Signed-off-by: Yoshihiro Furudera <fj5100bi@fujitsu.com>
---
 tools/perf/Documentation/perf-list.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index dea005410ec0..14621f39b375 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -8,7 +8,7 @@ perf-list - List all symbolic event types
 SYNOPSIS
 --------
 [verse]
-'perf list' [--no-desc] [--long-desc]
+'perf list' [<options>]
             [hw|sw|cache|tracepoint|pmu|sdt|metric|metricgroup|event_glob]
 
 DESCRIPTION
-- 
2.34.1

