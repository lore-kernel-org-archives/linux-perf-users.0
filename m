Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A4B225D4
	for <linux-perf-users@vger.kernel.org>; Fri, 26 Jul 2024 12:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721997478; cv=none; b=rMmN3yJ7iwlCr/H+KafRYAVL+/U/VK4aQwo/8unoofHGa783YLOIzslOVrd5rzxSrsIWpsX5vg0DZPe6yX+aQajhSTTrygapph26sFytxKibMnV2NYedH+cvm3oztNiuh16dQuajMCwZ7AtfTqUS9niO51TBRrJnD0U/6H10cAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721997478; c=relaxed/simple;
	bh=EEq0nyzjqU8eiJpGD8e5EI+vAxzQttlffDZu+gIky+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MZQ8zMiKpquUpefReOuYvDhgFuTZzzQ+VM8VkZ42AntoUI/QR8Fpk+mlFht9Gw9hwUEemF4mW3ndvycJrR1X0IRJNEQL1FYP3qRPnb3TQ1UBSY9Ag/qQz3Djq9gKXmD5Ub/0wKgXYv1IqtaG6lqHfaKgnYYL3YMGu3AmD2iMkaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=KW3oWWFV; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="KW3oWWFV"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ef23d04541so14865501fa.2
        for <linux-perf-users@vger.kernel.org>; Fri, 26 Jul 2024 05:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1721997473; x=1722602273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8CS5FjqHHrfrzcqpVzuA7yQixwEIvcBn/g6hapXBw6M=;
        b=KW3oWWFVQphK8svsJfWSAnkBHkLepX5WbcuAgQEG+z9KQKYbUic6p+BodO7c/jPiYy
         qAITGhZgXcaRdFm/wAK/8L7FRWv5dcbPL5oL+H1I4NDG+Qa2FlsKv5PXa/xbnsRiIlyq
         yPDNd1yZU7LDe0SDMkBTlXxFn7js0uh64+jUDjDJH+LbW8u9rjqRQDiQEr93SOEMi/Rz
         ta6QRCbpD0fmwxuHiLQbC4FU+P3+QZJ/6UttFFj4JTdPaVzCeng2/7BpEn0lw0w2RIhT
         3o7z2Zm6KP3benDA3cC2qf8+/ybD22LwZBAZOwaEJJleRvd+OTvvrHpY4KN658okiq88
         qkkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721997473; x=1722602273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8CS5FjqHHrfrzcqpVzuA7yQixwEIvcBn/g6hapXBw6M=;
        b=LGpdIuqLVTKnASh4K3cWSp/1U4lToX1kwGE6TnPJabJG+A3TLZ2GcHGlM36y8ArlpE
         XQqC4YzXvlSOUkXjhyXqJqgDo8nI/fpTDMpvU48BKDJYjx4hLzNamGmev9FmdfAknMVl
         5Ht810tMEOuAxU3mS27Zav0OPidoGeMXvNMrIWTLt3ftv9OZztIMjNBxeO4oipSDRWOJ
         p3zveShxku3mApRrYX6H7pYpg26WJs9WMlR4eAr135Ml3IAlK5u8LSIKsOW4m9u53FH6
         8fP9yV2URiz7O4IiIJdboiNOI6N+usi5THLRV6SOQ9wdqAhu+nXWOtttsf3Q2XDjgqHA
         OtLg==
X-Forwarded-Encrypted: i=1; AJvYcCUSAR5vbWJdM+eTcSwE2dYmZjbBZQxkCznMihwIAADEk+SkC6ONGl3sLiRH1eDR6HUt8FgCdYfR/IBuiBbol0Tkni5eydVsD/RXpP7MkHO3SA==
X-Gm-Message-State: AOJu0YyXELOjzHSWURUuhkUMeJTihcUEjwBq+wIwfaVXB18f4m5suZys
	madBXcEtZXVBw2si5Uj32e+TWtYNM+3RHuctOMEdG+3xozp5/tIZ1VyI4xQS8ZOgxGQd89aNcJL
	7Vsv+hhinS+COw0goFndbSqFPSRmgt+mUXqai
