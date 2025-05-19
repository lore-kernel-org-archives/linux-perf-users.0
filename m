Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4594205E16
	for <linux-perf-users@vger.kernel.org>; Mon, 19 May 2025 06:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747634465; cv=none; b=NgNgJmkYIaAFkRses+P+Mb/eVRSvEECGjbpOkOOy8Sa/PxosAZpUQ8F2yHeEoArxD8UXFoj2NgXw2KQstu5pg/LlbXsR1I/hFrtWrk8wKBkbbe34wqC2YexYDIzWmiNQ/NxoYzjgZqrKSosXVICSSi/+hXd3rQHuIzqV6VzKqJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747634465; c=relaxed/simple;
	bh=zGKLanqdBDjBH2n2RwqntomLdaHBIfd8P6s++6bckvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kfQ8Di2kOKBgfs6W95zrTHcJQeeGcPqK3KCYnbzX/E+6VwymgD+/Gzc09/am/f6y2IA7LUbzCgYi8dxkxO4he7w6ICFL35Hv/CkMSAJIn8Vqo2RWXzuqtk88y5qrNdsVhrAfkLRXhWGQ1UQUAcRIxot3tjVYoKM4OFpTGu+gBz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qTX/hgIc; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qTX/hgIc"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-551f00720deso709445e87.0
        for <linux-perf-users@vger.kernel.org>; Sun, 18 May 2025 23:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747634462; x=1748239262; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=btNxEnXkCBKhDgCVf39HqiEvekCT9disq1c7ypL1rjI=;
        b=qTX/hgIcbr0D6yRJ60ulKGjPnROnjZpY/LmW6eLK4tIp8qtCklFuhiLKnttihmhKjF
         jsuuf956WjzwMRyD/kntDsQnNTO8utDd5ym27TdoRmYq6MKfLU8bM+07VAT50g+ZkGto
         uN1LCaoYgFdPi/Fd45V9TrfqHIl5YUUdz01QMxJfHT5u/e7xB2Z9hvP8bVfv05ApN5j0
         NfkbMqD/Kq3vHUOh5FCbF7/Z91ACaF3tADQrLvmKPsZRazEMRagnWuaFm7NXVl95+CeX
         nmjyWi77JT8TzHXDEwNKJ1ffw/VXO6+KMHaeFJ5y7ERGKO630l43bxGZP4sXpi8lhdcE
         g0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747634462; x=1748239262;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=btNxEnXkCBKhDgCVf39HqiEvekCT9disq1c7ypL1rjI=;
        b=AOplN/ENPvG+vI6b7Su8144ioVOWvbehGZffyxatba+p/hc19XmFye41j3xxOnJioE
         qdkocooaiwtOwef73596I+QWA8WW/q+H9y9GJjL0cruHJDhETCWhAM/ciW8PYxKFQOqr
         Dv86puBfMgReKAeaGl7MjE9ZVCZ1wBEuuA4EBhikjNkiWcN+S/sEpwkuukUxT8CP6Ciy
         Z4CL0/3efocyBNlKD7anuyOMU4ubPxfOUmpP1PQpD3EZKCquViU6d7rFZvDRj3ETVCGm
         wMhz/M+Ta5eir8/OSOZr22vQfAQC2qkiHbJw+XtO69mSUxGSTOZkWr3IaK6znSNwNl5y
         XjkA==
X-Forwarded-Encrypted: i=1; AJvYcCWFqSxR3BPM7uksTSe+2T9ILDrDSOkvrj2ULlb2dhaX2EKEACMuOOPoqwkovNb8wLPgOp/NVjqSwe1ytFkHoWhL@vger.kernel.org
X-Gm-Message-State: AOJu0YxXdd/eCbIiiAwtw4OpKLYaKaRn2iFPdbMqQ3Q5lEAiF5jP+fG0
	f9JxDbFH0YHYglEHsgIdIA0fHp3JrtZ58zRqKQueNuoEAXgbnNat4qKGoRNHpF+OjXDd3hzorre
	bZF4OPNAfIBFXfTCKmL4AxwV+Z/duenNjCdDBg3jl
X-Gm-Gg: ASbGncuHHfybM+UfI+jZIVTpuM+y7okoZ8ZaZKVN+e0L3Zl5g5zKJUMd4qJqa0Rm78S
	TfIsdNUJdZBx5NzmMiRgK+QOEYj1QXUEWxR9co51Q1WtX/8SSPr1LDY9bwdvGwPQbGHwExPB4n8
	U5L7VOmWmYETXzvttpZjckuNU2S8l8aSuDRKqJCzifYrwRx30s3nbeGDn/qSCWDvDUQQ==
