Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2E925A656
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Feb 2025 19:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738611555; cv=none; b=upSKWJQEWScElqSOU7OaZoA6y9evJz1KlnGYAMfHRtxpFb3njWcvjJUTALgLCCUn62QMfVMAtFMv+dRkxg+yUT5IUhXMYB4Hgu/IJbV6rH5ujw7ixaJ2AxOMaZG6plpJs1MquzL5zbZhDF4u20BeabDUmQg8rh6pC6b3K+adGTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738611555; c=relaxed/simple;
	bh=RNYv5mL1keS9XkpE/N7AOK0bZkS8xIFIEUOnZNiysXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qkLlsryIPOLEb0xgO6zDc+M01KXmTkyBNy/mGpGLZrqRVfZjr3c4aV+/IaWbo3uoIXH+OKvxiGsdrb3hiwdENZfT8RfGD8rgbzqC+x0HymXm6Gu2YP9eJ4O5l/6Xd7A3lxxlGiGPxVytabC7+vf2hNQGaipQZ+2u1cMYkYCW500=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AICr0ad/; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AICr0ad/"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3ce82195aa0so23015ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Feb 2025 11:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738611552; x=1739216352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHHZnqU6DYFLZ8okqBKWpa9FEMJx8sgQSEViBE31WZs=;
        b=AICr0ad/LzKeJ4g7x9tg3WiJUp94QwTmIJ7nLDDhiUr4R7Tiii/0jnkIGNSC2EEKr9
         deAPB1pnDHG9lqkT9Stk6PZJJfzEbtmG8P6lQ8LAQRp19HAzqyMt5tzg8yR+f6+9LZyz
         IMVt8zPdTHGR7K7HifVWOo7BPdS7KCIVPXaUWRIZ85olSaPjoXlBWLk4QVPWpyb2sj+u
         NGN2och5VG/CCx4NVwW7KE638AHLhR8zVmLHXEuYkfGIkejbi/9R995DAG4tBPsOuLPq
         pSFo+/8uZ7MxAwguCcHV064pMsLVE8g9rir3IXg9d25GggBvm6/rJ7vo41RRMBrC3oYT
         gzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738611552; x=1739216352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SHHZnqU6DYFLZ8okqBKWpa9FEMJx8sgQSEViBE31WZs=;
        b=bGyWbaHg2ASiGDCyf87fPcWohGkdHqwz7sEg2APGwW6T8oqu6cVdFuigjmUg3alfhi
         gz9PO9E/NcQjiFWLRWaXFTB0LZvxwBbr4EbjWPKSdnjn82YEvpsgwlLaPnvw4rVVxJs8
         wjwIiDIighpiSIHjz23n4DDuJ4+EWY+GiBINbGG5C7NGpMq/Kv9qXwSGgE7KqHoqB/MF
         7NhBgQclIywNicKHntBy+9MkQRPNQvrO44LYutepn+XtDO+1rVc2sifybzJSelhnwf3j
         Av8vLfQiPFqcgYmpnS+JapsW3nYAsz4BwEe6jBx2uQAub4b80i0yhFaI3m8EGVPrlqmj
         Upqw==
X-Forwarded-Encrypted: i=1; AJvYcCUX53goGekX11AWm+4dBRAcvI3qt0/N93P2yGml7dOJXQjauI1VLR+SGGw4QafH0mCsbmZA1Pjax2oAuFFyWArv@vger.kernel.org
X-Gm-Message-State: AOJu0YxM6jYxjXY4n65ztGTc8LTWTGjwnL/grINooqN4WMzsKWUXHiqs
	xIfQ3YE0256wqkr0kN+yi+SWZPKkZE/SDifEwOElYJ2a5KilcWOaeH24QuJb+QNNbaKOa7BH5MR
	0+BBM0NCVHnfeytoAnMF6XpwE7iRY8GKXvRGh
