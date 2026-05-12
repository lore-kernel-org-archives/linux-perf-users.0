Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399AB376BCA;
	Tue, 12 May 2026 23:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778629178; cv=none; b=EaAf83xy9yNL/bd73mrbUI9SwfoVxtau4GJb1qZ/rJg2qM8h0e+U21tkbCEC8ydectAYxr0C7k49EsaMvYYxttgthtAHeWMKVuA8p3Yd9TtehA1R3K288TtGOqT6hPRJqsSmo2zZuj/R59l/YQxNj3SR3Sa31GB2JqnX53bB/38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778629178; c=relaxed/simple;
	bh=INwC3slLbtsBIlHq6ivO/Wm67ZWTZHFTQKLRUBkEQZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=er5jpZA1KPBcHRCcHZGxaXh6KPGB/OfBQPPqGawj5n2d140GHSidzZ1WQX9xZpFfJcVAmLAensOWVjj3RD4zDgbaxGdtSrlSljkVauj9sAjtw/5HuZq9FDZKf9agzkOcn2HxKrrpTo3Kn/u8NIwGTnU5zsw4H4ORYYp2juIbuVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rwvn4x2H; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rwvn4x2H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778629177; x=1810165177;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=INwC3slLbtsBIlHq6ivO/Wm67ZWTZHFTQKLRUBkEQZw=;
  b=Rwvn4x2HtgwCQjb9pdHxdMgq8nXq+QzvU28r7VYevHelndjRsLvVbSEY
   C4PpiglmCXivaqGWPLtV6kG7UK8hCyUmme1FA+AlWCH9Len8Ro6TWzLfM
   bhHsJAZrCcILOgVrAKNsE+9wGvJi3W32UsDXZ8knWPBcZQNEXqUcD8Ti6
   +GAQ+8wN1qeaEa2qCnHZu0R77uinWx9VK7fXK84kA0/Whe6vWhQAnFp3H
   5Ori1KK7oeJkeLjgEEZYJmWy6ZSvij4wWb1RK25RP/Nqi7a0NUnsV5esN
   QIBB142iLujttxZQAHdrYdjS4szuHDH40bbSH7vXUZvttVvsiZF8cfkn7
   g==;
X-CSE-ConnectionGUID: uN6OEMGDRcKESD0Is1xZgw==
X-CSE-MsgGUID: zs3JaAY9Qj2pRTD10swBPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="105008867"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="105008867"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 16:39:36 -0700
X-CSE-ConnectionGUID: 6izWw8RxRrKUChwS1c150g==
X-CSE-MsgGUID: YOHE5AmgSASSjKov0JzAlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="242271282"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 16:39:37 -0700
From: Zide Chen <zide.chen@intel.com>
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Zide Chen <zide.chen@intel.com>
Subject: [PATCH 0/7] perf/x86/intel/uncore: PMU setup robustness fixes
Date: Tue, 12 May 2026 16:30:41 -0700
Message-ID: <20260512233048.9577-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes correctness issues in Intel uncore PMU setup:

- If all init_box() on a PMU fails, the PMU sysfs node may still exist,
  while perf events read zeros and silently report wrong data.
- If init_box() fails on only some dies, perf may return partial
  non-zero counts, which is harder to diagnose.
- CPU hotplug ref/unref ordering bugs can skip init_box() when the first
  CPU in a die comes online, and can call box_exit() prematurely when
  the second-to-last CPU goes offline.

To address this, the series introduces a PMU broken state to track setup
failures and switches MSR/MMIO PMUs to lazy registration, matching
existing PCI behavior.

Zide Chen (7):
  perf/x86/intel/uncore: Rename refcount fields and other cleanups
  perf/x86/intel/uncore: Let init_box() callback report failures
  perf/x86/intel/uncore: Keep PCI PMUs working when MMIO/MSR setup fails
  perf/x86/intel/uncore: Factor out box setup code
  perf/x86/intel/uncore: Introduce PMU flags and broken state
  perf/x86/intel/uncore: Fix uncore_box ref/unref ordering on CPU
    hotplug
  perf/x86/intel/uncore: Implement lazy setup for MSR/MMIO PMU

 arch/x86/events/intel/uncore.c           | 214 +++++++++++------------
 arch/x86/events/intel/uncore.h           |  36 ++--
 arch/x86/events/intel/uncore_discovery.c |  16 +-
 arch/x86/events/intel/uncore_discovery.h |   6 +-
 arch/x86/events/intel/uncore_nhmex.c     |   3 +-
 arch/x86/events/intel/uncore_snb.c       |  84 +++++----
 arch/x86/events/intel/uncore_snbep.c     |  71 +++++---
 7 files changed, 242 insertions(+), 188 deletions(-)

-- 
2.54.0

