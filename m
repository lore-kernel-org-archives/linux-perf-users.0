Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0364D599
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Oct 2024 21:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729720105; cv=none; b=RnFKrmkofboWOr8FO5gVstHSYYcVPpjG13qdPyVeWJNI9QvEk5SkYXPlHNU+7tbuOiwETKJfIaLrj/VvwmzrsZHAa5L6SiZC/k4GKw3SpjebcLeSwlX0nfjcOIm+iI4YKoBNNo63pZWibjRa30dZM7x4njB/Pxj+HLO390EKWZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729720105; c=relaxed/simple;
	bh=IL0wyQWP0Pt77H4xEl1wxvaUTqvVp/EkoqXqWvSIwng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iva6CRGEfRWhUHkp0MXexkHJNojuAIDrwb/yT0X8zqZsTHY4kJHlg2EIplEWCkoLotDua8cIyXvYMRGWNGJ32QD10DJwCAEDpgoxSOfVOC8it1yndJDWp0Mgf5/Pyu55KJOp8dogAacsLrtYoYR4ig+Phmwme6dlOaEtEOPdROc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yIwCIV8L; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yIwCIV8L"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20c87b0332cso18085ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Oct 2024 14:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729720102; x=1730324902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T16/eW3qkzMOhEHsmlk+xqRjgZNiiB3cap0bYGPus8U=;
        b=yIwCIV8L9GI0CoFuv9iqVWAXEij7ppd9bMm65BTexVejgyOIIgZnWqXkiJ0s0ZtOhz
         UUBxq5+xOc2xJaVq1j3kzaA1oLJOV0C3PHZTYZgaYFQU0RuTHYPWLI3j+D4IlCUzcz7p
         GWNqjdWBMO34JiviznjLRbcCvINdQ66hS9BTyFt3eFqO7nFAhwHM63Bo1sqKgCuWr4y6
         OS9JHGNY8mix89Yb0AdBOT0quP/A4WRmSRsXb1GuVhpAsfvbvHniy5YwvtTg6a0rpCMT
         ogHiVleGzEUh/HOi6eMDnMF5UHN8Z2ZZZsTCwA665HD4AHDDCrFv+ivYVz5Tofmo+ChF
         BGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729720102; x=1730324902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T16/eW3qkzMOhEHsmlk+xqRjgZNiiB3cap0bYGPus8U=;
        b=s9Ch8cAorpBPw70u9xII/WViANwgnnIP9Ah2UKV9qFAnblI030vdUAnZ9eTjrsqJq2
         fejueKGcfcGSXXQuL+/DNX/uOsPQ0udYTyg92UQ02yosXRRmIeY/VMPjf5AA0uKduhE3
         JDC+N81jLNH0mRs7lSCDd83ZCIPnt5MbWCbe7D6gl54gYBtrx5cSWXd+o3l1YpbVt+I7
         RivJQXN7yW1SoM9/uIcIw+6DebkWrTvQUeS7/Wyze+1NUnioXU57hBrQdlKFSZx5E78v
         FPYeblE0VnT9x09C0VajEFGGz7uwXZMFz2vl+pJbfk/nS9wlL4cmCYonGiVis11oUWIl
         00Bw==
X-Forwarded-Encrypted: i=1; AJvYcCXLIlgXwmTopkd3Jq1tCXLFgtdTvdfnEzyV9huXmiNMwrHc4LChnKfFo42WcPmQI5VFwS8MeAwrJe0Aa0xNAyQg@vger.kernel.org
X-Gm-Message-State: AOJu0YxWp+awyAnJDbykra6j9vA3DqMsqeY+te1yY13dRaIx3AOiazV2
	iajYwhqidiq2eZc5aJu9TFbkZqvsTZ2s5EC9NxusPwbHoHSuL6U6t+2sQiHtAUzAoclusmUrEaU
	AmcZZQAd8mDpSu8jSwWGO+jgwujuTXR5T3G2w
X-Google-Smtp-Source: AGHT+IHeTzJMIbI07j3Yqr50sx54hl/KEQSmDh3LQFIsEwH7twUYGnQoDSD5eKhjbwpu4BBoyrG727LE07MujBrtDbY=
X-Received: by 2002:a17:902:fb4e:b0:20c:79f1:fee2 with SMTP id
 d9443c01a7336-20fb5f2d8d6mr985005ad.10.1729720102156; Wed, 23 Oct 2024
 14:48:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZxllAtpmEw5fg9oy@x1> <CAP-5=fUF1kfioGSgnXzPmadwKrd65mUpHPamPNt29ra9qZAzJw@mail.gmail.com>
 <ZxluzQ3wN1aTcEXt@x1>
In-Reply-To: <ZxluzQ3wN1aTcEXt@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 23 Oct 2024 14:48:04 -0700
Message-ID: <CAP-5=fVMwVigWsi7-QgBGZ1QbUuPjAxnr5gaLybHtynG7rHU6w@mail.gmail.com>
Subject: Re: [PATCH 1/1 perf-tools] perf python: Fix up the build on
 architectures without HAVE_KVM_STAT_SUPPORT
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 2:46=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Oct 23, 2024 at 02:40:45PM -0700, Ian Rogers wrote:
> > On Wed, Oct 23, 2024 at 2:05=E2=80=AFPM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > Noticed while building on a raspbian arm 32-bit system.
> > >
> > > There was also this other case, fixed by adding a missing util/stat.h
> > > with the prototypes:
> > >
> > >   /tmp/tmp.MbiSHoF3dj/perf-6.12.0-rc3/tools/perf/util/python.c:1396:6=
: error: no previous prototype for =E2=80=98perf_stat__set_no_csv_summary=
=E2=80=99 [-Werror=3Dmissing-prototypes]
> > >    1396 | void perf_stat__set_no_csv_summary(int set __maybe_unused)
> > >         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >   /tmp/tmp.MbiSHoF3dj/perf-6.12.0-rc3/tools/perf/util/python.c:1400:6=
: error: no previous prototype for =E2=80=98perf_stat__set_big_num=E2=80=99=
 [-Werror=3Dmissing-prototypes]
> > >    1400 | void perf_stat__set_big_num(int set __maybe_unused)
> > >         |      ^~~~~~~~~~~~~~~~~~~~~~
> > >   cc1: all warnings being treated as errors
> > >
> > > In other architectures this must be building due to some lucky indire=
ct
> > > inclusion of that header.
> > >
> > > Fixes: 9dabf4003423c8d3 ("perf python: Switch module to linking libra=
ries from building source")
> > > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > > Cc: Ian Rogers <irogers@google.com>
> > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > Cc: Kan Liang <kan.liang@linux.intel.com>
> > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> >
> > So this will at least conflict with:
> > https://lore.kernel.org/lkml/20241022173015.437550-6-irogers@google.com=
/
> > where the #ifdef-ed out functions are removed. Does that series fix
> > the ARM32 issue? Could we land that?
>
> I'd prefer to have what I posted for perf-tools, as it is smaller, and
> to land the patch removing those functions on perf-tools-next.

Makes sense to me. Have a
Reviewed-by: Ian Rogers <irogers@google.com>
should you need it.

> I'll try to switch testing to a librecomputer board, the rpi3 is super
> slow :-)

Thanks,
Ian