X-Gm-Gg: ASbGnctRcItJV21O7gMfGylJC8B8CV241leF96Z7fO7U5150hlZf30i4JvCNqwaCfBs
	Pz26rvBLguQRrTyZL3gIa5IpXJcbpjhdX3SHfh0qRnxiWZvrCiUkt3L58Zaa6D6ngx7h8mDZ/Lb
	IM9JhTLZC1HQM/yqUq2AnnCrk=
X-Google-Smtp-Source: AGHT+IHdY4s9Hp5Vc4l+FLstuexCcykhpRM8v2E7YaaWlmaZjPVvyG0raU2U/YG4zCFqF4xylbaK4WNzHAHM0z275/A=
X-Received: by 2002:a05:6e02:1aa7:b0:3ce:7852:1e9 with SMTP id
 e9e14a558f8ab-3d03fd784eemr245345ab.17.1738611552232; Mon, 03 Feb 2025
 11:39:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250201071455.718247-1-irogers@google.com> <Z6EStkn-YZ8zaO7u@ghost>
 <CAP-5=fXRz_8CKNz4Fr-=0yhKbf_QE2ND+PPykSAO5p8wcUz7xA@mail.gmail.com> <Z6EVwaOVYaKtaK1j@ghost>
In-Reply-To: <Z6EVwaOVYaKtaK1j@ghost>
From: Ian Rogers <irogers@google.com>
Date: Mon, 3 Feb 2025 11:39:01 -0800
X-Gm-Features: AWEUYZmZ9wDy6ohVvcewzzZYhBhzXyoFnlL0nFE9AqdajOcbRo2H1pqd5ez3kHM
Message-ID: <CAP-5=fX1hCNWWmGJPKYxj93S=zM1-eRucqzb4WW5fB_sZBCRLg@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] perf: Support multiple system call tables in the build
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Bibo Mao <maobibo@loongson.cn>, 
	Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Jiri Slaby <jirislaby@kernel.org>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 11:15=E2=80=AFAM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> On Mon, Feb 03, 2025 at 11:10:49AM -0800, Ian Rogers wrote:
> > On Mon, Feb 3, 2025 at 11:02=E2=80=AFAM Charlie Jenkins <charlie@rivosi=
nc.com> wrote:
> > >
> > > On Fri, Jan 31, 2025 at 11:14:48PM -0800, Ian Rogers wrote:
> > > > This work builds on the clean up of system call tables and removal =
of
> > > > libaudit by Charlie Jenkins <charlie@rivosinc.com>.
> > > >
> > > > The system call table in perf trace is used to map system call numb=
ers
> > > > to names and vice versa. Prior to these changes, a single table
> > > > matching the perf binary's build was present. The table would be
> > > > incorrect if tracing say a 32-bit binary from a 64-bit version of
> > > > perf, the names and numbers wouldn't match.
> > > >
> > > > Change the build so that a single system call file is built and the
> > > > potentially multiple tables are identifiable from the ELF machine t=
ype
> > > > of the process being examined. To determine the ELF machine type, t=
he
> > > > executable's header is read from /proc/pid/exe with fallbacks to us=
ing
> > > > the perf's binary type when unknown.
> > > >
> > > > Remove some runtime types used by the system call tables and make
> > > > equivalents generated at build time.
> > >
> > > Our approaches are very different but I sent out a patch to do this a
> > > couple of weeks ago [1].
> > >
> > > Did you look at that and decide you didn't like the approach?
> >
> > Missing link?
>
> Whoops here is the link:
>
> https://lore.kernel.org/all/20250114-perf_syscall_arch_runtime-v1-1-5b304=
e408e11@rivosinc.com/

I agree it is similar and progress, I think I prefer my changes :-)

