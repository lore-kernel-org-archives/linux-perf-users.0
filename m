Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FC52DAFD7
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Apr 2026 16:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775491890; cv=pass; b=j5rlYAfR72l3T6G0ZghRk+YC3Ralg4Gz65YMRYrXzwS91XsBmX7mUKP7NMpd+MCMNZVD5eo6aarCeyzcyHbWU0Gtqw3Z1iR3f/dbwvWky8+01/3/pgTPANTj73LUA5a0JP6YDvZVal4BkkdWHxd6UnZ49bDWFC9VElojRPjWhi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775491890; c=relaxed/simple;
	bh=6rXUBCUZbg9vIzk9rudSe/qcgXU5Be5B8LMI2la5dYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IWsNPxckJ5SfGxv4vwkW7PeztzcEuuOQU1RrnqexxhxX1uUc+CEEi/qN244+6DNeDwFLGjV9p+FkJbMJz+3hEaC5zUsCF6FIS+7vxC6+HUVYyqoOGPSR7/LzKMRwKGkF3TsqTKGqeWyTW9aADjFbBxgvnduSqha1z2PNmlw+FZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qc0dgBI3; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qc0dgBI3"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b0b260d309so213435ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Apr 2026 09:11:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775491888; cv=none;
        d=google.com; s=arc-20240605;
        b=gGh5MnQuuOX0c1kzaWocLKHZgbC0qhLiTr+ZVxSpjN9IgPO8Sq+nDZSfvynN7dj5X4
         RvRpwIoGqz6WhIv6e++oYV97GvI9n0dODjSwaMudgNkz8doWwSLTyjQwbm+6vpqwycf8
         dXx84WQ353+UlE599e0M6JkqhR1K/BnDBhiZwmy4iNvfeq1po7uqhomnzmBhGTIcZEJ6
         PRizvylROBfrfkXTkl3yGv6MiEkT+I/1NA3Wi5foTXN+PLqHvaCevVDa3AKrpf7wlJJx
         b+gXUS67J/YWsf6y0imQFM2xPlEh76ipCaAkex+Y6Q1lMJLOAGDXXaorDV0O/bdQP2Yn
         Y1XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1x81r3iRTa3fxKPMBJ/Qvf8xplCbNBHfOYy0Aqmmj78=;
        fh=SmoLkMJWC0ULDRn3J1kKRBX0cqZv0WyvmmmpWTdM4eU=;
        b=ZXm8Nhno9WEzTUoJrPWFz8bLhrz0RlnnAXeXuG9ydSSO7yeIOnnqNgRldQFONLDU11
         lQNEWbNG0smE931kRjImjBDSU+py1E4XeZp6JuIlPAlRlr08dhAG2nT7U3Q9os6uo47M
         8OxSC1neoD+/HRXcBabQlMytbARUgop8vE0u5LKpLf+3jLWEQjuYSf47cYWnkUxbSC8b
         UtCFBfZPNEWM6kDX3MALMCJd6P8B6m8O6HMQZwzKVliGMwjkLUMdhy9mvbHXS0EODmHb
         N2CYBPcDNl6P2q8e9CCiZetEiO6nhAKQ0rtkzv36QbZy/94DZ7hmfT2k1V0DzzWix8b3
         AenQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775491888; x=1776096688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1x81r3iRTa3fxKPMBJ/Qvf8xplCbNBHfOYy0Aqmmj78=;
        b=qc0dgBI376ijqE+KGptbl77EYwV4p/eeqDfbUc/oKx6naAKunRo/h9XmKA0rxrCjl6
         ScmRbrqiLkhMV9Mg2C8N0qelaL1bGbvtJLXnJns5ndCuUOiMJ+MIH6WQsqU4GMRhO48f
         SGHZ5ZqgicvzGqqKE6m4tQAaneUK2/A+vRw3UBsLDGExQAapYhXNccU/kYarQHhh6VDp
         BCfjmdcusq231aZsjRMdu1xBUHfv3tAZtkD44AqO+l0O29vHPCoukNBXnzt4SoKAsCP7
         z25tqJkgDFr+KstwkNTqAjsHRZFBtcHYTzBNRc5+bANFKIx48CQmtaDvPD+zUAQgOp3v
         N/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775491888; x=1776096688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1x81r3iRTa3fxKPMBJ/Qvf8xplCbNBHfOYy0Aqmmj78=;
        b=mDnxMq84fewiRJHUjeUJJ5E9sLXmk10ma85JWRY9XIv0hGIT6MrqdyEtPecU3fsnVi
         w7XfxWnK8DZLgdZUPNZm+M+VI5BIUg6+/Nqaj/biV6WAFVoRzf5GySAPqummstx2EfgG
         7PNlJgsMgKw0+MNvck7sdOv4DFjZ9mGVP5KyCI8tOD+76546VOeGdVlMm27V0PzAsNPP
         FQCTOY/GvwKMFGCW7LhjG3CU92PY/hhwAXzbiLiuNR9OLB0ITzALw+/R25Q4SGg6QAGr
         aRKos70Dlm4zghBuAQx8bCYAll9gctf7GhrV7a0UOPV7MWQqrqI4zBGVQcVv+M+xPpjA
         Vj2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVkzHjAC6/YBHA/nqMZdnSvNorX17Wa+ANmQ2Yt32SA+2W5CBFh3bwwEyUKP6N9JxN3m+XvKS6Exc/9ry5nQsQG@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Tq+wIZTDZKruN0NJ3PZnmsmFBWpWtVe1kh3pz520aoq61bl6
	K0+WKIfoENUFoUbHO0LstGVmHChUjTpdoZeDIAtnRyw2QDk7fumGWepqi4HwDLt6orUwzOU5xsc
	cH+ziJmbmsFR4+H+/t5OS680cWSmO8nCxhzPjTWol
