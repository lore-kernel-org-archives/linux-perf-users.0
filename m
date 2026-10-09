Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC41D386571;
	Fri,  9 Oct 2026 03:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791516470; cv=none; b=CjimK5TWgfDEowQtU0ol5/j4cUm/bCMVGI8R1kdlcO/ODgFeHil+VgT5H7m0ly6ydAw4e20QjgOL3AWyJ6MFleOZayAXgLyzfesEIk/fFC55bYc0bKOxsiJrSXSgfFMKmeVkhP8nrhUp3ddRXe2M8KZ4h36WIXSyPIACD+3aFV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791516470; c=relaxed/simple;
	bh=Kd1kZz1uJ3rf4ARzH0OoHTu/qb+3ByBVPcrw2pXNLnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QTNpA5Vg5wxhqTD2ghDgmda01ho2bV1FSU+O2OkiMQ2XigriDLAvIgPVsn7BfXp0vIkmXZffoz1UFYqmqTWFGpGrz6wxd0YrobKiu7kHIVhy6+rzIvXzGabAc8GdY3PjDhfUuAELyXLwMfsnwv1Hv7nkPQIlZzMjQLtqGr/WyUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=U+WbzG6j; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="U+WbzG6j"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1791516443; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=dyCekRw9sufTyDzZAdbNFK7/Qt5VQKyaiRdhuHgwJrU=;
	b=U+WbzG6jgZoMteiC/ffr8/lAYnEVYKsB8Ct7Yb4kUZzzf8keytj0VBGBU+GHIK1Sgdjnl5tzS5j2oOJLG3qzJ/rAbaarOfnGkTPgpfItLR9UR0APO8tfqVd6j1qAwMG9NrTPQZdr1ctcyw1USU0LEXzMGHJ9LVDHWFOOXtEPo38=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0XCS-sKT_1791516441;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XCS-sKT_1791516441 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 09 Oct 2026 11:27:22 +0800
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
Subject: [PATCH v3 1/2] perf riscv: Implement rdtsc()
Date: Fri,  9 Oct 2026 11:27:14 +0800
Message-ID: <20261009032715.2841-2-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009032715.2841-1-cp0613@linux.alibaba.com>
References: <20261009032715.2841-1-cp0613@linux.alibaba.com>
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
Acked-by: Paul Walmsley <pjw@kernel.org> # arch/riscv
Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
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

