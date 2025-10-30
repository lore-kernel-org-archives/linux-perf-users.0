Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527D43678B1
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Oct 2025 17:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761844472; cv=none; b=JcJItkDXgrvv8NvOxRS7+q+C3UuLTyajByHt9KmzRNvN5Sez4Jk7w9EyCdZLrO1JiC+rBqpezrWiZhBOoFrfNguEG72DjY0jf3jJGnywWN+sx/Iz5DNmSGrQ2ihJfyfbOmJN4iE+aOH/2yYvEDqAANC8qlnrpwZh2nFrfyKxVdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761844472; c=relaxed/simple;
	bh=x1QCEqe49PwIKXMfsnFozhJdGRcZK2CW6qkgBJSLolo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DXi0FtEG25K1D/HcWpoDClCM7k2nT97l9H8xVyXC+Dev/UocdSkZ/Ef37Du86DQmKBCKj5lbr0QmqGZzAuuXwMxIZfuyxhqm0ROw3r5r9xvO+Rvm3vCTkRjcZyDFLHRChBzKzTpe8R8FCafnSxKoQO7bINqqaacCVDdQXGBiL4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LK7Iz7gT; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LK7Iz7gT"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-294f3105435so6795ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Oct 2025 10:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761844466; x=1762449266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilBtKROruD66g6fW/wgYLouoVqUlDai8e4VWuh7vMBw=;
        b=LK7Iz7gT2NdfYfh1FEfLBQeX8hf9dvoPtcd+202Lxqzt93hBVvEsFw/4wggGRRvp1N
         XtWne9l0Q8VF3kgeRH2sJr8AOZZR2xRWuOeifsYAdiDBCwGJVx5wMFfjG+RMmljnwV+6
         wqZiQAC90bp1X0h92qrYwEs7W9oX0O9Ydz1qnIrHa+0US2WGlG5jxYWqI16AwGHEAaZo
         B6wrRtNcV2E9jZYMKoBR/aKTWdbOGr9cXMx9oLZDPlEDEEKTHPydWRgWzrkO3OMdQfNl
         8oh7wl4gCnGOym6dFatwTHfXaP6agM3dlz0BgVFh4ILvAOGh7J8u+0vVjNXN8lC5YccX
         JCUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761844466; x=1762449266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ilBtKROruD66g6fW/wgYLouoVqUlDai8e4VWuh7vMBw=;
        b=WCbpXj37zThPARloe1D+qtuofDAQsB7pr3zHLxA70DCLN+BFyZ3qXAlxtlu0cfGHJl
         ZT2Wlycd5cPyUf4Al8kFzCBnD76+Nk1LQK+qP+/WgrKZRF3Vaknu48wptMlcyBiPmGxU
         xRa4uvPFDO5vPxGTumPOdH6/XUl4PBxBOf9MNw2TYCs/FnJ7bgDefzWnXd/BgAQq7qz0
         2q0fdqdM2R9FE43mCi90IelhuaPmizTiQ5c2rxqXaifT0vameT/y5VLO7L7o4Rip6iTF
         7eePNtAsDWoV2jU8Eav/k4QbBTxj5Jv7Ntup0ubPMWSA6wNCnlA10ANbxVrA5ZydXBTa
         hN4w==
X-Gm-Message-State: AOJu0YwzHyd9ow5H0NihzBMTZj7gyKLQK4hkIHTQ+QQNe3g2RrlSdKJY
	lu9fZjNe6CpyyDVmzsTytSK/xrlhX02pflHFY3OXVzS1s0O/TVvRZTpN+tTPFuRK/enbCmj/66p
	CTkMxhHj/MNWa9i4shEVKMV2FrAsod+nucB6NWUyH
X-Gm-Gg: ASbGncvvrS3BU4/7rpZvEVGA1LDfUdGDXRxiNQwSEWzQbi54Uca+nXXnOVE5SfvHcDM
	M+/T/IEHixGn0hgiM0vKpH7wcQxcm66ej0CSRhS1Axi32okfQMh92eaDaftu7D7n5HTlZ7R8XVb
	y7exxEtTYqCJ5XeOwLT07TSY4O4Rv3MpzSvHkUV0zebxvmH6bahuPuwi3LTNm3thJi1I3N1OaJx
	khsMo1w+sNuD6OxlkHb73HykF0AFcMjs/VucZ5ID5gCKtKr+kvEOvfSHdnUK21NuAluhQVnTxva
	Vuhl60ibAXJK0xeAC0NwYQsi
