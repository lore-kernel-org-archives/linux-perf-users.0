Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FBC3239
	for <linux-perf-users@vger.kernel.org>; Mon, 30 Oct 2023 13:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB39C6;
	Mon, 30 Oct 2023 06:19:42 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-991c786369cso714745966b.1;
        Mon, 30 Oct 2023 06:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698671980; x=1699276780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=drQC3BeAXD9K/YjGx7Sswu2ZblzUFSxPPpFTVHOZhnQ=;
        b=ZB/YqeLQ98BjUwoxirmiLpuniHkKmjEyNuxiH1SHqK9Mbjc5lGNg+bPBFw6tXAGi4z
         W3YNOF58gEkF9eIu1Xmly2IEVkPLnGwQf1ZecQZIzKMZrv3mA7fJFKwNxmzN7yID22T2
         4TslXfSPfkWmIu0jCdHq04nZiZb849jnaYvnjzvVpgjTm8b9AgwFGNwQ67ePI4axSo6D
         1kdcxbQAD5dYtCTVjGiwW/iFhjVPSOffaXWarV+93FqH6nRUq56txAo+TYkooWTar14B
         YvqrRooIW211bwICd0oDiQDroc4mdHD20OIHnn+dfG7or5mPOeepCT0v78leUwv1bzgN
         jaTA==
X-Gm-Message-State: AOJu0YzTZtnz6iAeUClGGomUXtoVJx5pL6OkGyh9gYDBXnl9k8XP6HBN
	w5r/eBDLx4GcOx4FgOu/H3X1aamy2kfsCKT/
X-Google-Smtp-Source: AGHT+IFMmINhd3CdH6Kr8TmP3fblNK+IQ8UW9ZiVtKi/FTOgB7B3r+KOvEQLgq1moXgs02b79pIjIw==
X-Received: by 2002:a17:907:9449:b0:9ba:b5:e6b7 with SMTP id dl9-20020a170907944900b009ba00b5e6b7mr8166389ejc.7.1698671980423;
        Mon, 30 Oct 2023 06:19:40 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id n11-20020a170906b30b00b00989828a42e8sm5921042ejz.154.2023.10.30.06.19.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 06:19:40 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-53ed4688b9fso6825806a12.0;
        Mon, 30 Oct 2023 06:19:39 -0700 (PDT)
X-Received: by 2002:a17:907:7f0d:b0:9b9:f46f:8925 with SMTP id
 qf13-20020a1709077f0d00b009b9f46f8925mr8769834ejc.48.1698671979792; Mon, 30
 Oct 2023 06:19:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO8sHcn3+_qrnvp0580aK7jN0Wion5F7KYeBAa4MnCY4mqABPA@mail.gmail.com>
 <20231026145659.7063-A-hca@linux.ibm.com> <CAO8sHckF_D+SjvGySsGHOpOcdy6y7pwQEF9SfV3sw4Ye4_sCKA@mail.gmail.com>
 <20231027100925.9071-B-hca@linux.ibm.com> <CAEg-Je9+UnVsC9e_yDQmXTLNfZy+b42Smj3xobhTE5DiQjk_hA@mail.gmail.com>
 <20231030123558.10816-A-hca@linux.ibm.com>
In-Reply-To: <20231030123558.10816-A-hca@linux.ibm.com>
From: Neal Gompa <ngompa@fedoraproject.org>
Date: Mon, 30 Oct 2023 09:19:02 -0400
X-Gmail-Original-Message-ID: <CAEg-Je_eyVRFmtCtAH+BLvqfPut3LtZQL7NFASzv7Er=iJjqAw@mail.gmail.com>
Message-ID: <CAEg-Je_eyVRFmtCtAH+BLvqfPut3LtZQL7NFASzv7Er=iJjqAw@mail.gmail.com>
Subject: Re: s390x stack unwinding with perf?
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andreas Krebbel <krebbel@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Davide Cavalca <dcavalca@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 9:02=E2=80=AFAM Heiko Carstens <hca@linux.ibm.com> =
wrote:
>
> On Fri, Oct 27, 2023 at 11:22:42AM -0400, Neal Gompa wrote:
> > On Fri, Oct 27, 2023 at 6:10=E2=80=AFAM Heiko Carstens <hca@linux.ibm.c=
om> wrote:
> > >
> > > On Fri, Oct 27, 2023 at 10:00:53AM +0200, Daan De Meyer wrote:
> > > >
> > > > If the kernel gets support for s390x user space unwinding using the=
 backchain,
