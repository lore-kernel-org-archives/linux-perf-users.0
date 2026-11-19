Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795090156;
	b=5iyeh6BTP/Vt+AvrZCs4Sucv39s3gYlwRqiAZs84iKnpzSj+GgdOTua2dyioExjpdjSZ
	 7PHpLqoYsGO+W92po1iJiSLxszV7zVuuGW+9PYfECIUYQgpjxlMDL9CWYqTFjVXhasBkG
	 FKj0yV6Ysuiu+RScPNZ3niQD0qz+dkQ3aovu3FN2fLsRtECRfbn4rfWhcCXBBjVq3QYBs
	 sKFxaKLiOGaw47SwSy8cUXxBFuENSQv7SJ+EziN9kXWOi1fUUGFFxLHkqlXAVs3p4aKS3
	 AJ6p6YdD6NDVdr+X23K20IWdYlyHZPTLm+EltvCUgQwzoETOcYmjtZNTudkwHM2YHpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795090156;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=mjAOFIHRgj5VQM5DbT2bRqvGLu+RPIR/UnCkxZlsmdM=;
	b=RTO8Rk7WCsxW4cy9jeF9vsmdMgqVO3DfrpyXfnQD9ZtOzSJaJ23+2nV105+ZWoHcR1BJ
	 UItJ2NbNo8soWnlQhh9AKanyNcivuO/KEWDg/6WzmNOd8UY9xYF1ADnW4HlZOdScC4UmM
	 3oJt9xG6VCUoZIr9VI8/VNhEs0uihIDRkJoaI8zipmvJEknzA5G7I/sua/YWPhDd6PBby
	 DnDdSTZx8p4tWUqJUDmvbQV6fV3qAyd9ByVEarxJnAAuzEDUbaz/+S2xR0bKpPzfgxpHf
	 r8vngnD/2+ROG1lnUI1oBLDyO/Ckv6MAdsOjhd5rR+nANK1uXPssNx5H1rlEgPiG7qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Wsc0CibS;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4BB606A324
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 12:09:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B4BB606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Wsc0CibS
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36f8cdd30beso3084613eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 04:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1795090156; x=1795694956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mjAOFIHRgj5VQM5DbT2bRqvGLu+RPIR/UnCkxZlsmdM=;
        b=Wsc0CibSiluv3TklidkIpLjA5OkLdkf5ccIblDgjcq/CaX5RZ+B14ssAG07js2VCiW
         ebpRVBaQTfldMIPBitJc2jMTrFz+Cpdedts8XJunkArh1S9fi7pAcm153zFpJuPDBPbM
         PF92hOrdm9ibfTM+FKKWoZUdxrMzRmnT8WeKZmH2FbImaZC7WR6CarzthNn0eP32faEO
         F63yeNW7UpVRexxlzL40Zho82Q5pHvR3QP/T2h8apz0O1N5A4S9B1P/HjkY8WdhLGdPQ
         f9/+d9YL8uOMHnGLtVVbSZhwYpiN5AAFOs+EQ+qJzqIB8wmsNWuR+qdrxWu1gyJEW7+i
         gj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795090156; x=1795694956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mjAOFIHRgj5VQM5DbT2bRqvGLu+RPIR/UnCkxZlsmdM=;
        b=gtn+HJiN4CT67H5JRPYmhaHhqrxunUib0Zi7fu4oMX5MEocdHtm7vAi/QSxf0aGnq2
         k4xzfprbObWeSllOj/pfqjep8THkn+51EOhqWsqxXb+GPiArUw5ok+dIqhxVm8PZv6wf
         yuJpB8Bh5eAWi0EpVgK19+30PKN0QpoCo9rqGzyC/sE42H87DShzuk+38QRueQfPYpds
         CurJ4nEfSsl0HJX3otcQIU8CoGHhZVriVcCrwOiuQlviHjkvP7lraKf3XTbsudVif3tk
         NnMvJARl7YPE2C8yZTljgRGd/f/2AUoH18n8m6XHsNZtn//awwZ8Q+QyJYhJSOLYA8GL
         74IA==
X-Forwarded-Encrypted: i=1; AL+hErEKp8/ZKo7ilm+dNGvqFvoY6XiS/5RRvLR9D6uDEjw0mYdGoXSL+nIfPwSRTqz7fyc/CxzSZVbMVqNYDdxHninM@vger.kernel.org
X-Gm-Message-State: APuU4Z9oitdVFZEHmUsW9dyLNT2TpP192neBCbmTdNtQ3U3i3b7xgCxp
	zoSSvguC9zSn9N1igmJx4tC+jxnzxZFwHs81vqDuWBhK6q4eGC4v2q33YzqZzWvzNCE=
