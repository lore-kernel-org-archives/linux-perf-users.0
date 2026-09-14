Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DAD45C6E5
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 11:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789387203; cv=none; b=LiFc+XNMmbwqAf/EohM8ax4Pe3M5Z5xRUiZm/RPOzgwmqsCGF+TlyJ+YSU8uajuVEkP/J0uxtgOmnAK2UAqSTtUTLtYZHm1e5q8B1HI24Q1Mea8OM3FqKznFQwcii8WQiJN1Pu15gSmEiIWWezxMUTYSHNK6vUEJb1Qh5SnXTJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789387203; c=relaxed/simple;
	bh=A10D0NZw3RFvU9sAwBciZM8nUIdNfoZYYMeX2y6NBj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gJwHcXBSgCspjsEEUqoj8WUFFFJwA7i4w+mULy69qmMpid47oO5CdN1YDYJxGJRgweUWlKU5CLu2RrYjVSp6DwIV8GxdCwglMlo1r71baXsvqz5F/BuqtaG0sWDoainatCumYLt0T0gfkbMFOSJVMidlqx4piQOnD208DNfmViE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ak6Uch9+; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ak6Uch9+"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-485850cbac3so1699340f8f.3
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 04:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789387183; x=1789991983; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CKGEBXocfkP1cYm0xLoNtz8l8ywke8IK/b2q2YtiWKg=;
        b=ak6Uch9+Op5Z4TK6F4Njw4mJBE6yY9iWdb1fMwbigHcwVLOsZxMRSeITI/974UUk55
         3p1n7FuSe17HmZX6jqQkuXPrqw/nyen8Z8LQezwl/SCgeD53aXiQJnxPxqM+pEAbXFmQ
         BYzHgIXL5m5qfB65StM7KELToNgVuZdo1vkQuTDfWEiHDx9YUxSktgioqCzkQfG6DUxk
         CJpzWLdJZ1XV33yMUsqmEiuuEvrObhIz39vE+hcoxrX3CqttDUeczTNzhq9sjA2BYB8q
         9+0THkDrJdnv9wiJn8qPSzjqn0uJDR21meeSmkPzrjFZ0OjGvaR3vNBuK7Yz3JkFNGor
         Tz2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789387183; x=1789991983;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CKGEBXocfkP1cYm0xLoNtz8l8ywke8IK/b2q2YtiWKg=;
        b=OiNB0x+UOtM96hBOP9k6xYVh0HyMCotNsAXbHOModlVeCYPI2duUJSj5TYQLelp2kR
         9rYUDi8maNfZO/hWEm9YZkLV+AK7GXcd39vCBeP1aYI7sG+5c9qu5gf3Yapt8ZaFYoL/
         jYkm0Mavm5bgqCNx62itjxdtC0/1biahGM8aCzFYJawL7UY+gGj+8OwzQ6PaiFkMrtCA
         nS/TPcQ/WRVPxLQPAA5/NCQuaBCG6tVSqgtqGsy1mXEi/FbNVXNm3dIBV6D7WIiArrd7
         uA04di9hgUHE6vR+yUPmZV5jgN5oF0DibmF2fDyF7+5kSZDPl6hQyqbpdAFfsiCCZ6oX
         WOYw==
X-Forwarded-Encrypted: i=1; AKwUvByXm9XmSAse7GErQfVn1KqBOWsuRucDyclBF9x9G+oy5Z8JZ67ygugdKX6kW6ifaui7XOktqGXdWH9Xz69eEQnV@vger.kernel.org
X-Gm-Message-State: AFuF++nYUsxju5lLPEa7uEBiVgZp4LJjT3M52szcJmCVNlc2MjVI58QI
	pPZBGvPGkPE2eo//w7ct1Ssp6+DviZs1qPHD4D3ziFrKbOH5W2e/3YFy
X-Gm-Gg: AYBFou3x2j1pHvBvaah3fRLRt3MHpcnuCX70Q7g9eHlfAHIyVWEuth5Ei9maLLSnhLi
	45CmbC3+5IqsJ1RK16uTHyD7Z1nAtmbAelUuMgTe7g48pwhs/8EsUr2ZRqFk0kPpNNSGAmx1RhA
	/jicpsU5pK1bsK/VNVI7b8a3xKqC1ysOCx7y3VDm0/7NWTAsBsUBbpCAZL3PPrefUqOgKY8GdgC
	TfEppxVd47Zer4s9hR8HCwNzv7VZhDbdpiT2VnYXWG9W0gAo+2OC+RtvuS0xyRLvef0Gf5IDsuH
	wjkxO9Rnf5fDPD4YX0WxqSSHX4FDBUqqXcM/P7Y019PIvxZJbEF6vWdp68MjVebu+U2X3KT73gQ
	SN+sLYzZK0xF2PsPZG2gCC2SfzflwHHvhj0G+So0AuRjbssL1fi4OTDYFSkrlaCQOnxQhun1pFS
	nYdrm4puo3/eQUGQJNeH8ODATU2AGqQ2Bvbxte1DNFdyqT6Z0D+j4CtEy7wH3ZtDXQFYRaLU7n9
	HiFMye9VjEiSkD/YqMR9puNY4Z5xig2QpgOnIfgzWJIFw==
