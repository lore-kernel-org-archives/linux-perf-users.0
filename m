Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BA418732A
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 17:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729099332; cv=none; b=pz4VsRmysW5gjuaemITo87b+wG4viXtm+Q0voeBh2q+4pXQBqexJtuMX+JrYdV65+hK6cX99FhprvWqe1o2M+FXMCGeRYFjWXByysN2AGTSxEvuJAbIY3GXJnJWivng7ArAX8xvJLj9xXX+rgSdOqohGI4qcqZFaGxfMWc7yzJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729099332; c=relaxed/simple;
	bh=p58YBz3mCPXRx1C11mdVr8nwYV1zD8w5IVKOwatxwVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Pk1B2+COqiYdUiW9jMvSFTRRV0ZgGxpqdRREo9KhtNzpSeqUJrQbiJ0t+1GDEI6RODT15dnO26oYZWr8D5jhe+L8LD/ecgWk34imZLn2eWoigcfoP9JUzkywb7GHqWCmiuuiDgscx+HDjc19atYDmumpYihHmeU0iJ0hyGeU168=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EVmS0PGB; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EVmS0PGB"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-45fb0ebb1d0so14791cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 10:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729099329; x=1729704129; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zj4BpFF+3EfK+Q7KXtfS5PCqNKdGjX8auqgD68MCSp4=;
        b=EVmS0PGBXCFACvmHpk/SZaVRk+ECkTRVYwGZqU0CkAE0RQ2oyS69K24DMMHM4NiVNi
         Kyez95jYZXhh5XyuPKWSnHqr5BDx0smhzAtvHH3OpYE49+CSE24ZrS1lJ+ZcbTAi5Agr
         widrJ+mliQcj+MhB+e09c1yu056ftCoFTlAepTSiY3FbwlIX4tOHpbNZBCV5cnqma3aH
         eRWTzKOBATwiC4x0bvTVKpTX5hPLncJPX7LlJZHupbIBNv3EGSe8kUqM7MVm+s23SPM2
         tTyrb1EOlv8Z+Y+gFzyx4yjmsrzdUh2V7/Mok/rWOWYEr1SNWDy6qorcoScU6MBFLUtN
         uNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729099329; x=1729704129;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zj4BpFF+3EfK+Q7KXtfS5PCqNKdGjX8auqgD68MCSp4=;
        b=XpxYTS6m7akdRU7SeBJ4suwwd9pO7vYvqrBVjgaopbWxF8yTtA5MAZivXP2At4QsIR
         UOz8HGWiXvISgIhIgpbsTTjDCPzAh08VXzHCdch/9JHMXBTePkUFVApG2D9rF7ShrxL4
         vuB3UXfWr5yexxuDQJoHrPYYQnp3kSlJBTk7e8nBslNfAxaPWHKCopMeJB8WVS/LE0qE
         Mliav/IGztQZUeR2+XzyJX9BPdOfkPoZ94zMSyiNxB5gEmohYw7touat2T+Dis9RUffO
         kz4PJfMwwTmYPbdJLvE8wGJ6t7XCyp1VHfRLnMeUcPqpTstV7HPcr3X6yNJM4QVovDvI
         cZIg==
X-Forwarded-Encrypted: i=1; AJvYcCUC3vwp89ccrPzeO3x5Pk4TvI2Kl9R5Wu9BCjL8j5l3x6YV4a2cv8mjaRMCjm9GPQxYHgXu9S6B+YHVPnvuhzLg@vger.kernel.org
X-Gm-Message-State: AOJu0YznickDIa4q3yIAAXwOvtcc0Nu9XYIaA6paiHa9WPGxzPB8bYvD
	XljEKv3V7g4Y5jkOclhiPvrqRRC7sudr76qKJQKrAbrWyMdThKyuezTs+oGKmiec5U28QGfWEjl
	fZVXid+BjMz+Yoy2vVW7KgPajztZ4uVo+zHUx
