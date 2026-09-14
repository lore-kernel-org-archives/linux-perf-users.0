Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD34C486E58
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 15:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789401458; cv=pass; b=Ld8/6MicGEwyrL6TcjykcT6CIKgaLLi+gt2Nav2Pora+4x42V2XjZ1YVC39jWT8/hiICjIVM/IrCgKkYW3QCeNeVYJi1soUYDwUNNwqq2/ORSb6eWYp63+fDPOtslrhYba5f9Y7uOynqv6pyRK3eMG+bdeVK/TEGY3JT0ddAX+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789401458; c=relaxed/simple;
	bh=a/Rl2SwBqgPpR6LV/br/DKSHqrY84pKtnxzi5Sff3lA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CY3f9yVDwZAMhIw5/sD0+Mtynm/P0rvSRCuOUI8lulUjOv2SV4LtTQCJcN4E/P+aAbk9hsoug4sjgHfxdBbA7h5mbt7maX8ZlNrwrWMbuPY9xm6BAuuriBO3wmxqoJYylmZbLUxOpQy/X+Mq6uk82yWspBBGp9IehppocAGXtm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3hOg5Zx; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3hOg5Zx"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd66bb4so1867680a91.1
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 08:57:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789401455; cv=none;
        d=google.com; s=arc-20260327;
        b=qXNTl/jQNHcGcH8caej3lbrkZrk6twYbxUc/RpaJW+okrvi7nl1u2ySbFGL5Fcv6Tv
         bHBrIcDxtWJgeVQdH1qoGOiwzel0MKr2VSGHCGg6A+cU4hPLW74IQY7mAVah4urVwYgA
         DskokZwBnpwVyJVQn+B91h3qu0p1qNuJyzyHBJNKJuak2/L1hRSe32EheeVuBqQdE400
         sMLpz8rUxa4UKMJMHaAxwzxGH2YX/XClxDbWkRqVh1hmXNmcGMjeDevbudCD4iDCBpXr
         kKFbQXm/JJtj/aKgXeckgxyS6875sGqinEvM6wgx5wtvrdFjLyl87uNP5TpxcTdhIYQ4
         YBeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=20UiL5UA5p4ijMlXdNx35QfEsA7uCRpDrtN5FDClGEE=;
        fh=S/OkJqsrEmwf5KdQYL6+ZhqwZp29DHFcLe7wGWnklZc=;
        b=ClyGpcKhlVlbflfQn8WM+tbyQV5thMZAJdHZkDflk87KZK53CVNPfQQt7LbwDR06up
         AE9o5umoxTdg1KHb2LXJstRR7+jfmUSdNrvAkperAbyeDaRNTNUhh778Bo1iXQBrj69N
         DnVFQoGWISZHvvrUU/kTPuvCUUNnMZ7+IVMnIIW4Siv+fCj55rlsUDNMlKQnA0k0wRd0
         82Vs3/5z3Cwf3A7ctjNl5f+W1a8/tbVP9G7MLQx7Y/DDEgv+mWnFMqLBPleVTTNw833j
         YbUGc2Csdz1BeAIdtLNCzIPcRLt6w6RwnodLgsRJj9fKg0NgwColW9p0ma9Cu8eLGGNF
         S6jA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789401455; x=1790006255; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=20UiL5UA5p4ijMlXdNx35QfEsA7uCRpDrtN5FDClGEE=;
        b=e3hOg5Zxro3+LA0SBO03S8/09TgeO/65KqKyZsLXJvndpykG7ajGYhFFWnrns5jU8k
         ItlX0PCEx+1pt52Goofb8XpnXEM7A5okeENol8MtLLkNyBg4Y3ZvTv02ciQheMBMfegm
         iy0QhQ0j33t11zWPuQPMpE4tdxfIL6YEUNMpRq2pbMssDWGVkAqFVx1KkVngzMaTNpGY
         fDhVXExIUvlctBxKMFkVXMrIgLt7/BpRCgZhE0r/1kjPSR5qCdD4v5hVXFhYolIONuRK
         l7edGRzS8Lnkv70O7IL96VyGL6FPInhAeRkG2c2xzaGGiarLMoO34qhGbwSh57AJhx1H
         7xvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789401455; x=1790006255;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=20UiL5UA5p4ijMlXdNx35QfEsA7uCRpDrtN5FDClGEE=;
        b=WDbrKzzuIpkuNGjVkBDIJuXCiVPtR5O4+GGMX8decP0PfjndPPcGDtHtXijYf4xxpi
         WS/x666yK/rLIuAKjCmldXVlLvi3duwZUtBqKO4BMMsZ8yL6OlrY9X1W6yfQtMPwoRj8
         AHkJ5ogt8NRuaNed1oiD+DuGRGw0kaL34NLNdPnQHQBtP+Qfh4IDm30P9VfWAcnz8fFS
         CHORCLgxVm/PdwemJiH9EGrFZuKE/2Bm1Nn+p/OFm51BgDeJ45QBvvt4LPkeplNX1dgv
         WrxJFP8aJEukPZap8qosVw8IskoFfOoc2Wo3mM1fMhDelyPkZZjTJPnS6vnOKRpIULHc
         V/Fg==
