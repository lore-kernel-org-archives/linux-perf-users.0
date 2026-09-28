Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DEF4734F3;
	Mon, 28 Sep 2026 09:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790588882; cv=none; b=Dp4rPQzijJ89a7eKH/tcCxmWvoS44zxLzD/OBr9yNNkprrOF1TLYhsON+ZwF0t9BZTghp3nXsvziip3ybFTchB+Z7+kmjjavb8tPnljNZhxE9pYQYXhnLwJKwBfLxlR2wvsssIxWVdtWILzJYwrJcpYELSkNjNJ29w3ss4JLcZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790588882; c=relaxed/simple;
	bh=5b18Ty9UFVLwooMLI6zBNF1EFrPs1maBNemN2hj5/FE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iKV8pueVONOUDlVljMQKkg8S7isugKRrGazzrLVLO1yLYOUTaBmFBkisdczEARhzBotshINH8K7clCLkiNK28+AmxVS2MRiWxLQnln0eD0Qxa5jOz/uVmV/3PUJZkdLCEImCdqJuAhOHw+1TEzDmgYtRzgl3DRDEbbZdP1I99+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=h/GLixwK; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="h/GLixwK"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1790588865; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=EMqR6vKqG0eu05A9NobGOudkspzGkyf5Myx8wtsS/mc=;
	b=h/GLixwKtVEJnsNZvjgtVnvFxdgxmJotz3Kf1VYdIIemaS2HpupGq88aaWDiWvTts4oH5/lak7qu6gLWWmxUZnF8whgREoN0So7R7p7FEpnA3SwnWbLF95UkIgKtL58xo+xl0ywAl8x89kVgQs/YKpsEOfLwC4nhZ4+Cq2oEEzQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0XBlsELq_1790588859;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XBlsELq_1790588859 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 28 Sep 2026 17:47:44 +0800
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
Subject: [PATCH 0/2] perf riscv: Implement rdtsc()
Date: Mon, 28 Sep 2026 17:47:37 +0800
Message-ID: <20260928094739.2605-1-cp0613@linux.alibaba.com>
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

1. Implement rdtsc() over the time CSR for riscv.

2. Replace the compile-time TSC support check with a weak
   arch__rdtsc_supported() hook, so that support is declared next to
   the rdtsc() it describes rather than in the central list of compiler
   macros.

What this is worth beyond the subtest result:

1. The subtest is the only reader of those conversion fields riscv
   can run, so it guards arithmetic that has shipped unexercised;
   registering the counter at the same time leaves a future riscv
   auxtrace driver the reading and the conversion already in place.

2. The hook gives a caller something to ask the architecture before
   it uses the counter value, instead of each caller keeping its own
   copy of the macro list.

Tests:
======
- The "Convert perf time to TSC" test in a riscv64 QEMU virt guest
  with sscofpmf: the subtest skips before the series, passes after it.
- With the riscv implementation left out of the build, so that the
  weak defaults are in effect, the subtest still skips: the behaviour
  of an architecture without a counter is unchanged.

Chen Pei (2):
  perf riscv: Implement rdtsc()
  perf tsc: Replace the compile-time TSC support check with a weak hook

 tools/perf/arch/arm64/util/tsc.c    |  5 +++++
 tools/perf/arch/riscv/util/Build    |  1 +
 tools/perf/arch/riscv/util/tsc.c    | 24 ++++++++++++++++++++++++
 tools/perf/arch/x86/util/tsc.c      |  5 +++++
 tools/perf/tests/perf-time-to-tsc.c | 12 +-----------
 tools/perf/util/tsc.c               |  9 +++++++++
 tools/perf/util/tsc.h               |  1 +
 7 files changed, 46 insertions(+), 11 deletions(-)
 create mode 100644 tools/perf/arch/riscv/util/tsc.c

-- 
2.50.1