X-Gm-Gg: AZFdTZckOjDKi7C5Et/M0M74Lju5bal+ZLFuAE+qAC1sdh+N20P5IsQL3mHFxxuQoMD
	8skmG41g1p0F/cGCDjVlgFHMhW1tTN6viOSgC5fflUhDLzRob3y9ZwHFI+EkVgc0OSCiFATmYWs
	CXfk/dzmOSio06hUH7gqwasjjhJeA+qBLv9YdeOCRJTwcm1RUzCj1jTuv9aYMEGhAB6hkWr5Kuo
	aZ4B3wTKS8fRc/UUB0FTaxEYLq126MRmE5T9VfK4wzdDFslSu1hvzmedoViTGbJKLStXKdk4cUV
	Sv5p7JIgVRxq/+kGyAjD37DuEMHO560/ui+dNkz88j7ZiSw+b8uYvx76533Gxz6n2L1Zb0z7qQA
	30YaKpMDn4kiK0Lx/jCg2gvtwZ3u/34gHs5aAUCdOU+VlDKHG7/1anaQtvI3oJMObkXvnsjHVkN
	8Diqs8Uaj45r5Rbfhhz5ud0hpNWRLw06fmjW7XKS+8wZi0vDG5HIrW/rpSrhiGYWmGACnjwlKB/
	5aKl7CzlbCYEUNE21rCbj/gTIM5OFBiHij0nALXIHAp5e65uGRLU9xAoyeiFQWPcNbbAPjCp3lg
	bjd4jZjWag1LKr4xcBnqD73hylZlzAMcwQT0s8mqmVCfpKyF+TCyG0ZwjbDA2WzcCJqvMAki9+Y
	CY6lsH3s=
X-Received: by 2002:a05:7300:ce85:b0:381:a037:b060 with SMTP id 5a478bee46e88-3828026978bmr5371913eec.9.1795090155546;
        Thu, 19 Nov 2026 04:09:15 -0800 (PST)
