Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA312EA16A;
	Thu,  9 Oct 2025 14:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760018682; cv=none; b=X/qhdjrWzS5qam6PrF2kZVPShJkS+3kuiU9HCus1+h8W0SLsA6IODUFgn85WxmnVXzAL19XC/7T+OvgAu5XVaUvheIDZ1h5Y9rbr1JUwUNIMOzLc8R1lQP1/CFfzF7nfqb4rZV3FKy3CiyCtLFwmXWHS3kG341x1A2EikxBbeCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760018682; c=relaxed/simple;
	bh=3wGgMn8Cw0iY7lMDf17UHV7XGPinBRKzCOMhYp2CT+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oDhWTANE4Q/i2GoXfYl6gqi/eKtPrj0RJh6LU60ZqO07EObw/hKLRRDWkR/KYsos1/hoSjoz7N8uCAJeVh3sInhO7m43AN8sN7A/9HDqyzsnGfQ0YMHZX1Cq/NiyjFQSNv68BMQDIcumDhz6o6zhBSMKoVsjqSBZEDXYdsImrQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RxvxlZDY; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RxvxlZDY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760018681; x=1791554681;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3wGgMn8Cw0iY7lMDf17UHV7XGPinBRKzCOMhYp2CT+Q=;
  b=RxvxlZDYg1cF7vnPnLcu2e4Cb3JzPMS3TKIxWUCpq3zEUdEyJKLcm6O5
   /2hLE0jxB5p3lxsYcH2rMi0gHMACFJOjP1+A4v92Nu+CHtdHR1zeGybAC
   kC69X6JJxy2iE0+jocBC+iRkF40mqkTyKQ1bSELt3nakjs9GulhhPzacS
   jmv2BfxsbAEJUFOMKPnpgeHz99KXgXe/tbSDCNsfoRrISIa97NeRf6vQW
   fJqH0L6GCXU5e5mRGreTOY5dAHBfwNYYUHrPVXttBtWgk53SOFS9esGri
   dPXxNhN1c6B+a1OqsEWy0Nj8dUjGyI6BjQBHr1UnAlwJAAy49Tjz0T/F6
   g==;
X-CSE-ConnectionGUID: CHvORYmmSaCxXYyWw7yR3A==
X-CSE-MsgGUID: 5VT0EYnlRriUXhSQawfdEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="73655523"
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; 
   d="scan'208";a="73655523"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 07:04:29 -0700
X-CSE-ConnectionGUID: RCCEi1CcS86g/5vahGpiIg==
X-CSE-MsgGUID: YQQk8N/nTZOZsbRSb6sHag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; 
   d="scan'208";a="181489391"
Received: from linux-pnp-server-27.sh.intel.com ([10.239.147.41])
  by fmviesa010.fm.intel.com with ESMTP; 09 Oct 2025 07:04:25 -0700
From: Tianyou Li <tianyou.li@intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	tianyou.li@intel.com,
	wangyang.guo@intel.com,
	pan.deng@intel.com,
	zhiguo.zhou@intel.com,
	jiebin.sun@intel.com,
	thomas.falcon@intel.com,
	dapeng1.mi@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf tools annotate: fix a crash/hang when switch disassemble and source view
Date: Thu,  9 Oct 2025 22:57:58 +0800
Message-ID: <20251009145758.1742565-1-tianyou.li@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When perf report with annotation, press 'TAB' to navigate among hot lines,
press 's' to switch on the source view, then press 'TAB' again, the perf
report could crash or hang. The 'nd' and 'browser->curr_hot' need to be
updated when switch the disassemble and source view.

Signed-off-by: Tianyou Li <tianyou.li@intel.com>

format
---
 tools/perf/ui/browsers/annotate.c | 35 ++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 8fe699f98542..32da310b3b62 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -852,6 +852,30 @@ static void annotate_browser__debuginfo_warning(struct annotate_browser *browser
 	}
 }
 
+static u32 rb_node__get_idx_asm(struct rb_node *nd)
+{
+	struct annotation_line *al = NULL;
+
+	if (nd == NULL)
+		return 0;
+
+	al = rb_entry(nd, struct annotation_line, rb_node);
+
+	return al->idx_asm;
+}
+
+static struct rb_node *annotate_browser__rb_node_by_idx_asm(struct annotate_browser *browser,
+									u32 idx_asm)
+{
+	struct annotation_line *al = NULL;
+
+	if (idx_asm == 0)
+		return NULL;
+
+	al = annotate_browser__find_new_asm_line(browser, idx_asm);
+	return al ? &al->rb_node : NULL;
+}
+
 static int annotate_browser__run(struct annotate_browser *browser,
 				 struct evsel *evsel,
 				 struct hist_browser_timer *hbt)
@@ -969,8 +993,17 @@ static int annotate_browser__run(struct annotate_browser *browser,
 			nd = browser->curr_hot;
 			break;
 		case 's':
-			if (annotate_browser__toggle_source(browser, evsel))
+			u32 idx_asm_nd = rb_node__get_idx_asm(nd);
+			u32 idx_asm_curr_hot = rb_node__get_idx_asm(browser->curr_hot);
+
+			if (annotate_browser__toggle_source(browser, evsel)) {
 				ui_helpline__puts(help);
+				/* Update the annotation browser's rb_tree, and reset the nd */
+				annotate_browser__calc_percent(browser, evsel);
+				nd = annotate_browser__rb_node_by_idx_asm(browser, idx_asm_nd);
+				browser->curr_hot = annotate_browser__rb_node_by_idx_asm(browser,
+							idx_asm_curr_hot);
+			}
 			annotate__scnprintf_title(hists, title, sizeof(title));
 			annotate_browser__show(browser, title, help);
 			continue;
-- 
2.47.1

