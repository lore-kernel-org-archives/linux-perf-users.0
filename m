Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982A023956F
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Feb 2025 18:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738867275; cv=none; b=c5Ussa/V296j2ci0ETSWDhL+nqERkZb/PEwdqkQrP/29Rzv2SaRKJvhfBeO/gg1SYmSIifLEW0y7j30Gs/gcH2Hm93OH3q4mz4ZhUCLj+sPheKnB03LOKwbLTJ3kvU5W6guF0j+9wkYumuyP5MMMxsrPjOnKtjwYr08sYvfQeWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738867275; c=relaxed/simple;
	bh=nvffeYadc3fpJEHQH7BAtYU030TLHFW2jziAIX4uGTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B45+K9i1QPc8PPaZxPb64FUNKkQhWS4mNsgE+T5NgPsuw0g/GI6/ONUh3TlnSMIpLpLrY4pA2G3n3yWrkUmM1QfHLZdNsQ5822bsJv6DIFRx6Ozz4H0sorbPXyKir6Z2u8yfbJH0uJrSSQTV417jIuLH7BazOb0aY3iXd52K3nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HHTeqURp; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HHTeqURp"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5401bd6cdb7so1356186e87.2
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Feb 2025 10:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738867272; x=1739472072; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qk45u5eL6UrjO7ujgKkxwsztPQtoNsoUKCE3ySDBx+o=;
        b=HHTeqURpL5ERyXOvt+kZWqGTgRxrNEP4yndbT4HAZIrVvZkOkyKElDzZvouy8KF5HP
         3HsV04RJPqsRhNMjZDpudnTjg7pztxBLZI11WHWbUuvzfyEiMibqzH2TCauB9xeGdxuD
         MSAb364tIZkIf4ACn9+3G9d1Rjc2aWtPrmRd5PXhO4a906/ylsMzDy8eUEz6J4871csx
         S6/ZnR7hWtUZs/lcPW7ZEvaOfK+wtSy9JyR9YtRXq6wdjB/gcDDBLV6W71p5GzBHt8VX
         iUA9ICG6fwEL5aiJdlfQUZ4XQQ5mBMFHv8CF/U4kK2FFDsjwl8lfA7iWcjPFeko/VvhU
         AxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738867272; x=1739472072;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qk45u5eL6UrjO7ujgKkxwsztPQtoNsoUKCE3ySDBx+o=;
        b=VaiW+bgjBFahNazeRHLGMBzmQU0Sc+riKZz0xim1KZE7TKzjEcL1HFLWdFL1U/80Bq
         n0PKIRBG1P+AouFI4Ua//W/CZhtuU29eX/NAMu+cHOSDh9AzHwQSM5f50jX+6w7RsDfL
         EXI0Ne2nzy4tAApjOcCRqCQHvtI4rgOdAveQVB9ysNRF5yuk9mIGbzMPipu3/pMCaL6b
         l8Nnk7vq/+KcxNrl2TxzToDuZoVo3xXPBRGSL7YgQ0R40fA9ogGrSeDc1jymMbTtA5G/
         +Djo5oPYyhb2FnKC5xZsKHXPp5Tz2IOzObmIika320Lz4w4YYSyKDneh8U5rPPPR1E/Y
         CNnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdQtGp5VgaaGqL/JyiI7VDQK5M4572oZDxSDl/0lTq9aWUavLo/sLKDZu/oJGYqsSAowmPg+24yT7hOtuglCPP@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxvwxtqbdm4K6De4vAt02qgbJrTP9lm2eW1DiBHKdt0yG5qLo6
	L9UF81smb0KqV0eE9+oFf02WUzH0sjWRnOTrzAAyvokkoMgzyseCvAURrkeQWdJMzHtHy6QE92x
	rS098Z4nZ5bkVamuTnpDJ60k4nTLEXMALNOI4
X-Gm-Gg: ASbGncuRXkgub8lgBwRcNPdyzGbQb1LfuK83TV6APm/YCvNVvRKh9LqN0Ja86/ahms4
	2kxzDogTcw07YHhSUASAQNxMYe13ezM39fXv6WDgN1YpB7I2JDmBEijpY0egQmcxiegxRMggMup
	oAaRj6tNTr+z5XeTLXyQC5fIyr2PzDlQ==
