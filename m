Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAEC296BBE
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 03:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004270; cv=none; b=S1ioPEEjpsW1pHKZdWEU/hqWW4FT7zfXkZv6Nif+2hBLilAQemPGrm+891zD+xd5y0+QzvlRn2vEMBcnH1/VXIbnec6swa8Kjwdt2cUsXN3bSDRAxzzoaRHTJ6zwS/WTm8CD4FKbnyuyUwWyXO5dEZxR6Mx9lwGVPu2yeiD74Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004270; c=relaxed/simple;
	bh=w19LmHl9EzPoq+VagsivemZSdZB3oysJfy50JY4ePY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E2losKM0g7m8zJ1Bgpe0R8y4NGG1iHqsPgbEoFEoHRTvs25ZnORA+KltEnjXjzioUGsWg4XC9blPRig0L+pGl7oegDjYPQzY16l8NJdc5BpdqX5D5q0Zt6d3IPl1GDjaYNNUBdYwJuUD9QOwGS8CT3kJTBnj4kZzX0QccrQ3qcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hJP6Dw7o; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hJP6Dw7o"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-297e13bf404so107615ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 19:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004268; x=1763609068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGyRfQ7sxinUKyVvjsR+Vqj6OVZ9Yu2U/bhjn87KrGg=;
        b=hJP6Dw7oqVNrhg1lKL3H5OLVdY1uhO1tC6VnPHqHtPBr4TAW+FrtzCO1T2pUeIKGb+
         Y5DNrJpTAZ1qu4HSOQexkPscc5bYoDMwTAs2UHkhr4tIlXYmJc95X6LN4OPKmCg9/sZb
         VG/VnERPPln2XGhmGgU0nXN3Mk0hA7mY4b3/fFFF+63qNtg/6yskv28tdFYY+Ojv8U6u
         hlws2FiuIiTUT0pOwFD9ByAVHsY0yiKTvfB9H05hGYmdQCSKx/Vlew0leTvM75SL6owb
         eBCoDOURkl0vmCaKiKBIDtXnd4YbMktY/u8K2wumY/X/tsVf1JCTS2h7DRY4kjJCI0Xu
         bm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004268; x=1763609068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jGyRfQ7sxinUKyVvjsR+Vqj6OVZ9Yu2U/bhjn87KrGg=;
        b=O5XFNguvYi2Slc+G69+iN2+pjnlu/jqcOjIw+7O7NF3I3DqYDlR6xdfkGmZaxNtVJt
         tN1xbOH1AeU3OXNSIDyr46+rYngZUK/h/NPdzbQNuEUCdZ5VmF8Bv57hCR1a+RCtvQ97
         TGZYq4shiUYB+3Fo7YrS/NWlm7yfMqZa5EgJuuOZDFYkxO2Edr/vQBB9t/WEcHW/NNTH
         jbNY9gRauWX01jYmuoNT1WXTaZoCptGNpqHK8ULguh3A0GtM23H4896v/xY/dKwzPkbz
         H3k4gqwxmWr8kpc1Ay76ZrCmwFpjVrg8jsZVjCvX7YTzAjMQ03q5DTq8t6DNH5sXPCZX
         ViDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhIy/Sgt4vrrcH2Rf2p2/fHpr+VNpshj9PyvHiQ9JURI7uZjQPSGWnPBFcGhOFE+ccmzpc1+ZVOq+nCt8DwIO0@vger.kernel.org
X-Gm-Message-State: AOJu0YxbnhZXYS5xPa2BYxNIiH+J5U12atF+sFrc+dFhJ5vv6Ua8e9Of
	1gY2+KmMP9i4oxx9Kfjl38Q8bWLLiXqdGvxa16lDgKQmztC4iTJ/vNTSutSl4OL1ytwVNw/mqqe
	fPH7XjZuhcOeGNYmee+p0ZAhA2qtsEEKoqOVf0wU4
X-Gm-Gg: ASbGncvcEvRQTZhhND5ZrzROoMCDZOB5GoK9UrjLon8jw3J7J2sdoGTL2m4i/I7rc1u
	vjRHfGpg1GtRwMAXGyNwyVr8kvTwkPgh0m5Hp++sCzVuWadE2xXVBixoFNhIbPXdIRXB+45ezqU
	hf3yndo6iF+RWKEPQ3mRUhvwGfZGsXGyVdLJcM4k/XVcsRal2rM7ba66y9xMZtnZfYpFEq1YGgy
	4cNZ7X/ZBd6SutnphW0AJgrPj6Hxk7KhAlkBIlwWO0LYjPvVOngdJCJ3xXcj2O56JyWJTyi
X-Google-Smtp-Source: AGHT+IET2jzGv22qFGYzYgBvGvfIe5eJnj7IAX2cABZdqxy9Xi0Ge1lrllrdq2zKbFwAYFKpEx3lgnkNxvYprRHLu0s=
X-Received: by 2002:a17:902:e746:b0:290:be4a:40d2 with SMTP id
 d9443c01a7336-2985c41ca40mr1781765ad.13.1763004267309; Wed, 12 Nov 2025
 19:24:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aRUs5Lp7RM2qx1Gl@x1>
