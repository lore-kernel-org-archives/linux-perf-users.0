Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D008648094C
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 18:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789408821; cv=none; b=tcw9P/BaqQCNRP/A3jrtfo/Im6j+4Nsf3VdZeCy79YYPDBQqUSCXUGUKj3cCQSyA31U8c8kQrNkYL8H1W48dfwKzDQT2Gwn+iqI93pCTIhRvz1pgs65/jzlV22ALgQL3viG7I7tdUsEO05S0OWfD1z0lOQ+XjRlFKRTkZaC9H2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789408821; c=relaxed/simple;
	bh=qeiKkvM/JBbWPuPMMZkL8KYFGuhmrLgqUEcynuKHgP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bbL6vx5VaEvZ+ToSvjQ8ZLw9yd5N2sI8OW0rUFiBFCVi7LyFwURe7AJIbfDEMQ0VoRXREPyjwkivCOeojkDkIhCtPmh1BWiCw+XLxW4730IfiYC4DGzdVl82QTrXoSthVwDwTlJjSDOIQoJ3t9QXM5uY1Zarz8wB4WX8Fzp2E+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOfYZVCo; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOfYZVCo"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d822dso16680455e9.2
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 11:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789408818; x=1790013618; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iHylgiq6Hw45XeJjiAM6W7UpYZE6n5TpqZQfLbbi4pU=;
        b=YOfYZVCoxNsn9Qh8C4rUsDXSUoy6mEyl9nyhUNhxUDyBjJPQAtY+rSQjnHOfL0nQ2j
         rJO8Rw7X3cTGfXAS0VM0HscsK1XDSpKPnBlGyTmCUbqN3fC0mfhjcSiVJMuubBrIPSkW
         zO0o70xgYNvmsneR2UuW831dT3rzB78+ihLsZjbmU/ZOrXrdUnv/5olWtGaCMRSPzO8d
         XRGX3ouvhZbUlBtsqgh/G97MAnlXH1IEa7e61PKpEG7QNg4tOgVN378QDT6anSHMgtui
         smpsNJfZ/uR+7BmvdSYyP1euEQh7nKmdYUpVB6P52ImGgF3cqL6XlcMBxOE/n6L20b5y
         PCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789408818; x=1790013618;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iHylgiq6Hw45XeJjiAM6W7UpYZE6n5TpqZQfLbbi4pU=;
        b=TTd/BwitzeZ7kbNu3be+97J+6T4urcp+gCkg/Io+BJlSnnqhutN9TcvzjuHxl8wey3
         zD4Q+QqN7YH5HZD8Lo3w9/uz6HVN3p0AqKbCWd2Q9D+B2J9wHLl3PXWx6C4A+pU2rFZW
         0c+jTKYk/aulR+FBmKwbVH80eh65AF1cU1nDRL+IoJ2iWJr+QDXLlAcbJgufvnsq/Ksj
         sLkV2X/Y8fswB+gl28+mVgNYXKW/PQpd3lBuIROCubYzFWh7JvoN0qXuyH31VQKHnvkl
         +Fp7Zg7XfhHD9h6Hyb9/SNlrxPgWTjzVz218VasgNyb4M/yBQafqfRd3u9acJpK3G76k
         PzGA==
X-Forwarded-Encrypted: i=1; AKwUvBxhn57yXf95DNHFeLWPKHWj31qIG099fZnoS7H3SkEru8L+b96QWNTTv38BnWfd8jBw5Pap2r2zdbsc4mqr9/2E@vger.kernel.org
X-Gm-Message-State: AFuF++ltMSTzUl8JwpG9lSBDLMSM5en1geEzFDn6FLALzewwmQoQneVH
	1VhzTo7rIMdk29+ubiblSGL4er6Lk9tj8wluL66XMLCrXU5TRk7H1Yy/
