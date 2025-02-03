Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500C720E70B
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Feb 2025 20:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738616114; cv=none; b=J3cc0AB7dhY7MrCiUOJsYqnofiMTVik+0HSqspZ+pgDECZzS8JaQgQlGC/VACYkM3nEYWVieMW1DQgougHFC2b/mj400ZgbjqXNKFit1GYthKeQ5TJL7rwCSGmuiMLoa6+ewRAPXLkjaekNAg31tko5nuMYidsGE7QQJn2GFT4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738616114; c=relaxed/simple;
	bh=bAcEThKuMc8PFLRFATLoMnWG6H5KtQP46+rWaTlFgsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kpjNHjQ9l5HtRkWu5fi6sMQg/Ws92dPfLnO/YMXVoei7lA7tccRzL4hAg6wNqC94AzkGCEm6hO9ItqukB2d5xr7rpE9yMlS36d2bkSMxOk9fFP83Y5XLEJagQ6Z1f9QJoes+tVzYLwhflLvEfssQHz6kVQqutHluqKkcFIbvy3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DTWYGr6X; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DTWYGr6X"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3ce82195aa0so35185ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Feb 2025 12:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738616111; x=1739220911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0CpkOvatLv4wKhG0xtf/lUUhTY7jRaSGKWWG+/sybmU=;
        b=DTWYGr6XmyBRmZ5Sy0wmChhbUiqxAcDHYvyvnUl0mwLeJXajF50NgJHdGlUb3021IL
         nkGW3gXihPIB7YreC2h1AOUkng//hUsMkgZPEJ8CjNJ7DPGRnYBdrTk8Fr/JxdxVWiwu
         eP0d4rD969rAUs7/kab12FZwz71r1Miw7+NkU7pqGuyfa7ch1p39HCBt2RTxnbjmIFC5
         KQXmCRELmzUX1uUHFwakSavFoILhD6zJh9/mN27JuKEumE38V5rAX6V8BxJCaUZEKpuL
         9av8gDmBNJq1mzIndM3+f6Z8KYYn0Y9Smw016Z4SnXVSfR+fypy7W0WS4yDBAVYy5cFs
         abFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738616111; x=1739220911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0CpkOvatLv4wKhG0xtf/lUUhTY7jRaSGKWWG+/sybmU=;
        b=D2aFATP1x/J4rXR3hT04xQLTWMqG3MxJsvDGleB0qNRozQReLQK8dJovVu7B+U6DbX
         rcIrcWldbLJymNAa8M+/zCxP+/AuVqhbqbPVMNIGiZZGcAi1SOCVNtbqGFigxdLcwTxq
         +HsqQK9cFkn+XSLvhagJwg5RhUDHhaQKcQHcGZfXiS6lYbQPdasYWKUcfI+/UmoWnqjv
         2z5B/ADcB5UYn1zxlARfLZlRrGijkwodoAB6t14ue9AowIAAqfxXAyX+tE7bodsxFBIL
         ZFpqwlbFt30S5sB3wHGD6hTMnrdu/wv/bs+ZPynM/UMfpi/14zUJ8RlshfLEicHfxsJ5
         RNzA==
X-Forwarded-Encrypted: i=1; AJvYcCX4qdbsaDr00Fc08XcsQcsDGOrsa5X3l/Gl05qNjn173Sgl41TUexU5IpdyDzpT67rilZBKBYxJa+4la8TtHqgm@vger.kernel.org
X-Gm-Message-State: AOJu0YzBnqsGEwwl5ph8QoPvSkrR+f9nnz9zWNRl9K5Oz0n6U1UuH/vQ
	K6tkNBRJtJBQPFYlmTHlrpT2Zdp+rk67zfAORG4UNXwsFBxqi6SBQSrUVlEWSqVby0b69mCJ7qp
	kX+9JtXwLAWzXJ2iS5/+XSiavawF5NjX8I2Lt
X-Gm-Gg: ASbGncsuwdhgVm2Cde4vIXhZX7nqNlpc4zHW92rYhfAsvq48SUlrtPoVjIGT0dbfkqX
	sS/wJnlTYK9A6b47LRcDQWqtzlR5fKnOaIJfTc4hjCwv7EO+6YoYqe8C1QUJtYARx9YeaAyxRLg
	g7My4RLaF3XuBx5xV3r32B4xk=