In-Reply-To: <aRUs5Lp7RM2qx1Gl@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 12 Nov 2025 19:24:16 -0800
X-Gm-Features: AWmQ_blvZBbQKrOg0P6KfvzAlgf6prkDH91L0xaddiPExbWTy0XYsLDKlYlOGgU
Message-ID: <CAP-5=fUtdjaGHCQBNGuVfq7AYMsk67m1zhtrAwsbcwPSvDEr3Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf build: Don't fail fast path feature detection
 when binutils-devel is not available
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 4:57=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> tldr; Just FYI, I'm carrying this on the perf tools tree.
>
> This is one more remnant of the BUILD_NONDISTRO series to make building
> with binutils-devel opt-in due to license incompatibility.
>
> In this case just the references at link time were still in place, which
> make building the test-all.bin file fail, which wasn't detected before
> probably because the last test was done with binutils-devel available,
> doh.
>
> Now:
>
>   $ rpm -q binutils-devel
>   package binutils-devel is not installed
>   $ file /tmp/build/perf-tools/feature/test-all.bin
>   /tmp/build/perf-tools/feature/test-all.bin: ELF 64-bit LSB executable, =
x86-64, version 1 (SYSV),
>   dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2,
>   BuildID[sha1]=3D4b5388a346b51f1b993f0b0dbd49f4570769b03c, for GNU/Linux=
 3.2.0, not stripped
>   $
>
> Fixes: 970ae86307718c34 ("perf build: The bfd features are opt-in, stop t=
esting for them by default")
> Cc: Ian Rogers <irogers@google.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Lgtm.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/build/feature/Makefile | 4 ++--
>  tools/perf/Makefile.config   | 5 ++---
>  2 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index 49b0add392b1c11a..95646290cb89cda3 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -107,7 +107,7 @@ all: $(FILES)
>  __BUILD =3D $(CC) $(CFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.c=
,$(@F)) $(LDFLAGS)
>    BUILD =3D $(__BUILD) > $(@:.bin=3D.make.output) 2>&1
>    BUILD_BFD =3D $(BUILD) -DPACKAGE=3D'"perf"' -lbfd -ldl
> -  BUILD_ALL =3D $(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=3D2=
 -ldw -lelf -lnuma -lelf -lslang $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) =
-DPACKAGE=3D'"perf"' -lbfd -ldl -lz -llzma -lzstd
> +  BUILD_ALL =3D $(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=3D2=
 -ldw -lelf -lnuma -lelf -lslang $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) =
-ldl -lz -llzma -lzstd
>
>  __BUILDXX =3D $(CXX) $(CXXFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bi=
n,%.cpp,$(@F)) $(LDFLAGS)
>    BUILDXX =3D $(__BUILDXX) > $(@:.bin=3D.make.output) 2>&1
> @@ -115,7 +115,7 @@ __BUILDXX =3D $(CXX) $(CXXFLAGS) -MD -Wall -Werror -o=
 $@ $(patsubst %.bin,%.cpp,$(
>  ###############################
>
>  $(OUTPUT)test-all.bin:
> -       $(BUILD_ALL) || $(BUILD_ALL) -lopcodes -liberty
> +       $(BUILD_ALL)
>
>  $(OUTPUT)test-hello.bin:
>         $(BUILD)
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 5700516aa84aec2c..2dd5f5a60568d002 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -354,9 +354,6 @@ FEATURE_CHECK_LDFLAGS-libpython :=3D $(PYTHON_EMBED_L=
DOPTS)
>
>  FEATURE_CHECK_LDFLAGS-libaio =3D -lrt
>
> -FEATURE_CHECK_LDFLAGS-disassembler-four-args =3D -lbfd -lopcodes -ldl
> -FEATURE_CHECK_LDFLAGS-disassembler-init-styled =3D -lbfd -lopcodes -ldl
> -
>  CORE_CFLAGS +=3D -fno-omit-frame-pointer
>  CORE_CFLAGS +=3D -Wall
>  CORE_CFLAGS +=3D -Wextra
> @@ -930,6 +927,8 @@ ifdef BUILD_NONDISTRO
>
>    ifeq ($(feature-libbfd), 1)
>      EXTLIBS +=3D -lbfd -lopcodes
> +    FEATURE_CHECK_LDFLAGS-disassembler-four-args =3D -lbfd -lopcodes -ld=
l
> +    FEATURE_CHECK_LDFLAGS-disassembler-init-styled =3D -lbfd -lopcodes -=
ldl
>    else
>      # we are on a system that requires -liberty and (maybe) -lz
>      # to link against -lbfd; test each case individually here
> --
> 2.51.1
>
