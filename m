Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EC7369203;
	Fri, 12 Jun 2026 09:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781255229; cv=none; b=qTJZU3qtHgW/9PKao3TCwWjk980NtP76WEkzw0Jb2RZ1mfqIUIEGjbHqriwoiVKvIZYtOfpsvf5abPeSHgJebrfkNQuDqWPjj6/nWktpzKSE+Ex0slRoBp0SL8sXSanTfRL9e4g/qDiFf5mH4KS+Xih1eBl4VHGUsLtQNCFffH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781255229; c=relaxed/simple;
	bh=mly2iaCfBkjoH7gmdQqUuuX71xCZ4hm2aMsANOSobHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qhieu6iwjzJrIMZXUR70jU1wekACJZndgXXS6/9JZSdzmxuePIN66y4raaW4//i/yoKuCpL0napQjDeIL9Yu/jmL3LqatCpZi8UF4wwCW5vOlqMetQtaZ6JbQ/VwnhsZeGRZecnssJfbQmXIowpmsJX3dIAqRaZ2mteWIUVCygQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jcTPxbFl; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jcTPxbFl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781255223; x=1812791223;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mly2iaCfBkjoH7gmdQqUuuX71xCZ4hm2aMsANOSobHI=;
  b=jcTPxbFl0M+H9La9JgHgCQNzGDHppuEd21GvE/UMUrAagsspaGU7E8MA
   9KcIcaX9ottI/Tjk9YKpFfpWjFPlmzu+P+bc0NxLqRJMdVgRMLAakFF2r
   DstHBdc8IriwI6fPVfhk1c3HKFoZ+wO1lzsQ9ibm2TduOkhaFs4xjUfC1
   jkiUYp/xwKzdN3TfGtCU0FfrK6kfnY+7ST2usiLLsRk+LUDXxZICrecEJ
   gJfx6XT+kj35h6ZwPlTcnFMOmDis5A1e6GNP64mEts+osliwRba/ig3cm
   vEA+T7v8qiJMEfxG63QuR3nBq5tt8Cl66lp5CRDV8HNUU40zjO5sO6b1W
   g==;
X-CSE-ConnectionGUID: H10Cae+tSIaUdFrFO7YgVA==
X-CSE-MsgGUID: /9Ial7rUScC1F2EeiouAEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85714490"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="85714490"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 02:07:03 -0700
X-CSE-ConnectionGUID: Y0HchbsRT/6x4S1JxYIVug==
X-CSE-MsgGUID: XGs3VX0aThKJqP5nMxANlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="246838781"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa007.jf.intel.com with ESMTP; 12 Jun 2026 02:06:59 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [Patch v3 8/8] perf/core: Check kernel access when kernel callchains are requested
Date: Fri, 12 Jun 2026 17:01:14 +0800
Message-Id: <20260612090114.3188886-9-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260612090114.3188886-1-dapeng1.mi@linux.intel.com>
References: <20260612090114.3188886-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf_event_open() currently gates perf_allow_kernel() only on
!attr.exclude_kernel.

However, users can still request kernel callchain collection with
attr.exclude_callchain_kernel == 0 even when attr.exclude_kernel == 1.
That still requires kernel profiling privilege, but the existing check
does not enforce it.

Update the permission check to call perf_allow_kernel() when either
kernel sampling is requested or kernel callchains are requested.

This keeps permission checks aligned with requested data and prevents
unprivileged use of kernel callchain capture.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 kernel/events/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 89f6c9ffb964..bbd260d9d5b5 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13924,7 +13924,9 @@ SYSCALL_DEFINE5(perf_event_open,
 	if (err)
 		return err;
 
-	if (!attr.exclude_kernel) {
+	if (!attr.exclude_kernel ||
+	    ((attr.sample_type & PERF_SAMPLE_CALLCHAIN) &&
+	     !attr.exclude_callchain_kernel)) {
 		err = perf_allow_kernel();
 		if (err)
 			return err;
-- 
2.34.1

