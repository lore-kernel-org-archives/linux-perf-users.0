Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBF11E98EC
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Feb 2025 20:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738613213; cv=none; b=tSEmNMeJd7zLiVBu8knXd7cMxoHRkpw51zTOHXxOuJNBrZm8vLHaaJgeImCPxtjQKqAd9tgqP0c4RZ19LPLDSHqBgeEOJUsbQHCUwhN36d7I4w2aakaXtcrfD0PMJAEcS+uG/Mu7eonR8tJUfRdbsdXNCVY7R8SxQ9b+Mmf2DaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738613213; c=relaxed/simple;
	bh=1hwCPVXOXHWuWXPSZinoAZEAjLv4bL/Pmby+DMQyRvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3Kbh9cIMrGuMV38jTvQcjQPKID+aNASbOK4avPeR6zcu4mKTcZGYKV8WKvoALp0StQJ2P7I6o7GB6qN4p6qLl6pOpc9LEEmc9SS2ecuqfYCkODPJ4eb84Igpy67hw2gWgA0r6j9B9+K4AJSXKjBWwCOiMea3WZ9+ClBgu8aC70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=dp7TuAV2; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="dp7TuAV2"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2165cb60719so86863825ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Feb 2025 12:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738613209; x=1739218009; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zn842Fm2SvvoNPi7A8bTdA+SWs8V2Ex9Kn5BCkaIK+k=;
        b=dp7TuAV2KdHs9BYW9v6dTPTjcH/pS0p4kUcfSfbt6ZGWXil+tEwhIZTiaYSe6MOStc
         +n7naGiKdCsEUGbYHC9cyG+UjF+Uuw2KBs+yAbkeAPjBNc0NcIpP/3EwxiRdoXJNvWFb
         YNmIyfgaBOvAGpCDtaV9AN2DTvH6dwI502Qt7t1FIgDDK3au6MsU7Fp3gmQjShlXZ7qy
         A3nmu+jjSFDBCT7Sk3vaInjUum4NpmXhlYUQUih26I6Txq3JaNKZCM2TJMmONAblj/UI
         YKB9xusOvZ393/h+h4GP5OMY5+M5TnvDLAcyRpUAmHXFHsx/0Jw76+zg1SkKKd1l3g7o
         xJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738613209; x=1739218009;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zn842Fm2SvvoNPi7A8bTdA+SWs8V2Ex9Kn5BCkaIK+k=;
        b=ksOX2DTBlkAnSo0U8zijzmyz38vSBRBgJiW7cgsGQbkz3JiYceKKz4Bq1vdKEXPA3p
         JPEbDisXytrf1tU5q2R569TOqS/wK9ByMooh41LB7sBMAnzDpeQ3xcCf9gRD7sFyQMLM
         GgGGncaHJ4OrzYMrwqNgl8F9PopxbHhhXvikZNhpESFFt9N4ImjVoxvwbqaRfMtjcyHH
         irGmiHX+5InvnG3O1AjlueK+oZNKmcy6VD2YrBTfytDpXkzsx3SMNgkIeHlOM/CH3Ikt
         Y9jrhYQ1H+mweEw9IadDTrmCNKYHZAFPVn7Wa8qKnKlVDFbZt67ZaljkYgSBSELfRY0X
         PVYA==
X-Forwarded-Encrypted: i=1; AJvYcCXXOiDOa/HmCC4ncLl4H8uSfJJDc0Rt2TlWNp1+5qsIWJBvzQbyyM+xLfa9rA5vSMfKkUglQh//Dn4RhfmKDkyi@vger.kernel.org
X-Gm-Message-State: AOJu0YyzGkiP0g2gYHOnxu/6R65dHsmSatkxwl21d0R8BRV3BoZW8UW+
	0j9CZoYeA9dYn9oyR8eV3WSs7QNlo8P+bN0L9CMO3MQKYqabin9eeYWxyZdRNoQ=
