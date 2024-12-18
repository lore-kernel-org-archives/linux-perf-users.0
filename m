Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25181F5E6
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Dec 2024 01:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734484278; cv=none; b=dsbd/xmvW4Ic9DPRzheu3mV2g+2eEIGrnYi8Cr0AiKqG1YP5txTl8Fe+9y00Zrhx1jWsZxhgsXcwHy0HSOMETVBB8q2bKhgpsQTX68Br9oVjhyDC2d4j42y24egIRamU61Wl0jb8kc5OxXUNNORtok0bqTctaV6Ng6Q0xEaLsR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734484278; c=relaxed/simple;
	bh=FxP5WG2Kqa3WDGkwuAPnjbFknjmPg/KFzC3bOCOPlKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PRxxmNvmBBjCDf1sMQabVZOxl2U72/AsXN62nFyxM2Qe63y5EIeFUNtygcqqDNIWWdh2urbM4Xy0BFmG5q5sB+CFOD6hexe+dqc6g1saZid1lQcxAwNeHw55K4nLiAMkQRAAMsf+Onn0AC4J5N8A7gL/cilDQpcUaErgqwpFKto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=FsWGWup7; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="FsWGWup7"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21649a7bcdcso56429425ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Dec 2024 17:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734484274; x=1735089074; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=//AsXtq/PKwVlsB/6NdH9AeHKR9dR/Splpn+baz2miA=;
        b=FsWGWup7W5Rg9sqzJzfti/4wYXFQjiWFRVcBd7ueyDzdKI2YKna85K/0g3HqlAJ1Vz
         YeJ5Y0rzDJ3YZ6e9VGHalJmuEXihPVJ95Nsxck6RILwAOzekxKRu9V5dMPhAYKYmCv+V
         e8uZgbCcSzRtbzmyLbVoPbOJxMRjIQv6T9EkJymjPwgHMNLi/Xhjz9pNGXOxpU2jjXMM
         wo4xPS8Sk5uP0quE3+NLx1ssE8vag0WZ+F3u9K3SraI8buM9BCQpAfbzvNUHEv6JlFH0
         UwiEO6KQWJiKUAw4u68dtw8VY6olpCtQfXji/4OBf4BypBG9ZzEfxauuytKLBT8kTv2C
         KCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734484274; x=1735089074;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=//AsXtq/PKwVlsB/6NdH9AeHKR9dR/Splpn+baz2miA=;
        b=qor9RF+hLeYiL3WzsYkGhl4dA1FS6iUbxiMuSZ5C3J982ZBqZAa3Jzhim1zd9g9b6U
         eu2n+wv501k5SZ/tiilLYO1uSwZWShLSZsxfwZCBVopNV8xvYcBmXUhRWXVd9COpRu2W
         CvfaayakxjHt96KXMws8pK7tnQ6kSR7HPKwFTVJStJKGBGt0RzBvefuZjr+DlzM0ewIL
         VNwsHUsj5hLdcr5ZVZVjivAkwA4NxhNtisXki6DvwBTMit4jnMKWCuni6mj6ZtfYW3wC
         7L0v9Jc1Q1MXvp3bjn9co2S2fZ/NM6OL883FB6TNehKWyqtK7CfJryKspvJkoAJumkYG
         xk6A==
X-Forwarded-Encrypted: i=1; AJvYcCU0n2zrTHhUNzG6i+s8JBcaZmw6K3Z/nND/mLFGDNGTMIlmBX00M6GXAwPJUWia6WGWCHi7cy/ayP912spgMwO8@vger.kernel.org
X-Gm-Message-State: AOJu0YwNdynTtjaPmxakSTH/p/Pvd8FvTdL8s7++lXcNr38SYTFWOHY9
	Yq6/J1zET6rD7k9HXc/AGVCVLWm3HyzOjAyZhNZUqiQVIsMI23OlcO4/Dn9J7no=
