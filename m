Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F041C2D248B
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Oct 2025 09:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760000800; cv=none; b=mgpzFh6wo3ckvW1rxo5tRoW7ir3ue7rCJx42juXXIogrVf+QTOR7q+hS4f4nsXo3BWpZZtcvKBl9TEaGhMbTVs2w1aw6wSt8Je/uhHPjkyqiyqzJrjFyWxD/tNjlUOJSoP47f3fgGRm0K50tHGHkOLceBMAJYmPAaRVJ5UC/038=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760000800; c=relaxed/simple;
	bh=k077OpgFOoyPNJnpqtuATjFuVcbrfnogPqd7drNXAWA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FS1gXzFB2iWIYs5kcOVmE68iOwV2BR/3Zj80TIgqCOkD3l1JE9wBkSNGeBFGzzL4Cwqw/zhcTT6S2IyA2lxit6xcRkteI1HborFkjvK4xP0PdUuCEJK+fodtYme60Tl/LXVl7zdmnZssnKASK38UVF6GZvQrdkYNxrZk+5Xde1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X9dI/+ot; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X9dI/+ot"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e52279279so4631885e9.3
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Oct 2025 02:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760000796; x=1760605596; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J48rQBykDWCT3Ii30eoI2mL/LdKQbtj2BoXwRMrCGE8=;
        b=X9dI/+otexiNuCCDHLjWsvw4uC+yr8VVQqbDhb0RDfhCxbyGosXqV+8kg6qLNkKQjB
         K/3+gnDtYarVzNwu2jhPPqnw3ejMu8Bah3SDMfD2a7t5HcpDKyM0XEs0jEOP7N5BRA9R
         ZWOntq/WAlWQx2ySqSsdVT1zNNPQP9H3ubUgFPZBh8FWJ62YIxNqpXx+P2JcAGMp7Fqu
         W4CEw2fY8V8L8MshsuZCEwGCtoWPtGUomrJ2SQ47IWSOoAiKl/tcVzGfkHQVESUk5ETr
         5ito+UAzeW0ktypG7veXfKiowGOOdBce2GpDL1GA+j0CkQBWeObUXaw0R1DoFkD8pwrg
         +j5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760000796; x=1760605596;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J48rQBykDWCT3Ii30eoI2mL/LdKQbtj2BoXwRMrCGE8=;
        b=rcK8p3eFUyRsCe63XJDlQ468g42Of6ISNLqTi2cPUNxmG5bB4y7cOyraTmkwErCiyD
         bhEq4nodL/Zh2qoTsXVplxlzZ6iOZpzcvd4B7Jm4c/YNv61sOb+h2fj2a21GaEtDNgif
         qeeSCRGSOeYYinU48Svq6xIqulfPPL8vIU3GuSJjDMxLHI4EwV7AHx5xuKE5zTihc8cX
         c2nvZzvhVFrayNhIwCF9c+EpOPVZicHIQWsGCINOIdBVvPSzWhYRnH3IlABQrrnLEXNC
         D+8uQhPVB8LazXZhEwnldSWQRjOUB5xMeeXbc3sIj6f4j9eiki6WNC2ra/XNaur4cCR6
         Mh7g==
X-Forwarded-Encrypted: i=1; AJvYcCVvBuTKCdJTj7EPQESe3wESC59DXH6EML12VQCjXlqWrMRvbVBhUH4iDlDaC+RArhZBcddY8uXGK53Ppd1HY1lx@vger.kernel.org
X-Gm-Message-State: AOJu0YypFgztz/ioJmvXEj0ULyMTtnj9hkFcyk/k+8/N4XNthZMP6HAc
	nnqMY8nFU7yy7bX7uqYArifBZZMk+Re1UaRbzobuvXH2r1j0QMNC2SQh6TQ1FGdCuGY=
X-Gm-Gg: ASbGnct5kn0oV0xLGax4NXxGrRGFR+1juyqu0TeCQUC+o7wncC83YWZhEnMddOE4wvx
	Tvb1/5woAIfAvhfvJQj1QHBKmsHIy00hEA84NDGnQURaxBqsxnxSmwijp03caaeRGWH9HBm4XWJ
	W8GOqsVhUOH3FIclbA0NLNfuEHyElWM35gbnwFO1xbk3KjzonBQmOEVcyvENBOplLBQfMXGzBqI
	sBlclwLzY68HcRYBy20SV4J2aeD2weFWWaRa0veN4hF2RRk9PK/TPmrgqMzV6v0M49CT1vD5YsV
	suLyTimR3n1N/v4f6cP6uvT3ZWMDEq01lURHf/mHuyXVJhpM1+C359F+BU0Jz8bvGXmSDsj9hWD
	FWeU4zvY1waliNaZ6EU8P1Bsof9FYHlikbiU8p7DncN8k8FIdfJe5g/k8
