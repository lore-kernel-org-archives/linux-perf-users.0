Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EB1351C04
	for <linux-perf-users@vger.kernel.org>; Sat,  9 May 2026 13:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778332259; cv=none; b=g3mYaSf83TosOjMy2UczTx4PxuXyqmDy5jecOjGFifGy9z/2DYxZSJsYpGahMtuVOiJWvwC9DtLWlGcPJVpTT2ot0+4iA88KmEg4px2tIeQTt1/5GivZh4IOVtXpQu5ZRO4aYWLD3yrczIPTrZXJTiqS9nvxb+ww6ZHWlww8hWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778332259; c=relaxed/simple;
	bh=ebCvpVlXYudCqk2oDUSNFMiqT9vZTUFFH6ipMm2gON8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c8xYMPtTHZ+aOqjU9TF1NqG3cKvYzi0vde1BEJ9OWSBqUBdiRBaD0hoCdsiM19lH4grAoZFKkiAfAFA9R+sE4MgK/LW6mjJd3WA6eHw3rrEhG6HgfJA+yu3C3LNrKGFrvdVFoZjl9OGcyjKhf9KqEvueQD9U5zKtiIUYBgRBLzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Ye9RrcB3; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Ye9RrcB3"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-836ed29d1e5so1245174b3a.2
        for <linux-perf-users@vger.kernel.org>; Sat, 09 May 2026 06:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778332256; x=1778937056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXfPGCZUlYh3ML2E5Z35byh0hcud282pgOoFG2gFoW4=;
        b=Ye9RrcB36JAb76tmG1WfKVjY6nS+oKFIC2uJqy6/gxJVCoPr5DppXkKxbukzgoZSJE
         6QkdE3euYR61OzKRP0U9kJwRtnVU5t+OpxDZ48iXs2Gh9vmbcPzWKSwXpcbtN7gzDaxa
         Iu9NO225wVRNBA+izptc0VRMuXu1348xDybml5csdzoXFEtkLmCVAq9efqM9DI4Ay4Xd
         ruQST9SXUrJlD5NWjkOsJevVWd/nt2tu/Izvoiq7/OxRlk7FSiouU+MDzgBZUw1jkn9o
         +PXNpoOwnGW6RlS3wJwjTX7IsN9RuZ0PxdlwAZ1xXzEK65vkDMdPlpo7Auf7KI4Fiu0Y
         EQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778332256; x=1778937056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fXfPGCZUlYh3ML2E5Z35byh0hcud282pgOoFG2gFoW4=;
        b=rIn0Kspa/O8fPLAXGck5+YI59vTMHhF2X1M02AkDGEvOqgZPNGUiSBA8hHvbVvRKdL
         D3sUud+JOEFEmyuOxmldlP7D+qgyZvyvZiS8+wOWjXvQytgzJKIOi3C3tEkhlKVburM2
         M1DX8blXZskSFGXB6VRCAKeTQR1GG3km9aEeLA6ZGHtAm6bSXKmCbtnoNF8jh2e71ghM
         1DPskYJ5RRBALBdsypfH94hwYPdG9YUzawIqqsI3c/9P94iygzCCrBzAyEk8vnF+XCqE
         5kHe8l6WIgYFa3X8KdCzvEF+diOp1jVFodeGHunjexFKAlH2uwB5mElqzkcDf3T9NTbz
         yXlg==
X-Forwarded-Encrypted: i=1; AFNElJ/76Ls03tNx69gZu05yaueVI9czvJFR7QAaLMgiGFG6Nq/7oYSGeK9LI968NlLbVQpe7TkhAwHwlxm7uq1a8Xub@vger.kernel.org
X-Gm-Message-State: AOJu0YxSb7QRD+3XmQOqW0cMgEK+NyGg1an/VHn0OPF5f5j0eajPWFrH
	zCTCNLjKplHM5vP/xa59+JaAlTp3JWt7rCiMuNXjVGfwdgIES8uKXPhCwO7ukV1bTuM=
X-Gm-Gg: Acq92OG9QqVwrDW2xJrRZW/md2L54hesHt0nNbi4nDN//p/kVc4JfgT6QR28FKkRjVZ
	+uHDAOV5wqMlO7uaVSGIqFk5rHWevLGNKXTwFj0Hcc9/5F0FE+a7Ds0i3cd7ES3SJ69KU0Fj4Kl
	hsAQ0BbzsEe7JVweSz77Zysl7qP+eqkYNCXG/S1EvTTmb0XaeKSBGx8LRK892cmyn+fx5vmdqwl
	EkToxvdmo8z8WcRM+YMnF1mckRmvtxNG0PyR5FNSDmBU3a0fdMB+vdn15HUoR8gmq3VfZhP1yK4
	OG7sGR0k1VkqSYfwRoCzu/+2TCYNgMptLnKStyG0Rznm9881At1/9Wu2MnV6RBM3ccJwTLExp20
	vId8oFJTYgaNoMBnk/LE06NzLeM+IxIc0TGj+DPFz+zdZPE0v/zVs7qvCdeY0s6toQv6KC9RY8z
	yhnPBrIjeM8KBwhW7de0goT9WDr2Rx/zDtXEP3eZRmchigt5zP0TtMlp6mNpYuP1BMQno=
