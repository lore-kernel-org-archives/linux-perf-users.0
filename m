Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E7115A85A
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 01:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775869512; cv=pass; b=HzrbzyqrbycSOizR0w4V3sYBsgWM1s8xQjSYXJu5MR4EGiM26Z2p+xtLt+nAhmVJ3nBA5sXpPuxdYta1ZrZQ07HckgQCVOGqnM9gI7K13EP9LMEicaM2YopxUDiGRKQ0DrDiEjLBPsN6DYsRBcCWAscVpMMcZDFEbK3hRXA0N6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775869512; c=relaxed/simple;
	bh=g4HUMDfgxaemdtPfmfp0DxPsT/dOSpTAOM8iQhYaiJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LIHaRI2yzTyktzepu+OdFgHBbc9VfncQyiDSJEnNHrGpJk8n2Z2gYK879bN5rVDdcMa1JTC8AdHQIxL2fmhGWc7kOLKeIb3mLIOUJAGL+ueoFwFVoEdV3EaAoiBWR6/KpX+Szy0TytrAtU3xrt8E8w1w782cTm1ud6YMXCTXEwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZVzKiLNi; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZVzKiLNi"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b0c12be0ecso266495ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 18:05:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775869511; cv=none;
        d=google.com; s=arc-20240605;
        b=KUCIZtXWDWPfdLa5pVnQL9SdfUZLzc+zih3JG2cGeK9sySBUeZiRKcZB8d7c5bKmRL
         l/V8TBZpplBPSdo/kmsfOvvEmnhOhmS/c1CrHknie9tEl/FVIW0Fv+VRelCDi3jEHTLy
         FPTtbCUpnZ/mi/vv1OSqq1aZCQdC12qVl4O2oDNoJ9G+vraHaWu8Yj3n68eGXGYt7jYL
         ifIZ6Ze4st6XScXrOig6h6wqmeZRjyz91oIaV6P8KuZ8MSbgd8SSvG1GiSzdh5ksMqSS
         LGqWzgmSxn0Sfnmt+h9e9HZPYfzMyL8CGYWPaFbgDES/YkhSDmw/sFGY8j4o9gHAYnoo
         Pc3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5uUkoCeVRblw7zUWJdM9ekrZvgfUtRileoapKEzjQbY=;
        fh=Usizf1Fq6y5NYgar3ToFQGXu1CbC2h4n/FCc1lmGuyI=;
        b=bj7FzCCrIXgkX/nbAq1AEiw+aXlH2FCjOzgYDTTn9J1kTzrCn2pDyFSrF4BlQ4UnfS
         mmDVpZEf/PVA3COAGVHD6wbmpgmSFBaiF1Sc3LpNRctyKGfZ//ypAfEHyLgetUqT3KxK
         D1Y8/L/W26groFc3Zp7QScY2zsQ4Z++4dtHyGVzeOD6zpKAhyZyGskoLjn/cveis50mY
         CSZu1KdwrLEkpBwkap4SH6q1ht79RJsk6C9keF5unpPvotydX0yzKEknNc3Xs7nP0xhP
         yJ2dPmo8srzBM9fo7t212G8lgR15nKJATPbH6WbvJ3uDhwLIKAXYlOi5ycxhridvLM36
         4Vew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775869511; x=1776474311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5uUkoCeVRblw7zUWJdM9ekrZvgfUtRileoapKEzjQbY=;
        b=ZVzKiLNidqKjhKstgPceH3vbwll8AlZ3PqBqVbvYaLqmwItYa28atzJK8QBJOvAJQr
         otxBSilHseyLGiPtSRnLhtQUh5DP0MQa2bs1WPuwMwJ2WyE5+jR+3Sq5pNW3xVXQs/XB
         qI43DWKsKJ71Fy2Msgx1lNsL868lw4jzwpShOaik3RvaBCGY1lhDcXltnCYs+C4mexTF
         NkCIKZis2mjv6ecm9UhxVzm6ES7Rwn+Q0+BBMicOMRtSUKnAxJUsCaZhvUx4ju64g/JX
         87fLyWXM/7n9/IAnAZ1plRhLgZfmOL8KAvbpbvfVsZ6AhfKvAQhP+KCORZQEJx7A4JcG
         WRog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775869511; x=1776474311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5uUkoCeVRblw7zUWJdM9ekrZvgfUtRileoapKEzjQbY=;
        b=WmhcpYgsv4ARLS3RuUgqnlR8BItJUl+UhmZxlwuoOEg13YQRpio5GNxGqUdFImxWMP
         Gz3c+CQVSUdt3vEY7CKSdqKOqkbbutj/tRggOjXfhOeHUXjMUHIPuJE4dLbnAQop3H9e
         xVbbpnGKp3S3i10074VxPFdJbC02Ueh7D67FN/cXRIQ/2AzGl3F/DEybgjV5DYaDYsM5
         dnbFYo+ghbAV/lEouI1UQ/r6JplIorioL5LIIGHE63duN2nPqzvg7Y+TVYZNalWemF8B
         BXytdXQOkUbSGkIgNS24k+ZipzBsxdMUJRMuhqz8YtUXo3+81LNVgYy/0giC3g/6Ed3i
         IBPg==
