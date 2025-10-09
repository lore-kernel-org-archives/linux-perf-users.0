Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC162EA157
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Oct 2025 14:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760018894; cv=none; b=SGsEqd56UGnqZ+hbaLy94Os9/OY5V1kY0KQ0k6fmikLGXTO62nFVjSKX2HDowlDZ+lzk2mZHQJQSCSpEgFjJYKqjw8ly4bhXvQHsYKTAQtX6LNgyVDY9uplqiiGBAITuGr5NUslFWqs4gPZSaGGy8b8hHRsF7iYhkPzY89ChRL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760018894; c=relaxed/simple;
	bh=cnWqYJDBTt7GfKdiq8zoMxH7sfl38LRG68jp/X3oLHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LhaAcCuRRiYdtycrUSVtLhxDBHVZkQXh9WH67lED/nhxI8MJNStpviefQzcyhoQDtULfiewf6UzGJisll1gW17TDt/rzgXBGfE/T0JU8oNBMHq6NTGYtDaJI6b4aye97Fduh8/AuAjPHBAr47Pn3y6ycSZzAvmRLyOxDBT5aWeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OW3D0W4O; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OW3D0W4O"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e34bd8eb2so9912865e9.3
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Oct 2025 07:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760018891; x=1760623691; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MXaj+WtK2qtoaQvWIEYfrgqNLRFpGshLSB4/1VKi+hU=;
        b=OW3D0W4OGeCqyyT61aNsOrKRWb+MXs9j/EzXGJGl32jBUiHbiarm8yKuAEED0/rn0g
         eKDCdd12200rpQiB4LkVplJzchRb6GlzTe6BdMH9m/4ey0kHN33CP+aKMCtjIWEKqNp3
         iQo0Bu7qxf2lP7+qxsLMDUiXBQa1t30h79aiVESkh9cCJsSP1nbbRjX62shsDIBEWjom
         LIRkqC84+XH7gor+hYJD4LxP8UftWJk/u3OEuNtBy9OecRi/J/oiREoIN1BpBVP/pim7
         wAtRQ9D70v+GJkKJh9lQgeVQTj3+HkzaLKHORGcS94HwLSJtBad6ln5IILWrGClr2lbZ
         geIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760018891; x=1760623691;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MXaj+WtK2qtoaQvWIEYfrgqNLRFpGshLSB4/1VKi+hU=;
        b=DPywCgbOhW61ZKQQAwn/dsIelN+8hEBf1XhO/phWEYmLd0MdmMOJVUZv1Zs3o6imr6
         KWz5auENI4Kgt95mhZ+2Bll/ljOR86XcXFUX2I0JlmAbvQ2/Ua/+T8AofHA5tlM4Q8vZ
         p7ThatjWAReHYKkji5JR2A0K5OYeQ6GSYxIzt3BVLlUtdcOvMiLQ5QgpRJRFYRpc5zOI
         74s48m4QwqvAVy5NX6Mu0r38aQWvf1ODQG461GYdv7zgSYiu8lwlX9Q3azysu4G3t+62
         kfcCte1jjrdecNS6y8puok9D71HQj354SvS8auQ3/sv0lK2bcONcQ0CCajJb92Y/CRXR
         Bc4g==
X-Forwarded-Encrypted: i=1; AJvYcCWX50vgx0kWmaSB+RHUx/9sm49/T2PULvLHDP+A7JQXOIAAMoDrXJXI1/2zqc4mwuwLPsfJOpwkarwFTSyCtRMy@vger.kernel.org
X-Gm-Message-State: AOJu0YyEGF28amlBKtlPgvu1f50jFcD1ywkrnd7VDsmC4hAlo/OmA1ii
	MuGHYhH2p1aQwg435TaT1FSlsQukjHW/hiwmzXAil3nvv23+m/tylVzLgsukfNTe0E8=
X-Gm-Gg: ASbGncunYGnGRJUyUMToV6ss//jWKkqGcyQp6Lep1trcEGJJ+cmP2GUXTt6wF2r0gfW
	MiyiDZP1y1gLvpaulbmYZGSMohNFP0H2FwIBjg9z8VpGhVG8GjuFLtlOwqtbuuz92YELh2SEYNL
	OlA0YbvkNQve/TXBPcW9RbkimeVKmVSGd2vTXB5j7zp5QAOp54xKl9CIE8/UvAC0iWfm+kQLw4v
	vN8MmnrJPeu9yYvnt03OPsHirjaLV5GroOBkCaId6dcLmn4iYr+yE+C7cHVfpSY4J5WfX2ggyzf
	DB84g8T9B7zKHl0pHKNxGHJAVboZm2slbvPcfTsS63gmL38Bf71/oDvW0VbPKFbm9DvokZPSWZV
	nCn5yUk5NyDrx51gKxjSonlzAa1ou3nWTGmUv51ZraVJtbwaVbN7MTvlE
