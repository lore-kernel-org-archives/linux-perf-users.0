Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A484D1A4F09
	for <linux-perf-users@vger.kernel.org>; Mon, 11 Nov 2024 17:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731345581; cv=none; b=kN1NhuieERWNOLEvzOxcS+vEnVRUX0vprObHbuWlekTgI/0z3E8BYFpYl2OIvEhJfKpFID6wcGZzNBhiTtfz5r90BXRc6+zU4K34RhcaOeYSRhXo03UY++3S3OCbVHHWGtBGybG7JixpIzl5I8FJJX86ajhhL1oHCBO11hGc2zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731345581; c=relaxed/simple;
	bh=QMzqlhKEODr6U1uSie4LDo+kpQk5NIsCRHNo8Jc71/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tjbau64FpCEsji/7QHCqBhW32qcekpDo2WyedUJSqHgro3cTOYoY4Dr3P5w0hIIZlG/lKKJkyH0BNYdvSKv6rL1RZipUPfmGUu1zD18cjF4GhWFSf2JThj76zOtE2ESWPtUonR+1P3OlVOMr3UgH2UDyzPEdUowYyklbqVToX4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xbmvYf7w; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xbmvYf7w"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-460b295b9eeso387481cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Nov 2024 09:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731345578; x=1731950378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMzqlhKEODr6U1uSie4LDo+kpQk5NIsCRHNo8Jc71/c=;
        b=xbmvYf7wHwgsSHI4/yYqIFAnU/+goVe0sRJyHWq92nEyta6bcNKKz73dvU8LkrWcUE
         Uvh3dtOMkGBwgh2mPMU4RlMswcHseMWIzHjEy57V6KZ1qc/q/ErdLDNGTO9BRazV/P6T
         Pp3LkPBRz2jT8rPB7xQPBwy4ar8ln7HCPYU/fkTnj569HarufR9CifyCXCGvUxKEPo0u
         OTKxCC2BsHHs5Pqq8tvvrhoc5MRKm/8As9Yn//Jx2dJ5HIDQv2UGX7QHHyUNhyvGdHj4
         nhtsKgxKFgOW2aRh7iLejwXzhyGzSHeYgO/NFVYvboYc2A/VMSjCN8gjs+V4Grw0FJ1/
         6rLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731345578; x=1731950378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QMzqlhKEODr6U1uSie4LDo+kpQk5NIsCRHNo8Jc71/c=;
        b=ASz8TXUwKAyoAbGfEkP88cJY9nGSEjSfcby3lKNQB2hIetufr+yjwBNMEcL3or6VyG
         sJVgztM0L0zd26DBrmT+Z/Gmgu4BU+hRgPDT9qAaqc9rkLzRCsQ+v24iAFGg7Ga/OIWi
         iX/7zM+aBxPFvup34CP4ReFyuEG+NGvmTMeCbIgGSCJOxxh8C9oGrcwSePkEEN1+cKDm
         QptgFOFx6iG+kY/G2ak/v8TUDxOTSfjWqFGBOYWC7TyWS29YOVXvaEckqgCGjOGMn3KP
         o+1KfZQmBm8TocFDwAuKdrlPFY7Xo4uzOt2y4nGgLHOPvTWRTvSQRoh+qWDjWjz+cEoz
         0+Cw==
X-Forwarded-Encrypted: i=1; AJvYcCVkHOdjxDhpf7JCF79yQjc2AV5ehIVeUZaUX/hq/0m8fw6qeOjp0oS5lab0D/PUGd6vi/OCXRAwCrqPsAeEwCjf@vger.kernel.org
X-Gm-Message-State: AOJu0YypBD985f/1rm34jvlPlbV+3yvBAJVp3V0MQSKLgGevUmvF1w2F
	M4LNYRjQl3EGo6Ji8rcLdU8vswqJzBuu2oCYib7pAwVrewavfg/eUnCAgr8cMHQnykhrn+oEZck
	+rfCm1mQcXBYuXuKuR+h4p96kIo63d/5Yd4aq
