Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D9238F87
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Mar 2024 03:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711681360; cv=none; b=EkU5i0ZNJetuUTMHQdTHSzrDhd5ryo44NIOcocuhhXgn5MsipfMb0HIkKQIJnsbY7SMrC8/jzdYQxdl+6tiJLmVBG05vnNOYBepMFR0nGNvYYvhpf4PzOHOi2XlqMuD4dx40xbf8QLsynPPYkForIyt6kdYgbVaLkbNrdnMtqgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711681360; c=relaxed/simple;
	bh=AVLiTWMVC+4Q2njoACpxaoXX6UMM4Sch999y4awMC74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nyW/YwLmsNV3aXNshhHVMcG4g4DILOqX1R2mwWoVniYTE5TB4ZcT4AffH4p18Em+oPDMpqOV+N9QPNhMCUunW9JRCKueVqk6GUlJxjrtewGr557ApS/1GnTi7pBVnI9OCNXWeQikCGTVGriptiportaBWIhNdDCjOMLHSpYkvCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=WX3C1GeV; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WX3C1GeV"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e88e4c8500so1359363b3a.2
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Mar 2024 20:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1711681358; x=1712286158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+8LIgarHXGmSLHXoyWS+pqzvYLXPMse1ux2PzNUEQYk=;
        b=WX3C1GeVl7D8DPbU/mFwbGv3c/G+WTNny4V3rQmSwBeFaUVJJhXsdWnXaP1fhFMiQ4
         vee+ofIse7rxwLhbixtj2NFpgfkDvunam8PvS5wonbdbxNyjTndTSFzeWF+GjY0c132Z
         iz5xa1krPtVEJdwOSaDYdF5JiKa3ZvvcuhshPmHRx1S/+6FUWQcYa9Fuy/06r3mIM87E
         JlITHhzbyB2cIGE9CkZka9sgecBQNKdQ4OzArGBzzJjEr954BJ52U/JuxsaxOO//qIB0
         45I+Ikbt2MhSC3oQyvMASpDCgroMp1RD4uMlyIEFz10GgXNtd2KSMnKzynzPhVSyrLf/
         Kx0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711681358; x=1712286158;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+8LIgarHXGmSLHXoyWS+pqzvYLXPMse1ux2PzNUEQYk=;
        b=Uz+h2qgSstyO4GyK1XP5/2iIQ55lyL/xLIV+yEMH9QfH4aaTqiFtFO+CHN/3vBCW10
         wcfXKDANKQwx+PWz9iETec4WuRyPglEuRMYx0jfCmw3iUtBYOZoQv6ZfR04I5+LVEuZz
         Bym8LR6r0dgjBeymXiv3CTFTiqadEd1gMxymbUzolpJlH0AA3LzPLCWGFxK6C1oUsaYu
         xcww5TN0RxuTbSH4+/seXlsE0Vd3GVTKRT/+lT3AyIK4Bez3e4O5LKxZuot2R33BBPy5
         H/heGfPQm3bXUEe0wI36Gs0rOzVm6ptWsSfZFLUiEWACGB+vmcnDFKcHaOBRxlnj+CdM
         5B4g==
X-Forwarded-Encrypted: i=1; AJvYcCVtz1mo3M9NyfK8nPYMDFZyOjE6xR1IkJH6Yl/ksxCIBK/RI/5T/e4rlD2I3Q5W03/TZ8/IraE/wHUB7lOmagCSOl+G5BOz+46c982qE4MdEw==
X-Gm-Message-State: AOJu0Ywfb+RXFzcaZr1EzVqyn/NmOIHV9XJssvhAcfBnac+pWJVrhMWg
	L0jryhc63w4oztfs6a3iKia/SCXoXTzV7buJ9bNoh+aaLWxHnzGKQdf0zAkQctQ=
X-Google-Smtp-Source: AGHT+IGHoYNfZbCBVG7PgWNIFZQrRb/CeyOLMx44grXw1IR4U9Ffs88bDVeL3pqpVUKoN+EVskMBbA==
X-Received: by 2002:a05:6a20:12ca:b0:1a5:6cc3:8fc9 with SMTP id v10-20020a056a2012ca00b001a56cc38fc9mr1088026pzg.43.1711681358140;
        Thu, 28 Mar 2024 20:02:38 -0700 (PDT)
Received: from [10.70.146.105] ([203.208.189.8])
        by smtp.gmail.com with ESMTPSA id u7-20020a170902e80700b001dda32430b3sm2401890plg.89.2024.03.28.20.02.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 20:02:37 -0700 (PDT)
