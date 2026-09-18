Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC6F5111BB;
	Fri, 18 Sep 2026 16:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789750267; cv=none; b=suFd3CoMd39FSGwE8Rc5Ia9M5jtH0vanyjUiw6oD3ROhBNA8DOjwhiKYv2LnDOQR0Yt8qqWNdwIaBueMTFJmItO/8miBz37PjaWhV0g96CQKyBllRn0foRq6GHQg7JVoKx/Bv+x54d30HPU+auIk/TwWfjsyWMqEJj4JhYW9Ku0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789750267; c=relaxed/simple;
	bh=+aBtXKzSCgPnEdYubG3WgG6cEqUjkWTqNA6T8x2z/JY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gq4vhA7xPMLEPWrOIwWpKoUaeSWGIRBNs5UoPx8biQr3Xmpp4zk8Hd5uvPl+gSP0rbCk5MuYyCGOVwP+GerNr1aXQWg5MNJ0zLacfoJQ7I6MvTMvxNj0weuUr4W1n+/lhvlmsRv9x5f83qyM53zSwQ5HvJ7H7SptcGNxLaX+wbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e+wjVE5F; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e+wjVE5F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789750264; x=1821286264;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+aBtXKzSCgPnEdYubG3WgG6cEqUjkWTqNA6T8x2z/JY=;
  b=e+wjVE5FPxIuyTwQBGysRvM5roiDKVxb/D/dcEldzp7TZQaG8LrcPF0i
   1cBzm0MoMtQW3FQfaBO7DHgz9s27z7I4avTL2GihzoT50nyfZckIClw5c
   TXooWgvJNPpXmzi7uTCV8JU3iU3WS/G6uU4j1MOTDkG5ylhCUu3u+2wnk
   IMogBAYKexRNUYhVk/VVNP9W/HgnOSDJJyLXASd3X37WSsqMm4/FpJwAe
   /Wm3JIqjY+Si0HhqeUvhHEJbTL1XY6vG5bhiVoEuNYWvXIfPmIL8NhwoT
   J9e0Q7s2C+c+LvFAtYaXJv/26h6pkVwwl44QOlsvs7s90H9xK/w7d2TMU
   A==;
X-CSE-ConnectionGUID: fAFeeeaIRaCgiOj25YnJUA==
X-CSE-MsgGUID: QKcABtzrSSeIKZMHEs6OxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="90402578"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="90402578"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 09:51:01 -0700
X-CSE-ConnectionGUID: HTONxJk7QjCAkIfhDbnncw==
X-CSE-MsgGUID: vMQFgYDhSqqLfBfon8naFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="271161196"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.109.117]) ([10.125.109.117])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 09:50:57 -0700
Message-ID: <f4fca2d4-97de-43ba-baab-24bb0225853d@intel.com>
Date: Fri, 18 Sep 2026 09:50:56 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v4 00/11] perf/cxlpmu: Misc sashiko raised issues
 fixes
To: Ian Rogers <irogers@google.com>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org,
 jic23@kernel.org, will@kernel.org, mark.rutland@arm.com, dave@stgolabs.net,
 robin.murphy@arm.com, icheng@nvidia.com,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
References: <20260805155911.1304807-1-dave.jiang@intel.com>
 <CAP-5=fXoVf5dGua_TJ5CMWFMRwtegiO3v2S96X28vRCfqO+N8Q@mail.gmail.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <CAP-5=fXoVf5dGua_TJ5CMWFMRwtegiO3v2S96X28vRCfqO+N8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/15/26 3:43 PM, Ian Rogers wrote:
