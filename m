Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC8E3115A1
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2025 09:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761729940; cv=none; b=kzUoV4cnuhttlURf2wfuP02J156bCPg8nJXKzLQCgZ7hxUQKFS/Dycrtf/7sa9Am9QK9y75cCnyVdySpmKGlAJze2dd/zWjYCLVE+Yhng5IwT/dIkp0XxxJHjKIt28X3b9Cu5n/xKzB2FXvUIvaKrY+GNBJJz6J5LF2um2LlhXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761729940; c=relaxed/simple;
	bh=em8Yqb44MHlvpODw2ZdBZQz4bb8sy+E1eWIexrzmv7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f/owFVcpK4AcDKCEtz8KZRJXsuJ2H+rywhXz8kT2L5zLQ1fUBZzm+oyhTq8G5O3Ocrs3K+ImRozQXCjAxoSoH3RDdtIb8GFpIj1lKEp2J5ylQ8BuwRbWywgoDJEQxbrTAQ/hLi/dMa7Of9c62XLZRwO7kn1QPLrL1JLd7r4vwW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HQasnXru; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HQasnXru"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-426fd62bfeaso3363636f8f.2
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2025 02:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761729937; x=1762334737; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/pZNBSfIkxhE1LylNY8fIOfMqoKa3PB7kAGOJIexFb0=;
        b=HQasnXruqeocyuUKtY+nZuE1sQRmpez6pnViA9/CP0HXs6H48ggefwIhGT7ZORb3Uu
         JnZG8RZxtouH+/Q2/hHtdJSMn3UCpkUZZgKsi4anUGHnp/WHdEdplfwX95eMuWeZ9bMU
         U8PvkeQB7NltodBalGNg5i2CA2nyj0iBMUP+ZbAiWvRG09LKggbYr6JEvn6Wc8BlOu0M
         52q1ZC1LlFQBoR0PtJQANYfspJ1fgR7C8ah0OIMVF0LV0zW1e8fS1HCYL/+F1Tup27bM
         uOQx3Pya7YEJrYL1P2eggrWlhFFKE/1QlhwP+PXzjhYXtVdnkmzup5o1UULGFzLo34xm
         4lgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761729937; x=1762334737;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/pZNBSfIkxhE1LylNY8fIOfMqoKa3PB7kAGOJIexFb0=;
        b=RFmjTWjvOJt0EzDsmqaK3XAeuQ2e6Yjkxk3cNwFkk/CgGNTCmiSS/rstT59x4Ircbp
         Zd3N5NzUg4GoL2rXTGvwcuhMIaWhdwqs2WrNBpfJEkLA22dhWN2hVdmZWBbTHTAgSN5x
         fCIAAGvyzXl73tsk+9nAZckkSs/c/QaDyyTpe7lHUuyq2xWj4RmSpiQ7+OWj5uFEV5V6
         nUMZblQ0qtHu+tK2d5C5U7b6Bjgpi0KqxhkLggnY4QQEEkJQJSQxw5HBNQN9cgvtGh/C
         utZ9t/oyxyvpgTKfYU2lOv3r3D4TVVhM6SodyuUiDtujO/JjNB8Ikw4D49FscvdR4hVX
         GX9w==
X-Forwarded-Encrypted: i=1; AJvYcCVS5LeHzpdx/rqVsEUo83T3MEOJnM8P+XAGZojas4mhEq0SsxUyyDJdM29JF3/yqJWcESZN+KOn6RJZyhauVsgj@vger.kernel.org
X-Gm-Message-State: AOJu0YxaFNfW7ONGj1QP/2khOAzQkZ47fu1+jXL4bRPxICvDcJVImQ+t
	yDYeUjuQRrb/DBTBVrNyKvpHrjjUCZEkvb5NtDrjwkUhpB2jDXEMLt37y6+KFSDoBsc=
X-Gm-Gg: ASbGncs3O2zzPXq7gMU4WvivjGIkvFiVT9vq6qMW3VueIzSxHwFfzbYbn4VbLWmr6Y7
	1DKrzoYGv4lr6kuZejWY3KvMA6s4GFUmqJMnEdZVqDQ/665pBnIKpVm0NcpmvoSdGurt7pmet09
	cBXqL4xMKeIIPrue9NARuBRbEJOlCN/OX0lKT6UeyW9K87AullwAgt+VgFvEQO3ZcgP42OG6Yyv
	XLoKBQnUrhHpjOqzjHSvI2xrCsjjQMobJOKxd5/p/vUR0k9LffQiAKXrjxeBujX3OBlTSboMKPg
	XSUQ+zwAqeTTccX/V/o1XcXZutdXwudGQSMe/DGkDkXDv6KNzhJKuMsZ1k6+cPeq8TDZIoGeKU1
	stZ36ZMBvJRSnFX58W/I5r/rP3Lfr0BJxkyu1G4iQnBeT1+FVOxtQPX7eLoT6V9AkTs8ugyZzC0
	ZGfGy59Q1Wjmddrslh