X-Gm-Gg: ASbGncv90Tdu8soVD0XmvwezSFbM2gcppFh/InPYMmT2mBHwbPSwVKj1YXMaQSGFWyP
	OdEAOOjxDDdh5vs3D+vxjPFc+BnXou5h2ZAwv4JNXklMSri61hmDf1I8KbuNVwCEKnLODQ58TsD
	skM5qvwWn+LN10i98vw2OdAN+cTBqiK2ADZ7tt/C7TSh0yaxyStQu7r3q+ukHyArxmVY/7o1H8w
	nrfRkFBLIYntsWJUUgCcWx0rI46FPF5UxijfkjynIJeaC2++roRWEie3NrD42wph0+VZAXwVHZs
	wL3t+ZMd5Qw=
X-Google-Smtp-Source: AGHT+IGS8njPUir6FnFenAdtBINMEb+gIsqCrIFalq62SUNtJzt7ER4ln9yxJJRFPrJv3bhAJTVV+Q==
X-Received: by 2002:a17:90b:4b88:b0:2f4:9e8b:6aad with SMTP id 98e67ed59e1d1-2f83aa804cfmr41636277a91.0.1738613209064;
        Mon, 03 Feb 2025 12:06:49 -0800 (PST)
Received: from ghost ([2601:647:6700:64d0:4f63:f9d5:2cbd:2947])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f83bccc8bcsm11799434a91.13.2025.02.03.12.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 12:06:48 -0800 (PST)
Date: Mon, 3 Feb 2025 12:06:45 -0800
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
Message-ID: <Z6Eh1QLuqTbUKLCc@ghost>
References: <20250201071455.718247-1-irogers@google.com>
 <Z6EStkn-YZ8zaO7u@ghost>
 <CAP-5=fXRz_8CKNz4Fr-=0yhKbf_QE2ND+PPykSAO5p8wcUz7xA@mail.gmail.com>
 <Z6EVwaOVYaKtaK1j@ghost>
 <CAP-5=fX1hCNWWmGJPKYxj93S=zM1-eRucqzb4WW5fB_sZBCRLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fX1hCNWWmGJPKYxj93S=zM1-eRucqzb4WW5fB_sZBCRLg@mail.gmail.com>

On Mon, Feb 03, 2025 at 11:39:01AM -0800, Ian Rogers wrote:
> On Mon, Feb 3, 2025 at 11:15 AM Charlie Jenkins <charlie@rivosinc.com> wrote:
> >
> > On Mon, Feb 03, 2025 at 11:10:49AM -0800, Ian Rogers wrote:
> > > On Mon, Feb 3, 2025 at 11:02 AM Charlie Jenkins <charlie@rivosinc.com> wrote:
> > > >
> > > > On Fri, Jan 31, 2025 at 11:14:48PM -0800, Ian Rogers wrote:
> > > > > This work builds on the clean up of system call tables and removal of
> > > > > libaudit by Charlie Jenkins <charlie@rivosinc.com>.
> > > > >
> > > > > The system call table in perf trace is used to map system call numbers
> > > > > to names and vice versa. Prior to these changes, a single table
> > > > > matching the perf binary's build was present. The table would be
> > > > > incorrect if tracing say a 32-bit binary from a 64-bit version of
> > > > > perf, the names and numbers wouldn't match.
> > > > >
> > > > > Change the build so that a single system call file is built and the
> > > > > potentially multiple tables are identifiable from the ELF machine type
> > > > > of the process being examined. To determine the ELF machine type, the
> > > > > executable's header is read from /proc/pid/exe with fallbacks to using
> > > > > the perf's binary type when unknown.
> > > > >
> > > > > Remove some runtime types used by the system call tables and make
> > > > > equivalents generated at build time.
> > > >
> > > > Our approaches are very different but I sent out a patch to do this a
> > > > couple of weeks ago [1].
> > > >
> > > > Did you look at that and decide you didn't like the approach?
> > >
> > > Missing link?
> >
> > Whoops here is the link:
> >
> > https://lore.kernel.org/all/20250114-perf_syscall_arch_runtime-v1-1-5b304e408e11@rivosinc.com/
> 
> I agree it is similar and progress, I think I prefer my changes :-)
> 
> Anything in the arch directories is only going to be built given a
> Makefile SRCARCH:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/arch/Build?h=perf-tools-next#n2
> which means if we want the system call tables for say ARM on x86-64 we
> need to reinvent the build - this isn't a problem today but perhaps
> something to consider if we wanted a cross-architecture perf trace
> record. I'd like to do away entirely with the arch directory for this
> kind of reason. For example, if we run perf on a user space emulator
> (say a testing set up) and it sees AMD data fabric PMUs, logic for
> those PMUs currently lives in the arch directory for x86 and likely
> wasn't even built into the perf tool. We should be able to identify
> PMUs and act accordingly based on their names. In the case of the
> overloaded "cpu" PMU we can identify it with the CPUID. The less code
> in arch and the fewer architecture ifdefs, the better things should
> work cross-architecture, in testing scenarios, etc. We also win by
> getting code coverage without, for example, having to build and test
> on csky or super H.
> 
> Your changes are using the string for the architecture name. I think
> that string is something we should get rid of:
> https://lore.kernel.org/lkml/CAP-5=fX2BtFzhGLCSqO1QszqfX=HT8RrTdG_5Ttp5Gw4seSstA@mail.gmail.com/
> but there's no reason we couldn't clean that up on top of your change.

