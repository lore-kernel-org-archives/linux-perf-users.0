Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793950707;
	b=w+dNaH6uuiO7ySN6awVMWrYMVURc8ZQ+LY8hC4M+CQkFlhIAwKoTbSUN0F2kyZ5hzdTF
	 HfBF6OLZXh92cuH/XxgB5qZVGiwSXV+ySSgO1+1vbURg6r1IWSthy2pJxQRxbXXcLupXo
	 tbj+ZS8WdIeC7T83aZ5dIDh2kIuVyNW9m0alNXK52SAnifIXRBoHCgPZSEQX31jyOif6+
	 Vi37daVcj5HIxV9UmV6iPnjRLghNpyPFN3tIyXYgLoP4krpGEVNhEQSIi4Pg0MWKvOD3N
	 kgCXap2hY89t+aHnhfh932UhWi39oB03rAbCX9Fqc2OqO8F8r2V0Hr5XLgUlsP1iZBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793950707;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rB09DHDcxMokWa/D7IkAX6jg6GdN9oWeMRZveHB6Ga8=;
	b=A+uZCFrexGOOFLxU5njZ7rAlyjePgR8kisPqcf1A0osthPvKBepMahsxUKm1sHRCvjQR
	 vWNCJfib1zZ3teDXxx4lrTPRMgjDZl6NAq8z/l0unNbwxesReCqJBHSAsqwmT1URVPXCa
	 WtNXZEt2eSp3yBUn0NRUUbKRkHBhvgd0oNWxAB1beok7lxYmOAuXCBN5AMImTst1I2iEz
	 YDhoFUvNOTfCRir6OVuv9VfjVUYprx7IFS2GnPkIEw4moxjiMWJQD055cJHfWAKMwzumu
	 4m2fL57WgVCjvx8hxFPwG1L3yRaIxX88L2fNUvOT/VXawXcJfJYmkrHAwPrrHWjIeKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cM3p1Sek;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F57D606A330;
	Fri,  6 Nov 2026 07:38:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F57D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cM3p1Sek
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793950707; x=1825486707;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=97SHg7DHSD+ld5bsxu2o4TRwdcLmZ1rqS4hvjDXFRAc=;
  b=cM3p1SekS5saObVzSPbZorRPUIwKmZYximM44TIPkDSlu+YlaqOzavOj
   JKitIFR8iREM4GkvyOz65B61OncKbxwVHIZC1ybEN1KOeX5Zl2CobabEF
   NrQq5NVFSMSGty62x38t9czLfN84oILN7u8KKtUQ4BSG0r61HA8BUDi9W
   KarxpkMkVJNB/33VZELTAzlZU92jlNH2XWHdb923Kn6poZC8U+ms4wuTj
   Fi9MX+qb5i2LMwtWk9piqRAsKH5vyzJQ/RjeI4WRYfVSmNhDXx0XunQC2
   BV4PJyuM0CvE11v09dw812XnkC/UjyMii+tagbz09C3bb8ka+j6XUMsDO
   g==;
X-CSE-ConnectionGUID: FYcUZTUBT5SUMVBZjeboUg==
X-CSE-MsgGUID: d+tA+9tVQ5qw4xqytO+QBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2637954"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2637954"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 23:37:48 -0800
X-CSE-ConnectionGUID: 4frjOTbjTLiarnDHcIDdig==
X-CSE-MsgGUID: HjDlsFhCQ7mW/4KZS/JOIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7328253"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa009.jf.intel.com with ESMTP; 05 Nov 2026 23:37:44 -0800
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
Subject: [PATCH 2/2] perf c2c: Show all memory regions in the region column
Date: Fri,  6 Nov 2026 15:30:18 +0800
Message-Id: <20261106073018.903126-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261106073018.903126-1-dapeng1.mi@linux.intel.com>
References: <20261106073018.903126-1-dapeng1.mi@linux.intel.com>
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
 tools/perf/builtin-c2c.c | 80 +++++++++++++++++++++++++---------------
 tools/perf/util/c2c.h    |  3 +-
 2 files changed, 53 insertions(+), 30 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index f51fa23f3bf1..9c638fbfc2ea 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -260,7 +260,7 @@ static void c2c_he__set_mem_region(struct c2c_hist_entry *c2c_he,
 
 	/* Update mem_region only if it really accesses memory */
 	if (mem_region >= PERF_MEM_REGION_MMIO)
-		c2c_he->mem_region = mem_region;
+		c2c_he->regionset |= BIT(mem_region);
 }
 
 static void compute_stats(struct c2c_hist_entry *c2c_he,
@@ -565,37 +565,12 @@ dcacheline_node_mem_region(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
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
@@ -2264,6 +2239,52 @@ static int set_nodestr(struct c2c_hist_entry *c2c_he)
 	return c2c_he->nodestr ? 0 : -ENOMEM;
 }
 
+#define PERF_MEM_REGION_MASK	\
+	GENMASK(PERF_MEM_REGION_MEM7, PERF_MEM_REGION_MEM0)
+#define PERF_MEM_REGION_NUM	\
+	(PERF_MEM_REGION_MEM7 - PERF_MEM_REGION_MEM0 + 1)
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
+		int num = hweight_long(regionset);
+
+		len += scnprintf(buf + len, sizeof(buf) - len, "Mem-");
+		if (num > 1)
+			len += scnprintf(buf + len, sizeof(buf) - len, "{");
+		len += bitmap_scnprintf(&regionset, PERF_MEM_REGION_NUM,
+					buf + len, sizeof(buf) - len);
+		if (num > 1)
+			len += scnprintf(buf + len, sizeof(buf) - len, "}");
+	}
+
+out:
+	if (len > dim_dcacheline_mem_region.width)
+		dim_dcacheline_mem_region.width = len;
+	c2c_he->regionstr = strdup(buf);
+
+	return c2c_he->regionstr ? 0 : -ENOMEM;
+}
+
 static void calc_width(struct c2c_hist_entry *c2c_he)
 {
 	struct c2c_hists *c2c_hists;
@@ -2271,6 +2292,7 @@ static void calc_width(struct c2c_hist_entry *c2c_he)
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

