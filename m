Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5885D1A6822
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Mar 2026 23:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774136546; cv=none; b=c6Ir2JHb8JBeqDKS3T65ISz//AEILeltan4SEQ0+jfQZNKbmEhr+KNXoQ6YGggZKHwfl55ulhlSzzKQvD078Acz1pl62ghhyFlFMsIzd3nE9pVs050xrwVw5kXOAEY2kDOU1pmPQlDSjdBIe3vjit1BktzLJ/Ftsq9C1atDQTIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774136546; c=relaxed/simple;
	bh=d1IWVIrAYuDDTvF3d233KLrqD3z0W/n2VvTdJW/m9kA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bxaWbL8XMZouHQRd7PW2krklXQ4Gbbtg2he6tf7/5j/RM+4RBa2FRHNSVD51XypPE4RPf/d6AAuDcVEF8fYCPNAXkFoqLzgtU21/au6Ny27mCzYCBa2+lRB2ge8nDkQ7nJ0CipD5ZycT54qLeO4d4EcipJsqMYqk4btLr3s5IBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FL8caxej; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FL8caxej"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c0bddb9196so1822025eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 21 Mar 2026 16:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774136543; x=1774741343; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oTqCrTpO7xpe1pD5iEi4pz4O5z12UvBG8QJ70CExaM8=;
        b=FL8caxejuNgEUySbHiHBMUwFOVfKrMOdYYUP8RYyThuzA2kbJ58A0UyZ6FdzFhAf2a
         PN4UySFf1o6Vh6jFGWzW88XEJjC3Tl9NP3qbVzJB00hXPrbQiStR/gYCvmAT1umWGPy9
         4r1uBGDiISn5ETUWOZ7fVYPPv5jBPeuMtdms01+vHDqPx/gvYJn967TdBXJh63r3t340
         IvdssJiRpbai1/wtos9WzFCpmW/EUcyOVDNrt69JXNFqQ++7fqqrm9rk16GB0IuHxrRB
         1mpjR9sG1KMCVR6rLXh0p7cqHStv/msTRNQoO/5onMjfus7yprWb0Ch3Rdf32oR8FdNR
         su2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774136543; x=1774741343;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oTqCrTpO7xpe1pD5iEi4pz4O5z12UvBG8QJ70CExaM8=;
        b=OXgHXYE1EEs/Kafw+/0YoWTnxu3eXqyhBrHQG3ZucDJL7cbYfL4eFcViKuLJAoB6xk
         WxlAeEGxCg6D9lM4UJISoft3jp1X+vUHKl79Wl6stm4XU1zJ2uPV8Orq/amt7aHhhQ1B
         I0DXrrLCtMk6neJVJLSi8y5EP7R0YfofUizpfGDlfIM4oynFI13S7WGUoGSExWJvI73k
         tg7i+LDz2xOQ4KFjMK4SdTaHNCTO0lobhnOCrmA7NurJq2/uO/9z9qjS18ZLHP/m85ZM
         FWVQYR4m38EqzCCbF/oaTWkBd3oaVGb44FsUFeHzUlalsU++4uIkVOn+A3uMTXW8qfHC
         hDhA==
X-Forwarded-Encrypted: i=1; AJvYcCVHk/3jn4SU4FekoMixEaSn+Z63fGrHaAorVjUx5TcjekCS34iNNlPrGWGBzOdzkn1CuqhCWa0FATmoPcD6wTLt@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9c9FBmIcFtHqenEonpWxxj3slc7YmGgV6W53ekqf4Rt5KCRC1
	vLL0QTDv3G1x/o++fWiQ9bIBGjscC5oVjrxEaY3DLtX+pV0I3XYbb4Vlw7PetpJFDDgLvj16u1Z
	4mg/Vk8cOwg==
X-Received: from dykh34.prod.google.com ([2002:a05:7300:5722:b0:2be:70ac:88ad])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:5721:b0:2b7:a27f:3a6a
 with SMTP id 5a478bee46e88-2c109566b73mr3437476eec.4.1774136543007; Sat, 21
 Mar 2026 16:42:23 -0700 (PDT)
Date: Sat, 21 Mar 2026 16:42:18 -0700
In-Reply-To: <abxs-2rozL1tBEO1@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <abxs-2rozL1tBEO1@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260321234220.848859-1-irogers@google.com>
Subject: [PATCH v1 0/2] perf build: Remove libunwind support
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: 9erthalion6@gmail.com, acme@kernel.org, adrian.hunter@intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	andrew.jones@oss.qualcomm.com, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, 
	blakejones@google.com, ctshao@google.com, dapeng1.mi@linux.intel.com, 
	howardchu95@gmail.com, irogers@google.com, james.clark@linaro.org, 
	john.g.garry@oracle.com, jolsa@kernel.org, leo.yan@linux.dev, 
	libunwind-devel@nongnu.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-riscv@lists.infradead.org, mingo@redhat.com, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, shimin.guo@skydio.com, 
	tglozar@redhat.com, tmricht@linux.ibm.com, will@kernel.org, amadio@gentoo.org, 
	yuzhuo@google.com
Content-Type: text/plain; charset="UTF-8"

