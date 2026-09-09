Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7696D3BA25F
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Sep 2026 09:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788945580; cv=none; b=thF16Diy7fxgho+upIoZnEWY335srmeZ9KI3bcpIzbIpK1G1RZ+eDNKf71kvF9lQMexUi8K1eNZcgKA6wDD7UdlMFcDPP/54d4fPJIhOD2/iPv1Fgwr/3/XFg4eFFLugpXE9mDKVgE3lMTJed98CRfQMmJnohRK1QWdc+bTWfNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788945580; c=relaxed/simple;
	bh=AANUG2Fkiony31zysc7K1vyEm4d3ES6no5aVP8yMNjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k8BmCIA7kACr5ov93Uh9PYRjUUmRT/ew3NWH8ZEUHNh2uq0DmIkiGyirbOtnExTabmMGagsySnFy6HBFBjvBhSrRHOpUd/UvQMkh4eg8sH5c03n6daE32Ozworzkmu8JL7ggjkyEmJR0hm1OjPajCgMtH0cMgJSqQCyELWcTpAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfSMsm/3; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfSMsm/3"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49b9320423cso63639585e9.0
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Sep 2026 02:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788945574; x=1789550374; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+AHDOad1N4UeccxVypy7aIabm5nwKXZpXx1x5dAIbqI=;
        b=HfSMsm/3XsP9U0nAMZX6G4DzBWSdqtSqWUIm0eQNj8cHdqR/aVc35mgDd25bNBXXt2
         7RKzrO/h/irf11PAn8kL5s6l2mBwoOJUuL8mkkw2/OEDxgrmw4MutveXnvRH8/SlCDqD
         OBPgKEnrh84YOL03jymR+XjvOUCpe1p/RdyrsesVAGyhHqXiawzyapDLJrjg0Ud1K0Hw
         KzMgliRVV0lAYal7kkLqvrG2hvaEe5GssaXFzuulSYWKjkdf2TGx3IbXkxDsTxLQpcWU
         6+5vur2o+Y/8bWhdRNiGLjGahFaXxtS+E5RgY+nxrySkKkqTfrN9tJovyWt7hTgwxN35
         oZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788945574; x=1789550374;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+AHDOad1N4UeccxVypy7aIabm5nwKXZpXx1x5dAIbqI=;
        b=Wv9ueAh1wFRcXA8cSR8+n8a4O3KuCU9idcjoZCnWMixHHRMfbSWPdV46mdON++71Li
         IwZjwlEAzY7KehKWFhFW2DCwZlYCpZkW4r5fCCUt8Diqq5HJ3mFDiyGQF0TjumIM7SQ8
         V/uNSrt8z6VX7/7nXFbNHBxamNtHTViIXAE/WBSjrNAT1MDBkhoEqazWDHVHLBdD/hx9
         ehYqeteYgz9NPUok1V62xWQHx4viqzRVzcCTa50xHEDAm06WI3ZN7fDSWHTLEG9RXc4h
         JGmczVOGxx08MWxJ8ZWrwOBjDNEmg3IcUVXlKx6SerUlwQ+PTvHazb1YcriHLaY63Hsq
         w1jw==
X-Forwarded-Encrypted: i=1; AKwUvBw9h7HwjNs2r05z/tOcSC6zhgdtaFu/sOUTuDC+ovkNrZDv896u8lMW63Iqq6LeFYxuj6lhRGLxqs+Chmc57cqu@vger.kernel.org
X-Gm-Message-State: AFuF++l/QAicEZ5DNWaWmlJNC4lsls1c6QYLNMJgerCp4d0xwNDpw5uO
	vZZp/hV0ShC3JcB6Ws8AC3GbxW/uidjWHGtkFaNP2k3Ppuy9YRTaONcs
