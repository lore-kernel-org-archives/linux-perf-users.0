Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756F0347BA5
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 21:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776114113; cv=pass; b=s7mNevI+7e1DRr6Zudm4y34Wgv5YyzFOkezGeQFJz35nr1pChU45ixlrqxsCCP6ihUAzCkbH0+o5upK8lKgfGX1FpJ1FWWs10pQxGiFXZ4I27RvZv9795VPGZtfkTsqXyo6Kc+iB/IqPEJ9Ni5qchsUmtlbkjxAxPYS0iCURnpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776114113; c=relaxed/simple;
	bh=veGgXJ1h4//sMo9/vJooHgoWy+sdgaZUzLNXEfkZj84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qaW0T3ba8u1mWgCpbHeV1fDEMuif36CsrWbkbmt4DSRzj1finSZQ9LCHc/uuzCfY891fnXRG+UQdk66T0p0HxWDtacYkUR0A+v+REvm+SnmT6ONPCUN3GGLmo7L4iZ8Sfz0S09Qx97YJvIaP3FiaSj8Sc85cl5HyIL5klQG1EaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cWM1GGH0; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cWM1GGH0"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso153785ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 14:01:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776114111; cv=none;
        d=google.com; s=arc-20240605;
        b=B3FQsEF/0o9meg/BB3ueBa7XRMNMYHuJ5E42vHwr3kjq2n6HzEfWiuV6g4A52aT079
         JTDcpuW/zwOcubjmdfTfmB2ODlgZ/7XU022UEeRq3+gQ9NRMJuUFgdJqKY9VN/vAF4P3
         XDjg7fKOED3xi0lQi2uxLIQgKnxVdXxxbZhlqmVx42ZwmwYUM9nbNFvGnZ9CuEgXvz2F
         Md4jUQaxoqDPvd/A5f5qgs201m/I6J8U0s1FvpkQTW+mDPQW8JSpkFcm0I+Tr3PeM/fo
         TXsOutimdlNK9QmjI13B7kBa3b8QmmszNZOaaUD6QhZHDd7f2CNRj7vqsbLA2cgc/Nu0
         jbog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WC42rxO3vze6geTOuCaNxW1QdNNevD/rxpiV7DhI8F0=;
        fh=d+quX/I5KlEovcrY63bTmufYJwWqpOVz4wteEQh+cxc=;
        b=JOoda6oI5KEBeRE68zae8/yfZc/uKLuAryhxqSY40nKi3JruNbLHw42NYniZHG59WY
         JzJIzSMF9I3Qmsl+mmF9ADvlxh5w94jqyFa+vEL+Wep6+n80cO3vjWvMvgZuEKCHdQqI
         eqoOTeegY7aILFo2guhlyTySk05CwW02QHU8PWghjmse8rsxIB3CWXJP0xiIGqAxtPP0
         +0iIFRpR9PBKm2dkMP+SWWReLbKHDA3CjHZelJCNb5nYRXwnooLIL+o6aHL/1VNunVpd
         nmWMhb0AabXHrSHVFHa2RKz537Ab6j2SeozbWB8mymyRwfUA8I+VH1tiuVMgITQd9HX1
         2W/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776114111; x=1776718911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WC42rxO3vze6geTOuCaNxW1QdNNevD/rxpiV7DhI8F0=;
        b=cWM1GGH0JHSo0uQx3zJ9AeN45ERcjQ3E3wuxo8iETv+2Y7u48e4vTvnjKaX2qWc/5e
         pgSyMmlT1pMHPRHPJDUS5khGhXH/3I+ZpkEDQRhub+sZNhS0/U3xm9eWee38uRN8LMlU
         B8eX1XjCI+1Adl/eco8MKeaYGcYM2ZJfZxod8ohf8ycBaTkORrM0Z3yIOTXTZox3inbz
         doxs/VZIHgr5OlNiIdUWo+peTQEl9eJUH8cbEnmJambSvoDI21+2Q8BBLZIiKMu8a6fV
         RKpKAlsK1XBM5locpIyh4vZDiOhwI7LlvKZIZJsQ8ScPvKA3/ldLRpFxi5raqJFzFK9N
         oNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776114111; x=1776718911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WC42rxO3vze6geTOuCaNxW1QdNNevD/rxpiV7DhI8F0=;
        b=fB8+VDTgI1bdnc3U8YPL1vOMUGaNGPztBRPXM/gWs8uo/YOklt6+iovaUyLnsjEc4B
         6/UwDFBOjov9kKaWHkEJZmosdrGKE8QecQDQWgNuBIgCJ533IoLhbupfBA2rNrMQuKN8
         wIMbhXITWZbpdvwiRYQMD7xMypcTm537UTeiPZ/E3+Fk1tBUThZHdqShNsGGwOtBqKbo
         UUP268j2APejlRhgx1wMmqsgwGLTBBqqDanQ9dICuB+uczkhYB5hwdMeODCnk2t4Iw7L
         2mmtIO3yBDWqvtSLKJo+zWfyHX7C/ZuCame6pp7/TEA0+FPavZTS7KVoMH0+MdHX/Lf/
         QMrQ==
