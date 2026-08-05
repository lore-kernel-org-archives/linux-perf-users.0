Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8603F39E4;
	Wed,  5 Aug 2026 15:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785945562; cv=none; b=fbHs9h5OBOoUWckLp3zqs8oXmT2jvXFKuKfcHOU2+L9hjiE7OyEzYxNRvSS+fTyEL3O9B3/Q1FboMALRoeNFyei9QsvbfKvKeO62QBg54l/qfLR5hIVQ7pk2B4Q3KHRdDWihMHEJ+jw7aVISP+yw1nNY5sqrjMZCpd0wwzE1vCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785945562; c=relaxed/simple;
	bh=WxTTlLBXy0u/aIHvYaKkertGCiP/7Tl/6zsathxXMaY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s7Y0JlY4tAo6R3Pu4w0IgN8sgeFk+hGBX2mWB+EpvXkOXedb7X0oXZfcqDM3rkBpPdw4JtwFtBAj6H+QEBNiOFgaA6ztggPR9DRBw+r7IirY8um6kH5Z6rPogGDo8VSw+QgDF4wW5uIK/OWZ+yJLwxuTsPapl+ZYqUQVgyAD8To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E0561F000E9;
	Wed,  5 Aug 2026 15:59:13 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: jic23@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com,
	dave@stgolabs.net,
	robin.murphy@arm.com,
	icheng@nvidia.com,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [RESEND PATCH v4 00/11] perf/cxlpmu: Misc sashiko raised issues fixes
Date: Wed,  5 Aug 2026 08:59:00 -0700
Message-ID: <20260805155911.1304807-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[resend, mangled linux-cxl mailing addr]

Teed off of Davidlohr's misc cxlpmu series [1]. I had Claude pick up all
the sashiko raised issues and then continued multiple internal review
iterations to pick up a number of fixes. I'm no CXL PMU or perf expert,
but the fixes look reasonable to me AFAICT.

Since v3:
- 4/11 and 5/11 swapped, so the one-line MSI vector 0 fix comes before the
  info->msi_vec rename and backports on its own (Robin).
- 6/11: new patch, add the PMUs after configuring events.
- 7/11: no code change; the commit message no longer overstates what
  dropping IRQF_SHARED costs a device that shares a vector.
- 8/11: quote the spec sentence that makes the freeze sticky, and correct
  the claim about what the migration window leaves enabled (Richard,
  sashiko-bot).
- 10/11: split the probe-time overflow clear out, so this is back to the
  single hunk Jonathan acked.
- 11/11: new patch. Clear a counter's stale overflow status when starting
  an event, which is where the reuse case bites; the probe clear moved
  here from 10/11 (Richard).

Since v2:
- 1/11: check event_idx alongside counter_idx (Jonathan).
- 2/11: use FIELD_MODIFY() rather than mask-then-OR (Jonathan).
- 3/11: rewrite the rationale, no code change (Jonathan).
- 5/11: new patch, split the MSI vector out of info->irq (Robin, Jonathan).
- 7/11: drop IRQF_SHARED as well as adding IRQF_NOBALANCING, and retitle
  (Jonathan, Robin).
- 8/11: don't unfreeze if the PMU has been disabled meanwhile (Robin,
  Jonathan).
- 10/11: retitle, and drop the cxl_pmu_offline_cpu() hunk since that
  dev_err() cannot be reached (Robin).
- Dropped the old 9/9 that guarded cpumask_show() against cpumask_of(-1).
  The init case was a false positive and neither reviewer liked the shape
  of it (Jonathan, Robin).

Since v1:
- Updated 3/9 to address sashiko issue.
- No other changes as sashiko only raised issue with pre-existing.

Three follow-ups this series does not attempt:

cxl_pmu_read() relies on local64_t being same-CPU, which is the only reason
the interrupt has to be pinned at all. Moving prev_count and event->count
off local64_t would make the affinity question moot, and Robin may have a
view on whether that is worth doing.

cxl_pmu_offline_cpu() still leaves on_cpu at -1 across a sleeping
perf_pmu_migrate_context(), and still has an unreachable no-target branch.
Both want removing, possibly on top of the generic PMU hotplug rework
Jonathan pointed at [2].

Firmware can leave a counter enabled with Global Freeze on Overflow but not
Interrupt on Overflow, which stalls the whole CPMU with no interrupt to say
so. Quiescing the block at probe needs two writes per counter to stay
within the spec's rule about changing an enabled counter, so it belongs in
its own patch.

[1]: https://lore.kernel.org/linux-cxl/20260715191454.459673-1-dave@stgolabs.net/
[2]: https://lore.kernel.org/linux-arm-kernel/cover.1784911757.git.robin.murphy@arm.com/

Dave Jiang (11):
  perf/cxl: Program the requested event group on configurable counters
  perf/cxl: Clear stale event fields before reprogramming a counter
  perf/cxl: Fix the counter overflow delta fixup
  perf/cxl: Accept an overflow interrupt on MSI message number 0
  perf/cxl: Split the MSI vector out of info->irq
  cxl/pci: Add the PMUs after configuring events
  perf/cxl: Don't share the overflow interrupt, and keep it pinned
  perf/cxl: Unfreeze counters after handling an overflow interrupt
  perf/cxl: Validate the hardware-reported counter width
  perf/cxl: Don't log through pmu.dev in the overflow interrupt handler
  perf/cxl: Clear stale overflow status before using a counter

 drivers/cxl/pci.c      |  11 +++--
 drivers/perf/cxl_pmu.c | 107 ++++++++++++++++++++++++++++++++---------
 2 files changed, 90 insertions(+), 28 deletions(-)


base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
-- 
2.54.0

