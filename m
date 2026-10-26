Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793049127;
	b=IzIicpi3LZ0yK0r2PbZuWlNLCkKOfgAAiFuP3wis9/on0jaPZG4BsEgUsV819GYK2pap
	 BK/AjkKKqsPENiFhtIz5APscijOdpgrQGxjFa60dkIfDKJq+HxR2xRzTarNIuJ+tYhLQr
	 HxSHtg2zCOHsfX3XzXrphSEv/yP9gGxyH7zKZPZi9Qy2jawXS2H6eikNIZ0bbCkuVABRi
	 w1Emx1NbCRwVZ3KfwpAoyaGquVBhSrglamwZ9zL9GMxf1X9+WuyWGUb8LrQ/1zjyeDRL9
	 3G9jnzAUUmCs5EFkTrliJmxoid0GqDqr0SDKf3zJUSEIzDTqUksMirqhrTNeQs6CUWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793049127;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=nCwaaw/xtqnGmXa8VVCm7Mi3yhp9/gJBGfWg6DotTq8=;
	b=Ql/UQKkBdtjmsE5MetEspDU7KdMEpCuamXOLLr6B/LjAhMMlCQeQRdNSppIEmvCBp+nk
	 PfPK7zrICbW5y91XjK7EnkUnPjXXPoQBxXO7RQSEWY4LLD2qOL9riPwRzwuArbj1xBqyQ
	 T8iEAhemdNX1+hr4ZevI/8OyLRKDZgA2gA1//xTUg0ETRG+SRiLmmCclFUF9okQlGDeIH
	 34COOBB4mZCEa+bfEYHJed5tGQagSrTOzU7xpd4IrAk/KhIljlDmmOB2jzWHMkpBs7wYe
	 yD+UNM67tv5SvxiCIgroDtHGJlrFSFykPlCIEUE3vyCqNDRbEhtZMirjqI7uEbUo8hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=ByI+zTxU;
	arc=none smtp.remote-ip=209.85.216.99
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4095E606A326
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 21:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4095E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=ByI+zTxU
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3ae25008e2aso616419a91.2
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 14:12:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793049127; x=1793653927;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nCwaaw/xtqnGmXa8VVCm7Mi3yhp9/gJBGfWg6DotTq8=;
        b=cGvHnbkcjWhG1ygu5nA1WHDyWir4wCjZ4bpshUkrA7gwnrfNHJewQCLR5R26IANUdY
         mm9uYIZpejv7pN712RUHKB63e1VXF64sMkhZur3C829Id3MjvFhVHlAfMr5GqNT8Ke9a
         9eYVH5A1zXg73BYt4bVkpTU/t05G2jRtjwdT3JtdS4ew4FFGK5jHykFI2S5GrUhhv7kO
         Neaf0gkxJcgEYLgyUEy7oASh7aEM3ovdVNtp1kdr4aYcB85d1DuOq1/cTDLdd1PoiHKb
         Kw5iTZjUv015iJ3ONF1wWtJtxqf4waTMIoSd7sAxPrFJMDnsYeyK/CYR8hHsgDuWVl0x
         xKPA==
X-Forwarded-Encrypted: i=1; AKwUvBzC2cTqzleR1UAtJaFjw5OgDddERsSRWOzV/pG49kZxwQiYTCDrD66lvZ/vCmXd3LrZhytea5VKzOk4BRNbidl+@vger.kernel.org
X-Gm-Message-State: AFq9FYIr6WeSfd5JrPOgwKrDC2sOPS49ataxEhrV5Q9NPQFBJziB1vfZ
	zCLCjse4h8SqluZtrMzXZ1KuhxvP5A7jSxSOi/WgEbjw9lq/ToyCc52oPgc4NhEQXaxqGtA/1hp
	jcsMnHmLeByO55f0L8YLp8kiejVtuv0Nm6BKog57o3IoWeBz1tUD4QHSTznD2R3IIvtWJ59DmD4
	2MAzY7wrFUv9kZ66gMLeHqAkHJqx+KjrKCzxQRNlpcDJgN+Ri8U34CgNDQwLEH3GaSFjQ3aZCya
	R51kHLMB3e7sP4CoFdCKt/Az1IimjSV
