Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1EC81749
	for <linux-perf-users@vger.kernel.org>; Fri, 23 May 2025 17:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748022860; cv=none; b=opPerMkDagZIzbTCeWUn2n0Lc46TLkIDvTfySYWagcxDnLMj130JCtOVBuFv9xEi/Hq5uo3PjjQoB8pw2JsilWUyLE4wVVDkicyaQrXvv0eVMJUfw/rkvtr9rmUql2RbrP+f7ByWmaLEFyzdb4VWpniuloAdbvwym6SBXiT0xB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748022860; c=relaxed/simple;
	bh=mHx9nrqeslMmeOqW9EqCQiUHsNIyWWN9PxW0Wy4QUxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lIXd+Fw1gSiLQiBPed0gLGvp3AnF6E4v8gJIk/7Yh6K7/0ED+5V1OFR2rYDTlQSpHUSph7PKQN92V7oYxvVPzPi2zCFD2Gr57dJVbl4kzVMJFO7zPEBy7E2CzIuNaJPB1/7JXRLMGzCaXXQSjxQhXaHTnQqWaHvOCW0PfBgE0Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f+P/0FQO; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f+P/0FQO"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3db82534852so16295ab.0
        for <linux-perf-users@vger.kernel.org>; Fri, 23 May 2025 10:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748022856; x=1748627656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PcE201KoRNJYhD4feI9Zb+U9J1PL6BFh8gHFJfl+wqk=;
        b=f+P/0FQOD74M30xGM+HQadVRLy4NVVOWHAiEqzk2vQfeo5BMSLgTQTFAFqqalHtkAw
         OhwT2jHWS7eoxdFDFApJxbZf6+WHCtYy3KIw3g5fp2K8U2Gzc0IUAiqwfVTQyS1aYtfw
         vzarKhBYlJ/ya9AYsq+TldkM5a6HCUr7QKtUSRsAt//3aYAkdRy1NlISqb5TF2of5mlt
         UgoOWxVxIGi2kQbWkgMzJd7tsaouo0DwoidcI7v3m6PBpTtxFNzeMLov8/YvRpYwZBQI
         U8N/ON5ZsRBox+Kpuk+iN2C6X3jtEfZ5p9ZOj/WQavzf/9vHUvLqVzTNE0dbrskZVX4H
         K6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748022856; x=1748627656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PcE201KoRNJYhD4feI9Zb+U9J1PL6BFh8gHFJfl+wqk=;
        b=JjIfOKTiHittNtKBoe8WKKYwwfwwgUwhDQsRw2czXpzry9jiTJvAcM2tY6PRcmiOjQ
         Fru/Zcj9JnCSvtBKsGTJOVfNiLqLCT5Rbs3onOtRXdxeyyPTaX0PO+zI+7/uZcyJ9hH+
         3hMU7NITDoUJNMxqQ8RQPPOre4zkzgTIQ9G7pxV3EltiBR73bYBqb9FYLH32M9z9BimQ
         /GLxg/79Auepgvn2qKFSD0DyUN+3QaNoBG0dyJxokyNhM/Bky1G3JaZeQ69fd9UlNmRe
         3d2yJ70HW8KV2qBtjFchgtOMadNdUR3ZFC1lGJMHNkWFpCygqJtu5ghYegnwlmrnXQL4
         LM9g==
X-Forwarded-Encrypted: i=1; AJvYcCWJUYjBiOQ6f/8GMMMtH/DhUalT2TWCI8m1tDRigyL5MuVbGLdnf66ij/zgqHUQk09zhxa2Sz3rxgNoRQzGbYaI@vger.kernel.org
X-Gm-Message-State: AOJu0YzTuNNmJrCGUACpL3uUx37D+KdRrC+H4qHzi+bHxkOPo6zeXxd3
	JVbGW7nuoKyF13yFxRpnqfkhjlwqnWl3qdjz84ChUQXILgstip/mwLQDud02cZCMy6bhuF1MNke
	5N45TOOkiqNnz7VUKBSNRUx95WGoj3N3VffqZ0j45