X-Gm-Gg: AYBFou10ydOBFLa7TnXZXksjJwuB3MqZJ+FioLk1/2jSHmwpjMm87FzyYcx5N8qYyH5
	tldRUZl8GtEGHXwFdR0XClhcrJDEkZI1lJevLis+ho61IFZkbO+l2yG/MoPNWJqAmue6z3OdB52
	JUphmo95Rk7Wx+llhDRDLZWPm2/ETnhw7433WqPEl5sbStG7nGEg+1UZ2nCMOncfcAAlEhi8o91
	jcBksrdUmUiERl1e1gY53+Kkvr0jSEkOW52QHjnsWS8k4ZX6n6mrYevS4vz2FGON7BAXXLrGG9U
	GOa3ykHsZjRHsU6U30k1ibTeYEVDHbdnI0I+LxtGXej/OPvhdQHOTNxQw4B7zIL6BzFkifjT+DP
	Oq8oCpvBnqkRWs0TFjpdTLqRLi7Hjnfs2hjmYVhRu6h53fOsY1dbLmtkshRiKhvBt6Z37eYGz2Z
	eahRdVZgR+3IMeubSYhK3DAWjdH3Blmlk4zgcabECUpw9p4VqFnJZfmcSi0CLEqDoMQvxLA5iBE
	RmpiIx5eWSm9Pd5uQ9+7qc95qMM4tQyFBv0SLMp0fSzKUThRNeRJhlWpNE=
X-Received: by 2002:a05:600c:4e94:b0:498:943:ccc0 with SMTP id 5b1f17b1804b1-49cf81e368emr593719355e9.6.1788945573356;
        Wed, 09 Sep 2026 02:19:33 -0700 (PDT)
