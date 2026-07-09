Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C023B19D1
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jul 2026 19:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783624827; cv=none; b=IcQLph149pXV5UdQjhrtBlgIm8VwOQwoaCSONCiXIohGyAwo0RQ7wfD5YBOIR3shN/yTwgIagvJuP0OmJTdHKe58GpkQHkBfOvCuNax9CfBvNNzVIW1TG5fLbO7hzO6S7FbFB8yPpAvkRyNIuyZUW11sysQ2wkMsmrdA/LhrYNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783624827; c=relaxed/simple;
	bh=gJZyg9aZnNVaQHMBJUbzs8vTjWnAnXA0CgT5tkdOYyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O8B/8hNDKpzCIjt2G/1QmZRr65r0eXWIIS4aXZnesgsCa9CUYWHXNXcbMa+Ufvp1m0SKz78hwlAIxFZovaA8tvKghEPM5XC4YDhtfe5tIBSyxk0TOt69kgvk/ZVFoobdCPvnHoQMFV9CoOgdBBTOIUnyrTaSz4lgXTQPYfppkiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=SbhzWdwd; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="SbhzWdwd"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1979624C0;
	Thu,  9 Jul 2026 12:20:20 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FC133FC81;
	Thu,  9 Jul 2026 12:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783624824; bh=gJZyg9aZnNVaQHMBJUbzs8vTjWnAnXA0CgT5tkdOYyc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SbhzWdwdMZaRpaCIqIayjgQ9Ekxmsqhmsdwuc/JpOHjccnB6Ec2vpO4KVlqlM3dIh
	 HE5YGTXJK0oqx/zuccxDjoHMBbQ8m94TgXIREaKzEjZVa3uGEjJvUDZMMDRw+zhny5
	 sqqFf9gzxrpe15HSKOyo6V4ofNWiWGcF5bc8K9f8=
Message-ID: <6863f924-66be-4b3a-be46-18cbfd809488@arm.com>
Date: Thu, 9 Jul 2026 20:20:21 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] perf/arm-cmn: Support CMN S3 r2
To: Leo Yan <leo.yan@arm.com>
Cc: will@kernel.org, mark.rutland@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 ilkka@os.amperecomputing.com
References: <cover.1782830759.git.robin.murphy@arm.com>
 <1ce69a1cb72da220caa6bc83eb8ce74e295b595e.1782830759.git.robin.murphy@arm.com>
 <20260709170954.GH1024232@e132581.arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260709170954.GH1024232@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/07/2026 6:09 pm, Leo Yan wrote:
