Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768AB381EA4
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Aug 2026 23:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787094160; cv=none; b=sZ96y3s/HYVDeO3FIgGlN0j5zRhixL2nnC5JiX65ovNs8oq0Un8GXBFT14Q06tOdNgMjkUOP5U8HvRo8K0JNFljQiZh0uhDSwB8jUm5Ox8R2cOCsq5HOUKsNzxsW1P6emH4lSgjF80VGFsjwlt7zR5RwwN42wQhtz5YNwUdlr2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787094160; c=relaxed/simple;
	bh=fEgXKovIZOW4WfqZh+snAL8qnNOxXFUCVlAbVCbteOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kBvrof4E65lgbCNNEDj+bhQnqAqlQdhmyaFfIzpS1KfZGgiiRhk3noIAd/imUnBouuVcpP3iISqlnbJF/lBTEdbkO+9sLc5qadeReVpZIxmaI15tB4zd0LKXaHKTRRCukxVBW4R+iW5Vps/RPBd0P/lz53yJxiOjOMAoxBX0+1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OPpfJuU3; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OPpfJuU3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787094158; x=1818630158;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fEgXKovIZOW4WfqZh+snAL8qnNOxXFUCVlAbVCbteOk=;
  b=OPpfJuU3pmw1XsDnIxhEK6CHgAkEcOcLI3p+d9SR7x+MFCMqguQvw24i
   BOzibgCB5pxWtOyFLt+R6RgrLiRLu0hXwdtkW7BiA6EiPNYn3BhMCO1yx
   oJjneYEYXvSlvLNbRfLZiGl5D1j1vU5jYLgaiAj69ioo7/mQO9RW5kqkx
   N85uQzr88WEwI3SgupqAZcaHbFQfXlJJpPAVHi5P1+7Se7pHMXDNSzXsh
   j6WXveMxEKWCQrZ/zYGj0zNId+RrNjzbtL/FJJ7ZZiWZixihwBmOKytne
   F1Ru9TKWB2preD+ganiHwRYsoEf69T4CYzjJwx7rfHNfwRejWTAKKswR7
   A==;
X-CSE-ConnectionGUID: KJxtnu7AT++J3z+CnxEQfw==
X-CSE-MsgGUID: bcXjLLcQS72hPnkHYaXJFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="91409643"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="91409643"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 16:02:34 -0700
X-CSE-ConnectionGUID: UezKyeAVSfKw0VFCnycjtQ==
X-CSE-MsgGUID: qR+O96HWR/a41Qblm1bK6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="264060585"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 16:02:34 -0700
From: Andi Kleen <ak@linux.intel.com>
To: namhyung@kernel.org
Cc: acme@kernel.org,
	linux-perf-users@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v4 1/4] perf tools record: Modernize -W man page
Date: Tue, 18 Aug 2026 16:01:05 -0700
Message-ID: <20260818230229.1491871-2-ak@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260818230229.1491871-1-ak@linux.intel.com>
References: <20260818230229.1491871-1-ak@linux.intel.com>
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

