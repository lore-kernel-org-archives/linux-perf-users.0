Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34321FBF75
	for <linux-perf-users@vger.kernel.org>; Tue, 12 Nov 2024 14:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731420782; cv=none; b=MUqV9Ufry3WYvbu73f7+LMlSFEAZDAGQTI4yJKYVypak+71gyJXin1zvb7yw2gXV+oiYRslBMD23DPgXO8u7GxhP8s7D0INVUjsgEDH3nlwdK83nWfdS9/8EXNM1BrBgnRVYfNPUuaPUgbJY2+VX08a17yGSRxGU6FlQXl9KZa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731420782; c=relaxed/simple;
	bh=r9ulrn9W3iGqmUr28uMK/tpmBF/i8YyPFp6ATPxVgyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=drFmYgNs8sGrY4LOHYGupTQCN8L3/yUD4c7yWkcd/A2rFVPRrq4AUTwyQsvNVNA8dmey2WZRIL0AM+PwRHjp9IMALYIB8xeYR474eHzj/F9uM3Wo94o1mczxRLlVUQaBzHGkR88aC5SKwNVgAH+hqM2/fos1IQdDS4oLW8JGI8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c/aObiAN; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c/aObiAN"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c96b2a10e1so8674388a12.2
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Nov 2024 06:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731420777; x=1732025577; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kimy/1TnQyXFgX3XhWARxQaAButHmRKH6ok4ewImjsE=;
        b=c/aObiANj5BbJC1gyLsO7SAm3+3t1qDARAN7MHlmSs3HoleeQXRguF0alnbjFGNOqr
         5AKuQzbxyGzIwZTFL3GGZQw926jzyq3hEQeaVqSJjooWNHizdLgeKqwL094f9IQJPw+C
         4oR33hfEiuWBbx4yNPqNme1FVZirKV9Sw3X5JM1T/vIl0zHL1TXSz+4TL8nmR2zkrzHS
         Obk0Bp3Yf/hFyBrNJ8TiQZgSFbG9qkcRQEaGETid6/lGjGNMswJGN9kw58Y71lUgkFnd
         WxZ28534VwZanMed2WU2Cshh82x6gA4BgOQfOGGhwJkxZ9KS7IAgZR6VbvhmSJRUIsQ/
         RD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731420777; x=1732025577;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kimy/1TnQyXFgX3XhWARxQaAButHmRKH6ok4ewImjsE=;
        b=Q4dKNlqvee1dFBJgREVmYuC+qzIUdNAvsMhRhzA3OuB/zN1RkazAgXDOrJwAPhHw++
         pGBiJih4AlCSf++7+TFxDeV1wExX1r5QRlXDQ+oluxzb3lfAdUfT9cEFvMjAObs5EWIr
         mNLq1rUiPR2dSqVacVpbvjk03ooIfWjy+7FhUI2hm8tXnR+hvYMLPSg0ICCM7LUmwXCW
         tBtNutRL9+gWF0Vege+tuLCmhuqXiEuzqhBzY5cp2fYJMwgIK42CB+oduY9SCrOv+wrA
         plecmsp3Q3snQLAjAttWMrb1PlaMJlb+/SDALD1uHMtbt/pCrYor1EmvVK2yYqeCo+M8
         g7zw==
X-Forwarded-Encrypted: i=1; AJvYcCXenoinCYom5C/GNtvjuYvc48K0EcZt+qPaJgJ+CigSwB/WP7BG4XEyiUoM2s0wG9CTuXAQkGkJZbkK/s+WPTC/@vger.kernel.org
X-Gm-Message-State: AOJu0YzqIDFrTUDVEP/TF2SrwE+0aDlE+X93AT914l7f5I6eFBMLhF4I
	GIo7yQ6WC4cYSv7vym0Wx4C2Ox4dw0zoNoioSZwyDLs5qHPZ8MYznUKniNMSlQc=
X-Google-Smtp-Source: AGHT+IF8ZzFJGC2+9TmxkXCX8DpTdCc5s5/9wXaiXhqnbIR1gmuegK2IEMW1ZFA9x1EGQeWGSRbTvQ==
X-Received: by 2002:a17:907:d13:b0:a99:ffef:aec5 with SMTP id a640c23a62f3a-a9eeff0e434mr1778281966b.23.1731420777187;
        Tue, 12 Nov 2024 06:12:57 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.214])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0ad2f76sm717111766b.89.2024.11.12.06.12.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 06:12:56 -0800 (PST)
