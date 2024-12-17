Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408F71DD88F
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Dec 2024 06:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734417559; cv=none; b=qwjJYDPE4F1VEAJ7WRbKI0fopsrLFWOXD2PBRmTxabywsFphp1QxMyhZm3iPSmeyJT4D5F/lpOfeDgGw7AT4NpW5fCSj3bJP5d/QKeJoCu5T3clbxSSIH/zP9VbS3WkndgxICIBl1HFYQ+aZSPYmpyCRx/mnoFhF9k7ComG5Foc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734417559; c=relaxed/simple;
	bh=CSbFNbbtJpMGr7r+QYmbHb79wr/WkObTrKseW/OIITk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=V4Tgegx1ntzvtUDtDLIAb73y7PLCxRLhPGXiLA6a7JPsJs8DL3TCd/P75aelkvs4411G2mM2fJXpVWb2WESVhvlIPXSN+qVGIpr/3c89HjtdrkZGmyBq+CAe3hvPfkU8g/CWfJYDy1LwIWDePehCoH+fGOB90n4NxejAs/frmCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=mHhUr5DM; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="mHhUr5DM"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7e9e38dd5f1so3735996a12.0
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Dec 2024 22:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734417556; x=1735022356; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5GKwKdXwSXZuL2D8cviPm/qFzDIAQPtFdeTjDmUaPXg=;
        b=mHhUr5DMQmEK4dx0zoKVThyUihEY3YYER7W4uz85+/FHYFuWTNmTseYQIUspVRtB8n
         WR42naUNsAEVBEaUZao3PWTQ1oppVH4u1GMG8dkn8+UXFMBY1PSJF33yFaa/MArtL4ki
         Iq9Noxp3t687KmwD5pkpGKJ9rEI37raji4aJe5YeVT41wmv7TyFae69KLYTgj1YcRCma
         +KG6aLawPNGquasDTZEv29WPP8i4uAgIrgPyMJW8p2ELgzduEQpx86TZo+UyrJFkmW4/
         Ke2vsX7k3tnjXFKMJ4eJd1BmjLpIiypQZ37ZQQ8eDYiIE4xe7NIKcaBKVZhpcArKgyLv
         yX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734417556; x=1735022356;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5GKwKdXwSXZuL2D8cviPm/qFzDIAQPtFdeTjDmUaPXg=;
        b=PY82I5oHLWnKUJlirNPILgvtvnkzTJX77Xqyb9k+AvmASmIdCJ7vpglwmjibASFlu5
         w9uhZwLCcike1zGiTCHVvZFwNmHlGLhiO/jCW6L5U1ON459iQs8XyybEO5Ojp3+gh9bj
         V19OPvI/SPKI1I9nP4Lxhma18VRmRBM+W3NU3VpY1aj3efPvJQp2+/egIFkUK76rWmpg
         CUygYNLlELJIsaF/ueey8Yzo8G1+U8jBkyx2RwyEHlVU60xGZaakisnzDK4osHreyF98
         obz3WMi2gRNsoIY2KswuT4F8OLgtW4/29Tcx48m5QGtQRrIVoxXUyU3IPZBlS8cnKryn
         KlEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzccqNMbpJgCw98uy1MFPKQc78+XxLEEJAwV5/7yEF5YSlzfMIUkKEW3tjC/eEN33pCNeMNkA+N9PXEzy6NLIG@vger.kernel.org
X-Gm-Message-State: AOJu0YxIu+/cr7NEUX8EN9Wl77g74h8fHWIZNZ2LAzrudMRE7tJ2iFFP
	9M0WQBirng/KYGHtZihvL5hPyazSIN3NGgC09JIUBCr4yNRLUoJ9CM/4NOUFt4E=
