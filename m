Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF2D33D6F9
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 11:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763035096; cv=none; b=ussKlzbQl802l6ZRl+BITbEX8X5Rk1xtoqO70rKJsHkCn2TU5gIfTfkHxDlwQ8yfOXtDvr2XeqjoJ0OMF3Zr+wd4dD938dXQXwXbw5gR9xw6XKtKL5oOWF7Pxgh4pE90yq81eAZMYOLiQoBZQLdN5mt9Sqc/OyNc+v4rfpSFR4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763035096; c=relaxed/simple;
	bh=58nY4Xfwx3Izuzg4WgX3TEVstjvYerd3vKHr+lfDEpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B700cSWRhXU8VTm4SzhwwG+jCdPFpuUZkZPmQAPo/ulM9GhqJLFvnZ1FK8pFeJDtg7ns2X5shiJPodxTcdEm4SEQV9QtsacyqsqV/sQEBuFDPkXEhFc3E0tuHEef7veT+us+YzMq4KNvQM3jzY96bdRfoLFjSB5WU3RGTobfjqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x0ZQG5Mu; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x0ZQG5Mu"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477563e28a3so4878775e9.1
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 03:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763035092; x=1763639892; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MkIow71CZ0eQgckV1Nq9dOj+5LTtuc3iS6zVp3nyiRw=;
        b=x0ZQG5MumQn1kcp71ogW7yC8lyMT0iBLH54irVlIoTcvBK39/hglpCfvmEzYI7JePu
         TsLG0PoJINYrbGRiP2XcrfzfzIDGJsl+t6Nujem1PRgv4Df91jDT24xcCEHmb13eQNQZ
         p/8REt9Dz+Gr5Tw7uL9YGyEthsV7upT5wNH3XoUU3DXBIl1Vqat3lZlevcAfY6BUHBOu
         TUHdXXIJ/D7oVyANPmLp3BeUMV2u1r95n72tSnei+HcE+g3pmdh1JfIxdmakO0y2A/Ja
         TfrNvvQL45s6LmyOae3yJDclYn4CLX2D35MQfcF69RIjp4Sjxety2r1UmrhHZbVatQrJ
         Sc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763035092; x=1763639892;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MkIow71CZ0eQgckV1Nq9dOj+5LTtuc3iS6zVp3nyiRw=;
        b=VHRyLa9NVPd4dl21dA2BOTXFxmycxSgtUqU3iRxet6lyPuCS+Dfs+rwlcQFPgRUZKH
         G36XGu/o4o//MSRgGiSZIOLQ6550hiI3gCOCxVI4YC+N6j4jEdMvRf9gSAjpPj/HWCY7
         y5vF0NVmlhknQ99aypXRO5bIRZ9fK9VtlqtSZCB2LpenFtKQOjwTz7V+mYPpHfB25Kng
         sS7jU2xgiZzb2GZMD8HJZecrAhuBqTDk6lj8Kw8oSajk/DmBd+DXTUDVwFwUjgvH9wUG
         FRnmdRsiPjha0Md8MPGEtFYSO6zXSYavWSnFRMVHgBhER/GdqvCpZ46e4e7GN5rJxmQq
         wPww==
X-Forwarded-Encrypted: i=1; AJvYcCXvwgf6wQc0gbwAujMKCYoBkZzwqRde141XkkMVgilz3A2J3Hp7P58KJ9s14rBf78jGaxMoG6HOr9eEjBV4mMdh@vger.kernel.org
X-Gm-Message-State: AOJu0YwRwJB3GigRAK8GPvkpnxmXY2SXw+yOgxx1J6KhuVgso2dBFXCa
	zC1akza6iSwm7akYHp3RnIKPrckWuRSwLuqduCBLVjsrxTeQYOPNZXzpNMMJwsCGS1A=
X-Gm-Gg: ASbGncs83TvKKLCSdnHM9S91nHEBWf7gswLWQcHm4OwjCoElNhXtC9ol2rvTjsQR+Tv
	DAkUZYKHx8NsV5rGC1bCeo2dEdlgUTQ1ibE3HuwP5cNYDq54f04iMynwCG44Z50HgOhBF8yMF8R
	ejSxBrgFL1wElXJWjjLooNFUoYQ2hl3/v+hdeAuq0zvj+6ofToUtPmR+aesG7AYB2LzdlFpEvyP
	RkFna/QPo3EruMqxWmZII1CQcshPvxKmFX9JH6elLOTWuZAj5TmAM+OO4/RXAPZMUV/CTpli62A
	eYPNt9mqCL7YGScQiY/Vrd69h2VNRT77J7ykkGrrgvgB1fbHVDonvN2OAoHDgzp1lAZSeiG3d3O
	DPqMMejTfyO6oLauHLQBdXqHYVmkxAZG1LJjdMHFf8wU3wmI+PrB5Ahe0GONpUL0bGJAB+GYE5q
	m6nCE+ww==
