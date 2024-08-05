Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A79E155CAB
	for <linux-perf-users@vger.kernel.org>; Mon,  5 Aug 2024 11:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722858921; cv=none; b=A3qYukRg94HJPF07v/R1RRQ4utTmUvSDS4DkxidOfdKMSnxOsCBYwd42pYZs/iMkf9nSWwYlH0E6I/PKvq+z7U7LbdZesECRCtZ/gk0CrqKTdQJAUJyZNwJ26B7LIop0v9rAI0GvokTIKtWEIHzs2ORjfw76M5dBwfzvPPdJyVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722858921; c=relaxed/simple;
	bh=ZbLlIzxxYDPFIYyF3cjeehmzOBwHkwsjudapvSV5ayo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVUmcBqAPrGSfZXL859MsSKIMc9md3SYiFMgM1W+QuOhKOJ6/87Lmqy14lgG9VdoLg4BCPyJqRToOA65XQZG/r9PJmqHqn+p6P4qu2ypQhCRTALB9oeouU4z8Uxx+FACxawsII6k7lr5kA1BfPIvBr1gDhLqcZJasFSrAfktfg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=AaFiPWTf; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="AaFiPWTf"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4266f3e0df8so68106895e9.2
        for <linux-perf-users@vger.kernel.org>; Mon, 05 Aug 2024 04:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1722858918; x=1723463718; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k607eE+sU23kDmyW6jG14/IGhv43fCVDENewedmfdPw=;
        b=AaFiPWTf6TUEKH+wI5sIEhOF/uO0VnmHRK/ux0OIqVKeSSVa4h5oy2a6mMejS5o/Sa
         +ByabBDtZb/9DwGH6z+Jn4ZJjCEStIiHgXeQWDhcufiz/7M1SWlhD93pel07G2uvgxpg
         oOYqAJBbApi0r9MoyU7x2KO0U0ThSG6/zZlg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722858918; x=1723463718;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k607eE+sU23kDmyW6jG14/IGhv43fCVDENewedmfdPw=;
        b=cqb1+cFbjro5onpF2IkkUY74kYrBxtqjv30TnrJ97GOV6h/Z1eNj3KcoxXYWie8GOA
         Oq/2KeXUsUUBLPgQ8bHUbsJxsN0RghtaGxKL6CuweftqKlSfwL4YxcWQmWZ12N4Exnej
         bXsoBa8aNzig0JEVGrK+FkbzPfmuDMEO7mm0qQZEBpEL+lEFymYTUbslW58OP3piM5t4
         gP+ThygnWAlR/IVGCi6ilCu8k+XZyCEshXfwIT1D0J5WdXM6Y9i80ezlgMnaRhwELiOq
         GGOlnAfeOSwNhKeY/cAjAaOhJFVuOB8Uk7eqEAYvLYssbdqNUCVD4KIbh+KKzh3+iO+c
         EY4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQ6y6fhqa0eGvehyjmpUR0ao1N6pGBfg6cz/bqsDnqd1EioGzHKYm0nUm1xNZA91wD0X+5NWrW5CyKL9+5ZhAz9eJbjKDzzo7xFy8fH4vHgg==
X-Gm-Message-State: AOJu0YwbeGXje8wkZMClI5bLzcwIGFiL4MVfVD124BT6WJsZZEl1VAYa
	1WI0qCcIwkTl8JNFZvuniHgXA4P4utusPayicaXl/ux2u7ik5hOgF4JFfoli8BU=
X-Google-Smtp-Source: AGHT+IHezxs01d5kcwmted0mGR9db6XQJ8DPNJKKcSHGwequvX0hG8wypDlJ6PrTsz5uy59h4wPu7A==
X-Received: by 2002:a05:600c:4fc9:b0:426:8ee5:5d24 with SMTP id 5b1f17b1804b1-428e6b2f79fmr83890145e9.20.1722858917705;
        Mon, 05 Aug 2024 04:55:17 -0700 (PDT)
