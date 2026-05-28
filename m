Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D3D3002B3;
	Wed, 27 May 2026 00:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779843432; cv=none; b=Ih4qiqBK8R17pCtrxsMKGfZ1M4gfJOiGiwgcXm6cr4yOWSCa/XsDhuHxxdWf1dowO6XRkx5HK1nBUAfhKfpp+g/BfhJMoNIXJL2oCFxmsHQHO6hypK7jFGeyt2Ih2Uiok5Jgc8ltgvX5no2ulLiE4Gj4oclTdogzH1Vq6MNjXQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779843432; c=relaxed/simple;
	bh=bIUYSElHnCvQb1SJDclQpJXSvdKzMg2HoaWOjpHzo9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cyt+FWI7SODsW3876KhxJGgwDKveAaukuAyIJ1aZvR9vWTnqSmCvn1/M5EpZsCBCg8jEDXWt6xRmUX+p2iZGZeAGrDXC0DQIv3m8yKCE9HPQsDm2bTSfLR817H73DuTRyAlsXZFS2K3/KTFUIztsEOuJpio2lHBwdsq8f4PAzYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kcc2biI7; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kcc2biI7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779843431; x=1811379431;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bIUYSElHnCvQb1SJDclQpJXSvdKzMg2HoaWOjpHzo9c=;
  b=kcc2biI7bJIemXuJGGYUJ4Q3NUJXAueSwU/Vug5T3TpyXQc1dk4Kj8JD
   mW5xuguvh+5oS0Yhkee0YIyuImfZFGDrSgGT+YpVw75Jl2Q4Uz9ZFIQoX
   2buoqvwtMV4REsd6Oe/Z5xOccxtTzDIA28GceS+Zq5t/uT/Optl3Mepug
   LXQE+nV/K3o7sjdRiw57NxjTPkouZCy6AkLlUcpLjfs8Cz/Mx0VnTIpZd
   zS0tvbEmn8HYCCHnqK+ZBxtzrhREXH1aPmG6o9LqCJuM35kbVv9LiXnqT
   +cRnXPTtWR1IGza4DFAcRu8bghcNazDYD4axUcqLHD7MR6BDnPNpgl3Lj
   Q==;
X-CSE-ConnectionGUID: 5PAjDwmHRwqxmaWwoyK5YA==
X-CSE-MsgGUID: S0LIWBlfRpifnlps0P4CBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="80577487"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="80577487"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 17:57:10 -0700
X-CSE-ConnectionGUID: bl4lah1QTSm5dDwuQnOCKA==
X-CSE-MsgGUID: 7aah0/JZQ3qeALCsGjYR+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="247165843"
Received: from junxiao.bj.intel.com ([10.238.152.69])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 17:57:06 -0700
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
Subject: [PATCH 1/1] perf/core: allow trace events to be accessed from any CPU
Date: Thu, 28 May 2026 08:51:36 +0800
Message-ID: <20260528005136.1906479-2-junxiao.chang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528005136.1906479-1-junxiao.chang@intel.com>
References: <20260528005136.1906479-1-junxiao.chang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using perf to collect trace event statistics may introduce unnecessary
SMP IPI interrupts. For example:

  perf stat -e i915:i915_context_create -I 1000

In perf_event_read(), an SMP IPI is triggered when the event CPU
differs from the local CPU.

Allow trace events to be accessed from any CPU so the event CPU can
be set to the local CPU, eliminating the extra IPI overhead.

Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
---
 kernel/events/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index acdb1f02924da..b3a817c0eb3a2 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11376,6 +11376,7 @@ static struct pmu perf_tracepoint = {
 	.start		= perf_swevent_start,
 	.stop		= perf_swevent_stop,
 	.read		= perf_swevent_read,
+	.scope		= PERF_PMU_SCOPE_SYS_WIDE,
 };
 
 static int perf_tp_filter_match(struct perf_event *event,
-- 
2.43.0

