Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63651E5B7B;
	Fri, 19 Sep 2025 02:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758248318; cv=none; b=If0x0jxzNG2QX6vP9hy4uQio5xfviyOvvJZ9YZ6lEIv1HikHUiv/CqMf+yjln8ccW/02uiEDlPbxBCtGk4l9YCp/5buD+0mfiU2wwxVtfQbQ+LbkUaGcqOGt1D6upZsZ7O+BUZoaVX1YTQP7oaVNbs5qHDmuvI19eUcnYnW6FNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758248318; c=relaxed/simple;
	bh=tEvw8FFG0H83gztJ92OoyzWPO8cURkt1o/Eu3bahdMk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AY+57Z+zplkP0DjiOojlnqhgBweksKtV/EAdiIVjnaQF9ZYsovqXlPaztR/8IfhYuZj7MPmRKpbK+5ZmdR5R194pATOjON34dRcfNqYTdHXEyiUGntDJ9+ObHWilp7DHYehfI8E5l0E0ajpF+onr6DzeaYtgxBfqkEEBOoAtbDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fo1dfFyF; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fo1dfFyF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758248316; x=1789784316;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tEvw8FFG0H83gztJ92OoyzWPO8cURkt1o/Eu3bahdMk=;
  b=fo1dfFyFpv7lDVVr7d73QeG0rO1CFM5tZUhafjPF+A2dNfw2+a2DeTDs
   h6quBSDWORap5hB2XBFvj2tk92lRH0kqYRhcF73PT9jS0A1tVp7sGgUxQ
   kNOsjAbJJIrvwGsiSfF2oIUWw3j1qcdw/IYUgYBBTULNMJR0sYr/Q9B/M
   +vfjSY4vDkq6bJvEZNMXkHQjLtX2AI1f+jgFvXH+6QYZqB/m31o704ApG
   PUNq3ZACfRBoR8bxA4c57lZIpIB9dexzL9tV8hit8r+7FMFXhh29S/I6i
   v3iPKNqTFXmYhcraQ1CAykenRtq531a9kO8y0rjZURDdQ4tZ04NBKYpfD
   A==;
X-CSE-ConnectionGUID: cSgFjRKsSLKkuBweMtWRUw==
X-CSE-MsgGUID: U7/ys30sR5ePQc7ydju88g==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="64229108"
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="64229108"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 19:18:36 -0700
X-CSE-ConnectionGUID: 8dVxh5A8QIuU5m9TsB5Xjg==
X-CSE-MsgGUID: lDdVuhbURVC82exTtnXXiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="175535590"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa007.jf.intel.com with ESMTP; 18 Sep 2025 19:18:32 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v3 0/6] Perf kvm commands bug fix
Date: Fri, 19 Sep 2025 10:16:53 +0800
Message-Id: <20250919021659.1263351-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch-set fixes perf kvm commands issues, like missed memory
allocation check/free, out of range memory access and especially the
issue that fails to sample guest with "perf kvm record/top" commands on
Intel platforms.

Since the change "KVM: x86/pmu: Add basic support to enable guest PEBS
 via DS"[1] starts, host loses the capability to sample guest with PEBS
since all PEBS related MSRs are switched to guest value after vm-entry,
like IA32_DS_AREA MSR is switched to guest GVA at vm-entry. This leads
to PEBS events can't be used to sample guest by host, otherwise no guest
PEBS records can be really sampled. The patches 5-6/6 fix this issue by
using "cycles" event instead of PEBS event "cycles:P" to sample guest on
Intel platforms.

Changes:
  v2 -> v3:
  * Correct the fixes tag in patch 5-6/6.
  * Add "acked-by" tag from Namhyung.

  v1 -> v2:
  * Free memory allocated by strdup().
  * Check "--pfm-events" in kvm_add_default_arch_event() as well.
  * Opportunistically fix the missed memory allocation and free issue in
    builtin-kwork.
  * Comments refine.


Tests:
  * Run command "perf kvm record -a && perf kvm report" and "perf kvm
    top" on Intel Sapphire Rapids platform, guest records can be
    captured successfully.
  * Since no powerpc platforms on hand, doesn't check the patches on
    powerpc. Any test on powerpc is appreciated.

Ref:
  [1] https://lore.kernel.org/all/20220411101946.20262-1-likexu@tencent.com/
 

Dapeng Mi (6):
  perf tools kvm: Add missed memory allocation check and free
  perf tools kwork: Add missed memory allocation check and free
  perf tools kvm: Fix the potential out of range memory access issue
  perf tools: Add helper x86__is_intel_cpu()
  perf tools kvm: Use "cycles" to sample guest for "kvm record" on Intel
  perf tools kvm: Use "cycles" to sample guest for "kvm top" on Intel

 tools/perf/arch/x86/util/kvm-stat.c |  51 +++++++++++
 tools/perf/builtin-kvm.c            | 130 ++++++++++++++++++++--------
 tools/perf/builtin-kwork.c          |  27 ++++--
 tools/perf/util/env.c               |  22 +++++
 tools/perf/util/env.h               |   2 +
 tools/perf/util/kvm-stat.h          |  10 +++
 6 files changed, 203 insertions(+), 39 deletions(-)


base-commit: 576bd7a8c90c48e9e93a18de0bcc0fa1e0a5433b
-- 
2.34.1

