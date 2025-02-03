Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CB9211701
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Feb 2025 23:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738623766; cv=none; b=sGSRbdcXSqxyjVGrvF9gJGK1reh+ZFN3nkYYKLojqu/ihtOXhY7x6i3CKRWEqghVNkIGNj49eyrvsVnGQTiOmXp0OFt/TH627hv0aO+Kblkz8iquSyr56mOHZPdgIJ1bq4rDiGn1/S4r2fXzphdTp0D/hKT8OL5kysTIy7RLafQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738623766; c=relaxed/simple;
	bh=Q+iPl49UU0AvdpV59GquMjusOlZaViuHVDbDTurGm9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exz9DoCfM4dQcl0JkpYJkqMxnSSFoYQPCTRoSRulZsVxfs5C2uiejd5UiRGe0zNsVR5ikCOuj6vJQ+SPZitxinJZXYj304HhRKimzgNbqhRQcf78r6YArAimJdUVVSJIb80snnD9cRd0VMhTjv9Io3BMDTJ9/fCtiFoJAdgZMkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Dd222FKo; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Dd222FKo"
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-2eeb4d643a5so8268757a91.3
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Feb 2025 15:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738623760; x=1739228560; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mlSZOZfwKYccscHiA8mCvG85W1nYtxF2uCQLvRSMURg=;
        b=Dd222FKoWIe8gx1MTxjkKbNLoEKLkI4xkv/tjglpiU/FoDwg7OktmWDkHrNsVHhaXd
         urkmdRBbzWvROMrpNPMmwLmv5TPe2gGwtDh7P8UxIy7Rsf1YHGo8uukg/RaEe4ycIzPP
         QjtGPvVffsQtwlONCWRbwwZf6PVcQatnLg7iAllA2i3TJN6KCPs8mGiKhTcwkHEde1IK
         D83bHBllwOWaT44vjBIXf4qELrs8L4wzMiToRdSeaOMIS2jrM7aIM7g9MPoOKPo7nod6
         joiYQstXUm6Lx54VaeMLHGePFzGBdgIa61ZYj8A+BHBEIB65WUoJxeojYZdosGds2E2R
         hpAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738623760; x=1739228560;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mlSZOZfwKYccscHiA8mCvG85W1nYtxF2uCQLvRSMURg=;
        b=ChOI7ry2Lub+ZeMVhnBqedaMIANEWV3DVQe6EZXSUOONcMGzfQr2X2j4dcUhEoZhgy
         /f2qzypqMJOk1Kg4roVtYCFB8PurnGB/ilBhQse62V4a1vkTtjZKuCdTWCtybh5CmAik
         GfMm5kPEFVviwit6Ya+41ktVoSu9J+d6M5W8Bb8WEecKK3i5+vyDYl9O/wmTKuzMt68W
         aI2Uju6SB3LjhuiPYHviTjXAzPkEqpk4xA6eI6U3ZqdKbL4eAa2RXn1CSI3KaqiFzsjC
         +zfur2ass7WOACxcZ9S5EC0U732U/uk+O9rfqQDw3E9iaXScFkl5L4JysBfx+Ii5ohp9
         Tm4A==
X-Forwarded-Encrypted: i=1; AJvYcCVJj2VpLi7q9jG6BFwrPwqnimEHxl+mUYszt1DoI3id49lUqKLExCq1naEMno0XosDP+k8e+793Pz1/KSKDOIXi@vger.kernel.org
X-Gm-Message-State: AOJu0YwVGFIfWuhBCxLluxUuAak0soUU7bGkDPTFMr5uFmwzsxrs/TB/
	qHcfD63cfIcRdzz7HOBeX0tsxJ8M6ls4myaDamIB9hV4ehsxOFFmefrQp6Pot4Q=
