Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794989648;
	b=djAyvkZuzloGwNZcGyMcUqQYfVpgiVL15sMa3Lx0MzGk/Cv3gsBlz4x252uHwJKwA8MV
	 hQC/SKZFHNwac7lDlm5AhPBZJWoFonVkwov3HzQXy/CszOR+u1VbY7VhnqSCEJfQIve8J
	 9YrEWWyhkpKEeFAjmUyNYvXAmnc+3Dt8uHaYLNXs3JHwstBU9fsy1wKmnak1eJUYHUgnJ
	 kjjARS0BpcgoP9rGzmsU/eP01fWioqO1LTTRlFzQSwA80m1WBICCUZHW5LqM7w0O2IXCx
	 ayLkY51MY/TefqjheXuEXt5zmJzq2aDZ67dq7f5iIOlxMUqr/TNPKD2LfkHqintKczA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794989648;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=f2NCZzGgcdrImPed9UnBZvgkK6Iy+On/sKgEAZMJnX8=;
	b=frfaML4tP8wMkRBEBhsp09yI/u2Dj5J5AbkbVEnIT7J4Izw3r+vMsBuuRRdMpPgDnu8f
	 GQnaoXp2adFJsQnCjtG0DE864qLUUTYZ/3m8frKIKUWZLsV/+2YbCTYkczbdGtxYpPBBE
	 MuxGnnbbaGxWiVR98vu0lTkkBENKGN9N1G03Z67AADttzi8YRk9s6YJm0A4J0BcM9TcTx
	 Tn6EnRSBhU1BSPKbIgAnCIl1lCbmJs8c3za1mzNvCQncNopvtzpr7Tzh4dI7IYg1zqoKy
	 2JkyPytDyhHqj1kgNnOfsREHWYa86wjMFGbP9mGVGGYOJeWL+G2a4sF+QV92gHm+gSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=eiCKUgJl;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7501D606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 08:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7501D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=eiCKUgJl
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3b3a42a4bcdso324094a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 00:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1794989647; x=1795594447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f2NCZzGgcdrImPed9UnBZvgkK6Iy+On/sKgEAZMJnX8=;
        b=eiCKUgJlV8FYFgdiUKormrPCZnMBcJNr87Xd4H5fiW4GIhLll3eYNu7hSGF405R/gR
         N1wvjHmZRQ1u31rYzYTu/dEilDFLndNeGEVg1cFJhNZhKtMXvKexdpOgxLeDWmZVSqr9
         6oac9YJkUwPOmfGjD3ytcUsdYvIK73knRXLWxx2r1WLS09QdWGNgZuLhF5PNEuNfBm4I
         l3N1x86RTvfNKmEXlekMEGygqfrhysL05VM/3GaKh11ei17ZAFlPDps3OTvwbjN/VCF3
         VDfItzPlxvZiGfQkQGKlZ9R8FEie/XVcAQVZv8NzO8dsOn2m9oS7q7d+cbCt45qGkqXw
         NOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794989647; x=1795594447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f2NCZzGgcdrImPed9UnBZvgkK6Iy+On/sKgEAZMJnX8=;
        b=jBI68hpztvU6KvEqvVBXyqGnNo1PyMrI4f3KdOX2GN2X2AvHgOlow9lEozzIxjmDSJ
         nZIp5XanWBMBCOAWyX0+5bLm+fKBjDveszFH6vtqbRYmnm138afpVtSeRfVo91qXXfCS
         /Ur1GS8dmRJvi9pN0psuQoPdnL56yGCX8TQi02hL+uj76x8pLdV9U83Ipd/BotgXYf9L
         7ep/t4GnVyqJ5dGc6dUWQOr7vn9uY4pJgiE1dVIUVowM++tlWBIbs2iGQBfZWnCHcu8Q
         nL5EALC0EmX+Js7z+CHasupTKDQFgw5tGzgJjKgT+jSD18PevOp66Sq/Oz3hp+8MAn7g
         NQ8A==
