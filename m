Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651901B6D1A
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 23:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778715127; cv=none; b=XvZIeN6ard2CTWUMJB5uq9WUJaI8MFxdjXVDKgOuvo+YuVr+7+pv/7mBln7iwQXSs/cFvKvVujvD5jw1amvmN3+7b5/s11GT75izg9o+Ooh7WvBWsYlXrfvhU9jJmt1GljSqMBNFBdb7I2eQ/afMQoLsAZc/2kWmZD4hjVe7xUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778715127; c=relaxed/simple;
	bh=jIkQgL+xkqUF0vMMZiFKikoIqpg1+K8G3j0QFUqfuKM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kqONQXQ0CxEJNM8j4CQU4i+qLXMvAHGF1AI9d8c4McvYQUvorz44siMrg0iJMOatkj+2TGvsSEHiLe5hk3hBrZDQwC6GyKEn93juPwPza7p7FdviP12oyE1se9+NpXjp617Gl6WQFZ+gbnh3OZMwA6f04RJqOCKWzfdAGhS1hVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gTisWiBE; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gTisWiBE"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-30230e64087so922601eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 16:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778715124; x=1779319924; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z/G4RlBPz/1FhVhJ+hkmK/O47djbhkf5nNV0WY5rxaI=;
        b=gTisWiBEeumSnn5AjJ5TQeiPb1/522vWf1cPbm66EemQd8Wceecn5bnbwAbquREplr
         be8iE7Ojj2mhpFit2826+69spqhpvcCONyyrBrrWjEwu9whjc2kbr5f5UsO3URzkh80t
         fV9A4TNhFB7CaTbbPp4E5+ixcz/EzCAHXmdEkSvSQxSwWqo+0Pmk9nfWsagwUKM6KkTR
         PR3B2daFNKomqgoSNo8c8g57n7sHoGY+KGw3SVRGWABNraiB3ls9pIVx0YTdPtToNE35
         J9BqZ+y+OY62E9IgxgLnSCvBi5GYeTPKnHI4Rvj4mHSofTX692AuQEJY8BPH5Z7yTVGe
         pRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778715124; x=1779319924;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z/G4RlBPz/1FhVhJ+hkmK/O47djbhkf5nNV0WY5rxaI=;
        b=WiePtjUcqJhlN0yEp2/3X3695wzPrcQnkEipHBE4hWZheNtrOQLDd73zQNkVMYeiGW
         I73j5/01qd6x4Vt9gZ5tdLJYdYU1pD4H0SI+sykiKIo2ScunE3S9Tryg0urW687x/5rp
         RJBaVnXNr/JE/9V0rOYxKLoEHyXJcwV2DgQ9tRdCrGHs6Sg+fmiUA97lBG0RyoXMq+4M
         WkHQkhDzmdaAYZQ70AYBzMWKIUPrkqhfjqc2IdrM5/0rWkWdwSRIyJsylQUNbfh0+KId
         A8tErVofa2xyd5z/rHt6ILCwJ25C/p5YfjuJn2jfEur6Zv+DE1PouK4t8MMv+DUOKeak
         FwiA==
X-Forwarded-Encrypted: i=1; AFNElJ8Y4i0FYG/ksEn+xM0KKQzlh0GOS167K6c47q7RzyO0VwliKJTE0bQY78lNDHTarspW4FA7rOYcKgFQdmkOjGbr@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw0snaJelqtObYoSL5R6VJKjHaQdgVDLY+C2uo/XyhW9m9PQyv
	1/ubDWDKrWVjY0V/+GVigO6bh9i/jSykokIg+84g+bYMEh8oFj/7Too2/VOEVcCp5DOdE4LARQG
	bDykTrDrwwQ==
X-Received: from dlboy14.prod.google.com ([2002:a05:7022:128e:b0:12b:fe5e:215])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6b91:b0:129:fe5:117e
 with SMTP id a92af1059eb24-1349ab50ec8mr2869316c88.26.1778715124133; Wed, 13
 May 2026 16:32:04 -0700 (PDT)
Date: Wed, 13 May 2026 16:31:44 -0700
In-Reply-To: <20260413024805.1316480-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260413024805.1316480-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260513233151.572332-1-irogers@google.com>
Subject: [PATCH v5 0/7] perf libunwind multiple remote support
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, namhyung@kernel.org, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Li Guan <guanli.oerv@isrc.iscas.ac.cn>
Cc: 9erthalion6@gmail.com, alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	andrew.jones@oss.qualcomm.com, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, 
	howardchu95@gmail.com, john.g.garry@oracle.com, jolsa@kernel.org, 
	leo.yan@linux.dev, libunwind-devel@nongnu.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org, 
	mingo@redhat.com, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	shimin.guo@skydio.com, tglozar@redhat.com, tmricht@linux.ibm.com, 
	will@kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix the libunwind build for when libdw and libunwind are feature
detected, currently failing with a duplicate symbol.

