Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794510568;
	b=4cTrZ9gCqHaPbGECzh8oGBpvoUx5wQpY3ux67hB/kPsP37Ek+duqD89cWiklKSEEr6GC
	 zbTf1n4+AAwNGLqx4XLphuyKP4pRlDn7f4CFIRWbbNQDUkEY5XFAYxYPLZTm0d80EJpDD
	 QgPy0cBWV3WX3sBmZwU9yQ2PYB3oatKHBu0ixYS7SVQQZHHkSxOmbAojU5+L+jV1gHDst
	 QLxL5tM8ami1z6HM5w4cfkMpxu/+DikG4RpFkIXeNvr8ZITWmFloOiIK1NXbcM+QHKzan
	 I55SDvn7Rqk2bIirg5mTScqMHW1k/aR9t6aqK1YsSW/3UUvnRxDq5F2bt5fllNZcJmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794510568;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=MZNgkM904EAWrQX1/wn3079usEV+qyaStHRPZPAF7SI=;
	b=a4+8yeX80C4xGlOeKlfgiDOOK3JnmJrdeFPPSzNO4XRx7rhLJ1pu8ofSjt09erbwtimC
	 fnyEFeosEBrpF7dK8faGMJHrwtFZ0VaGy9+xPnKuY6KHLjLgLwV3EPwgBzufGx9h/T2qq
	 WQ+a+VptWXoEkOXikGaH8J9xrYM52lkMvAl1f+3fXsLyOdiuRLdcRlRz98FiUAIxXoaHi
	 r4do3cZoU2IpctZ77pbivqrUHAGjDV/DvPsI60n/S8IVpI8CyUx+Spx+S/7B39QdObPFV
	 FqkHmdL+eFPUceJpd5gIrUzymiHUKuhaLpYzu+bDS3CZ/LvKJbbJjLiLxS51CUx3AfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aFOHzwr+;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7435A606A886
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 19:09:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7435A606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aFOHzwr+
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3282db206d3so50839eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 11:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794510568; x=1795115368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MZNgkM904EAWrQX1/wn3079usEV+qyaStHRPZPAF7SI=;
        b=aFOHzwr+z8zfgGiL1j1rwCghO1Ql13ceA2/l19mnVX3+A4Z1VSMWWt+qtrXpIF9dVm
         xP9qqXjBHwJLedf8HGLSfuB/Arq9IhZCgyOBld5Tcef2QNShcFLC3V2uc/ZrEQ8k4Vp+
         EQ26nGWObftWoBoOYWBYTAI8XDKD7NkNvlIJ+S8rVSfHrfEPtAnw6awCBCZiwItIZu9p
         c0dBFRKOkMbFSmWOgqvAjBtWp+yXa3E553xB7a7rZGeeyTEpOkGieqQoJLM80V/d4mza
         TpEH5Ge3ToJQ355jUSj9/Oin+ERklDzkempk3wTPV0ZuXJ7KCDWwqRn/jOAf/FzS32Uq
         jQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794510568; x=1795115368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MZNgkM904EAWrQX1/wn3079usEV+qyaStHRPZPAF7SI=;
        b=iBv7ZCZU5CQHR0vzw33pZhZSXBkI37iU/KFua7nh8oWU+82Wd63a8lSUxgMoXm4tC1
         qdvT73NGScGvHlzKhPdu8U2qzg+7X0OK0XvU0H4yqcV6yKZZ43wOlPGuhxaj+poa5X1R
         VQhg+jfpPIghYbUVPqbk12u5/Vi5/WRu5p8bNPzHiPoOBaWkLyi3QVdfgGj549mlGhcJ
         hOjii3jAu4dXm0AvnsvNONu6ek1VH0TdI83TaiCnSyDnBpRufGFShSDWLyOKYGrLLND0
         9rIQMzvfTfW3JkHhMEe+loC2lSCsezpLjXzJrjBiODzEr+NK2BiHbY4/S0boxVHuIq7H
         PeMg==
X-Forwarded-Encrypted: i=1; AL+hErG9u+ZXNSDweLJQ6eOIIfQEJNyclXd/ibJbsS4CVWDUClE1rBtmFUx5TYJ3WUAa1kpkR+4qhEbdlc6Cm3/dgmc2@vger.kernel.org
X-Gm-Message-State: APuU4Z987P9zwc9szw+1RE7x7MGVyPUxYKWqaOBfjKzazwYfVXAbjoSo
	k+rI/+XJXevuC9BQFD0omOjRrDewfdJJYpA59SXogMsN8b/MvLJho7i5
X-Gm-Gg: AYBFou1rq2YUzgAG5sfNFyfm+ivWoNYsrPCMc9P+/eTLZ/pJhynsgjmblPsDwq0T8Ut
	n4EyoAolqeDbyRwI/0INZc5NrjdosfLmqAYUs//6xhcphQAuvW1UR2ZypUu/4ROrAHMIFen19ba
	NvYpw2piQconQLRNFi790u4Vr45IA30ZmcXa6eI8tqyN7SzxgwkLLwkh95cxQKSvcRo3Mk+iOG2
	Z4PSbT+6Xa9k3V72Rh8y1sKRiPkXqbLKB3pqQbxrjcepszob6HV+cjinIBnfW3jyIEJaWTMlQto
	o5R0DyZP844WMtiaN8mnWP3Xcp915AjXVy9jvT7VxU8oHZJH6AQ03K6WxBMtWEyCmUA5QSa0M9P
	Y1BhTnP2j4xyllLk0IC2MguVD83/r8akFJvi7vaxia5RKlZpcCYwVfLctveiyGhLp0zeI0A31oi
	t2U+LWhBFwSejJSTTAnGt4yfm0Yl15/Ecm5Zw/R8kPt9SB3FvqFbi66FaiM06F2G+75h5K+o6k7
	qnFJqiJ1L4vjxdJ2NQDuquiqG5b0BwVa+T9N6GuB31UcdxfKNMXyBBYXfi1MX49A4qa2L+UM2tM
	beBR+MaA
X-Received: by 2002:a05:7301:fd09:b0:36d:4570:a32d with SMTP id 5a478bee46e88-37963953f0amr89550eec.2.1794510567383;
        Thu, 12 Nov 2026 11:09:27 -0800 (PST)
Received: from eldorado ([2600:8802:b00:1f88::287])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37956bad6casm395674eec.26.2026.11.12.11.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 11:09:26 -0800 (PST)
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
Subject: [PATCH 1/3] MIPS: SiByte: Wire up the CPU interrupt controller
Date: Thu, 12 Nov 2026 11:09:14 -0800
Message-ID: <20261112190916.3725141-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112190916.3725141-1-f.fainelli@gmail.com>
References: <20261112190916.3725141-1-f.fainelli@gmail.com>
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

