Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD2A38736F;
	Fri,  9 Oct 2026 03:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791516462; cv=none; b=U4zwfg3k4lu8jCOslT6X8csUiIgR6cdNJtg5/Ba3w/IGmMa0IQqp6QQx3CrH3n44mptL/ux5sJd7nOzeQovcbQzmaK2gxSLhRqEDLBmTMw0y1O0xySQbG7Chkhip0l81xUNFsbaZ4YxqDXi29VMOYCUSZ7SOAHzy/Qatevkr3pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791516462; c=relaxed/simple;
	bh=F0R042ImaTk4A50eVJ5n1fMfRcnascuHs0g0yudcPy4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=go7CX1+Fn1kHdS0lcyn+PYdx6x3d46PKTnXA5IVpmlyNwSR5clvGY1iijP/ikBMD/RAC6SWFRYjGBhaUIVF8idFAOo1xQFdLpjwyAGsgbfpDUicJE+Kw0/fbX78IXu+pEu/SahAovixXAxJpF02KVQOH+TOlX34WFhftjmGQ3zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RavHdLXO; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RavHdLXO"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1791516442; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=yEryO6q/rSnNf7cAisuB4DggIjqAxg4m34Zq90Y4CtY=;
	b=RavHdLXOAPA40FYTIiclSUABwfIn0k6bwKgufVJZwchocNPs8tnMIltXOGucgPuYP/v3W560gLoq5HUL8s7jMkExXwka/0eFc6E/zR0NlKgxdifjGxTC2UgS2Lg3XZ59LaVMH949EiwqJ//7oNV7ywBi5sHsq3ZuJMfVy1pjVbs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0XCS-sIR_1791516435;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XCS-sIR_1791516435 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 09 Oct 2026 11:27:20 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: acme@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	namhyung@kernel.org
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	leo.yan@linux.dev,
	john.g.garry@oracle.com,
	will@kernel.org,
	mike.leach@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	guoren@kernel.org,
	anup@brainfault.org,
	david.laight.linux@gmail.com,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] perf riscv: Implement rdtsc()
Date: Fri,  9 Oct 2026 11:27:13 +0800
Message-ID: <20261009032715.2841-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tools/perf falls back to the __weak rdtsc() stub in tools/perf/util/tsc.c
on every architecture that does not override it, riscv included.  The
stub returns a constant 0, so anything that reaches for the counter gets
a value that means nothing and cannot tell it apart from a counter that
happens to be at 0.

The time CSR is a natural TSC equivalent on riscv: readable from user
mode, constant frequency, and the same counter that riscv's
arch_perf_update_userpage() feeds the user page conversion fields from,
ever since commit 83c5e13b8cbb ("riscv: Prepare for user-space perf
event mmap support").  This series registers that on the tools side.

The two patches are split so that the first stands on its own:

1. Implement rdtsc() over the time CSR for riscv64.

2. Have the build system say which architectures have a usable counter,
   instead of a list of compiler macros inside the test.

What this is worth beyond the subtest result:

1. The subtest is the only reader of those conversion fields riscv
   can run, so it guards arithmetic that has shipped unexercised;
   registering the counter at the same time leaves a future riscv
   auxtrace driver the reading and the conversion already in place.

2. The flag lets a caller ask whether the architecture has a counter
   before it uses the value, without keeping its own copy of a list
   that has to be edited every time an architecture grows an
   implementation.

Changes since v2:
- Key off IS_BUILTIN(HAVE_RDTSC), with <tools/config.h> included, instead
  of an #ifndef block, as Adrian Hunter suggested.
- Collected the tags received on v2.

Changes since v1:
- Define rdtsc() for RV64 only. RV32 now keeps the weak stub.
- Declare the capability through the build system rather than through a
  weak arch__rdtsc_supported() hook, following the PERF_HAVE_JITDUMP
  pattern, as Leo Yan suggested.

Tests:
======
- Build side, this version: the compile command of
  tests/perf-time-to-tsc.o carries -DHAVE_RDTSC on riscv64, arm64 and the
  x86_64 host, and does not on riscv32, so RV32 stays on the weak stub.
- Same object built on the host with and without the flag: with it the
  "TSC support" subtest returns TEST_OK with the skip branch folded out,
  without it the pr_debug and the TEST_SKIP branch are still there.  That
  is the branch the #ifndef used to pick, so the change is behaviour
  preserving.
- riscv64 QEMU virt guest with sscofpmf, as reported on v2: before the
  series the "TSC support" subtest skips and the conversion subtest fails
  while comparing against the stub's constant 0; after, both report Ok.
  Patch 1 is unchanged here and the subtest decision is behaviour
  preserving, so v3 was verified on the build side only.

Chen Pei (2):
  perf riscv: Implement rdtsc()
  perf tsc: Declare TSC support from the build system

 tools/perf/Makefile.config          |  4 ++++
 tools/perf/arch/arm64/Makefile      |  1 +
 tools/perf/arch/riscv/Makefile      |  1 +
 tools/perf/arch/riscv/util/Build    |  1 +
 tools/perf/arch/riscv/util/tsc.c    | 27 +++++++++++++++++++++++++++
 tools/perf/arch/x86/Makefile        |  1 +
 tools/perf/tests/perf-time-to-tsc.c | 14 ++------------
 7 files changed, 37 insertions(+), 12 deletions(-)
 create mode 100644 tools/perf/arch/riscv/util/tsc.c

-- 
2.50.1

