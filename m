Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5673234
	for <linux-perf-users@vger.kernel.org>; Tue, 27 May 2025 21:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748382776; cv=none; b=HghrFB9zbLOZJmtdrm5V8amhcTWfhpzHGLYltKPjtOzIfNhyfAWcSQ5wjkq1LUU2Qvx70SvjENXHLPVCFmGdZaq5YM6I87QLzvMums4Asre23oeiaFshxfIRRSavda2UDW5PCngNqek6gL8A9MsLXujATvAVEiogdiHohxM4sg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748382776; c=relaxed/simple;
	bh=NajqaMwzak2ZVvXTy1LnEbealGJdqp9h9PckD2MrsnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UCAS6z1uZcn8fyvct36iBL5wths3FR08EaxxMy8e3enCdd8svsCQ85Ah7X80RgTrYl2ebqD03VX+vxDm0kBiJmL2xKKlIMdFQlVX+XkHvlDTA1cfOpg+5/qXq3YL9brmeKmrlcrAz/+J3f2tWKIjpPlXI7kNIOxbhMWZnHW4hHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qTu8asSc; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qTu8asSc"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3dc8897f64cso29475ab.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 May 2025 14:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748382774; x=1748987574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nzy/VP72yEkDUxgyVW5whFWNlXXozP4lwanJ50OlT08=;
        b=qTu8asSclUdczT+2ecciVMS/9GtUzWFFG1rTsc+q4bxn8wnLDpQKZ5onrW0MshLnmH
         V6ReJ+bhl0oGM7YgNuW1PxX7W5dkmtTFwlgk1aY31KB8/NqLYMbuINE6o5YqC0SsgkaP
         HBMelfZWhKB7ZIQXULzxe7MciM9xRmEDv/kJ0yjTU1h0FqCtzJyoG3Tte8yrfv96EAUK
         W5/5lYAsySL/xNUzDx4BTU+6Ko5NgPNddpREtDMPt5eXbYTdVzv4TWgiNSgEE3fjUsRp
         hGO+Pi3LU88pQyH3lTHOQ6WoYIA4X7e2o+wco1HAPI6ng7w6xDxJtJ0eR6iPy1+KIhWr
         2l9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748382774; x=1748987574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nzy/VP72yEkDUxgyVW5whFWNlXXozP4lwanJ50OlT08=;
        b=s8QTEvvVmTdkFW7bMJsltqDWqaeMrdG+tRN9zU2XxOi9lxnLeTbbEyIWF/91LmsI9c
         AB+Dxsi7718h9PooAkYxC7G35NACYyBZroPhM+aXryDesuykNhtPjCDHtkbYM2ZHzX3X
         xDtpg6NL4opiK4WHfI/KbFf9CWXmAowD40jghN7mw9/LX2RjVAjwx651ZNDnPdP6N4QT
         qmi2/fDQ6Gw1OgbB2Pg7hpBzCzdP0C1inpArbQ+Avvkl+kNq2NDjpSPNGEMojTjvccKQ
         3hphx0vPovnv6FaQET9MwEf6GNWzAW6DEjRDrLEXEaYOe7i0GBHzcJG5MuAtYvn8jHNm
         eRQA==
X-Forwarded-Encrypted: i=1; AJvYcCWs6o6J43qkobXubSW6Ffqfvn5P80lfLoEnqlRxALKrwuwIZ/LbNwpmrJ0EuWQTyR4Dz2eY2ma/STW66vQ8j6F7@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1wsVJ+HxEdj2povztMyCP9ZwhJc02oWyoyiznfMXzW0q2JRUi
	5LzGhzr9B52TY5xx+Rkra/uSPqc65d0giUKhR0lt2bkcKk+62YVRWIm2pDPSBkkGUV7QnnK52hh
	mR7F1Mxf8yBVIrQbB1o0V2YFgPs7l3LlJCQMyxF6e
X-Gm-Gg: ASbGncuuR5on80onln9Yni0yWycZXm8xXOHzyzQjd91WuSGDtUlZ4hg6h9GVGJ6PzmT
	YSfoxhHQpzDA5Id0qRugOsa2e+vacbIXMA/2CRU2hJWsU7/L5H0ZF23XEtJX48hqCjTopBedLcD
	qTjHiy+kUL+FXGEIwfXR24yViPdndtoLL+PTkJr+8EIojlXrqpnksFtaWPrM2Kz7Q957HtVQ5Z