X-Gm-Gg: ASbGncvQ/UJt6SpXHgqlqOtYInWr8WuwtvvdmYQBZ2jm9D0snW8ZqflD3dEk89kv1PK
	zeeHNjjGksKfj7dFB6ut54Nzxn5noVB16fws9lhiHuPhJV/CEXikFS/gGqM8ZbzOOvj+874rQaq
	vGXSF7MDP+MINR02itDfA8kriIZm7vOJAIDLhTnq5xU6Cpw2jt3+Y5ae6BCJXNW2i+2keZdT2gu
	AnFxCkNlyYzG/kkZ1x0cex0CTbDc6PuIXfWxh2pU3KEJP3BZFmBCHIFzA6oQY2I8wcIocyPNn3x
	GwYg/uhQHpA=
X-Google-Smtp-Source: AGHT+IHVmCZ8M1HoH0RNab91JXVoT4R3jnAicYRidYc+9QjQ5Apn2RrVQw3Ur/bkgiLbrVxSa0JAIA==
X-Received: by 2002:a17:90b:2742:b0:2ee:b4d4:69 with SMTP id 98e67ed59e1d1-2f83ac87677mr33404517a91.35.1738623760388;
        Mon, 03 Feb 2025 15:02:40 -0800 (PST)
Received: from ghost ([2601:647:6700:64d0:4f63:f9d5:2cbd:2947])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f848acacadsm9535576a91.41.2025.02.03.15.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 15:02:39 -0800 (PST)
Date: Mon, 3 Feb 2025 15:02:36 -0800
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
Message-ID: <Z6FLDHz6V5L-HGR7@ghost>
References: <20250201071455.718247-1-irogers@google.com>
 <Z6EStkn-YZ8zaO7u@ghost>
 <CAP-5=fXRz_8CKNz4Fr-=0yhKbf_QE2ND+PPykSAO5p8wcUz7xA@mail.gmail.com>
 <Z6EVwaOVYaKtaK1j@ghost>
 <CAP-5=fX1hCNWWmGJPKYxj93S=zM1-eRucqzb4WW5fB_sZBCRLg@mail.gmail.com>
 <Z6Eh1QLuqTbUKLCc@ghost>
 <CAP-5=fXZr8L4Z=Lb28QDZF8cbv2eJJEHSb0H9zcqSOB9cn5-9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXZr8L4Z=Lb28QDZF8cbv2eJJEHSb0H9zcqSOB9cn5-9g@mail.gmail.com>

