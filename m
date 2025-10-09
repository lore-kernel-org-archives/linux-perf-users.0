Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695522EA48B
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Oct 2025 14:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760019467; cv=none; b=gmhxnJkREXPnP4Tu/kJZjcFbBby0EMlNaTMISqH1IbQMGpTB4/L4wXgh3LXdOZ9uE+5NwCE121T9xWi4f7vgtiH2lGkLEjwtj+y62BNlZ7j4CJqRKL3y9i+0ou/tZ0qNttEK0JzC9Lqe3wuoJAxJPDi7LtXwRmMpb5+122VG2AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760019467; c=relaxed/simple;
	bh=0V/KiaQqvKN5pUPPnK0xfQRKo1db3WQHdi+x8C6ja7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L9eRaYv/PSZ3td+rXHI7FxFJFgrOF0WWbT/7aBOWAOTJINc0D2eBfO/f21LKPNFU9h/d4tF1kbfbsw1Sers8KBE9jF4ybvj07CzDfWvLiW28EIFnHxCKekTSPlWqH0/E0/a5FkutJGyn+NVg9tdH2u0hv8kJzukMatprfCtU4t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KReNREs6; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KReNREs6"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso1161503f8f.1
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Oct 2025 07:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760019464; x=1760624264; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5l3qi2J/eOGmD22zeZuUwPLK/ndRwdJjA8IHaSGmN5M=;
        b=KReNREs6GukWNQVeXXgPCQi+f/biGbKZwvOT4i8LfFvJFqu8KgAH/4RGYz5WSvPCLl
         y+gVHIYlUSjWbrl78raWuNT1N+4+YJcXmntaoPan+a1ejhnBZD2ADA7bN4MTeK/Mvugq
         0uZOquQ+VscvqPvzcL9Mecj9fOa6ip/M0bUeef6Qv3kEJKooaKGAkBdcGc4E0735v1t+
         hKB9x1BQLFcieQ3lvl0GlzoXnUIs0WeaQ+Ri6oc/0hYicK+VE85LTtkbw08rymVGHY4G
         np/ayZq0nuTtr5yUo7FXOJ/98DRf3vQK4nNBEH2LJf3+aB/l/ZvesE6wsYEizkQizcrs
         YBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760019464; x=1760624264;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5l3qi2J/eOGmD22zeZuUwPLK/ndRwdJjA8IHaSGmN5M=;
        b=wUNBraRWv3W1sf7vJXSlFCxZuVYCeQ9sVxY9bxqs384fn3vTk+l+MY+pYLfQCs6Ara
         agbtnT4fqQUfJOJSRVUwcn939UJNuiS1HiVk0WFAMtVX9C1w8IQkd1jk1QXcTZcD1BIK
         LZT6tNLB5A88mxYDZnnNX4XWOqFF4qaEceP4oL74U9kayYNMBIQ6DjrtdmPcjIBJS0tl
         cClnB0NZaDguwAktArJrSDdwrRiv1+y2yjuy+Tl43yLy+2oInztQwUdvYQrEQUsSz90l
         nStensgAO3iDVfq9FJ5ERbeLDeWhUUth+N2JnZnI3cWWrpykfYjCx9TYZ7YU0PautPz0
         0lZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUavIrhpA+JAngh3m7hywLvKb/h+B8Z5oR6ML/zkSWNfh77la/ZO2889gIbzmbVQCG2/gwov37ch0hzSRfSk53t@vger.kernel.org
X-Gm-Message-State: AOJu0YwaIJ4c7U2d3Lw/3kTickvcdrC2OCCYLjCUd5xudo44fXTqhg7K
	IwtTD6frLUm490QOvswEEsnhv0CarHJ0CCBRSUhKGt6hDfQwocZLweF37JMsmDmi0/k=
X-Gm-Gg: ASbGnctKMGrv+D3BjDxBglrgohybdT4seu3idhSKXo0TudtkZI0dXIxUyVcB4QGPt+C
	4hlfkmwZDlilGtJOI/zMhZayo3CkfeVJ4O/4Ys8IhCI7UNf0EYLGpv0mbSsfStAD8WSLL2szODr
	KVWemW0BfZQWElqyY9Tek2wZA62Y+vN0ayU+vfZb8o9fFosl1luY4/ik89RxWs0ZEeFzsqN01St
	R97raib1ipc/FNGUBrh8nO6mVwh/9XfYKr5cHRAtuWULyc+cuubTCD20N7dyeTIYwbg/hWGnqjR
	rpb1UW5Y0jt9lGsSByiB1uwAK9rzi2UjPpjkUOGp7D6Hp3TFjMiMf2Ur/p7O0XwYyf9pn7vz2vB
	5taeYQa6ym3pnzOvDHQFjrC76sOE7x3V6CRRxQDaF6qOd1EtvKxi+M91hgwYVtKegHYk=