X-Google-Smtp-Source: AGHT+IF/X/d3ehgRBp3+RuMKNjyxr4o+rJWM+7S6FJZ0zE8aw5lm5Q/+wDtlGaOZJXxw2jrY/SoQ1HqZJ1vSLGyJoeY=
X-Received: by 2002:a05:6e02:2302:b0:3dc:6fb2:dac7 with SMTP id
 e9e14a558f8ab-3dd88f5058amr1391775ab.10.1748382774033; Tue, 27 May 2025
 14:52:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402211301.4153441-1-irogers@google.com> <Z_Af-KAKuOlqALH6@google.com>
 <CAP-5=fUiWm9kq2fhT-9+8LOmC2Yen9Mw2P8yPLTJH+nk83nmmA@mail.gmail.com> <aDYnLedM8RT17FHx@x1>
In-Reply-To: <aDYnLedM8RT17FHx@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 27 May 2025 14:52:42 -0700
X-Gm-Features: AX0GCFsymAJ2MGDqkcBSLY_tqzADwkSXe8XrJLlBH-xRrruWMpTuGsuArIlRpOU
Message-ID: <CAP-5=fWciArAOkiJDhahxvL3S0zWCNHVEK2msPNT58W9otDOqQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf pmu: Avoid segv for missing name/alias_name in wildcarding
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 1:57=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, May 27, 2025 at 01:33:35PM -0700, Ian Rogers wrote:
> > On Fri, Apr 4, 2025 at 11:07=E2=80=AFAM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > > On Wed, Apr 02, 2025 at 02:13:01PM -0700, Ian Rogers wrote:
> > > > The pmu name or alias_name fields may be NULL and should be skipped=
 if
> > > > so. This is done in all loops of perf_pmu___name_match except the
> > > > final wildcard loop which was an oversight.
>
> > > > Fixes: c786468a3585 ("perf pmu: Rename name matching for no suffix =
or wildcard variants")
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
>
> > > Acked-by: Namhyung Kim <namhyung@kernel.org>
>
> > Ping.
>
> =E2=AC=A2 [acme@toolbx perf-tools-next]$ patch -p1 < ./20250402_irogers_p=
erf_pmu_avoid_segv_for_missing_name_alias_name_in_wildcarding.mbx
> patching file tools/perf/util/pmu.c
> Hunk #1 FAILED at 2060.
> 1 out of 1 hunk FAILED -- saving rejects to file tools/perf/util/pmu.c.re=
j
> =E2=AC=A2 [acme@toolbx perf-tools-next]$
>
> =E2=AC=A2 [acme@toolbx perf-tools-next]$ cat tools/perf/util/pmu.c.rej
> --- tools/perf/util/pmu.c
> +++ tools/perf/util/pmu.c
> @@ -2060,7 +2060,9 @@ static bool perf_pmu___name_match(const struct perf=
_pmu *pmu, const char *to_mat
>         }
>         for (size_t i =3D 0; i < ARRAY_SIZE(names); i++) {
>                 const char *name =3D names[i];
> -
> +
> +               if (!name)
> +                       continue;
>                 if (wildcard && perf_pmu__match_wildcard_uncore(name, to_=
match))
>                         return true;
>                 if (!wildcard && perf_pmu__match_ignoring_suffix_uncore(n=
ame, to_match))
> =E2=AC=A2 [acme@toolbx perf-tools-next]$
>
> =E2=AC=A2 [acme@toolbx perf-tools-next]$ git log --oneline -5 tools/perf/=
util/pmu.c
> 754baf426e099fbf perf pmu: Change aliases from list to hashmap
> 255f5b6d060be5a4 perf parse-events: Add "cpu" term to set the CPU an even=
t is recorded on
> fa1332a8011eebe1 perf mem/c2c amd: Add ldlat support
> fc807b6bde6ad332 perf pmu-events: Add retirement latency to JSON events i=
nside of perf
> 58b8b5d142a8bd5c perf cpumap: Increment reference count for online cpumap
> =E2=AC=A2 [acme@toolbx perf-tools-next]$
>
> Can you please take a look?

Done.
https://lore.kernel.org/lkml/20250527215035.187992-1-irogers@google.com/
Not sure what put patch off given the small nature of the change.

Thanks,
Ian

> - Arnaldo
