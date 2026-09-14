Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B46E38734A
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 21:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789419842; cv=pass; b=ktm7DTxzD3y1dkU7W3f01+wdaQJjiTkKiExyN2h+5tjta3hscSg/Xb7JQSXPBf6dIrFhs+lxaFRRda9+Njra7GXj6kYu/XgSM6n76eN5QHzNFkXnJxKtSXhgDKUR+0c0sK+bp0Up2fYUHpndv515plombCWvunM4PlIkhBZrsz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789419842; c=relaxed/simple;
	bh=CgrKu7Zs/00QElfUvrqtZz+nxPvLPlwemeLf4emGtT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vris72jtZkYHghSVJA7wPntq4oyNTkOBbm3xLbQhDVkznP+ItTE1LJZOmFsP+ZnIT/3GE4Kdf2BAJmQxejTBOvsTjWdpdOgqEw9sky0snyXqhu+5FrRnD1qZcLZi1bjZEnLGCC0dcP11S4Bl//DplMgAJhIV7XnLU/8kxdGtiJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Se/NJczQ; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Se/NJczQ"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccafb751so2554747a91.2
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 14:04:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789419840; cv=none;
        d=google.com; s=arc-20260327;
        b=KUnDOEau/FrSsy8tzjPGID9ujcuDlh5jc3gdtLsc4hoC/kRH/Nn7A785y2gWtPTRMP
         IcwIyiBGy49E56vhildCMoxMn+OvuMTbBZyYCedEiZBlqWH7APzFsERG7WsLZqSJHaaU
         fWGiQQJX/xub6ykK7+2ibLcVQlytUyH7/KnGn77MziquH5lUA1PmA0pcmbLwHdjK5U5I
         dzLyVTCKex7myFufNrevdWcH80c6X2HIcu/IN6VgZIdszbi1vwlxIctHcLvNjVBaR7Zl
         7IlS5emB8pVeOqJ960hyd2o4FyR1FWRQdL9wDJwDIVERHHyQLf0PnhRUh2HPtSkOzCDh
         53Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aSoIi4TMGObut+6RiOF0Y1sT5N7W9UXkCoOWPUwVKn4=;
        fh=9b+J/OBa+QYbqxiQQvBX+HDB1P8qVGjHxonN/HIJqTY=;
        b=nkMR7hvIgUjpYjKTadz5LAQvxRMW4xvd/iSpegWnEOv0Ds4c6sf1D+IaCagpBR3QQL
         U7dccPCLhks5i1PMmfme6tAoxa2DZTdu4Azm6FeIs1BoQB2HpIolmdwCljhKV0IKTLrE
         ztdF1B7cxtqTcUe+XQ5oURT5Hv0vTLdIp733qzxLpeoc1gN599pJtZaVhtXUsIjoBjpE
         VnB+3zdDbZ4FbJXMALme+ugvj8YVS3AYdKAEaAxm0jYU0IuF9/bncmFJehFdvq8UnPC/
         75QQ35ptS8oQE0aiHpbsesKp05zJoWX4nWq0aLVP5oE3Q8Usju/I3hk5i8Y2JoeSqEac
         85/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789419840; x=1790024640; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aSoIi4TMGObut+6RiOF0Y1sT5N7W9UXkCoOWPUwVKn4=;
        b=Se/NJczQfYevCQhDuyKHcTjzV6x5cSKlsMizMx5dn/b7CjVIFFv2Twg2eer4YcanO9
         8qPeparXPP7eoP+W4k2+bdxxGYFe1sOBZgK0g7IDNvMqvhDS/sCfhs8LDhVF9KFKsvML
         4DFbPDQHVZHvKT7FvEaOFIJXqxukkj7kog17+VmeUfHOsViCRCUfld8irr873qGNOyx1
         MiJtmP8b2flJ324GSOoghh1ULHk0QR2zVRRreKRYolZeApxok28GCAi6q1Q+o65TXtqd
         aX2aNsA1tQ1JUX5064Gh/85JAW/Q2N06LVTk5BAxwgIuYBIpDDi4eoCxYxeyOB8ULFD0
         896g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789419840; x=1790024640;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aSoIi4TMGObut+6RiOF0Y1sT5N7W9UXkCoOWPUwVKn4=;
        b=qunwXCtLGEPPxz6DmqolMHFlaLaw8QzT10jTm4XAIFUz9c2Fm4b/NTOC1juoNBKltY
         23nf8nM8S+0K0DOfOYxDvrJENsc2BB3D34VcJVJRHSUuTIxjFf4BLrZnKBHRqPdKO9b9
         P2A2T8azwXx4MVQs3khvNcEAuhQqOIIVK2e2l22embhjGwdBqf1ktjHQ6gN+HHZxindl
         tBLcT/94DVK2QfVSNxtX7K/WVyMyXwfQu6BHl4kgz4bJNM14v+MumXRfRzilQGl+Glu6
         2KPLtEKR+c0lAqUdzblxdk2s1vKr19tqw1AZ66P1oJVlODXiai+SmxG264vrwWG7Algs
         r76Q==
