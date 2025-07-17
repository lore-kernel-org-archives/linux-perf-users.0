Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD262FCFC7
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Jul 2025 16:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752770562; cv=none; b=FBvBs4SGXHE91LDsGpc6OUNq2qDBLgqHv/2kjuQvgZZvjaiDuvAVBIwkZS3IPsHGrXblWJ0pZmm1qGlW2H41aiyGR0PQkfAekPFYI6N0J40t4ndTn7PnuzNPwzjv5TWqenThmrzxwudW77wVi4SKDmEka9g1MCjNgB9WjZIvAPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752770562; c=relaxed/simple;
	bh=Zp+bqdk2AUV+SBqOdeWsNgo02TfpUX044tCk09JCCZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZKXLJ+b2twB3cCirvmrkjAl5yX6620VaT6HKRZ8xZYtHKaV0L6HnqLLRkPPolIL9muAFJ0ySwFGaIkIRDCy0b51hpd4TCjiSUazpNWPJByzmnWcxkzTGqCLRPMRfLSIX6hJpo/cfdR/YEz8dSNbllMrkSt24cr0nRcitObOevfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l4uWNSTW; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l4uWNSTW"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4560add6cd2so9994185e9.0
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Jul 2025 09:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752770559; x=1753375359; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0KIZvn3WMN/D9GaYJuL0YNSf8jbAXvNffTD/qUx3PrA=;
        b=l4uWNSTWyIrBIqJn1bARw8DAb0ORCAF6cH2oLOzqdjZG0sZwsXeQBHI8w9wAn/2Ksi
         vER6D5I68erzfHGK7QAWNe/r78dKLKKyi3SC/djwhGJWD+6xanHb0amlMJI4lwMaSgmI
         HzrD81BL4vYw7JnpFasjIaAXQoz7DRUT/Lq8vtptFC+/i+Vimn+NqSfHWHtPNIMJzEjx
         D8HFpTlibcjl6g854o4huw1uvi2PgwBK6qBxiRNFrXhIGFj7HEMwotst/2XZEWugCp/o
         YpOQjDyUBjOvf2OLpjYNVp3myvfZaAdYnzpZl9ROZFAaa4EiDUyMgvwZm4eGgumGxnes
         6wAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752770559; x=1753375359;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0KIZvn3WMN/D9GaYJuL0YNSf8jbAXvNffTD/qUx3PrA=;
        b=Sz3auo9C5LxPXcDNiZbq1oInWcS3Ic0/MZ7gL/t6QH5j3OGYLr7zlOY+KdAZk/8kjx
         lbPDsHlO5b8Sc9jLawC5HawHpP/DjaFfes4x+rbJ+Sf9IQp37ZSMTL22U5EUmoZjAbrc
         N+H5RHLPVkZTJ+cAF0XwsbCI6I686/U60HlMFQTyQ+gH9PxVCdUwseNAsGXpLK7pnGQS
         uuLM2xs44tseFmTic5VIU99cg+aOK71uqkskGwXA1cFT7rztFItCd9+TsLBQzQ3wTCF+
         dv5zidKIt1xxDxHbjPVkXFw7A7kv+jrzvVrYWWZraxbJhd4kjvBnZOBXKGkF5DggSBV4
         jlPg==
X-Forwarded-Encrypted: i=1; AJvYcCUPW67ISXhMrUdbiQLoo8js3nCDrCd8Vmn+GWfCe6q56T0/BHGPa1n01k8ostFRf6rTmC6pT9JmEWoILg/23l/M@vger.kernel.org
X-Gm-Message-State: AOJu0YxeJC37MW5elDT6+X/bD++ea60aI3AC33AASkwwAdMbWPq65SY5
	5WW4gQghURiUO8SG7uHvAGlnfsoEfMa4MQ8fVGYo0yyD1SsUS348otdOt9o+XnCle7w=
X-Gm-Gg: ASbGncuYQZ7wyu0LkuOQLyWJO3rZEIrdf7/0DCU4k+WuszBmrUfFeMJsYeVvDUtLMKy
	6mlRlOLZV13vZVWwigYrQumoPIFvjyt8yt7pin6dUWYURnJ0odq8pYHGNKn4HsuLV5USK9mb91Z
	1y8YhAuPKACeXOJb9WEV0n6l6RXMZxur3WxD3rOGQxQRobSKt0k9GtPvajnZoIsL7vlDABu2zWO
	6xsl+NhC7lntkHt8clIUJYD1AUguRE+i6R9N8CNtOwpAThAofD+O0Wlweqcomwbz6/b+1YK7rlE
	EKOQ+M9cpv+8oErIhMZhrIcqPBVpfpd+vJuOvgbODsWFR9EbQi6lPhIaJXiW4u4vdvgmZYtGNqL
	Soa479EZeC5W+jBXjm7aH7OM+nFk=
X-Google-Smtp-Source: AGHT+IHw2GCF56hApJyEmdx/xTKHHH5iV9N7ia+pyQS/X4tv7tXWZh4hCv08eoEvqDhMJOVRwHk5hg==
X-Received: by 2002:a05:600c:3f12:b0:456:1ab0:d566 with SMTP id 5b1f17b1804b1-456348cbdb0mr41924525e9.16.1752770558925;
        Thu, 17 Jul 2025 09:42:38 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45634f5dd61sm28041015e9.11.2025.07.17.09.42.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 09:42:38 -0700 (PDT)
