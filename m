Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CC82848B2
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 21:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769549355; cv=pass; b=i34rJoZu27BLcnqX/4iUA3XvOovLzZ8wCsMdpHtBiPKOuLyh4NB66jlBwLhsJ9ZSy6A89mS8QJz3mp84mZOE5K1ZjENG4Zv5tZ0XjYTDKgorNJq1wgJQJJLAvFfnO1tRljwPSStYmk4P0CVE02sGe6izWnbY3ueplr1GJ4bNzEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769549355; c=relaxed/simple;
	bh=+I3JGUsur/mZ2zleWX8sGVHHTi+cYv9I31JZ2RQCgQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gJ0ADnrn//nqxdVvQjXiC2FOkO0Zo8B2GFf8vjmXZPQcHn8bdYh9OfnM9KOFd4kOWKUtVyB2iPeNN6bgeqKZHmNVplLnQISK0VmuXPPfOzvSLesQoPqb8iYOCJHAVirA4Okx2p7IOa7dPTvPtFR9xWhaXzQHCra6IYm1jMw7bf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=AnztNdi5; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="AnztNdi5"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-34c2f335681so2901552a91.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 13:29:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769549351; cv=none;
        d=google.com; s=arc-20240605;
        b=aUzPn2139/oa+XlJ9HzSKnMfHUrKWp1IVds9vHCn2T2x3I0yfAJrSpV+sxgiM6/+MJ
         SQMNr8B2BwgqOg7naFqH0geV9/0TnmiFItJ0oTCTi249LwhtwIXdlcvWMec+BhFDwsid
         bpuQgFzb2LNwr85j7g+vZzxI2wXpI/SXEmbamcmubNcX18sV5Pn+wfJSu1/xIMLvh+LR
         L20JqWYFKqJ3QR1duoN0KO0y4PqD18VtxrS57uipSCrzPWaPIoD7ZvvL1ssCTmDhyjvD
         hhlkFZ4yD3il2kgKXmWckIUyQu/BpDeCtOK6V7MnGsRloB0vkxJiJFQuMSrrj9InN6qk
         AZHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0rlFJUmOrPIItenOCIzMcTKZDat4D/65xQLGADuGob0=;
        fh=mhuTt08wF58gZafZS1Rmo5KeCjM2SZzwMIvie6kM8Ns=;
        b=bVDnjXR/ESh+mW6F5lnDrlM3SL3Z3Ki4b62rWePHlcFF6hH1wZEHKgzBgQwlnLyw3i
         hKyGZKH/cJKtkzNaJxjbyt1+F/8SMczC0uhaxFPdZEKmM5b4m0DKC8pNt7L0upzkUk1+
         pOUMfPU+0Rh6nFKZNE86/GyazZ1UCCVvczGIJt1KwHKj8uXAOzkhlFIUFAtyv3bhQmJT
         +41zaA3l+tY5eiRcKhBpyVpCxYwKd1q+F2fkn1GBd+DN6sduETzpvbnB8lVhY4+v32uV
         1+X7D53dWGQApDz/fL2H/iU9yYa/+PBhq2TpWexZ59v9h3teQWVA800dbBqqG5pjuRS/
         XZww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1769549351; x=1770154151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rlFJUmOrPIItenOCIzMcTKZDat4D/65xQLGADuGob0=;
        b=AnztNdi58p7ZeMTrmgaHZ9fF1afS0elib09YIatnTZnzC9e7yrdLWNWoBi4pHydlKw
         setTetD2srHZkZUmhiLaVE1FYcfXsGp46u0O8rmmiXP9a5ntzoUYkPVTBNgX8bDaSuXQ
         C8bCl45A69OSjjzJlDRMwv2XXx0WuNNJisbb5CT7k6vHSlhx0Gnw8rKHjsfKwR9D3pW4
         PH6biOGIqExu1/aejOhuBLpmd5VrMnac79z84xRjEad+hIJNdP0+Ow8Vusc6hwMyHY7m
         xUhip+zH9gME2oiNQMMZF1ktfMRFCTs6m4DSkeRyeQVfxR6BrEjf9mZ0yuydNBpJaLIX
         eKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769549351; x=1770154151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0rlFJUmOrPIItenOCIzMcTKZDat4D/65xQLGADuGob0=;
        b=padB26gm9jl8C/6ufLBX6HApUtEC2n4vXx6Xj7nn+oe1uA66cknCUlleCGuHqpJbr+
         dQqyhQ2EUWaotfA6I1KG/vllnmNKm4bcYA7SAMszy1WEy9uQ21cTYCfdHVUCRHrrZKqG
         2iUYXCKMAoonIGuPf41yFvqhISORE2+gLkJRODCsY05IU0aulMzW4o3jUmBmiWbU/Fco
         FrzSSjWdNnmB4spnSIveuPCPlGMs/Po0uKCtYSZHpKtYDf8CIz969VIF8VDNwd0dyldf
         jDU+B5+mwLKOn2OWDciTOHgXtDndyzjwRxlhQKzRC30kxh1wyKFNtzlePICpEWJ2qsiK
         A6DA==