X-Gm-Gg: AeBDiet5yG/CubCESA27xSZK/YpkqwBJwHuPSypYZJpOiZ9XXMoQS+1VmbJMYtz9XsJ
	9vAEz4TkViMiX9tAuIcKlVpEdoluVtdCkPDBz7/crWoGXTSCGZs994nBpNzx5xCmfmg4wxW9GaR
	LOk5kBDyNKQ4zphLyQUTnJWb3mM3z8YIS+4pClRMk3s2F+Pkx5EYCN0ZDk/fhnxAiMNXE/qORiz
	xTnlcn6ZvyVYeSurXEoQbaIzu+xBQNuMwgbn3vbTSDTvjO98IKW45qkRoQ4w5tV2ipWBO6BtgfV
	hdfRMsBiETUyNSjLeP78OyiyS4DrSDf43ohR2g==
X-Received: by 2002:a17:903:22d1:b0:2ae:7fa2:6bda with SMTP id
 d9443c01a7336-2b283f049edmr7309275ad.1.1775491887460; Mon, 06 Apr 2026
 09:11:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326174521.1829203-1-irogers@google.com> <20260327045025.2276517-1-irogers@google.com>
 <20260327045025.2276517-3-irogers@google.com> <adNAQzNcCufAf6Jk@google.com>
In-Reply-To: <adNAQzNcCufAf6Jk@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 6 Apr 2026 09:11:14 -0700
X-Gm-Features: AQROBzD6OZSk3B9NDHQDgnQVI83ou6Tcl6__NEgXrtGy9dCtraIUwzq2i7bBN4s
Message-ID: <CAP-5=fXxa2rvxMqZoD5ayETiPjS8cf7A49TdVwwt+10uPu58Pw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] perf symbol: Lazily compute idle and use the perf_env
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, tmricht@linux.ibm.com, agordeev@linux.ibm.com, 
	gor@linux.ibm.com, hca@linux.ibm.com, jameshongleiwang@126.com, 
	japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 5, 2026 at 10:10=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, Mar 26, 2026 at 09:50:25PM -0700, Ian Rogers wrote:
> > Move the idle boolean to a helper symbol__is_idle function. In the
> > function lazily compute whether a symbol is an idle function taking
> > into consideration the kernel version and architecture of the
> > machine. As symbols__insert no longer needs to know if a symbol is for
> > the kernel, remove the argument.
> >
> > This change is inspired by mailing list discussion, particularly from
> > Thomas Richter <tmricht@linux.ibm.com> and Heiko Carstens
> > <hca@linux.ibm.com>:
> > https://lore.kernel.org/lkml/20260219113850.354271-1-tmricht@linux.ibm.=
com/
> >
> > The change switches x86 matches to use strstarts which means
> > intel_idle_irq is matched as part of strstarts(name, "intel_idle"), a
> > change suggested by Honglei Wang <jameshongleiwang@126.com> in:
> > https://lore.kernel.org/lkml/20260323085255.98173-1-jameshongleiwang@12=
6.com/
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> [SNIP]
> > +     if (e_machine =3D=3D EM_S390 && strstarts(name, "psw_idle")) {
> > +             int major =3D 0, minor =3D 0;
> > +             const char *release =3D env && env->os_release
> > +                     ? env->os_release : perf_version_string;
>
> I think Sashiko's review is right.  You need to check the kernel version
> instead of perf.

Doing this can create more problems and complexity than it solves. If
we state that `os_release` can be NULL at this point, we recompute it
using `uname`:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/header.c?h=3Dperf-tools-next#n378
then do we cache the value in env? What happens if a data/pipe file
that assigns to the env later? Ad-hoc users of env->os_release
recomputing it shouldn't happen; instead, in 'live' mode, we should
assign os_release using uname either when the perf_env is created or
lazily with a helper function. I dislike that with a helper we could
potentially have multiple notions of os_release.

I'll add a patch to refactor the use of os_release, but can we be
mindful that this is clear feature creep with little benefit? We will
still fall back on `perf_version_string` if uname fails and for all
practical purposes, `perf_version_string` will differ little from
uname in this case. I'm only going to add the patch because checking
other uses of os_release suggests the change is benign.

Thanks,
Ian

> Thanks,
> Namhyung
>
> > +
> > +             /* Before v6.10, s390 used psw_idle. */
> > +             if (sscanf(release, "%d.%d", &major, &minor) !=3D 2 ||
> > +                 major < 6 || (major =3D=3D 6 && minor < 10)) {
> > +                     sym->idle =3D SYMBOL_IDLE__IDLE;
> > +                     return true;
> > +             }
> > +     }
> > +
> > +     sym->idle =3D SYMBOL_IDLE__NOT_IDLE;
> > +     return false;
> >  }
