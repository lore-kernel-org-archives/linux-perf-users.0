Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.90.104.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794486563;
	b=M5m8h+CoLhkNuaudt2fLUW0WBI/H7XYtjXMykGqwgBfCGHoUtGdc/MEb0rbdSiOoMwI9
	 g5m3lvRb7eczFRkM1wIEXlw9yrTL8aCchOlYVGKjTXfEFuCYZsYiORWwDKWbmnMaVb+nw
	 eIur28FHb3OkleqXZK9aow/r96JtZZTbEwcydVl6dnoxBBleYM9Cnzovgui1ODckyji0r
	 gPduOqYoJ57/Vz0jb3uxlacKhFIhSL5qp73TjkfwxGUClQuqpWuS6LKWonxSYU86h0pIC
	 AdJk5tyuD72T7oGFlCzJSrhzsrC49+1HW9qBXN0IwaTdr18mDrnIhw36FKDbbo5iLNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794486563;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=JUownZ9i4fagdIA01DIWXWA9WN5+CaB8lCEugi8eWWg=;
	b=quO8Bt9p9ANUcFewhVMmxIxrkSN6+g7nXOdQ2Sa6wI53jwgL3uCVWkXFwrB/GOdFQXuS
	 RoParN9shmpqCA53E8JZVsfmc61hQ8kv+KljFyMJ63GchWrrRquMbheG5J9R8n63ZDO8u
	 2DO6lLXec4vAAcFkh+CjPlPh6j/o5bA1+O1C440hswXLTf4ga+T+MpY7YuL6qUnnZ5Ul/
	 r5BYLkWgLelsrqlHlmBi7U2m99wgxxx7KksZmC5kMlDRAZmPfbG3To3xP0X75wqlC5Y04
	 xXtOoV/yG3lFvD3nqm5Fwx8ojUQiPbfZv2fwbj6SEJLaUZo79GypB3MujpljnciKEXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=23.90.104.144
Received: from esa1.hc555-34.eu.iphmx.com (esa1.hc555-34.eu.iphmx.com [23.90.104.144])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC31606A31C;
	Thu, 12 Nov 2026 12:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EC31606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1794486563; x=1826022563;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=T3xhb/1ELvNoo66BKk4ECC6rQdLhk2tH2mSUSvFvCsE=;
  b=Q7AUoQPVer3xv6RZqcmJgRQE3gK9+PpdP/b6f/XY6Tc44Vw55W0PGmw+
   tWSeYRYxPaX8kDz/5AGrZ8CVXXTXFqFEInheU4vxCMUrO5/ed5xONfYDo
   44a/Mnyw+S7B56p0NECfGmVcf2oD9A8TCCSRlz2N1a/VcjGs0FCr07fco
   hRyUWHgnELHD6n6lOo8Wyd3MP5y0pWbupgWLaRXVwMe/25KENFIB4SiHE
   HH1lBuE6vzrX6nh6keY4b0sgzF1JD8IvQKoA697BaGZA6r4zO/i3FRbox
   HfLfFGimKYEIMgG0EKq0DU94S/BltaYp4YwlH8IcQmGCgCZAsTrQaWMCO
   w==;
X-CSE-ConnectionGUID: Jly7lB5MTe+QEe3/IDSYWg==
X-CSE-MsgGUID: ycBjS/VmS3aAFjlSZ0Ta4Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces02_data.me-corp.lan) ([146.255.191.134])
  by esa1.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 14:29:20 +0200
X-CSE-ConnectionGUID: UNVFG+yMSkuWtO+xpASqGQ==
X-CSE-MsgGUID: nhdtPckwRuiNLLpkqcVBmQ==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.2])
  by ces02_data.me-corp.lan with SMTP; 12 Nov 2026 14:37:27 +0200
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Thu, 12 Nov 2026 14:29:19 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Date: Thu, 12 Nov 2026 14:29:00 +0200
Subject: [PATCH v2 3/6] MIPS: CM: export the symbols needed to access the
 GCRs from a module
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-i6500-cm3-pmu-v2-3-cd2569571819@mobileye.com>
References: <20261112-i6500-cm3-pmu-v2-0-cd2569571819@mobileye.com>
In-Reply-To: <20261112-i6500-cm3-pmu-v2-0-cd2569571819@mobileye.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Fu Chao-Ying <chao-ying.fu@globalfoundries.com>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, devicetree@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, linux-hardening@vger.kernel.org
X-Mailer: b4 0.16.0

Allow modules to use the GCR and CPC accessors from asm/mips-cm.h and
asm/mips-cpc.h:

- mips_gcr_base and mips_cpc_base are the mapped register blocks;
- the CPS_ACCESSOR macros consult mips_cm_is64 on every 64-bit register
  access;
- mips_cm_lock_other() / mips_cm_unlock_other() are the only way to
  reach the registers of another cluster through the redirect block.

This is a prerequisite for building the CM3 PMU driver as a module.

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
---
 arch/mips/kernel/mips-cm.c  | 5 +++++
 arch/mips/kernel/mips-cpc.c | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
index 3bfe85e86a9a..ed98021418b5 100644
--- a/arch/mips/kernel/mips-cm.c
+++ b/arch/mips/kernel/mips-cm.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/errno.h>
+#include <linux/export.h>
 #include <linux/of.h>
 #include <linux/percpu.h>
 #include <linux/spinlock.h>
@@ -14,8 +15,10 @@
 #include <asm/mipsregs.h>
 
 void __iomem *mips_gcr_base;
+EXPORT_SYMBOL_GPL(mips_gcr_base);
 void __iomem *mips_cm_l2sync_base;
 int mips_cm_is64;
+EXPORT_SYMBOL_GPL(mips_cm_is64);
 bool mips_cm_is_l2_hci_broken;
 
 static char *cm2_tr[8] = {
@@ -373,6 +376,7 @@ void mips_cm_lock_other(unsigned int cluster, unsigned int core,
 	 */
 	mb();
 }
+EXPORT_SYMBOL_GPL(mips_cm_lock_other);
 
 void mips_cm_unlock_other(void)
 {
@@ -389,6 +393,7 @@ void mips_cm_unlock_other(void)
 
 	preempt_enable();
 }
+EXPORT_SYMBOL_GPL(mips_cm_unlock_other);
 
 void mips_cm_error_report(void)
 {
diff --git a/arch/mips/kernel/mips-cpc.c b/arch/mips/kernel/mips-cpc.c
index 3e386f7e1545..4a8bd56bc2e8 100644
--- a/arch/mips/kernel/mips-cpc.c
+++ b/arch/mips/kernel/mips-cpc.c
@@ -6,6 +6,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/errno.h>
+#include <linux/export.h>
 #include <linux/percpu.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -14,6 +15,7 @@
 #include <asm/mips-cps.h>
 
 void __iomem *mips_cpc_base;
+EXPORT_SYMBOL_GPL(mips_cpc_base);
 
 static DEFINE_PER_CPU_ALIGNED(spinlock_t, cpc_core_lock);
 

-- 
2.43.0

