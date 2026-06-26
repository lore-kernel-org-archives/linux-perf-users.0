Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5936E3DCD94;
	Fri, 26 Jun 2026 07:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782457452; cv=none; b=qR4D3UqjczLV7hhSAljWOkqMiQxZfWxuWCkg6gBp03rX512UzR8XtdffZzezChpCswRFlROYqk5z/4FzqJRAZ12sByBlB3tm4rxTfqHFpoJyB9NbCWmyWTeup6hdmkAt2Jbnljy204NCeWx7CQbDvI/yor8Vl2OqRnDQ6mhy5gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782457452; c=relaxed/simple;
	bh=Ewfnh6yrSu/plgJzPF6dpQ01/Es2m2b+1MNzDAzcV6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eT9GYVYYwpsEmDsk8O+9uklBTR23ZhQC2J6U1oelV3AdlTwUp4fbA42I3MgTVgsCTd+QCD1cU9PgQdDT6e6dVtbxKJpaDLWjYR+h9870BeEHMOVkLNRxIIzpKI6nenK8uhMKwz8QuZuakwe/oyz7A3lg/PzVjrCzo5INMad3aMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kkU+hjRV; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kkU+hjRV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782457449; x=1813993449;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ewfnh6yrSu/plgJzPF6dpQ01/Es2m2b+1MNzDAzcV6s=;
  b=kkU+hjRVH62Pg+RpuXtj1DArUvzOW2EucOd8TuAcyenO2Uvq1mNTmZt8
   p7ABcWxwk14/hY7nJV+tTT2bdnTJtrHJ57HZMwyjKr5M3/WnQwendWJrj
   RFlOHAhVZrYoYWaW0odrfJiYfEbyJY9I4lUBz1IYF6LZOZUe7L6YUPi1B
   na5QQXKJDLU6qp+qVcQ/3ClaoilNeT+vCcmpsT+ATQTScFActAEgAtV+0
   rBcjhQoCUjhJmMRtPNqeDYHlrtlhH11M3Z45bzp86Zla+85JYJotVR7ua
   hNOEPKnuWwYe3t33G26B2y9XZosTSDJgmvKugYluCmakUkbjnxRI2BDfp
   Q==;
X-CSE-ConnectionGUID: oLxH6W/6SuSjW8nFLOmTdQ==
X-CSE-MsgGUID: SwXFIpLdQ0GoHi49L5w36g==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="94397477"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="94397477"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 00:04:09 -0700
X-CSE-ConnectionGUID: kQG6woNSQ4i1HVsWqks0TQ==
X-CSE-MsgGUID: 96kAP2OtSluz7Wwmaaasqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="247893591"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by fmviesa007.fm.intel.com with ESMTP; 26 Jun 2026 00:04:04 -0700
From: Jiebin Sun <jiebin.sun@intel.com>
To: Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Tianyou Li <tianyou.li@intel.com>,
	Wangyang Guo <wangyang.guo@intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiebin Sun <jiebin.sun@intel.com>
Subject: [PATCH 13/14] perf c2c: add TAB key to switch to function view
Date: Fri, 26 Jun 2026 15:03:54 +0800
Message-ID: <20260626070355.1556721-14-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260626070355.1556721-1-jiebin.sun@intel.com>
References: <20260626070355.1556721-1-jiebin.sun@intel.com>
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