X-Google-Smtp-Source: AGHT+IHR/x78i7O9rRO/FKdvovpnCsSwcVf6KdMlOiMooBPsYvgB9QlA/4bk1Vsza74g9+/+rgcHcg==
X-Received: by 2002:a05:600c:4586:b0:46e:1abc:1811 with SMTP id 5b1f17b1804b1-46fa9b08ae5mr54947335e9.27.1760018890704;
        Thu, 09 Oct 2025 07:08:10 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f4bdcsm34986879f8f.54.2025.10.09.07.08.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 07:08:09 -0700 (PDT)
Message-ID: <bda238f1-fd21-4411-8611-1bc246ec254c@linaro.org>
Date: Thu, 9 Oct 2025 15:08:08 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf tests record: allow for some difference in cycle
 count in leader sampling test on aarch64
To: Anubhav Shelat <ashelat@redhat.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>, Namhyung Kim
 <namhyung@kernel.org>, mpetlan@redhat.com, acme@kernel.org,
 irogers@google.com, linux-perf-users@vger.kernel.org, peterz@infradead.org,
 mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
 jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 dapeng1.mi@linux.intel.com
References: <20251001195047.541745-2-ashelat@redhat.com>
 <906a9e47-ec19-4897-bbc0-06101d7afd24@linux.ibm.com>
 <CA+G8DhL49FWD47bkbcXYeb9T=AbxNhC-ypqjkNxRnW0JqmYnPw@mail.gmail.com>
 <901d2d1d-647a-4a76-a0ee-d8a687ed3f85@linux.ibm.com>
 <ff157071-e241-4b81-8241-cfd15e5705ef@linaro.org>
 <7a03fb30-87f9-4737-b59a-9f977acc7549@linux.ibm.com>
 <296700d2-878b-4eeb-b8cd-0252b2f92479@linaro.org>
 <CA+G8Dh+Odf40jdY4h1knjU+3sSjZokMx6OdzRT3o9v1=ndKORQ@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CA+G8Dh+Odf40jdY4h1knjU+3sSjZokMx6OdzRT3o9v1=ndKORQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 09/10/2025 2:43 pm, Anubhav Shelat wrote:
> I tested on a new arm machine and I'm getting a similar issue as Thomas,

Which are your new and old Arm machines exactly? And which kernel 
versions did you run the test on?

> but the test fails every 20 or so runs and I'm not getting the issue that I
> previously mentioned.
> 

What do you mean here? Below I see the leader sampling test failure, 
which I thought was the same issue that was previously mentioned?