X-Gm-Gg: ASbGncs47qvTfZlGyE8I2GVFcPbatvtxim3M03Se9E7RJU330c9BZsYdeaxhGXcBDkB
	PFuWQsKrW9wKOeHhcjgbV3etiF11OuXz2zqilFQBgrcTYkGM6XrvZNwaz3BJsquKmMSGuDw7BpY
	ZMK+L8mSOPdBcO6T2NzTTIuGViJ45FZj8fIejj/UTksVv5UpYquvJ9g6qcZB6Nh9fUWrGhTkh+b
	XXLRRIDxL5ELjVy/359RPIdKaznkWFsKbPGIp/yxdNM/iSSUGe9nghYfuSDW1e0UDUgG8OK
X-Google-Smtp-Source: AGHT+IG8wAmIpqIQU+QN9wyuY7FpuGBEpM1hsVQvRU88nFGSgia4kFPf1I/7uxrw0bEBGiqVKBh0gg==
X-Received: by 2002:a17:90b:2807:b0:2ee:6263:cc0c with SMTP id 98e67ed59e1d1-2f2901b7d57mr23118004a91.37.1734417556372;
        Mon, 16 Dec 2024 22:39:16 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142d90d6bsm9179551a91.2.2024.12.16.22.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 22:39:15 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v3 00/16] perf tools: Use generic syscall scripts for all
 archs
Date: Mon, 16 Dec 2024 22:32:45 -0800
Message-Id: <20241216-perf_syscalltbl-v3-0-239f032481d5@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA0bYWcC/2XN0QqCMBTG8VeJXbfY5jTXVe8REet4Tg7MySYjE
 d+96U2Ql/8Pzu/MLGJwGNnlMLOAyUXn+xzF8cCgtf0LuWtyMyWUFkYWfMBAjzhFsF03Pjtekak
 bJICKSpavhoDkPpt4u+duXRx9mLYHSa7rZkkp9M5KkgtubGOxhHMlka7BJR9dDyfwb7ZySf0IJ
 dWeUJmgGqypNRFq8Ucsy/IFLsr3rfQAAAA=
X-Change-ID: 20240913-perf_syscalltbl-6f98defcc6f5
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Christian Brauner <brauner@kernel.org>, Guo Ren <guoren@kernel.org>, 
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
 Leo Yan <leo.yan@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>, 
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-security-module@vger.kernel.org, 
 bpf@vger.kernel.org, linux-csky@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7757; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=CSbFNbbtJpMGr7r+QYmbHb79wr/WkObTrKseW/OIITk=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3qi9Id/khryJidfsGr8eLdIPP7ResdrS8RPiqu2VF1+4
 ubhtEyvo5SFQYyDQVZMkYXnWgNz6x39sqOiZRNg5rAygQxh4OIUgInI3Wdk6KrVM56s6MG5qlrt
 RXzglZpl92OKLtef41ygIBE7jXOfEsMfrkWRr9U3fVrUJNjmZ2myVKXzt5fwEc2YE2LcjYev7vz
 HDgA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Standardize the generation of syscall headers around syscall tables.
Previously each architecture independently selected how syscall headers
would be generated, or would not define a way and fallback onto
libaudit. Convert all architectures to use a standard syscall header
generation script and allow each architecture to override the syscall
table to use if they do not use the generic table.

As a result of these changes, no architecture will require libaudit, and
so the fallback case of using libaudit is removed by this series.

Testing:

I have tested that the syscall mappings of id to name generation works
as expected for every architecture, but I have only validated that perf
trace compiles and runs as expected on riscv, arm64, and x86_64.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Changes in v3:
- Fix compiliation when OUTPUT is empty
- Correct unused headers to be .h instead of .c  (Namhyung)
- Make variable definition of supported archs (Namhyung)
- Convert += into := for syscalls headers (Namhyung)
- Link to v2: https://lore.kernel.org/r/20241212-perf_syscalltbl-v2-0-f8ca984ffe40@rivosinc.com

Changes in v2:
- Rebase onto 6.13-rc2
- Fix output path so it generates to /tools/perf/arch properly
- Link to v1: https://lore.kernel.org/r/20241104-perf_syscalltbl-v1-0-9adae5c761ef@rivosinc.com

