Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAF013212A
	for <linux-perf-users@vger.kernel.org>; Sat, 31 May 2025 06:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748673083; cv=none; b=Zv08kgdk6S057cwjPqqQldYIIFyI41OlJLU9ZRxr6sRK860Wjday9j5KgAvdSdAzx5lrfXvLtkqg8/BLcv0A2b7x5nGyn4DRr6peeKct6gBKdhbtpbUl5lyMHAdjGLm6qPJd/ZeunWcA+8RWvF3ZZIgptDMwviXdAexJmoRNt1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748673083; c=relaxed/simple;
	bh=CoXc0dCTOqLMCSZiQCdApcQAWyCSGk0wug+xWpDaT0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nAoOij45FvUBT9H/VAD2JTfPfhXVoEF+3dciGIodZ/6c38f2kHmjT8UwZrqsrnmIj4nnF9PWgMN4+fL3XRFRhka2Vb0Vd50lTqDk0n4yau+Pi//7eR9anYyJXod5stxSxp8naKE065yACNoo8xc4pdGmjEBXBHzB/Aaqrhhmydk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bUKubEWP; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bUKubEWP"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-31062172698so27970021fa.0
        for <linux-perf-users@vger.kernel.org>; Fri, 30 May 2025 23:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748673079; x=1749277879; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wWFXw3UdeTmdyAQraXFf2yqqkKSC8Rgoldk84MrVeHA=;
        b=bUKubEWPFBycap9GfZ9dW2SJIFpcEbAYCWQbDmN9mRK0SNG2mT2DZJP+a9ZPsBe/yX
         POJkfEdI0H5WKPJRh6aanNGWAzihWaFbM2eK4cuggMH2DH/sqHl88Y8gJsqEsv9IdSCP
         leTnxz45/eaVhL6Y7jC2dLsDUX4yhc51EufN5oPPLOoxgtSXpTXAK8V33gRLOl1uK+rs
         4r+5kOiU+WsrTugKJ9MlVWDyEpRns9oVKqf0N/eLZH82iiXOxuaKmlhuxpT8K2VT1ba9
         SBkF92rNQ4pGEf8rig8ZgPQ65W8tYddQUQ85w6DhpUBOfK0Zc+B7S7eMrU/+n202t9la
         +h4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748673079; x=1749277879;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wWFXw3UdeTmdyAQraXFf2yqqkKSC8Rgoldk84MrVeHA=;
        b=wl0TpNnN5Crh2oMG+kcUSuE+UrzV3Z0ZgrRJz3ZB+/VgipBc0e7amgeCVa7B9LScuy
         006kPEocSEOhKrGLCFjVNHYdkTPbeXGX6nps0VsjCvqE4VgwhdeZ7nrMx/IeBPNzIYTW
         bFkBjXcrHnXmO3oOBzJiW9gcpTBLNanXzgTo9OVxFGG3qyhGNcQdYawG92mjqtNb0R3i
         qzhba4PMQLsoCWdLR18kl1Co+LztAXP8pqZO0Y2oTO9kgty0v+0roeNKZeWMyiMn22j1
         g5sW3nS1NIVdbrWU2Q0UaN9fLJGSzKH+QsVkRnq5k6cZOSj/WBHja/c0XizNlPItkgM2
         GIjA==
X-Forwarded-Encrypted: i=1; AJvYcCUr6M0oYPdg8bfnwAnjvEDg6vlkudIuOXTFjcjEOYLWvYo5cz1IzYQ6EYthF1oTXg+GwFFtDwhahqbsibYt3sBT@vger.kernel.org
X-Gm-Message-State: AOJu0YwM7q+M3+iqpGiM5i5Lcnaa6ZlUZQ5GDfMiJ40V1s6hW6unJknW
	Vss8ArrxkfE1C31c4vQRn8EUoD/XiudnAmlN0HJ/WbhesRsMrTvakS2+sPv02OEzi6cZO3ejd2v
	Cr0/l7OOGS0qt3Xt3AogoaxLvlsqND2OxUPFZbr1B
X-Gm-Gg: ASbGncsUR1cEDnvAhz8ik23CEaYlwWPPKKxas3lGNW7FBfBJdN7xRyhZU55RMeXfU7c
	sQmx4FPPmyuZMuARfPDDtRk7+OcSMQBow+HGB3Xiqzm0Tb1NVMA6LCw7qhEQX5v/Zf+nSx0PAdd
	f6p0NYN591HAbw0EqWZTEKod4F4KrYaL86/ykzW7UBLM9jCTm74vztq61Z2nk1G/Ms4VitsMqqr
	Yjd
