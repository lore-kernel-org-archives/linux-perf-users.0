Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A924233D6E
	for <linux-perf-users@vger.kernel.org>; Fri,  8 Nov 2024 18:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731091088; cv=none; b=ZNbAbq23I+FKdRnGUzPlI2uN2GKTTiyH4/27GE7JC1N+lp4r2MJuap/VgNap9XKaztsD07iN4xc1lDsDd3YIo47KRbJQdzU1w9dhu4vKB7u2xEpVS5qLRgXeM6FSpt+bo9BERY8hxyCMm6LupED1iQh3WSm0F3SZ3sU6pi1z/QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731091088; c=relaxed/simple;
	bh=Gc2ziCJpWDyzAQ+CZpGI4C+n0VHuX8Z2LzzZPpP04s4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=owTiJbLE+gh7uhKOJo9janSQZ3z9DDz+MhvM4LanS7AFn3KwDcTmHdVVEuN42pnHu710YyTrH7o8pULJjP/159eAwgQuiFqtcMrPD3fxn3zgoReYQEX+057c9cXFiZwXvz05LmF1/Km9IWBThkAz1lx58JL3Nfpy+IVbtKM31dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=f7mP4aVo; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="f7mP4aVo"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-720cb6ac25aso2237835b3a.3
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Nov 2024 10:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731091085; x=1731695885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LyOTZ1GggUHCU1ByvHlta8qwu/Ygb8GuRAPYEnEC6J4=;
        b=f7mP4aVo6yjZdzXg8bGt17Rr8E7NtLdsdd0LhmonVR6yUpDI8s8tb9y1aSkc9x07ze
         rEucF2qLqeLxpU+2FaOb2uXYlG3PeS1x+mYTlaZLBZNyaXCbipAkWF8y6W0SofOHOVhq
         UqU77cJiGhLd1+7EyIyyR4R1gGJvjrI/4GCFPeFRGdYetpph+zAT2zHJgP5G6oEFn2gn
         UMXc/YHPUZjaqDeFo7fs78uxSG9jGNfq2b8kdtAgRAQZYRXQbZ6YUfrbdn/Jqr55Z0wx
         vd5nqLgnaGjHODnhsTLc7ByYfZwilPFO4/+Z4yNx6MYn7InWdqHMH1QgnoX8AE2+O5kW
         MvJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731091085; x=1731695885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LyOTZ1GggUHCU1ByvHlta8qwu/Ygb8GuRAPYEnEC6J4=;
        b=RQRo33dhmPzg+SrErd/r9qFACMXXDCVeQ1tenUeZ1Zgcd1ENHrqkX7+RPr3qxY6JJG
         DlHSxy1McEMC4tZNXY4mvmpAbxKxK5JWnBs78yCM+K3vm+4KKjLI1EwhJx4BOEaKoPZC
         xCAV29+sz7N8rnXZ01XhejYJsI63EcpDHF4aEIXVN8GsTHoOo4g0f9Ekc9b28jhTnxFZ
         +pfYFb7tyoxV0mu5iBejhZ5+U2j012u2sbAlRlzcB0bj55EiNHiAqugaJ05qfXUlt552
         xpwz0EAy1HJ1LU+Qeyg+NeJ/kNGKkMEG2Ynn6R41Qgn3nzufdmnl8Znt683GmQb69T2d
         AKAw==
X-Forwarded-Encrypted: i=1; AJvYcCWxXE1RU4lP9w0kp0B3hP6U47Z7xJ5xDofTKq+DmWfBC18vPGmO9hfonokEM7wXD2wPv334NEHWxboY86A/A1es@vger.kernel.org
X-Gm-Message-State: AOJu0YwLcdzRKr1UNE0wz168qSN+jNERLiqgCG7fw//Y0Wv8w5ZjNP0Y
	YA8agcrE6I2g7IF/d/eHOgUmqZM1csA0be+k8hFB0DXHYeN24lyqN7Op9YzQguHxsdzDjgzCMvx
	AAZoe0RzeXskkcNtQF7HogdAa74g9/WsywUcs9w==
X-Google-Smtp-Source: AGHT+IH0s7DgmXQEo7Are9T9yPXkX2O4l0efcpeae4hw3hEDAPmYOoll+kPm/WGYjK7WE6OS8LyvyIpyIKe7l4MkR9g=
X-Received: by 2002:a05:6a00:180f:b0:71e:7af9:2d0f with SMTP id
 d2e1a72fcca58-7241334a2f3mr4882482b3a.18.1731091085491; Fri, 08 Nov 2024
 10:38:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026121758.143259-1-irogers@google.com> <CAP-5=fXf9HtqKZyvfXNbKLTB-dL_Ax5Hd0_Gn1J-y0T1SE9wLQ@mail.gmail.com>
 <78eb729c-7594-460f-9d79-97fb683d8b5e@linaro.org>
In-Reply-To: <78eb729c-7594-460f-9d79-97fb683d8b5e@linaro.org>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Fri, 8 Nov 2024 10:37:54 -0800
Message-ID: <CAHBxVyFXWpczMmWJbpWoLUjQ4nfNC2_h1yZqSd7kSr6N8Rvm5Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Prefer sysfs/JSON events also when no PMU is provided
To: James Clark <james.clark@linaro.org>
Cc: Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ben Gainey <ben.gainey@arm.com>, 
	Junhao He <hejunhao3@huawei.com>, linux-riscv@lists.infradead.org, beeman@rivosinc.com, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 4:16=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
