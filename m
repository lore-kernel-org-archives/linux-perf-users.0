Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5C4267B89
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Feb 2026 11:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771241654; cv=none; b=fH8D3ncceSIZ7rNbWTOBgstDaNZfOdecX6q1/ByLSVSwvhqMEOFkgAYzz5/ToHH4K4zg36dF56WPpj0FhQNtXKwdoK9LzVFRx6t6EsSz6AlCSbQ3yiMLHWjBPUMO2Rxt9Bgy8fQrPkqSWEg5E+WgK710dyCEdQP+Tgjj+ZWe4PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771241654; c=relaxed/simple;
	bh=I2G54z3LjpFhitknhEV61k8hXgcN5D8jG7JUekhc1BI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iVC8PpaLD48yPBOsoZWTu4OZg7ofsSlXxUj3EmF5vMeI74R0WqpmrcVCWonY0D5/8sKDBYRCpRieHsTVoJquPJLGyKwvb4qk1TDUnYSxa3RFSRdDejXyUWIm5eU6RuStThcsROp2VoQxS3Y9fnsGGgkOpNaZDM7MyT6kBy1nyDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b+NjBnRw; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b+NjBnRw"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48329eb96a7so16344015e9.3
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Feb 2026 03:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771241650; x=1771846450; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aMQHyb3Me7O3xKkYmNAxoU8e3SEVpbFfIXHRr1rax8A=;
        b=b+NjBnRwkZanuwEZcGVFvk/g1jbU2gRT6f3nUoVORB1Eo/EdlI4K4/O3ARalFlI5Q+
         vN8PEUBjKKvGgDootLrxI7sjW3j7xwamw5z6B5KduyhFsbYk6T5DQA9IAFDh9jTxqMWY
         TD855r+45NJl24lE07EoBEkre3BH88qOdDStnM8nrdmmdsjKrcIGOrKW075CxrC4pAM+
         n5OLncm6wsvPhYYzE+EdLcw78kl3FM0vNhGwjfeCXUHDzlBZTA7VE314h5ywaosg7Mem
         hmrg+mWX3cLIhx8QFCvDEnes9vuwPqSI/AmKDf6M00oivjCxGsj9jJWnZO4Z9W1m5l+e
         Yo8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771241650; x=1771846450;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aMQHyb3Me7O3xKkYmNAxoU8e3SEVpbFfIXHRr1rax8A=;
        b=vz1A9a0DlrolisPowFGOnlAk7rWCbN3oJ/bnluAGc70z+RHhAk5+zUX4yOxVx3U9k2
         RKambSUs+7drdBFfRE/ZlDRowLGb4nCTESnpsP0XsvemS5uNyxjuOLNUn98Xggf9Gfs2
         nRHNcuNi4R97jYPZO4/jeUtWqwdc4gEWtT4iA/RhbKfQ/d9lgelX+pA7j8GCR191S5Xc
         zY6THN6qkAYXUq+KG8iQYUd6UDmv3TigpzyADYaxZkJmDxIZxljl0vOlMJUlnUM7f/FT
         0f0yTIz5YhJAmP4tCZ3SEjxlAtpiY0+ERSKctiWfpfSjy0e6jKo9bphMkT3C9WWSYn5F
         44ew==
X-Forwarded-Encrypted: i=1; AJvYcCU6EbS5XyibMowqGc28V9xr3pHxPdvWlfzp2N6b2pIovgbfAUqov0AqNa4MpXZhfTPmgJL40jgfcZfOdj7vZkrH@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+r5G0J6emoKCEYWkX6EO0e0e1/1AImWO7PabDexzSSlALeaeF
	rSLZRe9CIeOtrzbljsPm4/kM33ICW9nQ4hD5GhPiApP3Z5CsJ2WN33j8N10hFGvpqtk=
X-Gm-Gg: AZuq6aJrBSm7jfvUaTQL0pZ5GCKtDAOhWgPzYyNplmf8/fP4enUqIo3KV5E9Ualw8Ns
	9YBErzpVm11GsMDgQ3/tRFBYDB+XZmZwTUe2w4XZ9D+segLWfK3xcoGosjDM/nyzDAWEac0MaGs
	5z3QAojZ+mlZc6XZgswRP1wqGvCD4HIGDTiKn+O+OvbsX7WkGyKVD0sg6jA/QtNy7VAEAn8mKB8
	PU/U9J2tOCj98wmMz9mJyxFtK7fYgSCCSXGZCIHlqFTXdBCM/3b6WuoukIhaC5OMTUgIv3UKdJK
	VU68olnJ/7GP5WDTJ9Glok4IuK/z+ktn3JPoCn4z23RrkRaxvievogtKvlcuIl3wBq4VCI7BosX
	ibCAw6yGNz2D7tT2ht4DTVApKDysdGjFzjZkyGSoNk7xbCLpe2IFbmgZsHwYuFYuuBZ/1llSMgi
	hiImA1ens6LFYHQc1hHcJ1y/HybA3U
