Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABF355C08
	for <linux-perf-users@vger.kernel.org>; Sat, 25 May 2024 14:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716646172; cv=none; b=BNVoZrp4vXejUznShMo6Onud5JqP/IUGXghp9LEzS3eQcHQsKwdmPKgVN4iBI56BpLWZNFC+gHHYIDuXwWkp3YVljk6RzIMPwdotNVfEHJyPQyb91W7bk/jU2oBhthgpTEUtCqypv2jYhGUCi5yQOkgLFkG7lz/5+mQ56qLaMdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716646172; c=relaxed/simple;
	bh=9AB3F+ERpeNgpHuSA/LmQ68qrAHdgCH0rbQPc3A19C4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=inhR7YGal5J/xkG1LwcKhX3cZFPFEx3W5vHNqkwfbSY/JHLqiOig6pwOFScjzbSTJf6ii9R/AdrmQNLTZuaha6FFG7qooy8BH1PFVYjwWGTI8RwII+/wSo3gCUwIvxjLDp0s1ZjxgmTvW+Tk0SoRKgudvu5VcLOa1JqpKIV07oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JfeJQdVa; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JfeJQdVa"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-36db330403fso129945ab.0
        for <linux-perf-users@vger.kernel.org>; Sat, 25 May 2024 07:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716646170; x=1717250970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZhqZJUOejfkCvi+8WQ97T+9L3dgb+ZhC9CuNx3x7Y5k=;
        b=JfeJQdVaPDDRqaDFp3aHqgbnq8m99oxcwMxmHy7tJCmDS4DlQfrDwoxZkmoHed/qFs
         EW+R/yKEAQc6TarD+FlhY27iNnMVccZiFzb3blO2N1CWKa3/0tyhR6MrfflNIKM0bVkj
         FVTZm+ArCySxiOoZ6MAl93adqkfJv7ItSNaqjnT3zDR0tQsH28fJZc/++oSEdeX3C5PF
         Htc5MSpzflpPjX9opP5sYWS1EhjRBNfatQM8myrCcRU20CQK1wZDOQAdd+VbuEyADlLc
         fTTQc97IUrdsb//wuqECF60Os9GI3d9SHp5NRN27gULOzvVT4wS9rONhYg3Wvo8+xh1c
         qDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716646170; x=1717250970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZhqZJUOejfkCvi+8WQ97T+9L3dgb+ZhC9CuNx3x7Y5k=;
        b=m5TtMgpEZgI50CncZWbMrDlq1RnXWwm+56rKdLZ6sNfbED3QHQ7lyTCeJrHrqd4Is6
         mQJg2UEXjbwstABy+K6Wbbu9ZmRf/XvaYY/dzAkNd9BsSDW+XM+n2SD5gcBD4W57vn3P
         KnC1mGEZ7t3Ha8cdS4wAGOKmcOYmZih8gUJsZDjvOPgRHWFS+I202N+ZzEo2g2cvxfXT
         vhoZHFeoEJnyoI/AoMTZTQZgi1fK8Bw6QNhtIKU08BBLtIlYq2Bk74/Mb11oFsI56HG9
         Ijwi3zxpFZVuxp6vi8643tMntBzkOKDckQElM+pmJHOsv3LUWmUnizKWJ1B/ac0wGhcw
         2lgw==
X-Forwarded-Encrypted: i=1; AJvYcCU5wCj05xsVPCHPa1ahP531N6OiumuWO9ymAvpriwMP2LHZdfgB/W4TlEwcsm6c3/HyCnl4YVDm4rUlgg2iNdjSgCJCu3OJhBZ7t4MiqP/ebw==
X-Gm-Message-State: AOJu0Yw/EjHFgQ+/Q4dFg3BAirOD2JpTz6Mo3ZkoQubSkGv/ZeLktTFr
	yB2r1ej9EvUdeoH9I4tOPhk1Kp6jBxqm1G0r17g0TG8AEuwLnIjCnMRRMN8rhplrUQ7qcqcLgg6
	z1CXgqTRSwJGeZVOApNPFPFOWcu+i8k0Z6Aw8
X-Google-Smtp-Source: AGHT+IHF3UOqk63Ap5kc83idT/QbuIH4w9EjhqgctPC+S356f6TJ3LRsJ5FLjAdwUyQtn+68L2808l5lIeQhsirgkGk=
X-Received: by 2002:a92:c991:0:b0:36c:7fe9:333f with SMTP id
 e9e14a558f8ab-3738a749048mr1820085ab.14.1716646170263; Sat, 25 May 2024
 07:09:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521192614.3937942-1-acme@kernel.org> <CAHk-=wiWvtFyedDNpoV7a8Fq_FpbB+F5KmWK2xPY3QoYseOf_A@mail.gmail.com>
 <ZlFE-wbwStOqt8Ra@x1> <ZlFGpxWGQskCTjeK@x1> <CAP-5=fXDdcjMmn8iBenjPmZZQdB=AX+gc4TYDsHXuwH9TYq4Ng@mail.gmail.com>
 <CAHk-=wheZptGieaObmQEsz6bocUjhQXNpWXFDmCK-TOKbOvO+Q@mail.gmail.com>
