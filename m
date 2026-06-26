Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90773DD85A;
	Fri, 26 Jun 2026 07:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782457455; cv=none; b=pLiioFWj0/iTDhen4VTzx2Ed97eeqFwe4aRWZNZN7QW0H9ZIdnGREbiv55RIcsohgbWRAcx3KM7bhvxbJVvMXJZ0m98mdwJ6kkKpnjolcKVLAa/bJCPPNez0lQSu6XABZr5AZrvXunmIa4APQ8duI564odUfgXenQwsP5CA0v/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782457455; c=relaxed/simple;
	bh=W85myoASPehLBxoqFt5+TTsyUpo6c3Perb+cS0BpWhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uCduhAEMN19pStN8O4aXy5su+w+PANwR21WNqcsR62URX4rGa+zquzgd+7jesiTTIek0R5waJ3X1Gb9dM2Jed80fUj3jhZ/uqAvCOoe5nnPfRNAHCM6JfqCQhTlSBgi6oZ743TZerkOYRkrU6uZU746iNun4rl98RFFnv0fXQDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RstEV9ON; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RstEV9ON"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782457453; x=1813993453;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W85myoASPehLBxoqFt5+TTsyUpo6c3Perb+cS0BpWhs=;
  b=RstEV9ON/36/ouqfEbiiM+EIgm2BndKdW1jvUhOuB+YpgtAVv3WZGlv/
   QWijRT/wEw206+fyALQI1BgfkCRXQ7UwyCDyVZEAWAp44//9KPtD7IiLZ
   68KxuSIbSVx1JHiMk3SGa+9bQPXqMQhw5Wl0i7lZzDCLFeUMQPDqgG2wP
   HsCY3HdwVCGahz8W8X0RlHCBPmsM4cr2BweVnDwWVTT8Q9ni2WLe5Sl8h
   mF1d84pIAfzxstdVjI5Tp4wNXtyeP2Snr3iTL3nF7+q+ej53ZF6iuWqZB
   6riKQ06Dimh30Dv8KtBkz6xBW4k/2acxkW1dYlv6K8uJVhQaDNjz6WuId
   Q==;
X-CSE-ConnectionGUID: V6GTwuLqRryzhIuo0fzAhQ==
X-CSE-MsgGUID: 4fjnqDVEQkSKskfNWagmgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="94397488"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="94397488"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 00:04:13 -0700
X-CSE-ConnectionGUID: y8p0FDrWTpqo1K1SZ1Widw==
X-CSE-MsgGUID: tNsmoy39RA+noRb6wDaOdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="247893634"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by fmviesa007.fm.intel.com with ESMTP; 26 Jun 2026 00:04:08 -0700
From: Jiebin Sun <jiebin.sun@intel.com>
To: Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Tianyou Li <tianyou.li@intel.com>,
	Wangyang Guo <wangyang.guo@intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiebin Sun <jiebin.sun@intel.com>
Subject: [PATCH 14/14] perf c2c: document function view in perf-c2c man page
Date: Fri, 26 Jun 2026 15:03:55 +0800
Message-ID: <20260626070355.1556721-15-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260626070355.1556721-1-jiebin.sun@intel.com>
References: <20260626070355.1556721-1-jiebin.sun@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe the three-level function-view hierarchy (primary function,
sharing functions, shared cachelines) and the TAB/ESC/d/e key
bindings that drive it.

Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Falcon <thomas.falcon@intel.com>
Reviewed-by: Tianyou Li <tianyou.li@intel.com>
Reviewed-by: Wangyang Guo <wangyang.guo@intel.com>
---
 tools/perf/Documentation/perf-c2c.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
index e57a122b8719..1be38167f339 100644
--- a/tools/perf/Documentation/perf-c2c.txt
+++ b/tools/perf/Documentation/perf-c2c.txt
@@ -365,6 +365,21 @@ TUI OUTPUT
 The TUI output provides interactive interface to navigate
 through cachelines list and to display offset details.
 
+Pressing the 'TAB' key in the cacheline view switches to the function
+view.  The function view shows a three-level hierarchy of the same data,
+organized around functions rather than cachelines:
+
+  Level 1: primary functions, sorted by Cycles % (estimated load cycles:
+           HITM, peer-snoop and other-load cycles -- on systems whose
+           default display mode is peer, such as Arm64, the peer-snoop
+           component dominates)
+  Level 2: other functions that share cachelines with the level-1 function
+  Level 3: the specific shared cachelines for each function pair
+
+In the function view the 'd' key opens the detail view of the selected
+cacheline, 'e'/'+' expands or collapses the current entry, and 'TAB',
+'ESC' or 'q' returns to the cacheline view.
+
 For details please refer to the help window by pressing '?' key.
 
 CREDITS
-- 
2.52.0