Anything in the arch directories is only going to be built given a
Makefile SRCARCH:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/arch/Build?h=3Dperf-tools-next#n2
which means if we want the system call tables for say ARM on x86-64 we
need to reinvent the build - this isn't a problem today but perhaps
something to consider if we wanted a cross-architecture perf trace
record. I'd like to do away entirely with the arch directory for this
kind of reason. For example, if we run perf on a user space emulator
(say a testing set up) and it sees AMD data fabric PMUs, logic for
those PMUs currently lives in the arch directory for x86 and likely
wasn't even built into the perf tool. We should be able to identify
PMUs and act accordingly based on their names. In the case of the
overloaded "cpu" PMU we can identify it with the CPUID. The less code
in arch and the fewer architecture ifdefs, the better things should
work cross-architecture, in testing scenarios, etc. We also win by
getting code coverage without, for example, having to build and test
on csky or super H.

Your changes are using the string for the architecture name. I think
that string is something we should get rid of:
https://lore.kernel.org/lkml/CAP-5=3DfX2BtFzhGLCSqO1QszqfX=3DHT8RrTdG_5Ttp5=
Gw4seSstA@mail.gmail.com/
but there's no reason we couldn't clean that up on top of your change.

The build with lots of separate Build/Makefiles is something of a pain
to port/maintain in a bazel version of the build I maintain at Google
(happy to open source if anyone cares). In these changes you just run
a big script and get a big header file out the end, which largely
matches the other perf trace beauty things we build.

Thanks,
Ian

