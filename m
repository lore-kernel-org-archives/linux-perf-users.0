Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E802F19B3D3
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Aug 2024 14:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723560971; cv=none; b=NERc0vzvwjprMEBKQABC62ecrgsl3ScIeBR/LGQS++Mkra2OGwD7V3QvfABPALV+3MbroCPbfkU2CqNOAhadk73AO2O3OT9adtcXbImYPDXKmu8WV2fldTSIXJpw2qysrQqP3/dDPVNdpt1IO2DyzyDa3J8YHeECqqW0LwEOj2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723560971; c=relaxed/simple;
	bh=YJVPtcP3xBblRvsGTOkCtQsiaJruhggxGSYEIjcAO7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IGNqbyFFtSaddoet2HuCDt8j277nQdLdDPaUo/RaNtzSS1P+nb0l9s6P15KUICH5RECUMZs0cMUOVo8foaF/DTnixBYiW1FDx7r1KF6UGWsXitgSJ6o4T1j6FGg5wyuh5vNZuS7rXC/TxYDSrA2oKvQT+sKvm6VbKm9ZI5Ya9qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lPCYD2Ex; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lPCYD2Ex"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3686b554cfcso2898484f8f.1
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Aug 2024 07:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723560968; x=1724165768; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O/d6A/qhlCYrDmQa5ZxJBHKaNKQHaV6za1HEEAuYgug=;
        b=lPCYD2ExpRO3I0spqLhqgv7rKmGfQq5qIZgY+FfHH1OOr1K4U9+FDsY37kYpg932EV
         4QrerDDwoEHggdNkcwzAlOfHY2i4DAbN4zBuOVGCjHX1p2pYVNNaLcL2EFr8RCfOuXGe
         GGNZYuTlHsgGoOLRLHOmZOkmctA/6beXppsoTm+x7uP0KeVcuG3MxVYSoNj72R6tC0Mn
         gPN2SwU3YLXrXlErw4SX4nnsUevmHHxkNyXN3sKRKQkrNXgXEfiljPLdDFAFTDXBa+u+
         NOYOVZh9KRfjoSYIGr3hx++Bp625b7DvycrGIKJRBTPuR2ahB0YRGPjQwdVgfaxkX35R
         GVjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723560968; x=1724165768;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O/d6A/qhlCYrDmQa5ZxJBHKaNKQHaV6za1HEEAuYgug=;
        b=vYTJveOwumaZBChM//Z0WrQid/AEdoX5sHaYjye9GKeDt1SUXvE1uCc7x2z36A+QCb
         p2TbWjAil7H8IIBFsh/BVI/jG7FDRNux6i5poNlwDQlhSAKHvHGJV3znRyBo2RuzlnbZ
         kNpFE7gSH7eODhhrwn0mb7pPgXjsMcT0ki1XgRJSV6Eb1AphUTzVuoEpcJQTGbTJFYTD
         s4R1NiWAOQgwUVEwOrx/kpHfBQyiw5+uBQitEld1KNcnPe0Cy7y+cSVGZ3YQ8aHW6kAf
         /5zGtOVPm/yQlk7lWU5pHFlk5kSUAUan68AwnCCcqIxCFN7jgb0Tf+GlJzulN1vR21n6
         0BOA==
X-Gm-Message-State: AOJu0YziHq1obNnwhiECIdbWxuPQvZNrfqMU6NKTovziom2tDoDA13ce
	9RX9KCTmcUWGNGeSYX/YK97ZWxcGAdcMfwgyMGAnLTCA5VbEYEW35I893TLRVio=
X-Google-Smtp-Source: AGHT+IH7RYPn9n3FNQLlyWO1pof58QJznrPiQ53W+LJb5iUy2dFNCJFeItywrmlmentV2tdDZTVzxQ==
X-Received: by 2002:adf:e04a:0:b0:367:998a:87b3 with SMTP id ffacd0b85a97d-3716ccfe7f7mr2817949f8f.28.1723560968081;
        Tue, 13 Aug 2024 07:56:08 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4c937b23sm10542160f8f.35.2024.08.13.07.56.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 07:56:07 -0700 (PDT)