X-Forwarded-Encrypted: i=1; AKwUvBzHJISCOvpoUePYJggyIzUHla7nbj7aZUfENFbrbG528r29FY4Tcd5gfdyz89q4m5WKQ5emgLD9rHsv9VoYqD5f@vger.kernel.org
X-Gm-Message-State: AFuF++kalcvVfAMNXr1LwizzanFAChksS29dKJtUBvc0/7sWZ7GiBqP8
	e91ONUFNwSHRSC9QEZ+4oboa1ngPp0flLPkzGhlx1eZ4hdUAqDXh73iGzvJKR+5WLqhJFIKoBHr
	hp8eOlcd3G/3M337Lyq1BpmFu0sCADyw=
X-Gm-Gg: AYBFou2GJO+cwd2KB+6Kf9UNuxBNXvnbLFaEXxSXN4+m5qvK5wd+AbZf/h9XTrRTXvo
	j++LMER8/FAkfqaB730n7iMDAiIi3m6FoA+wbM+XxyvRbQB3KiFt+d983iK9//kC3pceEXXkGvg
	roZt5uWjIwmpX9ejZineDZgjZBY+2DwAhrP6r+hu7FViqzpdNnVsX1yxSHtrevTXV2hSjP0ywEP
	gzclC2UypD1gSvsyr7J+odQEWnr2rWVPzRpSffcVHBhfq9roRUThhEBLPZZX5efTjVaS92epEFE
	pXoXj0Ek3BiRk7+gJh9/76hVD27E1TU8JxtN2iYIGvd22723UlgwM6CAm8R4dg7QAkX08kWztdC
	b9dg/BXFkAsfhfN47x8hVgncCPUbbFTLEVfFtziDX6cdfi5ZmFzWP
X-Received: by 2002:a17:90a:b89:b0:39d:ec44:28b8 with SMTP id
 98e67ed59e1d1-39dec442921mr5988660a91.13.1789419839653; Mon, 14 Sep 2026
 14:03:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908-bpftool_cyles_per_run-v3-0-60e86f325c35@meta.com>
 <20260908-bpftool_cyles_per_run-v3-1-60e86f325c35@meta.com>
 <CAEf4Bza_4ihFJyOJrJKRpiCvU3Mr6KXLVM+5fYnmb9ydNELOJA@mail.gmail.com>
 <74544b6e-205f-4878-8d7a-d27fac7bd946@gmail.com> <CAEf4BzYhMGP5Bcj-qnyTqLAXnZDs3JGsVqVg+-XB9pqEvNKfjA@mail.gmail.com>
 <123fb2fb-8342-439c-8a9f-c5d27fb6e323@gmail.com> <CAEf4BzYVceGdJcM_TS_odTgG=L9c2YvsDRW-dic+G9RrCwDTPg@mail.gmail.com>
 <031948ac-13d1-46e7-aafa-16d3323e2aa3@gmail.com>
In-Reply-To: <031948ac-13d1-46e7-aafa-16d3323e2aa3@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 14 Sep 2026 14:03:45 -0700
X-Gm-Features: AcwNN1XNn2ddmOTpn7w8YlSs38NXJAfaDbKNtrI7zu8M55JjoNGHrjuHJSlDbq4
Message-ID: <CAEf4Bzbv_+Rpjj0F_KmPGjqQMeJFUdCQNHUEro8Jgtj9SqO0Pw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] bpftool: Track perf counter snapshot state
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com, 
	memxor@gmail.com, qmo@kernel.org, linux-perf-users@vger.kernel.org, 
	acme@kernel.org, namhyung@kernel.org, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 11:00=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