> >
> > The patches generating a syscall(_32|_64)?.h landed. These changes
> > take your changes and make it so that we just run the script once
> > building a header file for all architectures. On x86 we then have the
> > tables be guarded by ifdefs on i386 and x86-64. Then rather than the
> > table just matching the host architecture the ELF machine is used for
> > the executable running.
> >
> > Thanks,
> > Ian
> >
> > > - Charlie
> > >
> > > >
> > > > Ian Rogers (7):
> > > >   perf syscalltble: Remove syscall_table.h
> > > >   perf trace: Reorganize syscalls
> > > >   perf syscalltbl: Remove struct syscalltbl
> > > >   perf thread: Add support for reading the e_machine type for a thr=
ead
> > > >   perf trace beauty: Add syscalltbl.sh generating all system call t=
ables
> > > >   perf syscalltbl: Use lookup table containing multiple architectur=
es
> > > >   perf build: Remove Makefile.syscalls
> > > >
> > > >  tools/perf/Makefile.perf                      |  10 +-
> > > >  tools/perf/arch/alpha/entry/syscalls/Kbuild   |   2 -
> > > >  .../alpha/entry/syscalls/Makefile.syscalls    |   5 -
> > > >  tools/perf/arch/alpha/include/syscall_table.h |   2 -
> > > >  tools/perf/arch/arc/entry/syscalls/Kbuild     |   2 -
> > > >  .../arch/arc/entry/syscalls/Makefile.syscalls |   3 -
> > > >  tools/perf/arch/arc/include/syscall_table.h   |   2 -
> > > >  tools/perf/arch/arm/entry/syscalls/Kbuild     |   4 -
> > > >  .../arch/arm/entry/syscalls/Makefile.syscalls |   2 -
> > > >  tools/perf/arch/arm/include/syscall_table.h   |   2 -
> > > >  tools/perf/arch/arm64/entry/syscalls/Kbuild   |   3 -
> > > >  .../arm64/entry/syscalls/Makefile.syscalls    |   6 -
> > > >  tools/perf/arch/arm64/include/syscall_table.h |   8 -
> > > >  tools/perf/arch/csky/entry/syscalls/Kbuild    |   2 -
> > > >  .../csky/entry/syscalls/Makefile.syscalls     |   3 -
> > > >  tools/perf/arch/csky/include/syscall_table.h  |   2 -
> > > >  .../perf/arch/loongarch/entry/syscalls/Kbuild |   2 -
> > > >  .../entry/syscalls/Makefile.syscalls          |   3 -
> > > >  .../arch/loongarch/include/syscall_table.h    |   2 -
> > > >  tools/perf/arch/mips/entry/syscalls/Kbuild    |   2 -
> > > >  .../mips/entry/syscalls/Makefile.syscalls     |   5 -
> > > >  tools/perf/arch/mips/include/syscall_table.h  |   2 -
> > > >  tools/perf/arch/parisc/entry/syscalls/Kbuild  |   3 -
> > > >  .../parisc/entry/syscalls/Makefile.syscalls   |   6 -
> > > >  .../perf/arch/parisc/include/syscall_table.h  |   8 -
> > > >  tools/perf/arch/powerpc/entry/syscalls/Kbuild |   3 -
> > > >  .../powerpc/entry/syscalls/Makefile.syscalls  |   6 -
> > > >  .../perf/arch/powerpc/include/syscall_table.h |   8 -
> > > >  tools/perf/arch/riscv/entry/syscalls/Kbuild   |   2 -
> > > >  .../riscv/entry/syscalls/Makefile.syscalls    |   4 -
> > > >  tools/perf/arch/riscv/include/syscall_table.h |   8 -
> > > >  tools/perf/arch/s390/entry/syscalls/Kbuild    |   2 -
> > > >  .../s390/entry/syscalls/Makefile.syscalls     |   5 -
> > > >  tools/perf/arch/s390/include/syscall_table.h  |   2 -
> > > >  tools/perf/arch/sh/entry/syscalls/Kbuild      |   2 -
> > > >  .../arch/sh/entry/syscalls/Makefile.syscalls  |   4 -
> > > >  tools/perf/arch/sh/include/syscall_table.h    |   2 -
> > > >  tools/perf/arch/sparc/entry/syscalls/Kbuild   |   3 -
> > > >  .../sparc/entry/syscalls/Makefile.syscalls    |   5 -
> > > >  tools/perf/arch/sparc/include/syscall_table.h |   8 -
> > > >  tools/perf/arch/x86/entry/syscalls/Kbuild     |   3 -
> > > >  .../arch/x86/entry/syscalls/Makefile.syscalls |   6 -
> > > >  tools/perf/arch/x86/include/syscall_table.h   |   8 -
> > > >  tools/perf/arch/xtensa/entry/syscalls/Kbuild  |   2 -
> > > >  .../xtensa/entry/syscalls/Makefile.syscalls   |   4 -
> > > >  .../perf/arch/xtensa/include/syscall_table.h  |   2 -
> > > >  tools/perf/builtin-trace.c                    | 275 +++++++++++---=
----
> > > >  tools/perf/scripts/Makefile.syscalls          |  61 ----
> > > >  tools/perf/scripts/syscalltbl.sh              |  86 ------
> > > >  tools/perf/trace/beauty/syscalltbl.sh         | 274 ++++++++++++++=
+++
> > > >  tools/perf/util/syscalltbl.c                  | 142 ++++-----
> > > >  tools/perf/util/syscalltbl.h                  |  22 +-
> > > >  tools/perf/util/thread.c                      |  50 ++++
> > > >  tools/perf/util/thread.h                      |  14 +-
> > > >  54 files changed, 598 insertions(+), 506 deletions(-)
> > > >  delete mode 100644 tools/perf/arch/alpha/entry/syscalls/Kbuild
> > > >  delete mode 100644 tools/perf/arch/alpha/entry/syscalls/Makefile.s=
yscalls
> > > >  delete mode 100644 tools/perf/arch/alpha/include/syscall_table.h
> > > >  delete mode 100644 tools/perf/arch/arc/entry/syscalls/Kbuild
> > > >  delete mode 100644 tools/perf/arch/arc/entry/syscalls/Makefile.sys=
calls
> > > >  delete mode 100644 tools/perf/arch/arc/include/syscall_table.h
> > > >  delete mode 100644 tools/perf/arch/arm/entry/syscalls/Kbuild
> > > >  delete mode 100644 tools/perf/arch/arm/entry/syscalls/Makefile.sys=
calls
> > > >  delete mode 100644 tools/perf/arch/arm/include/syscall_table.h
> > > >  delete mode 100644 tools/perf/arch/arm64/entry/syscalls/Kbuild
> > > >  delete mode 100644 tools/perf/arch/arm64/entry/syscalls/Makefile.s=
yscalls
> > > >  delete mode 100644 tools/perf/arch/arm64/include/syscall_table.h
> > > >  delete mode 100644 tools/perf/arch/csky/entry/syscalls/Kbuild
> > > >  delete mode 100644 tools/perf/arch/csky/entry/syscalls/Makefile.sy=
scalls
> > > >  delete mode 100644 tools/perf/arch/csky/include/syscall_table.h
> > > >  delete mode 100644 tools/perf/arch/loongarch/entry/syscalls/Kbuild
> > > >  delete mode 100644 tools/perf/arch/loongarch/entry/syscalls/Makefi=
le.syscalls
> > > >  delete mode 100644 tools/perf/arch/loongarch/include/syscall_table=
.h
> > > >  delete mode 100644 tools/perf/arch/mips/entry/syscalls/Kbuild
> > > >  delete mode 100644 tools/perf/arch/mips/entry/syscalls/Makefile.sy=
scalls
> > > >  delete mode 100644 tools/perf/arch/mips/include/syscall_table.h
> > > >  delete mode 100644 tools/perf/arch/parisc/entry/syscalls/Kbuild
> > > >  delete mode 100644 tools/perf/arch/parisc/entry/syscalls/Makefile.=
syscalls
> > > >  delete mode 100644 tools/perf/arch/parisc/include/syscall_table.h
> > > >  delete mode 100644 tools/perf/arch/powerpc/entry/syscalls/Kbuild
> > > >  delete mode 100644 tools/perf/arch/powerpc/entry/syscalls/Makefile=
.syscalls
> > > >  delete mode 100644 tools/perf/arch/powerpc/include/syscall_table.h
> > > >  delete mode 100644 tools/perf/arch/riscv/entry/syscalls/Kbuild
> > > >  delete mode 100644 tools/perf/arch/riscv/entry/syscalls/Makefile.s=
yscalls
> > > >  delete mode 100644 tools/perf/arch/riscv/include/syscall_table.h
> > > >  delete mode 100644 tools/perf/arch/s390/entry/syscalls/Kbuild
> > > >  delete mode 100644 tools/perf/arch/s390/entry/syscalls/Makefile.sy=
scalls
> > > >  delete mode 100644 tools/perf/arch/s390/include/syscall_table.h
> > > >  delete mode 100644 tools/perf/arch/sh/entry/syscalls/Kbuild
> > > >  delete mode 100644 tools/perf/arch/sh/entry/syscalls/Makefile.sysc=
alls
> > > >  delete mode 100644 tools/perf/arch/sh/include/syscall_table.h
> > > >  delete mode 100644 tools/perf/arch/sparc/entry/syscalls/Kbuild
> > > >  delete mode 100644 tools/perf/arch/sparc/entry/syscalls/Makefile.s=
yscalls
> > > >  delete mode 100644 tools/perf/arch/sparc/include/syscall_table.h
> > > >  delete mode 100644 tools/perf/arch/x86/entry/syscalls/Kbuild
> > > >  delete mode 100644 tools/perf/arch/x86/entry/syscalls/Makefile.sys=
calls
> > > >  delete mode 100644 tools/perf/arch/x86/include/syscall_table.h
> > > >  delete mode 100644 tools/perf/arch/xtensa/entry/syscalls/Kbuild
> > > >  delete mode 100644 tools/perf/arch/xtensa/entry/syscalls/Makefile.=
syscalls
> > > >  delete mode 100644 tools/perf/arch/xtensa/include/syscall_table.h
> > > >  delete mode 100644 tools/perf/scripts/Makefile.syscalls
> > > >  delete mode 100755 tools/perf/scripts/syscalltbl.sh
> > > >  create mode 100755 tools/perf/trace/beauty/syscalltbl.sh
> > > >
> > > > --
> > > > 2.48.1.362.g079036d154-goog
> > > >