X-Gm-Gg: AYBFou1DyokpyeEq200l5HVHOMVyv5uHVuTYhZ/HbhGEK+Zn073JmU7XN+1cNy6pNuj
	znpZda6rzP4ADs3/nWh/R/z7om215pXHksaJ2+XzLMDP3csA6G+F6NP7hHEcozf7EudY38JXqd4
	2okF5Bi54DlVwCjdfQHSqeK0ylTCK/dWogglfN9X4jdCkZQ86To+p3ipIJzFcZjyM2CPI/x36x4
	tim9nos/xOnNxb4vx1p8g8G88gGjuYXhNRXEottRzk18gMdWaBtAHAqvohFBQERb2fFm7sX4jsR
	0GlLhl6ddcRhbBftXn8M1N7Wb0MFkZ5KQVjXFSsk2Mxqr6ZavxLJhjMKOqDDLdW51q9wxLNu31B
	RWNpt3bDHTrIQaV8A9cdJXdTV1DcRMGTACdwo873MR6RYUzRLaVgF05d9RAwRyJosx8LfAqu7DS
	4Qr3oWL5+sXc4UB1km45b17Dcyj9dIzR+ZY4w7bKaE
X-Received: by 2002:a17:90b:4b82:b0:3ac:8af9:4a73 with SMTP id 98e67ed59e1d1-3adead249d4mr6229833a91.28.1793049126320;
        Mon, 26 Oct 2026 14:12:06 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-23.dlp.protect.broadcom.com. [144.49.247.23])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3adebb2e8casm3130051a91.4.2026.10.26.14.12.05
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2026 14:12:06 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-139b62317d0so401704c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 14:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793049124; x=1793653924; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nCwaaw/xtqnGmXa8VVCm7Mi3yhp9/gJBGfWg6DotTq8=;
        b=ByI+zTxUppE8mZMPzLTY62Y+LjKur0ZKOraxr4aJeIw94hO+nO0H3l+TPwbNDUsli3
         RboF8JGrpxnZsuf4k8Io9pcZCNQXDWBV/0FyUrNHx+F2Vyq/oHYMRfUbCv/ODI+MXA+P
         PFpNgFCZPQElcxqXcozYZlQHMaL9gwOzAOHn0=
X-Forwarded-Encrypted: i=1; AKwUvBxPZsHCE/JoZAjrHuI7JmvNQdMNJeQQdsklNU31XOI7wNBoOhlHfJBLlN0eY7TULlNLceZK0HVL17ghHr4Gw5ol@vger.kernel.org
X-Received: by 2002:a05:7022:b05b:b0:196:aa86:fcf3 with SMTP id a92af1059eb24-19937da1c5cmr10506852c88.26.1793049123679;
        Mon, 26 Oct 2026 14:12:03 -0700 (PDT)
X-Received: by 2002:a05:7022:b05b:b0:196:aa86:fcf3 with SMTP id a92af1059eb24-19937da1c5cmr10506819c88.26.1793049122843;
        Mon, 26 Oct 2026 14:12:02 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a0f81ea9sm31915678c88.11.2026.10.26.14.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 14:12:02 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM5301X ARM ARCHITECTURE),
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-perf-users@vger.kernel.org (open list:ARM PMU PROFILING AND DEBUGGING),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Subject: [PATCH 2/3] perf: Add Broadcom BCM5301X AXI Trace Module counters
Date: Mon, 26 Oct 2026 14:11:50 -0700
Message-ID: <20261026211151.3212237-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026211151.3212237-1-florian.fainelli@broadcom.com>
References: <20261026211151.3212237-1-florian.fainelli@broadcom.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Expose unfiltered fixed counters through system-wide perf events. Keep
hardware free-running and use per-event baselines, locking, and periodic
32-bit delta accounting without resetting concurrent measurements.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 .../admin-guide/perf/bcm5301x-axi-pmu.rst     |  92 ++++
 Documentation/admin-guide/perf/index.rst      |   1 +
 MAINTAINERS                                   |   2 +
 drivers/perf/Kconfig                          |  12 +
 drivers/perf/Makefile                         |   1 +
 drivers/perf/bcm5301x_axi_pmu.c               | 450 ++++++++++++++++++
 6 files changed, 558 insertions(+)
 create mode 100644 Documentation/admin-guide/perf/bcm5301x-axi-pmu.rst
 create mode 100644 drivers/perf/bcm5301x_axi_pmu.c