> Running test #15
>   10bc60-10bcc4 g test_loop
> perf does have symbol 'test_loop'
>   10c354-10c418 l brstack
> perf does have symbol 'brstack'
> Basic leader sampling test
> Basic leader sampling test [Success]
> Invalid Counts: 1
> Valid Counts: 27
> Running test #16
>   10bc60-10bcc4 g test_loop
> perf does have symbol 'test_loop'
>   10c354-10c418 l brstack
> perf does have symbol 'brstack'
> Basic leader sampling test
> Basic leader sampling test [Success]
> Invalid Counts: 1
> Valid Counts: 27
> Running test #17
>   10bc60-10bcc4 g test_loop
> perf does have symbol 'test_loop'
>   10c354-10c418 l brstack
> perf does have symbol 'brstack'
> Basic leader sampling test
> Leader sampling [Failed inconsistent cycles count]
> Invalid Counts: 8
> Valid Counts: 28
> 
> Initially I thought it was the throttling issue mentioned in the comment in
> test_leadership_sampling, but there's another thread says that it's fixed:
> https://lore.kernel.org/lkml/20250520181644.2673067-2-kan.liang@linux.intel.com/
> 
> 
> 
> On Wed, Oct 8, 2025 at 12:24 PM James Clark <james.clark@linaro.org> wrote:
> 
>>
>>
>> On 08/10/2025 11:48 am, Thomas Richter wrote:
>>> On 10/7/25 14:34, James Clark wrote:
>>>>
>>>>
>>>> On 07/10/2025 6:47 am, Thomas Richter wrote:
>>>>> On 10/2/25 15:39, Anubhav Shelat wrote:
>>>>>> On Oct 1, 2025 at 9:44 PM, Ian Rogers wrote:
>>>>>>> If cycles is 0 then this will always pass, should this be checking a
>>>>>> range?
>>>>>>
>>>>>> Yes you're right this will be better.
>>>>>>
>>>>>> On Oct 2, 2025 at 7:56 AM, Thomas Richter wrote:
>>>>>>> Can we use a larger range to allow the test to pass?
>>>>>>
>>>>>> What range do you get on s390? When I do group measurements using
>> "perf
>>>>>> record -e "{cycles,cycles}:Su" perf test -w brstack" like in the test
>> I
>>>>>> always get somewhere between 20 and 50 cycles difference. I haven't
>> tested
>>>>>> on s390x, but I see no cycle count difference when testing the same
>> command
>>>>>> on x86. I have observed much larger, more varied differences when
>> using
>>>>>> software events.
>>>>>>
>>>>>> Anubhav
>>>>>>
>>>>>
>>>>> Here is the output of the
>>>>>
>>>>>     # perf record  -e "{cycles,cycles}:Su" -- ./perf test -w brstack
>>>>>     # perf script | grep brstack
>>>>>
>>>>> commands:
>>>>>
>>>>> perf 1110782 426394.696874:    6885000 cycles:           116fc9e
>> brstack_bench+0xae (/r>
>>>>> perf 1110782 426394.696875:    1377000 cycles:           116fb98
>> brstack_foo+0x0 (/root>
>>>>> perf 1110782 426394.696877:    1377000 cycles:           116fb48
>> brstack_bar+0x0 (/root>
>>>>> perf 1110782 426394.696878:    1377000 cycles:           116fc94
>> brstack_bench+0xa4 (/r>
>>>>> perf 1110782 426394.696880:    1377000 cycles:           116fc84
>> brstack_bench+0x94 (/r>
>>>>> perf 1110782 426394.696881:    1377000 cycles:           116fb7c
>> brstack_bar+0x34 (/roo>
>>>>> perf 1110782 426394.696883:    1377000 cycles:           116fb7c
>> brstack_bar+0x34 (/roo>
>>>>> perf 1110782 426394.696884:    1377000 cycles:           116fb7c
>> brstack_bar+0x34 (/roo>
>>>>> perf 1110782 426394.696885:    1377000 cycles:           116fb7c
>> brstack_bar+0x34 (/roo>
>>>>> perf 1110782 426394.696887:    1377000 cycles:           116fb7c
>> brstack_bar+0x34 (/roo>
>>>>> perf 1110782 426394.696888:    1377000 cycles:           116fc98
>> brstack_bench+0xa8 (/r>
>>>>> perf 1110782 426394.696890:    1377000 cycles:           116fb7c
>> brstack_bar+0x34 (/roo>
>>>>> perf 1110782 426394.696891:    1377000 cycles:           116fc9e
>> brstack_bench+0xae (/r>
>>>>> perf 1110782 426394.703542:    1377000 cycles:           116fb7c
>> brstack_bar+0x34 (/roo>
>>>>> perf 1110782 426394.703542:   30971975 cycles:           116fb7c
>> brstack_bar+0x34 (/roo>
>>>>> perf 1110782 426394.703543:    1377000 cycles:           116fc76
>> brstack_bench+0x86 (/r>
>>>>> perf 1110782 426394.703545:    1377000 cycles:           116fc06
>> brstack_bench+0x16 (/r>
>>>>> perf 1110782 426394.703546:    1377000 cycles:           116fc9e
>> brstack_bench+0xae (/r>
>>>>> perf 1110782 426394.703547:    1377000 cycles:           116fc20
>> brstack_bench+0x30 (/r>
>>>>> perf 1110782 426394.703549:    1377000 cycles:           116fc9e
>> brstack_bench+0xae (/r>
>>>>> perf 1110782 426394.703550:    1377000 cycles:           116fcbc
>> brstack_bench+0xcc
>>>>>
>>>>> They are usual identical values beside one or two which are way off.
>> Ignoring those would
>>>>> be good.
>>>>>
>>>>
>>>> FWIW I ran 100+ iterations my Arm Juno and N1SDP boards and the test
>> passed every time.
>>>>
>>>> Are we sure there isn't some kind of race condition or bug that the
>> test has found? Rather than a bug in the test?
>>> There is always a possibility of a bug, that can not be ruled out for
>> certain.
>>> However as LPARs on s390 run on top of a hypervisor, there is a chance
>> for the
>>> linux guest being stopped while hardware keeps running.
>>>
>>
>> I have no idea what's going on or how that works, so maybe this question
>> is useless, but doesn't that mean that guests can determine/guess the
>> counter values from other guests? If the hardware keeps the counter
>> running when the guest isn't, that sounds like something is leaking from
>> one guest to another? Should the hypervisor not be saving and restoring
>> context?
>>
>>> I see these runoff values time and again, roughly every second run fails
>> with
>>> one runoff value
>>>
>>> Hope this helps
>>>
>>
>> That may explain the issue for s390 then, but I'm assuming it doesn't
>> explain the issues on Arm if the failures there aren't in a VM. But even
>> if they were in a VM, the PMU is fully virtualised and the events would
>> be stopped and resumed when the guest is switched out.
>>
>> James
>>
>>
> 

