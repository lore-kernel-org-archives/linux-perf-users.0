Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E025B1EEA51
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Mar 2025 05:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741064661; cv=none; b=MuhoyBvEbSB1rjBjzphhvqrCw9ri7tul8kh0QZGYxsmP5TEf5249gAhN3Z8aDpJSJmgIL1M5KlMIMKSMrQeYSAR0DHOhxM5V1LMQURt4N4HcJc/xLt93DOH7XeVJOPpfJ1ljGRKk3uGM99JqRc1ylQFsT3FM8dNlmxSzdDl+Mso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741064661; c=relaxed/simple;
	bh=ql4UbiOnchdvTrSIrE+1RwI3JfN5mDYFtI/8NHqqwK0=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=dVslTG0Rrt+97Oj5Jk2dzmURvpG1S169JuBtPO3P5B6olgRqbT0d7Rv51BdQd00922CMd+7ZNS2I3aC/2gSZoYKGUnluz9v5oE5ZeW0e64SFfF2XVluBKRpBLmR/uWIiwVX7G6Z8FLNYh0JWxGvos2xDrhEU2mV/6YpaqkaMAw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FaaVJen0; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FaaVJen0"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6f68264a641so61039887b3.2
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Mar 2025 21:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741064659; x=1741669459; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6AVUQwBdF+LRNxSdmVWndTSxYXj6ILT2w+aCMp60CmU=;
        b=FaaVJen0QIHWIIS89nEthNrcmI/K4dLQxFKQ+brNr0PtC1qFEyPx1psWOEoBAJKuOx
         9RjxU913AhbXHR6065O+FPTexhBwoG3sGlVhUMxEQYXEIyExGs6pfMipMlVD2K3UIj/P
         +pCYITFX3dzg0wbTC8BHgQp/YFXX5gTokuU75jImQY7Mh9foT761DLCDZKSf6VRNXB78
         ld0FWI1Z7lwYWVNJQ84FYwARJMzdPZ64f/7omQRC4vEVb+M1laiS7lgQm7I8h+oPJywJ
         FlVvEbSGkPYR3m+s55jhMKZhcobVMPoSqCTCO6wjnRGjk2WpNvBA+n7tlwR19Zt8OBK6
         YuYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741064659; x=1741669459;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6AVUQwBdF+LRNxSdmVWndTSxYXj6ILT2w+aCMp60CmU=;
        b=L+ag1g7W6wMMkKrUznLq2EzGk84nX5F9KRi5bHgvI7j69Cma2CLdl0God+Pe4afWuj
         ogsFkgDbKXS6jjJJV4c9ZIH1+JIZSLwP06lGl55K9bmwa8tCefH9n1KMdVa/Qp6KKyqI
         A1V6qOuShPD9wDpU0kK+4UAfowOy45KLujz94JK6hVk2CFKrR9HOLHslmxdeOdww6ucT
         ssKK3Z7Q5L7j4reSP5JdjaPTKv5Xe2Mc6K+r3ye1HUcoLQzitK5SO4VZgwhG4P5M5U6B
         /0W/9GwdBZUFKFXk0il2rX8vtxbjI12qoFeRylkA0WUzM3q2CGGyLhSftwG3FfxxWHbD
         iQIA==
X-Forwarded-Encrypted: i=1; AJvYcCUfXBa7a/o1vW4i4ZQMfvW6rdeUZDSXMx2qosUUoE5WLUkmGf+MCr1GrD9QfmdcbS2jCteejJ5nhydv1FkwBvM0@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdl2s2Q7rbpaBNZp6K4YTMLYvyVD9g+sxwwFwfu+9Cyefc2TJN
	YQ0VGr4WwSBhmrxG24lKpgGPVIGYUsDVuSj42offaV18bYsEhwYtHzI991bgDI23QydVsT88Sxa
	c1bQN7g==
X-Google-Smtp-Source: AGHT+IFNriLJ/w4aUkUH1PpwPtem3wbzAD0wUUPq7hRnzJumCxTIiU77RSii8c4nOCM4RtZzSd5pJW9WLW9h
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8af9:d1f7:bca9:da2])
 (user=irogers job=sendgmr) by 2002:a05:690c:4d89:b0:6fd:1a6b:eb36 with SMTP
 id 00721157ae682-6fd4a134362mr16729937b3.7.1741064658796; Mon, 03 Mar 2025
 21:04:18 -0800 (PST)
