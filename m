Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF0F1AD9ED;
	Thu, 12 Dec 2024 22:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734044001; cv=none; b=dAgoWwo/FRImVvyQvT1e/qVlIMhnMJs8p7MM+l3PiGbFzamgoOc0Gkn1yiDnjEuvorRQEx4wSdaxlEUvbb+zrd+FILGEDQvK9SzKwiDfIzmzXs1jA2PUdbISWEnB5tR9wbXfNINRN3kU1L3LNqlpK1YeNPfe84iabHpff4jO1zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734044001; c=relaxed/simple;
	bh=/YNTLwDiiXmeMAln4zXCrcFNd27GGOqZjsf7WAO6E8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J2mOwvGq9vV2uqRe0avueWelxVZf3VTzBYYbNDXhM1RGergQTCFiD9JvB3dTdeqMkIFEev5SklR23ThHj9gOu2ClD15fWFeIr5tvj8N/UXGAVNeltXw4ZMDnbTfhuzc6UajRBTFAL91uSxod9hFPAHUFta/7CTIGwQELKWFteW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dF1+a7fJ; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dF1+a7fJ"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e3982e9278bso804915276.2;
        Thu, 12 Dec 2024 14:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734043998; x=1734648798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4rly/V8Cyqmjec5b0yb/5rS2Z14G/Kz8mvctLiguoqQ=;
        b=dF1+a7fJXjx1Li1pPDxqx1FBMM2rEa8kZnkGzsZDFCCYRzZPAfUDRmKd1fdzfbdOT9
         3el1wIoiWR7yyy49SooiUkx6OD6BI9O/dDyCRxiuAOiOfII/cGuq1jnD/+Y+KzLR0CvU
         elEMsdn2CJXBLgc7sBTM0DonKEtRy6UBuy0AsqEnzK8DMfvj9ZpZDgCU5/ISmU+1c+n6
         1M2dQBcpdA7xfJUgj1PoZGalb5MU4qsf6e8bSXRZp+UsfqbjCiAKTWQAnBl5Qv/z0Fww
         SfsROtTAITu/HZvi9tXiUGcm8t9GF4FJ7egr0GipnTfyYx3w8TEdzezCWvoNGwHeqwcv
         KBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734043998; x=1734648798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4rly/V8Cyqmjec5b0yb/5rS2Z14G/Kz8mvctLiguoqQ=;
        b=kK11wQ+OpqW4i1Zf3eD9HHVI/G9dzcHwNG4oY7FYHxcNUlmF+EpwcmFpB7Pm3javbr
         Gnahpq7mR1uKS8+9U4onv6promvJl5L6F1Glq2sKWw+9zvdPKd+9AYoIwcTFwJJC1G9K
         ujv04zPxyKDXl5z7V6w+OfOroUAuIS1M7M3omurKpu2tigc/ff6QJVfw/0ZD2N9ixLv6
         xnlA3zQmd84GjzOfGYo7d8gD85bxx44gCIIEn/hPvcKAQMDIbUp9630tmsfGZzuiBuqc
         Rv4YJVuajHS7LXN3w1D/WQUm4zThynq9MmcJXR9649Hh+qAx6SYrXM9Ogp3pwbmn/Nwo
         HY0A==
X-Forwarded-Encrypted: i=1; AJvYcCUr21lVMRG/jkbgLq+V4kDvp67eZPQeiTtN0Hu2crDD68idEfzp4ymZICH0By3E2U50kjw481QYQFzQHZk=@vger.kernel.org, AJvYcCVgSMftlcq4mc27dCY3WI7pWL4wp6bxAa1jCd5mC0Jg+5ogwfZxd9q/yTwqgwqgH/uDFeZJpUVORDumrZPqvMLUdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxpdP8PNGWm8ERIKbXQbtbVD/ikB6YGhjYhqAb6XyUfsTgpZsDC
	BBQ13IsHhYXJ8wp+Z2vdQtcDMGHjpbigPdPPPkydvFPQv0Og5kuUvYSx0pxEv3Lckl+jqvpXJys
	L9a/AAxgOdGrqlSMbX6nNgYJ6EL8=
X-Gm-Gg: ASbGnctvDXgywCizByhcs5NhlovP2oK54tEaqyflUFfELgmCX0IT1wZSvA5SbT6W0Ym
	LCZDEJXzX8Vw2tWpNZbfqpvoGIu7C4hJVaAOf
