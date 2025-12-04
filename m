Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198362DA768
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Dec 2025 18:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764872414; cv=none; b=Ea6U0+Qxr6tkm9lLCKf7DEGddVuKsQCFmJ4Qi8/lp22qqEP7CkhgYhN6m0G7tP3++pBQhryxBdBTYasGWnTX/FsWoZot1MDUiExU3+38swu0IZc/GTtWbAl8hVO1PO1RCpxVqxFpJ45qzOsHNJ/SGHaPJdMtBtPLpGAC3MLICE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764872414; c=relaxed/simple;
	bh=uGmQrKojHbfjgbGYv8My25L7Ow9cjr6R4cePCS1/ChM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lzi7xMPUW5boEFEO4PtItbcQkDFldHb6ZD3yeb8i/YkHQxZ9r9amM/5C+sg7pRdq/ubMqyNG5DgKAVPouZLsXBXULNyqEPYznysIt/tRz9eTvGcq+4fq4mgycNwH8gml2BjQ9iCcvKCUSqTZvfOopRn25hwzK7CQgNehQnDnfuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OsQwZ/1u; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OsQwZ/1u"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-29852dafa7dso7645ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Dec 2025 10:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764872411; x=1765477211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7UGDbYN0HgmxODNA4VdtXLtFmyqVq5pKIjkg+oiyjs=;
        b=OsQwZ/1uqN4J0t/sMo4rly6qnIp5UCxaj9HwvVD4Gvjc60azn8zvcsaa3vsMPxSfD+
         xqEoK+DAXHHl7J3PW3kzBUwBeSNjU/7pkA8k9RfwpM3O3bjbpfgWfCJi8ijUBIUmxMMG
         G4oUYqr27xyEf2GGE7FSY0AKcBr/dkNMsUIZWUutV1tY566ko0FIlXVUL5E9MA8szFhx
         sXMBbu/J4f0oG4MgqKiIYTfytmeITGHkYOnTHeQJDxHwpG9isD1jaZ57p6akOyPbSGru
         LT+xVI92paPxDMZz6l/fp4S0IV5sl3Zhgnfyu9p39QHqAUyF5jnHHaZ4AWxqGaUiqVWv
         mBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764872411; x=1765477211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i7UGDbYN0HgmxODNA4VdtXLtFmyqVq5pKIjkg+oiyjs=;
        b=TdCREWfvgQIZ7JlGb92cAdIpCDgGOLzkkjbePwXqzMpGHtvDJXstaYo7U2qgN5hpuH
         fdditPNLO0w03+mXxM4usUzoDp2+i/J/N2IayE8V9Ebp5k8n7g5dvVq7HCpBGArA64Kt
         qwVSAAMIPSyjhCGvDLJDS+i5SOEfxdMKcnE26rJ10BjS2Bm+UI8yCuWrBqjy92rezmI8
         TMM2+TM5e98ib3Yk7pwMD08avf2S4vLeW7YFVHWn1QehhNywAO1D3+ImzkoIo6w7+hZv
         ZY/GZrQjQWYUmZmLItm+/T61MAIIcyOMw1mUT+JHS8stPMtgtz6KQeL/DMQWiaL9f6P3
         2txw==
X-Forwarded-Encrypted: i=1; AJvYcCXX1Ld140D3cHM6psfuI8fOesqKjA6/woVbP1RLDXuxPeABJ9H0ENnns4Yc+P1rhzIvwas1jBjcLnllAo47dGDZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2g4NXvTjmhx9WdHIkgzOGgjDa24QcDvdZKKYbZbDZXUcrSwFr
	AzpJCJbyT0pL7aeSk8im//A+usiz3qqloGbagEu3bvpZO/udWWNPzOmFY2fLVPBjMOHCLfnD99z
	5dZ2ecf2kqywgOoT49yK7ZCUm6gKWDc+TmCXlPhqV
X-Gm-Gg: ASbGncsDjslOjZ98nFEl0DgctacGvLDkF+ZEuG153zi1ewO93aEQnXuAO3u0pXVV+CR
	fNWfuf3mCqpCNSq2sMAJ7oFalFOpgOKqYkjIa9ZnU1vI13fEjASfWbzDjjJVnesbErhAuTxy3Pt
	xFtrttYrRp3dYqqdhdvw8ieR/gE9ORofE04SWmRORNj599pkeYPUpd3KiL0WQid2wLFmrm/0Gtp
	Rzsy5Ulu6YgyjSL130gvFP44m6NuJNXMWdpUz1TayRaSS0QyRRvk/WhPDcm/m11s7vvbHyJJxSd
	n6oosPZTKIt28SxRYLf564jxiQ==
