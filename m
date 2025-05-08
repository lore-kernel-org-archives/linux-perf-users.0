Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8649B7E792
	for <linux-perf-users@vger.kernel.org>; Thu,  8 May 2025 15:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746717078; cv=none; b=Vi28devrjoYBkeFtzk/wnbIT9uRZYgvbv9GA9G1NjbqxrGl+xed4mZw7cytp9cF2qfLCWWlxJ/Zs1fintpkceMYfo8dKMfSiusTjqklUsP9D+G2VEiJxwpmUgBWv4NLeHqYoB2Auy5807UnrGsyy8Un8tJ/bcKiKW1e/KO1l+rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746717078; c=relaxed/simple;
	bh=Bvl5ba3YwvsEiX7qFzTQrsZHe1T6nf+edYW5UyyKea4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I4iEPZ/YElXnDtrjyQdsqHIHRBZ5YvRL2cFaYTLyVuVq5EXbWz2yeQfJyLASj2aYmNuFsvMbrBvvcnI1tYxibFmbupwOi0/Ws3A8bY7f7jW33mQrNADcn+zwUNtXOc8OaJpQKFcguvWpj0+WcYNGSlAUb4b1pkU0TAOdua1NBeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e2T1lxaN; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e2T1lxaN"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3d8c4222fc9so229135ab.0
        for <linux-perf-users@vger.kernel.org>; Thu, 08 May 2025 08:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746717075; x=1747321875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHfS18XLHw1fuH23fouICv2ZdP/LcvdC0OJaySiiGfE=;
        b=e2T1lxaNeCi59Le6g1OQQtPEn6zezlnfCTETfES65jvKNwekNYw7M4sr2911S4AVLd
         MHlyLfwHQhGKiSUjktszG5d95RhYqGM3QQJfje7PEiqk7M4W8RmYu5/2dzwj4u2NYff9
         UbdDNN6A6hllzF4zU7HK7XtrwUngSvX0qcJm85fQOmxPERE0YbKE+g8Kea2bFnG2U9WV
         gIUCufQPfg/aMTsi6SUnhFOPq5usMjNwFG4HONKBCot0WlSK/ikxfjdyfQQ3tyD5fFCe
         a8+geMNfgqmIiNV5Hh+tO/6kSPE7TmmVSDLnvfcFe8Bjg0heRsWGPY0WXioFxyDf/Xc2
         21Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746717075; x=1747321875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cHfS18XLHw1fuH23fouICv2ZdP/LcvdC0OJaySiiGfE=;
        b=gmjRp5UZqd+1i4kK15LAD5OfP18ySwB9xq4yhwbbePA1COTVKxuVYZQI5WBciLVfaS
         OAacXC65dZyIwXHgnJOJOman8X0FGOS9sPnuHUES9BHcaV308VSbDeH2KWRLfmcAEk8O
         5PdltMsVwfj2+je+Nixy3kUIz+IcfdaZD4CDt6ukTYB/DO/qzbG7wZqSxsoaT6SYsMmw
         cV7+pJJ84PGs+5gTE/uAzw27ISwz0fFiw2lQEXCBt3Av63STn0GId82IOKeNYG/n/WbC
         PpPnI4Aqglggj53E09sBaYt+Rxzy7CHoq2DgR4U7o7BsLBo6qt8T6T24ei+pN/XVydye
         0ygQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdDgZx3ZZXBJWsnQtYoN2oGP4k6t7Xp7MnjhLY9+jDCIIYCMWtZU6iSquRVhEcB+u6IboSNETK2dLCboQD4xg/@vger.kernel.org
X-Gm-Message-State: AOJu0YyXmcPsqgxKuhBQkmmkJn6rYVGBXuHZom6EgjhjrMKb5xoSkjxg
	Yj7vMsut0OgZ9pvU7l3KxswF7VmR/4L87JKEPmXvAeQp4BnVcl1wh9PeEeTyyIVYYZNUwx/BJHe
	sM2udr4E1uW6QwgvyzdOou3YRU8fZ0h23gYxq
X-Gm-Gg: ASbGncsAM2esxgzhoDUR4llLRfphf5oV71LV4pNCI9jdeR5vEoh2bjSUPPItNSySx01
	VMoqQltxCi7dPMMZub1HfEUty6euuRFigpjdQsjk8e+YOWR6Mvrs1E7hcdcCubHjG3wYYUPLO5p
	o1IUYpwcQPflP8jtTTioxzA9BpMeU84Jik7r85RXVdzyc3vd/eHgg=
X-Google-Smtp-Source: AGHT+IFFJVUbQXfgmM72qK+a/tgW1VnOX0I3j7G1qITzcwyR32vYuWtr/9hkpF6ADEctErBKN9iWetyfgg4nZJcpIAo=
X-Received: by 2002:a92:cd8f:0:b0:3d9:6498:ea24 with SMTP id
 e9e14a558f8ab-3da78cdd14amr3932905ab.6.1746717075312; Thu, 08 May 2025
 08:11:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507215939.54399-1-namhyung@kernel.org>
In-Reply-To: <20250507215939.54399-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 8 May 2025 08:11:03 -0700
X-Gm-Features: ATxdqUGIwKyO1AluhVQQEoLGtf3xZKIZYsFgUCWs6YV1c4qBENQQbw397sVgnp8
Message-ID: <CAP-5=fWE=jquq9WqReAu+Mow4r6LPgOOvxEXb-L5vK+UwThjGw@mail.gmail.com>
Subject: Re: [PATCH v2] perf pmu: Use available core PMU for raw events
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 2:59=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> When it finds a matching pmu for a legacy event, it should look for
> core pmus.  The raw events also refers to core events so it should be
> handled similarly.
>
> On x86, PERF_TYPE_RAW should match with the existing cpu PMU.  But on
> ARM, there's no PMU with the matching type so it'll pick the first core
> PMU for it.
>
> Suggested-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/pmus.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index b99292de76693dbb..3bbd26fec78a10e2 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
> @@ -727,14 +727,21 @@ struct perf_pmu *evsel__find_pmu(const struct evsel=
 *evsel)
>         legacy_core_type =3D
>                 evsel->core.attr.type =3D=3D PERF_TYPE_HARDWARE ||
>                 evsel->core.attr.type =3D=3D PERF_TYPE_HW_CACHE;
> -       if (!pmu && legacy_core_type) {
> -               if (perf_pmus__supports_extended_type()) {
> -                       u32 type =3D evsel->core.attr.config >> PERF_PMU_=
TYPE_SHIFT;
> +       if (!pmu && legacy_core_type && perf_pmus__supports_extended_type=
()) {
> +               u32 type =3D evsel->core.attr.config >> PERF_PMU_TYPE_SHI=
FT;
>
> -                       pmu =3D perf_pmus__find_by_type(type);
> -               } else {
> -                       pmu =3D perf_pmus__find_core_pmu();
> -               }
> +               pmu =3D perf_pmus__find_by_type(type);
> +       }
> +       if (!pmu && (legacy_core_type || evsel->core.attr.type =3D=3D PER=
F_TYPE_RAW)) {
> +               /*
> +                * For legacy events, if there was no extended type info =
then
> +                * assume the PMU is the first core PMU.
> +                *
> +                * On architectures like ARM there is no sysfs PMU with t=
ype
> +                * PERF_TYPE_RAW, assume the RAW events are going to be h=
andled
> +                * by the first core PMU.
> +                */
> +               pmu =3D perf_pmus__find_core_pmu();
>         }
>         ((struct evsel *)evsel)->pmu =3D pmu;
>         return pmu;
> --
> 2.49.0.987.g0cc8ee98dc-goog
>
