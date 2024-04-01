Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE09FEC2
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Apr 2024 01:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711936212; cv=none; b=Fqf7/HqdZRHTP8LOvPfQ+OuOe26IJNXolhcZxKfKsixX2WCDj7bsOSXTTfX6WuyX3T0Crt73nuE7AzD4416KeIesp07sCXF1B5ghLnrspUNK4zbUiTVCp6G9u43jtzXlwlZD9P3ZcvxBIsRcb8A3hNsPeqfE8W2BXBFj30EOkss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711936212; c=relaxed/simple;
	bh=rDFUral7vn5eS7vyVCG8JtxHLPByu19HqxEscA/SB4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j4S7XnPrrE1xxrDSDnmCOS6KOMLLBBemKkG5kXVSf20hbT0k6ne/PKGpk+Oe3PHG2+dcURbmFHOeXUMPsNSwkmSho7hXVTPs7pqDNfYw2YhRj7nn6rNh0Uyl0qELWo9yvzXbxsm2phNFLjOSgtv6xUNvHO0NoxabIOyCnWIfUGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RVMozxAa; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RVMozxAa"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5dbf7b74402so1677121a12.0
        for <linux-perf-users@vger.kernel.org>; Sun, 31 Mar 2024 18:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1711936210; x=1712541010; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CRYywXE8+9lX5RrI042vy6CzRi3+MsMsXqGgBAV3yHw=;
        b=RVMozxAalILwYSBy6ChMcwlKUCKO5SBV9uYOqx4lCQZ7iGgMogPOGHFU5MwaDX0NwE
         gDr+YAtvMhYdmKFnhtspo+fRYlZBh3b3o/514dt+LWKkWxhUxPBG84WTNZAow11pyU0g
         rHu38ll5x3nkUbeUBToLBZgPZ7jWslwvwj23syCQ7X67dCnpSIld6UMdgUzXw3XGeT9I
         PB6HImvawore5KAy4a6GdFUpRjFMIbW3S4kdV9sniSzaix/tIlLuXiL+DikhmDIPhWAa
         +a7cN8mrj+Z/uu1qwWty9NeZL7+LBTbgJJmeJ4KURzgp2LeBcitMt96bO6TCiCSoUmOE
         7GkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711936210; x=1712541010;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CRYywXE8+9lX5RrI042vy6CzRi3+MsMsXqGgBAV3yHw=;
        b=pN0wnc+6WS3E7sgpzwbVtNAmpML4r9UA/BTH/j7pVg//s389A4QP3P6B53odhxqmeK
         8phqwmMiEFPn8bZ47hOEFGfhFhJLx8JF19WYf6ABuEg+byVCRpB1to0brHPynZ+4EQzA
         4uQo4az8u/dzBCUF0euh8aE6r0AUd2M2MtsnIpFID2UlxePcAPO16OKw/1rpLqOLqt+T
         f7VYleHWVGBfqCjnigG/CMaKp93cO1qSt5KCKH2mnTdR2CLp7ERTCDoZSXudKyZH/a8U
         CwgWbGfzOyXryezVziL1BdKOlBDPH3OOae50OxVKiNrIipLmjUcljoMs6Vnac2NVJfGI
         EZbg==
X-Forwarded-Encrypted: i=1; AJvYcCXyqsOj+VamKVM3/WWYACoQmED5dcfT6K65EEp6eJyFrMm7l6l5mZbga0bLSvdZkWG9sH9UquEwjooPxmLwBU4Vg19FaXzZGFebExSbd+3vZQ==
X-Gm-Message-State: AOJu0YzJD4VcjAHYHW78ctUkoAye4ByO2A/Wizd9QEVw5us4/4NK4Ipd
	xWexxFjvy8LlkprRbvBhb0uoZJttGWMHxb9ktmjgCWu/L2pQes8XyOh1GuFgfXk=
X-Google-Smtp-Source: AGHT+IH3O3ddA0jLxC5WEKab+WbxA2X3ci2q31Bq94psQF6a23zi00KnDE6uDLGe1jAMKgE9PTe/UA==
X-Received: by 2002:a05:6a20:d90e:b0:1a3:dc61:926a with SMTP id jd14-20020a056a20d90e00b001a3dc61926amr8809408pzb.54.1711936209967;
        Sun, 31 Mar 2024 18:50:09 -0700 (PDT)
Received: from [10.70.146.105] ([203.208.189.8])
        by smtp.gmail.com with ESMTPSA id b15-20020a170902650f00b001e014627baasm7671692plk.79.2024.03.31.18.50.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Mar 2024 18:50:09 -0700 (PDT)
Message-ID: <3be0a35e-9e10-49b5-8fa2-71f6ddc6f704@bytedance.com>
Date: Mon, 1 Apr 2024 09:50:02 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH 1/2] perf sched timehist: Fix
 -g/--call-graph option failure
Content-Language: en-US
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, james.clark@arm.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240328055857.383180-1-yangjihong@bytedance.com>
 <CAP-5=fXms1noWT8PXqBu89QogcwVsvAGpxq3Q_bNUYOYL7PpKA@mail.gmail.com>
 <2e44ae50-d4af-4788-9274-aaf345bac066@bytedance.com>
 <CAP-5=fWDY9Aj+qHNOuwJ9yE==G=vmCzECXYEZAifOhGHX7yr6w@mail.gmail.com>
 <ZggmNWYjBtid_hCZ@x1>
