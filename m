Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6163E120E;
	Tue, 29 Sep 2026 03:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790653326; cv=none; b=tZ3WruIxOBdjzPDZY2TVHOrETwTWckjWSng79uTV6ydIHLkOfcdgcARbWz1WW107250/tgAxB1ixsdQlYlZBcY6SsYEBISkq0740kW/i6HYuOyf9xb6o8r7XaWOYHCL4QCZa3cIcGrGiQI4hirW0kpVE/BUX5BE+mw92MEEn0Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790653326; c=relaxed/simple;
	bh=TuZ7psFucdWVFwfwrolFJ39pHrG8NeYK+4YkV6w0ek8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s8DoaQ+10tcJYW16K5lgvqsSiSa/wecQnh+25zay/JGSQi1D61l0pnyP3dfNAOtS8e+CaBcFu/pL+KKzUvrrEAo67+SVCypxJaWb0cfM6va4xC6ejkmOX3DvPOc9CThZ9ftijYuGphWEMpoyNW5gt9Qw2j4Yi60l4XowcbmOd14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gvatITDK; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gvatITDK"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1790653301; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=fTGq35iqWxwugWo9PTY0ZSASRgU7CCPbN3hTCqx5nYQ=;
	b=gvatITDKeIOJ92ooi+X3j9hTZehMpVhgYmOhTCXqrEAODXOdkZSG3y/IjYBX19hQZeDNyUgKUN1Avz/E7fJ4ESwIVidqok2jL0gocd74hJ9HpA2TAzLYPUjPq8DT/FxFr9F27L3DChRkLy5T3YwP66nj3UsML0AvYzNVgfSQZqE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0XBrsVA-_1790653297;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XBrsVA-_1790653297 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 29 Sep 2026 11:41:39 +0800
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
	linux-kernel@vger.kernel.org,
	Anup Patel <anup@brainfault.org>
Subject: [PATCH v2 1/2] perf riscv: Implement rdtsc()
Date: Tue, 29 Sep 2026 11:41:32 +0800
Message-ID: <20260929034133.2153-2-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929034133.2153-1-cp0613@linux.alibaba.com>
References: <20260929034133.2153-1-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Perf has no riscv implementation of rdtsc(), so it links against the weak
stub in util/tsc.c and every caller reads a constant 0 that cannot be
told apart from a counter standing still.

Implement rdtsc() over the time CSR with rdtime.  The time CSR is a TSC
equivalent on riscv: readable from user mode, constant frequency, and the
same counter riscv's arch_perf_update_userpage() builds the user page
conversion fields from, so the counter and perf time share a timebase.

Define it for RV64 only.  Reading the counter whole on RV32 takes time and
timeh in a loop, and no RV32 user in tools/perf needs it that much, so
RV32 keeps the weak stub.

Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
Changes in v2:
- Define rdtsc() for RV64 only.

 tools/perf/arch/riscv/util/Build |  1 +
 tools/perf/arch/riscv/util/tsc.c | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 tools/perf/arch/riscv/util/tsc.c

diff --git a/tools/perf/arch/riscv/util/Build b/tools/perf/arch/riscv/util/Build
index 2328fb9a30a3..52cd6a481de8 100644
--- a/tools/perf/arch/riscv/util/Build
+++ b/tools/perf/arch/riscv/util/Build
@@ -1 +1,2 @@
 perf-util-y += header.o
+perf-util-y += tsc.o
diff --git a/tools/perf/arch/riscv/util/tsc.c b/tools/perf/arch/riscv/util/tsc.c
new file mode 100644
index 000000000000..3dd419ce9d2a
--- /dev/null
+++ b/tools/perf/arch/riscv/util/tsc.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/types.h>
+
+#include "../../../util/tsc.h"
+
+/*
+ * RV32 is left to the weak stub: reading the counter whole there takes time
+ * and timeh in a loop, and no RV32 user in tools/perf needs it that much.
+ */
+#if defined(__riscv) && __riscv_xlen == 64
+
+u64 rdtsc(void)
+{
+	u64 val;
+
+	/*
+	 * The time CSR ticks at a constant frequency and is the same counter
+	 * the kernel feeds into the user page conversion fields through
+	 * sched_clock(), so it is a TSC equivalent here.
+	 */
+	asm volatile("rdtime %0" : "=r" (val));
+
+	return val;
+}
+
+#endif
-- 
2.50.1