X-Forwarded-Encrypted: i=1; AL+hErFFLQXr2GXyXpw3wOuzJggIQxc1AFny9WYRO7rMgNCIbYgcGt9TCtrY8p/+QeGF6FiotDcYOWLg3avpHHqhhwgp@vger.kernel.org
X-Gm-Message-State: APuU4Z+hULlPQ/MFe5wRV6blPRJYl74FIC4i0cXKROjtYqPiaYBD7Ipx
	C/PpwKwueQLT7R5QSf/aU0BUmhXG7W7a7Ae8uDOmdGUw7i+3V5ktJ0sxejox9wmuOgM=
X-Gm-Gg: AZFdTZfcszFvPdipdX02eVHLEY6EFK349xQ02PfYFSoo2quB3Y70guP7dwADFoo6frh
	aYQdj8gX4e1MYSHlFR1H0DpMwoNZ9PRpbAk4BkiI1asCZqCtxh6JhfLp0nr+gHECCg3vp1ifKz8
	MVTv5REe/hvRBYE8K6PFHdEU7KT1yOu7wpIh4rKhOL/osY5ZQ4n7C+yTtKNOS94u/4mMOEmj9T9
	6muiLQUCq/TuefWZZ5kcv1US3yh+nTAgPMax47Ipcr1cis4KbltuyPMzD1X+ed296tRzCg1Do2L
	XN8SalJ8iK/QLz4YkQbRqBdgdaCyT/W4CKzxrQxskEUBF9Szp5DIOy2OU44QxDexUDVW5hLFmRD
	xV7hSMFrcpZmKtTXBpsL5M+2X9OafYvIc7BsSMkC4Ed62peVVXIMKjwCGNWwg8kE5M+EJtGrnd9
	nfocw0vXduQ6wgUNijf5OP54If/whgpFAaskf5HpaGRIp798V/pEaOhtxurZi8vhG5C4Z+xyyUA
	4VRNDi/7TlRkQCVQXjj4yz4A6QnLeuL7VRjLVypllY+B9KnZeXFNyEgCHgKXDyKgJnhey0fZePW
	YjTt9bJX4kuw+MLuZ9jABbm/9Z/AGz1v8X1xjdhiAxwQsCAjch/GTUGKyYPQ37mtEO5rjvQQLhW
	srf3qA50=
X-Received: by 2002:a17:90b:1649:b0:3ab:c370:3684 with SMTP id 98e67ed59e1d1-3b3d07c3f7cmr1818912a91.30.1794989646684;
        Wed, 18 Nov 2026 00:14:06 -0800 (PST)
Received: from FJ7FR2JRQ3.bytedance.net ([186.240.245.239])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3d1acde50sm3254680a91.14.2026.11.18.00.13.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 00:14:06 -0800 (PST)
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
To: linux-riscv@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	andrew.jones@linux.dev,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	atish.patra@linux.dev,
	anup@brainfault.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	yuanzhu@bytedance.com,
	cuiyunhui@bytedance.com,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	will@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: [RFC PATCH v1 3/5] perf: riscv: Probe the experimental PDIS CSR layout on matching CPUs
Date: Wed, 18 Nov 2026 16:13:31 +0800
Message-ID: <20261118081327.10684-10-zhangzhanpeng.jasper@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261118081327.10684-7-zhangzhanpeng.jasper@bytedance.com>
References: <20261118081327.10684-7-zhangzhanpeng.jasper@bytedance.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The draft leaves CSR encodings unallocated. Require an explicit boot
opt-in, the csr-v1 test-model marker and the supervisor ISA extensions
before accessing the provisional registers. Probe the control, counter
width and filters with exception fixups and leave the unit inhibited.

