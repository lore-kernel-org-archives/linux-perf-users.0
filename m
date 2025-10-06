Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFC5224AFB
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Oct 2025 17:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759773417; cv=none; b=ZeHpM9I/aNX4th3FJmO7RRdGrY+ArR/VXAhziKJNvBXC9sTa5uC2sVMOC9E7L2l1Cc0k+dASUJHc6In501g1WXEvMGFp9yLd/PpalZrscIhW0ZJnfRXePv4WD7zFAHNTIDFweqoAqPQLBx+dlChqEa8Da6afKorAcydWnoNOmMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759773417; c=relaxed/simple;
	bh=U9ffjV7BL0HXoD5lEUkf+VHuGrAOPXko+Tm91qRV1X0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e81McXhBmOUqhKZCu1+gqfgp1eMjFv8XXBteKEoOWQu1QFRGU04Q4dsd6WM/0fRKe0yursECPgKWdYiLrG3zeB0akiaWs6jHF14vhOLbVNaVJgYbR6ch+0A0KkTuYuC1lEt6gEUib6FPRPlXTWBWM5fc8Ddkq3+pONoVk/l1V4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WSIxygju; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WSIxygju"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-27eeafd4882so30895ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Oct 2025 10:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759773415; x=1760378215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgNIO/Vg03wOgHjezxsvevp0MBXeQPhEmL6wrOMft2c=;
        b=WSIxygju6iIKEtTrD16QZ/mTgPhebjWB3QpDBPi9iOxLjKN03N+ex5zy72LT10lxgx
         hu6HmYK0RaHXx4bWIqjws7eu1UUf9CXtREfv3gZO2f87EzDF/sWoGIu19A2QWl7trJKy
         JyJPq6j9/RraWr2IaH9W6oDwvaP2hl6M2vfJa8b8scZitJxPfa4629rmECxCn7tmnEBy
         q4tfm1kHpAGC0ODe5BME90UfEapXZtbkXGstmRS+alo9/iiyJ//dL2MfNzdC7JPeKmzL
         gqOcylK59mkZfp+OvEeVcV7Djnx7CmVh6RYjvB8Fz5EDDI9kvuW2eWoRXnNgs7IpWszA
         L6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759773415; x=1760378215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KgNIO/Vg03wOgHjezxsvevp0MBXeQPhEmL6wrOMft2c=;
        b=vDm0tQ7he7rVRxpPqdF6m9Z56x5mAhCCrAW3zHZR0K0dyB1HIlKsR584jf4Psx4Z1H
         /SzsQVkgCxAgVEbeUYfBuqJ2Gg4MEqoXxYfUwU3OovyhsBVz72QmJxQXK1j6rTNIEJ/k
         ioe/Eq8AaIxwj9AZF6tklFpQudk1iQLKO9kpPqjWbxobPvPhQ4WyLcYNkq+IlxexnryP
         VNbx3UfzRJ4a9n06VPoFd/mg69ZmEtkCPhbV8ZIShlk9XrO+BdGON/+w/5l79yyn/WSr
         rao8v0kprIwsm356QbHuTGNccgYjRbmFOp47Ex9ckB7e20AoE6Jc60OUFWrfJDv7w7j1
         63uA==
X-Forwarded-Encrypted: i=1; AJvYcCXLmEF/cFCajP/56jLeZuf4RP/0Z0bfX1g3+q/R7SKQ1n1xCT1GfXiYRQ5sI2HgO4opX/vrk3w1CT0gL2+NlMGZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxay46VKoZ1nmy7gNhjoXsPXlOn/Ld4GwTtn/GN5joNNl7qHSDT
	ah/CLuIdP3TMTZ+uanl1YRzhHNDeiLGuYe2RsY6bVjTnsbdMxRT/rQvFqHdRyIqgcowH3IsA6U/
	ZcSKgNn8h6pwncnOCwGxySm8elupRQWAhfWO1mGy3
X-Gm-Gg: ASbGncslTodNoDtzJTxQ5vTMXiy/iKvyOhU+S2f6IAZXRE/wZz/By51ITllHFEbD66t
	RyxqviF0kbgyqfnLrGZLyVEoStAd++9dpZ+dEUup+SXsNExAaZ6Ekxp9ObKFmf06eykeGzqGUAT
	71NWV12nwXzrH5m4hmHaaWXqTPm8dZYoM4vzu8kQ+4s9VG4woK3IqrPXgyHTO8x3AV2rk1e5Ltb
	OfBmMlke6iSFqRg5eP7zy+a36gzka65v4OuljI1rlRNq8ANfQ/YpV6zbxxCzfvnsQ2twLn/00Vi
	HMs=
X-Google-Smtp-Source: AGHT+IEc0OvHtFH5e8JUnvIJenLMDF0rFXPhnKj1FxC7gkK5Xn2psBR9dBkn9cD2lkoGGsFgB9c6AUjOaYgzf5qGaJo=
X-Received: by 2002:a17:903:3d07:b0:268:cc5:5e3c with SMTP id
 d9443c01a7336-28eca40ef40mr356805ad.10.1759773414620; Mon, 06 Oct 2025
 10:56:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006-perf_build_android_ndk-v3-0-4305590795b2@arm.com> <20251006-perf_build_android_ndk-v3-4-4305590795b2@arm.com>
