Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794185514;
	b=C9ZqYaKTqTkwKE2A4lQSaSRqQPxNRkVtzVlja7hWE2VLFApTlFPrygMwtwWa7CMNgnpe
	 38DIGlhUPQIAUyXSjc/wNTGDdJYg1JyT435xaA6a0W8w9S+dODGlV4LLooQk/pKa5qi0R
	 48zr8EOFWrU4LmNi6W+wLq1ZpP+vrJ7/YT76WlCB/adlo7RRbwr/kKiewrjYNoXPmaJ18
	 mR7bVSnWF+m1QEAG9ppkHXBPpy6WuLM9+gucqkCpt3XgiqnodvdLGM9fk+kuEH88sWMrA
	 PdSfUZzj7fS11sLIbJKbfsobC4CMjl/5J/j1E+vIAlKBx2KcqbdQtdYMz4LMSn+nNZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794185514;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=te/otpuvAkzcj6ULM7mmqWVDx0vUXmp8iYu9HRYtvm0=;
	b=Bg90Ns/pTjlAm6khM7W18cHQFz2J30Eu/CuO+m0+bYTyuuQ5kkU6EssyYg3H0xSoEvJ4
	 PbNP6hWEGCjYwQ5NqFPZdK+9Ql3qr4iNchJOUzh94+CZsQ6OVPEubY1+gBwt1BMfKwDop
	 s6nXf4B7mu3Xq6mmrzyafduJVUKhNqO8GJMYFrMyT29B9j0RSlNob8v9guYW0tlivPGss
	 qXPxmtLKM1KVRx74LhUQ++gb2p3iWkvud9obxkpA+QcpPp9ZgaooXa/SGLg+5N1Pkx7s2
	 x/DGNUYoKDZw2tGPLQV0fxsxu+fgyuUbfqnyk4CB1Jkjt75Y8TMvJA5VOMIlKLX7YCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SQTwqQ6f;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3487606A334;
	Mon,  9 Nov 2026 00:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3487606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SQTwqQ6f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794185514; x=1825721514;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YcyAmb4fxf9FjwDn+IqhvYLNjj0vTalGMhF0wJ3TpUU=;
  b=SQTwqQ6flIR0ayN+IByWMra+8SXNS02deUieT1wMn8+Q8CWCnqX9XES6
   kJj+e/kd7Bt73NUGN3q18YIkGuy2EATn+cQJ8HEchvovKO5+BqrkEo2o+
   euEi7cnf3G9KUubDwLXDVXiEBI7ePipxadqjIPJTM+TB1YNnnVxhW2UC6
   Qw5yAOQWnDf6hmC+cVzRZU62kODPGoVnBNb+R9I5YPrmTC1SfImrHirXT
   Ji+c9IIQ68W5AMNXfHkG/VQmc4vXMuaS7Wc66s2Lg70T8ygYjgrgvDQLP
   EL03Yd+P3xs9oQfSRy9m2hmI3hTGKstU2+ES1YkGSNrzpch6dxY1LMKCo
   A==;
X-CSE-ConnectionGUID: Ck3KltjMTKuMM3aiesL9ug==
X-CSE-MsgGUID: qQ8PXCjmT4K1ZeIlze6K7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2829559"
X-IronPort-AV: E=Sophos;i="6.27,202,1787036400"; 
   d="scan'208";a="2829559"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2026 16:51:54 -0800
X-CSE-ConnectionGUID: DuQHrF1OS0CTKI5R3bRyZg==
X-CSE-MsgGUID: G3DfZoIGR3ee7CL27T4GbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,202,1787036400"; 
   d="scan'208";a="7874334"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa005.fm.intel.com with ESMTP; 08 Nov 2026 16:51:51 -0800
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
Subject: [Patch v2 3/5] perf c2c: Show memory region in the per-cacheline view
Date: Mon,  9 Nov 2026 08:44:00 +0800
Message-Id: <20261109004402.1403713-4-dapeng1.mi@linux.intel.com>
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

The memory-region column is currently displayed only in the top-level
cacheline view; it is missing from the child per-cacheline view.

Show the memory region in the per-cacheline view as well so the display
is complete and consistent.

For example, the per-cacheline view now shows entries such as:

Cacheline 0xff11002f7ef47a00
RmtHitm  LclHitm   L1 Hit  L1 Miss      N/A    Off  Region  Node  PA cnt
100.00%    0.00%    0.00%    0.00%    0.00%   0x10   Mem-0     0       1

Also move the c2c.show_mem_region assignment before setup_coalesce() so
the per-cacheline header is generated with the correct region layout.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/builtin-c2c.c | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index a0c9afddbe98..8ed4a4704d2a 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -1452,6 +1452,14 @@ static struct c2c_dimension dim_offset_node = {
 	.width		= 4,
 };
 
+static struct c2c_dimension dim_offset_mem_region = {
+	.header		= HEADER_LOW("Region"),
+	.name		= "offset_mem_region",
+	.cmp		= empty_cmp,
+	.entry		= dcacheline_node_mem_region,
+	.width		= 6,
+};
+
 static struct c2c_dimension dim_iaddr = {
 	.header		= HEADER_LOW("Code address"),
 	.name		= "iaddr",
@@ -1861,6 +1869,7 @@ static struct c2c_dimension *dimensions[] = {
 	&dim_dcacheline_node,
 	&dim_dcacheline_count,
 	&dim_offset,
+	&dim_offset_mem_region,
 	&dim_offset_node,
 	&dim_iaddr,
 	&dim_tot_hitm,
@@ -3013,13 +3022,24 @@ static int ui_quirks(void)
 		nodestr = chk_double_cl ? "Double-CL" : "CL";
 	}
 
+	/*
+	 * With the extra "Region" column, the zero line of the
+	 * dcacheline/offset header must span one more column.  Set
+	 * this after the TUI header assignment above, which would
+	 * otherwise overwrite the span with the default value.
+	 */
+	if (c2c.show_mem_region) {
+		dim_dcacheline.header.line[0].span = 3;
+		dim_offset.header.line[0].span = 3;
+	}
+
 	dim_percent_costly_snoop.header = percent_costly_snoop_header[c2c.display];
 
 	/* Fix the zero line for dcacheline column. */
 	buf = fill_line(chk_double_cl ? "Double-Cacheline" : "Cacheline",
 				dim_dcacheline.width +
 				(c2c.show_mem_region ?
-					dim_dcacheline_mem_region.width : 0) +
+				 dim_dcacheline_mem_region.width : 0) +
 				dim_dcacheline_node.width +
 				dim_dcacheline_count.width +
 				(c2c.show_mem_region ? 6 : 4));
@@ -3030,8 +3050,11 @@ static int ui_quirks(void)
 
 	/* Fix the zero line for offset column. */
 	buf = fill_line(nodestr, dim_offset.width +
+				 (c2c.show_mem_region ?
+				  dim_offset_mem_region.width : 0) +
 			         dim_offset_node.width +
-				 dim_dcacheline_count.width + 4);
+				 dim_dcacheline_count.width +
+				 (c2c.show_mem_region ? 6 : 4));
 	if (!buf)
 		return -ENOMEM;
 
@@ -3158,7 +3181,7 @@ static int build_cl_output(char *cl_sort, bool no_source)
 	}
 
 	if (asprintf(&c2c.cl_output,
-		"%s%s%s%s%s%s%s%s%s%s%s%s",
+		"%s%s%s%s%s%s%s%s%s%s%s%s%s",
 		c2c.use_stdio ? "cl_num_empty," : "",
 		c2c.display == DISPLAY_SNP_PEER ? "percent_rmt_peer,"
 						  "percent_lcl_peer," :
@@ -3166,7 +3189,9 @@ static int build_cl_output(char *cl_sort, bool no_source)
 						  "percent_lcl_hitm,",
 		"percent_stores_l1hit,"
 		"percent_stores_l1miss,"
-		"percent_stores_na,"
+		"percent_stores_na,",
+		c2c.show_mem_region ?
+		"offset,offset_mem_region,offset_node,dcacheline_count," :
 		"offset,offset_node,dcacheline_count,",
 		add_pid   ? "pid," : "",
 		add_tid   ? "tid," : "",
@@ -3356,6 +3381,8 @@ static int perf_c2c__report(int argc, const char **argv)
 		goto out;
 	}
 	env = perf_session__env(session);
+	c2c.show_mem_region = perf_header__has_feat(&session->header,
+						HEADER_MEMORY_RANGES);
 	/*
 	 * Use the 'tot' as default display type if user doesn't specify it;
 	 * since Arm64 platform doesn't support HITMs flag, use 'peer' as the
@@ -3454,11 +3481,6 @@ static int perf_c2c__report(int argc, const char **argv)
 		goto out_mem2node;
 	}
 
-	c2c.show_mem_region = perf_header__has_feat(&session->header,
-						HEADER_MEMORY_RANGES);
-	if (c2c.show_mem_region)
-		dim_dcacheline.header.line[0].span = 3;
-
 	if (c2c.display != DISPLAY_SNP_PEER) {
 		if (asprintf(&output_str,
 			     "cl_idx,"
-- 
2.34.1