X-Google-Smtp-Source: AGHT+IFUP4wwgDPU5xadFsW2+YtAxm/ZRXMJCUO2VUwq3pewJ3T2QBLtcH9PvvF/iU6uJ9WXqPBDfTPSkeLB94Bg/as=
X-Received: by 2002:a05:622a:4512:b0:45f:924:6bcd with SMTP id
 d75a77b69052e-4608dbdc93emr6646781cf.22.1729099329189; Wed, 16 Oct 2024
 10:22:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005195541.380070-1-irogers@google.com>
In-Reply-To: <20241005195541.380070-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 16 Oct 2024 10:21:55 -0700
Message-ID: <CAP-5=fVZH3L-6y_sxLwSmT8WyMXDMFnuqUksNULdQYJCPNBFYw@mail.gmail.com>
Subject: Re: [PATCH v2 00/31] Libdw/dwarf build clean up
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Nick Terrell <terrelln@fb.com>, 
	"Steven Rostedt (Google)" <rostedt@goodmis.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Guilherme Amadio <amadio@gentoo.org>, Changbin Du <changbin.du@huawei.com>, 
	Daniel Bristot de Oliveira <bristot@kernel.org>, Daniel Wagner <dwagner@suse.de>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@rivosinc.com>, 
	Shenlin Liang <liangshenlin@eswincomputing.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Steinar H. Gunderson" <sesse@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Chen Pei <cp0613@linux.alibaba.com>, Dima Kogan <dima@secretsauce.net>, 
	Yury Norov <yury.norov@gmail.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 12:55=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> There patches are on top of:
> https://lore.kernel.org/lkml/20240924003720.617258-1-irogers@google.com/
> where it was pointed out that a lot of the libdw conditional
> compilation was due to features that have now been standard for 10 or
> 15 years. The patches remove the conditional compilation assuming the
> features are in libdw where the feature test is expanded to check
> there pressence.
>
> In the Makefile code, and for `perf record --call-graph`, dwarf tends
> to mean unwind or libdw support for dwarf things. To make it clearer
> when dwarf really just means libdw numerous build variables and
> defines are renamed. PERF_HAVE_DWARF_REGS was particularly tricky and
> has been removed as it isn't necessary as was somewhat inversely
> guarding libdw support. The Makefile variable indicated an
> architecture having a dwarf-regs.c file. This file contained code for
> BPF prologues, which were removed with BPF event support. The files
> also often just contained a redundant get_arch_regstr function. The
> function was redundant as get_dwarf_regstr would do the appropriate
> thing if the ELF machine were given. To remove get_arch_regstr the ELF
> machine is computed for the host machine. This now makes the logic
> work across platforms, but the testing I was able to do across
> platforms was minimal.

It would be nice if these patches could land as they remove quite a
bit of code and complexity. To recap:

1) there are initial patches trying to renaming dwarfy things to libdw
things to be more intention revealing. There was some initial concern
wrt PERF_HAVE_DWARF_REGS and so the series has now removed that
variable as explained next. I believe landing the first part of the
patches was agreed upon as okay (Masami/Namhyung).

2) PERF_HAVE_DWARF_REGS indicated the presence of dwarf-regs.c in the
arch directory. dwarf-regs.c provided upto 3 functions:

2.1) regs_query_register_offset would translate a register name into a
pt_regs offset and was used by BPF prologues. BPF prologues existed
for BPF events and support for these was removed many releases ago.
This code was dead and could be removed.

2.2) get_arch_regstr duplicated get_dwarf_regstr and so it could be
removed as Masami agreed:
https://lore.kernel.org/lkml/20241007171942.e96d5c520e065bbe4cf8ae5f@kernel=
.org/
The case for csky was a little more complicated as the ABI controlled
the string. The callers of get_dwarf_regstr were updated to also pass
the ELF flags so that on csky the appropriate table could be used. As
the argument is only used on csky this a no-op for everything else.

2.3) get_arch_regnum translated a register name back to a dwarf number
and only existed on x86 where "al", "ax", "eax" and "rax" could all
mean register 0. This code was moved to util with similar
machine/flags logic to get_arch_regstr and for consistency with it.

