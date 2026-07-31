Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4F61F94F;
	Fri, 31 Jul 2026 00:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785456684; cv=none; b=kXQ4ZQl4gzZEfVAkjokHp/8UP5tZ47YLKVXTo3fpV8+IdxsI3rLPhdAfoo0hPnukPq8Zitg14dX5d4110tCTemWnuNjiif+R1K7A9XfQJoLNbDaT/18TSoJ659dOpnm3rCcCwop3ZqkPewMa6ypibi08UCKETnCL6qmPeslksgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785456684; c=relaxed/simple;
	bh=EkDpzVxoha4JSFgC4RJPD/ZleGAhmY6mLsUikmZJMss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XoOuaUvRD8LS9VO3yKEUdhlL7mGw6Eezpdajuamt2mgu+Ug3VPFYx3ZNfjLcSlh1GvDXzv/gpLzS9BPuzuihz3j2lW+5FfqIHHy89pf56AB7e81VB0e44zHJXB2geDTxERqoR/9HRVAbsH2s2pdhA0s/o2flMIVSZcJ5XHSAHu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hXqh6sFy; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hXqh6sFy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785456683; x=1816992683;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EkDpzVxoha4JSFgC4RJPD/ZleGAhmY6mLsUikmZJMss=;
  b=hXqh6sFyPtrh/ZO6OThD+sxu0GG5TFnzoUyzFT2QQSL1jggjGiD5shXd
   RfjUFjY2AH3voupQDiWhbrX80gxEYk9ykdrfFjrfMgvvOIMlaAViDd+ui
   jApyYHSUiZmjr+zOHF3zCmGkNpTkSEuAOZpfH1+OzoJzSeUzZ5BNE4UNW
   AphIPFWhTUVTyu5R3lY81tqpAcUbZY1XAo2MncznDmuyyKZMUBvhsphde
   qz8RDpE5Nss6sRpr69bWb7CERHmt9pceQ4EPnN/Ys9fV6zq6SQMBAaQZ3
   JS50F4W3jQBvUsNI/r5II7hn53yKPUWga9ntAQ6kxMMYVWDGFw/4fKtuO
   Q==;
X-CSE-ConnectionGUID: Indo9C8yTheyV3WW3M/Y6A==
X-CSE-MsgGUID: ffSAmmKgSvmMXevRn4Q8sA==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="97599442"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="97599442"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 17:11:22 -0700
X-CSE-ConnectionGUID: eIbBzUtmTTW0rJR6FUfaqA==
X-CSE-MsgGUID: hDotel4UShyy9Gq1s6efsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="285039298"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO [10.125.111.248]) ([10.125.111.248])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 17:11:21 -0700
Message-ID: <fa12f874-c594-4cdb-94ea-4a53aad11c8f@intel.com>
Date: Thu, 30 Jul 2026 17:11:20 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] perf/cxl: Avoid cpumask_of(-1) when no CPU is
 assigned
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org,
 will@kernel.org, mark.rutland@arm.com, dave@stgolabs.net,
 sashiko-bot@kernel.org, Robin Murphy <robin.murphy@arm.com>
References: <20260729145555.3919550-1-dave.jiang@intel.com>
 <20260729145555.3919550-10-dave.jiang@intel.com>
 <20260729201446.62732044@jic23-huawei>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260729201446.62732044@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/29/26 12:14 PM, Jonathan Cameron wrote:
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
> 
> Can we just use the generic stuff?  Maybe need Robin's stuff to add init / exit
> per driver calls. 
> https://lore.kernel.org/linux-arm-kernel/cover.1784911757.git.robin.murphy@arm.com/

I'll drop this patch for now.

DJ

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
>>  drivers/perf/cxl_pmu.c | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
>> index f42238b2b6b0..6aad381c0376 100644
>> --- a/drivers/perf/cxl_pmu.c
>> +++ b/drivers/perf/cxl_pmu.c
>> @@ -501,8 +501,17 @@ static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr,
>>  			    char *buf)
>>  {
>>  	struct cxl_pmu_info *info = dev_get_drvdata(dev);
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
>>  }
>>  static DEVICE_ATTR_RO(cpumask);
>>  
> 

