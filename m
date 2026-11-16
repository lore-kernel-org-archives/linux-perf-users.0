Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794850730;
	b=5ZSgmI3PFq9zWHZ0BpNLHoWL4cZdkfy1GzPyks+BlT3InxXsTCotQcmypTgEqPFqnFY/
	 YnGAgGLOnAhYFzg/7h8WpbbfsOJWhPDT2V/IfxKmV6s1h+c+M2UmKCkQCcMkN8mKYn6No
	 8404nRQTh7tDX8NdfoLx3dudBi7G4jPLra6TB8vya9+o7+vwVJlbMK7CIVYCG0Yr+ewUd
	 rchDCV/5Dlr3YoxN/yduUPdGOMoOwpOWxwlSwF1VlY+mvl9isVi7UgK09uaW3LuAxNHST
	 gY4avVTzuMLMuebBXE4gqgmlcx/Gyjq6K0sUUQxm/XrBg4GPKa9g9QcOX1rAT+Y1Rdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794850730;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=MZNgkM904EAWrQX1/wn3079usEV+qyaStHRPZPAF7SI=;
	b=LsK0WwHhOEczd9Kb94m9SHK5byuwtULqnuedFfXo1s8p6R3K/YIOziLv9ZbzahXvlZW1
	 p0rWPPN0iduP92oUW1+lu3S9/xFTRKkVTVA/slrvbD6ZgjmwWBvvQEdwSMxHV9bEQxwuo
	 +ntvyyINSjQZhV4qkYo60ZSqJM2i1zJHaCbEXbCM4QNVA5mHfdH9sNtF1pnu6hlICK8eY
	 ANZhi7Z8zxQ56Bvq0BfJv9+NklsPm04roPuf2QIxic7orGB4xIr7uE3waFWQlVckR+H6z
	 MO+9WR22BZLNmcvv9Y+diilxr5ke+JAV2eI2rlq+kZNAWB7KKUGvJvvKfJQqKMjsB8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="f9r/fPlJ";
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A170606A336
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 17:38:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A170606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f9r/fPlJ
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-37071c0f42aso5507642eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 09:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794850730; x=1795455530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MZNgkM904EAWrQX1/wn3079usEV+qyaStHRPZPAF7SI=;
        b=f9r/fPlJ0OXy9CtCkhTP0ik7tjtwmI87EQwZl4TNmVa+aeA7IcmhljDNs7aoQMU79s
         BKPfSe9N0JHYKQtno0mFLb4Ts+eYKArmVc8JtkUVDxzOntIkyA0j873VAU2xDm52QfAr
         Seoz2s3kKLbNWXMzhn8oLpWqVbpdDvSL0nmYgZ6QCs+rs6zPUG5NcaZW2ELi181b1DgR
         6297ZZZi1fq0FyxKiLeZzN/IziC0mTsCEYBlNdD+Xxuk4pfXPETvSV/drHWMtxaxPuYs
         4rQaC+rZAOiRcFpsXKtRJwFPBYfrlmXVJIKFnTKt+5jXwnuDEvT83Jnkt0tUEMOKj2ak
         Coaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794850730; x=1795455530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MZNgkM904EAWrQX1/wn3079usEV+qyaStHRPZPAF7SI=;
        b=wOiOc04wYcmP+yL6xRvaXa3/+b1Gir5+4blCi5u5st2RafYgKevTZm+HkeRmC0yASt
         QRJpaPtHw+eM1dY+JoevZUNC8Y0yt/IAYf4ifi8RurKYkDjB6Ap4DxcL9swMGSTTwQDQ
         RQqoQhVWRzFcA+ZQ/gXeDrOL3uafekjl8Dc6MWvUhe0aqYadkxwPajFp50RfNPsqjca8
         /ujSGJHZjqwj9wXc83w2HwOA6xMemcii0o47IJ2FX3xkLOvhqStx7AaGtCyw0Eo3UnY/
         reOTAQrTr0O++6BMIjfKkTnq7htynz/0/6tTiFwnRp/yokeulCvp4mVudJBBb5g/1k4P
         yRcQ==
X-Forwarded-Encrypted: i=1; AL+hErEiWK2Z7pxB4+zihQltR8QjN+Deh2YUetb+jvMpamFcoRqGfRRqgyck2jB1Jqu3ZMtZDbaBDc9bppvZHgDeKCsv@vger.kernel.org
X-Gm-Message-State: APuU4Z/xUwjWcuPUKGbbE2ZXl3VB4przdaYubZ+z6wVwWgmAHXry5gND
	eD+tKUd7rxmZgbLKBRdCXJZhhz3f2FxLSZt1+0CCK8noqhHkrwKcuNnm
X-Gm-Gg: AZFdTZcl3stKXRBNroOQobzMurgLLF6/FMG92Wa7ZEh8TGqA4xC4b9Vll/MQ5AkUxHn
	KjpTO8WRtEMLw+UO0b6mtkI9t2QjaFX9uRS7tO+qaywn7M0oFbhNppHJIj4Z3uduffL/CP31n02
	/Td5lF2JqexUWs+ut47VNrjRRFELMYFyGVz+M1Lq8FWQ3p63rZmT+GKgRtI6tzS8JCsF3+XAuqe
	F9rfb6n7CyOABJTYI4TTYd1Jf5PDL9AjHmrSRXBGZYtEqDfN3w3qh1sICChrTMHEwmQUQH8MTgy
	/bBzqUk7MYxQ42pU89iwiWuXz799clfkXauQgQsrsMfRMa8Y7Pj+uZLwY+pK47lq+RDl/Y8+Yh1
	HivIkKgGHCdwnh+e8b9+LOyDeAn6goRN6kzB+MJtuJlwi/y4rBvXwSJaps6HHuq7bO15NpgdEfW
	wanVd/DnXV/wgP7+o2oAExWIuTG41Ly6pZV8y8Hy/XEJEX1C9xG1AeIuDYnHIVGVRD7LogbR1HE
	kxPq/LEnf8bJ0+CYELDFzeZsO6RRLEUnR9EqfM1SMvO5gK17YmnKGv5rbQHPKr6x22dpA8tXOIy
	PVNtoSjH