diff --git a/Documentation/admin-guide/perf/bcm5301x-axi-pmu.rst b/Documentation/admin-guide/perf/bcm5301x-axi-pmu.rst
new file mode 100644
index 000000000000..720f042dfbd0
--- /dev/null
+++ b/Documentation/admin-guide/perf/bcm5301x-axi-pmu.rst
@@ -0,0 +1,92 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+Broadcom BCM5301X AXI Trace Module PMU
+====================================
+
+The BCM5301X AXI Trace Modules observe the two PL310 master interfaces and
+the Accelerator Coherency Port (ACP). Each instance registers a PMU named
+``bcm5301x_axi_<physical-base>``, for example ``bcm5301x_axi_19003000`` for
+PL310 M0, ``bcm5301x_axi_19004000`` for PL310 M1, and
+``bcm5301x_axi_19007000`` for ACP.
+
+Enable CONFIG_PERF_EVENTS and CONFIG_BCM5301X_AXI_PMU and provide an enabled
+device-tree node for each instance. Load ``bcm5301x_axi_pmu`` if built as a
+module. The driver owns the module exclusively; firmware or debug tools
+must not change its configuration while the driver is bound.
+
+Events and scope
+----------------
+
+The ``events`` and ``format`` directories under
+``/sys/bus/event_source/devices/bcm5301x_axi_*`` describe the ABI. Event IDs
+0 through 15 select fixed counters:
+
+==== ====================================
+ID   Event
+==== ====================================
+0    write_commands
+1    read_commands
+2    write_address_cycles
+3    read_address_cycles
+4    write_data_cycles
+5    read_data_cycles
+6    write_response_cycles
+7    write_address_stall_cycles
+8    read_address_stall_cycles
+9    write_data_stall_cycles
+10   read_data_stall_cycles
+11   write_response_stall_cycles
+12   write_beats
+13   read_beats
+14   write_outstanding_cycles
+15   read_outstanding_cycles
+==== ====================================
+
+Active channel cycles count VALID asserted; stall cycles count VALID
+asserted while READY is deasserted. Outstanding cycles count cycles with
+more than zero outstanding commands. These are cycle counts, not the sum
+of outstanding requests. Counts cover all traffic at the observed port;
+PL310 hits do not necessarily generate traffic at its master interfaces.
+ACP can remain idle unless an accelerator uses that interface.
+
+All measurements are unfiltered and system-wide. The ``cpumask`` file
+identifies the CPU managing each PMU, not a CPU traffic filter. Per-task
+counting, privilege exclusions, sampling, configurable AXI filters,
+latency measurements, and ATB transaction trace capture are unsupported.
+Beat counts are reported as beats, without assuming a byte conversion.
+
+Each fixed counter can be allocated once at a time. Duplicate requests
+in a single group are rejected; separate events can be multiplexed by
+perf. Different counters on one PMU can run together. Groups spanning
+different hardware PMUs are rejected.
+
+The hardware counters run continuously while the driver is bound, with
+per-event baselines excluding periods when an event is stopped. Starting
+one event does not reset another event's hardware counter. There is no
+overflow interrupt. A timer extends the wrapping 32-bit counters to 64 bits
+every 100 ms while events run. At 500 MHz a counter incrementing once per
+cycle wraps in about 8.6 seconds. Accuracy requires servicing the timer
+before a full wrap; long interrupt stalls and suspend intervals can lose
+counts. Stop measurements before suspending the system.
+
+Testing
+-------
+
+Check discovery and count commands and beats over a memory workload::
+
+  modprobe bcm5301x_axi_pmu
+  ls /sys/bus/event_source/devices/bcm5301x_axi_*
+  perf list | grep bcm5301x_axi
+  perf stat -a -e '{bcm5301x_axi_19003000/read_commands/,bcm5301x_axi_19003000/read_beats/}' -- sleep 10
+
+Repeat during a workload whose working set exceeds the PL310 cache, such
+as a memory stress test. Compare with idle, test M1 separately, and expect
+ACP activity only with an ACP user. Network DMA traffic alone need not
+cross the monitored PL310 ports. Use ``perf stat -a -I 1000`` for interval
+counts and run for at least a minute under load to exercise counter wrap.
+
+Check that adding or removing a second, different counter leaves the first
+counter accumulating. Two requests for the same event in one group must
+fail. ``perf record`` and per-task ``perf stat`` must fail. If CPU hotplug
+is available, offline the CPU listed in ``cpumask`` while counting and
+verify that management moves to another online CPU and counting continues.
diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/admin-guide/perf/index.rst
index aa12708ddb96..6cf0010a3413 100644
--- a/Documentation/admin-guide/perf/index.rst
+++ b/Documentation/admin-guide/perf/index.rst
@@ -31,3 +31,4 @@ Performance monitor support
    ampere_cspmu
    mrvl-pem-pmu
    fujitsu_uncore_pmu
