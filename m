Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432F749159C;
	Mon, 28 Sep 2026 09:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790588875; cv=none; b=Ruga2tOvNVpTtwATguF++kI3BvAIa+Kw3EkwHnY99DH1FrwxBcg/ZMg/7cS82DEp5Y2gHcj1P4Fee01LyCwDUBtgGekvEqEt3apbEKznTaNh+15v1cdryfIRvF283wwK4nY0ma93kUWg583Ep2/Oy8eTd8c47O4/lrd9wIbj3w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790588875; c=relaxed/simple;
	bh=kGCj06U1WyBeuL0Q9kueObx5ppaZrciny/G6Yw6s0fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cI5aLzV7YDEALLqBuV27uLKlJ+11Mgm2DQgu9sdNDTgbOec4pVY3Oo4C9ScIi+dEvaNYCPudpjBzSDukUan4vEPLcd5avqbSb6XCnjfjfszoIkArK0kxbB/mvEv3FU00kXNPn45EfwsTLR/1CMxOUUP0D8DvpXyV60UUNiVk+UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=C7oCadEJ; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="C7oCadEJ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1790588866; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=x6LI/tGVPTJtzfGc+js4lja1XoZyu6sJ13/yvNlyYCQ=;
	b=C7oCadEJWctA9pmKwWasdGRTNpAW5Tjksa+IPi9sTN3cNobdR6J8Vs9WTLZgdSKtQs6VjEo9gxoJ9syf2nO45AHKVruJyYzdzBgaEiuJ/mDEXV0yijfipaEp58ZxV2kUe0u3if7jpy9qPQ5j4Aa71kdMvelsVlucSSy8GuYtNwQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0XBlsENU_1790588864;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XBlsENU_1790588864 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 28 Sep 2026 17:47:45 +0800
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
Subject: [PATCH 1/2] perf riscv: Implement rdtsc()
Date: Mon, 28 Sep 2026 17:47:38 +0800
Message-ID: <20260928094739.2605-2-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928094739.2605-1-cp0613@linux.alibaba.com>
References: <20260928094739.2605-1-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no riscv implementation of rdtsc(), so perf links against the
weak stub in util/tsc.c and every caller reads a constant 0 that is
indistinguishable from a real counter standing still.

Implement rdtsc() over the time CSR with rdtime.  The time CSR is a TSC
equivalent on riscv: it is readable from user mode, it ticks at a
constant frequency, and it is the same counter that riscv's
arch_perf_update_userpage() builds the user page conversion fields from,
so the counter and perf time share a timebase.

Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
 tools/perf/arch/riscv/util/Build |  1 +
 tools/perf/arch/riscv/util/tsc.c | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)
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
index 000000000000..7cc4710ac38c
--- /dev/null
+++ b/tools/perf/arch/riscv/util/tsc.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/types.h>
+
+#include "../../../util/tsc.h"
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
-- 
2.50.1

