Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD763FCB11;
	Thu, 30 Jul 2026 09:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785404202; cv=none; b=aH8jPNwtZvKQMP8MvRjzwiILpPAmekAcrKuLEPWaKuycPY3QtAUcLyTWvUI2UPAbiwUdIrY6JTDp+1ML6BFanTTMCzVwspvdgcOuisOt4ncw47ck2HdUelQymkol9aVQ92N2J3Z9E8jbQ4ZGg89AGMCRXdKdXRjE0dInxFZCjf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785404202; c=relaxed/simple;
	bh=sbiS7/mhJqPdX+9Zj95HBA4DYxZrYAH88hJZ7+G/CDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aXlOhxELTGsBahZ0ljSJ3VSGAR+/ZKuHoTE+iV8ee8dMC4pUda50bG36qYCqW3PfFSEq3GVZ1T70cLH9+UoNxP2Ce14KIoXwdw3qsYWLTzaxSrAC2C5pgcStTWem3xR4gGTSLb/q8ufpxEnBlq6h/xqljbcI6buOqk7Ds+DzmDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Sf61sdsx; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Sf61sdsx"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2EEEE1684;
	Thu, 30 Jul 2026 02:36:36 -0700 (PDT)
Received: from [10.57.84.210] (unknown [10.57.84.210])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03D6B3F763;
	Thu, 30 Jul 2026 02:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785404200; bh=sbiS7/mhJqPdX+9Zj95HBA4DYxZrYAH88hJZ7+G/CDE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Sf61sdsxxkyXEpyxPvQgL5mK5opxyaScjYjKS2vh+DGOW7QiIMXABx13Y0sYZiN1C
	 FcD59ESbbC1jz2E5JqvR+1cdi25d4Gv7J35x8k3fTORuBzAco6FzzdoGTHN69MzhJW
	 b0COYItRaxjJ+j60e6iYpN0qEO1cxNqEeVW6jM2o=
Message-ID: <822d1d81-4657-45e9-8857-843f35c327a2@arm.com>
Date: Thu, 30 Jul 2026 10:36:29 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] perf/cxl: Avoid cpumask_of(-1) when no CPU is
 assigned
To: Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org,
 will@kernel.org, mark.rutland@arm.com, dave@stgolabs.net,
 sashiko-bot@kernel.org
References: <20260729145555.3919550-1-dave.jiang@intel.com>
 <20260729145555.3919550-10-dave.jiang@intel.com>
 <20260729201446.62732044@jic23-huawei>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260729201446.62732044@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-07-29 8:14 pm, Jonathan Cameron wrote:
> On Wed, 29 Jul 2026 07:55:55 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> cpumask_show() feeds info->on_cpu straight into cpumask_of() for the
>> world-readable cpumask sysfs attribute. on_cpu is -1 before the first
>> hotplug online callback and transiently in cxl_pmu_offline_cpu() before a
>> new target is chosen. cpumask_of(-1) treats the CPU number as unsigned and
>> does out-of-bounds pointer arithmetic in get_cpu_mask(), so a concurrent
>> read of the attribute dereferences a wild pointer and can fault -- a local
>> denial of service.
>>
> 
> I'm not keen on the solution here.
> 
> The transient state is ugly anyway. We can just move setting it to -1 into
> the dummy code that deals with that well known case of you have CPUs online
> and code is still running.
> 
> The init case looks like a false positive to me.  But maybe I'm missing stuff.
> The perf registration that surfaces the sysfs happens after hotplug handler is
> added and I believe that synchronously runs it for CPUs that are already up.
> Given we are running code (and CXL stuff isn't super early) something will
> be up so it won't remain -1 by the time of use.

Yup, this is pure nonsensical AI gibberish. The only PMUs which might 
ever need to take care in this respect are those which can only 
associate with a fixed subset of CPUs (e.g. arm_dsu_pmu), where that set 
could potentially all be offlined while still leaving other CPUs capable 
of calling the driver.

If one _could_ offline the last CPU in the system (which hotplug doesn't 
allow for obvious reasons), the "local denial of service" would be 
rather larger than one random sysfs file...

> Can we just use the generic stuff?  Maybe need Robin's stuff to add init / exit
> per driver calls.
> https://lore.kernel.org/linux-arm-kernel/cover.1784911757.git.robin.murphy@arm.com/

Indeed for arbitrary CXL devices I'm not sure the existing x86 uncore 
scopes would fit, but feedback on my patch is welcome! ;)

Thanks,
Robin.

> 
> In general, I'd like Robin to take a quick look at the more generic perf
> parts of this series given he has clearly been deep in this stuff a lot
> more recently than me :)
> 
> Jonathan
> 
>> Read on_cpu once and emit an empty mask when it is negative.
>>
>> Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
>> Reported-by: sashiko-bot@kernel.org
>> Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
>> Assisted-by: Claude:claude-opus-4-8
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   drivers/perf/cxl_pmu.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
>> index f42238b2b6b0..6aad381c0376 100644
>> --- a/drivers/perf/cxl_pmu.c
>> +++ b/drivers/perf/cxl_pmu.c
>> @@ -501,8 +501,17 @@ static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr,
>>   			    char *buf)
>>   {
>>   	struct cxl_pmu_info *info = dev_get_drvdata(dev);
>> +	int cpu = READ_ONCE(info->on_cpu);
>>   
>> -	return cpumap_print_to_pagebuf(true, buf, cpumask_of(info->on_cpu));
>> +	/*
>> +	 * on_cpu is -1 before the first online callback and transiently during
>> +	 * cxl_pmu_offline_cpu(). cpumask_of(-1) computes an out-of-bounds
>> +	 * pointer, so report an empty mask instead.
>> +	 */
>> +	if (cpu < 0)
>> +		return sysfs_emit(buf, "\n");
>> +
>> +	return cpumap_print_to_pagebuf(true, buf, cpumask_of(cpu));
>>   }
>>   static DEVICE_ATTR_RO(cpumask);
>>   
> 