X-Forwarded-Encrypted: i=1; AJvYcCWTzsznxHOrnrufkxHQ6gda6nGbXkxMskQVWKzfAoeDXygH7snxDwxmJkU14fmca/EL9qFfCH9CzhLExz+k552k@vger.kernel.org
X-Gm-Message-State: AOJu0YzkIVjkaUCT9IRweznycMQ0Yl5OmSr4viU/WSmJJCFVfY8R+uqF
	tzvTAzUa5EZIt7aC/M/HnqFiPvDG1tlIgr5jgI+gtJ24zrUmBJuTwo72LGjl9Epv9NBOv4JB+Pc
	48qIm7K8V0HvSSoWu3wT8XcgtTQx/0PcwncMdKozF
X-Gm-Gg: AeBDievIhsKx73XJRuO1XPiOfMY0CgB7iy2bp7mCEGPr+bUzXGxhsai4P9K/PW/9bgo
	rTWcX7Qy6CGU8nv63UPSNT0KDDUbcSVM66wFnIvJO63Msy8aRZGS+hl10tEQxw/UmsPnRq10Ydp
	hLtyySAa2BJ3esAuKX7an8HUyR4x1fFEmm4bLgZS7qeQe6iwLNyRQDTTJNRS9mkJxWcuZrDn5CY
	gOutT/w/o4POz/ixQu3XletJ7ohnhjedcKjuLHmKECZZyagTRlCA5Pk+H4VjmDjVOmqPyHqLA7P
	wne9/xKZ6gKLxxWVt7fG1xcxR2uPdw==
X-Received: by 2002:a17:903:2b0f:b0:2b0:5e19:1862 with SMTP id
 d9443c01a7336-2b2c8c74a19mr8024825ad.5.1775869509864; Fri, 10 Apr 2026
 18:05:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305221927.3237145-1-irogers@google.com> <20260404054032.1538095-1-irogers@google.com>
In-Reply-To: <20260404054032.1538095-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 10 Apr 2026 18:04:57 -0700
X-Gm-Features: AQROBzCtgctYT5mXdJK7EI3KpOUNV_dJ28NxpQWANsDrRDgoBgsKRGHzUd38rjo
Message-ID: <CAP-5=fUz60Guq_gVV6wb_FfwhPs-fUN+PAbB3rQn3pycXbF3DA@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] perf libunwind multiple remote support
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

On Fri, Apr 3, 2026 at 10:40=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
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
>
> v3: Minor whitespace clean up and warn when a dynamic choice of libdw
>     or libunwind is selected for unwinding and support is missing (Arnald=
o).

Hi Arnaldo,

anything else outstanding from this series?

Thanks,
Ian

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
>  tools/perf/util/unwind-libunwind-local.c      | 832 ------------------
>  tools/perf/util/unwind-libunwind.c            | 679 ++++++++++++--
>  tools/perf/util/unwind.c                      |  98 +++
>  tools/perf/util/unwind.h                      |  77 +-
>  51 files changed, 4549 insertions(+), 1732 deletions(-)
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
