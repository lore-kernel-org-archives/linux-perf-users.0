Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F6834D38B
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 21:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776978270; cv=pass; b=pQrtudBnx166YX4S0gUzhO+d++ol7B+J4LhkmL2J1bsWh+FB/aoQiTRqlWo7h51X2XyVPfAmFQu+Ebrj4gtzeCwvxgjKbeQJJwmFkd/+8q+47FaOYghjhhE7QYYcUZUVkF+WB8qmrUAAWB1MuhWBnJcS4H6KxARSlERr45o6qNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776978270; c=relaxed/simple;
	bh=l0dbYjKaXACLE+g6kyWGTzIuoHgSBIG/FDz5a+LM1p8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ra62FyBwm0TmzVh/rwywPnMervvV7Lx9KWnRd5vXtpfZGy351sM5WvnkdSaSKpwyMVIJB5SCHrDZJVEihV3WJ0ijKJxoi7lY1ZnESNnssYh2xE0+6GkP78HGzc6TCqPE6xc1+zDmgIRjs9M6/J5+X42TCSPNLASuxKjRRO6cIRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L1e0ETat; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L1e0ETat"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b46da8c48eso164095ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 14:04:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776978268; cv=none;
        d=google.com; s=arc-20240605;
        b=LgywS+OeSJF+9QqOjW0HsWiuJYkGvJ++lo7m2ajiQTC8hdUip4ZjoNklzogV4j98wq
         TBpgMSDARME95dCtR8O9Q1as3mVU+M91g4H2ySEPIpTmtoy5TiJVeiRvHzoTsj+dbjc3
         MZopATxjkEZqKil4V+cDFFVpKRrGkwQBYNB2dccjS+0P8u5JND8copfJDzWsF7bEGWWx
         HBMdag9NcKf8oxOlZI12AnyekN8GqZ/Lk0pFJkxGoj8AVQYKu4WSwLTVdjTwueMQRlLx
         rk/HEPFFDqgGiQYRHELfZUDmvUTOHLi5UrbizyYLxs1ergXHaP+8zmNYLl9YcSJWGChd
         8WPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1cWLkIeO9dgziLvD/Z/sVLy1HSqogwbal/nrc7rK6xw=;
        fh=H/rlQhLByHYEgV4JJC0VNj8HzthlgQ6Q+f2H2eREEOA=;
        b=RM17WEOCLMven8d23MjvgxGAal6CBSZ5twLF2GYp8ofEFz5QON6Ub4d0K5DiTbzcz2
         yWFbLFJKtm80Vl7z6Qol6TYTLvM/C/Gj8B3BzF065LJub8HXGgT5WrggZd14VwTxBLmR
         Fto9mqO3WP7r2svJpGdHR26odhk4HqIlQ2a+sxej6nt47uj/4SHevcUonixeMxykqvKn
         C87rXGyqb9haIFq0SsMbSUt06/v7dxSPbrZs3zbhml3U1n5Rmy0my5J3XROZ8zn+LIGv
         1WOtVPmkVZyVl5NTdey7L273pfv9x7an1AuaoP3u/WzsX0Ix+HFa8pYWyOE56QoWv0NE
         37Aw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776978268; x=1777583068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cWLkIeO9dgziLvD/Z/sVLy1HSqogwbal/nrc7rK6xw=;
        b=L1e0ETatukCaAGKYOKmEzpg0l/CyxMvMZFMiR2LH21phe2vaAnWxjjINiAoMeB2PkD
         hS0/wY0eiSo++R3I8EYNimR6pk1d9sYVQp39il0d0sGQVnAkuYJ3vmTBSzMksVAAhFBB
         q9V5Cxe2zIKoVE1P2U0VL2g3mlNf/lmsWzox83lpUAef8LJBQvD5SUlqwTsr4ud71w+D
         Ygpr8xoSX/MwDlAsWIIX8nt6GN9ekQhxLhNp3yQa0rngUNHyrvYqcm3xuUiXvNuRJfWW
         AC0uX6x6PHWLZwoPDUiap9kaFfdYJDawZha7ek5A8XEp1yH4O+XyBrmkByYdxfKJaY2t
         uMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776978268; x=1777583068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1cWLkIeO9dgziLvD/Z/sVLy1HSqogwbal/nrc7rK6xw=;
        b=i0aY2CZuXg+JuzxN6UZ7tkXwAMaeiXHfpx/PrCK9R9gGStP6eclQrBBW2STdTlkNPF
         VPEJDn6S/82fs5WylxzAT4jFVMOczucyLjfxDoXmTPmt+1a+V0sdcwkU81gHgrGxdt1c
         LrsachBdYa9x/bmbjYStZzF1y+RUcAl/vWJcO1huy9Mrs3FvdlXEaDdGgTdKPPU1lvZF
         jcUOL7peiPHUyd3tVXymKE6KxXz0mCC06XgOxD4nXY9v/531/FmQ15EUCWePqJ29I9OM
         0CuWZ2cQQaMYNyhFVX4AksFDw1BjYZyi8XFz5/wR8LZa/ZspnhqyI9Qe6i/xuTBWAW9P
         JApw==
