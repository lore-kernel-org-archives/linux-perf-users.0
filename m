Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC9323D287
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Sep 2025 15:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757001248; cv=none; b=P5FUOfUY/OMY5EWeDaDDYhgFFpsonthwz0fbxg7mdajtWYpgKfef7mfQkZ/my1/CM/w+fTap8OWGN/67zz5/V4Mk8hQXvqPQV81ea6oNxRq0J1EstFvknVh8mTwd6GlfGlzRaebSTt1Lbe3pcqA6nH9NY9dw5G8K1+MiD3BMGvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757001248; c=relaxed/simple;
	bh=8bX8Pw0dU1Nv0/aA0MnnTJ1bz+yUeok84T0x+Kv0XEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nWp7PlijGwnMycvLvLjYkc/RyMyVZPrnvQQTc7FHkMr9YiR4/d4TxITR4/ZHkhR4eVOVA9LjI7F0O6jJEer8dFXRELjk4L4Ci93JzaTXe8J8MkalaqEey7bixaUb0ZlGLEbsDRIMcUrXucXFJ19UNbhwrRxxa1Ty7cu7XXQpaWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MWFum7xT; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MWFum7xT"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24b2d018f92so202595ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Sep 2025 08:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757001246; x=1757606046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rgDq9K4RutiA3+hQQ/hGnSVwSGPHlJ2FijaFdFtw3Mw=;
        b=MWFum7xTOueXqsd1BLAS5FS/utN8enQfM9z40gr78ZNtJNmCzYL1Ns0IzAW+6C7CCq
         ibOiQvk5X4nYmu9+oWgJ3oZrg3BjNaeDMBDbK6kcUC/UJWvLinLZ513wgmVPoF+cpwzD
         TBq7Kk3EWWSePCJSKf7wijoakR4yDlbl5PXvmN6T3ANZTU5gb074CQt4/M4ilzvOSiaa
         fiQ2N+f3JmQekyOAnVbdZlFtgggeVr/sZg7JlV9GPLzmMSXmxZMtvApw3iXzr/M1whxC
         CwuWgp/KPjrOZ/7/aaJYKwvt2bLCDbFBda9rLQ/bIEbXiyMR8g8yW3KymAxTPJSQ0Bjk
         VP5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757001246; x=1757606046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rgDq9K4RutiA3+hQQ/hGnSVwSGPHlJ2FijaFdFtw3Mw=;
        b=YS8S5HJehPRSpZIQBdmuy0Xn/+BYH1MaXjm9M3HEaikjr2Hr5+Bea2fGBjTvApnsbP
         GQqdzQSMH1vcEkAbTaEQK+8cD1xtW1L18Elo+ElfDXMb/L9HH2LA7gL2H/NzCBsljjAB
         8QWTH3xKTKn7kRsMIpY2jSj0CVvuIZlmPfNGDnxj7Xe8/U0n+9Gd+3iKqdyh8fvAGWWo
         icKU1dM0nYkv4YKm9ne+ws/0LSUlVS6jtQWLiAO2MwmYydcXD+Hjyo6YRpOE5zyuzO8O
         qZKvJMlEAJnQkJmM5kB9fMBCdpu8l8k9/ScPRiK7GuQndPN6KSHkqGRfhMSwZSI1/pGv
         8X7A==
X-Forwarded-Encrypted: i=1; AJvYcCUADZIIyYk16S7Xst93nAgstpVvj1RtcHb2Zsn7GxF3NBZf6RKUnceSmb9IjuUCW4y6e/QhK3HgxxrOcDSQzfqJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxHcnUm8hMDIyDbWIAX120E3QUT9IkHNEBx2tXyUyMm8Dy6gYcq
	gY3WhHI03BLGEv8Vwe4HKl9pVmgZ5xG1Qjm2jW7TSrBA/Jr/Ig91cZcUK/2ewPkJwiMtPxVR3Z0
	VhuGu0TrVVRX0PfooTc+2NDYI0D90mbzsltZJM5JM
X-Gm-Gg: ASbGnctYwYnXuOwOBWPr5CHbt++7ThKIOE9U7FJOiW1xle48qr7M0tx7AohHeiWIhtP
	is4mlujTvmHCAQsYKR8aCUsFlb7oiV5rsk5f1K8G42lKouVaReGm5Ih6SwDahs7jNcbhgytOiMa
	x4O9PDM0feQBd4x9xXu08O/NYNOkqHdNYSl/UnJJaRJ6ic8sNJqwf/xa+Vpb67pdQee7Am5LKmC
	aA3E1fP6RQcxnMScDSgiBvelvmbEgP2WO9t+8pjcf7QDwjgRasGqr5Ui98mH4lv6A==
