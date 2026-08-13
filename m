Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671E546EF65
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 21:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786655480; cv=none; b=Zm7556BQPOCK+2VEHYWhw0XNTQ9ca9OPdNUwcCx6naycDfeBqEH5sFhOt9e1JfdNn0iKrRsHBoWhOsiOZo9LsaXzXkTaRSavMLMig7DoKfBcH56QJbR9twD5m19WNPT7lBfNuJU2kSI58f5qb00krvRRt3eSuL7bMedVg68lA/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786655480; c=relaxed/simple;
	bh=fEgXKovIZOW4WfqZh+snAL8qnNOxXFUCVlAbVCbteOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AbWrZhvJZASCmSzZwM9GT0EQY+jY3ot5+2GK1ltECHctNVzxK9gPdyQShDMU4bM82BxJB4YyNcxWZNLggG00mwswvBYWFp41P0jLYiXmGuyxi/ugyKyTEmO787Lpnz/jN26czf+HlDmGkYrHmjr+yWpRcZ60ijBG0UMT5aCTpbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hl2XrQ7A; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hl2XrQ7A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786655479; x=1818191479;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fEgXKovIZOW4WfqZh+snAL8qnNOxXFUCVlAbVCbteOk=;
  b=Hl2XrQ7AX4rcSLO/H9k3em3PB1LsPcxl6jKapYOl+NxUTXNeCKr+UL2P
   q66Sekgwg+ZYq9N/uZC0QA7wcY35bxMJm4bvrkgKM3xm2by2/NRf6WJSD
   ZqgJYql2MjkAdYUiR32OxHxjjI03NDjOOe2b4al6vlqEURqB/7wHmpHQI
   8sA4BAti4ECtVspvbV7Un1/DrRgVWiI0nlP94UOLylkVuCXxavXf4hEIK
   n/PJ4tUFt7vyHqaNvCVdMjyTpsfGPkOmd77ssKI+zs+kYVapYIvaX0iU9
   jGVl+O3cnh/bSseW1iamOTxZCekjtDOVrY4gadC3v8TBz7uJ6FFzLwId/
   w==;
X-CSE-ConnectionGUID: A5jKuPJxQ9GkEzRO6xiPXA==
X-CSE-MsgGUID: 4C5SuOTvTV2SNz6vzihKSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="89760243"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="89760243"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 14:11:17 -0700
X-CSE-ConnectionGUID: uPd4gap1SRqDBtcFGdyYaA==
X-CSE-MsgGUID: +nIqKM0xQpiTSMwCWsWz1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="260773087"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 14:11:16 -0700
From: Andi Kleen <ak@linux.intel.com>
To: namhyung@kernel.org
Cc: acme@kernel.org,
	linux-perf-users@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v2 1/4] perf tools record: Modernize -W man page
Date: Thu, 13 Aug 2026 14:10:07 -0700
Message-ID: <20260813211109.240689-2-ak@linux.intel.com>
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

