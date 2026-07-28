Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE0B40DB55;
	Tue, 28 Jul 2026 21:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785272754; cv=none; b=j8WcqmU7R0i5DIK9eKUUy52VOJA6/PA4jkIEw5SiFHW1IYPa1U4kX+2/oHq7ooaXjm3mCY2hFKq2PqOH393W4QP1qcukb6rk9WZUx1xfXXmv7YdIrxhE5IG60eDipYmK7b4KdTGsZsTkF0zkWOkujx2+NnpuNjpX0LirPgTomSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785272754; c=relaxed/simple;
	bh=FA08Bl2eyB+AbIkYfByNN/UZvSCWQczXliUkSGwadOg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BbtsIaHdBiXq5tL4x3y23C/KsfTvQWVoFfsH2StSuA+rYi54Zp1Pn8atfATjljA/ywBLhVAMwNm95u0OR9tbmmf4+yIthjGM2ndUHiEmGM7nXgstzKShdnEF5pzDskOC7e3NOqjNoCsw7T4e3gnLDIBg9ozaYOYsKeRljx45wWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5DD1F000E9;
	Tue, 28 Jul 2026 21:05:52 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: jic23@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com,
	dave@stgolabs.net
Subject: [PATCH 0/9] perf/cxlpmu: Misc sashiko raised issues fixes
Date: Tue, 28 Jul 2026 14:05:42 -0700
Message-ID: <20260728210551.2449093-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Teed off of Davidlohr's misc cxlpmu series [1]. I had Claude pick up all
the sashiko raised issues and then continued multiple internal review
iterations to pick up a number of fixes. I'm no CXL PMU or perf expert,
but the fixes look reasonable to me AFAICT.

[1]: https://lore.kernel.org/linux-cxl/20260715191454.459673-1-dave@stgolabs.net/

Dave Jiang (9):
  perf/cxl: Program the requested event group on configurable counters
  perf/cxl: Clear stale event fields before reprogramming a counter
  perf/cxl: Drop bogus counter overflow fixup
  perf/cxl: Accept an overflow interrupt on MSI message number 0
  perf/cxl: Keep the overflow interrupt pinned to the managed CPU
  perf/cxl: Unfreeze counters after handling an overflow interrupt
  perf/cxl: Validate the hardware-reported counter width
  perf/cxl: Don't use pmu.dev in IRQ and hotplug callbacks after
    unregister
  perf/cxl: Avoid cpumask_of(-1) when no CPU is assigned

 drivers/perf/cxl_pmu.c | 59 ++++++++++++++++++++++++++++++------------
 1 file changed, 43 insertions(+), 16 deletions(-)


base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
-- 
2.55.0