X-Forwarded-Encrypted: i=1; AFNElJ/k1YkHG1PWEgd0P6iv4z4yZYkARQPv7+d3iWKwHIqPWRMzlWaz+yvC9+66dBQc1pQk6bl6xFms2/ZO35zEjJzQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyYPbG2mPaXnzey7tYulm/mcvvO6n93x6JjrhxP2RQtS8QwhBn/
	2d3igAAJIJPN10zu5u7Hv74MRCqxdiAJYKmHTOBLHsGh3AGJeipJdB+rOauoQSLmQUZshvTSQgD
	2IdeodAHdlMxEqWT4QZm0bSHyfIehH6FnS3xXobYl
X-Gm-Gg: AeBDiev+5RKyib1bE8Ci6vms3pMV35OrQQrSQsZ/mlijGa8ifaxW01VCT4sgiA97ngg
	710b90VGar8rKkeBNYrZ0qjZSiYSJK/xwtLlt73k9uDcbvcxscqNbVdqM7rFwuGRLr3Rf7FTwv+
	MareT61G2DYa91bazzoRCizEjntItPLSZx5K68xFPRKa2+Y5UMiAzL2j563tI/6GqrJ8XtH77mw
	ptv7eFCkKhd2FDLjxCniR52pfJQzaIL86goEQUotejHJZuyDJNvbz6kW8WIj8hoi6guJtxf//vA
	+tPrKB5wD9zvxVXyv8ic2A1D10Hd6lYdnEnnmdS26rDUtvoQEGcvTZAc1mw=
X-Received: by 2002:a17:902:da8a:b0:2b4:5978:4caf with SMTP id
 d9443c01a7336-2b459785063mr4238255ad.4.1776114110197; Mon, 13 Apr 2026
 14:01:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <advv6twWCEVBo_Hc@x1> <20260413024805.1316480-1-irogers@google.com>
In-Reply-To: <20260413024805.1316480-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 13 Apr 2026 14:01:38 -0700
X-Gm-Features: AQROBzAuRGrI4uKYnZMOk3esVVqBEb2hWHXENTOlfcuxd81eG75b2IwGOrneAqc
Message-ID: <CAP-5=fW6pJWTW0zCHStuTNqvN8Q1FaVvRf_eqgB9RSK8xDDwbQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] perf libunwind multiple remote support
To: acme@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, alex@ghiti.fr, 
	alexander.shishkin@linux.intel.com, andrew.jones@oss.qualcomm.com, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, howardchu95@gmail.com, 
	james.clark@linaro.org, john.g.garry@oracle.com, jolsa@kernel.org, 
	leo.yan@linux.dev, libunwind-devel@nongnu.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org, 
	mingo@redhat.com, namhyung@kernel.org, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, shimin.guo@skydio.com, 
	tglozar@redhat.com, tmricht@linux.ibm.com, will@kernel.org, yuzhuo@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 12, 2026 at 7:48=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Fix the libunwind build for when libdw and libunwind are feature
> detected, currently failing with a duplicate symbol.
>
> Refactor the libunwind support so that whenever a remote target is
> available, perf functions using the ELF machine can use that remote
> target regardless of what the host/local machine is. Migrate existing
> libunwind supported architectures like powerpc, arm64 and loongarch so
> that they can work in a cross-architecture way. Add support for
> RISC-V. Make the code more regular in function names, etc. and avoid
> including a C-file. This increases the lines of code. It is similar in
> style to the unwind-libdw implementation. It is hoped that the more
> uniform nature of the code with help with refactoring the perf
> registers for SIMD/APX support.
>
> Aside from local host testing these patches are under tested, in part
> as I'm failing to see how to build libunwind with support for multiple
> remote targets. Please could I get help in testing.

