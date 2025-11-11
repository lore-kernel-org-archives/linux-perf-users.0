Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B805F3AA195
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 14:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762869827; cv=none; b=VG2D3kJFN26VmkvfuJOMneW+TllG9joHFlNEKVJLAsB3O61CbTtqbBWQ9fBn+uzlGlF++SHNtCpiLufmtcvwICeRq787KMvpvHQ4BpYfU5GNpHKzlKq9Xv3ytYJp3N/2tg5TPZKeaRHDlOm1JzkqdTvhNA4sbFBAHWmMo/3Bwfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762869827; c=relaxed/simple;
	bh=F7hBGWEKDsw0+TGNdR3Lx90EeuJ8hMbHyh9VWrnVBNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rsz9bL7zq212blL+IyEWkualjdzdUCmFvTjA1U6dq+Rlp1mdfuAP5KsnU/pbbLM5HrTaWqs0IeSQyk84qy1rM8+LwEvs4Oh090fY6k0VgtNFDN5SAptdjBlOFwbk38/Ca+iCQtEqxI5GB7uY7vGzRe/+mqBbl38ddXJbj1SZTDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J4saIXaM; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J4saIXaM"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477770019e4so34638415e9.3
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 06:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762869823; x=1763474623; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6putN4cDsnbFqRWlHsZrHi33VqUEDcQRLD1Wqm7RzQw=;
        b=J4saIXaMYrVyFPIE4u0cd7DktvyYHNNV/PQ9Br2WC8MLY9BzSUD1V7NUBT+kOyqAVb
         yU0Pekf2S92ToV5BrDITcksVAPmmM2qlHDVVNl5ACxFe2JBAMj/2ycFR9N2lVGV+B56K
         ADwuVkM+MwB9h7rAqk0sTs6keZZZGqxpy2lHV+NC9Ivkp1mcQwXBdm9/WOAa8S6TaeSF
         ZuC6IX5DC8bjVekw7fN3zWdEmsQnhJi7ZT3XC9aifK2XceqMqJS3kom1jtTu1B6Tskgv
         nMQlx0F8CbkTaP9IfT5htZdBGnpmx9nyNaQCKSgY8L2EZQbPePTz43Frk2tzTvZgMkDt
         +YNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762869823; x=1763474623;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6putN4cDsnbFqRWlHsZrHi33VqUEDcQRLD1Wqm7RzQw=;
        b=F93J+FPqNcaM5UQ/eTxdKEwFguJA/Eqh1d2dqZFLfUKnKgxIVfdDBJbZ7HCvNQRq0d
         SoiPXaKnxv9o8E4/Zbjztu2plUkumblbXplN+VvKDKVc2a39hpmky9XPpEBj6f4GutRj
         b9d51sHgWMFTzmVGIhzMS1CKOwpBHsAs7NCM55uYtUYIpS2pjMvAQpwabUuyJQpSlTXX
         amFBaQk/xevTEfMhwI3XUaRvOZKBvP14x6cZHRQTNrKhsutEG45MjxmGCPRPfIlsXuKb
         pijWK8DdZcVG92biUAAWAkQJ+SJNU5pSrCm9UhntrTqy3fc5+XHwBChUstaL8rxNuPlk
         8CVw==
X-Forwarded-Encrypted: i=1; AJvYcCWm8qfwxGqCcwjrqlz3XhZh02CIq1GwFYbEAt6TiRyVj2GBLd9tGhVwneMBmLxw8NbTnhOMeiyahUfAEHVlZyw4@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3TQ6CS0LLZ/p4jL9eNYJmjbNLa3sPgLfmykdFqUQaDTs55EqZ
	Yan+sWWUN/lk4F0zscFoaKjeuuXKka/esNFd8qO0NFDnK1++jqqChj+R90U7b77+1Fo=
X-Gm-Gg: ASbGnct9bzaUvdQJ248GISboGbAYVVqvUGLw6wJ0GXdZ8+IAxjhsEAJcOrAI4HlGN5p
	DX7n79UXSrUl6AZZSVY1shEgGGey5kcbzK6Z86OZA/TRTpFL4jrUCprrEghFuHI7tRFruJ6WHue
	bAs+8NoS583qsqzxMGE5U05ke++hJWOiPeJrqirWICEcIzkY+SeoMUnBuOUAz43iht5GSwgMhme
	yJYxQda4fxYaIFuSVDgNZK7x1QC6/mGSDBt3EZGKiI4MdXAY9yBNnY61ywIs8mOPEUXaF+HKHQO
	tvokoEtBeRO+wnUAmp9xDB+Vno2YfLw1unTMfqUDJthMzq6FtB60b90md1PT/KG44Ok5H7IiEZ2
	AiGae9uqTWMM9EyMJDed432GReDb0QiieBJ3RW3mrOQ692SZisZcRoyIWP4SPAAvYpNTJfoEAPX
	pBgIccVA==
