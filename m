Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8C3944F
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Dec 2024 08:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733301145; cv=none; b=oBOM860GZR304eYQyBDgIeSdI/UFpJYDfyqEXc4puBbv/0c78TDoy/gaVIuRb1bomxrmbXdCLPY10dIAsw/G3gYIMxDnYSaSB+U2/ez8oT1Q80PWE3F9g4ofhW1BrmMvjZNM/rAwjmLfhN43RtLW4FqgT8U4GMKkLywa6Lhg4sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733301145; c=relaxed/simple;
	bh=zbB+QFCztPKtbAPO66u/b7Q6li5azbG20sPo396qa0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ClFWl37mgfdO4tNX0dpyZMF5+lR4qzvy6FNq2UCHVrrBQ3N0r2jXbQJvMLKgQ1cW3Z7gz0IIyYhFrVXb9A0P53pUmkN20ZbvZ84HeQdg00oHTRvRp/jgRWvorerSPkoLXfBfecZ5O75mGwYSYBdfaQHcdSsO0GWaxBg7TSxKJsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=MQHNxcjU; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="MQHNxcjU"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7251731d2b9so466656b3a.1
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Dec 2024 00:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733301143; x=1733905943; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bnMW2t5LKUBnNbekkAf4LMt1K0EpQnTIYhACyHeiDCM=;
        b=MQHNxcjUcvcZf1hlA4AYvCZaLIuFky9vHwf5GB5JqJLbgdlYpmNGDfDzmqxGChUQJ5
         QF8t+tviUyF7k9B/BdOgByEMrYIcJ7mZsoTm/WqxPbPb9EF2oF4NFa7pCMYK8ScwOkGB
         HWIKsdRkJOxKDcKkPddKfdmNheM1OC6wOSxyFNuW3gVThAzh2fmtdtbovgGSeDMuzHIV
         WA+lxQuX+n8YLZc279Vtst/cW2Wq5FmgQuPVPBnPkbPf5fAh0bEP9EBazVeL5VPg8GtZ
         7UHJOyl4Qju6TX7+K7fbaW/zzfL7H8LNZNEuXj4ckm9oeIW2SZD9D9d6Bc/KsqzKqj9T
         SMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733301143; x=1733905943;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bnMW2t5LKUBnNbekkAf4LMt1K0EpQnTIYhACyHeiDCM=;
        b=pH5KM4mpSoCNA5hEP4OwTjw2hIpq0AfZt1KXug+Rl/z+ZrBvilteVHLhJRjxTqlJH/
         ve/fbOUdEj6h6QJAod+g12/7gX4XYMSIggtQdyeN5u7KYqbkSpozbRXOgJEnCSKUSIjF
         72NpEFeuCWsUr0bvZr5QHuWclHnHUZcR7zBn7zhG6VQL3OVNC2Ken4iXKLGxY00DA+Oo
         hambV8df6BbjgzDi6PWN7HPLr4pOcUAJzsUys9sRx5wN1iDkBEkMm/YOYFv7AHm1Xxss
         pNBY5C0M8gn6Z2yfPsIz2FVcxubS0niEyMWa8sQean+6G2ygCBDCW4/POVX5Sq0O2ZwB
         PQPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnGUOb3abZSyo6HUkq86qQ/91Bc1jWY1PbeUlyJxmSywb8Md2s3fxQ4WgwTKJSEnvEAdnlB2zHhS4C1khazuoI@vger.kernel.org
X-Gm-Message-State: AOJu0YyKb2JYQZCpUMlBOzhX7o2HOVL0D/88ewFm+ShNYWlsxy8honk1
	yjBryfMjgbQI8pHH5Wy3CYGKuu6JNIT/f2+ZwurY2R1RvoafPwSDOCPPEdLbt7I=
X-Gm-Gg: ASbGncvgIMs7Z9AUySKOx/oBrE8LCdvwVa8b3KyYdVw8g89IiHuP5XcySNB1FVjegnJ
	HNYcOcDnfjyfgEBf1ducPyq5w5ZGtPr3IkSFX2xZStP5fhQVF3kIcXv/MMosiJ6Y2FNDcRGwXrH
	YwKpBvZCDQJZqua1SNMy4zlMm3FSuh71owtPNtdtgX4WDuGxiVBZvE/4+FdMWBOyGXNNJ7LwzNQ
	d8A4f73mvEpKEeu1MhyrlQTDnna/itaZTZj3/XJmGlLFeIXUmqKsLGboKJKA2Y=
X-Google-Smtp-Source: AGHT+IHOFXcLhAtgSKDz+uz5SjVYmgxi/mOoWfkRQ9WH7HYuhwNGn8YTjGrK+dNdYXbF9hcNvFh6FA==
X-Received: by 2002:a17:902:ccc5:b0:215:9d48:46f9 with SMTP id d9443c01a7336-2159d484a42mr160179695ad.21.1733301142748;
        Wed, 04 Dec 2024 00:32:22 -0800 (PST)
Received: from [10.255.194.25] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7259114e1b3sm675874b3a.25.2024.12.04.00.32.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 00:32:22 -0800 (PST)
Message-ID: <4d6adb42-81cf-4a8b-a8c5-4b322564430c@bytedance.com>
Date: Wed, 4 Dec 2024 16:32:16 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [RFC 03/12] perf event action: Add parsing const
 integer expr support
Content-Language: en-US
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 james.clark@arm.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241128133553.823722-1-yangjihong@bytedance.com>
 <20241128133553.823722-4-yangjihong@bytedance.com> <Z0jRvSlEZveQFVh7@x1>
From: Yang Jihong <yangjihong@bytedance.com>
In-Reply-To: <Z0jRvSlEZveQFVh7@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 11/29/24 04:25, Arnaldo Carvalho de Melo wrote:
> On Thu, Nov 28, 2024 at 09:35:44PM +0800, Yang Jihong wrote:
>> Support parsing of constant integer expression.
>>
>> Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
>> ---
>>   tools/perf/util/parse-action.c | 52 ++++++++++++++++++++++++++++++++++
>>   tools/perf/util/parse-action.h |  1 +
>>   tools/perf/util/parse-action.l | 19 +++++++++++++
>>   tools/perf/util/parse-action.y | 13 ++++++++-
>>   4 files changed, 84 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/parse-action.c b/tools/perf/util/parse-action.c
>> index 391546bf3d73..3b10cf9f99b3 100644
>> --- a/tools/perf/util/parse-action.c
>> +++ b/tools/perf/util/parse-action.c
>> @@ -7,6 +7,7 @@
>>    *
>>    * Supported expressions:
>>    *   - constant:
>> + *     - integer
> 
> And now there are alignment differences and no : ?
This indicates that integer expression is a subclass of constant 
expression, so integer is indented inside constant.
> 
>>    */
>>   
>>   #include "util/debug.h"
>> @@ -118,7 +119,58 @@ void event_actions__free(void)
>>   	(void)event_actions__for_each_expr_safe(do_action_free, NULL, false);
>>   }
>>   
>> +static int expr_const_int_new(struct evtact_expr *expr, void *data, int size)
>> +{
>> +	if (data == NULL ||
>> +	    (size != sizeof(int)
>> +	     && size != sizeof(long) && size != sizeof(long long))) {
> 
> && should be at the end of the previous line, just like you did with the
> || at the end of the first line
Okay, will fix in next version.

Thanks,
Yang