>
>
>
> On 07/11/2024 18:51, Ian Rogers wrote:
> > On Sat, Oct 26, 2024 at 5:18=E2=80=AFAM Ian Rogers <irogers@google.com>=
 wrote:
> >>
> >> At the RISC-V summit the topic of avoiding event data being in the
> >> RISC-V PMU kernel driver came up. There is a preference for sysfs/JSON
> >> events being the priority when no PMU is provided so that legacy
> >> events maybe supported via json. Originally Mark Rutland also
> >> expressed at LPC 2023 that doing this would resolve bugs on ARM Apple
> >> M? processors, but James Clark more recently tested this and believes
> >> the driver issues there may not have existed or have been resolved. In
> >> any case, it is inconsistent that with a PMU event names avoid legacy
> >> encodings, but when wildcarding PMUs (ie without a PMU with the event
> >> name) the legacy encodings have priority.
> >>
> >> The patch doing this work was reverted in a v6.10 release candidate
> >> as, even though the patch was posted for weeks and had been on
> >> linux-next for weeks without issue, Linus was in the habit of using
> >> explicit legacy events with unsupported precision options on his
> >> Neoverse-N1. This machine has SLC PMU events for bus and CPU cycles
> >> where ARM decided to call the events bus_cycles and cycles, the latter
> >> being also a legacy event name. ARM haven't renamed the cycles event
> >> to a more consistent cpu_cycles and avoided the problem. With these
> >> changes the problematic event will now be skipped, a large warning
> >> produced, and perf record will continue for the other PMU events. This
> >> solution was proposed by Arnaldo.
> >>
> >> Two minor changes have been added to help with the error message and
> >> to work around issues occurring with "perf stat metrics (shadow stat)
> >> test".
> >>
> >> The patches have only been tested on my x86 non-hybrid laptop.
> >
> > Hi Atish and James,
> >
> > Could I get your tags for this series?
> >

Hi Ian,
Thanks for your patches. It definitely helps to have a clean slate
implementation
for the perf tool. However, I have some open questions about other use case=
s
that we discussed during the RVI Summit.

> > The patches were originally motivated by wanting to make the behavior
> > of events parsed like "cycles" match that of "cpu/cycles/", the PMU is
> > wildcarded to "cpu" in the first case. This was divergent because of
> > ARM we switched from preferring legacy (type =3D PERF_TYPE_HARDWARE,
> > config =3D PERF_COUNT_HW_CPU_CYCLES) to sysfs/json (type=3D<core PMU's
> > type>, config=3D<encoding from event>) when a PMU name was given. This
> > aligns with RISC-V wanting to use json encodings to avoid complexity
> > in the PMU driver.
> >
>
> I couldn't find the thread, but I remember fairly recently it was
> mentioned that RISC-V would be supporting the legacy events after all,
> maybe it was a comment from Atish? I'm not sure if that changes the
> requirements for this or not?
>
> I still can't really imagine how tooling would work if every tool has to
> maintain the mappings of basic events like instructions and branches.
> For example all the perf_event_open tests in ltp use the legacy events.
>

No it has not changed. While this series helps to avoid clunky vendor
specific encodings
in the driver for perf tool, I am still unsure how we will manage
other applications
(directly passing legacy events through perf_event_open or
perf_evlist__open) will work.

I have only anecdotal data about folks relying perf legacy events
directly to profile
their application. All of them use mostly cycle/instruction events though.
Are there any users who use other legacy events directly without perf tool =
?

If not, we may have only cycle/instruction mapping in the driver and
rely on json for everything else.
The other use case is virtualization. I have been playing with these
patches to find a clean solution to
enable all the use cases. If you have any other ideas, please let me know.

> And wouldn't porting existing software to RISC-V would be an issue if it
> doesn't behave in a similar way to what's there already?
>
> > James, could you show the neoverse with the cmn PMU behavior for perf
> > record of "cycles:pp" due to sensitivities there.
> >
>
> Yep I can check this on Monday.
>
> > Thanks,
> > Ian
> >
>
>
> >
> >
> >
> >> Ian Rogers (4):
> >>    perf evsel: Add pmu_name helper
> >>    perf stat: Fix find_stat for mixed legacy/non-legacy events
> >>    perf record: Skip don't fail for events that don't open
> >>    perf parse-events: Reapply "Prefer sysfs/JSON hardware events over
> >>      legacy"
> >>
> >>   tools/perf/builtin-record.c    | 22 +++++++---
> >>   tools/perf/util/evsel.c        | 10 +++++
> >>   tools/perf/util/evsel.h        |  1 +
> >>   tools/perf/util/parse-events.c | 26 +++++++++---
> >>   tools/perf/util/parse-events.l | 76 +++++++++++++++++---------------=
--
> >>   tools/perf/util/parse-events.y | 60 ++++++++++++++++++---------
> >>   tools/perf/util/pmus.c         | 20 +++++++--
> >>   tools/perf/util/stat-shadow.c  |  3 +-
> >>   8 files changed, 145 insertions(+), 73 deletions(-)
> >>
> >> --
> >> 2.47.0.163.g1226f6d8fa-goog
> >>