>
>
> On 9/14/26 4:57 PM, Andrii Nakryiko wrote:
> > On Mon, Sep 14, 2026 at 4:59=E2=80=AFAM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> >>
> >>
> >>
> >> On 9/12/26 12:57 AM, Andrii Nakryiko wrote:
> >>> On Wed, Sep 9, 2026 at 2:19=E2=80=AFAM Mykyta Yatsenko
> >>> <mykyta.yatsenko5@gmail.com> wrote:
> >>>>
> >>>> On 9/9/26 12:56 AM, Andrii Nakryiko wrote:
> >>>>> On Tue, Sep 8, 2026 at 7:27=E2=80=AFAM Mykyta Yatsenko
> >>>>> <mykyta.yatsenko5@gmail.com> wrote:
> >>>>>>
> >>>>>> From: Mykyta Yatsenko <yatsenko@meta.com>
> >>>>>>
> >>>>>> A perf counter can be zero at fentry. PMU multiplexing can schedul=
e the
> >>>>>> event during the BPF program. The old counter check then drops a v=
alid
> >>>>>> sample.
> >>>>>>
> >>>>>> Use an armed flag to track each successful fentry snapshot. Reset =
all
> >>>>>> flags before new reads. The fexit path clears each flag when it co=
nsumes
> >>>>>> the snapshot.
> >>>>>>
> >>>>>> Fixes: 47c09d6a9f67 ("bpftool: Introduce "prog profile" command")
> >>>>>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> >>>>>> ---
> >>>>>>  tools/bpf/bpftool/skeleton/profiler.bpf.c | 25 +++++++++++++++++-=
-------
> >>>>>>  1 file changed, 17 insertions(+), 8 deletions(-)
> >>>>>>
> >>>>>> diff --git a/tools/bpf/bpftool/skeleton/profiler.bpf.c b/tools/bpf=
/bpftool/skeleton/profiler.bpf.c
> >>>>>> index f48c783cb9f7..6c654bd9b346 100644
> >>>>>> --- a/tools/bpf/bpftool/skeleton/profiler.bpf.c
> >>>>>> +++ b/tools/bpf/bpftool/skeleton/profiler.bpf.c
> >>>>>> @@ -10,6 +10,11 @@ struct bpf_perf_event_value___local {
> >>>>>>         __u64 running;
> >>>>>>  } __attribute__((preserve_access_index));
> >>>>>>
> >>>>>> +struct profile_reading {
> >>>>>> +       struct bpf_perf_event_value___local value;
> >>>>>> +       bool armed;
> >>>>>> +};
> >>>>>> +
> >>>>>>  /* map of perf event fds, num_cpu * num_metric entries */
> >>>>>>  struct {
> >>>>>>         __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
> >>>>>> @@ -21,7 +26,7 @@ struct {
> >>>>>>  struct {
> >>>>>>         __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> >>>>>>         __uint(key_size, sizeof(u32));
> >>>>>> -       __uint(value_size, sizeof(struct bpf_perf_event_value___lo=
cal));
> >>>>>
> >>>>> this is not a bug, but... ;)
> >>>>>
> >>>>>
> >>>>> struct bpf_perf_event_value is UAPI, why do we need CO-RE-relocatab=
le
> >>>>> ___local variant?...
> >>>>>
> >>>>>
> >>>>>> +       __uint(value_size, sizeof(struct profile_reading));
> >>>>>>  } fentry_readings SEC(".maps");
> >>>>>>
> >>>>>>  /* accumulated readings */
> >>>>>> @@ -45,7 +50,7 @@ const volatile __u32 num_metric =3D 1;
> >>>>>>  SEC("fentry/XXX")
> >>>>>>  int BPF_PROG(fentry_XXX)
> >>>>>>  {
> >>>>>> -       struct bpf_perf_event_value___local *ptrs[MAX_NUM_METRICS]=
;
> >>>>>> +       struct profile_reading *ptrs[MAX_NUM_METRICS];
> >>>>>>         u32 key =3D bpf_get_smp_processor_id();
> >>>>>>         u32 i;
> >>>>>>
> >>>>>> @@ -56,6 +61,7 @@ int BPF_PROG(fentry_XXX)
> >>>>>>                 ptrs[i] =3D bpf_map_lookup_elem(&fentry_readings, =
&flag);
> >>>>>>                 if (!ptrs[i])
> >>>>>>                         return 0;
> >>>>>> +               ptrs[i]->armed =3D false;
> >>>>>>         }
> >>>>>
> >>>>> this is preexisting, but why do we have two separate loops: first
> >>>>> lookup up fentry_readings pointers, and then separately a) reading
> >>>>> perf counters into local variable just to b) immediately copy it in=
to
> >>>>> map_value.
> >>>>>
> >>>>> can you try simplifying this and doing bpf_perf_event_read_value()
> >>>>> into ptrs[i] directly? all within the same loop?
> >>>>>
> >>>>> it might have been some verifier issue, not sure, but I think this
> >>>>> should work just fine
> >>>
> >>> you haven't answered this
> >>>
> >>
> >> Yes, I can try this, but should we care to support those older kernels
> >> in case someone tries fresh bpftool on old verifier?
> >>
> >
> > did you check that this logic will not verify on older kernels?
> >
> no, if you are ok with the change, I'll do it in the next version.>>>>>

yeah, let's try, I think it's a good change

