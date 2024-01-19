Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE63B28E04
	for <linux-perf-users@vger.kernel.org>; Fri, 19 Jan 2024 00:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705622859; cv=none; b=m29aygjwSSWYm9Wqf8sGgmveAo/B913NcbwXlYAIhaVEa2F7lLVm2u35zcGoO5oQQk6Wtsmu+71+o1KB0VKdxz6av/17rTxRRJj0r0ei2nYahk/6L+ASU+ClPj7M7IqjTQi80W0fVnoupf6Nfu3zBBmSBVEA32yiZfHGed88XE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705622859; c=relaxed/simple;
	bh=2tpFXdUHLYq6vpSJb6t5xz3SjDKWpiEEmbpAupwsgz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=asuDeogoZS9BHmBDuXGmQIcBOQmxVIE7jHkCOKTyegqA8/BMLtIHqK5swuIQQMRsL5Kn0J6dDUKVWg0oftITMaxqTUjHVrbhBaKOPz1ZJ4kCiTXI+qtldU3SLzZJLo4aAk5eDSled9OvuLq7UFNhC67KKd1Sp0vrcZ5wXV1Oe+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=QsxmWnjp; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="QsxmWnjp"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a2e0be86878so247941966b.1
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Jan 2024 16:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1705622855; x=1706227655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6CKyX0pNzi99NBbDT3o8PZvJJ1Dz5/dMYP64jGriCpE=;
        b=QsxmWnjpg67NjyD7Hb7X2VmsBU4DQIS5VOqHHY0N+GxkuV/HHZe1AM3iMpZgj70rjs
         V6Ned/1bTRuFBofmbFa68PrNYNAc3O3tNQXpmvoFUOussULfYyVHxRKuMhaSM+cPokRA
         7lNda6WFE1MSS5K3XT4enM8HEAPu6xBPJHnSX8mg+Nz+5sddRCahW7H1AAvtOuXeYvkr
         +T6EdStltfGElKaDrmboklgyj4oeHmgk/m5dOaBKy5+Dts2otjT2Xf3vYRD3Fst9IiaG
         jAvnUwKaor2nfoZFEy0eQq3iL015XstxN63L8SDs/Lh0Wzp8FB4ep6t2B21Td1cM+Ewe
         JDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705622855; x=1706227655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6CKyX0pNzi99NBbDT3o8PZvJJ1Dz5/dMYP64jGriCpE=;
        b=EJSNil/GWuCccfauLtyH4SdSGHEUVzhFU33Q+acvlLkV4EfhNr1v7moGwyj7rzO7pq
         AQ7IDfnpXo7Qgt/8UAgwLnKYv5xBCUQ4f1VFR2K01Zql2CtBtoiwaDQ6YQine3r6tFNk
         +00uv8Zeo0fG6nyG/ZsKn4pWXaENs7/Q4pZx/78DIEEEyj21a60SkNxp9rdvaWiqFczA
         DRPphQTLdc/aZ52p7a6n9hFNCIUl9C5XgndIo1Hc4GOTOOBrSqosl4aXfHRgPgFwLjjR
         ttphwSqmZnxx/nEEL8Kow2uqZjoEPA9Xe7Wavr8b2B33yjQsuLL5WznwwxapIZbwXgh7
         v3Dw==
X-Gm-Message-State: AOJu0Yz8xxdu2di8S9yWO6slWf+eEpvIKp31e/61CEofoHbCz80KxqU5
	PXjvqw3mU4kfCoL1bUtXtyNPhjUyZ7btnNGCW0AiuSLh7fudXQCTUOPx8Lv97in7AvydJgb0/MB
	JCKpYDllxjeVgYrJSXd6+HaKxgc2L5zHFaInr
X-Google-Smtp-Source: AGHT+IHgoAEVfm+MtfbTClIfy8far75akfY4VQrn/kESNUeUmaZAO7Xfnv1EQQm9ykdRXFK4YhXbAfyINSBmJUwxL+E=
X-Received: by 2002:a17:907:a803:b0:a2c:c519:505f with SMTP id
 vo3-20020a170907a80300b00a2cc519505fmr165621ejc.4.1705622854964; Thu, 18 Jan
 2024 16:07:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211045543.31741-1-khuey@kylehuey.com> <20231211045543.31741-2-khuey@kylehuey.com>
 <CAPhsuW4s5ZaZB0kFz8CWK-NvS4KrE7w90Fzz-wF5WgUMC7dPog@mail.gmail.com>
In-Reply-To: <CAPhsuW4s5ZaZB0kFz8CWK-NvS4KrE7w90Fzz-wF5WgUMC7dPog@mail.gmail.com>
From: Kyle Huey <me@kylehuey.com>
Date: Thu, 18 Jan 2024 16:07:23 -0800
Message-ID: <CAP045AroaWOQW4hNuc7EYM4TBVpgAoq5H6q54ACLp=oGYridJQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] perf/bpf: Call bpf handler directly, not through
 overflow machinery