X-Google-Smtp-Source: AGHT+IFovB/1hVfLQEVpXp2hcX+JruDAGn+2X9tQzrpodvNkO71mW2lpNbYirYKNTnTRjw3Jno81IOERpP52GSqP9hw=
X-Received: by 2002:a05:6e02:1b03:b0:3d0:a9b:bf4b with SMTP id
 e9e14a558f8ab-3d03fbc124emr730575ab.12.1738616111091; Mon, 03 Feb 2025
 12:55:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250201071455.718247-1-irogers@google.com> <Z6EStkn-YZ8zaO7u@ghost>
 <CAP-5=fXRz_8CKNz4Fr-=0yhKbf_QE2ND+PPykSAO5p8wcUz7xA@mail.gmail.com>
 <Z6EVwaOVYaKtaK1j@ghost> <CAP-5=fX1hCNWWmGJPKYxj93S=zM1-eRucqzb4WW5fB_sZBCRLg@mail.gmail.com>
 <Z6Eh1QLuqTbUKLCc@ghost>
In-Reply-To: <Z6Eh1QLuqTbUKLCc@ghost>
From: Ian Rogers <irogers@google.com>
Date: Mon, 3 Feb 2025 12:54:59 -0800
X-Gm-Features: AWEUYZlmOKvF2fD96Nbnrom7gMtVtXNQBtvLmxWr7es0TmhML1shSJVYzZg-gUA
Message-ID: <CAP-5=fXZr8L4Z=Lb28QDZF8cbv2eJJEHSb0H9zcqSOB9cn5-9g@mail.gmail.com>
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

On Mon, Feb 3, 2025 at 12:06=E2=80=AFPM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> On Mon, Feb 03, 2025 at 11:39:01AM -0800, Ian Rogers wrote:
> > On Mon, Feb 3, 2025 at 11:15=E2=80=AFAM Charlie Jenkins <charlie@rivosi=
nc.com> wrote:
> > >
> > > On Mon, Feb 03, 2025 at 11:10:49AM -0800, Ian Rogers wrote:
> > > > On Mon, Feb 3, 2025 at 11:02=E2=80=AFAM Charlie Jenkins <charlie@ri=
vosinc.com> wrote:
> > > > >
> > > > > On Fri, Jan 31, 2025 at 11:14:48PM -0800, Ian Rogers wrote:
> > > > > > This work builds on the clean up of system call tables and remo=
val of
> > > > > > libaudit by Charlie Jenkins <charlie@rivosinc.com>.
> > > > > >
> > > > > > The system call table in perf trace is used to map system call =
numbers
> > > > > > to names and vice versa. Prior to these changes, a single table
> > > > > > matching the perf binary's build was present. The table would b=
e
> > > > > > incorrect if tracing say a 32-bit binary from a 64-bit version =
of
> > > > > > perf, the names and numbers wouldn't match.
> > > > > >
> > > > > > Change the build so that a single system call file is built and=
 the
> > > > > > potentially multiple tables are identifiable from the ELF machi=
ne type
> > > > > > of the process being examined. To determine the ELF machine typ=
e, the
> > > > > > executable's header is read from /proc/pid/exe with fallbacks t=
o using
> > > > > > the perf's binary type when unknown.
> > > > > >
> > > > > > Remove some runtime types used by the system call tables and ma=
ke
> > > > > > equivalents generated at build time.
> > > > >
> > > > > Our approaches are very different but I sent out a patch to do th=
is a
> > > > > couple of weeks ago [1].
> > > > >
> > > > > Did you look at that and decide you didn't like the approach?
> > > >
> > > > Missing link?
> > >
> > > Whoops here is the link:
> > >
> > > https://lore.kernel.org/all/20250114-perf_syscall_arch_runtime-v1-1-5=
b304e408e11@rivosinc.com/
> >
> > I agree it is similar and progress, I think I prefer my changes :-)
> >
> > Anything in the arch directories is only going to be built given a
> > Makefile SRCARCH:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/arch/Build?h=3Dperf-tools-next#n2
> > which means if we want the system call tables for say ARM on x86-64 we
> > need to reinvent the build - this isn't a problem today but perhaps
> > something to consider if we wanted a cross-architecture perf trace
> > record. I'd like to do away entirely with the arch directory for this
> > kind of reason. For example, if we run perf on a user space emulator
> > (say a testing set up) and it sees AMD data fabric PMUs, logic for
> > those PMUs currently lives in the arch directory for x86 and likely
> > wasn't even built into the perf tool. We should be able to identify
> > PMUs and act accordingly based on their names. In the case of the
> > overloaded "cpu" PMU we can identify it with the CPUID. The less code
> > in arch and the fewer architecture ifdefs, the better things should
> > work cross-architecture, in testing scenarios, etc. We also win by
> > getting code coverage without, for example, having to build and test
> > on csky or super H.
> >
> > Your changes are using the string for the architecture name. I think
> > that string is something we should get rid of:
> > https://lore.kernel.org/lkml/CAP-5=3DfX2BtFzhGLCSqO1QszqfX=3DHT8RrTdG_5=
Ttp5Gw4seSstA@mail.gmail.com/
> > but there's no reason we couldn't clean that up on top of your change.
>
> Yes that part is not ideal.
>
> >
> > The build with lots of separate Build/Makefiles is something of a pain
> > to port/maintain in a bazel version of the build I maintain at Google
> > (happy to open source if anyone cares). In these changes you just run
> > a big script and get a big header file out the end, which largely
> > matches the other perf trace beauty things we build.
>
> Fair enough! I wanted to mimic how the kernel was building the syscall
> tables as closely as possible, it's convenient to have cohesion.

