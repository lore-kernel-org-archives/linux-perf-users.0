Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10EA276050
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Feb 2026 11:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771240741; cv=none; b=gOmfBxqGzPjg2QXCgtnUrbV8ekpUsTjUgEAgGNqhFm8Z5dhnaEgAtQt01mxzxisFHSRHwlUYw6odP89iwPyXYExeagGCsMAR1csFO4ou/bY6kxc1pCaHtWJwhUWIuMpTLLtbiuauJBqpcushOy8OYXSr/9lfO7ON3awL6OQALYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771240741; c=relaxed/simple;
	bh=PaZgIpamPhNVAi3HF1I8yncBr3MffQm3k/+p5MOwzLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JUIUteS121rqlV0kCZcRMRgyQgrVgthJsTIRyWOTHhB4lNVVRb3AQttUJCcmcXowJs1AUfcI+9PjztifwmFNvGRXp1fmAUOryBCN4/OJoRWHy/AMpBNdqnoQRfQpCcUb6VCxnQ/cgKUZbiXSE/oLB7V0eBtbbng9vEDy7HEYXvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DThxHIxS; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DThxHIxS"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4327790c4e9so2257211f8f.2
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Feb 2026 03:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771240738; x=1771845538; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=17HFvC407rHFCRdTCYg/CjcUmCQt5v/OQzlYZuxdpL0=;
        b=DThxHIxSIF3WKiHj/QVRaRQtKPJaJt2fXXgYq/4oaqgV4uEexz9i2xUY0KDo0vaxm+
         /b8eznsxvTlsx3zpp8oOFJwpAjJfLEGDjurxjiDJwx9/exzFIT65Jn/aLely6iWtKOwk
         2N2M+/p/KD1ppR0MhLozPkiaeOjq6ymcgDlS5gn5Zihuy17XBQFlD7Sf1ZLC3uofbjH9
         KPKybQH6difAdpCDWWojrgGIhyUyQqbjqB4arplMNy8bdwTUSOfiVZ1llcIsbMBr3ZuR
         Jfuc2Q/UzJiIWbw8I5wR8ZhYs7JAqmu6qF9ytTNYuSbwGCf+vzCzFsbQGWYXzIXGMosz
         s4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771240738; x=1771845538;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=17HFvC407rHFCRdTCYg/CjcUmCQt5v/OQzlYZuxdpL0=;
        b=P23NOH4XV6Wy1S3hlmnmrDargFuP0/tUlnUfoa9lLz8xeHjZL1+5hgV25PpfRmEFeT
         T1dHN0EUqIDf3mFpQXB/1P5ruFyK/FG+VogocWhf5ijsCpuV0DJw+5J8ZkwMJ9h7wouy
         TuBanwV6sbsLsIGNINZy8H+S1t6DfIatUS0f0ArfbcSWQy11kbx0TKV3zc0iMHXhmx89
         4Hb2dT9qGfl8relOH+AQ8Dz9bihQ7bcIb1kG61i97jKpDffWGJgwrVpplXnCmlZvVHT1
         2cawHPZcHRnMcHh+pc/8B69rAPQb69myTl1bxdsOTgNHLMXP5VIjfUFBk08O678UZjV2
         XZnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgGg8hUic6HI1+dE0rl97dgUyr3Fjr2uSmm4RQkUWy7KO/fy6fATlGmNBzHnxyhjECrR91O8TqF8cYO+cfIc21@vger.kernel.org
X-Gm-Message-State: AOJu0YxY30p7AlGgMbEfnxRBCEv5ir+FRThmcfdu9gpIDfd2nfmDOy7l
	XQgeHCdlYmLgqrJdV7RZZFyiwGXKDkAN77ZrIgG+PgXMqCJQ6Ro8ae7SYHy7M+LkFXo=