2.2 and 2.3 required the wiring through of the ELF machine and flags
in callers to get_dwarf_regstr and get_dwarf_regnum. When these values
weren't dependent on an ELF file a new EM_HOST and EF_HOST were added
to give the host ELF machine and flags. These 2 #defines got rid of
the existing separate arch files and #ifdefs.

So what's changed? On most architectures we're now passing ELF flags
to get_dwarf_regstr/regnum but these are unused unless we're on csky.
There's the get_dwarf_regstr simplification in 2.2, but I think we're
agreed that's fine. For 2.3 most of the concern seemed to be whether
we should put it in the arch directory or util, I prefer util so that
cross-platform perf.data recording/reporting is supported. Other than
this there was a call for demonstrating what happens with the wiring
up the cross-platform ELF machine/flags. To some extent this worked
before this series, this series really just fixes the plumbing so it
will work in more EM_NONE machine type cases, etc. Fixing
cross-platform isn't the intent of the series, cleaning up the code
base is, so I don't think this should gate landing the work. The code
is all well tested on the normal non-cross-platform case.

Removing 21 files, 703 lines of code and making the build variables
and defines more intention revealing feels like progress, so I'd like
for this to land.

Thanks,
Ian

> There is some tech debt in the changes as perf check still reports the
> values using the old name and for features that are no longer
> tested. This can be cleanup for another day.
>
> v2: Instead of renaming PERF_HAVE_DWARF_REGS to PERF_HAVE_LIBDW_REGS,
>     remove it.
>
> Ian Rogers (31):
>   perf build: Fix !HAVE_DWARF_GETLOCATIONS_SUPPORT
>   perf build: Rename NO_DWARF to NO_LIBDW
>   perf build: Remove defined but never used variable
>   perf build: Rename test-dwarf to test-libdw
>   perf build: Combine libdw-dwarf-unwind into libdw feature tests
>   perf build: Combine test-dwarf-getlocations into test-libdw
>   perf build: Combine test-dwarf-getcfi into test-libdw
>   perf probe: Move elfutils support check to libdw check
>   perf libdw: Remove unnecessary defines
>   perf build: Rename HAVE_DWARF_SUPPORT to HAVE_LIBDW_SUPPORT
>   perf build: Rename CONFIG_DWARF to CONFIG_LIBDW
>   perf bpf-prologue: Remove unused file
>   perf dwarf-regs: Remove PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET
>   perf dwarf-regs: Add EM_HOST and EF_HOST defines
>   perf disasm: Add e_machine/e_flags to struct arch
>   perf dwarf-regs: Pass accurate disassembly machine to get_dwarf_regnum
>   perf dwarf-regs: Pass ELF flags to get_dwarf_regstr
>   perf dwarf-regs: Move x86 dwarf-regs out of arch
>   perf arm64: Remove dwarf-regs.c
>   perf arm: Remove dwarf-regs.c
>   perf dwarf-regs: Move csky dwarf-regs out of arch
>   perf loongarch: Remove dwarf-regs.c
>   perf mips: Remove dwarf-regs.c
>   perf dwarf-regs: Move powerpc dwarf-regs out of arch
>   perf riscv: Remove dwarf-regs.c and add dwarf-regs-table.h
>   perf s390: Remove dwarf-regs.c
>   perf sh: Remove dwarf-regs.c
>   perf sparc: Remove dwarf-regs.c
>   perf xtensa: Remove dwarf-regs.c
>   perf dwarf-regs: Remove get_arch_regstr code
>   perf build: Remove PERF_HAVE_DWARF_REGS
>
>  tools/build/Makefile.feature                  |  11 +-
>  tools/build/feature/Makefile                  |  24 +--
>  tools/build/feature/test-all.c                |  16 +-
>  tools/build/feature/test-dwarf.c              |  11 --
>  tools/build/feature/test-dwarf_getcfi.c       |   9 --
>  tools/build/feature/test-dwarf_getlocations.c |  13 --
>  tools/build/feature/test-libdw-dwarf-unwind.c |  14 --
>  tools/build/feature/test-libdw.c              |  56 +++++++
>  tools/perf/Documentation/perf-check.txt       |   6 +-
>  tools/perf/Makefile.config                    |  58 ++-----
>  tools/perf/Makefile.perf                      |   2 +-
>  tools/perf/arch/arc/annotate/instructions.c   |   2 +
>  tools/perf/arch/arm/Makefile                  |   3 -
>  tools/perf/arch/arm/annotate/instructions.c   |   2 +
>  tools/perf/arch/arm/util/Build                |   2 -
>  tools/perf/arch/arm/util/dwarf-regs.c         |  61 -------
>  tools/perf/arch/arm64/Makefile                |   4 -
>  tools/perf/arch/arm64/annotate/instructions.c |   2 +
>  tools/perf/arch/arm64/util/Build              |   1 -
>  tools/perf/arch/arm64/util/dwarf-regs.c       |  92 -----------
>  tools/perf/arch/csky/Makefile                 |   4 -
>  tools/perf/arch/csky/annotate/instructions.c  |   7 +-
>  tools/perf/arch/csky/util/Build               |   1 -
>  tools/perf/arch/loongarch/Makefile            |   4 -
>  .../arch/loongarch/annotate/instructions.c    |   2 +
>  tools/perf/arch/loongarch/util/Build          |   1 -
>  tools/perf/arch/loongarch/util/dwarf-regs.c   |  44 -----
>  tools/perf/arch/mips/Makefile                 |   4 -
>  tools/perf/arch/mips/annotate/instructions.c  |   2 +
>  tools/perf/arch/mips/util/Build               |   1 -
>  tools/perf/arch/mips/util/dwarf-regs.c        |  38 -----
>  tools/perf/arch/powerpc/Makefile              |   5 -
>  .../perf/arch/powerpc/annotate/instructions.c |   6 +-
>  tools/perf/arch/powerpc/util/Build            |   3 +-
>  tools/perf/arch/powerpc/util/dwarf-regs.c     | 153 ------------------
>  tools/perf/arch/riscv/Makefile                |   5 +-
>  .../arch/riscv/include/dwarf-regs-table.h     |  42 +++++
>  tools/perf/arch/riscv/util/Build              |   1 -
>  tools/perf/arch/riscv/util/dwarf-regs.c       |  72 ---------
>  .../perf/arch/riscv64/annotate/instructions.c |   2 +
>  tools/perf/arch/s390/Makefile                 |   4 -
>  tools/perf/arch/s390/annotate/instructions.c  |   2 +
>  tools/perf/arch/s390/util/Build               |   1 -
>  tools/perf/arch/s390/util/dwarf-regs.c        |  43 -----
>  tools/perf/arch/sh/Build                      |   1 -
>  tools/perf/arch/sh/Makefile                   |   4 -
>  tools/perf/arch/sh/util/Build                 |   1 -
>  tools/perf/arch/sh/util/dwarf-regs.c          |  41 -----
>  tools/perf/arch/sparc/Build                   |   1 -
>  tools/perf/arch/sparc/Makefile                |   4 -
>  tools/perf/arch/sparc/annotate/instructions.c |   2 +
>  tools/perf/arch/sparc/util/Build              |   1 -
>  tools/perf/arch/sparc/util/dwarf-regs.c       |  39 -----
>  tools/perf/arch/x86/Makefile                  |   4 -
>  tools/perf/arch/x86/annotate/instructions.c   |   5 +-
>  tools/perf/arch/x86/util/Build                |   3 -
>  tools/perf/arch/x86/util/dwarf-regs.c         | 153 ------------------
>  tools/perf/arch/xtensa/Build                  |   1 -
>  tools/perf/arch/xtensa/Makefile               |   4 -
>  tools/perf/arch/xtensa/util/Build             |   1 -
>  tools/perf/arch/xtensa/util/dwarf-regs.c      |  21 ---
>  tools/perf/builtin-annotate.c                 |   2 +-
>  tools/perf/builtin-check.c                    |   6 +-
>  tools/perf/builtin-probe.c                    |  14 +-
>  tools/perf/builtin-report.c                   |   4 +-
>  tools/perf/util/Build                         |  15 +-
>  tools/perf/util/annotate-data.h               |   8 +-
>  tools/perf/util/annotate.c                    |   6 +-
>  tools/perf/util/bpf-prologue.h                |  37 -----
>  tools/perf/util/debuginfo.h                   |   6 +-
>  tools/perf/util/disasm.c                      |   4 +-
>  tools/perf/util/disasm.h                      |   8 +-
>  tools/perf/util/dwarf-aux.c                   |   6 -
>  tools/perf/util/dwarf-aux.h                   |  53 ------
>  .../dwarf-regs.c =3D> util/dwarf-regs-csky.c}   |  19 +--
>  tools/perf/util/dwarf-regs-powerpc.c          |  61 +++++++
>  tools/perf/util/dwarf-regs-x86.c              |  50 ++++++
>  tools/perf/util/dwarf-regs.c                  |  38 +++--
>  tools/perf/util/genelf.c                      |   4 +-
>  tools/perf/util/genelf.h                      |   2 +-
>  tools/perf/util/include/dwarf-regs.h          | 114 ++++++++++---
>  tools/perf/util/probe-event.c                 |   4 +-
>  tools/perf/util/probe-finder.c                |  19 +--
>  tools/perf/util/probe-finder.h                |   9 +-
>  84 files changed, 454 insertions(+), 1157 deletions(-)
>  delete mode 100644 tools/build/feature/test-dwarf.c
>  delete mode 100644 tools/build/feature/test-dwarf_getcfi.c
>  delete mode 100644 tools/build/feature/test-dwarf_getlocations.c
>  delete mode 100644 tools/build/feature/test-libdw-dwarf-unwind.c
>  create mode 100644 tools/build/feature/test-libdw.c
>  delete mode 100644 tools/perf/arch/arm/util/dwarf-regs.c
>  delete mode 100644 tools/perf/arch/arm64/util/dwarf-regs.c
>  delete mode 100644 tools/perf/arch/csky/Makefile
>  delete mode 100644 tools/perf/arch/loongarch/util/dwarf-regs.c
>  delete mode 100644 tools/perf/arch/mips/util/dwarf-regs.c
>  delete mode 100644 tools/perf/arch/powerpc/util/dwarf-regs.c
>  create mode 100644 tools/perf/arch/riscv/include/dwarf-regs-table.h
>  delete mode 100644 tools/perf/arch/riscv/util/dwarf-regs.c
>  delete mode 100644 tools/perf/arch/s390/util/dwarf-regs.c
>  delete mode 100644 tools/perf/arch/sh/Build
>  delete mode 100644 tools/perf/arch/sh/Makefile
>  delete mode 100644 tools/perf/arch/sh/util/Build
>  delete mode 100644 tools/perf/arch/sh/util/dwarf-regs.c
>  delete mode 100644 tools/perf/arch/sparc/Build
>  delete mode 100644 tools/perf/arch/sparc/util/Build
>  delete mode 100644 tools/perf/arch/sparc/util/dwarf-regs.c
>  delete mode 100644 tools/perf/arch/x86/util/dwarf-regs.c
>  delete mode 100644 tools/perf/arch/xtensa/Build
>  delete mode 100644 tools/perf/arch/xtensa/Makefile
>  delete mode 100644 tools/perf/arch/xtensa/util/Build
>  delete mode 100644 tools/perf/arch/xtensa/util/dwarf-regs.c
>  delete mode 100644 tools/perf/util/bpf-prologue.h
>  rename tools/perf/{arch/csky/util/dwarf-regs.c =3D> util/dwarf-regs-csky=
.c} (74%)
>  create mode 100644 tools/perf/util/dwarf-regs-powerpc.c
>  create mode 100644 tools/perf/util/dwarf-regs-x86.c
>
> --
> 2.47.0.rc0.187.ge670bccf7e-goog
>