X-Google-Smtp-Source: AGHT+IGAMto38c4LGeDRSszsom5w/xx1agT4AbOAzcJbsFBclnI8F1/yZcroSDeXkkFUnlHbHFsYhg==
X-Received: by 2002:a05:6000:25c5:b0:427:a34:648c with SMTP id ffacd0b85a97d-429aefdaa08mr1558025f8f.58.1761729936792;
        Wed, 29 Oct 2025 02:25:36 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e3aae1fsm36877955e9.12.2025.10.29.02.25.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 02:25:36 -0700 (PDT)
Message-ID: <1826ae90-b36b-4cde-b895-623cab4e1b08@linaro.org>
Date: Wed, 29 Oct 2025 09:25:34 +0000
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
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <a6218625-a08e-4466-837d-7bdd0c8631a5@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 29/10/2025 7:37 am, Thomas Richter wrote:
> On 10/28/25 16:23, James Clark wrote:
>>
>>
>> On 28/10/2025 12:55 pm, Thomas Richter wrote:
> .....
> 
>>> When I skip the grep it actually gets worse, there re more run away values:
>>> # perf record -e "{cycles,cycles}:Su" -- perf test -w brstack
>>> [ perf record: Woken up 2 times to write data ]
>>> [ perf record: Captured and wrote 0.012 MB perf.data (50 samples) ]
>>> # perf script | head -20
>>>               perf  919810  6726.456179:    2754000 cycles:       3ff95608ec8 _dl_map_object_from_fd+0xb18 (/usr/lib/ld64.so.1)
>>>               perf  919810  6726.456179:   58638457 cycles:       3ff95608ec8 _dl_map_object_from_fd+0xb18 (/usr/lib/ld64.so.1)
>>>               perf  919810  6726.456182:    1377000 cycles:       3ff9560a696 check_match+0x76 (/usr/lib/ld64.so.1)
>>>               perf  919810  6726.456182:    1377000 cycles:       3ff9560fa6a _dl_relocate_object_no_relro+0x5fa (/usr/lib/ld64.so.1)
>>
>> Can you share the raw output for the second sample as well? Or even the whole file would be better.
> 
> Ok I will append a perf.data from today and hopefully it will be delivered to you:
> See attachment perf.data.tmrs390 (binary file, big endian from s390)
> 
>>
>> It's the addresses from this sample that are confusing. 0x3ff95608ec8 is the same for both counters on the first sample (correctly), but the second sample has 0x3ff9560a696 and 0x3ff9560fa6a even though the cycles counts are the same.
>>
> 
> Command
>    ./perf record -r 99 -e "{cycles,cycles}:Su" -- ./perf test -w brstack
> is testing leadership group sampling in tests/shell/record.sh and
> fails most of the time on s390.
> 
> The command opens event cycles (as group leader) for sampling and the s390
> sampling facility is started with default frequency of 4000.
> This can be seen in the debug output:
> 
> perf record opening and mmapping events
> Opening: cycles
> ------------------------------------------------------------
> perf_event_attr:
>    type                             0 (PERF_TYPE_HARDWARE)
>    size                             136
>    config                           0 (PERF_COUNT_HW_CPU_CYCLES)
>    { sample_period, sample_freq }   4000
>    sample_type                      IP|TID|TIME|READ|ID|PERIOD
>    read_format                      ID|GROUP|LOST
>    disabled                         1
>    inherit                          1
>    exclude_kernel                   1
>    exclude_hv                       1
>    mmap                             1
>    comm                             1
>    freq                             1
>    enable_on_exec                   1
>    task                             1
>    sample_id_all                    1
>    mmap2                            1
>    comm_exec                        1
>    ksymbol                          1
>    bpf_event                        1
>    build_id                         1
> ....
> Next event cycles is opened in the s390 counting facility:
> Opening: cycles
> perf_event_attr:
>    type                             0 (PERF_TYPE_HARDWARE)
>    size                             136
>    config                           0 (PERF_COUNT_HW_CPU_CYCLES)
>    sample_type                      IP|TID|TIME|READ|ID|PERIOD
>    read_format                      ID|GROUP|LOST
>    inherit                          1
>    exclude_kernel                   1
>    exclude_hv                       1
>    sample_id_all                    1
> 
> So now there are 2 hardware events when are mapped on s390 to
>   1. event handled by CPU Measurement sampling facility, hardware writes 32 byte
>      large samples to buffers. The frequency of 4000 Hz translates
>      to a sample every 1300000 instructions. Interrupt driven.
>   2. event handled by CPU Measurement  counting facilitly, hardware
>      runs in the background and increments counters accordingly.
>      All available counters (about 400) are running in the background
>      and read via assembler instruction until stopped. No interrupts.
> 
> If I understand this setup correctly, the first event is the group
> leader and either both events run and are active or non of them.
> That is the reason why both values should be identitical
> Is this true?
> 
> Now given two independent CPU measurement units on s390, one running
> in the background incrementing counters, the other interrupt driven
> reading samples, there is always room the both counters to differ.
> The question is how much and how often.
> 
> When I look at the debug output of the perf.data file; I get this:
> 
> 55805554120788 0x22a8 [0x68]: PERF_RECORD_SAMPLE(IP, 0x2):
>                  14135/14135: 0x3ff9ae90340 period: 1300000 addr: 0
> ... sample_read:
> .... group nr 2
> ..... id 00000000000000b4, value 000000000115b5c0, lost 0
> ..... id 00000000000000bc, value 000000000195ac03, lost 0
>   ... thread: perf:14135
>   ...... dso: /usr/lib/ld64.so.1
> 
> The first value is the count from the sampling event, it gets
> incremented with 4000 Hz frequency:
> 
>   # perf report -D -i/tmp/perf.data.tmrs390|grep 00000000000000b4,|head -10
> ..... id 00000000000000b4, value 000000000101dfa0, lost 0
> ..... id 00000000000000b4, value 000000000115b5c0, lost 0
> ..... id 00000000000000b4, value 00000000013d6200, lost 0
> ..... id 00000000000000b4, value 0000000001513820, lost 0
> ..... id 00000000000000b4, value 0000000001650e40, lost 0
> ..... id 00000000000000b4, value 00000000018cba80, lost 0
> ..... id 00000000000000b4, value 0000000001a090a0, lost 0
> ..... id 00000000000000b4, value 0000000001b466c0, lost 0
> ..... id 00000000000000b4, value 0000000001c83ce0, lost 0
> ..... id 00000000000000b4, value 0000000001dc1300, lost 0
> 
> value 115b5c0 - 101dfa0 = 13d620 --> 1300000 period time.
> So that value always increments by period time.
> 
> The other counter id is:
>   # perf report -D -i/tmp/perf.data.tmrs390|grep 00000000000000bc,| sort | uniq -d
> ..... id 00000000000000bc, value 000000000195ac03, lost 0
> ..... id 00000000000000bc, value 0000000002fd8b45, lost 0
> ..... id 00000000000000bc, value 0000000005f0b1ce, lost 0
>   #
> It reads out the value of counter 0 (cycles) 85 times, but has only 3 different
> values.
> 
> Anyway what does perf script print out? The value of the samples frequency?
> Where does perf record read out the value of the counter event?
> Any ideas where to start debugging?
> 
> Thanks a lot.
> 