Received: from FJ7FR2JRQ3.bytedance.net ([186.240.245.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a7bc05cfsm17604650eec.26.2026.11.19.04.09.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Nov 2026 04:09:15 -0800 (PST)
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	himanshu.chauhan@oss.qualcomm.com,
	conor@kernel.org,
	anup.patel@oss.qualcomm.com
Cc: clement.leger@linux.dev,
	cuiyunhui@bytedance.com,
	atish.patra@linux.dev,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	will@kernel.org,
	tglx@kernel.org,
	corbet@lwn.net,
	rdunlap@infradead.org,
	shuah@kernel.org,
	yuanzhu@bytedance.com,
	yang.susheng@zte.com.cn,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhangzhanpeng.jasper@bytedance.com
Subject: [PATCH v13 03/11] riscv: sse: mask events during shutdown and kexec
Date: Thu, 19 Nov 2026 20:08:27 +0800
Message-ID: <20261119120824.13969-16-zhangzhanpeng.jasper@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261119120824.13969-13-zhangzhanpeng.jasper@bytedance.com>
References: <20261119120824.13969-13-zhangzhanpeng.jasper@bytedance.com>
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

SSE delivery is independent of normal S-mode interrupts. Firmware may also
retain an event registration until Linux explicitly unregisters it. A hart
must therefore stop accepting SSE events before Linux stops servicing the
registered handler.

Mask SSE on the local hart before panic stop, CPU stop, restart, poweroff,
and crash shutdown paths. This prevents firmware from entering Linux-owned
handler state after the corresponding CPU or kernel context is no longer
valid.

A crash kernel cannot identify or take ownership of registrations
inherited from the crashed kernel. Reject a later normal kexec while such
SSE state may still exist, rather than transferring unknown firmware state
to another kernel.

The restriction is deliberately based on firmware SSE availability, not
CONFIG_RISCV_SBI_SSE or registrations made by the crash kernel. Disabling
SSE in the crash kernel does not establish that registrations left by the
crashed kernel are absent. Consequently, normal kexec from a crash kernel
is also rejected when firmware advertises SSE but no registrations were
actually left behind. This conservative restriction remains until a safe
way to establish or clear inherited firmware state is available.

Link: https://lore.kernel.org/r/as7-3PbWDxygadnJ@hu-himchau-blr.qualcomm.com/
Reviewed-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
---
 arch/riscv/kernel/machine_kexec.c | 11 +++++++++++
 arch/riscv/kernel/reset.c         | 18 ++++++++++++++++++
 arch/riscv/kernel/smp.c           | 17 +++++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
index 738df176ff6f..24e7affae70b 100644
--- a/arch/riscv/kernel/machine_kexec.c
+++ b/arch/riscv/kernel/machine_kexec.c
@@ -14,10 +14,13 @@
 #include <asm/set_memory.h>	/* For set_memory_x() */
 #include <linux/compiler.h>	/* For unreachable() */
 #include <linux/cpu.h>		/* For cpu_down() */
+#include <linux/crash_dump.h>
 #include <linux/reboot.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 
+#include <asm/sse.h>
+
 /*
  * machine_kexec_prepare - Initialize kexec
  *
@@ -36,6 +39,13 @@ machine_kexec_prepare(struct kimage *image)
 	unsigned int control_code_buffer_sz = 0;
 	int i = 0;
 
+	/* A crash kernel cannot tear down registrations inherited from firmware. */
+	if (is_kdump_kernel() && image->type != KEXEC_TYPE_CRASH &&
+	    riscv_sse_available()) {
+		pr_err("Normal kexec from a crash kernel is unsupported with SSE\n");
+		return -EOPNOTSUPP;
+	}
+
 	/* Find the Flattened Device Tree and save its physical address */
 	for (i = 0; i < image->nr_segments; i++) {
 		if (image->segment[i].memsz <= sizeof(fdt))
@@ -127,6 +137,7 @@ void
 machine_crash_shutdown(struct pt_regs *regs)
 {
 	local_irq_disable();
+	riscv_sse_mask_current_hart();
 
 	/* shutdown non-crashing cpus */
 	crash_smp_send_stop();
diff --git a/arch/riscv/kernel/reset.c b/arch/riscv/kernel/reset.c
index 14eb08a6db85..fdab37e7ae52 100644
--- a/arch/riscv/kernel/reset.c
+++ b/arch/riscv/kernel/reset.c
@@ -6,6 +6,20 @@
 #include <linux/efi.h>
 #include <linux/reboot.h>
 #include <linux/pm.h>
+#include <linux/smp.h>
+
+#include <asm/sse.h>
+
+#ifndef CONFIG_SMP
+void __noreturn panic_smp_self_stop(void)
+{
+	riscv_sse_mask_current_hart();
+	local_irq_disable();
+
+	for (;;)
+		cpu_relax();
+}
+#endif
 
 static void __noreturn default_power_off(void)
 {
@@ -18,6 +32,8 @@ EXPORT_SYMBOL(pm_power_off);
 
 void machine_restart(char *cmd)
 {
+	riscv_sse_mask_current_hart();
+
 	/*
 	 * UpdateCapsule() depends on the system being reset via ResetSystem().
 	 */
@@ -30,12 +46,14 @@ void machine_restart(char *cmd)
 
 void machine_halt(void)
 {
+	riscv_sse_mask_current_hart();
 	do_kernel_power_off();
 	default_power_off();
 }
 
 void machine_power_off(void)
 {
+	riscv_sse_mask_current_hart();
 	do_kernel_power_off();
 	default_power_off();
 }
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 07027cfeba4b..5b05243e1deb 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -22,10 +22,13 @@
 #include <linux/irq.h>
 #include <linux/irq_work.h>
 #include <linux/nmi.h>
+#include <linux/panic.h>
 
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
 #include <asm/cpu_ops.h>
+#include <asm/sbi.h>
+#include <asm/sse.h>
 
 static const char * const ipi_names[] = {
 	[IPI_RESCHEDULE]	= "Rescheduling interrupts",
@@ -66,8 +69,18 @@ int riscv_hartid_to_cpuid(unsigned long hartid)
 	return -ENOENT;
 }
 
+void __noreturn panic_smp_self_stop(void)
+{
+	riscv_sse_mask_current_hart();
+	local_irq_disable();
+
+	for (;;)
+		cpu_relax();
+}
+
 static void ipi_stop(void)
 {
+	riscv_sse_mask_current_hart();
 	set_cpu_online(smp_processor_id(), false);
 	while (1)
 		wait_for_interrupt();
@@ -78,6 +91,7 @@ static atomic_t waiting_for_crash_ipi = ATOMIC_INIT(0);
 
 static inline void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
 {
+	riscv_sse_mask_current_hart();
 	crash_save_cpu(regs, cpu);
 
 	atomic_dec(&waiting_for_crash_ipi);
@@ -241,6 +255,8 @@ void smp_send_stop(void)
 {
 	unsigned long timeout;
 
+	riscv_sse_mask_current_hart();
+
 	if (num_online_cpus() > 1) {
 		cpumask_t mask;
 
@@ -288,6 +304,7 @@ void crash_smp_send_stop(void)
 		return;
 
 	cpus_stopped = 1;
+	riscv_sse_mask_current_hart();
 
 	/*
 	 * If this cpu is the only one alive at this point in time, online or
-- 
2.50.1 (Apple Git-155)