X-Received: by 2002:a05:600c:190d:b0:49e:7a00:b9a5 with SMTP id 5b1f17b1804b1-49e7a63a894mr28181985e9.4.1789387183142;
        Mon, 14 Sep 2026 04:59:43 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:37f5:891d:1d21:b3d3? ([2620:10d:c092:500::7:35f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e63c9a7c9sm523350055e9.13.2026.09.14.04.59.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 04:59:42 -0700 (PDT)
Message-ID: <123fb2fb-8342-439c-8a9f-c5d27fb6e323@gmail.com>
Date: Mon, 14 Sep 2026 12:59:41 +0100
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
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAEf4BzYhMGP5Bcj-qnyTqLAXnZDs3JGsVqVg+-XB9pqEvNKfjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/12/26 12:57 AM, Andrii Nakryiko wrote:
> On Wed, Sep 9, 2026 at 2:19 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>>
>> On 9/9/26 12:56 AM, Andrii Nakryiko wrote:
>>> On Tue, Sep 8, 2026 at 7:27 AM Mykyta Yatsenko
>>> <mykyta.yatsenko5@gmail.com> wrote:
>>>>
>>>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>>>
>>>> A perf counter can be zero at fentry. PMU multiplexing can schedule the
>>>> event during the BPF program. The old counter check then drops a valid
>>>> sample.
>>>>
>>>> Use an armed flag to track each successful fentry snapshot. Reset all
>>>> flags before new reads. The fexit path clears each flag when it consumes
>>>> the snapshot.
>>>>
>>>> Fixes: 47c09d6a9f67 ("bpftool: Introduce "prog profile" command")
>>>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>>>> ---
>>>>  tools/bpf/bpftool/skeleton/profiler.bpf.c | 25 +++++++++++++++++--------
>>>>  1 file changed, 17 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/tools/bpf/bpftool/skeleton/profiler.bpf.c b/tools/bpf/bpftool/skeleton/profiler.bpf.c
>>>> index f48c783cb9f7..6c654bd9b346 100644
>>>> --- a/tools/bpf/bpftool/skeleton/profiler.bpf.c
>>>> +++ b/tools/bpf/bpftool/skeleton/profiler.bpf.c
>>>> @@ -10,6 +10,11 @@ struct bpf_perf_event_value___local {
>>>>         __u64 running;
>>>>  } __attribute__((preserve_access_index));
>>>>
>>>> +struct profile_reading {
>>>> +       struct bpf_perf_event_value___local value;
>>>> +       bool armed;
>>>> +};
>>>> +
>>>>  /* map of perf event fds, num_cpu * num_metric entries */
>>>>  struct {
>>>>         __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
>>>> @@ -21,7 +26,7 @@ struct {
>>>>  struct {
>>>>         __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
>>>>         __uint(key_size, sizeof(u32));
>>>> -       __uint(value_size, sizeof(struct bpf_perf_event_value___local));
>>>
>>> this is not a bug, but... ;)
>>>
>>>
>>> struct bpf_perf_event_value is UAPI, why do we need CO-RE-relocatable
>>> ___local variant?...
>>>
>>>
>>>> +       __uint(value_size, sizeof(struct profile_reading));
>>>>  } fentry_readings SEC(".maps");
>>>>
>>>>  /* accumulated readings */
>>>> @@ -45,7 +50,7 @@ const volatile __u32 num_metric = 1;
>>>>  SEC("fentry/XXX")
>>>>  int BPF_PROG(fentry_XXX)
>>>>  {
>>>> -       struct bpf_perf_event_value___local *ptrs[MAX_NUM_METRICS];
>>>> +       struct profile_reading *ptrs[MAX_NUM_METRICS];
>>>>         u32 key = bpf_get_smp_processor_id();
>>>>         u32 i;
>>>>
>>>> @@ -56,6 +61,7 @@ int BPF_PROG(fentry_XXX)
>>>>                 ptrs[i] = bpf_map_lookup_elem(&fentry_readings, &flag);
>>>>                 if (!ptrs[i])
>>>>                         return 0;
>>>> +               ptrs[i]->armed = false;
>>>>         }
>>>
>>> this is preexisting, but why do we have two separate loops: first
>>> lookup up fentry_readings pointers, and then separately a) reading
>>> perf counters into local variable just to b) immediately copy it into
>>> map_value.
>>>
>>> can you try simplifying this and doing bpf_perf_event_read_value()
>>> into ptrs[i] directly? all within the same loop?
>>>
>>> it might have been some verifier issue, not sure, but I think this
>>> should work just fine
> 
> you haven't answered this
> 

Yes, I can try this, but should we care to support those older kernels
in case someone tries fresh bpftool on old verifier?

>>>
>>>>
>>>>         for (i = 0; i < num_metric && i < MAX_NUM_METRICS; i++) {
>>>> @@ -66,7 +72,8 @@ int BPF_PROG(fentry_XXX)
>>>>                                                 sizeof(reading));
>>>>                 if (err)
>>>>                         return 0;
>>>> -               *(ptrs[i]) = reading;
>>>> +               ptrs[i]->value = reading;
>>>> +               ptrs[i]->armed = true;
>>>>                 key += num_cpu;
>>>>         }
>>>>
>>>> @@ -76,16 +83,18 @@ int BPF_PROG(fentry_XXX)
>>>>  static inline void
>>>>  fexit_update_maps(u32 id, struct bpf_perf_event_value___local *after)
>>>>  {
>>>> -       struct bpf_perf_event_value___local *before, diff;
>>>> +       struct profile_reading *before;
>>>> +       struct bpf_perf_event_value___local diff;
>>>>
>>>>         before = bpf_map_lookup_elem(&fentry_readings, &id);
>>>>         /* only account samples with a valid fentry_reading */
>>>> -       if (before && before->counter) {
>>>> +       if (before && before->armed) {
>>>
>>> this is such an unlikely situation that I wouldn't even bother
>>> "fixing" it, tbh. alternatively we can check enabled or running for
>>> zero, I don't think realistically enabled can be zero if we actually
>>> captured it an fentry
>>
>> Here we check before->counter for 0, substituting by enabled or running
>> will still have the same risk of dropping the first sample.
>>
>> I could reproduce it by:
>> 1. make PMU busy with 4 events to force multiplexing
>> 2. then quick profile for 1 second
>> Result: first sample gets dropped, because measurement
>> at fentry is 0. This is not a huge deal by itself, but the fix is simple enough,
>> in my opinion, to make it worth. For a pocket change we get clearer flow:
>> fentry arms the counter, fexit disarms it.
>> We have the same code in perf, I thought it would be nice to have this change
>> there (more choice of sparse events, subsecond timeouts possible)
>>>
> 
> are you saying that you get zero even for before->enabled?
> 

yes, for sparse events like itlb misses + PMU contention 
that can happen.
for example log from one of the runs:
bpf_trace_printk: counter: 0, enabled: 29431875, running: 13638505
bpf_trace_printk: counter: 0, enabled: 60395630, running: 30502953
bpf_trace_printk: counter: 0, enabled: 60608030, running: 30502953
bpf_trace_printk: counter: 0, enabled: 5609314, running: 0
bpf_trace_printk: counter: 0, enabled: 5918970, running: 382474
bpf_trace_printk: counter: 0, enabled: 6243798, running: 542435
bpf_trace_printk: counter: 0, enabled: 6623769, running: 1087273
bpf_trace_printk: counter: 0, enabled: 7078241, running: 1376878
bpf_trace_printk: counter: 0, enabled: 7326934, running: 1625571
bpf_trace_printk: counter: 0, enabled: 7440054, running: 1738691

>>> pw-bot: cr
>>>
>>>
>>>>                 struct bpf_perf_event_value___local *accum;
>>>>
>>>> -               diff.counter = after->counter - before->counter;
>>>> -               diff.enabled = after->enabled - before->enabled;
>>>> -               diff.running = after->running - before->running;
>>>> +               before->armed = false;
>>>> +               diff.counter = after->counter - before->value.counter;
>>>> +               diff.enabled = after->enabled - before->value.enabled;
>>>> +               diff.running = after->running - before->value.running;
>>>>
>>>>                 accum = bpf_map_lookup_elem(&accum_readings, &id);
>>>>                 if (accum) {
>>>>
>>>> --
>>>> 2.53.0-Meta
>>>>
>>