Refactor the libunwind support so that whenever a remote target is
available, perf functions using the ELF machine can use that remote
target regardless of what the host/local machine is. Migrate existing
libunwind supported architectures like powerpc, arm64 and loongarch so
that they can work in a cross-architecture way. Add support for
RISC-V. Make the code more regular in function names, etc. and avoid
including a C-file. This increases the lines of code. It is similar in
style to the unwind-libdw implementation. It is hoped that the more
uniform nature of the code will help with refactoring the perf
registers for SIMD/APX support.

Aside from local host testing these patches are under tested, in part
as I'm failing to see how to build libunwind with support for multiple
remote targets. Please could I get help in testing.

v5: Rebase dropping merged loong arch fix patch. Fixes to Sashiko
    review feedback:
    - Patch 1: Hooked unwind__configure() into perf_default_config().
      Standardized unwinder return contracts (>0 success, 0 fallback,
      <0 fatal).  Fixed UNWIND_STYLE_UNKNOWN fallback and added
      memset() to clear config array on override.
    - Patch 2: Dynamically populated FILES list in
      tools/build/feature/Makefile using LIBUNWIND_ARCHS. Added
      libunwind cases to FEATURE_TESTS_EXTRA in
      tools/build/Makefile.feature for proper FEATURE-DUMP caching.
    - Patch 3: Restored core -lunwind linkage to
      FEATURE_CHECK_LDFLAGS.  Restored NO_LIBUNWIND fallback
      validation, corrected EXTLIBS evaluation ordering for
      BIONIC/Android compatibility, and restored static linking
      multiple definition flags.
    - Patch 4: Fixed out-of-bounds array read bugs (>= ARRAY_SIZE) in
      libunwind-i386.c and libunwind-x86_64.c. Fixed constant typos
      across LoongArch, PowerPC, and s390x.
    - Patch 5: Added early EM_NONE and ops validation checks to
      prevent warnings and NULL dereferences. Checked return value of
      unwind__prepare_access() in maps__copy_from(). Corrected
      architecture binding in thread__insert_map() by calculating
      e_machine after map insertion.
    - Patch 6: Aligned all remote architecture accessors to match
      5-argument generic declarations (removing trailing
      sizeof(unw_word_t)). Prevented frame discard on stack depth
      limit by returning 0 instead of -1 in unwind_step(). Fixed
      32-bit big-endian register corruption by replacing memcpy() with
      conditional type-casted assignment. Fixed max_stack == 1
      fallback trigger. Fixed .debug_frame layout union corruption by
      changing di.u.rti to di.u.ti across all DWARF find wrappers.
    - Patch 7: Applied the same corrections (5-argument accessors,
      u.ti union accessors, 0 return on max_ips) to the newly
      introduced libunwind-riscv.c.

v4: Rebase, in particular the zalloc->calloc change conflicted.
https://lore.kernel.org/linux-perf-users/20260413024805.1316480-1-irogers@google.com/

v3: Minor whitespace clean up and warn when a dynamic choice of libdw
    or libunwind is selected for unwinding and support is missing (Arnaldo).
https://lore.kernel.org/lkml/20260404054032.1538095-1-irogers@google.com/

v2: Move two fixes patches to position 1 and 2 in the series. Fix
    struct naming inconsistency, Andrew Jones
    <andrew.jones@oss.qualcomm.com>. Fix other inconsistencies and
    potential non-x86 build issues.
https://lore.kernel.org/lkml/20260305221927.3237145-1-irogers@google.com/

v1: https://lore.kernel.org/lkml/20260224142938.26088-1-irogers@google.com/

