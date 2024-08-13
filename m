Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EB218B48E
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Aug 2024 10:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723545452; cv=none; b=X2g0WZDaGzspmdh0lNoZUT3LJ8VUn6PBSBVClTjRQWbLIHo2G84nff1UDlbctPyZoT38lrcmTF+NOSuYr2b286Ktqm+8iyylwa0XOiqPLygnxv2Pvox+8SfcdgzcKWhH/zKJoTUX2y17gtt4X2fn2x3VOrvhOmLJUrsafGduGEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723545452; c=relaxed/simple;
	bh=Fx86RWNFPGzFcoJ2+JGDsyIXnDup4PvG8KrfisUsS6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pfw2jZnlWtlV/BGs1WKCGRwTRjOL70Nexa3MoLC8FEse9gp1x2rZKqBMjbgbOL5yWWYy/45bA1QuZYETFkfEchxVOWiCW+9QMVrTKdXUeoTpM5hdULQkepP5reePbmGjQMFXSPX04ESc6uSCn2vvs+EUh3FvfZJkjftHr5Ivw7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=qmX3GpIP; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="qmX3GpIP"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-428fb103724so35800955e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Aug 2024 03:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1723545449; x=1724150249; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fvbee0SW+pMXz7sN1ET87bGiGH6l11oU5neEpsez9DU=;
        b=qmX3GpIPoaxrAglEZvmDbvbR6fLKPjQyMnBL+E3TawEvHnXdqEcXu4S8JoCjrlGXpo
         0nYx9HGvxXBjSKRYZFL5yLnd8hS5vFIWoGCcDawN8iIJlK9wj/YAAqAAW3tuorK8Jf2c
         rMzAJRavPGPN39MmMVVOuTheOS5C2fK50sRv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723545449; x=1724150249;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fvbee0SW+pMXz7sN1ET87bGiGH6l11oU5neEpsez9DU=;
        b=QHGINMsus5ficU9llyD6b/QVUA3jfHMQ/RPG77ah/fUBqwpUdhfM1RgdTiwMIXtQx0
         ja86Kl4E/rvqT54tajuu7mC51O1WGuTiBtHwwu5hFscj/uSnc4Q6xuq2GhXD3yEchCuM
         6LIrHv1g5FkDW9Jav4M2mctieVel7/yzy57UI6zfQl0V5w44k8CSlFFoTLYA/2cEJtc4
         Gl+BjsRqngqD1eM9IbVW+bH4oALL6ew0y6va6GUH+Yb8jpC820G/eAZPZ+UgEccBD7Of
         NxyoiNcEC3D0Ug3LezSoLOjk1gkBxtBIBD4fGSLWZofDIF7JSWNtGAdOp+lUOCrWwqoa
         MeSg==
X-Forwarded-Encrypted: i=1; AJvYcCVzu/yrAe6rC5qB2AkOkg9eA2v6/3uNx/CBZpt6eclP62Li3nVzBIGV/AyrSkdCQudZpWMvAGIT3qM73UPR8Y+Y1LzAYDPcVhDOnWJWwIkczg==
X-Gm-Message-State: AOJu0YycKGmAdu5KVe7zN77uUYs//Dve560hEYG0x0Ehi1vw1ByDhUMa
	sUVGehhLttfwnb1QXVyXNzXO6G3z/Bi08rqIt5Yz0Q6eik2D5LSd4GSQJLt4Nik=
X-Google-Smtp-Source: AGHT+IH8waElxjdjm7UZ/RIkANd5DqTvRYZsedUWRh/rC+5Ycr+cgQv+7sCp7T6Chbqa2sHZt6mn6Q==
X-Received: by 2002:a05:600c:4fd5:b0:424:71f7:77f2 with SMTP id 5b1f17b1804b1-429d62fe07fmr16832245e9.16.1723545448849;
        Tue, 13 Aug 2024 03:37:28 -0700 (PDT)
