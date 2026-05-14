Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1B331ED7C
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 16:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778777485; cv=pass; b=Tt39l2tIWeaR6dkxLRKZ5t6RE4JuUf1wyWwa8IhjBlYYIPCD7WzcnG3VmEGIsthJ7MRO3nimkLO2gaG7gF4OQl33g1yLb1WjFEAyEGSyX8vDJaXU03M669QT/kY+VE6n5qlfJTUmCZptC63m529t4WCRIMriuGl51+UIaYes4Wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778777485; c=relaxed/simple;
	bh=6n2da3MVUrWC2k9FgwJbpSnusqtJqrPXIv4NR5tkUFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZoaO/rbVfyC2FTIgUi6Io8UAJ2stWa6Jsq6WiEVkqqGMmvs/TE0rVaFF3MewHWXaRW4dwdgmsxuljL+cnI6oR+xiBp8CLlZlJk4Ww3NRtoahd0MDLHbbblvGGIgWh/ZFM06xIRysQOcFATTfz5w7uffCdCXiOZYxLmsXVIuNqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YW8NpnG2; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YW8NpnG2"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso2675ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 09:51:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778777483; cv=none;
        d=google.com; s=arc-20240605;
        b=iGU9ENMLggJ2n2d3gLTc4V5a7oJenrs7/G9Ml/5oUfi4ARR3QGXx3iHrrZzEp9YrdZ
         Nq56gp4kdNdOQ6gCg/U2RfT/MXOH+D+RTG4QB+R66FMdte8eq0iwOJvVhUDmOOPSBOJj
         HrCkvZaiH94sxXvFjUGxm6ub5smU5IEod54sDG3xybc2jm3gg1lRwoprdkaHttncoJNi
         Ed35XulCEM3uxhpoWfAjXfi6HooXf3dfbgKLMal5qyYxZcp/Lj69IBXk1daLcsFKN9vZ
         xOlWJLa+Sy5tWVeDIpDDdOaUIBf+/KYr4h698QWlJZzEPLf2hTTJOakgmR/stds9R/at
         enCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UTb9VOWLgej72NUzrLbG/r3dp+jDNhJ8HUkQVGXZx6E=;
        fh=bQugKKRyhXf8Jq+fWmcEcVgb74ejqabsFlEgS6EvGPY=;
        b=dP+kRi0Lod80R/5cal2fGU8S+E1QX0nBHXwbOg7SdLEs1Dg7mkNgIglWbMw79X4P7Y
         scsxG1E7BL58LOSIhszGGrPn3EaWDgj9ExCHgqVwWC7J/6B3X2R1IvHkQlEvFhe4FbDO
         h823BELpWsRI2P1Bnfoin+9O8IG99MwSM1JPIoddios0Y9Tq0zRnQB5mGs4jAGjzLksH
         h4mXlpxh+pK3YTqxydY84iYnRlASU/awLG9CMjlwZTVS/yvBrMXhKAoUpPxx/LMFheTJ
         VZdYq/EACxr++yaGQsMJ3zEPcwHIlq5LRUq1aLk6O543oi67eOsef3E6RlSz2M2WXRVI
         g2KA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778777483; x=1779382283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTb9VOWLgej72NUzrLbG/r3dp+jDNhJ8HUkQVGXZx6E=;
        b=YW8NpnG2fJWXXexXVDCi763PKovSP0ZDl1wS/8Ro8QhpjglyjlaC4n+/+nsnYtukYx
         9HyN8tVlfHixcJzmvQ3/OCQ/3cd/ayjRlLNKb+PJVuVs1626hrx6CzJz898yeFGMGx0a
         wSxOGgFrWXw5KK2NZuoZc3uHH+sZn4UrhQEw6T2zwwcVCnx+tNP/eA2fscCxGA324oxl
         xXi38ICSTxALPFg8OrBOAUA1Bqa3cYzxyOcLtueBDlrlsgTfsrhkMR7nLuSE9IQx6k4v
         yoh7squorrVK5cgdx6PCnCOMRAueI6A21Z/v8AU/WHEMl26qT/KKDzJ5WGPIBaEifEwe
         fD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778777483; x=1779382283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UTb9VOWLgej72NUzrLbG/r3dp+jDNhJ8HUkQVGXZx6E=;
        b=B78GSm/JF5ZdaeFoyQwmermzwgqYRN0TPwfZwmOLKgwBgMmTw9QjoSaK072+VOIRiR
         MIUFpOUFwbiNXaFpSeNNW6zJ0xWZnrKOdQo831HESuBIOzsIQvUQIlm8CgvKtXuE5YuN
         rOYZK4VeUZNOuC2nZPcQ4ZU93D2Y4Gj8qGoMq7pmwdsYF9m14I82bdcGVvIexfcKigjj
         7XLA1UH1KQpC9fCcbyuh4j8on9dVDv2mB0cuj1PNQn8xVx+ucnpKNFfzEu92TxNMBkv3
         STgVWH486qpZBJZPaqEsuydoE/ltV8aVjFk8SEVAOR1unXdjm/hZSTZ6bXG9Kev4Qp4g
         9jnw==
