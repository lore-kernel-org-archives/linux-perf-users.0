Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B69229AAF3;
	Wed, 27 May 2026 00:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779843429; cv=none; b=DB59RkK2AtLM4l5VUWH/zxceJr1MNRR+iszS0MzroUm1r1yu/bT62qM6Z2fUvtfLDDRs+h28uDMsrJN/qYoU2bWmumI8b3E4oqWpJopwyDOBKrgM3nt9F705ruLdxd0U0cyWnEadVSVr/dqZjKaf25c9y4VzOM2XuDXil+DXR7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779843429; c=relaxed/simple;
	bh=QY1XCfUKp1HIKfRpUo4a9F3S/gXNvtzeeb4+Uou+81I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mbcDJKExzLP+zWTHxKoyiay5k50CMshcX5ZiiPQAO6sbfYSZKZV6SD85lukZVrlzfw8y0CjYX7diwreBM6H4coZAhLJZRNENnYS2jS/ZYD1Zw9FIRjAa/BXzf9mg0SEi5lopA0uP/1gScWw+WFnV9EoRVwzrmQvU7YwGtYTIhQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nzI2UZqP; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nzI2UZqP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779843428; x=1811379428;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QY1XCfUKp1HIKfRpUo4a9F3S/gXNvtzeeb4+Uou+81I=;
  b=nzI2UZqPjsiI7LXst6KJItWkCq9CIL/rVxaqo1aHEzWA+/wi9gCXwSxe
   xta6v9qD3UC2KHSdU7O8tLfwN75nqP2pxN0itfKGZ7XjICobSnK1L4szm
   3W+hzUqJxkDTEWemHfgARGxibv4Gn2/hEMi7HqTFjpdDqFuq7soCPoEZV
   j2Q8SeIo38Lhyj9D7/2hQOwo9QI6ryoMosmLaxVJEHjTuCQWLOJbMgyAq
   Kh20n9Umb6BeBirVVMAvYLk7XV9G1spooyrlMHSJcaAZqgNQGkrpcEyFO
   0v2F5HynoIpK7ocPpjaPlTuJaM2xSrdpYqN8BEo5MxjEqww1HfKPKWqWD
   w==;
X-CSE-ConnectionGUID: ztUzGAHJSfKGXoeGQKedyw==
X-CSE-MsgGUID: dZJaiEkAT2W6pnZiNMVBgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="80577479"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="80577479"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 17:57:07 -0700
X-CSE-ConnectionGUID: 8LCq7ccoQ0OGOQ9bjZ+r1A==
X-CSE-MsgGUID: S7pU5x5PQWy6ILt6wmSPbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="247165835"
Received: from junxiao.bj.intel.com ([10.238.152.69])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 17:57:03 -0700
From: Junxiao Chang <junxiao.chang@intel.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: bigeasy@linutronix.de,
	junxiao.chang@intel.com
Subject: [PATCH 0/1] allow trace events to be accessed from any CPU
Date: Thu, 28 May 2026 08:51:35 +0800
Message-ID: <20260528005136.1906479-1-junxiao.chang@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The issue was reproduced while debugging real-time scheduling
performance. An extra SMP IPI is triggered when using perf stat
to collect trace event statistics.

Trace events should be accessible from any CPU without requiring
an IPI when the current CPU differs from the event CPU.

Set the trace event PMU scope to PERF_PMU_SCOPE_SYS_WIDE so that
trace events can be accessed system-wide. With this change, no
extra SMP IPI is triggered even when the current CPU differs from
the event CPU.

Junxiao Chang (1):
  perf/core: allow trace events to be accessed from any CPU

 kernel/events/core.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.43.0