X-Forwarded-Encrypted: i=1; AJvYcCX17h9nCwbRvAUXo54KnxaDc8UlXnd+S5isZQRVM0/Zrw829Vp57J0osadmvjTJq3RwcHlZshktxEkRM2SB9Jgl@vger.kernel.org
X-Gm-Message-State: AOJu0YxTZN0yoZue0hqQy1BqkrCO/SINllx4aOutsNty2pP2xAgchI4y
	o66k/Tl5dTDw9Pbq/QRLcC/YOdv0mqjbwNG/1ZVCKR90YDZI8LuzVhW4DUZ/IhYjXB/QB/uPGQs
	3pzFlq+Uftnnb0qCa4uMt+2lY0pH7/9eGEfAwmuGx1w==
X-Gm-Gg: AZuq6aJWMDcO6vjYz7i1Uu9G6/fn7kbqJ5fgQQv+t2IOFrnpza/IXqCPugMIQv66e6P
	uyaw17DWdQ79BkSXwj7hZDBcOCXfpSunrHTdWd7ZZRnYLXtrnqpAvXGaf9eVFaaagbEcFgWLhec
	VIRSan2+iI9OxbRyQLHkINBkFZtdITk6E/NIupPRAHJwgZtPIbrcHmlVdWgzNz0YDRQhTfZcf2b
	GvSbnNn/gPvtRHjCuRhsbOmfz7qBgGr/2vXaMkPvo9o/Pk4gwhvyEOltuP5TdrsMjCS2ys=
X-Received: by 2002:a17:90b:518e:b0:336:b60f:3936 with SMTP id
 98e67ed59e1d1-353fecde76fmr2988743a91.12.1769549351506; Tue, 27 Jan 2026
 13:29:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127023618.1469937-1-zeri@umich.edu> <20260127103613.1407024-1-wangqing7171@gmail.com>
In-Reply-To: <20260127103613.1407024-1-wangqing7171@gmail.com>
From: Henry Zhang <zeri@umich.edu>
Date: Tue, 27 Jan 2026 16:29:00 -0500
X-Gm-Features: AZwV_QiKIBVLF7qqFTHhiK_ZIWPfzgsU_bEIuTalrmkBUH4IqKhy0MUJptPmb8g
Message-ID: <CACkPEmne--T_3bdwJEy8-GEYm4EJF60xSoqbrQ-m_LuZhJhCuQ@mail.gmail.com>
Subject: Re: [PATCH] perf: Fix data race in perf_event_set_bpf_handler()
To: Qing Wang <wangqing7171@gmail.com>
Cc: henryzhangjcle@gmail.com, acme@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	syzbot+2a077cb788749964cf68@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, this looks good.

--
Henry

