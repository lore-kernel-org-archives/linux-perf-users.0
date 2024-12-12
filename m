Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B641AD9ED;
	Thu, 12 Dec 2024 22:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734043780; cv=none; b=u0fvToBAbVMjhe61d+BtnvnzClgMchV/mxKPdI9tbZ99QjzRwL9RESlBgmre+weXmviCJXBd2gVjnVHh8fP6vatMjDNVY1dLktVeByVP9RIZWYVyxm9fnd68aGnCkwsGi9NJ4enNN3S9On0rFAihgse62Sb/zEtEDQwXNDE8I+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734043780; c=relaxed/simple;
	bh=Ut6emYEgnTXjJVoa5mTZmTYZex+6s7aErqe0nFoqUek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XP4q66l6l0PV/eCNzQzSFb8IDM08G8ZeeXb05cyQLPRYH6h547fLkLUYp5YUrUrVri1tpJsfBuKXjriMW6xrFiKi/+XDOwUU0fm6SxI6vno5ow6ykkx0Ni+4iq5shVB4yhrFnd5Qj7VIsBGuMt1TvIZmqXat1lBC2nTgSZf7nJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RP5JUkJd; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RP5JUkJd"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e3fd6cd9ef7so868340276.1;
        Thu, 12 Dec 2024 14:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734043778; x=1734648578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZ//GKpRnLAq0n73N40bNcMjtU3cwv4lRw3R8oUSpPc=;
        b=RP5JUkJdIANekZuIh/zR0yDFEGk+vP9ZgmrzDtN1zQBVloIG3WOLpLOb/pyFX5DbOi
         kKOoPnfGURJukatcC7Cp08y55xdx1TFFPUQ4AGhNweMI74OwB+KlCPhcRRr2UuFWS9Z6
         p9YUtI0Wgv93O1s6z0gvQF0SSGA50WANHjQufKjT8lc0rC2s6VhWlYeDEm1EIduV+WQ4
         BTlPlKDTDUv0pHLnYkfAytYHPeMmTtt3T36EOLciTEFQ7xEHaSB4eBZjlJ0vFx2HNBxs
         kXLodWEPhWnfSzq8nrzuBUpbVHkUH0gXrSsrgzi+wlEQQDe/PKjgGF/JTZ1k4E/5Yb+o
         mSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734043778; x=1734648578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sZ//GKpRnLAq0n73N40bNcMjtU3cwv4lRw3R8oUSpPc=;
        b=teVQYNUqZLnLJzvcwUMade6T//WTcpb5LTackg5DsBqT4JgpXHmYLoTCEN81wrGg3X
         FI5nGq25UGgeZ3LXKQKg9lwIdY9QLvA+5fUTzslgPz6yr8gfQ4Gwx/U2T/xMeWWrAJYn
         y+Xeqr4PBXpicBrqsDZnf9KpEJKSNbh6/pZ5N2CAO23FYvZGM8pFuJv1jpMyu0N49nC3
         d10wsOvF1MNdV8vJHs9w1S74rlmqckOrFpmhNmoLDkGTYFLOudYStwS4xl7pHJccJIQM
         kxXAyFpuKTInMLOCrtgj3eX5QVJqg0IvySebUOgaQbrGv/WnsOBLZjyBaKmetNYrXWFK
         PDfg==
X-Forwarded-Encrypted: i=1; AJvYcCUj4kSRAJ+1m8tv7MavvraJliqkGYqUbUQOHmSYRwCpeLQ3qaUqT/uF0Fgk5wMJOHczQUHa4CeubtQQWjpVtHpCAQ==@vger.kernel.org, AJvYcCVHzwYJQ7JPKECCOuYHdPi+H0IYjsohVceFvKhp8kSedLocinU0Z71xMwEYmFdsNaJVBi/nqtdKlf4hlIw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6vj/Vu2oSVjvifBzNNKSqwUI8GoX1lbimf9LXl8Op3tFObucT
	u81yXulSK6nSa9rndkPZaruGkahYCMiqJD/CcPfYrwsWJwJFye335EzJf2Ks2izPInrs3aRDcOa
	UzrnY1CQeh0YFUHTXe1OQDbYarJU=