Date: Mon,  3 Mar 2025 21:02:54 -0800
Message-Id: <20250304050305.901167-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Subject: [PATCH v4 00/11] perf: Support multiple system call tables in the build
From: Ian Rogers <irogers@google.com>
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, guoren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Charlie Jenkins <charlie@rivosinc.com>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Jiri Slaby <jirislaby@kernel.org>, 
	"=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn@rivosinc.com>, Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-riscv@lists.infradead.org, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

This work builds on the clean up of system call tables and removal of
libaudit by Charlie Jenkins <charlie@rivosinc.com>.

The system call table in perf trace is used to map system call numbers
to names and vice versa. Prior to these changes, a single table
matching the perf binary's build was present. The table would be
incorrect if tracing say a 32-bit binary from a 64-bit version of
perf, the names and numbers wouldn't match.

Change the build so that a single system call file is built and the
potentially multiple tables are identifiable from the ELF machine type
of the process being examined. To determine the ELF machine type, the
executable's maps are searched and the associated DSOs ELF headers are
read. When this fails and when live, /proc/pid/exe's ELF header is
read. Fallback to using the perf's binary type when unknown.

Remove some runtime types used by the system call tables and make
equivalents generated at build time.

v4: Add reading the e_machine from the thread's maps dsos, only read
    from /proc/pid/exe on failure and when live as requested by
    Namhyung. Add patches to add dso comments and remove unused
    dso_data variables that are unused without libunwind.

v3: Add Charlie's reviewed-by tags. Incorporate feedback from Arnd
    Bergmann <arnd@arndb.de> on additional optional column and MIPS
    system call numbering. Rebase past Namhyung's global system call
    statistics and add comments that they don't yet support an
    e_machine other than EM_HOST.

v2: Change the 1 element cache for the last table as suggested by
    Howard Chu, add Howard's reviewed-by tags.
    Add a comment and apology to Charlie for not doing better in
    guiding:
    https://lore.kernel.org/all/20250114-perf_syscall_arch_runtime-v1-1-5b304e408e11@rivosinc.com/
    After discussion on v1 and he agreed this patch series would be
    the better direction.

