Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF2023D283
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Aug 2026 06:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786341830; cv=pass; b=iAC4mZUvRmUal2rfG9jb6SLSKjlG1XKBqhQqhlTzkpefuSQsYVWTb1O8GV/+cRp8aU0oJtbCBgPu8tEUNRlUGNd4SLZ9x8d0lTFGzA9/PE40t/EEOQ0iGflclQABg6SxmRRPYVKl2qPD/+OSvjKe1MgYBQAQKXlwV8/9cdO+B/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786341830; c=relaxed/simple;
	bh=j6cLefgu4QnEtnzw279ypap0ZNr2lAsmTlFTK2IwjMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ffBbSZKYYVl2LKap/N+8dHHck/2NwZM6iDCQ5SzjjNZyikYuc1OY5wrrfx3Dfi++7+yn1qXl0IjJYvkIqlV4t8z/PbzLMWDKp6IdymGCJLeBFyeR9TI54JrnaXiFA31kLQHBuii9C/sVXyHGCVItTgwze0f2MkRsGp3nX31moow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oK5gz2fO; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oK5gz2fO"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c10e86e52so240761cf.1
        for <linux-perf-users@vger.kernel.org>; Sun, 09 Aug 2026 23:03:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786341828; cv=none;
        d=google.com; s=arc-20260327;
        b=KrCEnPn1J/HJWSxCadrscf9EqMHhGuUUpXPvVkWn+JlEa3T0XuaDvBXI9gwSYKL2Uq
         aw1XgeIb0GqBiGWTAcUp4kL2SQ2vx9PCEW6AxkMFhBX2hAeiVMn7pHE5U78NY/Hg7otf
         E9lOunoIEH96SxyVm5dAvYLTHFcMQ0Nbn3aiIz9DzRrqwlPKt/O4k/3aEiCYnnL7FoW4
         boDmi5twgKMHCH5Rwe+zK+Wm6nm78/whJ4Mg0X4x8jTO9QN2UCf6xDwtF01zoqEuEffr
         HHLlLrFwG6L59ih1E7RHOgKzEykV4/Elw+B4X7grSxEFrk08WlozsUve2aHeG5PB0241
         kznQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jLvgsXkbz1a5c9YUh4s60J5KhjGRbQn+3Eo+qEGp6MI=;
        fh=LFmQ6jFi3FD3rRbkL3UuXr1PCNTmqAeRAxE64511yOo=;
        b=lKh3RWeY48on6j3Z1ukqnK2/7HjibPMeeKh57Y69hyCsQDxN3VKMwPv0k8g2QFUFgE
         0nPL8byPOgxswH6F5WhGzVcgZJxGRSuSP5MLYzqZlH7jcQHt98D9M9p3MIp6IUcyPivg
         ZNxsvbhSwCoRwgkAA7PZt9YRnAFzKhfpjW/tWbgVYrZT0X6NgUZPkNLIcUhHSOncHx75
         4UbvI+Jmay18/08siJCJ6DCJjLdqLcwds2B6bVnXDdpK569FvxuYHy/adEX5hQ0j7+sz
         17x3o7bfKCyPjQzrhAI5KvCSulZea5/tL+4wsMlQZrKwtaiR+VkCNpxx5P03RNo9CwuZ
         P9aQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786341828; x=1786946628; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jLvgsXkbz1a5c9YUh4s60J5KhjGRbQn+3Eo+qEGp6MI=;
        b=oK5gz2fO/kVTQFXiGkGFBb42dWTspiK2u/zaVrV+3lSuI6moNRYOFk1sIfrljg3Lil
         Y2/x1FgRfb8XeeX5Rc2gyPRNkn2lqKlVS4KgwAP0B+RIfyVPPXqIXvBEiKOLjF3KK46U
         DnyRVDIqrXIfRwFWb4xndmVu6bdHyf86mkSDjPvFOI66dK9YUPu3a/m440Bhw9IL80Lb
         K92TIhNvJNZWnnJ2CGjgB9lqwIUkacBaml/rNjeTGcLs5dsuiw7+KoAXeDZnBMPwvmzE
         EBFUc6935A0oYNsCCSQFD5xdTEy7x+A3hiwhFA8zBXv0uXjhcF5rXit05fpNcDg0tOGh
         1lXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786341828; x=1786946628;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jLvgsXkbz1a5c9YUh4s60J5KhjGRbQn+3Eo+qEGp6MI=;
        b=MFPp7UlPekVW9QnUAdhG4l4vkPdMUL22lEoh0/hetLhJ97RkuoGgluOrXEZNi7AVrH
         uhTHuzYiBJgdcgaLuQy+zBGNHt6WhryIofyV4MwdZrPaB7g+ilndgFHrxdMWhn6PBPZP
         XP6FbMUP6VHguuJ47vhlj0xbrOP0/+Ci8fmVrCZG6VcRyMKFORgc92a5vSUONmti7q/6
         eBhxk78JEgTu767q275m4YMOe10h4M1ukEwe+cCQtpFR/cbXZd5x4AhBXud15oqVQXPF
         wXn3YydyjXBdSzLWEU1I+rHMmPewYLqhN05GJw3XF/72ZaEpUoITNvbikdAqZRWDNLkl
         W0vA==
