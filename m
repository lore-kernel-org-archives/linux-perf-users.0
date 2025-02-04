Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230E0212F9E
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Feb 2025 17:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738691409; cv=none; b=qAm6g2TyskNKtA5ih0sKNjuRqoSBpwfpiN30duU9m6TDxER9S8YwXAd1caB0/tMZUPl1M0zHy9fdfTgwKX2M4B4ajPI8i54GsYvV+ulMYitU40uwyCbDdPTXtd4y9/22JWhLLORnYfqIYGSy5OwjiHYTUaCJFiJ2dm8ns2NP/fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738691409; c=relaxed/simple;
	bh=e9lXk2KILvMrWAeBCb5anAWINuB4KplwAt5cSr6oTpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KYwtJdd6JAUtyNI1dm/xgcDtXrQlV9rOfHTC2muTcqomz4NmqedhYYhsHriWQLAzo9o92pEWzO6j78YyJaHbcwxfbPeKiQvJ7QRQgqFGPjJof3952d4I/rcfrSfxGWlWFHi4PvIUFetLbBPTSa8vt/WpHAJSn/6twxmf1NO1xFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i/ALBM7K; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i/ALBM7K"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a814c54742so170585ab.1
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Feb 2025 09:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738691407; x=1739296207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXY9WAEJPwalZKXt5PSHz3ksNwPYvzUFx1AjklywXew=;
        b=i/ALBM7K6FhY5d7da18+TZszr6w1j9tEETgzo6fe3gJaR9JdUU2OG+FCHpafCegYaG
         OeAZDIVyn8lkB3VJ63X7atHdodE/xgYHX+ObTZ7PeRdApyMy0sw+lQOuc4FGklMt7yIN
         8SvdEN4B0y7JeQ/fvWGGHqa/kksDcmuZYVIUhGHp3eVML9V4ZAbu/vb5Cq7S2hTQyQSq
         6xWQypeckvs5DYlbo09fFy7D5XZBFy2whgmbXofeKyX+KwTt2VyuA4pFS1V7jaw+TWUc
         O+gkWZVW6ThbNJ21kz2bUUu46NCeZAnI+iGptVHb3HQQWPZxGuLl2LcjfSANcj68aHjz
         bARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738691407; x=1739296207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXY9WAEJPwalZKXt5PSHz3ksNwPYvzUFx1AjklywXew=;
        b=fX2RDNUv9KvEn7Z4I6nYLv9sQwUg/PrwOJqNOqDW12lGqUmBTv92eckF98HPgk3iBO
         ODRIvPHmhkw4cs+rtjKpVMlWCx+wL/Mp9gErC6jNZSw66lCGCWJ9WkeDswkYvVLVXOUB
         mzpLMDqmL8glr+cXPRkLqVipRe9F4qv9eUVMbU/pZBwvpanSRRYbdxL+LqYNh4Xzguz0
         y6D1SBV02YZqwiTH31S6i2NVkqyT12vPj47QHg0AcmLE3SjYdcstieRxrULevj9qfH0u
         GFpcx1HE9H8x+Hg8R8BW9EPAaxUF1xzQOHfbKivacH2oFwawPlKDTxUUbi6VpjsH3FN0
         nQmg==
X-Forwarded-Encrypted: i=1; AJvYcCX8pMtAxKfWYidAiPahkkArx7WQkDisx4I2bVYkyGpdaPyKUyM8VRr9Ac9NAyWRTTXfVAmVQdwbrIKb8PxiFyx8@vger.kernel.org
X-Gm-Message-State: AOJu0YxvwGp7QSA0QXW/F0HtviOPqY+DDyb+OBxvWyskvX76fWBrXJn/
	YM5tY5q0UGYgL9wc22CFIrGcf9dG2w3HfSw62WeNJngcG8H5N4HQBE5r+HQKY4UqPFQyFMJZIrU
	awtHgEZT9POuAwNZ872a2A/Oc4I6aZoxQtZ2K
X-Gm-Gg: ASbGncvdO5gxt8a/mnrJ0kJqV7O/MPQZxyhkDG62lD0udUFbTkOK9v0yYrQfv64Iemg
	yKHM/gC1ua6GN9w2x9JFQhlgjwKU1x2yXi4DKd3J6x86WgjXDWEL5UpBvNnwKYgOjMa6Pq3u/VA
	Pw12IMA7G2CDspkduUz2LrxbI=
X-Google-Smtp-Source: AGHT+IFTRfRedM8Hrqvn//iHW8JZF0D7oHcsYTwMHHSYCjttPyU6Am1/z8FDdTDsPZAay61ZfVic2tlmrAYU86w24no=
X-Received: by 2002:a05:6e02:1985:b0:3a7:c721:57e2 with SMTP id
 e9e14a558f8ab-3d040f65d20mr3285835ab.21.1738691406906; Tue, 04 Feb 2025
 09:50:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025020304-chip-trench-4e56@gregkh> <87pljyyx68.fsf@ubik.fi.intel.com>
 <2025020426-spool-refreeze-2870@gregkh> <d689243f-9b25-40db-98b6-e032a6b27c62@linux.intel.com>
 <2025020408-apron-fled-d29e@gregkh> <6edcf7f8-d496-524e-2250-49284dfb55e4@maine.edu>
 <2025020447-gyration-wireless-f7da@gregkh>
In-Reply-To: <2025020447-gyration-wireless-f7da@gregkh>
From: Ian Rogers <irogers@google.com>
Date: Tue, 4 Feb 2025 09:49:55 -0800
X-Gm-Features: AWEUYZk3nRfzq951X9O4C_tXcKqwof2dziDIaNme5_Y_gVu_IZvGD-ODLAPYLVs
Message-ID: <CAP-5=fWT5J0svFsA-jqvE4P=NnTdrsKPF9x6JHkUEDp-vBd_1w@mail.gmail.com>
Subject: Re: [PATCH] perf/core: move all of the pmu devices into their own location
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephane Eranian <eranian@google.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 9:12=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Feb 04, 2025 at 11:41:38AM -0500, Vince Weaver wrote:
> > On Tue, 4 Feb 2025, Greg Kroah-Hartman wrote:
> >
> > >
> > > It seems that the majority of the perf code IS looking in the correct
> > > place, just mem-events.c seemed wrong.
> >
> > I hate to tell you, but other places in userspace are depending on the
> > current setup.  libpfm4, used by PAPI, is looking directly in /sys/devi=
ces
> > for pmus and will break with the changes you are planning.
>
> Then that too needs to be fixed, sorry.  Again, devices can, and will,
> move around in /sys/devices/ you can never hard-code any paths there.
> Any userspace code must ALWAYS be able to handle that, that's a sysfs
> requirement.
>
> And do you have a link to the source for that code?  Good news is that
> if the code is fixed in userspace, it will work for any kernel (old or
> new).

+Stephane Eranian

I see use of /sys/devices in at least:
https://sourceforge.net/p/perfmon2/libpfm4/ci/master/tree/lib/pfmlib_perf_e=
vent_pmu.c
I imagine it isn't a big job to clean it up.

Thanks,
Ian
