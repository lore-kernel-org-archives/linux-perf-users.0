Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D25374BE1
	for <linux-perf-users@vger.kernel.org>; Sun, 19 Jan 2025 11:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737284932; cv=none; b=oLnOoyV9H6yzDTx1IzWg3nsPnEWS+4QvTjA0jUqwlJdNvYzRJCO9xUgHMDvgKT5A5+KfeXhY2c9hbn/faAzEHZzR14PhQL+36FKc5u7CDvbZumu6gFHuUCFuc4LRtm2advtObu9R68TwlYPX+sXyAK9znZuRPcy1bn5frCodOiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737284932; c=relaxed/simple;
	bh=ut9yTDqHNWYIr6lLVWtmFVq+wRfa58IwQVvgxL+/5G8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OU5qfQrzmXZO6xvqf7YGwJyZMKFdBoim0cOKqnUCkuKq60Px2W8ImT3ThH09BjQjnHhIHSInU3pkFbZNf8VE56ETGHH8fmIg/R13BZd8jS/NZhFyN2L4r7v4xRUGsrsRTdSAanlGKVQgymVI5IBfbHo8OK69B42VzvTVKrDPWPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y2NG9mzM; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y2NG9mzM"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30615661f98so38195931fa.2
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Jan 2025 03:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737284928; x=1737889728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JIEQfCUsKzBVpYrWku2yuMv4Vr5lH5R7DgEOVUl6us=;
        b=y2NG9mzMSob4hjMw3T6GBHlxKxLil7VidbKLC6fQ9zA3VwcIou92UPBseAsIpkBAvT
         iIlGjCCwE3wa+IHsT+4yiDxJt6yxBIsUmu6FK0DD5MkOIVvnDmHVMrAKAqjI5aInHgsY
         SBW65KTAVHNCKpQZM81b141TXI14ObTPui0Ik/t/XlHc0fi+bnKCwsPevZfRggMcv+l+
         +YYpd/VJJpClxSrI3FQK0OyQIq2efYFYOAP7hxC3SyvCdkykqyl96xEqdOTSNkMm1lQN
         vZFIZJGTP7EKkk0gc9FLa2QKe0qpMio7G9o1nLXMI31puSA42OYdN9Ng1amEXfcIRrjF
         4GVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737284928; x=1737889728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1JIEQfCUsKzBVpYrWku2yuMv4Vr5lH5R7DgEOVUl6us=;
        b=Binz1+t/jGDUmaMimkj9k7qP7PL3MT9cCQK3GmuZNttP8L6+k5KZT0oDZv7loorpRK
         47hEzxyVRzBJFuP1pOQ52f42N3fS7iAhlsZZ5P+p6j6e7r6DWSQwzfquCVPzOUu7mSDo
         QpjtdMd/sc/6XwntrNfOQYEy8cH1mmOCDkidfYhJyQFtsQwe3c95GTA8FiqvvPtoTRAn
         wr1ciI68n8CAX6ZUKIKelE06dktHtCbDqQ2sy+C4e98rTmgDdoJD7tTP/7jrOrlCbhJa
         fPeMpzasSBin7Yo+/jRwAuOQTQd85k+erf002CYkOUNjNAlVrXW2lDGDTnb8J6XB1cMt
         ITkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxxSC4n72xHQMmqrp+tEWKiCcRIW8iwLPu3xqIv5+BrnOFOmOfB6In27GgcWOxr/weP1IBZyIiz3xm77GxvPvH@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8KZbL1ODac1co2EKNjqxttidPcgsA/iCa0p94nPca3O7ms3D5
	ScjQAabwe/TsXR9P0170FxUZW8vNnr0P8Ha5kJPctZhDpym4kCbo/UnZY8aQDJ0KE9c9UFqzeMh
	uWf8NvvRnXOOiH2G5f0PP8WlG4JgF8Y7i3KJd
X-Gm-Gg: ASbGncsSuNi1MRkYDy+oiRFrZbIZKOCK5TOWWwXNILg5QkqUO+O7U4GyL8WtttTDFbq
	sB8Uncvew1yHM8lCOrNf/utmY/ChDweTupnqNuLDsW4xt+WCkcR+8FQYROkhrSzDluWava3M3wU
	p1jc3Huu4q
