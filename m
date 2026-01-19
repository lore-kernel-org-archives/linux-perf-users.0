Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19F7314D03
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Jan 2026 11:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768823758; cv=none; b=iT/RfUWNo1fkXHD3SEjZcqjFO5GcqkcgRhAbE1744Eklu1febrOwpXcZacmLD1+zxsgA7iPeWfkw6fLkpTpxLNJCNQojxWSpFBDfCrlvFGHj8BL5POM8377P46kbjUsvvKzl+DK2fkGa8dA9nnwnjwDHvjXZzND0uMWBF/ZV5hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768823758; c=relaxed/simple;
	bh=9HNjF03FOvid9A7lhzX0xFoG2pq85dCgzmfWzy6LrZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rb1VyfCFjXSPP6+BMeBgEhhEGUyJuf9RWG0sHZ2WVNWg/Mg5tdu/WQ0kKtXaRw6TzGtWoG6NV+bBIROsY0GX+MH3IntjT4kBO7YpmafByASysfnCHpfqPmSxWj0m0RWR1Q9KEBwN58ai90QIOlyPWo1SFOmU7zt3UxooiGVXhGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gZq4m6WP; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gZq4m6WP"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-655af782859so5929406a12.2
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Jan 2026 03:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768823755; x=1769428555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AXiM1Ldm8EEc6/BLfYACbiNHnSMaV8xvZKNGfWydJ6Y=;
        b=gZq4m6WPZzI/LubnJUZLp136YSvRglk/cyQ6v7MXRbQP867moWW6wDi5Dt4ya/Bjkn
         q/E3IVE4AAmGmWme1R4JDz5knP+gpjwmHRzhxluihnAemjzaiAf4MKrz7LRJ4OknfL8m
         DyudCpe6fr4Bp+YUttp8Fe7/ehVqZFGTOzeyWclN/6YGafR+ZhRe8tnGRzcALwZDvupJ
         EyY2v+Sb7PzB9zsm0L36fyOaZu7FWpsZ9ONju67MAwrzn+UPGmv8a6VBCv6nQVSYyI3r
         VlGpjTbHAef1IOXuZA93gIvIrBz81TXunAbcA8pUiSKYfcmid/dHalGEzjuB/5u4PihN
         brMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768823755; x=1769428555;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AXiM1Ldm8EEc6/BLfYACbiNHnSMaV8xvZKNGfWydJ6Y=;
        b=rVX0A3xFplH5zIlK3w7mewfht8V3tNnst7K4z9K62bGI3+fCWmMabfKRfWkf1Y10DA
         Wtf6jYTnYjK2gJvUDsmBAxKywgYX4CcUPvXoyeb86Sz2fMSsAYkaxiwNAK3LDDae6Pu0
         WfSSqoDU/LzmO7LLRqX5b/XPCklF4MynjTw0YW7vx3BGMjdG56WzjieDOzuVwZ1n7/nY
         ZK0FNIe2ZXQWcOT3dQpzaqYMlNbjQ3EL1ocfeqWJcQezkK3+fee8ps1FXIhA9aqXx2yC
         n7D6PK5AS3tj7cM9vNgKpS/EDB8deueVF0+B8A+TE0+zZewStNksAMSmDy6yieF1wvIC
         5M/w==
X-Forwarded-Encrypted: i=1; AJvYcCUTL2fnRyjg2vjtT5yVPx1iRfYBKjxJxK7/0ZyNbEIOeuS/DymuE3ptytqyeDtubWg+udYf94IY3sfPOXS0RSQp@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu62Fo6WViHfNP1jmoH08m+QBlcRkgOHT05QoEZyh9gGcLkwU+
	rEmViFpgxssnLW4dfpcABEeDs2S+QYEJG++713/YfDdWsMil1cnArtGddzB7JaYqD+E=
