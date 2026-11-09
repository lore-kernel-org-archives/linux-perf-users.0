Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794185517;
	b=mrhMwiQ5a5iicszPit/5C7CUjauJpIKgr8JtHXVfQ45rCVq22cuh4yujWbEp3l+v1YMG
	 MkXa40NUhAC5GFjIQXGVG4GW8+g64kxrUCipiuVJZemA3e3M+wjxf/Kq7vkjfanT2yzKf
	 dIBYrtbSS9vHPYPQu9woRmOdpS22RKHMcSCFznMIq6XkxafzKXK7ForFAjlDK0ZpqpviL
	 aD3+q59rAu0ID83EDv16EewBr8NBFPATVRrvi44N+oR2Gxqu+XV2xNhhRJMd4Sho8QYG7
	 bnWG8hBaOPha1rHBtsrFZNg7J1Q4p66nAt/12dJYuUirmOUafs7AzlZAsRkyoCV5nTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794185517;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pnY96rIagGt1gCRi7El8yjbRnHF3x5U0xwDSaPkJyqI=;
	b=CCXY6j/Ppcf45rzrJoL9MY3Xw+mum54ItbHP3gpo4KlrBMLGQsBQ8dwnAaSXQYRIJGCD
	 etOl+5zG/SnxZvpnuI5YkzfoOtR+4lzppcWuLsivucjlpkYnmMfc8cLPsHcnye2fIP9yC
	 qDsJDtnKh3jG5DLVGTinkHK8xUlSCHp3z1z+pGahgOB/z/UUb9ewgqG9YPoyPEJ3lb0t3
	 oflx1J0N6F16nuL/Vnfgp8VB5C7fTNA3FCluGT3G5BAAUvEc1Py4GOamtXt3Uf1EEZ6bu
	 vnP1nOwd/HfIXxNZrCHAYlvYmwoWcO+u6PZV7Wald8jiV2KmQxZnCq72mvxaqPVbMRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jJwDE0w1;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E91606A33B;
	Mon,  9 Nov 2026 00:51:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41E91606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jJwDE0w1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794185517; x=1825721517;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=28I5eCSKb8KCGV6tdOjaCeeU20q8uT8YxyeDPzJ1qf0=;
  b=jJwDE0w1QuWtwP64lhsMTNT67Dc0Lb50Q49UKptw++vSF4/pxlpV3o7y
   +p7Wjk9jLlKvL9Y1NyD+NL4RIYz3o5n9m2ZZNEYuYtAhipA3/ezBAnFIb
   9mzncsGCNg1v5cCjA+GN7yHK6O+JWPAaIR+5HG5NIkZ6YLxAid/ZKh8LR
   RtY83KF1XBpa4NHIPwLRSE4LV0D7D7vB9BPQEPjExHgCW6Dj/1KsdNJBI
   Sa0tnnmVtIc9jd7t00BfblBhUIlEIeHFtEnFpxqRr2Jj/CZ2o0K3S66cS
   2tu4UaSa0mfwxBXT0KgeP6ekWxwpMRJj90o1FH61Ugx3ZD4CABJ+gWhfG
   g==;
X-CSE-ConnectionGUID: +MKPB3XTRPWUhT3JakmUvA==
X-CSE-MsgGUID: lIzB5BYoTs++JHQF7KSMrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2829564"
X-IronPort-AV: E=Sophos;i="6.27,202,1787036400"; 
   d="scan'208";a="2829564"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2026 16:51:57 -0800
X-CSE-ConnectionGUID: NYleDuPhQvKdNLhylWhOIg==
X-CSE-MsgGUID: DNKcrvlmT/+lnqodthK7Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,202,1787036400"; 
   d="scan'208";a="7874346"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa005.fm.intel.com with ESMTP; 08 Nov 2026 16:51:55 -0800
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v2 4/5] perf c2c: Show all memory regions in the region column
Date: Mon,  9 Nov 2026 08:44:01 +0800
Message-Id: <20261109004402.1403713-5-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261109004402.1403713-1-dapeng1.mi@linux.intel.com>
References: <20261109004402.1403713-1-dapeng1.mi@linux.intel.com>
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

The c2c memory-region column currently records only the last memory
region seen for an address. However, a single address can map to
multiple memory regions over the sampling window, so reporting only the
final one loses useful information.

Update the memory-region tracking to accumulate all sampled regions for
the address and display them together in the region column.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/builtin-c2c.c | 85 ++++++++++++++++++++++++++--------------
 tools/perf/util/c2c.h    |  3 +-
 2 files changed, 58 insertions(+), 30 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 8ed4a4704d2a..a2dcc65d6b3c 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -164,6 +164,7 @@ static void c2c_he_free(void *he)
 	zfree(&c2c_he->nodeset);
 	zfree(&c2c_he->nodestr);
 	zfree(&c2c_he->node_stats);
+	zfree(&c2c_he->regionstr);
 	free(c2c_he);
 }
 