Received: from LQ3V64L9R2.home ([2a02:c7c:f016:fc00:8d0e:f0af:9e74:240a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb9d786sm196573695e9.44.2024.08.05.04.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 04:55:17 -0700 (PDT)
Date: Mon, 5 Aug 2024 12:55:15 +0100
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
Message-ID: <ZrC9oxIcKebAKpx3@LQ3V64L9R2.home>
References: <CAP045ArBNZ559RFrvDTsHj42S4W+BuReHe+XV2tBPSeoHOMMpA@mail.gmail.com>
 <20240715150410.GJ14400@noisy.programming.kicks-ass.net>
 <CAP045Aq3Mv2oDMCU8-Afe7Ne+RLH62120F3RWqc+p9STpcxyxg@mail.gmail.com>
 <20240715163003.GK14400@noisy.programming.kicks-ass.net>
 <CAP045Apu6Sb=eKLXkZ5TWitWbmGHMDArD1++81vdN2_NqeFTyw@mail.gmail.com>
 <ZpYgYaKKbw3FPUpv@krava>
 <CAEf4BzZWWzio9oPe2_jS=_7CnKuJnugr2h4yd3QY1TqSF0aMXQ@mail.gmail.com>
 <CAP045ArhO4K2vcrhG_GnJNhx=+7v6WLYKsDj4CvqO7HKzBshXg@mail.gmail.com>
 <CAEf4BzbE4keci=hyt2APp5sfimvqfpLoWgEgEnC=Yp5S-jejKg@mail.gmail.com>
 <CAP045ArBf5Ja4s_gkg3vQciw0v7_h4kWjnbLUSk=uFgQ7WbTqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP045ArBf5Ja4s_gkg3vQciw0v7_h4kWjnbLUSk=uFgQ7WbTqQ@mail.gmail.com>

On Fri, Jul 26, 2024 at 09:35:43AM -0700, Kyle Huey wrote:
> Will do.
> 
> - Kyle
> 
> On Fri, Jul 26, 2024 at 9:34 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Jul 26, 2024 at 5:37 AM Kyle Huey <me@kylehuey.com> wrote:
> > >
> > > On Fri, Jul 19, 2024 at 11:26 AM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Tue, Jul 16, 2024 at 12:25 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > > >
> > > > > On Mon, Jul 15, 2024 at 09:48:58AM -0700, Kyle Huey wrote:
> > > > > > On Mon, Jul 15, 2024 at 9:30 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > > > > >
> > > > > > > On Mon, Jul 15, 2024 at 08:19:44AM -0700, Kyle Huey wrote:
> > > > > > >
> > > > > > > > I think this would probably work but stealing the bit seems far more
> > > > > > > > complicated than just gating on perf_event_is_tracing().
> > > > > > >
> > > > > > > perf_event_is_tracing() is something like 3 branches. It is not a simple
> > > > > > > conditional. Combined with that re-load and the wrong return value, this
> > > > > > > all wants a cleanup.
> > > > > > >
> > > > > > > Using that LSB works, it's just that the code aint pretty.
> > > > > >
> > > > > > Maybe we could gate on !event->tp_event instead. Somebody who is more
> > > > > > familiar with this code than me should probably confirm that tp_event
> > > > > > being non-null and perf_event_is_tracing() being true are equivalent
> > > > > > though.
> > > > > >
> > > > >
> > > > > it looks like that's the case, AFAICS tracepoint/kprobe/uprobe events
> > > > > are the only ones having the tp_event pointer set, Masami?
> > > > >
> > > > > fwiw I tried to run bpf selftests with that and it's fine
> > > >
> > > > Why can't we do the most straightforward thing in this case?
> > > >
> > > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > > index ab6c4c942f79..cf4645b26c90 100644
> > > > --- a/kernel/events/core.c
> > > > +++ b/kernel/events/core.c
> > > > @@ -9707,7 +9707,8 @@ static int __perf_event_overflow(struct perf_event *event,
> > > >
> > > >         ret = __perf_event_account_interrupt(event, throttle);
> > > >
> > > > -       if (event->prog && !bpf_overflow_handler(event, data, regs))
> > > > +       if (event->prog && event->prog->type == BPF_PROG_TYPE_PERF_EVENT &&
> > > > +           !bpf_overflow_handler(event, data, regs))
> > > >                 return ret;
> > > >
> > > >
> > > > >
> > > > > jirka
> > > > >
> > >
> > > Yes, that's effectively equivalent to calling perf_event_is_tracing()
> > > and would work too. Do you want to land that patch? It needs to go to
> > > 6.10 stable too.
> >
> > I'd appreciate it if you can just incorporate that into your patch and
> > resend it, thank you!
> >
> > >
> > > - Kyle

I probably missed the updated patch, but I am happy to test any new
versions, if needed, to ensure that the bug I hit is fixed.

Kyle: please let me know if there's a patch you'd like me to test?

- Joe
