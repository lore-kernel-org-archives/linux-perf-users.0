Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925433955D8
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 13:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786627764; cv=none; b=BokWQso/gig4sgjWCcXzS7hxmWhRPt7ZRPJByJrsu3xAV29QFFtkbxt9qwRZ4gxOsYeOmvgp4KObxjG6WJEm5ksejerPM8OkB3dooe5Ch1zj5Y/FKvYKta/cwLz5egALRB4TWTnH2n4D5tYLAvBK5w+5yEv0lGh5K0CgM0hfg8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786627764; c=relaxed/simple;
	bh=pRonUDAgZxdAZwTTX2/I4+5tzTb+ref34JeEVupa7Yw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QywcKqN7zR2wS1BFfzZxg8ADuqPfMuLgaCQScbskyFsLzFAkFznpwBG/26WEUTpAprhbZ2w3RuIETkj5fJCfEjYPIg9SuD3iMXBvkn5R/3RtxxkTKoDD7Vjpvw0Jqycu2eBX79c2/09H9uozm63feISK2vcam4LJC9kJMs/+fik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WU+UWM9S; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WU+UWM9S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786627763; x=1818163763;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pRonUDAgZxdAZwTTX2/I4+5tzTb+ref34JeEVupa7Yw=;
  b=WU+UWM9SFoc8v1AK+h0GsFt4ZH7KdPU9uJWoH/eA1efVvHRqmxBOlLyT
   zjvI6jQVFI3eA/iFAr9l8sfKlsWt50f1NHHgzwqn80Cxd2gNvHA1eis//
   ZxeCsV5b46ztHFOSuKwYkbYsKZwaCVKjwf/49zVtmthkGWu391/gfApSv
   qA/N2k19Q8vwVCBIMwXIbIEAuMdMSgMoezgXG2LqjxSNC0+3au0HJdsUz
   TGvq1VJqOiXR72/+AgX+r7iqWcaESLsL2vjQK1uqQgwnip4auNucHXjYk
   783geL6kB1iB70/uqp4GWQg8JHfHA+d7U8YcU47ZGOduyIxJ7uyAk3Jtx
   Q==;
X-CSE-ConnectionGUID: +KIGjdkUQbeQpS3g/9sy0g==
X-CSE-MsgGUID: 4hREoclRSxWnInKW0gblVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="89720102"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="89720102"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 06:29:23 -0700
X-CSE-ConnectionGUID: LIDSOHSvQSm4uYv6xky2yQ==
X-CSE-MsgGUID: 6S9RzpxMTZq6PWnR/Jlpeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="267455268"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 06:29:23 -0700
From: Andi Kleen <ak@linux.intel.com>
To: namhyung@kernel.org
Cc: acme@kernel.org,
	linux-perf-users@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v1 1/4] perf tools record: Modernize -W man page
Date: Thu, 13 Aug 2026 06:29:04 -0700
Message-ID: <20260813132907.50738-1-ak@linux.intel.com>
X-Mailer: git-send-email 2.55.0
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
index 178f483140ed..faf6a4419f23 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -480,9 +480,11 @@ Note that this feature may not be available on all processors.
 
 -W::
 --weight::
-Enable weightened sampling. An additional weight is recorded per sample and can be
-displayed with the weight and local_weight sort keys.  This currently works for TSX
-abort events and some memory events in precise mode on modern Intel CPUs.
+Enable weightened sampling. One or more additional weights can be recorded per sample
+and can be displayed with the weight, weight2, weight3  and local_weight sort keys.
+Possible uses for weights are memory or instruction retirement latencies.
+Support depends on the PMU and the event, as well as its configuration. Typically
+it requires use of 'p'.
 
 --namespaces::
 Record events of type PERF_RECORD_NAMESPACES.  This enables 'cgroup_id' sort key.
-- 
2.55.0

