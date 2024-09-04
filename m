Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302984400;
	Wed,  4 Sep 2024 14:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458551; cv=none; b=udhNPaO87TwMDqmsHgEpfOuYn6tsAHxmJDnNy/zeMd/ioRqr1Oc3kedIre51e8AG6aMMCCYBvOxNNXYDFcLA+CubjwyMc4bHywFc0FtveR2pferdj+sNh7pSKxSr4BAPIu3gDBmM+FTeqhFETlWB1ECgYWCf5arY3Safes6w8zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458551; c=relaxed/simple;
	bh=oUM29cWZRC0F6zWB1ab9D18QDlLiwlDzs5Y+Y1QxGw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oRduVIppFuXeThDtNWaIH+Vjz9FMmgNxlsnR8rYzN9mDamP1LPbNkp46hdlGZ3c0GqutZq8LEMqi5QcUp5Ke3Duj2oNk+javtcDenj2yIWufKxi36DWU+OlYskpNnyVtZF48ItMuSV39bfc8pAZAPEKo1UsV5xag/voUm0p+zp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A33FFEC;
	Wed,  4 Sep 2024 07:02:54 -0700 (PDT)
Received: from [10.1.33.19] (PF4Q20KV.arm.com [10.1.33.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CD603F73F;
	Wed,  4 Sep 2024 07:02:26 -0700 (PDT)
Message-ID: <f3d81afa-fd67-4750-86e9-dfea1e47e002@arm.com>
Date: Wed, 4 Sep 2024 15:02:19 +0100
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
 <0c6d3625-228a-4cb0-b75f-57f1d4069ced@arm.com>
 <20240904123544.GG13550@willie-the-truck>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <20240904123544.GG13550@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/2024 1:35 PM, Will Deacon wrote:

>>> Why not just decode a data source packet when you see it? i.e. assume LDS
>>> is always set.
>>
>> The current tool works this way to directly decode a data source packet.
>>
>> However, as Arm ARM section D17.2.4 "Data Source packet" describes, the loaded
>> data source is implementation dependent, the data source payload format also
>> is implementation defined.
>>
>> We are halfway here in using the LDS bit to determine if the data source is
>> implemented. However, we lack information on the data source format
>> implementation. As a first step, we can use the LDS bit for sanity checking in
>> the tool to detect any potential silicon implementation issues. Once we have
>> an architectural definition for the data source format, we can extend the tool
>> accordingly.
> 
> I don't think we shyould expose UAPI from the driver to detect potential
> hardware bugs. Let's add it when we know it's useful for something instead.

I understand your concern.

>>>> Another point is how to decide the data source packet format. Now we maintain
>>>> a CPU list for tracking CPU variants which support data source trace. For long
>>>> term, I would like the tool can based on hardware feature (e.g. a ID register
>>>> in Arm SPE) to decide the data source format, so far it is absent. This is why
>>>> LDS bit + CPU list is a more reliable way. See some discussion [1].
>>>
>>> Huh. Why would you have a CPU in the list if it _doesn't_ have LDS?
>>
>> Yeah, this is what we don't expect - we can verify the implementation based on
>> LDS bit.
>>
>> E.g. if users ask data source related questions, we can use LDS bit (saved in
>> the perf metadata) to confirm the feature has been implemented in a silicon.
> 
> What exactly do you mean by this?

Sometimes, users might ask if the data source is supported in Arm SPE. With exposing
the LDS bit, it would be helpful for us to check if the feature is supported. For
example, when a user uses the perf tool to record Arm SPE data, the LDS bit is stored
in the perf metadata, and we can check its value during post-analysis.
 
> As far as I can tell:
> 
>   - Data source packets are either present or absent depending on LDS
>   - You need CPU-specific information to decode them it they are present
> 
> So it's neither necessary nor sufficient to expose the LDS bit to
> userspace.

We can live without exposing LDS bit currently. I will drop this change in next spin.

Just head up, later I think we might still need to expose capacity bits (or the
PMSIDR_EL1 register) for new features. As you said, we can do it when it is necessary.

Thanks for suggestion!

Leo 