X-Gm-Gg: ASbGncv8i36KqJQHCTW6w8n7odCQwmIDzVC3z0EQsXcGpiduE3dTj+XQt/f1TyGMfw8
	Xj0SHqJuYPwnQNlfKK+YNp0twz5WkAtyDQH4u
X-Google-Smtp-Source: AGHT+IEhTol3z/4jrBZUZIufEWXcXhc69c43GEeH7bsexV7UUfoXp5YzGsRW6jT7FGwA5nSX5Wy5i2eyXHn3yGapPiU=
X-Received: by 2002:a05:6902:1b09:b0:e29:2560:914c with SMTP id
 3f1490d57ef6-e4389bcbb5bmr209029276.9.1734043777748; Thu, 12 Dec 2024
 14:49:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212022420.1035999-1-howardchu95@gmail.com>
 <20241212022420.1035999-5-howardchu95@gmail.com> <Z1tPpZ7HHaF8g4PQ@google.com>
In-Reply-To: <Z1tPpZ7HHaF8g4PQ@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Thu, 12 Dec 2024 14:49:28 -0800
Message-ID: <CAH0uvohN0GPW_ABFUTK7Goo0WXcSRNVhjwabKkhruXM1zB8+hQ@mail.gmail.com>
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

Hello Namhyung,

