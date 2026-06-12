Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CF930F7F2;
	Fri, 12 Jun 2026 19:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781292538; cv=none; b=p/3+Jpo/jax8enNe6GkJ4ByWcfhXbBnpMtp2XhV12OTzsse45iI3dPxu1XXElLuUMwUNLfu7AIGaO5Z1o8kjvEg2/bq+B5qIysbz8epCykhUnGEfV4UD/2B/PkC5M08Q3YYwpTzB/k6SZMZ4+mZpEy4LAu2MMog3XS+E3LETxZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781292538; c=relaxed/simple;
	bh=CBQGwm9rl/EjaOlLBMxJBNs37qlZaT3UAADoq+Malnc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZDUQhdbVCIurRhFuZRY3bGTsU3oYNE+jb3qE/MXDT6FCimRZbPIpl0L494qDNIZJc/THYHHOjtMrvniDVvXus4iuAOZxMvchdDaVrPQwuY+948MwVNuyxlBCWF3Ju8k02rDqNgOk8FALJZW9OiIpsm0EOmHOYLQs0LK4Z5U0LsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eDj5Qq/7; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eDj5Qq/7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781292536; x=1812828536;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CBQGwm9rl/EjaOlLBMxJBNs37qlZaT3UAADoq+Malnc=;
  b=eDj5Qq/7NHxTbXnEhxYbMx/oRmd/J8ioQ8LEGq/WLTZ/5IG3zeC77l5M
   nbNgAUGVFeYKR6AVJg5rU9hEGD5lny359uNMKdJf62L62gPbh/OOfdXeb
   bhqcRKIsXdl+gXOYpw+y8XkemaH9gi/MSuULMBbVIvkw5Xb+KuXrIdS2n
   8Xo6etOhl39BCe2QJGrhPwUDDEqVtN0UmMVNSsdpzlg5VGEZ6DnnobsuG
   oSAZ20z492lErEBcShX+hVMkm7JsE30FN01q+afc7sVyDgfNATf7AVJZi
   FmO+2yGEgveUptQizKbrwX0sHXkrQlHoNsoBrLyd3gKoBGLgQNlnWDPPJ
   Q==;
X-CSE-ConnectionGUID: ikejmjceRKWTc2dDQ1WT8w==
X-CSE-MsgGUID: kIA2BFDVTzuWPCpRioLYrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11815"; a="81264338"
X-IronPort-AV: E=Sophos;i="6.24,201,1774335600"; 
   d="scan'208";a="81264338"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 12:28:55 -0700
X-CSE-ConnectionGUID: Tt0asowNRgeGjnAmrMUfhw==
X-CSE-MsgGUID: 5u6m39prScOVQp6yL2Zyjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,201,1774335600"; 
   d="scan'208";a="246963775"
Received: from rodrigoa-mobl1.amr.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.220.220])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 12:28:53 -0700
From: Thomas Falcon <thomas.falcon@intel.com>
To: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH] perf: Document recent additions to the perf.data file header
Date: Fri, 12 Jun 2026 14:28:47 -0500
Message-ID: <20260612192847.1221091-1-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documentation for recently added HEADER_E_MACHINE and
HEADER_CLN_SIZE data to the perf.data file. Also fix a typo
at the end of the header section.

Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
---
 .../perf/Documentation/perf.data-file-format.txt | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index 0e4d0ecc9e12..b90cba9168f8 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -464,7 +464,21 @@ struct cpu_domain_info {
 	struct domain_info domains[];
 };
 
-	other bits are reserved and should ignored for now
+	HEADER_E_MACHINE = 33,
+
+ELF machine and flags data. e_machine is expanded from 16 to 32 bits
+for alignment. Format:
+
+	u32 e_machine;
+	u32 e_flags;
+
+	HEADER_CLN_SIZE = 34,
+
+The size of the cacheline in bytes. Format:
+
+	unsigned int cln_size;
+
+	other bits are reserved and should be ignored for now
 	HEADER_FEAT_BITS	= 256,
 
 Attributes
-- 
2.43.0

