Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE48113AD0A;
	Wed,  5 Jun 2024 05:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717564935; cv=none; b=u4XKqHFHZ8rvIo3jXW7qkrlmFNIPKyjLaxTNInPE1d285WjEfuFH/YTU1NdPm8UFy+rpKcMjkAX02OD6x2M2RqF5mCOCMWO9/BtZM+qbJbXjcOaQMRIr73YjeNe3JZIaptABkcNZxXY/uyZFPAGH/Z8jh7gZLbseE4dSnfJqGz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717564935; c=relaxed/simple;
	bh=El3YDeqjczhekPR1W+uyDSK2dsNIh5KkIWwOCQU6c88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZQvxPqJ5YApb/6wDkn2uwyhuog9IkkCmZQ62GL7O3Sv1HAPpq3z8MmPWu/DA6AU0OLbXvrQc99/bUgKx0tVz+DmjGUU6MFTP571u/FMwISwD0IwT0ZXxq1INRi/Hj/HMX1J60fJFppkViZT9acaJe0rjHp4G88+TQKqJ9GCHnQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WE73wZcT; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WE73wZcT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717564934; x=1749100934;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=El3YDeqjczhekPR1W+uyDSK2dsNIh5KkIWwOCQU6c88=;
  b=WE73wZcTyYiKoSJ75CNrqTlWdht1hd9fitNQV+Zlc+rUo6yxPub3kAGO
   iYa080SN6BZA4hvNQpE7464kKuemo8zaSQyoVDz8Nlc2I7WD3yqVFviEc
   pOCPXDuEecpML4bEW37K/LjWZct9E64b/Frh0MW+svlVR0K730Cpi306A
   Iu1S0/0eLv5BmV3zc+gABJPCj9bOH/pDQgSuaKpJZ2jT1PnVeAq4H5Ly7
   C6DdA9yAb/jP11QWDp/QS7elSjVCB6E8U+8aTYmLdtauVX7XwS3vva0J5
   DslRw0V/lJw1U8+Q+34VT6sQx2fRcw9KPns3zCfbCtC1tsXnJdwb2xE5p
   A==;
X-CSE-ConnectionGUID: lyaRyq+/RduShXdz3sZB4A==
X-CSE-MsgGUID: +Dex+yYBSXGeSoIPWYKD/Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="25258794"
X-IronPort-AV: E=Sophos;i="6.08,215,1712646000"; 
   d="scan'208";a="25258794"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 22:22:11 -0700
X-CSE-ConnectionGUID: SNp05dP1Q+aaNtUzrvNe9w==
X-CSE-MsgGUID: kqMQYeOnR+yDmtfaysABew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,215,1712646000"; 
   d="scan'208";a="37525731"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by orviesa009.jf.intel.com with ESMTP; 04 Jun 2024 22:22:11 -0700
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
Subject: [RFC PATCH v11 2/8] perf data: Allow to use given fd in data->file.fd
Date: Wed,  5 Jun 2024 01:21:43 -0400
Message-ID: <20240605052200.4143205-3-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605052200.4143205-1-weilin.wang@intel.com>
References: <20240605052200.4143205-1-weilin.wang@intel.com>
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