On Thu, Dec 12, 2024 at 1:03=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> On Wed, Dec 11, 2024 at 06:24:14PM -0800, Howard Chu wrote:
> > Collect tid, period, callchain, and cgroup id and dump them when off-cp=
u
> > time threshold is reached.
> >
> > We don't collect the off-cpu time twice (the delta), it's either in
> > direct samples, or accumulated samples that are dumped at the end of
> > perf.data.
> >
> > Suggested-by: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: James Clark <james.clark@linaro.org>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Kan Liang <kan.liang@linux.intel.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Link: https://lore.kernel.org/r/20241108204137.2444151-6-howardchu95@gm=
ail.com
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/util/bpf_skel/off_cpu.bpf.c | 86 ++++++++++++++++++++++++--
> >  1 file changed, 81 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/b=
pf_skel/off_cpu.bpf.c
> > index c87132e01eb3..aae63d999abb 100644
> > --- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
> > +++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> > @@ -19,11 +19,17 @@
> >  #define MAX_ENTRIES  102400
> >
> >  #define MAX_CPUS  4096
> > +#define MAX_OFFCPU_LEN 37
> > +
> > +struct stack {
> > +     u64 array[MAX_STACKS];
> > +};
> >
> >  struct tstamp_data {
> >       __u32 stack_id;
> >       __u32 state;
> >       __u64 timestamp;
> > +     struct stack stack;
> >  };
> >
> >  struct offcpu_key {
> > @@ -41,6 +47,10 @@ struct {
> >       __uint(max_entries, MAX_ENTRIES);
> >  } stacks SEC(".maps");
> >
> > +struct offcpu_data {
> > +     u64 array[MAX_OFFCPU_LEN];
> > +};
> > +
> >  struct {
> >       __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
> >       __uint(key_size, sizeof(__u32));
> > @@ -48,6 +58,13 @@ struct {
> >       __uint(max_entries, MAX_CPUS);
> >  } offcpu_output SEC(".maps");
> >
> > +struct {
> > +     __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> > +     __uint(key_size, sizeof(__u32));
> > +     __uint(value_size, sizeof(struct offcpu_data));
> > +     __uint(max_entries, 1);
> > +} offcpu_payload SEC(".maps");
> > +
> >  struct {
> >       __uint(type, BPF_MAP_TYPE_TASK_STORAGE);
> >       __uint(map_flags, BPF_F_NO_PREALLOC);
> > @@ -194,6 +211,47 @@ static inline int can_record(struct task_struct *t=
, int state)
> >       return 1;
> >  }
> >
> > +static inline int copy_stack(struct stack *from, struct offcpu_data *t=
o, int n)
> > +{
> > +     int len =3D 0;
> > +
> > +     for (int i =3D 0; i < MAX_STACKS && from->array[i]; ++i, ++len)
> > +             to->array[n + 2 + i] =3D from->array[i];
> > +
> > +     return len;
> > +}
> > +
> > +/**
> > + * off_cpu_dump - dump off-cpu samples to ring buffer
> > + * @data: payload for dumping off-cpu samples
> > + * @key: off-cpu data
> > + * @stack: stack trace of the task before being scheduled out
> > + *
> > + * If the threshold of off-cpu time is reached, acquire tid, period, c=
allchain, and cgroup id
> > + * information of the task, and dump it as a raw sample to perf ring b=
uffer
> > + */
> > +static int off_cpu_dump(void *ctx, struct offcpu_data *data, struct of=
fcpu_key *key,
> > +                     struct stack *stack, __u64 delta)
> > +{
> > +     int n =3D 0, len =3D 0;
> > +
> > +     data->array[n++] =3D (u64)key->tgid << 32 | key->pid;
> > +     data->array[n++] =3D delta;
> > +
> > +     /* data->array[n] is callchain->nr (updated later) */
> > +     data->array[n + 1] =3D PERF_CONTEXT_USER;
> > +     data->array[n + 2] =3D 0;
> > +     len =3D copy_stack(stack, data, n);
> > +
> > +     /* update length of callchain */
> > +     data->array[n] =3D len + 1;
> > +     n +=3D len + 2;
> > +
> > +     data->array[n++] =3D key->cgroup_id;
> > +
> > +     return bpf_perf_event_output(ctx, &offcpu_output, BPF_F_CURRENT_C=
PU, data, n * sizeof(u64));
> > +}
> > +
> >  static int off_cpu_stat(u64 *ctx, struct task_struct *prev,
> >                       struct task_struct *next, int state)
> >  {
> > @@ -218,6 +276,16 @@ static int off_cpu_stat(u64 *ctx, struct task_stru=
ct *prev,
> >       pelem->state =3D state;
> >       pelem->stack_id =3D stack_id;
> >
> > +     /*
> > +      * If stacks are successfully collected by bpf_get_stackid(), col=
lect them once more
> > +      * in task_storage for direct off-cpu sample dumping
> > +      */
> > +     if (stack_id > 0 && bpf_get_stack(ctx, &pelem->stack, MAX_STACKS =
* sizeof(u64), BPF_F_USER_STACK)) {
> > +             /*
> > +              * This empty if block is used to avoid 'result unused wa=
rning' from bpf_get_stack().
> > +              * If the collection fails, continue with the logic for t=
he next task.
> > +              */
> > +     }
> >  next:
> >       pelem =3D bpf_task_storage_get(&tstamp, next, NULL, 0);
> >
> > @@ -232,11 +300,19 @@ static int off_cpu_stat(u64 *ctx, struct task_str=
uct *prev,
> >               __u64 delta =3D ts - pelem->timestamp;
> >               __u64 *total;
> >
> > -             total =3D bpf_map_lookup_elem(&off_cpu, &key);
> > -             if (total)
> > -                     *total +=3D delta;
> > -             else
> > -                     bpf_map_update_elem(&off_cpu, &key, &delta, BPF_A=
NY);
> > +             if (delta >=3D offcpu_thresh_ns) {
>
> It seems offcpu_thresh_ns is not defined at this moment.  You can use
> a hard-coded value with a comment for now.

My bad, I wonder how it builds, turns out I put the definition in the
previous patch... (link:
https://lore.kernel.org/linux-perf-users/20241212022420.1035999-4-howardchu=
95@gmail.com/T/#u)
I will move it to this patch, thanks a lot!

Thanks,
Howard
