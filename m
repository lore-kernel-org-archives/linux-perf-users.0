Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1E51D0E04
	for <linux-perf-users@vger.kernel.org>; Fri,  8 Nov 2024 22:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731103598; cv=none; b=KAZUVSMGFtTLiaxom7JAUOWChnx+feXBDpuNJ17IpGiEBWUj36X+RTbLhPFjArLrnBJi/JYj4SkqHLsC5MJ1DGr8/ckPxBmQCTNPMHKaH54sZUqA5GF3ERkb9L16T7THBl5geGwBPo8yNKsTDb6vchVVBd/2FDbO9Hej+BM+dOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731103598; c=relaxed/simple;
	bh=cVDgce5UJ1oFHNte8ccVIxRm9FjpVduW3Ued9oDNZNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G3n4+dfuPIGyiiJR4iLcZ10kN6a1IJb3sfgNa0z+pizKl+Bo+JcLW+AUeYZ7uLjX/AwPr4PJSv0NDKFQAECXyr3YrRbd9M9aJ/eMmbw9bdNKfYtugMtkaYKdDVT4EiO0Jl/PjgsZTm/58sTcHTuVWeCnbo0JQNh3Ii7Tx36OAIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=nezvO50h; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="nezvO50h"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5ebc04d495aso1475625eaf.2
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Nov 2024 14:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731103594; x=1731708394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8geVVxx7+PoVe1ZAIaa+P5mdgg7DXuiooGvQOJRNjgc=;
        b=nezvO50h8q/yOmfJ5iBtpUMJc37apWovnBEV6uL9IiRNTZEqVeykRAoyiFOtezzVgJ
         4ndc1lO9jy2GY7OVDYVd+bGA2xnehuNXpLW3HwOTz6h1yY6TgWMn/JRr7SOw8wM78EON
         6ov94SZncPeHuv2hnUHJkARQx4V4e7GuNlDDkZwgb2ysfnrAFiuHkqe0tha9pRrcAQcm
         VA4ngMMScYhzGHRqiEWnAt5FZQsgGLQrsHnM3Z0t1sj+0QC2bscAw4UMY0m4ImbkMKxK
         Y0hpn4TegssuATj155aUVLWLovWUP14H5V8QY5tMDY/nGII1NG4ItLG/QP9x0BkXXCTq
         uJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731103594; x=1731708394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8geVVxx7+PoVe1ZAIaa+P5mdgg7DXuiooGvQOJRNjgc=;
        b=qmRU+4pguTab2E3rdy8ifqODQEZYIFNIPji9F2gq2x2OGxvaKbfWo3CNhojrq/J2/t
         kyJb8bBqpOm7yyUKZcpZqzBwvry7KXV3E3b+vOV8/kwGttzrHP/GAhu23r3xIpM19K/M
         wUEf+X2UBoNprGI7K5ZPN5XQYYsg2EMwxxv9oaW9HmSb8cBqF/3bFzf/0IGyi44W5e6s
         d3yWk2F5ZtR8H76Td0b6kHlEp4+J54SxbAwhzVdb4tiCxEy3j7o/YdJFoE5j5G2ULUZJ
         8mi2Fnytm7U0q+rfFS3Wszil8plJV3ewKtrUoBJNqCp925vslXOmqaKdxJOqVs3ECW6D
         ZmJw==
X-Forwarded-Encrypted: i=1; AJvYcCV8ScVrAgsvBp3eBYI6RdmURqrO0HQl/Y+IQTFakE3Rkb0jRdYR/Kx4Oe9YkrYgOju4NYFgiWLCgJgAplFkER0w@vger.kernel.org
X-Gm-Message-State: AOJu0YzT8v5c4DKUM5oX/JuBM7tnXm8NexB4zrD2qZn3/7foEgU0Lthb
	7M+7UgbdDLSa8zRpEjDGjg2QTUekg+RwMI6fk6d0XWi9V6zpXK8MfjEYUaosn29QFz/tUMa/sFz
	lc7ND7BqvtgVW8Est3v3mLzEKr8zRkUX/vsLBlg==
X-Google-Smtp-Source: AGHT+IGsktpU9OsNBGqijAXV+ixUty9gB+RwmOrLwAs7k+sRIgfQqG8929U++FJbDCQQ7GZuGxSoROr0sQeTZ6VFgAk=
X-Received: by 2002:a05:6820:2018:b0:5ed:fc18:9109 with SMTP id
 006d021491bc7-5ee57c507ebmr3728208eaf.3.1731103594076; Fri, 08 Nov 2024
 14:06:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026121758.143259-1-irogers@google.com> <CAP-5=fXf9HtqKZyvfXNbKLTB-dL_Ax5Hd0_Gn1J-y0T1SE9wLQ@mail.gmail.com>
 <78eb729c-7594-460f-9d79-97fb683d8b5e@linaro.org> <CAHBxVyFXWpczMmWJbpWoLUjQ4nfNC2_h1yZqSd7kSr6N8Rvm5Q@mail.gmail.com>
 <CAP-5=fV23r-_yVvGP3n5gjH8uZ2rEXmbZEwxr2wF+bpg=m745A@mail.gmail.com>