X-Forwarded-Encrypted: i=1; AFNElJ82GmNe48Q1I9K49HzMALMUb+ZF+yMXlOqcwPq+awP7wrgbXoTFsge8/7GbzT1RK4WJWhdlxpvxRUYwI7rzvlEO@vger.kernel.org
X-Gm-Message-State: AOJu0YxYH+E64YzFFuU8hYDNpJBIL/C9bm9aGN5vuKhoEMfJz684FfDt
	hD/cueDUxoiVbVfyIU3kDpsw5atA1Y/uutEzkkIJYilWN125yM+TJvdOYjl6rOjkws67Xbx0l46
	TTM/pwv4dKNu3KR8/CetoYZ6BjOBDocq3C5Lwsy/F
X-Gm-Gg: Acq92OEKxzieRDRZ2vDrpplJ09aW/dIEuU7vJViW49kgKxz6iHkHBj91MdmgePP5J8Y
	MQ2etU4CloyGr6jpu0EdSrzAcVLW3INMlkThTQIlsOvp0mk46fCLQTf0cySTVPyXjXYTNM4T41s
	p15WJtGVTgxHcmp2papDT35+eWxgVBSB3K5w8Tr0RXiC8iG0bM9mdO0hMrr+/IAkL85QmdBM+Ft
	5bY6Ye7bdaOFUIHMEGOBeiUX5KA1sWg2caibrYrJ5JUlL8TxvKJRxWPkFJ8AlWoyN8LUCq8lZfR
	fhSVz/gCYAMW0pnCfv/ESh+k86S0MMKEzTlYMPR8o6u2bOo=
X-Received: by 2002:a17:903:290f:b0:2bd:6dad:7ccb with SMTP id
 d9443c01a7336-2bd6dad7e0bmr1042685ad.23.1778777482418; Thu, 14 May 2026
 09:51:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413024805.1316480-1-irogers@google.com> <20260513233151.572332-1-irogers@google.com>
In-Reply-To: <20260513233151.572332-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 14 May 2026 09:51:09 -0700
X-Gm-Features: AVHnY4IgkWfYDaMSqVQBab29EPYgZmksZltdaS5chOvp2j0mkJEYQvlgA4fqxgU
Message-ID: <CAP-5=fW6S1XzZvq=kWj6ma=O1UCDrVV3ZNbzK0fMS_ho6e1qVg@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] perf libunwind multiple remote support
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
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 4:32=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
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
> uniform nature of the code will help with refactoring the perf
> registers for SIMD/APX support.
>
> Aside from local host testing these patches are under tested, in part
> as I'm failing to see how to build libunwind with support for multiple
> remote targets. Please could I get help in testing.

So the patches failed to apply in Sashiko:
https://sashiko.dev/#/patchset/20260513233151.572332-1-irogers%40google.com
The baseline logs show perf-tools-next was at commit 8c8f20936143
("perf build: Remove NO_GTK2 build test") which is 6 patches
out-of-date compared to the current tip these patches are against. I
ran Sashiko locally, so I don't expect a huge amount from the reviews.
Currently Sashiko is catching up with a backlog because its tokens
have a lower priority and there was high load earlier in the week.
Anyway, I could repost the patches for Sashiko review but given the
backlog I think that would just create noise at the moment. Hopefully
I can get human review so we can move forward with merging these
improvements.

Thanks,
Ian

