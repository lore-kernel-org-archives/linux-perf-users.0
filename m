Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125B53DFC77
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 15:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777908409; cv=pass; b=leOFW9u04D9SPjzf8sSvpOCnjyH+vp5TCFVlrWtzqrRnTy6RGigDv3HctTolve+9XViOvaa1HVZQjfeAUA+yxFIWKEaYhQQaBd8nGRaX9vlZjjVpLRGWVG0xcorR5DRtRLz0QgziKCo50lroxF36RLwc593903+lauJpQZX3tkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777908409; c=relaxed/simple;
	bh=9kuhRo2FzyDeDB/f2HIMKjEN00Oze4XF5EsTLm2QQXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=acCsNd0P/ZioVLwGT7752+c5nIytGmiGW8uqsFPVy+ii+pwXBIA/Yu7J66Zh22QPFKqMHBfcUi0CIEwhdNwTJ1+qV3VzEJrPRued15VJTow1sV0Q4uauKB/dU2tBZvw+s07Pmj1ZHBqHECtfZS9nP2fjoZlQUU2hnOLzrXNzDPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f+N0VFfN; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f+N0VFfN"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso141045ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 04 May 2026 08:26:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777908407; cv=none;
        d=google.com; s=arc-20240605;
        b=UuhnKB3X+9mLoHRQp8y7mQsyXzCfK/106uUfXZKgxNTT1OZnh+qZBiaC9dkjpVWCDw
         LxQhfI1jagksULi57agxCX66xBO0Fceqn7k9o1ANFO8YN9uj+2qovzy+rtl9NkvIWj2D
         Dz//nZOAXEfVTdodfLOq3qbg4SO04/ZoazX342+pr9jnsAJgYTxBksf2cm1Co3svLJxB
         /W4rrPmSKERP9jZACpHi92VCtRbrxd36KocQCDRie6ueJPpHZsFcjTaYVzyAYHt5y1nP
         h0xCAxF/QY5JA87I/edy5EC7MyPBUM89HescO5GyTjIQOOcxCiMCCcXKcRfob7Isg7n8
         LKuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MVNGYuyQwowloAjO2LdpR0sLjaPkeXfjsZQ2ODRZb7Q=;
        fh=RAx4EYoAEHQX8CREJ/n5iCXuFT3ssl6UaSz9YrEw66M=;
        b=gDHkctcnP9Ne1oe7qgW6KAi7xa0mKDEeYq1RdLb/a2fhgShxUNLraKsVwkiyrl4Qi1
         bjj4K594u3N9babNHgveeDnKT/PLrxgOFEhgkB/C8ha9edhpC02oaptLD31z9REvS1/e
         4rof2PTnkJa8iB4ZDjkzyJGq8MM1db8mwduyYNKY56iE9HAs97i+qdkvqHz0FEdvuwlk
         OPfV0J1pnnSG8Xm2ZqZUFLIZevVQgVxOOJqSQpNY5dgMSnPQimYOmg3NzDlHt8gGxEPb
         roIAyJJNuO+fMfnPp8yFdLqg5aEP2Zmr36pNnV12HvtXfevpf8ReZ8Ala2rIq8jqPPd9
         aqLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777908407; x=1778513207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVNGYuyQwowloAjO2LdpR0sLjaPkeXfjsZQ2ODRZb7Q=;
        b=f+N0VFfNPibq0Qy3LGCmZGm3gW1jZB6cNAegS+E7OXqanRh3b8tjH41FzLB8cQoW8M
         dUL0S0QOwoouNHCHwJLh1St1s8+DH/rg2kbXxQeNt/VLGNQJA1xPYLT2/hZWbpBIF/b/
         jZEwPcEOxGdDzKc3Yu1ZAtLvSC9JaOR3f0QMZ8safRQhkvGmGIYnoFubKZltkrar3Aou
         /A8tsneXCDTNAXZBbsYLKDbkWf2BGjIizi5WVnp97StF8w3JxrJhwwR1aObM5+xraeTq
         1d0t4tZxYDJwNVsjKt10VwGRI8VuFjJLYH3voWSyK6R7HJxeXUiE8co954seqC35Vzwe
         ZbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777908407; x=1778513207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MVNGYuyQwowloAjO2LdpR0sLjaPkeXfjsZQ2ODRZb7Q=;
        b=HrwMMywttm4ngXOS+XzdKIe/b5H2/fLFYQGYt5Zboq/BVTjM3XBNk6vnwIpYriiWun
         ZV9f+AESVrVwAf26csCLie9wz93TcP4Hdvojb8G5ZT8W5/4Z/T2v+yFwoamqBVXV0A/j
         HUYr34rSp/medbsFPJ7Uc6Cp0vK7OLw0ZSgbfbEvoUXXgJXaObg41PMqNp9mfyvVweKf
         mtXhuu8XZNyTLWsoUZXcW/VC6jakOb0HOfS8x0hZs73KhdB8EGBpjuUYEaFl2sStrEY1
         e8LVZYy8KcssTb8aR9oTbGRGEW0M9M0VPvyXB2iBq04LK2C8FJ9f1OxbK83Don/HhKBd
         7OAw==