X-Google-Smtp-Source: AGHT+IHBWzgDBgAxxkiYbaD4McWEQbOAHxWqmHENov7UfaCiOJggLNAJL5FkBG4LQgbSM0wadUDFTFsiVbhH9vh4+fs=
X-Received: by 2002:a17:902:e852:b0:274:1a09:9553 with SMTP id
 d9443c01a7336-2951e6da7f6mr78415ad.6.1761844465835; Thu, 30 Oct 2025 10:14:25
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <09943f4f-516c-4b93-877c-e4a64ed61d38@linux.ibm.com>
 <79195870-7223-4aeb-beb4-a7d8f1895caa@linux.ibm.com> <CAP-5=fXi=EDU7-tdNLwTKbCHR80_p3=TAe0qF0oE-tXbx35znw@mail.gmail.com>
 <13800bed-1256-4414-ac8b-e99439c748ec@linux.ibm.com> <3b86c7e0-5b3e-468c-8077-7efa3959d221@linux.ibm.com>
 <02841ee0-d0b2-48a8-b523-7bcc561ad64f@linux.ibm.com> <CAP-5=fUKaX0b5b3QYarL9qUK4Z=u0zpKnB9XVm-_bOKap7sJag@mail.gmail.com>
In-Reply-To: <CAP-5=fUKaX0b5b3QYarL9qUK4Z=u0zpKnB9XVm-_bOKap7sJag@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 30 Oct 2025 10:14:14 -0700
X-Gm-Features: AWmQ_bnTQAZyUhzhQn-d8X42OBCjQBQlgESl2RlkvGZQKiv-UysaVdggflhLyj4
Message-ID: <CAP-5=fVLSML-B111RDGcKAE=ZrF1sZ6oGt_z=GQeePQLcZs-KA@mail.gmail.com>
Subject: Re: [linux-next] perf report runtime extremely long
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>, Jan Polensky <japo@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 8:57=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Thu, Oct 30, 2025 at 7:27=E2=80=AFAM Thomas Richter <tmricht@linux.ibm=
.com> wrote:
> >
> > On 10/30/25 14:25, Thomas Richter wrote:
> > > On 10/30/25 09:59, Thomas Richter wrote:
> > > This is the first bad commit.... (I actually tested it :-(, obviously=
 without -D option )
> > >
> > > commit 0012e0fa221bf9cc54aa6a0e94d848653dc781bb (HEAD)
> > > Author: Ian Rogers <irogers@google.com>
> > > Date:   Sun Oct 5 11:24:16 2025 -0700
> > >
> > >     perf jevents: Add legacy-hardware and legacy-cache json
> > >
> > >     The legacy-hardware.json is added containing hardware events simi=
larly
> > >     to the software.json file. A difference is that for the software =
PMU
> > >     the name is known and matches sysfs. In the legacy-hardware.json =
no
> > >     Unit/PMU is specified for the events meaning default_core is used=
 and
> > >     the events will appear for all core PMUs.
> > >     ......
> > >
> > > What puzzles me is that the above patch does not change anything in
> > > util/s390-sample-raw.c which handles s390 specific sample interpretat=
ion.
> > >
> > > Maybe that patch affects perf_pmus__find()?
> > > Not sure how to proceed.
> > >
> > > Thanks a lot
> >
> > Ian,
> >
> > the issue is within function perf_pmu__for_each_event().
> > Without calling this function the output is as fast as before.
> > (Well a bit faster, because I replaced this call by strdup("hardcoded-n=
ame");)
> >
> > I have looked at this code, but I did not understand a thing....
> > Strange, perf_pmu__for_each_event() did not change in this commit,
> > but the behavior changed a lot.
> >
> > What we need for s390 is some way of faster event name lookup,
> > the PMU is known, its "cpum_cf". Is there no easy way to
> > find the events on this PMU (given the event number).
> >
> > Maybe a some sort of table, because this lookup is done
> > millions of times on a large file with samples including raw data
> >
> > Ideas?
>
> Thanks Thomas!
>
> The bisect and the behavior make sense now. Previously the legacy
> events weren't part of perf_pmu__for_each_event and now with the
> legacy-hardware.json they are. The events were parsed by matching
> explicitly in the parse-events.l lex parser, but for lots of reasons
> the json is better. Anyway, there is common functionality for
> reversing a perf_event_attr.config to an event name in
> perf_pmu__name_from_config:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/tools/perf/util/pmu.h?h=3Dperf-tools-next#n306
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/tools/perf/util/pmu.c?h=3Dperf-tools-next#n2728
>
> The normal case for a PMU is that we want to see if it has an event by
> name, so we have a hashmap from name to the "alias" information (I
> don't really like the name "alias", it is information about an event
> we want to encode):
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/tools/perf/util/pmu.c?h=3Dperf-tools-next#n58
>
> The use-case for perf_pmu__name_from_config is generally debug output,
> so there isn't a fast path config to name lookup. Is config to name
> lookup sufficient in s390-sample-raw.c? I notice that the code is
> matching the "event=3D" part of the encoding, which is a sub-part of the
> config (and may actually be a value in config2 or config3).
>
> I wonder if it would be easier to add a cache of matched names in
> s390-sample-raw.c? So a global/static hashmap in that C file with a
> key of set and nr as per get_counter_name (it seems the PMU can be
> implied to always only be the core PMU) and a value of a strdup-ed
> counter name.
>
> Let me know what you think and I can send you a patch if you like.

So:
https://lore.kernel.org/lkml/20251030171211.1109480-1-irogers@google.com/
should cover it. Let me know what you think.

Thanks,
Ian
