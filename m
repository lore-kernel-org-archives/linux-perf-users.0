Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5226B346AC5
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Aug 2026 17:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787162311; cv=pass; b=mjx7DwkJHtNpWvw0u7voJ2glQDVnpwdC1kLSfoNZDgOGLAwyIOTFFw0ec9vu4HpZ+cj+Ny2n22jIDARdcm1WX9jpClETiNMwqaL98LIZRbq4fbeza0w8qdI4SPXAz1aWosf+xc1I02iWFqoSFB8/oGmNlAbHMgaPHl1cjDn7rwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787162311; c=relaxed/simple;
	bh=8htLvc9RrWnOxfsOW/mW5Hw/8Vd/OSkT/OSEZcR4ZTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JZVt+ZWJfYfwmIiJcfjjL237n/15T9R+HOx3nY0THT5ln5SItyumG4WMFZMzPvGUqm+v+NxVLIHU1vJPHMqvREpfalnajtEO0agg/tbUNHwrjVDkrPST+Q6AtAKgWV6FqXQZF6sdUlaCN/YQfJLZYEHbXt7+5nKLR+FVkOAo2Yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PTfTOh+z; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PTfTOh+z"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c01c79467so26021cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Aug 2026 10:58:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787162309; cv=none;
        d=google.com; s=arc-20260327;
        b=EY2Ftmu0UsuLzyWrT8YNzW98qYECQ6tcUIEpjSBBZQSiklDq8oqi+vURwJi9uG+LBv
         A9o3JtB4zez8G6if1NMoAifUPEuZ/Qb2gk0mrcWV4ME4BVJbK7FpPQocecjdh1sarym/
         XWHPlCUu4GLavpdlZDtMORtbI3vVvQHATVBEC19VTN3gxUoeMyeiXETZK3E99BObniBU
         RPfPzyqPaImfWf8lFjgWKCZ0HXYPX9GXPXFsNORLhhJpFwgQgrg2FR9wP9ixtyUjmGiS
         EaeH0YER4FBRKpSsRx7k2p63sfTdua8IjxIz12hAF8W6EkfcOVm7KfhpzPbWNvp/0qqJ
         lOpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mc0hyeqioqtzmULFrbxkZ3s+nq4L+ZdiW8xKqrbfCrY=;
        fh=VBF+dyWjWvfS06EJtD4n2tHmIZBHLHdwMXERApeu2vo=;
        b=sc0jNM+wMOw9Dj93thSLvDsX4LSRIN+ie+Kts2ljkg6M5JwQ6VM4mFDSWeMw6JS3zy
         kKEePA+AaijIO5qZN84cnTwGZGGRtRzqUnqKi0jCLN9zueTMNQ4ZIMWK0blPIGnp4eGg
         QDK6liXGW2shqjiCfvt8QfJsM7LJVNZf/jpSteTgUiTgEHCOWBoFcpXoBHUWKhYp7io2
         JPTthcA+Fz8nOcP1p0Y8DMHxo3lAh8haMD0cOsHOzjOb15ZaBMwWZGTIk7u4YWazh5EP
         Pag8XVgBWZgGM9oxtmrqnLBmhq0h9EWx/MA2CCz5cSSSZnfdJyeHkRLZj5K+A1hm9/kU
         2rUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787162309; x=1787767109; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mc0hyeqioqtzmULFrbxkZ3s+nq4L+ZdiW8xKqrbfCrY=;
        b=PTfTOh+zvcuDwnsMG1RePktn8E4KBwPumx2jnzSrVWmf1ZvYZO50FSGvEnxg/e+SmL
         7HeG1nFhDev9W/UqvcI5WE5ekD3VOMW7/cgjVfBgHXxTCmB69hWXQgEm56ng8arvazQx
         CAxcP1x/NDvC3l/guwVxjMHF7y5TKdjtrB/PIdt42m3nz3km9ER1A2/o+WIFEdHRFpmv
         XxZw4+uBtHj1nKELh3SA6Czvbnsf0LRuU7AOJvtcCvyNSlk3Yi4iyuwshYUEFjY7JOCf
         GVceJhuiMZGFXwOzAODr/73wJYb+4Yx4YuyoMdFCgNxXZWF4AI2osJftxCEUk3Gf23yC
         9jgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787162309; x=1787767109;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mc0hyeqioqtzmULFrbxkZ3s+nq4L+ZdiW8xKqrbfCrY=;
        b=P7uBKsfgKgObwzBKoVusgGgHo4riuqU78kDQ6Oegt/6kDoyDdilB5M3bM4x8pl2LD3
         K/hNk2zWcqH8lM6KGlyp8zkdF2GAR8JRhBT638UfLfvSYu60z5A7B8ZICJWqT2GFPfRd
         BReAHdjLxjtQxYj50F30uk42/KsfDYp7zfVdpxI27hPwzgM+Wo7CnyM2mG75YrPiZnl+
         oz8U0QFjkiQbTM2BxadwvCjFtbVHLgmvvYfr0KCeCCVvlVTHxreMEEmQgmEYec6nj6rP
         G/ADw/0PSYcLl8SfAlnGvnsn3Kx1PV7TIkJnJzx/hTwyoaI+eoXiRFSHpdadFIkWXb6A
         iIqg==