X-Gm-Message-State: AOJu0Yz4XRtMl3vr9a8FkNeVMWal+FHdNKgVQsOT6ixRMXZB9BqIPdYC
	7tJqFHvEWgRqqH3ePyPiYP7oka3IyH28/SVaLjTSfEzQ2DQaxRV49n+KjFih6okKO2QUBSBKr7w
	R3mm/2aAuFay35tIuW2JzVaGNhalVAO2oiL5vTBs1lT45DhD4k/8kPwHJ6sg=
X-Gm-Gg: AeBDiesYvEkyPFYJNIVi2hDMttWpaBokVMlfDbfZRmOYMYKClShpxBq7DTNtk2xlZ0R
	veyGb3CAhzbkqtgMc7YbpG+YwU+QnewYs0IMW5ZVD3ev6YJF2U4aYAilDWWgX6qpOwuNm7qJCOT
	2fwvUR6vVYgrfXlANNWMULxsu0Wp8izNTPiyX/p3Y1lMlowXArtvQ1iZQke0FEfjfOLptlWP/TY
	k21XcZJrvkPsn3iJjNzpwzFKUPsL7vuMG99TuS5czg3JIT8q7ppsrNfkc8dIqFFErhtp2nKWzsa
	wRbyRAr+gqa8Z3G2wUz+PRxaLM8M6g==
X-Received: by 2002:a17:903:1a86:b0:2a7:87c2:fcde with SMTP id
 d9443c01a7336-2b9f5892686mr4609735ad.15.1777908406371; Mon, 04 May 2026
 08:26:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504081227.2203848-10-irogers@google.com> <20260504105301.29676C2BCB8@smtp.kernel.org>
In-Reply-To: <20260504105301.29676C2BCB8@smtp.kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 4 May 2026 08:26:34 -0700
X-Gm-Features: AVHnY4IHluG7YJn6wbIzJuthvTjQOKDjQwRxZDYKQywpOY6yeP3FnIHR8raHaq8
Message-ID: <CAP-5=fUuqcGCgpZApHbqpP8hxs2Y+FYU2W=h1T0D4qgdhOfdBw@mail.gmail.com>
Subject: Re: [PATCH v5 9/9] perf debuginfo: Fix libdw API contract violations
To: linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: sashiko@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 3:53=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Critical] This problem wasn't introduced by this patch, but the open()=
 call in debuginfo__init_offline_dwarf() lacks the O_NONBLOCK flag, exposin=
g a local Denial of Service (DoS) vulnerability.
> --
>
> commit a6e339ae66465b909762a437f958cdaed424b666
> Author: Ian Rogers <irogers@google.com>
>
> perf debuginfo: Fix libdw API contract violations
>
> This commit adds return value checks for dwfl_report_end and
> dwfl_module_relocation_info to prevent potential segmentation faults. It =
also
> fixes a file descriptor leak in the error path of
> debuginfo__init_offline_dwarf() when offline initialization fails.
>
> > diff --git a/tools/perf/util/debuginfo.c b/tools/perf/util/debuginfo.c
> > index 0e35c13abd04..84a78b30ceac 100644
> > --- a/tools/perf/util/debuginfo.c
> > +++ b/tools/perf/util/debuginfo.c
> > @@ -42,6 +42,7 @@ static int debuginfo__init_offline_dwarf(struct debug=
info *dbg,
> >  {
> >       GElf_Addr dummy;
> >       int fd;
> > +     bool fd_consumed =3D false;
> >
> >       fd =3D open(path, O_RDONLY);
>
> While this wasn't introduced by this patch, could this open() call cause =
a
> regression by hanging on a FIFO?
>
> If the path originates from user-controlled sources, opening it without
> O_NONBLOCK can cause the perf record session to hang indefinitely. Using
> O_RDONLY | O_NONBLOCK would prevent this.

So this review is bad and based on this prompt:
https://github.com/masoncl/review-prompts/blob/main/kernel/subsystem/perf.m=
d#file-io-safety-on-untrusted-paths

I'm trying to get the bad prompt removed. The prompt was automatically
generated from fixes commits when we added O_NONBLOCK to address build
ID reading hangs, particularly for data mmaps during perf record
synthesis. We now avoid those hangs by checking for a "regular" file
with stat. Therefore, the advice regarding O_NONBLOCK and EINTR from
the prompts is incorrect and does not reflect what the code base does.

Side note: this is the only Sashiko feedback on this series:
https://sashiko.dev/#/patchset/20260504081227.2203848-1-irogers%40google.co=
m

Thanks,
Ian


> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504081227.22=
03848-1-irogers@google.com?part=3D9