@@ -260,7 +261,7 @@ static void c2c_he__set_mem_region(struct c2c_hist_entry *c2c_he,
 
 	/* Update mem_region only if it really accesses memory */
 	if (mem_region >= PERF_MEM_REGION_MMIO)
-		c2c_he->mem_region = mem_region;
+		c2c_he->regionset |= BIT(mem_region);
 }
 
 static void compute_stats(struct c2c_hist_entry *c2c_he,
@@ -565,37 +566,12 @@ dcacheline_node_mem_region(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 {
 	int width = c2c_width(fmt, hpp, he->hists);
 	struct c2c_hist_entry *c2c_he;
-	unsigned int mem_region;
-	char buf[20];
 
 	c2c_he = container_of(he, struct c2c_hist_entry, he);
-	mem_region = c2c_he->mem_region;
-
-	switch (mem_region) {
-	case PERF_MEM_REGION_NA:
-	case PERF_MEM_REGION_RSVD:
-		scnprintf(buf, sizeof(buf), "N/A");
-		break;
-	case PERF_MEM_REGION_MMIO:
-		scnprintf(buf, sizeof(buf), "MMIO");
-		break;
-	case PERF_MEM_REGION_MEM0:
-	case PERF_MEM_REGION_MEM1:
-	case PERF_MEM_REGION_MEM2:
-	case PERF_MEM_REGION_MEM3:
-	case PERF_MEM_REGION_MEM4:
-	case PERF_MEM_REGION_MEM5:
-	case PERF_MEM_REGION_MEM6:
-	case PERF_MEM_REGION_MEM7:
-		scnprintf(buf, sizeof(buf), "Mem-%d",
-			  mem_region - PERF_MEM_REGION_MEM0);
-		break;
-	default:
-		scnprintf(buf, sizeof(buf), "N/A");
-		break;
-	}
+	if (WARN_ON_ONCE(!c2c_he->regionstr))
+		return 0;
 
-	return scnprintf(hpp->buf, hpp->size, "%*s", width, buf);
+	return scnprintf(hpp->buf, hpp->size, "%*s", width, c2c_he->regionstr);
 }
 
 static int offset_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
@@ -2281,6 +2257,56 @@ static int set_nodestr(struct c2c_hist_entry *c2c_he)
 	return c2c_he->nodestr ? 0 : -ENOMEM;
 }
 
+#define PERF_MEM_REGION_MASK	\
+	GENMASK(PERF_MEM_REGION_MEM7, PERF_MEM_REGION_MEM0)
+#define PERF_MEM_REGION_NUM	\
+	(PERF_MEM_REGION_MEM7 - PERF_MEM_REGION_MEM0 + 1)
+
+static void set_mem_region_width(struct c2c_hist_entry *c2c_he, int len)
+{
+	struct c2c_dimension *dim;
+
+	dim = c2c_he__is_main_hist(c2c_he) ?
+	      &dim_dcacheline_mem_region : &dim_offset_mem_region;
+
+	if (len > dim->width)
+		dim->width = len;
+}
+
+static int set_mem_region_str(struct c2c_hist_entry *c2c_he)
+{
+	char buf[32];
+	int len = 0;
+
+	if (c2c_he->regionstr)
+		return 0;
+
+	if (!c2c_he->regionset) {
+		len = scnprintf(buf, sizeof(buf), "N/A");
+		goto out;
+	}
+
+	if (c2c_he->regionset & BIT(PERF_MEM_REGION_MMIO)) {
+		len = scnprintf(buf, sizeof(buf), "MMIO");
+		if (c2c_he->regionset & PERF_MEM_REGION_MASK)
+			len += scnprintf(buf + len, sizeof(buf) - len, ",");
+	}
+
+	if (c2c_he->regionset & PERF_MEM_REGION_MASK) {
+		unsigned long regionset =
+			c2c_he->regionset >> PERF_MEM_REGION_MEM0;
+
+		len += bitmap_scnprintf(&regionset, PERF_MEM_REGION_NUM,
+					buf + len, sizeof(buf) - len);
+	}
+
+out:
+	set_mem_region_width(c2c_he, len);
+	c2c_he->regionstr = strdup(buf);
+
+	return c2c_he->regionstr ? 0 : -ENOMEM;
+}
+
 static void calc_width(struct c2c_hist_entry *c2c_he)
 {
 	struct c2c_hists *c2c_hists;
@@ -2288,6 +2314,7 @@ static void calc_width(struct c2c_hist_entry *c2c_he)
 	c2c_hists = container_of(c2c_he->he.hists, struct c2c_hists, hists);
 	hists__calc_col_len(&c2c_hists->hists, &c2c_he->he);
 	set_nodestr(c2c_he);
+	set_mem_region_str(c2c_he);
 }
 
 static int filter_cb(struct hist_entry *he, void *arg __maybe_unused)
diff --git a/tools/perf/util/c2c.h b/tools/perf/util/c2c.h
index 65117108ddb1..e09edfa04710 100644
--- a/tools/perf/util/c2c.h
+++ b/tools/perf/util/c2c.h
@@ -33,7 +33,7 @@ struct c2c_hist_entry {
 	unsigned long		*nodeset;
 	struct c2c_stats	*node_stats;
 	unsigned int		 cacheline_idx;
-	unsigned int		 mem_region;
+	unsigned long		 regionset;
 
 	struct compute_stats	 cstats;
 
@@ -41,6 +41,7 @@ struct c2c_hist_entry {
 	unsigned long		 paddr_cnt;
 	bool			 paddr_zero;
 	char			*nodestr;
+	char			*regionstr;
 
 	/*
 	 * must be at the end,
-- 
2.34.1