X-Gm-Gg: AZuq6aIeZ3Tj2d22QYdQeNIiK+Gb974tk52OM1Lpp4dLB4I81QpggI6JH1Fg6jpNaVk
	jN8N2iZxJmUIbadEbEzQfMtbwc/t97ZGospKp6cH3UeStT0YyDJTvJbFUfYdeFS8ovegOFN5Xro
	th7vcGGOqqomFBL+0Ah1Cj57N2xORdtckbiQ7nqG03NkiwCSUTD2JcDxcAb1jcrAoyig+Wmep5P
	rR5w3eiKrG2pStLpNYDRUOUQHw3PRc+qiARszvtTKzzC9nXoXWMrSpRkUx43aIwwgPgu6zdalxl
	N0X7ZkhRcZjb5t3o8rMcmAHj79D95D6LiFBuKImM9x4DQ6C74A8K4v69s6azEVOX63zbZFEm/PP
	twmz0XnlRi1EpT+dZdcv1lK5MCb9kkkVbwLYvLBJrLYgFds03zGKEbUSRXtJFEdtIKFfqlKWrvM
	q063Smwrm/9dQDzQLcOiFzuph/x69vHzE0+1uo7Jg=
X-Received: by 2002:a05:6000:178b:b0:435:9690:f056 with SMTP id ffacd0b85a97d-43796aefb76mr19098979f8f.35.1771240737133;
        Mon, 16 Feb 2026 03:18:57 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abc8b1sm27555334f8f.23.2026.02.16.03.18.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 03:18:56 -0800 (PST)
Message-ID: <2109e3bf-8c33-49cf-aa52-e81e7c5ef87b@linaro.org>
Date: Mon, 16 Feb 2026 11:18:55 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next] perf parse-events: Fix big-endian 'overwrite'
 by writing correct union member
To: Thomas Richter <tmricht@linux.ibm.com>, Ian Rogers <irogers@google.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
 agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
 hca@linux.ibm.com, japo@linux.ibm.com
References: <20260212125315.777356-1-tmricht@linux.ibm.com>
 <CAP-5=fWxHfGZaLyrvzuQF83K1g=LaFC4uRvg3HjM0=W9ts_yxQ@mail.gmail.com>
 <30f598eb-4c9e-49da-a643-118b462b8b77@linux.ibm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <30f598eb-4c9e-49da-a643-118b462b8b77@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16/02/2026 10:04 am, Thomas Richter wrote:
> On 2/12/26 19:17, Ian Rogers wrote:
>> On Thu, Feb 12, 2026 at 4:53 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
>>>
>>> The "Read backward ring buffer" test crashes on big-endian (e.g. s390x)
>>> due to a NULL dereference when the backward mmap path isn't enabled.
>>>
>>> Reproducer:
>>>    # ./perf test -F 'Read backward ring buffer'
>>>    Segmentation fault (core dumped)
>>>    # uname -m
>>>    s390x
>>>    #
>>>
>>> Root cause:
>>> get_config_terms() stores into evsel_config_term::val.val (u64) while later
>>> code reads boolean fields such as evsel_config_term::val.overwrite.
>>> On big-endian the 1-byte boolean is left-aligned, so writing
>>> evsel_config_term::val.val = 1 is read back as
>>> evsel_config_term::val.overwrite = 0,
>>> leaving backward mmap disabled and a NULL map being used.
>>>
>>> Store values in the union member that matches the term type, e.g.:
>>>    /* for OVERWRITE */
>>>    new_term->val.overwrite = 1;  /* not new_term->val.val = 1 */
>>> to fix this.
>>>
>>> Impact:
>>> Enables backward mmap on big-endian and prevents the crash.
>>> No change on little-endian.
>>>
>>> Output after:
>>>   # ./perf test -Fv 44
>>>   --- start ---
>>>   Using CPUID IBM,9175,705,ME1,3.8,002f
>>>   mmap size 1052672B
>>>   mmap size 8192B
>>>   ---- end ----
>>>   44: Read backward ring buffer                         : Ok
>>>   #
>>>
>>> Fixes: 159ca97cd97c ("perf parse-events: Refactor get_config_terms() to remove macros")
>>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>>> Reviewed-by: Jan Polensky <japo@linux.ibm.com>
>>> Cc: James Clark <james.clark@linaro.org>
>>> Cc: Ian Rogers <irogers@google.com>
>>> ---
>>>   tools/perf/util/parse-events.c | 49 +++++++++++++++++++++++++++++++++-
>>>   1 file changed, 48 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
>>> index d4647ded340f..12fe5392c832 100644
>>> --- a/tools/perf/util/parse-events.c
>>> +++ b/tools/perf/util/parse-events.c
>>> @@ -1250,7 +1250,54 @@ static int get_config_terms(const struct parse_events_terms *head_config,
>>>                          }
>>>                          new_term->free_str = true;
>>>                  } else {
>>> -                       new_term->val.val = val;
>>> +                       switch (new_type) {
>>> +                       case EVSEL__CONFIG_TERM_PERIOD:
>>> +                               new_term->val.period = val;
>>> +                               break;
>>
>> Thanks Thomas and sorry big endian got broken! I'm a little confused
>> here as period is a u64 so I think this one can be a default case.
>>
>>> +                       case EVSEL__CONFIG_TERM_FREQ:
>>> +                               new_term->val.freq = val;
>>> +                               break;
>>
>> Also a u64.
>>
>>> +                       case EVSEL__CONFIG_TERM_TIME:
>>> +                               new_term->val.time = val;
>>> +                               break;
>>> +                       case EVSEL__CONFIG_TERM_STACK_USER:
>>> +                               new_term->val.stack_user = val;
>>> +                               break;
>>
>> Also a u64.
> 
> Agreed, I really don't mind. However should that type be changed (yep extremely unlikely)
> we run into the same issue again.
>>
>>> +                       case EVSEL__CONFIG_TERM_INHERIT:
>>> +                               new_term->val.inherit = val;
>>> +                               break;
>>> +                       case EVSEL__CONFIG_TERM_OVERWRITE:
>>> +                               new_term->val.overwrite = val;
>>> +                               break;
>>> +                       case EVSEL__CONFIG_TERM_MAX_STACK:
>>> +                               new_term->val.max_stack = val;
>>> +                               break;
>>> +                       case EVSEL__CONFIG_TERM_MAX_EVENTS:
>>> +                               new_term->val.max_events = val;
>>> +                               break;
>>> +                       case EVSEL__CONFIG_TERM_PERCORE:
>>> +                               new_term->val.percore = val;
>>> +                               break;
>>> +                       case EVSEL__CONFIG_TERM_AUX_OUTPUT:
>>> +                               new_term->val.aux_output = val;
>>> +                               break;
>>> +                       case EVSEL__CONFIG_TERM_AUX_SAMPLE_SIZE:
>>> +                               new_term->val.aux_sample_size = val;
>>> +                               break;
>>> +                       case EVSEL__CONFIG_TERM_CALLGRAPH:
>>> +                       case EVSEL__CONFIG_TERM_DRV_CFG:
>>> +                       case EVSEL__CONFIG_TERM_BRANCH:
>>> +                       case EVSEL__CONFIG_TERM_AUX_ACTION:
>>> +                       case EVSEL__CONFIG_TERM_USR_CHG_CONFIG:
>>> +                       case EVSEL__CONFIG_TERM_USR_CHG_CONFIG1:
>>> +                       case EVSEL__CONFIG_TERM_USR_CHG_CONFIG2:
>>> +                       case EVSEL__CONFIG_TERM_USR_CHG_CONFIG3:
>>> +                       case EVSEL__CONFIG_TERM_USR_CHG_CONFIG4:
>>> +                       case EVSEL__CONFIG_TERM_RATIO_TO_PREV:
>>
>> I think these cases are all assigning a str so would using str rather
>> than val be cleaner?
>>
>> The change looks good but it is a little inconsistent that the default
>> copying is done for str values but not for u64. It would kind of be
>> nice to remove the default copying so that if a new config term is
>> added the switch will fail to compile due to a missing case statement.
>> Then we can do the right copy for big endian. Given we've broken
>> big-endian here we should probably add a comment.
>>
>> Thanks,
>> Ian
> 
> Yep I will send v2 later today and hopefully address your remarks completely.
> 

Oops sorry about the breakage. You could remove the val member entirely 
now and set them all individually. I only added it to avoid a second 
switch statement after creating the new entry. But if we have to add the 
switch back in again and list out each item we might as well go back to 
how it was before and assign each one individually.

Or a nuclear option could be to just have a single u64 numeric member 
and a string one and not try to rename them and change the types so 
much. Ironically half of the usages of the bools look like this:

  attr->aux_output = term->val.aux_output ? 1 : 0;

Almost makes all the shuffling around and renaming seem a bit pointless 
in the end.


>>
>> I> +                       default:
>>> +                               new_term->val.val = val;
>>> +                               break;
>>> +                       }
>>>                  }
>>>          }
>>>          return 0;
>>> --
>>> 2.53.0
>>>
> 
> Thanks
> 