X-Received: by 2002:a05:7300:fd12:b0:369:a162:af96 with SMTP id 5a478bee46e88-379673164cbmr17174143eec.17.1794850729510;
        Mon, 16 Nov 2026 09:38:49 -0800 (PST)
Received: from eldorado ([2600:8802:b00:1f88::287])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955e0d966sm36635215eec.15.2026.11.16.09.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 09:38:48 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-mips@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
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
	Thomas Gleixner <tglx@kernel.org>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list),
	linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM),
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: [PATCH v3 1/3] MIPS: SiByte: Wire up the CPU interrupt controller
Date: Mon, 16 Nov 2026 09:38:36 -0800
Message-ID: <20261116173843.911523-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116173843.911523-1-f.fainelli@gmail.com>
References: <20261116173843.911523-1-f.fainelli@gmail.com>
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

Initialize the MIPS CPU interrupt controller on SB1250 and BCM1480 so
CPU-local interrupts have a configured irq_chip and handler. Reserve IRQs
128 through 135 above both interrupt mapper ranges, and dispatch BCM1480
IP7 through the CPU controller as SB1250 already does.

This provides the CPU-local IP7 interrupt needed by the SB1 performance
counters without overlapping the SiByte interrupt mapper IRQ numbers.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/include/asm/mach-sibyte/irq.h | 10 ++++++++++
 arch/mips/sibyte/bcm1480/irq.c          |  7 ++++++-
 arch/mips/sibyte/sb1250/irq.c           |  3 +++
 3 files changed, 19 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/include/asm/mach-sibyte/irq.h

diff --git a/arch/mips/include/asm/mach-sibyte/irq.h b/arch/mips/include/asm/mach-sibyte/irq.h
new file mode 100644
index 000000000000..b7073830d2ec
--- /dev/null
+++ b/arch/mips/include/asm/mach-sibyte/irq.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __ASM_MACH_SIBYTE_IRQ_H
+#define __ASM_MACH_SIBYTE_IRQ_H
+
+/* Keep CPU-local interrupts above both SiByte interrupt mapper ranges. */
+#define MIPS_CPU_IRQ_BASE	128
+
+#include <asm/mach-generic/irq.h>
+
+#endif
diff --git a/arch/mips/sibyte/bcm1480/irq.c b/arch/mips/sibyte/bcm1480/irq.c
index 4c18a2c755d2..5eff85a8659b 100644
--- a/arch/mips/sibyte/bcm1480/irq.c
+++ b/arch/mips/sibyte/bcm1480/irq.c
@@ -15,6 +15,7 @@
 #include <asm/irq_regs.h>
 #include <asm/signal.h>
 #include <asm/io.h>
+#include <asm/irq_cpu.h>
 
 #include <asm/sibyte/bcm1480_regs.h>
 #include <asm/sibyte/bcm1480_int.h>
@@ -242,6 +243,8 @@ void __init arch_init_irq(void)
 	unsigned int imask = STATUSF_IP4 | STATUSF_IP3 | STATUSF_IP2 |
 		STATUSF_IP1 | STATUSF_IP0;
 
+	mips_cpu_irq_init();
+
 	/* Default everything to IP2 */
 	/* Start with _high registers which has no bit 0 interrupt source */
 	for (i = 1; i < BCM1480_NR_IRQS_HALF; i++) {	/* was I0 */
@@ -337,7 +340,9 @@ asmlinkage void plat_irq_dispatch(void)
 
 	pending = read_c0_cause() & read_c0_status();
 
-	if (pending & CAUSEF_IP4)
+	if (pending & CAUSEF_IP7)
+		do_IRQ(MIPS_CPU_IRQ_BASE + 7);
+	else if (pending & CAUSEF_IP4)
 		do_IRQ(K_BCM1480_INT_TIMER_0 + cpu);
 #ifdef CONFIG_SMP
 	else if (pending & CAUSEF_IP3)
diff --git a/arch/mips/sibyte/sb1250/irq.c b/arch/mips/sibyte/sb1250/irq.c
index 57943fe3ac03..2df115269f81 100644
--- a/arch/mips/sibyte/sb1250/irq.c
+++ b/arch/mips/sibyte/sb1250/irq.c
@@ -15,6 +15,7 @@
 #include <asm/signal.h>
 #include <asm/time.h>
 #include <asm/io.h>
+#include <asm/irq_cpu.h>
 
 #include <asm/sibyte/sb1250_regs.h>
 #include <asm/sibyte/sb1250_int.h>
@@ -225,6 +226,8 @@ void __init arch_init_irq(void)
 	unsigned int imask = STATUSF_IP4 | STATUSF_IP3 | STATUSF_IP2 |
 		STATUSF_IP1 | STATUSF_IP0;
 
+	mips_cpu_irq_init();
+
 	/* Default everything to IP2 */
 	for (i = 0; i < SB1250_NR_IRQS; i++) {	/* was I0 */
 		__raw_writeq(IMR_IP2_VAL,
-- 
2.53.0

