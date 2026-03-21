Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A272D97A6
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Mar 2026 03:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774062416; cv=pass; b=pyFnWGoIbP0Ycnr5xqQ/f3wyN2JnOoDPUf0yu5sXnwuYEuAzrr5T4hiKRrMlFqKTyUzI61mD0U7rVrinsUnWjJyH1nVvxoFNBQUBs2R404wZjCly8w1WrQML2EAQ6zVOndRlqbz62MRbwXlAbMIa3XqEpsHB4wh3qV+CPcTwLSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774062416; c=relaxed/simple;
	bh=ZmXlMo22Z3Dvmhae5AQ/0UkJCleBzbdRS82EzF3CqO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D4/P2cN7ov2dBaf2BESFIZI7K3AeX5rNWlWeAaW4lVfHfiEaHA3aND3PriSSr8EvsiFAm/bzDg93cRj9tgpnL2YmTEX0D9nqD523V0oF9qSjmV05H9coLjEBBUxR09jI7kA+DmFBDr+yGLywv5u+tdk4qbo4h4HwS1xrQKbV3rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gkHbX4/J; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gkHbX4/J"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b052562254so52775ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 20:06:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774062414; cv=none;
        d=google.com; s=arc-20240605;
        b=NzDwG2I8SQxw5q83hp4aF+sMBsUfhZBXnw6O6tw4jxL8jrxwxyljHvBiVvwAPoVJeU
         s7Ti/PRlwM9q0ndd5G+LmSoY6MEJmfRCXlqbph33J/aQh8ogjJzM03oHXsIaZ9O74cEE
         hSdUexQPcOJx5E6DC4lx4L+QWq4aD/aXJtdlFZA3CesXR7C9BIJesLU+zdx6ZC+kq65c
         p19Sb8WactyLDMUC2KaVGpmlX5/1Zmi/20THWWKWK42XrOLlEzoswN8ZZ6XAnSZBt5Zo
         p2C4Nd66sQXnSpYpSMM0w16jSukRxeLBC+XpQM2yxztwbL3ldQVrVCKPjiT6Wf7ZaDYt
         axUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G1u2A7Wmr7+BgkJQ4sTGR6krxwXZYsSpdKl+44diHvM=;
        fh=J0CNbHyxwjzQ0cq5HTJFWARcX7z8CHM090y4zdyrLYc=;
        b=GZictlfunI/Ho/aGtvHSKyF78XAKZ6D5uCMqf52eRQI8pZVEiI6M0YR4xk0t4h9LgG
         QL8B9Qzi3FoKtEKev6kG+333NFwGMJBjix8Jm0JT8FRwOekzuAwaUwoJJP8ELPaxynQr
         X0UO7iLPfdxYHQvl2VrmrrQKf/euJroISVhyzMbHfLuJ9GbStcwdW+tx8+bMA0tp54UB
         m7hf0j5PLkmWxweQS6KPWQwzAeO2ffYDF3ycbPDMxLRhrAdre32IrnWGiGq1vWLzU9pH
         nK/GsW3UcmqZZOliU+DKgFGqTFQTQ7/hv1yG8kHs8A/NV7YEovGTXOgmUZjFZyO2k2mu
         VKUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774062414; x=1774667214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1u2A7Wmr7+BgkJQ4sTGR6krxwXZYsSpdKl+44diHvM=;
        b=gkHbX4/JXrbUi88qrOCupjz6ah203r2+v9NzRxJFpGar51ZHqbHQ309WNbyGEiJbmI
         5W+PRtukw4EBI9cXe59O6foOCG0ExkiD8LOl0u/ieRtZkr4lW/OQtImHgP3cok74VcNy
         lQLbuz7W99Jfm6fJDGfoXAlurj3ySpHfEXsHx94/KyQEFsLgHSeh/v0HJAUXASF7TCjw
         0lWLTdElpXuNWVWIwXmw0skBvazr78CqPIpekARvbgjltJw9mxOdoiMeTqas8ezQpCnJ
         buqDVc0RYH9jhWN4NtM5tk6QCp2LBeEmJn83AWVeT5cEqDJNKOEH4QGZxoLMi+1baYLv
         KIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774062414; x=1774667214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G1u2A7Wmr7+BgkJQ4sTGR6krxwXZYsSpdKl+44diHvM=;
        b=EphSk4DAvu88Wn7q8moMrJ9KMZ/OrMImIdXtz2d5b3h+l1S4Jx2XSAnes7vqyeSi2H
         I2YB5y926090LHig4gN417R+gRy1SVyvPZ2LM1REZvNKkiaPAxtK/CfX8pyE0t/D45Ls
         ghGZrquMqnNhCMzFB6VCgvuQtkQTXAvQILC43+c5mUa+svmjvuoXSIeezTm/QKM8d6Jy
         KumLZEG1aSoYOWUgp5jtHJNYJPGMRvOJGV3Q4IBWCJC4T/N3Vwpq7StWfFdp9BEHUTiI
         7lBSH91arxExcCmiOKmW4Xu3ZW3KGiLHpfrmhNrRHhTRU+mGdXa7qGMR0IfLgz4tNEyn
         kxlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLw+r7DdAHZuxvbbbUFxua3Ex1nY5hYD3crsiL1cWWgiMYNsbbtWHgbfW1nzlSaZdpLKnfnon3eqjV+UB34t3Y@vger.kernel.org