Ian Rogers (7):
  perf unwind: Refactor get_entries to allow dynamic libdw/libunwind
    selection
  tools build: Deduplicate test-libunwind for different architectures
  perf build: Be more programmatic when setting up libunwind variables
  perf unwind-libunwind: Make libunwind register reading cross platform
  perf unwind-libunwind: Move flush/finish access out of local
  perf unwind-libunwind: Remove libunwind-local
  perf unwind-libunwind: Add RISC-V libunwind support

 tools/build/Makefile.feature                  |  12 +-
 tools/build/feature/Makefile                  |  46 +-
 tools/build/feature/test-libunwind-aarch64.c  |  27 -
 tools/build/feature/test-libunwind-arm.c      |  28 -
 .../test-libunwind-debug-frame-aarch64.c      |  17 -
 .../feature/test-libunwind-debug-frame-arm.c  |  17 -
 .../feature/test-libunwind-debug-frame.c      |   1 -
 tools/build/feature/test-libunwind-x86.c      |  28 -
 tools/build/feature/test-libunwind-x86_64.c   |  28 -
 tools/build/feature/test-libunwind.c          |   1 -
 tools/perf/Makefile.config                    | 226 +++--
 tools/perf/arch/arm/util/Build                |   2 -
 tools/perf/arch/arm/util/unwind-libunwind.c   |  50 --
 tools/perf/arch/arm64/util/Build              |   1 -
 tools/perf/arch/arm64/util/unwind-libunwind.c |  17 -
 tools/perf/arch/loongarch/util/Build          |   2 -
 .../arch/loongarch/util/unwind-libunwind.c    |  82 --
 tools/perf/arch/mips/Build                    |   1 -
 tools/perf/arch/mips/util/Build               |   1 -
 tools/perf/arch/mips/util/unwind-libunwind.c  |  22 -
 tools/perf/arch/powerpc/util/Build            |   1 -
 .../perf/arch/powerpc/util/unwind-libunwind.c |  92 --
 tools/perf/arch/x86/util/Build                |   3 -
 tools/perf/arch/x86/util/unwind-libunwind.c   | 115 ---
 tools/perf/builtin-inject.c                   |   4 +
 tools/perf/builtin-report.c                   |   4 +
 tools/perf/builtin-script.c                   |   4 +
 tools/perf/util/Build                         |   5 +-
 tools/perf/util/config.c                      |   4 +
 tools/perf/util/libunwind-arch/Build          |  11 +
 .../perf/util/libunwind-arch/libunwind-arch.c | 319 +++++++
 .../perf/util/libunwind-arch/libunwind-arch.h | 296 +++++++
 .../perf/util/libunwind-arch/libunwind-arm.c  | 290 ++++++
 .../util/libunwind-arch/libunwind-arm64.c     | 289 ++++++
 .../perf/util/libunwind-arch/libunwind-i386.c | 312 +++++++
 .../util/libunwind-arch/libunwind-loongarch.c | 297 +++++++
 .../perf/util/libunwind-arch/libunwind-mips.c | 299 +++++++
 .../util/libunwind-arch/libunwind-ppc32.c     | 301 +++++++
 .../util/libunwind-arch/libunwind-ppc64.c     | 303 +++++++
 .../util/libunwind-arch/libunwind-riscv.c     | 297 +++++++
 .../perf/util/libunwind-arch/libunwind-s390.c | 299 +++++++
 .../util/libunwind-arch/libunwind-x86_64.c    | 320 +++++++
 tools/perf/util/libunwind/arm64.c             |  40 -
 tools/perf/util/libunwind/x86_32.c            |  41 -
 tools/perf/util/maps.c                        |  34 +-
 tools/perf/util/maps.h                        |   4 +-
 tools/perf/util/symbol_conf.h                 |  10 +
 tools/perf/util/thread.c                      |  32 +-
 tools/perf/util/unwind-libdw.c                |  20 +-
 tools/perf/util/unwind-libunwind-local.c      | 831 ------------------
 tools/perf/util/unwind-libunwind.c            | 699 +++++++++++++--
 tools/perf/util/unwind.c                      | 104 +++
 tools/perf/util/unwind.h                      |  73 +-
 53 files changed, 4623 insertions(+), 1739 deletions(-)
 delete mode 100644 tools/build/feature/test-libunwind-aarch64.c
 delete mode 100644 tools/build/feature/test-libunwind-arm.c
 delete mode 100644 tools/build/feature/test-libunwind-debug-frame-aarch64.c
 delete mode 100644 tools/build/feature/test-libunwind-debug-frame-arm.c
 delete mode 100644 tools/build/feature/test-libunwind-x86.c
 delete mode 100644 tools/build/feature/test-libunwind-x86_64.c
 delete mode 100644 tools/perf/arch/arm/util/unwind-libunwind.c
 delete mode 100644 tools/perf/arch/arm64/util/unwind-libunwind.c
 delete mode 100644 tools/perf/arch/loongarch/util/unwind-libunwind.c
 delete mode 100644 tools/perf/arch/mips/Build
 delete mode 100644 tools/perf/arch/mips/util/Build
 delete mode 100644 tools/perf/arch/mips/util/unwind-libunwind.c
 delete mode 100644 tools/perf/arch/powerpc/util/unwind-libunwind.c
 delete mode 100644 tools/perf/arch/x86/util/unwind-libunwind.c
 create mode 100644 tools/perf/util/libunwind-arch/Build
 create mode 100644 tools/perf/util/libunwind-arch/libunwind-arch.c
 create mode 100644 tools/perf/util/libunwind-arch/libunwind-arch.h
 create mode 100644 tools/perf/util/libunwind-arch/libunwind-arm.c
 create mode 100644 tools/perf/util/libunwind-arch/libunwind-arm64.c
 create mode 100644 tools/perf/util/libunwind-arch/libunwind-i386.c
 create mode 100644 tools/perf/util/libunwind-arch/libunwind-loongarch.c
 create mode 100644 tools/perf/util/libunwind-arch/libunwind-mips.c
 create mode 100644 tools/perf/util/libunwind-arch/libunwind-ppc32.c
 create mode 100644 tools/perf/util/libunwind-arch/libunwind-ppc64.c
 create mode 100644 tools/perf/util/libunwind-arch/libunwind-riscv.c
 create mode 100644 tools/perf/util/libunwind-arch/libunwind-s390.c
 create mode 100644 tools/perf/util/libunwind-arch/libunwind-x86_64.c
 delete mode 100644 tools/perf/util/libunwind/arm64.c
 delete mode 100644 tools/perf/util/libunwind/x86_32.c
 delete mode 100644 tools/perf/util/unwind-libunwind-local.c
 create mode 100644 tools/perf/util/unwind.c

-- 
2.54.0.563.g4f69b47b94-goog

