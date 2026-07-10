Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CFD3F1ACF;
	Fri, 10 Jul 2026 08:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783673022; cv=none; b=Cp4Q2iRIScDJswYdMGBMDEc+SGqNFB28+rZKpqHgWAY7s3mbpA1+Je67IQgqnc+Eo+WOBUmRZC0hTK+YOLrXcEACsuDdg6+Jr0HTB8JyYDRqOAd/MkIgzRkyOBpzMbLIrVJq4Frn5ebwc8txnYfMKi/BHmHRyQtTYmJTOsP4GlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783673022; c=relaxed/simple;
	bh=Ewfnh6yrSu/plgJzPF6dpQ01/Es2m2b+1MNzDAzcV6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=spWjr7LdtzRRRw/TDhrYYmRY6DEQxzXO4UOb+pRjVC10xuQkCyJuBA1dCOxgDKEhZ2z+mktgudQJF4DCFwp8GOiWoCcijAel/cIeE2tmShIrHF65TYK7/k5ovZHE5Nk9mOE7OyraSJdYQ1TmpWzI4I567obcEFpcf8Aw30c6IKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bqzTDXyk; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bqzTDXyk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783673021; x=1815209021;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ewfnh6yrSu/plgJzPF6dpQ01/Es2m2b+1MNzDAzcV6s=;
  b=bqzTDXykZyVofOI43MeCTZO0bcOoVFxtg18OHXvUcuwZEWGoRo+rABJH
   LM7GFQLZ0bsrFlVRWF/eBlWpXStaGLqY0d6JhmYIO49XJEzkGxrG75LHC
   /1WiD6G3fuhHzyU1Z7wkN6kcOhqobaqlqSUZmBS1oNx79TJR88rHZpuQA
   uBkbfd/TGN3oKrxpxUB8D2t2PRVX+MaEdrVVcJVV4n20swOt2sFnyVoyi
   NYIOY2DrTShjoZ/WePUpzlUXiZbzjLCIQ+3gyPpNty+6B91ndDRHxNaGF
   CLYXbXEzxQT5/KgxWtIhJCR8/C0pnRfICNLHV3h5goc3BV6KKzp39vyap
   w==;
X-CSE-ConnectionGUID: XW8dw8SnQZyre2oMq8rZMA==
X-CSE-MsgGUID: jXdPQ0fFQUaEdCjAjVKFHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84390915"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84390915"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 01:43:35 -0700
X-CSE-ConnectionGUID: 1dLcrXI4QCSF3qaKP9o1Tg==
X-CSE-MsgGUID: KXB6ZY6hSg+9LpH9FPkp5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="258435472"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by orviesa003.jf.intel.com with ESMTP; 10 Jul 2026 01:43:31 -0700
From: Jiebin Sun <jiebin.sun@intel.com>
To: Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiebin Sun <jiebin.sun@intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Tianyou Li <tianyou.li@intel.com>,
	Wangyang Guo <wangyang.guo@intel.com>
Subject: [PATCH v2 13/14] perf c2c: add TAB key to switch to function view
Date: Fri, 10 Jul 2026 16:42:46 +0800
Message-ID: <20260710084247.3576706-14-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260710084247.3576706-1-jiebin.sun@intel.com>
References: <20260626070355.1556721-1-jiebin.sun@intel.com>
 <20260710084247.3576706-1-jiebin.sun@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wire up the TAB key in the cacheline browser to launch the function
view browser via perf_c2c__browse_function_view(). This allows users
to switch between the traditional cacheline view and the new
function-level sharing analysis view.

Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Falcon <thomas.falcon@intel.com>
Reviewed-by: Tianyou Li <tianyou.li@intel.com>
Reviewed-by: Wangyang Guo <wangyang.guo@intel.com>
---
 tools/perf/builtin-c2c.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 33271554e354..a924948bc507 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2693,6 +2693,7 @@ static int perf_c2c__hists_browse(struct hists *hists)
 	static const char help[] =
 	" d             Display cacheline details \n"
 	" ENTER         Toggle callchains (if present) \n"
+	" TAB           Switch to function view\n"
 	" q             Quit \n";
 
 	browser = perf_c2c_browser__new(hists);
@@ -2714,6 +2715,9 @@ static int perf_c2c__hists_browse(struct hists *hists)
 		case 'd':
 			perf_c2c__browse_cacheline(browser->he_selection);
 			break;
+		case '\t':
+			perf_c2c__browse_function_view(hists);
+			break;
 		case '?':
 			ui_browser__help_window(&browser->b, help);
 			break;
-- 
2.52.0