On Mon, Feb 03, 2025 at 12:54:59PM -0800, Ian Rogers wrote:
> On Mon, Feb 3, 2025 at 12:06 PM Charlie Jenkins <charlie@rivosinc.com> wrote:
> >
> > On Mon, Feb 03, 2025 at 11:39:01AM -0800, Ian Rogers wrote:
> > > On Mon, Feb 3, 2025 at 11:15 AM Charlie Jenkins <charlie@rivosinc.com> wrote:
> > > >
> > > > On Mon, Feb 03, 2025 at 11:10:49AM -0800, Ian Rogers wrote:
> > > > > On Mon, Feb 3, 2025 at 11:02 AM Charlie Jenkins <charlie@rivosinc.com> wrote:
> > > > > >
> > > > > > On Fri, Jan 31, 2025 at 11:14:48PM -0800, Ian Rogers wrote:
> > > > > > > This work builds on the clean up of system call tables and removal of
> > > > > > > libaudit by Charlie Jenkins <charlie@rivosinc.com>.
> > > > > > >
> > > > > > > The system call table in perf trace is used to map system call numbers
> > > > > > > to names and vice versa. Prior to these changes, a single table
> > > > > > > matching the perf binary's build was present. The table would be
> > > > > > > incorrect if tracing say a 32-bit binary from a 64-bit version of
> > > > > > > perf, the names and numbers wouldn't match.
> > > > > > >
> > > > > > > Change the build so that a single system call file is built and the
> > > > > > > potentially multiple tables are identifiable from the ELF machine type
> > > > > > > of the process being examined. To determine the ELF machine type, the
> > > > > > > executable's header is read from /proc/pid/exe with fallbacks to using
> > > > > > > the perf's binary type when unknown.
> > > > > > >
> > > > > > > Remove some runtime types used by the system call tables and make
> > > > > > > equivalents generated at build time.
> > > > > >
> > > > > > Our approaches are very different but I sent out a patch to do this a
> > > > > > couple of weeks ago [1].
> > > > > >
> > > > > > Did you look at that and decide you didn't like the approach?
> > > > >
> > > > > Missing link?
> > > >
> > > > Whoops here is the link:
> > > >
> > > > https://lore.kernel.org/all/20250114-perf_syscall_arch_runtime-v1-1-5b304e408e11@rivosinc.com/
> > >
> > > I agree it is similar and progress, I think I prefer my changes :-)
> > >
> > > Anything in the arch directories is only going to be built given a
> > > Makefile SRCARCH:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/arch/Build?h=perf-tools-next#n2
> > > which means if we want the system call tables for say ARM on x86-64 we
> > > need to reinvent the build - this isn't a problem today but perhaps
> > > something to consider if we wanted a cross-architecture perf trace
> > > record. I'd like to do away entirely with the arch directory for this
> > > kind of reason. For example, if we run perf on a user space emulator
> > > (say a testing set up) and it sees AMD data fabric PMUs, logic for
> > > those PMUs currently lives in the arch directory for x86 and likely
> > > wasn't even built into the perf tool. We should be able to identify
> > > PMUs and act accordingly based on their names. In the case of the
> > > overloaded "cpu" PMU we can identify it with the CPUID. The less code
> > > in arch and the fewer architecture ifdefs, the better things should
> > > work cross-architecture, in testing scenarios, etc. We also win by
> > > getting code coverage without, for example, having to build and test
> > > on csky or super H.
> > >
> > > Your changes are using the string for the architecture name. I think
> > > that string is something we should get rid of:
> > > https://lore.kernel.org/lkml/CAP-5=fX2BtFzhGLCSqO1QszqfX=HT8RrTdG_5Ttp5Gw4seSstA@mail.gmail.com/
> > > but there's no reason we couldn't clean that up on top of your change.
> >
> > Yes that part is not ideal.
> >
> > >
> > > The build with lots of separate Build/Makefiles is something of a pain
> > > to port/maintain in a bazel version of the build I maintain at Google
> > > (happy to open source if anyone cares). In these changes you just run
> > > a big script and get a big header file out the end, which largely
> > > matches the other perf trace beauty things we build.
> >
> > Fair enough! I wanted to mimic how the kernel was building the syscall
> > tables as closely as possible, it's convenient to have cohesion.
> 
> I think it makes sense in the kernel, as the built binary doesn't have
> cross-platform concerns. This is probably also the reason why the perf
> tool has an arch directory. Let me know what you think is the right
> direction for the perf tool syscall table code.

I am hesitant about moving all of the arch-specific syscall generation
flags into a single file. There is currently a really clean separation
between the architectures and it's possible to generate all of the
syscall tables for all of the architecutures based on the paths to the
syscall table. What causes the arch directory to be a pain for Bazel? I
guess I am mostly confused why it makes sense to change the kernel
Makefiles in order to accomidate a rewrite of the build system in Bazel
that isn't planned to be used upstream.

- Charlie

