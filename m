Received: from mail-ed2-f43.google.com (mail-ed2-f43.google.com [74.125.228.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340D73E833E
	for <linux-perf-users@vger.kernel.org>; Mon,  5 Oct 2026 08:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791189236; cv=none; b=VQ+3+bRlPQ/ugiJIeqlGWR4+2LeScNUtK9sc6aG/L64p2TeZSMrpKQMYG3AL/AVFUBw1DDhZ5fEE0feyoOGf/nPVtrBEV0nVb3tRcjVTMuzKMd0WJMrLxSpXkiMLsnBpQMbaWUbmz8QXyR869XxCelaVoE3poakXT8K76PcGH4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791189236; c=relaxed/simple;
	bh=7mgyRzesFLFROC0q+fCt+AVsMpWCRWhTyy0sbEdAAgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ES0rvUuGifzyRTvK8uQX0vv4HJI5FGMDtI4MxkwDQriZjarBJ7u0Le4IFY7o/HdPNhfJ61s+xL/T48ti9KOPEEcgj1WdtDa1669bA8rdgc4styYB4IhxqRggCy4G2HLUTdlP9iRkja5c2aL1/VCY8REfyGe7rv/bCNuwWi8TAEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MkxN+HmA; arc=none smtp.client-ip=74.125.228.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MkxN+HmA"
Received: by mail-ed2-f43.google.com with SMTP id 4fb4d7f45d1cf-6ae19319854so1904260a12.3
        for <linux-perf-users@vger.kernel.org>; Mon, 05 Oct 2026 01:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791189233; x=1791794033; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O6/Hu0+FzeutECjLCJhR6ThF6X+jor72I2j2aChvi7s=;
        b=MkxN+HmAXMdrj5w/polwz4ybhxUb1vHn/3prFs6I8a4B7cr62/nV7Un0e8F68UVLND
         W4D8xrVYyzRBcqYEt00vVgbcP6hJv8f3i2Fw3/u7KCDE8Tv1mHfKhpbjwYqfGfIPQIdx
         LOwaJgKxjXfLRQ4lzUPaPtPgiYHtuKdwJAsFjum7MkcaEKYJTlVERFBPf3oYgS+Nk2lu
         2nM9hEA4Q/ibem05LWdHl+IuTTnRul/G2O5MoOZf05NnlcraU30fMX0hOvVz4kK+Xw9W
         mU0fjCXCEUjmRUzkRco4Iya8Q7Txi5EMMUs79VCPu8NSPqh/gXRYJqLLAN/4c2CzPkU4
         cZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791189233; x=1791794033;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O6/Hu0+FzeutECjLCJhR6ThF6X+jor72I2j2aChvi7s=;
        b=XZoUwAhUhN/PhMsTdsD5TVSSnYNeGxJzWccpo3QxV1wqyVVxqghJ4LH0VvuEzXZxST
         7LoK2Npd+xK7wtbFVYxZzvtYOMsVJsArzhj5ch/go5F0un+YWoHY7pGagddP0z6vHc1W
         K1g6wgEuIAPzPXL2r7+UdKNNp442CCMIobnM3KaPLMFss8Tb9KRh8YoPuflmnkW8LAP/
         f17p+WjAEBJARANBZKWKBcSwNQZlCB601BF8+i4ByHQi6fVZGuh41p6oAzvrOltRluyr
         VwmHeDBSvKgn/34qkuJdVCbx2icS6QxQ898l/3r/AuP5mAuyt9KxM3UxcYK1iJsKgcwa
         kDsg==
X-Forwarded-Encrypted: i=1; AKwUvBwBjqNffTplWXAIhCUgCzuJfGDxrPW3/Yi6fcgqJoaZXogqDFE763ChNkJu+gwxhIU9wbxlUlBah0RFYHiu/Kab@vger.kernel.org
X-Gm-Message-State: AFq9FYKXSP+opnbtnNk2ZaN7kGUPkj/jVxpWfGmi/KGYiP3RlY1yh/Hn
	GO97wGAx0gobRHTJATq3JMozzrtvpI8WBxdxx098Zg241elzfNZLRSv380K/ZaRRaGI=
X-Gm-Gg: AYBFou1X4XK/s2y2IXBlkNbrinyaA6hLmFg2rZaSNeXcVJ/sjukpAU+XkH9aRVLofgB
	sqqPulrcdsqTkqHkK39aFSqDc2NFXi5xYxv8GSRn0k/KdSuluJ9m8+obYBh2i9VGgZRVgS+ugkX
	7wFa+CRVyO2l0I/6ZVCztDkG4+r/3fUc+ik+h2jK3TDRjJuL4AEsn9OCL7XqkVHYUIm+ROndHza
	79WRq1S5mrgKw0JK7QdoyOhAphBS16DwmK60q3MlL/DL4a3v7spzpCe8X92aydohdm4eYSm7SAP
	vghx6azbM5caqeuNPiVBuazCXYISFJrC+7nLL7TL3HtLml6730LQB0XvgDM4aO3X7D+UUgO4ONy
	NBQnPwfNmDwDPfga+gMBnKB1gbwYFp7D9g7TG3NAHSBWU5fnowx5smi5QnpCQzwcFSySB1Te0Fg
	41sAR2VZ9z7eInRd3zvTOmQTmrh/s6TyzaBELjKHYNN8AGLGGXYTRLeO/+wXxiWRnz0AU6YUzAv
	t8=
X-Received: by 2002:a05:6402:4594:b0:6ac:c82f:3caa with SMTP id 4fb4d7f45d1cf-6af9e03e03dmr8002385a12.1.1791189233468;
        Mon, 05 Oct 2026 01:33:53 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6afb005a424sm3031255a12.0.2026.10.05.01.33.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 01:33:52 -0700 (PDT)
Message-ID: <c22b2771-95c5-4f1d-bd9e-26088313b864@linaro.org>
Date: Mon, 5 Oct 2026 09:33:51 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] perf cs-etm: Synthesize missing HW_ID mappings for
 raw trace
To: Leo Yan <leo.yan@arm.com>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@linux.dev>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Suyash Mahar <smahar@meta.com>,
 Amir Ayupov <aaupov@fb.com>, Arnaldo Carvalho de Melo <acme@redhat.com>,
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261002-james-cs-hw_id-output-failure-v3-0-1d8b6ef339c8@linaro.org>
 <20261002-james-cs-hw_id-output-failure-v3-3-1d8b6ef339c8@linaro.org>
 <20261002171405.GG1208404@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20261002171405.GG1208404@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/10/2026 18:14, Leo Yan wrote:
> On Fri, Oct 02, 2026 at 12:15:13PM +0100, James Clark wrote:
> 
> [...]
> 
>>   static struct cs_etm_queue *cs_etm__get_queue(struct cs_etm_auxtrace *etm, int cpu)
>> @@ -314,12 +317,11 @@ static int cs_etm__map_trace_id_v0(struct cs_etm_auxtrace *etm, u8 trace_chan_id
>>   		return -EINVAL;
>>   
>>   	/*
>> -	 * If the queue is unformatted then only save one mapping in the
>> -	 * queue associated with that CPU so only one decoder is made.
>> +	 * Ignore HW_IDs for unformatted, a decoder will be made
>> +	 * unconditionally later.
>>   	 */
>>   	if (etmq->format == UNFORMATTED)
>> -		return cs_etm__insert_trace_id_node(etmq, trace_chan_id,
>> -						    cpu_metadata);
>> +		return 0;
> 
> Nitpick: It seems to me that we can move the
> etmq->format == UNFORMATTED check into cs_etm__process_aux_output_hw_id().
> 
> This avoids duplicating the check in both cs_etm__map_trace_id_v0()
> and cs_etm__process_trace_id_v0_1(), and makes it more apparent that
> the unformatted case does not use HW_ID at all.
> 
> It's up to you whether to keep it as is or update it. Either way:
> 

I might leave it for now. It's also called by 
cs_etm__map_trace_ids_metadata() which doesn't have a reference to the 
queue, and neither does cs_etm__process_aux_output_hw_id(). Probably not 
worth another refactor at this point.

> Reviewed-by: Leo Yan leo.yan@arm.com
> 
> P.S. Although I contributed the initial idea, the change is now quite
> different from the original patch I shared. Please feel free to drop my
> name if you prefer.

Will do if I send another one, but it looks like it can be applied now 
so it might have to stay.
