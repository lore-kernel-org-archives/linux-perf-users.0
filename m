Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C060134567
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Nov 2023 23:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GLE6YcUX"
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D5410D1
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Nov 2023 15:47:57 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-67089696545so39229506d6.0
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Nov 2023 15:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699400876; x=1700005676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AwiYwgDPePRyKDhIdyq+gxbwUtv6ztRkGu1vD58BCfU=;
        b=GLE6YcUXiZVaDhNRRBgDrrb8ptklAXljZEHWD8CwEmtasOQcPBvNpnid408+nHv/uX
         a4kuyX1FEQShivBIGM/OhSU99Fo0G3UqWzucD/2X8K7xHDNwnlDfVkmQOnwgsAd6ZPtQ
         dG4+D7RySa8YJ+03c+J4CWvs+9Jdl1jkEPtS9pMPNv9sf2OaMPfwvKHrvA6gC+updWYQ
         ETwz6bdI3TmeDhY7twFETJPK3HyMu9G0WgmeQEA9cJpw1ceKoHOuVIfBkfOile5Q9gFR
         Dzcy/srqa1F7WU0OGKAk+LL7sQi/AlKrYAaoZQjR7fV7UfafwZANwxJ9noO1kOxhUJVL
         36pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699400876; x=1700005676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AwiYwgDPePRyKDhIdyq+gxbwUtv6ztRkGu1vD58BCfU=;
        b=g51YJz2O9myfYHTMos5oM0F3BZCMzzDYX8coPGYWFF1JGdYWxiXyYuuT2ed1OwPOaB
         PsTmUX/03z0jBIDIkDJ1exn+UYR07LN6+m0MmEY9twg50TDRzKUoPgb7gGCQbAUt/FQ4
         jTp1iIJilbu4zodfJSTYUDwPdKPFL9w+NVcA4+BJ1l9Y43le9ERyzhr4/kfkq4SKN0ak
         u381kVu8chIfN/G1wHsF2WDHfjHPA9MAtas2UDuxUVHS8DPMbT5qhOikKT3PywbkKK13
         lPmrheT+UBq4sfEv5VGrmSMAYL+c77Y5b/WV2PoeI7Z2v39bFCf7tE1gNlVEo25Ze/+B
         Wr4w==
X-Gm-Message-State: AOJu0YyrXYXli5kFd2j1Q/KbyBBOs+rV0aP5K3qPDKdlTClbO6FmfuPm
	Zv7bNr8/kbXAqbA0glF0jlPJu4oGAhGt8Kr36Khp/4w+HVqCdXahQ8k=
X-Google-Smtp-Source: AGHT+IHssMMrX4lEp4vtt6ZlKyyydttGs0SzYQgAkmOanWn/emWbZcA3IgXFKH4igP3ZN3Aj2LGnIA+vG2fFNRyrMfU=
X-Received: by 2002:a05:6214:e8d:b0:66f:bcc5:cf70 with SMTP id
 hf13-20020a0562140e8d00b0066fbcc5cf70mr313097qvb.42.1699400876052; Tue, 07
 Nov 2023 15:47:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231107183605.409588-1-seanjc@google.com> <ZUqSQKHwvKQs7_qA@google.com>
 <ZUrCE9j1Gvw4zacY@google.com>
In-Reply-To: <ZUrCE9j1Gvw4zacY@google.com>
From: Mingwei Zhang <mizhang@google.com>
Date: Tue, 7 Nov 2023 15:47:19 -0800
Message-ID: <CAL715WL3Uo-XjH=GYW9vybDJTscE4-f2a_fndUpOEig1JhkwvQ@mail.gmail.com>
Subject: Re: [PATCH] perf/x86: Don't enforce minimum period for KVM guest-only events
To: Sean Christopherson <seanjc@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Like Xu <likexu@tencent.com>, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 7, 2023 at 3:02=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Tue, Nov 07, 2023, Mingwei Zhang wrote:
> > On Tue, Nov 07, 2023, Sean Christopherson wrote:
> > >  arch/x86/events/core.c | 21 +++++++++++++++------
> > >  1 file changed, 15 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> > > index 40ad1425ffa2..f8a8a4ea4d47 100644
> > > --- a/arch/x86/events/core.c
> > > +++ b/arch/x86/events/core.c
> > > @@ -1388,16 +1388,25 @@ int x86_perf_event_set_period(struct perf_eve=
nt *event)
> > >             hwc->last_period =3D period;
> > >             ret =3D 1;
> > >     }
> > > -   /*
> > > -    * Quirk: certain CPUs dont like it if just 1 hw_event is left:
> > > -    */
> > > -   if (unlikely(left < 2))
> > > -           left =3D 2;
> > >
> > >     if (left > x86_pmu.max_period)
> > >             left =3D x86_pmu.max_period;
> > >
> > > -   static_call_cond(x86_pmu_limit_period)(event, &left);
> > > +   /*
> > > +    * Exempt KVM guest events from the minimum period requirements. =
 It's
> > > +    * the guest's responsibility to ensure it can make forward progr=
ess,
> > > +    * and it's KVM's responsibility to configure an appropriate "per=
iod"
> > > +    * to correctly virtualize overflow for the guest's PMCs.
> > > +    */
> > > +   if (!event->attr.exclude_host) {
> > > +           /*
> > > +            * Quirk: certain CPUs dont like it if just 1 event is le=
ft:
> > > +            */
> > > +           if (unlikely(left < 2))
> > > +                   left =3D 2;
> > > +
> > > +           static_call_cond(x86_pmu_limit_period)(event, &left);
> > > +   }
> > >
> > >     this_cpu_write(pmc_prev_left[idx], left);
> > >
> >
> > Nice one. I am curious how you tested this one? I would like to
> > reproduce that one on my side.
>
> The check_emulated_instr() sub-test in KVM-Unit-Tests's x86/pmu.c fails w=
hen run
> with "my" (which is really yours) fix for the KVM's handling of emulated =
PMC
> events[*].  If KVM synthesizes an "instructions retired" event that bumps=
 the
> PMC to all ones, i.e. -1 for all intents and purposes, the test fails bec=
ause
> KVM creates a sample_period of '1', but perf programs a period of '2'.
>
> I suspect a very simple test of writing -1 to a PMC from the guest would =
exhibit
> the same behavior.
>
> [*] https://lkml.kernel.org/r/ZUWAg3WP2XESCAR4%40google.com

Nice, I will try that and see if I can reproduce. Will give
Reviewed-by after testing it on my side.

Thanks.
-Mingwei