I think it makes sense in the kernel, as the built binary doesn't have
cross-platform concerns. This is probably also the reason why the perf
tool has an arch directory. Let me know what you think is the right
direction for the perf tool syscall table code.

> What is the usecase for the bazel version?

I'm sure there's more info in:
https://bazel.build/
but the main thing is having hermetic and reproducible builds. The
main problem with open sourcing would be dealing with external
repositories, test set up, etc. Tbh, hermetic builds are a challenge
as things like lex and yacc will vary the C code they generate based
on the platform they run on. Bazel has plans to change the world so
maybe this could be more of a thing in the future.

Fwiw, I did push changes into the perf tree so that man page building
was reproducible:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/co=
mmit/tools/perf/Documentation?h=3Dperf-tools-next&id=3Dd586ac10ce56b2381b8e=
1d8ed74660c1b2b8ab0d
The man pages used to reflect the date/time they were built, but now
reflect the date the of the commit of the file being built:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/Documentation/Makefile?h=3Dperf-tools-next#n255

Thanks,
Ian

> - Charlie
>
> >
> > Thanks,
> > Ian
> >
> > > >
> > > > The patches generating a syscall(_32|_64)?.h landed. These changes
> > > > take your changes and make it so that we just run the script once
> > > > building a header file for all architectures. On x86 we then have t=
he
> > > > tables be guarded by ifdefs on i386 and x86-64. Then rather than th=
e
> > > > table just matching the host architecture the ELF machine is used f=
or
> > > > the executable running.
> > > >
> > > > Thanks,
> > > > Ian
> > > >
> > > > > - Charlie
> > > > >
> > > > > >
> > > > > > Ian Rogers (7):
> > > > > >   perf syscalltble: Remove syscall_table.h
> > > > > >   perf trace: Reorganize syscalls
> > > > > >   perf syscalltbl: Remove struct syscalltbl
> > > > > >   perf thread: Add support for reading the e_machine type for a=
 thread