X-Google-Smtp-Source: AGHT+IEAurIsmS/1mZnVXxdgIRE6IB080lHcqEp12KpWx+oh0MQgIEVViE4NAtxyCUqKHf7RV0NRtQ==
X-Received: by 2002:a05:600c:b96:b0:46f:b42e:e38f with SMTP id 5b1f17b1804b1-4778bd7d77fmr29204975e9.19.1763035091980;
        Thu, 13 Nov 2025 03:58:11 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787daab3fsm101346955e9.0.2025.11.13.03.58.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 03:58:11 -0800 (PST)
Message-ID: <404abeb1-35cf-4126-b215-fa76c129d28b@linaro.org>
Date: Thu, 13 Nov 2025 11:58:10 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "perf test: Allow tolerance for leader sampling
 test"
To: Thomas Richter <tmricht@linux.ibm.com>,
 Anubhav Shelat <ashelat@redhat.com>
Cc: mpetlan@redhat.com, acme@kernel.org, namhyung@kernel.org,
 irogers@google.com, linux-perf-users@vger.kernel.org, peterz@infradead.org,
 mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
 jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 dapeng1.mi@linux.intel.com
References: <20251023132406.78359-2-ashelat@redhat.com>
 <5b02372a-f0be-4d3a-a875-c5ea65f2bafe@linux.ibm.com>
 <CA+G8Dh+DaVp1XVHm=Hh1aLP=5YOmChTRu4=nSUAwTKJO-a4LDw@mail.gmail.com>
 <f674d1eb-c492-4dec-a49c-8b40833741a4@linaro.org>
 <2e756e75-7dc9-4838-8651-ca1a0f056966@linux.ibm.com>
 <be8f4890-1c45-4116-9c9f-1e40e908747b@linaro.org>
 <a6218625-a08e-4466-837d-7bdd0c8631a5@linux.ibm.com>
 <1826ae90-b36b-4cde-b895-623cab4e1b08@linaro.org>
 <38c9bd83-d823-4b84-9f1d-ad0b58f20a4c@linux.ibm.com>
 <42a066c9-8be3-432c-8cd2-5311c26e7b36@linaro.org>
 <0862c069-8c12-42f0-9a9b-2580daad56d1@linux.ibm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <0862c069-8c12-42f0-9a9b-2580daad56d1@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/11/2025 10:47 am, Thomas Richter wrote:
> On 11/11/25 15:03, James Clark wrote:
> 
> .....
> 
>>>
>>> James,
>>> the counter above being always 0 come from the fact that the group uses modifier :u
>>> for user space, the cycles event are invoked without :u modifier.
>>> On s390 you need to use -e "{cycles,cycles}:S"
>>
>> I'm not following why :u should make a difference. I see from your explanation below that you have two different types of counter and the first event runs on the buffered one and the other on a simple PMU counter, but how does that translate to userspace filtering making a difference?
>>
> 
> Well, s390 counters are
>   # ls -l /sys/devices/cpum_cf/events/*CPU_CYCLES
> -r--r--r-- 1 root root 4096 Nov 12 11:10 /sys/devices/cpum_cf/events/CPU_CYCLES
> -r--r--r-- 1 root root 4096 Nov 12 11:10 /sys/devices/cpum_cf/events/PROBLEM_STATE_CPU_CYCLES
>   # cat /sys/devices/cpum_cf/events/*CPU_CYCLES
>   event=0x0000
>   event=0x0020
>   #
> 
> The generic event cycles is translated to CPU_CYCLES and user space cycles are counted with
> a different counter named PROBLEM_STATE_CPU_CYCLES
> 
> So 2 different counters, in 2 different counter sets, one started one not started.
> 

But why can't the second counter be started at the same time as the 
first one?

