Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56F47260A
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Oct 2025 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759941128; cv=none; b=cln3an+C1Y9Oo+PwviFB6oinA+2v6PqmjTfVijxmXZfUh99TKTVTeha0Prp+2f2RRzrqjjjQ9oVUsTTCYKi6haKYbeja8HOI/NoXlU1F7s9mdXYSdyu5BNuIjj7r5sQFQM2KKd+guPEjUfK8BYwbE4JnFPzgdOGskFrHaYYveLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759941128; c=relaxed/simple;
	bh=j+KG90QHUq8UmErnUnf4KEjhOcBO2c0iFGFWaJiiMyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W6Ab6Ns+gbpzPLDUhLpd4nwjJX2XTRhdEV35gzs5cFGQcGK6bdP6dlrJgL5GIZjurtnyeuZnPEVahKL4eDexnrHk0nQ7wBY+N2LChq2CAIUyIQDLnOwgzYCfyaaXJe9HM8TFqAVj+NK0p12V9b7dnup2BABYXil17zHzKrYnV1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qEandcT/; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qEandcT/"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27d67abd215so304585ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Oct 2025 09:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759941126; x=1760545926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSuPYLhNBhQbv9PnRs/ehQEpBWk9AgU9ZFIL2VExLKk=;
        b=qEandcT/8s1RsLWIfaFwIeKHjD3g4B7J6zPDTfoxwlScUBdsYENZXjt+/F7gmW2b8f
         /+HdE2/ur+1m9W6EZggpFZOrPhHZ9/+72eH9pNIrAkua9H8O0VoPo0skqWukrO/XIMsN
         ddw+UZtIsO6x4/wibUZShwN8abXhioZNmDdh8aww0nnEPoQfOuyOTR5ddqKlKe2QPiuW
         GJItyWE1kKmeQsRrhUpcU2DN1MwmtC8vXr3pAJ7PW4NmKWYYIJGh56jdxSQDArRoUiok
         3iADFEQtWQahJdPX4BqBGV+tpjwW4EUWW+Qgrlb4caFrWIyc/pxwKu/cXdA+2nJWyXkF
         hBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759941126; x=1760545926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SSuPYLhNBhQbv9PnRs/ehQEpBWk9AgU9ZFIL2VExLKk=;
        b=YTCdj08bNH5LgGhnYhO/YgGcD65nggt/q8ztoqvKEpXpgt6PgIgB81uQ7+zCwOMmD+
         2NgRckBEv7hmcgGyzfqZWeYSHOo+Fnr6d76lK25jB3nL23o+2H6FpZDiJED2suCjj2fd
         /1G720N6bm6Yh5GK9wJRv4a9U8Yg4wuIKEujPyyTgeuiZLrprepWa0SlD3Z1w/kbdBZd
         tJA9gLe5BkPbwhKWeR5EXGDF8E87j1mdC6NCihQ6fQsix+k9kItnVZBYBu9LCY/16ptH
         MTM/STP+guKZr4Ppep8AwW//Tq/1GTXoO7mq/QFPT0Sczol6GilIXdv/MIKiES+VAMsd
         CItA==
X-Forwarded-Encrypted: i=1; AJvYcCWIX7XxHLs+coMLH2hdQEyiopajD4rHqx5yrpq7DWZOEqGRu7uHWPx8OO34MnxxdWUmYe6v9u6zh31ZGHvqUm8q@vger.kernel.org
X-Gm-Message-State: AOJu0YwM/44BHw9mmSKog8sVrhJg6R/mEYWVxf5No6Xwo4Yv8k7mPv65
	eMPP+ZheyZZBQzc/ckIDt+JShvHa4Q0kIxT0cFg/G4SWVxBBkm6I/aF7tiVInw9mNrvpUK3W8vR
	RwBz7tcm6x90OZr5Y2mcR9FGMZPCCj3sCOj2UuXGPityA9jS0NG4KcSjr
X-Gm-Gg: ASbGnctO34a/F1MyfE9EsLVuAoJt2KK00DyuWhRrMYLZMuBvnKFSZlDEnId6TEkgFAD
	83WfiDCHWfhHCzs2yTXMrS6IR8tlXBUiDKIKUyUmGPYxEnvdUXy9tmhtGSoIOC1OVXmx4bdQg9K
	7vQoWcTn8rSdjWA0jCPRLNIxmFoA2ayK0ujQVUgP7YpVmmOPvLNnoJsoUvCwLN6p7ZyD9xKJetB
	gu0F0qyp9W5yfkuFa92mKaEQt3+tMWu+awyCT24ES1RdFdW2fYKbq+GvvNeHII0sssicGo4y5Hv
	aMs=
X-Google-Smtp-Source: AGHT+IHSYUCWVVfawwj76MCuZAt7I2oBJNyK1d6keP/z8TRxeN1VnE76Y6GyeiD+58cgYNsHWxjSRkxeknXwYtcnDuQ=
X-Received: by 2002:a17:902:f545:b0:27e:e96a:4c6 with SMTP id
 d9443c01a7336-290275dda35mr6978595ad.2.1759941125342; Wed, 08 Oct 2025
 09:32:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251005181421.2787960-1-irogers@google.com> <aOYkRdU5pn_jTOq3@google.com>
