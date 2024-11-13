Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486FE1FAC56
	for <linux-perf-users@vger.kernel.org>; Wed, 13 Nov 2024 10:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731492043; cv=none; b=KWK4GortZNU9JyCGh/K0YPpxLq903MtDw/upSlTr62uDvmlmoJhPN/ghH7OOTyWLxeT1BQnN8KWFUa3+OKLd1mH2BzVUq/YNaBgMCJhzIhUUyBNFBMzSZPqAsh+KVzO/rkH4I0eWseeEBYW4lvejWEbgwzz3XJevqFEK4QLYZvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731492043; c=relaxed/simple;
	bh=KQyypn11QfmaUdPq9znBrvj/Mm8NiWbp/Ld82JhNGa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qrtPINCzJFdQcrjLrlqYmQFtpKNCW2Lciu73B0c+msGdbC9aryKIz2yP5ZlbQhkVR2JavMeq1NJdaNMOvA8ZuYq3MNLCOtpvCaVMDWw8Me07gR+8S+wl3x4vH4Tvj/i/M39D1e10F98NWO2sKwiHaLULaNpwmpxb48louK1k8+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vkaGKKQJ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vkaGKKQJ"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9a68480164so940622766b.3
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Nov 2024 02:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731492039; x=1732096839; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MW7KPVnVNr5FD5G+DQH0BUzbgVMNYEdIujB7YLFl0RE=;
        b=vkaGKKQJSfzOFJ377YJIFO5uN5IxtHC1+cXFk4QRjyvIHtp1/RxmEoprW851k45iN1
         IhdKDgCUocwKezrgM1CgSv1x9wRrGht1wQgOCqsAX9OktHHwVnr2Y32VGAt1NsRMkKXA
         /iInWvsts0UD7d2sIEP8ZXSn7Q9ucteuMxJQrjmeFO2tlLmRBbTLFX5EALKyBszEh56o
         qiOzocIRytcPuKY2QP9hhHSeQi4EoNKw9oscQ30FRFagzn/JKz2fVs+/5gEE4VTVLvD4
         53sev7mLGnXoAb7EJqm/rqLn8RtAhgcL+o6sjXReWfUFEEW30v21xhenHHo0teAOfdx/
         lFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731492039; x=1732096839;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MW7KPVnVNr5FD5G+DQH0BUzbgVMNYEdIujB7YLFl0RE=;
        b=TIFXV5zWn2J7j4DpMNUGPI+KqLQrrlqyh+Cywgw5K1t3upj0bfZPE8hWahnIIpB5eg
         yZTkNNnTd5SEdpslRmJ/DHw5jEts/DUXDgQ1PTQNqb83dmVHM1h0ksE9Fi3sEde1VG2/
         TMIYegFuU/vIrTcm3oxkaMDI76ZEIsrmISsN0yLDMV13TmUKYGvR2Kwo65/mcuke+9IW
         W8lURLVGwiBPr4nFaVYk1kaKQ46Of2QjJzV7QOD5AyFLSdmqK595AaMqs6Owi6diyEab
         gLcT8nWdzSLjGsmBWlVWV2VmBNGokOCUUww2a4JEE4C5VS2C5dCCSlpCwJVOSNIAIqAM
         FJuw==
X-Forwarded-Encrypted: i=1; AJvYcCUr4d2Ls8Mf+daieVP7V0vFKQIW07HamLIYSz4AQ45zMaiGJclgOfNY3eo8oafGFNDSOphJJLn/fiO+5jpae/1y@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4GlZsjdHIqH9+BSjav3ThGKrywsozqGh5AI+JCMG/C05gPx4Z
	ip2wr2X/oBCuwY39Sco1VlcQitfmmCA8e6nqL/leZ1adguN3u4hxwufvEYE1Jgw=
X-Google-Smtp-Source: AGHT+IHv9nZHtlDz14UBGAVIklvxBfY2kCgIEnK88nypjRiMHPCpE4YZloV915vQIZ4YH2V9q3fBNw==
X-Received: by 2002:a17:906:c007:b0:aa1:f73b:be43 with SMTP id a640c23a62f3a-aa1f73bbf94mr176807366b.32.1731492039416;
        Wed, 13 Nov 2024 02:00:39 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.214])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0e2e41bsm842658666b.191.2024.11.13.02.00.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 02:00:38 -0800 (PST)