X-Google-Smtp-Source: AGHT+IFnK76TJTo6RM38j58lfpOJgceq2qYXJbGaEksQqe0mpFJzTZ3frcZi8l7foGiOEXkM+AGi9g==
X-Received: by 2002:a5d:5f96:0:b0:3ec:42f9:952b with SMTP id ffacd0b85a97d-42666a9e191mr5595769f8f.4.1760019463528;
        Thu, 09 Oct 2025 07:17:43 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e97fbsm34746850f8f.34.2025.10.09.07.17.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 07:17:43 -0700 (PDT)
Message-ID: <f4eba834-e45c-4eba-9650-5b6720fcd30f@linaro.org>
Date: Thu, 9 Oct 2025 15:17:42 +0100
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
 <CA+G8DhKDvkojDnwxXKe1iiLWwJ0uwD62-qc4_sJgBDdS+qLu-g@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CA+G8DhKDvkojDnwxXKe1iiLWwJ0uwD62-qc4_sJgBDdS+qLu-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 09/10/2025 2:55 pm, Anubhav Shelat wrote:
> I tested on a new arm machine and I'm getting a similar issue as
> Thomas, but the test fails every 20 or so runs and I'm not getting the
> issue that I previously mentioned.
> 
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
> Initially I thought it was the throttling issue mentioned in the
> comment in test_leadership_sampling, but there's another thread says
> that it's fixed:
> https://lore.kernel.org/lkml/20250520181644.2673067-2-kan.liang@linux.intel.com/
> 
> 

After reading that patch it seems like we should actually be removing 
the 80% tolerance from the leader sampling test. Both instances of the 
cycles counts should be the same now.

(Excluding s390) I'm starting to think you were hitting this bug on an 
older kernel? Or something else is going wrong that we should  get to 
the bottom of. The test could have found something and we shouldn't 
ignore it yet.

