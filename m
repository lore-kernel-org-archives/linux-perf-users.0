Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9711531FC;
	Fri, 30 Aug 2024 07:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725004488; cv=none; b=Jkx59oB0HIoH9CC0bONeB85ymnU7eRmpJSWfto6oVWq0XXr12lpGiNAoN1yTCv0mlSnrBM7umU3Tek4A8NDI7epU9P3BvtSAfAHcE1XUyDjoOBJbcqpw1+Ptk45Jw9b7SK9IjONFYXjE0dM5vE1WaoIYcphZ5WISEAmK6zdXfOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725004488; c=relaxed/simple;
	bh=ICYHULuCEXJMyFjPlygiTLaIzDP1RtvfBDBMmHAMIlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SRQctPDMgJSchNkDv1qVT+6dGETEq+wiVC1xFqEIw9nLFmH2EQ+VHmtOdoCu/lEQq2CzqwgDMzLaeRkpxEldamM/WJvkJXpBHwFNPBLHgjgf4E4ml8a1w/qw3e/qbGSiLD3sKB0HKCZTDl02KfRRjxaW2muSVfG9vlwm3IrqAuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F11931063;
	Fri, 30 Aug 2024 00:55:11 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C21AD3F73B;
	Fri, 30 Aug 2024 00:54:43 -0700 (PDT)
Message-ID: <f14f9dc5-7a82-4ec3-8acc-53a0c7b5a2b6@arm.com>
Date: Fri, 30 Aug 2024 08:54:42 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 9/9] perf arm-spe: Dump metadata with version 2
To: James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Will Deacon
 <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Yicong Yang <yangyicong@hisilicon.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org
References: <20240827164417.3309560-1-leo.yan@arm.com>
 <20240827164417.3309560-10-leo.yan@arm.com>
 <f80c4933-6531-4578-87de-60e5eccc6cc4@linaro.org>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <f80c4933-6531-4578-87de-60e5eccc6cc4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/28/24 17:20, James Clark wrote:
>> +static void arm_spe_print_info(struct arm_spe *spe, __u64 *arr)
>>   {
>> +     unsigned int i, cpu, header_size, cpu_num, per_cpu_size;
>> +
>>       if (!dump_trace)
>>               return;
>>
>> -     fprintf(stdout, arm_spe_info_fmts[ARM_SPE_PMU_TYPE], arr[ARM_SPE_PMU_TYPE]);
>> +     if (spe->metadata_ver == 1) {
>> +             cpu_num = 0;
>> +             header_size = ARM_SPE_AUXTRACE_V1_PRIV_MAX;
>> +             per_cpu_size = 0;
>> +     } else if (spe->metadata_ver == 2) {
> 
> Assuming future version updates are backwards compatible and only add
> new info this should be spe->metadata_ver >= 2, otherwise version bumps
> end up causing errors when files get passed around.
> 
> I know there are arguments about what should and shouldn't be supported
> when opening new files on old perfs, but in this case it's easy to only
> add new info to the aux header and leave the old stuff intact.
> 
>> +             cpu_num = arr[ARM_SPE_CPU_NUM];
>> +             header_size = ARM_SPE_AUXTRACE_V2_PRIV_MAX;
>> +             per_cpu_size = ARM_SPE_AUXTRACE_V2_PRIV_PER_CPU_MAX;
> 
> I think for coresight we also save the size of each per-cpu block rather
> than use a constant, that way new items can be appended without breaking
> readers.

Good point for adding a 'size' field for each per-cpu block.

My understanding is we need to make the metadata format to be self-described.
E.g. the metadata header contains the size for itself, and every per CPU
metadata block also contains a 'size' field.  Based on this, a general code
can be used to processing different metadata versions.
  
> That kind of leads to another point that this mechanism is mostly
> duplicated from coresight. It saves a main header version, then per-cpu
> groups of variable size with named elements. I'm not saying we should
> definitely try to share the code, but it's worth keeping in mind.

Agreed. I will refine a bit, for better matching this direction.

Thanks for suggestion.

Leo