X-Forwarded-Encrypted: i=1; AFNElJ++FAsuQZl2jvRKA3jjQNwsL0yM3VZ6qY9R0oV9yXlUit1O/vaJlNBOVGsukvQKlTP87owWtLHh53sVVE/DNdcQ@vger.kernel.org
X-Gm-Message-State: AOJu0YynU+lh+Ge37KCr3mX14KVonRArr1PLg5bOfYzaClN3Nlnw3muS
	bc+xJT60230ielo7HgH65zrAD6HAoV7LGaOQVq34fg0GUcTZqbMhbhCYbPm48ayFrWi4Hx41xCR
	v0NGp+/t4iGbRvrg1V3Y5rcfkkYq+J9V2Rq+9YLwY
X-Gm-Gg: AeBDieuc+EtdObgE30GoHNekW2S5d5O7VyiVZg5xsAVfDrX7BgU7IgN1hfWqc0XDGs3
	wm7fMIg03fe9f8ZrIWG/kaqpasmRiK1pIMQ9th5ecF6IvQg/UAW4vhoJBeDVNQft61893bLYz1+
	xGij9K5ckdAHWAMjmyDikC8I/PpLJqnNr0/8UxHLzlmX0BKjtrskZi7/eV0MqRGzvWZfctSTr0j
	pGS6iWk5bWfc8RTPGIAPILOfsC8HFfTyUZXo1ezLzUEL2XmLGnvkklAmJjYnyQtznJAyYCh/sSg
	B6Te71DpPIrT+OsUMxGGV8Xr/2k+DXINnsajDB0mIkgEy5asgQyGcmYn5l3rlWnAeihN
X-Received: by 2002:a17:903:1b68:b0:2ae:7fa2:6bda with SMTP id
 d9443c01a7336-2b603e99857mr10721985ad.1.1776978267781; Thu, 23 Apr 2026
 14:04:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aenFGy9WDllTEO0S@stanley.mountain> <CAP-5=fVL_qishriDrRvvXQQ5VSBZAxs3F-HQ69yEtEzdf+6MMg@mail.gmail.com>
 <aeqAypUUfE8jB7Uo@stanley.mountain>
In-Reply-To: <aeqAypUUfE8jB7Uo@stanley.mountain>
From: Ian Rogers <irogers@google.com>
Date: Thu, 23 Apr 2026 14:04:16 -0700
X-Gm-Features: AQROBzCNv8y7m_shmSeQzeQ1gvsdC7ZxfHk-9Me1GDtw-oRfFJO5phcWWkhoONg
Message-ID: <CAP-5=fUc+j+B1s0BO-xrUe6shv=xdGtoAyztFRrLwHR53yY_SQ@mail.gmail.com>
Subject: Re: [PATCH] perf dwarf-regs: s390: Fix an off by one bug
To: Dan Carpenter <error27@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Guo Ren <guoren@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 1:28=E2=80=AFPM Dan Carpenter <error27@gmail.com> w=
rote:
>
> On Thu, Apr 23, 2026 at 01:24:50PM -0700, Ian Rogers wrote:
> > On Thu, Apr 23, 2026 at 12:07=E2=80=AFAM Dan Carpenter <error27@gmail.c=
om> wrote:
> > >
> > > Change the > comparison to >=3D to prevent an out of bounds access of
> > > the dwarf_s390_regnums[] array.
> > >
> > > Fixes: 1e452dd850f3 ("perf dwarf-regs: Add S390 perf to DWARF registe=
r number mapping functions")
> > > Signed-off-by: Dan Carpenter <error27@gmail.com>
> > > ---
> > >  tools/perf/util/dwarf-regs-arch/dwarf-regs-s390.c | 1 +-
> > >  1 files changed, 1 insertions(+), 1 deletions(-)
> > >
> > > diff --git a/tools/perf/util/dwarf-regs-arch/dwarf-regs-s390.c b/tool=
s/perf/util/dwarf-regs-arch/dwarf-regs-s390.c
> > > index 310a37451bdc..f79216a7665a 100644
> > > --- a/tools/perf/util/dwarf-regs-arch/dwarf-regs-s390.c
> > > +++ b/tools/perf/util/dwarf-regs-arch/dwarf-regs-s390.c
> > > @@ -45,7 +45,7 @@ int __get_dwarf_regnum_for_perf_regnum_s390(int per=
f_regnum)
> > >         if (perf_regnum =3D=3D 0)
> > >                 return 0;
> > >
> > > -       if (perf_regnum <  0 || perf_regnum > (int)ARRAY_SIZE(dwarf_s=
390_regnums) ||
> > > +       if (perf_regnum <  0 || perf_regnum >=3D (int)ARRAY_SIZE(dwar=
f_s390_regnums) ||
> >
> > It looks like this mistake was copy-pasted into these files as well:
> >  - tools/perf/util/dwarf-regs-arch/dwarf-regs-csky.c
> >  - tools/perf/util/dwarf-regs-arch/dwarf-regs-x86.c
> >  - tools/perf/util/dwarf-regs-arch/dwarf-regs-powerpc.c
> >
> > Could you fix them all?
>
> Sure.  Do you want that as four separate patches or just one patch with
> four Fixes tags?

Probably the latter as it will make backports easier. Thanks!
Ian

> regards,
> dan carpenter
>