>>> I disagree with your assessment completely. I have spent quite some time
>>> debugging this and come to a different finding. I executed this command
>>> on the latest kernel:
>>>
>>>    # uname -a
>>>    Linux b83lp65.lnxne.boe 6.18.0-rc4d-perf+ #84 SMP Fri Nov  7 09:24:44 CET 2025 s390x GNU/Linux
>>>    # /root/linux/tools/perf/perf record -e "{cycles,cycles}:S" \
>>>           -- taskset -c 0 /root/linux/tools/perf/perf test -w brstack 5000000 2>/dev/null
>>>
>>> I also had your suggestion patched into the perf script code:
>>>    # git diff
>>>    diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
>>> index 09af486c83e4..212bca671a49 100644
>>> --- a/tools/perf/util/session.c
>>> +++ b/tools/perf/util/session.c
>>> @@ -1212,9 +1212,9 @@ static int deliver_sample_value(struct evlist *evlist,
>>>           /*
>>>            * There's no reason to deliver sample
>>>            * for zero period, bail out.
>>> -        */
>>>           if (!sample->period)
>>>                   return 0;
>>> +        */
>>>
>>>           evsel = container_of(sid->evsel, struct evsel, core);
>>>           return tool->sample(tool, event, sample, evsel, machine);
>>>    #
>>>
>>> The output of perf script is now (always in pairs of 2 lines):
>>>> taskset    7005   332.357459:    1377000 cycles:       3ff9db4611a find_module_idx+0x8a (/usr/lib64/libc.so.6)
>>> taskset    7005   332.357459:    1948445 cycles:       3ff9db4611a find_module_idx+0x8a (/usr/lib64/libc.so.6)
>>>      perf    7005   332.368619:    1377000 cycles:       3ffe03a4fa6 xas_reload+0x36 ([kernel.kallsyms])
>>>      perf    7005   332.368619:   61344023 cycles:       3ffe03a4fa6 xas_reload+0x36 ([kernel.kallsyms])
>>>      perf    7005   332.368624:    1377000 cycles:       3ffe0b53624 mas_empty_area_rev+0x3c4 ([kernel.kallsyms])
>>>      perf    7005   332.368624:      25448 cycles:       3ffe0b53624 mas_empty_area_rev+0x3c4 ([kernel.kallsyms])
>>>      perf    7005   332.368626:    1377000 cycles:       3ffadf81606 _dl_catch_exception+0xb6 (/usr/lib/ld64.so.1)
>>>      perf    7005   332.368626:      12182 cycles:       3ffadf81606 _dl_catch_exception+0xb6 (/usr/lib/ld64.so.1)
>>>      perf    7005   332.368628:    1377000 cycles:       3ffadf8c9b2 _dl_add_to_namespace_list+0x42 (/usr/lib/ld64.so.1)
>>>      perf    7005   332.368628:      11392 cycles:       3ffadf8c9b2 _dl_add_to_namespace_list+0x42 (/usr/lib/ld64.so.1)
>>>      perf    7005   332.368630:    1377000 cycles:       3ffe0b4f800 mas_prev+0x0 ([kernel.kallsyms])
>>>      perf    7005   332.368630:      11476 cycles:       3ffe0b4f800 mas_prev+0x0 ([kernel.kallsyms])
>>>
>>
>> The above patch won't make a difference to this output because none of them are 0. You get exactly the same output with or without the patch.
>>
>> I only showed that this part of the code was hiding the original issue where most of the second counter values were 0. That seems to not be the case if you remove :u as you found, but isn't related to this part.
>>
> 
> Agreed
> 
>> I kind of see why :u results in 0 counts, because you're only counting the time between when the buffered counter fills up and interrupted and when you generated the other samples. But I don't get why that has to be the case. Couldn't you leave the other counters running and then they would count everything between samples?
>>
>>>
>>> Now to the debugging and investigation:
>>> 1. With command
>>>          perf record -e '{cycles,cycles}:S' -- ....
>>>      the first cycles event start sampling.
>>>      On s390 this sets up sampling with a frequency of 4000 Hz.
>>>      This translates to hardware sample rate of 1377000 instructions per
>>>      micro-second to meet a frequency of 4000 HZ.
>>
>> 1377000 instructions per sample? I'm assuming per micro-second is a mistake.
> 
> Here is the maths:
> # cat /proc/service_levels
> CPU-MF: Counter facility: version=3.8 authorization=002f
> CPU-MF: Sampling facility: min_rate=22032 max_rate=180464112 cpu_speed=5508
> CPU-MF: Sampling facility: mode=basic sample_size=32
> CPU-MF: Sampling facility: mode=diagnostic sample_size=171
> ...
> 
> So the cpu_speed of 5508 (machine type z17) means 5508 CPU cycles per micro second. Document SA23-2260-08 page 2-35
> 5508 * 1000000 = 5508000000b / 4000 --> 1377000 CPU cycles between hardware write a sample.
> 

Makes sense, I was just confused about the units.

>>
>> As in, it sets the counter to roll over and take a sample every 1377000 cycles (instructions?), which ends up being 4000 samples per second.
>>
>>>
>>> 2. With first event cycles now sampling into a hardware buffer, an interrupt
>>>      is triggered each time a sampling buffer gets full. The interrupt handler
>>>      is then invoked and debug output shows the processing of samples.
>>>      The size of one hardware sample is 32 bytes. With an interrupt triggered
>>>      when the hardware buffer page of 4KB gets full, the interrupt handler
>>>      processes 128 samples.
>>>      (This is taken from s390 specific fast debug data gathering)
>>>      2025-11-07 14:35:51.977248  000003ffe013cbfa  perf_event_count_update event->count 0x0 count 0x1502e8
>>>      2025-11-07 14:35:51.977248  000003ffe013cbfa  perf_event_count_update event->count 0x1502e8 count 0x1502e8
>>>      2025-11-07 14:35:51.977248  000003ffe013cbfa  perf_event_count_update event->count 0x2a05d0 count 0x1502e8
>>>      2025-11-07 14:35:51.977252  000003ffe013cbfa  perf_event_count_update event->count 0x3f08b8 count 0x1502e8
>>>      2025-11-07 14:35:51.977252  000003ffe013cbfa  perf_event_count_update event->count 0x540ba0 count 0x1502e8
>>>      2025-11-07 14:35:51.977253  000003ffe013cbfa  perf_event_count_update event->count 0x690e88 count 0x1502e8
>>>      2025-11-07 14:35:51.977254  000003ffe013cbfa  perf_event_count_update event->count 0x7e1170 count 0x1502e8
>>>      2025-11-07 14:35:51.977254  000003ffe013cbfa  perf_event_count_update event->count 0x931458 count 0x1502e8
>>>      2025-11-07 14:35:51.977254  000003ffe013cbfa  perf_event_count_update event->count 0xa81740 count 0x1502e8
>>>
>>> 3. The value is constantly increasing by the number of instructions executed
>>>      to generate a sample entry.  This is the first line of the pairs of lines.
>>>      count 0x1502e8 --> 1377000
>>>
>>>      # perf script | grep 1377000 | wc -l
>>>      214
>>>      # perf script | wc -l
>>>      428
>>>      #
>>>      That is 428 lines in total, and half of the lines contain value 1377000.
>>>
>>> 4. The second event cycles is opened against the counting PMU, which is an
>>>      independent PMU and is not interrupt driven.  Once enabled it runs in the
>>>      backgroud and keeps running, incrementing silently about 400+
>>>      counters. The counter values are read via assembly instructions.
>>>
>>>      This second counter PMU's read call back function is called when the
>>>      interrupt handler of the sampling facility processes each sample. The
>>>      function call sequence is:
>>>
>>>      perf_event_overflow()
>>>      +--> __perf_event_overflow()
>>>           +--> __perf_event_output()
>>>                  +--> perf_output_sample()
>>>                       +--> perf_output_read()
>>>                            +--> perf_output_read_group()
>>>                                     for_each_sibling_event(sub, leader) {
>>>                   values[n++] = perf_event_count(sub, self);
>>>                   printk("%s sub %p values %#lx\n", __func__, sub, values[n-1]);
>>>                                     }
>>>
>>>      The last function perf_event_count() is invoked on the second event cylces
>>>      *on* the counting PMU. An added printk statement shows the following lines
>>>      in the dmesg output:
>>>
>>>      # dmesg|grep perf_output_read_group |head -10
>>>      [  332.368620] perf_output_read_group sub 00000000d80b7c1f values 0x3a80917 (1)
>>>      [  332.368624] perf_output_read_group sub 00000000d80b7c1f values 0x3a86c7f (2)
>>>      [  332.368627] perf_output_read_group sub 00000000d80b7c1f values 0x3a89c15 (3)
>>>      [  332.368629] perf_output_read_group sub 00000000d80b7c1f values 0x3a8c895 (4)
>>>      [  332.368631] perf_output_read_group sub 00000000d80b7c1f values 0x3a8f569 (5)
>>>      [  332.368633] perf_output_read_group sub 00000000d80b7c1f values 0x3a9204b
>>>      [  332.368635] perf_output_read_group sub 00000000d80b7c1f values 0x3a94790
>>>      [  332.368637] perf_output_read_group sub 00000000d80b7c1f values 0x3a9704b
>>>      [  332.368638] perf_output_read_group sub 00000000d80b7c1f values 0x3a99888
>>>      #
>>>
>>>     This correlates with the output of
>>>      # perf report -D | grep 'id 00000000000000'|head -10
>>>      ..... id 0000000000000006, value 00000000001502e8, lost 0
>>>      ..... id 000000000000000e, value 0000000003a80917, lost 0 --> line (1) above
>>>      ..... id 0000000000000006, value 00000000002a05d0, lost 0
>>>      ..... id 000000000000000e, value 0000000003a86c7f, lost 0 --> line (2) above
>>>      ..... id 0000000000000006, value 00000000003f08b8, lost 0
>>>      ..... id 000000000000000e, value 0000000003a89c15, lost 0 --> line (3) above
>>>      ..... id 0000000000000006, value 0000000000540ba0, lost 0
>>>      ..... id 000000000000000e, value 0000000003a8c895, lost 0 --> line (4) above
>>>      ..... id 0000000000000006, value 0000000000690e88, lost 0
>>>      ..... id 000000000000000e, value 0000000003a8f569, lost 0 --> line (5) above
>>>
>>> Summary:
>>> - Above command starts the CPU sampling facility, with runs interrupt
>>>     driven when a 4KB page is full. An interrupt processes the 128 samples
>>>     and calls eventually perf_output_read_group() for each sample to save it
>>>     in the event's ring buffer.
>>>
>>> - At that time the CPU counting facility is invoked to read the value of
>>>     the event cycles. This value is saved as the second value in the
>>>     sample_read structure.
>>>
>>> - The first and odd lines in the perf script output displays the period
>>>     value between 2 samples being created by hardware. It is the number
>>>     of instructions executes before the hardware writes a sample.
>>>
>>> - The second and even lines in the perf script output displays the number
>>>     of CPU cycles needed to process each sample and save it in the event's ring
>>>     buffer.
> 
> ....
> 
>>> Thanks a lot.
>>
>> I agree, it looks like the test in its current form isn't valid and shouldn't be run on s390.
>>
>> Does this buffered hardware counter only support the cycles event? Or does it support any event but there is only one instance of it?
>>
>> Because if it only supports the cycles event then we can just change the test to count branches which would force it to run on a simple counter instead. If it supports any event then I think the test (or sample read as a whole) can never work.
>>
>> You'd still probably want to update the PMU to reject sample read events that run on the buffered counter, whether it's only for cycles or not. That would prevent people from being confused outside of the test as well.
>>
> We can disable this leader sampling test for s390, because we only have one event.
> Or I change the command line invocation to this:
> 
> # git diff tests/shell/record.sh
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index 0f5841c479e7..4d2557b85606 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -260,7 +260,7 @@ test_uid() {
>   
>   test_leader_sampling() {
>     echo "Basic leader sampling test"
> -  if ! perf record -o "${perfdata}" -e "{cycles,cycles}:Su" -- \
> +  if ! perf record -o "${perfdata}" -e "{cpum_sf/SF_CYCLES_BASIC/,cycles}:S" -- \
>       perf test -w brstack 2> /dev/null
>     then
>       echo "Leader sampling [Failed record]"
> @@ -432,18 +432,18 @@ if [[ $default_fd_limit -lt $min_fd_limit ]]; then
>          ulimit -Sn $min_fd_limit
>   fi
> 
> It installs the sampling using a different perf_event::attr::type and
> perf_event::attr::config combination for sampling. It now operates on
> two sampling event which run in sync.
> 
> Leads to this result:
> # for i in $(seq 10); do ./perf test 124; done
> 124: perf record tests                                               : Ok
> 124: perf record tests                                               : Ok
> 124: perf record tests                                               : Ok
> 124: perf record tests                                               : Ok
> 124: perf record tests                                               : Ok
> 124: perf record tests                                               : Ok
> 124: perf record tests                                               : Ok
> 124: perf record tests                                               : Ok
> 124: perf record tests                                               : Ok
> 124: perf record tests                                               : Ok
> #
> 
> Should I submit a patch for that?
> 
> Thanks

If it's possible to make the test work then the alternate command format 
is probably better than disabling it completely. I would send a patch, yes.

But ignoring the test, I think you should still make a change to reject 
"{cycles,cycles}:S" in the PMU, because the buffered counter can't 
support sampling when it's the group leader. From what you've described, 
the behavior of the other counters in this mode is not what anyone would 
expect that command to do.

This would be to benefit users hitting this, rather than fix the test. I 
think the test is pointing to an issue and some action should be taken 
rather than worked around.

