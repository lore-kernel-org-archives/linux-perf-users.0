Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D881B415B
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Jan 2025 23:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738193967; cv=none; b=tc+Jy/8i0QEoMmwSVrwqHWvreIN8MKJ9ZXEsX2vXHY6xLqLkt5AD88upzzi1FdqvTf3zFeKlRk6UQSOHXRBuvJi30z3OWvTd8L9t0Ch0fZM1J65PCB6dsEK0YXq0qSiub84uJ/AhgaLYD5jIH+9PmyJiKwCxEnO6rwUGnIQ8W7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738193967; c=relaxed/simple;
	bh=AkSOBqesdCgmlr//WvbqaUN/Vyb/Qmi9h7fRqvUqHwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cE49P3BDDChCsSH1jPXpQU4YC++TRa8+tPg+B2juMua9Dyc15ENgBCPanOu/Y0Fk8ZHYv0ERKQ71mtZr5iH3N2OYD0Uz/ld+Zi+zgeB0Vq3MYJhjZmM1oAwZQDYabKniM2EOiio3k56mh79YFQoj0B1XEfKSuD9Hzouf4Vjvnmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o+S8btMz; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o+S8btMz"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a7dfcd40fcso20135ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Jan 2025 15:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738193965; x=1738798765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gz0whKbBG5sXEswMf7L/dv0ztGv/l6uXtzaue0oLH3w=;
        b=o+S8btMzgz41qwBIJuZ/0nNm0cbFmKnpoofd7gAnLLow2py2fWfSkm2Mtdjs+KG1a1
         hSNn6lRNmkVVjRbbmZUQu7JcJrO6NV9VlxKlWc9YIUQ4MSfb7nTnHSpJe3uxlZvdDPgC
         5nmsULXm0HAeYh2/wGD4UGVOai0JQt1lwgfnTwLElEi5PdK16CAZXj8cyrZHWV3XBBbC
         EZl8Sv3lmJ7k1n8uPNTKlDDSlR2QuDNKTgprGL5VX2ZHzFQWeuywyU0ez6iOzUM1qM6p
         acEc7GzKuJ36wDqvRPo0jCbJB4seF/oh145P6rkrCgQ7+pDUiebSk1C0lv/LvgvJHf2+
         3PEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738193965; x=1738798765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gz0whKbBG5sXEswMf7L/dv0ztGv/l6uXtzaue0oLH3w=;
        b=BDwLHXZY3KnTDGy+m2baCrpPr0xsbBRH7tHESI0onxWiTf8ExFmgMxOBwwaRxbS6Sk
         so07YiPB+xNYWaUZoAaGbAFZAKKwpk1EKuuaFHeSnCWQSpVY2hpa5jb0tBTM46PB/l5R
         ofYXXXPa2tByQ0MYiBilpxSg2OEFkn8IdaUFLYYntnOff2QshH0iiQNzasOwR3NnTKE4
         k8+S2NkCNze7n8VoGAOx/ck6f6GUsZ86O9W59YAwM2hWDeAOEufiOoprtb+JSlruSnqB
         QVb3uWp0pm40pgFsnQecMONzQWuFLY7LLSk2xqEehDryeX9gQxOjv1hHIbQpLpB0+1sk
         58Ag==
X-Gm-Message-State: AOJu0YyOGsY5JNh4SsgPTtQZfvIFKjYiR47AkfcQV9tmPCVZWeP/UfP0
	X7FPEJF+kF1q6kJ1kYejZxhuHJi3yfIJawMSzTWZ2AqB/enJlzbuzNoCiyH2NFxXfpuHRj6gGJk
	dXJ1weMulyzmA6g0ICO/GXXqgxGVN9USrsjK9
X-Gm-Gg: ASbGncuuVk85i+mWGZ7+JWvK5ilUNCCWEBqvVypS8QD8VwHR2W/em//9l5as+ldYBKm
	qPgll0mnVedYFkH3Yrnu7G4cHR7+Ul2E6qv+CdoZTi+Ui0QtU0a3DDqAhaem16oZ9ji9hwZxanC
	mgAJutq1jl6YH0HKuv/twF5WQ6