X-Gm-Message-State: AOJu0YzGW0/RG/hXxBbviHRnUs4zEaAJmfZ5vfxm/qHClTVfVBp/kKfO
	isxKdFFK3dx2XHGOGqG/5aOlhDcOMBQaNUzu90x9G1CciNn2f1qyZdQ8cZsF4B/rru/+w4xFcDd
	30hB8ecwPphJiT/TBdwSoFNqRVgml6QpBHqHXk6td
X-Gm-Gg: ATEYQzxxYr+UGaSm4U1XwcRnp5OL3NjbHc4tNa5DncXUgzhq9Q7lxAHDELfB25tdOzb
	3t9oF4fn1VrAhLOnuz6Vjn0dWlmfXLkLEaiTMDWAvnGMOb/eIJ0FNkyYUnfb+e6NYBwJzMFW8HW
	Fbax+KsG8KUQP4GP5eqMHx5NupSOG9oblnNSxGk4xQvN3w4VnADwFJqk7rI3SmcYzuwwuXt0gqm
	NRTD7kAEVO19YAonOllcS9H4FwbJQPS106OnCCloUTNhKNMDyIFOlUaltwhYYrLe+fu25yS18e5
	J1F69fqm
X-Received: by 2002:a17:903:1b2b:b0:2ad:6f9b:3b2e with SMTP id
 d9443c01a7336-2b08c46bb85mr1193195ad.23.1774062414044; Fri, 20 Mar 2026
 20:06:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fWVU3ktkGAnZQrjQJf+Z5AtQo73BVUhj-nr3H95GdcEJQ@mail.gmail.com>
 <20260305221927.3237145-1-irogers@google.com> <abxs-2rozL1tBEO1@google.com>
In-Reply-To: <abxs-2rozL1tBEO1@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 20 Mar 2026 20:06:42 -0700
X-Gm-Features: AaiRm50GKgA2m097_r_LRBfJe7uc84BV7Ex9dBKU2eCRmJOWzuBOeVNhLtt3CGs
Message-ID: <CAP-5=fVEKifx7VZJAsoPFguMPipW66k-06vgb9iE2oO6GxSxdw@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] perf libunwind multiple remote support
To: Namhyung Kim <namhyung@kernel.org>, Guilherme Amadio <amadio@gentoo.org>
Cc: 9erthalion6@gmail.com, acme@kernel.org, adrian.hunter@intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	andrew.jones@oss.qualcomm.com, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, 
	blakejones@google.com, ctshao@google.com, dapeng1.mi@linux.intel.com, 
	howardchu95@gmail.com, james.clark@linaro.org, john.g.garry@oracle.com, 
	jolsa@kernel.org, leo.yan@linux.dev, libunwind-devel@nongnu.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org, 
	mingo@redhat.com, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	shimin.guo@skydio.com, tglozar@redhat.com, tmricht@linux.ibm.com, 
	will@kernel.org, yuzhuo@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 2:39=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hi Ian,
>
> On Thu, Mar 05, 2026 at 02:19:19PM -0800, Ian Rogers wrote:
> > Fix the libunwind build for when libdw and libunwind are feature
> > detected, currently failing with a duplicate symbol.
> >
> > Refactor the libunwind support so that whenever a remote target is
> > available, perf functions using the ELF machine can use that remote
> > target regardless of what the host/local machine is. Migrate existing
> > libunwind supported architectures like powerpc, arm64 and loongarch so
> > that they can work in a cross-architecture way. Add support for
> > RISC-V. Make the code more regular in function names, etc. and avoid
> > including a C-file. This increases the lines of code. It is similar in
> > style to the unwind-libdw implementation. It is hoped that the more
> > uniform nature of the code with help with refactoring the perf
> > registers for SIMD/APX support.
> >
> > Aside from local host testing these patches are under tested, in part
> > as I'm failing to see how to build libunwind with support for multiple
> > remote targets. Please could I get help in testing.
>
> It seems libunwind project is not actively maintained.  Assuming libdw
> unwinding is performant enough, we may want to get rid of libunwind
> support.