In-Reply-To: <CAP-5=fV23r-_yVvGP3n5gjH8uZ2rEXmbZEwxr2wF+bpg=m745A@mail.gmail.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Fri, 8 Nov 2024 14:06:22 -0800
Message-ID: <CAHBxVyF77Ndio+a9OfbLTfMDVZvuXCVPrbeNvLYH06MbKXz4-A@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Prefer sysfs/JSON events also when no PMU is provided
To: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ben Gainey <ben.gainey@arm.com>, 
	Junhao He <hejunhao3@huawei.com>, linux-riscv@lists.infradead.org, beeman@rivosinc.com, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Anup Patel <apatel@ventanamicro.com>, mikey@neuling.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 11:00=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Fri, Nov 8, 2024 at 10:38=E2=80=AFAM Atish Kumar Patra <atishp@rivosin=
c.com> wrote:
> >
> > On Fri, Nov 8, 2024 at 4:16=E2=80=AFAM James Clark <james.clark@linaro.=
org> wrote:
> > >
> > >
> > >
> > > On 07/11/2024 18:51, Ian Rogers wrote:
> > > > On Sat, Oct 26, 2024 at 5:18=E2=80=AFAM Ian Rogers <irogers@google.=
com> wrote:
> > > >>
> > > >> At the RISC-V summit the topic of avoiding event data being in the
> > > >> RISC-V PMU kernel driver came up. There is a preference for sysfs/=
JSON
> > > >> events being the priority when no PMU is provided so that legacy
> > > >> events maybe supported via json. Originally Mark Rutland also
> > > >> expressed at LPC 2023 that doing this would resolve bugs on ARM Ap=
ple
> > > >> M? processors, but James Clark more recently tested this and belie=
ves
> > > >> the driver issues there may not have existed or have been resolved=
. In
> > > >> any case, it is inconsistent that with a PMU event names avoid leg=
acy
> > > >> encodings, but when wildcarding PMUs (ie without a PMU with the ev=
ent
> > > >> name) the legacy encodings have priority.
> > > >>
> > > >> The patch doing this work was reverted in a v6.10 release candidat=
e
> > > >> as, even though the patch was posted for weeks and had been on
> > > >> linux-next for weeks without issue, Linus was in the habit of usin=
g
> > > >> explicit legacy events with unsupported precision options on his
> > > >> Neoverse-N1. This machine has SLC PMU events for bus and CPU cycle=
s
> > > >> where ARM decided to call the events bus_cycles and cycles, the la=
tter
> > > >> being also a legacy event name. ARM haven't renamed the cycles eve=
nt
> > > >> to a more consistent cpu_cycles and avoided the problem. With thes=
e
> > > >> changes the problematic event will now be skipped, a large warning
> > > >> produced, and perf record will continue for the other PMU events. =
This
> > > >> solution was proposed by Arnaldo.
> > > >>
> > > >> Two minor changes have been added to help with the error message a=
nd
> > > >> to work around issues occurring with "perf stat metrics (shadow st=
at)
> > > >> test".
> > > >>
> > > >> The patches have only been tested on my x86 non-hybrid laptop.
> > > >
> > > > Hi Atish and James,
> > > >
> > > > Could I get your tags for this series?
> > > >
> >
> > Hi Ian,
> > Thanks for your patches. It definitely helps to have a clean slate
> > implementation
> > for the perf tool. However, I have some open questions about other use =
cases
> > that we discussed during the RVI Summit.
>
> Thanks Atish, could I get your acked/reviewed/tested tags?
>

Sure. I will finish the testing and send those.

> Ian
>
> > > > The patches were originally motivated by wanting to make the behavi=
or
> > > > of events parsed like "cycles" match that of "cpu/cycles/", the PMU=
 is
> > > > wildcarded to "cpu" in the first case. This was divergent because o=
f
> > > > ARM we switched from preferring legacy (type =3D PERF_TYPE_HARDWARE=
,
> > > > config =3D PERF_COUNT_HW_CPU_CYCLES) to sysfs/json (type=3D<core PM=
U's
> > > > type>, config=3D<encoding from event>) when a PMU name was given. T=
his
> > > > aligns with RISC-V wanting to use json encodings to avoid complexit=
y
> > > > in the PMU driver.
> > > >
> > >
> > > I couldn't find the thread, but I remember fairly recently it was
> > > mentioned that RISC-V would be supporting the legacy events after all=
,
> > > maybe it was a comment from Atish? I'm not sure if that changes the
> > > requirements for this or not?
> > >
> > > I still can't really imagine how tooling would work if every tool has=
 to
