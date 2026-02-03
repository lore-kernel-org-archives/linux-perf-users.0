Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0055B35EDB3
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Feb 2026 18:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770143226; cv=none; b=GasqtUAej2rlUCPhFcNDw/vdfjldNqZ9SNQZkxQpxGLd4foJG7pqhuDN05izDvSnloku2rkEV5vgHNIOmgT8fd94ua4WEr6BlTrgPKn59B/h7pWOXfpv4mrV8uXwVyHxR8O8bPrqz8fW3Ig0XlNXZJmT03zTKKlX8sobIJjAjJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770143226; c=relaxed/simple;
	bh=xyXwMzrlLHVU9R/Xsu84yI0mTGRWcKcAY4bLVDpEjNs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CMwEvXCFEqAof52hgWSla/ukxN7bOHXhIY9il7c5DQkqAxD8lZmpmCTNido02LbI8MwH7SmWIn7GEofnJ5sEAXfT5zzsiQSQNCDWTGrtr0P6xyo56PkIh2Nsz/alUJSGJRsf4H/32/SVrATXcf0UrJZiPBPiE7Y3gRGO87RcPBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m8e0UhzZ; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m8e0UhzZ"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b715b26fc3so7973192eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Feb 2026 10:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770143224; x=1770748024; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6nfD0iDGQlTrmds7D8QgMt8w2CmNdX8gcS8Au5Qqnqw=;
        b=m8e0UhzZpVi557r2Aulca9f6qByneWjt3X50D/Qsm87BApHfgfNl71cJQgxDeA3tU5
         ouV1cJFtsD2Vll3ux1yB2kLVrGrOUt4B3H/7fOP6StF5yn3EhH0gWe3vw2zGiFtF6wXr
         x1l8EDiafCrzmxLP/TUYkIRzGlSHx8dft+hNUF8v8H+Y5ldhNgrNeJO/n/OkpkUepzCP
         x2l69uG9KJCdiUMYIQXcaG+2fMqTOuwUMkxxQGPQFfj0ice9lE1PerlXDw/p1m6EJpAc
         vjnCZ0732qdsRMVTKruC0wrrQYlkW52i29cMHwaFkwaO3hImh+rDoaeWBv4EOoh9H4un
         4GGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770143224; x=1770748024;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6nfD0iDGQlTrmds7D8QgMt8w2CmNdX8gcS8Au5Qqnqw=;
        b=wAev+ISK/HMrgMTd17JO60OQ7oc484nPzLrgPK7hMKkzGlAQH9zCrPoNcpZdrimadr
         R8kr5giYlGBkOIbYj0wchsqoC+Oeatazd27lSVPgb+BrvbflINWtrauUqQxQanKP6XKK
         tjquhsnfZwG1GbZ2K8uiiBqCWDGPMVCwwMd4kzcSmgUW9PZ0asVUH6rD96iSeIQpXlvB
         RoVzyMeryO1XgPuOlGM2T2OscfqJUCdbgwCcqrwcEzbZpg7V+xFjz1ibn7usjQtM/8sF
         jGrEGfjYPY7AP5GV0R9i/VjMiKL/05uY6FFuLKr0yRA63KRZDQ8uT55TzUlybs8dYKhr
         +oUw==
X-Forwarded-Encrypted: i=1; AJvYcCU1SNDvaCn+w0AoyecrEHYrpr8caj2C/lzwHp2d30GK/g471SFvacy1TURPe1W94NBfDk5Nr8hsNAMcFnV9gvpW@vger.kernel.org
X-Gm-Message-State: AOJu0YzEtvWQz1PkD1OJZno1FRTVWGWgOhU0uICMeOPnJk8z2u3jjX4l
	IeQ3EmHWVnSu7z4sretDfmrBBMObOKjSvhNXwvuA/evRUw06Eaho2tifT5k6cLVsJdVxW4LzH1/
	3aNCGuT5yLw==
X-Received: from dlak15.prod.google.com ([2002:a05:701b:290f:b0:123:2800:6acb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6713:b0:119:e56b:98ba
 with SMTP id a92af1059eb24-126f47db898mr153926c88.33.1770143223895; Tue, 03
 Feb 2026 10:27:03 -0800 (PST)
Date: Tue,  3 Feb 2026 10:26:35 -0800
In-Reply-To: <aYIOMWb2sijXzSDm@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aYIOMWb2sijXzSDm@x1>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260203182640.3911987-1-irogers@google.com>
Subject: [PATCH v3 0/5] perf Cross platform KVM support
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org
Cc: aditya.b1@linux.ibm.com, adrian.hunter@intel.com, ajones@ventanamicro.com, 
	ak@linux.intel.com, alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, ashelat@redhat.com, 
	atrajeev@linux.ibm.com, blakejones@google.com, ctshao@google.com, 
	dapeng1.mi@linux.intel.com, dvyukov@google.com, howardchu95@gmail.com, 
	irogers@google.com, james.clark@linaro.org, john.g.garry@oracle.com, 
	jolsa@kernel.org, leo.yan@linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-riscv@lists.infradead.org, mingo@redhat.com, namhyung@kernel.org, 
	palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	shimin.guo@skydio.com, swapnil.sapkal@amd.com, thomas.falcon@intel.com, 
	will@kernel.org, ysk@kzalloc.com, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

The existing perf kvm code is using the arch directory, which means a
data file can only be processed on the same machine type that it was
recorded. Switch to using the ELF machine of the session at runtime to
set up the KVM support, making it cross-architectural. So that the ELF
machine number is available early in initialization add it to the perf
data file header.

v3: Fix NO_LIBTRACEEVENT=1 build, kvm-stat-loongarch.c for old elf.h
    files and 32-bit build of kvm-stat-s390.c as reported by
    Arnaldo. Drop the first kvm stat live test patch that Arnaldo
    reported as merged.

v2: Wire up the perf data header to have the e_machine and allow early
    initialization of the KVM operations based upon it.
    https://lore.kernel.org/lkml/20260131200224.1296136-1-irogers@google.com/#t

v1: https://lore.kernel.org/lkml/20260128074106.788156-1-irogers@google.com/

Ian Rogers (5):
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
 .../kvm-stat-arch/kvm-stat-loongarch.c}       |  49 ++--
 .../kvm-stat-arch/kvm-stat-powerpc.c}         |  61 ++---
 .../kvm-stat-arch/kvm-stat-riscv.c}           |  42 ++--
 .../kvm-stat-arch/kvm-stat-s390.c}            |  40 ++--
 .../kvm-stat-arch/kvm-stat-x86.c}             |  44 ++--
 .../kvm-stat-arch}/riscv_trap_types.h         |   2 +-
 tools/perf/util/kvm-stat.c                    | 215 +++++++++++++++++-
 tools/perf/util/kvm-stat.h                    |  79 +++++--
 .../scripting-engines/trace-event-python.c    |   8 +-
 tools/perf/util/session.c                     |  62 ++++-
 tools/perf/util/session.h                     |   2 +-
 tools/perf/util/thread.c                      |   5 +
 39 files changed, 590 insertions(+), 215 deletions(-)
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
2.53.0.rc2.204.g2597b5adb4-goog

