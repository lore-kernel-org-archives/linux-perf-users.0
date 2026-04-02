Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA59A3D8128
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Apr 2026 09:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775123335; cv=none; b=BI1Ng8Htqd4QToc/gEG2Doe8fDBu+8kwtHnOpaAv7um+fyS99mX2rKSgur6TMvkyNULdHW4rsoAtoNQtPZuv9noW0HeOWZmkjITxp44Z70AtamgN7Sel6ASTl/CY2XmGJQpMhxTg3PSBbOdrnLa1WwgNpjIN9JcIen689COl0TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775123335; c=relaxed/simple;
	bh=F2AvbkVLdysGuxwhR8Dur8bhLDXPNFj0dL8sdWMBZu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OMoE81puJR4ydXUfhjUZxW6i2tjvnRnn5c4nNL7vsq50D9MCnaacZrH80qB3qAQe5+7z5tfYFkwTprPoYOZtxCFnL9QwE2mB6Sak0CEFkajj7va6b0x7kAt0jBKExz8v6FCx7tj/kiMnrUg0Y3s1MIZD3mLGMRBEJwyfZY9lKe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HJ69a2m2; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HJ69a2m2"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4852c9b4158so5507405e9.0
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Apr 2026 02:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775123323; x=1775728123; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AGicjAqt+pYR5kpOTLsrHtRFExrJLu3z8Y8VhWzp3DE=;
        b=HJ69a2m2sSrEMUxiq7aJ8nYvqpsjoTO29EqSx8SI6iPWzkzMN9kqHPXYgcfwS0clwJ
         2qYpk/TQmWMnSCZzxrdN5hk/s6UyZgrTI9drapiVCtdpI6ncUGQxFkwpx1S6MvSCOupg
         KgL6mINbVraQwsQ6fFtzloMTCunJCxiNE7Qd7F6VH9iEZPGysKdYoWCTQtmy/FFbaBCX
         5cx7ejQZhY26OU+mHUH7/sLuBy4NrC+/QBVMNjy0X494PDv/tkqqPTSvDvCygN+O8dCE
         s2yr0WlTERjOgwIrq92RvDp8vgSu5fvgIxrZwq68wu9QvILtwwT9rjYYKzuqTf9gPtwU
         I/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775123323; x=1775728123;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AGicjAqt+pYR5kpOTLsrHtRFExrJLu3z8Y8VhWzp3DE=;
        b=THltxm9o1Y3aA7otJyOI7eUYtyn/RWIW2rSzDaX+SRM08Z0fcSXLYflnZ6yB8EY7si
         XaS/uOIG+vg+sDjjgmtL3qa/YogvVn0qGu/PURADkciCURhZpcnRx9WtKIfcNNl8jesq
         jqjx70fovXKyIFaSl2R4uq6w3mww8nsdsyAHkGWwJTNcweAfAwhjwr7CExXHIZ10SHh2
         D72NP5DKi8TqqV6RvLK7mOXyPkjq/IDAAbWTvSYrvsq4EODKhLQ1NYXWhcYsiILiPK/y
         dBARnQo0DBs8OgFsDoVYog+EICcme9gMHhGHkILH1NeS38g58WUHKAu0a1+zWE1zB/jL
         hZFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVq+0YIx1/RHr3qWxTB3BS3eiGELkkQsxC8LtzCCvws0SYhFQO+L8GHoFKNce7NHMzDHzfNqW18oAgijLNjDqqt@vger.kernel.org
X-Gm-Message-State: AOJu0YwqIdzAKvrNFqVQh8pNZBy5n1ru6MKOyLhpPU2kQAxRRxnVf71a
	breQ88A9JcaUk0QyNoPC5EFLIJ68MpmtHdnSAst+GJS5DQpYI0FW7c078zdl5OvMbTc=
X-Gm-Gg: ATEYQzycEsK0DYtq5SitKm3VkUkCB4Stl2eU8alQS9yE2MWnsVYhbIy09AEn6h5d2vT
	WO5vyMerbVhQ/Tsmxt7Z6WVc7HT9/4yKAAh1PwcDzzFMlqw2nqky2wbT1jmlNvOslkd/po3UdOv
	hmXyydeT+XDGQvLA+Tp8/0b2+LstORwshIxWbRI/IiaG2RugIWKWxFg77lUn/FDTuuSt4JvkdmZ
	4Xq5NJ+XSyLm1wm2bYGGdGg+cep88EgmDHawXkrCmFK673ErKfCMjZZrIJJhdv/LcK7FFLjVh9s
	qhcCoUBZ8sCCUzjKs52FitS1t8+iQCNXtnZ0SEPpuZSNMs93hDFcUpvSTeSfJBWOrbJrP6DoFmM
	VhIGUW3pdySQx/l5bjDy06wincjA3hDuI8YkASNjpqQiRNRIYpZ2tfkQaAsyaUar4fQhrmHyEOI
	06rKJZwuWPqc6DcvjX+jTxRHB0g+dI9fMKbipYSCw=