X-Gm-Gg: ASbGncvvN2IXzOS0uVBOPbRNl96gD0gCejmDP8MkEDD5rAv4iMSVBQJK21sthI4+qym
	3swNWYsg2yjpuRoEcdeMv0dCC2f8/Brr0Q2FI3XiuNV+i1swmzIACkT90FjXf8VvOaQmz32mcnZ
	2bR/GcOQkJtJt7qk9lq1J1M3fTbDEcz75iOdAQjIK6Y6Nv
X-Google-Smtp-Source: AGHT+IG5pJa6XNSEbq3AwCPNtrUfQOv1uHdn1F546Kd1DuB4oclakA7CB0Ovhv8zyPXbUxN2tE+LNNJLyOP3Ctk1zc0=
X-Received: by 2002:a92:cda7:0:b0:3dc:7be3:2712 with SMTP id
 e9e14a558f8ab-3dc942d4f30mr4135655ab.29.1748022855717; Fri, 23 May 2025
 10:54:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522171044.1075583-1-namhyung@kernel.org> <CAP-5=fXDaKueO9HE-Gr3Q7R6qm2EjwnL845nh7R2OU+DCfrhyA@mail.gmail.com>
 <4763aca8-a140-4291-b12e-e03cc0d82bdd@linaro.org>
In-Reply-To: <4763aca8-a140-4291-b12e-e03cc0d82bdd@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 23 May 2025 10:54:02 -0700
X-Gm-Features: AX0GCFv5o_BFbcay3SpWqv2Ef3jWnyQrNSCxEBiptddIrv5ki4ovE1puhXHTsuA
Message-ID: <CAP-5=fWUZ78s1DMzQV8SP0U8Hb=TnCwB1_t2_o+3UcoJeyi=0Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf test: Support arch-specific shell tests
To: James Clark <james.clark@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 3:48=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> On 22/05/2025 9:09 pm, Ian Rogers wrote:
> > On Thu, May 22, 2025 at 10:10=E2=80=AFAM Namhyung Kim <namhyung@kernel.=
org> wrote:
> >>
> >> This is a preparation for shell tests belong to an arch.
> >
> > I keep repeating that I don't like arch and I think ideally we'd be
> > getting rid of the C arch tests. I just sent out a patch doing this
> > for 1 test:
> > https://lore.kernel.org/lkml/20250521165317.713463-2-irogers@google.com=
/
> > We should be able to make perf, tests, etc. dependent on a PMU rather
> > than an architecture. This means that running perf built for ARM will
> > be able to do things running on an instruction emulator on x86. It
>
> In this case for Arm SPE and Coresight you can only generate trace by
> running on a full model or a real CPU, so I'm not sure if we could ever
> get close to running on just an emulator.

Ok, that's the SPE and coresight PMUs, shouldn't the bulk of "perf
test" pass under an emulator and those tests skip when the PMUs aren't
there?

> > means the tool, the kernel APIs, etc. are generic and new
> > architectures like RISC-V can test things. It means cross-platform
> > (record on 1 machine type, report on another) can work without
> > tripping over load bearing architecture ifdefs. It means that we
>
> I have thought about adding some generic decoding side tests for SPE and
> Coresight, but couldn't really get past the fact that you need to put
> the trace dump _and_ the binaries traced into the git repo. Not only
> would this benefit testing on other arches like you say, but it would
> also lock down that decoding of a known file doesn't regress which we
> can't currently do by generating new trace every time the test runs.
>
> If we ever added this they would be separate tests though so they could
> go in the top level folder, where the ones in the arch folder would
> continue to do record and decode. Maybe naming the folders by PMU could
> work, but you could also have both PMU name and arch name folders like:
>
> Recording/requires hardware:
>
>    tools/perf/arch/arm64/tests/shell/cs_etm/
>
> Cross platform decode tests:
>
>    tools/perf/tests/shell/cs_etm/
>
> Which would mirror how the source files are currently laid out:
>
>   tools/perf/arch/arm/util/cs-etm.c
>   tools/perf/util/cs-etm.c

