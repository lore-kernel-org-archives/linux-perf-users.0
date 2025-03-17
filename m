Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514CB18C00B
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Mar 2025 16:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742227842; cv=none; b=B4GJz4OKSZTsFB3dfP00P+XS7OJkTiH5/S41m2uQuGeOFp1jQyBpLeY1rwNJZvbjaAfobTsEYfgyHOREOoCKvpHP+poOlk0bNhOqLVWzczdT3yXjZVYUuNWLEhruDI3Ae/U1Z51fquD4KUnwqvQ4gSAYwflRArPe8PoyiSMPEsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742227842; c=relaxed/simple;
	bh=h1HX52WVSfCd/vFf8OXw8LFNOMMTKRgfja2DL2tQ7ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gt0FDaIo3q5yl1ZFSqKin0qLhzSAYWZqNyqksRsLpNwbLNZ4YYHctQpZoTsLNvALNvfUMyJshitN8S07k+WyjoELT+do/7EA42C7vd0FIZnjPTzc5SSd2aEwCLjikLaJFJAbZHib8Ce2ns7G1shTy87F66XHAHbvBs9rViFTUtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4SGblc43; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4SGblc43"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2242aca53efso34285ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Mar 2025 09:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742227840; x=1742832640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DvKgDiFuVPnQfg+ceHEVlgMkuHE4w+BuHOV13uh3LU=;
        b=4SGblc43thxAGEUsTA3KNeyxqD15gzRe4pnDYMza8Wevuc30p0b1u0P86w4Le/+Hnq
         Y6y6aQXa9o8KV8jpbRlHPmy6Om2TQUNLACR7lJajfu6zVZm7FqtRledM/GOVlA9e/Gui
         45jTWI1Uwidt27yf/03gXtjoxgX2MP2E3ioG79OKsZGHq6ZTRGB9iPqtxPzzZ/+SAG93
         s/p4BlaClR/fGKwD2SJsl5ge3HM2MzxCWlvUL6Nu6emSS409K1qRELWVNbbMuhr98/x4
         ZHcVge676rd6qAgomfjTm1J2IidAFDaVcAwAUbozzYqMUPrfVcz9g20mlZNSwMLHdcR6
         ZJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742227840; x=1742832640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1DvKgDiFuVPnQfg+ceHEVlgMkuHE4w+BuHOV13uh3LU=;
        b=C/NmPEEMwRsSbzm8vtRfguZb3xGvsXDqvM1UT13U1m1vWVHaU91Jn4t1cNsJncsDJd
         iM9hT1Kv81eJGcV6ECI8pBuu8HJG8fp96hjHRGduYuCxaB0ubOD9DJ/eiuvh1osGrqiY
         nwckRSEYYxhjTTqskKDSaLLBmY5jorR2c4KgIugZZMLHukn03KaTV/YeqZAihnihQd0V
         hyTxE/SSdJbNQxA7+S0CI/4yxgX1IMcxt3IEz9Ot7JZwimUFw0wE2vPnmGsYMkk8BUxJ
         FQN+c5u1+nxmruKYDWxBmqGOxthWH08wWK/uznPUfz1vDWCiK96wKDUg29GnkYUUtudv
         bC+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV4ISF770NFW05tEzvSc81M3V23L76cZZ/OxyLNmlrlF6h86i/jLh49k/NxyEFkvB4ozYQK9/62STfIurmTqb/1@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj4wkw8I+LILwsHW2BtTqW0peQJX68W1GE0CyIOIOWpXjTE2wW
	gTqwChx9FVmxJ3yhWsF1D42Biq5X+iaJX5TIJHs9QyXFD5YLt0Jj8XnjLmwvyIlE4rp+SFW7GrY
	MC5eUUXll8YmO+eW3jjgoKy5SyslbboQ2b6kf
X-Gm-Gg: ASbGncup0MnxxEU2n97xk19BzUn+zOUJfNuF0JqgYHEFkW/IVB/698ME6GR/gyxyFMo
	wYx9gWQ9B0esw0os2c/afnACWOWMgjZkoHkIg8+f7OBZ7iPU7vjsa240CV5tA2DXTU9qKanfhMd
	HwK6SQfWBHms9HebtAtWsmWyzfngwVdqHoCi8tGoDWtGa1mXCzO6drnsUQaBhD4CkwzA==
X-Google-Smtp-Source: AGHT+IGeAR+kboapMmrI0SfAf9umNYS8qxnTewPO2Hiig9OJgjhMXcEEJe7y4RMtQNgysDaOlB2OxIDqA72esNDwUIU=
X-Received: by 2002:a17:903:41cc:b0:223:37ec:63be with SMTP id
 d9443c01a7336-225f3c14de3mr4520955ad.4.1742227840351; Mon, 17 Mar 2025
 09:10:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z1mzpfAUi8zeiFOp@x1>
In-Reply-To: <Z1mzpfAUi8zeiFOp@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Mar 2025 09:10:29 -0700
X-Gm-Features: AQ5f1JrEeD3OpKfZTGEdcDO24vz4DHfLcO2IC__rF2ZvyedwJ7qT6NXJ2L6tJ3Q
Message-ID: <CAP-5=fWqpcwc021enM8uMChSgCRB+UW_6z7+=pdsQG9msLJsbw@mail.gmail.com>
Subject: Re: [PATCH 1/1 next] tools build: Remove the libunwind feature tests
 from the ones detected when test-all.o builds
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 7:45=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> We have a tools/build/feature/test-all.c that has the most common set of
> features that perf uses and are expected to have its development files
> available when building perf.
>
> When we made libwunwind opt-in we forgot to remove them from the list of
> features that are assumed to be available when test-all.c builds, remove
> them.
>
> Before this patch:
>
>   $ rm -rf /tmp/b ; mkdir /tmp/b ; make -C tools/perf O=3D/tmp/b feature-=
dump ; grep feature-libunwind-aarch64=3D /tmp/b/FEATURE-DUMP
>   feature-libunwind-aarch64=3D1
>   $
>
> Even tho this not being test built and those header files being
> available:
>
>   $ head -5 tools/build/feature/test-libunwind-aarch64.c
>   // SPDX-License-Identifier: GPL-2.0
>   #include <libunwind-aarch64.h>
>   #include <stdlib.h>
>
>   extern int UNW_OBJ(dwarf_search_unwind_table) (unw_addr_space_t as,
>   $
>
> After this patch:
>
>   $ grep feature-libunwind- /tmp/b/FEATURE-DUMP
>   $
>
> Now an audit on what is being enabled when test-all.c builds will be
> performed.
>
> Fixes: 176c9d1e6a06f2fa ("tools features: Don't check for libunwind devel=
 files by default")
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sorry for the delay on this.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/build/Makefile.feature | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index b2884bc23775e986..9cde51104c2d70ec 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -90,13 +90,6 @@ FEATURE_TESTS_EXTRA :=3D                  \
>           libbfd-liberty                 \
>           libbfd-liberty-z               \
>           libopencsd                     \
> -         libunwind-x86                  \
> -         libunwind-x86_64               \
> -         libunwind-arm                  \
> -         libunwind-aarch64              \
> -         libunwind-debug-frame          \
> -         libunwind-debug-frame-arm      \
> -         libunwind-debug-frame-aarch64  \
>           cxx                            \
>           llvm                           \
>           clang                          \
> --
> 2.47.0
>