Received: from LQ3V64L9R2.home ([80.208.222.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c75044a8sm133746935e9.9.2024.08.13.03.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 03:37:28 -0700 (PDT)
Date: Tue, 13 Aug 2024 11:37:26 +0100
From: Joe Damato <jdamato@fastly.com>
To: Kyle Huey <me@kylehuey.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, khuey@kylehuey.com,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	robert@ocallahan.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH] perf/bpf: Don't call bpf_overflow_handler() for tracing
 events
Message-ID: <Zrs3ZqRtT3_lNj6a@LQ3V64L9R2.home>
References: <20240715150410.GJ14400@noisy.programming.kicks-ass.net>
 <CAP045Aq3Mv2oDMCU8-Afe7Ne+RLH62120F3RWqc+p9STpcxyxg@mail.gmail.com>
 <20240715163003.GK14400@noisy.programming.kicks-ass.net>
 <CAP045Apu6Sb=eKLXkZ5TWitWbmGHMDArD1++81vdN2_NqeFTyw@mail.gmail.com>
 <ZpYgYaKKbw3FPUpv@krava>
 <CAEf4BzZWWzio9oPe2_jS=_7CnKuJnugr2h4yd3QY1TqSF0aMXQ@mail.gmail.com>
 <CAP045ArhO4K2vcrhG_GnJNhx=+7v6WLYKsDj4CvqO7HKzBshXg@mail.gmail.com>
 <CAEf4BzbE4keci=hyt2APp5sfimvqfpLoWgEgEnC=Yp5S-jejKg@mail.gmail.com>
 <CAP045ArBf5Ja4s_gkg3vQciw0v7_h4kWjnbLUSk=uFgQ7WbTqQ@mail.gmail.com>
 <ZrC9oxIcKebAKpx3@LQ3V64L9R2.home>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZrC9oxIcKebAKpx3@LQ3V64L9R2.home>

On Mon, Aug 05, 2024 at 12:55:17PM +0100, Joe Damato wrote:
> On Fri, Jul 26, 2024 at 09:35:43AM -0700, Kyle Huey wrote:
> > Will do.
> > 
> > - Kyle
> > 
> > On Fri, Jul 26, 2024 at 9:34 AM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Fri, Jul 26, 2024 at 5:37 AM Kyle Huey <me@kylehuey.com> wrote:
> > > >
> > > > On Fri, Jul 19, 2024 at 11:26 AM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > On Tue, Jul 16, 2024 at 12:25 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > > > >
> > > > > > On Mon, Jul 15, 2024 at 09:48:58AM -0700, Kyle Huey wrote:
> > > > > > > On Mon, Jul 15, 2024 at 9:30 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > > > > > >
> > > > > > > > On Mon, Jul 15, 2024 at 08:19:44AM -0700, Kyle Huey wrote:
> > > > > > > >
> > > > > > > > > I think this would probably work but stealing the bit seems far more
> > > > > > > > > complicated than just gating on perf_event_is_tracing().
> > > > > > > >
> > > > > > > > perf_event_is_tracing() is something like 3 branches. It is not a simple
> > > > > > > > conditional. Combined with that re-load and the wrong return value, this
> > > > > > > > all wants a cleanup.
> > > > > > > >
> > > > > > > > Using that LSB works, it's just that the code aint pretty.
> > > > > > >
> > > > > > > Maybe we could gate on !event->tp_event instead. Somebody who is more
> > > > > > > familiar with this code than me should probably confirm that tp_event
> > > > > > > being non-null and perf_event_is_tracing() being true are equivalent
> > > > > > > though.
> > > > > > >
> > > > > >
> > > > > > it looks like that's the case, AFAICS tracepoint/kprobe/uprobe events
> > > > > > are the only ones having the tp_event pointer set, Masami?
> > > > > >
> > > > > > fwiw I tried to run bpf selftests with that and it's fine
> > > > >
> > > > > Why can't we do the most straightforward thing in this case?
> > > > >
> > > > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > > > index ab6c4c942f79..cf4645b26c90 100644
> > > > > --- a/kernel/events/core.c
> > > > > +++ b/kernel/events/core.c
> > > > > @@ -9707,7 +9707,8 @@ static int __perf_event_overflow(struct perf_event *event,
> > > > >
> > > > >         ret = __perf_event_account_interrupt(event, throttle);
> > > > >
> > > > > -       if (event->prog && !bpf_overflow_handler(event, data, regs))
> > > > > +       if (event->prog && event->prog->type == BPF_PROG_TYPE_PERF_EVENT &&
> > > > > +           !bpf_overflow_handler(event, data, regs))
> > > > >                 return ret;
> > > > >
> > > > >
> > > > > >
> > > > > > jirka
> > > > > >
> > > >
> > > > Yes, that's effectively equivalent to calling perf_event_is_tracing()
> > > > and would work too. Do you want to land that patch? It needs to go to
> > > > 6.10 stable too.
> > >
> > > I'd appreciate it if you can just incorporate that into your patch and
> > > resend it, thank you!
> > >
> > > >
> > > > - Kyle
> 
> I probably missed the updated patch, but I am happy to test any new
> versions, if needed, to ensure that the bug I hit is fixed.
> 
> Kyle: please let me know if there's a patch you'd like me to test?

Sorry for pinging this thread again; let me know if a fix was merged
and I missed it?

Otherwise, if it'd be helpful, I am happy to modify Kyle's patch to
take Andrii's suggestion and resend, but I don't want to step on
anyone's toes :)

- Joe