I think your PMU is just broken when setup for sampling events. The 
second counter is not being reset to zero to begin with, and then it 
doesn't increment after the first sample. I don't think your issues are 
to do with virtualisation.

The reason I was confused about the addresses in the Perf script output 
is because Perf discards samples where the counter didn't increment:

	/*
	 * There's no reason to deliver sample
	 * for zero period, bail out.
	 */
	if (!sample->period)
		return 0;

I'm not really sure about the logic for this because it breaks the 
assumption that the Perf script output has one line for each counter. 
And counters not increasing is information in itself which should be 
displayed.

If I comment out this line, then the output looks like I would expect 
and plainly shows your issue:

perf 55805.554110: 15600000 cycles: 3ff9ae95194 (lib/ld64.so.1)
perf 55805.554110: 26586115 cycles: 3ff9ae95194 (lib/ld64.so.1)
perf 55805.554117:  1300000 cycles: 3ff9ae8bb3e (lib/ld64.so.1)
perf 55805.554117:        0 cycles: 3ff9ae8bb3e (lib/ld64.so.1)
perf 55805.554120:  1300000 cycles: 3ff9ae90340 (lib/ld64.so.1)
perf 55805.554120:        0 cycles: 3ff9ae90340 (lib/ld64.so.1)

Now we always have pairs of samples, and you can see that your second 
cycle counter isn't doing anything.

