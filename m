Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673D4331202;
	Fri, 17 Jul 2026 02:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784253982; cv=none; b=OpxCy2e8Ssn5WVh3GuQf4NkOxxKZcBMwiEjx6E8BM/g3QluwzAUftFNJsBjfZe481hTrMD7wzDNpu3C8mRa+4iUJdnRMrqiOkb1temD4PnxoccCDmOjZrtrSny1B5YsETB84hqZYUe0lSvIihgNO5guMrAKud00ENj7XlNAGUAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784253982; c=relaxed/simple;
	bh=VxumeM2X7wfXjXb2RbnqOV4BcLwA9OBmfvijtV5OWDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FOBTL1vBxZOFVA59HCwhSAWj57K/mhhnNboCQBxoHBE35sOtN/v50KM1kVesUbKG6459pudblUK72VGD96wxYxJ78+mp8owkI0Uh3SdWVeuCFD+8HFwnOc2SObXuxMJXKovTDD5NpRTMhX+EVpzplRr+I2RMxHAjbYIOFq7lysw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F0jctI0V; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F0jctI0V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784253981; x=1815789981;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VxumeM2X7wfXjXb2RbnqOV4BcLwA9OBmfvijtV5OWDE=;
  b=F0jctI0Vta6UhdY9AL4r2m+PjcHTbc9CZKBZTx8MdaiTlhqzMpgyc4uk
   zCJYTH3j5LX+3KWjbXsHNKudGYB/K9Wq+PHxtgwdOhfhugIpAeLQEdRFJ
   Mp/r2JFV+eDOqs1S3NR1A66XPM22L4WYiEhFa0iQRzVq/xHc/4XebGbLu
   pKeNd1bYD2WR5ZHA7oO8ASy8l8f+/uy/6hftmzbFZClFSqLpD9XXHS2V6
   Ag8Z9I3rZndaE0gqACsuzCxh9zM3B0MyF2o1S54U60EXDwE8bF65T8XMA
   BWihHeacLJe6hK2E8Zt4EzJDMIe+B/ySY6mFuCCKShZ7mhreb13sbWDYP
   g==;
X-CSE-ConnectionGUID: kHhTLARhQh2Hl56c9Bj9oA==
X-CSE-MsgGUID: IstgLpx5T/ir3gpis2Wd0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="107720103"
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="107720103"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 19:06:21 -0700
X-CSE-ConnectionGUID: c53pXVr3QKiPBKTgu8lCzg==
X-CSE-MsgGUID: zfcB7oceTZ2Zuzqo6nKQYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="279952890"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by fmviesa002.fm.intel.com with ESMTP; 16 Jul 2026 19:06:16 -0700
From: Jiebin Sun <jiebin.sun@intel.com>
To: namhyung@kernel.org,
	acme@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	tianyou.li@intel.com,
	wangyang.guo@intel.com,
	dapeng1.mi@linux.intel.com,
	thomas.falcon@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiebin Sun <jiebin.sun@intel.com>
Subject: [PATCH v3 13/14] perf c2c: add TAB key to switch to function view
Date: Fri, 17 Jul 2026 10:05:29 +0800
Message-ID: <20260717020530.1645123-14-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260717020530.1645123-1-jiebin.sun@intel.com>
References: <20260710084247.3576706-1-jiebin.sun@intel.com>
 <20260717020530.1645123-1-jiebin.sun@intel.com>
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
index f1dd9d8699cb..23c58eba415a 100644
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