Run the probe during CPU bringup on the standard local counter overflow
interrupt path. Quiesce the unit at CPU teardown. The experiment uses
RV64 with KVM disabled and matching firmware that excludes M/VS/VU.

Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
---
 .../admin-guide/kernel-parameters.txt         |  10 ++
 MAINTAINERS                                   |   1 +
 drivers/perf/Kconfig                          |  13 ++
 drivers/perf/Makefile                         |   1 +
 drivers/perf/riscv_pdis.c                     | 137 ++++++++++++++++++
 drivers/perf/riscv_pdis.h                     |  13 ++
 drivers/perf/riscv_pmu_sbi.c                  |   5 +
 7 files changed, 180 insertions(+)
 create mode 100644 drivers/perf/riscv_pdis.c
 create mode 100644 drivers/perf/riscv_pdis.h

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0b3c140babd9..dc15ddd29cf4 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6722,6 +6722,16 @@ Kernel parameters
 		fcfi	Disable user forward CFI ABI to userspace even if the
 			landing pad extension is available.
 
+	riscv_pdis_test= [RISCV,EARLY]
+			Format: <bool>
+			Authorize the experimental PDIS PMU to probe temporary
+			CSR encodings. Requires CONFIG_RISCV_PDIS_CSR,
+			CONFIG_KVM=n and matching test firmware. The private
+			test DT must mark each matching CPU with
+			riscv,pdis-test-model = "csr-v1".
+			Firmware must also advertise Sspdis on each usable CPU.
+			Default: disabled. Do not enable on production hardware.
+
 	ro		[KNL] Mount root device read-only on boot
 
 	rodata=		[KNL,EARLY]
diff --git a/MAINTAINERS b/MAINTAINERS
index 93abbb315065..3e695d4c5fc1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24128,6 +24128,7 @@ M:	Atish Patra <atish.patra@linux.dev>
 R:	Anup Patel <anup@brainfault.org>
 L:	linux-riscv@lists.infradead.org
 S:	Supported
+F:	drivers/perf/riscv_pdis*
 F:	drivers/perf/riscv_pmu.c
 F:	drivers/perf/riscv_pmu_legacy.c
 F:	drivers/perf/riscv_pmu_sbi.c
diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 245e7bb763b9..791d252d4952 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -105,6 +105,19 @@ config RISCV_PMU_SBI
 	  full perf feature support i.e. counter overflow, privilege mode
 	  filtering, counter configuration.
 
+config RISCV_PDIS_CSR
+	bool "Experimental RISC-V PDIS CSR-output perf PMU"
+	depends on RISCV_PMU_SBI && 64BIT && MMU && !RISCV_M_MODE && EXPERT
+	help
+	  Build an experimental per-CPU PDIS sampling PMU. This requires a
+	  matching test model and firmware with the temporary CSR encodings.
+	  Firmware must report Sspdis on CPUs authorized to use PDIS.
+	  The riscv_pdis_test=1 boot parameter explicitly authorizes probing.
+	  Task sampling, mixed privilege and KVM are not supported. Do not
+	  enable the boot parameter on existing production hardware.
+
+	  If unsure, say N.
+
 config STARFIVE_STARLINK_PMU
 	depends on ARCH_STARFIVE || COMPILE_TEST
 	depends on 64BIT
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index eb8a022dad9a..203e6227dc6b 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_QCOM_L3_PMU) += qcom_l3_pmu.o
 obj-$(CONFIG_RISCV_PMU) += riscv_pmu.o
 obj-$(CONFIG_RISCV_PMU_LEGACY) += riscv_pmu_legacy.o
 obj-$(CONFIG_RISCV_PMU_SBI) += riscv_pmu_sbi.o
+obj-$(CONFIG_RISCV_PDIS_CSR) += riscv_pdis.o
 obj-$(CONFIG_STARFIVE_STARLINK_PMU) += starfive_starlink_pmu.o
 obj-$(CONFIG_THUNDERX2_PMU) += thunderx2_pmu.o
 obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o
