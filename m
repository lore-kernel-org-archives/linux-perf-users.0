Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09BF421255;
	Mon,  3 Aug 2026 17:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777664; cv=none; b=HPbrldBY9SknK63HWEI59ocpBi//fFlxy0HxG+sIWwEN+BwIycFhVgjvTvkB03GPQIqyXz9+QFDog5rgQX6r69faHOCFo7zrPmH2sXzZM71/GRxVDcNyp/TIodVZDdNjOM0W5QhLDlKgdu/A/3hxGkpbCKodd22i8aR6Q2n6gwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777664; c=relaxed/simple;
	bh=6CnFkG9LXI17KmuvQVP3wyXFtIz8bQdBghV0XA7gMvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VakwiPXMAen7khnD53HJFPrhRjrVDtW6EFUYN1givG2uO6fGynMnHLuIFyptq/wvz+FXIx1ZXLqU0l2nfMAgVRPgoAUCKTT0NC2CIfFcLOnASlFD/eE6/fujLsZgVhbDLn8S4V1y8LecZopMKnDX08aaCGifw31awXlQXAGASa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nhwwf6qm; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nhwwf6qm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785777661; x=1817313661;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6CnFkG9LXI17KmuvQVP3wyXFtIz8bQdBghV0XA7gMvw=;
  b=Nhwwf6qmyumNftp/SU/IK2NoCHFKbIpTcVzM1QlrxPVum8i9e0+KMfle
   G+uNFiGt1ZiUPcIBG5JYRCVJ9/2fVo49HeTafCyB6DipG482SHNbUOBPW
   mEgwzmiPd4wS6WDS3qRL8l1sTcSg93sqKftwVg+25sSgCMk9930MyuM1y
   RdKs5ZwyHhQztKQ5s1cOeynQ5z1G5ILCfL5BOMnouZShxbFfPy+V54a6h
   YNIBsN5O9Uusb1MzuuXnyKRq668X63XhhaDuKTaxF7kgtT/qeFxtpVU8M
   pWDAHJMBwGOBAmomXQY3B+qmd19V1aLqfwwZcNQDaP5n9zWmllxjBfWQO
   w==;
X-CSE-ConnectionGUID: F7A97BCcRqSAt7e5jfzA3Q==
X-CSE-MsgGUID: v3mZVrdnRY2Y7LdzFARs7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="85451686"
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="85451686"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 10:20:57 -0700
X-CSE-ConnectionGUID: KLUPn4yWQKefcFAnZeEmGg==
X-CSE-MsgGUID: 4LPdYXsTQWuZWmyI5dcPNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="257368994"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.108.187]) ([10.125.108.187])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 09:39:45 -0700
Message-ID: <fb57cfe8-cb70-4e4f-8fea-77e82bf1cb68@intel.com>
Date: Mon, 3 Aug 2026 09:39:44 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 9/9] perf/cxl: Don't log through pmu.dev in the
 overflow interrupt handler
To: Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org,
 jic23@kernel.org, will@kernel.org, mark.rutland@arm.com, dave@stgolabs.net,
 robin.murphy@arm.com, sashiko-bot@kernel.org
References: <20260731232827.401447-1-dave.jiang@intel.com>
 <20260731232827.401447-10-dave.jiang@intel.com> <anAVpO--i5heVfz9@MWDK4CY14F>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <anAVpO--i5heVfz9@MWDK4CY14F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/2/26 10:29 PM, Richard Cheng wrote:
> On Fri, Jul 31, 2026 at 04:28:27PM +0800, Dave Jiang wrote:
>> perf_pmu_unregister() frees pmu->dev without clearing the pointer, and
>> cxl_pmu_probe() registers its devm actions so that teardown runs
>> perf_pmu_unregister() first, then the hotplug instance removal, then
>> free_irq(). Nothing before free_irq() masks the interrupt, so the handler
>> stays live across a window where info->pmu.dev is freed and its dev_dbg()
>> walks that pointer.
>>
>> Unsharing the interrupt does not close that window. cxl_pmu_event_stop()
>> leaves the counter's overflow status bit set, and only the handler clears
>> it, so an overflow taken just before teardown is still delivered and still
>> gets past the "did anything overflow" early-out. It lands in the !event
>> branch, where the dev_dbg() is.
>>
>> Log through info->pmu.parent instead, which is devm-managed and outlives
>> every teardown action.
>>
>> Clear the overflow status before requesting the interrupt too, since the
>> driver never touched it at probe and a counter left enabled with
>> INT_ON_OVRFLW by firmware or a previous kernel can raise an interrupt at
>> any point.
>>
>> Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
>> Reported-by: sashiko-bot@kernel.org
>> Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
>> Assisted-by: Claude:claude-opus-4-8
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> v3:
>> - Clear CXL_PMU_OVERFLOW_REG at probe, before the handler is armed. A stale
>>   status bit from firmware can cause overflow interrupt. (Robin)
>> - Ack dropped as the patch grew a hunk.
>> - Drop the cxl_pmu_offline_cpu() hunk. That dev_err() cannot be reached.
>> ---
>>  drivers/perf/cxl_pmu.c | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
>> index 37742ce43d9f..3683427fbb7e 100644
>> --- a/drivers/perf/cxl_pmu.c
>> +++ b/drivers/perf/cxl_pmu.c
>> @@ -806,7 +806,7 @@ static irqreturn_t cxl_pmu_irq(int irq, void *data)
>>  		struct perf_event *event = info->hw_events[i];
>>  
>>  		if (!event) {
>> -			dev_dbg(info->pmu.dev,
>> +			dev_dbg(info->pmu.parent,
>>  				"overflow but on non enabled counter %d\n", i);
>>  			continue;
>>  		}
>> @@ -903,6 +903,15 @@ static int cxl_pmu_probe(struct device *dev)
>>  	if (!irq_name)
>>  		return -ENOMEM;
>>  
>> +	/*
>> +	 * Clear any overflow status left set by firmware or a previous kernel
>> +	 * before the handler goes live, so it cannot mistake a stale bit for an
>> +	 * overflow on a counter no event owns yet. The register is RW1C, and
>> +	 * bits above the implemented counters are RsvdZ, so only write those.
>> +	 */
>> +	writeq(GENMASK_ULL(info->num_counters - 1, 0),
>> +	       info->base + CXL_PMU_OVERFLOW_REG);
>> +
> 
> Hi Dave,
> 
> I have a question here, since you are adding a clear, event_start() covers more than probe does. The block is frozen there, and it closes the reuse case as well as the boot one.
> If a counter's overflow MSI is still in flight when perf reschedule that counter
> to another event, the handler charges the full period to an event whose
> prev_count was just zeroed.

You are correct. v4 will add to event_start():
	writeq(BIT_ULL(hwc->idx), base + CXL_PMU_OVERFLOW_REG);


> 
> Also if FW can leave a counter enabled, I'm not sure whether it's possible or not, but if that's the case, is clearing the status bit enough?
> A leftoever counter with Global Freeze on Overflow but not Interrupt on Overflow
> will wrap, freeze the whole CPMU, and raise nothing.

Also right. This series is already large enough. Will have follow on patches to address this.

> 
> Best regards,
> Richard Cheng.
> 
> 
> 
>>  	/*
>>  	 * The handler must run on info->on_cpu, so the interrupt cannot be
>>  	 * shared - IRQF_NOBALANCING is only honoured for the first action on a
>> -- 
>> 2.55.0
>>
>>