X-Received: by 2002:a05:600c:638e:b0:483:2c98:4368 with SMTP id 5b1f17b1804b1-4888b76980bmr45277335e9.18.1775123323120;
        Thu, 02 Apr 2026 02:48:43 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c77df84sm102305985e9.4.2026.04.02.02.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 02:48:42 -0700 (PDT)
Message-ID: <28cc665e-ac0c-4efd-89a6-3ac0d9a41752@linaro.org>
Date: Thu, 2 Apr 2026 10:48:41 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] perf arm_spe: Turn event name mappings into an array
To: Leo Yan <leo.yan@arm.com>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Al Grant <al.grant@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260401-james-spe-impdef-decode-v1-0-ad0d372c220c@linaro.org>
 <20260401-james-spe-impdef-decode-v1-2-ad0d372c220c@linaro.org>
 <20260402091300.GF356832@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260402091300.GF356832@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/04/2026 10:13 am, Leo Yan wrote:
> On Wed, Apr 01, 2026 at 03:25:50PM +0100, James Clark wrote:
>> This is so we can have a single function that prints events and can be
>> used with multiple mappings from different CPUs. Remove any bit that was
>> printed so that later we can print out the remaining unknown impdef
>> bits.
>>
>> No functional changes intended.
>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   .../util/arm-spe-decoder/arm-spe-pkt-decoder.c     | 88 +++++++++++-----------
>>   1 file changed, 43 insertions(+), 45 deletions(-)
>>
>> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
>> index 5769ba2f4140..c880b0dec3a1 100644
>> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
>> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
>> @@ -276,6 +276,48 @@ static int arm_spe_pkt_out_string(int *err, char **buf_p, size_t *blen,
>>   	return ret;
>>   }
>>   
>> +struct ev_string {
>> +	u8 event;
>> +	const char *desc;
>> +};
> 
> Maybe we can have more ambition to define a more general structure:
> 
>    struct packet_field_string {
>    	u64 bit_mask;
>    	u64 bit_val;
>    	const char *desc;
>    };
> 
> Thus, this also can be used by other bit fields decoding.  We can do
> this now or if later refactor for other packets.
> 
> Either way is fine for me:
> 
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> 

Thanks. I think I'll leave it as it is, there's a risk of making it too 
generic and then it doesn't fit any other use case anyway. We can always 
add it later.

