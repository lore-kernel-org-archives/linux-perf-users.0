Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E5317BB0C;
	Fri, 30 Aug 2024 12:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725019966; cv=none; b=FWk1V6Q0XcP/V5vzQrxgifevgpmv8kZiM/3NYTBKNw5NwqOBhM3S4XmRllVGhFrFodHWiFIGGElutlShpC9XZBrznpT/U57nv/nc8/PR99sl2hzaFdaxLYIo0qZtZFL3jJi1YalyuNyedV4HpTtGC67j/ESpbR5P2JvtT/HYg7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725019966; c=relaxed/simple;
	bh=5efDUvWPJTQzrLZn1kIQh/Y0LwK0Dnn/sLPIabxchwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A3CwvRYax8Qu6ms5lIdF3+EOdikFjoSikxZaQCSt8TTc0+61+AeVyoVvE0UKm/vpzZscU40Idbo5S03oFRkhVDLYlITI+Q5U2pjPUypSzxNRKjQQWRPkYgy7q1bZ0j2UvQaley+4X66kzOkPRbdUEUGzDVrPdaghTwX/Fn8ebwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7829F339;
	Fri, 30 Aug 2024 05:13:03 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E88EF3F762;
	Fri, 30 Aug 2024 05:12:34 -0700 (PDT)
Message-ID: <655edf2e-8e0d-4c00-91a1-1af58593f597@arm.com>
Date: Fri, 30 Aug 2024 13:12:33 +0100
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
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <20240830103834.GA8000@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/30/24 11:38, Will Deacon wrote:
> On Tue, Aug 27, 2024 at 05:44:09PM +0100, Leo Yan wrote:
>> This commit adds a new entry 'lds' in the capacity folder. 'lds' stands
>> for "loaded data source". When its value is 1, it indicates the data
>> source implemented, and data source packets will be recorded in the
>> trace data.
>>
>> Signed-off-by: Leo Yan <leo.yan@arm.com>
>> ---
>>   drivers/perf/arm_spe_pmu.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
>> index 9100d82bfabc..81c1e7627721 100644
>> --- a/drivers/perf/arm_spe_pmu.c
>> +++ b/drivers/perf/arm_spe_pmu.c
>> @@ -110,6 +110,7 @@ enum arm_spe_pmu_buf_fault_action {
>>   /* This sysfs gunk was really good fun to write. */
>>   enum arm_spe_pmu_capabilities {
>>        SPE_PMU_CAP_ARCH_INST = 0,
>> +     SPE_PMU_CAP_LDS,
>>        SPE_PMU_CAP_ERND,
>>        SPE_PMU_CAP_FEAT_MAX,
>>        SPE_PMU_CAP_CNT_SZ = SPE_PMU_CAP_FEAT_MAX,
>> @@ -118,6 +119,7 @@ enum arm_spe_pmu_capabilities {
>>
>>   static int arm_spe_pmu_feat_caps[SPE_PMU_CAP_FEAT_MAX] = {
>>        [SPE_PMU_CAP_ARCH_INST] = SPE_PMU_FEAT_ARCH_INST,
>> +     [SPE_PMU_CAP_LDS]       = SPE_PMU_FEAT_LDS,
>>        [SPE_PMU_CAP_ERND]      = SPE_PMU_FEAT_ERND,
>>   };
>>
>> @@ -160,6 +162,7 @@ static ssize_t arm_spe_pmu_cap_show(struct device *dev,
>>
>>   static struct attribute *arm_spe_pmu_cap_attr[] = {
>>        SPE_CAP_EXT_ATTR_ENTRY(arch_inst, SPE_PMU_CAP_ARCH_INST),
>> +     SPE_CAP_EXT_ATTR_ENTRY(lds, SPE_PMU_CAP_LDS),
>>        SPE_CAP_EXT_ATTR_ENTRY(ernd, SPE_PMU_CAP_ERND),
>>        SPE_CAP_EXT_ATTR_ENTRY(count_size, SPE_PMU_CAP_CNT_SZ),
>>        SPE_CAP_EXT_ATTR_ENTRY(min_interval, SPE_PMU_CAP_MIN_IVAL),
> 
> What will userspace do with this? I don't think you can turn LDS on/off,
> so either you'll get the data source packet or you won't.

Yes, LDS bit does not work as a switch.

The tool in the userspace will record the LDS bit into the metadata. During
decoding phase, it reads out the LDS from metadata. Based on it, the perf
tool can know if the data source is supported or not, if yes then decode the
data source packet.

Another point is how to decide the data source packet format. Now we maintain
a CPU list for tracking CPU variants which support data source trace. For long
term, I would like the tool can based on hardware feature (e.g. a ID register
in Arm SPE) to decide the data source format, so far it is absent. This is why
LDS bit + CPU list is a more reliable way. See some discussion [1].

Thanks,
Leo

[1] https://lore.kernel.org/linux-perf-users/Zl9jLtiFagBcH7oH@J2N7QTR9R3/