X-Google-Smtp-Source: AGHT+IFf+VWpRoPAv192tHNIq38glaxoIijpwbtfMXFCpvOLbawe6MNxrX/jmz5K/0lxeQFPbP5CHSNCMYrEj6F6uUM=
X-Received: by 2002:a17:902:ea0c:b0:299:c367:9e03 with SMTP id
 d9443c01a7336-29dcd8c62a4mr70705ad.18.1764872411110; Thu, 04 Dec 2025
 10:20:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251204-perf_fix_syscall_header-v1-0-b8e27f74ed6a@arm.com> <20251204-perf_fix_syscall_header-v1-2-b8e27f74ed6a@arm.com>
In-Reply-To: <20251204-perf_fix_syscall_header-v1-2-b8e27f74ed6a@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 4 Dec 2025 10:19:59 -0800
X-Gm-Features: AWmQ_bmidjMG4fWzPpsr-eDCkaa5ZHJi6Jiu7ERoPT2EOBvLSxtMTBW1reHdG44
Message-ID: <CAP-5=fV-d_X1uFYACEOJOxOY43+fj9aEm0_bp7NGSo9kZVMJ4Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] Revert "perf tools: Fix arm64 build by generating unistd_64.h"
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 8:53=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> This reverts:
>
> commit 8988c4b91945 ("perf tools: Fix in-source libperf build")
> commit bfb713ea53c7 ("perf tools: Fix arm64 build by generating unistd_64=
.h")
>
> Since we now have a static unistd_64.h for the arm64 build, there is no
> need to generate unistd_64.h in libperf.  Revert all patches related to
> generating unistd_64.h.

Could we generate the file and then compare the two? We do something
like this for empty-pmu-events.c here:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/pmu-events/Build?h=3Dperf-tools-next#n49

Similarly, could we get rid of the unistd_64.h generation and just add
a build time validation test? Generating the file is painful in many
ways, as this series testifies.

Thanks,
Ian

> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/lib/perf/Makefile    | 14 ++------------
>  tools/perf/Makefile.config |  1 -
>  2 files changed, 2 insertions(+), 13 deletions(-)
>
> diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
> index 7fbb50b74c00b3b99ac538821124e04bfbc6da6a..ffcfd777c45181960afc7505e=
f8f85d0b7ea7e8d 100644
> --- a/tools/lib/perf/Makefile
> +++ b/tools/lib/perf/Makefile
> @@ -42,7 +42,6 @@ libdir_relative_SQ =3D $(subst ','\'',$(libdir_relative=
))
>  TEST_ARGS :=3D $(if $(V),-v)
>
>  INCLUDES =3D \
> --I$(OUTPUT)arch/$(SRCARCH)/include/generated/uapi \
>  -I$(srctree)/tools/lib/perf/include \
>  -I$(srctree)/tools/lib/ \
>  -I$(srctree)/tools/include \
> @@ -100,16 +99,7 @@ $(LIBAPI)-clean:
>         $(call QUIET_CLEAN, libapi)
>         $(Q)$(MAKE) -C $(LIB_DIR) O=3D$(OUTPUT) clean >/dev/null
>
> -uapi-asm :=3D $(OUTPUT)arch/$(SRCARCH)/include/generated/uapi/asm
> -ifeq ($(SRCARCH),arm64)
> -       syscall-y :=3D $(uapi-asm)/unistd_64.h
> -endif
> -uapi-asm-generic:
> -       $(if $(syscall-y),\
> -               $(Q)$(MAKE) -f $(srctree)/scripts/Makefile.asm-headers ob=
j=3D$(uapi-asm) \
> -               generic=3Dinclude/uapi/asm-generic $(syscall-y),)
> -
> -$(LIBPERF_IN): uapi-asm-generic FORCE
> +$(LIBPERF_IN): FORCE
>         $(Q)$(MAKE) $(build)=3Dlibperf
>
>  $(LIBPERF_A): $(LIBPERF_IN)
> @@ -130,7 +120,7 @@ all: fixdep
>  clean: $(LIBAPI)-clean
>         $(call QUIET_CLEAN, libperf) $(RM) $(LIBPERF_A) \
>                  *.o *~ *.a *.so *.so.$(VERSION) *.so.$(LIBPERF_VERSION) =
.*.d .*.cmd tests/*.o LIBPERF-CFLAGS $(LIBPERF_PC) \
> -                $(TESTS_STATIC) $(TESTS_SHARED) $(syscall-y)
> +                $(TESTS_STATIC) $(TESTS_SHARED)
>
>  TESTS_IN =3D tests-in.o
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 6b62fea21a0ad1caf99d75d06fc29d2b05007931..b1e39fe0cf40ce1419b19a11d=
accc18853d5cfe6 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -64,7 +64,6 @@ include $(srctree)/tools/scripts/Makefile.arch
>  $(call detected_var,SRCARCH)
>
>  CFLAGS +=3D -I$(OUTPUT)arch/$(SRCARCH)/include/generated
> -CFLAGS +=3D -I$(OUTPUT)libperf/arch/$(SRCARCH)/include/generated/uapi
>
>  # Additional ARCH settings for ppc
>  ifeq ($(SRCARCH),powerpc)
>
> --
> 2.34.1
>