libunwind support exists for "--call-graph dwarf", however, libunwind
support has been opt-in rather than opt-out since Linux v6.13 as libdw
is preferred - commit 13e17c9ff49119aa ("perf build: Make libunwind
opt-in rather than opt-out"). A problem with the libdw support was
that it was slow, an issue fixed in Linux v7.0 in commit 6b2658b3f36a
("perf unwind-libdw: Don't discard loaded ELF/DWARF after every
unwind"). As such libunwind support is now unnecessary.

The patch series:
https://lore.kernel.org/lkml/20260305221927.3237145-1-irogers@google.com/
looked to make the libunwind support in perf similar to the libdw
support, allow cross-architecture unwinding, etc. This was motivated
by the perf regs conventions being altered by the addition of x86 APX
support:
https://lore.kernel.org/lkml/20260209072047.2180332-1-dapeng1.mi@linux.intel.com/
It is necessary to translate the library's notion of registers to the
perf register convention so that the stack unwinding state can be
initialized. On this series it was stated that removing libunwind
support from perf should be an option, rather than updating support:
https://lore.kernel.org/lkml/abxs-2rozL1tBEO1@google.com/
This was also what motivated making libunwind opt-in rather than
opt-out.

Given that 7 minor releases have happened with libunwind "deprecated"
by making it opt-in, let's remove the libunwind support. There doesn't
appear to be any disagreement to this on the mailing list.

Ian Rogers (2):
  perf build: Remove libunwind support
  tools build: Remove libunwind feature tests

 tools/build/feature/Makefile                  |  31 -
 tools/build/feature/test-libunwind-aarch64.c  |  27 -
 tools/build/feature/test-libunwind-arm.c      |  28 -
 .../test-libunwind-debug-frame-aarch64.c      |  17 -
 .../feature/test-libunwind-debug-frame-arm.c  |  17 -
 .../feature/test-libunwind-debug-frame.c      |  17 -
 tools/build/feature/test-libunwind-x86.c      |  28 -
 tools/build/feature/test-libunwind-x86_64.c   |  28 -
 tools/build/feature/test-libunwind.c          |  28 -
 tools/perf/Documentation/perf-check.txt       |   1 -
 tools/perf/Documentation/perf-config.txt      |   4 +-
 tools/perf/Documentation/perf-record.txt      |   2 +-
 tools/perf/Makefile.config                    | 163 +---
 tools/perf/Makefile.perf                      |   3 -
 tools/perf/arch/arm/util/Build                |   1 -
 tools/perf/arch/arm/util/unwind-libunwind.c   |  50 --
 tools/perf/arch/arm64/util/Build              |   1 -
 tools/perf/arch/arm64/util/unwind-libunwind.c |  17 -
 tools/perf/arch/loongarch/util/Build          |   1 -
 .../arch/loongarch/util/unwind-libunwind.c    |  82 --
 tools/perf/arch/mips/util/Build               |   1 -
 tools/perf/arch/mips/util/unwind-libunwind.c  |  22 -
 tools/perf/arch/powerpc/util/Build            |   1 -
 .../perf/arch/powerpc/util/unwind-libunwind.c |  92 --
 tools/perf/arch/x86/util/Build                |   1 -
 tools/perf/arch/x86/util/unwind-libunwind.c   | 115 ---
 tools/perf/builtin-check.c                    |   1 -
 tools/perf/builtin-report.c                   |   4 +-
 tools/perf/tests/make                         |   2 -
 tools/perf/util/Build                         |   5 -
 tools/perf/util/callchain.c                   |   2 +-
 tools/perf/util/dso.h                         |   6 -
 tools/perf/util/libunwind/arm64.c             |  40 -
 tools/perf/util/libunwind/x86_32.c            |  41 -
 tools/perf/util/maps.c                        |  47 +-
 tools/perf/util/maps.h                        |   6 -
 tools/perf/util/thread.c                      |  40 +-
 tools/perf/util/thread.h                      |   1 -
 tools/perf/util/unwind-libunwind-local.c      | 832 ------------------
 tools/perf/util/unwind-libunwind.c            |  92 --
 tools/perf/util/unwind.h                      |  41 +-
 41 files changed, 19 insertions(+), 1919 deletions(-)
 delete mode 100644 tools/build/feature/test-libunwind-aarch64.c
 delete mode 100644 tools/build/feature/test-libunwind-arm.c
 delete mode 100644 tools/build/feature/test-libunwind-debug-frame-aarch64.c
 delete mode 100644 tools/build/feature/test-libunwind-debug-frame-arm.c
 delete mode 100644 tools/build/feature/test-libunwind-debug-frame.c
 delete mode 100644 tools/build/feature/test-libunwind-x86.c
 delete mode 100644 tools/build/feature/test-libunwind-x86_64.c
 delete mode 100644 tools/build/feature/test-libunwind.c
 delete mode 100644 tools/perf/arch/arm/util/unwind-libunwind.c
 delete mode 100644 tools/perf/arch/arm64/util/unwind-libunwind.c
 delete mode 100644 tools/perf/arch/loongarch/util/unwind-libunwind.c
 delete mode 100644 tools/perf/arch/mips/util/unwind-libunwind.c
 delete mode 100644 tools/perf/arch/powerpc/util/unwind-libunwind.c
 delete mode 100644 tools/perf/arch/x86/util/unwind-libunwind.c
 delete mode 100644 tools/perf/util/libunwind/arm64.c
 delete mode 100644 tools/perf/util/libunwind/x86_32.c
 delete mode 100644 tools/perf/util/unwind-libunwind-local.c
 delete mode 100644 tools/perf/util/unwind-libunwind.c

-- 
2.53.0.959.g497ff81fa9-goog

