Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF512BEC34;
	Tue, 29 Sep 2026 03:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790653310; cv=none; b=sK/PSK+N0tm1g4fCOtNkLIv3gN/GnguZ4+EXLqj8jXP4HMlV0aSOQ026pLCeq5IAyRRifl9Xn9MMXfP5ojV/JKAZbrB1rzwKGnS379NjXh2KDCV1dI8/Hf4H3usj/7FbbNbu4jW/iuhLHwQC06IP3jK2MpVYTcc/r75Sfzlw8pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790653310; c=relaxed/simple;
	bh=XtC2PpTUqFiwER6avxQuNzIDluVCAxWNcbGY59pPVHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YbeHq2oq6f0l6C127sUTF7SVFaxKL/u5n94IvzDPSXDCw3ZuHUD2OMhhPMCKGb8DIgdC62ZMXIZSogdLP8BUmLYqsGecbNCJC0pQvlND6z9Q0KIA5v9z4g08SBg5wOlB/NTaNOx7sEvQAfPx/YjYUlvyafGrCvVZ52QUWBMC990=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GMV9XxXG; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GMV9XxXG"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1790653298; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=nAu9I11wCZbEgfjoBBQOuGXm3l1adZEVZbodMdFHRcA=;
	b=GMV9XxXGhunyLWbLkLyHvk5t2HqyGidpsgcYFfEjVi5JOmL8zHWBi9tvPdNFVviTahPhJdAtlBq+BiIyfzkAOehVxpphWszB6l5q6wKtcZ9H5TX5SIQa1ZdJN23cASV8fZofAgmMn2mnEu+qKQ7rgNGAsCQIHu+QEYYC1B0aUCE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0XBrsV8l_1790653293;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XBrsV8l_1790653293 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 29 Sep 2026 11:41:37 +0800
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
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] perf riscv: Implement rdtsc()
Date: Tue, 29 Sep 2026 11:41:31 +0800
Message-ID: <20260929034133.2153-1-cp0613@linux.alibaba.com>
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

Changes since v1:
- Define rdtsc() for RV64 only. RV32 now keeps the weak stub.
- Declare the capability through the build system rather than through a
  weak arch__rdtsc_supported() hook, following the PERF_HAVE_JITDUMP
  pattern, as Leo Yan suggested.

Tests:
======
- riscv64 QEMU virt guest with sscofpmf, comparing the build before the
  series with the build after it: before, the "TSC support" subtest skips
  and the conversion subtest fails while comparing against the stub's
  constant 0; after, both report Ok.
- riscv64 and riscv32 cross builds: the compile command of
  tests/perf-time-to-tsc.o carries -DHAVE_RDTSC on rv64 and not on
  rv32, so RV32 stays on the weak stub.
- x86_64 host and arm64 cross builds: -DHAVE_RDTSC is in effect for
  both, and on the host the "TSC support" subtest still reports Ok.

Chen Pei (2):
  perf riscv: Implement rdtsc()
  perf tsc: Declare TSC support from the build system

 tools/perf/Makefile.config          |  4 ++++
 tools/perf/arch/arm64/Makefile      |  1 +
 tools/perf/arch/riscv/Makefile      |  1 +
 tools/perf/arch/riscv/util/Build    |  1 +
 tools/perf/arch/riscv/util/tsc.c    | 27 +++++++++++++++++++++++++++
 tools/perf/arch/x86/Makefile        |  1 +
 tools/perf/tests/perf-time-to-tsc.c | 19 ++++---------------
 7 files changed, 39 insertions(+), 15 deletions(-)
 create mode 100644 tools/perf/arch/riscv/util/tsc.c

-- 
2.50.1

