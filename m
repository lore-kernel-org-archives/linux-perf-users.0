Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F408720DD2;
	Thu, 10 Oct 2024 14:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728572296; cv=none; b=kVTvaWVBCOYBTwx1G8pS8Vr2iKK3kDztKNNH977cwdnh7PGg236RUen8eXsoi5CHxM4CM5Zb1h7AHidoifWVO3lNJtLfyLyV/mWsyTpxQBmlQInGLmSECYDPky0pzp9hcMQq8r81/I/nlHm14X04CZ4Ulb4kLr5bgY0NRjHkF5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728572296; c=relaxed/simple;
	bh=8pZA2xOOCOXB8sS0wILEwHzPzOc9cjzcLAaB4pjJ/zw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FiaL3Gg/85ppqoSbDN7gA4SWqV+ZBBQO1BmqTRbDH69YyT0DsR/uiIM6wW8RUo9DCyxJ0hVNQ4oky346LsKoFsEmc5FLg7dXEwTFqXk22HF89kexdFohGpaY8Wgu/BbiHc+AzkhhawpGwj6w8KNa7Nii01VGCOhXT1oKJwlxSi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BDE2497;
	Thu, 10 Oct 2024 07:58:42 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C5B713F64C;
	Thu, 10 Oct 2024 07:58:10 -0700 (PDT)
Message-ID: <a496733e-7bab-44ba-bff8-00af38d2874b@arm.com>
Date: Thu, 10 Oct 2024 15:58:09 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] perf arm-spe: Use metadata to decide the data
 source feature
To: James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Besar Wicaksono <bwicaksono@nvidia.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20241003185322.192357-1-leo.yan@arm.com>
 <20241003185322.192357-5-leo.yan@arm.com>
 <555fbea8-7103-4de1-bcd5-accc9c649e62@linaro.org>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <555fbea8-7103-4de1-bcd5-accc9c649e62@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/10/24 14:53, James Clark wrote:

[...]

>> +static bool arm_spe__is_common_ds_encoding(struct arm_spe_queue *speq)
>> +{
>> +     struct arm_spe *spe = speq->spe;
>> +     bool is_in_cpu_list;
>> +     u64 *metadata = NULL;
>> +     u64 midr = 0;
>> +
>> +     /*
>> +      * Metadata version 1 doesn't contain any info for MIDR.
>> +      * Simply return false in this case.
>> +      */
>> +     if (spe->metadata_ver == 1) {
>> +             pr_warning_once("The data file contains metadata version 1, "
>> +                             "which is absent the info for data source. "
>> +                             "Please upgrade the tool to record data.\n");
>> +             return false;
>> +     }
>> +
>> +     /* CPU ID is -1 for per-thread mode */
>> +     if (speq->cpu < 0) {
>> +             /*
>> +              * On the heterogeneous system, due to CPU ID is -1,
>> +              * cannot confirm the data source packet is supported.
>> +              */
>> +             if (!spe->is_homogeneous)
>> +                     return false;
> 
> Technically you could look at timestamps and context switches to find
> the CPU for non-homogeneous per-thread mode. But it's such an edge case
> I'm not sure it's even worth leaving a TODO for.

Good point. Let’s bear the idea in mind in case we need it later.

Thanks,
Leo