X-Gm-Gg: ASbGncvvNGPFIs4xzE0nmbxKJhw2nB8+lmYrAw1ZtTu/DGAo8MEvbCdkYWrD/FaxE9o
	UigcSUu3dmgkIMzCS+qkb9o1SQWXcj0dYgm1IILnDAJzPQRUfZ3OeXXMd2sHmReI=
X-Google-Smtp-Source: AGHT+IFbKxYUeHJb8Wx9iqiLZDDt6pXqnwG/JbMcQ32dlJCIWMKZfzz8w6NjeMRTo+i0nq2LtGTTXLrW54me0Z7epbE=
X-Received: by 2002:a05:622a:3d1:b0:461:3e03:738b with SMTP id
 d75a77b69052e-46317e478a2mr4046511cf.19.1731345578094; Mon, 11 Nov 2024
 09:19:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026121758.143259-1-irogers@google.com> <CAP-5=fXf9HtqKZyvfXNbKLTB-dL_Ax5Hd0_Gn1J-y0T1SE9wLQ@mail.gmail.com>
 <78eb729c-7594-460f-9d79-97fb683d8b5e@linaro.org> <CAHBxVyFXWpczMmWJbpWoLUjQ4nfNC2_h1yZqSd7kSr6N8Rvm5Q@mail.gmail.com>
 <d9bfd75a-003a-4f65-abba-b8bcaad13682@linaro.org>
In-Reply-To: <d9bfd75a-003a-4f65-abba-b8bcaad13682@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 11 Nov 2024 09:19:26 -0800
Message-ID: <CAP-5=fUHjxL5QbsyQQU-3EYiVhiO6wt=F5MfSfDcAffKP7WWAg@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Prefer sysfs/JSON events also when no PMU is provided
To: James Clark <james.clark@linaro.org>
Cc: Atish Kumar Patra <atishp@rivosinc.com>, linux-perf-users@vger.kernel.org, 
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