Message-ID: <95468171-a09d-4b6b-a0bd-189d83ff33a6@linaro.org>
Date: Thu, 17 Jul 2025 17:42:37 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] perf: arm_spe: Add support for filtering on data
 source
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Zenghui Yu <yuzenghui@huawei.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, leo.yan@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
 kvmarm@lists.linux.dev
References: <20250605-james-perf-feat_spe_eft-v3-0-71b0c9f98093@linaro.org>
 <20250605-james-perf-feat_spe_eft-v3-7-71b0c9f98093@linaro.org>
 <aHUOig-kaRo15ZH5@willie-the-truck>
 <7f51d4f9-7e08-49b5-ab43-8bc765bb2ca8@linaro.org>
 <aHkI5_IOV35L4YJa@willie-the-truck>
 <ca99af3b-e358-4c2b-8d62-0b6c29984391@linaro.org>
 <aHkWTlaRKdXbnA0r@willie-the-truck>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aHkWTlaRKdXbnA0r@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17/07/2025 4:27 pm, Will Deacon wrote:
> On Thu, Jul 17, 2025 at 04:16:32PM +0100, James Clark wrote:
>>
>>
>> On 17/07/2025 3:29 pm, Will Deacon wrote:
>>> On Tue, Jul 15, 2025 at 02:04:18PM +0100, James Clark wrote:
>>>> On 14/07/2025 3:04 pm, Will Deacon wrote:
>>>>> On Thu, Jun 05, 2025 at 11:49:05AM +0100, James Clark wrote:
>>>>>> @@ -406,6 +416,9 @@ static u64 arm_spe_event_to_pmsfcr(struct perf_event *event)
>>>>>>     	if (ATTR_CFG_GET_FLD(attr, inv_event_filter))
>>>>>>     		reg |= PMSFCR_EL1_FnE;
>>>>>> +	if (ATTR_CFG_GET_FLD(attr, data_src_filter))
>>>>>> +		reg |= PMSFCR_EL1_FDS;
>>>>>
>>>>> Is the polarity correct here? The description of PMSDSFR_EL1.S<m> suggests
>>>>> that setting bits to 1 _excludes_ the FDS filtering.
>>>>>
>>>>
>>>> Setting filter bits to 1 means that samples matching are included. Setting
>>>> bits to 0 means that they are excluded. And PMSFCR_EL1.FDS enables filtering
>>>> as a whole, so if the user sets any filter bit to 1 we want to enable
>>>> filtering:
>>>>
>>>>     PMSDSFR_EL1.S<m>
>>>>
>>>>     0b0  If PMSFCR_EL1.FDS is 1, do not record load operations that have
>>>>          bits [5:0] of the Data Source packet set to <m>.
>>>>
>>>>     0b1  Load operations with Data Source <m> are unaffected by
>>>>          PMSFCR_EL1.FDS.
>>>>
>>>> I think it's all the right way around and it ends up being the same as the
>>>> other filters in SPE. Because we're using any bit being set to enable the
>>>> filtering, the only thing you can't do is enable filtering with a 0 filter,
>>>> but I didn't think that was useful. See the previous discussion on this
>>>> here:
>>>> https://lore.kernel.org/all/5752f039-51c1-4452-b5df-03ff06da7be3@linaro.org/
>>>>
>>>> Reading the "Data source filtering" section in the docs change at the end
>>>> might help too.
>>>
>>> Sorry, but I still don't get it :/
>>>
>>> afaict, if any of the bits in 'data_src_filter' are _zero_ then we
>>> should set PMSFCR_EL1.FDS. That also means that a mask of zero means all
>>> loads are filtered, which is what the architecture says and is what we
>>> should provide to userspace.
>>>
>>> Will
>>
>> We'd have to add another format flag to enable data source filtering then,
>> because otherwise the default would be zero and people's samples would
>> disappear.
>>
>> But the only use cases I could think of were more like "I want to see
>> samples from data source 1":
>>
>>    -e arm_spe/data_src_filter=0x1/
>>
>> Or "I want to see all data sources except 1":
>>
>>    -e arm_spe/data_src_filter=0xfffffffe/
>>
>> Filtering out all samples with any data source didn't seem to make sense to
>> me, and I think you can already do that with the other filters (remove loads
>> etc).
>>
>> It would be a shame to be inconsistent and to add an enable flag just for
>> that one case because the other filters in SPE are auto enabled for non-zero
>> values. Although to be fair for PMSFCR.FT and others, zero filters are
>> explicitly not allowed:
>>
>>    If this field is set to 1 and the PMSFCR_EL1.{ST, LD, B} bits are all
>>    set to zero, it is CONSTRAINED UNPREDICTABLE whether no samples are
>>    recorded or the PE behaves as if PMSFCR_EL1.FT is set to 0
>>
>> Seems like FDS doesn't end up as neat as the others, but IMO I can't see
>> anyone needing a zero filter. I did discuss it with Leo and we decided that
>> we could always add the enable flag at a later date if a use case turned up
>> and it wouldn't be a breaking change.
>>
>> But if you think it's there so it should be exposed I can add it.
> 
> What about if we expose the inverse of PMSDSFR_EL1 to userspace instead?
> 
> Will

That's exactly what I was thinking. It does seem a bit weird, but I can 
call it inv_data_src_filter and document it appropriately so it should 
be fine.