Hmm.. these were reposted in part for Sashiko reviews but that has failed:
https://sashiko.dev/#/log/baseline/9180/2
```
Trying baseline: perf-tools-next/perf-tools-next
(4e03d6494f9504f8af46ba68a2a8b6877c196789)
Patch 9180/4 (ID: 24748) failed to apply.
Application failed.
```
While my local tree shows that I have perf-tools-next plus these 8
patches. I'll wait a while, rebase and repost.

Thanks,
Ian

> v4: Rebase, in particular the zalloc->calloc change conflicted.
>
> v3: Minor whitespace clean up and warn when a dynamic choice of libdw
>     or libunwind is selected for unwinding and support is missing (Arnald=
o).
> https://lore.kernel.org/lkml/20260404054032.1538095-1-irogers@google.com/
>
> v2: Move two fixes patches to position 1 and 2 in the series. Fix
>     struct naming inconsistency, Andrew Jones
>     <andrew.jones@oss.qualcomm.com>. Fix other inconsistencies and
>     potential non-x86 build issues.
> https://lore.kernel.org/lkml/20260305221927.3237145-1-irogers@google.com/
>
> v1: https://lore.kernel.org/lkml/20260224142938.26088-1-irogers@google.co=
m/
>
> Ian Rogers (8):
>   perf unwind: Refactor get_entries to allow dynamic libdw/libunwind
>     selection
>   perf build loongarch: Remove reference to missing file
>   tools build: Deduplicate test-libunwind for different architectures
>   perf build: Be more programmatic when setting up libunwind variables
>   perf unwind-libunwind: Make libunwind register reading cross platform
>   perf unwind-libunwind: Move flush/finish access out of local
>   perf unwind-libunwind: Remove libunwind-local
>   perf unwind-libunwind: Add RISC-V libunwind support
>
>  tools/build/feature/Makefile                  |  38 +-
>  tools/build/feature/test-libunwind-aarch64.c  |  27 -
>  tools/build/feature/test-libunwind-arm.c      |  28 -
>  .../test-libunwind-debug-frame-aarch64.c      |  17 -
>  .../feature/test-libunwind-debug-frame-arm.c  |  17 -
>  .../feature/test-libunwind-debug-frame.c      |   1 -
>  tools/build/feature/test-libunwind-x86.c      |  28 -
>  tools/build/feature/test-libunwind-x86_64.c   |  28 -
>  tools/build/feature/test-libunwind.c          |   1 -
>  tools/perf/Makefile.config                    | 215 ++---
>  tools/perf/arch/arm/util/Build                |   2 -
>  tools/perf/arch/arm/util/unwind-libunwind.c   |  50 --
>  tools/perf/arch/arm64/util/Build              |   1 -
>  tools/perf/arch/arm64/util/unwind-libunwind.c |  17 -
>  tools/perf/arch/loongarch/util/Build          |   3 -
>  .../arch/loongarch/util/unwind-libunwind.c    |  82 --
>  tools/perf/arch/mips/Build                    |   1 -
>  tools/perf/arch/mips/util/Build               |   1 -
>  tools/perf/arch/mips/util/unwind-libunwind.c  |  22 -
>  tools/perf/arch/powerpc/util/Build            |   1 -
>  .../perf/arch/powerpc/util/unwind-libunwind.c |  92 --
>  tools/perf/arch/x86/util/Build                |   3 -
>  tools/perf/arch/x86/util/unwind-libunwind.c   | 115 ---
>  tools/perf/builtin-inject.c                   |   4 +
>  tools/perf/builtin-report.c                   |   4 +
>  tools/perf/builtin-script.c                   |   4 +
>  tools/perf/util/Build                         |   5 +-
>  tools/perf/util/libunwind-arch/Build          |  11 +
>  .../perf/util/libunwind-arch/libunwind-arch.c | 319 +++++++
>  .../perf/util/libunwind-arch/libunwind-arch.h | 296 +++++++
>  .../perf/util/libunwind-arch/libunwind-arm.c  | 290 ++++++
>  .../util/libunwind-arch/libunwind-arm64.c     | 289 ++++++
>  .../perf/util/libunwind-arch/libunwind-i386.c | 312 +++++++
>  .../util/libunwind-arch/libunwind-loongarch.c | 297 +++++++
>  .../perf/util/libunwind-arch/libunwind-mips.c | 299 +++++++
>  .../util/libunwind-arch/libunwind-ppc32.c     | 301 +++++++
>  .../util/libunwind-arch/libunwind-ppc64.c     | 303 +++++++
>  .../util/libunwind-arch/libunwind-riscv.c     | 297 +++++++
>  .../perf/util/libunwind-arch/libunwind-s390.c | 299 +++++++
>  .../util/libunwind-arch/libunwind-x86_64.c    | 320 +++++++
>  tools/perf/util/libunwind/arm64.c             |  40 -
>  tools/perf/util/libunwind/x86_32.c            |  41 -
>  tools/perf/util/maps.c                        |  29 +-
>  tools/perf/util/maps.h                        |   4 +-
>  tools/perf/util/symbol_conf.h                 |  10 +
>  tools/perf/util/thread.c                      |  29 +-
>  tools/perf/util/unwind-libdw.c                |   2 +-
>  tools/perf/util/unwind-libunwind-local.c      | 831 ------------------
>  tools/perf/util/unwind-libunwind.c            | 679 ++++++++++++--
>  tools/perf/util/unwind.c                      |  98 +++
>  tools/perf/util/unwind.h                      |  77 +-
>  51 files changed, 4549 insertions(+), 1731 deletions(-)
>  delete mode 100644 tools/build/feature/test-libunwind-aarch64.c
>  delete mode 100644 tools/build/feature/test-libunwind-arm.c
>  delete mode 100644 tools/build/feature/test-libunwind-debug-frame-aarch6=
4.c
>  delete mode 100644 tools/build/feature/test-libunwind-debug-frame-arm.c
>  delete mode 100644 tools/build/feature/test-libunwind-x86.c
>  delete mode 100644 tools/build/feature/test-libunwind-x86_64.c
>  delete mode 100644 tools/perf/arch/arm/util/unwind-libunwind.c
>  delete mode 100644 tools/perf/arch/arm64/util/unwind-libunwind.c
>  delete mode 100644 tools/perf/arch/loongarch/util/unwind-libunwind.c
>  delete mode 100644 tools/perf/arch/mips/Build
>  delete mode 100644 tools/perf/arch/mips/util/Build
>  delete mode 100644 tools/perf/arch/mips/util/unwind-libunwind.c
>  delete mode 100644 tools/perf/arch/powerpc/util/unwind-libunwind.c
>  delete mode 100644 tools/perf/arch/x86/util/unwind-libunwind.c
>  create mode 100644 tools/perf/util/libunwind-arch/Build
>  create mode 100644 tools/perf/util/libunwind-arch/libunwind-arch.c
>  create mode 100644 tools/perf/util/libunwind-arch/libunwind-arch.h
>  create mode 100644 tools/perf/util/libunwind-arch/libunwind-arm.c
>  create mode 100644 tools/perf/util/libunwind-arch/libunwind-arm64.c
>  create mode 100644 tools/perf/util/libunwind-arch/libunwind-i386.c
>  create mode 100644 tools/perf/util/libunwind-arch/libunwind-loongarch.c
>  create mode 100644 tools/perf/util/libunwind-arch/libunwind-mips.c
>  create mode 100644 tools/perf/util/libunwind-arch/libunwind-ppc32.c
>  create mode 100644 tools/perf/util/libunwind-arch/libunwind-ppc64.c
>  create mode 100644 tools/perf/util/libunwind-arch/libunwind-riscv.c
>  create mode 100644 tools/perf/util/libunwind-arch/libunwind-s390.c
>  create mode 100644 tools/perf/util/libunwind-arch/libunwind-x86_64.c
>  delete mode 100644 tools/perf/util/libunwind/arm64.c
>  delete mode 100644 tools/perf/util/libunwind/x86_32.c
>  delete mode 100644 tools/perf/util/unwind-libunwind-local.c
>  create mode 100644 tools/perf/util/unwind.c
>
> --
> 2.53.0.1213.gd9a14994de-goog
>
