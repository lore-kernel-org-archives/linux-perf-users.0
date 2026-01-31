Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A645736B05A
	for <linux-perf-users@vger.kernel.org>; Sat, 31 Jan 2026 20:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769889750; cv=none; b=MYpa6KvtJJuWINbJ7gPtde4YrA1U4YN6aSAEz9SygV792H97hLX3iQcQXNNfGTHHqfoV0Hdek1TI13ydm8zXN0W4WW8Zr2PmtJxFVH69sLvDGu7rd7wdtNiA4ag8HblBQuerGpRpWKqXD/pVHpCdAX/vK35HoAwyYJygY4kcONk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769889750; c=relaxed/simple;
	bh=NVyx+VCsRHKhaUbQdV0o6S3WdZimaqcI1qOtaxBD2pA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=hXYp12EjWK+Hr7wiyxB5GKzgAf8+2x0iOgYj0FEn7xoD7LMO91lGbED2HLj5qY/w+RoAK/nK8wt27AkCkhp/xDYJcSTg7ZIO7N/O/KysXW3rMX5ILSs8JLexIigfcfY0kDVm08TWvGvnPPZRpjL8I8AaVWNX259aSTiXJbcQ/+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PSZPCFeV; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PSZPCFeV"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2b7c12b62f8so1991578eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 31 Jan 2026 12:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769889748; x=1770494548; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QaGUZTYnRQ2wGpunAGr/0FtMXdyckbXL2oq4bK6APm0=;
        b=PSZPCFeVGcM09JnJhWiySKNx+4w2b5HYUy6owQFXbk92twVfwrLIQD7M0MHgPh1dL7
         Fv46cdtZ7e85qPgrKb97iaAmmH2KkpMnl/C7XRXhIbKDeb/8mG1plhUw2+hOKoXTFt8w
         /wU3tXdXGZuwiz9Oy2PFw/3MUvfJ12ilST0adFQfeCsCj2GgIgSpd6yfroFYCLTtGFE6
         an2lzHTHuSW8n8X7ChSnB/oeInRsBaAVIRF2Mxr82Wa733/2wmfaQGYG9rYcJF73NRRl
         UyBdLj0MbKLXDjX6HSFgKySP8ThugIRl8TaUb8lwsXU0Yrm1uWwCdz9WyzSwNe01GYhB
         X+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769889748; x=1770494548;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QaGUZTYnRQ2wGpunAGr/0FtMXdyckbXL2oq4bK6APm0=;
        b=mvEoTHGEiwtxF4+xzbBax4Fgili/uiMistKLL2fDjQVhg+LpT9NrlXzUceeRn2q8ia
         z7hvk3/+BOKSVmICx4c3uB1/dF1QYaDOMq3G6zkqKGhbDNFpdYInyzM4daJR3W40TMHk
         I4y3QvKEw4zzVymXVoT9pIW8faU8Uy0ugD5dPAOxCfNWqKjG5NIURA+O85FKWvb3nSmY
         +F/AoP8zHt/Z0nSZ/9GpdF7/Us07JTdcUWfuTYpPqnZoVJSzGkbdIbbQuep/lMvScZ3n
         VmWIlG80ORuNU5+QxKCDT1N/5+MZLQ/2MPEnP6nWfCU5aRoVxAem9iv94U4MSC82uSQF
         xkvw==
X-Forwarded-Encrypted: i=1; AJvYcCWopuazdXf1BF3lcqdWahkXhCR5EYZC1+x/g9cyZkZ6CTxxrCgEGKuUAbbouMBL/Kfvf5SDJiRCXuWC7nsjNqmM@vger.kernel.org
X-Gm-Message-State: AOJu0YxQdzFdtA5c3tvTjF/KWRS/DqXC7u8T7xdknUr2XVJke/I21bpN
	YS6M5PrVi53WeP6SqYVSWUXCEbD/L6S6zxzirdn/mEjzRpSZQdxV7DHAWf4AD5Z1JQP9dHVVtXK
	plrNE7kjvUA==
X-Received: from dlbpy24.prod.google.com ([2002:a05:7022:e998:b0:123:2708:9404])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:608d:b0:123:2de5:346e
 with SMTP id a92af1059eb24-125c18bebdbmr2411145c88.0.1769889747533; Sat, 31
 Jan 2026 12:02:27 -0800 (PST)
Date: Sat, 31 Jan 2026 12:02:18 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260131200224.1296136-1-irogers@google.com>
Subject: [PATCH v2 0/6] perf Cross platform KVM support
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Shimin Guo <shimin.guo@skydio.com>, Yunseong Kim <ysk@kzalloc.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Quan Zhou <zhouquan@iscas.ac.cn>, 
	Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Blake Jones <blakejones@google.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Anubhav Shelat <ashelat@redhat.com>, Aditya Bodkhe <aditya.b1@linux.ibm.com>, 
	Chun-Tse Shao <ctshao@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

