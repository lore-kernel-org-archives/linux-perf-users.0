Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A427346D2B4
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Sep 2026 12:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789129024; cv=none; b=oV/6pQwTkuC65p6FTCh90aj+7/besdmrFLs3iaIL8wWCB6rFEZEbjvyvkdmIeR2pFp+NgaKqH6mIdIlHXt4/IpqSDhg7MdMGm3zEfBjcg0HUXY7KiGE4xZ8qSFNksEBv+jN80+Ktaq+3hnPDyDIBQOzQjqBAkCj8+1np8n/M3Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789129024; c=relaxed/simple;
	bh=UW055qidpWjj8fYsbtGf82g7Eh6VSvAwDift9+SjHFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oEBggxQGSnantJUbxKBtxAOjyw7xFNytc162tYLsP4xSnV9O8LqHGMpDCCJnjApUlkbJXWmfMGotqSslWOrh9akUXVBG7xJsnAfHgtOtQsj+uDgGYabNG5jfPxSoDDMYrQQdoykIA19gO8PyMYQ66CNxls81BGoxWfANQztpu64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RBAH/DFb; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RBAH/DFb"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cbedf433a99so933243a12.2
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Sep 2026 05:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789129013; x=1789733813; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=29WRZ9QMKSR5w3L8qTXfZEq2cJJHpjm4tC7mknOYQfs=;
        b=RBAH/DFbHt3PJra+0j1U6GKF2FllL2NWoxKC4ElmhCdgSxEpF08DEX0GUYYv2QQ/zC
         67Yy2KrxQsY1JUb3ZM4hvDAFB4qLc1RI21KC+HDvognQ2EVbs31LMSjCBHagLCc90jbJ
         7Pz2i4fNtDsmTSjmdqzJ2l9Nbqed6mt3NnZklo/3u4pn0XYUDcEA9LTaXH5KeejAyaFC
         hKNKTWc/Xb+7M+a2Gh81WEQWKZXeevNVVZBPGeT7aZ5WuZaw41WLAeJZgKFw0XLM4fM5
         qc3t7uEfP2Nt50MrVKxo26wHpoC5mZZo3Y6Gjl1A7w8mTqXeY+NTNsXLb4ytQlRY9ZBX
         /4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789129013; x=1789733813;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=29WRZ9QMKSR5w3L8qTXfZEq2cJJHpjm4tC7mknOYQfs=;
        b=BytDzV5qJMpKHz4qiP5SF9aDeUt3dCC+5164vwUZ536p1RZRFLb4YFMvV3K3C1Pm6N
         S3OHXARwDGD2H0BvlMH5wg0J8ZSAQrGVjoUmBo6qKRCnbMhsRUvaxFrOvMp3n3SC6yXJ
         wT3KJ5/vMDeJJ7n/Jfyc2Ca0ReiE7CaX/YWy8QIPt0qEn5+DtIP0J71HdI9KACXnB/d/
         dB3vuNAOcF0PKiERCos32SDeJ3Urrl8TV+QRw4l13FIaB4WKex1gQXo6uTOM01nVbCE0
         v2x4UnSONN0SzpD2K+ujFiPpiR3zDDH4J9dsIalv6Yeb9EXb9MMn41ft8m2Z/+tMD2ob
         /MVQ==
X-Forwarded-Encrypted: i=1; AKwUvBxjd0dIheH/l0tcrzWnJWnUGwZDOYMBfaF0pC34IRZh7RrZp263avzGAhCKarVUZ1MOhbX+pzq1KX8PF6Il+oiP@vger.kernel.org
X-Gm-Message-State: AFuF++md7/070z7SwY3JwQfYZe8yMIcjpHBVw6QGeOEfInnlYiXXl2eM
	yg61Juhwtez/jP2cjTMqtOW868tnAba82EZAxO7WCzIr15rhBpOkj3P1n9XqjtswPsU=
X-Gm-Gg: AYBFou0/A+xrleZoXpaJCetpmCNgJzyA64Siacu+SLknmyblM9IZmNTgRZGlQGOzvnV
	NQYnHWG9NMXx5Va/4zlBCrThLCPjTWlnbl/ppTbKd9Cqv1c44xU6ctLoxK9oxR/gjmlYlrBvUox
	vMhaDEKLXFhGIOaPS7Ye1hUB8XiB8j9s/7TphAd66kA+pw70JluIG0jsJDIAbPfnLhyWh+f0pjf
	Ry5AdDygPM9JAAcYz3XReLn7fhamrgANCPwducGOl5VAb3b1LIR0mDy9uC2wcCXaV7sLTSWFY2N
	DuvqYrQuIQxjxHqlBpjyjav+FnlJW9HDUy9RWlrx6Ed1O/6Re6QZHOLaQ0bsEAyxxQGIc1s/oQy
	9bcBT1BvCWaBM7lan20x59vHyQ5GrXTO59aHC1jW4SstGII1N3a4VfReasXYKYOl69Mxre7/u2S
	lkhzTkTyoDEnPaAB2RNVGLHmdxVfLnjcgF6rnLLblvnblYyjDgMu/avxr9SM3v7hhpfGD6XhA1L
	5SArzUOB2lFRmzuz8V9xj9o4cuBJ91ZiwxKUqNRhQ==
X-Received: by 2002:a17:90b:586f:b0:39b:66ee:a14 with SMTP id 98e67ed59e1d1-39d9c374d49mr6159190a91.25.1789129012797;
        Fri, 11 Sep 2026 05:16:52 -0700 (PDT)
