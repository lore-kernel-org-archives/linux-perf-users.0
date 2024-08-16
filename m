Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65601BF32B;
	Fri, 16 Aug 2024 17:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723829163; cv=none; b=q+SHpTHvqzYrrLpSPW/lOtO4pglrSvEUJ9DF+zMOT5aJgNt8qak6fQ6XoXJknfefHS5bRKgMr0Ks9JakGuOyI2gu1guyiTlCKYze18yOoCvL3Y9F1Kq2Fj+spK+XZ83+36D6qLgy1LPfZiQivwM8v76y2/3shM8btcbIzxZqAJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723829163; c=relaxed/simple;
	bh=3nQvv8Als6rOPUcJ7zrtdi1QMhsT3TgoiQ/Du/9Z6PI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RWLF/gMPuE87ACbEkAQjbgbHUEvyzhtt1d7VC35a9Pdpzia3/C73KrN84cqXre498TLuj500byFQKJtZokQ+LUsrRe5Bbysr+rx6isx+IR7j1CUDUdtHlMlCk84+JerMt35sZq5tyANrcv+AI1aY/8YI32MQRkSUOeIt/OjDjVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akNMUqJ4; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akNMUqJ4"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-66a048806e6so23368507b3.3;
        Fri, 16 Aug 2024 10:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723829160; x=1724433960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBIyOaQDlB5W56TivbiL02BLcb9MzJxBkMYceNa+hKQ=;
        b=akNMUqJ4Nb3FVSdTPTWf9hw7t6fsGFjPryF9iFUQjxy0fNScG/WmTAI1Vs1g/XOoW3
         UAtBGQHAjuC0ubu+ahXt8SBAIio4V8cKyrYOaMdPnD6cYmJKuUlV/Gbrhn1+ooNOjGiW
         kSeu4Xj5DGBXEGRUqXNbTrCtZqAwSBvzWFPaYyQlvlDjlpg47bDeGUHCgXo51P614cfR
         96HiVaBkQI/EdlMYu0lg0wECMed7t13XgracZw0Ny9sj/hKyWb7TMK5odtbJ3LbaVF2k
         6n/YcCsC/I/PyxSxKjw3lX086WYV9sQuKqKCMYxLHRPf3XZnLOY/PGtQp4nXxtzsb4w0
         XLPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723829160; x=1724433960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OBIyOaQDlB5W56TivbiL02BLcb9MzJxBkMYceNa+hKQ=;
        b=ndZf9HPqM8sjKSmpHSXIvKTu9/JNDYdU+2xYm5LNBL2NaiEXygxVBTTfMJekg2sIsS
         NlG8ICFJY+I6Fklyx+h43GOGgj8ngGYO37u/Y/h8PG2ighv4TZ6q6UkEUbczgopRpf3Y
         d9Qo9iPVbCl4Y5whpFRPEz01RMcBe45+cB27481qDmXAk34U/gjaTc4wuo2vC0CQLavE
         qj0oWbRt6/u/CIz5NYjOee9JcCGEI31PW22DQboKwJV6adRn/LbUlaSqlrCFp/lLGTVp
         QrLlHkN6eUHD+8kdYK4RbPz8aJ9mWa01+B0KNaNhzKEtuEb8g85z0tEylRaGycR+B5uu
         pnPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBHG1EmFHIk+kEiasunSwCfS6pQ1NP8oz5FduFjj5L4T53Ar+eynhdhKXgVN5gIGyJkcq6NUeChb0D5zy8Bh2JcwCQ3BVwB7amn0N1YGxmPd9XpTHMz+4gYjZ0jefvGFiK1BD9WqK8BKi4BakBYg==
X-Gm-Message-State: AOJu0Ywvd48sdDnd0T0AcrIaPztEH8n45XUR4wsTv8g7kKSX7dyH7Qzv
	GyPJYivEDxayw5LQ8IJ3iEw8i78+YvHP9GFqmLqEnXBMi44sZcqd2L3PghwxAaYZ8fFufGb2TJD
	jCipk7UQ/z6mZZg7wfWjUpkIvlYo=
X-Google-Smtp-Source: AGHT+IHaGTU484NjDJUhst9NOuSOvYfKH06kYzmoqxmm8uR0lfHkCKiTAq8JygM4CUALyx4SxogkYW2eDoe5xPQBOnk=
X-Received: by 2002:a05:690c:6009:b0:6b0:cd9d:8f5c with SMTP id
 00721157ae682-6b1bb28f34emr43744817b3.29.1723829159719; Fri, 16 Aug 2024
 10:25:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815013626.935097-1-howardchu95@gmail.com>
 <20240815013626.935097-2-howardchu95@gmail.com> <CAP-5=fXCt4axmdjqDZXZzjW-gZK_KZ8R--OTR-M1sZYxZ94k5A@mail.gmail.com>
 <Zr9ntEtIvseYwG90@x1>
