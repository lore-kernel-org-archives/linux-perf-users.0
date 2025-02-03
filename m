Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB9C150980
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Feb 2025 19:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738610120; cv=none; b=pWPjLCJ8bKJ7N6ywl4bpeCE9c+y9iDj13CyUchPB/rlRGWKANDlaqGERzoXA7ljOaU5SjZ/u6Gii/qCxMufDFsmEabvLBnhVijrzQ6MCw46sYodoBsCkrbZIVUWc9jNdvxILixtUp4PimF0vByoHcyzRPxmtCMBCYeIQR2CdIgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738610120; c=relaxed/simple;
	bh=1eukzfk/qoeEs/MvVf2UR7p9fD5fIxj3KFpYr6+vSWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVV3Xa2FKthzYc0BuqEzUimjO3tIN636Lg2WlsDHSz3I9+sRYPSbow4rbRGqpj9VLsctIlTXJWDTiAAHuZgxGit1LlB27kVi6I5S7x22xuWrcRA+Ts/UJo9sPCrTdJd5HBy4WBbr6jvEnqXHDKDBRn2LgJfW9zw8xX6shIM1KxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=OotxtKWW; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="OotxtKWW"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-21654fdd5daso82766355ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Feb 2025 11:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738610117; x=1739214917; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s5WYJSVQEj2dIPfcyxFbM6JaAz2cg3KwbW58tJF8Jpk=;
        b=OotxtKWWyfXpsOnkR2lH/PCbxSBZ9/yZuG6Yq/7g1SWjYRYt3hDBFWm36opgkvkLAo
         CFMdk0Vrs5fLsJkl2tiTzvyQwJRDbxqSAGnGetToesLldZ2hHGShdXVzPHnWi3PRXQaj
         y8WdG6caohoCU0+/UMWNEpP3+hAYkzp68gf8HlkiPLQeE3R2XNMU9OGp1/M+Ms/zLFu/
         h5kko5GGeB/M55OHcWvQ+/yWKTKlMyL1aqbNG5qfZK34tzWd3lu80e7yp5aJJQvqQmo3
         9vi88fKogha0VOYmIEU25WvBQmRqz1s05S/B9OiyMf3y4sWiopZxyjk6f5JcdEZYqnw+
         RFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738610117; x=1739214917;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s5WYJSVQEj2dIPfcyxFbM6JaAz2cg3KwbW58tJF8Jpk=;
        b=fSg4JGZoBSyMazvjLulFx6oHkwVHjQoUic+54eWtYM/eTgiGbsuKx8+nTjv3qsyRR+
         aDy3TGfa7N1B33ceVSmuuduUgpD8DTD1gaiJ0tTI2EdrjIGKx75af5zsofHfRlf+Is8B
         p9YWYemCdoxpPnaWFzpWuvhY+IoTIj9i6K8glCT4aldgPfT0d+B6zpCr8lVbLak5xmmz
         FKHJsoqmw7P9iLfvVpHFqzdEL+9NiftdFylRdjyVc/ihH1KSJyjtYc7Af9Og/JhUTZ6d
         r0CNjTGRI+LFgF9Rw1vCe1BqBlBz63FozGkEYCWhsnS5eS2Z7cl73++eVAXbWP/hYxBy
         aUZg==
X-Forwarded-Encrypted: i=1; AJvYcCVlq4GP4XRQ73pQMo4+rBrRet8unjFjwzlrUtZXV/5+6lLCxda67QEwOjyiqXLuDiuFFGYTo5QfKjl3vnIkqmMs@vger.kernel.org
X-Gm-Message-State: AOJu0YyOe+d2L9FX5qr/iXEfCFEdxkXm/HTgk2fDgusvUBKKGBpQXDq5
	AqnenosnaeCUC8u5e3JRNstsGd7BmPd8Vrm5zI9MdJuaTDgSeWAZJt08K7uxVrQ=
X-Gm-Gg: ASbGncv5+iBvr8ac7tfjpByFWKDHeRlQIgl7so17m7obL5E8VXfcR2e43SRB3pyRm/X
	H6D17rOCPVE0d/DiFI5c2mmFnKp9XNTsokgd29YinaVYKRLNSGDUaoFLh8C5w9kCCckeSEh98sC
	pQcCLSETDJeDtAg+d8Yon95s7dq/Kc0O5BMr8nlaNtfe/VSYDB88N33D87RdCIsW3ozsDQ7/Nes
	yKACkwFWHpYevVZIuWv7rSZKF9mDzviAiaRb+UXhpJG96gL1e7xBG940GicSLuqcyV5YPdCFdFz
	+FZBU/WwwI8=