X-Google-Smtp-Source: AGHT+IGoDI5jHKPKdic6NBmNQ8X2/CmLJDusmgFIYND1/SUMhOLQvGX14xQFa0VFFkogGhCokRr0WA==
X-Received: by 2002:a05:600c:46ce:b0:477:7b16:5f80 with SMTP id 5b1f17b1804b1-4777b166260mr69526605e9.10.1762869822776;
        Tue, 11 Nov 2025 06:03:42 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776bcfcfc7sm307793085e9.12.2025.11.11.06.03.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 06:03:42 -0800 (PST)
Message-ID: <42a066c9-8be3-432c-8cd2-5311c26e7b36@linaro.org>
Date: Tue, 11 Nov 2025 14:03:40 +0000
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
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <38c9bd83-d823-4b84-9f1d-ad0b58f20a4c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/11/2025 11:22 am, Thomas Richter wrote:
> On 10/29/25 10:25, James Clark wrote:
>>
>>
>> On 29/10/2025 7:37 am, Thomas Richter wrote:
>>> On 10/28/25 16:23, James Clark wrote:
>>>>
>>>>
>>>> On 28/10/2025 12:55 pm, Thomas Richter wrote:
>>> .....
>>>
>>>>> When I skip the grep it actually gets worse, there re more run away values:
>>>>> # perf record -e "{cycles,cycles}:Su" -- perf test -w brstack
>>>>> [ perf record: Woken up 2 times to write data ]
>>>>> [ perf record: Captured and wrote 0.012 MB perf.data (50 samples) ]
>>>>> # perf script | head -20
>>>>>                perf  919810  6726.456179:    2754000 cycles:       3ff95608ec8 _dl_map_object_from_fd+0xb18 (/usr/lib/ld64.so.1)
>>>>>                perf  919810  6726.456179:   58638457 cycles:       3ff95608ec8 _dl_map_object_from_fd+0xb18 (/usr/lib/ld64.so.1)
>>>>>                perf  919810  6726.456182:    1377000 cycles:       3ff9560a696 check_match+0x76 (/usr/lib/ld64.so.1)
>>>>>                perf  919810  6726.456182:    1377000 cycles:       3ff9560fa6a _dl_relocate_object_no_relro+0x5fa (/usr/lib/ld64.so.1)
>>>>
>>>> Can you share the raw output for the second sample as well? Or even the whole file would be better.
>>>
>>> Ok I will append a perf.data from today and hopefully it will be delivered to you:
>>> See attachment perf.data.tmrs390 (binary file, big endian from s390)
>>>
>>>>
>>>> It's the addresses from this sample that are confusing. 0x3ff95608ec8 is the same for both counters on the first sample (correctly), but the second sample has 0x3ff9560a696 and 0x3ff9560fa6a even though the cycles counts are the same.
>>>>
>>>
>>> Command
>>>     ./perf record -r 99 -e "{cycles,cycles}:Su" -- ./perf test -w brstack
>>> is testing leadership group sampling in tests/shell/record.sh and
>>> fails most of the time on s390.
>>>
>>> The command opens event cycles (as group leader) for sampling and the s390
>>> sampling facility is started with default frequency of 4000.
>>> This can be seen in the debug output:
>>>
>>> perf record opening and mmapping events
>>> Opening: cycles
>>> ------------------------------------------------------------
>>> perf_event_attr:
>>>     type                             0 (PERF_TYPE_HARDWARE)
>>>     size                             136
>>>     config                           0 (PERF_COUNT_HW_CPU_CYCLES)
>>>     { sample_period, sample_freq }   4000
>>>     sample_type                      IP|TID|TIME|READ|ID|PERIOD
>>>     read_format                      ID|GROUP|LOST
>>>     disabled                         1
>>>     inherit                          1
>>>     exclude_kernel                   1
>>>     exclude_hv                       1
>>>     mmap                             1
>>>     comm                             1
>>>     freq                             1
>>>     enable_on_exec                   1
>>>     task                             1
>>>     sample_id_all                    1
>>>     mmap2                            1
>>>     comm_exec                        1
>>>     ksymbol                          1
>>>     bpf_event                        1
>>>     build_id                         1
>>> ....
>>> Next event cycles is opened in the s390 counting facility:
>>> Opening: cycles
>>> perf_event_attr:
>>>     type                             0 (PERF_TYPE_HARDWARE)
>>>     size                             136
>>>     config                           0 (PERF_COUNT_HW_CPU_CYCLES)
>>>     sample_type                      IP|TID|TIME|READ|ID|PERIOD
>>>     read_format                      ID|GROUP|LOST
>>>     inherit                          1
>>>     exclude_kernel                   1
>>>     exclude_hv                       1
>>>     sample_id_all                    1
>>>
>>> So now there are 2 hardware events when are mapped on s390 to
>>>    1. event handled by CPU Measurement sampling facility, hardware writes 32 byte
>>>       large samples to buffers. The frequency of 4000 Hz translates
>>>       to a sample every 1300000 instructions. Interrupt driven.
>>>    2. event handled by CPU Measurement  counting facilitly, hardware
>>>       runs in the background and increments counters accordingly.
>>>       All available counters (about 400) are running in the background
>>>       and read via assembler instruction until stopped. No interrupts.
>>>
>>> If I understand this setup correctly, the first event is the group
>>> leader and either both events run and are active or non of them.
>>> That is the reason why both values should be identitical
>>> Is this true?
>>>
>>> Now given two independent CPU measurement units on s390, one running
>>> in the background incrementing counters, the other interrupt driven
>>> reading samples, there is always room the both counters to differ.
>>> The question is how much and how often.
>>>
>>> When I look at the debug output of the perf.data file; I get this:
>>>
>>> 55805554120788 0x22a8 [0x68]: PERF_RECORD_SAMPLE(IP, 0x2):
>>>                   14135/14135: 0x3ff9ae90340 period: 1300000 addr: 0
>>> ... sample_read:
>>> .... group nr 2
>>> ..... id 00000000000000b4, value 000000000115b5c0, lost 0
>>> ..... id 00000000000000bc, value 000000000195ac03, lost 0
>>>    ... thread: perf:14135
>>>    ...... dso: /usr/lib/ld64.so.1
>>>
>>> The first value is the count from the sampling event, it gets
>>> incremented with 4000 Hz frequency:
>>>
>>>    # perf report -D -i/tmp/perf.data.tmrs390|grep 00000000000000b4,|head -10
>>> ..... id 00000000000000b4, value 000000000101dfa0, lost 0
>>> ..... id 00000000000000b4, value 000000000115b5c0, lost 0
>>> ..... id 00000000000000b4, value 00000000013d6200, lost 0
>>> ..... id 00000000000000b4, value 0000000001513820, lost 0
>>> ..... id 00000000000000b4, value 0000000001650e40, lost 0
>>> ..... id 00000000000000b4, value 00000000018cba80, lost 0
>>> ..... id 00000000000000b4, value 0000000001a090a0, lost 0
>>> ..... id 00000000000000b4, value 0000000001b466c0, lost 0
>>> ..... id 00000000000000b4, value 0000000001c83ce0, lost 0
>>> ..... id 00000000000000b4, value 0000000001dc1300, lost 0
>>>
>>> value 115b5c0 - 101dfa0 = 13d620 --> 1300000 period time.
>>> So that value always increments by period time.
>>>
>>> The other counter id is:
>>>    # perf report -D -i/tmp/perf.data.tmrs390|grep 00000000000000bc,| sort | uniq -d
>>> ..... id 00000000000000bc, value 000000000195ac03, lost 0
>>> ..... id 00000000000000bc, value 0000000002fd8b45, lost 0
>>> ..... id 00000000000000bc, value 0000000005f0b1ce, lost 0
>>>    #
>>> It reads out the value of counter 0 (cycles) 85 times, but has only 3 different
>>> values.
>>>
>>> Anyway what does perf script print out? The value of the samples frequency?
>>> Where does perf record read out the value of the counter event?
>>> Any ideas where to start debugging?
>>>
>>> Thanks a lot.
>>>
>>
>> I think your PMU is just broken when setup for sampling events. The second counter is not being reset to zero to begin with, and then it doesn't increment after the first sample. I don't think your issues are to do with virtualisation.
>>
>> The reason I was confused about the addresses in the Perf script output is because Perf discards samples where the counter didn't increment:
>>
>>      /*
>>       * There's no reason to deliver sample
>>       * for zero period, bail out.
>>       */
>>      if (!sample->period)
>>          return 0;
>>
>> I'm not really sure about the logic for this because it breaks the assumption that the Perf script output has one line for each counter. And counters not increasing is information in itself which should be displayed.
>>
>> If I comment out this line, then the output looks like I would expect and plainly shows your issue:
>>
>> perf 55805.554110: 15600000 cycles: 3ff9ae95194 (lib/ld64.so.1)
>> perf 55805.554110: 26586115 cycles: 3ff9ae95194 (lib/ld64.so.1)
>> perf 55805.554117:  1300000 cycles: 3ff9ae8bb3e (lib/ld64.so.1)
>> perf 55805.554117:        0 cycles: 3ff9ae8bb3e (lib/ld64.so.1)
>> perf 55805.554120:  1300000 cycles: 3ff9ae90340 (lib/ld64.so.1)
>> perf 55805.554120:        0 cycles: 3ff9ae90340 (lib/ld64.so.1)
>>
>> Now we always have pairs of samples, and you can see that your second cycle counter isn't doing anything.
>>
>>
> 
> James,
> the counter above being always 0 come from the fact that the group uses modifier :u
> for user space, the cycles event are invoked without :u modifier.
> On s390 you need to use -e "{cycles,cycles}:S"