X-Google-Smtp-Source: AGHT+IFLD0AMOveUgIxfuaFXAqWtATyO7+L5W8zqlnflXwDNc6nRZ8Py06TbH/yLATDOr7fr48Td6f9hVXFBvs+WP+E=
X-Received: by 2002:a05:6512:6d2:b0:544:123e:331a with SMTP id
 2adb3069b0e04-544123e3555mr894484e87.14.1738867271542; Thu, 06 Feb 2025
 10:41:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1738772628.git.dvyukov@google.com> <87ldujkjsi.fsf@linux.intel.com>
In-Reply-To: <87ldujkjsi.fsf@linux.intel.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 6 Feb 2025 19:41:00 +0100
X-Gm-Features: AWEUYZlYIYYrxtBDXZaUPnHA29Ll1mqyfEjy95EoBl8Vi8hkcfBXpCgUndmyCqA
Message-ID: <CACT4Y+aVWH6d7kuxzvcJSarXMQB-PPDTcE5OvN2tjkOLnzmMLg@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] perf report: Add latency and parallelism profiling
To: Andi Kleen <ak@linux.intel.com>
Cc: namhyung@kernel.org, irogers@google.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Feb 2025 at 19:30, Andi Kleen <ak@linux.intel.com> wrote:
>
> Dmitry Vyukov <dvyukov@google.com> writes:
>
> > There are two notions of time: wall-clock time and CPU time.
> > For a single-threaded program, or a program running on a single-core
> > machine, these notions are the same. However, for a multi-threaded/
> > multi-process program running on a multi-core machine, these notions are
> > significantly different. Each second of wall-clock time we have
> > number-of-cores seconds of CPU time.
>
> I'm curious how does this interact with the time / --time-quantum sort key?
>
> I assume it just works, but might be worth checking.

I will check later. But if you have some concrete commands to try, it
will help. I never used --time-quantum before.


> It was intended to address some of these issues too.
>
> > Optimizing CPU overhead is useful to improve 'throughput', while
> > optimizing wall-clock overhead is useful to improve 'latency'.
> > These profiles are complementary and are not interchangeable.
> > Examples of where latency profile is needed:
> >  - optimzing build latency
> >  - optimizing server request latency
> >  - optimizing ML training/inference latency
> >  - optimizing running time of any command line program
> >
> > CPU profile is useless for these use cases at best (if a user understands
> > the difference), or misleading at worst (if a user tries to use a wrong
> > profile for a job).
>
> I would agree in the general case, but not if the time sort key
> is chosen with a suitable quantum. You can see how the parallelism
> changes over time then which is often a good enough proxy.

Never used it. I will look at what capabilities it provides.

> > We still default to the CPU profile, so it's up to users to learn
> > about the second profiling mode and use it when appropriate.
>
> You should add it to tips.txt then

It is done in the docs patch.

> >  .../callchain-overhead-calculation.txt        |   5 +-
> >  .../cpu-and-latency-overheads.txt             |  85 ++++++++++++++
> >  tools/perf/Documentation/perf-record.txt      |   4 +
> >  tools/perf/Documentation/perf-report.txt      |  54 ++++++---
> >  tools/perf/Documentation/tips.txt             |   3 +
> >  tools/perf/builtin-record.c                   |  20 ++++
> >  tools/perf/builtin-report.c                   |  39 +++++++
> >  tools/perf/ui/browsers/hists.c                |  27 +++--
> >  tools/perf/ui/hist.c                          | 104 ++++++++++++------
> >  tools/perf/util/addr_location.c               |   1 +
> >  tools/perf/util/addr_location.h               |   7 +-
> >  tools/perf/util/event.c                       |  11 ++
> >  tools/perf/util/events_stats.h                |   2 +
> >  tools/perf/util/hist.c                        |  90 ++++++++++++---
> >  tools/perf/util/hist.h                        |  32 +++++-
> >  tools/perf/util/machine.c                     |   7 ++
> >  tools/perf/util/machine.h                     |   6 +
> >  tools/perf/util/sample.h                      |   2 +-
> >  tools/perf/util/session.c                     |  12 ++
> >  tools/perf/util/session.h                     |   1 +
> >  tools/perf/util/sort.c                        |  69 +++++++++++-
> >  tools/perf/util/sort.h                        |   3 +-
> >  tools/perf/util/symbol.c                      |  34 ++++++
> >  tools/perf/util/symbol_conf.h                 |   8 +-
>
> We traditionally didn't do it, but in general test coverage
> of perf report is too low, so I would recommend to add some simple
> test case in the perf test scripts.

What of this is testable within the current testing framework?
Also how do I run tests? I failed to figure it out.