X-Google-Smtp-Source: AGHT+IHdLWbK7BMIbV54SHtKp6nI8Lx6kIibmwBh1RypY+YX9tUCTbr5mxcKqccGQisd29DGMy40FlXzf8vMWGvDJ7M=
X-Received: by 2002:a05:651c:1470:b0:32a:88b8:9bb with SMTP id
 38308e7fff4ca-32a9e9ce1c1mr2742301fa.11.1748673079299; Fri, 30 May 2025
 23:31:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACT4Y+YacgzrUL1uTqxkPOjQm6ryn2R_nPs8dgnrP_iKA9yasQ@mail.gmail.com>
 <aCdo6Vz2MVv3N0kk@google.com> <CACT4Y+YHxXjCU2jySTUO5kH=xC8scdzTTuP2qEBc5zMber44Aw@mail.gmail.com>
 <aCveO4qQGy03ow5p@google.com> <CACT4Y+YdnQebkGTQJ9yhLs2j12WBYk2ReiBAq5cE+wtu1RRU5A@mail.gmail.com>
 <aC0HH45JCBTchZMc@google.com> <CACT4Y+apAJ_m9W=P2hsGvWrGZnTzxB+9qgJg=ujjU8OWCVcUoQ@mail.gmail.com>
 <CACT4Y+Z3Bbn3KcwhjOYAmzHWqRSZ4ywCrw8FNNxj5MrDUzFtVg@mail.gmail.com>
 <aDdYEH3lIYHAB-lk@google.com> <CACT4Y+Y=1aXG_25ONnfD4TxMbsrnW3uFOOL9yrcP+LYeh4pHpg@mail.gmail.com>
 <aDormwKnOYm_-Jgs@google.com>
In-Reply-To: <aDormwKnOYm_-Jgs@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Sat, 31 May 2025 08:31:07 +0200
X-Gm-Features: AX0GCFviC7XJS3BaHNpqUb4Z5Ty9Rd3yiY1UkSqSOuXvQPCVo1G2J50a8_DnJ94
Message-ID: <CACT4Y+Z4Yr_jNV56NvdiJeUzMDmubFL5BtkACDXWaTGxZC2deg@mail.gmail.com>
Subject: Re: [RFC/PATCH] perf report: Support latency profiling in system-wide mode
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 31 May 2025 at 00:05, Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Fri, May 30, 2025 at 07:50:45AM +0200, Dmitry Vyukov wrote:
> > On Wed, 28 May 2025 at 20:38, Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > Hello,
> > >
> > > On Tue, May 27, 2025 at 09:14:34AM +0200, Dmitry Vyukov wrote:
> > > > On Wed, 21 May 2025 at 09:30, Dmitry Vyukov <dvyukov@google.com> wrote:
> > > > >
> > > > > > Maybe we can use this
> > > > > > only for the frequency mode which means user didn't use -c option or
> > > > > > similar in the event description.
> > > >
> > > >
> > > > All-in-all I think the best option for now is using CPU IDs to track
> > > > parallelism as you suggested, but be more precise with idle detection.
> > > > 2 passes over the trace may be fine to detect idle points. I see the
> > > > most time now spent in hist_entry__cmp, which accesses other entries
> > > > and is like a part of O(N*logN) processing, so a simple O(N) pass
> > > > shouldn't slow it down much.
> > > > That's what I would try. But I would also try to assess the precision
> > > > of this approach by comparing with results of using explicit switch
> > > > events.
> > >
> > > It's not clear to me how you want to maintain the idle info in the 2
> > > pass approach.  Please feel free to propose something based on this
> > > work.
> >
> >
> > What part of it is unclear?
> >
> > Basically, in the first pass we only mark events as sched_out/in.
> > When we don't see samples on a CPU for 2*period, we mark the previous
> > sample on the CPU as sched_out:
> >
> >   // Assuming the period is stable across time and CPUs.
> >   for_each_cpu(cpu) {
> >       if (current[cpu]->last_timestamp + 2*period < sample->timestamp) {
> >           if (current[cpu]->thread != idle)
> >               current[cpu]->last_sample->sched_out = true;
> >       }
> >   }
> >
> >   leader = machine__findnew_thread(machine, sample->pid);
> >   if (current[sample->cpu]->thread != leader) {
> >     current[sample->cpu]->last_sample->sched_out = true;
> >     sample->sched_in = true;
> >   }
> >   current[sample->cpu]->thread = leader;
> >   current[sample->cpu]->last_sample = sample;
> >   current[sample->cpu]->last_timestamp = sample->timestamp;
>
> Oh, you wanted to save the info in the sample.  But I'm afraid it won't
> work since it's stack allocated for one-time use in the
> perf_session__deliver_event().

No, I just showed the algorithm. I don't know perf well enough to say
how to implement it.

> > On the second pass we use the precomputed sched_in/out to calculate parallelism:
> >
> >   leader = machine__findnew_thread(machine, sample->pid);
> >   if (sample->sched_in)
> >     leader->parallelism++;
> >   sample->parallelism = leader->parallelism;
> >   if (sample->sched_out)
> >     leader->parallelism--;
> >
> > This is more precise b/c we don't consider a thread running for
> > 2*period after it stopped running.
>
> IIUC it can make some samples have less parallelism right before
> they go to idle.
>
> > A more precise approach would probably be to consider the thread
> > running for 0.5*period after the last sample (and similarly for
> > 0.5*period before the first sample), but it would require injecting
> > sched_in/out events into the trace at these points.
>
> Yep, that will fix the issue.  But then how to inject the events is the
> problem.

Yes, but incorrect data is incomparably worse problem than writing a
bit of code.
