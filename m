Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DAF303CAB
	for <linux-perf-users@vger.kernel.org>; Sun, 30 Aug 2026 19:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788118513; cv=none; b=m6suJ6elI7KbWZO1efRPD9wYVoEjCa7hpfU/FocRGqOXnDljeKXk1/900Z0JK+1JJ8x4iA2mD8PMnydKHIqFhqRYPHnMAcA0/CkCgjGsl9wyY9Jmtl+5wyKS4rs5/Ak7C5eZ1X43BfHx4W2uFGLWRbjdQL/hukmZIewvXdUnBuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788118513; c=relaxed/simple;
	bh=fEgXKovIZOW4WfqZh+snAL8qnNOxXFUCVlAbVCbteOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M3H5N1WFx+7DJEGeZSlzi1pO/YD5RVLTg1u/zfGM+RM7XjWA0oT0cPKvZAhF8qYA7gWIzKBXdDlJBDREVj3DAjB7kIJwEGfWGjyTBSxj/jZPtNwhm0xdu5tOMe0lIFpCUKbzETZ/jCIXj6ALV48V2cjLVnYffLpFV6WA76aGjVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PqCoDBLv; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PqCoDBLv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788118512; x=1819654512;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fEgXKovIZOW4WfqZh+snAL8qnNOxXFUCVlAbVCbteOk=;
  b=PqCoDBLvHhBg3t35gdPid7UNoIHmC64feAvq7SNd+Z4cjYkBYzy2rRiQ
   YS7zjP4sibQ2u+OOVObJqQ/bWBw3EcSt1Gbjx0FoHOEGn5GdF3BDv1dUb
   cRC93+HuywEoneYkUVpmoG5PxXg97CnmYLKUQOATrUVXpzhbFnZVszAlv
   YZxa15egMwf/W7p4JdrhuhZBpmfYuGe9qMQDbn/bxdFt2Zgkcd08WIVyr
   /AB7KwvNIb9SUIks6xZ4bGHMc2uNmyvoQPwbdhLZaOqunlOY1R7k5xSPK
   DPWKEuV3u/je/Nc3vhegLOcHZ5E9mYNDTY/FTY/dRmqPRbbk8vLYNpnE9
   w==;
X-CSE-ConnectionGUID: NKcJavD+T7WQiZHNFDT6pQ==
X-CSE-MsgGUID: s+r+VWrhQHKFg2xltY5Ayg==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="87667334"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="87667334"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 12:35:08 -0700
X-CSE-ConnectionGUID: 0CL2SOo2Q7+9JJGvmz2FjQ==
X-CSE-MsgGUID: akVXaDPqS9qg/p+KdUiIuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="292118654"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 12:35:07 -0700
From: Andi Kleen <ak@linux.intel.com>
To: namhyung@kernel.org
Cc: acme@kernel.org,
	linux-perf-users@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v5 1/4] perf tools record: Modernize -W man page
Date: Sun, 30 Aug 2026 12:34:37 -0700
Message-ID: <20260830193459.2840519-2-ak@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260830193459.2840519-1-ak@linux.intel.com>
References: <20260830193459.2840519-1-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modernize the -W / --weight description in the manpage to cover more
cases that are supported now.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/Documentation/perf-record.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 178f483140ed..2c6510c5a87b 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -480,9 +480,11 @@ Note that this feature may not be available on all processors.
 
 -W::
 --weight::
-Enable weightened sampling. An additional weight is recorded per sample and can be
-displayed with the weight and local_weight sort keys.  This currently works for TSX
-abort events and some memory events in precise mode on modern Intel CPUs.
+Enable weighted sampling. One or more additional weights can be recorded per sample
+and can be displayed with the weight, weight2, weight3 and local_weight sort keys.
+Possible uses for weights are memory or instruction retirement latencies.
+Support depends on the PMU and the event, as well as its configuration. Typically
+it requires use of 'p'.
 
 --namespaces::
 Record events of type PERF_RECORD_NAMESPACES.  This enables 'cgroup_id' sort key.
-- 
2.55.0

