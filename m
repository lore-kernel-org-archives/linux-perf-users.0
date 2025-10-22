Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225C52FB0A4;
	Wed, 22 Oct 2025 22:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761171272; cv=none; b=HHmQILsJF/7YQwXe3xbktwrTHXidYiPQ8WMx57sBOWQ1e/QsnEruIaGkrTbEPEVJxE9UXJxVh2cAGMmoZ+GBC9+jds9MWTAxr911S9UclObu35ndRzxESp5PWziPM4D5bljlN7b++L4/3b6X96RzSTkA3syTGtWmh3jCYQLNWdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761171272; c=relaxed/simple;
	bh=M7JNCkBzWiAR2xNNK2WourqTZyvlf3fBBzC0e2GerT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RJSMKT0Vw/1hGLZCmpfZF/SLB40i+OIcpkAtyPCt/nJKRYNy5/8EoHU61maEmTTAe3k6//qxhq4Lslb1Ka/d2RNgfc7mt72qA6U/K0UYkFSSGTgOYLs9GYnz5o2Jp92nlv2tX9eyXI1v1Hm3uLOxq3r/UnBxX79gBLJ11s6Sy6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MJOChMm3; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MJOChMm3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761171271; x=1792707271;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=M7JNCkBzWiAR2xNNK2WourqTZyvlf3fBBzC0e2GerT4=;
  b=MJOChMm3dmq3xh3zqDrKEVDONutDMRfwIGHJ0kHT3elTHfIzU3dcyRmA
   WfHZv1H9Q9+0XtXrPfLj9lYaYv79Wa7dH8S3oPdhWPOnDVUXrfWl9e1MC
   QnPkOy8A++1ruyVlCylv/1ZWzGajZCzxaSCBaYAvJr3xKRBWOxwD193pq
   QzWHIEC4dNoKDlcxanHalE12zhqwoH9mRYonIuHh8lCdYp3JXjmDYfWT+
   D2bQFSZQ63tv7wgun+0bOIPsA23WNZAXaGOc/+I+rB8r4akpv3t5PAZdA
   QcUT3PsQVnkCwRvvOSDDeY4o9FCg7V9Xn+AdP4ebMc5PuYAOn4eH8mmGV
   w==;
X-CSE-ConnectionGUID: 4dOtSecYStGvMxqT0me/Tg==
X-CSE-MsgGUID: K44LM05tR7eYfx0wT3oXeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63369220"
X-IronPort-AV: E=Sophos;i="6.19,248,1754982000"; 
   d="scan'208";a="63369220"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 15:14:30 -0700
X-CSE-ConnectionGUID: pl5F504CSbCpcmn0bV50Sw==
X-CSE-MsgGUID: X8wysPAnSeadWwulB41ohA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,248,1754982000"; 
   d="scan'208";a="184043752"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 15:14:30 -0700
From: Zide Chen <zide.chen@intel.com>
To: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	thomas.falcon@intel.com,
	dapeng1.mi@linux.intel.com,
	xudong.hao@intel.com,
	Zide Chen <zide.chen@intel.com>
Subject: [PATCH] perf tools: Refactor precise_ip fallback logic
Date: Wed, 22 Oct 2025 15:08:02 -0700
Message-ID: <20251022220802.1335131-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit c33aea446bf555ab ("perf tools: Fix precise_ip fallback logic")
unconditionally called the precise_ip fallback and moved it after the
missing-feature checks so that it could handle EINVAL as well.

However, this introduced an issue: after disabling missing features,
the event could fail to open, which makes the subsequent precise_ip
fallback useless since it will always fail.

For example, run the following command on Intel SPR:

$ perf record -e '{cpu/mem-loads-aux/S,cpu/mem-loads,ldlat=3/PS}' -- ls

Opening the event "cpu/mem-loads,ldlat=3/PS" returns EINVAL when
precise_ip == 3. It then sets attr.inherit = false, which triggers a
kernel check failure since it doesn't match the group leader's inherit
attribute. As a result, it continues to fail even after precise_ip is
reduced.

By moving the precise_ip fallback earlier, this issue is resolved, as
well as the kernel test robot report mentioned in commit
c33aea446bf555ab.

No negative side effects are expected, because the precise_ip level is
restored by evsel__precise_ip_fallback() if the fallback does not help.

This also aligns with commit 2b70702917337a8d ("perf tools: Remove
evsel__handle_error_quirks()").

Fixes: af954f76eea56453 ("perf tools: Check fallback error and order")
Fixes: c33aea446bf555ab ("perf tools: Fix precise_ip fallback logic")
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 tools/perf/util/evsel.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ca74514c8707..6ce32533a213 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2714,12 +2714,12 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	if (err == -EMFILE && rlimit__increase_nofile(&set_rlimit))
 		goto retry_open;
 
+	if (evsel__precise_ip_fallback(evsel))
+		goto retry_open;
+
 	if (err == -EINVAL && evsel__detect_missing_features(evsel, cpu))
 		goto fallback_missing_features;
 
-	if (evsel__precise_ip_fallback(evsel))
-		goto retry_open;
-
 out_close:
 	if (err)
 		threads->err_thread = thread;
-- 
2.51.0

