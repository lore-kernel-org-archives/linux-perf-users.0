Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79623451B3;
	Tue, 22 Sep 2026 01:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790038942; cv=none; b=ry1s1Z9kee6OEspjRnwhEBr+3CfYWKs3Y34AhcYdTZdatUHgTbk3V9oPKlymRkEMO5yUBbMX2RqPL3VDFs4GIYj3MlqOyAW2iTtYWGDYp87XlVjVIv/u7WjxACpt8T0ihOXKer5CZ6rkZ3bTRS0BU6B9cGuFkZmJW31ICX1IlEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790038942; c=relaxed/simple;
	bh=Kjk/2a16qcLn6eOubkotjlhXsgv3swwXAy/nu4kMH90=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nZtJS/F3WExOvM6YvBLWBXb/uXyDHv8FA43ecc7xz1WWL5qyTjx68fdRi3VfBACzaTslj5adchRi1GaUsZIx4GE/plpkaiooAPkNjoILOGC750i2rwwyTK68bmcZ/r4ZQdi8C2q9o2A7mSz9tvhblPqsKtzxhjKvX6ZuUK0wKHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kipl0lEb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kipl0lEb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 603321F000FF;
	Tue, 22 Sep 2026 01:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790038940;
	bh=EnuE7zMmyFoOF46S//+Edh4k7ernbygu7EPdcpMmmHU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kipl0lEbuco0NRAsxSab3ylT8a7j4jP3DCZb6P2Zs5y/njq16bfkmD2ToskvnTyYZ
	 D4UzxkxY02dIGZLol+hxJAAnj6oXKpy76bEg39ISNCnkfcnp8cABfi6Drt1A57Dmyi
	 jUvYi0GUeD0V4uNABok7ja1zSqeJvmjkyB7Qi7AoTgMR6DtXXiWQyTLjlskqtSPTyE
	 4FIdB3EAbdoIgiG5pRjvHRHOubLMpabo1flsVtgJaMgYD/2tq+M4K8jKtcarMcMDs/
	 nLoXbhdPimdqVne3BWMNcFRcBEUvHqpLcD7DVoizYK7gY86ZhtTYBGMUOHmXF8YDqU
	 4+rbjx7A0JBxg==
Date: Tue, 22 Sep 2026 02:02:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org,
 will@kernel.org, mark.rutland@arm.com, dave@stgolabs.net,
 robin.murphy@arm.com, icheng@nvidia.com, Jonathan Cameron
 <jonathan.cameron@oss.qualcomm.com>, Robert Richter <rrichter@amd.com>
Subject: Re: [RESEND PATCH v4 00/11] perf/cxlpmu: Misc sashiko raised issues
 fixes
Message-ID: <20260922020216.2d1776ca@jic23-hlaptop>
In-Reply-To: <20260805155911.1304807-1-dave.jiang@intel.com>
References: <20260805155911.1304807-1-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Aug 2026 08:59:00 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> [resend, mangled linux-cxl mailing addr]
> 
> Teed off of Davidlohr's misc cxlpmu series [1]. I had Claude pick up all
> the sashiko raised issues and then continued multiple internal review
> iterations to pick up a number of fixes. I'm no CXL PMU or perf expert,
> but the fixes look reasonable to me AFAICT.

+CC Robert given Robert is talking about what needs adding to this driver at
LPC and so presumably has hardware (and will send lots of nice patches
for this driver shortly ;)

https://lpc.events/event/20/contributions/2521/


> 
> Since v3:
> - 4/11 and 5/11 swapped, so the one-line MSI vector 0 fix comes before the
>   info->msi_vec rename and backports on its own (Robin).
> - 6/11: new patch, add the PMUs after configuring events.
> - 7/11: no code change; the commit message no longer overstates what
>   dropping IRQF_SHARED costs a device that shares a vector.
> - 8/11: quote the spec sentence that makes the freeze sticky, and correct
>   the claim about what the migration window leaves enabled (Richard,
>   sashiko-bot).
> - 10/11: split the probe-time overflow clear out, so this is back to the
>   single hunk Jonathan acked.
> - 11/11: new patch. Clear a counter's stale overflow status when starting
>   an event, which is where the reuse case bites; the probe clear moved
>   here from 10/11 (Richard).
> 
> Since v2:
> - 1/11: check event_idx alongside counter_idx (Jonathan).
> - 2/11: use FIELD_MODIFY() rather than mask-then-OR (Jonathan).
> - 3/11: rewrite the rationale, no code change (Jonathan).
> - 5/11: new patch, split the MSI vector out of info->irq (Robin, Jonathan).
> - 7/11: drop IRQF_SHARED as well as adding IRQF_NOBALANCING, and retitle
>   (Jonathan, Robin).
> - 8/11: don't unfreeze if the PMU has been disabled meanwhile (Robin,
>   Jonathan).
> - 10/11: retitle, and drop the cxl_pmu_offline_cpu() hunk since that
>   dev_err() cannot be reached (Robin).
> - Dropped the old 9/9 that guarded cpumask_show() against cpumask_of(-1).
>   The init case was a false positive and neither reviewer liked the shape
>   of it (Jonathan, Robin).
> 
> Since v1:
> - Updated 3/9 to address sashiko issue.
> - No other changes as sashiko only raised issue with pre-existing.
> 
> Three follow-ups this series does not attempt:
> 
> cxl_pmu_read() relies on local64_t being same-CPU, which is the only reason
> the interrupt has to be pinned at all. Moving prev_count and event->count
> off local64_t would make the affinity question moot, and Robin may have a
> view on whether that is worth doing.
> 
> cxl_pmu_offline_cpu() still leaves on_cpu at -1 across a sleeping
> perf_pmu_migrate_context(), and still has an unreachable no-target branch.
> Both want removing, possibly on top of the generic PMU hotplug rework
> Jonathan pointed at [2].
> 
> Firmware can leave a counter enabled with Global Freeze on Overflow but not
> Interrupt on Overflow, which stalls the whole CPMU with no interrupt to say
> so. Quiescing the block at probe needs two writes per counter to stay
> within the spec's rule about changing an enabled counter, so it belongs in
> its own patch.
> 
> [1]: https://lore.kernel.org/linux-cxl/20260715191454.459673-1-dave@stgolabs.net/
> [2]: https://lore.kernel.org/linux-arm-kernel/cover.1784911757.git.robin.murphy@arm.com/
> 
> Dave Jiang (11):
>   perf/cxl: Program the requested event group on configurable counters
>   perf/cxl: Clear stale event fields before reprogramming a counter
>   perf/cxl: Fix the counter overflow delta fixup
>   perf/cxl: Accept an overflow interrupt on MSI message number 0
>   perf/cxl: Split the MSI vector out of info->irq
>   cxl/pci: Add the PMUs after configuring events
>   perf/cxl: Don't share the overflow interrupt, and keep it pinned
>   perf/cxl: Unfreeze counters after handling an overflow interrupt
>   perf/cxl: Validate the hardware-reported counter width
>   perf/cxl: Don't log through pmu.dev in the overflow interrupt handler
>   perf/cxl: Clear stale overflow status before using a counter
> 
>  drivers/cxl/pci.c      |  11 +++--
>  drivers/perf/cxl_pmu.c | 107 ++++++++++++++++++++++++++++++++---------
>  2 files changed, 90 insertions(+), 28 deletions(-)
> 
> 
> base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff

