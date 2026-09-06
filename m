Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784C4207E00;
	Sun,  6 Sep 2026 04:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788669004; cv=none; b=mW8MGbLdfzfd6XaBXMHQXLDUUtZPsXStCpJ1O0be1z1QmsC1zNe/mahVsZLLGur1R4I1UoQ0OI0qQaOFtVYLqyPtNoRvU0NsE801D/t6oGC0cz+nshWtJQueZTbI0LsUIZksehMBkFuHzk9mFP2VSG8xryK+YIGsSUlTktc1tSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788669004; c=relaxed/simple;
	bh=TBHU0lUu16L1h/aH/vpLZrZutE88K2yMfCLaa9tQTyc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=aIzjXZvAmQKDt3KhmQ8g4w3PheLkOonWp9ldW70KZFyjvsdlZbHO+rzTQlkBOg3QPlyH3ayAKwqxflL83wIQ63ihHE2bE32yV/wOXm0oKlzHM8eOe/28K8GpAT7HVbjsC7MU1cg2QJQe4uAC+EnlfQ7sLi0tAwa1kJY2XZ2RqQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HJKyoCj+; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HJKyoCj+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:Content-Type:
	MIME-Version; bh=UWVKgjlpVvo+EoPOXvCFd6amsMMPLnh3+oXB0HxW/2I=;
	b=HJKyoCj+XA9m0I+UsFXeya5l9M5/x6UxV8Kgv6YUvxpe7UrSObDDTKYKxIrjfb
	+MdvBjxzcKrSYjMnrYX2WMs17tE9sT20PM11Q08RmXL5pb187JLinol7k/t+3yQQ
	0RMq/d5mjH21lI3OUnQ5eGbNJ/0aPICrVyrCk7PRffui8=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgCnYyDh65xqP0cBQQ--.256S2;
	Sun, 06 Sep 2026 12:28:19 +0800 (CST)
From: Pengpeng Hou <hppiscas@163.com>
To: Atish Patra <atish.patra@linux.dev>,
	Anup Patel <anup@brainfault.org>
Cc: Pengpeng Hou <hppiscas@163.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Jones <andrew.jones@oss.qualcomm.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH] perf/riscv: clear snapshot setup state when a CPU goes offline
Date: Sun,  6 Sep 2026 12:28:14 +0800
Message-ID: <caplitmus-rv.75b0e9ee82984422ba17d833767912a8.d33@163.com>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgCnYyDh65xqP0cBQQ--.256S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tryfGw4UXw15ur47ZFWxXrb_yoW8Zr47pr
	4fCayYkF4FvF10q348AF48XFyrArs3W39rtr98CwnxZ3W3AF4fCFs5JFy5Zrn8JrW8Z3y2
	yr4avrW5CF4jgFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UzE__UUUUU=
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbCxgP0vWqc6+NrcgAA3r

pmu_sbi_dying_cpu() disables the calling hart's SBI PMU snapshot shared
memory but leaves snapshot_set_done set. When the CPU comes back online,
pmu_sbi_snapshot_setup() returns early without registering the shared
memory again.

Snapshot operations on that hart can then fail because the firmware no
longer has a snapshot area, while the driver still follows its snapshot
paths.

Clear the per-CPU setup flag after snapshot disable succeeds. Retain the
flag and the existing error return if disable fails, so a failed teardown
does not claim that the firmware registration has been removed.

Fixes: a8625217a054 ("drivers/perf: riscv: Implement SBI PMU snapshot function")
Assisted-by: GPT-5
Signed-off-by: Pengpeng Hou <hppiscas@163.com>
---
The issue was found by our static-analysis tool and manually reviewed.


diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 50220f7b..f38a64c7 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -1175,6 +1175,10 @@ static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_node *node)
 
 static int pmu_sbi_dying_cpu(unsigned int cpu, struct hlist_node *node)
 {
+	struct riscv_pmu *pmu = hlist_entry_safe(node, struct riscv_pmu, node);
+	struct cpu_hw_events *cpu_hw_evt = per_cpu_ptr(pmu->hw_events, cpu);
+	int ret;
+
 	if (riscv_pmu_use_irq) {
 		disable_percpu_irq(riscv_pmu_irq);
 	}
@@ -1182,8 +1186,12 @@ static int pmu_sbi_dying_cpu(unsigned int cpu, struct hlist_node *node)
 	/* Disable all counters access for user mode now */
 	csr_write(CSR_SCOUNTEREN, 0x0);
 
-	if (sbi_pmu_snapshot_available())
-		return pmu_sbi_snapshot_disable();
+	if (sbi_pmu_snapshot_available()) {
+		ret = pmu_sbi_snapshot_disable();
+		if (ret)
+			return ret;
+		cpu_hw_evt->snapshot_set_done = false;
+	}
 
 	return 0;
 }

base-commit: 4d7d9486c04d917265f64c55bd23b2cc4fe7749c