X-Gm-Gg: AY/fxX7YQZPukrHTWAJPVoA/bwFO0/tvLs4NCL+aH4In6LhDDZdZOTJ0z57TJhob7Py
	VxHogTjpoJg8O0CgDAq/UNDO79Wysg5gmoAaKv+O3XaT+PvytTa+5MVyn4yI6ycjTO/phbgs2eA
	Ri8qmRZV3Qi8fqFMYjnwkP0HElemeiiLUOFIfNcBfSr52nyIUZ1+xu96tg5tSlwIEAVb75FCAC3
	TyxQMmsrEDCtimjhP3cpzFyDrKK3tpah4+WNa5XiTpMSrQOK1/bldVRnSRBdtEI3Q/cNZxYRJ+q
	9Ya/uz1p0WzP4kIK0u4VW6vhQrBHjhKE7WfLyFa4XdLnIjidWEkZSymXmMnn98VZhXNiSJur1bY
	LCG7j73LivYXz7ENXo0rcnL0x6oDP0J1iHA/1yTbO0jwGLEpfgdVNGo8DQqq3fbOQTECV04NBYC
	TEzAMhx3td/Z5GTf0YviA5DFmmj84=
X-Received: by 2002:a05:6402:13c8:b0:649:6a2e:9bbb with SMTP id 4fb4d7f45d1cf-654524cf1bemr8705520a12.2.1768823755134;
        Mon, 19 Jan 2026 03:55:55 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-654534c8c82sm10269125a12.29.2026.01.19.03.55.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 03:55:54 -0800 (PST)
Message-ID: <3b06ea25-2516-406c-8b78-c359d3fb2aa6@linaro.org>
Date: Mon, 19 Jan 2026 11:55:53 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] perf cs-etm: Fix decoding for sparse CPU maps
To: Leo Yan <leo.yan@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
 Mike Leach <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Thomas Falcon <thomas.falcon@intel.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260119-james-perf-coresight-cpu-map-segfault-v2-0-56b956a629ee@linaro.org>
 <20260119-james-perf-coresight-cpu-map-segfault-v2-1-56b956a629ee@linaro.org>
 <20260119111509.GD1286628@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260119111509.GD1286628@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 19/01/2026 11:15 am, Leo Yan wrote:
> On Mon, Jan 19, 2026 at 10:18:35AM +0000, Coresight ML wrote:
>> The ETM decoder incorrectly assumed that auxtrace queue indices were
>> equivalent to CPU number. This assumption is used for inserting records
>> into the queue, and for fetching queues when given a CPU number. This
>> assumption held when Perf always opened a dummy event on every CPU, even
>> if the user provided a subset of CPUs on the commandline, resulting in
>> the indices aligning.
>>
>> For example:
>>
>>    # event : name = cs_etm//u, , id = { 2451, 2452 }, type = 11 (cs_etm), size = 136, config = 0x4010, { sample_period, samp>
>>    # event : name = dummy:u, , id = { 2453, 2454, 2455, 2456 }, type = 1 (PERF_TYPE_SOFTWARE), size = 136, config = 0x9 (PER>
>>
>>    0 0 0x200 [0xd0]: PERF_RECORD_ID_INDEX nr: 6
>>    ... id: 2451  idx: 2  cpu: 2  tid: -1
>>    ... id: 2452  idx: 3  cpu: 3  tid: -1
>>    ... id: 2453  idx: 0  cpu: 0  tid: -1
>>    ... id: 2454  idx: 1  cpu: 1  tid: -1
>>    ... id: 2455  idx: 2  cpu: 2  tid: -1
>>    ... id: 2456  idx: 3  cpu: 3  tid: -1
>>
>> Since commit 811082e4b668 ("perf parse-events: Support user CPUs mixed
>> with threads/processes") the dummy event no longer behaves in this way,
>> making the ETM event indices start from 0 on the first CPU recorded
>> regardless of its ID:
>>
>>    # event : name = cs_etm//u, , id = { 771, 772 }, type = 11 (cs_etm), size = 144, config = 0x4010, { sample_period, sample>
>>    # event : name = dummy:u, , id = { 773, 774 }, type = 1 (PERF_TYPE_SOFTWARE), size = 144, config = 0x9 (PERF_COUNT_SW_DUM>
>>
>>    0 0 0x200 [0x90]: PERF_RECORD_ID_INDEX nr: 4
>>    ... id: 771  idx: 0  cpu: 2  tid: -1
>>    ... id: 772  idx: 1  cpu: 3  tid: -1
>>    ... id: 773  idx: 0  cpu: 2  tid: -1
>>    ... id: 774  idx: 1  cpu: 3  tid: -1
> 
> Seems to me that this patch works around the issue by using the CPU ID
> instead, but event->auxtrace.idx is broken.
> 
> Should we store the correct index in event->auxtrace.idx (e.g., in the
> __perf_event__synthesize_id_index()) ?
> 
> Thanks,
> Leo
> 

I don't think it's a workaround, I think it should have been written 
this way in the first place.

Idx is just what it says it is, it's the position in the array. If there 
are only two events then they are idx 0 and 1, but CPU can be anything. 
If ETM didn't open a dummy event at the same time then I think it always 
would have behaved like that.

>> This causes the following segfault when decoding:
>>
>>    $ perf record -e cs_etm//u -C 2,3 -- true
>>    $ perf report
>>
>>    perf: Segmentation fault
>>    -------- backtrace --------
>>    #0 0xaaaabf9fd020 in ui__signal_backtrace setup.c:110
>>    #1 0xffffab5c7930 in __kernel_rt_sigreturn [vdso][930]
>>    #2 0xaaaabfb68d30 in cs_etm_decoder__reset cs-etm-decoder.c:85
>>    #3 0xaaaabfb65930 in cs_etm__get_data_block cs-etm.c:2032
>>    #4 0xaaaabfb666fc in cs_etm__run_per_cpu_timeless_decoder cs-etm.c:2551
>>    #5 0xaaaabfb6692c in (cs_etm__process_timeless_queues cs-etm.c:2612
>>    #6 0xaaaabfb63390 in cs_etm__flush_events cs-etm.c:921
>>    #7 0xaaaabfb324c0 in auxtrace__flush_events auxtrace.c:2915
>>    #8 0xaaaabfaac378 in __perf_session__process_events session.c:2285
>>    #9 0xaaaabfaacc9c in perf_session__process_events session.c:2442
>>    #10 0xaaaabf8d3d90 in __cmd_report builtin-report.c:1085
>>    #11 0xaaaabf8d6944 in cmd_report builtin-report.c:1866
>>    #12 0xaaaabf95ebfc in run_builtin perf.c:351
>>    #13 0xaaaabf95eeb0 in handle_internal_command perf.c:404
>>    #14 0xaaaabf95f068 in run_argv perf.c:451
>>    #15 0xaaaabf95f390 in main perf.c:558
>>    #16 0xffffaab97400 in __libc_start_call_main libc_start_call_main.h:74
>>    #17 0xffffaab974d8 in __libc_start_main@@GLIBC_2.34 libc-start.c:128
>>    #18 0xaaaabf8aa8f0 in _start perf[7a8f0]
>>
>> Fix it by inserting into the queues based on CPU number, rather than
>> using the index.
>>
>> Fixes: 811082e4b668 ("perf parse-events: Support user CPUs mixed with threads/processes")
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   tools/perf/util/cs-etm.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
>> index 25d56e0f1c07..12b55c2bc2ca 100644
>> --- a/tools/perf/util/cs-etm.c
>> +++ b/tools/perf/util/cs-etm.c
>> @@ -3086,7 +3086,7 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
>>   
>>   	if (aux_offset >= auxtrace_event->offset &&
>>   	    aux_offset + aux_size <= auxtrace_event->offset + auxtrace_event->size) {
>> -		struct cs_etm_queue *etmq = etm->queues.queue_array[auxtrace_event->idx].priv;
>> +		struct cs_etm_queue *etmq = cs_etm__get_queue(etm, auxtrace_event->cpu);
>>   
>>   		/*
>>   		 * If this AUX event was inside this buffer somewhere, create a new auxtrace event
>> @@ -3095,6 +3095,7 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
>>   		auxtrace_fragment.auxtrace = *auxtrace_event;
>>   		auxtrace_fragment.auxtrace.size = aux_size;
>>   		auxtrace_fragment.auxtrace.offset = aux_offset;
>> +		auxtrace_fragment.auxtrace.idx = etmq->queue_nr;
>>   		file_offset += aux_offset - auxtrace_event->offset + auxtrace_event->header.size;
>>   
>>   		pr_debug3("CS ETM: Queue buffer size: %#"PRI_lx64" offset: %#"PRI_lx64
>>
>> -- 
>> 2.34.1
>>
>> _______________________________________________
>> CoreSight mailing list -- coresight@lists.linaro.org
>> To unsubscribe send an email to coresight-leave@lists.linaro.org