X-Google-Smtp-Source: AGHT+IGa8q1L/w2WsP8N8nsLp1KLayBcPH09Ym4t3KD9fyuAGMJmjHdlYaNkbdFwKMu+prfIEcxVEw==
X-Received: by 2002:a17:902:db04:b0:216:4c88:d93a with SMTP id d9443c01a7336-21dd7dd7356mr392103185ad.48.1738610117017;
        Mon, 03 Feb 2025 11:15:17 -0800 (PST)
Received: from ghost ([2601:647:6700:64d0:4f63:f9d5:2cbd:2947])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de331f8c9sm80863205ad.227.2025.02.03.11.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 11:15:16 -0800 (PST)
Date: Mon, 3 Feb 2025 11:15:13 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Guo Ren <guoren@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Bibo Mao <maobibo@loongson.cn>,
	Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v1 0/7] perf: Support multiple system call tables in the
 build
Message-ID: <Z6EVwaOVYaKtaK1j@ghost>
References: <20250201071455.718247-1-irogers@google.com>
 <Z6EStkn-YZ8zaO7u@ghost>
 <CAP-5=fXRz_8CKNz4Fr-=0yhKbf_QE2ND+PPykSAO5p8wcUz7xA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXRz_8CKNz4Fr-=0yhKbf_QE2ND+PPykSAO5p8wcUz7xA@mail.gmail.com>

On Mon, Feb 03, 2025 at 11:10:49AM -0800, Ian Rogers wrote:
> On Mon, Feb 3, 2025 at 11:02 AM Charlie Jenkins <charlie@rivosinc.com> wrote:
> >
> > On Fri, Jan 31, 2025 at 11:14:48PM -0800, Ian Rogers wrote:
> > > This work builds on the clean up of system call tables and removal of
> > > libaudit by Charlie Jenkins <charlie@rivosinc.com>.
> > >
> > > The system call table in perf trace is used to map system call numbers
> > > to names and vice versa. Prior to these changes, a single table
> > > matching the perf binary's build was present. The table would be
> > > incorrect if tracing say a 32-bit binary from a 64-bit version of
> > > perf, the names and numbers wouldn't match.
> > >
> > > Change the build so that a single system call file is built and the
> > > potentially multiple tables are identifiable from the ELF machine type
> > > of the process being examined. To determine the ELF machine type, the
> > > executable's header is read from /proc/pid/exe with fallbacks to using
> > > the perf's binary type when unknown.
> > >
> > > Remove some runtime types used by the system call tables and make
> > > equivalents generated at build time.
> >
> > Our approaches are very different but I sent out a patch to do this a
> > couple of weeks ago [1].
> >
> > Did you look at that and decide you didn't like the approach?
> 
> Missing link?

Whoops here is the link:

https://lore.kernel.org/all/20250114-perf_syscall_arch_runtime-v1-1-5b304e408e11@rivosinc.com/

