Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160AE211A0A
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Feb 2025 18:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738693051; cv=none; b=RRfjE3nCTyyV4k8W2tt2FUAcKVrxc0j0Y1ar+vnvEHZdWISDS0sHXTF52dWOjrveiWgk21gExXi6pi7ebLMgARoBz+XzN+U2l0lmH3y7Uoz3Pgog4dnaIz+4ZvXx6SPPHeet1YGW+NvJ5Dyf6mky5eFLwn85xRv3O2dIxUZZRkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738693051; c=relaxed/simple;
	bh=pWaBP0CVleItpcklVYbBi++6w91KDe9zBdArHRpRrWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QpvwmENUWQ/y88FibwaPMy5xDlbHqyjTbVngf15CI5QPw4AUzNSp7PWdQHaz4aZ8hBByXCyJ24G5OIPCuSfIreuyXvjbVK05tXcTKDsI/byWYYyQ52bkdot7/EI/iDF6r/X5vGdlr9N7KzWRUUwBX+kdsXnLX5mrM9SC59gVoJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MGdX0wjR; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MGdX0wjR"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3d04e5bd797so16085ab.1
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Feb 2025 10:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738693049; x=1739297849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3UvNoN7gqpsLO22STOhC2pxClv5CftaFh/u/6+uCJk=;
        b=MGdX0wjRCBWUCfm7WlqnxIHuW3MU9MiFDJ24A5nAQ9qo2q73qhHowpsJ/NQSlZ1Rc8
         4Pu3/biL/EkyL2urfCSQtUj6hOlMYowQtGZhxSWCW+TrQ//bFdN9j/W1hUj0n6hMMZq/
         8dUBVjEe1oSkAHMRKL6XVIKKVAFBF8XjN02PfaEu+gkMxMmD+AV/c7KwWGMuVrgJ+y05
         jiDFmKJrmewJEXsIKAIrBBNjacTdAi4XA+SbT3Hr9nOOtmYns8pKTBbaVdNXJWajUAfn
         6BkOuiX42ZfjSvIqX5fMsxDVsE/eqFWHISlNOI8eNjxV8TA1yhSiqm/fjU/9ziJCh1Cs
         OFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738693049; x=1739297849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o3UvNoN7gqpsLO22STOhC2pxClv5CftaFh/u/6+uCJk=;
        b=n3rTOmB4gB6Ydb7gH1RS/hSfdkZH1zLU4aJtU2t2he0mXC6snwTaXjCTgrhMCZ2yUl
         1LwaP1Oh2iruNOY8MPvswyqG+hMMghFdGKrsvXS4ZmatNxAMVPA0R18MQ/24+cGe68vw
         df7ZZGRh69T1PAEqEmjbgKBukUZqJY7SMiyL/DWRmLLs5Hn41i1omSSurwzM86ba257Z
         q8UDS46AukEJkHN/LS8/idpj6daIaA6Vtyk4yfIJquY50bsgS0KnQ4wIsadn+luDumX0
         xvty5veOwO/P9jUzCtROv0TaohMnHMWzQHXNpVU5d9dfUy5er1bVVb2uLU3D5ttrdSBX
         ZKRA==
X-Gm-Message-State: AOJu0YzEP3p7+kEU+57iq0n9BJVEA1Sm1ae3zY/gqkulkg6qZScrvYlD
	DIHQtIwql7yX32ISDJfN18Q+A4QRG5VlYkaVm+l2xmwblYcaVTkMoeYiY04kk8u2h7Z7DSj2A55
	AX3C5CP5eAFGY7mDQ5jSmXY/Pv+Y1aNXE5qgJ
X-Gm-Gg: ASbGnctE+3PYG+Xh3q19Ju73e+rrNRB74NEUshUNUBcxfIxG/YXXbdzEBK1ELdQrLXV
	C+6DdM9e0Yfl2P2q9KU7YMfuUHPBH7Y/NmZDKYqM0vqk2KBibvhCZd99NsbgAd7Q7XiCrT35EbS
	4KeJuoo8j88g4htmTVIHN1L2A=
X-Google-Smtp-Source: AGHT+IFSb6p+y33pvkXVKpplGE3ncyZOropQ02NFuyiOGkQJgIOV4Fnl+vR4vOLwj59ExMNx49afv7Vgb7F1KNqUL2g=
X-Received: by 2002:a92:c544:0:b0:3ce:3873:48d4 with SMTP id
 e9e14a558f8ab-3d03fbc113dmr4328295ab.4.1738693048936; Tue, 04 Feb 2025
 10:17:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025020304-chip-trench-4e56@gregkh> <CAP-5=fXwprvLc3ubPmAuyUaTL2aD1frqL+RHJzkp8oe5z85oRw@mail.gmail.com>
 <2025020444-chivalry-wanting-7f0c@gregkh>
In-Reply-To: <2025020444-chivalry-wanting-7f0c@gregkh>
From: Ian Rogers <irogers@google.com>
Date: Tue, 4 Feb 2025 10:17:17 -0800
X-Gm-Features: AWEUYZkf_zL-nqp7mLrmVj3RIJAOBqhUHw3vAZ2mCHhPzzWvQTYIBpDsD-wJCns
Message-ID: <CAP-5=fUk3DB4orma=vM=+cKrztsRqHVhvvPk+py+G+9w9sOdqg@mail.gmail.com>
Subject: Re: [PATCH] perf/core: move all of the pmu devices into their own location
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 11:05=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Feb 03, 2025 at 11:44:13AM -0800, Ian Rogers wrote:
> > On Mon, Feb 3, 2025 at 11:25=E2=80=AFAM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
[snip]
> > > Note, if you all don't like "pmu_bus" for the name, that's fine, plea=
se
> > > let me know and I can rename it to something else, but it should be
> > > something to get these objects out of the root sysfs directory.
> >
> > Excuse my ignorance, does the event_source bus already provide a
> > similar solution?
> > ```
> > $ ls /sys/bus/event_source/devices
> > breakpoint   i915       msr         uncore_arb     uncore_cbox_3
> > uncore_cbox_7              uprobe
> > cpu          intel_bts  power       uncore_cbox_0  uncore_cbox_4  uncor=
e_clock
> > cstate_core  intel_pt   software    uncore_cbox_1  uncore_cbox_5
> > uncore_imc_free_running_0
> > cstate_pkg   kprobe     tracepoint  uncore_cbox_2  uncore_cbox_6
> > uncore_imc_free_running_1
> > $ ls /sys/devices
> > breakpoint   intel_pt     platform    uncore_arb     uncore_cbox_5
> >          uprobe
> > cpu          isa          pnp0        uncore_cbox_0  uncore_cbox_6
> >          virtual
> > cstate_core  kprobe       power       uncore_cbox_1  uncore_cbox_7
> > cstate_pkg   LNXSYSTM:00  software    uncore_cbox_2  uncore_clock
> > i915         msr          system      uncore_cbox_3  uncore_imc_free_ru=
nning_0
> > intel_bts    pci0000:00   tracepoint  uncore_cbox_4  uncore_imc_free_ru=
nning_1
> > ```
>
> Those are the exact same device structures :)
>
> Look at /sys/bus/event_source/devices/ those are symlinks back to
> /sys/devices.  In other words, that's the exact same structures, and
> the mess in /sys/devices/ with these event devices is what I am trying
> to clean up.

Thanks! Again my ignorance, why do we need pmu_bus? Could the symlinks
in event_source be the actual devices? Perhaps for temporary
compatibility some symlinks could be placed in /sys/devices?

Thanks,
Ian