Ian Rogers (11):
  perf dso: Move libunwind dso_data variables into ifdef
  perf dso: kernel-doc for enum dso_binary_type
  perf syscalltbl: Remove syscall_table.h
  perf trace: Reorganize syscalls
  perf syscalltbl: Remove struct syscalltbl
  perf dso: Add support for reading the e_machine type for a dso
  perf thread: Add support for reading the e_machine type for a thread
  perf trace beauty: Add syscalltbl.sh generating all system call tables
  perf syscalltbl: Use lookup table containing multiple architectures
  perf build: Remove Makefile.syscalls
  perf syscalltbl: Mask off ABI type for MIPS system calls

 tools/perf/Makefile.perf                      |  10 +-
 tools/perf/arch/alpha/entry/syscalls/Kbuild   |   2 -
 .../alpha/entry/syscalls/Makefile.syscalls    |   5 -
 tools/perf/arch/alpha/include/syscall_table.h |   2 -
 tools/perf/arch/arc/entry/syscalls/Kbuild     |   2 -
 .../arch/arc/entry/syscalls/Makefile.syscalls |   3 -
 tools/perf/arch/arc/include/syscall_table.h   |   2 -
 tools/perf/arch/arm/entry/syscalls/Kbuild     |   4 -
 .../arch/arm/entry/syscalls/Makefile.syscalls |   2 -
 tools/perf/arch/arm/include/syscall_table.h   |   2 -
 tools/perf/arch/arm64/entry/syscalls/Kbuild   |   3 -
 .../arm64/entry/syscalls/Makefile.syscalls    |   6 -
 tools/perf/arch/arm64/include/syscall_table.h |   8 -
 tools/perf/arch/csky/entry/syscalls/Kbuild    |   2 -
 .../csky/entry/syscalls/Makefile.syscalls     |   3 -
 tools/perf/arch/csky/include/syscall_table.h  |   2 -
 .../perf/arch/loongarch/entry/syscalls/Kbuild |   2 -
 .../entry/syscalls/Makefile.syscalls          |   3 -
 .../arch/loongarch/include/syscall_table.h    |   2 -
 tools/perf/arch/mips/entry/syscalls/Kbuild    |   2 -
 .../mips/entry/syscalls/Makefile.syscalls     |   5 -
 tools/perf/arch/mips/include/syscall_table.h  |   2 -
 tools/perf/arch/parisc/entry/syscalls/Kbuild  |   3 -
 .../parisc/entry/syscalls/Makefile.syscalls   |   6 -
 .../perf/arch/parisc/include/syscall_table.h  |   8 -
 tools/perf/arch/powerpc/entry/syscalls/Kbuild |   3 -
 .../powerpc/entry/syscalls/Makefile.syscalls  |   6 -
 .../perf/arch/powerpc/include/syscall_table.h |   8 -
 tools/perf/arch/riscv/entry/syscalls/Kbuild   |   2 -
 .../riscv/entry/syscalls/Makefile.syscalls    |   4 -
 tools/perf/arch/riscv/include/syscall_table.h |   8 -
 tools/perf/arch/s390/entry/syscalls/Kbuild    |   2 -
 .../s390/entry/syscalls/Makefile.syscalls     |   5 -
 tools/perf/arch/s390/include/syscall_table.h  |   2 -
 tools/perf/arch/sh/entry/syscalls/Kbuild      |   2 -
 .../arch/sh/entry/syscalls/Makefile.syscalls  |   4 -
 tools/perf/arch/sh/include/syscall_table.h    |   2 -
 tools/perf/arch/sparc/entry/syscalls/Kbuild   |   3 -
 .../sparc/entry/syscalls/Makefile.syscalls    |   5 -
 tools/perf/arch/sparc/include/syscall_table.h |   8 -
 tools/perf/arch/x86/entry/syscalls/Kbuild     |   3 -
 .../arch/x86/entry/syscalls/Makefile.syscalls |   6 -
 tools/perf/arch/x86/include/syscall_table.h   |   8 -
 tools/perf/arch/xtensa/entry/syscalls/Kbuild  |   2 -
 .../xtensa/entry/syscalls/Makefile.syscalls   |   4 -
 .../perf/arch/xtensa/include/syscall_table.h  |   2 -
 tools/perf/builtin-trace.c                    | 290 +++++++++++-------
 tools/perf/scripts/Makefile.syscalls          |  61 ----
 tools/perf/scripts/syscalltbl.sh              |  86 ------
 tools/perf/trace/beauty/syscalltbl.sh         | 274 +++++++++++++++++
 tools/perf/util/dso.c                         |  54 ++++
 tools/perf/util/dso.h                         |  56 ++++
 tools/perf/util/syscalltbl.c                  | 148 ++++-----
 tools/perf/util/syscalltbl.h                  |  22 +-
 tools/perf/util/thread.c                      |  80 +++++
 tools/perf/util/thread.h                      |  14 +-
 56 files changed, 756 insertions(+), 509 deletions(-)
 delete mode 100644 tools/perf/arch/alpha/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/alpha/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/alpha/include/syscall_table.h
 delete mode 100644 tools/perf/arch/arc/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/arc/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/arc/include/syscall_table.h
 delete mode 100644 tools/perf/arch/arm/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/arm/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/arm/include/syscall_table.h
 delete mode 100644 tools/perf/arch/arm64/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/arm64/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/arm64/include/syscall_table.h
 delete mode 100644 tools/perf/arch/csky/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/csky/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/csky/include/syscall_table.h
 delete mode 100644 tools/perf/arch/loongarch/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/loongarch/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/loongarch/include/syscall_table.h
 delete mode 100644 tools/perf/arch/mips/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/mips/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/mips/include/syscall_table.h
 delete mode 100644 tools/perf/arch/parisc/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/parisc/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/parisc/include/syscall_table.h
 delete mode 100644 tools/perf/arch/powerpc/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/powerpc/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/powerpc/include/syscall_table.h
 delete mode 100644 tools/perf/arch/riscv/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/riscv/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/riscv/include/syscall_table.h
 delete mode 100644 tools/perf/arch/s390/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/s390/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/s390/include/syscall_table.h
 delete mode 100644 tools/perf/arch/sh/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/sh/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/sh/include/syscall_table.h
 delete mode 100644 tools/perf/arch/sparc/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/sparc/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/sparc/include/syscall_table.h
 delete mode 100644 tools/perf/arch/x86/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/x86/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/x86/include/syscall_table.h
 delete mode 100644 tools/perf/arch/xtensa/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/xtensa/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/xtensa/include/syscall_table.h
 delete mode 100644 tools/perf/scripts/Makefile.syscalls
 delete mode 100755 tools/perf/scripts/syscalltbl.sh
 create mode 100755 tools/perf/trace/beauty/syscalltbl.sh

-- 
2.48.1.711.g2feabab25a-goog