> v5: Rebase dropping merged loong arch fix patch. Fixes to Sashiko
>     review feedback:
>     - Patch 1: Hooked unwind__configure() into perf_default_config().
>       Standardized unwinder return contracts (>0 success, 0 fallback,
>       <0 fatal).  Fixed UNWIND_STYLE_UNKNOWN fallback and added
>       memset() to clear config array on override.
>     - Patch 2: Dynamically populated FILES list in
>       tools/build/feature/Makefile using LIBUNWIND_ARCHS. Added
>       libunwind cases to FEATURE_TESTS_EXTRA in
>       tools/build/Makefile.feature for proper FEATURE-DUMP caching.
>     - Patch 3: Restored core -lunwind linkage to
>       FEATURE_CHECK_LDFLAGS.  Restored NO_LIBUNWIND fallback
>       validation, corrected EXTLIBS evaluation ordering for
>       BIONIC/Android compatibility, and restored static linking
>       multiple definition flags.
>     - Patch 4: Fixed out-of-bounds array read bugs (>=3D ARRAY_SIZE) in
>       libunwind-i386.c and libunwind-x86_64.c. Fixed constant typos
>       across LoongArch, PowerPC, and s390x.
>     - Patch 5: Added early EM_NONE and ops validation checks to
>       prevent warnings and NULL dereferences. Checked return value of
>       unwind__prepare_access() in maps__copy_from(). Corrected
>       architecture binding in thread__insert_map() by calculating
>       e_machine after map insertion.
>     - Patch 6: Aligned all remote architecture accessors to match
>       5-argument generic declarations (removing trailing
>       sizeof(unw_word_t)). Prevented frame discard on stack depth
>       limit by returning 0 instead of -1 in unwind_step(). Fixed
>       32-bit big-endian register corruption by replacing memcpy() with
>       conditional type-casted assignment. Fixed max_stack =3D=3D 1
>       fallback trigger. Fixed .debug_frame layout union corruption by
>       changing di.u.rti to di.u.ti across all DWARF find wrappers.
>     - Patch 7: Applied the same corrections (5-argument accessors,
>       u.ti union accessors, 0 return on max_ips) to the newly
>       introduced libunwind-riscv.c.
>
> v4: Rebase, in particular the zalloc->calloc change conflicted.
> https://lore.kernel.org/linux-perf-users/20260413024805.1316480-1-irogers=
@google.com/
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
> Ian Rogers (7):
>   perf unwind: Refactor get_entries to allow dynamic libdw/libunwind
>     selection
>   tools build: Deduplicate test-libunwind for different architectures
>   perf build: Be more programmatic when setting up libunwind variables
>   perf unwind-libunwind: Make libunwind register reading cross platform
>   perf unwind-libunwind: Move flush/finish access out of local
>   perf unwind-libunwind: Remove libunwind-local
>   perf unwind-libunwind: Add RISC-V libunwind support
>
>  tools/build/Makefile.feature                  |  12 +-
>  tools/build/feature/Makefile                  |  46 +-
>  tools/build/feature/test-libunwind-aarch64.c  |  27 -
>  tools/build/feature/test-libunwind-arm.c      |  28 -
>  .../test-libunwind-debug-frame-aarch64.c      |  17 -
>  .../feature/test-libunwind-debug-frame-arm.c  |  17 -
>  .../feature/test-libunwind-debug-frame.c      |   1 -
>  tools/build/feature/test-libunwind-x86.c      |  28 -
>  tools/build/feature/test-libunwind-x86_64.c   |  28 -
>  tools/build/feature/test-libunwind.c          |   1 -
>  tools/perf/Makefile.config                    | 226 +++--
>  tools/perf/arch/arm/util/Build                |   2 -
>  tools/perf/arch/arm/util/unwind-libunwind.c   |  50 --
>  tools/perf/arch/arm64/util/Build              |   1 -
>  tools/perf/arch/arm64/util/unwind-libunwind.c |  17 -
>  tools/perf/arch/loongarch/util/Build          |   2 -
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
>  tools/perf/util/config.c                      |   4 +
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
>  tools/perf/util/maps.c                        |  34 +-
>  tools/perf/util/maps.h                        |   4 +-
>  tools/perf/util/symbol_conf.h                 |  10 +
>  tools/perf/util/thread.c                      |  32 +-
>  tools/perf/util/unwind-libdw.c                |  20 +-
>  tools/perf/util/unwind-libunwind-local.c      | 831 ------------------
>  tools/perf/util/unwind-libunwind.c            | 699 +++++++++++++--
>  tools/perf/util/unwind.c                      | 104 +++
>  tools/perf/util/unwind.h                      |  73 +-
>  53 files changed, 4623 insertions(+), 1739 deletions(-)
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
> 2.54.0.563.g4f69b47b94-goog
>