---
Charlie Jenkins (16):
      perf tools: Create generic syscall table support
      perf tools: arc: Support generic syscall headers
      perf tools: csky: Support generic syscall headers
      perf tools: arm: Support syscall headers
      perf tools: sh: Support syscall headers
      perf tools: sparc: Support syscall headers
      perf tools: xtensa: Support syscall header
      perf tools: x86: Use generic syscall scripts
      perf tools: alpha: Support syscall header
      perf tools: parisc: Support syscall header
      perf tools: arm64: Use syscall table
      perf tools: loongarch: Use syscall table
      perf tools: mips: Use generic syscall scripts
      perf tools: powerpc: Use generic syscall table scripts
      perf tools: s390: Use generic syscall table scripts
      perf tools: Remove dependency on libaudit

 Documentation/admin-guide/workload-tracing.rst     |   2 +-
 tools/build/feature/Makefile                       |   4 -
 tools/build/feature/test-libaudit.c                |  11 -
 tools/perf/Documentation/perf-check.txt            |   1 -
 tools/perf/Makefile.config                         |  39 +-
 tools/perf/Makefile.perf                           |  12 +-
 tools/perf/arch/alpha/entry/syscalls/Kbuild        |   2 +
 .../arch/alpha/entry/syscalls/Makefile.syscalls    |   5 +
 tools/perf/arch/alpha/entry/syscalls/syscall.tbl   | 504 ++++++++++++++++++++
 tools/perf/arch/alpha/include/syscall_table.h      |   2 +
 tools/perf/arch/arc/entry/syscalls/Kbuild          |   2 +
 .../perf/arch/arc/entry/syscalls/Makefile.syscalls |   3 +
 tools/perf/arch/arc/include/syscall_table.h        |   2 +
 tools/perf/arch/arm/entry/syscalls/Kbuild          |   4 +
 .../perf/arch/arm/entry/syscalls/Makefile.syscalls |   2 +
 tools/perf/arch/arm/entry/syscalls/syscall.tbl     | 483 +++++++++++++++++++
 tools/perf/arch/arm/include/syscall_table.h        |   2 +
 tools/perf/arch/arm64/Makefile                     |  22 -
 tools/perf/arch/arm64/entry/syscalls/Kbuild        |   3 +
 .../arch/arm64/entry/syscalls/Makefile.syscalls    |   6 +
 tools/perf/arch/arm64/entry/syscalls/mksyscalltbl  |  46 --
 .../perf/arch/arm64/entry/syscalls/syscall_32.tbl  | 476 +++++++++++++++++++
 .../perf/arch/arm64/entry/syscalls/syscall_64.tbl  |   1 +
 tools/perf/arch/arm64/include/syscall_table.h      |   8 +
 tools/perf/arch/csky/entry/syscalls/Kbuild         |   2 +
 .../arch/csky/entry/syscalls/Makefile.syscalls     |   3 +
 tools/perf/arch/csky/include/syscall_table.h       |   2 +
 tools/perf/arch/loongarch/Makefile                 |  22 -
 tools/perf/arch/loongarch/entry/syscalls/Kbuild    |   2 +
 .../loongarch/entry/syscalls/Makefile.syscalls     |   3 +
 .../arch/loongarch/entry/syscalls/mksyscalltbl     |  45 --
 tools/perf/arch/loongarch/include/syscall_table.h  |   2 +
 tools/perf/arch/mips/entry/syscalls/Kbuild         |   2 +
 .../arch/mips/entry/syscalls/Makefile.syscalls     |   5 +
 tools/perf/arch/mips/entry/syscalls/mksyscalltbl   |  32 --
 tools/perf/arch/mips/include/syscall_table.h       |   2 +
 tools/perf/arch/parisc/entry/syscalls/Kbuild       |   3 +
 .../arch/parisc/entry/syscalls/Makefile.syscalls   |   6 +
 tools/perf/arch/parisc/entry/syscalls/syscall.tbl  | 463 +++++++++++++++++++
 tools/perf/arch/parisc/include/syscall_table.h     |   8 +
 tools/perf/arch/powerpc/Makefile                   |  25 -
 tools/perf/arch/powerpc/entry/syscalls/Kbuild      |   3 +
 .../arch/powerpc/entry/syscalls/Makefile.syscalls  |   6 +
 .../perf/arch/powerpc/entry/syscalls/mksyscalltbl  |  39 --
 tools/perf/arch/powerpc/include/syscall_table.h    |   8 +
 tools/perf/arch/riscv/Makefile                     |  22 -
 tools/perf/arch/riscv/entry/syscalls/Kbuild        |   2 +
 .../arch/riscv/entry/syscalls/Makefile.syscalls    |   4 +
 tools/perf/arch/riscv/entry/syscalls/mksyscalltbl  |  47 --
 tools/perf/arch/riscv/include/syscall_table.h      |   8 +
 tools/perf/arch/s390/Makefile                      |  21 -
 tools/perf/arch/s390/entry/syscalls/Kbuild         |   2 +
 .../arch/s390/entry/syscalls/Makefile.syscalls     |   5 +
 tools/perf/arch/s390/entry/syscalls/mksyscalltbl   |  32 --
 tools/perf/arch/s390/include/syscall_table.h       |   2 +
 tools/perf/arch/sh/entry/syscalls/Kbuild           |   2 +
 .../perf/arch/sh/entry/syscalls/Makefile.syscalls  |   4 +
 tools/perf/arch/sh/entry/syscalls/syscall.tbl      | 472 +++++++++++++++++++
 tools/perf/arch/sh/include/syscall_table.h         |   2 +
 tools/perf/arch/sparc/entry/syscalls/Kbuild        |   3 +
 .../arch/sparc/entry/syscalls/Makefile.syscalls    |   5 +
 tools/perf/arch/sparc/entry/syscalls/syscall.tbl   | 514 +++++++++++++++++++++
 tools/perf/arch/sparc/include/syscall_table.h      |   8 +
 tools/perf/arch/x86/Build                          |   1 -
 tools/perf/arch/x86/Makefile                       |  25 -
 tools/perf/arch/x86/entry/syscalls/Kbuild          |   3 +
 .../perf/arch/x86/entry/syscalls/Makefile.syscalls |   6 +
 tools/perf/arch/x86/entry/syscalls/syscalltbl.sh   |  42 --
 tools/perf/arch/x86/include/syscall_table.h        |   8 +
 tools/perf/arch/xtensa/entry/syscalls/Kbuild       |   2 +
 .../arch/xtensa/entry/syscalls/Makefile.syscalls   |   4 +
 tools/perf/arch/xtensa/entry/syscalls/syscall.tbl  | 439 ++++++++++++++++++
 tools/perf/arch/xtensa/include/syscall_table.h     |   2 +
 tools/perf/builtin-check.c                         |   1 -
 tools/perf/builtin-help.c                          |   2 -
 tools/perf/builtin-trace.c                         |  30 --
 tools/perf/check-headers.sh                        |   9 +
 tools/perf/perf.c                                  |   6 +-
 tools/perf/scripts/Makefile.syscalls               |  61 +++
 tools/perf/scripts/syscalltbl.sh                   |  86 ++++
 tools/perf/tests/make                              |   7 +-
 tools/perf/util/env.c                              |   4 +-
 tools/perf/util/generate-cmdlist.sh                |   4 +-
 tools/perf/util/syscalltbl.c                       |  90 +---
 tools/scripts/syscall.tbl                          | 409 ++++++++++++++++
 85 files changed, 4102 insertions(+), 619 deletions(-)
---
base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
change-id: 20240913-perf_syscalltbl-6f98defcc6f5
-- 
- Charlie

