Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C56D34A781
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Oct 2025 16:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761064653; cv=none; b=c5fP1XMlEG4Mcg+dhLVjhby6U2V8Wub8lVsC/xqme+kzK6vWHtv/cMU80EwcPu2nKwweOhqfs0dQW5mvNkZanMons4Px9wKao8YzAIWYayeUg75MRW/MBYWt0zF4SW+U8VKtD8kVp3M1K+WWIznXXN4fwslFFICr5d3amrB3ufk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761064653; c=relaxed/simple;
	bh=u1aXe3OZU3rThPI8gaL85kHmK7YHG5m2vjMkz3nPm58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GoDg80Dd6F3qT6q2LqoYq03OU2KsyLRsJ5IiqILqsgd5G/lo5JBFuJ/28L0xk/jc3KfGg26mdQrIWpaZjuDXXoIwsHefn4PSg1FfR1orlOqChB49/CN1ury2MBLLpubhQ1v9vsyutEnxgcA/QL3hL77QpZcPn8k4MJ0B8JaJKl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLJTDoZ1; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLJTDoZ1"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-793021f348fso5188381b3a.1
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Oct 2025 09:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761064651; x=1761669451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3y2cYdyUhGgZgaU9jOoq8c6+3IRxfTCtnQf14RXXjoU=;
        b=SLJTDoZ1PwAUX5EXUCT+BcPSr2l1WDlXgE9/+gGaM0d1eWb3qdZl2OYyHKgxKNTDu/
         29OJhBP9NGpZ/sHT33GMoqg1pgy1y7vjlFLPWoc3LjZ3aoMcXDu9iWYsQopku5NiqnZV
         WRG5D/BqGzRqXC3rHjN2rWfxc0oL3HTKR625eDXFFhg7hS6UN7WnRU7+7BW5XZxRUse6
         LI9+yxa5fvRza/KoHj0l7MKK6oeryet0J3QMKokmG4steIIPzvnaXotny0i+jkTgQ4VS
         tE2WWC9/F9xbjD+2WWdOYO0eQbWBB4ldfVD+0XeTFe/Gk0PHR72gBLrjZC8ar0Jp9KmY
         H+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761064651; x=1761669451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3y2cYdyUhGgZgaU9jOoq8c6+3IRxfTCtnQf14RXXjoU=;
        b=v5xNKPi4os6XZ9hceBiscy6g3J5+ZyoF0ejGuMheyUOTnG/uqBM/HR7DPRdCm3j0mB
         oKSd1xFs7+v4baibvrFoHACzXBOtp8L4AnHkYmh+o8knNz9JmdVBvxcI2bksCL0RF5Im
         Kn7lSbV5O3beH8/d84yjjiKMLgKT8+4c0GCHzE7hSmvcVn4uZtBJkwJq3RdXVBe01jri
         D6ycAp/PzmmrJtc8JjKMlk7z0qxCFNTwkpr6oPWDD3D3hD+i3x94MmArTL7aWze3Ifll
         BrIm5No8HeQHco0Zcm1w8FYuRsTGpG3I7r+ef7K29S6y1hZ/QGq8sz1E5xD746nayKfV
         THJw==
X-Forwarded-Encrypted: i=1; AJvYcCXA9833W5zpLDaZLH7VUUGbTeU6Y6xHiXQT+SjMdxTqqYF4Tv+i5ZZlaD9QyGMMw3I/+p7MpkcrHf+mGUt/ZBoS@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7WW8E0yQEATSLTlZrKbpRJyWuSMkWc5fw8DNwEJxe+9I5faT3
	6XyJL4XiZ29/EFx+PbgFYJSvdeTwZQll2DWLg/5mM7T2PXi8BC7ixzM4ghjGsKiscqEhYHnrY62
	d2IMmCVSjf4EZ0nOxHinvwl5DuMah4rc=
X-Gm-Gg: ASbGnctgKQlXmd0wo46c5wWCJBbeehJW0QgmiF8HZvZSCplv9xf9Em/XKACZ1WYDiA6
	mN5uxGbb8MJD8+HZ5M8ox9n8baIKoh8w9JJ7rQlbeh1B9Q64RQOatU0+ERxM5ZDihJ8lIWHRTWw
	/bteWg/2YRV3AKE5lT9dWmlR2KEaRAuHt+z48GKDai4ko+XxAlWUuWZwiSKXl1qDsX3oZSdMrmA
	sT0gamoHtp9ZFicJIU/mRV3/m7vCkkxwPtyLcsy0N1zIUGKygRJtznvdXcA9ZyUa2ff
X-Google-Smtp-Source: AGHT+IEcEPOsBjjen57dx8AWzJlKnv1o2mKhcYtgeOkzW9WYILltvjYki1lVHlptLzSgvH3qoaPXs4xTQQZARlVNhgU=
X-Received: by 2002:a05:6a20:12cb:b0:334:a322:f326 with SMTP id
 adf61e73a8af0-334a86070cdmr25486907637.28.1761064651341; Tue, 21 Oct 2025
 09:37:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014100128.2721104-1-chen.dylane@linux.dev>
 <20251014100128.2721104-3-chen.dylane@linux.dev> <aO4-jAA5RIUY2yxc@krava>
 <CAADnVQLoF49pu8CT81FV1ddvysQzvYT4UO1P21fVxnafnO5vrQ@mail.gmail.com>
 <CAEf4BzbAt_3co0s-+DspnHuJryG2DKPLP9OwsN0bWWnbd5zsmQ@mail.gmail.com> <abd75aed-9ff2-4e6d-8fec-2b118264efa9@linux.dev>
