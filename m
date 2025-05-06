Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACED4220F47
	for <linux-perf-users@vger.kernel.org>; Tue,  6 May 2025 06:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746513995; cv=none; b=hXDyGof12ZLX4TYgAkUM2O7NOQMPINmA4zEyRnveA3mknoZpbDBZcGZgIzRFhhGUe2DoJzlY+oLh7uu0gEl6/LDqz574rPpIZVujcCvONkaQGMbwg+6VmlM4HWxvZfLmduh8uZR6sF6OUFtnq9D/L89MU74RiZYRHUzQaMOl0Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746513995; c=relaxed/simple;
	bh=5Xi6j//R02dpub/R7xxHcBfZMhj1LSXeBKp5n05nTvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mnEB5E5/9bF9s17AxOV78aGMvoOPgNS3c/3ScDVDv6SwXkuHprwY/sadk4DsuhDwx/8lvUMyxPABQYEFwRwc/1EtmObgKZLOJbF5nnUEgLjeSTjCycxA9Qfna2Os4Ti3k0CcfDtkJwzcCOJnh+wVzUgpGFPWEIc6p2pD0s62EKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wv4ZsJPy; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wv4ZsJPy"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-54e816aeca6so6748395e87.2
        for <linux-perf-users@vger.kernel.org>; Mon, 05 May 2025 23:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746513992; x=1747118792; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+TkT8CQai/ZWtD1K5cF0ad1w9jdiTtki3uhfACJlgto=;
        b=wv4ZsJPy78qW2Ry7u6LbEeFyNfoBXAks1HWIXRhWF4dcMRKvydWJw6OBlbbK//QSr9
         3Nnz1fwBqKmM9rqdD6uAqlvs6v5pLDy6bytsx4HrWiNQjb0N7F3A6capq2AT/vJ4Tl4l
         ExFnEL7Q/JpN5G3dHxtEEYUgZeDrBR+4izajKEN0UCG2lQxBC85wmhG0g6IB0JgsXiTW
         7CfqgLFOAcIwVmHLmulUkDPcmGdU4GwR7MoOADCIUcXdwny0r4pVeR2tM9zc297Rxc0u
         NiEcq6Gt9r34ZmzAaxu4GHROTQw3JjYuSGtE84hKO9y+jglOfEawcj2JLNEP2TJTUJtR
         KXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746513992; x=1747118792;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+TkT8CQai/ZWtD1K5cF0ad1w9jdiTtki3uhfACJlgto=;
        b=LS6uS8ja7pN4BeGvaeCXf6IuK9G3I8eUAxIk2SZre9n4PkV38NDF7nSvL3yQWobK2M
         Of4xHLWp0mQsmXuFjDVuDla9WOutK4N4QbIk4vk8F6hD4DDmMVFsoDbnS1o1a0tAUAvR
         V5M9wuwAaYLT6qM792P2wn8U7RO/gKME4xNJfJFX+NP8eWQWGyTapN4hy92gNVHtGKJH
         MTqPAeBAaYpxSBe8KVdoTHgdp5z2pyd1lpBQMS1Uye29SQGcSxGIX3j5Mlld1I/2XcsO
         una+TQjasqTLXDyhFfaW6eLnHpU2gMcASD3I2e+KB45piHkIHulnwXE+QBFx+gUd6OUz
         iEOg==
X-Forwarded-Encrypted: i=1; AJvYcCVLxb0TFb0+a6QVSilt+ibb/9S1U/rtbmBDOZ//TCYrHXwZ1GoYOfcQ48oxeewLM2+S9IQ0oDtxGlnn47KzRfLq@vger.kernel.org
X-Gm-Message-State: AOJu0YxDOX8BOra0gQs3u0PTKt7pxJ/uODKV2A5h5Dx8t/WbeXUjmP1s
	cobpmISzw+Bv35/GWj/x9jwEVjiC2fOK8c/kFtsWT9dHXRPRzKmNCpcVRt+aNbfUJPNFhiZm7yt
	cbMZfDSi8pD802PA7JpxEra5RNLStcup9J9+7
X-Gm-Gg: ASbGncutbHmtd7wNYEaENtPdosQI5X4DnkDeIrLQ4BOMgUDBL+PMLJQbJuW0t9r3mft
	h8piSjIQmnN80V+eag7HZLL0wFcFwr6JXYqEqKsDdjzjyOt6K7OR83oY7eXp8mnYQfReCO6E6BH
	eN0Oz9LFJpiSap8DKfw+wba4TjfFMq3XhknCvs3SJuuHfPtGRZyVK0eXo=