X-Google-Smtp-Source: AGHT+IEEi7CKsuJWJUwchtoyuIekBDyDvrAMUfyssJJJ1oReMkk/qGduMnGB9jCYH6g9kldOFkdoyzIivXaqFTZhu5Q=
X-Received: by 2002:a05:6e02:1a02:b0:3ce:3873:48d4 with SMTP id
 e9e14a558f8ab-3d009815b88mr1279785ab.4.1738193964491; Wed, 29 Jan 2025
 15:39:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250129154405.777533-1-james.clark@linaro.org>
In-Reply-To: <20250129154405.777533-1-james.clark@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 29 Jan 2025 15:39:13 -0800
X-Gm-Features: AWEUYZlpJHNjcwYBk2SlqO-JWrSR1iXNStr3ZwGWPzCWTLxaNxIIBB-53FZp-wc
Message-ID: <CAP-5=fUS4P6dFXXQ23pvv8+yP6XDt4YmL+NqnGu-+i1EmjmOkA@mail.gmail.com>
Subject: Re: [PATCH] perf: Always feature test reallocarray
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, Ali Utku Selen <ali.utku.selen@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2025 at 7:44=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> This is also used in util/comm.c now, so instead of selectively doing
> the feature test, always do it. If it's ever used anywhere else it's
> less likely to cause another build failure.
>
> This doesn't remove the need to manually include libc_compat.h, and
> missing that will still cause an error for glibc < 2.26. There isn't a
> way to fix that without poisoning reallocarray like libbpf did, but that
> has other downsides like making memory debugging tools less useful. So
> for Perf keep it like this and we'll have to fix up any missed includes.
>
> Fixes the following build error:
>
>   util/comm.c:152:31: error: implicit declaration of function
>                       'reallocarray' [-Wimplicit-function-declaration]
>   152 |                         tmp =3D reallocarray(comm_strs->strs,
>       |                               ^~~~~~~~~~~~
>
> Fixes: 13ca628716c6 ("perf comm: Add reference count checking to 'struct =
comm_str'")
> Reported-by: Ali Utku Selen <ali.utku.selen@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/Makefile.config | 10 ++++------
>  tools/perf/util/comm.c     |  2 ++
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index a148ca9efca9..ed3ba13f1018 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -497,13 +497,14 @@ ifeq ($(feature-setns), 1)
>    $(call detected,CONFIG_SETNS)
>  endif
>
> +ifeq ($(feature-reallocarray), 0)
> +      CFLAGS +=3D -DCOMPAT_NEED_REALLOCARRAY
> +endif
> +
>  ifdef CORESIGHT
>    $(call feature_check,libopencsd)
>    ifeq ($(feature-libopencsd), 1)
>      CFLAGS +=3D -DHAVE_CSTRACE_SUPPORT $(LIBOPENCSD_CFLAGS)
> -    ifeq ($(feature-reallocarray), 0)
> -      CFLAGS +=3D -DCOMPAT_NEED_REALLOCARRAY
> -    endif
>      LDFLAGS +=3D $(LIBOPENCSD_LDFLAGS)
>      EXTLIBS +=3D $(OPENCSDLIBS)
>      $(call detected,CONFIG_LIBOPENCSD)
> @@ -1103,9 +1104,6 @@ ifndef NO_AUXTRACE
>    ifndef NO_AUXTRACE
>      $(call detected,CONFIG_AUXTRACE)
>      CFLAGS +=3D -DHAVE_AUXTRACE_SUPPORT
> -    ifeq ($(feature-reallocarray), 0)
> -      CFLAGS +=3D -DCOMPAT_NEED_REALLOCARRAY
> -    endif
>    endif
>  endif
>
> diff --git a/tools/perf/util/comm.c b/tools/perf/util/comm.c
> index 49b79cf0c5cc..8aa456d7c2cd 100644
> --- a/tools/perf/util/comm.c
> +++ b/tools/perf/util/comm.c
> @@ -5,6 +5,8 @@
>  #include <internal/rc_check.h>
>  #include <linux/refcount.h>
>  #include <linux/zalloc.h>
> +#include <tools/libc_compat.h> // reallocarray
> +
>  #include "rwsem.h"
>
>  DECLARE_RC_STRUCT(comm_str) {
> --
> 2.34.1
>
