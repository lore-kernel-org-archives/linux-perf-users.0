Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB071DFFC
	for <linux-perf-users@vger.kernel.org>; Sat, 25 May 2024 15:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716651183; cv=none; b=MoAIWM0gSV5mKk9aRCBi8MpdTpnCG+vQfkPx/LttOXSrgCXZSq5pvZoh/O6yW6/1sm4zWKs7Tg48Zb/hwOMjffBs/7J5Jss+t52K/LRfUxWUuK35aSui6QPoaJXfSWPxZnnY13Qh3v3bRtEi4m/gIGV50hvTxJh59g63xifWUrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716651183; c=relaxed/simple;
	bh=XjmGvjCvVdoRQGgp99J37Ge5ugalFU+Zb2ab/lElIe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5AicqxCE2a0MlNDlibuo5XyD6YzyapIJa+2jYB01mf4AmDViR4sRI3Hw7w739dSb1STVnpjX3LtPTABCbVaK8qApTyykR0VBoY+1w9VzP2sntRj9XN3mG3wKFeLWWTT2Gjnih5s9TTYVw/mVYmy2/C1lilTEBtAq/lsFnu93Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L3JNu4h4; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L3JNu4h4"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-43e14f0bd75so155151cf.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 May 2024 08:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716651180; x=1717255980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qxIheNE36/AFQ6DFb1h2gQ7uwhDUW5kimFTAbxrrBs=;
        b=L3JNu4h4OzBAzM9A+xyapf+QULYwwJMrbUCLPX05hvHg7YZRs7HgA4XpF6fWqQBjPV
         e021QYdC0h+fSIBbs1dz6vM3g5LCag42hTCZol6Y8RDkJI1YByr2R0COfCOIu1NnwMNL
         8Dyoy6V7BOjtnL/ipzz7eafgA+mly9ree1u1mdceG6+VfhNpcRNSsmgIPlVbVQOEQPyb
         0m9G4pD61M+WRaCv7BvaEL1j4xGBkmXm/EF3wVTc0E5pTITJ5ZBzChFM6nCoGLcbIHMQ
         8iCFnWnpJKJUSeLh2pLnemQsh3S4GlECYaSoTgVZjfWbUS/TtxsSd0fJ4j2pCFQ0E0Rc
         FrPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716651180; x=1717255980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9qxIheNE36/AFQ6DFb1h2gQ7uwhDUW5kimFTAbxrrBs=;
        b=Sw/XzTPPcEQp1ubCnt8Sd+ttippSOTBjWbXtgASMMxhojOLO/u99IHiILrsE7wsyCD
         3hmRWuMqvCdn8Prx+T/XebCWV02oKlo+ET3dkT4bufPvLlS0Jt0QiUB1xPbBaDs2R55R
         mxK/TuVYA8wA6tN9A6fP1IEHgMCkrMCsaXJSdSBezkbsUJljK87DCCY9O/yTaXfQehGF
         39TmdGKTmB1k24m5iO4HRlQp5XxxH5IWuZA6uPTHkoNswcNb5q/M8Zhtr8ppaK5bc/PN
         jyJX8o7GdzCXpKCOfxd3qxf0n7ljZTWTCleHQb2auShRe8kRuADN+2oBZQGsbQ38SnaP
         GVHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeV/RIJ4VKLYocbllj8OfhscHClNr/L0ti9FQqowfh4I1iw46Syd3seKzThLgDhuAXTx7XYEqPu1CVWm5MDcUeT8rDfLcD9oykD2kcKV/W1w==
X-Gm-Message-State: AOJu0Yw5LxV7VI7YbGBvqJcWRQo5lyMLzNtY4Gl1iTSgnJrr5aw0E1J6
	rYA37+4JFRvkG3f2Ed84MK8IGeKevSLuehuO8AGPn+0ohGOXD8LLpU0CQuFiBII1m0vZssSHksf
	gw28qXyj+idcFOIIEylqDb6bbArX8Go+YY/89
X-Google-Smtp-Source: AGHT+IEPcapSXKl3WWFHyiygvTag/hYU+0l2uIplRTD5RF5rRPCj4xxISCeGcwwl+++10HK6E8faefmYlkzq3CfuOiI=
X-Received: by 2002:a05:622a:1e13:b0:43e:a94:c1c9 with SMTP id
 d75a77b69052e-43fb9fabab2mr2139101cf.20.1716651179981; Sat, 25 May 2024
 08:32:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521192614.3937942-1-acme@kernel.org> <CAHk-=wiWvtFyedDNpoV7a8Fq_FpbB+F5KmWK2xPY3QoYseOf_A@mail.gmail.com>
 <ZlFE-wbwStOqt8Ra@x1> <ZlFGpxWGQskCTjeK@x1> <CAP-5=fXDdcjMmn8iBenjPmZZQdB=AX+gc4TYDsHXuwH9TYq4Ng@mail.gmail.com>
 <CAHk-=wheZptGieaObmQEsz6bocUjhQXNpWXFDmCK-TOKbOvO+Q@mail.gmail.com> <CAP-5=fVFJNqYaQNekrWNVRg8=_2K0T-WKZ=8-iafU4CCfUCXSA@mail.gmail.com>