> >>>>>>
> >>>>>>         for (i =3D 0; i < num_metric && i < MAX_NUM_METRICS; i++) =
{
> >>>>>> @@ -66,7 +72,8 @@ int BPF_PROG(fentry_XXX)
> >>>>>>                                                 sizeof(reading));
> >>>>>>                 if (err)
> >>>>>>                         return 0;
> >>>>>> -               *(ptrs[i]) =3D reading;
> >>>>>> +               ptrs[i]->value =3D reading;
> >>>>>> +               ptrs[i]->armed =3D true;
> >>>>>>                 key +=3D num_cpu;
> >>>>>>         }
> >>>>>>
> >>>>>> @@ -76,16 +83,18 @@ int BPF_PROG(fentry_XXX)
> >>>>>>  static inline void
> >>>>>>  fexit_update_maps(u32 id, struct bpf_perf_event_value___local *af=
ter)
> >>>>>>  {
> >>>>>> -       struct bpf_perf_event_value___local *before, diff;
> >>>>>> +       struct profile_reading *before;
> >>>>>> +       struct bpf_perf_event_value___local diff;
> >>>>>>
> >>>>>>         before =3D bpf_map_lookup_elem(&fentry_readings, &id);
> >>>>>>         /* only account samples with a valid fentry_reading */
> >>>>>> -       if (before && before->counter) {
> >>>>>> +       if (before && before->armed) {
> >>>>>
> >>>>> this is such an unlikely situation that I wouldn't even bother
> >>>>> "fixing" it, tbh. alternatively we can check enabled or running for
> >>>>> zero, I don't think realistically enabled can be zero if we actuall=
y
> >>>>> captured it an fentry
> >>>>
> >>>> Here we check before->counter for 0, substituting by enabled or runn=
ing
> >>>> will still have the same risk of dropping the first sample.
> >>>>
> >>>> I could reproduce it by:
> >>>> 1. make PMU busy with 4 events to force multiplexing
> >>>> 2. then quick profile for 1 second
> >>>> Result: first sample gets dropped, because measurement
> >>>> at fentry is 0. This is not a huge deal by itself, but the fix is si=
mple enough,
> >>>> in my opinion, to make it worth. For a pocket change we get clearer =
flow:
> >>>> fentry arms the counter, fexit disarms it.
> >>>> We have the same code in perf, I thought it would be nice to have th=
is change
> >>>> there (more choice of sparse events, subsecond timeouts possible)
> >>>>>
> >>>
> >>> are you saying that you get zero even for before->enabled?
> >>>
> >>
> >> yes, for sparse events like itlb misses + PMU contention
> >> that can happen.
> >> for example log from one of the runs:
> >> bpf_trace_printk: counter: 0, enabled: 29431875, running: 13638505
> >> bpf_trace_printk: counter: 0, enabled: 60395630, running: 30502953
> >> bpf_trace_printk: counter: 0, enabled: 60608030, running: 30502953
> >> bpf_trace_printk: counter: 0, enabled: 5609314, running: 0
> >
> > But enabled doesn't, see? I keep forgetting which of enabled/running
> > means "PMU event would like to be active" (that seems to be "enabled"
> > judging by this output you shared) and which one is "PMU event was
> > actually active", but the one with "would like to be active" should
> > never be zero after activation, so why not use that instead of adding
> > extra layer of armed/unarmed?
> >
>
> yes, agree, checking for enabled should fix dropping 0 counters.

cool, thanks

>
> >> bpf_trace_printk: counter: 0, enabled: 5918970, running: 382474
> >> bpf_trace_printk: counter: 0, enabled: 6243798, running: 542435
> >> bpf_trace_printk: counter: 0, enabled: 6623769, running: 1087273
> >> bpf_trace_printk: counter: 0, enabled: 7078241, running: 1376878
> >> bpf_trace_printk: counter: 0, enabled: 7326934, running: 1625571
> >> bpf_trace_printk: counter: 0, enabled: 7440054, running: 1738691
> >>
> >>>>> pw-bot: cr
> >>>>>
> >>>>>
> >>>>>>                 struct bpf_perf_event_value___local *accum;
> >>>>>>
> >>>>>> -               diff.counter =3D after->counter - before->counter;
> >>>>>> -               diff.enabled =3D after->enabled - before->enabled;
> >>>>>> -               diff.running =3D after->running - before->running;
> >>>>>> +               before->armed =3D false;
> >>>>>> +               diff.counter =3D after->counter - before->value.co=
unter;
> >>>>>> +               diff.enabled =3D after->enabled - before->value.en=
abled;
> >>>>>> +               diff.running =3D after->running - before->value.ru=
nning;
> >>>>>>
> >>>>>>                 accum =3D bpf_map_lookup_elem(&accum_readings, &id=
);
> >>>>>>                 if (accum) {
> >>>>>>
> >>>>>> --
> >>>>>> 2.53.0-Meta
> >>>>>>
> >>>>
> >>
>