> On Thu, Oct 9, 2025 at 2:43 PM Anubhav Shelat <ashelat@redhat.com> wrote:
>>
>> I tested on a new arm machine and I'm getting a similar issue as Thomas, but the test fails every 20 or so runs and I'm not getting the issue that I previously mentioned.
>>
>> Running test #15
>>   10bc60-10bcc4 g test_loop
>> perf does have symbol 'test_loop'
>>   10c354-10c418 l brstack
>> perf does have symbol 'brstack'
>> Basic leader sampling test
>> Basic leader sampling test [Success]
>> Invalid Counts: 1
>> Valid Counts: 27
>> Running test #16
>>   10bc60-10bcc4 g test_loop
>> perf does have symbol 'test_loop'
>>   10c354-10c418 l brstack
>> perf does have symbol 'brstack'
>> Basic leader sampling test
>> Basic leader sampling test [Success]
>> Invalid Counts: 1
>> Valid Counts: 27
>> Running test #17
>>   10bc60-10bcc4 g test_loop
>> perf does have symbol 'test_loop'
>>   10c354-10c418 l brstack
>> perf does have symbol 'brstack'
>> Basic leader sampling test
>> Leader sampling [Failed inconsistent cycles count]
>> Invalid Counts: 8
>> Valid Counts: 28
>>
>> Initially I thought it was the throttling issue mentioned in the comment in test_leadership_sampling, but there's another thread says that it's fixed:
>> https://lore.kernel.org/lkml/20250520181644.2673067-2-kan.liang@linux.intel.com/
>>
>>
>> On Wed, Oct 8, 2025 at 12:24 PM James Clark <james.clark@linaro.org> wrote:
>>>
>>>
>>>
>>> On 08/10/2025 11:48 am, Thomas Richter wrote:
>>>> On 10/7/25 14:34, James Clark wrote:
>>>>>
>>>>>
>>>>> On 07/10/2025 6:47 am, Thomas Richter wrote:
>>>>>> On 10/2/25 15:39, Anubhav Shelat wrote:
>>>>>>> On Oct 1, 2025 at 9:44 PM, Ian Rogers wrote:
>>>>>>>> If cycles is 0 then this will always pass, should this be checking a
>>>>>>> range?
>>>>>>>
>>>>>>> Yes you're right this will be better.
>>>>>>>
>>>>>>> On Oct 2, 2025 at 7:56 AM, Thomas Richter wrote:
>>>>>>>> Can we use a larger range to allow the test to pass?
>>>>>>>
>>>>>>> What range do you get on s390? When I do group measurements using "perf
>>>>>>> record -e "{cycles,cycles}:Su" perf test -w brstack" like in the test I
>>>>>>> always get somewhere between 20 and 50 cycles difference. I haven't tested
>>>>>>> on s390x, but I see no cycle count difference when testing the same command
>>>>>>> on x86. I have observed much larger, more varied differences when using
>>>>>>> software events.
>>>>>>>
>>>>>>> Anubhav
>>>>>>>
>>>>>>
>>>>>> Here is the output of the
>>>>>>
>>>>>>     # perf record  -e "{cycles,cycles}:Su" -- ./perf test -w brstack
>>>>>>     # perf script | grep brstack
>>>>>>
>>>>>> commands:
>>>>>>
>>>>>> perf 1110782 426394.696874:    6885000 cycles:           116fc9e brstack_bench+0xae (/r>
>>>>>> perf 1110782 426394.696875:    1377000 cycles:           116fb98 brstack_foo+0x0 (/root>
>>>>>> perf 1110782 426394.696877:    1377000 cycles:           116fb48 brstack_bar+0x0 (/root>
>>>>>> perf 1110782 426394.696878:    1377000 cycles:           116fc94 brstack_bench+0xa4 (/r>
>>>>>> perf 1110782 426394.696880:    1377000 cycles:           116fc84 brstack_bench+0x94 (/r>
>>>>>> perf 1110782 426394.696881:    1377000 cycles:           116fb7c brstack_bar+0x34 (/roo>
>>>>>> perf 1110782 426394.696883:    1377000 cycles:           116fb7c brstack_bar+0x34 (/roo>
>>>>>> perf 1110782 426394.696884:    1377000 cycles:           116fb7c brstack_bar+0x34 (/roo>
>>>>>> perf 1110782 426394.696885:    1377000 cycles:           116fb7c brstack_bar+0x34 (/roo>
>>>>>> perf 1110782 426394.696887:    1377000 cycles:           116fb7c brstack_bar+0x34 (/roo>
>>>>>> perf 1110782 426394.696888:    1377000 cycles:           116fc98 brstack_bench+0xa8 (/r>
>>>>>> perf 1110782 426394.696890:    1377000 cycles:           116fb7c brstack_bar+0x34 (/roo>
>>>>>> perf 1110782 426394.696891:    1377000 cycles:           116fc9e brstack_bench+0xae (/r>
>>>>>> perf 1110782 426394.703542:    1377000 cycles:           116fb7c brstack_bar+0x34 (/roo>
>>>>>> perf 1110782 426394.703542:   30971975 cycles:           116fb7c brstack_bar+0x34 (/roo>
>>>>>> perf 1110782 426394.703543:    1377000 cycles:           116fc76 brstack_bench+0x86 (/r>
>>>>>> perf 1110782 426394.703545:    1377000 cycles:           116fc06 brstack_bench+0x16 (/r>
>>>>>> perf 1110782 426394.703546:    1377000 cycles:           116fc9e brstack_bench+0xae (/r>
>>>>>> perf 1110782 426394.703547:    1377000 cycles:           116fc20 brstack_bench+0x30 (/r>
>>>>>> perf 1110782 426394.703549:    1377000 cycles:           116fc9e brstack_bench+0xae (/r>
>>>>>> perf 1110782 426394.703550:    1377000 cycles:           116fcbc brstack_bench+0xcc
>>>>>>
>>>>>> They are usual identical values beside one or two which are way off. Ignoring those would
>>>>>> be good.
>>>>>>
>>>>>
>>>>> FWIW I ran 100+ iterations my Arm Juno and N1SDP boards and the test passed every time.
>>>>>
>>>>> Are we sure there isn't some kind of race condition or bug that the test has found? Rather than a bug in the test?
>>>> There is always a possibility of a bug, that can not be ruled out for certain.
>>>> However as LPARs on s390 run on top of a hypervisor, there is a chance for the
>>>> linux guest being stopped while hardware keeps running.
>>>>
>>>
>>> I have no idea what's going on or how that works, so maybe this question
>>> is useless, but doesn't that mean that guests can determine/guess the
>>> counter values from other guests? If the hardware keeps the counter
>>> running when the guest isn't, that sounds like something is leaking from
>>> one guest to another? Should the hypervisor not be saving and restoring
>>> context?
>>>
>>>> I see these runoff values time and again, roughly every second run fails with
>>>> one runoff value
>>>>
>>>> Hope this helps
>>>>
>>>
>>> That may explain the issue for s390 then, but I'm assuming it doesn't
>>> explain the issues on Arm if the failures there aren't in a VM. But even
>>> if they were in a VM, the PMU is fully virtualised and the events would
>>> be stopped and resumed when the guest is switched out.
>>>
>>> James
>>>
> 