X-Gm-Gg: ASbGnct4f+lrw2G8nQNio49fBPKsigfgyLSovf4s3yQmlGeM5N2ZsdqV90CyMneKgBg
	H4O1FfKCD5BhffwxUU6YyzpyHs3RggVDSSo7pQNILhA8Xb8LeAI0BvoVWFRkxHwDC7VzklswPCx
	PGEfLwTcRVmXmk0jBsP3EKDotKFwpwm37/JDiRBgqI47+cVPcFipHZJmkv+GK0mXKLJHn7y6des
	2xdJAkWiXqZBkDPzCwNMhtlTEjXCkjvsPCgPO+SJxOqR2o=
X-Google-Smtp-Source: AGHT+IEOXPRe9Wq6Eef0ftWD1QmBlV0TBPdEvvDl6Yjh3OVfGIkOaO5fTDZemiJS1rNtOnnDywF/wA==
X-Received: by 2002:a17:902:f705:b0:216:2e5e:971d with SMTP id d9443c01a7336-218d726c177mr12199525ad.51.1734484273938;
        Tue, 17 Dec 2024 17:11:13 -0800 (PST)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e657d1sm65805315ad.239.2024.12.17.17.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 17:11:12 -0800 (PST)
Date: Tue, 17 Dec 2024 17:11:09 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Christian Brauner <brauner@kernel.org>, Guo Ren <guoren@kernel.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	linux-csky@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 00/16] perf tools: Use generic syscall scripts for all
 archs
Message-ID: <Z2IhLZ8mfTWvbCvI@ghost>
References: <20241216-perf_syscalltbl-v3-0-239f032481d5@rivosinc.com>
 <CAP-5=fWEUq_nLx7PUx96ixMrX0NqqF8W0EmXV9Zvc449zj0Z7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWEUq_nLx7PUx96ixMrX0NqqF8W0EmXV9Zvc449zj0Z7A@mail.gmail.com>

On Tue, Dec 17, 2024 at 04:03:29PM -0800, Ian Rogers wrote:
> On Mon, Dec 16, 2024 at 10:39 PM Charlie Jenkins <charlie@rivosinc.com> wrote:
> >
> > Standardize the generation of syscall headers around syscall tables.
> > Previously each architecture independently selected how syscall headers
> > would be generated, or would not define a way and fallback onto
> > libaudit. Convert all architectures to use a standard syscall header
> > generation script and allow each architecture to override the syscall
> > table to use if they do not use the generic table.
> >
> > As a result of these changes, no architecture will require libaudit, and
> > so the fallback case of using libaudit is removed by this series.
> >
> > Testing:
> >
> > I have tested that the syscall mappings of id to name generation works
> > as expected for every architecture, but I have only validated that perf
> > trace compiles and runs as expected on riscv, arm64, and x86_64.
> >
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> 
> This is really great, thanks for taking the time for a substantial
> clean up. I had difficulty applying the patches to the perf-tools-next
> branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/log/?h=perf-tools-next
> using patch and dealing with rejects I was able to test.
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> On x86-64:
> Tested-by: Ian Rogers <irogers@google.com>

Thank you! I will base my next version on perf-tools-next.

- Charlie