> > > > we'll propose to enable -mbackchain in the default compilation flag=
s for Fedora
> > > > so that s390x on Fedora will have the same profiling experience as =
x86-64, arm64
> > > > and ppc64. For now we'll keep the status quo since compiling with t=
he backchain
> > > > doesn't provide any benefit until the kernel unwinder can unwind us=
er
> > > > space stacks
> > > > using it.
> > > >
> > > > Thanks for clarifying the current state of user space stack unwindi=
ng on s390x!
> > >
> > > We will implement the missing pieces and let you know when things are
> > > supposed to work.
> >
> > Do you think we could have an initial patch set for implementing the
> > missing pieces in time for the Linux 6.8 merge window? Then we can
> > look at enabling this for s390x as a Fedora Linux 40 Change.
>
> This will be very likely the case. Actually the plan is to go with the
> patch below. I gave it some testing with Fedora 38 and replaced (only)
> glibc with a variant that was compiled with -mbackchain.
>
> It seems to work, including the not avoidable problems described below. S=
o
> I guess we will try to bring this upstream with the current merge window.
>
> From 3ba1e255c8af61f172a8b31de2b76d39c7d4c0c7 Mon Sep 17 00:00:00 2001
> From: Heiko Carstens <hca@linux.ibm.com>
> Date: Mon, 30 Oct 2023 11:34:07 +0100
> Subject: [PATCH] s390/perf: implement perf_callchain_user()
>
> Daan De Meyer and Neal Gompa reported that s390 does not support perf use=
r
> stack unwinding.
>
> This was never implemented since this requires user space to be compiled
> with the -mbackchain compile option, which until now no distribution
> did. However this is going to change with Fedora. Therefore provide a
> perf_callchain_user() implementation.
>
> Note that due to the way s390 sets up stack frames the provided call chai=
ns
> can contain invalid values. This is especially true for the first stack
> frame, where it is not possible to tell if the return address has been
> written to the stack already or not.
>
> Reported-by: Daan De Meyer <daan.j.demeyer@gmail.com>
> Reported-by: Neal Gompa <ngompa@fedoraproject.org>
> Closes: https://lore.kernel.org/all/CAO8sHcn3+_qrnvp0580aK7jN0Wion5F7KYeB=
Aa4MnCY4mqABPA@mail.gmail.com/
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/kernel/perf_event.c | 47 +++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/arch/s390/kernel/perf_event.c b/arch/s390/kernel/perf_event.=
c
> index c27321cb0969..fdbe7e1d9eea 100644
> --- a/arch/s390/kernel/perf_event.c
> +++ b/arch/s390/kernel/perf_event.c
> @@ -212,6 +212,53 @@ void perf_callchain_kernel(struct perf_callchain_ent=
ry_ctx *entry,
>         }
>  }
>
> +struct stack_frame_user {
> +       unsigned long back_chain;
> +       unsigned long empty1[5];
> +       unsigned long gprs[10];
> +       unsigned long empty2[4];
> +};
> +
> +void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
> +                        struct pt_regs *regs)
> +{
> +       struct stack_frame_user __user *sf;
> +       unsigned long ip, sp;
> +       bool first =3D true;
> +
> +       if (perf_guest_state())
> +               return;
> +       if (is_compat_task())
> +               return;
> +       perf_callchain_store(entry, instruction_pointer(regs));
> +       sf =3D (void *)user_stack_pointer(regs);
> +       pagefault_disable();
> +       while (entry->nr < entry->max_stack) {
> +               if (__get_user(sp, &sf->back_chain))
> +                       break;
> +               if (__get_user(ip, &sf->gprs[8]))
> +                       break;
> +               if (ip & 0x1) {
> +                       /*
> +                        * If the instruction address is invalid, and thi=
s
> +                        * is the first stack frame, assume r14 has not
> +                        * been written to the stack yet. Otherwise exit.
> +                        */
> +                       if (first && !(regs->gprs[14] & 0x1))
> +                               ip =3D regs->gprs[14];
> +                       else
> +                               break;
> +               }
> +               perf_callchain_store(entry, ip);
> +               /* Sanity check: ABI requires SP to be aligned 8 bytes. *=
/
> +               if (!sp || sp & 0x7)
> +                       break;
> +               sf =3D (void __user *)sp;
> +               first =3D false;
> +       }
> +       pagefault_enable();
> +}
> +
>  /* Perf definitions for PMU event attributes in sysfs */
>  ssize_t cpumf_events_sysfs_show(struct device *dev,
>                                 struct device_attribute *attr, char *page=
)
> --
> 2.39.2
>

This patch LGTM. I'd love to see it land in Linux 6.7!

Reviewed-by: Neal Gompa <ngompa@fedoraproject.org>



--
Neal Gompa (FAS: ngompa)
