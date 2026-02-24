Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E2037BE70
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Feb 2026 14:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771943392; cv=none; b=fsTH0XgtXCHfL/K7WD5V8GoxO8ybwFfUmyRg/t+1g4atNu28evkjbnQDvsLCBpouu0OMlUzTN1vMI5RiMcJIcHlLJtLFsDTpDQ8GsDGdmM3+uiDOqhdr1QdWtlLI5FsIyKpLd5lEv2RowuprSkcpoB/x/6FDFb+jnWuu+iQBgSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771943392; c=relaxed/simple;
	bh=b10yHLIJ/YudyiBGcKE0aIz92HeSVh7Su78T6tMUi8M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=ulA3MT6/TpQA6Oh/D8diJFMBSilJiRGSw/N5T4xoDr3ihjlCO7uHEM5it4cjEwwdKenKkp6X5IeS7U7HjoBb608xvEGD3Hb3Z9axcX72c5uy3W7jk1SoW0O4MTpTolvNR+H+d9AZ9a1tlnbg5t8TCD8/B8JmfLihLwwJJogTnOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3hSIPU4T; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3hSIPU4T"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1270dcd11c1so7400219c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Feb 2026 06:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771943390; x=1772548190; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s3scIhHvsH0vZ718UKHcz+QOCtlI3GCwPe35U/BRBaA=;
        b=3hSIPU4TwTmWUtHtJ5MgWZliw0sAVYDh577LpiS+dKtv7i8gryWYAi+c7/izdNpx6A
         qHMmuZbXBftg0h+iha+aPWBwpvlmsvzojAZxWE1g+3hgzxay1zp6tpSCyrtj1hFelgbx
         WUCSVB4ljd0hjYIpRX6toF+Wq20gcNBRJ0CpcEh2z9+5CmTe/dgBEhY6sdCxXbeZiYiM
         p55H0XBnOoiItUcJKA1PRv5RcpM+boJ3iYhp7cqRX6fMyU6SbCDOnqDFDTEJUtEkkr7s
         gAT3VZWqbHRf/tHrMrY1x7ymt9yi4bTCZyeNyUHXofoLqlCWwuMYsI+XwfS/zsK2Lbj4
         RYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771943390; x=1772548190;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s3scIhHvsH0vZ718UKHcz+QOCtlI3GCwPe35U/BRBaA=;
        b=OMxcRm4Kww2yI518WIutA6z/tOA5UbC4+ov8ahYYU/YE7m6sgifV7UvEAbMhx0z79C
         W2qQU63kV40w8Z9OTAhqzIoEfauJ0ftk/65d4v9abubqj5TS50uptI1xsBa9smvaLjyb
         DxKWSLz4vdtcHDXs+ilnnpPpF2rxgPbWoB+U52ElsggFYTYNOKV6JZ4jKu/6nuTuY7Al
         DBUoY97xOaJhNn/cUbAofy9LZe8karffDfADvRgWZ4Ju2KFMLyShpf/fiby7tpRbwAii
         bGF3/no4pNNHEXPeW7XiQRdUj8ehuhvIIbymHwu7vYOxdfgr/Zr830AjHaaOGxllm3Vp
         Ij3A==
X-Forwarded-Encrypted: i=1; AJvYcCWNor9n/JGLNtMkIzEoDgL1r+NYdRdURXV1b7PQpR3SDsbHQqQIDD4Zw+YVrud2nV9EQ92FFiHaqAuXPS7MULCh@vger.kernel.org
X-Gm-Message-State: AOJu0YwvQfTSL73TNw/HEwc4gNLIUwTANX4qCOxvd/hGT2Z9N0nD65zd
	6BINpc8dzumQVLK8iKvfGoa3bIJvOwRnxsgwbtYM6UL1Z68/AIAM7K8kkwy5xB4CqerLfoxEuGs
	rR5yfJK7ZaA==
