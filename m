Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F038015FCF2;
	Wed, 29 May 2024 06:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716965018; cv=none; b=VnUQgBSSCA4XNY+yH3h2X3/7FYx5KUdjLCTmVvIvQIPG02QEvjVcIdkJ5ErqvTWWt6Npm+RJ9+nhaYClJW5Sn8hwa0MVL7nx5M5kM0t06L01iZ/lXMyoz0GeIjOGvl4Dc3h0ixIXblDJNeEKm9zuLOw4vXj9LTd6jSlyZekDyqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716965018; c=relaxed/simple;
	bh=El3YDeqjczhekPR1W+uyDSK2dsNIh5KkIWwOCQU6c88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DQbKETVJfWDM+hNXLe1ub5wBC2QxSm11D9+J2DcK69IBbPcB7rOZLnM3x3BBD+ou5x7CRAUQmIBCoE6Aj75j+DhSN615eSj8YwwC03Psrx2StwgeuJDubZ7EqvzFHKqgAY5NJ0AR6PG6ViTibVt/YSsOwCx5W1hXViY4yuP9Gek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YXI1EMXY; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YXI1EMXY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716965017; x=1748501017;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=El3YDeqjczhekPR1W+uyDSK2dsNIh5KkIWwOCQU6c88=;
  b=YXI1EMXYOcQbilH9zYUZ0mGUdprAm7vCKXEibCip3zPKrGATc06mlBl1
   kuQ7GXsAVbKkQJUJZTTAbyxKnEayrk50NB8FbFi+GIutxApw1dZx9BIhr
   keSk2oU96S6EKslzXIunae8h9sxTx5HXeT0jsVZcbQ/PXK5kSKTMGc0eB
   t2fCOzgA1V+xVT88O3JZWckAQta4cp0iF0OrVh9ekz/T00uiXrZO+Lxhg
   HPh6sx3J/WcZFNE0tO1CGrIED2P/cciFf22v+rNoAZP7psbXFBPZskMln
   3ql731icMvnVVKr1J7VLUXX8kzc8Py2UKMqJe2Rou/5NRZROVkeXCss4+
   g==;
X-CSE-ConnectionGUID: 217vS8sQS0mNBNDcG8WfYQ==
X-CSE-MsgGUID: 81v9E6gKSdShM5wP+Z2fWg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="16297986"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="16297986"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 23:43:35 -0700
X-CSE-ConnectionGUID: 9QiraeXmTPKOYrvmOit7UA==
X-CSE-MsgGUID: NlvS2dNQQhiP0+TOe+wGtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="39759266"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by fmviesa005.fm.intel.com with ESMTP; 28 May 2024 23:43:34 -0700
From: weilin.wang@intel.com
To: weilin.wang@intel.com,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>
Subject: [RFC PATCH v10 2/8] perf data: Allow to use given fd in data->file.fd
Date: Wed, 29 May 2024 02:43:18 -0400
Message-ID: <20240529064327.4080674-3-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240529064327.4080674-1-weilin.wang@intel.com>
References: <20240529064327.4080674-1-weilin.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weilin Wang <weilin.wang@intel.com>

When in PIPE mode, allow to use fd dynamically opened and asigned to
data->file.fd instead of STDIN_FILENO or STDOUT_FILENO.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/util/data.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 08c4bfbd817f..98661ede2a73 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -204,7 +204,12 @@ static bool check_pipe(struct perf_data *data)
 				data->file.fd = fd;
 				data->use_stdio = false;
 			}
-		} else {
+
+		/*
+		 * When is_pipe and data->file.fd is given, use given fd
+		 * instead of STDIN_FILENO or STDOUT_FILENO
+		 */
+		} else if (data->file.fd <= 0) {
 			data->file.fd = fd;
 		}
 	}
-- 
2.43.0