X-Forwarded-Encrypted: i=1; AHgh+RoFVJ5frRMpj7jFEoVKlxUvTeQZ+DWbR1lEgxNK3J0GQ0lIO/Wc3Zj9daoxEru46Kcg1qERLEmBOcYcvhWW51tb@vger.kernel.org
X-Gm-Message-State: AOJu0YxOK6lPupEFLaOwqKMaDdbzIG7hhPyGKlS5zBPzvKt+VttFgRSd
	3DnTCcKC+8Z7t71OSTwPVb5aIwWdrxdhUWs4+cY5WM7ZAVmz9Fb5rCnlC0kyQM18pise6xYqaMk
	GkTJdk77DcRGH9RzjPq3n9CnC7hkBRTa2Sl6aPViP
X-Gm-Gg: AR+sD12rR8bkjVHZ7c9X196LVN2GAbk+2yTTOwwXye3kC9bswI0m+8fR/4gspigunEP
	gcD7nWxhRh0B6xUU4NtRiXAx2hjIY4l4j6GsCQS5IZ46AlnvKsm12GOlr5ldlTH1jn6CqXrR7XX
	qNlyDJRVeZkdhkB6VFjn292u/mujY0OOKkcrXhDRMM2XWJyfi8Pi+Kp6gucAiQ/814MoKDuB4S6
	T+SN1SPO22qw5Vb2zwJ75X+dmvSKppPNqw3LSsHETB5k18O1xciOAMuevnAZW657oCY2iYx30Q3
	kc2dlA0MHRtirr37ArAzNyreyBJpzcl+2888xRIUBZSCFA==
X-Received: by 2002:a05:622a:98c:b0:51c:ca9:3d17 with SMTP id
 d75a77b69052e-52d23c783fcmr24558951cf.12.1786341827685; Sun, 09 Aug 2026
 23:03:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810005127.289896-1-acme@kernel.org> <20260810005127.289896-7-acme@kernel.org>
In-Reply-To: <20260810005127.289896-7-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Sun, 9 Aug 2026 23:03:36 -0700
X-Gm-Features: AUfX_myjKGDw2QBshRvHsaAGxC9O1lvn-tQ8WNlw2CyQP_p6kLRnQ8UaTqm8qtQ
Message-ID: <CAP-5=fUFyq4Xme36ScLjqa+0kJbLAdrwzxvU-SprzFeu14Gggg@mail.gmail.com>
Subject: Re: [PATCH 6/7] perf build: Remove leftover feature tests for removed
 cxx and clang support
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 9, 2026 at 5:52=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> 56b11a2126bf2f42 ("perf bpf: Remove support for embedding clang for
> compiling BPF events (-e foo.c)") removed the test-cxx.cpp and
> test-clang.cpp sources, but left behind their entries in the feature
> test FILES list, the build rules and the cxx and clang entries in
> FEATURE_TESTS_EXTRA.
>
> Since the sources no longer exist, those rules would always fail,
> making the artificial feature-cxx and feature-clang results to be
> perpetually disabled/absent, remove the leftover entries, making the
> feature test scripts list match the available sources.
>
> Assisted-by: opencode:deepseek-v4-flash-free
> Signed-off-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Looks good, perhaps a Fixes tag given the commit above?

Thanks,
Ian

> ---
>  tools/build/Makefile.feature |  2 --
>  tools/build/feature/Makefile | 14 --------------
>  2 files changed, 16 deletions(-)
>
> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index ed1374af31c16838..99eb0ea095375606 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -123,9 +123,7 @@ FEATURE_TESTS_EXTRA :=3D                  \
>           libbfd-liberty-z               \
>           libopencsd                     \
>           libperl                        \
> -         cxx                            \
>           llvm                           \
> -         clang                          \
>           libbpf                         \
>           libpfm4                        \
>           libdebuginfod                 \
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index 62909a9c799d3338..7d165018116a552f 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -55,7 +55,6 @@ FILES=3D                                          \
>           test-bpf.bin                           \
>           test-libbpf.bin                        \
>           test-sdt.bin                           \
> -         test-cxx.bin                           \
>           test-gettid.bin                       \
>           test-jvmti.bin                                \
>           test-jvmti-cmlr.bin                   \
> @@ -63,7 +62,6 @@ FILES=3D                                          \
>           test-sched_getcpu.bin                 \
>           test-setns.bin                                \
>           test-libopencsd.bin                   \
> -         test-clang.bin                                \
>           test-llvm.bin                         \
>           test-llvm-perf.bin                    \
>           test-libaio.bin                       \
> @@ -335,9 +333,6 @@ $(OUTPUT)test-libbpf.bin:
>  $(OUTPUT)test-sdt.bin:
>         $(BUILD)
>
> -$(OUTPUT)test-cxx.bin:
> -       $(BUILDXX) -std=3Dgnu++11
> -
>  $(OUTPUT)test-gettid.bin:
>         $(BUILD)
>
> @@ -363,15 +358,6 @@ $(OUTPUT)test-llvm-perf.bin:
>                 $(shell $(LLVM_CONFIG) --system-libs)           \
>                 > $(@:.bin=3D.make.output) 2>&1
>
> -$(OUTPUT)test-clang.bin:
> -       $(BUILDXX) -std=3Dgnu++17                                 \
> -               -I$(shell $(LLVM_CONFIG) --includedir)          \
> -               -L$(shell $(LLVM_CONFIG) --libdir)              \
> -               -Wl,--start-group -lclang-cpp -Wl,--end-group   \
> -               $(shell $(LLVM_CONFIG) --libs Core option)      \
> -               $(shell $(LLVM_CONFIG) --system-libs)           \
> -               > $(@:.bin=3D.make.output) 2>&1
> -
>  -include $(OUTPUT)*.d
>
>  $(OUTPUT)test-libaio.bin:
> --
> 2.55.0
>