The existing perf kvm code is using the arch directory, which means a
data file can only be processed on the same machine type that it was
recorded. Switch to using the ELF machine of the session at runtime to
set up the KVM support, making it cross-architectural. So that the ELF
machine number is available early in initialization add it to the perf
data file header.

v2: Wire up the perf data header to have the e_machine and allow early
    initialization of the KVM operations based upon it.
v1: https://lore.kernel.org/lkml/20260128074106.788156-1-irogers@google.com/

Ian Rogers (6):
  perf test kvm: Add stat live testing
  perf kvm stat: Remove use of the arch directory
  perf kvm: Wire up e_machine
  perf session: Add e_flags to the e_machine helper
  perf header: Add e_machine/e_flags to the header
  perf thread: Don't require machine to compute the e_machine

 tools/perf/Makefile.config                    |   4 -
 tools/perf/arch/arm64/Makefile                |   1 -
 tools/perf/arch/arm64/util/Build              |   1 -
 tools/perf/arch/loongarch/Makefile            |   1 -
 tools/perf/arch/loongarch/util/Build          |   1 -
 tools/perf/arch/powerpc/Makefile              |   1 -
 tools/perf/arch/powerpc/util/Build            |   1 -
 tools/perf/arch/riscv/Makefile                |   1 -
 tools/perf/arch/riscv/util/Build              |   2 -
 tools/perf/arch/s390/Makefile                 |   1 -
 tools/perf/arch/s390/util/Build               |   1 -
 tools/perf/arch/x86/Makefile                  |   1 -
 tools/perf/arch/x86/util/Build                |   1 -
 tools/perf/builtin-kvm.c                      |  73 +++---
 tools/perf/builtin-report.c                   |   4 +-
 tools/perf/builtin-script.c                   |   6 +-
 tools/perf/tests/shell/kvm.sh                 |  30 ++-
 tools/perf/util/Build                         |   3 +-
 tools/perf/util/env.h                         |   3 +
 tools/perf/util/evsel.c                       |   6 +-
 tools/perf/util/evsel.h                       |   1 +
 tools/perf/util/header.c                      |  33 +++
 tools/perf/util/header.h                      |   1 +
 tools/perf/util/kvm-stat-arch/Build           |   6 +
 .../kvm-stat-arch}/arm64_exception_types.h    |   0
 .../kvm-stat-arch}/book3s_hcalls.h            |   0
 .../kvm-stat-arch}/book3s_hv_exits.h          |   0
 .../kvm-stat-arch/kvm-stat-arm64.c}           |  43 ++--
 .../kvm-stat-arch/kvm-stat-loongarch.c}       |  48 ++--
 .../kvm-stat-arch/kvm-stat-powerpc.c}         |  61 ++---
 .../kvm-stat-arch/kvm-stat-riscv.c}           |  42 ++--
 .../kvm-stat-arch/kvm-stat-s390.c}            |  38 ++--
 .../kvm-stat-arch/kvm-stat-x86.c}             |  44 ++--
 .../kvm-stat-arch}/riscv_trap_types.h         |   2 +-
 tools/perf/util/kvm-stat.c                    | 215 +++++++++++++++++-
 tools/perf/util/kvm-stat.h                    |  70 ++++--
 .../scripting-engines/trace-event-python.c    |   8 +-
 tools/perf/util/session.c                     |  62 ++++-
 tools/perf/util/session.h                     |   2 +-
 tools/perf/util/thread.c                      |   5 +
 40 files changed, 606 insertions(+), 217 deletions(-)
 create mode 100644 tools/perf/util/kvm-stat-arch/Build
 rename tools/perf/{arch/arm64/util => util/kvm-stat-arch}/arm64_exception_types.h (100%)
 rename tools/perf/{arch/powerpc/util => util/kvm-stat-arch}/book3s_hcalls.h (100%)
 rename tools/perf/{arch/powerpc/util => util/kvm-stat-arch}/book3s_hv_exits.h (100%)
 rename tools/perf/{arch/arm64/util/kvm-stat.c => util/kvm-stat-arch/kvm-stat-arm64.c} (62%)
 rename tools/perf/{arch/loongarch/util/kvm-stat.c => util/kvm-stat-arch/kvm-stat-loongarch.c} (77%)
 rename tools/perf/{arch/powerpc/util/kvm-stat.c => util/kvm-stat-arch/kvm-stat-powerpc.c} (78%)
 rename tools/perf/{arch/riscv/util/kvm-stat.c => util/kvm-stat-arch/kvm-stat-riscv.c} (57%)
 rename tools/perf/{arch/s390/util/kvm-stat.c => util/kvm-stat-arch/kvm-stat-s390.c} (77%)
 rename tools/perf/{arch/x86/util/kvm-stat.c => util/kvm-stat-arch/kvm-stat-x86.c} (88%)
 rename tools/perf/{arch/riscv/util => util/kvm-stat-arch}/riscv_trap_types.h (96%)

-- 
2.53.0.rc1.225.gd81095ad13-goog