Message-ID: <2e44ae50-d4af-4788-9274-aaf345bac066@bytedance.com>
Date: Fri, 29 Mar 2024 11:02:33 +0800
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
To: Ian Rogers <irogers@google.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, james.clark@arm.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240328055857.383180-1-yangjihong@bytedance.com>
 <CAP-5=fXms1noWT8PXqBu89QogcwVsvAGpxq3Q_bNUYOYL7PpKA@mail.gmail.com>
From: Yang Jihong <yangjihong@bytedance.com>
In-Reply-To: <CAP-5=fXms1noWT8PXqBu89QogcwVsvAGpxq3Q_bNUYOYL7PpKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

Sorry, due to the new email settings, the last reply email was in html 
format, resend it now.

On 3/29/24 00:02, Ian Rogers wrote:
> On Wed, Mar 27, 2024 at 10:59 PM Yang Jihong <yangjihong@bytedance.com> wrote:
>>
>> When perf-sched enables the call-graph recording, sample_type of dummy
>> event does not have PERF_SAMPLE_CALLCHAIN, timehist_check_attr() checks
>> that the evsel does not have a callchain, and set show_callchain to 0.
>>
>> Currently perf sched timehist only saves callchain when processing
>> sched:sched_switch event, timehist_check_attr() only needs to determine
>> whether the event has PERF_SAMPLE_CALLCHAIN.
>>
>> Before:
>>    # perf sched record -g true
>>    [ perf record: Woken up 0 times to write data ]
>>    [ perf record: Captured and wrote 4.153 MB perf.data (7536 samples) ]
>>    # perf sched timehist
>>    Samples do not have callchains.
>>               time    cpu  task name                       wait time  sch delay   run time
>>                            [tid/pid]                          (msec)     (msec)     (msec)
>>    --------------- ------  ------------------------------  ---------  ---------  ---------
>>      147851.826019 [0000]  perf[285035]                        0.000      0.000      0.000
>>      147851.826029 [0000]  migration/0[15]                     0.000      0.003      0.009
>>      147851.826063 [0001]  perf[285035]                        0.000      0.000      0.000
>>      147851.826069 [0001]  migration/1[21]                     0.000      0.003      0.006
>>    <SNIP>
>>
>> After:
>>    # perf sched record -g true
>>    [ perf record: Woken up 1 times to write data ]
>>    [ perf record: Captured and wrote 2.572 MB perf.data (822 samples) ]
>>    # perf sched timehist
>>               time    cpu  task name                       wait time  sch delay   run time
>>                            [tid/pid]                          (msec)     (msec)     (msec)
>>    --------------- ------  ------------------------------  ---------  ---------  ---------
>>      144193.035164 [0000]  perf[277062]                        0.000      0.000      0.000    __traceiter_sched_switch <- __traceiter_sched_switch <- __sched_text_start <- preempt_schedule_common <- __cond_resched <- __wait_for_common <- wait_for_completion
>>      144193.035174 [0000]  migration/0[15]                     0.000      0.003      0.009    __traceiter_sched_switch <- __traceiter_sched_switch <- __sched_text_start <- smpboot_thread_fn <- kthread <- ret_from_fork
>>      144193.035207 [0001]  perf[277062]                        0.000      0.000      0.000    __traceiter_sched_switch <- __traceiter_sched_switch <- __sched_text_start <- preempt_schedule_common <- __cond_resched <- __wait_for_common <- wait_for_completion
>>      144193.035214 [0001]  migration/1[21]                     0.000      0.003      0.007    __traceiter_sched_switch <- __traceiter_sched_switch <- __sched_text_start <- smpboot_thread_fn <- kthread <- ret_from_fork
>> <SNIP>
> 
> This looks good, should there be a Fixes tag for the sake of backports?
> 
The direct cause is commit 9c95e4ef0657 ("perf evlist: Add 
evlist__findnew_tracking_event() helper"). perf-record uses 
evlist__add_aux_dummy() to replace evlist__add_dummy() to add a dummy 
event. The difference is that evlist__add_aux_dummy() sets 
no_aux_samples to true (this is expected behavior, for dummy event, no 
need to sample aux data), resulting in evsel__config() not adding the 
PERF_SAMPLE_CALLCHAIN bit to dummy's sample_type.

In summary, the direct cause is the problem introduced by commit 
9c95e4ef0657 ("perf evlist: Add evlist__findnew_tracking_event() 
helper"), but the root cause is the timehist_check_attr() logic problem, 
The dummy event itself does not need to have PERF_SAMPLE_CALLCHAIN, so 
there is no need to check it.


So, maybe add fixes-tag:

Fixes: 9c95e4ef0657 ("perf evlist: Add evlist__findnew_tracking_event() 
helper")

If it is ok, I will send v2 version with this fixes-tag.

Thanks,
Yang