Received: from ?IPV6:2a02:8109:a307:d900:dabd:d9e2:64b7:dfc3? ([2a02:8109:a307:d900:dabd:d9e2:64b7:dfc3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d07b371afsm373554075e9.9.2026.09.09.02.19.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 02:19:32 -0700 (PDT)
Message-ID: <74544b6e-205f-4878-8d7a-d27fac7bd946@gmail.com>
Date: Wed, 9 Sep 2026 10:19:31 +0100
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
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAEf4Bza_4ihFJyOJrJKRpiCvU3Mr6KXLVM+5fYnmb9ydNELOJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/9/26 12:56 AM, Andrii Nakryiko wrote:
> On Tue, Sep 8, 2026 at 7:27 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>>
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> A perf counter can be zero at fentry. PMU multiplexing can schedule the
>> event during the BPF program. The old counter check then drops a valid
>> sample.
>>
>> Use an armed flag to track each successful fentry snapshot. Reset all
>> flags before new reads. The fexit path clears each flag when it consumes
>> the snapshot.
>>
>> Fixes: 47c09d6a9f67 ("bpftool: Introduce "prog profile" command")
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>  tools/bpf/bpftool/skeleton/profiler.bpf.c | 25 +++++++++++++++++--------
>>  1 file changed, 17 insertions(+), 8 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/skeleton/profiler.bpf.c b/tools/bpf/bpftool/skeleton/profiler.bpf.c
>> index f48c783cb9f7..6c654bd9b346 100644
>> --- a/tools/bpf/bpftool/skeleton/profiler.bpf.c
>> +++ b/tools/bpf/bpftool/skeleton/profiler.bpf.c
>> @@ -10,6 +10,11 @@ struct bpf_perf_event_value___local {
>>         __u64 running;
>>  } __attribute__((preserve_access_index));
>>
>> +struct profile_reading {
>> +       struct bpf_perf_event_value___local value;
>> +       bool armed;
>> +};
>> +
>>  /* map of perf event fds, num_cpu * num_metric entries */
>>  struct {
>>         __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
>> @@ -21,7 +26,7 @@ struct {
>>  struct {
>>         __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
>>         __uint(key_size, sizeof(u32));
>> -       __uint(value_size, sizeof(struct bpf_perf_event_value___local));
> 
> this is not a bug, but... ;)
> 
> 
> struct bpf_perf_event_value is UAPI, why do we need CO-RE-relocatable
> ___local variant?...
> 
> 
>> +       __uint(value_size, sizeof(struct profile_reading));
>>  } fentry_readings SEC(".maps");
>>
>>  /* accumulated readings */
>> @@ -45,7 +50,7 @@ const volatile __u32 num_metric = 1;
>>  SEC("fentry/XXX")
>>  int BPF_PROG(fentry_XXX)
>>  {
>> -       struct bpf_perf_event_value___local *ptrs[MAX_NUM_METRICS];
>> +       struct profile_reading *ptrs[MAX_NUM_METRICS];
>>         u32 key = bpf_get_smp_processor_id();
>>         u32 i;
>>
>> @@ -56,6 +61,7 @@ int BPF_PROG(fentry_XXX)
>>                 ptrs[i] = bpf_map_lookup_elem(&fentry_readings, &flag);
>>                 if (!ptrs[i])
>>                         return 0;
>> +               ptrs[i]->armed = false;
>>         }
> 
> this is preexisting, but why do we have two separate loops: first
> lookup up fentry_readings pointers, and then separately a) reading
> perf counters into local variable just to b) immediately copy it into
> map_value.
> 
> can you try simplifying this and doing bpf_perf_event_read_value()
> into ptrs[i] directly? all within the same loop?
> 
> it might have been some verifier issue, not sure, but I think this
> should work just fine
> 
>>
>>         for (i = 0; i < num_metric && i < MAX_NUM_METRICS; i++) {
>> @@ -66,7 +72,8 @@ int BPF_PROG(fentry_XXX)
>>                                                 sizeof(reading));
>>                 if (err)
>>                         return 0;
>> -               *(ptrs[i]) = reading;
>> +               ptrs[i]->value = reading;
>> +               ptrs[i]->armed = true;
>>                 key += num_cpu;
>>         }
>>
>> @@ -76,16 +83,18 @@ int BPF_PROG(fentry_XXX)
>>  static inline void
>>  fexit_update_maps(u32 id, struct bpf_perf_event_value___local *after)
>>  {
>> -       struct bpf_perf_event_value___local *before, diff;
>> +       struct profile_reading *before;
>> +       struct bpf_perf_event_value___local diff;
>>
>>         before = bpf_map_lookup_elem(&fentry_readings, &id);
>>         /* only account samples with a valid fentry_reading */
>> -       if (before && before->counter) {
>> +       if (before && before->armed) {
> 
> this is such an unlikely situation that I wouldn't even bother
> "fixing" it, tbh. alternatively we can check enabled or running for
> zero, I don't think realistically enabled can be zero if we actually
> captured it an fentry

Here we check before->counter for 0, substituting by enabled or running
will still have the same risk of dropping the first sample.

I could reproduce it by: 
1. make PMU busy with 4 events to force multiplexing
2. then quick profile for 1 second
Result: first sample gets dropped, because measurement
at fentry is 0. This is not a huge deal by itself, but the fix is simple enough,
in my opinion, to make it worth. For a pocket change we get clearer flow:
fentry arms the counter, fexit disarms it. 
We have the same code in perf, I thought it would be nice to have this change 
there (more choice of sparse events, subsecond timeouts possible)
> 
> pw-bot: cr
> 
> 
>>                 struct bpf_perf_event_value___local *accum;
>>
>> -               diff.counter = after->counter - before->counter;
>> -               diff.enabled = after->enabled - before->enabled;
>> -               diff.running = after->running - before->running;
>> +               before->armed = false;
>> +               diff.counter = after->counter - before->value.counter;
>> +               diff.enabled = after->enabled - before->value.enabled;
>> +               diff.running = after->running - before->value.running;
>>
>>                 accum = bpf_map_lookup_elem(&accum_readings, &id);
>>                 if (accum) {
>>
>> --
>> 2.53.0-Meta
>>

