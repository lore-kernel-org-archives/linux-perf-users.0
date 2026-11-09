Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794185511;
	b=17bg3cSJp77XOMTH0qJeW7+ZXBOanV2NHAAk+pbV0KT9qKPW3/OyDwbX5fgACJhnsbkh
	 6wRkzf+it/j04JlMcPaX36CTeCVhvzcoD4ewz73L7VHyEM16ZQ2fu4d1Y6zZe++5pARnE
	 kuVX4nNXMLiJBF2sFK2oFkoRSQMFLFCf9OId37tjHeKz6h4m1jUZBFHvE1ORbukKPO8ab
	 TS+UWqcE+xMLPk4Qczx1OZ5KSMKGEunssAFtCivlJCyLgPcBF4vN6XvgSnd+ogkzTFq7h
	 CKdmgHxRg8IzTGWW75ks3Z5YyqeWmTG6BDm5HdbF1/SiFDr2nJzVrSeL6siwkmVYBwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794185511;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FjQensKeQZoCkCEtDIT3fbgPZuiXjpFr286UBMz+mDM=;
	b=fAZd1Y+T506RE+TLpZyQpZR4Pg1vsiWhY//1NYdYq6//QkWrD3JTOyK6pN1Tba0Y080V
	 R4q9BS8PT6gRnMkhaIZtn7FVHNGLefL1EqhDxvbgUjRN6Bs70LVB8m1SxShvHBzihRYvw
	 0BHUr8IhSUpnqfO6YvikqeURIP/2ATb7ph4OZwDzdJjOEHhM4H6yX2UkhaC2zbJ9uddbk
	 xEeEkDKetAfF/PN92p/tgPu4mTXGdtr8hxPjObMlilVrERo5uGf5UJLjKLBf5j8cm1Wez
	 7rRtrcJAf8J4uF2ZctSe85L0c2hanvcqI/mR9Yit45Ni1N/oGDTxVNUc2Ep3sf+jaog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="mo/KIdj6";
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9563E606A330;
	Mon,  9 Nov 2026 00:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9563E606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mo/KIdj6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794185511; x=1825721511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JTSudecPECm0X7twhNJ/3RdQ+NQoq+8d8auCWKZkKwU=;
  b=mo/KIdj6rA67UgorVrH70qsSFyDeeEBb5kLBSsw368Mb0273wROja/IS
   t633EkMcTIV2BGMMEnqASyPHfTFH+Ad9x+rgTOnA5132tHZCs1zDcEkts
   efZAW0Ih/bk0tp/F5sqwpqbUjoVHqDjbiw9zz1X/Gom0mBroTKkW01Nfw
   8RgrcSEOTjG67wY4hD0CGjswdB1z6ofujIQ8CVF3IqdyKiXAMarnkvL0R
   sKSLB9NH7UXvjN0zn4Pm/gyxGl9EvhqiQDubOLIff6qBdXhpw1Nt/XyAk
   m/PTOyxOd9is3+qXBtud/qPTEpwmLFJheJYnmXSceI6NzTgeYLCGtia5A
   Q==;
X-CSE-ConnectionGUID: bc3nK0YXQ8iqtHjApa+MFA==
X-CSE-MsgGUID: k3dsW442SOSYWqBH1rb1yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2829553"
X-IronPort-AV: E=Sophos;i="6.27,202,1787036400"; 
   d="scan'208";a="2829553"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2026 16:51:50 -0800
X-CSE-ConnectionGUID: jhNu7Q1CRBu+e42PFKikCA==
X-CSE-MsgGUID: jfrkf1+wQquALfpfkaM3yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,202,1787036400"; 
   d="scan'208";a="7874308"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa005.fm.intel.com with ESMTP; 08 Nov 2026 16:51:48 -0800
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
Subject: [Patch v2 2/5] perf c2c: Fix top-level histogram ownership check
Date: Mon,  9 Nov 2026 08:43:59 +0800
Message-Id: <20261109004402.1403713-3-dapeng1.mi@linux.intel.com>
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

The function set_node_width() incorrectly determined whether a c2c
histogram entry belonged to the top-level cacheline view by checking
if &c2c.hists equals c2c_he->hists.

This comparison is always false for top-level entries because
c2c_he->hists is only assigned for lazily-created sub-histograms in
he__get_c2c_hists(). Top-level entries are instead stored under
he->hists, which points to the embedded struct hists inside c2c.hists.

Add a dedicated helper, c2c_he__is_main_hist(), to check whether a
c2c_hist_entry belongs to the top-level histogram tree and use it to
update the node width accordingly for top-level cachelines view or
per-cacheline view.

Fixes: 7f834c2e84bb ("perf c2c report: Display node for cacheline address")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/builtin-c2c.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index f51fa23f3bf1..a0c9afddbe98 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2233,11 +2233,19 @@ static inline bool is_valid_hist_entry(struct hist_entry *he)
 	return has_record;
 }
 
+static inline bool c2c_he__is_main_hist(struct c2c_hist_entry *c2c_he)
+{
+	struct hists *hists = c2c_he->he.hists;
+
+	return hists &&
+	       container_of(hists, struct c2c_hists, hists) == &c2c.hists;
+}
+
 static void set_node_width(struct c2c_hist_entry *c2c_he, int len)
 {
 	struct c2c_dimension *dim;
 
-	dim = &c2c.hists == c2c_he->hists ?
+	dim = c2c_he__is_main_hist(c2c_he) ?
 	      &dim_dcacheline_node : &dim_offset_node;
 
 	if (len > dim->width)
-- 
2.34.1

