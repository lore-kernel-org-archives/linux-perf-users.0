Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602097866F
	for <linux-perf-users@vger.kernel.org>; Wed, 31 Jan 2024 13:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706709111; cv=none; b=A3ciwgfneuP1NkSlw2iKPDVDxVitn4Js6d8T4UXak8qfn860sM/SzpZgwfcRJik7bGZ2kbW/l8HPuarK8u+QpVRxhTogaCeKF9Uo+g22/CWNNOEJrP63ZRF1mDMwatgaii5/WpXbWMscqTgT7nx3/X7m1Q3FonAbhoZaZ0erZ2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706709111; c=relaxed/simple;
	bh=fyn7CNrrVrpYyrM58B+ntXebk8wUTe3fdYprQRco57w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=T2fACS14H98Ku/dr30Ylvc21N6S+Z/N2Hpi31pDFJMtAnttP5CZxw4+2SALV7nQt0EKN10claFupz/V6nMzmnsZ+ybDvaFHdGYKd6vCh0CAAeJqy8JbMfF7H2N+Fl4yoL7nOqWNpj8raw598M4lAASaaSxODNilKgIXlycfS1OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LVNj2Nr6; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LVNj2Nr6"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-36394219fbfso141275ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Jan 2024 05:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706709107; x=1707313907; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qp92m4+7j1oe526U6TZ1do3LliICAajgI9vCOPFkmF0=;
        b=LVNj2Nr6xDNiGEKjMbxMD3UBG8y8693Dl7x8vddOiBWwVoHRaufFXh59Exy3JCu2Wb
         SdrG4/5109P/Me7ug+ZOrleUu17dgYY6sfbGPf7rWGR8+w5pIF5ds+VecaS4qc662Cd5
         YIN9NE13v9rhcAC//SAqO9EHdmdrrp/cwX4VER0ius6ykdU4t5hQUnDNcQVIHpOGRgQm
         aZvU8JqagTcXAFm7aLpZAY9ofytkarq3JrL1h4kmfYZO9jML7S31xYSe2n+dj6IvSuab
         h3w/6Yw6QVuptWTsSwz+SAhRvkuS7DOd0LTiPmIPppz+6Mtfzn4PQprDXuF+our48xnq
         jD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706709107; x=1707313907;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qp92m4+7j1oe526U6TZ1do3LliICAajgI9vCOPFkmF0=;
        b=Llowj3rHWMNk/cZxKvNOypf9SkkDXxQ94OPMxgGjc1lgB7evSLKVcU29uYrgxKLRxo
         4J+LON3l3zEeKpSP62AlP1yWPYGaajQtn5q5rGvSmt0f4uj0q+cvMXgsx7QV+dca6Ljf
         Tdf6CGn4Gw8BCDl6EaDPwVh7ovHMekcJ+qoN6fETlnB2ljuv8ESHwprQzaZxAHZo0Dvl
         P97y5BgQgDvmQrfcWayihFoN9dKVZYMWwRhSHklA+I9qTgMYJ2Yu/0RlGubLb5ujHA7p
         usV7LYO+oi6jsOiMX1H0SubmrnSE47xgPnkhB3Tao0AffmcIaO99t1PGld+GaMG+BuOg
         6TDw==
X-Gm-Message-State: AOJu0Yylk369OXEZwb+06/6PuBz+fGG8kA3aEaOWS5Ila3MqW3Iju4V3
	ZFZaPajZjB82FwwN3HTYO/7TpxbDLFdXo4UMMWx1sphOf6scdeagrnxlttYU7FrsL/huhM3g53I
	SHoJcMUDhHE8sBNhgqAMzauMMwTp0rFu3Z+yp
X-Google-Smtp-Source: AGHT+IFz910e95ewtwhhYN+Tk20AQOgrnpskxCJV00zrcITe64YiZIZkOE0LSPtKjShspk5+kSPGqENdP6DEEZRg6mk=
X-Received: by 2002:a05:6e02:e0b:b0:363:8007:d7dd with SMTP id
 a11-20020a056e020e0b00b003638007d7ddmr468225ilk.3.1706709107325; Wed, 31 Jan
 2024 05:51:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131134940.593788-1-irogers@google.com>
In-Reply-To: <20240131134940.593788-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 31 Jan 2024 05:51:36 -0800
Message-ID: <CAP-5=fVf6A2dxLpFKo4S5A7KUtVqBsBH0u1P29ksf1TjYZvhaQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] perf tsc: Add missing newlines to debug statements
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tchen168@asu.edu, Michael Petlan <mpetlan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 5:49=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> It is assumed that debug statements always print a newline, fix two
> missing ones.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Sorry forgot to add:
Reviewed-by: James Clark <james.clark@arm.com>
To this one.

Thanks,
Ian

> ---
> This patch was inspired by bad debug output in:
> https://lore.kernel.org/linux-perf-users/CAGjhMsg_bVKJ_zfsLUR32+oZwGDr3Oi=
BHV_BJ3QtFjyKAs7Sgg@mail.gmail.com/
> ---
>  tools/perf/arch/x86/util/tsc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/arch/x86/util/tsc.c b/tools/perf/arch/x86/util/ts=
c.c
> index 9b99f48b923c..e2d6cfe21057 100644
> --- a/tools/perf/arch/x86/util/tsc.c
> +++ b/tools/perf/arch/x86/util/tsc.c
> @@ -33,7 +33,7 @@ static double cpuinfo_tsc_freq(void)
>
>         cpuinfo =3D fopen("/proc/cpuinfo", "r");
>         if (!cpuinfo) {
> -               pr_err("Failed to read /proc/cpuinfo for TSC frequency");
> +               pr_err("Failed to read /proc/cpuinfo for TSC frequency\n"=
);
>                 return NAN;
>         }
>         while (getline(&line, &len, cpuinfo) > 0) {
> @@ -48,7 +48,7 @@ static double cpuinfo_tsc_freq(void)
>         }
>  out:
>         if (fpclassify(result) =3D=3D FP_ZERO)
> -               pr_err("Failed to find TSC frequency in /proc/cpuinfo");
> +               pr_err("Failed to find TSC frequency in /proc/cpuinfo\n")=
;
>
>         free(line);
>         fclose(cpuinfo);
> --
> 2.43.0.429.g432eaa2c6b-goog
>