> 
> I think there are follow up patches that clean up the ABI, allow >1
> table at a time, .. but those things are best saved for a follow up.
> 
> Thanks,
> Ian
> 
> > ---
> > Changes in v3:
> > - Fix compiliation when OUTPUT is empty
> > - Correct unused headers to be .h instead of .c  (Namhyung)
> > - Make variable definition of supported archs (Namhyung)
> > - Convert += into := for syscalls headers (Namhyung)
> > - Link to v2: https://lore.kernel.org/r/20241212-perf_syscalltbl-v2-0-f8ca984ffe40@rivosinc.com
> >
> > Changes in v2:
> > - Rebase onto 6.13-rc2
> > - Fix output path so it generates to /tools/perf/arch properly
> > - Link to v1: https://lore.kernel.org/r/20241104-perf_syscalltbl-v1-0-9adae5c761ef@rivosinc.com
> >
> > ---
> > Charlie Jenkins (16):
> >       perf tools: Create generic syscall table support
> >       perf tools: arc: Support generic syscall headers
> >       perf tools: csky: Support generic syscall headers
> >       perf tools: arm: Support syscall headers
> >       perf tools: sh: Support syscall headers
> >       perf tools: sparc: Support syscall headers
> >       perf tools: xtensa: Support syscall header
> >       perf tools: x86: Use generic syscall scripts
> >       perf tools: alpha: Support syscall header
> >       perf tools: parisc: Support syscall header
> >       perf tools: arm64: Use syscall table
> >       perf tools: loongarch: Use syscall table
> >       perf tools: mips: Use generic syscall scripts
> >       perf tools: powerpc: Use generic syscall table scripts
> >       perf tools: s390: Use generic syscall table scripts
> >       perf tools: Remove dependency on libaudit
> >
> >  Documentation/admin-guide/workload-tracing.rst     |   2 +-
> >  tools/build/feature/Makefile                       |   4 -
> >  tools/build/feature/test-libaudit.c                |  11 -
> >  tools/perf/Documentation/perf-check.txt            |   1 -
> >  tools/perf/Makefile.config                         |  39 +-
> >  tools/perf/Makefile.perf                           |  12 +-
> >  tools/perf/arch/alpha/entry/syscalls/Kbuild        |   2 +
> >  .../arch/alpha/entry/syscalls/Makefile.syscalls    |   5 +
> >  tools/perf/arch/alpha/entry/syscalls/syscall.tbl   | 504 ++++++++++++++++++++
> >  tools/perf/arch/alpha/include/syscall_table.h      |   2 +
> >  tools/perf/arch/arc/entry/syscalls/Kbuild          |   2 +
> >  .../perf/arch/arc/entry/syscalls/Makefile.syscalls |   3 +
> >  tools/perf/arch/arc/include/syscall_table.h        |   2 +
> >  tools/perf/arch/arm/entry/syscalls/Kbuild          |   4 +
> >  .../perf/arch/arm/entry/syscalls/Makefile.syscalls |   2 +
> >  tools/perf/arch/arm/entry/syscalls/syscall.tbl     | 483 +++++++++++++++++++
> >  tools/perf/arch/arm/include/syscall_table.h        |   2 +
> >  tools/perf/arch/arm64/Makefile                     |  22 -
> >  tools/perf/arch/arm64/entry/syscalls/Kbuild        |   3 +
> >  .../arch/arm64/entry/syscalls/Makefile.syscalls    |   6 +
> >  tools/perf/arch/arm64/entry/syscalls/mksyscalltbl  |  46 --
> >  .../perf/arch/arm64/entry/syscalls/syscall_32.tbl  | 476 +++++++++++++++++++
> >  .../perf/arch/arm64/entry/syscalls/syscall_64.tbl  |   1 +
> >  tools/perf/arch/arm64/include/syscall_table.h      |   8 +
> >  tools/perf/arch/csky/entry/syscalls/Kbuild         |   2 +
> >  .../arch/csky/entry/syscalls/Makefile.syscalls     |   3 +
> >  tools/perf/arch/csky/include/syscall_table.h       |   2 +
> >  tools/perf/arch/loongarch/Makefile                 |  22 -
> >  tools/perf/arch/loongarch/entry/syscalls/Kbuild    |   2 +
> >  .../loongarch/entry/syscalls/Makefile.syscalls     |   3 +
> >  .../arch/loongarch/entry/syscalls/mksyscalltbl     |  45 --
> >  tools/perf/arch/loongarch/include/syscall_table.h  |   2 +
> >  tools/perf/arch/mips/entry/syscalls/Kbuild         |   2 +
> >  .../arch/mips/entry/syscalls/Makefile.syscalls     |   5 +
> >  tools/perf/arch/mips/entry/syscalls/mksyscalltbl   |  32 --
> >  tools/perf/arch/mips/include/syscall_table.h       |   2 +
> >  tools/perf/arch/parisc/entry/syscalls/Kbuild       |   3 +
> >  .../arch/parisc/entry/syscalls/Makefile.syscalls   |   6 +
> >  tools/perf/arch/parisc/entry/syscalls/syscall.tbl  | 463 +++++++++++++++++++
> >  tools/perf/arch/parisc/include/syscall_table.h     |   8 +
> >  tools/perf/arch/powerpc/Makefile                   |  25 -
> >  tools/perf/arch/powerpc/entry/syscalls/Kbuild      |   3 +
> >  .../arch/powerpc/entry/syscalls/Makefile.syscalls  |   6 +
> >  .../perf/arch/powerpc/entry/syscalls/mksyscalltbl  |  39 --
> >  tools/perf/arch/powerpc/include/syscall_table.h    |   8 +
> >  tools/perf/arch/riscv/Makefile                     |  22 -
> >  tools/perf/arch/riscv/entry/syscalls/Kbuild        |   2 +
> >  .../arch/riscv/entry/syscalls/Makefile.syscalls    |   4 +
> >  tools/perf/arch/riscv/entry/syscalls/mksyscalltbl  |  47 --
> >  tools/perf/arch/riscv/include/syscall_table.h      |   8 +
> >  tools/perf/arch/s390/Makefile                      |  21 -
> >  tools/perf/arch/s390/entry/syscalls/Kbuild         |   2 +
> >  .../arch/s390/entry/syscalls/Makefile.syscalls     |   5 +
> >  tools/perf/arch/s390/entry/syscalls/mksyscalltbl   |  32 --
> >  tools/perf/arch/s390/include/syscall_table.h       |   2 +
> >  tools/perf/arch/sh/entry/syscalls/Kbuild           |   2 +
> >  .../perf/arch/sh/entry/syscalls/Makefile.syscalls  |   4 +
> >  tools/perf/arch/sh/entry/syscalls/syscall.tbl      | 472 +++++++++++++++++++
> >  tools/perf/arch/sh/include/syscall_table.h         |   2 +
> >  tools/perf/arch/sparc/entry/syscalls/Kbuild        |   3 +
> >  .../arch/sparc/entry/syscalls/Makefile.syscalls    |   5 +
> >  tools/perf/arch/sparc/entry/syscalls/syscall.tbl   | 514 +++++++++++++++++++++
> >  tools/perf/arch/sparc/include/syscall_table.h      |   8 +
> >  tools/perf/arch/x86/Build                          |   1 -
> >  tools/perf/arch/x86/Makefile                       |  25 -
> >  tools/perf/arch/x86/entry/syscalls/Kbuild          |   3 +
> >  .../perf/arch/x86/entry/syscalls/Makefile.syscalls |   6 +
> >  tools/perf/arch/x86/entry/syscalls/syscalltbl.sh   |  42 --
> >  tools/perf/arch/x86/include/syscall_table.h        |   8 +
> >  tools/perf/arch/xtensa/entry/syscalls/Kbuild       |   2 +
> >  .../arch/xtensa/entry/syscalls/Makefile.syscalls   |   4 +
> >  tools/perf/arch/xtensa/entry/syscalls/syscall.tbl  | 439 ++++++++++++++++++
> >  tools/perf/arch/xtensa/include/syscall_table.h     |   2 +
> >  tools/perf/builtin-check.c                         |   1 -
> >  tools/perf/builtin-help.c                          |   2 -
> >  tools/perf/builtin-trace.c                         |  30 --
> >  tools/perf/check-headers.sh                        |   9 +
> >  tools/perf/perf.c                                  |   6 +-
> >  tools/perf/scripts/Makefile.syscalls               |  61 +++
> >  tools/perf/scripts/syscalltbl.sh                   |  86 ++++
> >  tools/perf/tests/make                              |   7 +-
> >  tools/perf/util/env.c                              |   4 +-
> >  tools/perf/util/generate-cmdlist.sh                |   4 +-
> >  tools/perf/util/syscalltbl.c                       |  90 +---
> >  tools/scripts/syscall.tbl                          | 409 ++++++++++++++++
> >  85 files changed, 4102 insertions(+), 619 deletions(-)
> > ---
> > base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
> > change-id: 20240913-perf_syscalltbl-6f98defcc6f5
> > --
> > - Charlie
> >