On Mon, Nov 11, 2024 at 2:45=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 08/11/2024 6:37 pm, Atish Kumar Patra wrote:
> > On Fri, Nov 8, 2024 at 4:16=E2=80=AFAM James Clark <james.clark@linaro.=
org> wrote:
> >>
> >>
> >>
> >> On 07/11/2024 18:51, Ian Rogers wrote:
> >>> On Sat, Oct 26, 2024 at 5:18=E2=80=AFAM Ian Rogers <irogers@google.co=
m> wrote:
> >>>>
> >>>> At the RISC-V summit the topic of avoiding event data being in the
> >>>> RISC-V PMU kernel driver came up. There is a preference for sysfs/JS=
ON
> >>>> events being the priority when no PMU is provided so that legacy
> >>>> events maybe supported via json. Originally Mark Rutland also
> >>>> expressed at LPC 2023 that doing this would resolve bugs on ARM Appl=
e
> >>>> M? processors, but James Clark more recently tested this and believe=
s
> >>>> the driver issues there may not have existed or have been resolved. =
In
> >>>> any case, it is inconsistent that with a PMU event names avoid legac=
y
> >>>> encodings, but when wildcarding PMUs (ie without a PMU with the even=
t
> >>>> name) the legacy encodings have priority.
> >>>>
> >>>> The patch doing this work was reverted in a v6.10 release candidate
> >>>> as, even though the patch was posted for weeks and had been on
> >>>> linux-next for weeks without issue, Linus was in the habit of using
> >>>> explicit legacy events with unsupported precision options on his
> >>>> Neoverse-N1. This machine has SLC PMU events for bus and CPU cycles
> >>>> where ARM decided to call the events bus_cycles and cycles, the latt=
er
> >>>> being also a legacy event name. ARM haven't renamed the cycles event
> >>>> to a more consistent cpu_cycles and avoided the problem. With these
> >>>> changes the problematic event will now be skipped, a large warning
> >>>> produced, and perf record will continue for the other PMU events. Th=
is
> >>>> solution was proposed by Arnaldo.
> >>>>
> >>>> Two minor changes have been added to help with the error message and
> >>>> to work around issues occurring with "perf stat metrics (shadow stat=
)
> >>>> test".
> >>>>
> >>>> The patches have only been tested on my x86 non-hybrid laptop.
> >>>
> >>> Hi Atish and James,
> >>>
> >>> Could I get your tags for this series?
> >>>
> >
> > Hi Ian,
> > Thanks for your patches. It definitely helps to have a clean slate
> > implementation
> > for the perf tool. However, I have some open questions about other use =
cases
> > that we discussed during the RVI Summit.
> >
> >>> The patches were originally motivated by wanting to make the behavior
> >>> of events parsed like "cycles" match that of "cpu/cycles/", the PMU i=
s
> >>> wildcarded to "cpu" in the first case. This was divergent because of
> >>> ARM we switched from preferring legacy (type =3D PERF_TYPE_HARDWARE,
> >>> config =3D PERF_COUNT_HW_CPU_CYCLES) to sysfs/json (type=3D<core PMU'=
s
> >>> type>, config=3D<encoding from event>) when a PMU name was given. Thi=
s
> >>> aligns with RISC-V wanting to use json encodings to avoid complexity
> >>> in the PMU driver.
> >>>
> >>
> >> I couldn't find the thread, but I remember fairly recently it was
> >> mentioned that RISC-V would be supporting the legacy events after all,
> >> maybe it was a comment from Atish? I'm not sure if that changes the
> >> requirements for this or not?
> >>
> >> I still can't really imagine how tooling would work if every tool has =
to
> >> maintain the mappings of basic events like instructions and branches.
> >> For example all the perf_event_open tests in ltp use the legacy events=
.
> >>
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
> > If not, we may have only cycle/instruction mapping in the driver and
> > rely on json for everything else.
> > The other use case is virtualization. I have been playing with these
> > patches to find a clean solution to
> > enable all the use cases. If you have any other ideas, please let me kn=
ow.
> >
>
> Yeah I would expect it's mostly cycles and instructions. I searched a
> bit for PERF_COUNT_HW_BRANCH_MISSES and only found tool/developer type
> usages, which I suppose we could expect to have to handle the mappings
> like perf. Although it's not the easiest thing to search for and
> obviously that only includes open source.
>
> Usages do exist though, there are people posting on stack overflow using
> it, and other various bug tracker listings. So you would expect those
> same users to have to use raw event codes and some switch statement to
> pick the right one for their hardware, or use Perf.

I don't have any magic to solve this. My thoughts:

1) I thought legacy events were just going to hang around forever,
although the name hinting they'd kind of been deprecated. At LPC '23
Atish and Mark Rutland originally asked for the sysfs/json to be the
preference. I thought Kan was going to push back given the upheaval,
especially updating every test expectation. It went through but we're
in this weird state where wildcard events are encoded using legacy and
PMU specifying events aren't. What this series hopes to solve.

2) I think it is important that perf tool be a reference
implementation where others can look (strace, etc.) to base their
implementation. Moving perf to sysfs/json is 1 step closer to legacy
event deprecation. Please yell if deprecation isn't what is wanted as
personally other than cleanliness I don't mind. If we do decide not to
have sysfs/json be the priority then I think it sensible to revert the
changes making it the priority for events that specify a PMU. I'd like
some level of consistency.

3) I'd like event parsing to be a library that is as easy to link
against as libbpf (i.e. not a viral license). Event parsing is really
just mapping an event name to 1 or more perf_event_attr. The PMU
abstraction is tied into the event parsing, but this has only been
more true recently. The evsel/evlist is tied into event parsing but
that feels separable. As most json isn't distributed under a viral
license this feels achievable, then I suspect most tools can use this
library rather than have to reinvent a wheel.

Still looking for tags :-)

Thanks,
Ian