X-Google-Smtp-Source: AGHT+IFNO2xOMsLdOa03cqqdhbyK8n24WxIIij+1AF2VZRC146RZ+a29GIoqquww0CLNZF0BXI3v+BKcSiu728jmRF0=
X-Received: by 2002:a05:6902:1612:b0:e3c:8c27:a93 with SMTP id
 3f1490d57ef6-e43492f5941mr390121276.1.1734043998348; Thu, 12 Dec 2024
 14:53:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212022420.1035999-1-howardchu95@gmail.com>
 <20241212022420.1035999-5-howardchu95@gmail.com> <Z1tPpZ7HHaF8g4PQ@google.com>
 <CAH0uvohN0GPW_ABFUTK7Goo0WXcSRNVhjwabKkhruXM1zB8+hQ@mail.gmail.com>
In-Reply-To: <CAH0uvohN0GPW_ABFUTK7Goo0WXcSRNVhjwabKkhruXM1zB8+hQ@mail.gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Thu, 12 Dec 2024 14:53:09 -0800
Message-ID: <CAH0uvogSNKigyw1JD3D7yZeftsc0Ygs6KoTfGUhyFTBBHhz6fw@mail.gmail.com>
Subject: Re: [PATCH v12 04/10] perf record --off-cpu: Dump off-cpu samples in BPF
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
	James Clark <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Also, apologies on the wrong version number of "Changes in v12:" in
v12 series' cover letter.

Thanks,
Howard

