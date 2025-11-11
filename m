Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6235A27EFEF
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 18:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762886180; cv=none; b=Hk5i7Xx8fbXRJqUXL9HBh9Clzz3kbujjMXS1By2fGRzSi39vYuyEp8pGZOKkjuFNE7O4c/359AzZiiytu45wLv4PoCNt6XAaS55s1gEeMrV4BlI0SN48qLSdvPYwM6b0bjTH4JZVQJzVq7bembwLuax0Olrv845H46RjQIjtG5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762886180; c=relaxed/simple;
	bh=1pBvUNJMalSWx8tG7uNlB8Qsp606sbxH7cQgaKu+NdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BpN4pkvBGW7xGZ30YwBZp/v3Vy822V1sRLuTVu9zfkD/vO69tfjxZmgxp7iHOm5BuIqyh39d2ghSmn0Uq8i9UTRcVoqG7H+gECUTkXQR9Tx/wOzFyaRxo3H8avXfYYVTvurFMpgLvMZClwOY67hY/A4ebxxuqVUd7XDfZfplc8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=USjugteI; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="USjugteI"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2959197b68eso12555ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 10:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762886179; x=1763490979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYswEPzRlK+mthA04wWtQO8wabtLWYDKjZICxBjkS8U=;
        b=USjugteIlsFFClvnJbEZF8GmkKElOXH/6yE8JwebydVXKPazYTi3fGOD2pYjP7Iayv
         JsO6BlgZrAJZTJFjvRy4o7PU9VdXLx837cIHUJ+jDPY3QGbaAvzDjiYegWQrL0kSEzyw
         MDUU+HWWhg3o7fkL0sAlCf00fwKQxSRvCl2kx48SUcoU2uSs9iaVx1oCrAm7gK8rlyz8
         d/F34AJTqLZ9EfU2UveLw6P8B3a3tbz/MuoIZ6l9jeRDdUnDy/6wUWg5aKjYATMb0H+I
         LuM8mWGL+pO6oYiMvLBevRBJxyzHaDljpKP7LAFjH5NZl5/t6hx1EFWBiXY98ggFE56s
         Ltmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762886179; x=1763490979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PYswEPzRlK+mthA04wWtQO8wabtLWYDKjZICxBjkS8U=;
        b=TDzsTD52QNmVVZ+JEgSbSqPfRDSuEhrWpBujIOeSWF37nIMo+Vp9Lc4W1HmfvPldeX
         KIG2aziV7WbeqTMjOMty5e+jqiB7Q7ygzfo8KVWPz3Um1XOPf53QT1zSh2r0U6oUb2UT
         HJ1ZfoZqWpe0BmHWRS73fHTnNeZNlO8HYGkOOo8u758biZs9xYHncUh6e0eBXib2XW43
         emd96b/h3XQmL9fnMjx0xLkyg7UAfgUKCVqbLfTra5dAQ7EDa9GIUYr0wUYICOZT4VhN
         WLf7Q7cCu4gY+IJobcrZOKdF7fh6PyrrkZ2xFreYKEFXAKXQVihLQF/1X7d6+HDH4pD6
         Xmgw==
X-Forwarded-Encrypted: i=1; AJvYcCXA0Ct6iV8wgtjxCtYWh+Ef/cwlkbX6JVMsZToZ57PEdf2seUQqfX/821+Uz7meVhrxehe2/KcTW/Y0kMadMMQc@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnblb0wRhrbqMjPDOv3k5TKCeZWv82NFW1Ul5WQMk4Z//WtQC5
	L6rYhp0iMGVEloKxULTLvqV53Y3q+3SUxFodDt/fhirwWCQnH4kvgi490DfErkovfFcnn1GAnS3
	Y6EmkNj4AODXcyBU1Cc9jZaqUkVaRDE4OSZa2Fnp0
X-Gm-Gg: ASbGncvA0cpMho8qax5zOmYOhs24MiZhdSnToJOA0FHMv2fkmpaVlzLt10cFRAumhhO
	9gdRG8+0AadF0N/jNvhVOGIUT2j5aV6daZMI1OWgYObuPCtb/oRLS96gEbGdCqtO0lBHG+0huZp
	lHhtckBOgKf1SA/4BNqSXJ1rZVu6/a6AGhkldq+iVT4F7qh/eThTm83Gk8ISZIwToPZpTCTiGNR
	WbmlAUBISZ8QUOcbATSbinOgZVjV7krYcsAjdGLtK+rRf8H8WmaxzGCpDvqWfAzUU88Wj+/HOd4
	diJD12XsQhvY3TsYvDTZOy+WdQ==
X-Google-Smtp-Source: AGHT+IE9BeTE35laGTdRmTn3te8Hb2F8tasmp7+CYxRqo9ta4KZit/BcUZa0e4dYpT+XU1sD7lEfxFQhKg04tGEuUls=
X-Received: by 2002:a17:902:d2c1:b0:294:d42c:ca0f with SMTP id
 d9443c01a7336-2984f7a74f1mr299025ad.2.1762886178314; Tue, 11 Nov 2025
 10:36:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111075944.2328021-1-namhyung@kernel.org>
In-Reply-To: <20251111075944.2328021-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 11 Nov 2025 10:36:06 -0800
X-Gm-Features: AWmQ_bkL8bvdtE6EATLhXQExRW-2Q0l_3acxh8Ac-qF6d7y_2VzNr8x5gTajQEo
Message-ID: <CAP-5=fV6Kt0qeyG=WkFgw4EGjfxyEN5HwS_KunC3VW7QeGn7OA@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Fix missing feature check for inherit + SAMPLE_READ
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	"Chen, Zide" <zide.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 11:59=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> It should also have PERF_SAMPLE_TID to enable inherit and PERF_SAMPLE_REA=
D
> on recent kernels.  Not having _TID makes the feature check wrongly detec=
t
> the inherit and _READ support.
>
> It was reported that the following command failed due to the error in
> the missing feature check on Intel SPR machines.
>
>   $ perf record -e '{cpu/mem-loads-aux/S,cpu/mem-loads,ldlat=3D3/PS}' -- =
ls
>   Error:
>   Failure to open event 'cpu/mem-loads,ldlat=3D3/PS' on PMU 'cpu' which w=
ill be removed.
>   Invalid event (cpu/mem-loads,ldlat=3D3/PS) in per-thread mode, enable s=
ystem wide with '-a'.
>
> Fixes: 3b193a57baf15c468 ("perf tools: Detect missing kernel features pro=
perly")
> Reported-by: "Chen, Zide" <zide.chen@intel.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Perhaps also:
Closes: https://lore.kernel.org/lkml/20251022220802.1335131-1-zide.chen@int=
el.com/

Thanks,
Ian

> ---
>  tools/perf/util/evsel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 67a898cda86ab559..989c56d4a23f74f4 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2474,7 +2474,7 @@ static bool evsel__detect_missing_features(struct e=
vsel *evsel, struct perf_cpu
>         /* Please add new feature detection here. */
>
>         attr.inherit =3D true;
> -       attr.sample_type =3D PERF_SAMPLE_READ;
> +       attr.sample_type =3D PERF_SAMPLE_READ | PERF_SAMPLE_TID;
>         if (has_attr_feature(&attr, /*flags=3D*/0))
>                 goto found;
>         perf_missing_features.inherit_sample_read =3D true;
> --
> 2.51.2.1041.gc1ab5b90ca-goog
>
