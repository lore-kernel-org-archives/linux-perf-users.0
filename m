Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD39C453A45;
	Wed, 29 Jul 2026 14:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336957; cv=none; b=oc9sg4uE3Q/NjFEXxdEntfOYgAWpODIUr7XkwPkq4jvRJSFGJkyJrBBSgIEfIlX+FD0/bSHVR6san5b2RlXs8uHvXUD2T+NMGllpb+RkNwuyhyMF+hEkJdQgfS6aFBjza4Mb75STZEcD+ybZ7JOJmIMlia4WHG7P/JIUiNl2FUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336957; c=relaxed/simple;
	bh=xmielT87tz267+8FkC4aKD2qpyXyImdnsGQ8eziLfWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KhdTCEQAvbHaPpounwh8RnliB07DcqnHKi5WIqSU1pqBMc9vo0N8d15yU2oLHtWn1dP2hUQjqLNUqY4pBNYrCguHMV6TENqnCOgcwrAQem5PfI1MrNT5B45tz66LdmRmcvLhco5QJEZ+d3OG9lPYJnTdNmWr+TK/fYO1Bu0R1K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753271F000E9;
	Wed, 29 Jul 2026 14:55:56 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: jic23@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com,
	dave@stgolabs.net
Subject: [PATCH v2 0/9] perf/cxlpmu: Misc sashiko raised issues fixes
Date: Wed, 29 Jul 2026 07:55:46 -0700
Message-ID: <20260729145555.3919550-1-dave.jiang@intel.com>
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

Please give extra scrutiny to patch 3 and ensure the math is correct.

Since v1:
- Updated 3/9 to address sashiko issue.
- No other changes as sashiko only raised issue with pre-existing.

[1]: https://lore.kernel.org/linux-cxl/20260715191454.459673-1-dave@stgolabs.net/

Dave Jiang (9):
  perf/cxl: Program the requested event group on configurable counters
  perf/cxl: Clear stale event fields before reprogramming a counter
  perf/cxl: Fix the counter overflow delta fixup
  perf/cxl: Accept an overflow interrupt on MSI message number 0
  perf/cxl: Keep the overflow interrupt pinned to the managed CPU
  perf/cxl: Unfreeze counters after handling an overflow interrupt
  perf/cxl: Validate the hardware-reported counter width
  perf/cxl: Don't use pmu.dev in IRQ and hotplug callbacks after
    unregister
  perf/cxl: Avoid cpumask_of(-1) when no CPU is assigned

 drivers/perf/cxl_pmu.c | 61 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 50 insertions(+), 11 deletions(-)


base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
-- 
2.55.0