Received: from FJ7FR2JRQ3 ([2409:8a28:f48:3091:908c:b537:572a:4db0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33baf0ea9a1sm3178278eec.8.2026.09.11.05.16.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 11 Sep 2026 05:16:52 -0700 (PDT)
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
	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v10 4/9] drivers: firmware: add riscv SSE support
Date: Fri, 11 Sep 2026 20:14:51 +0800
Message-ID: <20260911121456.33223-5-zhangzhanpeng.jasper@bytedance.com>
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

Add a driver-level interface for RISC-V SSE. Linux clients can register
handlers, select a target CPU for global events, and enable, disable or
unregister events. The architecture entry wrapper completes an event after
the registered handler returns. PMU and GHES drivers can use this
interface.

Represent global events with one firmware registration and local events
with one registration per possible CPU. Keep registration and enable state
stable across CPU hotplug, and validate firmware-provided hart IDs before
converting them to Linux CPU IDs. Use phys_addr_t for attribute buffers to
match the physical addresses passed to firmware. Require MMU support
because the current event-stack implementation relies on vmapped memory and
TLB synchronization.

Serialize client list updates with the SSE mutex and the CPU read lock.
Normal CPU hotplug callbacks provide the matching write-side exclusion, and
CPUHP state removal holds the SSE mutex. These rules avoid holding an
additional spinlock across firmware calls. Local event operations select a
per-CPU registration, so require callers to remain on the current CPU and
use lockdep assertions to verify that contract.

Propagate firmware failures from register, disable and unregister
operations. Update Linux state only after successful firmware operations,
and release an event only after all registrations are gone. Preserve the
difference between SBI_ERR_NOT_SUPPORTED and a generic SBI failure so
clients only select a fallback after firmware explicitly rejects an SSE
operation.

If setup fails partway through a local event, roll back only the CPU
instances changed by that invocation. Keep non-fallback errors across CPUs.
This lets a client distinguish an event rejected as unsupported by every
failing hart from an unknown firmware failure.

A failed registration rollback can leave firmware state without a client
handle. Retain these events on a driver-owned cleanup list with a no-op
handler. This lets CPU hotplug and shutdown retry cleanup without relying
on client callback lifetime.

Mask SSE before CPU teardown. If a normal CPU-offline teardown fails after
partially changing local events, reconstruct their requested registration
and enable state. Unmask the hart, then return the original error to abort
the offline operation. Shutdown and CPUHP state removal cannot fail, so
record incomplete cleanup and refuse an unsafe normal kexec instead.

Close enable admission before reboot or kexec teardown. Protect the
shutdown check and firmware enable operation with RCU, then drain existing
enable calls before CPUHP removes registrations. This prevents a client
from re-enabling an event between the teardown disable and unregister
operations.

A crash kernel cannot identify registrations inherited from the crashed
kernel. Leave SSE masked, report the retained firmware state separately
from an unavailable extension, and do not let clients select a delivery
path that may still be owned by the old kernel.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Co-developed-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Co-developed-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 MAINTAINERS                            |    7 +
 drivers/firmware/Kconfig               |    1 +
 drivers/firmware/Makefile              |    1 +
 drivers/firmware/riscv/Kconfig         |   18 +
 drivers/firmware/riscv/Makefile        |    3 +
 drivers/firmware/riscv/riscv_sbi_sse.c | 1214 ++++++++++++++++++++++++
 include/linux/cpuhotplug.h             |    1 +
 include/linux/riscv_sbi_sse.h          |   89 ++
 8 files changed, 1334 insertions(+)
 create mode 100644 drivers/firmware/riscv/Kconfig
 create mode 100644 drivers/firmware/riscv/Makefile
 create mode 100644 drivers/firmware/riscv/riscv_sbi_sse.c
 create mode 100644 include/linux/riscv_sbi_sse.h

diff --git a/MAINTAINERS b/MAINTAINERS
index f6a2ed9990dd..d11cd44d2449 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23330,6 +23330,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git
 F:	Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
 F:	drivers/iommu/riscv/
 
+RISC-V FIRMWARE DRIVERS
+M:	Conor Dooley <conor@kernel.org>
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git
+F:	drivers/firmware/riscv/
+
 RISC-V MICROCHIP SUPPORT
 M:	Conor Dooley <conor.dooley@microchip.com>
 M:	Daire McNamara <daire.mcnamara@microchip.com>
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index dbaca140a1b0..47eac61b9150 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -318,6 +318,7 @@ source "drivers/firmware/meson/Kconfig"
 source "drivers/firmware/microchip/Kconfig"
 source "drivers/firmware/psci/Kconfig"
 source "drivers/firmware/qcom/Kconfig"
+source "drivers/firmware/riscv/Kconfig"
 source "drivers/firmware/samsung/Kconfig"
 source "drivers/firmware/smccc/Kconfig"
 source "drivers/firmware/tegra/Kconfig"
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index be46f1e1dc77..879953c316dc 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -35,6 +35,7 @@ obj-y				+= efi/
 obj-y				+= imx/
 obj-y				+= psci/
 obj-y				+= qcom/
+obj-y				+= riscv/
 obj-y				+= samsung/
 obj-y				+= smccc/
 obj-y				+= tegra/
diff --git a/drivers/firmware/riscv/Kconfig b/drivers/firmware/riscv/Kconfig
new file mode 100644
index 000000000000..d15ff84e1258
--- /dev/null
+++ b/drivers/firmware/riscv/Kconfig
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0-only
+menu "Risc-V Specific firmware drivers"
+depends on RISCV
+
+config RISCV_SBI_SSE
+	bool "Enable SBI Supervisor Software Events support"
+	depends on RISCV_SBI && MMU && !HIBERNATION
+	default y
+	help
+	  The Supervisor Software Events support allows the SBI to deliver
+	  NMI-like notifications to the supervisor mode software. When enabled,
+	  this option provides support to register callbacks on specific SSE
+	  events.
+
+	  Hibernation is not supported because firmware registrations do not
+	  survive restoring a kernel image.
+
+endmenu
diff --git a/drivers/firmware/riscv/Makefile b/drivers/firmware/riscv/Makefile
new file mode 100644
index 000000000000..c8795d4bbb2e
--- /dev/null
+++ b/drivers/firmware/riscv/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_RISCV_SBI_SSE)		+= riscv_sbi_sse.o
diff --git a/drivers/firmware/riscv/riscv_sbi_sse.c b/drivers/firmware/riscv/riscv_sbi_sse.c
new file mode 100644
index 000000000000..e81cfb4b0c56
--- /dev/null
+++ b/drivers/firmware/riscv/riscv_sbi_sse.c
@@ -0,0 +1,1214 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025 Rivos Inc.
+ */
+
+#define pr_fmt(fmt) "sse: " fmt
+
+#include <linux/atomic.h>
+#include <linux/cpu.h>
+#include <linux/cpuhotplug.h>
+#include <linux/cpu_pm.h>
+#include <linux/crash_dump.h>
+#include <linux/hardirq.h>
+#include <linux/kexec.h>
+#include <linux/list.h>
+#include <linux/panic_notifier.h>
+#include <linux/percpu-defs.h>
+#include <linux/rcupdate.h>
+#include <linux/reboot.h>
+#include <linux/riscv_sbi_sse.h>
+#include <linux/slab.h>
+#include <linux/smp.h>
+
+#include <asm/sbi.h>
+#include <asm/sse.h>
+
+struct sse_event {
+	struct list_head list;
+	u32 evt_id;
+	u32 priority;
+	sse_event_handler_fn __rcu *handler;
+	void *handler_arg;
+	/* Only valid for global events */
+	unsigned int cpu;
+	/*
+	 * Desired state requested by the client. Firmware state is tracked per
+	 * instance because a failed transition can leave a partial result.
+	 */
+	bool enable_requested;
+	/* Registration failed, but firmware state still needs driver cleanup. */
+	bool cleanup_pending;
+
+	union {
+		struct sse_registered_event *global;
+		struct sse_registered_event __percpu *local;
+	};
+};
+
+static bool sse_available __ro_after_init;
+static bool sse_fw_state_retained __ro_after_init;
+static bool sse_shutting_down;
+static atomic_t sse_teardown_failed = ATOMIC_INIT(0);
+/*
+ * Client-side updates hold sse_mutex and the CPU read lock. Normal CPU hotplug
+ * callbacks exclude them through the CPUHP write side. Initialization replay
+ * runs before clients can register, and state removal holds sse_mutex.
+ */
+static LIST_HEAD(events);
+static DEFINE_MUTEX(sse_mutex);
+
+/*
+ * A registration rollback can fail before the client receives an event
+ * handle. Keep the retained event independent of client-owned callback text
+ * and data while the driver retries firmware cleanup.
+ */
+static int sse_cleanup_event_handler(u32 evt, void *arg, struct pt_regs *regs)
+{
+	return 0;
+}
+
+struct sse_registered_event {
+	struct sse_event_arch_data arch;
+	struct sse_event *event;
+	unsigned long attr;
+	/*
+	 * Actual firmware state for one global or per-CPU instance. A retry can
+	 * then skip instances that already completed a partial transition.
+	 */
+	bool is_registered;
+	bool is_enabled;
+};
+
+void sse_handle_event(struct sse_event_arch_data *arch_event,
+		      struct pt_regs *regs)
+{
+	sse_event_handler_fn *handler;
+	int ret;
+	struct sse_registered_event *reg_evt =
+		container_of(arch_event, struct sse_registered_event, arch);
+	struct sse_event *evt = reg_evt->event;
+
+	rcu_read_lock();
+	handler = rcu_dereference(evt->handler);
+	ret = handler(evt->evt_id, evt->handler_arg, regs);
+	rcu_read_unlock();
+	if (ret)
+		pr_warn("event %x handler failed with error %d\n", evt->evt_id, ret);
+}
+
+static struct sse_event *sse_event_get(u32 evt)
+{
+	struct sse_event *event;
+
+	lockdep_assert_held(&sse_mutex);
+
+	list_for_each_entry(event, &events, list) {
+		if (event->evt_id == evt)
+			return event;
+	}
+
+	return NULL;
+}
+
+static phys_addr_t sse_event_get_attr_phys(struct sse_registered_event *reg_evt)
+{
+	phys_addr_t phys;
+	void *addr = &reg_evt->attr;
+
+	if (sse_event_is_global(reg_evt->event->evt_id))
+		phys = virt_to_phys(addr);
+	else
+		phys = per_cpu_ptr_to_phys(addr);
+
+	return phys;
+}
+
+static struct sse_registered_event *sse_get_reg_evt(struct sse_event *event)
+{
+	if (sse_event_is_global(event->evt_id))
+		return event->global;
+	else
+		return per_cpu_ptr(event->local, smp_processor_id());
+}
+
+static int sse_err_map_linux_errno(long err)
+{
+	if (err == SBI_ERR_NOT_SUPPORTED)
+		return -EOPNOTSUPP;
+
+	return sbi_err_map_linux_errno(err);
+}
+
+static int sse_sbi_event_func(struct sse_event *event, unsigned long func)
+{
+	struct sbiret ret;
+	u32 evt = event->evt_id;
+	struct sse_registered_event *reg_evt = sse_get_reg_evt(event);
+
+	ret = sbi_ecall(SBI_EXT_SSE, func, evt, 0, 0, 0, 0, 0);
+	if (ret.error) {
+		pr_warn("Failed to execute func %lx, event %x, error %ld\n",
+			func, evt, ret.error);
+		return sse_err_map_linux_errno(ret.error);
+	}
+
+	if (func == SBI_SSE_EVENT_DISABLE)
+		reg_evt->is_enabled = false;
+	else if (func == SBI_SSE_EVENT_ENABLE)
+		reg_evt->is_enabled = true;
+
+	return 0;
+}
+
+int sse_event_disable_local(struct sse_event *event)
+{
+	if (!sse_event_is_global(event->evt_id))
+		lockdep_assert_preemption_disabled();
+
+	if (!sse_get_reg_evt(event)->is_enabled)
+		return 0;
+
+	return sse_sbi_event_func(event, SBI_SSE_EVENT_DISABLE);
+}
+EXPORT_SYMBOL_GPL(sse_event_disable_local);
+
+int sse_event_enable_local(struct sse_event *event)
+{
+	struct sse_registered_event *reg_evt = sse_get_reg_evt(event);
+	int ret;
+
+	if (!sse_event_is_global(event->evt_id))
+		lockdep_assert_preemption_disabled();
+
+	rcu_read_lock();
+	if (READ_ONCE(sse_shutting_down)) {
+		ret = -ESHUTDOWN;
+		goto out;
+	}
+
+	if (!reg_evt->is_registered) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (reg_evt->is_enabled) {
+		ret = 0;
+		goto out;
+	}
+
+	ret = sse_sbi_event_func(event, SBI_SSE_EVENT_ENABLE);
+out:
+	rcu_read_unlock();
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sse_event_enable_local);
+
+static int sse_event_attr_get_no_lock(struct sse_registered_event *reg_evt,
+				      unsigned long attr_id, unsigned long *val)
+{
+	struct sbiret sret;
+	u32 evt = reg_evt->event->evt_id;
+	phys_addr_t phys;
+
+	phys = sse_event_get_attr_phys(reg_evt);
+
+	sret = sbi_ecall(SBI_EXT_SSE, SBI_SSE_EVENT_ATTR_READ, evt, attr_id, 1,
+			 (unsigned long)phys, 0, 0);
+	if (sret.error) {
+		pr_debug("Failed to get event %x attr %lx, error %ld\n", evt,
+			 attr_id, sret.error);
+		return sse_err_map_linux_errno(sret.error);
+	}
+
+	*val = reg_evt->attr;
+
+	return 0;
+}
+
+static int sse_event_attr_set_nolock(struct sse_registered_event *reg_evt,
+				     unsigned long attr_id, unsigned long val)
+{
+	struct sbiret sret;
+	u32 evt = reg_evt->event->evt_id;
+	phys_addr_t phys;
+
+	reg_evt->attr = val;
+	phys = sse_event_get_attr_phys(reg_evt);
+
+	sret = sbi_ecall(SBI_EXT_SSE, SBI_SSE_EVENT_ATTR_WRITE, evt, attr_id, 1,
+			 (unsigned long)phys, 0, 0);
+	if (sret.error)
+		pr_debug("Failed to set event %x attr %lx, error %ld\n", evt,
+			 attr_id, sret.error);
+
+	return sse_err_map_linux_errno(sret.error);
+}
+
+static void sse_global_event_update_cpu(struct sse_event *event,
+					unsigned int cpu)
+{
+	struct sse_registered_event *reg_evt = event->global;
+
+	event->cpu = cpu;
+	arch_sse_event_update_cpu(&reg_evt->arch, cpu);
+}
+
+static int sse_event_set_target_cpu_nolock(struct sse_event *event,
+					   unsigned int cpu)
+{
+	unsigned long hart_id, old_hart_id;
+	struct sse_registered_event *reg_evt = event->global;
+	u32 evt = event->evt_id;
+	unsigned int old_cpu;
+	bool was_enabled;
+	int ret;
+
+	if (!sse_event_is_global(evt))
+		return -EINVAL;
+
+	if (cpu >= nr_cpu_ids || !cpu_online(cpu))
+		return -EINVAL;
+	hart_id = cpuid_to_hartid_map(cpu);
+	old_cpu = event->cpu;
+	old_hart_id = cpuid_to_hartid_map(old_cpu);
+
+	was_enabled = reg_evt->is_enabled;
+	if (was_enabled) {
+		ret = sse_event_disable_local(event);
+		if (ret)
+			return ret;
+	}
+
+	ret = sse_event_attr_set_nolock(reg_evt, SBI_SSE_ATTR_PREFERRED_HART,
+					hart_id);
+	if (ret == 0)
+		sse_global_event_update_cpu(event, cpu);
+
+	if (was_enabled) {
+		int enable_ret;
+
+		enable_ret = sse_event_enable_local(event);
+		if (enable_ret) {
+			int rollback_ret;
+
+			/*
+			 * The preferred hart was already changed. Restore both the
+			 * firmware attribute and Linux's cached target before reporting
+			 * the failed migration.
+			 */
+			rollback_ret = sse_event_attr_set_nolock(reg_evt,
+								 SBI_SSE_ATTR_PREFERRED_HART,
+								 old_hart_id);
+			if (!rollback_ret) {
+				sse_global_event_update_cpu(event, old_cpu);
+				rollback_ret = sse_event_enable_local(event);
+			}
+			if (!rollback_ret)
+				return enable_ret;
+
+			pr_warn("Failed to restore global event %x to CPU %u: %d\n",
+				evt, old_cpu, rollback_ret);
+			event->enable_requested = false;
+			return enable_ret;
+		}
+	}
+
+	return ret;
+}
+
+int sse_event_set_target_cpu(struct sse_event *event, unsigned int cpu)
+{
+	int ret;
+
+	if (cpu >= nr_cpu_ids)
+		return -EINVAL;
+
+	scoped_guard(mutex, &sse_mutex) {
+		if (READ_ONCE(sse_shutting_down))
+			return -ESHUTDOWN;
+
+		scoped_guard(cpus_read_lock) {
+			if (!cpu_online(cpu))
+				return -EINVAL;
+
+			ret = sse_event_set_target_cpu_nolock(event, cpu);
+		}
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sse_event_set_target_cpu);
+
+static int sse_event_init_registered(unsigned int cpu,
+				     struct sse_registered_event *reg_evt,
+				     struct sse_event *event)
+{
+	reg_evt->event = event;
+	reg_evt->is_registered = false;
+	reg_evt->is_enabled = false;
+
+	return arch_sse_init_event(&reg_evt->arch, event->evt_id, cpu);
+}
+
+static void sse_event_free_registered(struct sse_registered_event *reg_evt)
+{
+	arch_sse_free_event(&reg_evt->arch);
+}
+
+static int sse_event_alloc_global(struct sse_event *event)
+{
+	unsigned int cpu;
+	int err;
+	struct sse_registered_event *reg_evt;
+
+	reg_evt = kzalloc_obj(*reg_evt, GFP_KERNEL);
+	if (!reg_evt)
+		return -ENOMEM;
+
+	event->global = reg_evt;
+	cpu = cpumask_first(cpu_possible_mask);
+	if (cpu >= nr_cpu_ids) {
+		kfree(reg_evt);
+		return -ENODEV;
+	}
+
+	err = sse_event_init_registered(cpu, reg_evt, event);
+	if (err)
+		kfree(reg_evt);
+
+	return err;
+}
+
+static int sse_event_alloc_local(struct sse_event *event)
+{
+	int err;
+	unsigned int cpu, err_cpu;
+	struct sse_registered_event *reg_evt;
+	struct sse_registered_event __percpu *reg_evts;
+
+	reg_evts = alloc_percpu(struct sse_registered_event);
+	if (!reg_evts)
+		return -ENOMEM;
+
+	event->local = reg_evts;
+
+	for_each_possible_cpu(cpu) {
+		reg_evt = per_cpu_ptr(reg_evts, cpu);
+		err = sse_event_init_registered(cpu, reg_evt, event);
+		if (err) {
+			err_cpu = cpu;
+			goto err_free_per_cpu;
+		}
+	}
+
+	return 0;
+
+err_free_per_cpu:
+	for_each_possible_cpu(cpu) {
+		if (cpu == err_cpu)
+			break;
+		reg_evt = per_cpu_ptr(reg_evts, cpu);
+		sse_event_free_registered(reg_evt);
+	}
+
+	free_percpu(reg_evts);
+
+	return err;
+}
+
+static struct sse_event *sse_event_alloc(u32 evt, u32 priority,
+					 sse_event_handler_fn *handler,
+					 void *arg)
+{
+	int err;
+	struct sse_event *event;
+
+	event = kzalloc_obj(*event, GFP_KERNEL);
+	if (!event)
+		return ERR_PTR(-ENOMEM);
+
+	event->evt_id = evt;
+	event->priority = priority;
+	event->handler_arg = arg;
+	RCU_INIT_POINTER(event->handler, handler);
+
+	if (sse_event_is_global(evt))
+		err = sse_event_alloc_global(event);
+	else
+		err = sse_event_alloc_local(event);
+
+	if (err) {
+		kfree(event);
+		return ERR_PTR(err);
+	}
+
+	return event;
+}
+
+static int sse_sbi_register_event(struct sse_event *event,
+				  struct sse_registered_event *reg_evt)
+{
+	int ret;
+
+	if (reg_evt->is_registered)
+		return 0;
+
+	ret = sse_event_attr_set_nolock(reg_evt, SBI_SSE_ATTR_PRIO,
+					event->priority);
+	if (ret)
+		return ret;
+
+	ret = arch_sse_register_event(&reg_evt->arch);
+	if (!ret)
+		reg_evt->is_registered = true;
+
+	return ret;
+}
+
+static int sse_event_register_local(struct sse_event *event)
+{
+	int ret;
+	struct sse_registered_event *reg_evt;
+
+	reg_evt = per_cpu_ptr(event->local, smp_processor_id());
+	ret = sse_sbi_register_event(event, reg_evt);
+	if (ret)
+		pr_debug("Failed to register event %x: err %d\n", event->evt_id,
+			 ret);
+
+	return ret;
+}
+
+static int sse_sbi_unregister_event(struct sse_event *event)
+{
+	struct sse_registered_event *reg_evt = sse_get_reg_evt(event);
+	int ret;
+
+	if (!reg_evt->is_registered)
+		return 0;
+
+	ret = sse_sbi_event_func(event, SBI_SSE_EVENT_UNREGISTER);
+	if (!ret) {
+		reg_evt->is_registered = false;
+		reg_evt->is_enabled = false;
+	}
+
+	return ret;
+}
+
+struct sse_per_cpu_evt {
+	struct sse_event *event;
+	unsigned long func;
+	atomic_t first_error;
+	atomic_t nonfallback_error;
+	cpumask_t changed;
+};
+
+static void sse_event_per_cpu_func(void *info)
+{
+	struct sse_per_cpu_evt *cpu_evt = info;
+	struct sse_registered_event *reg_evt;
+	bool changed;
+	int ret;
+
+	reg_evt = sse_get_reg_evt(cpu_evt->event);
+
+	if (cpu_evt->func == SBI_SSE_EVENT_REGISTER) {
+		changed = !reg_evt->is_registered;
+		ret = sse_event_register_local(cpu_evt->event);
+	} else if (cpu_evt->func == SBI_SSE_EVENT_UNREGISTER) {
+		changed = reg_evt->is_registered;
+		ret = sse_sbi_unregister_event(cpu_evt->event);
+	} else if (cpu_evt->func == SBI_SSE_EVENT_ENABLE) {
+		changed = !reg_evt->is_enabled;
+		ret = sse_event_enable_local(cpu_evt->event);
+	} else if (cpu_evt->func == SBI_SSE_EVENT_DISABLE) {
+		changed = reg_evt->is_enabled;
+		ret = sse_event_disable_local(cpu_evt->event);
+	} else {
+		changed = false;
+		ret = -EINVAL;
+	}
+
+	if (ret) {
+		atomic_cmpxchg(&cpu_evt->first_error, 0, ret);
+		if (ret != -EOPNOTSUPP)
+			atomic_cmpxchg(&cpu_evt->nonfallback_error, 0, ret);
+	} else if (changed) {
+		cpumask_set_cpu(smp_processor_id(), &cpu_evt->changed);
+	}
+}
+
+static bool sse_event_is_registered(struct sse_event *event)
+{
+	unsigned int cpu;
+
+	if (sse_event_is_global(event->evt_id))
+		return event->global->is_registered;
+
+	for_each_possible_cpu(cpu) {
+		if (per_cpu_ptr(event->local, cpu)->is_registered)
+			return true;
+	}
+
+	return false;
+}
+
+static bool sse_event_is_enabled(struct sse_event *event)
+{
+	unsigned int cpu;
+
+	if (sse_event_is_global(event->evt_id))
+		return event->global->is_enabled;
+
+	for_each_possible_cpu(cpu) {
+		if (per_cpu_ptr(event->local, cpu)->is_enabled)
+			return true;
+	}
+
+	return false;
+}
+
+static void sse_event_free(struct sse_event *event)
+{
+	unsigned int cpu;
+	struct sse_registered_event *reg_evt;
+
+	if (WARN_ON_ONCE(sse_event_is_registered(event)))
+		return;
+
+	if (sse_event_is_global(event->evt_id)) {
+		sse_event_free_registered(event->global);
+		kfree(event->global);
+	} else {
+		for_each_possible_cpu(cpu) {
+			reg_evt = per_cpu_ptr(event->local, cpu);
+			sse_event_free_registered(reg_evt);
+		}
+		free_percpu(event->local);
+	}
+
+	kfree(event);
+}
+
+static struct sse_event *sse_register_failed(struct sse_event *event, int ret)
+{
+	/*
+	 * Keep failed rollback state visible to CPU hotplug and shutdown. The
+	 * core-owned handler also makes the retained registration independent of
+	 * the client whose registration request failed.
+	 */
+	if (sse_event_is_registered(event)) {
+		event->cleanup_pending = true;
+		rcu_assign_pointer(event->handler, sse_cleanup_event_handler);
+		synchronize_rcu();
+		list_add(&event->list, &events);
+		pr_err("Event %x remains registered after rollback; cleanup retained\n",
+		       event->evt_id);
+		ret = -EUCLEAN;
+	} else {
+		sse_event_free(event);
+	}
+
+	return ERR_PTR(ret);
+}
+
+void sse_event_cleanup(struct sse_event *event)
+{
+	guard(mutex)(&sse_mutex);
+	guard(cpus_read_lock)();
+
+	if (event->cleanup_pending)
+		return;
+
+	/*
+	 * Firmware may still enter the old callback after disable or unregister
+	 * fails. Publish a core-owned callback, then wait before the client frees
+	 * its callback data.
+	 */
+	event->cleanup_pending = true;
+	rcu_assign_pointer(event->handler, sse_cleanup_event_handler);
+	synchronize_rcu();
+}
+EXPORT_SYMBOL_GPL(sse_event_cleanup);
+
+static void sse_release_cleanup_event(struct sse_event *event)
+{
+	if (!event->cleanup_pending || sse_event_is_registered(event))
+		return;
+
+	list_del(&event->list);
+	sse_event_free(event);
+}
+
+static int sse_event_setup_all_cpus(struct sse_event *event,
+				    unsigned long func,
+				    unsigned long rollback_func)
+{
+	struct sse_per_cpu_evt cpu_evt;
+	int rollback_ret;
+	int ret;
+
+	cpu_evt.event = event;
+	atomic_set(&cpu_evt.first_error, 0);
+	atomic_set(&cpu_evt.nonfallback_error, 0);
+	cpumask_clear(&cpu_evt.changed);
+	cpu_evt.func = func;
+	on_each_cpu(sse_event_per_cpu_func, &cpu_evt, 1);
+	/* IRQ fallback is safe only if every failing CPU reports unsupported. */
+	ret = atomic_read(&cpu_evt.nonfallback_error);
+	if (!ret)
+		ret = atomic_read(&cpu_evt.first_error);
+	/*
+	 * A previous attempt may already have changed some CPUs. Roll back only
+	 * instances changed by this invocation.
+	 */
+	if (ret) {
+		cpu_evt.func = rollback_func;
+		atomic_set(&cpu_evt.first_error, 0);
+		atomic_set(&cpu_evt.nonfallback_error, 0);
+		on_each_cpu_mask(&cpu_evt.changed, sse_event_per_cpu_func, &cpu_evt, 1);
+
+		rollback_ret = atomic_read(&cpu_evt.nonfallback_error);
+		if (!rollback_ret)
+			rollback_ret = atomic_read(&cpu_evt.first_error);
+
+		/* A rollback failure leaves the firmware state uncertain. */
+		return rollback_ret ?: ret;
+	}
+
+	return 0;
+}
+
+static int sse_event_teardown_all_cpus(struct sse_event *event,
+				       unsigned long func)
+{
+	struct sse_per_cpu_evt cpu_evt;
+
+	cpu_evt.event = event;
+	atomic_set(&cpu_evt.first_error, 0);
+	atomic_set(&cpu_evt.nonfallback_error, 0);
+	cpumask_clear(&cpu_evt.changed);
+	cpu_evt.func = func;
+	on_each_cpu(sse_event_per_cpu_func, &cpu_evt, 1);
+
+	return atomic_read(&cpu_evt.first_error);
+}
+
+int sse_event_enable(struct sse_event *event)
+{
+	int ret = 0;
+
+	scoped_guard(mutex, &sse_mutex) {
+		if (READ_ONCE(sse_shutting_down))
+			return -ESHUTDOWN;
+
+		scoped_guard(cpus_read_lock) {
+			if (sse_event_is_global(event->evt_id)) {
+				ret = sse_event_enable_local(event);
+			} else {
+				ret = sse_event_setup_all_cpus(event,
+							       SBI_SSE_EVENT_ENABLE,
+							       SBI_SSE_EVENT_DISABLE);
+			}
+			event->enable_requested = !ret;
+		}
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sse_event_enable);
+
+static int sse_events_mask(void)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_SSE, SBI_SSE_HART_MASK, 0, 0, 0, 0, 0, 0);
+	if (ret.error == SBI_ERR_ALREADY_STOPPED)
+		return 0;
+
+	return sse_err_map_linux_errno(ret.error);
+}
+
+static int sse_events_unmask(void)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_SSE, SBI_SSE_HART_UNMASK, 0, 0, 0, 0, 0, 0);
+	if (ret.error == SBI_ERR_ALREADY_STARTED)
+		return 0;
+
+	return sse_err_map_linux_errno(ret.error);
+}
+
+static int sse_event_disable_nolock(struct sse_event *event)
+{
+	if (sse_event_is_global(event->evt_id))
+		return sse_event_disable_local(event);
+
+	return sse_event_teardown_all_cpus(event, SBI_SSE_EVENT_DISABLE);
+}
+
+int sse_event_disable(struct sse_event *event)
+{
+	int ret = 0;
+
+	scoped_guard(mutex, &sse_mutex) {
+		if (READ_ONCE(sse_shutting_down))
+			return -ESHUTDOWN;
+
+		scoped_guard(cpus_read_lock) {
+			if (!event->enable_requested && !sse_event_is_enabled(event))
+				return 0;
+
+			event->enable_requested = false;
+			ret = sse_event_disable_nolock(event);
+			if (!ret && sse_event_is_enabled(event))
+				ret = -EIO;
+		}
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sse_event_disable);
+
+struct sse_event *sse_event_register(u32 evt, u32 priority,
+				     sse_event_handler_fn *handler, void *arg)
+{
+	struct sse_event *event;
+	int cpu;
+	int ret = 0;
+
+	if (sse_fw_state_retained)
+		return ERR_PTR(-EUCLEAN);
+	if (!sse_available)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	guard(mutex)(&sse_mutex);
+	if (READ_ONCE(sse_shutting_down))
+		return ERR_PTR(-ESHUTDOWN);
+
+	guard(cpus_read_lock)();
+
+	if (sse_event_get(evt))
+		return ERR_PTR(-EEXIST);
+
+	event = sse_event_alloc(evt, priority, handler, arg);
+	if (IS_ERR(event))
+		return event;
+
+	if (sse_event_is_global(evt)) {
+		unsigned long preferred_hart;
+
+		ret = sse_event_attr_get_no_lock(event->global,
+						 SBI_SSE_ATTR_PREFERRED_HART,
+						 &preferred_hart);
+		if (ret)
+			return sse_register_failed(event, ret);
+
+		cpu = riscv_hartid_to_cpuid(preferred_hart);
+		if (cpu < 0 || !cpu_online(cpu)) {
+			cpu = cpumask_first(cpu_online_mask);
+			if (cpu >= nr_cpu_ids)
+				return sse_register_failed(event, -ENODEV);
+
+			ret = sse_event_set_target_cpu_nolock(event, cpu);
+			if (ret)
+				return sse_register_failed(event, ret);
+		} else {
+			sse_global_event_update_cpu(event, cpu);
+		}
+
+		ret = sse_sbi_register_event(event, event->global);
+		if (ret)
+			return sse_register_failed(event, ret);
+	} else {
+		ret = sse_event_setup_all_cpus(event, SBI_SSE_EVENT_REGISTER,
+					       SBI_SSE_EVENT_UNREGISTER);
+		if (ret)
+			return sse_register_failed(event, ret);
+	}
+
+	list_add(&event->list, &events);
+
+	return event;
+}
+EXPORT_SYMBOL_GPL(sse_event_register);
+
+static int sse_event_unregister_nolock(struct sse_event *event)
+{
+	if (sse_event_is_global(event->evt_id))
+		return sse_sbi_unregister_event(event);
+
+	return sse_event_teardown_all_cpus(event, SBI_SSE_EVENT_UNREGISTER);
+}
+
+int sse_event_unregister(struct sse_event *event)
+{
+	int ret = 0;
+
+	scoped_guard(mutex, &sse_mutex) {
+		if (READ_ONCE(sse_shutting_down))
+			return -ESHUTDOWN;
+
+		scoped_guard(cpus_read_lock) {
+			ret = sse_event_unregister_nolock(event);
+			if (ret)
+				return ret;
+			if (sse_event_is_registered(event))
+				return -EBUSY;
+
+			list_del(&event->list);
+
+			sse_event_free(event);
+		}
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sse_event_unregister);
+
+static int sse_teardown_event(struct sse_event *event, unsigned int cpu);
+
+static int sse_cpu_online(unsigned int cpu)
+{
+	int ret, rollback_ret;
+	struct sse_event *event, *tmp;
+	struct sse_registered_event *reg_evt;
+
+	arch_sse_init_cpu();
+
+	list_for_each_entry_safe(event, tmp, &events, list) {
+		if (sse_event_is_global(event->evt_id))
+			continue;
+		if (event->cleanup_pending) {
+			ret = sse_teardown_event(event, cpu);
+			if (ret)
+				goto rollback;
+			sse_release_cleanup_event(event);
+			continue;
+		}
+
+		ret = sse_event_register_local(event);
+		if (ret)
+			goto rollback;
+		if (event->enable_requested)
+			ret = sse_event_enable_local(event);
+		else
+			ret = sse_event_disable_local(event);
+		if (ret)
+			goto rollback;
+	}
+
+	/* Only unmask after every cached per-CPU state is reconstructed. */
+	ret = sse_events_unmask();
+	if (!ret)
+		return 0;
+
+rollback:
+	/* A failed startup callback is not followed by this state's teardown. */
+	list_for_each_entry_safe(event, tmp, &events, list) {
+		if (sse_event_is_global(event->evt_id))
+			continue;
+
+		reg_evt = sse_get_reg_evt(event);
+		rollback_ret = reg_evt->is_enabled ?
+			sse_event_disable_local(event) : 0;
+		if (rollback_ret) {
+			pr_warn("Failed to disable event %x while rolling back CPU %u: %d\n",
+				event->evt_id, cpu, rollback_ret);
+			atomic_set(&sse_teardown_failed, 1);
+			continue;
+		}
+
+		rollback_ret = reg_evt->is_registered ?
+			sse_sbi_unregister_event(event) : 0;
+		if (rollback_ret) {
+			pr_warn("Failed to unregister event %x while rolling back CPU %u: %d\n",
+				event->evt_id, cpu, rollback_ret);
+			atomic_set(&sse_teardown_failed, 1);
+		}
+		sse_release_cleanup_event(event);
+	}
+
+	return ret;
+}
+
+static int sse_teardown_event(struct sse_event *event, unsigned int cpu)
+{
+	struct sse_registered_event *reg_evt = sse_get_reg_evt(event);
+	int ret;
+
+	if (reg_evt->is_enabled) {
+		ret = sse_event_disable_local(event);
+		if (ret) {
+			pr_warn("Failed to disable event %x on CPU %u: %d\n",
+				event->evt_id, cpu, ret);
+			return ret;
+		}
+	}
+
+	ret = sse_sbi_unregister_event(event);
+	if (ret)
+		pr_warn("Failed to unregister event %x on CPU %u: %d\n",
+			event->evt_id, cpu, ret);
+
+	return ret;
+}
+
+static int sse_restore_local_events(unsigned int cpu)
+{
+	struct sse_event *event;
+	int first_error = 0;
+	int ret;
+
+	list_for_each_entry(event, &events, list) {
+		if (sse_event_is_global(event->evt_id) || event->cleanup_pending)
+			continue;
+
+		ret = sse_event_register_local(event);
+		if (!ret) {
+			ret = event->enable_requested ?
+				sse_event_enable_local(event) :
+				sse_event_disable_local(event);
+		}
+		if (ret) {
+			pr_warn("Failed to restore event %x on CPU %u: %d\n",
+				event->evt_id, cpu, ret);
+			if (!first_error)
+				first_error = ret;
+		}
+	}
+
+	return first_error;
+}
+
+static int sse_cpu_teardown(unsigned int cpu)
+{
+	/* Only a regular CPU-offline callback may abort the CPUHP operation. */
+	bool regular_offline = READ_ONCE(sse_available) &&
+			       !READ_ONCE(sse_shutting_down);
+	unsigned int next_cpu;
+	struct sse_event *event, *tmp;
+	int first_error = 0;
+	int ret;
+
+	/* Do not dismantle CPU state while firmware can still deliver SSE. */
+	ret = sse_events_mask();
+	if (ret) {
+		pr_warn("Failed to mask SSE on CPU %u during teardown: %d\n",
+			cpu, ret);
+		if (READ_ONCE(sse_shutting_down))
+			atomic_set(&sse_teardown_failed, 1);
+		/* CPUHP installation rollback and state removal cannot fail. */
+		return regular_offline ? ret : 0;
+	}
+
+	list_for_each_entry_safe(event, tmp, &events, list) {
+		if (sse_event_is_global(event->evt_id))
+			continue;
+
+		ret = sse_teardown_event(event, cpu);
+		if (ret && !first_error)
+			first_error = ret;
+		sse_release_cleanup_event(event);
+		if (ret && regular_offline)
+			goto restore_cpu;
+	}
+
+	list_for_each_entry_safe(event, tmp, &events, list) {
+		if (!sse_event_is_global(event->evt_id) || event->cpu != cpu)
+			continue;
+
+		/*
+		 * cpuhp_remove_state() invokes teardown while every CPU remains
+		 * online. Do not migrate to a CPU whose callback may have run.
+		 */
+		if (READ_ONCE(sse_shutting_down) || event->cleanup_pending) {
+			ret = sse_teardown_event(event, cpu);
+		} else {
+			next_cpu = cpumask_any_but(cpu_online_mask, cpu);
+			if (next_cpu >= nr_cpu_ids) {
+				ret = sse_teardown_event(event, cpu);
+			} else {
+				ret = sse_event_set_target_cpu_nolock(event, next_cpu);
+				if (ret)
+					pr_warn("Failed to migrate global event %x from CPU %u: %d\n",
+						event->evt_id, cpu, ret);
+			}
+		}
+
+		if (ret && !first_error)
+			first_error = ret;
+		sse_release_cleanup_event(event);
+		if (ret && regular_offline)
+			goto restore_cpu;
+	}
+
+	if (first_error) {
+		/* An offline CPU is not revisited when this CPUHP state is removed. */
+		atomic_set(&sse_teardown_failed, 1);
+	}
+
+	return 0;
+
+restore_cpu:
+	/*
+	 * CPUHP leaves this CPU online when teardown returns an error. Restore
+	 * every client-owned local event before making SSE delivery visible again.
+	 */
+	ret = sse_restore_local_events(cpu);
+	if (!ret)
+		ret = sse_events_unmask();
+	if (ret) {
+		atomic_set(&sse_teardown_failed, 1);
+		pr_warn("Failed to restore SSE after aborting CPU %u offline: %d\n",
+			cpu, ret);
+	} else {
+		pr_warn("Aborted CPU %u offline after SSE teardown failed: %d\n",
+			cpu, first_error);
+	}
+
+	return first_error;
+}
+
+static int sse_pm_notifier(struct notifier_block *nb, unsigned long action,
+			   void *data)
+{
+	int ret;
+
+	WARN_ON_ONCE(preemptible());
+
+	switch (action) {
+	case CPU_PM_ENTER:
+		ret = sse_events_mask();
+		break;
+	case CPU_PM_EXIT:
+	case CPU_PM_ENTER_FAILED:
+		if (READ_ONCE(sse_shutting_down))
+			return NOTIFY_OK;
+		ret = sse_events_unmask();
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	if (ret)
+		return notifier_from_errno(ret);
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block sse_pm_nb = {
+	.notifier_call = sse_pm_notifier,
+};
+
+static int sse_panic_notifier(struct notifier_block *nb, unsigned long action,
+			      void *data)
+{
+	riscv_sse_mask_current_hart();
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block sse_panic_nb = {
+	.notifier_call = sse_panic_notifier,
+	.priority = INT_MAX,
+};
+
+/*
+ * Mask all CPUs and unregister all events on reboot or kexec.
+ */
+static int sse_reboot_notifier(struct notifier_block *nb, unsigned long action,
+			       void *data)
+{
+	int ret;
+
+	scoped_guard(mutex, &sse_mutex) {
+		if (!sse_shutting_down) {
+			WRITE_ONCE(sse_shutting_down, true);
+			ret = cpu_pm_unregister_notifier(&sse_pm_nb);
+			if (ret) {
+				pr_warn("Failed to unregister CPU PM notifier: %d\n",
+					ret);
+				atomic_set(&sse_teardown_failed, 1);
+			}
+			/* Drain CPU PM callbacks and client enables before teardown. */
+			synchronize_rcu();
+			cpuhp_remove_state(CPUHP_AP_RISCV_SSE_ONLINE);
+		}
+	}
+
+	/* Normal kexec preserves firmware state but discards old kernel memory. */
+	if (kexec_in_progress && atomic_read(&sse_teardown_failed))
+		panic("SSE teardown failed; refusing unsafe kexec");
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block sse_reboot_nb = {
+	.notifier_call = sse_reboot_notifier,
+};
+
+static int __init sse_init(void)
+{
+	int ret;
+
+	/*
+	 * A kdump kernel cannot identify registrations left by the crashed
+	 * kernel. Keep them masked by not initializing SSE again.
+	 */
+	if (is_kdump_kernel() && riscv_sse_available()) {
+		sse_fw_state_retained = true;
+		pr_info("SSE remains disabled in the crash kernel\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (sbi_probe_extension(SBI_EXT_SSE) <= 0) {
+		pr_info("Missing SBI SSE extension\n");
+		return -EOPNOTSUPP;
+	}
+	pr_info("SBI SSE extension detected\n");
+
+	ret = cpu_pm_register_notifier(&sse_pm_nb);
+	if (ret) {
+		pr_warn("Failed to register CPU PM notifier...\n");
+		return ret;
+	}
+
+	ret = register_reboot_notifier(&sse_reboot_nb);
+	if (ret) {
+		pr_warn("Failed to register reboot notifier...\n");
+		goto remove_cpupm;
+	}
+
+	ret = atomic_notifier_chain_register(&panic_notifier_list, &sse_panic_nb);
+	if (ret) {
+		pr_warn("Failed to register panic notifier...\n");
+		goto remove_reboot;
+	}
+
+	/* Tear down perf events before dismantling their SSE delivery path. */
+	ret = cpuhp_setup_state(CPUHP_AP_RISCV_SSE_ONLINE, "riscv/sse:online",
+				sse_cpu_online, sse_cpu_teardown);
+	if (ret < 0)
+		goto remove_panic;
+
+	sse_available = true;
+
+	return 0;
+
+remove_panic:
+	atomic_notifier_chain_unregister(&panic_notifier_list, &sse_panic_nb);
+
+remove_reboot:
+	unregister_reboot_notifier(&sse_reboot_nb);
+
+remove_cpupm:
+	cpu_pm_unregister_notifier(&sse_pm_nb);
+
+	return ret;
+}
+arch_initcall(sse_init);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index feb32949aeea..d13af475508d 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -200,6 +200,7 @@ enum cpuhp_state {
 	CPUHP_AP_ARM_MVEBU_SYNC_CLOCKS,
 	CPUHP_AP_ARM_CORESIGHT_ONLINE,
 	CPUHP_AP_X86_INTEL_EPB_ONLINE,
+	CPUHP_AP_RISCV_SSE_ONLINE,
 	CPUHP_AP_PERF_ONLINE,
 	CPUHP_AP_PERF_X86_ONLINE,
 	CPUHP_AP_PERF_X86_UNCORE_ONLINE,
diff --git a/include/linux/riscv_sbi_sse.h b/include/linux/riscv_sbi_sse.h
new file mode 100644
index 000000000000..774a782e556d
--- /dev/null
+++ b/include/linux/riscv_sbi_sse.h
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2025 Rivos Inc.
+ */
+
+#ifndef __LINUX_RISCV_SBI_SSE_H
+#define __LINUX_RISCV_SBI_SSE_H
+
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <linux/linkage.h>
+
+struct sse_event;
+struct pt_regs;
+
+typedef int (sse_event_handler_fn)(u32 event_num, void *arg,
+				   struct pt_regs *regs);
+
+#ifdef CONFIG_RISCV_SBI_SSE
+
+/*
+ * The callback and its argument must remain valid until unregister succeeds.
+ * The callback runs in NMI context and must not sleep.
+ * regs is NULL if firmware cannot provide a complete interrupted context.
+ */
+struct sse_event *sse_event_register(u32 event_num, u32 priority,
+				     sse_event_handler_fn *handler, void *arg);
+
+int sse_event_unregister(struct sse_event *evt);
+
+/*
+ * Transfer a retained event to the SSE core for deferred cleanup. The caller
+ * must not access the event or its callback data after this function returns.
+ */
+void sse_event_cleanup(struct sse_event *evt);
+
+int sse_event_set_target_cpu(struct sse_event *sse_evt, unsigned int cpu);
+
+int sse_event_enable(struct sse_event *sse_evt);
+
+int sse_event_disable(struct sse_event *sse_evt);
+
+/* Local events require the caller to remain on the current CPU. */
+int sse_event_enable_local(struct sse_event *sse_evt);
+int sse_event_disable_local(struct sse_event *sse_evt);
+
+#else
+static inline struct sse_event *sse_event_register(u32 event_num, u32 priority,
+						   sse_event_handler_fn *handler,
+						   void *arg)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static inline int sse_event_unregister(struct sse_event *evt)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void sse_event_cleanup(struct sse_event *evt) { }
+
+static inline int sse_event_set_target_cpu(struct sse_event *sse_evt,
+					   unsigned int cpu)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int sse_event_enable(struct sse_event *sse_evt)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int sse_event_disable(struct sse_event *sse_evt)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int sse_event_enable_local(struct sse_event *sse_evt)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int sse_event_disable_local(struct sse_event *sse_evt)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+#endif /* __LINUX_RISCV_SBI_SSE_H */
-- 
2.50.1 (Apple Git-155)

