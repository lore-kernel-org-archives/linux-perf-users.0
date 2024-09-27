Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C6718787B;
	Fri, 27 Sep 2024 08:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727424844; cv=none; b=bTA3yP7AfhAoeo2r8oHzakuchXymZZMOxRocZDpvzQEEse5W+SWFvuA8DuTxJw/R9aoAYOmvkVgw0r0VPAQJ6lPEQaZVOk2yOnNiIYNjFZt4b5LEij0lUYa5Yd4PC/iucIBHa579W87xQVZd4V1JN4GPA/T5UiP1Pr9LLFSvUS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727424844; c=relaxed/simple;
	bh=lwgs0DbF6pYjRu7NVtLRWOaCSE0VWwhAvD+Td8xkjzg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=n+fj9dXHIHffOrQhsm9HeIJPcvX+GJDSJO41WlJYPt1KN0YyeHMIOOp9AWQEqF4ZDoqqWD6qj8pSnZSxntqWGqrjue3p3kzXrfgRFO0P+Rkdv9QSeN+DOdC51JmdHbNJGp203HUAsUucMDU+cnUFqD8s7gEt1abFpvMqo9xDkSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7AC214BF;
	Fri, 27 Sep 2024 01:06:09 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A6CE3F6A8;
	Fri, 27 Sep 2024 01:05:38 -0700 (PDT)
Message-ID: <f6a90906-6855-4524-9ff8-62099cbdb863@arm.com>
Date: Fri, 27 Sep 2024 09:05:36 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Leo Yan <leo.yan@arm.com>
Subject: Re: [PATCH v2 1/5] perf arm-spe: Define metadata header version 2
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240914215458.751802-1-leo.yan@arm.com>
 <20240914215458.751802-2-leo.yan@arm.com> <ZvZRiTYrTOdXUVUk@google.com>
Content-Language: en-US
In-Reply-To: <ZvZRiTYrTOdXUVUk@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/27/24 07:32, Namhyung Kim wrote:

[...]

>> diff --git a/tools/perf/util/arm-spe.h b/tools/perf/util/arm-spe.h
>> index 4f4900c18f3e..5416d4e1d15f 100644
>> --- a/tools/perf/util/arm-spe.h
>> +++ b/tools/perf/util/arm-spe.h
>> @@ -12,10 +12,46 @@
>>   enum {
>>        ARM_SPE_PMU_TYPE,
>>        ARM_SPE_PER_CPU_MMAPS,
>> +     ARM_SPE_AUXTRACE_V1_PRIV_MAX,
>> +};
>> +
>> +#define ARM_SPE_AUXTRACE_V1_PRIV_SIZE        \
>> +     (ARM_SPE_AUXTRACE_V1_PRIV_MAX * sizeof(u64))
>> +
>> +enum {
>> +     /*
>> +      * The old metadata format (defined above) does not include a
>> +      * field for version number. Version 1 is reserved and starts
>> +      * from version 2.
>> +      */
>> +     ARM_SPE_HEADER_VERSION,
>> +     /* Number of sizeof(u64) */
>> +     ARM_SPE_HEADER_SIZE,
>> +     /* PMU type shared by CPUs */
>> +     ARM_SPE_SHARED_PMU_TYPE,
>> +     /* Number of CPUs */
>> +     ARM_SPE_CPUS_NUM,
>>        ARM_SPE_AUXTRACE_PRIV_MAX,
>>   };
> 
> Why don't you define something like struct arm_spe_header_v2 ?

Here the target is to make metadata to be self-described and can be
easily extended for new version (but I would not expect updating header
will happen frequently).

The fields ARM_SPE_HEADER_VERSION and ARM_SPE_HEADER_SIZE give a
header version and a header size. This allows us to easily extend new
enum items for new header. A benefit is we can use general code for
decoding because we don't need to process structure for a specific
version.

Thanks for review!

Leo
