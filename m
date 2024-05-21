Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0F11482FD;
	Tue, 21 May 2024 17:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716313200; cv=none; b=OX3i1jkVgnZ8YPxP2qIWy5BUDp5kbMyod8mN03GUDG/du1NXjShRPTqq/98n5XSf6qPAkAi7ki1DjbSYupNSCdPRua2j0wspVhhP1e0WG+EZvjOG0N6P1jhzYsGja10RtzB9QqjNZuIzqm6HIJOYbh6iAlex72PjUUihhwcYD/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716313200; c=relaxed/simple;
	bh=7qISfX8pQXnp5VsCsVfGRRlPI2rRCjiR3HDByhARypk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jFwmJRtlE6fzw6wn9yaxu76hU2Qn3nmlSuW6ndyWrCCMrvZyjC2XXcTFqkc8bKix/iHX0DbrsTlFfWO5nAANSUFj9vtJkbA1gvSiKQa05hoXwljrc6jl+i7jJkHmYgnbjAEdgry0EMbhK7XKl5s0Jh+UNV/CS9MgZJnKrKokLhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XBIN5fdu; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XBIN5fdu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716313199; x=1747849199;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7qISfX8pQXnp5VsCsVfGRRlPI2rRCjiR3HDByhARypk=;
  b=XBIN5fdu2obJ0CcMru1NdpEypALFDXqaiVDxQYMibl3GXtv2vwGD5+pD
   w+HQ3/kbg0YlQ8IIIejdZmUT816oecbaeC5YZnwdf29gPUK8Ay+3Skuhh
   aawJbcKOyMhMiAuGFC2weMkR2og+spkVFsB3I6WaHbr06aNRntNQk0i51
   MCHSIcW9ME3BP6TF/96FUOfMwX/QcrgXk1UX/O0YNnxr8c8b+BuNHTCGD
   0d/MuefrrXuOSM2niUnrrdXehNQoWTiEphHjy87YSnjl2CR9SvUiK6HWN
   btavXXswT/u5Q90Vz2/PUjIuOMVz8MCS4F84Spzl52ZXLqQCEizkG6Eab
   w==;
X-CSE-ConnectionGUID: FtyMIl8GTyiz9cP2dXWDjw==
X-CSE-MsgGUID: mhcpHtjiQ0e8FLtW5GGXwg==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="12317651"
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="12317651"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 10:39:57 -0700
X-CSE-ConnectionGUID: /8yrsMx0QWK5yArBIM8nDw==
X-CSE-MsgGUID: teC3IRU4RwemBZuybC0lMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="32924951"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by fmviesa007.fm.intel.com with ESMTP; 21 May 2024 10:39:57 -0700
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
Subject: [RFC PATCH v9 2/7] perf data: Allow to use given fd in data->file.fd
Date: Tue, 21 May 2024 13:39:30 -0400
Message-ID: <20240521173952.3397644-3-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240521173952.3397644-1-weilin.wang@intel.com>
References: <20240521173952.3397644-1-weilin.wang@intel.com>
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
Reviewed-by: Ian Rogers <irogers@google.com>
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

