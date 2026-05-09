Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6D438C414
	for <linux-perf-users@vger.kernel.org>; Sat,  9 May 2026 13:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778332242; cv=none; b=TOuT45ipIojk8+EGytGlsU6VEa48uh7xwgYZKScCdk99x59xlJnFHYTAKGs8CqNDDzisNFztgo9eOabCUSbjpuSPR6MJ0bYdpGUx/JhcA5mlUK58cVjKNlmjDElxzGlzxRWpkt5mb2+DTirPVDxuDAb3ytHWsYYJ3lcPef/qlXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778332242; c=relaxed/simple;
	bh=7dqz4segQ/MalpRZ9Ya0yjpSu+KiCILfAeaCem3tceQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rZnA1LBo1SVJELvV5Jp2jDCQ+p0Cq3xavgusOt2m0AG8zjQEDyqTGWbN2dgXle78+e4tQByKA3vp0dAOorol0LrGN4yH5W7RUMjAicDVRFhDWxZiJ4Jsysqm208enyGMs1QHXpXxv97QinUruJEUfl56BTMsEaZkb9jvuM4gByg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LhBROx4G; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LhBROx4G"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c801d732058so1309385a12.1
        for <linux-perf-users@vger.kernel.org>; Sat, 09 May 2026 06:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778332239; x=1778937039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Q4dh0CdjTPEi5DSD0op3QJu9CGHQvyYzAsp+GsL6pc=;
        b=LhBROx4Galci6bBPyC7i37+JkW7o8CYC6JSXZVxkrAwPXrx72b3EP5rukqNwbMbE0q
         qV2oNzUG3fcIB/tvOt/lreEfsLPx5OdqlaaTonPM2agbLxNIr8f+lPXJHaMQvPMWM+gc
         Wh6r/Gn7jVmf9FqHQuLd+N9aSIyHcId3qAZ4wadky1uAV2AvFbRiRCcF3PHJ3b6xT+F4
         aq9meFA0796vb6VppkBMhOICiqIaWIZMenSCmlsbhm6+CKYO4w04qrJNgT5iYawpSe2+
         5xTh62nu7Q2rYY3JxE84PjsJZf/83eu7WCCsSl7PnYJMMA/NS+mqauQ46VC8vZ7NtOSs
         m8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778332239; x=1778937039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Q4dh0CdjTPEi5DSD0op3QJu9CGHQvyYzAsp+GsL6pc=;
        b=XYuiMMdwpuLz/PVvV7c3+60GxdEA9f4H3RpVE+tlRf0zHvX3de+7lFOIfAUbf0VLOi
         miu+iko8vYB3+FV7qvRKoyhnQcgWHfO+fYoKmsD9gagTeOMfvUG0gHPIKhDo8wBbEVIP
         fi+WxM5LX3653NAaF8r0+Kuh7lz2ytvdC6uy16/2jxv31/+Y5cqPVXXyAOAdFMqpZ07u
         BeawPemogeZoLBJN+vgTEEE7URfyWWoLiXPT4Is+LSIohJcUzg70hgT2t/KMk3CWXp/c
         DGVaIUhLjXXCFUJOt+e0bCsU0mLK9RUF9oTUJ7IW7Ts5xa0c9duE4KUUJM8EmgSezTGl
         f+JA==
X-Forwarded-Encrypted: i=1; AFNElJ/4kwqF6bxG8q58KmmCPsnGzGGL5HtD4FhgN2fwXDONYP8qw/fPku3cI7f4L5inPOJd2ShdCvDvUXOt7Jer+fYE@vger.kernel.org
X-Gm-Message-State: AOJu0YyoHv3Y/vZiuqnK+ekrn2pfo5qe5TT/T4hin68NErk/hg1doNgV
	BS7LuzInzsNpbyZQ2/+fuCxze9a4/d57OkAkb0FA6w+efaa4R2XzJq4Sekr2DgKBwP8=
X-Gm-Gg: Acq92OFBTVPEmj/cbAcirXexxbuzDX5zAsZ/dcyZ1ZhUR1Qy/prRnni3BZc1CTzjTHz
	k3sANaLYo4njY94Vd9eDSZO7NHBXgt8pib+6nyt/1dOZqP2ouC3MUdeuM9R2PV2K/T1IYMmMzB7
	Dgaf2NsGAQM5tEsRh6H7xk7rj5mHUmFLBVUuT91r0GGdIgn8CJczJH1v+KXnm49QlDHi/3ilyYS
	JJyfQZxKQ8+xO0rZvL1mW0Jy66xIP3yfXx+bprFxTx0qFcDkA/FnxwxfZjua/CaDNQPx93AurdQ
	JUJWEog3jLhbP4RSxbAIvB8/n0VPbdgVjuh7nsEw4ApC2o+t/vSR1dKm8LPraLp+oJ2dtJfxl6t
	TwAbSK6o+svvQviLYl2OwlQj/uzens+JkvuQ6Oku0Ah650f5JFz69lYqhpXJFYKLo1P5XBRaqzm
	cZBW+49uAB0AFuolEJ/yfm5s6TUsGX6CX+qZ8+t4tH3oJlJF5oqLhBiJXV8iHNGp7eenI=
X-Received: by 2002:a05:6a20:12c6:b0:3a2:c9a1:2c22 with SMTP id adf61e73a8af0-3aa8be1d28bmr9696923637.6.1778332239111;
        Sat, 09 May 2026 06:10:39 -0700 (PDT)