X-Forwarded-Encrypted: i=1; AKwUvByfVGhXdUnk8j13ltIhySI/bB0VaKKg8ueqx/zZ3bGKloz7IhqoloD62XgmJPfsj0c7BVYdc9oxrdWpalGl13Vb@vger.kernel.org
X-Gm-Message-State: AFuF++mZuwwS5wsGPl+DShxJIRfkSBSjg+h7IBBouWS80OO9FKipSgiu
	5KMEusCY8k7O/v41QI2h4drwplq8ARsxD92h3uv1ROtDNkiwwiv2GSRmzn8GQiaNuGows4HITtO
	Sh2oVj8D7FyJdXeKqIKIWh6fmefKENmk=
X-Gm-Gg: AYBFou17/R2AYuU+TgKzY/Ed3idMeIJT0idujP02mgtYjrjnOBigViSZDCLeko55sS6
	qLutexB8NBxxPMa9SUS1NExk3lfXkKbtwBWY2J1RkG5g76dKxqYPlE2LcAX4OvLnxuG//3RR5S7
	TcEQX6s5w4vpKeW+KnaKpU4ufo0WkTGkiTgKCyV7AH45QXauHPnnjyesWqyOKh4ZBVKCWzVo3vI
	kD+fiShS14mqniHwwbNfhnmN/D4MAcgQRELrjcFmRHsNGHgnVvFwkneJH1RpBy99IxyfASfHEzL
	NJu81ihT9/tOQmImv57gsKnqDV11UoH4TpsM2NH4pE4D8GbCzLceEK9AYXD8DJ/aQ4h6cJwDJ9Y
	Zntal3xiHMukqKeV2nakXRDFzjd81n9Z9pxY/kqSBlBToOt6oOo+o
X-Received: by 2002:a17:90a:d64e:b0:39b:2c55:365 with SMTP id
 98e67ed59e1d1-39dec07ab33mr6599011a91.12.1789401454565; Mon, 14 Sep 2026
 08:57:34 -0700 (PDT)
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
 <123fb2fb-8342-439c-8a9f-c5d27fb6e323@gmail.com>
In-Reply-To: <123fb2fb-8342-439c-8a9f-c5d27fb6e323@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 14 Sep 2026 08:57:21 -0700
X-Gm-Features: AcwNN1Umi1WYncfpQpCCx4h48V8YYIg3U7yqezS15KBc-DBEZUHeyy5Pih5oCkM
Message-ID: <CAEf4BzYVceGdJcM_TS_odTgG=L9c2YvsDRW-dic+G9RrCwDTPg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] bpftool: Track perf counter snapshot state
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com, 
	memxor@gmail.com, qmo@kernel.org, linux-perf-users@vger.kernel.org, 
	acme@kernel.org, namhyung@kernel.org, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 4:59=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
