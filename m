Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F5933F5B9
	for <linux-perf-users@vger.kernel.org>; Sat,  4 Apr 2026 05:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775281248; cv=none; b=DumpgzhXzbUwR0dEhDFnCIUHze617ALIeBkM34gE6XnZn9bgkMBKC2xvmCScnVIqxD8B87Au5ojmHt6QDM0dOPWBsvTCY2Wi0KiGlb6KIRiS33wG3RCET/B6zOSC4DrDtOd48tgX9YSb1DVPOEhfpDoq0lMQV6v0DHnMEOJce7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775281248; c=relaxed/simple;
	bh=7VeT1c8nby4ChJMqQV7geWi1+ejwIUQZ8RKfPdROmWM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Kd4fPvV4yv5pEKoYvy78Pdd2yVvE/reJjoPE2QuoY7BPQHhzS8RBwVu0IJnGgMNyrg1o/RywbWVZNBf/l0nsg4AVrBgJPCJnnPDBi8fHmkfoiUA8J8liqAxPeFH7cARQETzw9I5uWYebMEPhtTwN/ZhEqDNOh/w+VoMsGwonwtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lvm36KLk; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lvm36KLk"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bdf75bc88fso3127837eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Apr 2026 22:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775281246; x=1775886046; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q0bWS7IQWf/pTrd7yQAODT3hHm6x/5r6ulA0C6sdgYw=;
        b=lvm36KLkKGrMIzR8sbfGLWmguSkmEXtjfIVEXDcLWjwGp5/voftvvvgHFDQ4SJ7VFv
         yX8TUcktrQkaQKJvNDC6VbH8af4NROC6zHDT6uMKFV6j9rq9qDfjQWuRYcSbs2u4bzVS
         sGOvB+tibTU1HHyR+F9qVrFcxp3waJdyZpEG4RuCeMvQsFLxTcuKPYTlVGu1+xh++CaB
         MxzNa5ROMqD0BrzWDoLTA7VnOaUaPKXjXd49EGjAqtIuOVTX4pOP6+uquFgWCKr+hxDL
         C/fSZHtiCyicoR944Sl6qPBApxk4++pL7G8b2HMPGLNZi1RIrJLAaDNpaHC6aD4lHqVv
         e60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775281246; x=1775886046;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q0bWS7IQWf/pTrd7yQAODT3hHm6x/5r6ulA0C6sdgYw=;
        b=LrPYlVQJxJ3ntpJsDeLynCM+8UZddF4DbJLtUOG7+SbiKpjLcQy23iBZ2sGi4/U6SO
         6se4u6Uch+X+LentZvJWKBCDDJlYJZuADJdQHfgV3a3zRzcvnf7dNSVq5yF7GV2j/rzI
         XdQZs5iMGYTmjUgAe/W1ecmppifCp1/pfZQOQy6wM4RswwjfJIqKy3XLVAMcUH0Pq8OJ
         31xoXX6G+obPe787jbVKWPDUfi9xqpAaQurDyzKwRer72aP/Wo+ctDQrmfgJOKGiDDET
         Ay7lf5hDhToY2U61tPKEwLo32mAGrOVj2kTK8YdrqE7Vk2xMbdlmNNQTZkwo+oqt9bvZ
         p7aA==
X-Forwarded-Encrypted: i=1; AJvYcCVvAVgF6QWlDycqCialml+fnJ3McDxsfpXTnnqRJYGlUGXdLycYot+UBEMM5Z4vHIzxg1NQ2r8SBLhkO8P6Dgtm@vger.kernel.org
X-Gm-Message-State: AOJu0YyafcH2mJAvgmczFLC2i7CN/0HKGfya6a76rk0mvEg+t/Z1mfUU
	JG/PfsyjhI+5fRkUcY55nRXRAI5SqiYSupM3Iq/EwxrAHJCb+LZQ3SB0s+TxCyXOfUYmjooFZBH
	BX1d8qw3D7Q==
X-Received: from dybmx6.prod.google.com ([2002:a05:7300:d406:b0:2c1:5b29:d58f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:3005:b0:2ca:2f21:64da
 with SMTP id 5a478bee46e88-2cbf6a8e179mr2811537eec.0.1775281246342; Fri, 03
 Apr 2026 22:40:46 -0700 (PDT)
Date: Fri,  3 Apr 2026 22:40:24 -0700
In-Reply-To: <20260305221927.3237145-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260305221927.3237145-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260404054032.1538095-1-irogers@google.com>
Subject: [PATCH v3 0/8] perf libunwind multiple remote support
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org
Cc: irogers@google.com, 9erthalion6@gmail.com, adrian.hunter@intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	andrew.jones@oss.qualcomm.com, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, 
	blakejones@google.com, ctshao@google.com, dapeng1.mi@linux.intel.com, 
	howardchu95@gmail.com, james.clark@linaro.org, john.g.garry@oracle.com, 
	jolsa@kernel.org, leo.yan@linux.dev, libunwind-devel@nongnu.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org, 
	mingo@redhat.com, namhyung@kernel.org, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, shimin.guo@skydio.com, 
	tglozar@redhat.com, tmricht@linux.ibm.com, will@kernel.org, yuzhuo@google.com
Content-Type: text/plain; charset="UTF-8"

Fix the libunwind build for when libdw and libunwind are feature
detected, currently failing with a duplicate symbol.

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
remote targets. Please could I get help in testing.

v3: Minor whitespace clean up and warn when a dynamic choice of libdw
    or libunwind is selected for unwinding and support is missing (Arnaldo).

v2: Move two fixes patches to position 1 and 2 in the series. Fix
    struct naming inconsistency, Andrew Jones
    <andrew.jones@oss.qualcomm.com>. Fix other inconsistencies and
    potential non-x86 build issues.
https://lore.kernel.org/lkml/20260305221927.3237145-1-irogers@google.com/

v1: https://lore.kernel.org/lkml/20260224142938.26088-1-irogers@google.com/

Ian Rogers (8):
  perf unwind: Refactor get_entries to allow dynamic libdw/libunwind
    selection
  perf build loongarch: Remove reference to missing file
  tools build: Deduplicate test-libunwind for different architectures
  perf build: Be more programmatic when setting up libunwind variables
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
 tools/perf/builtin-inject.c                   |   4 +
 tools/perf/builtin-report.c                   |   4 +
 tools/perf/builtin-script.c                   |   4 +
 tools/perf/util/Build                         |   5 +-
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
 tools/perf/util/symbol_conf.h                 |  10 +
 tools/perf/util/thread.c                      |  29 +-
 tools/perf/util/unwind-libdw.c                |   2 +-
 tools/perf/util/unwind-libunwind-local.c      | 832 ------------------
 tools/perf/util/unwind-libunwind.c            | 679 ++++++++++++--
 tools/perf/util/unwind.c                      |  98 +++
 tools/perf/util/unwind.h                      |  77 +-
 51 files changed, 4549 insertions(+), 1732 deletions(-)
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
 create mode 100644 tools/perf/util/unwind.c

-- 
2.53.0.1213.gd9a14994de-goog