In-Reply-To: <CAHk-=wheZptGieaObmQEsz6bocUjhQXNpWXFDmCK-TOKbOvO+Q@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 25 May 2024 07:09:18 -0700
Message-ID: <CAP-5=fVFJNqYaQNekrWNVRg8=_2K0T-WKZ=8-iafU4CCfUCXSA@mail.gmail.com>
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

On Fri, May 24, 2024 at 9:20=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, 24 May 2024 at 20:48, Ian Rogers <irogers@google.com> wrote:
> >
> > Thanks for the report. TL;DR try putting the PMU name with the event
> > name, so "cycles:pp" becomes "armv8_pmuv3_0/cycles/pp", where
> > armv8_pmuv3_0 is the name of the PMU from /sys/devices.
>
> What? No.
>
> If that is the new rule, then I'm just going to revert. I'm not going
> to use some random different PMU names across architectures when all I
> want is just "cycles".

The issue is that perf previously would do two things, if you asked
for a 'cycles' event then as the name was a legacy one it would encode
the type in the perf_event_attr as PERF_TYPE_HARDWARE and the config
as PERF_COUNT_HW_CPU_CYCLES job done. With BIG.little/hybrid/.. those
events now need opening on multiple PMUs otherwise you end up only
sampling on either the big or the little core. On Intel with hybrid,
cycles had to become cpu_core/cycles/ and cpu_atom/cycles/.

If we look at an event name that isn't a legacy one, like
inst_retired.any, then when no PMU is specified perf's behavior is to
try to open this event on every PMU it can. On Intel this event will
be found on the 'cpu' PMU, or on a hybrid Intel on cpu_core and
cpu_atom. Were the event 'data_read' then it could be found on the
uncore_imc_free_running_0 and uncore_imc_free_running_1 PMUs. My point
here is that wildcarding an event to every PMU that supports it is
arguably a feature as it avoids users needing to remember a specific
PMU name. PMU names are often duplicated and it would be laborious to
name them all.

> In fact, the "cycles:pp" is a complete red herring. Just doing a simple
>
>  $ perf record sleep 1
>
> with no explicit expression at all, results in that same
>
>   Error:
>   cycles:P: PMU Hardware doesn't support sampling/overflow-interrupts.
> Try 'perf stat'
>
> because perf *ITSELF* uses the sane format by default.
>
> So ABSOLUTELY NO. We're not changing the rules to "You have to know
> some idiotic per-architecture JSON magic".
>
> I don't want any excuses like this. No "You are holding it wrong".
> This is a BUG. Treat it as such.
>
> And yes, "perf record -vv" shows that it apparently picked some insane
> arm_dsu_0 event. Which just shows that trying to parse the JSON rules
> instead of just having sane defaults is clearly not working.
>
> So here's the deal: I will revert your commit tomorrow unless you show
> that you are taking it seriously and have a sane fix.
>
> Because no, "You are holding it wrong" is not the answer. Never was,
> never will be. Things used to work, they don't work any more. That
> shit is not acceptable.

I wasn't trying to say you were holding it wrong, I was trying to give
you practical advice that would solve your problem whilst we determine
what the right fix is.

The question is what to do about events when no PMU is specified, here
are the alternatives I see:

1) make legacy event names special and only open them on core PMUs,
2) make sure PMUs, like arm_dsu_0 in your case, don't advertise events
matching legacy names like cycles,
3) make perf record only scan PMUs that support sampling,
4) in the case that we're using cycles:P as a default event, only open
that on core PMUs (on Intel make cycles:P ->
cpu_core/cycles/P,cpu_atom/cycles/P).

A revert achieves (1) and I consider it a regression as now the
behavior of 'cycles' doesn't match 'inst_retired.any' and the user
somehow needs to know that certain event names are special.
Changing the driver (2) is a workaround, but it feels like a burden on
the driver writers.
In order to determine whether a PMU supports sampling (3) we'd need to
try probe using perf_event_open. The perf_event_open may fail due to
things like host/guest permissions, etc. so we need fallbacks. We do
something similar here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/too=
ls/perf/util/print-events.c#n242
(4) is the simplest change and I think it lowers the surprise from the
behavior change in the patch. It means that were you to do "perf
record -e cycles ..." you would still need to specify a PMU on Linus'
special ARM box. We may lack permissions to read sysfs and so then it
is hard to determine the PMU name, but the code was likely to fail
then anyway.

I'll write a patch to do (4), hopefully this qualifies as being
serious, but it would be useful if the interested parties could work
out what they think the behavior should be.

Thanks,
Ian

>                    Linus
>