diff --git a/drivers/perf/riscv_pdis.c b/drivers/perf/riscv_pdis.c
new file mode 100644
index 000000000000..b7671e5ad63e
--- /dev/null
+++ b/drivers/perf/riscv_pdis.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Experimental RV64 PDIS CSR-output PMU for an explicitly matching model. */
+
+#include <linux/bits.h>
+#include <linux/cpu.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/of.h>
+#include <linux/percpu.h>
+
+#include <asm/asm-extable.h>
+#include <asm/cpufeature.h>
+#include <asm/csr.h>
+
+#include "riscv_pdis.h"
+
+/* Draft spdis.adoc at 2de60e18118ce78e2da82ec33296345c94d8560c. */
+#define RISCV_PDIS_COUNTER_BIT		BIT(1)
+/* Local experimental encodings, not architectural CSR allocations. */
+#define RISCV_PDIS_CSR_CTL		0x5e0
+#define RISCV_PDIS_CSR_COUNTER		0x5e1
+#define RISCV_PDIS_CSR_EVMASK		0x5e2
+#define RISCV_PDIS_CSR_EVMATCH		0x5e3
+#define RISCV_PDIS_CSR_FILTER		0x5e4
+#define RISCV_PDIS_CSR_VSCTL		0x6d0
+#define RISCV_PDIS_STATEEN		BIT_ULL(55)
+#define RISCV_PDIS_CTL_ACC		BIT_ULL(33)
+
+struct pdis_cpu {
+	bool ready;
+};
+
+static DEFINE_PER_CPU(struct pdis_cpu, pdis_cpu);
+static cpumask_t pdis_cpus;
+static bool pdis_test;
+
+static int __init pdis_test_setup(char *str)
+{
+	return kstrtobool(str, &pdis_test);
+}
+early_param("riscv_pdis_test", pdis_test_setup);
+
+/* Private test DT marker, not a binding for architectural PDIS. */
+static bool pdis_test_model_matches(unsigned int cpu)
+{
+	struct device_node *node = of_cpu_device_node_get(cpu);
+	const char *model;
+	bool matches;
+
+	matches = !of_property_read_string(node, "riscv,pdis-test-model", &model) &&
+		  !strcmp(model, "csr-v1");
+	of_node_put(node);
+	return matches;
+}
+
+/* Used only during opt-in probing; missing/unauthorized CSRs must not oops. */
+static __always_inline int pdis_read_csr(unsigned int csr, unsigned long *value)
+{
+	asm goto("1: csrr %[value], %[csr]\n"
+		 _ASM_EXTABLE(1b, %l[fault])
+		 : [value] "=r" (*value) : [csr] "i" (csr) : "memory" : fault);
+	return 0;
+fault:
+	*value = 0;
+	return -ENODEV;
+}
+
+static __always_inline int pdis_write_csr(unsigned int csr, unsigned long value)
+{
+	asm goto("1: csrw %[csr], %[value]\n"
+		 _ASM_EXTABLE(1b, %l[fault])
+		 : : [value] "r" (value), [csr] "i" (csr) : "memory" : fault);
+	return 0;
+fault:
+	return -ENODEV;
+}
+
+void riscv_pdis_cpu_starting(void)
+{
+	struct pdis_cpu *pcpu = this_cpu_ptr(&pdis_cpu);
+	unsigned long ctl, inhibit, value;
+	unsigned int cpu = smp_processor_id();
+
+	pcpu->ready = false;
+	cpumask_clear_cpu(cpu, &pdis_cpus);
+	if (!pdis_test || IS_ENABLED(CONFIG_KVM) ||
+	    !riscv_cpu_has_extension_unlikely(cpu, RISCV_ISA_EXT_SSPDIS) ||
+	    !riscv_cpu_has_extension_unlikely(cpu, RISCV_ISA_EXT_SSCOFPMF) ||
+	    !riscv_cpu_has_extension_unlikely(cpu, RISCV_ISA_EXT_SSCSRIND) ||
+	    !pdis_test_model_matches(cpu))
+		return;
+
+	if (pdis_read_csr(RISCV_PDIS_CSR_CTL, &ctl) ||
+	    ctl & ~RISCV_PDIS_CTL_ACC ||
+	    pdis_read_csr(CSR_SCOUNTINHIBIT, &inhibit) ||
+	    !(inhibit & RISCV_PDIS_COUNTER_BIT))
+		return;
+	if (pdis_write_csr(RISCV_PDIS_CSR_CTL, 0) ||
+	    pdis_write_csr(RISCV_PDIS_CSR_EVMASK, 0) ||
+	    pdis_write_csr(RISCV_PDIS_CSR_EVMATCH, 0) ||
+	    pdis_write_csr(RISCV_PDIS_CSR_FILTER, 0))
+		return;
+	if (pdis_read_csr(RISCV_PDIS_CSR_EVMASK, &value) || value ||
+	    pdis_read_csr(RISCV_PDIS_CSR_EVMATCH, &value) || value ||
+	    pdis_read_csr(RISCV_PDIS_CSR_FILTER, &value) || value)
+		return;
+	/* The first version requires all 32 COUNT and INITVAL bits. */
+	if (pdis_write_csr(RISCV_PDIS_CSR_COUNTER, ~0UL) ||
+	    pdis_read_csr(RISCV_PDIS_CSR_COUNTER, &value) || value != ~0UL ||
+	    pdis_write_csr(RISCV_PDIS_CSR_COUNTER, 0))
+		return;
+	if (riscv_cpu_has_extension_unlikely(cpu, RISCV_ISA_EXT_H)) {
+		if (pdis_read_csr(RISCV_PDIS_CSR_VSCTL, &value) ||
+		    value & ~RISCV_PDIS_CTL_ACC ||
+		    pdis_read_csr(CSR_HSTATEEN0, &value) || value & RISCV_PDIS_STATEEN)
+			return;
+	}
+	pcpu->ready = true;
+	cpumask_set_cpu(cpu, &pdis_cpus);
+}
+
+static void pdis_quiesce(void)
+{
+	csr_set(CSR_SCOUNTINHIBIT, RISCV_PDIS_COUNTER_BIT);
+	/* The test-model contract requires this to cancel in-flight selections. */
+	csr_write(RISCV_PDIS_CSR_CTL, 0);
+}
+
+void riscv_pdis_cpu_dying(void)
+{
+	struct pdis_cpu *pcpu = this_cpu_ptr(&pdis_cpu);
+
+	if (pcpu->ready)
+		pdis_quiesce();
+	pcpu->ready = false;
+	cpumask_clear_cpu(smp_processor_id(), &pdis_cpus);
+}
diff --git a/drivers/perf/riscv_pdis.h b/drivers/perf/riscv_pdis.h
new file mode 100644
index 000000000000..b1ffe7d16ce0
--- /dev/null
+++ b/drivers/perf/riscv_pdis.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __RISCV_PDIS_H
+#define __RISCV_PDIS_H
+
+#ifdef CONFIG_RISCV_PDIS_CSR
+void riscv_pdis_cpu_starting(void);
+void riscv_pdis_cpu_dying(void);
+#else
+static inline void riscv_pdis_cpu_starting(void) { }
+static inline void riscv_pdis_cpu_dying(void) { }
+#endif
+
+#endif /* __RISCV_PDIS_H */
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 21a2078eab98..545b8becf90a 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -27,6 +27,8 @@
 #include <asm/vendor_extensions.h>
 #include <asm/vendor_extensions/andes.h>
 
+#include "riscv_pdis.h"
+
 #define ALT_SBI_PMU_OVERFLOW(__ovl)					\
 asm volatile(ALTERNATIVE_2(						\
 	"csrr %0, " __stringify(CSR_SCOUNTOVF),				\
@@ -1204,6 +1206,8 @@ static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_node *node)
 
 	if (riscv_pmu_use_irq) {
 		cpu_hw_evt->irq = riscv_pmu_irq;
+		if (riscv_pmu_irq_num == RV_IRQ_PMU)
+			riscv_pdis_cpu_starting();
 		ALT_SBI_PMU_OVF_CLEAR_PENDING(riscv_pmu_irq_mask);
 		enable_percpu_irq(riscv_pmu_irq, IRQ_TYPE_NONE);
 	}
@@ -1216,6 +1220,7 @@ static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_node *node)
 
 static int pmu_sbi_dying_cpu(unsigned int cpu, struct hlist_node *node)
 {
+	riscv_pdis_cpu_dying();
 	if (riscv_pmu_use_irq) {
 		disable_percpu_irq(riscv_pmu_irq);
 	}
-- 
2.50.1 (Apple Git-155)