> 
> > What is the usecase for the bazel version?
> 
> I'm sure there's more info in:
> https://bazel.build/
> but the main thing is having hermetic and reproducible builds. The
> main problem with open sourcing would be dealing with external
> repositories, test set up, etc. Tbh, hermetic builds are a challenge
> as things like lex and yacc will vary the C code they generate based
> on the platform they run on. Bazel has plans to change the world so
> maybe this could be more of a thing in the future.
> 
> Fwiw, I did push changes into the perf tree so that man page building
> was reproducible:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/commit/tools/perf/Documentation?h=perf-tools-next&id=d586ac10ce56b2381b8e1d8ed74660c1b2b8ab0d
> The man pages used to reflect the date/time they were built, but now
> reflect the date the of the commit of the file being built:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/Documentation/Makefile?h=perf-tools-next#n255
> 
> Thanks,
> Ian
> 
> > - Charlie
> >
> > >
> > > Thanks,
> > > Ian
> > >
> > > > >
> > > > > The patches generating a syscall(_32|_64)?.h landed. These changes
> > > > > take your changes and make it so that we just run the script once
> > > > > building a header file for all architectures. On x86 we then have the
> > > > > tables be guarded by ifdefs on i386 and x86-64. Then rather than the
> > > > > table just matching the host architecture the ELF machine is used for
> > > > > the executable running.
> > > > >
> > > > > Thanks,
> > > > > Ian
> > > > >
> > > > > > - Charlie
> > > > > >
> > > > > > >
> > > > > > > Ian Rogers (7):
> > > > > > >   perf syscalltble: Remove syscall_table.h
> > > > > > >   perf trace: Reorganize syscalls
> > > > > > >   perf syscalltbl: Remove struct syscalltbl
> > > > > > >   perf thread: Add support for reading the e_machine type for a thread
> > > > > > >   perf trace beauty: Add syscalltbl.sh generating all system call tables
> > > > > > >   perf syscalltbl: Use lookup table containing multiple architectures
> > > > > > >   perf build: Remove Makefile.syscalls
> > > > > > >
> > > > > > >  tools/perf/Makefile.perf                      |  10 +-
> > > > > > >  tools/perf/arch/alpha/entry/syscalls/Kbuild   |   2 -
> > > > > > >  .../alpha/entry/syscalls/Makefile.syscalls    |   5 -
> > > > > > >  tools/perf/arch/alpha/include/syscall_table.h |   2 -
> > > > > > >  tools/perf/arch/arc/entry/syscalls/Kbuild     |   2 -
> > > > > > >  .../arch/arc/entry/syscalls/Makefile.syscalls |   3 -
> > > > > > >  tools/perf/arch/arc/include/syscall_table.h   |   2 -
> > > > > > >  tools/perf/arch/arm/entry/syscalls/Kbuild     |   4 -
> > > > > > >  .../arch/arm/entry/syscalls/Makefile.syscalls |   2 -
> > > > > > >  tools/perf/arch/arm/include/syscall_table.h   |   2 -
> > > > > > >  tools/perf/arch/arm64/entry/syscalls/Kbuild   |   3 -
> > > > > > >  .../arm64/entry/syscalls/Makefile.syscalls    |   6 -
> > > > > > >  tools/perf/arch/arm64/include/syscall_table.h |   8 -
> > > > > > >  tools/perf/arch/csky/entry/syscalls/Kbuild    |   2 -
> > > > > > >  .../csky/entry/syscalls/Makefile.syscalls     |   3 -
> > > > > > >  tools/perf/arch/csky/include/syscall_table.h  |   2 -
> > > > > > >  .../perf/arch/loongarch/entry/syscalls/Kbuild |   2 -
> > > > > > >  .../entry/syscalls/Makefile.syscalls          |   3 -
> > > > > > >  .../arch/loongarch/include/syscall_table.h    |   2 -
> > > > > > >  tools/perf/arch/mips/entry/syscalls/Kbuild    |   2 -
> > > > > > >  .../mips/entry/syscalls/Makefile.syscalls     |   5 -
> > > > > > >  tools/perf/arch/mips/include/syscall_table.h  |   2 -
> > > > > > >  tools/perf/arch/parisc/entry/syscalls/Kbuild  |   3 -
> > > > > > >  .../parisc/entry/syscalls/Makefile.syscalls   |   6 -
> > > > > > >  .../perf/arch/parisc/include/syscall_table.h  |   8 -
> > > > > > >  tools/perf/arch/powerpc/entry/syscalls/Kbuild |   3 -
> > > > > > >  .../powerpc/entry/syscalls/Makefile.syscalls  |   6 -
> > > > > > >  .../perf/arch/powerpc/include/syscall_table.h |   8 -
> > > > > > >  tools/perf/arch/riscv/entry/syscalls/Kbuild   |   2 -
> > > > > > >  .../riscv/entry/syscalls/Makefile.syscalls    |   4 -
> > > > > > >  tools/perf/arch/riscv/include/syscall_table.h |   8 -
> > > > > > >  tools/perf/arch/s390/entry/syscalls/Kbuild    |   2 -
> > > > > > >  .../s390/entry/syscalls/Makefile.syscalls     |   5 -
> > > > > > >  tools/perf/arch/s390/include/syscall_table.h  |   2 -
> > > > > > >  tools/perf/arch/sh/entry/syscalls/Kbuild      |   2 -
> > > > > > >  .../arch/sh/entry/syscalls/Makefile.syscalls  |   4 -
> > > > > > >  tools/perf/arch/sh/include/syscall_table.h    |   2 -
> > > > > > >  tools/perf/arch/sparc/entry/syscalls/Kbuild   |   3 -
> > > > > > >  .../sparc/entry/syscalls/Makefile.syscalls    |   5 -
> > > > > > >  tools/perf/arch/sparc/include/syscall_table.h |   8 -
> > > > > > >  tools/perf/arch/x86/entry/syscalls/Kbuild     |   3 -
> > > > > > >  .../arch/x86/entry/syscalls/Makefile.syscalls |   6 -
> > > > > > >  tools/perf/arch/x86/include/syscall_table.h   |   8 -
> > > > > > >  tools/perf/arch/xtensa/entry/syscalls/Kbuild  |   2 -
> > > > > > >  .../xtensa/entry/syscalls/Makefile.syscalls   |   4 -
> > > > > > >  .../perf/arch/xtensa/include/syscall_table.h  |   2 -
> > > > > > >  tools/perf/builtin-trace.c                    | 275 +++++++++++-------
> > > > > > >  tools/perf/scripts/Makefile.syscalls          |  61 ----
> > > > > > >  tools/perf/scripts/syscalltbl.sh              |  86 ------
> > > > > > >  tools/perf/trace/beauty/syscalltbl.sh         | 274 +++++++++++++++++
> > > > > > >  tools/perf/util/syscalltbl.c                  | 142 ++++-----
> > > > > > >  tools/perf/util/syscalltbl.h                  |  22 +-
> > > > > > >  tools/perf/util/thread.c                      |  50 ++++
> > > > > > >  tools/perf/util/thread.h                      |  14 +-
> > > > > > >  54 files changed, 598 insertions(+), 506 deletions(-)
> > > > > > >  delete mode 100644 tools/perf/arch/alpha/entry/syscalls/Kbuild
> > > > > > >  delete mode 100644 tools/perf/arch/alpha/entry/syscalls/Makefile.syscalls
> > > > > > >  delete mode 100644 tools/perf/arch/alpha/include/syscall_table.h
> > > > > > >  delete mode 100644 tools/perf/arch/arc/entry/syscalls/Kbuild
> > > > > > >  delete mode 100644 tools/perf/arch/arc/entry/syscalls/Makefile.syscalls
> > > > > > >  delete mode 100644 tools/perf/arch/arc/include/syscall_table.h
> > > > > > >  delete mode 100644 tools/perf/arch/arm/entry/syscalls/Kbuild
> > > > > > >  delete mode 100644 tools/perf/arch/arm/entry/syscalls/Makefile.syscalls
> > > > > > >  delete mode 100644 tools/perf/arch/arm/include/syscall_table.h
> > > > > > >  delete mode 100644 tools/perf/arch/arm64/entry/syscalls/Kbuild
> > > > > > >  delete mode 100644 tools/perf/arch/arm64/entry/syscalls/Makefile.syscalls
> > > > > > >  delete mode 100644 tools/perf/arch/arm64/include/syscall_table.h
> > > > > > >  delete mode 100644 tools/perf/arch/csky/entry/syscalls/Kbuild
> > > > > > >  delete mode 100644 tools/perf/arch/csky/entry/syscalls/Makefile.syscalls
> > > > > > >  delete mode 100644 tools/perf/arch/csky/include/syscall_table.h
> > > > > > >  delete mode 100644 tools/perf/arch/loongarch/entry/syscalls/Kbuild
> > > > > > >  delete mode 100644 tools/perf/arch/loongarch/entry/syscalls/Makefile.syscalls
> > > > > > >  delete mode 100644 tools/perf/arch/loongarch/include/syscall_table.h
> > > > > > >  delete mode 100644 tools/perf/arch/mips/entry/syscalls/Kbuild
> > > > > > >  delete mode 100644 tools/perf/arch/mips/entry/syscalls/Makefile.syscalls
> > > > > > >  delete mode 100644 tools/perf/arch/mips/include/syscall_table.h
> > > > > > >  delete mode 100644 tools/perf/arch/parisc/entry/syscalls/Kbuild
> > > > > > >  delete mode 100644 tools/perf/arch/parisc/entry/syscalls/Makefile.syscalls
> > > > > > >  delete mode 100644 tools/perf/arch/parisc/include/syscall_table.h
> > > > > > >  delete mode 100644 tools/perf/arch/powerpc/entry/syscalls/Kbuild
> > > > > > >  delete mode 100644 tools/perf/arch/powerpc/entry/syscalls/Makefile.syscalls
> > > > > > >  delete mode 100644 tools/perf/arch/powerpc/include/syscall_table.h
> > > > > > >  delete mode 100644 tools/perf/arch/riscv/entry/syscalls/Kbuild
> > > > > > >  delete mode 100644 tools/perf/arch/riscv/entry/syscalls/Makefile.syscalls
> > > > > > >  delete mode 100644 tools/perf/arch/riscv/include/syscall_table.h
> > > > > > >  delete mode 100644 tools/perf/arch/s390/entry/syscalls/Kbuild
> > > > > > >  delete mode 100644 tools/perf/arch/s390/entry/syscalls/Makefile.syscalls
> > > > > > >  delete mode 100644 tools/perf/arch/s390/include/syscall_table.h
> > > > > > >  delete mode 100644 tools/perf/arch/sh/entry/syscalls/Kbuild
> > > > > > >  delete mode 100644 tools/perf/arch/sh/entry/syscalls/Makefile.syscalls
> > > > > > >  delete mode 100644 tools/perf/arch/sh/include/syscall_table.h
> > > > > > >  delete mode 100644 tools/perf/arch/sparc/entry/syscalls/Kbuild
> > > > > > >  delete mode 100644 tools/perf/arch/sparc/entry/syscalls/Makefile.syscalls
> > > > > > >  delete mode 100644 tools/perf/arch/sparc/include/syscall_table.h
> > > > > > >  delete mode 100644 tools/perf/arch/x86/entry/syscalls/Kbuild
> > > > > > >  delete mode 100644 tools/perf/arch/x86/entry/syscalls/Makefile.syscalls
> > > > > > >  delete mode 100644 tools/perf/arch/x86/include/syscall_table.h
> > > > > > >  delete mode 100644 tools/perf/arch/xtensa/entry/syscalls/Kbuild
> > > > > > >  delete mode 100644 tools/perf/arch/xtensa/entry/syscalls/Makefile.syscalls
> > > > > > >  delete mode 100644 tools/perf/arch/xtensa/include/syscall_table.h
> > > > > > >  delete mode 100644 tools/perf/scripts/Makefile.syscalls
> > > > > > >  delete mode 100755 tools/perf/scripts/syscalltbl.sh
> > > > > > >  create mode 100755 tools/perf/trace/beauty/syscalltbl.sh
> > > > > > >
> > > > > > > --
> > > > > > > 2.48.1.362.g079036d154-goog
> > > > > > >