X-Google-Smtp-Source: AGHT+IF/1cJ0gn0VbpuxAups41aSoda4aMlkyRVuVVCTnyySXdE5xjS3ApovhcJGPqcHbWgerPHgZOwlWlSuLsCbw5o=
X-Received: by 2002:a05:651c:b2a:b0:319:d856:c2f3 with SMTP id
 38308e7fff4ca-3266b59789emr4354901fa.10.1746513991522; Mon, 05 May 2025
 23:46:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250503003620.45072-1-namhyung@kernel.org> <CACT4Y+Yr7vffLYG+YmyB=9Vn_oxdQqR_6U4d-_WeQoOtPXZ6iw@mail.gmail.com>
 <aBmei7cMf-MzzX5W@google.com> <CACT4Y+ameQFd3n=u+bjd+vKR6svShp3NNQzjsUo_UUBCZPzrBw@mail.gmail.com>
 <aBmvmmRKpeVd6aT3@google.com>
In-Reply-To: <aBmvmmRKpeVd6aT3@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 6 May 2025 08:46:20 +0200
X-Gm-Features: ATxdqUEgdDVnyyriKiX9pDQDs3z8t8w0Gd3KuZT0JW1dkH5BkkyNq1pTZnz9pko
Message-ID: <CACT4Y+bm4gCO_sGvEkxLQfw8JyrWvCzqV_H5h+oebt8kk1_Hwg@mail.gmail.com>
Subject: Re: [RFC/PATCH] perf report: Support latency profiling in system-wide mode
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 May 2025 at 08:43, Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Tue, May 06, 2025 at 07:55:25AM +0200, Dmitry Vyukov wrote:
> > On Tue, 6 May 2025 at 07:30, Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > Hello,
> > >
> > > On Mon, May 05, 2025 at 10:08:17AM +0200, Dmitry Vyukov wrote:
> > > > On Sat, 3 May 2025 at 02:36, Namhyung Kim <namhyung@kernel.org> wrote:
> > > > >
> > > > > When it profile a target process (and its children), it's
> > > > > straight-forward to track parallelism using sched-switch info.  The
> > > > > parallelism is kept in machine-level in this case.
> > > > >
> > > > > But when it profile multiple processes like in the system-wide mode,
> > > > > it might not be clear how to apply the (machine-level) parallelism to
> > > > > different tasks.  That's why it disabled the latency profiling for
> > > > > system-wide mode.
> > > > >
> > > > > But it should be able to track parallelism in each process and it'd
> > > > > useful to profile latency issues in multi-threaded programs.  So this
> > > > > patch tries to enable it.
> > > > >
> > > > > However using sched-switch info can be a problem since it may emit a lot
> > > > > more data and more chances for losing data when perf cannot keep up with
> > > > > it.
> > > > >
> > > > > Instead, it can maintain the current process for each CPU when it sees
> > > > > samples.
> > > >
> > > > Interesting.
> > > >
> > > > Few questions:
> > > > 1. Do we always see a CPU sample when a CPU becomes idle? Otherwise we
> > > > will think that the last thread runs on that CPU for arbitrary long,
> > > > when it's actually not.
> > >
> > > No, it's not guaranteed to have a sample for idle tasks.  So right, it
> > > can mis-calculate the parallelism for the last task.  If we can emit
> > > sched-switches only when it goes to the idle task, it'd be accurate.
> >
> > Then I think the profile can be significantly off if the system wasn't
> > ~100% loaded, right?
>
> Yep, it can be.
>
> >
> > > > 2. If yes, can we also lose that "terminating" even when a CPU becomes
> > > > idle? If yes, then it looks equivalent to missing a context switch
> > > > event.
> > >
> > > I'm not sure what you are asking.  When it lose some records because the
> > > buffer is full, it'll see the task of the last sample on each CPU.
> > > Maybe we want to reset the current task after PERF_RECORD_LOST.
> >
> > This probably does not matter much if the answer to question 1 is No.
> >
> > But what I was is the following:
> >
> > let's say we have samples:
> > Sample 1 for Pid 42 on Cpu 10
> > Sample 2 for idle task on Cpu 10
> > ... no samples for some time on Cpu 10 ...
> >
> > When we process sample 2, we decrement the counter for running tasks
> > for Pid 42, right.
> > Now if sample 2 is lost, then we don't do decrement and the accounting
> > becomes off.
> > In a sense this is equivalent to the problem of losing context switch event.
>
> Right.  But I think it's hard to be correct once it loses something.
>
> >
> >
> > > > 3. Does this mode kick in even for non system-wide profiles (collected
> > > > w/o context switch events)? If yes, do we properly understand when a
> > > > thread stops running for such profiles? How do we do that? There won't
> > > > be samples for idle/other tasks.
> > >
> > > For non system-wide profiles, the problem is that it cannot know when
> > > the current task is scheduled out so that it can decrease the count of
> > > parallelism.  So this approach cannot work and sched-switch info is
> > > required.
> >
> > Where does the patch check that this mode is used only for system-wide profiles?
> > Is it that PERF_SAMPLE_CPU present only for system-wide profiles?
>
> Basically yes, but you can use --sample-cpu to add it.

Are you sure? --sample-cpu seems to work for non-system-wide profiles too.

> In util/evsel.c::evsel__config():
>
>         if (target__has_cpu(&opts->target) || opts->sample_cpu)
>                 evsel__set_sample_bit(evsel, CPU);