> On Wed, Aug 5, 2026 at 9:02 AM Dave Jiang <dave.jiang@intel.com> wrote:
>>
>> [resend, mangled linux-cxl mailing addr]
>>
>> Teed off of Davidlohr's misc cxlpmu series [1]. I had Claude pick up all
>> the sashiko raised issues and then continued multiple internal review
>> iterations to pick up a number of fixes. I'm no CXL PMU or perf expert,
>> but the fixes look reasonable to me AFAICT.
>>
>> Since v3:
>> - 4/11 and 5/11 swapped, so the one-line MSI vector 0 fix comes before the
>>   info->msi_vec rename and backports on its own (Robin).
>> - 6/11: new patch, add the PMUs after configuring events.
>> - 7/11: no code change; the commit message no longer overstates what
>>   dropping IRQF_SHARED costs a device that shares a vector.
>> - 8/11: quote the spec sentence that makes the freeze sticky, and correct
>>   the claim about what the migration window leaves enabled (Richard,
>>   sashiko-bot).
>> - 10/11: split the probe-time overflow clear out, so this is back to the
>>   single hunk Jonathan acked.
>> - 11/11: new patch. Clear a counter's stale overflow status when starting
>>   an event, which is where the reuse case bites; the probe clear moved
>>   here from 10/11 (Richard).
>>
>> Since v2:
>> - 1/11: check event_idx alongside counter_idx (Jonathan).
>> - 2/11: use FIELD_MODIFY() rather than mask-then-OR (Jonathan).
>> - 3/11: rewrite the rationale, no code change (Jonathan).
>> - 5/11: new patch, split the MSI vector out of info->irq (Robin, Jonathan).
>> - 7/11: drop IRQF_SHARED as well as adding IRQF_NOBALANCING, and retitle
>>   (Jonathan, Robin).
>> - 8/11: don't unfreeze if the PMU has been disabled meanwhile (Robin,
>>   Jonathan).
>> - 10/11: retitle, and drop the cxl_pmu_offline_cpu() hunk since that
>>   dev_err() cannot be reached (Robin).
>> - Dropped the old 9/9 that guarded cpumask_show() against cpumask_of(-1).
>>   The init case was a false positive and neither reviewer liked the shape
>>   of it (Jonathan, Robin).
>>
>> Since v1:
>> - Updated 3/9 to address sashiko issue.
>> - No other changes as sashiko only raised issue with pre-existing.
>>
>> Three follow-ups this series does not attempt:
>>
>> cxl_pmu_read() relies on local64_t being same-CPU, which is the only reason
>> the interrupt has to be pinned at all. Moving prev_count and event->count
>> off local64_t would make the affinity question moot, and Robin may have a
>> view on whether that is worth doing.
>>
>> cxl_pmu_offline_cpu() still leaves on_cpu at -1 across a sleeping
>> perf_pmu_migrate_context(), and still has an unreachable no-target branch.
>> Both want removing, possibly on top of the generic PMU hotplug rework
>> Jonathan pointed at [2].
>>
>> Firmware can leave a counter enabled with Global Freeze on Overflow but not
>> Interrupt on Overflow, which stalls the whole CPMU with no interrupt to say
>> so. Quiescing the block at probe needs two writes per counter to stay
>> within the spec's rule about changing an enabled counter, so it belongs in
>> its own patch.
>>
>> [1]: https://lore.kernel.org/linux-cxl/20260715191454.459673-1-dave@stgolabs.net/
>> [2]: https://lore.kernel.org/linux-arm-kernel/cover.1784911757.git.robin.murphy@arm.com/
> 
> 
> Thanks Dave, I notice that everything seems ready to land for this
> series. Is there anything pending? Sashiko mentioned pre-existing
> issues.

Hi Ian. Nothing is pending. Don't plan to address the pre-existing issues in the current series. Will look at follow-ups once this series is picked up. Thanks!

> 
> Thanks,
> Ian
> 
>> Dave Jiang (11):
>>   perf/cxl: Program the requested event group on configurable counters
>>   perf/cxl: Clear stale event fields before reprogramming a counter
>>   perf/cxl: Fix the counter overflow delta fixup
>>   perf/cxl: Accept an overflow interrupt on MSI message number 0
>>   perf/cxl: Split the MSI vector out of info->irq
>>   cxl/pci: Add the PMUs after configuring events
>>   perf/cxl: Don't share the overflow interrupt, and keep it pinned
>>   perf/cxl: Unfreeze counters after handling an overflow interrupt
>>   perf/cxl: Validate the hardware-reported counter width
>>   perf/cxl: Don't log through pmu.dev in the overflow interrupt handler
>>   perf/cxl: Clear stale overflow status before using a counter
>>
>>  drivers/cxl/pci.c      |  11 +++--
>>  drivers/perf/cxl_pmu.c | 107 ++++++++++++++++++++++++++++++++---------
>>  2 files changed, 90 insertions(+), 28 deletions(-)
>>
>>
>> base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
>> --
>> 2.54.0
>>
>>

