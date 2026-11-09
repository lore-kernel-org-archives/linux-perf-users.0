Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794185521;
	b=3KhIqKZ963H0znotG2o3JgBHewHeEnYVTWaj8bm0dEF6fzB/IXwq2HpkovQSBP7p0yHe
	 Xga+hdZfDhxvSVj/ePunhQcaJU3zIa+m/ay/r0XNwkC+6VoSdR/066FNEkKgRZPIoF/fw
	 apGFv2xlHy/eEy7Uu9HJFQCBNlxMRpBw1L6Gby3iD5Y4oCZIxwFHjpUjK0VIbYsalAABB
	 pbfBpWHZ+LJhZEOSqZf7hNUMs3lggM5UDabWMJMZpnBy+pnOF8tfmdlb090ToAFmjaptV
	 DH5Lcp4YQNs6zjt4h/GWmQLwIuNi0DU9tJZ6ON06PUFRnI/qOCyws+u290XHyZjDCAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794185521;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=A2/Aph2qfH3RXUgYlqDL38imd1N9APnssAe7CDVkTj4=;
	b=vJ88Ot44uvPM7lDVIf8oXIFWgY4jMTXRS4M3EyHVsH1pAzYLscV7TzX7Je24xzysx0nm
	 mrtxsM6lXtf5hnP9zVCNWcdtWDnSVxby9IOs/8zoa0Zl3j5nGxmwihbcNX4pXePoK6tlJ
	 Hhw9GIAJ8Gxhb5Z2at5JhFUZwBXurYfclUrWCXKau9+pJ2XmHy/GvOfko6qlYvPbAT+p5
	 MMWi6ysh5WT+0MLTS/dSuvJ1TcLm/uljgNltFUwj1Wo/QK9G8rXZT49ipABipeIiKyiv1
	 z29yAteuILFCINdTkJVioAuar50QXSaKxSrFY7q91XAtjZTSjvp09NKXcQYdSJmssrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Crw2+fBt;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CAC606D809;
	Mon,  9 Nov 2026 00:52:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89CAC606D809
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Crw2+fBt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794185521; x=1825721521;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dffyN6jv3w949aLbiEJmcopGK9+iRTGjwv7+QCFfef0=;
  b=Crw2+fBtsDiIRSOFzoJ0MWQcQ9dlqluhqusYnHN/NMlpKi4605uDfXti
   dQQR+65+Dagy8iquRwep5KJiPTdE00CkE15Eb66j066BxlfR1KubNWEio
   YzdoxNZUCIVlSt3uZuv0FR/v/If8jO9y8RrgN8WYgweNfUcO7yeKSOOmE
   dvmI3ssqAtR9+iAIwucWMaqJrOl8AFUuNNxQo5HCqcOL6thaK2La7YUJp
   +eBU9AtrCwK25E6vYYvVWsowuDCoIQ8qm0/nVvqXWrwvMivnIs2M7wJxF
   1kAS9CdpgNix+1l2nEUSsgXwvn3/YywhGHgDeuYBWsxmoCIudhlhwwMcA
   Q==;
X-CSE-ConnectionGUID: zSoK8cp9SOajDWkW7DBKXg==
X-CSE-MsgGUID: 1YgST6asThemST+d5tULfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2829569"
X-IronPort-AV: E=Sophos;i="6.27,202,1787036400"; 
   d="scan'208";a="2829569"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2026 16:52:00 -0800
X-CSE-ConnectionGUID: vD4d9O+XS62fimFFSjsC4A==
X-CSE-MsgGUID: QJ0cX3TFSEmgjvLZ3WbFjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,202,1787036400"; 
   d="scan'208";a="7874364"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa005.fm.intel.com with ESMTP; 08 Nov 2026 16:51:58 -0800
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
Subject: [Patch v2 5/5] perf c2c: Rename "Region" column to "Range" for consistency
Date: Mon,  9 Nov 2026 08:44:02 +0800
Message-Id: <20261109004402.1403713-6-dapeng1.mi@linux.intel.com>
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

Currently the "Memory Ranges" header uses the word "range" to indicate
a memory region, however the top-level cachelines and per-cacheline pages
label the memory-region column as "Region". This naming mismatch could
confuse the users.

Rename the column label to "Range" to match the existing "Memory Ranges"
terminology and keep the output clearer for users.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/builtin-c2c.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index a2dcc65d6b3c..94fca3e4fc0a 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -1395,11 +1395,11 @@ static struct c2c_dimension dim_dcacheline_node = {
 };
 
 static struct c2c_dimension dim_dcacheline_mem_region = {
-	.header		= HEADER_LOW("Region"),
+	.header		= HEADER_LOW("Range"),
 	.name		= "dcacheline_mem_region",
 	.cmp		= empty_cmp,
 	.entry		= dcacheline_node_mem_region,
-	.width		= 6,
+	.width		= 5,
 };
 
 static struct c2c_dimension dim_dcacheline_count = {
@@ -1429,11 +1429,11 @@ static struct c2c_dimension dim_offset_node = {
 };
 
 static struct c2c_dimension dim_offset_mem_region = {
-	.header		= HEADER_LOW("Region"),
+	.header		= HEADER_LOW("Range"),
 	.name		= "offset_mem_region",
 	.cmp		= empty_cmp,
 	.entry		= dcacheline_node_mem_region,
-	.width		= 6,
+	.width		= 5,
 };
 
 static struct c2c_dimension dim_iaddr = {
-- 
2.34.1

