Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99934156F38
	for <linux-perf-users@vger.kernel.org>; Fri, 26 Apr 2024 16:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714149959; cv=none; b=WG4nE5UHZW27eeT0O2c/+UFUdYvRBbgPdm24rzOO65jd7ykL1IB+Gjda1gyQ8dvWugQK0fEiuf028Is6yBjGpnMX0cDgfCWuQCkC1OmP7kQn3Wp+3yyJ2EefrwEyOvu+52XgExo3Y3D7KoETefqzdSj6K3cexaLeTVXZmEpEhhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714149959; c=relaxed/simple;
	bh=TsW6GTHiTQeGY0lIhBtmL90amY6atH1W3WIzWx9xDaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KUQjIIK4OQJoK1P/wWV5oML9FhtHjBVv1oOO39DLWj5OBkcFi66TyuMtoG5aAE0YnYhFuS+rDtwU/qB2LaJdX1MDLlno1O9Ex1nihx5qNuY6i4FLIYiuXg3b774T4Cu4IrNempsjymmA/s9GGRQmMQYalmlpAY3Bcf9QHB4ZUTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CBcpbqUk; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CBcpbqUk"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-36b3738f01cso3275ab.0
        for <linux-perf-users@vger.kernel.org>; Fri, 26 Apr 2024 09:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714149957; x=1714754757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iH10hcFVd/zxNn6ShOQRCsj816hnsyk+v3ag974TenE=;
        b=CBcpbqUkHKS1wCF/NeGv3oIaLT/+3cN+2XIfK1lxAbDerS7fXtC0b6w9DdVaX8PrQ2
         7NUG2WZ2Eh6wZ8myoe+TsbVu8r/sEXTnrzjfvmJIObUEiMUBFncPhEfr/HuKNCN5szHb
         ImXiiOoAJ96GJDu2vGR4T1OxDlXZ2J5ghm/zDTDGEYaEl+QeGLdwk0bCK4Ee77IfRo2J
         IlUdhNyrBw0c/jtI3aZQO53qAdjuISDgc+zdLvwpbQoI8BeR+hk886kWSiIvWpFzFSl7
         F0PmpY3i6SbRgIsLcbah2t6MDdygBUlnoC6LwCddhKH8z0Qfji6YBgRkefPRrnM4fJUl
         +6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714149957; x=1714754757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iH10hcFVd/zxNn6ShOQRCsj816hnsyk+v3ag974TenE=;
        b=b1hRjx+8k+nGAp8vzY3td9vpY1pAKh37cygDPDGL7rH5s86TPyQ1KMUpZc41YNPHsE
         tqQXOY1+MTNI5pfk0OohISWAPTGoS36z1mBJlRo5f3YIRAETGePkCZZqLi3DkBOQI5eY
         6qcnI/VfZgVlpILVHMdw3R2DvNhxWe3ALSv7HCK4U0rpk03vpyJtaqnYLVXDN+ntIKIl
         OB8E9yEk86FJLSN0ad31fsXGh1CoNNLewrRHyTt/ICfYtH+wRB6+QRb66A9xgzC6FhoN
         6s+8ELC5h0f8nL8Q8JyK0MOHDJJq3sZCl9+niS46E5k03lA65WHhDzWMEO0jICamuPTT
         pgrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxPQNaOxJB3/NhnTfKmr2+MdVoPO5ZSQCiLZlwbl53Ht0sWeTlLB9ZN+4yWdbKeYtHt3UHl2AEea62iZh43WqY3ZH+izFQkUlguKfMq+gS3A==
X-Gm-Message-State: AOJu0YxTuldyw+S5OmrMXZ5gW4Mhu1sYWSp9Sx0M3/nJVbI4Sc6N+dBU
	kOi1kpyJ0O7NQSHxNJT5G4pi9xWatnLck9WlaGrVtkSJbh10pGJFk8aIBqXyr1vaxF4ohib24VP
	vuXgy1r8SyO7iY34HwIyMwKYHVdMimbbFvEZq
X-Google-Smtp-Source: AGHT+IGyqiUHq+bsq/fcDLWIZFYHRSRwpnnauY5KJb3XD469uS70sYP9EhJoE2ZqedpHAuLk5QeNwVmENstOTUvQIIw=
X-Received: by 2002:a05:6e02:13f0:b0:36c:3046:a6ef with SMTP id
 w16-20020a056e0213f000b0036c3046a6efmr283307ilj.12.1714149956436; Fri, 26 Apr
 2024 09:45:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301174711.2646944-1-irogers@google.com> <3e54fea7-2a37-4774-8a6a-85f75cc4a9ea@arm.com>
 <88b460e5-ef2f-4b2f-a173-deac34c99788@intel.com>
