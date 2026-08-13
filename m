Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AF0376A07
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 21:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786655481; cv=none; b=LlCqOG5Xugww6fmCrfLA3S7OBsSjU+Qi3+hJu8lSYnlbIQEurHK6Wt0qt1cQR8o3ltyjwY9R8wJdOSjJQc7p/4oVFWnlVyhByvfR4tA0mr25/LaMarSl0HyfS6Ha2/DzFeJ8JmnWhrkdjpZXgx+mm7OomDUMIAM5i2cK799r1lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786655481; c=relaxed/simple;
	bh=Wgz9ttw+P9cRA8Csd2hTJOvx98uIuT5zF8yBYalng/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SL/eqSLS92D5VBAELUUopfqtgW2ZUpDMhjHJErSDnxl2stFesLLmJnc0L7YKaGPmWLYgSfeYX5Q+WubKUzF4H+FEAxMRrMZX36nfb+J9XjfVvv9z62K9dy80zeXsjclAhluEEf0uJ7tVvCLF+7SwSUfDqy17EgW0bPUAa2IZ/UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H21kGkKu; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H21kGkKu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786655480; x=1818191480;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wgz9ttw+P9cRA8Csd2hTJOvx98uIuT5zF8yBYalng/Q=;
  b=H21kGkKu7eM8h61glDTTxwH05DcWdA7rfHBsbLSR6Es4VMHHm+s9FhI4
   5lUpD6kFuZY8VFr7nJQ6EFhLVc0IcTVimzU7dksXcXO7i6hsX1OPiwDT3
   82gMEgKKDoBxQ2cHF9+9JIQGHxcYEA+XAtWs05xEWNTyQ8um+d+8kf/5f
   SVzHG1Ib9EW2e/LnkolRNEkWuhWmB+K7Hwf6Dvi448JvkajgiTHcx1fAD
   FbXsVzKn4Y2C/Qmqr34JO59UfhowUOJC4WJKmgofVW3I49voFsy+5xHsx
   LBkleOHD7sWf2jLMiusB+Bkb4BqDl3+ZmtHNlGq3wAOXaRgXZwCIeW2GH
   w==;
X-CSE-ConnectionGUID: zpfPCXsuS+iQv5EhNWIaIA==
X-CSE-MsgGUID: GF3k+MckTJ2Xdulebygsog==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="89760245"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="89760245"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 14:11:17 -0700
X-CSE-ConnectionGUID: O516wzk+Q96fs8ZgdKkqxA==
X-CSE-MsgGUID: 0VXn+z/tRYqPVDGwQja96A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="260773089"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 14:11:16 -0700
From: Andi Kleen <ak@linux.intel.com>
To: namhyung@kernel.org
Cc: acme@kernel.org,
	linux-perf-users@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v2 2/4] perf tools top: Add --weight option
Date: Thu, 13 Aug 2026 14:10:08 -0700
Message-ID: <20260813211109.240689-3-ak@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813211109.240689-1-ak@linux.intel.com>
References: <20260813211109.240689-1-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a -W/--weight option to perf top to collect weights too. Useful with
follow on patches.

Assisted-by: omp:GPT-5.6-Luna
Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/Documentation/perf-top.txt | 6 ++++++
 tools/perf/builtin-top.c              | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index af3e4230c72f..2da2a16bbf26 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -25,6 +25,12 @@ OPTIONS
 --count=<count>::
 	Event period to sample.
 
+-W::
+--weight::
+Enable weighted sampling. One or more additional weights can be recorded per sample
+and can be displayed with the weight, weight2, weight3 and local_weight sort keys.
+Possible uses for weights are memory or instruction retirement latencies.
+
 -C <cpu-list>::
 --cpu=<cpu>::
 Monitor only on the list of CPUs provided. Multiple CPUs can be provided as a
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 570410599f1b..2888ac3b7b92 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1493,6 +1493,8 @@ int cmd_top(int argc, const char **argv)
 	OPT_CALLBACK(0, "filter", &top.evlist, "filter",
 		     "event filter", parse_filter),
 	OPT_U64('c', "count", &opts->user_interval, "event period to sample"),
+	OPT_BOOLEAN('W', "weight", &opts->sample_weight,
+		    "sample by weight (on special events only)"),
 	OPT_STRING('p', "pid", &target->pid, "pid",
 		    "profile events on existing process id"),
 	OPT_STRING('t', "tid", &target->tid, "tid",
-- 
2.55.0