>
>
> On 9/12/26 12:57 AM, Andrii Nakryiko wrote:
> > On Wed, Sep 9, 2026 at 2:19=E2=80=AFAM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> >>
> >> On 9/9/26 12:56 AM, Andrii Nakryiko wrote:
> >>> On Tue, Sep 8, 2026 at 7:27=E2=80=AFAM Mykyta Yatsenko
> >>> <mykyta.yatsenko5@gmail.com> wrote:
> >>>>
> >>>> From: Mykyta Yatsenko <yatsenko@meta.com>
> >>>>
> >>>> A perf counter can be zero at fentry. PMU multiplexing can schedule =
the
> >>>> event during the BPF program. The old counter check then drops a val=
id
> >>>> sample.
> >>>>
> >>>> Use an armed flag to track each successful fentry snapshot. Reset al=
l
> >>>> flags before new reads. The fexit path clears each flag when it cons=
umes
> >>>> the snapshot.
> >>>>
> >>>> Fixes: 47c09d6a9f67 ("bpftool: Introduce "prog profile" command")
> >>>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> >>>> ---
> >>>>  tools/bpf/bpftool/skeleton/profiler.bpf.c | 25 +++++++++++++++++---=
-----
> >>>>  1 file changed, 17 insertions(+), 8 deletions(-)
> >>>>
> >>>> diff --git a/tools/bpf/bpftool/skeleton/profiler.bpf.c b/tools/bpf/b=
pftool/skeleton/profiler.bpf.c
> >>>> index f48c783cb9f7..6c654bd9b346 100644
> >>>> --- a/tools/bpf/bpftool/skeleton/profiler.bpf.c
> >>>> +++ b/tools/bpf/bpftool/skeleton/profiler.bpf.c
> >>>> @@ -10,6 +10,11 @@ struct bpf_perf_event_value___local {
> >>>>         __u64 running;
> >>>>  } __attribute__((preserve_access_index));
> >>>>
> >>>> +struct profile_reading {
> >>>> +       struct bpf_perf_event_value___local value;
> >>>> +       bool armed;
> >>>> +};
> >>>> +
> >>>>  /* map of perf event fds, num_cpu * num_metric entries */
> >>>>  struct {
> >>>>         __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
> >>>> @@ -21,7 +26,7 @@ struct {
> >>>>  struct {
> >>>>         __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> >>>>         __uint(key_size, sizeof(u32));
> >>>> -       __uint(value_size, sizeof(struct bpf_perf_event_value___loca=
l));
> >>>
> >>> this is not a bug, but... ;)
> >>>
> >>>
> >>> struct bpf_perf_event_value is UAPI, why do we need CO-RE-relocatable
> >>> ___local variant?...
> >>>
> >>>
> >>>> +       __uint(value_size, sizeof(struct profile_reading));
> >>>>  } fentry_readings SEC(".maps");
> >>>>
> >>>>  /* accumulated readings */
> >>>> @@ -45,7 +50,7 @@ const volatile __u32 num_metric =3D 1;
> >>>>  SEC("fentry/XXX")
> >>>>  int BPF_PROG(fentry_XXX)
> >>>>  {
> >>>> -       struct bpf_perf_event_value___local *ptrs[MAX_NUM_METRICS];
> >>>> +       struct profile_reading *ptrs[MAX_NUM_METRICS];
> >>>>         u32 key =3D bpf_get_smp_processor_id();
> >>>>         u32 i;
> >>>>
> >>>> @@ -56,6 +61,7 @@ int BPF_PROG(fentry_XXX)
> >>>>                 ptrs[i] =3D bpf_map_lookup_elem(&fentry_readings, &f=
lag);
> >>>>                 if (!ptrs[i])
> >>>>                         return 0;
> >>>> +               ptrs[i]->armed =3D false;
> >>>>         }
> >>>
> >>> this is preexisting, but why do we have two separate loops: first
> >>> lookup up fentry_readings pointers, and then separately a) reading
> >>> perf counters into local variable just to b) immediately copy it into
> >>> map_value.
> >>>
> >>> can you try simplifying this and doing bpf_perf_event_read_value()
> >>> into ptrs[i] directly? all within the same loop?
> >>>
> >>> it might have been some verifier issue, not sure, but I think this
> >>> should work just fine
> >
> > you haven't answered this
> >
>
> Yes, I can try this, but should we care to support those older kernels
> in case someone tries fresh bpftool on old verifier?
>

did you check that this logic will not verify on older kernels?