I'm not following why :u should make a difference. I see from your 
explanation below that you have two different types of counter and the 
first event runs on the buffered one and the other on a simple PMU 
counter, but how does that translate to userspace filtering making a 
difference?

> 
> I disagree with your assessment completely. I have spent quite some time
> debugging this and come to a different finding. I executed this command
> on the latest kernel:
> 
>   # uname -a
>   Linux b83lp65.lnxne.boe 6.18.0-rc4d-perf+ #84 SMP Fri Nov  7 09:24:44 CET 2025 s390x GNU/Linux
>   # /root/linux/tools/perf/perf record -e "{cycles,cycles}:S" \
>          -- taskset -c 0 /root/linux/tools/perf/perf test -w brstack 5000000 2>/dev/null
> 
> I also had your suggestion patched into the perf script code:
>   # git diff
>   diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 09af486c83e4..212bca671a49 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1212,9 +1212,9 @@ static int deliver_sample_value(struct evlist *evlist,
>          /*
>           * There's no reason to deliver sample
>           * for zero period, bail out.
> -        */
>          if (!sample->period)
>                  return 0;
> +        */
> 
>          evsel = container_of(sid->evsel, struct evsel, core);
>          return tool->sample(tool, event, sample, evsel, machine);
>   #
> 
> The output of perf script is now (always in pairs of 2 lines):
 > > taskset    7005   332.357459:    1377000 cycles:       3ff9db4611a 
find_module_idx+0x8a (/usr/lib64/libc.so.6)
> taskset    7005   332.357459:    1948445 cycles:       3ff9db4611a find_module_idx+0x8a (/usr/lib64/libc.so.6)
>     perf    7005   332.368619:    1377000 cycles:       3ffe03a4fa6 xas_reload+0x36 ([kernel.kallsyms])
>     perf    7005   332.368619:   61344023 cycles:       3ffe03a4fa6 xas_reload+0x36 ([kernel.kallsyms])
>     perf    7005   332.368624:    1377000 cycles:       3ffe0b53624 mas_empty_area_rev+0x3c4 ([kernel.kallsyms])
>     perf    7005   332.368624:      25448 cycles:       3ffe0b53624 mas_empty_area_rev+0x3c4 ([kernel.kallsyms])
>     perf    7005   332.368626:    1377000 cycles:       3ffadf81606 _dl_catch_exception+0xb6 (/usr/lib/ld64.so.1)
>     perf    7005   332.368626:      12182 cycles:       3ffadf81606 _dl_catch_exception+0xb6 (/usr/lib/ld64.so.1)
>     perf    7005   332.368628:    1377000 cycles:       3ffadf8c9b2 _dl_add_to_namespace_list+0x42 (/usr/lib/ld64.so.1)
>     perf    7005   332.368628:      11392 cycles:       3ffadf8c9b2 _dl_add_to_namespace_list+0x42 (/usr/lib/ld64.so.1)
>     perf    7005   332.368630:    1377000 cycles:       3ffe0b4f800 mas_prev+0x0 ([kernel.kallsyms])
>     perf    7005   332.368630:      11476 cycles:       3ffe0b4f800 mas_prev+0x0 ([kernel.kallsyms])
> 

The above patch won't make a difference to this output because none of 
them are 0. You get exactly the same output with or without the patch.

I only showed that this part of the code was hiding the original issue 
where most of the second counter values were 0. That seems to not be the 
case if you remove :u as you found, but isn't related to this part.

I kind of see why :u results in 0 counts, because you're only counting 
the time between when the buffered counter fills up and interrupted and 
when you generated the other samples. But I don't get why that has to be 
the case. Couldn't you leave the other counters running and then they 
would count everything between samples?

> 
> Now to the debugging and investigation:
> 1. With command
>         perf record -e '{cycles,cycles}:S' -- ....
>     the first cycles event start sampling.
>     On s390 this sets up sampling with a frequency of 4000 Hz.
>     This translates to hardware sample rate of 1377000 instructions per
>     micro-second to meet a frequency of 4000 HZ.

1377000 instructions per sample? I'm assuming per micro-second is a mistake.

As in, it sets the counter to roll over and take a sample every 1377000 
cycles (instructions?), which ends up being 4000 samples per second.

> 
> 2. With first event cycles now sampling into a hardware buffer, an interrupt
>     is triggered each time a sampling buffer gets full. The interrupt handler
>     is then invoked and debug output shows the processing of samples.
>     The size of one hardware sample is 32 bytes. With an interrupt triggered
>     when the hardware buffer page of 4KB gets full, the interrupt handler
>     processes 128 samples.
>     (This is taken from s390 specific fast debug data gathering)
>     2025-11-07 14:35:51.977248  000003ffe013cbfa  perf_event_count_update event->count 0x0 count 0x1502e8
>     2025-11-07 14:35:51.977248  000003ffe013cbfa  perf_event_count_update event->count 0x1502e8 count 0x1502e8
>     2025-11-07 14:35:51.977248  000003ffe013cbfa  perf_event_count_update event->count 0x2a05d0 count 0x1502e8
>     2025-11-07 14:35:51.977252  000003ffe013cbfa  perf_event_count_update event->count 0x3f08b8 count 0x1502e8
>     2025-11-07 14:35:51.977252  000003ffe013cbfa  perf_event_count_update event->count 0x540ba0 count 0x1502e8
>     2025-11-07 14:35:51.977253  000003ffe013cbfa  perf_event_count_update event->count 0x690e88 count 0x1502e8
>     2025-11-07 14:35:51.977254  000003ffe013cbfa  perf_event_count_update event->count 0x7e1170 count 0x1502e8
>     2025-11-07 14:35:51.977254  000003ffe013cbfa  perf_event_count_update event->count 0x931458 count 0x1502e8
>     2025-11-07 14:35:51.977254  000003ffe013cbfa  perf_event_count_update event->count 0xa81740 count 0x1502e8
> 
> 3. The value is constantly increasing by the number of instructions executed
>     to generate a sample entry.  This is the first line of the pairs of lines.
>     count 0x1502e8 --> 1377000
> 
>     # perf script | grep 1377000 | wc -l
>     214
>     # perf script | wc -l
>     428
>     #
>     That is 428 lines in total, and half of the lines contain value 1377000.
> 
> 4. The second event cycles is opened against the counting PMU, which is an
>     independent PMU and is not interrupt driven.  Once enabled it runs in the
>     backgroud and keeps running, incrementing silently about 400+
>     counters. The counter values are read via assembly instructions.
> 
>     This second counter PMU's read call back function is called when the
>     interrupt handler of the sampling facility processes each sample. The
>     function call sequence is:
> 
>     perf_event_overflow()
>     +--> __perf_event_overflow()
>          +--> __perf_event_output()
>                 +--> perf_output_sample()
>                      +--> perf_output_read()
>                           +--> perf_output_read_group()
>                                    for_each_sibling_event(sub, leader) {
>                  values[n++] = perf_event_count(sub, self);
>                  printk("%s sub %p values %#lx\n", __func__, sub, values[n-1]);
>                                    }
> 
>     The last function perf_event_count() is invoked on the second event cylces
>     *on* the counting PMU. An added printk statement shows the following lines
>     in the dmesg output:
> 
>     # dmesg|grep perf_output_read_group |head -10
>     [  332.368620] perf_output_read_group sub 00000000d80b7c1f values 0x3a80917 (1)
>     [  332.368624] perf_output_read_group sub 00000000d80b7c1f values 0x3a86c7f (2)
>     [  332.368627] perf_output_read_group sub 00000000d80b7c1f values 0x3a89c15 (3)
>     [  332.368629] perf_output_read_group sub 00000000d80b7c1f values 0x3a8c895 (4)
>     [  332.368631] perf_output_read_group sub 00000000d80b7c1f values 0x3a8f569 (5)
>     [  332.368633] perf_output_read_group sub 00000000d80b7c1f values 0x3a9204b
>     [  332.368635] perf_output_read_group sub 00000000d80b7c1f values 0x3a94790
>     [  332.368637] perf_output_read_group sub 00000000d80b7c1f values 0x3a9704b
>     [  332.368638] perf_output_read_group sub 00000000d80b7c1f values 0x3a99888
>     #
> 
>    This correlates with the output of
>     # perf report -D | grep 'id 00000000000000'|head -10
>     ..... id 0000000000000006, value 00000000001502e8, lost 0
>     ..... id 000000000000000e, value 0000000003a80917, lost 0 --> line (1) above
>     ..... id 0000000000000006, value 00000000002a05d0, lost 0
>     ..... id 000000000000000e, value 0000000003a86c7f, lost 0 --> line (2) above
>     ..... id 0000000000000006, value 00000000003f08b8, lost 0
>     ..... id 000000000000000e, value 0000000003a89c15, lost 0 --> line (3) above
>     ..... id 0000000000000006, value 0000000000540ba0, lost 0
>     ..... id 000000000000000e, value 0000000003a8c895, lost 0 --> line (4) above
>     ..... id 0000000000000006, value 0000000000690e88, lost 0
>     ..... id 000000000000000e, value 0000000003a8f569, lost 0 --> line (5) above
> 
> Summary:
> - Above command starts the CPU sampling facility, with runs interrupt
>    driven when a 4KB page is full. An interrupt processes the 128 samples
>    and calls eventually perf_output_read_group() for each sample to save it
>    in the event's ring buffer.
> 
> - At that time the CPU counting facility is invoked to read the value of
>    the event cycles. This value is saved as the second value in the
>    sample_read structure.
> 
> - The first and odd lines in the perf script output displays the period
>    value between 2 samples being created by hardware. It is the number
>    of instructions executes before the hardware writes a sample.
> 
> - The second and even lines in the perf script output displays the number
>    of CPU cycles needed to process each sample and save it in the event's ring
>    buffer.

Thanks for the explanation, I understand now. But this particular point 
stands out to me. When set up for PERF_SAMPLE_READ, the values of the 
counters returned shouldn't be the number of cycles required to process 
each sample. They should be whatever value that the counters were when 
the group leader took its sample. The counts should include everything 
from between when the last sample was taken to now.

It sounds like you can't honor that with your buffered cycles counter 
being the group leader anyway, so you shouldn't allow sample read events 
to be opened on it.

If the hardware counter is just doing its own thing writing its own 
samples into a buffer, without any interaction with the other counters 
then it's not really doing what the sample read feature intends. I think 
pretending that it can do it but returning confusing data is worse than 
just failing to open to begin with.

I know there's always going to be some slight differences in 
architectures and sometimes you have to fit things into the existing 
ABI, but this difference seems a bit too big to call it sample read at all.

> 
> These 2 different values can never be identical on s390.
> In fact I think this test case is not valid for s390. Or we have to
> compare the odd numbered lines to each other (1 with 3, 3 with 5 and so on)
> and the even lines (2 with 4, 4 with 6 and so on) to each other.
> 
> Any ideas or comments?
> 
> 
> Thanks a lot.

I agree, it looks like the test in its current form isn't valid and 
shouldn't be run on s390.

Does this buffered hardware counter only support the cycles event? Or 
does it support any event but there is only one instance of it?

Because if it only supports the cycles event then we can just change the 
test to count branches which would force it to run on a simple counter 
instead. If it supports any event then I think the test (or sample read 
as a whole) can never work.

You'd still probably want to update the PMU to reject sample read events 
that run on the buffered counter, whether it's only for cycles or not. 
That would prevent people from being confused outside of the test as well.

