Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587FF3E3C5A
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 20:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790195927; cv=pass; b=nyWgwaw+OF+SCOKTP+XXTppq3dkK2HkynKm1jjNqRgfT+fe8jyx0u/fpA1zmp3OCXgTGt6GwrD378cMV6YilidlSVtQst+SQrvqzz9xVxumIU61uhbW8uemgOvJ+78gwCuyRJMXZtQowUrlDihf55ShMBT/TXJTOPWU/kvyHTnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790195927; c=relaxed/simple;
	bh=1323NqL3CnlUce5XBrIJSLy43Ws8JZBp7hMlzmPHrRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mEOkIsLqSFj0s2H/RfDaoGBVqvuje95sjNVRyCM9x5PFFiASvi/fYzpfuTKL04ZBNLKkKPqLCyvJmt4SU9ORhzR2PqC0ES9A9a3RgGdDHy371axGjGBgVIHOQakCEKM8lwlxgrREb2huyt91sPR0eDvyHOtd3+7+WW+XfAOpdZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UTK9jh5A; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UTK9jh5A"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d3b445a84fso4865ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 13:38:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790195917; cv=none;
        d=google.com; s=arc-20260327;
        b=j31C+dmXmj0VgwSqebBTTHyXotLggcaikmyHuvL/MzGtctC8AyXQlvqiPIacendUE/
         jzdFm//cqKs5owyrO8BksIiKTq9Ju0pGxKs11gcsCDI5cn/ccsgWFsmkEbXtk+I5xGe9
         4DQyBAjU0ILHGRPN95kkpMd8Cpgb7VBItSESHvESHxvgWXBrpNwsB5oIhjXedre3X0jl
         eLeJeTBbgICtLuVicpNpNGwwzSPWuUf36XgBln+d152lWZ58YzWNDioERpOxaVVK1oO9
         7m/SL9pP5rZbsGVcB5OJUiMHdnvd6xjdF+S77x2NkborSUdSISF8IzU2Ajl25Fsx0o7M
         OZjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J915CxCyoQiRvBpeSoeKGmPezPQTdfg1IocPf7kC9Cw=;
        fh=sbtIplsa/YaPdHNsii5NZA50eNc1t5g/FeKJKxa22HE=;
        b=DFAsUR3CI2KuwiQwqFBYYbcXwYJT59Y1ocerABXkoOIfF7hbQuY/Jt4a+igGpZ0LtV
         dzWJC2HN2+k91FH+amNwJ441QHyAzTJugER/6WTf6tHIe/6xfCgrJv5mPkOcJFn+zv+3
         AToten1rRPC4lLZ3RlOqFkPVlC2U07K1mSsbr+bDYgF0PG2MAAmAu7tVzWPSUWfMUJST
         onRwXHZhcTPmwCrz704xoAXGIFUTXV3lnBLYgA8GEGgBXPvxt0JIg3+AmOkzo57y7joO
         B9LAnl1h7AOTsdU8K20JU7Fsgv6U9edD96i6+To8Ses5O/rbIbQi1FOoIl+uhGx3TtYP
         xoRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790195917; x=1790800717; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J915CxCyoQiRvBpeSoeKGmPezPQTdfg1IocPf7kC9Cw=;
        b=UTK9jh5AVVPYAgpwE98Cq9VszKtqOjO+4QCEih0/J4NpXCRWlSJkfsCe+vtjnlDbHG
         69baWXT6tHwAlZUtTDrb0ednkMLW9EazC9un0TgODObSjX1m1bDrOoruD1+Qp5GkiJ57
         BEx42dvy0cFvkDs+5EToZCljzI0uv/yHO1YWJxKEFEDXVco+Wqy9mfifTwRE3gCzQyd2
         TWjES3E8euDKKfC98Tt9NVFz/DIUjuT0s6YGKaRfjaMx73+GTZhHWO2xWqkPlOIfBir6
         AkEmVGx8sKXkY/rfSg8SV6nQVsdapJOEHDAw+SniHjszsJ3FLI0OIq+khZshgZ4kJcIv
         p3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790195917; x=1790800717;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J915CxCyoQiRvBpeSoeKGmPezPQTdfg1IocPf7kC9Cw=;
        b=RST1+hRK86RZv+XOQT15KsfiStkody+CMbscxbfyyBR6j5ZrZxt0gz9LU6expXBsDl
         MYl5uUg+aZURMIk6O86Vu7sUGTSriDBrVay/HaEvQjbriw0ibAkXcELoHqqTqTwR0VVM
         Rorci4W5K+Ur5bcJ45Bi/KxZ7syyKI2mLgOaklIwp6z1df4ldkEw5Q2HNFtokfmy5+Gk
         5ljzsQ0jPkydnk+llvXbeGsVuGH4SrlRclO9jGNry0yBfOC1us+Nm+uBXUkVzNKAWteE
         g9ZUPgysMozEOvxs4fMnX8H6fI0A7/1+O9swn9omN10+LEsV+MFArGInhjNtlaNYa2dW
         2eMg==