> >>>
> >>>>
> >>>>         for (i =3D 0; i < num_metric && i < MAX_NUM_METRICS; i++) {
> >>>> @@ -66,7 +72,8 @@ int BPF_PROG(fentry_XXX)
> >>>>                                                 sizeof(reading));
> >>>>                 if (err)
> >>>>                         return 0;
> >>>> -               *(ptrs[i]) =3D reading;
> >>>> +               ptrs[i]->value =3D reading;
> >>>> +               ptrs[i]->armed =3D true;
> >>>>                 key +=3D num_cpu;
> >>>>         }
> >>>>
> >>>> @@ -76,16 +83,18 @@ int BPF_PROG(fentry_XXX)
> >>>>  static inline void
> >>>>  fexit_update_maps(u32 id, struct bpf_perf_event_value___local *afte=
r)
> >>>>  {
> >>>> -       struct bpf_perf_event_value___local *before, diff;
> >>>> +       struct profile_reading *before;
> >>>> +       struct bpf_perf_event_value___local diff;
> >>>>
> >>>>         before =3D bpf_map_lookup_elem(&fentry_readings, &id);
> >>>>         /* only account samples with a valid fentry_reading */
> >>>> -       if (before && before->counter) {
> >>>> +       if (before && before->armed) {
> >>>
> >>> this is such an unlikely situation that I wouldn't even bother
> >>> "fixing" it, tbh. alternatively we can check enabled or running for
> >>> zero, I don't think realistically enabled can be zero if we actually
> >>> captured it an fentry
> >>
> >> Here we check before->counter for 0, substituting by enabled or runnin=
g
> >> will still have the same risk of dropping the first sample.
> >>
> >> I could reproduce it by:
> >> 1. make PMU busy with 4 events to force multiplexing
> >> 2. then quick profile for 1 second
> >> Result: first sample gets dropped, because measurement
> >> at fentry is 0. This is not a huge deal by itself, but the fix is simp=
le enough,
> >> in my opinion, to make it worth. For a pocket change we get clearer fl=
ow:
> >> fentry arms the counter, fexit disarms it.
> >> We have the same code in perf, I thought it would be nice to have this=
 change
> >> there (more choice of sparse events, subsecond timeouts possible)
> >>>
> >
> > are you saying that you get zero even for before->enabled?
> >
>
> yes, for sparse events like itlb misses + PMU contention
> that can happen.
> for example log from one of the runs:
> bpf_trace_printk: counter: 0, enabled: 29431875, running: 13638505
> bpf_trace_printk: counter: 0, enabled: 60395630, running: 30502953
> bpf_trace_printk: counter: 0, enabled: 60608030, running: 30502953
> bpf_trace_printk: counter: 0, enabled: 5609314, running: 0

But enabled doesn't, see? I keep forgetting which of enabled/running
means "PMU event would like to be active" (that seems to be "enabled"
judging by this output you shared) and which one is "PMU event was
actually active", but the one with "would like to be active" should
never be zero after activation, so why not use that instead of adding
extra layer of armed/unarmed?

> bpf_trace_printk: counter: 0, enabled: 5918970, running: 382474
> bpf_trace_printk: counter: 0, enabled: 6243798, running: 542435
> bpf_trace_printk: counter: 0, enabled: 6623769, running: 1087273
> bpf_trace_printk: counter: 0, enabled: 7078241, running: 1376878
> bpf_trace_printk: counter: 0, enabled: 7326934, running: 1625571
> bpf_trace_printk: counter: 0, enabled: 7440054, running: 1738691
>
> >>> pw-bot: cr
> >>>
> >>>
> >>>>                 struct bpf_perf_event_value___local *accum;
> >>>>
> >>>> -               diff.counter =3D after->counter - before->counter;
> >>>> -               diff.enabled =3D after->enabled - before->enabled;
> >>>> -               diff.running =3D after->running - before->running;
> >>>> +               before->armed =3D false;
> >>>> +               diff.counter =3D after->counter - before->value.coun=
ter;
> >>>> +               diff.enabled =3D after->enabled - before->value.enab=
led;
> >>>> +               diff.running =3D after->running - before->value.runn=
ing;
> >>>>
> >>>>                 accum =3D bpf_map_lookup_elem(&accum_readings, &id);
> >>>>                 if (accum) {
> >>>>
> >>>> --
> >>>> 2.53.0-Meta
> >>>>
> >>
>