>> +
>> +static const struct ev_string common_ev_strings[] = {
>> +	{ .event = EV_EXCEPTION_GEN, .desc = "EXCEPTION-GEN" },
>> +	{ .event = EV_RETIRED, .desc = "RETIRED" },
>> +	{ .event = EV_L1D_ACCESS, .desc = "L1D-ACCESS" },
>> +	{ .event = EV_L1D_REFILL, .desc = "L1D-REFILL" },
>> +	{ .event = EV_TLB_ACCESS, .desc = "TLB-ACCESS" },
>> +	{ .event = EV_TLB_WALK, .desc = "TLB-REFILL" },
>> +	{ .event = EV_NOT_TAKEN, .desc = "NOT-TAKEN" },
>> +	{ .event = EV_MISPRED, .desc = "MISPRED" },
>> +	{ .event = EV_LLC_ACCESS, .desc = "LLC-ACCESS" },
>> +	{ .event = EV_LLC_MISS, .desc = "LLC-REFILL" },
>> +	{ .event = EV_REMOTE_ACCESS, .desc = "REMOTE-ACCESS" },
>> +	{ .event = EV_ALIGNMENT, .desc = "ALIGNMENT" },
>> +	{ .event = EV_TRANSACTIONAL, .desc = "TXN" },
>> +	{ .event = EV_PARTIAL_PREDICATE, .desc = "SVE-PARTIAL-PRED" },
>> +	{ .event = EV_EMPTY_PREDICATE, .desc = "SVE-EMPTY-PRED" },
>> +	{ .event = EV_L2D_ACCESS, .desc = "L2D-ACCESS" },
>> +	{ .event = EV_L2D_MISS, .desc = "L2D-MISS" },
>> +	{ .event = EV_CACHE_DATA_MODIFIED, .desc = "HITM" },
>> +	{ .event = EV_RECENTLY_FETCHED, .desc = "LFB" },
>> +	{ .event = EV_DATA_SNOOPED, .desc = "SNOOPED" },
>> +	{ .event = EV_STREAMING_SVE_MODE, .desc = "STREAMING-SVE" },
>> +	{ .event = EV_SMCU, .desc = "SMCU" },
>> +	{ .event = 0, .desc = NULL },
>> +};
>> +
>> +static u64 print_event_list(int *err, char **buf, size_t *buf_len,
>> +			    const struct ev_string *ev_strings, u64 payload)
>> +{
>> +	for (const struct ev_string *ev = ev_strings; ev->desc != NULL; ev++) {
>> +		if (payload & BIT(ev->event))
>> +			arm_spe_pkt_out_string(err, buf, buf_len, " %s", ev->desc);
>> +		payload &= ~BIT(ev->event);
>> +	}
>> +	return payload;
>> +}
>> +
>>   static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
>>   				  char *buf, size_t buf_len)
>>   {
>> @@ -283,51 +325,7 @@ static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
>>   	int err = 0;
>>   
>>   	arm_spe_pkt_out_string(&err, &buf, &buf_len, "EV");
>> -
>> -	if (payload & BIT(EV_EXCEPTION_GEN))
>> -		arm_spe_pkt_out_string(&err, &buf, &buf_len, " EXCEPTION-GEN");
>> -	if (payload & BIT(EV_RETIRED))
>> -		arm_spe_pkt_out_string(&err, &buf, &buf_len, " RETIRED");
>> -	if (payload & BIT(EV_L1D_ACCESS))
>> -		arm_spe_pkt_out_string(&err, &buf, &buf_len, " L1D-ACCESS");
>> -	if (payload & BIT(EV_L1D_REFILL))
>> -		arm_spe_pkt_out_string(&err, &buf, &buf_len, " L1D-REFILL");
>> -	if (payload & BIT(EV_TLB_ACCESS))
>> -		arm_spe_pkt_out_string(&err, &buf, &buf_len, " TLB-ACCESS");
>> -	if (payload & BIT(EV_TLB_WALK))
>> -		arm_spe_pkt_out_string(&err, &buf, &buf_len, " TLB-REFILL");
>> -	if (payload & BIT(EV_NOT_TAKEN))
>> -		arm_spe_pkt_out_string(&err, &buf, &buf_len, " NOT-TAKEN");
>> -	if (payload & BIT(EV_MISPRED))
>> -		arm_spe_pkt_out_string(&err, &buf, &buf_len, " MISPRED");
>> -	if (payload & BIT(EV_LLC_ACCESS))
>> -		arm_spe_pkt_out_string(&err, &buf, &buf_len, " LLC-ACCESS");
>> -	if (payload & BIT(EV_LLC_MISS))
>> -		arm_spe_pkt_out_string(&err, &buf, &buf_len, " LLC-REFILL");
>> -	if (payload & BIT(EV_REMOTE_ACCESS))
>> -		arm_spe_pkt_out_string(&err, &buf, &buf_len, " REMOTE-ACCESS");
>> -	if (payload & BIT(EV_ALIGNMENT))
>> -		arm_spe_pkt_out_string(&err, &buf, &buf_len, " ALIGNMENT");
>> -	if (payload & BIT(EV_TRANSACTIONAL))
>> -		arm_spe_pkt_out_string(&err, &buf, &buf_len, " TXN");
>> -	if (payload & BIT(EV_PARTIAL_PREDICATE))
>> -		arm_spe_pkt_out_string(&err, &buf, &buf_len, " SVE-PARTIAL-PRED");
>> -	if (payload & BIT(EV_EMPTY_PREDICATE))
>> -		arm_spe_pkt_out_string(&err, &buf, &buf_len, " SVE-EMPTY-PRED");
>> -	if (payload & BIT(EV_L2D_ACCESS))
>> -		arm_spe_pkt_out_string(&err, &buf, &buf_len, " L2D-ACCESS");
>> -	if (payload & BIT(EV_L2D_MISS))
>> -		arm_spe_pkt_out_string(&err, &buf, &buf_len, " L2D-MISS");
>> -	if (payload & BIT(EV_CACHE_DATA_MODIFIED))
>> -		arm_spe_pkt_out_string(&err, &buf, &buf_len, " HITM");
>> -	if (payload & BIT(EV_RECENTLY_FETCHED))
>> -		arm_spe_pkt_out_string(&err, &buf, &buf_len, " LFB");
>> -	if (payload & BIT(EV_DATA_SNOOPED))
>> -		arm_spe_pkt_out_string(&err, &buf, &buf_len, " SNOOPED");
>> -	if (payload & BIT(EV_STREAMING_SVE_MODE))
>> -		arm_spe_pkt_out_string(&err, &buf, &buf_len, " STREAMING-SVE");
>> -	if (payload & BIT(EV_SMCU))
>> -		arm_spe_pkt_out_string(&err, &buf, &buf_len, " SMCU");
>> +	print_event_list(&err, &buf, &buf_len, common_ev_strings, payload);
>>   
>>   	return err;
>>   }
>>
>> -- 
>> 2.34.1
>>
>>