Message-ID: <9c0ab8c6-fdb1-49b2-a030-b74e779b6e48@linaro.org>
Date: Tue, 13 Aug 2024 15:56:06 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] perf stat: Initialize instead of overwriting clock
 event
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>,
 Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Yang Jihong <yangjihong1@huawei.com>, Ze Gao <zegao2021@gmail.com>,
 Dominique Martinet <asmadeus@codewreck.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240813132323.98728-1-james.clark@linaro.org>
 <20240813132323.98728-2-james.clark@linaro.org>
 <CAP-5=fX-m3mhi0sGsGo9biWmFV_U=35Tp7h9X0reg3zHMEsy_Q@mail.gmail.com>
 <76ee9150-36fa-4dfc-ba9f-8a10df580c92@linaro.org>
 <CAP-5=fXYSLH9QcvdgV0D8Z-FoVxO25F_SN0BUdge4G_eCDDjZg@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fXYSLH9QcvdgV0D8Z-FoVxO25F_SN0BUdge4G_eCDDjZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 13/08/2024 3:43 pm, Ian Rogers wrote:
> On Tue, Aug 13, 2024 at 7:38 AM James Clark <james.clark@linaro.org> wrote:
>>
>>
>>
>> On 13/08/2024 3:28 pm, Ian Rogers wrote:
>>> On Tue, Aug 13, 2024 at 6:24 AM James Clark <james.clark@linaro.org> wrote:
>>>>
>>>> This overwrite relies on the clock event remaining at index 0 and is
>>>> quite a way down from where the array is initialized, making it easy to
>>>> miss. Just initialize it with the correct clock event to begin with.
>>>>
>>>> Signed-off-by: James Clark <james.clark@linaro.org>
>>>> ---
>>>>    tools/perf/builtin-stat.c | 7 +++----
>>>>    1 file changed, 3 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>>>> index 1f92445f7480..a65f58f8783f 100644
>>>> --- a/tools/perf/builtin-stat.c
>>>> +++ b/tools/perf/builtin-stat.c
>>>> @@ -1817,7 +1817,9 @@ static int add_default_attributes(void)
>>>>    {
>>>>           struct perf_event_attr default_attrs0[] = {
>>>>
>>>> -  { .type = PERF_TYPE_SOFTWARE, .config = PERF_COUNT_SW_TASK_CLOCK             },
>>>> +  { .type = PERF_TYPE_SOFTWARE, .config = target__has_cpu(&target) ?
>>>> +                                               PERF_COUNT_SW_CPU_CLOCK :
>>>> +                                               PERF_COUNT_SW_TASK_CLOCK        },
>>>
>>> Hand crafting perf_event_attr when we have an event name to
>>> perf_event_atttr parser doesn't make sense. Doing things this way
>>> means we need to duplicate logic between event parsing and these
>>> default configurations. The default configurations are also using
>>> legacy events which of course are broken on Apple ARM M? (albeit for
>>> hardware events, here it is software). Event and metric parsing has to
>>> worry about things like grouping topdown events. All-in-all let's have
>>> one way to do things, event parsing, otherwise this code is going to
>>> end up reinventing all the workarounds the event parsing has to have.
>>> Lots of struct perf_event_attr also contribute to binary size.
>>>
>>> If you are worried about a cycles event being opened on arm_dsu PMUs,
>>> there is this patch:
>>> https://lore.kernel.org/lkml/20240525152927.665498-1-irogers@google.com/
>>>
>>> Thanks,
>>> Ian
>>
>> Hi Ian,
>>
>> Is this comment related to this patch specifically or is it more of a
>> general comment?
>>
>> This patch doesn't really make any actual changes other than move one
>> line of code from one place to another.
> 
> James, this code is removed here:
> https://lore.kernel.org/lkml/20240510053705.2462258-4-irogers@google.com/
> 
> Thanks,
> Ian

Oh I see yeah. We can still work on that change, merging this one 
doesn't necessarily have to block that one, it just makes this one a bit 
redundant when the other one gets done.

If I remember correctly in one of the last related discussions we 
thought that opening the cycles event as a sampling event should be a 
softer warning?

Actually it seems like the DSU cycles event is a non-issue specifically 
for perf stat because it will open successfully anyway? It was just in 
perf record where it was the issue?