Message-ID: <9bfdc5a0-ed1d-40f6-8a72-6129e1587ca7@linaro.org>
Date: Tue, 12 Nov 2024 14:12:52 +0000
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
Cc: Atish Patra <atishp@rivosinc.com>, Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, linux-riscv@lists.infradead.org,
 beeman@rivosinc.com, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Ze Gao <zegao2021@gmail.com>,
 Weilin Wang <weilin.wang@intel.com>, Ben Gainey <ben.gainey@arm.com>,
 Dominique Martinet <asmadeus@codewreck.org>, Junhao He
 <hejunhao3@huawei.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241026121758.143259-1-irogers@google.com>
 <20241026121758.143259-4-irogers@google.com>
 <7c1a0bbf-12fd-46ef-9db2-183dfa70a334@linaro.org>
 <CAP-5=fVODgnWgfCpA7x3B8JFQhkt_unUeTjhWWdSDpKECdTSYg@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fVODgnWgfCpA7x3B8JFQhkt_unUeTjhWWdSDpKECdTSYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/11/2024 5:00 pm, Ian Rogers wrote:
> On Mon, Nov 11, 2024 at 7:49 AM James Clark <james.clark@linaro.org> wrote:
>>
>>
>>
>> On 26/10/2024 1:17 pm, Ian Rogers wrote:
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
>>
>> This makes me wonder if this message was overly wordy to begin with.
>> This line is fine:
>>
>>    Failure to open event 'data_read' on PMU 'uncore_imc_free_running_0'
>>    which will be removed.
>>
>> The next bit about the syscall just repeats. The exit code could be
>> included on the previous line. And the dmesg bit is general advice that
>> could possibly be printed once at the end.
> 
> Thanks for the time spent investigating this!
> 
> I agree on this. I wonder if we should have short and long messages,
> or message+help like we do for parse events. One patch series like
> this is improving EBUSY:
> https://lore.kernel.org/lkml/20241106003007.2112584-1-ctshao@google.com/
> The issue with printing at the end is knowing where/when the end is.
> Printing once is easy enough.
> 
>>> Error:
>>> Failure to open event 'LLC-prefetch-read' on PMU 'cpu' which will be removed.
>>> The LLC-prefetch-read event is not supported.
>>> [ perf record: Woken up 1 times to write data ]
>>> [ perf record: Captured and wrote 2.188 MB perf.data (87 samples) ]
>>>
>>> $ perf report --stats
>>> Aggregated stats:
>>>                  TOTAL events:      17255
>>>                   MMAP events:        284  ( 1.6%)
>>>                   COMM events:       1961  (11.4%)
>>>                   EXIT events:          1  ( 0.0%)
>>>                   FORK events:       1960  (11.4%)
>>>                 SAMPLE events:         87  ( 0.5%)
>>>                  MMAP2 events:      12836  (74.4%)
>>>                KSYMBOL events:         83  ( 0.5%)
>>>              BPF_EVENT events:         36  ( 0.2%)
>>>         FINISHED_ROUND events:          2  ( 0.0%)
>>>               ID_INDEX events:          1  ( 0.0%)
>>>             THREAD_MAP events:          1  ( 0.0%)
>>>                CPU_MAP events:          1  ( 0.0%)
>>>              TIME_CONV events:          1  ( 0.0%)
>>>          FINISHED_INIT events:          1  ( 0.0%)
>>> cycles stats:
>>>                 SAMPLE events:         87
>>> ```
>>>
>>> Note, if all events fail to open then the data file will contain no
>>> samples. This is deliberate as at the point the events are opened
>>> there are other events, such as the dummy event for sideband data, and
>>> these events will succeed in opening even if the user specified ones
>>
>> Is a file with only sideband events useful? Is it possible to fail the
>> record command if the event doesn't open anywhere?
>>
>> I noticed this leads to some different behavior and a libperf warning
>> when you have paranoid=3:
>>
>>     $ perf record -e cycles -C 0 -- true
>>
>>     Error:
>>     Failure to open event 'cpu_atom/cycles/u' on PMU 'cpu_atom' which will
>>     be removed.
>>     ...
>>     Consider adjusting /proc/sys/kernel/perf_event_paranoid setting
>>     ...
>>     libperf: Miscounted nr_mmaps 0 vs 28
>>     WARNING: No sample_id_all support, falling back to unordered
>>     processing
>>     [ perf record: Woken up 1 times to write data ]
>>     [ perf record: Captured and wrote 0.021 MB perf.data ]
> 
> So paranoid=3 is a Debian extension that Peter Z doesn't agree with
> and so isn't enabled in regular kernels. So we're dealing with cycles,
> which we'd expect to open or fall-back to a software event like
> task-clock. It feels like things could happen better here but that's
> not necessarily the fault of this patch.
> 

paranoid=3 is a bit of a red-herring. I actually meant any paranoid 
value other than -1. The important part is "-C 0" because only root is 
allowed to open on a CPU. Or "-a" also causes the issue.

Previously you got the command failure and the hint about the paranoid 
value, but now you get the libperf error too and it still makes the file.

I still don't think a file with only sideband events is useful, I don't 
think there's even a commandline that you can run currently that results 
in that? You always need at least one event to open for it to succeed 
and I'm thinking we could keep that.

It would be nice to fix the libperf warning too because it's warning 
about something that was already warned about.

>>> don't. Having a mix of open and broken events leads to a problem of
>>> identifying different sources of events.
>>   >
>>
>> In my basic test I saw that the opened event was identified correctly in
>> perf report, unless you have an example that you encountered that we
>> should fix?
> 
> I didn't find any but we also don't tend to test failing to open
> events. I could imagine things failing in `perf test` on neoverse
> testing given the l3 advertising the cycles event.
> 
>> One place I saw an issue was with auxtrace events. If there's an event
>> name clash then you're likely to not be able to open the file afterwards
>> because the auxtrace code can't handle an event that didn't open. But I
>> don't know of any name clashes there (I just faked one for testing), and
>> maybe that could be fixed up later in the auxtrace code if there is ever
>> a real one.
>>
>> Other than the above it does seem to work ok.
> 
> Cool, can this be taken as a Tested-by?
> 

Yep, although with a caveat that I faked the second cycles PMU that 
wouldn't open, but I don't think that should make a difference:

Tested-by: James Clark <james.clark@linaro.org>

I can also test with the real thing if you like but would take a bit 
longer as I have to borrow it off Leo.

> Thanks,
> Ian
> 
>>> The issue with legacy events is that on RISC-V they want the driver to
>>> not have mappings from legacy to non-legacy config encodings for each
>>> vendor/model due to size, complexity and difficulty to update. It was
>>> reported that on ARM Apple-M? CPUs the legacy mapping in the driver
>>> was broken and the sysfs/json events should always take precedent,
>>> however, it isn't clear this is still the case. It is the case that
>>> without working around this issue a legacy event like cycles without a
>>> PMU can encode differently than when specified with a PMU - the
>>> non-PMU version favoring legacy encodings, the PMU one avoiding legacy
>>> encodings.
>>>
>>> The patch removes events and then adjusts the idx value for each
>>> evsel. This is done so that the dense xyarrays used for file
>>> descriptors, etc. don't contain broken entries. As event opening
>>> happens relatively late in the record process, use of the idx value
>>> before the open will have become corrupted, so it is expected there
>>> are latent bugs hidden behind this change - the change is best
>>> effort. As the only vendor that has broken event names is ARM, this
>>> will principally effect ARM users. They will also experience warning
>>> messages like those above because of the uncore PMU advertising legacy
>>> event names.
>>
>>
>>
>>>
>>> Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> ---
>>>    tools/perf/builtin-record.c | 22 +++++++++++++++++-----
>>>    1 file changed, 17 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>>> index f83252472921..7e99743f7e42 100644
>>> --- a/tools/perf/builtin-record.c
>>> +++ b/tools/perf/builtin-record.c
>>> @@ -1364,6 +1364,7 @@ static int record__open(struct record *rec)
>>>        struct perf_session *session = rec->session;
>>>        struct record_opts *opts = &rec->opts;
>>>        int rc = 0;
>>> +     bool skipped = false;
>>>
>>>        evlist__for_each_entry(evlist, pos) {
>>>    try_again:
>>> @@ -1379,15 +1380,26 @@ static int record__open(struct record *rec)
>>>                                pos = evlist__reset_weak_group(evlist, pos, true);
>>>                                goto try_again;
>>>                        }
>>> -                     rc = -errno;
>>>                        evsel__open_strerror(pos, &opts->target, errno, msg, sizeof(msg));
>>> -                     ui__error("%s\n", msg);
>>> -                     goto out;
>>> +                     ui__error("Failure to open event '%s' on PMU '%s' which will be removed.\n%s\n",
>>> +                               evsel__name(pos), evsel__pmu_name(pos), msg);
>>> +                     pos->skippable = true;
>>> +                     skipped = true;
>>> +             } else {
>>> +                     pos->supported = true;
>>>                }
>>> -
>>> -             pos->supported = true;
>>>        }
>>>
>>> +     if (skipped) {
>>> +             struct evsel *tmp;
>>> +             int idx = 0;
>>> +
>>> +             evlist__for_each_entry_safe(evlist, tmp, pos) {
>>> +                     if (pos->skippable)
>>> +                             evlist__remove(evlist, pos);
>>> +                     pos->core.idx = idx++;
>>> +             }
>>> +     }
>>>        if (symbol_conf.kptr_restrict && !evlist__exclude_kernel(evlist)) {
>>>                pr_warning(
>>>    "WARNING: Kernel address maps (/proc/{kallsyms,modules}) are restricted,\n"
>>

