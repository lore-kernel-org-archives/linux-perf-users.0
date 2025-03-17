Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC151CFBC
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Mar 2025 16:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742227774; cv=none; b=SMD7FlV2x/MlnMVGsf/gfXAmHMg6IfRsROdn7K7CDTps9n2FQ6Cl8D+txTjSikEyRd9HhI4PmIyxVwFv07M48uYp7gFWDHCYr4O8bXXG7Q6ykeXGa6Y2yficozFrWSRNQ0jA337KJNcCNfPOX290qjhFhz8FHlsOHqD/DYTlYVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742227774; c=relaxed/simple;
	bh=i86nH+tmUQv4YMe6EkDV5wZutoEVl6UzvcahTdElQ7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N9dFmeNxenG4vb0EseJL12J8Um7M7YQF/oCuvV0Oz+RjLrQzLXYscvlvVfc5nlb47P3ybB16oPBM2wsMhWSuQwAPPeGQuzqDjsSBbxHzfyurNAGTLrFGItLrSfXRwSmbKmdzlloL10u1eODM9QfARz4VscLrFDYLAjI9H98NFYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X++MIL3A; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X++MIL3A"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2242ac37caeso25815ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Mar 2025 09:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742227771; x=1742832571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlM9OChSCkYaZ+F91J5IxvZyILSfcJF/XkspQ3JZAjs=;
        b=X++MIL3AU5nNeifoq+xm7hxqE/RSkkZwm7OTAiNA9vkL6eQqRnydOjsRFhl9TWm7Nl
         xJwHuRf0DkTvG2kDHlWFG7zw/Y4+Enz/RQw2cKrs+9wY29zNNOVSqLlUvMXOR0hC6SJt
         6BELvaaxoh48PKSRFN3P/LXSkNZc+5Ar/dBgMhD3D6FCrkwvZev7YNaFRhazw7OKp8JQ
         C85v9higKG8JC4e508UZPwiUc9+JWksYQCl4BT8IjfeBqH71F3pNfOl5cU/ln1VWbHpI
         hcRq+jAVpal0iLPCL4yl/VED3PT3k1aBgr2+kEl/r3E0cbn2Aagl03CD7CnP5AnmI040
         Hvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742227771; x=1742832571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hlM9OChSCkYaZ+F91J5IxvZyILSfcJF/XkspQ3JZAjs=;
        b=eBV5xD2yA+8gyPoIO8TTZpQtT1vBtUhpvrVcTGSBwa0SM/DCRDiWko85jKaE+CrWVV
         qpzrCymeFu1GaCSrRiIul86J70kc0AU/rzvluJmFJtl0T7DTVXFN1g53LDa42/2CJZnR
         td7cfLmEmlBmP5FgrssqsLuUkOkrCGe6drCx6tfyMvtjS9q3JAt5V1WjAsoy7merZwrr
         lMLygNY4TB8wE6Fu+iMckcfA7ItvFugn3o64kfqyA0QvhRH0Dh9wMtLglrenI7l2iBHS
         DH6E9UtEDzSEiqvRLPMrO4FhXbhnFl8nxlCEqqYVGgIiNBbkmMewzs0D8dAl7+CgKSud
         WpaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhYZQ8MI6quc459awryKdxVfMoL/kC9D38KsX7EnK3fVzYplgNZzazrWsKQSPWCX0Q5nZFY3DnOY/xwt7na2ci@vger.kernel.org
X-Gm-Message-State: AOJu0YwJofW4ULiJuJRGo3fo3U0VQ8mnCT2zINdhEPd8iW+/ZvVFzmAD
	7lakkyOcGYXVQ1OhM9gfuiI1q5HnM9K7wEZSyhQtO8oGCDB2JM+tW9ViK9dE9gtumAOmwV7jEea
	hYP+Y/ethQpGLpTckWqaYrHpZkwq6VnVI7aC6
X-Gm-Gg: ASbGnctit+mpiE2gMNfqaTYWEByQfXw9o9S5SVvAV7EiXX0ODSaWfmFVu5zcOEdrQ66
	t2UPBTk0ssX5rA2oTMuHNka8q12/dE4c43JIFdpjMXuvYzNhmnf+Ede2vRe1qczGWd8+LeMkS4d
	kto7ufNJEHlHv1CKL8OJDWAfB754EfkV2+W2IbS8Pyt7RcdkNbfVaiLiA=
X-Google-Smtp-Source: AGHT+IHVH9qFxd1OQq+RXQxMeegIEk0ijmacpFwXFhV3ftGifgWKdzDbrND4WMuI0scK6jRVh+4KwzCOnaGUMSkFuoM=
X-Received: by 2002:a17:902:da81:b0:216:4d90:47af with SMTP id
 d9443c01a7336-225f58b42e0mr3944635ad.29.1742227771391; Mon, 17 Mar 2025
 09:09:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z09zTztD8X8qIWCX@x1>