In-Reply-To: <aOYkRdU5pn_jTOq3@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 8 Oct 2025 09:31:53 -0700
X-Gm-Features: AS18NWCGtV-hp43VXeqvQ4UJu4ENt9gz6g5gTLbFb7BmReBQIdsR0EpEar-QFOQ
Message-ID: <CAP-5=fUqYeaE_P3ApXvq7j9SRuNXpLf+mK-4XBsvv2R=OTccbQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf stat: Additional verbose details for <not
 supported> events
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 1:43=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Sun, Oct 05, 2025 at 11:14:21AM -0700, Ian Rogers wrote:
> > If an event shows as "<not supported>" in perf stat output, in verbose
> > mode add the strerror output to help diagnose the issue.
> >
> > Consider:
> > ```
> > $ perf stat -e cycles,data_read,instructions true
> >
> >  Performance counter stats for 'true':
> >
> >            357,457      cycles:u
> >    <not supported> MiB  data_read:u
> >            156,182      instructions:u                   #    0.44  ins=
n per cycle
> >
> >        0.001250315 seconds time elapsed
> >
> >        0.001283000 seconds user
> >        0.000000000 seconds sys
> > ```
> >
> > To understand why the data_read uncore event failed, with this change:
> > ```
> > $ perf stat -v -e cycles,data_read,instructions true
> > Using CPUID GenuineIntel-6-8D-1
> > cycles -> cpu/cycles/
> > data_read -> uncore_imc_free_running_0/data_read/
> > data_read -> uncore_imc_free_running_1/data_read/
> > instructions -> cpu/instructions/
> > Control descriptor is not initialized
> > Warning:
> > kernel.perf_event_paranoid=3D2, trying to fall back to excluding kernel=
 and hypervisor  samples
> > Warning:
> > kernel.perf_event_paranoid=3D2, trying to fall back to excluding kernel=
 and hypervisor  samples
> > Warning:
> > kernel.perf_event_paranoid=3D2, trying to fall back to excluding kernel=
 and hypervisor  samples
> > Warning:
> > data_read:u event is not supported by the kernel.
> > Invalid event (data_read:u) in per-thread mode, enable system wide with=
 '-a'.
> > Warning:
> > kernel.perf_event_paranoid=3D2, trying to fall back to excluding kernel=
 and hypervisor  samples
> > Warning:
> > data_read:u event is not supported by the kernel.
> > Invalid event (data_read:u) in per-thread mode, enable system wide with=
 '-a'.
> > cycles:u: 351621 362833 362833
> > failed to read counter data_read:u
> > failed to read counter data_read:u
> > instructions:u: 156184 362833 362833
> >
> >  Performance counter stats for 'true':
> >
> >            351,621      cycles:u
> >    <not supported> MiB  data_read:u
> >            156,184      instructions:u                   #    0.44  ins=
n per cycle
> >
> >        0.001584472 seconds time elapsed
> >
> >        0.001811000 seconds user
> >        0.000000000 seconds sys
> > ```
> > where without this change only "data_read:u event is not supported by
> > the kernel." is shown.
>
> I think what you say is:
>
> Before:
>   data_read:u event is not supported by the kernel.
>
> After:
>   data_read:u event is not supported by the kernel.
>   Invalid event (data_read:u) in per-thread mode, enable system wide with=
 '-a'.

I kept things verbose as unfortunately the
"kernel.perf_event_paranoid=3D2" is important as is the use of
per-thread mode. Different paranoia levels lead to different errors
and unfortunately a lot of the time the error gets reported as "
data_read:u event is not supported by the kernel." and I'm not sure
all users will get that the key part there is the :u modifier.
However, fixing  evsel__open_strerror wasn't in scope for this change.

Thanks,
Ian


> Off-topic, it'd be great if we reduce the number of the same warning
> messages.  I think the data_read is from two uncore PMUs so the message
> was repeated.  If we can connect the related evsels and show the
> messages once, then the output is more readable.  Maybe we also want to
> show the fallback message just once (globally).
>
> Thanks,
> Namhyung
>
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-stat.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index 7006f848f87a..84e06ec09cc2 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -624,8 +624,9 @@ static enum counter_recovery stat_handle_error(stru=
ct evsel *counter, int err)
> >        */
> >       if (err =3D=3D EINVAL || err =3D=3D ENOSYS || err =3D=3D ENOENT |=
| err =3D=3D ENXIO) {
> >               if (verbose > 0) {
> > -                     ui__warning("%s event is not supported by the ker=
nel.\n",
> > -                                 evsel__name(counter));
> > +                     evsel__open_strerror(counter, &target, err, msg, =
sizeof(msg));
> > +                     ui__warning("%s event is not supported by the ker=
nel.\n%s\n",
> > +                                 evsel__name(counter), msg);
> >               }
> >               return COUNTER_SKIP;
> >       }
> > @@ -649,10 +650,11 @@ static enum counter_recovery stat_handle_error(st=
ruct evsel *counter, int err)
> >               }
> >       }
> >       if (verbose > 0) {
> > +             evsel__open_strerror(counter, &target, err, msg, sizeof(m=
sg));
> >               ui__warning(err =3D=3D EOPNOTSUPP
> > -                     ? "%s event is not supported by the kernel.\n"
> > -                     : "skipping event %s that kernel failed to open.\=
n",
> > -                     evsel__name(counter));
> > +                     ? "%s event is not supported by the kernel.\n%s\n=
"
> > +                     : "skipping event %s that kernel failed to open.\=
n%s\n",
> > +                     evsel__name(counter), msg);
> >       }
> >       return COUNTER_SKIP;
> >  }
> > --
> > 2.51.0.618.g983fd99d29-goog
> >