X-Forwarded-Encrypted: i=1; AKwUvBxoFfW9MuMd2OIMkavNzfu0oePcg43WUoVdObBN1OUSN8Z3cNE2C0lJbw6M0bY+wn905JPI0BLpeFlmiqNuIexL@vger.kernel.org
X-Gm-Message-State: AFuF++nhnR1zfv0n9oaToOKwdAsrj+NnMLPrNMVIMMIWQ9GXSvAwQV9Z
	GpIHTGkUqTCoVC4mHNzfimYTZN9usi32I4zVEFGgVPT/qHm6s1y3tLoWMC+92WgPS7oDNBRtFjx
	rbi1C7osp0+i4IcIas1Y3psl+pGu6sVypDPRFLP1R
X-Gm-Gg: AYBFou3E3mGXzQnmHNeKx3dK9AJz3OPvkyqNFV5TUugyHQoghWoAN9UvkvUga3l0uUk
	gDiz1CKXAHc4cWpK7CmLL9KehWchc4nr4iNlAhE5tKyFTzAKX3/4cWq14IcYS4wUCnccHRGWbtU
	VIBNHVV6MENaREiU92D1ypqsVB7gYQt7gcecJicomZPGEqp7047uSfyFZjC54BVSTaHo6byIEfz
	pXKXcfL4dIP2hIE/r9XHqMEIt96PV9JZYfNpyRAMEmIdIROlAwV59uI1WbrsOJTW5ONuyprM2OC
	E6QEcnFDWNqbv+pOpqPEztargqV9HLIlaVwHDKRvdY0R9X/8f3zTOhpMOxrXbBrVdI9esRUHanP
	j5Qo/tKsMbA==
X-Received: by 2002:a17:903:3546:b0:2d5:db3d:1a43 with SMTP id
 d9443c01a7336-2df7b543459mr2096965ad.16.1790195916082; Wed, 23 Sep 2026
 13:38:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923090429.2026529-1-stian@itx.no>
In-Reply-To: <20260923090429.2026529-1-stian@itx.no>
From: Ian Rogers <irogers@google.com>
Date: Wed, 23 Sep 2026 13:38:22 -0700
X-Gm-Features: AclHuK9IEgUm7kI4_piSGvTKV7diZ2jvf8wc2SM-hRRU78_gdW8Ka0g33Qc7YwM
Message-ID: <CAP-5=fW4bzmy5_6a-8YucOy7JGKg+izRbq+7TaOGKV5aG0oYcw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/3] perf: sparc64 user regs and stack dump, with
 arch hooks
To: Stian Halseth <stian@itx.no>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Andreas Larsson <andreas@gaisler.com>, "David S. Miller" <davem@davemloft.net>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Magnus Lindholm <linmag7@gmail.com>, 
	linux-perf-users@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 2:04=E2=80=AFAM Stian Halseth <stian@itx.no> wrote:
>
> This adds HAVE_PERF_REGS and HAVE_PERF_USER_STACK_DUMP to sparc64, so
> that perf record --call-graph dwarf and elfutils' eu-stackprof work
> there.
>
> Two things about the user stack dump do not fit in arch code. The
> sampled register window's %l/%i registers, which hold the frame pointer
> and return address the unwinder starts from, stay in the register file
> until a window spills. The kernel already flushes them wherever it
> exposes user stack memory (perf_callchain_user(), ptrace), but the stack
> dump has no arch entry point where that could happen. And a 64-bit
> sparc stack pointer is biased by 2047, so a dump that starts at the
> register value begins 2047 bytes below the frame, and is empty when that
> page has never been touched.
>
> Patch 1 therefore adds two hooks in the style of perf_arch_misc_flags(),
> both no-ops by default. Patch 2 is the sparc64 implementation and their
> user. Patch 3 teaches tools/perf the sparc registers and DWARF unwinding
> from the dump. The matching elfutils changes are attached to the
> tracking issue:
>
>   https://github.com/sparclinux/issues/issues/99
>
> Tested on an UltraSPARC T4-1 on 7.3-rc4: register values check out
> against known contents, --call-graph dwarf unwinds correctly for both
> cycles and cpu-clock, as does eu-stackprof, and perf stat/record/record
> -g are unchanged. Starting the dump at the stack's actual address
> matters in practice: with the dump at the biased register value, 94% of
> the user samples of xz -T4 had an empty stack dump; with this series,
> none do.
>
> Changes since v2:
> - Patch 1: add perf_arch_user_stack_pointer(), so an arch can start the
>   dump at the stack's actual address (sashiko review).
> - Patch 2: drop %g0 from the uapi, as trap entry does not save it; the
>   PC takes its slot, as on mips and loongarch (sashiko review).
> - Patch 2: start the dump at %sp + 2047 for a 64-bit stack (sashiko
>   review).
> - Patch 3: follow both, and comment the max_dwarf_reg adjustment (Ian).
>   Drop the memcpy() change to memory_read(), which the unbiased dump
>   start makes unnecessary.
>
> v2: https://lore.kernel.org/all/20260922201507.1719668-1-stian@itx.no/
> v1: https://lore.kernel.org/all/20260922135653.1622301-1-stian@itx.no/
>
> Stian Halseth (3):
>   perf/core: Let an arch prepare and locate the user stack dump
>   sparc64: Support PERF_SAMPLE_REGS_USER and PERF_SAMPLE_STACK_USER
>   perf tools: Support sparc user register samples and dwarf unwinding

For the series:

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

>  .../features/perf/perf-regs/arch-support.txt  |  2 +-
>  .../perf/perf-stackdump/arch-support.txt      |  2 +-
>  arch/sparc/Kconfig                            |  2 +
>  arch/sparc/include/asm/perf_event.h           |  5 ++
>  arch/sparc/include/uapi/asm/perf_regs.h       | 34 +++++++++
>  arch/sparc/kernel/Makefile                    |  2 +-
>  arch/sparc/kernel/perf_regs.c                 | 74 +++++++++++++++++++
>  include/linux/perf_event.h                    | 11 +++
>  kernel/events/core.c                          |  2 +
>  kernel/events/internal.h                      |  2 +-
>  tools/arch/sparc/include/uapi/asm/perf_regs.h | 34 +++++++++
>  tools/perf/arch/sparc/include/perf_regs.h     | 18 +++++
>  tools/perf/check-headers.sh                   |  1 +
>  tools/perf/util/dwarf-regs-arch/Build         |  1 +
>  .../util/dwarf-regs-arch/dwarf-regs-sparc.c   | 12 +++
>  tools/perf/util/dwarf-regs.c                  |  4 +
>  tools/perf/util/include/dwarf-regs.h          |  1 +
>  tools/perf/util/perf-regs-arch/Build          |  1 +
>  .../util/perf-regs-arch/perf_regs_sparc.c     | 67 +++++++++++++++++
>  tools/perf/util/perf_regs.c                   | 18 +++++
>  tools/perf/util/perf_regs.h                   |  5 ++
>  tools/perf/util/unwind-libdw.c                | 37 ++++++++++
>  22 files changed, 331 insertions(+), 4 deletions(-)
>  create mode 100644 arch/sparc/include/uapi/asm/perf_regs.h
>  create mode 100644 arch/sparc/kernel/perf_regs.c
>  create mode 100644 tools/arch/sparc/include/uapi/asm/perf_regs.h
>  create mode 100644 tools/perf/arch/sparc/include/perf_regs.h
>  create mode 100644 tools/perf/util/dwarf-regs-arch/dwarf-regs-sparc.c
>  create mode 100644 tools/perf/util/perf-regs-arch/perf_regs_sparc.c
>
> --
> 2.55.0
>