On Thu, Dec 12, 2024 at 2:49=E2=80=AFPM Howard Chu <howardchu95@gmail.com> =
wrote:
>
> Hello Namhyung,
>
> On Thu, Dec 12, 2024 at 1:03=E2=80=AFPM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > Hello,
> >
> > On Wed, Dec 11, 2024 at 06:24:14PM -0800, Howard Chu wrote:
> > > Collect tid, period, callchain, and cgroup id and dump them when off-=
cpu
> > > time threshold is reached.
> > >
> > > We don't collect the off-cpu time twice (the delta), it's either in
> > > direct samples, or accumulated samples that are dumped at the end of
> > > perf.data.
> > >
> > > Suggested-by: Namhyung Kim <namhyung@kernel.org>
> > > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > > Cc: Ian Rogers <irogers@google.com>
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: James Clark <james.clark@linaro.org>
> > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > Cc: Kan Liang <kan.liang@linux.intel.com>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Link: https://lore.kernel.org/r/20241108204137.2444151-6-howardchu95@=
gmail.com
> > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > ---
> > >  tools/perf/util/bpf_skel/off_cpu.bpf.c | 86 ++++++++++++++++++++++++=
--
> > >  1 file changed, 81 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util=
/bpf_skel/off_cpu.bpf.c
> > > index c87132e01eb3..aae63d999abb 100644
> > > --- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
> > > +++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> > > @@ -19,11 +19,17 @@
> > >  #define MAX_ENTRIES  102400
> > >
> > >  #define MAX_CPUS  4096
> > > +#define MAX_OFFCPU_LEN 37
> > > +
> > > +struct stack {
> > > +     u64 array[MAX_STACKS];
> > > +};
> > >
> > >  struct tstamp_data {
> > >       __u32 stack_id;
> > >       __u32 state;
> > >       __u64 timestamp;
> > > +     struct stack stack;
> > >  };
> > >
> > >  struct offcpu_key {
> > > @@ -41,6 +47,10 @@ struct {
> > >       __uint(max_entries, MAX_ENTRIES);
> > >  } stacks SEC(".maps");
> > >
> > > +struct offcpu_data {
> > > +     u64 array[MAX_OFFCPU_LEN];
> > > +};
> > > +
> > >  struct {
> > >       __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
> > >       __uint(key_size, sizeof(__u32));
> > > @@ -48,6 +58,13 @@ struct {
> > >       __uint(max_entries, MAX_CPUS);
> > >  } offcpu_output SEC(".maps");
> > >
> > > +struct {
> > > +     __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> > > +     __uint(key_size, sizeof(__u32));
> > > +     __uint(value_size, sizeof(struct offcpu_data));
> > > +     __uint(max_entries, 1);
> > > +} offcpu_payload SEC(".maps");
> > > +
> > >  struct {
> > >       __uint(type, BPF_MAP_TYPE_TASK_STORAGE);
> > >       __uint(map_flags, BPF_F_NO_PREALLOC);
> > > @@ -194,6 +211,47 @@ static inline int can_record(struct task_struct =
*t, int state)
> > >       return 1;
> > >  }
> > >
> > > +static inline int copy_stack(struct stack *from, struct offcpu_data =
*to, int n)
> > > +{
> > > +     int len =3D 0;
> > > +
> > > +     for (int i =3D 0; i < MAX_STACKS && from->array[i]; ++i, ++len)
> > > +             to->array[n + 2 + i] =3D from->array[i];
> > > +
> > > +     return len;
> > > +}
> > > +
> > > +/**
> > > + * off_cpu_dump - dump off-cpu samples to ring buffer
> > > + * @data: payload for dumping off-cpu samples
> > > + * @key: off-cpu data
> > > + * @stack: stack trace of the task before being scheduled out
> > > + *
> > > + * If the threshold of off-cpu time is reached, acquire tid, period,=
 callchain, and cgroup id
> > > + * information of the task, and dump it as a raw sample to perf ring=
 buffer
> > > + */
> > > +static int off_cpu_dump(void *ctx, struct offcpu_data *data, struct =
offcpu_key *key,
> > > +                     struct stack *stack, __u64 delta)
> > > +{
> > > +     int n =3D 0, len =3D 0;
> > > +
> > > +     data->array[n++] =3D (u64)key->tgid << 32 | key->pid;
> > > +     data->array[n++] =3D delta;
> > > +
> > > +     /* data->array[n] is callchain->nr (updated later) */
> > > +     data->array[n + 1] =3D PERF_CONTEXT_USER;
> > > +     data->array[n + 2] =3D 0;
> > > +     len =3D copy_stack(stack, data, n);
> > > +
> > > +     /* update length of callchain */
> > > +     data->array[n] =3D len + 1;
> > > +     n +=3D len + 2;
> > > +
> > > +     data->array[n++] =3D key->cgroup_id;
> > > +
> > > +     return bpf_perf_event_output(ctx, &offcpu_output, BPF_F_CURRENT=
_CPU, data, n * sizeof(u64));
> > > +}
> > > +
> > >  static int off_cpu_stat(u64 *ctx, struct task_struct *prev,
> > >                       struct task_struct *next, int state)
> > >  {
> > > @@ -218,6 +276,16 @@ static int off_cpu_stat(u64 *ctx, struct task_st=
ruct *prev,
> > >       pelem->state =3D state;
> > >       pelem->stack_id =3D stack_id;
> > >
> > > +     /*
> > > +      * If stacks are successfully collected by bpf_get_stackid(), c=
ollect them once more
> > > +      * in task_storage for direct off-cpu sample dumping
> > > +      */
> > > +     if (stack_id > 0 && bpf_get_stack(ctx, &pelem->stack, MAX_STACK=
S * sizeof(u64), BPF_F_USER_STACK)) {
> > > +             /*
> > > +              * This empty if block is used to avoid 'result unused =
warning' from bpf_get_stack().
> > > +              * If the collection fails, continue with the logic for=
 the next task.
> > > +              */
> > > +     }
> > >  next:
> > >       pelem =3D bpf_task_storage_get(&tstamp, next, NULL, 0);
> > >
> > > @@ -232,11 +300,19 @@ static int off_cpu_stat(u64 *ctx, struct task_s=
truct *prev,
> > >               __u64 delta =3D ts - pelem->timestamp;
> > >               __u64 *total;
> > >
> > > -             total =3D bpf_map_lookup_elem(&off_cpu, &key);
> > > -             if (total)
> > > -                     *total +=3D delta;
> > > -             else
> > > -                     bpf_map_update_elem(&off_cpu, &key, &delta, BPF=
_ANY);
> > > +             if (delta >=3D offcpu_thresh_ns) {
> >
> > It seems offcpu_thresh_ns is not defined at this moment.  You can use
> > a hard-coded value with a comment for now.
>
> My bad, I wonder how it builds, turns out I put the definition in the
> previous patch... (link:
> https://lore.kernel.org/linux-perf-users/20241212022420.1035999-4-howardc=
hu95@gmail.com/T/#u)
> I will move it to this patch, thanks a lot!
>
> Thanks,
> Howard