> > > > > >   perf trace beauty: Add syscalltbl.sh generating all system ca=
ll tables
> > > > > >   perf syscalltbl: Use lookup table containing multiple archite=
ctures
> > > > > >   perf build: Remove Makefile.syscalls
> > > > > >
> > > > > >  tools/perf/Makefile.perf                      |  10 +-
> > > > > >  tools/perf/arch/alpha/entry/syscalls/Kbuild   |   2 -
> > > > > >  .../alpha/entry/syscalls/Makefile.syscalls    |   5 -
> > > > > >  tools/perf/arch/alpha/include/syscall_table.h |   2 -
> > > > > >  tools/perf/arch/arc/entry/syscalls/Kbuild     |   2 -
> > > > > >  .../arch/arc/entry/syscalls/Makefile.syscalls |   3 -
> > > > > >  tools/perf/arch/arc/include/syscall_table.h   |   2 -
> > > > > >  tools/perf/arch/arm/entry/syscalls/Kbuild     |   4 -
> > > > > >  .../arch/arm/entry/syscalls/Makefile.syscalls |   2 -
> > > > > >  tools/perf/arch/arm/include/syscall_table.h   |   2 -
> > > > > >  tools/perf/arch/arm64/entry/syscalls/Kbuild   |   3 -
> > > > > >  .../arm64/entry/syscalls/Makefile.syscalls    |   6 -
> > > > > >  tools/perf/arch/arm64/include/syscall_table.h |   8 -
> > > > > >  tools/perf/arch/csky/entry/syscalls/Kbuild    |   2 -
> > > > > >  .../csky/entry/syscalls/Makefile.syscalls     |   3 -
> > > > > >  tools/perf/arch/csky/include/syscall_table.h  |   2 -
> > > > > >  .../perf/arch/loongarch/entry/syscalls/Kbuild |   2 -
> > > > > >  .../entry/syscalls/Makefile.syscalls          |   3 -
> > > > > >  .../arch/loongarch/include/syscall_table.h    |   2 -
> > > > > >  tools/perf/arch/mips/entry/syscalls/Kbuild    |   2 -
> > > > > >  .../mips/entry/syscalls/Makefile.syscalls     |   5 -
> > > > > >  tools/perf/arch/mips/include/syscall_table.h  |   2 -
> > > > > >  tools/perf/arch/parisc/entry/syscalls/Kbuild  |   3 -
> > > > > >  .../parisc/entry/syscalls/Makefile.syscalls   |   6 -
> > > > > >  .../perf/arch/parisc/include/syscall_table.h  |   8 -
> > > > > >  tools/perf/arch/powerpc/entry/syscalls/Kbuild |   3 -
> > > > > >  .../powerpc/entry/syscalls/Makefile.syscalls  |   6 -
> > > > > >  .../perf/arch/powerpc/include/syscall_table.h |   8 -
> > > > > >  tools/perf/arch/riscv/entry/syscalls/Kbuild   |   2 -
> > > > > >  .../riscv/entry/syscalls/Makefile.syscalls    |   4 -
> > > > > >  tools/perf/arch/riscv/include/syscall_table.h |   8 -
> > > > > >  tools/perf/arch/s390/entry/syscalls/Kbuild    |   2 -
> > > > > >  .../s390/entry/syscalls/Makefile.syscalls     |   5 -
> > > > > >  tools/perf/arch/s390/include/syscall_table.h  |   2 -
> > > > > >  tools/perf/arch/sh/entry/syscalls/Kbuild      |   2 -
> > > > > >  .../arch/sh/entry/syscalls/Makefile.syscalls  |   4 -
> > > > > >  tools/perf/arch/sh/include/syscall_table.h    |   2 -
> > > > > >  tools/perf/arch/sparc/entry/syscalls/Kbuild   |   3 -
> > > > > >  .../sparc/entry/syscalls/Makefile.syscalls    |   5 -
> > > > > >  tools/perf/arch/sparc/include/syscall_table.h |   8 -
> > > > > >  tools/perf/arch/x86/entry/syscalls/Kbuild     |   3 -
> > > > > >  .../arch/x86/entry/syscalls/Makefile.syscalls |   6 -
> > > > > >  tools/perf/arch/x86/include/syscall_table.h   |   8 -
> > > > > >  tools/perf/arch/xtensa/entry/syscalls/Kbuild  |   2 -
> > > > > >  .../xtensa/entry/syscalls/Makefile.syscalls   |   4 -
> > > > > >  .../perf/arch/xtensa/include/syscall_table.h  |   2 -
> > > > > >  tools/perf/builtin-trace.c                    | 275 ++++++++++=
+-------
> > > > > >  tools/perf/scripts/Makefile.syscalls          |  61 ----
> > > > > >  tools/perf/scripts/syscalltbl.sh              |  86 ------
> > > > > >  tools/perf/trace/beauty/syscalltbl.sh         | 274 ++++++++++=
+++++++
> > > > > >  tools/perf/util/syscalltbl.c                  | 142 ++++-----
> > > > > >  tools/perf/util/syscalltbl.h                  |  22 +-
> > > > > >  tools/perf/util/thread.c                      |  50 ++++
> > > > > >  tools/perf/util/thread.h                      |  14 +-
> > > > > >  54 files changed, 598 insertions(+), 506 deletions(-)
> > > > > >  delete mode 100644 tools/perf/arch/alpha/entry/syscalls/Kbuild
> > > > > >  delete mode 100644 tools/perf/arch/alpha/entry/syscalls/Makefi=
le.syscalls
> > > > > >  delete mode 100644 tools/perf/arch/alpha/include/syscall_table=
.h
> > > > > >  delete mode 100644 tools/perf/arch/arc/entry/syscalls/Kbuild
> > > > > >  delete mode 100644 tools/perf/arch/arc/entry/syscalls/Makefile=
.syscalls
> > > > > >  delete mode 100644 tools/perf/arch/arc/include/syscall_table.h
> > > > > >  delete mode 100644 tools/perf/arch/arm/entry/syscalls/Kbuild
> > > > > >  delete mode 100644 tools/perf/arch/arm/entry/syscalls/Makefile=
.syscalls
> > > > > >  delete mode 100644 tools/perf/arch/arm/include/syscall_table.h
> > > > > >  delete mode 100644 tools/perf/arch/arm64/entry/syscalls/Kbuild
> > > > > >  delete mode 100644 tools/perf/arch/arm64/entry/syscalls/Makefi=
le.syscalls
> > > > > >  delete mode 100644 tools/perf/arch/arm64/include/syscall_table=
.h
> > > > > >  delete mode 100644 tools/perf/arch/csky/entry/syscalls/Kbuild
> > > > > >  delete mode 100644 tools/perf/arch/csky/entry/syscalls/Makefil=
e.syscalls
> > > > > >  delete mode 100644 tools/perf/arch/csky/include/syscall_table.=
h
> > > > > >  delete mode 100644 tools/perf/arch/loongarch/entry/syscalls/Kb=
uild
> > > > > >  delete mode 100644 tools/perf/arch/loongarch/entry/syscalls/Ma=
kefile.syscalls
> > > > > >  delete mode 100644 tools/perf/arch/loongarch/include/syscall_t=
able.h
> > > > > >  delete mode 100644 tools/perf/arch/mips/entry/syscalls/Kbuild
> > > > > >  delete mode 100644 tools/perf/arch/mips/entry/syscalls/Makefil=
e.syscalls
> > > > > >  delete mode 100644 tools/perf/arch/mips/include/syscall_table.=
h
> > > > > >  delete mode 100644 tools/perf/arch/parisc/entry/syscalls/Kbuil=
d
> > > > > >  delete mode 100644 tools/perf/arch/parisc/entry/syscalls/Makef=
ile.syscalls
> > > > > >  delete mode 100644 tools/perf/arch/parisc/include/syscall_tabl=
e.h
> > > > > >  delete mode 100644 tools/perf/arch/powerpc/entry/syscalls/Kbui=
ld
> > > > > >  delete mode 100644 tools/perf/arch/powerpc/entry/syscalls/Make=
file.syscalls
> > > > > >  delete mode 100644 tools/perf/arch/powerpc/include/syscall_tab=
le.h
> > > > > >  delete mode 100644 tools/perf/arch/riscv/entry/syscalls/Kbuild
> > > > > >  delete mode 100644 tools/perf/arch/riscv/entry/syscalls/Makefi=
le.syscalls
> > > > > >  delete mode 100644 tools/perf/arch/riscv/include/syscall_table=
.h
> > > > > >  delete mode 100644 tools/perf/arch/s390/entry/syscalls/Kbuild
> > > > > >  delete mode 100644 tools/perf/arch/s390/entry/syscalls/Makefil=
e.syscalls
> > > > > >  delete mode 100644 tools/perf/arch/s390/include/syscall_table.=
h
> > > > > >  delete mode 100644 tools/perf/arch/sh/entry/syscalls/Kbuild
> > > > > >  delete mode 100644 tools/perf/arch/sh/entry/syscalls/Makefile.=
syscalls
> > > > > >  delete mode 100644 tools/perf/arch/sh/include/syscall_table.h
> > > > > >  delete mode 100644 tools/perf/arch/sparc/entry/syscalls/Kbuild
> > > > > >  delete mode 100644 tools/perf/arch/sparc/entry/syscalls/Makefi=
le.syscalls
> > > > > >  delete mode 100644 tools/perf/arch/sparc/include/syscall_table=
.h
> > > > > >  delete mode 100644 tools/perf/arch/x86/entry/syscalls/Kbuild
> > > > > >  delete mode 100644 tools/perf/arch/x86/entry/syscalls/Makefile=
.syscalls
> > > > > >  delete mode 100644 tools/perf/arch/x86/include/syscall_table.h
> > > > > >  delete mode 100644 tools/perf/arch/xtensa/entry/syscalls/Kbuil=
d
> > > > > >  delete mode 100644 tools/perf/arch/xtensa/entry/syscalls/Makef=
ile.syscalls
> > > > > >  delete mode 100644 tools/perf/arch/xtensa/include/syscall_tabl=
e.h
> > > > > >  delete mode 100644 tools/perf/scripts/Makefile.syscalls
> > > > > >  delete mode 100755 tools/perf/scripts/syscalltbl.sh
> > > > > >  create mode 100755 tools/perf/trace/beauty/syscalltbl.sh
> > > > > >
> > > > > > --
> > > > > > 2.48.1.362.g079036d154-goog
> > > > > >