X-Google-Smtp-Source: AGHT+IHmNzUvpkCP3LaZQZ2t1mPyUDUkFC0ewOzgseX8R3Whoth9RBFCwFyaUATu13s7KSKYxpL2cBB79USyXuUg2jA=
X-Received: by 2002:a05:6512:a92:b0:549:39ca:13fc with SMTP id
 2adb3069b0e04-550e9938627mr2467673e87.49.1747634461101; Sun, 18 May 2025
 23:01:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250503003620.45072-1-namhyung@kernel.org> <CACT4Y+Yr7vffLYG+YmyB=9Vn_oxdQqR_6U4d-_WeQoOtPXZ6iw@mail.gmail.com>
 <aBmei7cMf-MzzX5W@google.com> <CACT4Y+ameQFd3n=u+bjd+vKR6svShp3NNQzjsUo_UUBCZPzrBw@mail.gmail.com>
 <aBmvmmRKpeVd6aT3@google.com> <CACT4Y+bm4gCO_sGvEkxLQfw8JyrWvCzqV_H5h+oebt8kk1_Hwg@mail.gmail.com>
 <aBm1x2as1fraHXHz@google.com> <CACT4Y+aiU-dHVgTKEpyJtn=RUUyYJp8U5BjyWSOHm6b2ODp9cA@mail.gmail.com>
 <aBvwFPRwA2LVQJkO@google.com> <CACT4Y+YacgzrUL1uTqxkPOjQm6ryn2R_nPs8dgnrP_iKA9yasQ@mail.gmail.com>
 <aCdo6Vz2MVv3N0kk@google.com>