In-Reply-To: <88b460e5-ef2f-4b2f-a173-deac34c99788@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 26 Apr 2024 09:45:42 -0700
Message-ID: <CAP-5=fWk6hMWMy93QgRAWUowRk5LNEkqRVa3u4h0fPRXyE-y+Q@mail.gmail.com>
Subject: Re: [PATCH v1] perf tests: Run tests in parallel by default
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: James Clark <james.clark@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 8:42=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 26/04/24 18:06, James Clark wrote:
> >
> >
> > On 01/03/2024 17:47, Ian Rogers wrote:
> >> Switch from running tests sequentially to running in parallel by
> >> default. Change the opt-in '-p' or '--parallel' flag to '-S' or
> >> '--sequential'.
> >>
> >> On an 8 core tigerlake an address sanitizer run time changes from:
> >> 326.54user 622.73system 6:59.91elapsed 226%CPU
> >> to:
> >> 973.02user 583.98system 3:01.17elapsed 859%CPU
> >>
> >> So over twice as fast, saving 4 minutes.
> >>
> >
> > Apologies for not replying earlier before this was applied. But IMO thi=
s
> > isn't a good default. Tests that use things like exclusive PMUs
> > (Coresight for example) can never pass when run in parallel.
>
> Yes, that is an issue for Intel PT also.

Right, Arnaldo and I discussed this and the safe thing to do for now
is to keep the default at serial - ie revert this change.

My longer term concern is that basically means people won't use
parallel testing and we'll bitrot in places like synthesis where it's
easy to make naive assumptions that say /proc won't be changing.

We have these tests set up for continuous testing in my team, and as
part of that set up each test is run independently to maximize
parallelism. This means the exclusive PMU thing does make the tests
flaky so it would be nice to have the tests address this, either by
skipping or busy waiting (only when the error code from the PMU is
busy, up to some maximum time period).

> >
> > For CI it's arguable whether you'd want to trade stability for speed.
> > And for interactive sessions there was already the --parallel option
> > which was easy to add and have it in your bash history.
> >
> > Now we've changed the default, any CI will need to be updated to add
> > --sequential if it wants all the tests to pass.
>
> Same here.
>
> >                                                 Maybe we could do some
> > hack and gate it on interactive vs non interactive sessions, but that
> > might be getting too clever. (Or a "don't run in parallel" flag on
> > certain tests)
>
> Perhaps more attention is needed for the tests that take so long.
> For example, maybe they could do things in parallel.

This is true for the tool in general. The problem is a lack of good
abstractions. Probably the easiest candidate for this are the shell
tests.

> Also -F option doesn't seem to work.
>
> $ tools/perf/perf test -F
> Couldn't find a vmlinux that matches the kernel running on this machine, =
skipping test
>   1: vmlinux symtab matches kallsyms                                 : Sk=
ip
>   2: Detect openat syscall event                                     : Ok
>   3: Detect openat syscall event on all cpus                         : Ok
>   4.1: Read samples using the mmap interface                         : Ok
>   4.2: User space counter reading of instructions                    : Ok
>   4.3: User space counter reading of cycles                          : Ok
>   5: Test data source output                                         : Ok
> WARNING: event 'numpmu' not valid (bits 16-17,20,22 of config '6530160' n=
ot supported by kernel)!
>   6.1: Test event parsing                                            : Ok
>   6.2: Parsing of all PMU events from sysfs                          : Ok
> WARNING: event 'N/A' not valid (bits 0-1 of config2 '3' not supported by =
kernel)!
>   6.3: Parsing of given PMU events from sysfs                        : Ok
>   6.4: Parsing of aliased events from sysfs                          : Sk=
ip (no aliases in sysfs)
>   6.5: Parsing of aliased events                                     : Ok
>   6.6: Parsing of terms (event modifiers)                            : Ok
>   7: Simple expression parser                                        : Ok
>   8: PERF_RECORD_* events & perf_sample fields                       : Ok
>   9: Parse perf pmu format                                           : Ok
>  10.1: PMU event table sanity                                        : Ok
>  10.2: PMU event map aliases                                         : Ok
> failed: recursion detected for M1
> failed: recursion detected for M2
> failed: recursion detected for M3
> Not grouping metric tma_memory_fence's events.
> Try disabling the NMI watchdog to comply NO_NMI_WATCHDOG metric constrain=
t:
>     echo 0 > /proc/sys/kernel/nmi_watchdog
>     perf stat ...
>     echo 1 > /proc/sys/kernel/nmi_watchdog
> Try disabling the NMI watchdog to comply NO_NMI_WATCHDOG metric constrain=
t:
>     echo 0 > /proc/sys/kernel/nmi_watchdog
>     perf stat ...
>     echo 1 > /proc/sys/kernel/nmi_watchdog
> ...
> ^C

Not working meaning the errors are going to stderr? The issue is that
pr_err will write to stderr regardless of the verbosity setting and
some tests deliberately induce errors. We could use debug_set_file
 to set the output to /dev/null, but that could hide trouble. -F
usually means your debugging so we've not cared in the past.

Thanks,
Ian