X-Gm-Gg: AYBFou0azjGrB+YJq8wZDYnqrbhK0RqwpsxysINLP9Bp9y/P48slk5kw9RYegXVFJVl
	gVJ7Rl/48weBg66VGZ5p0WxKpZr0ufTyv6e/JICpE6geVp5iVcMenunXLTPgXYrFGQ8WvWig8Zk
	5DuSt1Hl/o4XmflnxC7OvniPK6d8l37pCR5yB4G3UTM1NxoVRz7/htjNYgVfYUYstY+EZAqQGVU
	Ch6lA8bbIxn20j98xOsgTrLz9kuQTbb3bEmPlU4VBZeps43Wu1g08RKWxWXkacuz6vFDNuHxjbm
	h0HNqZe5igp0LNee5/+7sRUAh7gzsWyYj2n7K0DP4IciVg6hy5Sf9eAmM0nVciFClzIT2YGt7XQ
	HoFkAi6j9bFk2Ecf/xIO4DTJjgbggyIs9XSDKe9dbNTpr0dy+w7JSdQ4YCPMYoeuUu6CaMPBQ3x
	yVU98YOOA8GMNW0Lv2In8GtY24ODv0PgExgnT2nRYcws/BZG14syhcjFlECWeTs4b1nk1f+J+K5
	SSZ3YHS6l40MRiEA+nKgszmmC4nMX8tA0U=
