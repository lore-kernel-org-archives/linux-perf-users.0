Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4C116DEB2;
	Mon, 22 Jul 2024 14:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721659727; cv=none; b=CzB86MMS0xTCnkI8b82HG342wFSpr99qkqjVpG/m1fvtiebt/UZhxIkY0Jua1j9553Xo7q/vr3Cq9VeARJAUrbwV1oOYJ1ofzYvgVIAmc4OI+lKVp5lF18oj3K0NnB368uZWjRRPg3vNrw2BKvBPI3C2Oo/Z1GZBGM2KBofq7iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721659727; c=relaxed/simple;
	bh=atDlABSs8TWqozIAX0lOgTXANYKDnBCRPkaJ2w/TPTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JeZYL3j5VSscX8rO9CxdB6hk1AH6dY2AIvrjJRjLqmLbxFJQIFcuP3XTvg39cmiWAo0kWxbBrF3ZozCPXlNo84rhgztpZsnRlINh2sxXOA1twu850/oI93zLOG0LFI1q987qUFiSsu3UTa3m2Hbv+Myqv+spH7R/ffThAd4T54Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C767DFEC;
	Mon, 22 Jul 2024 07:49:07 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4196D3F73F;
	Mon, 22 Jul 2024 07:48:40 -0700 (PDT)
Message-ID: <8df1a663-1720-4ee6-9097-b0d6e05beb0e@arm.com>
Date: Mon, 22 Jul 2024 15:48:38 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/6] perf auxtrace s390: Set the 'auxtrace' flag for
 AUX events
To: Adrian Hunter <adrian.hunter@intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 James Clark <james.clark@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240721202113.380750-1-leo.yan@arm.com>
 <20240721202113.380750-4-leo.yan@arm.com>
 <a9d07994-cf6e-4059-8180-c0b9cd51e528@intel.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <a9d07994-cf6e-4059-8180-c0b9cd51e528@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/22/24 11:54, Adrian Hunter wrote:

[...]

> On 21/07/24 23:21, Leo Yan wrote:
>> Set the 'auxtrace' flag for AUX events on s390.
>>
>> Signed-off-by: Leo Yan <leo.yan@arm.com>
>> ---
>>   tools/perf/arch/s390/util/auxtrace.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/tools/perf/arch/s390/util/auxtrace.c b/tools/perf/arch/s390/util/auxtrace.c
>> index 5068baa3e092..d7e72413b262 100644
>> --- a/tools/perf/arch/s390/util/auxtrace.c
>> +++ b/tools/perf/arch/s390/util/auxtrace.c
>> @@ -99,6 +99,7 @@ struct auxtrace_record *auxtrace_record__init(struct evlist *evlist,
>>                if (pos->core.attr.config == PERF_EVENT_CPUM_SF_DIAG) {
>>                        diagnose = 1;
>>                        pos->needs_auxtrace_mmap = true;
>> +                     pos->pmu->auxtrace = true;
> 
> This is probably too late. See:
> 
> https://lore.kernel.org/all/20240715160712.127117-7-adrian.hunter@intel.com/

Okay, I will drop this patch.

Thanks,
Leo


> 
>>                        break;
>>                }
>>        }
> 
