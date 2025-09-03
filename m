Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3493B2E7651
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Sep 2025 16:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756916937; cv=none; b=GDSzVdaSJnxCwDYL5d9ah2FbuEmvvztOviejHHMR2b8lFER+30Tv7TfggrJmxm6spc/lddwXTalngfG9WThnk9W3Lyrb3yZYF9YZEevpBAbpSWyPFNclj99bpl5VhTPMF8LV7zgQIUAhk14JAZHCJKEjXh6XrKXfNj41ISqaAs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756916937; c=relaxed/simple;
	bh=gHqDPrgBowyiL/sR10xX7tCoLg/UtZOXeCKXzFhG97Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5F3QRHZ5BpnY5hONF5J35T5dfSdzaPhl7I9DX7HnJnezBYBFCg3bLDCaiegjk/wTXhHjoVSu0gmySYGuJNUOhB1SaIFby+kC9rCNpPz+jBhI6ylaPc8c8HHysA1PtJiMiUaQaeMV2iulOV8FK2bhS7i8hoPI32pHy/tIhJ+RbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mt827w6v; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mt827w6v"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24b2d018f92so193345ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Sep 2025 09:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756916935; x=1757521735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fkzaQdVLnKFZXbvLfVWTo4jS+1+R+7yKNhtbqs6gLsA=;
        b=Mt827w6vF0i26syQa7LEhglHJKz0of3DkFIlkfTZp9rSgQnrN4HepjSqpDvWO1GEjy
         yDMRJnJ7ghI7IBUnyQgYpvzWNhmXAR1G6210JuNvQ7lzap53HJj+FAaYP2Ibl0sIGZT7
         /wSxQNaxGCumXHeXRlbgpmK0x/K+M9pDLnO9E0fGMAq1WDeLSxqwFwMn9FLTi09AWevM
         XyiDjOG6ZX9LUfj2RqoUxPvenCLYGUzhJptaMD9deuCef7aoQnqmOpG0yr4BDtwl+VKI
         lBGlcdaT9sf0l/Tefy0nB592WtwozVAiEBvHHdhui8EeiDJDjSDoCr7a0C7hgUn+qnUN
         OQjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756916935; x=1757521735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fkzaQdVLnKFZXbvLfVWTo4jS+1+R+7yKNhtbqs6gLsA=;
        b=X7WuzlKs6AUVTEbezuD/HTSEIibsE7IxMaHhJBZU1aQxmKt/OW5YfRz1XD6fisIBoX
         FUAvlq9cCISxjydj2ZVbPnmDmM+RMXesisoTWIRbS2bfc9GL8y3x1QhhWUNJ53A7T6ym
         ip89gOIgKFwhPB0OiKfPHyWW25RbxDJ2Zw5GL0P6Sx0wWvfUIwjQ4TLzHTZ9NlV6P3vx
         Ko5AE2CgoZckORMExfMyRwDncTR3dZ1dTiQziB6ZXl60bsgxa4kl2O6nBrhPz6WVpZlG
         uoNO3oVluHLLi1+9FsA0Tbbe+QlL42395o8+pGHxhJoQcunAtAWzfcoMWok2lXu88pGQ
         NqRA==
X-Forwarded-Encrypted: i=1; AJvYcCXzVNbSkT143hotSl4fLtSBROSyRBctyGvxizJWZ5/2gZxPr6pDg5zskrb6PQ9ynq7gW5zG4FHn0gqVOCHE/aoY@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+YCeenqmSi4a0eDnz8PiqgsD1FaW+P3TlC4PVtafT6JmildUr
	7R1vvUwQhGPdmcrTR5tGdy/lkY7t1+Sn3vZx9o2nghV+KEWPLkYFLL//tOWEJtqi7XfK03zsHR6
	eVB4E3pjrt1MfE1zDF9rKH5x33H0UsKOWDus/egvc
X-Gm-Gg: ASbGnctivv5k0t+r1a36YSv+i5NPfcNuK9D5C2/dGvkwIFXv0ffHEtn0rYVDDFcAp/I
	cZlV4SndXq66Dq7i83W3CgnrB5zWiWvtXvWwjBZwgPwE/569LalMmuAM7KIFcS169Iivp4N+jS4
	XOURg2f7QqvPEfri+sWrWxyTMnBQgclhlPOvJghfiVrPu7pBnCA9f4hXMONmgShMGM3uR3oXxoy
	2v6dW1ZJGsAmerioX00TaoD3qIMVpqNh/SZwQiPy6fO
X-Google-Smtp-Source: AGHT+IFLvogXoWj7bYgIYljO7Kq06b7Mx2huDYeeQfQOxWOFq1fwFiBFqisnFFT1giElvHyfpoFKP1+sUC4j9uhlhrw=
X-Received: by 2002:a17:902:c404:b0:248:f683:e980 with SMTP id
 d9443c01a7336-2493e7bec60mr5863425ad.2.1756916935150; Wed, 03 Sep 2025
 09:28:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903-james-perf-read-build-id-fix-v1-0-6a694d0a980f@linaro.org>
 <20250903-james-perf-read-build-id-fix-v1-1-6a694d0a980f@linaro.org>
In-Reply-To: <20250903-james-perf-read-build-id-fix-v1-1-6a694d0a980f@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 3 Sep 2025 09:28:43 -0700
X-Gm-Features: Ac12FXxbJVOMs9ZoCA7IT5qWj0pUUT4GbYHwevYbRn2uBnh2ATV_lVvROKlpx8Q
Message-ID: <CAP-5=fXVw4zokEM2hUpbBbJyxQmE3YgyEf-umVzsFhw7vaSK9g@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf tests: Fix "PE file support" test build
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 8:15=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
>
> filename__read_build_id() now takes a blocking/non-blocking argument.
> The original behavior of filename__read_build_id() was blocking so add
> block=3Dtrue to fix the build.
>
> Fixes: 2c369d91d093 ("perf symbol: Add blocking argument to filename__rea=
d_build_id")
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks for the fix!
Ian

> ---
>  tools/perf/tests/pe-file-parsing.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/pe-file-parsing.c b/tools/perf/tests/pe-fil=
e-parsing.c
> index 30c7da79e109..8b31d1d05f90 100644
> --- a/tools/perf/tests/pe-file-parsing.c
> +++ b/tools/perf/tests/pe-file-parsing.c
> @@ -37,7 +37,7 @@ static int run_dir(const char *d)
>         size_t idx;
>
>         scnprintf(filename, PATH_MAX, "%s/pe-file.exe", d);
> -       ret =3D filename__read_build_id(filename, &bid);
> +       ret =3D filename__read_build_id(filename, &bid, /*block=3D*/true)=
;
>         TEST_ASSERT_VAL("Failed to read build_id",
>                         ret =3D=3D sizeof(expect_build_id));
>         TEST_ASSERT_VAL("Wrong build_id", !memcmp(bid.data, expect_build_=
id,
> @@ -49,7 +49,7 @@ static int run_dir(const char *d)
>                         !strcmp(debuglink, expect_debuglink));
>
>         scnprintf(debugfile, PATH_MAX, "%s/%s", d, debuglink);
> -       ret =3D filename__read_build_id(debugfile, &bid);
> +       ret =3D filename__read_build_id(debugfile, &bid, /*block=3D*/true=
);
>         TEST_ASSERT_VAL("Failed to read debug file build_id",
>                         ret =3D=3D sizeof(expect_build_id));
>         TEST_ASSERT_VAL("Wrong build_id", !memcmp(bid.data, expect_build_=
id,
>
> --
> 2.34.1
>