+   bcm5301x-axi-pmu
diff --git a/MAINTAINERS b/MAINTAINERS
index b97f22107fbf..460725721bc8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5220,12 +5220,14 @@ M:	Rafał Miłecki <zajec5@gmail.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+F:	Documentation/admin-guide/perf/bcm5301x-axi-pmu.rst
 F:	Documentation/devicetree/bindings/perf/brcm,bcm5301x-axi-pmu.yaml
 F:	arch/arm/boot/dts/broadcom/bcm-ns.dtsi
 F:	arch/arm/boot/dts/broadcom/bcm470*
 F:	arch/arm/boot/dts/broadcom/bcm5301*
 F:	arch/arm/boot/dts/broadcom/bcm953012*
 F:	arch/arm/mach-bcm/bcm_5301x.c
+F:	drivers/perf/bcm5301x_axi_pmu.c
 
 BROADCOM BCM53573 ARM ARCHITECTURE
 M:	Florian Fainelli <florian.fainelli@broadcom.com>
diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 245e7bb763b9..69674cc3f31f 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -6,6 +6,18 @@
 menu "Performance monitor support"
 	depends on PERF_EVENTS
 
+config BCM5301X_AXI_PMU
+	tristate "Broadcom BCM5301X AXI Trace Module PMU"
+	depends on ARCH_BCM_5301X || COMPILE_TEST
+	depends on OF
+	help
+	  Support system-wide perf counting on the BCM5301X AXI Trace Modules
+	  monitoring the PL310 master interfaces and ACP. Supports commands,
+	  beats, active/stall cycles, and outstanding-command cycles. Sampling
+	  and transaction trace capture are not supported.
+
+	  If compiled as a module, it will be called bcm5301x_axi_pmu.
+
 config ARM_CCI_PMU
 	tristate "ARM CCI PMU driver"
 	depends on (ARM && CPU_V7) || ARM64
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index eb8a022dad9a..2a51a963b692 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_BCM5301X_AXI_PMU) += bcm5301x_axi_pmu.o
 obj-$(CONFIG_ARM_CCI_PMU) += arm-cci.o
 obj-$(CONFIG_ARM_CCN) += arm-ccn.o
 obj-$(CONFIG_ARM_CMN) += arm-cmn.o
