Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8826125F7B9;
	Fri, 31 Jul 2026 23:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785540510; cv=none; b=D2Ty48RH1aiaXyXaW0pui/ZLNZLKNVeFKNpDAY9G9JO1mJos67pB/MTBKJwvJIqA+TZ4/j+dXEGh6F7v+qyPY449KbuygHZyiGKt/CWJAOdRFeyZGg7nvwtgPhZPNC6rA0gO+ZdItIK6qxXQhrdWaU1NwUcF8MxAt77Z7ZrXGxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785540510; c=relaxed/simple;
	bh=iiEkSAAwx55Zn5peXJTzFixohV/NENi3eyR9Kg3paYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qNeNfT7oqgrKuIF5ySDIjA96UU+efkZRVpzO312vdFY6DpiInd6XVtnbLkcn7tbQBwIzERqebTUeYGjeZFh1ihgYwCrf3wtQNrNazMWyqnWq2wqZAKO4kJp/qwvM4m4YzJ0ZUD1qjgsXYfwZZtH/Dwsd/wV5fBjhppRVs6y/NV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F3B1F00AC4;
	Fri, 31 Jul 2026 23:28:29 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: jic23@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com,
	dave@stgolabs.net,
	robin.murphy@arm.com,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v3 0/9] perf/cxlpmu: Misc sashiko raised issues fixes
Date: Fri, 31 Jul 2026 16:28:18 -0700
Message-ID: <20260731232827.401447-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Teed off of Davidlohr's misc cxlpmu series [1]. I had Claude pick up all
the sashiko raised issues and then continued multiple internal review
iterations to pick up a number of fixes. I'm no CXL PMU or perf expert,
but the fixes look reasonable to me AFAICT.

Since v2:
- 1/9: check event_idx alongside counter_idx (Jonathan).
- 2/9: use FIELD_MODIFY() rather than mask-then-OR, for the four fields
  that can carry a stale value (Jonathan).
- 3/9: rewrite the rationale, no code change (Jonathan).
- 4/9: new patch, split the MSI vector out of info->irq (Robin, Jonathan).
- 5/9: was 4/9, now tests info->msi_vec. Fix unchanged.
- 6/9: was 5/9, retitled. Drop IRQF_SHARED as well as adding
  IRQF_NOBALANCING (Jonathan, Robin). Review tags dropped as the patch
  grew.
- 7/9: was 6/9. Don't unfreeze if the PMU has been disabled meanwhile
  (Robin, Jonathan). Review tag dropped as the patch grew a hunk.
- 8/9: was 7/9, unchanged.
- 9/9: was 8/9, retitled. Drop the cxl_pmu_offline_cpu() hunk, and clear
  the overflow status at probe so a stale bit from firmware cannot reach
  the handler (Robin). Ack dropped as the patch grew a hunk.
- dropped: the old 9/9 (cpumask_of(-1) guard).

Since v1:
- Updated 3/9 to address sashiko issue.
- No other changes as sashiko only raised issue with pre-existing.

Two follow-ups this series does not attempt. cxl_pmu_read() relies on
local64_t being same-CPU, which is the only reason the interrupt has to be
pinned at all; moving prev_count and event->count off local64_t would make
that moot and Robin may have a view on whether it is worth it. And the
on_cpu transient plus dead branch above want the same patch, possibly on
top of the generic PMU hotplug rework Jonathan pointed at [2].

[1]: https://lore.kernel.org/linux-cxl/20260715191454.459673-1-dave@stgolabs.net/
[2]: https://lore.kernel.org/linux-arm-kernel/cover.1784911757.git.robin.murphy@arm.com/

Dave Jiang (9):
  perf/cxl: Program the requested event group on configurable counters
  perf/cxl: Clear stale event fields before reprogramming a counter
  perf/cxl: Fix the counter overflow delta fixup
  perf/cxl: Split the MSI vector out of info->irq
  perf/cxl: Accept an overflow interrupt on MSI message number 0
  perf/cxl: Don't share the overflow interrupt, and keep it pinned
  perf/cxl: Unfreeze counters after handling an overflow interrupt
  perf/cxl: Validate the hardware-reported counter width
  perf/cxl: Don't log through pmu.dev in the overflow interrupt handler

 drivers/perf/cxl_pmu.c | 88 +++++++++++++++++++++++++++++++-----------
 1 file changed, 65 insertions(+), 23 deletions(-)


base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
-- 
2.55.0