In-Reply-To: <aCdo6Vz2MVv3N0kk@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 19 May 2025 08:00:49 +0200
X-Gm-Features: AX0GCFt1vMv0b_iYLCvuOizirg0AVrg_V3aEGQp5wYPG0FItQmCpSkJp3EqikN4
Message-ID: <CACT4Y+YHxXjCU2jySTUO5kH=xC8scdzTTuP2qEBc5zMber44Aw@mail.gmail.com>
Subject: Re: [RFC/PATCH] perf report: Support latency profiling in system-wide mode
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 May 2025 at 18:33, Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello,
>
> Sorry for the delay.
>
> On Thu, May 08, 2025 at 02:24:08PM +0200, Dmitry Vyukov wrote:
> > On Thu, 8 May 2025 at 01:43, Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > On Tue, May 06, 2025 at 09:40:52AM +0200, Dmitry Vyukov wrote:
> > > > On Tue, 6 May 2025 at 09:10, Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > > > > Where does the patch check that this mode is used only for system-wide profiles?
> > > > > > > > Is it that PERF_SAMPLE_CPU present only for system-wide profiles?
> > > > > > >
> > > > > > > Basically yes, but you can use --sample-cpu to add it.
> > > > > >
> > > > > > Are you sure? --sample-cpu seems to work for non-system-wide profiles too.
> > > > >
> > > > > Yep, that's why I said "Basically".  So it's not 100% guarantee.
> > > > >
> > > > > We may disable latency column by default in this case and show warning
> > > > > if it's requested.  Or we may add a new attribute to emit sched-switch
> > > > > records only for idle tasks and enable the latency report only if the
> > > > > data has sched-switch records.
> > > > >
> > > > > What do you think?
> > > >
> > > > Depends on what problem we are trying to solve:
> > > >
> > > > 1. Enabling latency profiling for system-wide mode.
> > > >
> > > > 2. Switch events bloating trace too much.
> > > >
> > > > 3. Lost switch events lead to imprecise accounting.
> > > >
> > > > The patch mentions all 3 :)
> > > > But I think 2 and 3 are not really specific to system-wide mode.
> > > > An active single process profile can emit more samples than a
> > > > system-wide profile on a lightly loaded system.
> > >
> > > True.  But we don't need to care about lightly loaded systems as they
> > > won't cause problems.
> > >
> > >
> > > > Similarly, if we rely on switch events for system-wide mode, then it's
> > > > equally subject to the lost events problem.
> > >
> > > Right, but I'm afraid practically it'll increase the chance of lost
> > > in system-wide mode.  The default size of the sample for system-wide
> > > is 56 byte and the size of the switch is 48 byte.  And the default
> > > sample frequency is 4000 Hz but it cannot control the rate of the
> > > switch.  I saw around 10000 Hz of switches per CPU on my work env.
> > >
> > > >
> > > > For problem 1: we can just permit --latency for system wide mode and
> > > > fully rely on switch events.
> > > > It's not any worse than we do now (wrt both profile size and lost events).
> > >
> > > This can be an option and it'd work well on lightly loaded systems.
> > > Maybe we can just try it first.  But I think it's better to have an
> > > option to make it work on heavily loaded systems.
> > >
> > > >
> > > > For problem 2: yes, we could emit only switches to idle tasks. Or
> > > > maybe just a fake CPU sample for an idle task? That's effectively what
> > > > we want, then your current accounting code will work w/o any changes.
> > > > This should help wrt trace size only for system-wide mode (provided
> > > > that user already enables CPU accounting for other reasons, otherwise
> > > > it's unclear what's better -- attaching CPU to each sample, or writing
> > > > switch events).
> > >
> > > I'm not sure how we can add the fake samples.  The switch events will be
> > > from the kernel and we may add the condition in the attribute.
> > >
> > > And PERF_SAMPLE_CPU is on by default in system-wide mode.
> > >
> > > >
> > > > For problem 3: switches to idle task won't really help. There can be
> > > > lots of them, and missing any will lead to wrong accounting.
> > >
> > > I don't know how severe the situation will be.  On heavily loaded
> > > systems, the idle task won't run much and data size won't increase.
> > > On lightly loaded systems, increased data will likely be handled well.
> > >
> > >
> > > > A principled approach would be to attach a per-thread scheduler
> > > > quantum sequence number to each CPU sample. The sequence number would
> > > > be incremented on every context switch. Then any subset of CPU should
> > > > be enough to understand when a task was scheduled in and out
> > > > (scheduled in on the first CPU sample with sequence number N, and
> > > > switched out on the last sample with sequence number N).
> > >
> > > I'm not sure how it can help.  We don't need the switch info itself.
> > > What's needed is when the CPU was idle, right?
> >
> > I mean the following.
> > Each sample has a TID.
> > We add a SEQ field, which is per-thread and is incremented after every
> > rescheduling of the thread.
> >
> > When we see the last sample for (TID,SEQ), we pretend there is SCHED
> > OUT event for this thread at this timestamp. When we see the first
> > sample for (TID,SEQ+1), we pretend there is SCHED IN event for this
> > thread at this timestamp.
> >
> > These SCHED IN/OUT events are not injected by the kernel. We just
> > pretend they happen for accounting purposes. We may actually
> > materialize them in the perf tool, or me may just update parallelism
> > as if they happen.
>
> Thanks for the explanation.  But I don't think it needs the SEQ and
> SCHED IN/OUT generated from it to track lost records.  Please see below.
>
> >
> > With this scheme we can lose absolutely any subset of samples, and
> > still get very precise accounting. When we lose samples, the profile
> > of course becomes a bit less precise, but the effect is local and
> > recoverable.
> >
> > If we lose the last/first event for (TID,SEQ), then we slightly
> > shorten/postpone the thread accounting in the process parallelism
> > level. If we lose a middle (TID,SEQ), then parallelism is not
> > affected.
>
> I'm afraid it cannot check parallelism by just seeing the current thread.
> I guess it would need information from other threads even if it has same
> SEQ.

Yes, we still count parallelism like you do in this patch, we just use
the SEQ info instead of CPU numbers and explicit switch events.

> Also postpone thread accounting can be complex.  I think it should wait
> for all other threads to get a sample.  Maybe some threads exited and
> lost too.

Yes, in order to understand what's the last event for (TID,SEQ) we
need to look ahead and find the event (TID,SEQ+1). The easiest way to
do it would be to do 2 passes over the trace. That's the cost of
saving trace space + being resilient to lost events.

Do you see any other issues with this scheme besides requiring 2 passes?


> In my approach, I can clear the current thread from all CPUs when it
> sees a LOST record and restart calculation of parallelism.
>
> >
> > The switches from a thread to itself is not a problem. We will just
> > inject a SCHED OUT followed by SCHED IN. But exactly the same happens
> > now when the kernel injects these events.
> >
> > But if we switch to idle task and got no samples for some period of
> > time on the CPU, then we properly inject SCHED OUT/IN that will
> > account for the thread not actually running.
>
> Hmm.. ok.  Maybe we can save the timestamp of the last sample on each
> CPU and clear the current thread after some period (2x of given freq?).
> But it may slow down perf report as it'd check all CPUs for each sample.
>
> Thanks,
> Namhyung
>