Yes that part is not ideal.

> 
> The build with lots of separate Build/Makefiles is something of a pain
> to port/maintain in a bazel version of the build I maintain at Google
> (happy to open source if anyone cares). In these changes you just run
> a big script and get a big header file out the end, which largely
> matches the other perf trace beauty things we build.

Fair enough! I wanted to mimic how the kernel was building the syscall
tables as closely as possible, it's convenient to have cohesion.

What is the usecase for the bazel version?

- Charlie

> 
> Thanks,
> Ian
> 
> > >
> > > The patches generating a syscall(_32|_64)?.h landed. These changes
> > > take your changes and make it so that we just run the script once
> > > building a header file for all architectures. On x86 we then have the
> > > tables be guarded by ifdefs on i386 and x86-64. Then rather than the
> > > table just matching the host architecture the ELF machine is used for
> > > the executable running.
> > >
> > > Thanks,
> > > Ian
> > >
> > > > - Charlie
> > > >
> > > > >
> > > > > Ian Rogers (7):
> > > > >   perf syscalltble: Remove syscall_table.h
> > > > >   perf trace: Reorganize syscalls
> > > > >   perf syscalltbl: Remove struct syscalltbl
> > > > >   perf thread: Add support for reading the e_machine type for a thread
> > > > >   perf trace beauty: Add syscalltbl.sh generating all system call tables
> > > > >   perf syscalltbl: Use lookup table containing multiple architectures
> > > > >   perf build: Remove Makefile.syscalls
> > > > >
> > > > >  tools/perf/Makefile.perf                      |  10 +-
> > > > >  tools/perf/arch/alpha/entry/syscalls/Kbuild   |   2 -
> > > > >  .../alpha/entry/syscalls/Makefile.syscalls    |   5 -
> > > > >  tools/perf/arch/alpha/include/syscall_table.h |   2 -
> > > > >  tools/perf/arch/arc/entry/syscalls/Kbuild     |   2 -
> > > > >  .../arch/arc/entry/syscalls/Makefile.syscalls |   3 -
> > > > >  tools/perf/arch/arc/include/syscall_table.h   |   2 -
> > > > >  tools/perf/arch/arm/entry/syscalls/Kbuild     |   4 -
> > > > >  .../arch/arm/entry/syscalls/Makefile.syscalls |   2 -
> > > > >  tools/perf/arch/arm/include/syscall_table.h   |   2 -
> > > > >  tools/perf/arch/arm64/entry/syscalls/Kbuild   |   3 -
> > > > >  .../arm64/entry/syscalls/Makefile.syscalls    |   6 -
> > > > >  tools/perf/arch/arm64/include/syscall_table.h |   8 -
> > > > >  tools/perf/arch/csky/entry/syscalls/Kbuild    |   2 -
> > > > >  .../csky/entry/syscalls/Makefile.syscalls     |   3 -
> > > > >  tools/perf/arch/csky/include/syscall_table.h  |   2 -
> > > > >  .../perf/arch/loongarch/entry/syscalls/Kbuild |   2 -
> > > > >  .../entry/syscalls/Makefile.syscalls          |   3 -
> > > > >  .../arch/loongarch/include/syscall_table.h    |   2 -
> > > > >  tools/perf/arch/mips/entry/syscalls/Kbuild    |   2 -
> > > > >  .../mips/entry/syscalls/Makefile.syscalls     |   5 -
> > > > >  tools/perf/arch/mips/include/syscall_table.h  |   2 -
> > > > >  tools/perf/arch/parisc/entry/syscalls/Kbuild  |   3 -
> > > > >  .../parisc/entry/syscalls/Makefile.syscalls   |   6 -
> > > > >  .../perf/arch/parisc/include/syscall_table.h  |   8 -
> > > > >  tools/perf/arch/powerpc/entry/syscalls/Kbuild |   3 -
> > > > >  .../powerpc/entry/syscalls/Makefile.syscalls  |   6 -
> > > > >  .../perf/arch/powerpc/include/syscall_table.h |   8 -
> > > > >  tools/perf/arch/riscv/entry/syscalls/Kbuild   |   2 -
> > > > >  .../riscv/entry/syscalls/Makefile.syscalls    |   4 -
> > > > >  tools/perf/arch/riscv/include/syscall_table.h |   8 -
> > > > >  tools/perf/arch/s390/entry/syscalls/Kbuild    |   2 -
> > > > >  .../s390/entry/syscalls/Makefile.syscalls     |   5 -
> > > > >  tools/perf/arch/s390/include/syscall_table.h  |   2 -
> > > > >  tools/perf/arch/sh/entry/syscalls/Kbuild      |   2 -
> > > > >  .../arch/sh/entry/syscalls/Makefile.syscalls  |   4 -
> > > > >  tools/perf/arch/sh/include/syscall_table.h    |   2 -
> > > > >  tools/perf/arch/sparc/entry/syscalls/Kbuild   |   3 -
> > > > >  .../sparc/entry/syscalls/Makefile.syscalls    |   5 -
> > > > >  tools/perf/arch/sparc/include/syscall_table.h |   8 -
> > > > >  tools/perf/arch/x86/entry/syscalls/Kbuild     |   3 -
> > > > >  .../arch/x86/entry/syscalls/Makefile.syscalls |   6 -
> > > > >  tools/perf/arch/x86/include/syscall_table.h   |   8 -
> > > > >  tools/perf/arch/xtensa/entry/syscalls/Kbuild  |   2 -
> > > > >  .../xtensa/entry/syscalls/Makefile.syscalls   |   4 -
> > > > >  .../perf/arch/xtensa/include/syscall_table.h  |   2 -
> > > > >  tools/perf/builtin-trace.c                    | 275 +++++++++++-------
> > > > >  tools/perf/scripts/Makefile.syscalls          |  61 ----
> > > > >  tools/perf/scripts/syscalltbl.sh              |  86 ------
> > > > >  tools/perf/trace/beauty/syscalltbl.sh         | 274 +++++++++++++++++
> > > > >  tools/perf/util/syscalltbl.c                  | 142 ++++-----
> > > > >  tools/perf/util/syscalltbl.h                  |  22 +-
> > > > >  tools/perf/util/thread.c                      |  50 ++++
> > > > >  tools/perf/util/thread.h                      |  14 +-
> > > > >  54 files changed, 598 insertions(+), 506 deletions(-)
> > > > >  delete mode 100644 tools/perf/arch/alpha/entry/syscalls/Kbuild
> > > > >  delete mode 100644 tools/perf/arch/alpha/entry/syscalls/Makefile.syscalls
> > > > >  delete mode 100644 tools/perf/arch/alpha/include/syscall_table.h
> > > > >  delete mode 100644 tools/perf/arch/arc/entry/syscalls/Kbuild
> > > > >  delete mode 100644 tools/perf/arch/arc/entry/syscalls/Makefile.syscalls
> > > > >  delete mode 100644 tools/perf/arch/arc/include/syscall_table.h
> > > > >  delete mode 100644 tools/perf/arch/arm/entry/syscalls/Kbuild
> > > > >  delete mode 100644 tools/perf/arch/arm/entry/syscalls/Makefile.syscalls
> > > > >  delete mode 100644 tools/perf/arch/arm/include/syscall_table.h
> > > > >  delete mode 100644 tools/perf/arch/arm64/entry/syscalls/Kbuild
> > > > >  delete mode 100644 tools/perf/arch/arm64/entry/syscalls/Makefile.syscalls
> > > > >  delete mode 100644 tools/perf/arch/arm64/include/syscall_table.h
> > > > >  delete mode 100644 tools/perf/arch/csky/entry/syscalls/Kbuild
> > > > >  delete mode 100644 tools/perf/arch/csky/entry/syscalls/Makefile.syscalls
> > > > >  delete mode 100644 tools/perf/arch/csky/include/syscall_table.h
> > > > >  delete mode 100644 tools/perf/arch/loongarch/entry/syscalls/Kbuild
> > > > >  delete mode 100644 tools/perf/arch/loongarch/entry/syscalls/Makefile.syscalls
> > > > >  delete mode 100644 tools/perf/arch/loongarch/include/syscall_table.h
> > > > >  delete mode 100644 tools/perf/arch/mips/entry/syscalls/Kbuild
> > > > >  delete mode 100644 tools/perf/arch/mips/entry/syscalls/Makefile.syscalls
> > > > >  delete mode 100644 tools/perf/arch/mips/include/syscall_table.h
> > > > >  delete mode 100644 tools/perf/arch/parisc/entry/syscalls/Kbuild
> > > > >  delete mode 100644 tools/perf/arch/parisc/entry/syscalls/Makefile.syscalls
> > > > >  delete mode 100644 tools/perf/arch/parisc/include/syscall_table.h
> > > > >  delete mode 100644 tools/perf/arch/powerpc/entry/syscalls/Kbuild
> > > > >  delete mode 100644 tools/perf/arch/powerpc/entry/syscalls/Makefile.syscalls
> > > > >  delete mode 100644 tools/perf/arch/powerpc/include/syscall_table.h
> > > > >  delete mode 100644 tools/perf/arch/riscv/entry/syscalls/Kbuild
> > > > >  delete mode 100644 tools/perf/arch/riscv/entry/syscalls/Makefile.syscalls
> > > > >  delete mode 100644 tools/perf/arch/riscv/include/syscall_table.h
> > > > >  delete mode 100644 tools/perf/arch/s390/entry/syscalls/Kbuild
> > > > >  delete mode 100644 tools/perf/arch/s390/entry/syscalls/Makefile.syscalls
> > > > >  delete mode 100644 tools/perf/arch/s390/include/syscall_table.h
> > > > >  delete mode 100644 tools/perf/arch/sh/entry/syscalls/Kbuild
> > > > >  delete mode 100644 tools/perf/arch/sh/entry/syscalls/Makefile.syscalls
> > > > >  delete mode 100644 tools/perf/arch/sh/include/syscall_table.h
> > > > >  delete mode 100644 tools/perf/arch/sparc/entry/syscalls/Kbuild
> > > > >  delete mode 100644 tools/perf/arch/sparc/entry/syscalls/Makefile.syscalls
> > > > >  delete mode 100644 tools/perf/arch/sparc/include/syscall_table.h
> > > > >  delete mode 100644 tools/perf/arch/x86/entry/syscalls/Kbuild
> > > > >  delete mode 100644 tools/perf/arch/x86/entry/syscalls/Makefile.syscalls
> > > > >  delete mode 100644 tools/perf/arch/x86/include/syscall_table.h
> > > > >  delete mode 100644 tools/perf/arch/xtensa/entry/syscalls/Kbuild
> > > > >  delete mode 100644 tools/perf/arch/xtensa/entry/syscalls/Makefile.syscalls
> > > > >  delete mode 100644 tools/perf/arch/xtensa/include/syscall_table.h
> > > > >  delete mode 100644 tools/perf/scripts/Makefile.syscalls
> > > > >  delete mode 100755 tools/perf/scripts/syscalltbl.sh
> > > > >  create mode 100755 tools/perf/trace/beauty/syscalltbl.sh
> > > > >
> > > > > --
> > > > > 2.48.1.362.g079036d154-goog
> > > > >
