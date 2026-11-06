Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793950706;
	b=sY5eYHtIUERM2ieACueGr2ONk2YSzvqXtJ8es7AwxT0u2SJksPt2j+6R/yFMJgWpwKE8
	 qSLUVbgcGLsmo7BBh01cRt+CZa3FQqtI9EfyfkpzuXrIOpP2VvaGJLdqaFD5clLmcu9nI
	 xnUaSruv2Jc388bdLWNj+/Jj5wxZoN/5sSwoEURyv+AHfCwROKTLxABa4CgWAZHvdznGp
	 K9Rp6uskmyMDe64vHIseANEuZqriQ44tPNOre7koGaE4X/5AdH3Wy9/9nRCfXy8h+KvzY
	 Trk4Sxnv1GK+ibXG/xTRAvRT0e04f7kWZhtbQoFDyd4J5IqAL0nxHt2DrBIqpvOt20g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793950706;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=md4DV7Uq6VE7WZ7howJj84G8xOt7wd8gui73Hd+prt4=;
	b=MLTv/WFG/1+ldAxmpoqOMLDN2lnWSEMvjSDzg6UuazzWTIHEtPhGHJ+XrvE3hQjQFcq8
	 g6nq4z/SYWOecR0g0t0/h4xThXm3HiVi2quuDiLGEtOq0I7f0hk/wLPNCB8vqRo22WQuL
	 doVGdlE8XSzgKqTRPOJBb2qYkpyh2Ph+K089GgZMSxEJaowycM7dj+2YQ3ZTvUOUEg4oT
	 iZLnpwSqT6hHRlal4KkNhVYFwMmDP1qbPnbIrKdxmC4J+pB7H4OcYS4rBup4mPuGlng0h
	 Ej2LlHx6NpuevEUGP50Wxm3tS7od2le6PNrhl0IgOHHNf+dLew4AERlCmMCJ9QDYGCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DgponXQ7;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4A9606A326;
	Fri,  6 Nov 2026 07:38:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A4A9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DgponXQ7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793950705; x=1825486705;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=70d4DhRMabrnAiAt2CKS7Ue/r14+uvnteF2U7TPnl70=;
  b=DgponXQ70T32qVBrX50GoKDcl8pFsjDgNZ2mtSiczYikyrEAZTmR9POV
   tmmKa0pbcMW5GZYRkpzJFR5srTGCJu68lNDGuptUCCtNoHF3ruNLB4hip
   hQ5SApzzpgh82hXWSUM1HRcpH4wMovbfcEZnyrul4gjR/OWvNKu8pm7gC
   yJSc7BT+jhG+twgezvPGBxqVmdb/4Bk92OYzDc6RBkH1ceeLPPwjXvy/X
   L0a86mqLj4ZnmBVwjKkgFOG6Vvan1NKzzO+kd+XMVwBUcKNqwKhDT/vat
   jwLHS2fm7yHyC/ZynCNMcRRPjSjxie8wAhmh6F9vJVDGlFy56aIrdZ2+Z
   w==;
X-CSE-ConnectionGUID: iAN2mx0fTFybRmJ+W3LN1g==
X-CSE-MsgGUID: onfkH9X1TqGWgJOunhb7wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2637941"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2637941"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 23:37:45 -0800
X-CSE-ConnectionGUID: So72+R7nSFy2DzaQ/AwXwQ==
X-CSE-MsgGUID: H6iPHfUSSZqvaDCSzgCoEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7328224"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa009.jf.intel.com with ESMTP; 05 Nov 2026 23:37:41 -0800
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	kernel test robot <yi1.lai@intel.com>
Subject: [PATCH 1/2] perf tests: Skip zero sample IP in object-code reading test
Date: Fri,  6 Nov 2026 15:30:17 +0800
Message-Id: <20261106073018.903126-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel may clear the sample IP to 0 when a user-space address is
expected but a kernel address is sampled due to hardware skid. A zero
sample IP causes the object-code reading test to fail incorrectly.

Skip zero sample IP values in the object-code reading test to avoid
false-positive failures.

Reported-by: kernel test robot <yi1.lai@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202609151503.cb02f753-lkp@intel.com
Fixes: 166f10836a65 ("perf/core: Fix kernel register info leak via hardware skid")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/tests/code-reading.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 130cd6021f93..7b80c4ab6916 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -546,6 +546,11 @@ static int process_sample_event(struct machine *machine, struct evlist *evlist,
 		goto out;
 	}
 
+	if (!sample.ip) {
+		pr_debug("kernel may clear IP to 0 in invalid cases, skip it\n");
+		goto out;
+	}
+
 	thread = machine__findnew_thread(machine, sample.pid, sample.tid);
 	if (!thread) {
 		pr_debug("machine__findnew_thread failed\n");
-- 
2.34.1

