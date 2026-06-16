Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A2D3CB916;
	Tue, 16 Jun 2026 04:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781585585; cv=none; b=tk+CNftnySnuV7aW1qagp/Vxhz5K/r8G291QY+wWSbPnOa105JVOAPh/UB/iyoj9dIdIvS9WAnof/MgzBR3Q6chBlzzwqlJBDNrXSxm3W3oX/p1/Bzg3wJe/1oEp6r995AqtTO8ITCDxHketYJaeIIzOVdtZBYCrLHelPw/s18U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781585585; c=relaxed/simple;
	bh=mly2iaCfBkjoH7gmdQqUuuX71xCZ4hm2aMsANOSobHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uuossfkj6j92uxHKmeOfHJReCA9LVoOoWg6po20V+I0xhXOuFIEYs1vQi8tWHGpDWkLqJlRn5mRjAiMK/QyvVPH1Ikf/b5/8VR3TGd/I1ZUlfAvj2zA8ZVwEy18F8dgeqMgaW57Fmb2bOY/0e7F578OL4Xq7uyQWqN1Veb/OJLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VzkTp9qK; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VzkTp9qK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781585583; x=1813121583;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mly2iaCfBkjoH7gmdQqUuuX71xCZ4hm2aMsANOSobHI=;
  b=VzkTp9qKNskDHxPKUkXekuzRoDbNkgUQYhYFOCvQEnqe4oCA1cOIhbpP
   8OpDRdP7y0ph7eZ28gV7fKAUvYlJOFdo/WJb/HPj4IL9iToYBOEU0rjbA
   fNCn5Xwd2buCR1znCZXENyMMcDoe9T0UHtOTw8a6zQxsCwraLYwd07vTE
   6M9+X5psnf+t3QhsCwETeiFUiU6jDjEsXk0GKztZQFc6swcGJs0a7Cw9t
   61G57z3RbSioFngiqgv+f8kaPHnz5IYFP9aGkZYWdDUHKJSBtwbO3A01o
   79Xe1ulrQffXodeUQ/dWi3g33mY/jMXv3Z9GSnl4RCTHWbqmYQ3GrYPQZ
   g==;
X-CSE-ConnectionGUID: TtYlkVmtSVu/5feYnk2lUw==
X-CSE-MsgGUID: sLqCGiVNT3WhXvyHfPWXVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="82445552"
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="82445552"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 21:53:01 -0700
X-CSE-ConnectionGUID: sSTN3KaSRZiVQ+Wj1j0NAg==
X-CSE-MsgGUID: Oduj4eaxTqOx+2+8WMwjqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="271726579"
Received: from spr.sh.intel.com ([10.112.230.239])
  by fmviesa001.fm.intel.com with ESMTP; 15 Jun 2026 21:52:55 -0700
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
Subject: [Patch v4 8/8] perf/core: Check kernel access when kernel callchains are requested
Date: Tue, 16 Jun 2026 12:46:54 +0800
Message-Id: <20260616044654.3468742-9-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260616044654.3468742-1-dapeng1.mi@linux.intel.com>
References: <20260616044654.3468742-1-dapeng1.mi@linux.intel.com>
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