From: Yang Jihong <yangjihong@bytedance.com>
In-Reply-To: <ZggmNWYjBtid_hCZ@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

On 3/30/24 22:48, Arnaldo Carvalho de Melo wrote:
> On Fri, Mar 29, 2024 at 09:08:01AM -0700, Ian Rogers wrote:
>> On Thu, Mar 28, 2024 at 8:02 PM Yang Jihong <yangjihong@bytedance.com> wrote:
>>>
>>> Hello,
>>>
>>> Sorry, due to the new email settings, the last reply email was in html
>>> format, resend it now.
>>>
>>> On 3/29/24 00:02, Ian Rogers wrote:
>>>> On Wed, Mar 27, 2024 at 10:59 PM Yang Jihong <yangjihong@bytedance.com> wrote:
>>>>>
>>>>> When perf-sched enables the call-graph recording, sample_type of dummy
>>>>> event does not have PERF_SAMPLE_CALLCHAIN, timehist_check_attr() checks
>>>>> that the evsel does not have a callchain, and set show_callchain to 0.
>>>>>
>>>>> Currently perf sched timehist only saves callchain when processing
>>>>> sched:sched_switch event, timehist_check_attr() only needs to determine
>>>>> whether the event has PERF_SAMPLE_CALLCHAIN.
>>>>>
>>>>> Before:
>>>>>     # perf sched record -g true
>>>>>     [ perf record: Woken up 0 times to write data ]
>>>>>     [ perf record: Captured and wrote 4.153 MB perf.data (7536 samples) ]
>>>>>     # perf sched timehist
>>>>>     Samples do not have callchains.
>>>>>                time    cpu  task name                       wait time  sch delay   run time
>>>>>                             [tid/pid]                          (msec)     (msec)     (msec)
>>>>>     --------------- ------  ------------------------------  ---------  ---------  ---------
>>>>>       147851.826019 [0000]  perf[285035]                        0.000      0.000      0.000
>>>>>       147851.826029 [0000]  migration/0[15]                     0.000      0.003      0.009
>>>>>       147851.826063 [0001]  perf[285035]                        0.000      0.000      0.000
>>>>>       147851.826069 [0001]  migration/1[21]                     0.000      0.003      0.006
>>>>>     <SNIP>
>>>>>
>>>>> After:
>>>>>     # perf sched record -g true
>>>>>     [ perf record: Woken up 1 times to write data ]
>>>>>     [ perf record: Captured and wrote 2.572 MB perf.data (822 samples) ]
>>>>>     # perf sched timehist
>>>>>                time    cpu  task name                       wait time  sch delay   run time
>>>>>                             [tid/pid]                          (msec)     (msec)     (msec)
>>>>>     --------------- ------  ------------------------------  ---------  ---------  ---------
>>>>>       144193.035164 [0000]  perf[277062]                        0.000      0.000      0.000    __traceiter_sched_switch <- __traceiter_sched_switch <- __sched_text_start <- preempt_schedule_common <- __cond_resched <- __wait_for_common <- wait_for_completion
>>>>>       144193.035174 [0000]  migration/0[15]                     0.000      0.003      0.009    __traceiter_sched_switch <- __traceiter_sched_switch <- __sched_text_start <- smpboot_thread_fn <- kthread <- ret_from_fork
>>>>>       144193.035207 [0001]  perf[277062]                        0.000      0.000      0.000    __traceiter_sched_switch <- __traceiter_sched_switch <- __sched_text_start <- preempt_schedule_common <- __cond_resched <- __wait_for_common <- wait_for_completion
>>>>>       144193.035214 [0001]  migration/1[21]                     0.000      0.003      0.007    __traceiter_sched_switch <- __traceiter_sched_switch <- __sched_text_start <- smpboot_thread_fn <- kthread <- ret_from_fork
>>>>> <SNIP>
>>>>
>>>> This looks good, should there be a Fixes tag for the sake of backports?
>>>>
>>> The direct cause is commit 9c95e4ef0657 ("perf evlist: Add
>>> evlist__findnew_tracking_event() helper"). perf-record uses
>>> evlist__add_aux_dummy() to replace evlist__add_dummy() to add a dummy
>>> event. The difference is that evlist__add_aux_dummy() sets
>>> no_aux_samples to true (this is expected behavior, for dummy event, no
>>> need to sample aux data), resulting in evsel__config() not adding the
>>> PERF_SAMPLE_CALLCHAIN bit to dummy's sample_type.
>>>
>>> In summary, the direct cause is the problem introduced by commit
>>> 9c95e4ef0657 ("perf evlist: Add evlist__findnew_tracking_event()
>>> helper"), but the root cause is the timehist_check_attr() logic problem,
>>> The dummy event itself does not need to have PERF_SAMPLE_CALLCHAIN, so
>>> there is no need to check it.
>>>
>>>
>>> So, maybe add fixes-tag:
>>>
>>> Fixes: 9c95e4ef0657 ("perf evlist: Add evlist__findnew_tracking_event()
>>> helper")
>>>
>>> If it is ok, I will send v2 version with this fixes-tag.
>>
>> I think the maintainer can add the fixes tag when they add the reviewed-by tag:
> 
> I usually do this, but if the submitter does it I'll have just to check
> that it is the right tag, helps a bit in processing.
Okay, will send v2 version.

> 
> - Arnaldo
>   
>> Reviewed-by: Ian Rogers <irogers@google.com>
Thanks for reviewed-by tag.

Thanks,
Yang