X-Google-Smtp-Source: AGHT+IEAe10HGupW0C0imyF3812fO4JpavJhwuTnW9WFqcLxeal+Kei55mpY2juDKAUc7lZYLtm4UQ==
X-Received: by 2002:a05:600c:4745:b0:46e:59f8:8546 with SMTP id 5b1f17b1804b1-46fa9af35e7mr46222785e9.17.1760000796024;
        Thu, 09 Oct 2025 02:06:36 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e9719sm34426273f8f.31.2025.10.09.02.06.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 02:06:35 -0700 (PDT)
Message-ID: <a252e477-2f5c-41ef-8cf9-bcee5e0e7574@linaro.org>
Date: Thu, 9 Oct 2025 10:06:34 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/25] perf arm_spe: Decode ASE and FP fields in other
 operation
From: James Clark <james.clark@linaro.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
References: <20250929-perf_support_arm_spev1-3-v1-0-1150b3c83857@arm.com>
 <20250929-perf_support_arm_spev1-3-v1-5-1150b3c83857@arm.com>
 <897c28a8-599f-44b3-8939-8279d2639f2c@linaro.org>
Content-Language: en-US
In-Reply-To: <897c28a8-599f-44b3-8939-8279d2639f2c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 09/10/2025 10:04 am, James Clark wrote:
> 
> 
> On 29/09/2025 5:37 pm, Leo Yan wrote:
>> Add a check for other operation, which prevents any incorrectly
>> classifying. Parse the ASE and FP fields.
>>
>> After:
>>
>>    .  0000002f:  48 06                                           OTHER 
>> ASE FP INSN-OTHER
>>    .  00000031:  b2 08 80 48 01 08 00 ff ff                      VA 
>> 0xffff000801488008
>>    .  0000003a:  9a 00 00                                        LAT 0 
>> XLAT
>>    .  0000003d:  42 16                                           EV 
>> RETIRED L1D-ACCESS TLB-ACCESS
>>
>> Signed-off-by: Leo Yan <leo.yan@arm.com>
>> ---
>>   tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 6 +++++-
>>   tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h | 4 ++++
>>   2 files changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/ 
>> tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
>> index 
>> 533920b738cbcb39136d1ba3d88e99f9d8009e74..21b65a9b40f481b6cb25aaf01ab627ade046ff72 100644
>> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
>> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
>> @@ -351,8 +351,12 @@ static int arm_spe_pkt_desc_op_type(const struct 
>> arm_spe_pkt *packet,
>>                   arm_spe_pkt_out_string(&err, &buf, &buf_len, " FP");
>>               if (payload & SPE_OP_PKT_SVE_PRED)
>>                   arm_spe_pkt_out_string(&err, &buf, &buf_len, " PRED");
>> -        } else {
>> +        } else if (SPE_OP_PKT_OTHER_SUBCLASS_OTHER(payload)) {
>>               arm_spe_pkt_out_string(&err, &buf, &buf_len, "OTHER");
>> +            if (payload & SPE_OP_PKT_OTHER_ASE)
>> +                arm_spe_pkt_out_string(&err, &buf, &buf_len, " ASE");
>> +            if (payload & SPE_OP_PKT_OTHER_FP)
>> +                arm_spe_pkt_out_string(&err, &buf, &buf_len, " FP");
>>               arm_spe_pkt_out_string(&err, &buf, &buf_len, " %s",
>>                              payload & SPE_OP_PKT_COND ?
>>                              "COND-SELECT" : "INSN-OTHER");
> 
> A warning for unknown packet type would be useful here now that there is 
> no final else catch-all.
> 

Although I see it's consistent with other cases now. Maybe it could be a 
later fix to add unknown packet type warnings for all cases.

>> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/ 
>> tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
>> index 
>> 48bd9e9ef132b11b79ffe2e2fbc7cfe4c340ff92..704601c6dbe30e93f83a82670d0d60344a22222a 100644
>> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
>> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
>> @@ -123,8 +123,12 @@ enum arm_spe_events {
>>   #define SPE_OP_PKT_HDR_CLASS_LD_ST_ATOMIC    0x1
>>   #define SPE_OP_PKT_HDR_CLASS_BR_ERET        0x2
>> +#define SPE_OP_PKT_OTHER_SUBCLASS_OTHER(v)    (((v) & GENMASK_ULL(7, 
>> 3)) == 0x0)
>>   #define SPE_OP_PKT_OTHER_SUBCLASS_SVE(v)    (((v) & (BIT(7) | BIT(3) 
>> | BIT(0))) == 0x8)
>> +#define SPE_OP_PKT_OTHER_ASE            BIT(2)
>> +#define SPE_OP_PKT_OTHER_FP            BIT(1)
>> +
>>   #define SPE_OP_PKT_LDST_SUBCLASS_GP_REG(v)    (((v) & GENMASK_ULL(7, 
>> 1)) == 0x0)
>>   #define SPE_OP_PKT_LDST_SUBCLASS_SIMD_FP(v)    (((v) & 
>> GENMASK_ULL(7, 1)) == 0x4)
>>   #define SPE_OP_PKT_LDST_SUBCLASS_UNSPEC_REG(v)    (((v) & 
>> GENMASK_ULL(7, 1)) == 0x10)
>>
> 