In-Reply-To: <Z09zTztD8X8qIWCX@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Mar 2025 09:09:20 -0700
X-Gm-Features: AQ5f1JqhSYSgHg3syzLPnXTH2JcXwR5fTBoxTs88Nxxc32CeyHEAXDEZS9b7FGs
Message-ID: <CAP-5=fWqA+Wjr5eb3Mi0MO8KZ01fey6J2d72jJouN+_r_8vbdA@mail.gmail.com>
Subject: Re: [PATCH 1/1 perf-tools-next] tools features: Don't check for
 libunwind devel files by default
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 1:08=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> Since 13e17c9ff49119aa ("perf build: Make libunwind opt-in rather than
> opt-out"), so we shouldn't by default be testing for its availability at
> build time in tools/build/features/test-all.c.
>
> That test was designed to test the features we expect to be the most
> common ones in most builds, so if we test build just that file, then we
> assume the features there are present and will not test one by one.
>
> Removing it from test-all.c gets rid of the first impediment for
> test-all.c to build successfully:
>
>   $ cat /tmp/build/perf-tools-next/feature/test-all.make.output
>   In file included from test-all.c:62:
>   test-libunwind.c:2:10: fatal error: libunwind.h: No such file or direct=
ory
>       2 | #include <libunwind.h>
>         |          ^~~~~~~~~~~~~
>   compilation terminated.
>   $
>
> We then get to:
>
>   $ cat /tmp/build/perf-tools-next/feature/test-all.make.output
>   /usr/bin/ld: cannot find -lunwind-x86_64: No such file or directory
>   /usr/bin/ld: cannot find -lunwind: No such file or directory
>   collect2: error: ld returned 1 exit status
>   $
>
> So make all the logic related to setting CFLAGS, LDFLAGS, etc for
> libunwind to be conditional on NO_LIBWUNWIND=3D1, which is now the
> default, now we get a faster build:
>
>   $ cat /tmp/build/perf-tools-next/feature/test-all.make.output
>   $ ldd /tmp/build/perf-tools-next/feature/test-all.bin
>         linux-vdso.so.1 (0x00007fef04cde000)
>         libdw.so.1 =3D> /lib64/libdw.so.1 (0x00007fef04a49000)
>         libpython3.12.so.1.0 =3D> /lib64/libpython3.12.so.1.0 (0x00007fef=
04478000)
>         libm.so.6 =3D> /lib64/libm.so.6 (0x00007fef04394000)
>         libtraceevent.so.1 =3D> /lib64/libtraceevent.so.1 (0x00007fef0436=
c000)
>         libtracefs.so.1 =3D> /lib64/libtracefs.so.1 (0x00007fef04345000)
>         libcrypto.so.3 =3D> /lib64/libcrypto.so.3 (0x00007fef03e95000)
>         libz.so.1 =3D> /lib64/libz.so.1 (0x00007fef03e72000)
>         libelf.so.1 =3D> /lib64/libelf.so.1 (0x00007fef03e56000)
>         libnuma.so.1 =3D> /lib64/libnuma.so.1 (0x00007fef03e48000)
>         libslang.so.2 =3D> /lib64/libslang.so.2 (0x00007fef03b65000)
>         libperl.so.5.38 =3D> /lib64/libperl.so.5.38 (0x00007fef037c6000)
>         libc.so.6 =3D> /lib64/libc.so.6 (0x00007fef035d5000)
>         liblzma.so.5 =3D> /lib64/liblzma.so.5 (0x00007fef035a0000)
>         libzstd.so.1 =3D> /lib64/libzstd.so.1 (0x00007fef034e1000)
>         libbz2.so.1 =3D> /lib64/libbz2.so.1 (0x00007fef034cd000)
>         /lib64/ld-linux-x86-64.so.2 (0x00007fef04ce0000)
>         libcrypt.so.2 =3D> /lib64/libcrypt.so.2 (0x00007fef03495000)
>   $
>
> Fixes: 13e17c9ff49119aa ("perf build: Make libunwind opt-in rather than o=
pt-out")
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/build/feature/test-all.c |  5 --
>  tools/perf/Makefile.config     | 83 ++++++++++++++++++++--------------
>  2 files changed, 49 insertions(+), 39 deletions(-)
>
> diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-al=
l.c
> index 59ef3d7fe6a4e771..80ac297f81967171 100644
> --- a/tools/build/feature/test-all.c
> +++ b/tools/build/feature/test-all.c
> @@ -58,10 +58,6 @@
>  # include "test-libelf-getshdrstrndx.c"
>  #undef main
>
> -#define main main_test_libunwind
> -# include "test-libunwind.c"
> -#undef main
> -
>  #define main main_test_libslang
>  # include "test-libslang.c"
>  #undef main
> @@ -184,7 +180,6 @@ int main(int argc, char *argv[])
>         main_test_libelf_getphdrnum();
>         main_test_libelf_gelf_getnote();
>         main_test_libelf_getshdrstrndx();
> -       main_test_libunwind();
>         main_test_libslang();
>         main_test_libbfd();
>         main_test_libbfd_buildid();
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 2916d59c88cd08b2..0e4f6a860ae25339 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -43,7 +43,9 @@ endif
>  # Additional ARCH settings for ppc
>  ifeq ($(SRCARCH),powerpc)
>    CFLAGS +=3D -I$(OUTPUT)arch/powerpc/include/generated
> -  LIBUNWIND_LIBS :=3D -lunwind -lunwind-ppc64
> +  ifndef NO_LIBUNWIND
> +    LIBUNWIND_LIBS :=3D -lunwind -lunwind-ppc64
> +  endif

Sorry for missing this patch. Given this, and below, are just
declaring a variable making it NO_LIBUNWIND conditional feels like
clutter. I'd suggest just keeping the variable unconditionally and
making the uses conditional (which of course the patch does).

Other than this:
Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>  endif
>
>  # Additional ARCH settings for x86
> @@ -53,25 +55,35 @@ ifeq ($(SRCARCH),x86)
>    ifeq (${IS_64_BIT}, 1)
>      CFLAGS +=3D -DHAVE_ARCH_X86_64_SUPPORT
>      ARCH_INCLUDE =3D ../../arch/x86/lib/memcpy_64.S ../../arch/x86/lib/m=
emset_64.S
> -    LIBUNWIND_LIBS =3D -lunwind-x86_64 -lunwind -llzma
> +    ifndef NO_LIBUNWIND
> +      LIBUNWIND_LIBS =3D -lunwind-x86_64 -lunwind -llzma
> +    endif
>      $(call detected,CONFIG_X86_64)
>    else
> -    LIBUNWIND_LIBS =3D -lunwind-x86 -llzma -lunwind
> +    ifndef NO_LIBUNWIND
> +      LIBUNWIND_LIBS =3D -lunwind-x86 -llzma -lunwind
> +    endif
>    endif
>  endif
>
>  ifeq ($(SRCARCH),arm)
> -  LIBUNWIND_LIBS =3D -lunwind -lunwind-arm
> +  ifndef NO_LIBUNWIND
> +    LIBUNWIND_LIBS =3D -lunwind -lunwind-arm
> +  endif
>  endif
>
>  ifeq ($(SRCARCH),arm64)
>    CFLAGS +=3D -I$(OUTPUT)arch/arm64/include/generated
> -  LIBUNWIND_LIBS =3D -lunwind -lunwind-aarch64
> +  ifndef NO_LIBUNWIND
> +    LIBUNWIND_LIBS =3D -lunwind -lunwind-aarch64
> +  endif
>  endif
>
>  ifeq ($(SRCARCH),loongarch)
>    CFLAGS +=3D -I$(OUTPUT)arch/loongarch/include/generated
> -  LIBUNWIND_LIBS =3D -lunwind -lunwind-loongarch64
> +  ifndef NO_LIBUNWIND
> +    LIBUNWIND_LIBS =3D -lunwind -lunwind-loongarch64
> +  endif
>  endif
>
>  ifeq ($(ARCH),s390)
> @@ -80,7 +92,9 @@ endif
>
>  ifeq ($(ARCH),mips)
>    CFLAGS +=3D -I$(OUTPUT)arch/mips/include/generated
> -  LIBUNWIND_LIBS =3D -lunwind -lunwind-mips
> +  ifndef NO_LIBUNWIND
> +    LIBUNWIND_LIBS =3D -lunwind -lunwind-mips
> +  endif
>  endif
>
>  ifeq ($(ARCH),riscv)
> @@ -121,16 +135,18 @@ ifdef LIBUNWIND_DIR
>    $(foreach libunwind_arch,$(LIBUNWIND_ARCHS),$(call libunwind_arch_set_=
flags,$(libunwind_arch)))
>  endif
>
> -# Set per-feature check compilation flags
> -FEATURE_CHECK_CFLAGS-libunwind =3D $(LIBUNWIND_CFLAGS)
> -FEATURE_CHECK_LDFLAGS-libunwind =3D $(LIBUNWIND_LDFLAGS) $(LIBUNWIND_LIB=
S)
> -FEATURE_CHECK_CFLAGS-libunwind-debug-frame =3D $(LIBUNWIND_CFLAGS)
> -FEATURE_CHECK_LDFLAGS-libunwind-debug-frame =3D $(LIBUNWIND_LDFLAGS) $(L=
IBUNWIND_LIBS)
> -
> -FEATURE_CHECK_LDFLAGS-libunwind-arm +=3D -lunwind -lunwind-arm
> -FEATURE_CHECK_LDFLAGS-libunwind-aarch64 +=3D -lunwind -lunwind-aarch64
> -FEATURE_CHECK_LDFLAGS-libunwind-x86 +=3D -lunwind -llzma -lunwind-x86
> -FEATURE_CHECK_LDFLAGS-libunwind-x86_64 +=3D -lunwind -llzma -lunwind-x86=
_64
> +ifndef NO_LIBUNWIND
> +  # Set per-feature check compilation flags
> +  FEATURE_CHECK_CFLAGS-libunwind =3D $(LIBUNWIND_CFLAGS)
> +  FEATURE_CHECK_LDFLAGS-libunwind =3D $(LIBUNWIND_LDFLAGS) $(LIBUNWIND_L=
IBS)
> +  FEATURE_CHECK_CFLAGS-libunwind-debug-frame =3D $(LIBUNWIND_CFLAGS)
> +  FEATURE_CHECK_LDFLAGS-libunwind-debug-frame =3D $(LIBUNWIND_LDFLAGS) $=
(LIBUNWIND_LIBS)
> +
> +  FEATURE_CHECK_LDFLAGS-libunwind-arm +=3D -lunwind -lunwind-arm
> +  FEATURE_CHECK_LDFLAGS-libunwind-aarch64 +=3D -lunwind -lunwind-aarch64
> +  FEATURE_CHECK_LDFLAGS-libunwind-x86 +=3D -lunwind -llzma -lunwind-x86
> +  FEATURE_CHECK_LDFLAGS-libunwind-x86_64 +=3D -lunwind -llzma -lunwind-x=
86_64
> +endif
>
>  FEATURE_CHECK_LDFLAGS-libcrypto =3D -lcrypto
>
> @@ -734,26 +750,25 @@ ifeq ($(dwarf-post-unwind),1)
>    $(call detected,CONFIG_DWARF_UNWIND)
>  endif
>
> -ifndef NO_LOCAL_LIBUNWIND
> -  ifeq ($(SRCARCH),$(filter $(SRCARCH),arm arm64))
> -    $(call feature_check,libunwind-debug-frame)
> -    ifneq ($(feature-libunwind-debug-frame), 1)
> -      $(warning No debug_frame support found in libunwind)
> +ifndef NO_LIBUNWIND
> +  ifndef NO_LOCAL_LIBUNWIND
> +    ifeq ($(SRCARCH),$(filter $(SRCARCH),arm arm64))
> +      $(call feature_check,libunwind-debug-frame)
> +      ifneq ($(feature-libunwind-debug-frame), 1)
> +        $(warning No debug_frame support found in libunwind)
> +        CFLAGS +=3D -DNO_LIBUNWIND_DEBUG_FRAME
> +      endif
> +    else
> +      # non-ARM has no dwarf_find_debug_frame() function:
>        CFLAGS +=3D -DNO_LIBUNWIND_DEBUG_FRAME
>      endif
> -  else
> -    # non-ARM has no dwarf_find_debug_frame() function:
> -    CFLAGS +=3D -DNO_LIBUNWIND_DEBUG_FRAME
> +    EXTLIBS +=3D $(LIBUNWIND_LIBS)
> +    LDFLAGS +=3D $(LIBUNWIND_LIBS)
> +  endif
> +  ifeq ($(findstring -static,${LDFLAGS}),-static)
> +    # gcc -static links libgcc_eh which contans piece of libunwind
> +    LIBUNWIND_LDFLAGS +=3D -Wl,--allow-multiple-definition
>    endif
> -  EXTLIBS +=3D $(LIBUNWIND_LIBS)
> -  LDFLAGS +=3D $(LIBUNWIND_LIBS)
> -endif
> -ifeq ($(findstring -static,${LDFLAGS}),-static)
> -  # gcc -static links libgcc_eh which contans piece of libunwind
> -  LIBUNWIND_LDFLAGS +=3D -Wl,--allow-multiple-definition
> -endif
> -
> -ifndef NO_LIBUNWIND
>    CFLAGS  +=3D -DHAVE_LIBUNWIND_SUPPORT
>    CFLAGS  +=3D $(LIBUNWIND_CFLAGS)
>    LDFLAGS +=3D $(LIBUNWIND_LDFLAGS)
> --
> 2.47.0
>