In-Reply-To: <20251006-perf_build_android_ndk-v3-4-4305590795b2@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 6 Oct 2025 10:56:43 -0700
X-Gm-Features: AS18NWBYM4S-kQkaLa4kp8LfC_m-pnaoulSPmNbf8CExHNpB0ol_xCKKyPKhVEQ
Message-ID: <CAP-5=fUVs8Dn+kQDgPW08SNC=W5ZQKMFEETjjqkOJ_Mvbv22dw@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] perf build: Disable thread safety analysis for
 perl header
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 9:21=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> When build with perl5, it reports error:
>
>     In file included from /usr/lib/perl5/5.42.0/x86_64-linux-thread-multi=
/CORE/perl.h:7933:
>     /usr/lib/perl5/5.42.0/x86_64-linux-thread-multi/CORE/inline.h:298:5: =
error:
>           mutex 'PL_env_mutex.lock' is not held on every path through
>           here [-Werror,-Wthread-safety-analysis]
>       298 |     ENV_UNLOCK;
>           |     ^
>     /usr/lib/perl5/5.42.0/x86_64-linux-thread-multi/CORE/perl.h:7091:31: =
note:
>           expanded from macro 'ENV_UNLOCK'
>      7091 | #  define ENV_UNLOCK          PERL_REENTRANT_UNLOCK("env"...
>           |                               ^
>     /usr/lib/perl5/5.42.0/x86_64-linux-thread-multi/CORE/perl.h:6465:7: n=
ote:
>           expanded from macro 'PERL_REENTRANT_UNLOCK'
>      6465 |     } STMT_END
>           |       ^
>     /usr/lib/perl5/5.42.0/x86_64-linux-thread-multi/CORE/perl.h:865:28: n=
ote:
>           expanded from macro 'STMT_END'
>       865 | #   define STMT_END     while (0)
>           |                                ^
>
> The error is caused by perl header but not perf code, disable thread
> safety analysis if including the header.
>
> Though GCC does not support the thread safety analysis option, this
> negative warning flag is silently ignored by it.
>
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/perf/scripts/perl/Perf-Trace-Util/Build | 2 +-
>  tools/perf/util/scripting-engines/Build       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/scripts/perl/Perf-Trace-Util/Build b/tools/perf/s=
cripts/perl/Perf-Trace-Util/Build
> index 9b0e5a8b5070f1a1640518fae75557f824ef21ee..01a1a0ed51aefd721b4bc7eba=
728c29a8ffcd551 100644
> --- a/tools/perf/scripts/perl/Perf-Trace-Util/Build
> +++ b/tools/perf/scripts/perl/Perf-Trace-Util/Build
> @@ -2,7 +2,7 @@ perf-util-y +=3D Context.o
>
>  CFLAGS_Context.o +=3D $(PERL_EMBED_CCOPTS) -Wno-redundant-decls -Wno-str=
ict-prototypes -Wno-bad-function-cast -Wno-declaration-after-statement -Wno=
-switch-enum
>  CFLAGS_Context.o +=3D -Wno-unused-parameter -Wno-nested-externs -Wno-und=
ef
> -CFLAGS_Context.o +=3D -Wno-switch-default -Wno-shadow
> +CFLAGS_Context.o +=3D -Wno-switch-default -Wno-shadow -Wno-thread-safety=
-analysis

I wasn't able to reproduce this on Debian with perf-tools-next and:
make -C tools/perf O=3D/tmp/perf DEBUG=3D1 CC=3Dclang CXX=3Dclang++
HOSTCC=3Dclang LIBPERL=3D1 clean all
but my libperl is 5.40. I'm a little concerned that the warning may
cause an unrecognized compiler option warning/error with GCC given
progress on thread-safety-analysis has ended there. Anyway, these
aren't blockers.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>
>  ifeq ($(CC_NO_CLANG), 1)
>    CFLAGS_Context.o +=3D -Wno-unused-command-line-argument
> diff --git a/tools/perf/util/scripting-engines/Build b/tools/perf/util/sc=
ripting-engines/Build
> index 2282fe3772f3bdc35056cb5e66efb3462dc1c2e3..24f087b0cd11b3e06a338c394=
dc2c650bc2c60b1 100644
> --- a/tools/perf/util/scripting-engines/Build
> +++ b/tools/perf/util/scripting-engines/Build
> @@ -3,7 +3,7 @@ ifeq ($(CONFIG_LIBTRACEEVENT),y)
>  endif
>  perf-util-$(CONFIG_LIBPYTHON) +=3D trace-event-python.o
>
> -CFLAGS_trace-event-perl.o +=3D $(PERL_EMBED_CCOPTS) -Wno-redundant-decls=
 -Wno-strict-prototypes -Wno-unused-parameter -Wno-shadow -Wno-nested-exter=
ns -Wno-undef -Wno-switch-default -Wno-bad-function-cast -Wno-declaration-a=
fter-statement -Wno-switch-enum
> +CFLAGS_trace-event-perl.o +=3D $(PERL_EMBED_CCOPTS) -Wno-redundant-decls=
 -Wno-strict-prototypes -Wno-unused-parameter -Wno-shadow -Wno-nested-exter=
ns -Wno-undef -Wno-switch-default -Wno-bad-function-cast -Wno-declaration-a=
fter-statement -Wno-switch-enum -Wno-thread-safety-analysis
>
>  # -Wno-declaration-after-statement: The python headers have mixed code w=
ith declarations (decls after asserts, for instance)
>  CFLAGS_trace-event-python.o +=3D $(PYTHON_EMBED_CCOPTS) -Wno-redundant-d=
ecls -Wno-strict-prototypes -Wno-unused-parameter -Wno-shadow -Wno-deprecat=
ed-declarations -Wno-switch-enum -Wno-declaration-after-statement
>
> --
> 2.34.1
>