X-Received: from dlzz34.prod.google.com ([2002:a05:7022:4a2:b0:123:35cc:b60f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:92a:b0:122:3a5:fc42
 with SMTP id a92af1059eb24-1276ad16d7fmr5344712c88.20.1771943390102; Tue, 24
 Feb 2026 06:29:50 -0800 (PST)
Date: Tue, 24 Feb 2026 06:29:30 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
Message-ID: <20260224142938.26088-1-irogers@google.com>
Subject: [RFC PATCH v1 0/7] perf libunwind multiple remote support
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Blake Jones <blakejones@google.com>, Tomas Glozar <tglozar@redhat.com>, 
	Yuzhuo Jing <yuzhuo@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Shimin Guo <shimin.guo@skydio.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Chun-Tse Shao <ctshao@google.com>, Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, Thomas Richter <tmricht@linux.ibm.com>, 
	libunwind-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"

Refactor the libunwind support so that whenever a remote target is
available, perf functions using the ELF machine can use that remote
target regardless of what the host/local machine is. Migrate existing
libunwind supported architectures like powerpc, arm64 and loongarch so
that they can work in a cross-architecture way. Add support for
RISC-V. Make the code more regular in function names, etc. and avoid
including a C-file. This increases the lines of code. It is similar in
style to the unwind-libdw implementation. It is hoped that the more
uniform nature of the code with help with refactoring the perf
registers for SIMD/APX support.

Aside from local host testing these patches are under tested, in part
as I'm failing to see how to build libunwind with support for multiple
remote targets. Please could I get help in testing, hence this being
an RFC.

Ian Rogers (7):
  tools build: Deduplicate test-libunwind for different architectures
  perf build: Be more programmatic when setting up libunwind variables
  perf build loongarch: Remove reference to missing file
  perf unwind-libunwind: Make libunwind register reading cross platform
  perf unwind-libunwind: Move flush/finish access out of local
  perf unwind-libunwind: Remove libunwind-local
  perf unwind-libunwind: Add RISC-V libunwind support

 tools/build/feature/Makefile                  |  38 +-
 tools/build/feature/test-libunwind-aarch64.c  |  27 -
 tools/build/feature/test-libunwind-arm.c      |  28 -
 .../test-libunwind-debug-frame-aarch64.c      |  17 -
 .../feature/test-libunwind-debug-frame-arm.c  |  17 -
 .../feature/test-libunwind-debug-frame.c      |   1 -
 tools/build/feature/test-libunwind-x86.c      |  28 -
 tools/build/feature/test-libunwind-x86_64.c   |  28 -
 tools/build/feature/test-libunwind.c          |   1 -
 tools/perf/Makefile.config                    | 215 ++---
 tools/perf/arch/arm/util/Build                |   2 -
 tools/perf/arch/arm/util/unwind-libunwind.c   |  50 --
 tools/perf/arch/arm64/util/Build              |   1 -
 tools/perf/arch/arm64/util/unwind-libunwind.c |  17 -
 tools/perf/arch/loongarch/util/Build          |   3 -
 .../arch/loongarch/util/unwind-libunwind.c    |  82 --
 tools/perf/arch/mips/Build                    |   1 -
 tools/perf/arch/mips/util/Build               |   1 -
 tools/perf/arch/mips/util/unwind-libunwind.c  |  22 -
 tools/perf/arch/powerpc/util/Build            |   1 -
 .../perf/arch/powerpc/util/unwind-libunwind.c |  92 --
 tools/perf/arch/x86/util/Build                |   3 -
 tools/perf/arch/x86/util/unwind-libunwind.c   | 115 ---
 tools/perf/util/Build                         |   4 +-
 tools/perf/util/libunwind-arch/Build          |  11 +
 .../perf/util/libunwind-arch/libunwind-arch.c | 319 +++++++
 .../perf/util/libunwind-arch/libunwind-arch.h | 296 +++++++
 .../perf/util/libunwind-arch/libunwind-arm.c  | 290 ++++++
 .../util/libunwind-arch/libunwind-arm64.c     | 289 ++++++
 .../perf/util/libunwind-arch/libunwind-i386.c | 312 +++++++
 .../util/libunwind-arch/libunwind-loongarch.c | 297 +++++++
 .../perf/util/libunwind-arch/libunwind-mips.c | 299 +++++++
 .../util/libunwind-arch/libunwind-ppc32.c     | 301 +++++++
 .../util/libunwind-arch/libunwind-ppc64.c     | 303 +++++++
 .../util/libunwind-arch/libunwind-riscv.c     | 297 +++++++
 .../perf/util/libunwind-arch/libunwind-s390.c | 299 +++++++
 .../util/libunwind-arch/libunwind-x86_64.c    | 320 +++++++
 tools/perf/util/libunwind/arm64.c             |  40 -
 tools/perf/util/libunwind/x86_32.c            |  41 -
 tools/perf/util/maps.c                        |  29 +-
 tools/perf/util/maps.h                        |   4 +-
 tools/perf/util/thread.c                      |  29 +-
 tools/perf/util/unwind-libunwind-local.c      | 832 ------------------
 tools/perf/util/unwind-libunwind.c            | 677 ++++++++++++--
 tools/perf/util/unwind.h                      |  13 +-
 45 files changed, 4389 insertions(+), 1703 deletions(-)
 delete mode 100644 tools/build/feature/test-libunwind-aarch64.c
 delete mode 100644 tools/build/feature/test-libunwind-arm.c
 delete mode 100644 tools/build/feature/test-libunwind-debug-frame-aarch64.c
 delete mode 100644 tools/build/feature/test-libunwind-debug-frame-arm.c
 delete mode 100644 tools/build/feature/test-libunwind-x86.c
 delete mode 100644 tools/build/feature/test-libunwind-x86_64.c
 delete mode 100644 tools/perf/arch/arm/util/unwind-libunwind.c
 delete mode 100644 tools/perf/arch/arm64/util/unwind-libunwind.c
 delete mode 100644 tools/perf/arch/loongarch/util/unwind-libunwind.c
 delete mode 100644 tools/perf/arch/mips/Build
 delete mode 100644 tools/perf/arch/mips/util/Build
 delete mode 100644 tools/perf/arch/mips/util/unwind-libunwind.c
 delete mode 100644 tools/perf/arch/powerpc/util/unwind-libunwind.c
 delete mode 100644 tools/perf/arch/x86/util/unwind-libunwind.c
 create mode 100644 tools/perf/util/libunwind-arch/Build
 create mode 100644 tools/perf/util/libunwind-arch/libunwind-arch.c
 create mode 100644 tools/perf/util/libunwind-arch/libunwind-arch.h
 create mode 100644 tools/perf/util/libunwind-arch/libunwind-arm.c
 create mode 100644 tools/perf/util/libunwind-arch/libunwind-arm64.c
 create mode 100644 tools/perf/util/libunwind-arch/libunwind-i386.c
 create mode 100644 tools/perf/util/libunwind-arch/libunwind-loongarch.c
 create mode 100644 tools/perf/util/libunwind-arch/libunwind-mips.c
 create mode 100644 tools/perf/util/libunwind-arch/libunwind-ppc32.c
 create mode 100644 tools/perf/util/libunwind-arch/libunwind-ppc64.c
 create mode 100644 tools/perf/util/libunwind-arch/libunwind-riscv.c
 create mode 100644 tools/perf/util/libunwind-arch/libunwind-s390.c
 create mode 100644 tools/perf/util/libunwind-arch/libunwind-x86_64.c
 delete mode 100644 tools/perf/util/libunwind/arm64.c
 delete mode 100644 tools/perf/util/libunwind/x86_32.c
 delete mode 100644 tools/perf/util/unwind-libunwind-local.c

-- 
2.53.0.371.g1d285c8824-goog