X-Google-Smtp-Source: AGHT+IFO/8a7epbXcEUM2QYUUiM0RY38qQiqMPBjU8U6zPWaJzD0n8kxnStqajocVm3AOdSn/6DwrJAsf/eIRXGQwfE=
X-Received: by 2002:a2e:9b15:0:b0:2ef:286e:ca68 with SMTP id
 38308e7fff4ca-2f039c9eb88mr40520681fa.23.1721997472896; Fri, 26 Jul 2024
 05:37:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240713044645.10840-1-khuey@kylehuey.com> <ZpLkR2qOo0wTyfqB@krava>
 <20240715111208.GB14400@noisy.programming.kicks-ass.net> <CAP045ArBNZ559RFrvDTsHj42S4W+BuReHe+XV2tBPSeoHOMMpA@mail.gmail.com>
 <20240715150410.GJ14400@noisy.programming.kicks-ass.net> <CAP045Aq3Mv2oDMCU8-Afe7Ne+RLH62120F3RWqc+p9STpcxyxg@mail.gmail.com>
 <20240715163003.GK14400@noisy.programming.kicks-ass.net> <CAP045Apu6Sb=eKLXkZ5TWitWbmGHMDArD1++81vdN2_NqeFTyw@mail.gmail.com>
 <ZpYgYaKKbw3FPUpv@krava> <CAEf4BzZWWzio9oPe2_jS=_7CnKuJnugr2h4yd3QY1TqSF0aMXQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZWWzio9oPe2_jS=_7CnKuJnugr2h4yd3QY1TqSF0aMXQ@mail.gmail.com>
From: Kyle Huey <me@kylehuey.com>
Date: Fri, 26 Jul 2024 05:37:40 -0700
Message-ID: <CAP045ArhO4K2vcrhG_GnJNhx=+7v6WLYKsDj4CvqO7HKzBshXg@mail.gmail.com>
Subject: Re: [PATCH] perf/bpf: Don't call bpf_overflow_handler() for tracing events
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, khuey@kylehuey.com, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	robert@ocallahan.org, Joe Damato <jdamato@fastly.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 11:26=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Jul 16, 2024 at 12:25=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> w=
rote:
> >
> > On Mon, Jul 15, 2024 at 09:48:58AM -0700, Kyle Huey wrote:
> > > On Mon, Jul 15, 2024 at 9:30=E2=80=AFAM Peter Zijlstra <peterz@infrad=
ead.org> wrote:
> > > >
> > > > On Mon, Jul 15, 2024 at 08:19:44AM -0700, Kyle Huey wrote:
> > > >
> > > > > I think this would probably work but stealing the bit seems far m=
ore
> > > > > complicated than just gating on perf_event_is_tracing().
> > > >
> > > > perf_event_is_tracing() is something like 3 branches. It is not a s=
imple
> > > > conditional. Combined with that re-load and the wrong return value,=
 this
> > > > all wants a cleanup.
> > > >
> > > > Using that LSB works, it's just that the code aint pretty.
> > >
> > > Maybe we could gate on !event->tp_event instead. Somebody who is more
> > > familiar with this code than me should probably confirm that tp_event
> > > being non-null and perf_event_is_tracing() being true are equivalent
> > > though.
> > >
> >
> > it looks like that's the case, AFAICS tracepoint/kprobe/uprobe events
> > are the only ones having the tp_event pointer set, Masami?
> >
> > fwiw I tried to run bpf selftests with that and it's fine
>
> Why can't we do the most straightforward thing in this case?
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index ab6c4c942f79..cf4645b26c90 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9707,7 +9707,8 @@ static int __perf_event_overflow(struct perf_event =
*event,
>
>         ret =3D __perf_event_account_interrupt(event, throttle);
>
> -       if (event->prog && !bpf_overflow_handler(event, data, regs))
> +       if (event->prog && event->prog->type =3D=3D BPF_PROG_TYPE_PERF_EV=
ENT &&
> +           !bpf_overflow_handler(event, data, regs))
>                 return ret;
>
>
> >
> > jirka
> >

Yes, that's effectively equivalent to calling perf_event_is_tracing()
and would work too. Do you want to land that patch? It needs to go to
6.10 stable too.

- Kyle