> On Tue, Jun 30, 2026 at 04:19:20PM +0100, Robin Murphy wrote:
> 
> [...]
> 
>> @@ -913,7 +956,12 @@ static umode_t arm_cmn_event_attr_is_visible(struct kobject *kobj,
>>   	CMN_EVENT_ATTR(_model, _name##_group1_read, _type, _event, SEL_CBUSY_SNTHROTTLE_SEL, 3), \
>>   	CMN_EVENT_ATTR(_model, _name##_group1_write, _type, _event, SEL_CBUSY_SNTHROTTLE_SEL, 4), \
>>   	CMN_EVENT_ATTR(_model, _name##_read, _type, _event, SEL_CBUSY_SNTHROTTLE_SEL, 5), \
>> -	CMN_EVENT_ATTR(_model, _name##_write, _type, _event, SEL_CBUSY_SNTHROTTLE_SEL, 6)
>> +	CMN_EVENT_ATTR(_model, _name##_write, _type, _event, SEL_CBUSY_SNTHROTTLE_SEL, 6), \
>> +	CMN_EVENT_ATTR(CMNS3R2, _name##_ccg_read, _type, _event, SEL_CBUSY_SNTHROTTLE_SEL, 9), \
>> +	CMN_EVENT_ATTR(CMNS3R2, _name##_ccg_write, _type, _event, SEL_CBUSY_SNTHROTTLE_SEL, 10), \
>> +	CMN_EVENT_ATTR(CMNS3R2, _name##_lbt_read, _type, _event, SEL_CBUSY_SNTHROTTLE_SEL, 11), \
>> +	CMN_EVENT_ATTR(CMNS3R2, _name##_lbt_write, _type, _event, SEL_CBUSY_SNTHROTTLE_SEL, 12), \
>> +	CMN_EVENT_ATTR(CMNS3R2, _name##_lbt, _type, _event, SEL_CBUSY_SNTHROTTLE_SEL, 13)
> 
> If these CMN_EVENT_ATTR(CMNS3R2, ...) entries are appended to
> CMN_EVENT_HN_SNT(), they will extend the CMNS3R2 attributes for other
> models as well. For example:
> 
>    CMN_EVENT_HNF_SNT(CMN700, sn_throttle, 0x2a),
> 
> This would also add the CMNS3R2 attributes to CMN700. Is this intended?

Yes, hence why the new values hard-code CMNS3R2 at this level rather 
than the incoming _model argument, so the additional attributes should 
still end up being hidden by arm_cmn_event_attr_is_visible() on anything 
else (indeed that probably won't scale well for the *next* CMN model, 
but for now that's future Robin's problem...)

As for the other angle, the documentation is not at all clear what 
applies if an instance of S3 r2 itself were to have HN-Fs rather than 
HN-Ses, nor whether that's even possible, so frankly I'm choosing not to 
care much about what we end up doing in that case. At worst we may 
advertise some aliases that aren't meaningful, and/or omit some that 
are. I can't say how wrong that might be since I don't know what's right.

>> +#define CMN_EVENT_HNS_OCC(_model, _name, _event)			\
>> +	CMN_EVENT_HN_OCC(_model, hns_##_name, CMN_TYPE_HNS, _event),	\
>> +	_CMN_EVENT_HNS(_model, _name##_rxsnp, _event, SEL_OCCUP1_ID, 5), \
>> +	_CMN_EVENT_HNS(_model, _name##_lbt, _event, SEL_OCCUP1_ID, 6),	\
>> +	_CMN_EVENT_HNS(_model, _name##_hbt, _event, SEL_OCCUP1_ID, 7),	\
>> +	_CMN_EVENT_HNS(CMNS3R2, _name##_rnf, _event, SEL_OCCUP1_ID, 8),	\
>> +	_CMN_EVENT_HNS(CMNS3R2, _name##_rni, _event, SEL_OCCUP1_ID, 9),	\
>> +	_CMN_EVENT_HNS(CMNS3R2, _name##_ccglcn, _event, SEL_OCCUP1_ID, 10), \
>> +	_CMN_EVENT_HNS(CMNS3R2, _name##_ccgrn, _event, SEL_OCCUP1_ID, 11)
> 
> I have a similar question here. My impression is that this is mainly for
> the convenience of appending CMNS3R2 specific attributes, but it doesn't
> necessarily mean those attributes should be added for every model.

Note that the design here is that each event alias encodes a bitmap of 
the models to which it is relevant - although with some simplification, 
since we don't need to explicitly exclude models where the whole node 
type could never be present anyway. So tht notion of "adding attributes 
to a model" doesn't really make sense - at most we're adding the new 
model to existing attributes in some places (mostly implicitly in the 
"bitmap tricks" enum values), but mostly adding new attributes only 
*for* the new model.

>> @@ -1288,65 +1388,72 @@ static struct attribute *arm_cmn_event_attrs[] = {
> 
>> +	CMN_EVENT_HNS_HBT_ENHBT(cache_miss,		0x01),
> 
> I manually extend the macro and got the result:
> 
>    CMN_EVENT_ATTR(CMN700 | CMNS3R01, hns_cache_miss_all, CMN_TYPE_HNS, 0x1, SEL_HBT_LBT_SEL, 0),
>    CMN_EVENT_ATTR(CMN700 | CMNS3R01, hns_cache_miss_hbt, CMN_TYPE_HNS, 0x1, SEL_HBT_LBT_SEL, 1),
>    CMN_EVENT_ATTR(CMN700 | CMNS3R01, hns_cache_miss_lbt, CMN_TYPE_HNS, 0x1, SEL_HBT_LBT_SEL, 2),
>    CMN_EVENT_ATTR(CMNS3R2, hns_cache_miss_all, CMN_TYPE_HNS, 0x1, SEL_ENHANCED_HBT_LBT_SEL, 0),
>    CMN_EVENT_ATTR(CMNS3R2, hns_cache_miss_hbt, CMN_TYPE_HNS, 0x1, SEL_ENHANCED_HBT_LBT_SEL, 1),
>    CMN_EVENT_ATTR(CMNS3R2, hns_cache_miss_lbt, CMN_TYPE_HNS, 0x1, SEL_ENHANCED_HBT_LBT_SEL, 2),
>    CMN_EVENT_ATTR(CMNS3R2, hns_cache_miss_rnf, CMN_TYPE_HNS, 0x1, SEL_ENHANCED_HBT_LBT_SEL, 3),
>    CMN_EVENT_ATTR(CMNS3R2, hns_cache_miss_rni, CMN_TYPE_HNS, 0x1, SEL_ENHANCED_HBT_LBT_SEL, 4),
>    CMN_EVENT_ATTR(CMNS3R2, hns_cache_miss_ccglcn, CMN_TYPE_HNS, 0x1, SEL_ENHANCED_HBT_LBT_SEL, 5),
>    CMN_EVENT_ATTR(CMNS3R2, hns_cache_miss_ccgrn, CMN_TYPE_HNS, 0x1, SEL_ENHANCED_HBT_LBT_SEL, 6),
> 
> CMNS3R2 has added items like rnf/rni/ccglcn/ccgrn, not sure if this is
> purposed or not ...

Indeed that is correct - in this case we can't encode (e.g.) a single 
"hns_cache_miss_hbt" attribute even though the name, node type, event 
code, and filter value are all common, since S3 r2 went and changed the 
filter itself. Thus we define two sets of aliases, one encoding the 
original selector and its values, and one for the new variant, but only 
one set or the other will be exposed at runtime based on the model 
match. (And if the model bitmaps were to overlap such that we did try to 
expose both, then we'd blow up with a sysfs collision from trying to 
create two attributes with the same name.)

>> @@ -2431,21 +2538,33 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
>>   	/*
>>   	 * With the device isolation feature, if firmware has neglected to enable
>>   	 * an XP port then we risk locking up if we try to access anything behind
>> -	 * it; however we also have no way to tell from Non-Secure whether any
>> -	 * given port is disabled or not, so the only way to win is not to play...
>> +	 * it; however prior to CMN S3 r2p0 we also have no way to tell from
>> +	 * Non-Secure whether any given port is disabled or not, so in that case
>> +	 * the only way to win is not to play...
>>   	 */
>>   	reg = readq_relaxed(cfg_region + CMN_CFGM_INFO_GLOBAL);
>> -	if (reg & CMN_INFO_DEVICE_ISO_ENABLE) {
>> +	if (reg & CMN_INFO_DEVICE_ISO_ENABLE && model == CMNS3R01) {
> 
> As the comment claims "prior to CMN S3 r2p0", would here be:
> 
>    if (reg & CMN_INFO_DEVICE_ISO_ENABLE && model < CMNS3R2) {

Although bit 44 of INFO_GLOBAL should be RES0 on CMN-700 and older 
versions, it only carries the meaning of DEVICE_ISO_ENABLE from CMN S3 
r0 onwards, so while we could get away with being lazy before, once we 
have *some* check then it might as well be the most correctly-specific one.

Thanks,
Robin.

> 
>>   		dev_err(cmn->dev, "Device isolation enabled, not continuing due to risk of lockup\n");
>>   		return -ENODEV;
>>   	}
> 
> Thanks,
> Leo