> 
> The patches generating a syscall(_32|_64)?.h landed. These changes
> take your changes and make it so that we just run the script once
> building a header file for all architectures. On x86 we then have the
> tables be guarded by ifdefs on i386 and x86-64. Then rather than the
> table just matching the host architecture the ELF machine is used for
> the executable running.
> 
> Thanks,
> Ian
> 
> > - Charlie
> >
> > >
> > > Ian Rogers (7):
> > >   perf syscalltble: Remove syscall_table.h
> > >   perf trace: Reorganize syscalls
> > >   perf syscalltbl: Remove struct syscalltbl
> > >   perf thread: Add support for reading the e_machine type for a thread
> > >   perf trace beauty: Add syscalltbl.sh generating all system call tables
> > >   perf syscalltbl: Use lookup table containing multiple architectures
> > >   perf build: Remove Makefile.syscalls
> > >
> > >  tools/perf/Makefile.perf                      |  10 +-
> > >  tools/perf/arch/alpha/entry/syscalls/Kbuild   |   2 -
> > >  .../alpha/entry/syscalls/Makefile.syscalls    |   5 -
> > >  tools/perf/arch/alpha/include/syscall_table.h |   2 -
> > >  tools/perf/arch/arc/entry/syscalls/Kbuild     |   2 -
> > >  .../arch/arc/entry/syscalls/Makefile.syscalls |   3 -
> > >  tools/perf/arch/arc/include/syscall_table.h   |   2 -
> > >  tools/perf/arch/arm/entry/syscalls/Kbuild     |   4 -
> > >  .../arch/arm/entry/syscalls/Makefile.syscalls |   2 -
> > >  tools/perf/arch/arm/include/syscall_table.h   |   2 -
> > >  tools/perf/arch/arm64/entry/syscalls/Kbuild   |   3 -
> > >  .../arm64/entry/syscalls/Makefile.syscalls    |   6 -
> > >  tools/perf/arch/arm64/include/syscall_table.h |   8 -
> > >  tools/perf/arch/csky/entry/syscalls/Kbuild    |   2 -
> > >  .../csky/entry/syscalls/Makefile.syscalls     |   3 -
> > >  tools/perf/arch/csky/include/syscall_table.h  |   2 -
> > >  .../perf/arch/loongarch/entry/syscalls/Kbuild |   2 -
> > >  .../entry/syscalls/Makefile.syscalls          |   3 -
> > >  .../arch/loongarch/include/syscall_table.h    |   2 -
> > >  tools/perf/arch/mips/entry/syscalls/Kbuild    |   2 -
> > >  .../mips/entry/syscalls/Makefile.syscalls     |   5 -
> > >  tools/perf/arch/mips/include/syscall_table.h  |   2 -
> > >  tools/perf/arch/parisc/entry/syscalls/Kbuild  |   3 -
> > >  .../parisc/entry/syscalls/Makefile.syscalls   |   6 -
> > >  .../perf/arch/parisc/include/syscall_table.h  |   8 -
> > >  tools/perf/arch/powerpc/entry/syscalls/Kbuild |   3 -
> > >  .../powerpc/entry/syscalls/Makefile.syscalls  |   6 -
> > >  .../perf/arch/powerpc/include/syscall_table.h |   8 -
> > >  tools/perf/arch/riscv/entry/syscalls/Kbuild   |   2 -
> > >  .../riscv/entry/syscalls/Makefile.syscalls    |   4 -
> > >  tools/perf/arch/riscv/include/syscall_table.h |   8 -
> > >  tools/perf/arch/s390/entry/syscalls/Kbuild    |   2 -
> > >  .../s390/entry/syscalls/Makefile.syscalls     |   5 -
> > >  tools/perf/arch/s390/include/syscall_table.h  |   2 -
> > >  tools/perf/arch/sh/entry/syscalls/Kbuild      |   2 -
> > >  .../arch/sh/entry/syscalls/Makefile.syscalls  |   4 -
> > >  tools/perf/arch/sh/include/syscall_table.h    |   2 -
> > >  tools/perf/arch/sparc/entry/syscalls/Kbuild   |   3 -
> > >  .../sparc/entry/syscalls/Makefile.syscalls    |   5 -
> > >  tools/perf/arch/sparc/include/syscall_table.h |   8 -
> > >  tools/perf/arch/x86/entry/syscalls/Kbuild     |   3 -
> > >  .../arch/x86/entry/syscalls/Makefile.syscalls |   6 -
> > >  tools/perf/arch/x86/include/syscall_table.h   |   8 -
> > >  tools/perf/arch/xtensa/entry/syscalls/Kbuild  |   2 -
> > >  .../xtensa/entry/syscalls/Makefile.syscalls   |   4 -
> > >  .../perf/arch/xtensa/include/syscall_table.h  |   2 -
> > >  tools/perf/builtin-trace.c                    | 275 +++++++++++-------
> > >  tools/perf/scripts/Makefile.syscalls          |  61 ----
> > >  tools/perf/scripts/syscalltbl.sh              |  86 ------
> > >  tools/perf/trace/beauty/syscalltbl.sh         | 274 +++++++++++++++++
> > >  tools/perf/util/syscalltbl.c                  | 142 ++++-----
> > >  tools/perf/util/syscalltbl.h                  |  22 +-
> > >  tools/perf/util/thread.c                      |  50 ++++
> > >  tools/perf/util/thread.h                      |  14 +-
> > >  54 files changed, 598 insertions(+), 506 deletions(-)
> > >  delete mode 100644 tools/perf/arch/alpha/entry/syscalls/Kbuild
> > >  delete mode 100644 tools/perf/arch/alpha/entry/syscalls/Makefile.syscalls
> > >  delete mode 100644 tools/perf/arch/alpha/include/syscall_table.h
> > >  delete mode 100644 tools/perf/arch/arc/entry/syscalls/Kbuild
> > >  delete mode 100644 tools/perf/arch/arc/entry/syscalls/Makefile.syscalls
> > >  delete mode 100644 tools/perf/arch/arc/include/syscall_table.h
> > >  delete mode 100644 tools/perf/arch/arm/entry/syscalls/Kbuild
> > >  delete mode 100644 tools/perf/arch/arm/entry/syscalls/Makefile.syscalls
> > >  delete mode 100644 tools/perf/arch/arm/include/syscall_table.h
> > >  delete mode 100644 tools/perf/arch/arm64/entry/syscalls/Kbuild
> > >  delete mode 100644 tools/perf/arch/arm64/entry/syscalls/Makefile.syscalls
> > >  delete mode 100644 tools/perf/arch/arm64/include/syscall_table.h
> > >  delete mode 100644 tools/perf/arch/csky/entry/syscalls/Kbuild
> > >  delete mode 100644 tools/perf/arch/csky/entry/syscalls/Makefile.syscalls
> > >  delete mode 100644 tools/perf/arch/csky/include/syscall_table.h
> > >  delete mode 100644 tools/perf/arch/loongarch/entry/syscalls/Kbuild
> > >  delete mode 100644 tools/perf/arch/loongarch/entry/syscalls/Makefile.syscalls
> > >  delete mode 100644 tools/perf/arch/loongarch/include/syscall_table.h
> > >  delete mode 100644 tools/perf/arch/mips/entry/syscalls/Kbuild
> > >  delete mode 100644 tools/perf/arch/mips/entry/syscalls/Makefile.syscalls
> > >  delete mode 100644 tools/perf/arch/mips/include/syscall_table.h
> > >  delete mode 100644 tools/perf/arch/parisc/entry/syscalls/Kbuild
> > >  delete mode 100644 tools/perf/arch/parisc/entry/syscalls/Makefile.syscalls
> > >  delete mode 100644 tools/perf/arch/parisc/include/syscall_table.h
> > >  delete mode 100644 tools/perf/arch/powerpc/entry/syscalls/Kbuild
> > >  delete mode 100644 tools/perf/arch/powerpc/entry/syscalls/Makefile.syscalls
> > >  delete mode 100644 tools/perf/arch/powerpc/include/syscall_table.h
> > >  delete mode 100644 tools/perf/arch/riscv/entry/syscalls/Kbuild
> > >  delete mode 100644 tools/perf/arch/riscv/entry/syscalls/Makefile.syscalls
> > >  delete mode 100644 tools/perf/arch/riscv/include/syscall_table.h
> > >  delete mode 100644 tools/perf/arch/s390/entry/syscalls/Kbuild
> > >  delete mode 100644 tools/perf/arch/s390/entry/syscalls/Makefile.syscalls
> > >  delete mode 100644 tools/perf/arch/s390/include/syscall_table.h
> > >  delete mode 100644 tools/perf/arch/sh/entry/syscalls/Kbuild
> > >  delete mode 100644 tools/perf/arch/sh/entry/syscalls/Makefile.syscalls
> > >  delete mode 100644 tools/perf/arch/sh/include/syscall_table.h
> > >  delete mode 100644 tools/perf/arch/sparc/entry/syscalls/Kbuild
> > >  delete mode 100644 tools/perf/arch/sparc/entry/syscalls/Makefile.syscalls
> > >  delete mode 100644 tools/perf/arch/sparc/include/syscall_table.h
> > >  delete mode 100644 tools/perf/arch/x86/entry/syscalls/Kbuild
> > >  delete mode 100644 tools/perf/arch/x86/entry/syscalls/Makefile.syscalls
> > >  delete mode 100644 tools/perf/arch/x86/include/syscall_table.h
> > >  delete mode 100644 tools/perf/arch/xtensa/entry/syscalls/Kbuild
> > >  delete mode 100644 tools/perf/arch/xtensa/entry/syscalls/Makefile.syscalls
> > >  delete mode 100644 tools/perf/arch/xtensa/include/syscall_table.h
> > >  delete mode 100644 tools/perf/scripts/Makefile.syscalls
> > >  delete mode 100755 tools/perf/scripts/syscalltbl.sh
> > >  create mode 100755 tools/perf/trace/beauty/syscalltbl.sh
> > >
> > > --
> > > 2.48.1.362.g079036d154-goog
> > >
