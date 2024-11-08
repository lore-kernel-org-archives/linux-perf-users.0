Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5391B13C69E;
	Fri,  8 Nov 2024 16:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731082903; cv=none; b=ELUu1Q1+iFhONsdoqqR1jHZTmYQRTZ9EByu2pzBViq1hDerCRQLbYvC2x8lMJep1rhana1rPcXrTfPBfczppEgj939x3KkQEQqO/dsnrUv71pqL19/R6XujPfm0WFPtLBTz7D3FhzX6Bu5Kab9SiIli4ZdFPIycPNyTgEGQsGAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731082903; c=relaxed/simple;
	bh=gA+KisiweHZcsVfVaf2In9pQ6V20Ay2o6O9TgQkzIoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lnvhlvdChftNW90VYki4/r8iDHHRrs+jDv7945y0Z4qmZ0NVAvuilOrbE+CDljerkoT0DafuVtSdMzV50rIY5jCDVHVwtULZ4hkGdSyJrJ/l9m/aABZod5V3BJly6X3DygX9kioP1c2tWzptvig6MnPBaVRWRYBR9qGpWzhJ3a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcyzdvlK; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcyzdvlK"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6ea0b25695dso19855057b3.2;
        Fri, 08 Nov 2024 08:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731082901; x=1731687701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8mizFjjFDshSal/ZVKlqm4wJJC1d6SLtN/SOKwKRps=;
        b=dcyzdvlK7fvzdYAUYrjQWEOeVijzA15lXFhbQoAX5cbAyNLGUVCvfBxJQ3NWOi7Gqf
         M0of9xrT2y8srLer2G9fSxBf5apKh2g9DzUEvFxsKNrJ7y8gYYDzpIdd1CqZYGoiXxE5
         feVisgs1m/Bax3opBNa0bMhzhoXV23UycE82O6n8/UvHgXshTZyq/pUfjfca1tDCo5l4
         7UPoAikhKSot4HhAYTEQbIhQwDe0i/Hc0z3aCPGVhyLmPao8GyMb32YGmwFerzn38oBK
         MpPIHIMPYWmXoRC5cDRtW13WcHClHfRqnIJk6Kmuk4h3yWz9yY9wsljA+KbOk/WxTFL8
         bf5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731082901; x=1731687701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O8mizFjjFDshSal/ZVKlqm4wJJC1d6SLtN/SOKwKRps=;
        b=K1wOv7/ZFQV0JHck+ymMISNfiLVl3qziqkXD7yrJmOpsh7EVroWYfi67/PpaaEd6sG
         5L3CUHFU7V7FG9RJaz3VeCoF7itb8heG6SF//8AG3blsNChFgABvyhQvtDBabbeCz8gu
         dFrC7SYB06riQFOcLSIxSTpC9X/Qfe2VL+ZoVcTvyyLESFYP4NZ9aV2yiaiqG51PfsHw
         al5XUsEO7BtU3uXqHAcdTumAQNboouQNK3lrPDb4MKalnpOl2ia1g+Irq1C8Cf3r3LQD
         q10If2dPxMqEDK6ZUvIdBM/G+gc6wyiMJ8gUO7GZ3DB/jluHatsdOq8NTgbU32Wj7E/g
         T2ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDrOi0b7xSTW7eW9qYrVGqIoEyDz2uJGRbO3BtcjyxibLF/API7R4SlrSz8vNaaP/lpg/5G2vUOJrLjRXXQ8lIJg==@vger.kernel.org, AJvYcCXyljdROjES15AQDns9F4QmgCTDlR0cB0R2Sd+bOxUoXg1vHdlqELKaa8xmWKntHdyuikhsLlfJE+wT+Yc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0DEeHnhJhFU6cPOe/JTf8xca7fVKJZMPGgVw0Y2tgVjZ9TS/2
	rA4YlGBsbX1u4ocfLrKLTcLpf1QSmdkMzCsAtkUrhZvhmGcV+8XJGvM00t3HW/UQpoQXkgAtBFz
	rQOwEZiMj8B2uQm6ddluAjgWccHI=
X-Google-Smtp-Source: AGHT+IF5Qv/CWRBNVEiNL8p8Q/bKbW4idf5F9u0sg7/BQZn4Cui9AESQ2wmf/dlzWbtmlIWd1V+tm9TGwQFdtH8MePk=
X-Received: by 2002:a05:690c:9a88:b0:6ea:85ee:b5e3 with SMTP id
 00721157ae682-6eaddd73a0cmr38795637b3.5.1731082901181; Fri, 08 Nov 2024
 08:21:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107232128.108981-1-benjamin@engflow.com> <20241107232128.108981-2-benjamin@engflow.com>
In-Reply-To: <20241107232128.108981-2-benjamin@engflow.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Fri, 8 Nov 2024 08:21:30 -0800
Message-ID: <CAH0uvojHH-wmbieqgtVyc7pGWQ0gyrzkWdtUkLpSyreub1uk_Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] perf trace: avoid garbage when not printing a
 syscall's arguments
To: Benjamin Peterson <benjamin@engflow.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

This patch solves the garbage output problem I got, and your test can be ru=
n.

Thanks,
Howard

On Thu, Nov 7, 2024 at 3:21=E2=80=AFPM Benjamin Peterson <benjamin@engflow.=
com> wrote:
>
> syscall__scnprintf_args may not place anything in the output buffer
> (e.g., because the arguments are all zero). If that happened in
> trace__fprintf_sys_enter, its fprintf would receive an unitialized
> buffer leading to garbage output.
>
> Fix the problem by passing the (possibly zero) bounds of the argument
> buffer to the output fprintf.
>
> Fixes: a98392bb1e169 ("perf trace: Use beautifiers on syscalls:sys_enter_=
 handlers")
> Signed-off-by: Benjamin Peterson <benjamin@engflow.com>
> ---
>  tools/perf/builtin-trace.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index f6179b13b8b4..28f61d10a2f8 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -2702,6 +2702,7 @@ static int trace__fprintf_sys_enter(struct trace *t=
race, struct evsel *evsel,
>         char msg[1024];
>         void *args, *augmented_args =3D NULL;
>         int augmented_args_size;
> +       size_t printed =3D 0;
>
>         if (sc =3D=3D NULL)
>                 return -1;
> @@ -2717,8 +2718,8 @@ static int trace__fprintf_sys_enter(struct trace *t=
race, struct evsel *evsel,
>
>         args =3D perf_evsel__sc_tp_ptr(evsel, args, sample);
>         augmented_args =3D syscall__augmented_args(sc, sample, &augmented=
_args_size, trace->raw_augmented_syscalls_args_size);
> -       syscall__scnprintf_args(sc, msg, sizeof(msg), args, augmented_arg=
s, augmented_args_size, trace, thread);
> -       fprintf(trace->output, "%s", msg);
> +       printed +=3D syscall__scnprintf_args(sc, msg, sizeof(msg), args, =
augmented_args, augmented_args_size, trace, thread);
> +       fprintf(trace->output, "%.*s", (int)printed, msg);
>         err =3D 0;
>  out_put:
>         thread__put(thread);
> --
> 2.39.5
>
>