> > > maintain the mappings of basic events like instructions and branches.
> > > For example all the perf_event_open tests in ltp use the legacy event=
s.
> > >
> >
> > No it has not changed. While this series helps to avoid clunky vendor
> > specific encodings
> > in the driver for perf tool, I am still unsure how we will manage
> > other applications
> > (directly passing legacy events through perf_event_open or
> > perf_evlist__open) will work.
> >
> > I have only anecdotal data about folks relying perf legacy events
> > directly to profile
> > their application. All of them use mostly cycle/instruction events thou=
gh.
> > Are there any users who use other legacy events directly without perf t=
ool ?
> >

+ Michale from tensorrent who was suggesting that they use the direct perf =
calls
in their profiling application.

@Michale : Do you have more details of direct usage of perf legacy
events to profile your application ?

> > If not, we may have only cycle/instruction mapping in the driver and
> > rely on json for everything else.
> > The other use case is virtualization. I have been playing with these
> > patches to find a clean solution to
> > enable all the use cases. If you have any other ideas, please let me kn=
ow.
> >

@Ian

Any thoughts on this ? Let me explain the hypervisor use case a little bit =
more.
RISC-V KVM relies on SBI PMU[1] (equivalent to hypercall in x86 or HVC in A=
RM).
As the RISC-V ISA doesn't have any event encodings, the SBI PMU
defines a standard set corresponding to
each perf legacy event. When a guest tries to allocate a counter for
an event, it makes an SBI call (CFG_MATCH)
with SBI event encodings (matching perf legacy) or a raw event
encoding. The host kernel allocates a virtual counter
and programs the corresponding event CSRs and enables the counter.

There are two possible approaches to support it.

1. The guest OS has the correct version of the perf tool with the json
file that provides the encoding of the events supported by
the running host. The guest OS passes the exact encoding of the event
during the CFG_MATCH SBI call as a raw event and the host programs
the event CSR.  It is a much simpler scheme and less management on the
host side. But the perf tool on guests has to pass any perf legacy
events
as raw events to the driver instead of PERF_HARDWARE/CACHE or indicate
event encoding is coming from json in some other way.

The other issue is that VMM can not modify the vendorid,implid,archid
shown to the guest (the default is the same as the host).
Migration across CPU generation or vendors won't be possible if perf
in use. This may not be an issue as VM migration across CPU
Generations are not a common thing.

2. The guest OS driver always relies on the SBI PMU event encoding
(i.e perf legacy event) which the host can translate to the event
encoding the hardware
supports if it is baked into the driver. The obvious downside is the
vendor specific encodings in the driver which we are trying to avoid.

[1] https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/src/ext-pmu.=
adoc
> > > And wouldn't porting existing software to RISC-V would be an issue if=
 it
> > > doesn't behave in a similar way to what's there already?
> > >
> > > > James, could you show the neoverse with the cmn PMU behavior for pe=
rf
> > > > record of "cycles:pp" due to sensitivities there.
> > > >
> > >
> > > Yep I can check this on Monday.
> > >
> > > > Thanks,
> > > > Ian
> > > >
> > >
> > >
> > > >
> > > >
> > > >
> > > >> Ian Rogers (4):
> > > >>    perf evsel: Add pmu_name helper
> > > >>    perf stat: Fix find_stat for mixed legacy/non-legacy events
> > > >>    perf record: Skip don't fail for events that don't open
> > > >>    perf parse-events: Reapply "Prefer sysfs/JSON hardware events o=
ver
> > > >>      legacy"
> > > >>
> > > >>   tools/perf/builtin-record.c    | 22 +++++++---
> > > >>   tools/perf/util/evsel.c        | 10 +++++
> > > >>   tools/perf/util/evsel.h        |  1 +
> > > >>   tools/perf/util/parse-events.c | 26 +++++++++---
> > > >>   tools/perf/util/parse-events.l | 76 +++++++++++++++++-----------=
------
> > > >>   tools/perf/util/parse-events.y | 60 ++++++++++++++++++---------
> > > >>   tools/perf/util/pmus.c         | 20 +++++++--
> > > >>   tools/perf/util/stat-shadow.c  |  3 +-
> > > >>   8 files changed, 145 insertions(+), 73 deletions(-)
> > > >>
> > > >> --
> > > >> 2.47.0.163.g1226f6d8fa-goog
> > > >>
