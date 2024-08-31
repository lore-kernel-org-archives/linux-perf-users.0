Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A8B13B797;
	Sat, 31 Aug 2024 11:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725104262; cv=none; b=q5L2KgJgOUChUxLJs9hP7pkTrIgxnK9tmQMZHvgEqAGuUYE7f+7arJGKPAaSvENxv4UoUmpg8GxGuRtI1cvqZM97JHpKO8YT50JPpL5l+EAEHm+1XvUrSiQNa41b4W/TyzcNTqd9DDwHxC7xrl9xALL4v0P1ObKRFU7Rpz8xO/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725104262; c=relaxed/simple;
	bh=p7YwjUYQ2OGjacewqfUPEKpjZ+QWcRjoLDUApUuglow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=efovPTrD86qe1NmYDGOZAo87KiywQYyq+rjV2V8/6uMUOFrI0kgt9xzfIr+JNXObPaulFkQdMfDowjANdqzDqM4uXzpMWN0dm41zGKFmSTxkzkqeyljt4miO2utJggAPvZiAoRWMuhFYkqHynijBZQppxVvY8VGQefWVykFZj0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B463D339;
	Sat, 31 Aug 2024 04:38:05 -0700 (PDT)
Received: from [10.57.87.50] (unknown [10.57.87.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D119F3F762;
	Sat, 31 Aug 2024 04:37:36 -0700 (PDT)
Message-ID: <0c6d3625-228a-4cb0-b75f-57f1d4069ced@arm.com>
Date: Sat, 31 Aug 2024 12:37:29 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/9] perf: arm_spe: Introduce 'lds' capacity
To: Will Deacon <will@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>,
 John Garry <john.g.garry@oracle.com>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Yicong Yang <yangyicong@hisilicon.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org
References: <20240827164417.3309560-1-leo.yan@arm.com>
 <20240827164417.3309560-2-leo.yan@arm.com>
 <20240830103834.GA8000@willie-the-truck>
 <655edf2e-8e0d-4c00-91a1-1af58593f597@arm.com>
 <20240830130930.GA8615@willie-the-truck>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <20240830130930.GA8615@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/30/2024 2:09 PM, Will Deacon wrote:

[...]

>>>> @@ -160,6 +162,7 @@ static ssize_t arm_spe_pmu_cap_show(struct device *dev,
>>>>
>>>>   static struct attribute *arm_spe_pmu_cap_attr[] = {
>>>>        SPE_CAP_EXT_ATTR_ENTRY(arch_inst, SPE_PMU_CAP_ARCH_INST),
>>>> +     SPE_CAP_EXT_ATTR_ENTRY(lds, SPE_PMU_CAP_LDS),
>>>>        SPE_CAP_EXT_ATTR_ENTRY(ernd, SPE_PMU_CAP_ERND),
>>>>        SPE_CAP_EXT_ATTR_ENTRY(count_size, SPE_PMU_CAP_CNT_SZ),
>>>>        SPE_CAP_EXT_ATTR_ENTRY(min_interval, SPE_PMU_CAP_MIN_IVAL),
>>>
>>> What will userspace do with this? I don't think you can turn LDS on/off,
>>> so either you'll get the data source packet or you won't.
>>
>> Yes, LDS bit does not work as a switch.
>>
>> The tool in the userspace will record the LDS bit into the metadata. During
>> decoding phase, it reads out the LDS from metadata. Based on it, the perf
>> tool can know if the data source is supported or not, if yes then decode the
>> data source packet.
> 
> Why not just decode a data source packet when you see it? i.e. assume LDS
> is always set.

The current tool works this way to directly decode a data source packet.

However, as Arm ARM section D17.2.4 "Data Source packet" describes, the loaded
data source is implementation dependent, the data source payload format also
is implementation defined.

We are halfway here in using the LDS bit to determine if the data source is
implemented. However, we lack information on the data source format
implementation. As a first step, we can use the LDS bit for sanity checking in
the tool to detect any potential silicon implementation issues. Once we have
an architectural definition for the data source format, we can extend the tool
accordingly.

>> Another point is how to decide the data source packet format. Now we maintain
>> a CPU list for tracking CPU variants which support data source trace. For long
>> term, I would like the tool can based on hardware feature (e.g. a ID register
>> in Arm SPE) to decide the data source format, so far it is absent. This is why
>> LDS bit + CPU list is a more reliable way. See some discussion [1].
> 
> Huh. Why would you have a CPU in the list if it _doesn't_ have LDS?

Yeah, this is what we don't expect - we can verify the implementation based on
LDS bit.

E.g. if users ask data source related questions, we can use LDS bit (saved in
the perf metadata) to confirm the feature has been implemented in a silicon.

> If we have to resort to per-CPU decoding, then that's even more of a reason>
not to have the LDS cap imo.

This series converts the Arm SPE information into per-CPU metadata, including
the LDS bit. Consequently, the decoding process retrieves CPU metadata for
per-CPU decoding, making it easy to determine if a CPU supports the data source.

We have platforms that not all CPUs support Arm SPE, for example, the CPU0 and
CPU1 don't support Arm SPE, CPU2~CPU5 share a Arm SPE PMU event, CPU6~CPU7
share another Arm SPE PMU event. In this case, per CPU metadata can be easily
for checking hardware capacity (include LDS bit) in the decoding.

Thanks,
Leo

