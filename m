Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27D9382F1E;
	Tue,  9 Jun 2026 05:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780981699; cv=none; b=BshoyF50uf8U/uh9xb8J9w5uwGCjOPx2yEyx/fkWY/ChNZ4+cWwUwj6WA8skwgnubqW1wuw9ZiaZhOwHLywQ404uMmPDqR07FjAxz1jEmqaiZlCA/K75OIXbeLmAO/8ILk9MfWvMADblV5Q4I51vI0lQmakM+Cp/s/rMytr4TP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780981699; c=relaxed/simple;
	bh=0opGLz58tqOBQk0g3QkpKG/34nOsQ+Ls31VCt62BZAM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I3wkLCiW3YP/f5CdlNJ0Hj2wzYTjLaMmkvtgMaMT8V32QTQwkg9ziWCvH5HHjqHhCGijdy+m1JyRwOEo1lO8cpfkWJ0vvYsetz/lSvCvuOoXC15jzhAe5Ofh2N9wdVR4DHxE8aiAT28eMmChUqIW59kQ8HR+r6PxG5+WiqKVfKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lY4BN1mI; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lY4BN1mI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780981699; x=1812517699;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0opGLz58tqOBQk0g3QkpKG/34nOsQ+Ls31VCt62BZAM=;
  b=lY4BN1mIFyXJE4MxUHY4yYp8ot5MnKNakfFQ8x5n8EECIZPNTS2DEdZ7
   9/g0d45mkOIQWkOodkjfugsHP6QZLDVOZDFp0JBkZPHS6EtK6jUIbYB9W
   Iu0XG+phD6WjrmmX2Drj/6kRdEo4nfFKOPmowiG3BVMzuh5NY5tBtQQe9
   MudnoG1VVddL2zBN2+2c9AeqEzrXADIID1VVWrWXJPW8hfjEHdq1c+OVW
   ZMjOJpGbjneCtDOCR+58euTUnt1YjkJ4fum/1AoML07wtr1T8FQgoYq6c
   N0weIuHzttB2C2O5GvlR8VHugjD+GcWihi7qv+d1ZzOIdfaMPO8JEmbqE
   Q==;
X-CSE-ConnectionGUID: PJw/d0kCQlK93ksL5wm4mA==
X-CSE-MsgGUID: 4zHON8w+SbSfqVSRSJqjRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81586206"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="81586206"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 22:08:18 -0700
X-CSE-ConnectionGUID: l+nGj0DoRLeLmDqdMOLfzQ==
X-CSE-MsgGUID: VXgNcThnQdqGw6Hh7LvXVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="283838940"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa001.jf.intel.com with ESMTP; 08 Jun 2026 22:08:14 -0700
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
Subject: [Patch v2 9/9] perf/core: Check kernel access when kernel callchains are requested
Date: Tue,  9 Jun 2026 13:02:22 +0800
Message-Id: <20260609050222.2458129-10-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609050222.2458129-1-dapeng1.mi@linux.intel.com>
References: <20260609050222.2458129-1-dapeng1.mi@linux.intel.com>
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
index 1bde029eeca7..57c9fd640cf5 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13895,7 +13895,9 @@ SYSCALL_DEFINE5(perf_event_open,
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

