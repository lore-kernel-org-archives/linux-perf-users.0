Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009AF443C1C
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Sep 2026 12:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789129106; cv=none; b=FUTlpZT2/WtqRTBpOmvNNmQWpAxDILPQCME8+kKKbwpxegfFgjUhVpD+Yb2D9xKhmHz5pZyHFVPk8ZRCPioy0EjR+Fa+Rk25LzwMPyy3tUQ15rOJ5n2oL3VvEaxBu8YHmUDeSV+llSBpg2MH3C/K3+mQmXazUwiqNQyhcno7OiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789129106; c=relaxed/simple;
	bh=ecWbsHkDohV9HpvlUochbfYy8/6I6I/Zva001j3dlhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UnP7cqXcv1deYUnllBqpQPcuV2VQfhwJpWCftEMARp3+jHYMfHeEXSSYeuQJkFwSUM6NKvYEuxxnc0fkD9aKvWHVbzDi+x+xkkXbjC6FiATq85OtwhfCZ94XGWtSylmp00h0dMXJMW19W+4LflwyrZ0XM4G9qnEH7ShG5XJcPy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Zi9sUZGr; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Zi9sUZGr"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-86959a6f7f6so640195b3a.2
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Sep 2026 05:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789129093; x=1789733893; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H2kKJ/otpfmq2C/dfVeiTAO3V8lFWPgoLmHcveBqE+4=;
        b=Zi9sUZGr75W0ppHb5PdCk36Zfz5ah9gkJ1BTRLTBcJcn8swadwotuO1T4pxYdOAOof
         QPXuMEA0fDgE6Fcq41OwK1c/i3jOJ2oB52IsGhelibMSJKObHxS+YyBTr/izu8AqffAx
         kg24ZSUoOl84M7FaApcTLzMuILd2EU+NQbQjxFIbX229BO4lv9W7jXYN1MPM4TN2YhSP
         ZI6xp3O4R0oxVLDef1wmN1351NhlYUZxrRgRocBPeFEuM/OcojpDPTab/66byvC2ShCh
         VpQFPwO8OPqeKOK9gCapjqesqRfw2kHsll1+Q/QAGNfXthzf57hsPMsk7JSjr1yBNURJ
         BT/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789129093; x=1789733893;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H2kKJ/otpfmq2C/dfVeiTAO3V8lFWPgoLmHcveBqE+4=;
        b=CLmjjJ2Ls2itjgeORB1xgQHIdFrSNSPeOZmTtO1ajxduy8J/p6A78DxP8pfs/o1wYs
         9W5xrwhVi9Gs8iW240YceIsTZwtBtE0JObOUWced7/rp1VslZ7EUQvzPIDej8wrLcOff
         gqJOXWjGRpO4QLV4jhNMzIbQ+QSrLa9DGJyLr+Nkee1Xsi0iNFHUGqPEqQGz24gA+ytM
         dO2kLxQCuPEuwcUhoObiYl5qPDjpt8dnbsvEVbjNuyqDPWGV/YHvrhWUf93o1D5aU4D6
         UgCTludtih54pQWP3EoeEhn4S5xjFKAbXzA6hy+O7xcVPIBfSIz5Q8Oyv2dt+nj1IFFS
         kf2Q==
X-Forwarded-Encrypted: i=1; AKwUvBytO9mXBI0tOlB1A64HdDVoPqpl93edd8Bbcs2et5/mLeCc8CCdcOfaLhib8XzzePiOwNJjT/Y8PFFHIWBG/9Bk@vger.kernel.org
X-Gm-Message-State: AFuF++l/W09sEHHgAmUxI2bBTL/w9vEV+zmXDzWF6tSjs5yd1bE1IRfw
	PhFl0lijTG641RAZ3kIFXIfMQtqmoKAWsGnuSiacKCnU0lDxx5PLrat3Tam0ASb125o=
X-Gm-Gg: AYBFou0n3MEIRKORy2DiyYw0rrpdFteK8g22Sym/vLkQH7NrD3MV+LwGT+PKii56Z7V
	y4felzC6hBIkcNrs2N6gxcxf2y9WDJBCoSQi6qcn/3Kl2DeVHrskHwAnGqZTb203U9CpIS6Hz/+
	0iSiX7etT0kEnLEZEc0/uDdWPviHE8NsOvMqpKr+MNh+3gX1sq+M+X8KZ5favyDpBR6czHgdcCK
	XTOegX0ltr1Qj0GPTu1ikvVrjA2+7jSxzwR919ZnVvJuDTzvHmNxdwye1waPGIiU+JweruRserN
	EHIV230v/mB5PxhORdPNODM0SF018OeR53ts3t6iNw0HWs3akrmBrcUPeOjfyUKFg8M6+Cudrr7
	s3x4CCQhq8F9G02vg2aHoKHN3Wqy6NzBJ6rKqrVCEJ8KJQDHa7fwtn3fW7IHzL5QNMAraBhOk47
	Zk840Od5KqVcCYlIGkBokuHPU3HBOc19ItgwU3yrafFCRN+7J4qMb8mR2olripTA09c1gJZmWrC
	xN8QVacwSkGVTF79dolOQq6AWPkyZz8DN1OwyLA+A==