X-Received: by 2002:a05:600c:4f86:b0:47a:810f:1d06 with SMTP id 5b1f17b1804b1-483739fc258mr154626695e9.4.1771241649542;
        Mon, 16 Feb 2026 03:34:09 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48378b5196esm92923415e9.8.2026.02.16.03.34.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 03:34:09 -0800 (PST)
Message-ID: <45417895-ff1b-4b32-9b1d-1464ef17fca2@linaro.org>
Date: Mon, 16 Feb 2026 11:34:08 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next] perf parse-events: Fix big-endian 'overwrite'
 by writing correct union member
From: James Clark <james.clark@linaro.org>
To: Thomas Richter <tmricht@linux.ibm.com>, Ian Rogers <irogers@google.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
 agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
 hca@linux.ibm.com, japo@linux.ibm.com
References: <20260212125315.777356-1-tmricht@linux.ibm.com>
 <CAP-5=fWxHfGZaLyrvzuQF83K1g=LaFC4uRvg3HjM0=W9ts_yxQ@mail.gmail.com>
 <30f598eb-4c9e-49da-a643-118b462b8b77@linux.ibm.com>
 <2109e3bf-8c33-49cf-aa52-e81e7c5ef87b@linaro.org>
Content-Language: en-US
In-Reply-To: <2109e3bf-8c33-49cf-aa52-e81e7c5ef87b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16/02/2026 11:18 am, James Clark wrote:
> 
> 
> On 16/02/2026 10:04 am, Thomas Richter wrote:
>> On 2/12/26 19:17, Ian Rogers wrote:
>>> On Thu, Feb 12, 2026 at 4:53 AM Thomas Richter 
>>> <tmricht@linux.ibm.com> wrote:
>>>>
>>>> The "Read backward ring buffer" test crashes on big-endian (e.g. s390x)
>>>> due to a NULL dereference when the backward mmap path isn't enabled.
>>>>
>>>> Reproducer:
>>>>    # ./perf test -F 'Read backward ring buffer'
>>>>    Segmentation fault (core dumped)
>>>>    # uname -m
>>>>    s390x
>>>>    #
>>>>
>>>> Root cause:
>>>> get_config_terms() stores into evsel_config_term::val.val (u64) 
>>>> while later
>>>> code reads boolean fields such as evsel_config_term::val.overwrite.
>>>> On big-endian the 1-byte boolean is left-aligned, so writing
>>>> evsel_config_term::val.val = 1 is read back as
>>>> evsel_config_term::val.overwrite = 0,
>>>> leaving backward mmap disabled and a NULL map being used.
>>>>
>>>> Store values in the union member that matches the term type, e.g.:
>>>>    /* for OVERWRITE */
>>>>    new_term->val.overwrite = 1;  /* not new_term->val.val = 1 */
>>>> to fix this.
>>>>
>>>> Impact:
>>>> Enables backward mmap on big-endian and prevents the crash.
>>>> No change on little-endian.
>>>>
>>>> Output after:
>>>>   # ./perf test -Fv 44
>>>>   --- start ---
>>>>   Using CPUID IBM,9175,705,ME1,3.8,002f
>>>>   mmap size 1052672B
>>>>   mmap size 8192B
>>>>   ---- end ----
>>>>   44: Read backward ring buffer                         : Ok
>>>>   #
>>>>
>>>> Fixes: 159ca97cd97c ("perf parse-events: Refactor get_config_terms() 
>>>> to remove macros")
>>>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>>>> Reviewed-by: Jan Polensky <japo@linux.ibm.com>
>>>> Cc: James Clark <james.clark@linaro.org>
>>>> Cc: Ian Rogers <irogers@google.com>
>>>> ---
>>>>   tools/perf/util/parse-events.c | 49 ++++++++++++++++++++++++++++++ 
>>>> +++-
>>>>   1 file changed, 48 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse- 
>>>> events.c
>>>> index d4647ded340f..12fe5392c832 100644
>>>> --- a/tools/perf/util/parse-events.c
>>>> +++ b/tools/perf/util/parse-events.c
>>>> @@ -1250,7 +1250,54 @@ static int get_config_terms(const struct 
>>>> parse_events_terms *head_config,
>>>>                          }
>>>>                          new_term->free_str = true;
>>>>                  } else {
>>>> -                       new_term->val.val = val;
>>>> +                       switch (new_type) {
>>>> +                       case EVSEL__CONFIG_TERM_PERIOD:
>>>> +                               new_term->val.period = val;
>>>> +                               break;
>>>
>>> Thanks Thomas and sorry big endian got broken! I'm a little confused
>>> here as period is a u64 so I think this one can be a default case.
>>>
>>>> +                       case EVSEL__CONFIG_TERM_FREQ:
>>>> +                               new_term->val.freq = val;
>>>> +                               break;
>>>
>>> Also a u64.
>>>
>>>> +                       case EVSEL__CONFIG_TERM_TIME:
>>>> +                               new_term->val.time = val;
>>>> +                               break;
>>>> +                       case EVSEL__CONFIG_TERM_STACK_USER:
>>>> +                               new_term->val.stack_user = val;
>>>> +                               break;
>>>
>>> Also a u64.
>>
>> Agreed, I really don't mind. However should that type be changed (yep 
>> extremely unlikely)
>> we run into the same issue again.
>>>
>>>> +                       case EVSEL__CONFIG_TERM_INHERIT:
>>>> +                               new_term->val.inherit = val;
>>>> +                               break;
>>>> +                       case EVSEL__CONFIG_TERM_OVERWRITE:
>>>> +                               new_term->val.overwrite = val;
>>>> +                               break;
>>>> +                       case EVSEL__CONFIG_TERM_MAX_STACK:
>>>> +                               new_term->val.max_stack = val;
>>>> +                               break;
>>>> +                       case EVSEL__CONFIG_TERM_MAX_EVENTS:
>>>> +                               new_term->val.max_events = val;
>>>> +                               break;
>>>> +                       case EVSEL__CONFIG_TERM_PERCORE:
>>>> +                               new_term->val.percore = val;
>>>> +                               break;
>>>> +                       case EVSEL__CONFIG_TERM_AUX_OUTPUT:
>>>> +                               new_term->val.aux_output = val;
>>>> +                               break;
>>>> +                       case EVSEL__CONFIG_TERM_AUX_SAMPLE_SIZE:
>>>> +                               new_term->val.aux_sample_size = val;
>>>> +                               break;
>>>> +                       case EVSEL__CONFIG_TERM_CALLGRAPH:
>>>> +                       case EVSEL__CONFIG_TERM_DRV_CFG:
>>>> +                       case EVSEL__CONFIG_TERM_BRANCH:
>>>> +                       case EVSEL__CONFIG_TERM_AUX_ACTION:
>>>> +                       case EVSEL__CONFIG_TERM_USR_CHG_CONFIG:
>>>> +                       case EVSEL__CONFIG_TERM_USR_CHG_CONFIG1:
>>>> +                       case EVSEL__CONFIG_TERM_USR_CHG_CONFIG2:
>>>> +                       case EVSEL__CONFIG_TERM_USR_CHG_CONFIG3:
>>>> +                       case EVSEL__CONFIG_TERM_USR_CHG_CONFIG4:
>>>> +                       case EVSEL__CONFIG_TERM_RATIO_TO_PREV:
>>>
>>> I think these cases are all assigning a str so would using str rather
>>> than val be cleaner?
>>>
>>> The change looks good but it is a little inconsistent that the default
>>> copying is done for str values but not for u64. It would kind of be
>>> nice to remove the default copying so that if a new config term is
>>> added the switch will fail to compile due to a missing case statement.
>>> Then we can do the right copy for big endian. Given we've broken
>>> big-endian here we should probably add a comment.
>>>
>>> Thanks,
>>> Ian
>>
>> Yep I will send v2 later today and hopefully address your remarks 
>> completely.
>>
> 
> Oops sorry about the breakage. You could remove the val member entirely 
> now and set them all individually. I only added it to avoid a second 
> switch statement after creating the new entry. But if we have to add the 
> switch back in again and list out each item we might as well go back to 
> how it was before and assign each one individually.
> 
> Or a nuclear option could be to just have a single u64 numeric member 
> and a string one and not try to rename them and change the types so 
> much. Ironically half of the usages of the bools look like this:
> 
>   attr->aux_output = term->val.aux_output ? 1 : 0;
> 
> Almost makes all the shuffling around and renaming seem a bit pointless 
> in the end.
> 

To further this point: many different string term types share the same 
str member, but the numeric ones assign through different names even if 
the underlying type is the same. So it's not even that consistent.

> 
>>>
>>> I> +                       default:
>>>> +                               new_term->val.val = val;
>>>> +                               break;
>>>> +                       }
>>>>                  }
>>>>          }
>>>>          return 0;
>>>> -- 
>>>> 2.53.0
>>>>
>>
>> Thanks
>>
> 