diff --git a/drivers/perf/bcm5301x_axi_pmu.c b/drivers/perf/bcm5301x_axi_pmu.c
new file mode 100644
index 000000000000..15da137a4085
--- /dev/null
+++ b/drivers/perf/bcm5301x_axi_pmu.c
@@ -0,0 +1,450 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Broadcom BCM5301X AXI Trace Module performance counters. */
+
+#include <linux/bitops.h>
+#include <linux/cpu.h>
+#include <linux/cpuhotplug.h>
+#include <linux/hrtimer.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/perf_event.h>
+#include <linux/platform_device.h>
+#include <linux/sizes.h>
+#include <linux/slab.h>
+
+#define ATM_CONFIG		0x00
+#define ATM_STATUS		0x04
+#define ATM_CMD			0x0c
+#define ATM_CTRL_LOCAL		BIT(0)
+#define ATM_CMDS_EN		BIT(4)
+#define ATM_BEATS_EN		BIT(6)
+#define ATM_BUSY_EN		BIT(8)
+#define ATM_OUTS_EN		BIT(14)
+#define ATM_COUNT_ENABLE	(ATM_CMDS_EN | ATM_BEATS_EN | \
+				 ATM_BUSY_EN | ATM_OUTS_EN)
+#define ATM_STATE_ENABLE	(BIT(9) | BIT(10) | BIT(11) | BIT(13))
+#define ATM_STATE_MASK		GENMASK(13, 9)
+#define ATM_CLEAR		0
+#define ATM_STOP		1
+#define ATM_START		2
+
+/* At most one increment per AXI cycle for the exposed counters. */
+#define ATM_POLL_INTERVAL	ms_to_ktime(100)
+#define ATM_NR_COUNTERS		16
+
+static enum cpuhp_state bcm5301x_axi_hp_state;
+
+struct bcm5301x_axi_pmu {
+	struct pmu pmu;
+	void __iomem *base;
+	raw_spinlock_t lock;
+	struct hrtimer timer;
+	struct hlist_node hp_node;
+	struct perf_event *events[ATM_NR_COUNTERS];
+	unsigned int nr_active;
+	int cpu;
+};
+
+/* Event IDs select fixed counters, not programmable event selectors. */
+static const u16 bcm5301x_axi_offsets[ATM_NR_COUNTERS] = {
+	0x10, 0x14, 0x18, 0x1c, 0x20, 0x24, 0x28, 0x2c,
+	0x30, 0x34, 0x38, 0x3c, 0x58, 0x5c, 0x60, 0x64,
+};
+
+#define ATM_EVENT(_name, _id) \
+	static struct perf_pmu_events_attr event_attr_##_name = { \
+		.attr = __ATTR(_name, 0444, perf_event_sysfs_show, NULL), \
+		.id = _id, \
+		.event_str = "event=" __stringify(_id), \
+	}
+
+ATM_EVENT(write_commands, 0);
+ATM_EVENT(read_commands, 1);
+ATM_EVENT(write_address_cycles, 2);
+ATM_EVENT(read_address_cycles, 3);
+ATM_EVENT(write_data_cycles, 4);
+ATM_EVENT(read_data_cycles, 5);
+ATM_EVENT(write_response_cycles, 6);
+ATM_EVENT(write_address_stall_cycles, 7);
+ATM_EVENT(read_address_stall_cycles, 8);
+ATM_EVENT(write_data_stall_cycles, 9);
+ATM_EVENT(read_data_stall_cycles, 10);
+ATM_EVENT(write_response_stall_cycles, 11);
+ATM_EVENT(write_beats, 12);
+ATM_EVENT(read_beats, 13);
+ATM_EVENT(write_outstanding_cycles, 14);
+ATM_EVENT(read_outstanding_cycles, 15);
+
+static struct attribute *bcm5301x_axi_event_attrs[] = {
+	&event_attr_write_commands.attr.attr,
+	&event_attr_read_commands.attr.attr,
+	&event_attr_write_address_cycles.attr.attr,
+	&event_attr_read_address_cycles.attr.attr,
+	&event_attr_write_data_cycles.attr.attr,
+	&event_attr_read_data_cycles.attr.attr,
+	&event_attr_write_response_cycles.attr.attr,
+	&event_attr_write_address_stall_cycles.attr.attr,
+	&event_attr_read_address_stall_cycles.attr.attr,
+	&event_attr_write_data_stall_cycles.attr.attr,
+	&event_attr_read_data_stall_cycles.attr.attr,
+	&event_attr_write_response_stall_cycles.attr.attr,
+	&event_attr_write_beats.attr.attr,
+	&event_attr_read_beats.attr.attr,
+	&event_attr_write_outstanding_cycles.attr.attr,
+	&event_attr_read_outstanding_cycles.attr.attr,
+	NULL,
+};
+
+static const struct attribute_group bcm5301x_axi_events_group = {
+	.name = "events",
+	.attrs = bcm5301x_axi_event_attrs,
+};
+
+PMU_FORMAT_ATTR(event, "config:0-3");
+
+static struct attribute *bcm5301x_axi_format_attrs[] = {
+	&format_attr_event.attr,
+	NULL,
+};
+
+static const struct attribute_group bcm5301x_axi_format_group = {
+	.name = "format",
+	.attrs = bcm5301x_axi_format_attrs,
+};
+
+static struct bcm5301x_axi_pmu *to_axi_pmu(struct pmu *pmu)
+{
+	return container_of(pmu, struct bcm5301x_axi_pmu, pmu);
+}
+
+static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	struct bcm5301x_axi_pmu *axi = to_axi_pmu(dev_get_drvdata(dev));
+
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(READ_ONCE(axi->cpu))));
+}
+static DEVICE_ATTR_RO(cpumask);
+
+static struct attribute *bcm5301x_axi_attrs[] = {
+	&dev_attr_cpumask.attr,
+	NULL,
+};
+
+static const struct attribute_group bcm5301x_axi_group = {
+	.attrs = bcm5301x_axi_attrs,
+};
+
+static const struct attribute_group *bcm5301x_axi_attr_groups[] = {
+	&bcm5301x_axi_events_group,
+	&bcm5301x_axi_format_group,
+	&bcm5301x_axi_group,
+	NULL,
+};
+
+static u32 bcm5301x_axi_read_counter(struct bcm5301x_axi_pmu *axi, int idx)
+{
+	return readl(axi->base + bcm5301x_axi_offsets[idx]);
+}
+
+/* All counter state, including prev_count, is serialized by axi->lock. */
+static void bcm5301x_axi_update(struct bcm5301x_axi_pmu *axi,
+			       struct perf_event *event)
+{
+	u32 now = bcm5301x_axi_read_counter(axi, event->hw.idx);
+	u32 prev = local64_read(&event->hw.prev_count);
+
+	local64_set(&event->hw.prev_count, now);
+	local64_add((u32)(now - prev), &event->count);
+}
+
+static enum hrtimer_restart bcm5301x_axi_timer(struct hrtimer *timer)
+{
+	struct bcm5301x_axi_pmu *axi = container_of(timer, typeof(*axi), timer);
+	enum hrtimer_restart ret = HRTIMER_NORESTART;
+	unsigned long flags;
+	int i;
+
+	raw_spin_lock_irqsave(&axi->lock, flags);
+	for (i = 0; i < ATM_NR_COUNTERS; i++) {
+		struct perf_event *event = axi->events[i];
+
+		if (event && !(event->hw.state & PERF_HES_STOPPED))
+			bcm5301x_axi_update(axi, event);
+	}
+	if (axi->nr_active) {
+		hrtimer_forward_now(timer, ATM_POLL_INTERVAL);
+		ret = HRTIMER_RESTART;
+	}
+	raw_spin_unlock_irqrestore(&axi->lock, flags);
+
+	return ret;
+}
+
+static int bcm5301x_axi_event_init(struct perf_event *event)
+{
+	struct bcm5301x_axi_pmu *axi = to_axi_pmu(event->pmu);
+	struct perf_event *sibling, *leader = event->group_leader;
+	unsigned long used = 0;
+
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK ||
+	    event->cpu < 0)
+		return -EOPNOTSUPP;
+	if (event->attr.config >= ATM_NR_COUNTERS || event->attr.config1 ||
+	    event->attr.config2)
+		return -EINVAL;
+
+	/* A group cannot allocate the same fixed counter twice. */
+	if (!is_software_event(leader)) {
+		if (leader->pmu != event->pmu)
+			return -EINVAL;
+		__set_bit(leader->attr.config, &used);
+	}
+	for_each_sibling_event(sibling, leader) {
+		if (is_software_event(sibling))
+			continue;
+		if (sibling->pmu != event->pmu ||
+		    test_and_set_bit(sibling->attr.config, &used))
+			return -EINVAL;
+	}
+	if (event != leader && test_bit(event->attr.config, &used))
+		return -EINVAL;
+
+	event->cpu = READ_ONCE(axi->cpu);
+	event->hw.idx = -1;
+	return 0;
+}
+
+static void bcm5301x_axi_start(struct perf_event *event, int flags)
+{
+	struct bcm5301x_axi_pmu *axi = to_axi_pmu(event->pmu);
+	unsigned long irqflags;
+
+	raw_spin_lock_irqsave(&axi->lock, irqflags);
+	if (event->hw.state & PERF_HES_STOPPED) {
+		local64_set(&event->hw.prev_count,
+			    bcm5301x_axi_read_counter(axi, event->hw.idx));
+		event->hw.state = 0;
+		/* Unpinned: the timer can migrate when the managing CPU goes offline. */
+		if (!axi->nr_active++)
+			hrtimer_start(&axi->timer, ATM_POLL_INTERVAL, HRTIMER_MODE_REL);
+	}
+	raw_spin_unlock_irqrestore(&axi->lock, irqflags);
+}
+
+static void bcm5301x_axi_stop(struct perf_event *event, int flags)
+{
+	struct bcm5301x_axi_pmu *axi = to_axi_pmu(event->pmu);
+	unsigned long irqflags;
+
+	raw_spin_lock_irqsave(&axi->lock, irqflags);
+	if (!(event->hw.state & PERF_HES_STOPPED)) {
+		bcm5301x_axi_update(axi, event);
+		event->hw.state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
+		axi->nr_active--;
+	}
+	/* The timer stops itself when no events are running. */
+	raw_spin_unlock_irqrestore(&axi->lock, irqflags);
+}
+
+static void bcm5301x_axi_read(struct perf_event *event)
+{
+	struct bcm5301x_axi_pmu *axi = to_axi_pmu(event->pmu);
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&axi->lock, flags);
+	if (!(event->hw.state & PERF_HES_STOPPED))
+		bcm5301x_axi_update(axi, event);
+	raw_spin_unlock_irqrestore(&axi->lock, flags);
+}
+
+static int bcm5301x_axi_add(struct perf_event *event, int flags)
+{
+	struct bcm5301x_axi_pmu *axi = to_axi_pmu(event->pmu);
+	unsigned int idx = event->attr.config;
+	unsigned long irqflags;
+
+	raw_spin_lock_irqsave(&axi->lock, irqflags);
+	if (axi->events[idx]) {
+		raw_spin_unlock_irqrestore(&axi->lock, irqflags);
+		return -EAGAIN;
+	}
+	axi->events[idx] = event;
+	event->hw.idx = idx;
+	event->hw.state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
+	raw_spin_unlock_irqrestore(&axi->lock, irqflags);
+
+	if (flags & PERF_EF_START)
+		bcm5301x_axi_start(event, PERF_EF_RELOAD);
+	perf_event_update_userpage(event);
+	return 0;
+}
+
+static void bcm5301x_axi_del(struct perf_event *event, int flags)
+{
+	struct bcm5301x_axi_pmu *axi = to_axi_pmu(event->pmu);
+	unsigned long irqflags;
+
+	bcm5301x_axi_stop(event, PERF_EF_UPDATE);
+	raw_spin_lock_irqsave(&axi->lock, irqflags);
+	axi->events[event->hw.idx] = NULL;
+	event->hw.idx = -1;
+	raw_spin_unlock_irqrestore(&axi->lock, irqflags);
+	perf_event_update_userpage(event);
+}
+
+static int bcm5301x_axi_offline(unsigned int cpu, struct hlist_node *node)
+{
+	struct bcm5301x_axi_pmu *axi = hlist_entry(node, typeof(*axi), hp_node);
+	unsigned int target;
+
+	if (cpu != READ_ONCE(axi->cpu))
+		return 0;
+	target = cpumask_any_but(cpu_online_mask, cpu);
+	if (target >= nr_cpu_ids)
+		return 0;
+	perf_pmu_migrate_context(&axi->pmu, cpu, target);
+	WRITE_ONCE(axi->cpu, target);
+	return 0;
+}
+
+static void bcm5301x_axi_hw_stop(struct bcm5301x_axi_pmu *axi)
+{
+	writel(ATM_STOP, axi->base + ATM_CMD);
+	/* Flush the posted command before the resource is unmapped. */
+	readl(axi->base + ATM_STATUS);
+}
+
+static int bcm5301x_axi_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct bcm5301x_axi_pmu *axi;
+	struct resource *res;
+	char *name;
+	u32 status;
+	int ret;
+
+	axi = devm_kzalloc(dev, sizeof(*axi), GFP_KERNEL);
+	if (!axi)
+		return -ENOMEM;
+	axi->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(axi->base))
+		return PTR_ERR(axi->base);
+	if (resource_size(res) < SZ_4K)
+		return -EINVAL;
+	name = devm_kasprintf(dev, GFP_KERNEL, "bcm5301x_axi_%llx",
+			      (unsigned long long)res->start);
+	if (!name)
+		return -ENOMEM;
+
+	raw_spin_lock_init(&axi->lock);
+	hrtimer_setup(&axi->timer, bcm5301x_axi_timer, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
+	axi->pmu = (struct pmu) {
+		.module = THIS_MODULE,
+		.parent = dev,
+		.task_ctx_nr = perf_invalid_context,
+		.capabilities = PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
+		.attr_groups = bcm5301x_axi_attr_groups,
+		.event_init = bcm5301x_axi_event_init,
+		.add = bcm5301x_axi_add,
+		.del = bcm5301x_axi_del,
+		.start = bcm5301x_axi_start,
+		.stop = bcm5301x_axi_stop,
+		.read = bcm5301x_axi_read,
+	};
+
+	/* Take exclusive local ownership; disable tracing, filtering and saturation. */
+	writel(ATM_CTRL_LOCAL, axi->base + ATM_CONFIG);
+	writel(ATM_STOP, axi->base + ATM_CMD);
+	ret = readl_poll_timeout(axi->base + ATM_STATUS, status,
+				!(status & ATM_STATE_MASK), 1, 1000);
+	if (ret)
+		return dev_err_probe(dev, ret, "Counters did not stop\n");
+	writel(ATM_CLEAR, axi->base + ATM_CMD);
+	writel(ATM_CTRL_LOCAL | ATM_COUNT_ENABLE, axi->base + ATM_CONFIG);
+	writel(ATM_START, axi->base + ATM_CMD);
+	ret = readl_poll_timeout(axi->base + ATM_STATUS, status,
+				(status & ATM_STATE_MASK) == ATM_STATE_ENABLE, 1, 1000);
+	if (ret) {
+		bcm5301x_axi_hw_stop(axi);
+		return dev_err_probe(dev, ret, "Counters did not start\n");
+	}
+	/*
+	 * Keep fixed counters free-running. Per-event baselines isolate sessions
+	 * without clearing or stopping counters used by another perf event.
+	 */
+	cpus_read_lock();
+	axi->cpu = cpumask_first(cpu_online_mask);
+	ret = perf_pmu_register(&axi->pmu, name, -1);
+	if (!ret) {
+		ret = cpuhp_state_add_instance_nocalls_cpuslocked(bcm5301x_axi_hp_state,
+							       &axi->hp_node);
+		if (ret)
+			perf_pmu_unregister(&axi->pmu);
+	}
+	cpus_read_unlock();
+	if (ret) {
+		hrtimer_cancel(&axi->timer);
+		bcm5301x_axi_hw_stop(axi);
+		return ret;
+	}
+	platform_set_drvdata(pdev, axi);
+	return 0;
+}
+
+static void bcm5301x_axi_remove(struct platform_device *pdev)
+{
+	struct bcm5301x_axi_pmu *axi = platform_get_drvdata(pdev);
+
+	cpuhp_state_remove_instance_nocalls(bcm5301x_axi_hp_state, &axi->hp_node);
+	perf_pmu_unregister(&axi->pmu);
+	hrtimer_cancel(&axi->timer);
+	bcm5301x_axi_hw_stop(axi);
+}
+
+static const struct of_device_id bcm5301x_axi_of_match[] = {
+	{ .compatible = "brcm,bcm5301x-axi-pmu" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, bcm5301x_axi_of_match);
+
+static struct platform_driver bcm5301x_axi_driver = {
+	.probe = bcm5301x_axi_probe,
+	.remove = bcm5301x_axi_remove,
+	.driver = {
+		.name = "bcm5301x-axi-pmu",
+		.of_match_table = bcm5301x_axi_of_match,
+		.suppress_bind_attrs = true,
+	},
+};
+
+static int __init bcm5301x_axi_init(void)
+{
+	int ret;
+
+	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN, "perf/bcm5301x_axi:online",
+				     NULL, bcm5301x_axi_offline);
+	if (ret < 0)
+		return ret;
+	bcm5301x_axi_hp_state = ret;
+	ret = platform_driver_register(&bcm5301x_axi_driver);
+	if (ret)
+		cpuhp_remove_multi_state(bcm5301x_axi_hp_state);
+	return ret;
+}
+module_init(bcm5301x_axi_init);
+
+static void __exit bcm5301x_axi_exit(void)
+{
+	platform_driver_unregister(&bcm5301x_axi_driver);
+	cpuhp_remove_multi_state(bcm5301x_axi_hp_state);
+}
+module_exit(bcm5301x_axi_exit);
+
+MODULE_DESCRIPTION("Broadcom BCM5301X AXI Trace Module PMU");
+MODULE_LICENSE("GPL");
-- 
2.53.0