In-Reply-To: <Zr9ntEtIvseYwG90@x1>
From: Howard Chu <howardchu95@gmail.com>
Date: Sat, 17 Aug 2024 01:25:48 +0800
Message-ID: <CAH0uvoggxJZYaYAiWuUt-i+0rx24yZNA2hCCjVcbYMmZ7=BAyg@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] perf trace: Fix perf trace -p <PID>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	adrian.hunter@intel.com, jolsa@kernel.org, kan.liang@linux.intel.com, 
	namhyung@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Thanks to Namhyung Kim <namhyung@kernel.org>, this bug is fixed. There
is no problem in BPF, sorry for causing the trouble.

Thanks,
Howard

On Fri, Aug 16, 2024 at 10:52=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, Aug 15, 2024 at 11:28:17AM -0700, Ian Rogers wrote:
> > On Wed, Aug 14, 2024 at 6:36=E2=80=AFPM Howard Chu <howardchu95@gmail.c=
om> wrote:
> > >
> > > perf trace -p <PID> work on a syscall that is unaugmented, but doesn'=
t
> > > work on a syscall that's augmented (when it calls perf_event_output()=
 in
> > > BPF).
> > >
> > > Let's take open() as an example. open() is augmented in perf trace.
> > >
> > > Before:
> > > ```
> > > perf $ perf trace -e open -p 3792392
> > >          ? (         ):  ... [continued]: open())                    =
                         =3D -1 ENOENT (No such file or directory)
> > >          ? (         ):  ... [continued]: open())                    =
                         =3D -1 ENOENT (No such file or directory)
> > > ```
> > >
> > > We can see there's no output.
> > >
> > > After:
> > > ```
> > > perf $ perf trace -e open -p 3792392
> > >      0.000 ( 0.123 ms): a.out/3792392 open(filename: "DINGZHEN", flag=
s: WRONLY)                             =3D -1 ENOENT (No such file or direc=
tory)
> > >   1000.398 ( 0.116 ms): a.out/3792392 open(filename: "DINGZHEN", flag=
s: WRONLY)                             =3D -1 ENOENT (No such file or direc=
tory)
> > > ```
> > >
> > > Reason:
> > >
> > > bpf_perf_event_output() will fail when you specify a pid in perf trac=
e (EOPNOTSUPP).
>
> Trying to figure out why it returns EOPNOTSUPP:
>
> static __always_inline u64
> __bpf_perf_event_output(struct pt_regs *regs, struct bpf_map *map,
>                         u64 flags, struct perf_sample_data *sd)
> {
>         struct bpf_array *array =3D container_of(map, struct bpf_array, m=
ap);
>         unsigned int cpu =3D smp_processor_id();
>         u64 index =3D flags & BPF_F_INDEX_MASK;
>         struct bpf_event_entry *ee;
>         struct perf_event *event;
>
>         if (index =3D=3D BPF_F_CURRENT_CPU)
>                 index =3D cpu;
>         if (unlikely(index >=3D array->map.max_entries))
>                 return -E2BIG;
>
>         ee =3D READ_ONCE(array->ptrs[index]);
> <SNIP>
>         if (unlikely(event->oncpu !=3D cpu))
>                 return -EOPNOTSUPP;
>
>         return perf_event_output(event, sd, regs);
> }
>
> =E2=AC=A2[acme@toolbox perf-tools-next]$ git grep -- '->oncpu'
> arch/x86/kvm/vmx/pmu_intel.c:    *   cpu pinned event reclaims LBR, the e=
vent->oncpu will be set to -1;
> kernel/events/core.c:   event->oncpu =3D -1;
> kernel/events/core.c:   WRITE_ONCE(event->oncpu, smp_processor_id());
> kernel/events/core.c:    * ->oncpu if it sees ACTIVE.
> kernel/events/core.c:           event->oncpu =3D -1;
> kernel/events/core.c:   if (READ_ONCE(event->oncpu) !=3D smp_processor_id=
())
> kernel/events/core.c:            * inactive here (event->oncpu=3D=3D-1), =
there's nothing more to do;
> kernel/events/core.c:           ret =3D cpu_function_call(READ_ONCE(event=
->oncpu),
> kernel/events/core.c:   event_oncpu =3D __perf_event_read_cpu(event, even=
t->oncpu);
> kernel/events/core.c:            * Orders the ->state and ->oncpu loads s=
uch that if we see
> kernel/events/core.c:            * ACTIVE we must also see the right ->on=
cpu.
> kernel/events/core.c:           event_cpu =3D READ_ONCE(event->oncpu);
> kernel/events/core.c:   int cpu =3D READ_ONCE(event->oncpu);
> kernel/events/core.c:   if (WARN_ON_ONCE(READ_ONCE(sampler->oncpu) !=3D s=
mp_processor_id()))
> kernel/events/core.c:                   cpu =3D READ_ONCE(iter->oncpu);
> kernel/events/core.c:   event->oncpu            =3D -1;
> kernel/trace/bpf_trace.c:       if (unlikely(event->oncpu !=3D cpu))
> =E2=AC=A2[acme@toolbox perf-tools-next]$
>
> This looks like a bug, no? It seems what this patch is doing is papering
> onver that bug :-\
>
> Alexei, Peter?
>
> That part in the cset introducing bpf_perf_output_event() says:
>
> "User space needs to perf_event_open() it (either for one or all cpus)"
>
> -1 should mean all cpus, right, or is bpf_perf_event_output() only
> supported if we do as Howard did in this patch?
>
> ---
> commit a43eec304259a6c637f4014a6d4767159b6a3aa3
> Author: Alexei Starovoitov <ast@kernel.org>
> Date:   Tue Oct 20 20:02:34 2015 -0700
>
>     bpf: introduce bpf_perf_event_output() helper
>
>     This helper is used to send raw data from eBPF program into
>     special PERF_TYPE_SOFTWARE/PERF_COUNT_SW_BPF_OUTPUT perf_event.
>     User space needs to perf_event_open() it (either for one or all cpus)=
 and
>     store FD into perf_event_array (similar to bpf_perf_event_read() help=
er)
>     before eBPF program can send data into it.
> ---
>
> We're missing something, can you help?
>
> - Arnaldo
>
> > > When using perf trace -p 114, before perf_event_open(), we'll have PI=
D
> > > =3D 114, and CPU =3D -1.
> > >
> > > This is bad for bpf-output event, because the ring buffer won't accep=
t
> > > output from BPF's perf_event_output(), making it fail. I'm still tryi=
ng
> > > to find out why.
> > >
> > > If we open bpf-output for every cpu, instead of setting it to -1, lik=
e
> > > this:
> > > PID =3D <PID>, CPU =3D 0
> > > PID =3D <PID>, CPU =3D 1
> > > PID =3D <PID>, CPU =3D 2
> > > PID =3D <PID>, CPU =3D 3
> > > ...
> > >
> > > Everything works.
> > >
> > > You can test it with this script:
> > > ```
> > >  #include <unistd.h>
> > >  #include <sys/syscall.h>
> > >
> > > int main()
> > > {
> > >         int i1 =3D 1, i2 =3D 2, i3 =3D 3, i4 =3D 4;
> > >         char s1[] =3D "DINGZHEN", s2[] =3D "XUEBAO";
> > >
> > >         while (1) {
> > >                 syscall(SYS_open, s1, i1, i2);
> > >                 sleep(1);
> > >         }
> > >
> > >         return 0;
> > > }
> > > ```
> > >
> > > save, compile
> > > ```
> > > gcc open.c
> > > ```
> > >
> > > perf trace
> > > ```
> > > perf trace -e open <path-to-the-executable>
> > > ```
> > >
> > > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > > ---
> > >  tools/perf/util/evlist.c | 14 +++++++++++++-
> > >  tools/perf/util/evlist.h |  1 +
> > >  2 files changed, 14 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> > > index c0379fa1ccfe..f14b7e6ff1dc 100644
> > > --- a/tools/perf/util/evlist.c
> > > +++ b/tools/perf/util/evlist.c
> > > @@ -1067,7 +1067,7 @@ int evlist__create_maps(struct evlist *evlist, =
struct target *target)
> > >         if (!threads)
> > >                 return -1;
> > >
> > > -       if (target__uses_dummy_map(target))
> > > +       if (target__uses_dummy_map(target) && !evlist__has_bpf_output=
(evlist))
> >
> > I'm wondering if there should be a comment above this, something like:
> >
> > Do we need the "any"/-1 CPU value or do we need to open an event on
> > all target CPUs (the default NULL implies all online CPUs). The dummy
> > map indicates that we need sideband perf record events in order to
> > symbolize samples. The mmap-ed ring buffers need CPUs. Similarly BPF
> > output events need ring buffers.
> >
> > I'm not 100% on the ring buffer perf_event_open restrictions, and the
> > man page doesn't cover it, my knowledge is implied from failures and
> > seeing what the tool does.
> >
> > Thanks,
> > Ian
> >
> >
> > >                 cpus =3D perf_cpu_map__new_any_cpu();
> > >         else
> > >                 cpus =3D perf_cpu_map__new(target->cpu_list);
> > > @@ -2627,3 +2627,15 @@ void evlist__uniquify_name(struct evlist *evli=
st)
> > >                 }
> > >         }
> > >  }
> > > +
> > > +bool evlist__has_bpf_output(struct evlist *evlist)
> > > +{
> > > +       struct evsel *evsel;
> > > +
> > > +       evlist__for_each_entry(evlist, evsel) {
> > > +               if (evsel__is_bpf_output(evsel))
> > > +                       return true;
> > > +       }
> > > +
> > > +       return false;
> > > +}
> > > diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> > > index b46f1a320783..bcc1c6984bb5 100644
> > > --- a/tools/perf/util/evlist.h
> > > +++ b/tools/perf/util/evlist.h
> > > @@ -447,5 +447,6 @@ int evlist__scnprintf_evsels(struct evlist *evlis=
t, size_t size, char *bf);
> > >  void evlist__check_mem_load_aux(struct evlist *evlist);
> > >  void evlist__warn_user_requested_cpus(struct evlist *evlist, const c=
har *cpu_list);
> > >  void evlist__uniquify_name(struct evlist *evlist);
> > > +bool evlist__has_bpf_output(struct evlist *evlist);
> > >
> > >  #endif /* __PERF_EVLIST_H */
> > > --
> > > 2.45.2
> > >