Guilherme, is it true that libunwind is built into perf with Gentoo?

The performance fix for unwinding with libdw is in commit
6b2658b3f36a ("perf unwind-libdw: Don't discard loaded ELF/DWARF after
every unwind") that is currently only in v7.0-rc[1-4].

In commit 13e17c9ff49119aa ("perf build: Make libunwind opt-in rather
than opt-out"), perf made libunwind opt-in rather than opt-out. This
change is in v6.13.

LLVM has a libunwind project but LLVM scares me because its library
dependencies are so large.

Perhaps we should merge these changes and then delete the libunwind
support in 2 or 3 releases time. I believe this is closer to how
libbpf deprecated the pre-1.0 behaviors. Personally I don't mind if we
just delete everything now, but typically we're not that aggressive.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > v2: Move two fixes patches to position 1 and 2 in the series. Fix
> >     struct naming inconsistency, Andrew Jones
> >     <andrew.jones@oss.qualcomm.com>. Fix other inconsistencies and
> >     potential non-x86 build issues.
> >
> > v1: https://lore.kernel.org/lkml/20260224142938.26088-1-irogers@google.=
com/
> >
> > Ian Rogers (8):
> >   perf unwind: Refactor get_entries to allow dynamic libdw/libunwind
> >     selection
> >   perf build loongarch: Remove reference to missing file
> >   tools build: Deduplicate test-libunwind for different architectures
> >   perf build: Be more programmatic when setting up libunwind variables
> >   perf unwind-libunwind: Make libunwind register reading cross platform
> >   perf unwind-libunwind: Move flush/finish access out of local
> >   perf unwind-libunwind: Remove libunwind-local
> >   perf unwind-libunwind: Add RISC-V libunwind support
> >
> >  tools/build/feature/Makefile                  |  38 +-
> >  tools/build/feature/test-libunwind-aarch64.c  |  27 -
> >  tools/build/feature/test-libunwind-arm.c      |  28 -
> >  .../test-libunwind-debug-frame-aarch64.c      |  17 -
> >  .../feature/test-libunwind-debug-frame-arm.c  |  17 -
> >  .../feature/test-libunwind-debug-frame.c      |   1 -
> >  tools/build/feature/test-libunwind-x86.c      |  28 -
> >  tools/build/feature/test-libunwind-x86_64.c   |  28 -
> >  tools/build/feature/test-libunwind.c          |   1 -
> >  tools/perf/Makefile.config                    | 215 ++---
> >  tools/perf/arch/arm/util/Build                |   2 -
> >  tools/perf/arch/arm/util/unwind-libunwind.c   |  50 --
> >  tools/perf/arch/arm64/util/Build              |   1 -
> >  tools/perf/arch/arm64/util/unwind-libunwind.c |  17 -
> >  tools/perf/arch/loongarch/util/Build          |   3 -
> >  .../arch/loongarch/util/unwind-libunwind.c    |  82 --
> >  tools/perf/arch/mips/Build                    |   1 -
> >  tools/perf/arch/mips/util/Build               |   1 -
> >  tools/perf/arch/mips/util/unwind-libunwind.c  |  22 -
> >  tools/perf/arch/powerpc/util/Build            |   1 -
> >  .../perf/arch/powerpc/util/unwind-libunwind.c |  92 --
> >  tools/perf/arch/x86/util/Build                |   3 -
> >  tools/perf/arch/x86/util/unwind-libunwind.c   | 115 ---
> >  tools/perf/builtin-inject.c                   |   4 +
> >  tools/perf/builtin-report.c                   |   4 +
> >  tools/perf/builtin-script.c                   |   4 +
> >  tools/perf/util/Build                         |   5 +-
> >  tools/perf/util/libunwind-arch/Build          |  11 +
> >  .../perf/util/libunwind-arch/libunwind-arch.c | 319 +++++++
> >  .../perf/util/libunwind-arch/libunwind-arch.h | 296 +++++++
> >  .../perf/util/libunwind-arch/libunwind-arm.c  | 290 ++++++
> >  .../util/libunwind-arch/libunwind-arm64.c     | 289 ++++++
> >  .../perf/util/libunwind-arch/libunwind-i386.c | 312 +++++++
> >  .../util/libunwind-arch/libunwind-loongarch.c | 297 +++++++
> >  .../perf/util/libunwind-arch/libunwind-mips.c | 299 +++++++
> >  .../util/libunwind-arch/libunwind-ppc32.c     | 301 +++++++
> >  .../util/libunwind-arch/libunwind-ppc64.c     | 303 +++++++
> >  .../util/libunwind-arch/libunwind-riscv.c     | 297 +++++++
> >  .../perf/util/libunwind-arch/libunwind-s390.c | 299 +++++++
> >  .../util/libunwind-arch/libunwind-x86_64.c    | 320 +++++++
> >  tools/perf/util/libunwind/arm64.c             |  40 -
> >  tools/perf/util/libunwind/x86_32.c            |  41 -
> >  tools/perf/util/maps.c                        |  29 +-
> >  tools/perf/util/maps.h                        |   4 +-
> >  tools/perf/util/symbol_conf.h                 |  15 +
> >  tools/perf/util/thread.c                      |  29 +-
> >  tools/perf/util/unwind-libdw.c                |   2 +-
> >  tools/perf/util/unwind-libunwind-local.c      | 832 ------------------
> >  tools/perf/util/unwind-libunwind.c            | 679 ++++++++++++--
> >  tools/perf/util/unwind.c                      | 102 +++
> >  tools/perf/util/unwind.h                      |  56 +-
> >  51 files changed, 4536 insertions(+), 1733 deletions(-)
> >  delete mode 100644 tools/build/feature/test-libunwind-aarch64.c
> >  delete mode 100644 tools/build/feature/test-libunwind-arm.c
> >  delete mode 100644 tools/build/feature/test-libunwind-debug-frame-aarc=
h64.c
> >  delete mode 100644 tools/build/feature/test-libunwind-debug-frame-arm.=
c
> >  delete mode 100644 tools/build/feature/test-libunwind-x86.c
> >  delete mode 100644 tools/build/feature/test-libunwind-x86_64.c
> >  delete mode 100644 tools/perf/arch/arm/util/unwind-libunwind.c
> >  delete mode 100644 tools/perf/arch/arm64/util/unwind-libunwind.c
> >  delete mode 100644 tools/perf/arch/loongarch/util/unwind-libunwind.c
> >  delete mode 100644 tools/perf/arch/mips/Build
> >  delete mode 100644 tools/perf/arch/mips/util/Build
> >  delete mode 100644 tools/perf/arch/mips/util/unwind-libunwind.c
> >  delete mode 100644 tools/perf/arch/powerpc/util/unwind-libunwind.c
> >  delete mode 100644 tools/perf/arch/x86/util/unwind-libunwind.c
> >  create mode 100644 tools/perf/util/libunwind-arch/Build
> >  create mode 100644 tools/perf/util/libunwind-arch/libunwind-arch.c
> >  create mode 100644 tools/perf/util/libunwind-arch/libunwind-arch.h
> >  create mode 100644 tools/perf/util/libunwind-arch/libunwind-arm.c
> >  create mode 100644 tools/perf/util/libunwind-arch/libunwind-arm64.c
> >  create mode 100644 tools/perf/util/libunwind-arch/libunwind-i386.c
> >  create mode 100644 tools/perf/util/libunwind-arch/libunwind-loongarch.=
c
> >  create mode 100644 tools/perf/util/libunwind-arch/libunwind-mips.c
> >  create mode 100644 tools/perf/util/libunwind-arch/libunwind-ppc32.c
> >  create mode 100644 tools/perf/util/libunwind-arch/libunwind-ppc64.c
> >  create mode 100644 tools/perf/util/libunwind-arch/libunwind-riscv.c
> >  create mode 100644 tools/perf/util/libunwind-arch/libunwind-s390.c
> >  create mode 100644 tools/perf/util/libunwind-arch/libunwind-x86_64.c
> >  delete mode 100644 tools/perf/util/libunwind/arm64.c
> >  delete mode 100644 tools/perf/util/libunwind/x86_32.c
> >  delete mode 100644 tools/perf/util/unwind-libunwind-local.c
> >  create mode 100644 tools/perf/util/unwind.c
> >
> > --
> > 2.53.0.473.g4a7958ca14-goog
> >
