Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00463354AFF;
	Mon, 20 Oct 2025 06:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760941884; cv=none; b=hjzSkOFLeTK6OhOKI7w/adlmuuHD51Dl2TVeyD095G/CmVeznM1NeqRFyukoOwfW3a/kWp3zOHxD4ppKet6arGE7nD1DJBDxT3NFM+sqHeXa+lh2Ids64xZMmbhDlbX5TSVM5LTk7AiiEOoaAxdJMBvbTmQQENsvC0/aKhi+Jp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760941884; c=relaxed/simple;
	bh=qyBM+Jnm2MByZNlMcaSbOGK+smc1LK7AJ8Z/c/XczKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bWL3TdKdI6baafwNH1XYdL1R2Oui9BeBbdS45uiZPEftVDp9BoW2T/5pmi1MTfxNDapqv92ms7+VfMMrutZI41WmI/8wGJLv4oMmRrXd5PFHy41Cm10vlxRUadjlCQzYjaURUGz+uwUGnsyJj4FBitJRkG59/7nT792ZqAhSGnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jXq+JoGb; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jXq+JoGb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760941883; x=1792477883;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qyBM+Jnm2MByZNlMcaSbOGK+smc1LK7AJ8Z/c/XczKk=;
  b=jXq+JoGbM4qasURUdhZZqQKmBOVohCNrxRHzLdaSILtIEfXqNZpvfugV
   UW6mGlRRx2XPIK05QYW6cvEOmq1E9WlaagBZFfK+iKxhmlatFRNjAuGce
   XSo8RlmYyh2yD8Ybp00SHKx+ws+43Zy6p0m1BMPBLqpggPbgmkT+YglVU
   pbD6hM8xI1hxBX7FrmlPgFKAORFOpMOXAL2pSOTHn1LrP/3J5DjUse6X9
   1EpeOa+0/lJHY6JNuk8jsr5dUV6mgFFWodiUGjdjojtErCbsaPBY2nq7b
   J7UDpZELTVfPEof0vrF3y/7vCiivYDsUzvvKyAeAqw13Z9DKoi1JnhENP
   A==;
X-CSE-ConnectionGUID: o/I8tuvbQgWGVEk5wRrx9Q==
X-CSE-MsgGUID: hyDFc+XPSZmOto2pRl3FqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62960738"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62960738"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 23:31:23 -0700
X-CSE-ConnectionGUID: gmNbTvdvRl277lUk5eP00Q==
X-CSE-MsgGUID: 9S5I2fMfTiiSARJ41lMXrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="188550815"
Received: from linux-pnp-server-27.sh.intel.com ([10.239.147.41])
  by fmviesa004.fm.intel.com with ESMTP; 19 Oct 2025 23:31:18 -0700
From: Tianyou Li <tianyou.li@intel.com>
To: Namhyung Kim <namhyung@kernel.org>,
	James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
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
Subject: [PATCH v4 2/2] perf tools annotate: Align the symbol_annotate return code
Date: Mon, 20 Oct 2025 15:30:05 +0800
Message-ID: <20251020073005.957524-2-tianyou.li@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <aPW2iiNeheOxDGw8@google.com>
References: <aPW2iiNeheOxDGw8@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Return error code from the symbol_annotate previously checks the
evsel__get_arch from '<0', now to '!=0'.

Suggested-by: James Clark <james.clark@linaro.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Tianyou Li <tianyou.li@intel.com>
---
 tools/perf/util/annotate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 39d6594850f1..859e802a1e5e 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1021,7 +1021,7 @@ int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
 	int err, nr;
 
 	err = evsel__get_arch(evsel, &arch);
-	if (err < 0)
+	if (err)
 		return err;
 
 	if (parch)
-- 
2.47.1