X-Received: by 2002:a05:6a00:1411:b0:838:c01a:7a50 with SMTP id d2e1a72fcca58-83a5d68134fmr15695879b3a.30.1778332255468;
        Sat, 09 May 2026 06:10:55 -0700 (PDT)
Received: from FJ7FR2JRQ3.bytedance.net ([155.117.34.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839679c86b3sm18552855b3a.28.2026.05.09.06.10.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 09 May 2026 06:10:54 -0700 (PDT)
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
To: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Conor Dooley <conor@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Himanshu Chauhan <himanshu@thechauhan.dev>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Atish Patra <atish.patra@linux.dev>,
	Anup Patel <anup@brainfault.org>,
	Shuah Khan <shuah@kernel.org>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Zhu Yuan <yuanzhu@bytedance.com>,
	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Subject: [PATCH v9 5/5] selftests/riscv: add SSE test module
Date: Sat,  9 May 2026 21:10:02 +0800
Message-ID: <1f66bfb775e8b6658c6f2f2f48aa4f668f911db5.1778331862.5.git.zhangzhanpeng.jasper@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1778331862.git.zhangzhanpeng.jasper@bytedance.com>
References: <cover.1778331862.git.zhangzhanpeng.jasper@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Clément Léger <cleger@rivosinc.com>

This module, once loaded, will execute a series of tests using the SSE
framework. The provided script will check for any error reported by the
test module.

Add stress={0,1,2} modes so the same module can cover repeated handler
entry, SBI calls from a handler, PMU activity and re-injection.  Also make
the tests tolerate events that are already registered, and keep the
attribute read buffer lifetime local to the SBI call.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Co-developed-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
---
 MAINTAINERS                                   |   1 +
 tools/testing/selftests/riscv/Makefile        |   2 +-
 tools/testing/selftests/riscv/sse/Makefile    |   5 +
 .../selftests/riscv/sse/module/Makefile       |  16 +
 .../riscv/sse/module/riscv_sse_test.c         | 769 ++++++++++++++++++
 .../selftests/riscv/sse/run_sse_test.sh       |  48 ++
 6 files changed, 840 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/riscv/sse/Makefile
 create mode 100644 tools/testing/selftests/riscv/sse/module/Makefile
 create mode 100644 tools/testing/selftests/riscv/sse/module/riscv_sse_test.c
 create mode 100644 tools/testing/selftests/riscv/sse/run_sse_test.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index c247acc56d1c..e4bb9b880c26 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22902,6 +22902,7 @@ C:	irc://irc.libera.chat/riscv
 P:	Documentation/arch/riscv/patch-acceptance.rst
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
 F:	arch/riscv/
+F:	tools/testing/selftests/riscv/
 N:	riscv
 K:	riscv
 
diff --git a/tools/testing/selftests/riscv/Makefile b/tools/testing/selftests/riscv/Makefile
index 5671b4405a12..43c7c8f97676 100644
--- a/tools/testing/selftests/riscv/Makefile
+++ b/tools/testing/selftests/riscv/Makefile
@@ -5,7 +5,7 @@
 ARCH ?= $(shell uname -m 2>/dev/null || echo not)
 
 ifneq (,$(filter $(ARCH),riscv))
-RISCV_SUBTARGETS ?= abi hwprobe mm sigreturn vector cfi
+RISCV_SUBTARGETS ?= abi hwprobe mm sigreturn vector cfi sse
 else
 RISCV_SUBTARGETS :=
 endif
diff --git a/tools/testing/selftests/riscv/sse/Makefile b/tools/testing/selftests/riscv/sse/Makefile
new file mode 100644
index 000000000000..67eaee06f213
--- /dev/null
+++ b/tools/testing/selftests/riscv/sse/Makefile
@@ -0,0 +1,5 @@
+TEST_GEN_MODS_DIR := module
+
+TEST_FILES := run_sse_test.sh
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/riscv/sse/module/Makefile b/tools/testing/selftests/riscv/sse/module/Makefile
new file mode 100644
index 000000000000..02018f083456
--- /dev/null
+++ b/tools/testing/selftests/riscv/sse/module/Makefile
@@ -0,0 +1,16 @@
+TESTMODS_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
+KDIR ?= /lib/modules/$(shell uname -r)/build
+
+obj-m += riscv_sse_test.o
+
+# Ensure that KDIR exists, otherwise skip the compilation
+modules:
+ifneq ("$(wildcard $(KDIR))", "")
+	$(Q)$(MAKE) -C $(KDIR) modules KBUILD_EXTMOD=$(TESTMODS_DIR)
+endif
+
+# Ensure that KDIR exists, otherwise skip the clean target
+clean:
+ifneq ("$(wildcard $(KDIR))", "")
+	$(Q)$(MAKE) -C $(KDIR) clean KBUILD_EXTMOD=$(TESTMODS_DIR)
+endif
diff --git a/tools/testing/selftests/riscv/sse/module/riscv_sse_test.c b/tools/testing/selftests/riscv/sse/module/riscv_sse_test.c
new file mode 100644
index 000000000000..c0efdfc5467c
--- /dev/null
+++ b/tools/testing/selftests/riscv/sse/module/riscv_sse_test.c
@@ -0,0 +1,769 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025 Rivos Inc.
+ */
+
+#define pr_fmt(fmt) "riscv_sse_test: " fmt
+
+#include <linux/array_size.h>
+#include <linux/atomic.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/hrtimer.h>
+#include <linux/io.h>
+#include <linux/jiffies.h>
+#include <linux/kthread.h>
+#include <linux/module.h>
+#include <linux/riscv_sbi_sse.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/smp.h>
+
+#include <asm/sbi.h>
+#include <asm/sse.h>
+
+#define RUN_LOOP_COUNT		1000
+#define SSE_FAILED_PREFIX	"FAILED: "
+#define STRESS_DURATION_MS	3000
+#define STRESS_INJECT_NS	10000
+#define STRESS_REINJECT_DEPTH	10
+#define sse_err(...)		pr_err(SSE_FAILED_PREFIX __VA_ARGS__)
+
+enum sse_stress_mode {
+	SSE_STRESS_OFF,
+	SSE_STRESS_AFTER_SMOKE,
+	SSE_STRESS_ONLY,
+};
+
+static int stress;
+module_param(stress, int, 0444);
+MODULE_PARM_DESC(stress, "Stress mode: 0=off, 1=after smoke, 2=stress only");
+
+struct sse_event_desc {
+	u32 evt_id;
+	const char *name;
+	bool can_inject;
+};
+
+static struct sse_event_desc sse_event_descs[] = {
+	{
+		.evt_id = SBI_SSE_EVENT_LOCAL_HIGH_PRIO_RAS,
+		.name = "local_high_prio_ras",
+	},
+	{
+		.evt_id = SBI_SSE_EVENT_LOCAL_DOUBLE_TRAP,
+		.name = "local_double_trap",
+	},
+	{
+		.evt_id = SBI_SSE_EVENT_GLOBAL_HIGH_PRIO_RAS,
+		.name = "global_high_prio_ras",
+	},
+	{
+		.evt_id = SBI_SSE_EVENT_LOCAL_PMU_OVERFLOW,
+		.name = "local_pmu_overflow",
+	},
+	{
+		.evt_id = SBI_SSE_EVENT_LOCAL_LOW_PRIO_RAS,
+		.name = "local_low_prio_ras",
+	},
+	{
+		.evt_id = SBI_SSE_EVENT_GLOBAL_LOW_PRIO_RAS,
+		.name = "global_low_prio_ras",
+	},
+	{
+		.evt_id = SBI_SSE_EVENT_LOCAL_SOFTWARE_INJECTED,
+		.name = "local_software_injected",
+	},
+	{
+		.evt_id = SBI_SSE_EVENT_GLOBAL_SOFTWARE_INJECTED,
+		.name = "global_software_injected",
+	}
+};
+
+static struct sse_event_desc *sse_get_evt_desc(u32 evt)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(sse_event_descs); i++) {
+		if (sse_event_descs[i].evt_id == evt)
+			return &sse_event_descs[i];
+	}
+
+	return NULL;
+}
+
+static const char *sse_evt_name(u32 evt)
+{
+	struct sse_event_desc *desc = sse_get_evt_desc(evt);
+
+	return desc ? desc->name : NULL;
+}
+
+static bool sse_test_can_inject_event(u32 evt)
+{
+	struct sse_event_desc *desc = sse_get_evt_desc(evt);
+
+	return desc ? desc->can_inject : false;
+}
+
+static struct sbiret sbi_sse_ecall(int fid, unsigned long arg0, unsigned long arg1)
+{
+	return sbi_ecall(SBI_EXT_SSE, fid, arg0, arg1, 0, 0, 0, 0);
+}
+
+static int sse_event_attr_get(u32 evt, unsigned long attr_id,
+			      unsigned long *val)
+{
+	struct sbiret sret;
+	unsigned long *attr_buf, phys;
+
+	attr_buf = kmalloc_obj(*attr_buf, GFP_KERNEL);
+	if (!attr_buf)
+		return -ENOMEM;
+
+	phys = virt_to_phys(attr_buf);
+
+	sret = sbi_ecall(SBI_EXT_SSE, SBI_SSE_EVENT_ATTR_READ, evt, attr_id, 1,
+			 phys, 0, 0);
+	if (sret.error) {
+		kfree(attr_buf);
+		return sbi_err_map_linux_errno(sret.error);
+	}
+
+	*val = *attr_buf;
+	kfree(attr_buf);
+
+	return 0;
+}
+
+static int sse_test_signal(u32 evt, unsigned int cpu)
+{
+	unsigned int hart_id = cpuid_to_hartid_map(cpu);
+	struct sbiret ret;
+
+	ret = sbi_sse_ecall(SBI_SSE_EVENT_INJECT, evt, hart_id);
+	if (ret.error) {
+		sse_err("Failed to signal event %x, error %ld\n", evt, ret.error);
+		return sbi_err_map_linux_errno(ret.error);
+	}
+
+	return 0;
+}
+
+static int sse_test_inject_event(struct sse_event *event, u32 evt, unsigned int cpu)
+{
+	int res;
+	unsigned long status;
+
+	if (sse_event_is_global(evt)) {
+		/*
+		 * Due to the fact the completion might happen faster than
+		 * the call to SBI_SSE_COMPLETE in the handler, if the event was
+		 * running on another CPU, we need to wait for the event status
+		 * to be !RUNNING.
+		 */
+		do {
+			res = sse_event_attr_get(evt, SBI_SSE_ATTR_STATUS, &status);
+			if (res) {
+				sse_err("Failed to get status for evt %x, error %d\n", evt, res);
+				return res;
+			}
+			status = status & SBI_SSE_ATTR_STATUS_STATE_MASK;
+		} while (status == SBI_SSE_STATE_RUNNING);
+
+		res = sse_event_set_target_cpu(event, cpu);
+		if (res) {
+			sse_err("Failed to set cpu for evt %x, error %d\n", evt, res);
+			return res;
+		}
+	}
+
+	return sse_test_signal(evt, cpu);
+}
+
+struct fast_test_arg {
+	u32 evt;
+	int cpu;
+	bool completion;
+};
+
+static int sse_test_handler(u32 evt, void *arg, struct pt_regs *regs)
+{
+	int ret = 0;
+	struct fast_test_arg *targ = arg;
+	u32 test_evt = READ_ONCE(targ->evt);
+	int cpu = READ_ONCE(targ->cpu);
+
+	if (evt != test_evt) {
+		sse_err("Received SSE event id %x instead of %x\n", test_evt, evt);
+		ret = -EINVAL;
+	}
+
+	if (cpu != smp_processor_id()) {
+		sse_err("Received SSE event %d on CPU %d instead of %d\n", evt, smp_processor_id(),
+			cpu);
+		ret = -EINVAL;
+	}
+
+	WRITE_ONCE(targ->completion, true);
+
+	return ret;
+}
+
+static void sse_run_fast_test(struct fast_test_arg *test_arg, struct sse_event *event, u32 evt)
+{
+	unsigned long timeout;
+	int ret, cpu;
+
+	for_each_online_cpu(cpu) {
+		WRITE_ONCE(test_arg->completion, false);
+		WRITE_ONCE(test_arg->cpu, cpu);
+		/* Test arg is used on another CPU */
+		smp_wmb();
+
+		ret = sse_test_inject_event(event, evt, cpu);
+		if (ret) {
+			sse_err("event %s injection failed, err %d\n", sse_evt_name(evt), ret);
+			return;
+		}
+
+		timeout = jiffies + HZ / 100;
+		/* We can not use <linux/completion.h> since they are not NMI safe */
+		while (!READ_ONCE(test_arg->completion) &&
+		       time_before(jiffies, timeout)) {
+			cpu_relax();
+		}
+		if (!time_before(jiffies, timeout)) {
+			sse_err("Failed to wait for event %s completion on CPU %d\n",
+				sse_evt_name(evt), cpu);
+			return;
+		}
+	}
+}
+
+static void sse_test_injection_fast(void)
+{
+	int i, ret = 0, j;
+	u32 evt;
+	struct fast_test_arg test_arg;
+	struct sse_event *event;
+
+	pr_info("Starting SSE test (fast)\n");
+
+	for (i = 0; i < ARRAY_SIZE(sse_event_descs); i++) {
+		evt = sse_event_descs[i].evt_id;
+		WRITE_ONCE(test_arg.evt, evt);
+
+		if (!sse_event_descs[i].can_inject)
+			continue;
+
+		event = sse_event_register(evt, 0, sse_test_handler,
+					   (void *)&test_arg);
+		if (IS_ERR(event)) {
+			if (PTR_ERR(event) == -EEXIST) {
+				pr_info("Event %s already registered, skipping\n",
+					sse_evt_name(evt));
+				continue;
+			}
+			sse_err("Failed to register event %s, err %ld\n", sse_evt_name(evt),
+				PTR_ERR(event));
+			continue;
+		}
+
+		ret = sse_event_enable(event);
+		if (ret) {
+			sse_err("Failed to enable event %s, err %d\n", sse_evt_name(evt), ret);
+			goto err_unregister;
+		}
+
+		pr_info("Starting testing event %s\n", sse_evt_name(evt));
+
+		for (j = 0; j < RUN_LOOP_COUNT; j++)
+			sse_run_fast_test(&test_arg, event, evt);
+
+		pr_info("Finished testing event %s\n", sse_evt_name(evt));
+
+		sse_event_disable(event);
+err_unregister:
+		sse_event_unregister(event);
+	}
+	pr_info("Finished SSE test (fast)\n");
+}
+
+struct priority_test_arg {
+	unsigned long evt;
+	struct sse_event *event;
+	bool called;
+	u32 prio;
+	struct priority_test_arg *next_evt_arg;
+	void (*check_func)(struct priority_test_arg *arg);
+};
+
+static int sse_hi_priority_test_handler(u32 evt, void *arg,
+					struct pt_regs *regs)
+{
+	struct priority_test_arg *targ = arg;
+	struct priority_test_arg *next = READ_ONCE(targ->next_evt_arg);
+
+	WRITE_ONCE(targ->called, 1);
+
+	if (next) {
+		sse_test_signal(next->evt, smp_processor_id());
+		if (!READ_ONCE(next->called)) {
+			sse_err("Higher priority event %s was not handled %s\n",
+				sse_evt_name(next->evt), sse_evt_name(evt));
+		}
+	}
+
+	return 0;
+}
+
+static int sse_low_priority_test_handler(u32 evt, void *arg, struct pt_regs *regs)
+{
+	struct priority_test_arg *targ = arg;
+	struct priority_test_arg *next = READ_ONCE(targ->next_evt_arg);
+
+	WRITE_ONCE(targ->called, 1);
+
+	if (next) {
+		sse_test_signal(next->evt, smp_processor_id());
+		if (READ_ONCE(next->called)) {
+			sse_err("Lower priority event %s was handle before %s\n",
+				sse_evt_name(next->evt), sse_evt_name(evt));
+		}
+	}
+
+	return 0;
+}
+
+static void sse_test_injection_priority_arg(struct priority_test_arg *args, unsigned int args_size,
+					    sse_event_handler_fn handler, const char *test_name)
+{
+	unsigned int i;
+	int ret;
+	struct sse_event *event;
+	struct priority_test_arg *arg, *first_arg = NULL, *prev_arg = NULL;
+
+	pr_info("Starting SSE priority test (%s)\n", test_name);
+	for (i = 0; i < args_size; i++) {
+		arg = &args[i];
+
+		if (!sse_test_can_inject_event(arg->evt))
+			continue;
+
+		WRITE_ONCE(arg->called, false);
+		WRITE_ONCE(arg->next_evt_arg, NULL);
+		WRITE_ONCE(arg->event, NULL);
+
+		event = sse_event_register(arg->evt, arg->prio, handler, (void *)arg);
+		if (IS_ERR(event)) {
+			if (PTR_ERR(event) == -EEXIST) {
+				pr_info("Event %s already registered, skipping\n",
+					sse_evt_name(arg->evt));
+				continue;
+			}
+			sse_err("Failed to register event %s, err %ld\n", sse_evt_name(arg->evt),
+				PTR_ERR(event));
+			goto release_events;
+		}
+		arg->event = event;
+
+		if (sse_event_is_global(arg->evt)) {
+			/* Target event at current CPU */
+			ret = sse_event_set_target_cpu(event, smp_processor_id());
+			if (ret) {
+				sse_err("Failed to set event %s target CPU, err %d\n",
+					sse_evt_name(arg->evt), ret);
+				goto release_events;
+			}
+		}
+
+		ret = sse_event_enable(event);
+		if (ret) {
+			sse_err("Failed to enable event %s, err %d\n", sse_evt_name(arg->evt), ret);
+			goto release_events;
+		}
+
+		if (prev_arg)
+			WRITE_ONCE(prev_arg->next_evt_arg, arg);
+
+		prev_arg = arg;
+
+		if (!first_arg)
+			first_arg = arg;
+	}
+
+	if (!first_arg) {
+		pr_info("No injectable event available for %s priority test\n",
+			test_name);
+		return;
+	}
+
+	/* Inject first event, handler should trigger the others in chain. */
+	ret = sse_test_inject_event(first_arg->event, first_arg->evt, smp_processor_id());
+	if (ret) {
+		sse_err("SSE event %s injection failed\n", sse_evt_name(first_arg->evt));
+		goto release_events;
+	}
+
+	/*
+	 * Event are injected directly on the current CPU after calling sse_test_inject_event()
+	 * so that execution is preempted right away, no need to wait for timeout.
+	 */
+	arg = first_arg;
+	while (arg) {
+		if (!READ_ONCE(arg->called)) {
+			sse_err("Event %s handler was not called\n",
+				sse_evt_name(arg->evt));
+			ret = -EINVAL;
+		}
+
+		event = arg->event;
+		arg = READ_ONCE(arg->next_evt_arg);
+	}
+
+release_events:
+
+	arg = first_arg;
+	while (arg) {
+		event = arg->event;
+		if (!event)
+			break;
+
+		sse_event_disable(event);
+		sse_event_unregister(event);
+		arg = READ_ONCE(arg->next_evt_arg);
+	}
+
+	pr_info("Finished SSE priority test (%s)\n", test_name);
+}
+
+static void sse_test_injection_priority(void)
+{
+	struct priority_test_arg default_hi_prio_args[] = {
+		{ .evt = SBI_SSE_EVENT_GLOBAL_SOFTWARE_INJECTED },
+		{ .evt = SBI_SSE_EVENT_LOCAL_SOFTWARE_INJECTED },
+		{ .evt = SBI_SSE_EVENT_GLOBAL_LOW_PRIO_RAS },
+		{ .evt = SBI_SSE_EVENT_LOCAL_LOW_PRIO_RAS },
+		{ .evt = SBI_SSE_EVENT_LOCAL_PMU_OVERFLOW },
+		{ .evt = SBI_SSE_EVENT_GLOBAL_HIGH_PRIO_RAS },
+		{ .evt = SBI_SSE_EVENT_LOCAL_DOUBLE_TRAP },
+		{ .evt = SBI_SSE_EVENT_LOCAL_HIGH_PRIO_RAS },
+	};
+
+	struct priority_test_arg default_low_prio_args[] = {
+		{ .evt = SBI_SSE_EVENT_LOCAL_HIGH_PRIO_RAS },
+		{ .evt = SBI_SSE_EVENT_LOCAL_DOUBLE_TRAP },
+		{ .evt = SBI_SSE_EVENT_GLOBAL_HIGH_PRIO_RAS },
+		{ .evt = SBI_SSE_EVENT_LOCAL_PMU_OVERFLOW },
+		{ .evt = SBI_SSE_EVENT_LOCAL_LOW_PRIO_RAS },
+		{ .evt = SBI_SSE_EVENT_GLOBAL_LOW_PRIO_RAS },
+		{ .evt = SBI_SSE_EVENT_LOCAL_SOFTWARE_INJECTED },
+		{ .evt = SBI_SSE_EVENT_GLOBAL_SOFTWARE_INJECTED },
+
+	};
+	struct priority_test_arg set_prio_args[] = {
+		{ .evt = SBI_SSE_EVENT_GLOBAL_SOFTWARE_INJECTED, .prio = 5 },
+		{ .evt = SBI_SSE_EVENT_LOCAL_SOFTWARE_INJECTED, .prio = 10 },
+		{ .evt = SBI_SSE_EVENT_GLOBAL_LOW_PRIO_RAS, .prio = 15 },
+		{ .evt = SBI_SSE_EVENT_LOCAL_LOW_PRIO_RAS, .prio = 20 },
+		{ .evt = SBI_SSE_EVENT_LOCAL_PMU_OVERFLOW, .prio = 25 },
+		{ .evt = SBI_SSE_EVENT_GLOBAL_HIGH_PRIO_RAS, .prio = 30 },
+		{ .evt = SBI_SSE_EVENT_LOCAL_DOUBLE_TRAP, .prio = 35 },
+		{ .evt = SBI_SSE_EVENT_LOCAL_HIGH_PRIO_RAS, .prio = 40 },
+	};
+
+	struct priority_test_arg same_prio_args[] = {
+		{ .evt = SBI_SSE_EVENT_LOCAL_PMU_OVERFLOW, .prio = 0 },
+		{ .evt = SBI_SSE_EVENT_LOCAL_HIGH_PRIO_RAS, .prio = 10 },
+		{ .evt = SBI_SSE_EVENT_LOCAL_SOFTWARE_INJECTED, .prio = 10 },
+		{ .evt = SBI_SSE_EVENT_GLOBAL_SOFTWARE_INJECTED, .prio = 10 },
+		{ .evt = SBI_SSE_EVENT_GLOBAL_HIGH_PRIO_RAS, .prio = 20 },
+	};
+
+	sse_test_injection_priority_arg(default_hi_prio_args, ARRAY_SIZE(default_hi_prio_args),
+					sse_hi_priority_test_handler, "high");
+
+	sse_test_injection_priority_arg(default_low_prio_args, ARRAY_SIZE(default_low_prio_args),
+					sse_low_priority_test_handler, "low");
+
+	sse_test_injection_priority_arg(set_prio_args, ARRAY_SIZE(set_prio_args),
+					sse_low_priority_test_handler, "set");
+
+	sse_test_injection_priority_arg(same_prio_args, ARRAY_SIZE(same_prio_args),
+					sse_low_priority_test_handler, "same_prio_args");
+}
+
+static bool sse_get_inject_status(u32 evt)
+{
+	int ret;
+	unsigned long val;
+
+	/* Check if injection is supported */
+	ret = sse_event_attr_get(evt, SBI_SSE_ATTR_STATUS, &val);
+	if (ret)
+		return false;
+
+	return !!(val & BIT(SBI_SSE_ATTR_STATUS_INJECT_OFFSET));
+}
+
+static void sse_init_events(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(sse_event_descs); i++) {
+		struct sse_event_desc *desc = &sse_event_descs[i];
+
+		desc->can_inject = sse_get_inject_status(desc->evt_id);
+		if (!desc->can_inject)
+			pr_info("Can not inject event %s, tests using this event will be skipped\n",
+				desc->name);
+	}
+}
+
+struct stress_test_ctx {
+	struct sse_event *event;
+	struct hrtimer timer;
+	struct hrtimer stop_timer;
+	struct task_struct *monitor_task;
+	wait_queue_head_t wait_q;
+	atomic_t inject_count;
+	atomic_t handler_count;
+	u32 evt_id;
+	int layer;
+	bool running;
+	bool test_done;
+};
+
+static struct stress_test_ctx stress_ctx;
+static DEFINE_PER_CPU(int, stress_reinject_cpu_depth);
+
+static int stress_handler_empty(u32 evt, void *arg, struct pt_regs *regs)
+{
+	struct stress_test_ctx *ctx = arg;
+
+	atomic_inc(&ctx->handler_count);
+
+	return 0;
+}
+
+static int stress_handler_ecall(u32 evt, void *arg, struct pt_regs *regs)
+{
+	struct stress_test_ctx *ctx = arg;
+
+	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_NUM_COUNTERS, 0, 0, 0, 0, 0, 0);
+	atomic_inc(&ctx->handler_count);
+
+	return 0;
+}
+
+static int stress_handler_pmu(u32 evt, void *arg, struct pt_regs *regs)
+{
+	struct stress_test_ctx *ctx = arg;
+
+	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, 3, 1, 0, 0, 0, 0);
+	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, 3, 1, 0, 0, 0, 0);
+	atomic_inc(&ctx->handler_count);
+
+	return 0;
+}
+
+static int stress_handler_reinject(u32 evt, void *arg, struct pt_regs *regs)
+{
+	struct stress_test_ctx *ctx = arg;
+	int *depth = this_cpu_ptr(&stress_reinject_cpu_depth);
+
+	(*depth)++;
+	if (*depth < STRESS_REINJECT_DEPTH)
+		sse_test_signal(evt, smp_processor_id());
+	else
+		*depth = 0;
+
+	atomic_inc(&ctx->handler_count);
+
+	return 0;
+}
+
+static sse_event_handler_fn *stress_handlers[] = {
+	stress_handler_empty,
+	stress_handler_ecall,
+	stress_handler_pmu,
+	stress_handler_reinject,
+};
+
+static const char * const stress_layer_names[] = {
+	"empty handler",
+	"SBI ecall in handler",
+	"PMU stop/start in handler",
+	"self re-inject",
+};
+
+static enum hrtimer_restart stress_timer_callback(struct hrtimer *timer)
+{
+	struct stress_test_ctx *ctx = container_of(timer, struct stress_test_ctx, timer);
+
+	if (!READ_ONCE(ctx->running))
+		return HRTIMER_NORESTART;
+
+	sse_test_signal(ctx->evt_id, smp_processor_id());
+	atomic_inc(&ctx->inject_count);
+	hrtimer_forward_now(timer, ns_to_ktime(STRESS_INJECT_NS));
+
+	return HRTIMER_RESTART;
+}
+
+static enum hrtimer_restart stress_stop_timer_callback(struct hrtimer *timer)
+{
+	struct stress_test_ctx *ctx;
+
+	ctx = container_of(timer, struct stress_test_ctx, stop_timer);
+	WRITE_ONCE(ctx->test_done, true);
+	wake_up(&ctx->wait_q);
+
+	return HRTIMER_NORESTART;
+}
+
+static int stress_monitor_thread(void *data)
+{
+	struct stress_test_ctx *ctx = data;
+	unsigned long last_inject = 0, last_handler = 0;
+
+	while (!kthread_should_stop() && READ_ONCE(ctx->running)) {
+		unsigned long inject = atomic_read(&ctx->inject_count);
+		unsigned long handler = atomic_read(&ctx->handler_count);
+
+		pr_info("stress layer %d: inject=%lu (+%lu), handler=%lu (+%lu)\n",
+			ctx->layer, inject, inject - last_inject,
+			handler, handler - last_handler);
+
+		last_inject = inject;
+		last_handler = handler;
+
+		schedule_timeout_interruptible(HZ);
+	}
+
+	return 0;
+}
+
+static int sse_stress_test_layer(int layer)
+{
+	struct sse_event *event;
+	int ret;
+
+	if (layer < 0 || layer >= ARRAY_SIZE(stress_handlers))
+		return -EINVAL;
+
+	pr_info("Starting SSE stress layer %d (%s)\n",
+		layer, stress_layer_names[layer]);
+
+	memset(&stress_ctx, 0, sizeof(stress_ctx));
+	stress_ctx.evt_id = SBI_SSE_EVENT_LOCAL_SOFTWARE_INJECTED;
+	stress_ctx.layer = layer;
+	WRITE_ONCE(stress_ctx.running, true);
+	atomic_set(&stress_ctx.inject_count, 0);
+	atomic_set(&stress_ctx.handler_count, 0);
+	init_waitqueue_head(&stress_ctx.wait_q);
+
+	event = sse_event_register(stress_ctx.evt_id, 0,
+				   stress_handlers[layer], &stress_ctx);
+	if (IS_ERR(event)) {
+		sse_err("Failed to register stress event, err %ld\n",
+			PTR_ERR(event));
+		return PTR_ERR(event);
+	}
+
+	stress_ctx.event = event;
+
+	ret = sse_event_enable(event);
+	if (ret) {
+		sse_err("Failed to enable stress event, err %d\n", ret);
+		goto err_unregister;
+	}
+
+	stress_ctx.monitor_task = kthread_run(stress_monitor_thread,
+					      &stress_ctx, "sse_stress_mon");
+	if (IS_ERR(stress_ctx.monitor_task)) {
+		ret = PTR_ERR(stress_ctx.monitor_task);
+		sse_err("Failed to create stress monitor thread, err %d\n", ret);
+		goto err_disable;
+	}
+
+	hrtimer_setup(&stress_ctx.timer, stress_timer_callback,
+		      CLOCK_MONOTONIC, HRTIMER_MODE_PINNED);
+	hrtimer_start(&stress_ctx.timer, ns_to_ktime(STRESS_INJECT_NS),
+		      HRTIMER_MODE_REL_PINNED);
+
+	hrtimer_setup(&stress_ctx.stop_timer, stress_stop_timer_callback,
+		      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_start(&stress_ctx.stop_timer, ms_to_ktime(STRESS_DURATION_MS),
+		      HRTIMER_MODE_REL);
+
+	wait_event(stress_ctx.wait_q, READ_ONCE(stress_ctx.test_done));
+
+	WRITE_ONCE(stress_ctx.running, false);
+	hrtimer_cancel(&stress_ctx.timer);
+	hrtimer_cancel(&stress_ctx.stop_timer);
+	kthread_stop(stress_ctx.monitor_task);
+
+	pr_info("Finished SSE stress layer %d (%s): inject=%d, handler=%d\n",
+		layer, stress_layer_names[layer],
+		atomic_read(&stress_ctx.inject_count),
+		atomic_read(&stress_ctx.handler_count));
+
+err_disable:
+	sse_event_disable(event);
+err_unregister:
+	sse_event_unregister(event);
+
+	return ret;
+}
+
+static void sse_stress_test_all_layers(void)
+{
+	int i, ret;
+
+	pr_info("Starting SSE stress tests: duration=%d ms, interval=%d ns\n",
+		STRESS_DURATION_MS, STRESS_INJECT_NS);
+
+	for (i = 0; i < ARRAY_SIZE(stress_handlers); i++) {
+		ret = sse_stress_test_layer(i);
+		if (ret)
+			sse_err("Stress layer %d failed, err %d\n", i, ret);
+
+		msleep(100);
+	}
+
+	pr_info("Finished SSE stress tests\n");
+}
+
+static int __init sse_test_init(void)
+{
+	if (stress < SSE_STRESS_OFF || stress > SSE_STRESS_ONLY) {
+		sse_err("Invalid stress mode %d\n", stress);
+		return -EINVAL;
+	}
+
+	sse_init_events();
+
+	if (stress != SSE_STRESS_ONLY) {
+		sse_test_injection_fast();
+		sse_test_injection_priority();
+	}
+
+	if (stress != SSE_STRESS_OFF)
+		sse_stress_test_all_layers();
+
+	return 0;
+}
+
+static void __exit sse_test_exit(void)
+{
+}
+
+module_init(sse_test_init);
+module_exit(sse_test_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Clément Léger <cleger@rivosinc.com>");
+MODULE_DESCRIPTION("Test module for SSE");
diff --git a/tools/testing/selftests/riscv/sse/run_sse_test.sh b/tools/testing/selftests/riscv/sse/run_sse_test.sh
new file mode 100644
index 000000000000..c8eb1ce51682
--- /dev/null
+++ b/tools/testing/selftests/riscv/sse/run_sse_test.sh
@@ -0,0 +1,48 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2025 Rivos Inc.
+
+MODULE_NAME=riscv_sse_test
+DRIVER="./module/${MODULE_NAME}.ko"
+
+check_test_failed_prefix() {
+	if dmesg | grep -q "${MODULE_NAME}: FAILED:";then
+		echo "${MODULE_NAME} failed, please check dmesg"
+		exit 1
+	fi
+}
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+check_test_requirements()
+{
+	uid=$(id -u)
+	if [ $uid -ne 0 ]; then
+		echo "$0: Must be run as root"
+		exit $ksft_skip
+	fi
+
+	if ! which insmod > /dev/null 2>&1; then
+		echo "$0: You need insmod installed"
+		exit $ksft_skip
+	fi
+
+	if [ ! -f $DRIVER ]; then
+		echo "$0: You need to compile ${MODULE_NAME} module"
+		exit $ksft_skip
+	fi
+}
+
+check_test_requirements
+
+if ! insmod $DRIVER "$@" > /dev/null 2>&1; then
+	echo "${MODULE_NAME}: failed to load, please check dmesg"
+	exit 1
+fi
+
+rmmod $MODULE_NAME
+check_test_failed_prefix
+
+exit 0
-- 
2.50.1 (Apple Git-155)
