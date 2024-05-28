Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EECC39FFB;
	Tue, 28 May 2024 18:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716922606; cv=none; b=umK+E708zGcYMdMwhjJHRx8XBwhaZyUU4mIHGi7G/Nji/L61ukqn2G9o+ODUd8f/OMiNsL+12ivKU1fPO9WBh2dOasEGkEaZETCEm6Y26ZXoOnCqG09Femi6IesX1Sb6KiWZU1seeBAlQ2seO4wtnCvfXbAj1i8vfQmkKD3/Hk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716922606; c=relaxed/simple;
	bh=1GkxxU7eiisDXTv7dlI9z9uvQ2yOMGG0iM5hZFEjUKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BdBBLww4DUHXtajWF+XOnowE62C3aogZxLfQuKsrajylUBfLoJ7BxQd13uUrSdyXkqJAcgMEeePErYY5GqFGqgcMyse8/MbRuGhv3Yd6QtWhSMKCQc9TglMK0PPjKqc4NrS+AAR45Ja8l7Gved74EJd/EUkUOce1UNxtvmJWbEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-68185f92bfdso793896a12.0;
        Tue, 28 May 2024 11:56:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716922604; x=1717527404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tV2y+zzHtC8fi/GAxZbta7nCZzttI/+j3Qu6+XzqVmY=;
        b=Apr3e/BSta3V1tuQKozW1RwIYwbH4niIBhIKwmMd8FOOpi5hkBwvOEdA1GdHqfl081
         eNXTblRdpLE7d/mJA+tId+rU2XLnejmEH5aE0+SQXMxWdUUf9ueXWTAHz7pWeUN4MWRx
         8F99B/FtA0qUK5EcZ6wPJ0Y12OjTXZYQug+xP3itvaQXRTC+/tsyTR1c0PE7KrRGueAY
         HKATzqo+E5pOKqocLzc8i1rcVttqdhV2LJQZrQEEoK+7hO8sy04DHkzcWanhodRi7hr6
         ynFgDEsv7z/JnjAA+zvIgvBJwYCwexaBHIZASk1xehnO3W8r4PAvgJMZPp67nLp6zaU9
         EmvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvEeVL04BCoFXKDHb3yXGawDjU3szlxQ5cCg6hbzUNFMWFCG9oc7jfOSpIFFFuwytl5GIcHuYI9BexfxCvAEAt8wQqAmXKKzhifXirKCAbHsvd4IOZoWa32hQnT5vbiqNIA1oUvsoW3CxfgH02yg==
X-Gm-Message-State: AOJu0Yx7esCeSQrdKNZUM9MqxObtI76pzimjJ2PhPeW5V58cAnInn6Nc
	e2HfQwdt1/5P7QuihW9MhYzC9K8AYGpvuhUh1Mm+EwT1dzA3aHGDSCLGf3HUUZ+/rJfug4IMnfE
	+lx0b+pDlzIYIqcN2i26IWqdk/pA=
X-Google-Smtp-Source: AGHT+IE8tv8M6ZLQILAkH0C67BI/2TkBWI9laCMPaHlE1MnRq9lKpGEUlZAVuwUkhx6Wgc/7o+9AwiyHmCrCamGILZQ=
X-Received: by 2002:a17:90b:30d6:b0:2c0:bc7:63c3 with SMTP id
 98e67ed59e1d1-2c00bc76514mr2606961a91.42.1716922603850; Tue, 28 May 2024
 11:56:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527090300.17864-1-yskelg@gmail.com>
In-Reply-To: <20240527090300.17864-1-yskelg@gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 28 May 2024 11:56:32 -0700
Message-ID: <CAM9d7cjhwO99e0GLKf54V+1g7cdppL3hwjpgB3cdid7YzytkMA@mail.gmail.com>
Subject: Re: [PATCH] perf stat: allocation check when calculating cache
 instance ID
To: yskelg@gmail.com
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Gautham Shenoy <gautham.shenoy@amd.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, skhan@linuxfoundation.org, 
	Austin Kim <austindh.kim@gmail.com>, shjy180909@gmail.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Yunseong,

On Mon, May 27, 2024 at 2:06=E2=80=AFAM <yskelg@gmail.com> wrote:
>
> From: Yunseong Kim <yskelg@gmail.com>
>
> Adds an allocation check for cpu_map before perf_cpu_map__min() accessing

I think perf_cpu_map__min() works well with NULL.

Thanks,
Namhyung

>
> Signed-off-by: Yunseong Kim <yskelg@gmail.com>
> ---
>  tools/perf/builtin-stat.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 35f79b48e8dc..1f238824abb2 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1291,20 +1291,22 @@ static struct option stat_options[] =3D {
>   */
>  static int cpu__get_cache_id_from_map(struct perf_cpu cpu, char *map)
>  {
> -       int id;
> +       int id =3D cpu.cpu;
>         struct perf_cpu_map *cpu_map =3D perf_cpu_map__new(map);
>
> -       /*
> -        * If the map contains no CPU, consider the current CPU to
> -        * be the first online CPU in the cache domain else use the
> -        * first online CPU of the cache domain as the ID.
> -        */
> -       id =3D perf_cpu_map__min(cpu_map).cpu;
> -       if (id =3D=3D -1)
> -               id =3D cpu.cpu;
> +       if (cpu_map) {
> +               /*
> +                * If the map contains no CPU, consider the current CPU t=
o
> +                * be the first online CPU in the cache domain else use t=
he
> +                * first online CPU of the cache domain as the ID.
> +                */
> +               id =3D perf_cpu_map__min(cpu_map).cpu;
> +               if (id =3D=3D -1)
> +                       id =3D cpu.cpu;
>
> -       /* Free the perf_cpu_map used to find the cache ID */
> -       perf_cpu_map__put(cpu_map);
> +               /* Free the perf_cpu_map used to find the cache ID */
> +               perf_cpu_map__put(cpu_map);
> +       }
>
>         return id;
>  }
> --
> 2.34.1
>