Message-ID: <f762f404-626a-430f-b307-33c9da756ac3@linaro.org>
Date: Wed, 13 Nov 2024 10:00:36 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] perf record: Skip don't fail for events that don't
 open
To: Ian Rogers <irogers@google.com>, Leo Yan <leo.yan@arm.com>
Cc: Atish Patra <atishp@rivosinc.com>, linux-riscv@lists.infradead.org,
 beeman@rivosinc.com, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Ze Gao <zegao2021@gmail.com>,
 Weilin Wang <weilin.wang@intel.com>, Ben Gainey <ben.gainey@arm.com>,
 Dominique Martinet <asmadeus@codewreck.org>, Junhao He
 <hejunhao3@huawei.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241026121758.143259-1-irogers@google.com>
 <20241026121758.143259-4-irogers@google.com>
 <20241112195343.GA404636@e132581.arm.com>
 <CAP-5=fXuyZbn3Jiq=RQaLTqybgji50Ko8jrpsinFqo+OOPBeRw@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fXuyZbn3Jiq=RQaLTqybgji50Ko8jrpsinFqo+OOPBeRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/11/2024 10:24 pm, Ian Rogers wrote:
> On Tue, Nov 12, 2024 at 11:53 AM Leo Yan <leo.yan@arm.com> wrote:
>>
>> On Sat, Oct 26, 2024 at 05:17:57AM -0700, Ian Rogers wrote:
>>>
>>> Whilst for many tools it is an expected behavior that failure to open
>>> a perf event is a failure, ARM decided to name PMU events the same as
>>> legacy events and then failed to rename such events on a server uncore
>>> SLC PMU. As perf's default behavior when no PMU is specified is to
>>> open the event on all PMUs that advertise/"have" the event, this
>>> yielded failures when trying to make the priority of legacy and
>>> sysfs/json events uniform - something requested by RISC-V and ARM. A
>>> legacy event user on ARM hardware may find their event opened on an
>>> uncore PMU which for perf record will fail. Arnaldo suggested skipping
>>> such events which this patch implements. Rather than have the skipping
>>> conditional on running on ARM, the skipping is done on all
>>> architectures as such a fundamental behavioral difference could lead
>>> to problems with tools built/depending on perf.
>>>
>>> An example of perf record failing to open events on x86 is:
>>> ```
>>> $ perf record -e data_read,cycles,LLC-prefetch-read -a sleep 0.1
>>> Error:
>>> Failure to open event 'data_read' on PMU 'uncore_imc_free_running_0' which will be removed.
>>> The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (data_read).
>>> "dmesg | grep -i perf" may provide additional information.
>>>
>>> Error:
>>> Failure to open event 'data_read' on PMU 'uncore_imc_free_running_1' which will be removed.
>>> The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (data_read).
>>> "dmesg | grep -i perf" may provide additional information.
>>>
>>> Error:
>>> Failure to open event 'LLC-prefetch-read' on PMU 'cpu' which will be removed.
>>> The LLC-prefetch-read event is not supported.
>>> [ perf record: Woken up 1 times to write data ]
>>> [ perf record: Captured and wrote 2.188 MB perf.data (87 samples) ]
>>>
>>> $ perf report --stats
>>> Aggregated stats:
>>>                 TOTAL events:      17255
>>>                  MMAP events:        284  ( 1.6%)
>>>                  COMM events:       1961  (11.4%)
>>>                  EXIT events:          1  ( 0.0%)
>>>                  FORK events:       1960  (11.4%)
>>>                SAMPLE events:         87  ( 0.5%)
>>>                 MMAP2 events:      12836  (74.4%)
>>>               KSYMBOL events:         83  ( 0.5%)
>>>             BPF_EVENT events:         36  ( 0.2%)
>>>        FINISHED_ROUND events:          2  ( 0.0%)
>>>              ID_INDEX events:          1  ( 0.0%)
>>>            THREAD_MAP events:          1  ( 0.0%)
>>>               CPU_MAP events:          1  ( 0.0%)
>>>             TIME_CONV events:          1  ( 0.0%)
>>>         FINISHED_INIT events:          1  ( 0.0%)
>>> cycles stats:
>>>                SAMPLE events:         87
>>> ```
>>
>> Thanks for James reminding me.  Tested on AVA platform:
>>
>> # tree /sys/bus/event_source/devices/arm_dsu_*/events
>>    ...
>>    /sys/bus/event_source/devices/arm_dsu_9/events
>>    ├── bus_access
>>    ├── bus_cycles
>>    ├── cycles
>>    ├── l3d_cache
>>    ├── l3d_cache_allocate
>>    ├── l3d_cache_refill
>>    ├── l3d_cache_wb
>>    └── memory_error
>>
>> # ./perf record -- sleep 0.1
>>   Error:
>>   Failure to open event 'cycles:PH' on PMU 'arm_dsu_0' which will be
>>   removed.
>>   cycles:PH: PMU Hardware doesn't support sampling/overflow-interrupts.
>>   Try 'perf stat'
>>   Error:
>>   Failure to open event 'cycles:PH' on PMU 'arm_dsu_1' which will be
>>   removed.
>>   cycles:PH: PMU Hardware doesn't support sampling/overflow-interrupts.
>>   Try 'perf stat'
>>   ...
>>   Error:
>>   Failure to open event 'cycles:PH' on PMU 'arm_dsu_15' which will be
>>   removed.
>>   cycles:PH: PMU Hardware doesn't support sampling/overflow-interrupts.
>>   Try 'perf stat'
>>   [ perf record: Woken up 1 times to write data ]
>>   [ perf record: Captured and wrote 0.008 MB perf.data (8 samples) ]
>>
>> # ./perf report --stats
>>
>>   Aggregated stats:
>>                  TOTAL events:         67
>>                   MMAP events:         40  (59.7%)
>>                   COMM events:          1  ( 1.5%)
>>                 SAMPLE events:          8  (11.9%)
>>                KSYMBOL events:          6  ( 9.0%)
>>              BPF_EVENT events:          6  ( 9.0%)
>>         FINISHED_ROUND events:          1  ( 1.5%)
>>               ID_INDEX events:          1  ( 1.5%)
>>             THREAD_MAP events:          1  ( 1.5%)
>>                CPU_MAP events:          1  ( 1.5%)
>>              TIME_CONV events:          1  ( 1.5%)
>>          FINISHED_INIT events:          1  ( 1.5%)
>>   cycles:P stats:
>>                 SAMPLE events:          8
>>
>> # ./perf stat -- sleep 0.1
>>
>>   Performance counter stats for 'sleep 0.1':
>>
>>                0.87 msec task-clock                       #    0.009 CPUs utilized
>>                   1      context-switches                 #    1.148 K/sec
>>                   0      cpu-migrations                   #    0.000 /sec
>>                  52      page-faults                      #   59.685 K/sec
>>             877,835      instructions                     #    1.14  insn per cycle
>>                                                    #    0.25  stalled cycles per insn
>>             772,102      cycles                           #  886.210 M/sec
>>             191,914      stalled-cycles-frontend          #   24.86% frontend cycles idle
>>             219,183      stalled-cycles-backend           #   28.39% backend cycles idle
>>             184,099      branches                         #  211.307 M/sec
>>               8,548      branch-misses                    #    4.64% of all branches
>>
>>         0.101623529 seconds time elapsed
>>
>>         0.001645000 seconds user
>>         0.000000000 seconds sys
>>
>> Tested-by: Leo Yan <leo.yan@arm.com>
> 
> Thanks Leo! As the Tested-by makes sense only if you've applied all 4
> patches, which your testing and James' testing shows you've both done,
> I'll add the tags to all 4 patches. I'll do likewise with Atish,
> rebase and resend the patches.
> 
> Thanks,
> Ian

Yep makes sense
