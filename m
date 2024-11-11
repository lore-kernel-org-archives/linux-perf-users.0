Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B6619F113
	for <linux-perf-users@vger.kernel.org>; Mon, 11 Nov 2024 17:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731347759; cv=none; b=mT0pzX/LyxfR24RnhuAkxm1cihfUMteliuke4W3TVvVNuL1YgigAfEGJ5fvkjwJPBlRQQ8INAGqih8hxUxlsAWTZ+0dCbodULzTReo0bVQXmoo647j8Pb/V6nWVOouJyWlTHlskUIrsKvnOtOVcAxTWbSNkMOBLE9SLkAmsI1is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731347759; c=relaxed/simple;
	bh=Gk3Bd65cbPXkb67tabSPVYvDafMdc4UaLcN1JZUm3MY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GpNnAjyOZMw6MSAkMBnfhwnfbOAtzwLlcnJpwD3dXjvWBusZdxzaWJjwofPp9S2PnBy992K19T3VD5XHITj0PABxi5onBwtevb0d5lmgoTPsol++fDnZM83i2X97eu1gtrFolL/eRXvvjt9zx02Bt6n512RgmmaHf6tJN3sVxKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ABfWiFW4; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ABfWiFW4"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a4e4776f79so3515ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Nov 2024 09:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731347758; x=1731952558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hWCEpVzPP2C567p2YX+zooGp6OPXofG6vmEFnRTKNhU=;
        b=ABfWiFW4gYDdLyXDhWJfnQF3j0Tnfg9+xjmYm3e1p3ip5lQHh7km/3r77EynbDIyYT
         LgJDMJQZ6tkWXFTNRtZ9JlylGESTW5idOB9L1Gi+K09P0I39+1k+MPQ//QI9rSKGns12
         2i8tAGyPv4xRYPRs0MjaM2Ho+hgfgxUPtHtOEFuepffZE2LK+7i7Tozi+DEMkFu6nasG
         A6F6oPBybmBtbPkEnioppQewtouc8C+OnnuGAwLxowj0IFZXK9sWpSMg5WWfmiwwet3n
         1Dg8dHS9SdEtm1rGnzZ5nUF741bsJXLzupE1XC965Pcmiztf0i8QMWh7UQ2vtGO/Bor1
         0vLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731347758; x=1731952558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hWCEpVzPP2C567p2YX+zooGp6OPXofG6vmEFnRTKNhU=;
        b=hoWnOBLtu0r55ZSBGvQIQxrH8YB25HbypWr8CYZxdCVlidTXifIh9uY7rfDKlROJzN
         FVIFAI/Q9MTrM1mHD2Q29DBfNTVLE2/C9Ggb9r3HS7cHXLTXdRTJAZGF2u1reSh3Fl8a
         kipBGVqSbcYIrSLquogz8sWGPkMti3fWtPDJlJqmPO5X/5bFgMLu7RxIzHUafE1aKeIC
         IQR9rofq7Q9jFkOU7YolcUnydwvjUITBHhPLiGACGUhXVcsI9TcCQd2cCgTvlyvMfHul
         xQS9DVxCdV7cQOa8DZkhQQCUkFi2I6QnyYdRiQ7MOuqVJG8hyaz6Pje0JbFf7sBsNGl7
         bPLg==
X-Forwarded-Encrypted: i=1; AJvYcCWrxvanVZKE0MzB7EfE+K5rdOPiTYi2gy+stHH4Qp43foPOdpWrGHnAmI/VDMtOYrPhQaiFLTT0+r+1kxhvqby+@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9hPgEEEg27YsnmKbh7Otv+XHjea0nopswJYQ4SD429gvQ+HDk
	5TCaL11MBSDr2vJLcI7acPNLED133A0eruhsNDLOdenfHPVL+nlUfjR/QsQJ5sGW0KmsnMN8AEK
	KyKibBGv4Yd6zgrZibEKANjZ9yrBXcFeon8ER
X-Gm-Gg: ASbGncu1xK41gCvfXpbTL3qeznvcZKnhY9ezy9g5H//nYgVjMDZYFHewZxBcXRq9LgU
	Gtvh9hWIT7M65bWK7Drvwa1kbaTIACwELJNxSFflHHDTuHOn6gGGdSTzh+ygNAnE=
X-Google-Smtp-Source: AGHT+IFhSYq0STb5lF6oh/lN0IEV8ozrjpzp1B9XixwyORRQYQpKjw+W9mCRekpu31DkLDY6hY5cBsmbP4Hr0C2pjdg=
X-Received: by 2002:a05:6e02:1605:b0:3a6:b0a3:540b with SMTP id
 e9e14a558f8ab-3a6f8a97e8fmr7613755ab.20.1731347757481; Mon, 11 Nov 2024
 09:55:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108204137.2444151-1-howardchu95@gmail.com> <20241108204137.2444151-7-howardchu95@gmail.com>
In-Reply-To: <20241108204137.2444151-7-howardchu95@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 11 Nov 2024 09:55:46 -0800
Message-ID: <CAP-5=fU8DC+-bS0E+=8UwNtjch8MUNJOx8TshhjcPD+-NMGKNA@mail.gmail.com>
Subject: Re: [PATCH v7 06/10] perf evsel: Assemble offcpu samples
To: Howard Chu <howardchu95@gmail.com>
Cc: acme@kernel.org, peterz@infradead.org, namhyung@kernel.org, 
	mingo@redhat.com, mark.rutland@arm.com, james.clark@linaro.org, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 12:41=E2=80=AFPM Howard Chu <howardchu95@gmail.com> =
wrote:
>
> Use the data in bpf-output samples, to assemble offcpu samples.
>
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Howard Chu <howardchu95@gmail.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/evsel.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 695f831b463d..20f07597fac1 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2783,6 +2783,35 @@ static inline bool evsel__has_branch_counters(cons=
t struct evsel *evsel)
>         return false;
>  }
>
> +static int __set_offcpu_sample(struct perf_sample *data)
> +{
> +       u64 *array =3D data->raw_data;
> +       u32 max_size =3D data->raw_size, *p32;
> +       const void *endp =3D (void *)array + max_size;
> +
> +       if (array =3D=3D NULL)
> +               return -EFAULT;
> +
> +       OVERFLOW_CHECK_u64(array);
> +       p32 =3D (void *)array++;
> +       data->pid =3D p32[0];
> +       data->tid =3D p32[1];
> +
> +       OVERFLOW_CHECK_u64(array);
> +       data->period =3D *array++;
> +
> +       OVERFLOW_CHECK_u64(array);
> +       data->callchain =3D (struct ip_callchain *)array++;
> +       OVERFLOW_CHECK(array, data->callchain->nr * sizeof(u64), max_size=
);
> +       data->ip =3D data->callchain->ips[1];
> +       array +=3D data->callchain->nr;
> +
> +       OVERFLOW_CHECK_u64(array);
> +       data->cgroup =3D *array;
> +
> +       return 0;
> +}
> +
>  int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>                         struct perf_sample *data)
>  {
> @@ -3134,6 +3163,9 @@ int evsel__parse_sample(struct evsel *evsel, union =
perf_event *event,
>                 array =3D (void *)array + sz;
>         }
>
> +       if (evsel__is_offcpu_event(evsel))
> +               return __set_offcpu_sample(data);
> +
>         return 0;
>  }
>
> --
> 2.43.0
>
