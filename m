Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39753451988
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Jul 2026 18:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785350378; cv=none; b=t3Z3ZqnDrHok4IeNq0rBDjxAuCZYekP/BE3JaPrvs1eLD/0iaeh7FjD6R2sY5D/QbEh7yJKKjztHqWyA91Gi2Pw+NKFQHoRDqbUoYQ0RJv8vskz9Sk1o9lmR7Bo0uzUWIl+mB7PugI7DhDRdWzT3mYmmUMvz+CVNSd/aEzzW5V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785350378; c=relaxed/simple;
	bh=wxnN+qGhBe6IuV78Od6T4NuLPnJ1LTmDsaJiSs76zMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DQQE1qU/1BfzJKwXmDd0dN+KPdwxiHIYhxuTQdzHxhdZUue2YUpnsBcjK4fhU7VMhxBkRyQWR4EtDp9E+9gvtdR814H4t24XHXgBd1eYzToTlcLfqaxVpocZH0pIiXS21+b2Gvb/83eMaR3zCIRgYIh7IHn/wGJ4K4zQS13qVz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fOo2fY/c; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fOo2fY/c"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61F0F1684;
	Wed, 29 Jul 2026 11:39:31 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E1AA3F66F;
	Wed, 29 Jul 2026 11:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785350375; bh=wxnN+qGhBe6IuV78Od6T4NuLPnJ1LTmDsaJiSs76zMU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fOo2fY/cWfI27/+AvUJ66KuJYjF/ObPU337QH3V5fQbTqvlk25zdbKlL6r3Cc88IV
	 At/XWAxihpM1XI9CyrbJhAawzmigGsmDBUkTzQtkiF+gJXq+iq4AMTEipERAVqE6mP
	 QMDJRcQqctvKIUho9u9BeglC6hTHPnfqBDa+HqLw=
Message-ID: <25ddc6ec-3a8a-4ae5-8f33-e6c71ff354b5@arm.com>
Date: Wed, 29 Jul 2026 19:39:33 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] perf/arm-cmn: Rename filter variables for clarity
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: will@kernel.org, mark.rutland@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 ilkka@os.amperecomputing.com, leo.yan@arm.com
References: <cover.1785252273.git.robin.murphy@arm.com>
 <ae87ea9530b3c2073874035a244f34baf7915def.1785252273.git.robin.murphy@arm.com>
 <20260729102014.000019ea@oss.qualcomm.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260729102014.000019ea@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/07/2026 6:20 pm, Jonathan Cameron wrote:
> On Tue, 28 Jul 2026 16:59:21 +0100
> Robin Murphy <robin.murphy@arm.com> wrote:
> 
>> CMN has already grown many more event-specific filters than the original
>> Occupancy ID, but since they are all independent of each other we've
>> just overloaded them onto the same name. Before we add yet more, and
>> they begin to overlap, rename all our "occupid" variables to "filter" so
>> that things can be a bit clearer and more consistent (but leaving the
>> format attribute itself, to avoid UAPI concerns).
> Hi Robin,
> 
> Drive by review... I'm a bit confused.
> The print out change isn't a ABI change?  I'd at least mention what changes
> around that in the commit message.
> 
> Jonathan
> 
>>
>> Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>
>> v2: No change
>>
>>   drivers/perf/arm-cmn.c | 53 ++++++++++++++++++++++--------------------
>>   1 file changed, 28 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
>> index 50402bc4a21d..2a8a67da72c3 100644
>> --- a/drivers/perf/arm-cmn.c
>> +++ b/drivers/perf/arm-cmn.c
> ...
> 
>> @@ -709,8 +709,8 @@ static ssize_t arm_cmn_event_show(struct device *dev,
>>   				  eattr->type, eattr->eventid);
>>   
>>   	if (eattr->fsel > SEL_NONE)
>> -		return sysfs_emit(buf, "type=0x%x,eventid=0x%x,occupid=0x%x\n",
>> -				  eattr->type, eattr->eventid, eattr->occupid);
>> +		return sysfs_emit(buf, "type=0x%x,eventid=0x%x,filter=0x%x\n",
>> +				  eattr->type, eattr->eventid, eattr->filter);
> 
> Changing the format of this smells like ABI change to me.

This is not a change per the event alias ABI itself[1], since that 
contract is only that these aliases may contain *some* symbolic terms 
which are to be dynamically resolved from the corresponding "format" 
attributes. Both the "occupid" and "filter" format names yield the same 
result, so tools simply parsing the sysfs aliases from scratch as 
intended are entirely unaffected.

The potential UAPI concern alluded to is between *those* tools and any 
higher-level scripts driving them - if those scripts contain 
already-copied or manually-generated event specifiers using an 
"occupid=" term then they would start failing if perf tool (or 
equivalent) could no longer resolve the "occupid" format. Thus although 
we're free to stop referring to it from our own event aliases, we can't 
just remove the old format name altogether. Because unfortunately, such 
scripts definitely do exist[2].

Anyone who was reading the sysfs event attributes expecting to see 
something they already know would have missed the point of the whole 
mechanism so hard I wouldn't even know what to say...

Thanks,
Robin.

[1] i.e. Documentation/ABI/testing/sysfs-bus-event_source-devices-events
[2] 
https://gitlab.arm.com/telemetry-solution/telemetry-solution/-/blob/main/tools/topdown_tool/topdown_tool/cmn_probe/common.py?ref_type=heads#L311

> 
>>   
>>   	return sysfs_emit(buf, "type=0x%x,eventid=0x%x\n", eattr->type,
>>   			  eattr->eventid);