In-Reply-To: <abd75aed-9ff2-4e6d-8fec-2b118264efa9@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 21 Oct 2025 09:37:17 -0700
X-Gm-Features: AS18NWC2L-suUbbDctX16FVllHMGNBcyDiKSAstnT23J7xmL--qqD_w8JO_1IuQ
Message-ID: <CAEf4BzbtU2m9mh+Wi-BvuJ7U5_oHL3TWB8w2M5pRO6w6CCbfVw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 2/2] bpf: Pass external callchain entry to get_perf_callchain
To: Tao Chen <chen.dylane@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Jiri Olsa <olsajiri@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 18, 2025 at 12:51=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> w=
rote:
>
> =E5=9C=A8 2025/10/17 04:39, Andrii Nakryiko =E5=86=99=E9=81=93:
> > On Tue, Oct 14, 2025 at 8:02=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >>
> >> On Tue, Oct 14, 2025 at 5:14=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com>=
 wrote:
> >>>
> >>> On Tue, Oct 14, 2025 at 06:01:28PM +0800, Tao Chen wrote:
> >>>> As Alexei noted, get_perf_callchain() return values may be reused
> >>>> if a task is preempted after the BPF program enters migrate disable
> >>>> mode. Drawing on the per-cpu design of bpf_perf_callchain_entries,
> >>>> stack-allocated memory of bpf_perf_callchain_entry is used here.
> >>>>
> >>>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> >>>> ---
> >>>>   kernel/bpf/stackmap.c | 19 +++++++++++--------
> >>>>   1 file changed, 11 insertions(+), 8 deletions(-)
> >>>>
> >>>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> >>>> index 94e46b7f340..acd72c021c0 100644
> >>>> --- a/kernel/bpf/stackmap.c
> >>>> +++ b/kernel/bpf/stackmap.c
> >>>> @@ -31,6 +31,11 @@ struct bpf_stack_map {
> >>>>        struct stack_map_bucket *buckets[] __counted_by(n_buckets);
> >>>>   };
> >>>>
> >>>> +struct bpf_perf_callchain_entry {
> >>>> +     u64 nr;
> >>>> +     u64 ip[PERF_MAX_STACK_DEPTH];
> >>>> +};
> >>>> +
> >
> > we shouldn't introduce another type, there is perf_callchain_entry in
> > linux/perf_event.h, what's the problem with using that?
>
> perf_callchain_entry uses flexible array, DEFINE_PER_CPU seems do not
> create buffer for this, for ease of use, the size of the ip array has
> been explicitly defined.
>
> struct perf_callchain_entry {
>          u64                             nr;
>          u64                             ip[]; /*
> /proc/sys/kernel/perf_event_max_stack */
> };
>

Ok, fair enough, but instead of casting between perf_callchain_entry
and bpf_perf_callchain_entry, why not put perf_callchain_entry inside
bpf_perf_callchain_entry as a first struct and pass a pointer to it.
That looks a bit more appropriate? Though I'm not sure if compiler
will complain about that flex array...

But on related note, I looked briefly at how perf gets those
perf_callchain_entries, and it does seem like it also has a small
stack of entries, so maybe we don't really need to invent anything
here. See PERF_NR_CONTEXTS and how that's used.

If instead of disabling preemption we disable migration, then I think
we should be good with relying on perf's callchain management, or am I
missing something?

> >
> >>>>   static inline bool stack_map_use_build_id(struct bpf_map *map)
> >>>>   {
> >>>>        return (map->map_flags & BPF_F_STACK_BUILD_ID);
> >>>> @@ -305,6 +310,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, re=
gs, struct bpf_map *, map,
> >>>>        bool user =3D flags & BPF_F_USER_STACK;
> >>>>        struct perf_callchain_entry *trace;
> >>>>        bool kernel =3D !user;
> >>>> +     struct bpf_perf_callchain_entry entry =3D { 0 };
> >>>
> >>> so IIUC having entries on stack we do not need to do preempt_disable
> >>> you had in the previous version, right?
> >>>
> >>> I saw Andrii's justification to have this on the stack, I think it's
> >>> fine, but does it have to be initialized? it seems that only used
> >>> entries are copied to map
> >>
> >> No. We're not adding 1k stack consumption.
> >
> > Right, and I thought we concluded as much last time, so it's a bit
> > surprising to see this in this patch.
> >
>
> Ok, I feel like I'm missing some context from our previous exchange.
>
> > Tao, you should go with 3 entries per CPU used in a stack-like
> > fashion. And then passing that entry into get_perf_callchain() (to
> > avoid one extra copy).
> >
>
> Got it. It is more clearer, will change it in v3.
>
> >>
> >> pw-bot: cr
>
>
> --
> Best Regards
> Tao Chen