In-Reply-To: <CAP-5=fVFJNqYaQNekrWNVRg8=_2K0T-WKZ=8-iafU4CCfUCXSA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 25 May 2024 08:32:48 -0700
Message-ID: <CAP-5=fU2XGnxE0sBU6QrUAKBOwVy=+w2ZJ0M2WC_Rf2jW-Y0PQ@mail.gmail.com>
Subject: Re: [GIT PULL] perf tools changes for v6.10
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Anne Macedo <retpolanne@posteo.net>, 
	Bhaskar Chowdhury <unixbhaskar@gmail.com>, Ethan Adams <j.ethan.adams@gmail.com>, 
	James Clark <james.clark@arm.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Tycho Andersen <tycho@tycho.pizza>, 
	Yang Jihong <yangjihong@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 25, 2024 at 7:09=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Fri, May 24, 2024 at 9:20=E2=80=AFPM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Fri, 24 May 2024 at 20:48, Ian Rogers <irogers@google.com> wrote:
> > >
> > > Thanks for the report. TL;DR try putting the PMU name with the event
> > > name, so "cycles:pp" becomes "armv8_pmuv3_0/cycles/pp", where
> > > armv8_pmuv3_0 is the name of the PMU from /sys/devices.
> >
> > What? No.
> >
> > If that is the new rule, then I'm just going to revert. I'm not going
> > to use some random different PMU names across architectures when all I
> > want is just "cycles".
>
> The issue is that perf previously would do two things, if you asked
> for a 'cycles' event then as the name was a legacy one it would encode
> the type in the perf_event_attr as PERF_TYPE_HARDWARE and the config
> as PERF_COUNT_HW_CPU_CYCLES job done. With BIG.little/hybrid/.. those
> events now need opening on multiple PMUs otherwise you end up only
> sampling on either the big or the little core. On Intel with hybrid,
> cycles had to become cpu_core/cycles/ and cpu_atom/cycles/.
>
> If we look at an event name that isn't a legacy one, like
> inst_retired.any, then when no PMU is specified perf's behavior is to
> try to open this event on every PMU it can. On Intel this event will
> be found on the 'cpu' PMU, or on a hybrid Intel on cpu_core and
> cpu_atom. Were the event 'data_read' then it could be found on the
> uncore_imc_free_running_0 and uncore_imc_free_running_1 PMUs. My point
> here is that wildcarding an event to every PMU that supports it is
> arguably a feature as it avoids users needing to remember a specific
> PMU name. PMU names are often duplicated and it would be laborious to
> name them all.
>
> > In fact, the "cycles:pp" is a complete red herring. Just doing a simple
> >
> >  $ perf record sleep 1
> >
> > with no explicit expression at all, results in that same
> >
> >   Error:
> >   cycles:P: PMU Hardware doesn't support sampling/overflow-interrupts.
> > Try 'perf stat'
> >
> > because perf *ITSELF* uses the sane format by default.
> >
> > So ABSOLUTELY NO. We're not changing the rules to "You have to know
> > some idiotic per-architecture JSON magic".
> >
> > I don't want any excuses like this. No "You are holding it wrong".
> > This is a BUG. Treat it as such.
> >
> > And yes, "perf record -vv" shows that it apparently picked some insane
> > arm_dsu_0 event. Which just shows that trying to parse the JSON rules
> > instead of just having sane defaults is clearly not working.
> >
> > So here's the deal: I will revert your commit tomorrow unless you show
> > that you are taking it seriously and have a sane fix.
> >
> > Because no, "You are holding it wrong" is not the answer. Never was,
> > never will be. Things used to work, they don't work any more. That
> > shit is not acceptable.
>
> I wasn't trying to say you were holding it wrong, I was trying to give
> you practical advice that would solve your problem whilst we determine
> what the right fix is.
>
> The question is what to do about events when no PMU is specified, here
> are the alternatives I see:
>
> 1) make legacy event names special and only open them on core PMUs,
> 2) make sure PMUs, like arm_dsu_0 in your case, don't advertise events
> matching legacy names like cycles,
> 3) make perf record only scan PMUs that support sampling,
> 4) in the case that we're using cycles:P as a default event, only open
> that on core PMUs (on Intel make cycles:P ->
> cpu_core/cycles/P,cpu_atom/cycles/P).
>
> A revert achieves (1) and I consider it a regression as now the
> behavior of 'cycles' doesn't match 'inst_retired.any' and the user
> somehow needs to know that certain event names are special.
> Changing the driver (2) is a workaround, but it feels like a burden on
> the driver writers.
> In order to determine whether a PMU supports sampling (3) we'd need to
> try probe using perf_event_open. The perf_event_open may fail due to
> things like host/guest permissions, etc. so we need fallbacks. We do
> something similar here:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/t=
ools/perf/util/print-events.c#n242
> (4) is the simplest change and I think it lowers the surprise from the
> behavior change in the patch. It means that were you to do "perf
> record -e cycles ..." you would still need to specify a PMU on Linus'
> special ARM box. We may lack permissions to read sysfs and so then it
> is hard to determine the PMU name, but the code was likely to fail
> then anyway.
>
> I'll write a patch to do (4), hopefully this qualifies as being
> serious, but it would be useful if the interested parties could work
> out what they think the behavior should be.

Patch sent:
https://lore.kernel.org/lkml/20240525152927.665498-1-irogers@google.com/

Thanks,
Ian

> Thanks,
> Ian
>
> >                    Linus
> >