X-Received: by 2002:a05:600c:4f0c:b0:49c:d019:70c5 with SMTP id 5b1f17b1804b1-49e7a5f2dddmr52232375e9.0.1789408817604;
        Mon, 14 Sep 2026 11:00:17 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:37f5:891d:1d21:b3d3? ([2620:10d:c092:500::7:35f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7d66e77csm9313975e9.5.2026.09.14.11.00.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 11:00:17 -0700 (PDT)
Message-ID: <031948ac-13d1-46e7-aafa-16d3323e2aa3@gmail.com>
Date: Mon, 14 Sep 2026 19:00:16 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/3] bpftool: Track perf counter snapshot
 state
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com,
 memxor@gmail.com, qmo@kernel.org, linux-perf-users@vger.kernel.org,
 acme@kernel.org, namhyung@kernel.org, Mykyta Yatsenko <yatsenko@meta.com>
References: <20260908-bpftool_cyles_per_run-v3-0-60e86f325c35@meta.com>
 <20260908-bpftool_cyles_per_run-v3-1-60e86f325c35@meta.com>
 <CAEf4Bza_4ihFJyOJrJKRpiCvU3Mr6KXLVM+5fYnmb9ydNELOJA@mail.gmail.com>
 <74544b6e-205f-4878-8d7a-d27fac7bd946@gmail.com>
 <CAEf4BzYhMGP5Bcj-qnyTqLAXnZDs3JGsVqVg+-XB9pqEvNKfjA@mail.gmail.com>
 <123fb2fb-8342-439c-8a9f-c5d27fb6e323@gmail.com>
 <CAEf4BzYVceGdJcM_TS_odTgG=L9c2YvsDRW-dic+G9RrCwDTPg@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAEf4BzYVceGdJcM_TS_odTgG=L9c2YvsDRW-dic+G9RrCwDTPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/14/26 4:57 PM, Andrii Nakryiko wrote:
> On Mon, Sep 14, 2026 at 4:59 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>>
>>
>>
>> On 9/12/26 12:57 AM, Andrii Nakryiko wrote:
>>> On Wed, Sep 9, 2026 at 2:19 AM Mykyta Yatsenko
>>> <mykyta.yatsenko5@gmail.com> wrote:
>>>>
>>>> On 9/9/26 12:56 AM, Andrii Nakryiko wrote:
>>>>> On Tue, Sep 8, 2026 at 7:27 AM Mykyta Yatsenko
>>>>> <mykyta.yatsenko5@gmail.com> wrote:
>>>>>>
>>>>>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>>>>>
>>>>>> A perf counter can be zero at fentry. PMU multiplexing can schedule the
>>>>>> event during the BPF program. The old counter check then drops a valid
>>>>>> sample.
>>>>>>
>>>>>> Use an armed flag to track each successful fentry snapshot. Reset all
>>>>>> flags before new reads. The fexit path clears each flag when it consumes
>>>>>> the snapshot.
>>>>>>
>>>>>> Fixes: 47c09d6a9f67 ("bpftool: Introduce "prog profile" command")
>>>>>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>>>>>> ---
>>>>>>  tools/bpf/bpftool/skeleton/profiler.bpf.c | 25 +++++++++++++++++--------
>>>>>>  1 file changed, 17 insertions(+), 8 deletions(-)
>>>>>>
>>>>>> diff --git a/tools/bpf/bpftool/skeleton/profiler.bpf.c b/tools/bpf/bpftool/skeleton/profiler.bpf.c
>>>>>> index f48c783cb9f7..6c654bd9b346 100644
>>>>>> --- a/tools/bpf/bpftool/skeleton/profiler.bpf.c
>>>>>> +++ b/tools/bpf/bpftool/skeleton/profiler.bpf.c
>>>>>> @@ -10,6 +10,11 @@ struct bpf_perf_event_value___local {
>>>>>>         __u64 running;
>>>>>>  } __attribute__((preserve_access_index));
>>>>>>
>>>>>> +struct profile_reading {
>>>>>> +       struct bpf_perf_event_value___local value;
>>>>>> +       bool armed;
>>>>>> +};
>>>>>> +
>>>>>>  /* map of perf event fds, num_cpu * num_metric entries */
>>>>>>  struct {
>>>>>>         __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
>>>>>> @@ -21,7 +26,7 @@ struct {
>>>>>>  struct {
>>>>>>         __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
>>>>>>         __uint(key_size, sizeof(u32));
>>>>>> -       __uint(value_size, sizeof(struct bpf_perf_event_value___local));
>>>>>
>>>>> this is not a bug, but... ;)
>>>>>
>>>>>
>>>>> struct bpf_perf_event_value is UAPI, why do we need CO-RE-relocatable
>>>>> ___local variant?...
>>>>>
>>>>>
>>>>>> +       __uint(value_size, sizeof(struct profile_reading));
>>>>>>  } fentry_readings SEC(".maps");
>>>>>>
>>>>>>  /* accumulated readings */
>>>>>> @@ -45,7 +50,7 @@ const volatile __u32 num_metric = 1;
>>>>>>  SEC("fentry/XXX")
>>>>>>  int BPF_PROG(fentry_XXX)
>>>>>>  {
>>>>>> -       struct bpf_perf_event_value___local *ptrs[MAX_NUM_METRICS];
>>>>>> +       struct profile_reading *ptrs[MAX_NUM_METRICS];
>>>>>>         u32 key = bpf_get_smp_processor_id();
>>>>>>         u32 i;
>>>>>>
>>>>>> @@ -56,6 +61,7 @@ int BPF_PROG(fentry_XXX)
>>>>>>                 ptrs[i] = bpf_map_lookup_elem(&fentry_readings, &flag);
>>>>>>                 if (!ptrs[i])
>>>>>>                         return 0;
>>>>>> +               ptrs[i]->armed = false;
>>>>>>         }
>>>>>
>>>>> this is preexisting, but why do we have two separate loops: first
>>>>> lookup up fentry_readings pointers, and then separately a) reading
>>>>> perf counters into local variable just to b) immediately copy it into
>>>>> map_value.
>>>>>
>>>>> can you try simplifying this and doing bpf_perf_event_read_value()
>>>>> into ptrs[i] directly? all within the same loop?
>>>>>
>>>>> it might have been some verifier issue, not sure, but I think this
>>>>> should work just fine
>>>
>>> you haven't answered this
>>>
>>
>> Yes, I can try this, but should we care to support those older kernels
>> in case someone tries fresh bpftool on old verifier?
>>
> 
> did you check that this logic will not verify on older kernels?
> 
no, if you are ok with the change, I'll do it in the next version.>>>>>
>>>>>>
>>>>>>         for (i = 0; i < num_metric && i < MAX_NUM_METRICS; i++) {
>>>>>> @@ -66,7 +72,8 @@ int BPF_PROG(fentry_XXX)
>>>>>>                                                 sizeof(reading));
>>>>>>                 if (err)
>>>>>>                         return 0;
>>>>>> -               *(ptrs[i]) = reading;
>>>>>> +               ptrs[i]->value = reading;
>>>>>> +               ptrs[i]->armed = true;
>>>>>>                 key += num_cpu;
>>>>>>         }
>>>>>>
>>>>>> @@ -76,16 +83,18 @@ int BPF_PROG(fentry_XXX)
>>>>>>  static inline void
>>>>>>  fexit_update_maps(u32 id, struct bpf_perf_event_value___local *after)
>>>>>>  {
>>>>>> -       struct bpf_perf_event_value___local *before, diff;
>>>>>> +       struct profile_reading *before;
>>>>>> +       struct bpf_perf_event_value___local diff;
>>>>>>
>>>>>>         before = bpf_map_lookup_elem(&fentry_readings, &id);
>>>>>>         /* only account samples with a valid fentry_reading */
>>>>>> -       if (before && before->counter) {
>>>>>> +       if (before && before->armed) {
>>>>>
>>>>> this is such an unlikely situation that I wouldn't even bother
>>>>> "fixing" it, tbh. alternatively we can check enabled or running for
>>>>> zero, I don't think realistically enabled can be zero if we actually
>>>>> captured it an fentry
>>>>
>>>> Here we check before->counter for 0, substituting by enabled or running
>>>> will still have the same risk of dropping the first sample.
>>>>
>>>> I could reproduce it by:
>>>> 1. make PMU busy with 4 events to force multiplexing
>>>> 2. then quick profile for 1 second
>>>> Result: first sample gets dropped, because measurement
>>>> at fentry is 0. This is not a huge deal by itself, but the fix is simple enough,
>>>> in my opinion, to make it worth. For a pocket change we get clearer flow:
>>>> fentry arms the counter, fexit disarms it.
>>>> We have the same code in perf, I thought it would be nice to have this change
>>>> there (more choice of sparse events, subsecond timeouts possible)
>>>>>
>>>
>>> are you saying that you get zero even for before->enabled?
>>>
>>
>> yes, for sparse events like itlb misses + PMU contention
>> that can happen.
>> for example log from one of the runs:
>> bpf_trace_printk: counter: 0, enabled: 29431875, running: 13638505
>> bpf_trace_printk: counter: 0, enabled: 60395630, running: 30502953
>> bpf_trace_printk: counter: 0, enabled: 60608030, running: 30502953
>> bpf_trace_printk: counter: 0, enabled: 5609314, running: 0
> 
> But enabled doesn't, see? I keep forgetting which of enabled/running
> means "PMU event would like to be active" (that seems to be "enabled"
> judging by this output you shared) and which one is "PMU event was
> actually active", but the one with "would like to be active" should
> never be zero after activation, so why not use that instead of adding
> extra layer of armed/unarmed?
> 

yes, agree, checking for enabled should fix dropping 0 counters.

>> bpf_trace_printk: counter: 0, enabled: 5918970, running: 382474
>> bpf_trace_printk: counter: 0, enabled: 6243798, running: 542435
>> bpf_trace_printk: counter: 0, enabled: 6623769, running: 1087273
>> bpf_trace_printk: counter: 0, enabled: 7078241, running: 1376878
>> bpf_trace_printk: counter: 0, enabled: 7326934, running: 1625571
>> bpf_trace_printk: counter: 0, enabled: 7440054, running: 1738691
>>
>>>>> pw-bot: cr
>>>>>
>>>>>
>>>>>>                 struct bpf_perf_event_value___local *accum;
>>>>>>
>>>>>> -               diff.counter = after->counter - before->counter;
>>>>>> -               diff.enabled = after->enabled - before->enabled;
>>>>>> -               diff.running = after->running - before->running;
>>>>>> +               before->armed = false;
>>>>>> +               diff.counter = after->counter - before->value.counter;
>>>>>> +               diff.enabled = after->enabled - before->value.enabled;
>>>>>> +               diff.running = after->running - before->value.running;
>>>>>>
>>>>>>                 accum = bpf_map_lookup_elem(&accum_readings, &id);
>>>>>>                 if (accum) {
>>>>>>
>>>>>> --
>>>>>> 2.53.0-Meta
>>>>>>
>>>>
>>

