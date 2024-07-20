Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C33810A01;
	Sat, 20 Jul 2024 06:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721456472; cv=none; b=Uf16HNW3Ss8MdihTL34kzt6srERiGQTG92ufb17ftlq9s2mCuzybOEbBxFVDR8cgVOOpE0lV1gs5m7TrzuSz9UG9Je+qtFZ1y6F3YJNmpTqhItCDbAuefePO8bnVH7pPlCZVNWm35UZ3zBc1PCjPLBga6Jt5rHc+bAv60KLcOWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721456472; c=relaxed/simple;
	bh=El3YDeqjczhekPR1W+uyDSK2dsNIh5KkIWwOCQU6c88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LcDLIDgLE7svpcQVF8PceX1EWep0InLPzYrwInf+R8BKwzSuiF10BdoV+cRGh+zYmGeG9qHAkrXq3NrWzyWB1r+kgGXOKhHvOX34C90vwQSpw8RtC0tfflseUJbMTlG1Y1mGzRoGpOoRsy1QXznQggt/OWrSKMEcu3bW8wYYRCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CuKlo13J; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CuKlo13J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721456471; x=1752992471;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=El3YDeqjczhekPR1W+uyDSK2dsNIh5KkIWwOCQU6c88=;
  b=CuKlo13JAAVLK31z03QFCYdCtj+zfgtudKCKNiPjIURprrga/lhj5Iq3
   +TA0HjOVOcx3zso+6fRk1du6daaHdqAH811L6AHWv8ooFNsRsWNlRRbDH
   N/5+ucvIRWBm8X5uKNPiCKHjqUQZXSMdWTvt4Dk31W6UOC477f7tCixmV
   Vabuz3qFQzXIUb77A7oYFViKeNgTBM5z6DEkjRv3MF6ffr9L6yOKnQj68
   GSKQDgNKEv/u6ex0lS4DTLuPmunzz9TvE92dKXZgoE/iwU2KAVcjU5SGp
   CJpIP1dmT57rWZrO8JqQtrULrfaIGqWVhg51Y/VYHVWu6M+FJGZ7MBCW8
   g==;
X-CSE-ConnectionGUID: yjb25MEqTQe4tlF4wGQKnA==
X-CSE-MsgGUID: QLs/cySOSsOMNqCFElaIYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11138"; a="12630478"
X-IronPort-AV: E=Sophos;i="6.09,222,1716274800"; 
   d="scan'208";a="12630478"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 23:21:09 -0700
X-CSE-ConnectionGUID: 4lSa4TUxQNynSAvoUqLsiQ==
X-CSE-MsgGUID: vjkv0QB2Q5qzDrX705+O1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,222,1716274800"; 
   d="scan'208";a="51403579"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by fmviesa010.fm.intel.com with ESMTP; 19 Jul 2024 23:21:08 -0700
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
Subject: [RFC PATCH v18 2/8] perf data: Allow to use given fd in data->file.fd
Date: Sat, 20 Jul 2024 02:20:55 -0400
Message-ID: <20240720062102.444578-3-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240720062102.444578-1-weilin.wang@intel.com>
References: <20240720062102.444578-1-weilin.wang@intel.com>
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