X-Google-Smtp-Source: AGHT+IGLW4T+/b+6iiktnGjwUL9ahOwVBUh7A5NO/XdZbBXV9/dPTCN9B4d5C96Ku1vbMAzrARf6hbfnMf2J83BJHpw=
X-Received: by 2002:a2e:bd01:0:b0:304:588a:99ce with SMTP id
 38308e7fff4ca-3072c994c81mr36694421fa.0.1737284927883; Sun, 19 Jan 2025
 03:08:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACT4Y+b4WYa9TSqKtDKTJNgXth1U30=KddutfSdp5gmXVOV_jA@mail.gmail.com>
 <20250113134022.2545894-1-dvyukov@google.com> <Z4XDJyvjiie3howF@google.com>
 <CACT4Y+b96xynNaZoBHP72-4tJM5Nzo3MBRW19_E7JsMKRWYCzg@mail.gmail.com>
 <CAP-5=fWHivx7Q6okMwYOs=65MZr40RjE16tgatMX0hjkCfrwfw@mail.gmail.com>
 <CACT4Y+Yh98VcNgmJ-gF9+inw=ZDkg1rRzi4_35f6krw8BBRpug@mail.gmail.com> <Z4lWDPpmdQDM1k6l@google.com>
In-Reply-To: <Z4lWDPpmdQDM1k6l@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Sun, 19 Jan 2025 12:08:36 +0100
X-Gm-Features: AbW1kvZVnmborYEGWImDjdyTZZtzQRfGfg6XBcKRakltamYyk-HPqHHmyX3N0i0
Message-ID: <CACT4Y+YMAM1eMEEWhGsOcGqPT2bn+4FRSp5ORgF0Qji8nmBzdQ@mail.gmail.com>
Subject: Off-CPU sampling (was perf report: Add wall-clock and parallelism profiling)
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Stephane Eranian <eranian@google.com>, 
	Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	chu howard <howardchu95@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 16 Jan 2025 at 19:55, Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Wed, Jan 15, 2025 at 08:11:51AM +0100, Dmitry Vyukov wrote:
> > On Wed, 15 Jan 2025 at 06:59, Ian Rogers <irogers@google.com> wrote:
> > >
> > > On Tue, Jan 14, 2025 at 12:27=E2=80=AFAM Dmitry Vyukov <dvyukov@googl=
e.com> wrote:
> > > [snip]
> > > > FWIW I've also considered and started implementing a different
> > > > approach where the kernel would count parallelism level for each
> > > > context and write it out with samples:
> > > > https://github.com/dvyukov/linux/commit/56ee1f638ac1597a800a30025f7=
11ab496c1a9f2
> > > > Then sched_in/out would need to do atomic inc/dec on a global count=
er.
> > > > Not sure how hard it is to make all corner cases work there, I drop=
ped
> > > > it half way b/c the perf record post-processing looked like a bette=
r
> > > > approach.
> > >
> > > Nice. Just to focus on this point and go off on something of a
> > > tangent. I worry a little about perf_event_sample_format where we've
> > > used 25 out of the 64 bits of sample_type. Perhaps there will be a
> > > sample_type2 in the future. For the code and data page size it seems
> > > the same information could come from mmap events. You have a similar
> > > issue. I was thinking of another similar issue, adding information
> > > about the number of dirty pages in a VMA. I wonder if there is a
> > > better way to organize these things, rather than just keep using up
> > > bits in the perf_event_sample_format. For example, we could have a
> > > code page size software event that when in a leader sampling group
> > > with a hardware event with a sample IP provides the code page size
> > > information of the leader event's sample IP. We have loads of space i=
n
> > > the types and config values to have an endless number of such events
> > > and maybe the value could be generated by a BPF program for yet more
> > > flexibility. What these events would mean without a leader sample
> > > event I'm not sure.
> >
> > In the end I did not go with adding parallelism to each sample (this
> > is purely perf report change), so at least for this patch this is very
> > tangential :)
> >
> > > Wrt wall clock time, Howard Chu has done some work advancing off-CPU
> > > sampling. Wall clock time being off CPU plus on CPU. We need to do
> > > something to move forward the default flags/options for perf record,
> > > for example, we don't enable build ID mmap events by default causing
> > > the whole perf.data file to be scanned looking to add build ID events
> > > for the dsos with samples in them. One option that could be a default
> > > could be off-CPU profiling, and when permissions deny the BPF approac=
h
> > > we can fallback on using events. If these events are there by default
> > > then it makes sense to hook them up in perf report.
> >
> > Interesting. Do you mean "IO" by "off-CPU".
> > Yes, if a program was blocked for IO for 10 seconds (no CPU work),
> > then that obviously contributes to latency, but won't be in this
> > profile. Though, it still works well for a large number of important
> > cases (e.g. builds, ML inference, server request handling are
> > frequently not IO bound).
> >
> > I was thinking how IO can be accounted for in the wall-clock profile.
> > Since we have SWITCH OUT events (and they already include preemption
> > bit), we do have info to account for blocked threads. But it gets
> > somewhat complex and has to make some hypotheses b/c not all blocked
> > threads contribute to latency (e.g. blocked watchdog thread). So I
> > left it out for now.
> >
> > The idea was as follows.
> > We know a set of threads blocked at any point in time (switched out,
> > but not preempted).
> > We hypothesise that each of these could equally improve CPU load to
> > max if/when unblocked.
> > We inject synthetic samples in a leaf "IO wait" symbol with the weight
> > according to the hypothesis. I think these events can be  injected
> > before each switch in event only (which changes the set of blocked
> > threads).
> >
> > Namely:
> > If CPU load is already at max (parallelism =3D=3D num cpus), we don't
> > inject any IO wait events.
> > If the number of blocked threads is 0, we don't inject any IO wait even=
ts.
> > If there are C idle CPUs and B blocked threads, we inject IO wait
> > events with weight C/B for each of them.
>
> To track idle CPUs, you need sched-switch of all CPUs regardless of your
> workload, right?  Also I'm not sure when do you want to inject the IO
> wait events - when a thread is sched-out without preemption?  And what
> would be the weight?  I guess you want something like:
>
>   blocked time * C / B
>
> Then C and B can change before the thread is woken up.

Yes, these events need to be emitted on every switch-in/out in the
trace so that a long blocked thread gets multiple events with
different weights.

> > For example, if there is a single blocked thread, then we hypothesise
> > that this blocked thread is the root cause of all currently idle CPUs
> > being idle.
>
> I think this may make sense when you target a single process group but
> it also needs system-wide idle information.

I assumed this profiling is done on a mostly idle system (generally
it's a good idea for any profiling).

Theoretically, we could look at runnable threads rather than running.
If there are NumCPU runnable threads, then creating more runnable
threads won't help.

> > This still has a problem of saying that unrelated threads contribute
> > to latency, but at least it's a simple/explainable model and it should
> > show guilty threads as well. Maybe unrelated threads can be filtered
> > by the user by specifying a set of symbols in stacks of unrelated
> > threads.
>
> Or by task name.
>
> >
> > Does it make any sense? Do you have anything better?
>
> I'm not sure if it's right to use idle state which will be affected by
> unrelated processes.  Maybe it's good for system-wide profiling.
>
> For a process (group) profiliing, I think you need to consider number of
> total threads, active threads, and CPUs.  And if the #active-threads is
> less than min(#total-threads, #CPUs), then it could be considered as
> idle from the workload's perspective.
>
> What do you think?

I don't know, hard to say. I see what you mean, but this makes the
problem even harder, and potentially breaking hypotheses we are
making.
For example, if we have 2 unrelated workloads A and B running on the
machine. Their high- and low-parallelism phases will overlap randomly,
and we will make conclusions from that, but these overlapping are
really random and may not hold next time. Or next time A may be
collocated with C.

I would solve the simpler problem of profiling a single workload on a
mostly idle system first, and only then move to the harder case. Are
you considering this for GWP-type profiling?