Received: from FJ7FR2JRQ3.bytedance.net ([155.117.34.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839679c86b3sm18552855b3a.28.2026.05.09.06.10.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 09 May 2026 06:10:38 -0700 (PDT)
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
	Himanshu Chauhan <hchauhan@ventanamicro.com>,
	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v9 3/5] drivers: firmware: add riscv SSE support
Date: Sat,  9 May 2026 21:10:00 +0800
Message-ID: <7d86cbd47688700fbdfc27e530e824a6bec0548c.1778331862.3.git.zhangzhanpeng.jasper@bytedance.com>
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

Add a driver-level interface for RISC-V SSE support.  The interface lets
Linux clients register handlers and enable, disable and complete SSE
events.  It will be used by PMU and GHES drivers.

Co-developed-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
Signed-off-by: Clément Léger <cleger@rivosinc.com>
Co-developed-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 MAINTAINERS                            |  16 +
 drivers/firmware/Kconfig               |   1 +
 drivers/firmware/Makefile              |   1 +
 drivers/firmware/riscv/Kconfig         |  15 +
 drivers/firmware/riscv/Makefile        |   3 +
 drivers/firmware/riscv/riscv_sbi_sse.c | 694 +++++++++++++++++++++++++
 include/linux/riscv_sbi_sse.h          |  57 ++
 7 files changed, 787 insertions(+)
 create mode 100644 drivers/firmware/riscv/Kconfig
 create mode 100644 drivers/firmware/riscv/Makefile
 create mode 100644 drivers/firmware/riscv/riscv_sbi_sse.c
 create mode 100644 include/linux/riscv_sbi_sse.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 2fb1c75afd16..c247acc56d1c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22914,6 +22914,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git
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
@@ -22999,6 +23006,15 @@ F:	arch/riscv/boot/dts/spacemit/
 N:	spacemit
 K:	spacemit
 
+RISC-V SSE DRIVER
+M:	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
+R:	Himanshu Chauhan <himanshu@thechauhan.dev>
+R:	Yunhui Cui <cuiyunhui@bytedance.com>
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+F:	drivers/firmware/riscv/riscv_sbi_sse.c
+F:	include/linux/riscv_sbi_sse.h
+
 RISC-V TENSTORRENT SoC SUPPORT
 M:	Drew Fustini <dfustini@oss.tenstorrent.com>
 M:	Joel Stanley <jms@oss.tenstorrent.com>
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index bbd2155d8483..1894df87b08e 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -294,6 +294,7 @@ source "drivers/firmware/meson/Kconfig"
 source "drivers/firmware/microchip/Kconfig"
 source "drivers/firmware/psci/Kconfig"
 source "drivers/firmware/qcom/Kconfig"
+source "drivers/firmware/riscv/Kconfig"
 source "drivers/firmware/samsung/Kconfig"
 source "drivers/firmware/smccc/Kconfig"
 source "drivers/firmware/tegra/Kconfig"
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 4ddec2820c96..6cdd84570ea7 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -34,6 +34,7 @@ obj-y				+= efi/
 obj-y				+= imx/
 obj-y				+= psci/
 obj-y				+= qcom/
+obj-y				+= riscv/
 obj-y				+= samsung/
 obj-y				+= smccc/
 obj-y				+= tegra/
diff --git a/drivers/firmware/riscv/Kconfig b/drivers/firmware/riscv/Kconfig
new file mode 100644
index 000000000000..ed5b663ac5f9
--- /dev/null
+++ b/drivers/firmware/riscv/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+menu "Risc-V Specific firmware drivers"
+depends on RISCV
+
+config RISCV_SBI_SSE
+	bool "Enable SBI Supervisor Software Events support"
+	depends on RISCV_SBI
+	default y
+	help
+	  The Supervisor Software Events support allows the SBI to deliver
+	  NMI-like notifications to the supervisor mode software. When enabled,
+	  this option provides support to register callbacks on specific SSE
+	  events.
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
index 000000000000..830011ddd33f
--- /dev/null
+++ b/drivers/firmware/riscv/riscv_sbi_sse.c
@@ -0,0 +1,694 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025 Rivos Inc.
+ */
+
+#define pr_fmt(fmt) "sse: " fmt
+
+#include <linux/cpu.h>
+#include <linux/cpuhotplug.h>
+#include <linux/cpu_pm.h>
+#include <linux/hardirq.h>
+#include <linux/list.h>
+#include <linux/percpu-defs.h>
+#include <linux/reboot.h>
+#include <linux/riscv_sbi_sse.h>
+#include <linux/slab.h>
+
+#include <asm/sbi.h>
+#include <asm/sse.h>
+
+struct sse_event {
+	struct list_head list;
+	u32 evt_id;
+	u32 priority;
+	sse_event_handler_fn *handler;
+	void *handler_arg;
+	/* Only valid for global events */
+	unsigned int cpu;
+
+	union {
+		struct sse_registered_event *global;
+		struct sse_registered_event __percpu *local;
+	};
+};
+
+static int sse_hp_state;
+static bool sse_available __ro_after_init;
+static DEFINE_SPINLOCK(events_list_lock);
+static LIST_HEAD(events);
+static DEFINE_MUTEX(sse_mutex);
+
+struct sse_registered_event {
+	struct sse_event_arch_data arch;
+	struct sse_event *event;
+	unsigned long attr;
+	bool is_enabled;
+};
+
+void sse_handle_event(struct sse_event_arch_data *arch_event,
+		      struct pt_regs *regs)
+{
+	int ret;
+	struct sse_registered_event *reg_evt =
+		container_of(arch_event, struct sse_registered_event, arch);
+	struct sse_event *evt = reg_evt->event;
+
+	ret = evt->handler(evt->evt_id, evt->handler_arg, regs);
+	if (ret)
+		pr_warn("event %x handler failed with error %d\n", evt->evt_id, ret);
+}
+
+static struct sse_event *sse_event_get(u32 evt)
+{
+	struct sse_event *event = NULL;
+
+	scoped_guard(spinlock, &events_list_lock) {
+		list_for_each_entry(event, &events, list) {
+			if (event->evt_id == evt)
+				return event;
+		}
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
+		return sbi_err_map_linux_errno(ret.error);
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
+	return sse_sbi_event_func(event, SBI_SSE_EVENT_DISABLE);
+}
+EXPORT_SYMBOL_GPL(sse_event_disable_local);
+
+int sse_event_enable_local(struct sse_event *event)
+{
+	return sse_sbi_event_func(event, SBI_SSE_EVENT_ENABLE);
+}
+EXPORT_SYMBOL_GPL(sse_event_enable_local);
+
+static int sse_event_attr_get_no_lock(struct sse_registered_event *reg_evt,
+				      unsigned long attr_id, unsigned long *val)
+{
+	struct sbiret sret;
+	u32 evt = reg_evt->event->evt_id;
+	unsigned long phys;
+
+	phys = sse_event_get_attr_phys(reg_evt);
+
+	sret = sbi_ecall(SBI_EXT_SSE, SBI_SSE_EVENT_ATTR_READ, evt, attr_id, 1,
+			 phys, 0, 0);
+	if (sret.error) {
+		pr_debug("Failed to get event %x attr %lx, error %ld\n", evt,
+			 attr_id, sret.error);
+		return sbi_err_map_linux_errno(sret.error);
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
+	unsigned long phys;
+
+	reg_evt->attr = val;
+	phys = sse_event_get_attr_phys(reg_evt);
+
+	sret = sbi_ecall(SBI_EXT_SSE, SBI_SSE_EVENT_ATTR_WRITE, evt, attr_id, 1,
+			 phys, 0, 0);
+	if (sret.error)
+		pr_debug("Failed to set event %x attr %lx, error %ld\n", evt,
+			 attr_id, sret.error);
+
+	return sbi_err_map_linux_errno(sret.error);
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
+	unsigned long hart_id = cpuid_to_hartid_map(cpu);
+	struct sse_registered_event *reg_evt = event->global;
+	u32 evt = event->evt_id;
+	bool was_enabled;
+	int ret;
+
+	if (!sse_event_is_global(evt))
+		return -EINVAL;
+
+	was_enabled = reg_evt->is_enabled;
+	if (was_enabled)
+		sse_event_disable_local(event);
+
+	ret = sse_event_attr_set_nolock(reg_evt, SBI_SSE_ATTR_PREFERRED_HART,
+					hart_id);
+	if (ret == 0)
+		sse_global_event_update_cpu(event, cpu);
+
+	if (was_enabled)
+		sse_event_enable_local(event);
+
+	return 0;
+}
+
+int sse_event_set_target_cpu(struct sse_event *event, unsigned int cpu)
+{
+	int ret;
+
+	scoped_guard(mutex, &sse_mutex) {
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
+	int err;
+	struct sse_registered_event *reg_evt;
+
+	reg_evt = kzalloc_obj(*reg_evt, GFP_KERNEL);
+	if (!reg_evt)
+		return -ENOMEM;
+
+	event->global = reg_evt;
+	err = sse_event_init_registered(smp_processor_id(), reg_evt, event);
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
+	event->handler = handler;
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
+	ret = sse_event_attr_set_nolock(reg_evt, SBI_SSE_ATTR_PRIO,
+					event->priority);
+	if (ret)
+		return ret;
+
+	return arch_sse_register_event(&reg_evt->arch);
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
+	return sse_sbi_event_func(event, SBI_SSE_EVENT_UNREGISTER);
+}
+
+struct sse_per_cpu_evt {
+	struct sse_event *event;
+	unsigned long func;
+	cpumask_t error;
+};
+
+static void sse_event_per_cpu_func(void *info)
+{
+	int ret;
+	struct sse_per_cpu_evt *cpu_evt = info;
+
+	if (cpu_evt->func == SBI_SSE_EVENT_REGISTER)
+		ret = sse_event_register_local(cpu_evt->event);
+	else
+		ret = sse_sbi_event_func(cpu_evt->event, cpu_evt->func);
+
+	if (ret)
+		cpumask_set_cpu(smp_processor_id(), &cpu_evt->error);
+}
+
+static void sse_event_free(struct sse_event *event)
+{
+	unsigned int cpu;
+	struct sse_registered_event *reg_evt;
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
+static int sse_on_each_cpu(struct sse_event *event, unsigned long func,
+			   unsigned long revert_func)
+{
+	struct sse_per_cpu_evt cpu_evt;
+
+	cpu_evt.event = event;
+	cpumask_clear(&cpu_evt.error);
+	cpu_evt.func = func;
+	on_each_cpu(sse_event_per_cpu_func, &cpu_evt, 1);
+	/*
+	 * If there are some error reported by CPUs, revert event state on the
+	 * other ones
+	 */
+	if (!cpumask_empty(&cpu_evt.error)) {
+		cpumask_t revert;
+
+		cpumask_andnot(&revert, cpu_online_mask, &cpu_evt.error);
+		cpu_evt.func = revert_func;
+		on_each_cpu_mask(&revert, sse_event_per_cpu_func, &cpu_evt, 1);
+
+		return -EIO;
+	}
+
+	return 0;
+}
+
+int sse_event_enable(struct sse_event *event)
+{
+	int ret = 0;
+
+	scoped_guard(mutex, &sse_mutex) {
+		scoped_guard(cpus_read_lock) {
+			if (sse_event_is_global(event->evt_id)) {
+				ret = sse_event_enable_local(event);
+			} else {
+				ret = sse_on_each_cpu(event,
+						      SBI_SSE_EVENT_ENABLE,
+						      SBI_SSE_EVENT_DISABLE);
+			}
+		}
+	}
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sse_event_enable);
+
+static int sse_events_mask(void)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_SSE, SBI_SSE_HART_MASK, 0, 0, 0, 0, 0, 0);
+
+	return sbi_err_map_linux_errno(ret.error);
+}
+
+static int sse_events_unmask(void)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_SSE, SBI_SSE_HART_UNMASK, 0, 0, 0, 0, 0, 0);
+
+	return sbi_err_map_linux_errno(ret.error);
+}
+
+static void sse_event_disable_nolock(struct sse_event *event)
+{
+	struct sse_per_cpu_evt cpu_evt;
+
+	if (sse_event_is_global(event->evt_id)) {
+		sse_event_disable_local(event);
+	} else {
+		cpu_evt.event = event;
+		cpu_evt.func = SBI_SSE_EVENT_DISABLE;
+		on_each_cpu(sse_event_per_cpu_func, &cpu_evt, 1);
+	}
+}
+
+void sse_event_disable(struct sse_event *event)
+{
+	scoped_guard(mutex, &sse_mutex) {
+		scoped_guard(cpus_read_lock) {
+			sse_event_disable_nolock(event);
+		}
+	}
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
+	if (!sse_available)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	guard(mutex)(&sse_mutex);
+	if (sse_event_get(evt))
+		return ERR_PTR(-EEXIST);
+
+	event = sse_event_alloc(evt, priority, handler, arg);
+	if (IS_ERR(event))
+		return event;
+
+	scoped_guard(cpus_read_lock) {
+		if (sse_event_is_global(evt)) {
+			unsigned long preferred_hart;
+
+			ret = sse_event_attr_get_no_lock(event->global,
+							 SBI_SSE_ATTR_PREFERRED_HART,
+							 &preferred_hart);
+			if (ret)
+				goto err_event_free;
+
+			cpu = riscv_hartid_to_cpuid(preferred_hart);
+			sse_global_event_update_cpu(event, cpu);
+
+			ret = sse_sbi_register_event(event, event->global);
+			if (ret)
+				goto err_event_free;
+
+		} else {
+			ret = sse_on_each_cpu(event, SBI_SSE_EVENT_REGISTER,
+					      SBI_SSE_EVENT_DISABLE);
+			if (ret)
+				goto err_event_free;
+		}
+	}
+
+	scoped_guard(spinlock, &events_list_lock)
+		list_add(&event->list, &events);
+
+	return event;
+
+err_event_free:
+	sse_event_free(event);
+
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(sse_event_register);
+
+static void sse_event_unregister_nolock(struct sse_event *event)
+{
+	struct sse_per_cpu_evt cpu_evt;
+
+	if (sse_event_is_global(event->evt_id)) {
+		sse_sbi_unregister_event(event);
+	} else {
+		cpu_evt.event = event;
+		cpu_evt.func = SBI_SSE_EVENT_UNREGISTER;
+		on_each_cpu(sse_event_per_cpu_func, &cpu_evt, 1);
+	}
+}
+
+void sse_event_unregister(struct sse_event *event)
+{
+	scoped_guard(mutex, &sse_mutex) {
+		scoped_guard(cpus_read_lock)
+			sse_event_unregister_nolock(event);
+
+		scoped_guard(spinlock, &events_list_lock)
+			list_del(&event->list);
+
+		sse_event_free(event);
+	}
+}
+EXPORT_SYMBOL_GPL(sse_event_unregister);
+
+static int sse_cpu_online(unsigned int cpu)
+{
+	struct sse_event *event;
+
+	scoped_guard(spinlock, &events_list_lock) {
+		list_for_each_entry(event, &events, list) {
+			if (sse_event_is_global(event->evt_id))
+				continue;
+
+			sse_event_register_local(event);
+			if (sse_get_reg_evt(event))
+				sse_event_enable_local(event);
+		}
+	}
+
+	/* Ready to handle events. Unmask SSE. */
+	return sse_events_unmask();
+}
+
+static int sse_cpu_teardown(unsigned int cpu)
+{
+	int ret = 0;
+	unsigned int next_cpu;
+	struct sse_event *event;
+	struct sse_registered_event *reg_evt;
+
+	/* Mask the sse events */
+	ret = sse_events_mask();
+	if (ret)
+		return ret;
+
+	scoped_guard(spinlock, &events_list_lock) {
+		list_for_each_entry(event, &events, list) {
+			/* Disable local event on current cpu */
+			if (!sse_event_is_global(event->evt_id)) {
+				reg_evt = sse_get_reg_evt(event);
+				if (reg_evt->is_enabled)
+					sse_event_disable_local(event);
+
+				sse_sbi_unregister_event(event);
+				continue;
+			}
+
+			if (event->cpu != smp_processor_id())
+				continue;
+
+			/* Update destination hart for global event */
+			next_cpu = cpumask_any_but(cpu_online_mask, cpu);
+			ret = sse_event_set_target_cpu_nolock(event, next_cpu);
+		}
+	}
+
+	return ret;
+}
+
+static int sse_pm_notifier(struct notifier_block *nb, unsigned long action,
+			   void *data)
+{
+	WARN_ON_ONCE(preemptible());
+
+	switch (action) {
+	case CPU_PM_ENTER:
+		sse_events_mask();
+		break;
+	case CPU_PM_EXIT:
+	case CPU_PM_ENTER_FAILED:
+		sse_events_unmask();
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block sse_pm_nb = {
+	.notifier_call = sse_pm_notifier,
+};
+
+/*
+ * Mask all CPUs and unregister all events on panic, reboot or kexec.
+ */
+static int sse_reboot_notifier(struct notifier_block *nb, unsigned long action,
+			       void *data)
+{
+	cpuhp_remove_state(sse_hp_state);
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
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "riscv/sse:online",
+				sse_cpu_online, sse_cpu_teardown);
+	if (ret < 0)
+		goto remove_reboot;
+
+	sse_hp_state = ret;
+	sse_available = true;
+
+	return 0;
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
diff --git a/include/linux/riscv_sbi_sse.h b/include/linux/riscv_sbi_sse.h
new file mode 100644
index 000000000000..84165cb5f2d0
--- /dev/null
+++ b/include/linux/riscv_sbi_sse.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2025 Rivos Inc.
+ */
+
+#ifndef __LINUX_RISCV_SBI_SSE_H
+#define __LINUX_RISCV_SBI_SSE_H
+
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
+struct sse_event *sse_event_register(u32 event_num, u32 priority,
+				     sse_event_handler_fn *handler, void *arg);
+
+void sse_event_unregister(struct sse_event *evt);
+
+int sse_event_set_target_cpu(struct sse_event *sse_evt, unsigned int cpu);
+
+int sse_event_enable(struct sse_event *sse_evt);
+
+void sse_event_disable(struct sse_event *sse_evt);
+
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
+static inline void sse_event_unregister(struct sse_event *evt) {}
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
+static inline void sse_event_disable(struct sse_event *sse_evt) {}
+#endif
+#endif /* __LINUX_RISCV_SBI_SSE_H */
-- 
2.50.1 (Apple Git-155)