X-Forwarded-Encrypted: i=1; AHgh+RoprIzr3jfCG0gktTNKRqpVNR1WeMwvw5cjXdCGiVRmohgrKTI80IJsmiqjJqpvMsdYiJjeh2GFtU0KrC3AMUUO@vger.kernel.org
X-Gm-Message-State: AOJu0YxA5oVYT6fRgiqECLePvN2N+70Nigc9aFc1PIiFJDJXv/stTiOf
	N2nDnguSIpFDTM3QV9qdQ3nUq+0pzdpkaUz7yC/U4OENvGAUBdsIMzsgOujudBrjPerxPh50Xic
	ibZl/1DNTNSH4FlXS4sKOgBB4Koc+BnUNz9ROt84Y
X-Gm-Gg: AR+sD10nUn11fyPzNqkXqDYYelSQktW0fYL90O0DeGJ6y0aNuVZN0xw5kqjeyPq/Zzl
	mMwV3e1H0Y+2+WlorjH2WYfUG/WOVYhdz6KzqqeQC+IjCcmTAWla8pMiJIDTVhe7Cj7/qbq3ux2
	Eno7YfpMtoSz8KxhKwQubb60YiFhif+CbSocGNeBPkm70YuHgvHX4utVu6W9AWyYaB2wMClfpah
	IQCDf2Leg5n02yNJ/CAMM8pSwTglGFXJG7R1S4GqTZcNm08q7BViN7Qcduh6Hh5zEaM4BrGgLn4
	15suV8sEVVI2aAJIqxyxMjlww4lFvqgy/6KWBqlerSk3viqimGh28oIL1aDBFAWDw/7yQkavO0b
	alKZzUesS4g==
X-Received: by 2002:a05:622a:4d04:b0:517:64f6:3365 with SMTP id
 d75a77b69052e-52de42038bbmr1358881cf.4.1787162308468; Wed, 19 Aug 2026
 10:58:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813132519.4099508-1-andi@firstfloor.org> <CAP-5=fW112qVVdZGNpdRH0n-B2at4ENDjjNv4Hdehn5bEB9BSA@mail.gmail.com>
 <aoSWkMjxuz3hYr7C@tassilo> <CAP-5=fXYPdVcdVQP0LW+ueLSWY11vFJq9GNVLA_yE=P_1_7giA@mail.gmail.com>
 <7f5ae51dea8c7b6770716dedc46ee1b3@firstfloor.org> <CAP-5=fXLe9tqR7wHh9auRxqX82Fw6zYh1EoTOXjPhOXcRXB92A@mail.gmail.com>
 <aoXVrD-Qbhi5qd2D@tassilo>
In-Reply-To: <aoXVrD-Qbhi5qd2D@tassilo>
From: Ian Rogers <irogers@google.com>
Date: Wed, 19 Aug 2026 10:58:17 -0700
X-Gm-Features: AcwNN1WxbLT0UzpIJJCzK8MIckHOrcyA7R3gvLQicnnUJycmlvwHymouDL1GFNE
Message-ID: <CAP-5=fW6a4MQurwVeL16WWFnO0VQPRm992M==DP9zVza3wgdfw@mail.gmail.com>
Subject: Re: [PATCH v1] perf top: Merge hybrid common events
To: Andi Kleen <ak@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>, namhyung@kernel.org, acme@kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 9:11=E2=80=AFAM Andi Kleen <ak@linux.intel.com> wro=
te:
>
> > With frequency scaling, doesn't IPC remain relatively constant with
> > frequency when ignoring external factors like memory? The IPC on an
> > e-core is expected to be lower than on a p-core.
>
> For most workloads you cannot ignore memory.
>
> Also the e-core IPC is often not lower than p-core, it's
> actually quite competitive in many things. It just has
> a much lower frequency ceiling.
>
> > So I was in a presentation today where someone claimed that larger
> > cycle counts translated to memory system overhead, but they could be
> > unique :-) In my two loop example the lower IPC core's loop would show
> > a greater number of cycles than the higher-IPC core's loop. This would
> > make it appear higher in `perf top`, leading the user to drill into it
> > assuming more time was spent there due to issues with the code. As I'm
> > hypothesizing the code is identical then the higher `perf top` is down
> > to being scheduled on the e-core and its lower IPC. Having identical
> > code where by default in perf one appears worse than the other doesn't
> > strike me as desirable as the same behavior wouldn't happen on a
> > non-hybrid system.
>
> Yes performance analysis is hard and a lot of people get it wrong.
>
> >
> > > > How can we merge non-legacy events? On ARM there is no PMU with a t=
ype
> > > > number file with TYPE_HARDWARE.
> > >
> > > Very few people use top with anything other than cycles, so it's
> > > probably
> > > not a very urgent problem.  I suppose you could push the problem to
> > > the user with some configuration file.
> >
> > So I think users (and me) don't like the choose your event thing at
> > the beginning of `perf top`. I think the work in the histogram code to
>
> I'm not sure what you're proposing here. You want to make
> merging default to off?

So I think we can add a json field to indicate mergeability and set it
on legacy instructions, perhaps things like branches and
branch-misses. We can also detect a hybrid system and switch from
cycles to instructions as the default event when merging is desired
(like in perf top). We can also give an extra prompt when selecting
the event in perf top, perf report, .. where events can presumably be
merged by name. For default perf stat I'm not sure what the behavior
should be as we already expose different count values.

Thanks,
Ian

> -Andi