X-Google-Smtp-Source: AGHT+IFn09tZFMUc7Fo4TXop3uOW4hFYWgY+V3qnhieRUGzXAnxOjxJLxOzHpopesCWQqDuc8eiCaAklrshD5N2EaOI=
X-Received: by 2002:a17:903:2450:b0:24b:1741:1a4c with SMTP id
 d9443c01a7336-24ccaab49d7mr3468945ad.0.1757001245354; Thu, 04 Sep 2025
 08:54:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903-james-perf-read-build-id-fix-v1-0-6a694d0a980f@linaro.org>
 <20250903-james-perf-read-build-id-fix-v1-2-6a694d0a980f@linaro.org>
 <CAP-5=fWHGFBaCgiRcj8zVy196OE07F8jnSUbjvsO_HerdqeyTg@mail.gmail.com>
 <70bd9eea-905a-4fa9-8265-f84ab9894b12@linaro.org> <2b958dec-7ba9-41a3-b11b-43b5e8418849@codeweavers.com>
 <549d3812-a606-4981-83f5-0a99b0ff9f6a@linaro.org>
In-Reply-To: <549d3812-a606-4981-83f5-0a99b0ff9f6a@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 4 Sep 2025 08:53:54 -0700
X-Gm-Features: Ac12FXzHwKy2t84CiPZNRVWOAvpknEgxnXzuzVKZ0Zr3bUGonJJspm9wVw5gIqg
Message-ID: <CAP-5=fXKthsZe3J4_UHHGwDafBq7pHzM18Mh=_2QrnSfCT3nOg@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf symbols: Fix HAVE_LIBBFD_BUILDID_SUPPORT build
To: James Clark <james.clark@linaro.org>
Cc: =?UTF-8?B?UsOpbWkgQmVybm9u?= <rbernon@codeweavers.com>, 
	Sam James <sam@gentoo.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 7:18=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
>
>
>
> On 04/09/2025 9:27 am, R=C3=A9mi Bernon wrote:
> > Hi!
> >
> > On 9/4/25 10:13, James Clark wrote:
> >>
> >>
> >> On 03/09/2025 5:07 pm, Ian Rogers wrote:
> >>> On Wed, Sep 3, 2025 at 8:15=E2=80=AFAM James Clark <james.clark@linar=
o.org>
> >>> wrote:
> >>>>
> >>>> read_build_id() now has a blocking argument, but libbfd uses fopen()
> >>>> internally which doesn't support O_NONBLOCK. Fix the build by adding
> >>>> the
> >>>> argument and ignoring it:
> >>>>
> >>>>    util/symbol-elf.c:964:8: error: too many arguments to function
> >>>> =E2=80=98read_build_id=E2=80=99
> >>>>      964 |  err =3D read_build_id(filename, bid, block);
> >>>>
> >>>> Fixes: 2c369d91d093 ("perf symbol: Add blocking argument to
> >>>> filename__read_build_id")
> >>>> Signed-off-by: James Clark <james.clark@linaro.org>
> >>>
> >>> Libbfd should go away:
> >>> https://lore.kernel.org/lkml/20250823003216.733941-14-
> >>> irogers@google.com/
> >>> but I can imagine that currently this is hit in a build test - sorry
> >>> for missing that and thanks for the fix!
> >>>
> >>
> >> Yeah just one of the build tests, I'm not actually using it.
> >>
> >> Remi are you still using this? To be fair the addition for PE support
> >> is fairly recent and even includes a binary for testing it so I'm not
> >> sure if we should be so quick to remove it.
> >>
> > Yes, I'm still using it occasionally, and I think it's generally useful
> > for Wine profiling purposes and I would rather prefer that it's not
> > removed.
> >
> > I know it's not built by default because of license conflicts. I didn't
> > realize that was an issue when contributing the changes, and it is quit=
e
> > unfortunate (and silly IMO).
> >
> > Then I'm not particularly attached to libbfd and any other option that
> > would let perf read PE files would be alright, as long as PE support is
> > kept.
> >
> > Cheers,
>
> It looks like libLLVM might work. Looking at the doxygen there are vague
> references to PE binaries around the getBuildID() function. But as
> mentioned in the linked thread, it's huge at 100+ MB.
>
> WRT that thread, I think maybe re-writing some of this in Perf wouldn't
> be so bad. Surely getting the buildID is trivial. For PE binaries it's
> hard to tell what's supported currently, what's being used and what's
> being done by what library or tool. addr2line, libbfd, symbols,
> disassembly etc.

I know some people who work on LLVM for Windows for the sake of having
a Chrome build from Linux. It should be possible to migrate the libbfd
use cases to LLVM. If I remember John Levine's Linkers and Loaders
book correctly (contents available by way of your favorite search
engine) everything is just a variant of COFF anyway.

It is a shame that the PE testing in buildid.sh (and the testing in
general) is requiring `cc` as it'd be much nicer to have the tests in
a form similar to the perf test workloads (e.g. perf test -w noploop).
I don't have a good idea on how to fix this but just wanted to note
it.

I'll write a non-blocking patch for read_build_id with libbfd that
matches what the others do and should avoid the hang in the meantime.

Thanks,
Ian