So this a digression, I don't necessarily disagree with it. Back to
adding arch-specific shell tests, we should be working hard to not
target work to a particular architecture. Making code, tests, etc.
specific to an architecture means someone, quite often myself, has to
come along later and undo the damage. Hybrid being a very large and
long case in point where >1 core PMU was hard coded to only work
within the tool for two specific PMUs. To be specific as to why
notions of architecture in the code base are actively harmful (off the
top of my head):

1) architecture isn't a specific enough term as PMUs are always
evolving so we need to support figuring this out, not just hiding the
affected code by an ifdef or build option;

2) lower and more problematic test coverage (will we shellcheck an ARM
test on x86? we're lowering the container coverage or requiring it to
be run on multiple architectures);

3) the tests need to be able to handle being on the architecture with
or without the PMU (such as under a hypervisor);
3.1) the without PMU case is a very frequent source of my patching
tests as most people test on a bare metal development machines and
forget continuous testing environments;
3.2) this kind of support can enable continuous testing efforts that
are run under an emulator. If a cloud has no ARM offering they can at
least emulator test, and SuSE have at least offered this. Google may
or may not run testing through emulators and tests need to handle it,
we have and do carry patches for this;

4) broken cross-platform support, such as with sample parsing where
decoding a sample is missing pieces when not done on x86 (come on,
this is terrible and we don't want more of it);

5) the tests do and should make use of common library code for things
like checking the perf event permissions, this code lives in
tools/perf/tests/shell/lib but the arch dependencies go where? We
shouldn't reinvent the shell testing environment per architecture.


I get that vendors would quite like things not to work on other
architectures, or for event parsing [1], testing, etc. to be in some
way crippled and require architecture specific reinvention. Why should
their engineers invest in infrastructure and testing that could
benefit someone else? Heck sometimes it feels like vendors may be
doing everything in their power via broken PMU names, event names,
etc. to make common infrastructure break when not run in their arch
specific way [2]? I see things differently and indeed when things go
wrong vendors argue that the generic code/behaviors needs to be
changed (I'm thinking of Mark Rutland on Apple PMU support and the
generic behavior changes made at that time that are now not carried
through leading to event parsing and display inconsistencies as well
as RISC-V needing to adopt a different event lookup strategy).

I want the perf tool to have its behavior be generic. The kernel has
an arch directory for understandable reasons, for the perf tool the
key thing is the PMU and we've been building out the infrastructure
for this. Should the perf tool have every event, metric or syscall
number for every architecture? For cross-platform work it doesn't seem
like a completely terrible idea. I'm sensitive to binary size [3] so
I'm not pushing on it.

Anyway, this change is unnecessary as the current skipping behavior
works and is better for the reasons enumerated above. This change gets
a very large nack from me. I'm supportive of more IBS coverage in the
rest of the series, but this change isn't required for that.

Thanks,
Ian

[1] https://lore.kernel.org/lkml/20250416045117.876775-1-irogers@google.com=
/
[2] https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/drivers/perf/arm_cspmu/arm_cspmu.c?h=3Dperf-tools-next#n150
- please call it cpu_cycles to avoid ambiguity with the legacy event.
[3] https://lore.kernel.org/lkml/20250417230740.86048-1-irogers@google.com/



> Thanks
> James
>
> > benefit from more testing on generic pieces of code on all
> > architectures - like sample parsing. We can always strcmp the PMU name
> > or the architecture at runtime.
> >
> > Structure wise we could have:
> > tools/perf/pmu/ibs_op/tests/
> > tools/perf/pmu/ibs_op/tests/shell
> >
> > It feels noisy compared to just having the shell test in
> > tools/perf/tests/shell skip when the PMU isn't present. There are also
> > things like library dependencies that aren't clear when we have >1
> > directory. I'd prefer if new testing followed the existing model
> > rather than this.
> >
> > Thanks,
> > Ian
> >