On Tue, Jan 27, 2026 at 5:36=E2=80=AFAM Qing Wang <wangqing7171@gmail.com> =
wrote:
>
> On Tue, 27 Jan 2026 at 16:37, Qing Wang <wangqing7171@gmail.com> wrote:
> > On Tue, 27 Jan 2026 at 10:36, Henry Zhang <henryzhangjcle@gmail.com> wr=
ote:
> > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > index a0fa488bce84..1f3ed9e87507 100644
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -10349,7 +10349,7 @@ static inline int perf_event_set_bpf_handler(=
struct perf_event *event,
> > >             return -EPROTO;
> > >     }
> > >
> > > -   event->prog =3D prog;
> > > +   WRITE_ONCE(event->prog, prog);
> > >     event->bpf_cookie =3D bpf_cookie;
> > >     return 0;
> > >  }
> > > @@ -10407,7 +10407,9 @@ static int __perf_event_overflow(struct perf_=
event *event,
> > >     if (event->attr.aux_pause)
> > >             perf_event_aux_pause(event->aux_event, true);
> > >
> > > -   if (event->prog && event->prog->type =3D=3D BPF_PROG_TYPE_PERF_EV=
ENT &&
> > > +   struct bpf_prog *prog =3D READ_ONCE(event->prog);
> > > +
> > > +   if (prog && prog->type =3D=3D BPF_PROG_TYPE_PERF_EVENT &&
> > >         !bpf_overflow_handler(event, data, regs))
> > >             goto out;
> >
> > Looking at this code, I guess there may be an serious issue: a potentia=
l
> > use-after-free (UAF) risk when accessing event->prog in __perf_event_ov=
erflow.
> >
> > CPU 0 (interrupt context)               CPU 1 (process context)
> > read event->prog
> >                                         perf_event_free_bpf_handler()
> >                                             put(prog)
> >                                                 free(prog)
> > access memory pointed to by prog
> >
> > This scenario need to be more analysis.
> >
> > --
> > Qing
>
> This is my idea for solving the problem of data competition and potential=
 UAF.
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index a0fa488bce84..3abf3689157d 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10291,7 +10291,12 @@ static inline bool sample_is_allowed(struct perf=
_event *event, struct pt_regs *r
>  }
>
>  #ifdef CONFIG_BPF_SYSCALL
> +/*
> + * Execute the attached BPF program. Caller must ensure prog is non-NULL
> + * and of type BPF_PROG_TYPE_PERF_EVENT under RCU protection.
> + */
>  static int bpf_overflow_handler(struct perf_event *event,
> +                               struct bpf_prog *prog,
>                                 struct perf_sample_data *data,
>                                 struct pt_regs *regs)
>  {
> @@ -10299,22 +10304,17 @@ static int bpf_overflow_handler(struct perf_eve=
nt *event,
>                 .data =3D data,
>                 .event =3D event,
>         };
> -       struct bpf_prog *prog;
>         int ret =3D 0;
>
>         ctx.regs =3D perf_arch_bpf_user_pt_regs(regs);
>         if (unlikely(__this_cpu_inc_return(bpf_prog_active) !=3D 1))
>                 goto out;
> -       rcu_read_lock();
> -       prog =3D READ_ONCE(event->prog);
> -       if (prog) {
> -               perf_prepare_sample(data, event, regs);
> -               ret =3D bpf_prog_run(prog, &ctx);
> -       }
> -       rcu_read_unlock();
> +
> +       perf_prepare_sample(data, event, regs);
> +       ret =3D bpf_prog_run(prog, &ctx);
> +
>  out:
>         __this_cpu_dec(bpf_prog_active);
> -
>         return ret;
>  }
>
> @@ -10349,7 +10349,7 @@ static inline int perf_event_set_bpf_handler(stru=
ct perf_event *event,
>                 return -EPROTO;
>         }
>
> -       event->prog =3D prog;
> +       WRITE_ONCE(event->prog, prog);
>         event->bpf_cookie =3D bpf_cookie;
>         return 0;
>  }
> @@ -10361,13 +10361,14 @@ static inline void perf_event_free_bpf_handler(=
struct perf_event *event)
>         if (!prog)
>                 return;
>
> -       event->prog =3D NULL;
> +       WRITE_ONCE(event->prog, NULL);
>         bpf_prog_put(prog);
>  }
>  #else
>  static inline int bpf_overflow_handler(struct perf_event *event,
> -                                      struct perf_sample_data *data,
> -                                      struct pt_regs *regs)
> +                               struct bpf_prog *prog,
> +                               struct perf_sample_data *data,
> +                               struct pt_regs *regs)
>  {
>         return 1;
>  }
> @@ -10407,9 +10408,19 @@ static int __perf_event_overflow(struct perf_eve=
nt *event,
>         if (event->attr.aux_pause)
>                 perf_event_aux_pause(event->aux_event, true);
>
> -       if (event->prog && event->prog->type =3D=3D BPF_PROG_TYPE_PERF_EV=
ENT &&
> -           !bpf_overflow_handler(event, data, regs))
> +       /*
> +        * For BPF-based overflow handling. If a BPF_PROG_TYPE_PERF_EVENT
> +        * program is attached, execute it and skip default overflow hand=
ling.
> +        */
> +       rcu_read_lock();
> +       struct bpf_prog *prog =3D rcu_dereference(event->prog);
> +
> +       if (prog && prog->type =3D=3D BPF_PROG_TYPE_PERF_EVENT &&
> +           !bpf_overflow_handler(event, prog, data, regs)) {
> +               rcu_read_unlock();
>                 goto out;
> +       }
> +       rcu_read_unlock();
>
>         /*
>          * XXX event_limit might not quite work as expected on inherited
>
> What do you think about this solution? Looking forward to your review.
> --
> Qing