X-Received: by 2002:a05:6a20:b598:b0:3d9:3626:1326 with SMTP id adf61e73a8af0-3daed14f694mr6396589637.2.1789129092961;
        Fri, 11 Sep 2026 05:18:12 -0700 (PDT)
Received: from FJ7FR2JRQ3 ([2409:8a28:f48:3091:908c:b537:572a:4db0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33baf0ea9a1sm3178278eec.8.2026.09.11.05.17.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 11 Sep 2026 05:18:12 -0700 (PDT)
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>,
	Conor Dooley <conor@kernel.org>,
	Anup Patel <anup@brainfault.org>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Atish Patra <atish.patra@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Yuanzhu <yuanzhu@bytedance.com>,
	Yicong Yang <yang.yicong@picoheart.com>,
	Susheng Yang <yang.susheng@zte.com.cn>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Subject: [PATCH v10 8/9] selftests/riscv: add SSE test module
Date: Fri, 11 Sep 2026 20:14:55 +0800
Message-ID: <20260911121456.33223-9-zhangzhanpeng.jasper@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260911121456.33223-1-zhangzhanpeng.jasper@bytedance.com>
References: <20260911121456.33223-1-zhangzhanpeng.jasper@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Clément Léger <cleger@rivosinc.com>

Add an SSE selftest module and runner. Loading the module executes
smoke tests for the SSE framework, and the runner reports any error
emitted by the module.

Add stress={0,1,2} modes to exercise repeated handler entry and
completion, single and multiple read-only SBI calls from a handler, and
self re-injection. Check the SBI return values so handler execution alone
cannot produce a false pass, and avoid touching an unreserved PMU counter
owned by another user.

Harden the test against false failures and leaks by using TEST_PROGS for
the runner, using phys_addr_t for SBI attribute buffers, adding timeouts
to busy waits, pinning each priority chain with migrate_disable(), and
holding the CPU read lock while a fast-test target is selected, injected,
and completed. Unregister all registered events on error, check teardown
failures, and let kthread_stop() drive monitor-thread exit.

Track handler progress across fast, priority, and stress paths. If
firmware reports injectable events but the test cannot acquire or handle
any of them, report SKIP instead of silently passing a capability-only
run.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Co-developed-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Co-developed-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
---
 MAINTAINERS                                   |    2 +
 tools/testing/selftests/riscv/Makefile        |    2 +-
 tools/testing/selftests/riscv/sse/Makefile    |    5 +
 .../selftests/riscv/sse/module/Makefile       |   22 +
 .../riscv/sse/module/riscv_sse_test.c         | 1154 +++++++++++++++++
 .../selftests/riscv/sse/run_sse_test.sh       |   59 +
 6 files changed, 1243 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/riscv/sse/Makefile
 create mode 100644 tools/testing/selftests/riscv/sse/module/Makefile
 create mode 100644 tools/testing/selftests/riscv/sse/module/riscv_sse_test.c
 create mode 100644 tools/testing/selftests/riscv/sse/run_sse_test.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index 91b4e32a1fb2..ca27ca62f298 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23318,6 +23318,7 @@ C:	irc://irc.libera.chat/riscv
 P:	Documentation/arch/riscv/patch-acceptance.rst
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
 F:	arch/riscv/
+F:	tools/testing/selftests/riscv/
 N:	riscv
 K:	riscv
 
@@ -23443,6 +23444,7 @@ F:	arch/riscv/kernel/sbi_sse.c
 F:	arch/riscv/kernel/sbi_sse_entry.S
 F:	drivers/firmware/riscv/riscv_sbi_sse.c
 F:	include/linux/riscv_sbi_sse.h
+F:	tools/testing/selftests/riscv/sse/
 
 RISC-V TENSTORRENT SoC SUPPORT
 M:	Drew Fustini <dfustini@oss.tenstorrent.com>
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
index 000000000000..7e2677fdce09
--- /dev/null
+++ b/tools/testing/selftests/riscv/sse/Makefile
@@ -0,0 +1,5 @@
+TEST_GEN_MODS_DIR := module
+
+TEST_PROGS := run_sse_test.sh
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/riscv/sse/module/Makefile b/tools/testing/selftests/riscv/sse/module/Makefile
new file mode 100644
index 000000000000..eac4b1c6228b
--- /dev/null
+++ b/tools/testing/selftests/riscv/sse/module/Makefile
@@ -0,0 +1,22 @@
+ifneq ($(CONFIG_RISCV_SBI_SSE),)
+obj-m += riscv_sse_test.o
+endif
+
+ifndef KERNELRELEASE
+
+TESTMODS_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
+KDIR ?= /lib/modules/$(shell uname -r)/build
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
+
+endif
diff --git a/tools/testing/selftests/riscv/sse/module/riscv_sse_test.c b/tools/testing/selftests/riscv/sse/module/riscv_sse_test.c
new file mode 100644
index 000000000000..cc5c2e46f2fd
--- /dev/null
+++ b/tools/testing/selftests/riscv/sse/module/riscv_sse_test.c
@@ -0,0 +1,1154 @@
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
+#include <linux/cpu.h>
+#include <linux/cpuhplock.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/hrtimer.h>
+#include <linux/io.h>
+#include <linux/jiffies.h>
+#include <linux/kthread.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/riscv_sbi_sse.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/smp.h>
+#include <linux/workqueue.h>
+
+#include <asm/sbi.h>
+#include <asm/sse.h>
+
+#define RUN_LOOP_COUNT		1000
+#define SSE_FAILED_PREFIX	"FAILED: "
+#define SSE_SKIP_PREFIX		"SKIP: "
+#define STRESS_DURATION_MS	3000
+#define STRESS_INJECT_NS	10000
+#define STRESS_REINJECT_DEPTH	10
+#define sse_err(...)		pr_err(SSE_FAILED_PREFIX __VA_ARGS__)
+#define sse_skip(...)		pr_info(SSE_SKIP_PREFIX __VA_ARGS__)
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
+static char *run_id = "unknown";
+module_param(run_id, charp, 0444);
+MODULE_PARM_DESC(run_id, "Unique identifier used to delimit one test run");
+
+/* Do not report PASS for a capability-only run that handled no event. */
+static atomic_t sse_test_handler_count = ATOMIC_INIT(0);
+static bool sse_stress_event_can_inject;
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
+static DEFINE_MUTEX(sse_test_cleanup_lock);
+/* Firmware permits only one registration for each event ID. */
+static struct sse_event *sse_test_cleanup_events[ARRAY_SIZE(sse_event_descs)];
+
+static void sse_test_cleanup_workfn(struct work_struct *work);
+static DECLARE_DELAYED_WORK(sse_test_cleanup_work, sse_test_cleanup_workfn);
+
+static void sse_test_queue_cleanup(struct sse_event *event)
+{
+	int i, free_slot = -1;
+
+	mutex_lock(&sse_test_cleanup_lock);
+	for (i = 0; i < ARRAY_SIZE(sse_test_cleanup_events); i++) {
+		if (sse_test_cleanup_events[i] == event)
+			goto out_schedule;
+		if (!sse_test_cleanup_events[i] && free_slot < 0)
+			free_slot = i;
+	}
+
+	if (WARN_ON_ONCE(free_slot < 0))
+		goto out_unlock;
+
+	sse_test_cleanup_events[free_slot] = event;
+
+out_schedule:
+	mod_delayed_work(system_wq, &sse_test_cleanup_work,
+			 msecs_to_jiffies(100));
+out_unlock:
+	mutex_unlock(&sse_test_cleanup_lock);
+}
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
+/*
+ * Firmware can invoke the callback until unregister succeeds. Pin the module
+ * so its handler text cannot disappear first.
+ */
+static struct sse_event *sse_test_event_register(u32 evt, u32 priority,
+						 sse_event_handler_fn *handler,
+						 void *arg)
+{
+	struct sse_event *event;
+
+	event = sse_event_register(evt, priority, handler, arg);
+	if (!IS_ERR(event))
+		__module_get(THIS_MODULE);
+
+	return event;
+}
+
+static int sse_test_event_unregister(struct sse_event *event)
+{
+	int ret;
+
+	ret = sse_event_unregister(event);
+	if (!ret)
+		module_put(THIS_MODULE);
+	else
+		sse_test_queue_cleanup(event);
+
+	return ret;
+}
+
+static void sse_test_cleanup_workfn(struct work_struct *work)
+{
+	bool retry = false;
+	int i, ret;
+
+	mutex_lock(&sse_test_cleanup_lock);
+	for (i = 0; i < ARRAY_SIZE(sse_test_cleanup_events); i++) {
+		struct sse_event *event = sse_test_cleanup_events[i];
+
+		if (!event)
+			continue;
+
+		ret = sse_event_disable(event);
+		if (!ret)
+			ret = sse_event_unregister(event);
+		if (ret) {
+			retry = true;
+			continue;
+		}
+
+		sse_test_cleanup_events[i] = NULL;
+		module_put(THIS_MODULE);
+	}
+	mutex_unlock(&sse_test_cleanup_lock);
+
+	if (retry)
+		mod_delayed_work(system_wq, &sse_test_cleanup_work,
+				 msecs_to_jiffies(100));
+}
+
+static struct sbiret sbi_sse_ecall(int fid, unsigned long arg0, unsigned long arg1)
+{
+	return sbi_ecall(SBI_EXT_SSE, fid, arg0, arg1, 0, 0, 0, 0);
+}
+
+static int sse_event_attr_read(u32 evt, unsigned long attr_id,
+			       unsigned long *attr_buf)
+{
+	struct sbiret sret;
+	phys_addr_t phys;
+
+	phys = virt_to_phys(attr_buf);
+
+	sret = sbi_ecall(SBI_EXT_SSE, SBI_SSE_EVENT_ATTR_READ, evt, attr_id, 1,
+			 (unsigned long)phys, 0, 0);
+	if (sret.error)
+		return sbi_err_map_linux_errno(sret.error);
+
+	return 0;
+}
+
+static int sse_event_attr_get(u32 evt, unsigned long attr_id,
+			      unsigned long *val)
+{
+	unsigned long *attr_buf;
+	int ret;
+
+	attr_buf = kmalloc_obj(*attr_buf, GFP_KERNEL);
+	if (!attr_buf)
+		return -ENOMEM;
+
+	ret = sse_event_attr_read(evt, attr_id, attr_buf);
+	if (!ret)
+		*val = *attr_buf;
+	kfree(attr_buf);
+
+	return ret;
+}
+
+static int sse_test_signal(u32 evt, unsigned int cpu)
+{
+	unsigned long hart_id = cpuid_to_hartid_map(cpu);
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
+static int sse_test_wait_not_running(u32 evt)
+{
+	unsigned long timeout = jiffies + HZ;
+	unsigned long status;
+	int ret;
+
+	do {
+		ret = sse_event_attr_get(evt, SBI_SSE_ATTR_STATUS, &status);
+		if (ret) {
+			sse_err("Failed to get status for evt %x, error %d\n", evt, ret);
+			return ret;
+		}
+		status &= SBI_SSE_ATTR_STATUS_STATE_MASK;
+		cpu_relax();
+	} while (status == SBI_SSE_STATE_RUNNING && time_before(jiffies, timeout));
+
+	if (status == SBI_SSE_STATE_RUNNING) {
+		sse_err("Timed out waiting for event %x to leave RUNNING state\n", evt);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+struct sse_test_wait_status {
+	u32 evt;
+	unsigned long *attr_buf;
+	unsigned long status;
+	int ret;
+};
+
+static void sse_test_read_status_local(void *info)
+{
+	struct sse_test_wait_status *wait = info;
+
+	wait->ret = sse_event_attr_read(wait->evt, SBI_SSE_ATTR_STATUS,
+					wait->attr_buf);
+	if (!wait->ret)
+		wait->status = *wait->attr_buf & SBI_SSE_ATTR_STATUS_STATE_MASK;
+}
+
+static int sse_test_wait_not_running_on_cpu(u32 evt, unsigned int cpu)
+{
+	struct sse_test_wait_status wait = { .evt = evt };
+	unsigned long timeout;
+	int ret = 0;
+
+	if (sse_event_is_global(evt))
+		return sse_test_wait_not_running(evt);
+
+	wait.attr_buf = kmalloc_obj(*wait.attr_buf, GFP_KERNEL);
+	if (!wait.attr_buf)
+		return -ENOMEM;
+
+	timeout = jiffies + HZ;
+	do {
+		ret = smp_call_function_single(cpu, sse_test_read_status_local,
+					       &wait, true);
+		if (ret || wait.ret) {
+			ret = ret ?: wait.ret;
+			break;
+		}
+		if (wait.status != SBI_SSE_STATE_RUNNING)
+			break;
+		usleep_range(100, 200);
+	} while (time_before(jiffies, timeout));
+
+	if (!ret && wait.status == SBI_SSE_STATE_RUNNING) {
+		sse_err("Timed out waiting for event %x on CPU %u\n", evt, cpu);
+		ret = -ETIMEDOUT;
+	}
+
+	kfree(wait.attr_buf);
+
+	return ret;
+}
+
+static int sse_test_inject_event(struct sse_event *event, u32 evt, unsigned int cpu)
+{
+	int res;
+
+	if (sse_event_is_global(evt)) {
+		/*
+		 * Due to the fact the completion might happen faster than
+		 * the call to SBI_SSE_COMPLETE in the handler, if the event was
+		 * running on another CPU, we need to wait for the event status
+		 * to be !RUNNING.
+		 */
+		res = sse_test_wait_not_running(evt);
+		if (res)
+			return res;
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
+	bool args_ready;
+	bool completion;
+};
+
+/* A failed unregister may leave firmware holding this handler argument. */
+static struct fast_test_arg fast_test_arg;
+
+static int sse_test_handler(u32 evt, void *arg, struct pt_regs *regs)
+{
+	int ret = 0;
+	struct fast_test_arg *targ = arg;
+	u32 test_evt;
+	int cpu;
+
+	atomic_inc(&sse_test_handler_count);
+
+	/* Pairs with the argument publication in sse_run_fast_test_cpu(). */
+	if (!smp_load_acquire(&targ->args_ready)) {
+		sse_err("Received SSE event %x before its test arguments were published\n",
+			evt);
+		ret = -EINVAL;
+		goto complete;
+	}
+
+	test_evt = READ_ONCE(targ->evt);
+	cpu = READ_ONCE(targ->cpu);
+
+	if (evt != test_evt) {
+		sse_err("Received SSE event id %x instead of %x\n", test_evt, evt);
+		ret = -EINVAL;
+	}
+
+	if (!sse_event_is_global(evt) && cpu != smp_processor_id()) {
+		sse_err("Received SSE event %d on CPU %d instead of %d\n", evt, smp_processor_id(),
+			cpu);
+		ret = -EINVAL;
+	}
+
+complete:
+	WRITE_ONCE(targ->args_ready, false);
+	/* Publish handler-side checks before waking the waiting CPU. */
+	smp_store_release(&targ->completion, true);
+
+	return ret;
+}
+
+static int sse_run_fast_test_cpu(struct fast_test_arg *test_arg,
+				 struct sse_event *event, u32 evt, int cpu)
+{
+	unsigned long timeout;
+	int ret;
+
+	WRITE_ONCE(test_arg->completion, false);
+	WRITE_ONCE(test_arg->args_ready, false);
+	WRITE_ONCE(test_arg->evt, evt);
+	WRITE_ONCE(test_arg->cpu, cpu);
+	/* Publish all arguments before firmware can inject on another hart. */
+	smp_store_release(&test_arg->args_ready, true);
+
+	ret = sse_test_inject_event(event, evt, cpu);
+	if (ret) {
+		sse_err("event %s injection failed, err %d\n",
+			sse_evt_name(evt), ret);
+		return ret;
+	}
+
+	timeout = jiffies + HZ / 100;
+	/* We can not use <linux/completion.h> since they are not NMI safe */
+	/* Pairs with the handler's completion publication. */
+	while (!smp_load_acquire(&test_arg->completion) &&
+	       time_before(jiffies, timeout))
+		cpu_relax();
+	/* Acquire the handler's checks even if the loop observed a timeout. */
+	if (!smp_load_acquire(&test_arg->completion)) {
+		sse_err("Failed to wait for event %s completion on CPU %d\n",
+			sse_evt_name(evt), cpu);
+		return -ETIMEDOUT;
+	}
+
+	return sse_test_wait_not_running_on_cpu(evt, cpu);
+}
+
+static void sse_run_fast_test(struct fast_test_arg *test_arg,
+			      struct sse_event *event, u32 evt)
+{
+	int cpu;
+
+	if (sse_event_is_global(evt)) {
+		/* Keep the selected target online through injection and completion. */
+		cpu_hotplug_disable();
+		for_each_online_cpu(cpu) {
+			if (sse_run_fast_test_cpu(test_arg, event, evt, cpu))
+				break;
+		}
+		cpu_hotplug_enable();
+		return;
+	}
+
+	guard(cpus_read_lock)();
+	for_each_online_cpu(cpu) {
+		if (sse_run_fast_test_cpu(test_arg, event, evt, cpu))
+			return;
+	}
+}
+
+static void sse_test_injection_fast(void)
+{
+	int i, ret = 0, j;
+	u32 evt;
+	struct sse_event *event;
+
+	pr_info("Starting SSE test (fast)\n");
+
+	for (i = 0; i < ARRAY_SIZE(sse_event_descs); i++) {
+		evt = sse_event_descs[i].evt_id;
+		WRITE_ONCE(fast_test_arg.evt, evt);
+		WRITE_ONCE(fast_test_arg.cpu, -1);
+		WRITE_ONCE(fast_test_arg.args_ready, false);
+		WRITE_ONCE(fast_test_arg.completion, false);
+
+		if (!sse_event_descs[i].can_inject)
+			continue;
+
+		event = sse_test_event_register(evt, 0, sse_test_handler,
+						(void *)&fast_test_arg);
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
+			goto err_disable;
+		}
+
+		pr_info("Starting testing event %s\n", sse_evt_name(evt));
+
+		for (j = 0; j < RUN_LOOP_COUNT; j++)
+			sse_run_fast_test(&fast_test_arg, event, evt);
+		pr_info("Finished testing event %s\n", sse_evt_name(evt));
+
+err_disable:
+		ret = sse_event_disable(event);
+		if (ret)
+			sse_err("Failed to disable event %s, err %d\n",
+				sse_evt_name(evt), ret);
+		ret = sse_test_event_unregister(event);
+		if (ret) {
+			sse_err("Failed to unregister event %s, err %d\n",
+				sse_evt_name(evt), ret);
+			return;
+		}
+	}
+	pr_info("Finished SSE test (fast)\n");
+}
+
+struct priority_test_arg {
+	unsigned long evt;
+	struct sse_event *event;
+	bool called;
+	bool enable_attempted;
+	u32 prio;
+	struct priority_test_arg *next_evt_arg;
+	void (*check_func)(struct priority_test_arg *arg);
+};
+
+/* A failed unregister may leave firmware holding these handler arguments. */
+static struct priority_test_arg default_hi_prio_args[] = {
+	{ .evt = SBI_SSE_EVENT_GLOBAL_SOFTWARE_INJECTED },
+	{ .evt = SBI_SSE_EVENT_LOCAL_SOFTWARE_INJECTED },
+	{ .evt = SBI_SSE_EVENT_GLOBAL_LOW_PRIO_RAS },
+	{ .evt = SBI_SSE_EVENT_LOCAL_LOW_PRIO_RAS },
+	{ .evt = SBI_SSE_EVENT_LOCAL_PMU_OVERFLOW },
+	{ .evt = SBI_SSE_EVENT_GLOBAL_HIGH_PRIO_RAS },
+	{ .evt = SBI_SSE_EVENT_LOCAL_DOUBLE_TRAP },
+	{ .evt = SBI_SSE_EVENT_LOCAL_HIGH_PRIO_RAS },
+};
+
+static struct priority_test_arg default_low_prio_args[] = {
+	{ .evt = SBI_SSE_EVENT_LOCAL_HIGH_PRIO_RAS },
+	{ .evt = SBI_SSE_EVENT_LOCAL_DOUBLE_TRAP },
+	{ .evt = SBI_SSE_EVENT_GLOBAL_HIGH_PRIO_RAS },
+	{ .evt = SBI_SSE_EVENT_LOCAL_PMU_OVERFLOW },
+	{ .evt = SBI_SSE_EVENT_LOCAL_LOW_PRIO_RAS },
+	{ .evt = SBI_SSE_EVENT_GLOBAL_LOW_PRIO_RAS },
+	{ .evt = SBI_SSE_EVENT_LOCAL_SOFTWARE_INJECTED },
+	{ .evt = SBI_SSE_EVENT_GLOBAL_SOFTWARE_INJECTED },
+};
+
+static struct priority_test_arg set_prio_args[] = {
+	{ .evt = SBI_SSE_EVENT_GLOBAL_SOFTWARE_INJECTED, .prio = 5 },
+	{ .evt = SBI_SSE_EVENT_LOCAL_SOFTWARE_INJECTED, .prio = 10 },
+	{ .evt = SBI_SSE_EVENT_GLOBAL_LOW_PRIO_RAS, .prio = 15 },
+	{ .evt = SBI_SSE_EVENT_LOCAL_LOW_PRIO_RAS, .prio = 20 },
+	{ .evt = SBI_SSE_EVENT_LOCAL_PMU_OVERFLOW, .prio = 25 },
+	{ .evt = SBI_SSE_EVENT_GLOBAL_HIGH_PRIO_RAS, .prio = 30 },
+	{ .evt = SBI_SSE_EVENT_LOCAL_DOUBLE_TRAP, .prio = 35 },
+	{ .evt = SBI_SSE_EVENT_LOCAL_HIGH_PRIO_RAS, .prio = 40 },
+};
+
+static struct priority_test_arg same_prio_args[] = {
+	{ .evt = SBI_SSE_EVENT_LOCAL_PMU_OVERFLOW, .prio = 0 },
+	{ .evt = SBI_SSE_EVENT_LOCAL_HIGH_PRIO_RAS, .prio = 10 },
+	{ .evt = SBI_SSE_EVENT_LOCAL_SOFTWARE_INJECTED, .prio = 10 },
+	{ .evt = SBI_SSE_EVENT_GLOBAL_SOFTWARE_INJECTED, .prio = 10 },
+	{ .evt = SBI_SSE_EVENT_GLOBAL_HIGH_PRIO_RAS, .prio = 20 },
+};
+
+static int sse_hi_priority_test_handler(u32 evt, void *arg,
+					struct pt_regs *regs)
+{
+	struct priority_test_arg *targ = arg;
+	struct priority_test_arg *next = READ_ONCE(targ->next_evt_arg);
+
+	atomic_inc(&sse_test_handler_count);
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
+	atomic_inc(&sse_test_handler_count);
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
+	unsigned long timeout;
+	int ret;
+	int target_cpu;
+	struct sse_event *event;
+	struct priority_test_arg *arg, *first_arg = NULL, *prev_arg = NULL;
+
+	pr_info("Starting SSE priority test (%s)\n", test_name);
+	/* Keep the complete priority chain on one CPU. */
+	migrate_disable();
+	target_cpu = smp_processor_id();
+
+	for (i = 0; i < args_size; i++) {
+		arg = &args[i];
+
+		if (!sse_test_can_inject_event(arg->evt))
+			continue;
+
+		WRITE_ONCE(arg->called, false);
+		WRITE_ONCE(arg->next_evt_arg, NULL);
+		WRITE_ONCE(arg->event, NULL);
+		WRITE_ONCE(arg->enable_attempted, false);
+
+		event = sse_test_event_register(arg->evt, arg->prio, handler,
+						(void *)arg);
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
+			/* Keep the chain on one stable CPU. */
+			ret = sse_event_set_target_cpu(event, target_cpu);
+			if (ret) {
+				sse_err("Failed to set event %s target CPU, err %d\n",
+					sse_evt_name(arg->evt), ret);
+				goto release_events;
+			}
+		}
+
+		WRITE_ONCE(arg->enable_attempted, true);
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
+		goto out;
+	}
+
+	/* Inject first event, handler should trigger the others in chain. */
+	ret = sse_test_inject_event(first_arg->event, first_arg->evt, target_cpu);
+	if (ret) {
+		sse_err("SSE event %s injection failed\n", sse_evt_name(first_arg->evt));
+		goto release_events;
+	}
+
+	/* Lower-priority events run after the handler that injected them completes. */
+	arg = first_arg;
+	while (arg) {
+		timeout = jiffies + HZ;
+		while (!READ_ONCE(arg->called) && time_before(jiffies, timeout))
+			cpu_relax();
+
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
+	for (i = 0; i < args_size; i++) {
+		arg = &args[i];
+		event = arg->event;
+		if (!event)
+			continue;
+
+		ret = sse_test_wait_not_running_on_cpu(arg->evt, target_cpu);
+		if (ret)
+			sse_err("Event %s did not complete, err %d\n",
+				sse_evt_name(arg->evt), ret);
+
+		if (arg->enable_attempted) {
+			ret = sse_event_disable(event);
+			if (ret) {
+				sse_err("Failed to disable event %s, err %d\n",
+					sse_evt_name(arg->evt), ret);
+				sse_test_queue_cleanup(event);
+				WRITE_ONCE(arg->event, NULL);
+				WRITE_ONCE(arg->enable_attempted, false);
+				continue;
+			}
+		}
+
+		ret = sse_test_event_unregister(event);
+		if (ret) {
+			sse_err("Failed to unregister event %s, err %d\n",
+				sse_evt_name(arg->evt), ret);
+			continue;
+		}
+
+		WRITE_ONCE(arg->event, NULL);
+		WRITE_ONCE(arg->enable_attempted, false);
+	}
+
+	pr_info("Finished SSE priority test (%s)\n", test_name);
+out:
+	migrate_enable();
+}
+
+static void sse_test_injection_priority(void)
+{
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
+static int sse_get_inject_status(u32 evt, bool *can_inject)
+{
+	int ret;
+	unsigned long val;
+
+	/* Check if injection is supported */
+	ret = sse_event_attr_get(evt, SBI_SSE_ATTR_STATUS, &val);
+	if (ret == sbi_err_map_linux_errno(SBI_ERR_NOT_SUPPORTED) ||
+	    ret == sbi_err_map_linux_errno(SBI_ERR_INVALID_PARAM)) {
+		*can_inject = false;
+		return 0;
+	}
+	if (ret)
+		return ret;
+
+	*can_inject = !!(val & BIT(SBI_SSE_ATTR_STATUS_INJECT_OFFSET));
+
+	return 0;
+}
+
+static int sse_init_events(void)
+{
+	int i, injectable = 0, ret;
+
+	for (i = 0; i < ARRAY_SIZE(sse_event_descs); i++) {
+		struct sse_event_desc *desc = &sse_event_descs[i];
+
+		ret = sse_get_inject_status(desc->evt_id, &desc->can_inject);
+		if (ret) {
+			sse_err("Failed to read injection status for %s, err %d\n",
+				desc->name, ret);
+			return ret;
+		}
+
+		if (desc->can_inject)
+			injectable++;
+		else
+			pr_info("Can not inject event %s, tests using this event will be skipped\n",
+				desc->name);
+
+		if (desc->evt_id == SBI_SSE_EVENT_LOCAL_SOFTWARE_INJECTED)
+			sse_stress_event_can_inject = desc->can_inject;
+	}
+
+	return injectable;
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
+	atomic_t handler_errors;
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
+	atomic_inc(&sse_test_handler_count);
+	atomic_inc(&ctx->handler_count);
+
+	return 0;
+}
+
+static int stress_handler_ecall(u32 evt, void *arg, struct pt_regs *regs)
+{
+	struct stress_test_ctx *ctx = arg;
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_BASE, SBI_EXT_BASE_GET_SPEC_VERSION,
+			0, 0, 0, 0, 0, 0);
+	if (ret.error)
+		atomic_inc(&ctx->handler_errors);
+	atomic_inc(&sse_test_handler_count);
+	atomic_inc(&ctx->handler_count);
+
+	return 0;
+}
+
+static int stress_handler_multi_ecall(u32 evt, void *arg, struct pt_regs *regs)
+{
+	struct stress_test_ctx *ctx = arg;
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_BASE, SBI_EXT_BASE_GET_SPEC_VERSION,
+			0, 0, 0, 0, 0, 0);
+	if (ret.error)
+		atomic_inc(&ctx->handler_errors);
+	ret = sbi_ecall(SBI_EXT_BASE, SBI_EXT_BASE_GET_IMP_ID,
+			0, 0, 0, 0, 0, 0);
+	if (ret.error)
+		atomic_inc(&ctx->handler_errors);
+	ret = sbi_ecall(SBI_EXT_BASE, SBI_EXT_BASE_GET_IMP_VERSION,
+			0, 0, 0, 0, 0, 0);
+	if (ret.error)
+		atomic_inc(&ctx->handler_errors);
+	atomic_inc(&sse_test_handler_count);
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
+	atomic_inc(&sse_test_handler_count);
+	atomic_inc(&ctx->handler_count);
+
+	return 0;
+}
+
+static sse_event_handler_fn *stress_handlers[] = {
+	stress_handler_empty,
+	stress_handler_ecall,
+	stress_handler_multi_ecall,
+	stress_handler_reinject,
+};
+
+static const char * const stress_layer_names[] = {
+	"empty handler",
+	"single SBI ecall in handler",
+	"multiple SBI ecalls in handler",
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
+	if (!sse_test_signal(ctx->evt_id, smp_processor_id()))
+		atomic_inc(&ctx->inject_count);
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
+	while (!kthread_should_stop()) {
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
+	int inject_count, handler_count;
+	int ret, target_cpu, unregister_ret;
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
+	atomic_set(&stress_ctx.handler_errors, 0);
+	init_waitqueue_head(&stress_ctx.wait_q);
+
+	event = sse_test_event_register(stress_ctx.evt_id, 0,
+					stress_handlers[layer], &stress_ctx);
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
+		goto err_disable;
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
+	/* Keep the pinned timer and its local event on the selected CPU. */
+	cpus_read_lock();
+	migrate_disable();
+	target_cpu = smp_processor_id();
+	hrtimer_setup(&stress_ctx.timer, stress_timer_callback,
+		      CLOCK_MONOTONIC, HRTIMER_MODE_PINNED);
+	hrtimer_start(&stress_ctx.timer, ns_to_ktime(STRESS_INJECT_NS),
+		      HRTIMER_MODE_REL_PINNED);
+	migrate_enable();
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
+	inject_count = atomic_read(&stress_ctx.inject_count);
+	handler_count = atomic_read(&stress_ctx.handler_count);
+	if (!inject_count || !handler_count) {
+		sse_err("Stress layer %d made no progress: inject=%d, handler=%d\n",
+			layer, inject_count, handler_count);
+		ret = -EIO;
+	}
+	if (atomic_read(&stress_ctx.handler_errors)) {
+		sse_err("Stress layer %d observed %d SBI call errors\n", layer,
+			atomic_read(&stress_ctx.handler_errors));
+		ret = -EIO;
+	}
+	if (sse_test_wait_not_running_on_cpu(stress_ctx.evt_id, target_cpu)) {
+		sse_err("Stress event did not complete on CPU %d\n", target_cpu);
+		if (!ret)
+			ret = -ETIMEDOUT;
+	}
+	cpus_read_unlock();
+
+err_disable:
+	if (sse_event_disable(event)) {
+		sse_err("Failed to disable stress event\n");
+		if (!ret)
+			ret = -EIO;
+	}
+	unregister_ret = sse_test_event_unregister(event);
+	if (unregister_ret) {
+		sse_err("Failed to unregister stress event\n");
+		if (!ret)
+			ret = unregister_ret;
+	}
+	stress_ctx.event = NULL;
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
+		if (ret) {
+			sse_err("Stress layer %d failed, err %d\n", i, ret);
+			break;
+		}
+
+		msleep(100);
+	}
+
+	pr_info("Finished SSE stress tests\n");
+}
+
+static int __init sse_test_init(void)
+{
+	int ret;
+
+	pr_info("RUN %s BEGIN\n", run_id);
+	atomic_set(&sse_test_handler_count, 0);
+
+	if (stress < SSE_STRESS_OFF || stress > SSE_STRESS_ONLY) {
+		sse_err("Invalid stress mode %d\n", stress);
+		pr_info("RUN %s END\n", run_id);
+		return -EINVAL;
+	}
+
+	ret = sse_init_events();
+	if (ret < 0) {
+		pr_info("RUN %s END\n", run_id);
+		return ret;
+	}
+	if (!ret) {
+		sse_skip("No injectable SSE event is available\n");
+		pr_info("RUN %s END\n", run_id);
+		return 0;
+	}
+	if (stress == SSE_STRESS_ONLY && !sse_stress_event_can_inject) {
+		sse_skip("Local software-injected event is unavailable for stress\n");
+		pr_info("RUN %s END\n", run_id);
+		return 0;
+	}
+
+	if (stress != SSE_STRESS_ONLY) {
+		sse_test_injection_fast();
+		sse_test_injection_priority();
+	}
+
+	if (stress == SSE_STRESS_AFTER_SMOKE && !sse_stress_event_can_inject)
+		sse_skip("Local software-injected event is unavailable for stress\n");
+	else if (stress != SSE_STRESS_OFF)
+		sse_stress_test_all_layers();
+	if (!atomic_read(&sse_test_handler_count))
+		sse_skip("No SSE event was handled\n");
+
+	pr_info("RUN %s END\n", run_id);
+
+	return 0;
+}
+
+static void __exit sse_test_exit(void)
+{
+	cancel_delayed_work_sync(&sse_test_cleanup_work);
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
index 000000000000..e70a2fd14b05
--- /dev/null
+++ b/tools/testing/selftests/riscv/sse/run_sse_test.sh
@@ -0,0 +1,59 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2025 Rivos Inc.
+
+MODULE_NAME=riscv_sse_test
+DRIVER="./module/${MODULE_NAME}.ko"
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
+	if [ ! -f "$DRIVER" ]; then
+		echo "$0: SSE is disabled or ${MODULE_NAME} is not built"
+		exit $ksft_skip
+	fi
+}
+
+check_test_requirements
+run_id="$$-$(date +%s)"
+
+if ! insmod "$DRIVER" run_id="$run_id" "$@" > /dev/null 2>&1; then
+	echo "${MODULE_NAME}: failed to load, please check dmesg"
+	exit 1
+fi
+
+if ! rmmod "$MODULE_NAME"; then
+	echo "${MODULE_NAME}: failed to unload, please check dmesg"
+	exit 1
+fi
+
+run_log=$(dmesg | sed -n \
+	"/${MODULE_NAME}: RUN ${run_id} BEGIN/,/${MODULE_NAME}: RUN ${run_id} END/p")
+if [ -z "$run_log" ]; then
+	echo "${MODULE_NAME}: unable to find log for run ${run_id}"
+	exit 1
+fi
+
+if echo "$run_log" | grep -q "${MODULE_NAME}: FAILED:"; then
+	echo "${MODULE_NAME} failed, please check dmesg"
+	exit 1
+fi
+
+if echo "$run_log" | grep -q "${MODULE_NAME}: SKIP:"; then
+	echo "${MODULE_NAME}: no injectable SSE event"
+	exit $ksft_skip
+fi
+
+exit 0
-- 
2.50.1 (Apple Git-155)