To: Song Liu <song@kernel.org>
Cc: Kyle Huey <khuey@kylehuey.com>, linux-kernel@vger.kernel.org, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, "Robert O'Callahan" <robert@ocallahan.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 3:05=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Sun, Dec 10, 2023 at 8:55=E2=80=AFPM Kyle Huey <me@kylehuey.com> wrote=
:
> >
> > To ultimately allow bpf programs attached to perf events to completely
> > suppress all of the effects of a perf event overflow (rather than just =
the
> > sample output, as they do today), call bpf_overflow_handler() from
> > __perf_event_overflow() directly rather than modifying struct perf_even=
t's
> > overflow_handler. Return the bpf program's return value from
> > bpf_overflow_handler() so that __perf_event_overflow() knows how to
> > proceed. Remove the now unnecessary orig_overflow_handler from struct
> > perf_event.
> >
> > This patch is solely a refactoring and results in no behavior change.
> >
> > Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> > Suggested-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  include/linux/perf_event.h |  6 +-----
> >  kernel/events/core.c       | 28 +++++++++++++++-------------
> >  2 files changed, 16 insertions(+), 18 deletions(-)
> >
> > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > index 5547ba68e6e4..312b9f31442c 100644
> > --- a/include/linux/perf_event.h
> > +++ b/include/linux/perf_event.h
> > @@ -810,7 +810,6 @@ struct perf_event {
> >         perf_overflow_handler_t         overflow_handler;
> >         void                            *overflow_handler_context;
> >  #ifdef CONFIG_BPF_SYSCALL
> > -       perf_overflow_handler_t         orig_overflow_handler;
> >         struct bpf_prog                 *prog;
> >         u64                             bpf_cookie;
> >  #endif
> > @@ -1337,10 +1336,7 @@ __is_default_overflow_handler(perf_overflow_hand=
ler_t overflow_handler)
> >  #ifdef CONFIG_BPF_SYSCALL
> >  static inline bool uses_default_overflow_handler(struct perf_event *ev=
ent)
> >  {
> > -       if (likely(is_default_overflow_handler(event)))
> > -               return true;
> > -
> > -       return __is_default_overflow_handler(event->orig_overflow_handl=
er);
> > +       return is_default_overflow_handler(event);
> >  }
> >  #else
> >  #define uses_default_overflow_handler(event) \
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index b704d83a28b2..54f6372d2634 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -9515,6 +9515,12 @@ static inline bool sample_is_allowed(struct perf=
_event *event, struct pt_regs *r
> >         return true;
> >  }
> >
> > +#ifdef CONFIG_BPF_SYSCALL
> > +static int bpf_overflow_handler(struct perf_event *event,
> > +                               struct perf_sample_data *data,
> > +                               struct pt_regs *regs);
> > +#endif
> > +
> >  /*
> >   * Generic event overflow handling, sampling.
> >   */
> > @@ -9584,7 +9590,10 @@ static int __perf_event_overflow(struct perf_eve=
nt *event,
> >                 irq_work_queue(&event->pending_irq);
> >         }
> >
> > -       READ_ONCE(event->overflow_handler)(event, data, regs);
> > +#ifdef CONFIG_BPF_SYSCALL
> > +       if (!(event->prog && !bpf_overflow_handler(event, data, regs)))
>
> This condition is hard to follow. Please consider simplifying it.
>
> Thanks,
> Song

It gets simplified later in patch 3/4.

- Kyle

> > +#endif
> > +               READ_ONCE(event->overflow_handler)(event, data, regs);
> >
> >         if (*perf_event_fasync(event) && event->pending_kill) {
> >                 event->pending_wakeup =3D 1;
> > @@ -10394,9 +10403,9 @@ static void perf_event_free_filter(struct perf_=
event *event)
> >  }
> >
> >  #ifdef CONFIG_BPF_SYSCALL
> > -static void bpf_overflow_handler(struct perf_event *event,
> > -                                struct perf_sample_data *data,
> > -                                struct pt_regs *regs)
> > +static int bpf_overflow_handler(struct perf_event *event,
> > +                               struct perf_sample_data *data,
> > +                               struct pt_regs *regs)
> >  {
> >         struct bpf_perf_event_data_kern ctx =3D {
> >                 .data =3D data,
> > @@ -10417,10 +10426,8 @@ static void bpf_overflow_handler(struct perf_e=
vent *event,
> >         rcu_read_unlock();
> >  out:
> >         __this_cpu_dec(bpf_prog_active);
> > -       if (!ret)
> > -               return;
> >
> > -       event->orig_overflow_handler(event, data, regs);
> > +       return ret;
> >  }
> >
> >  static int perf_event_set_bpf_handler(struct perf_event *event,
> > @@ -10456,8 +10463,6 @@ static int perf_event_set_bpf_handler(struct pe=
rf_event *event,
> >
> >         event->prog =3D prog;
> >         event->bpf_cookie =3D bpf_cookie;
> > -       event->orig_overflow_handler =3D READ_ONCE(event->overflow_hand=
ler);
> > -       WRITE_ONCE(event->overflow_handler, bpf_overflow_handler);
> >         return 0;
> >  }
> >
> > @@ -10468,7 +10473,6 @@ static void perf_event_free_bpf_handler(struct =
perf_event *event)
> >         if (!prog)
> >                 return;
> >
> > -       WRITE_ONCE(event->overflow_handler, event->orig_overflow_handle=
r);
> >         event->prog =3D NULL;
> >         bpf_prog_put(prog);
> >  }
> > @@ -11928,13 +11932,11 @@ perf_event_alloc(struct perf_event_attr *attr=
, int cpu,
> >                 overflow_handler =3D parent_event->overflow_handler;
> >                 context =3D parent_event->overflow_handler_context;
> >  #if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_EVENT_TRACING)
> > -               if (overflow_handler =3D=3D bpf_overflow_handler) {
> > +               if (parent_event->prog) {
> >                         struct bpf_prog *prog =3D parent_event->prog;
> >
> >                         bpf_prog_inc(prog);
> >                         event->prog =3D prog;
> > -                       event->orig_overflow_handler =3D
> > -                               parent_event->orig_overflow_handler;
> >                 }
> >  #endif
> >         }
> > --
> > 2.34.1
> >
> >
