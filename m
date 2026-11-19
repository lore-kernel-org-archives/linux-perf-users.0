Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.54.77.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795110704;
	b=iglj1rXLrEuAEbwpfP4rL157mX23WUTvmI9WVgqpjJ66orXIv343KIaCmELVszpCCUnE
	 wp/5gloL/JGSkpeM+611Hw1dLUxi5AU/HnVtApc0xyGwbJKevnDoqBcPfxlD1zwSOho+s
	 ZsOFqc7M/7r282UD6ttDoyIo2Z0QO7t7E4r4mje51VucXhp2b5m+dtVgo6asJZe9fRVjU
	 y5+rruLNxFD4EROcSEEWalIuqk/e/GKQ4ofJUpt1RfQq1w6hJvdMlCYsnAySWcMV4rBI0
	 aZ+cn6POtQoiERF+V7poyhs7qNT2WP9bZ0Zsr9x2jibt5F4rk9vscyNtVJXv+eCrJSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795110704;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=CedYSSN4VmRSUUDOCoWWB86uIFN22b2CcBsb82DlUJU=;
	b=d+IPVAhdgTtIiVAh5GRNaOdjOn4c3mn7o35ezyAFL+CSOsI5EgQsQe+9rOWMA7PTeIKi
	 JwlajaWmZsbW80SpOKFIwvgankXnqHFDjO0TKWSYQgjARmbJvCbq2IOMunrh45D30HL3f
	 uxNTpTFNv/2T9Qdm7RfnODp63tOTqMpcRvvg0OuYk940DrybRum/OoTdkkfwNViY7bWqe
	 h1wVAvUdms2xw1mvmrDlIcDFX7Ii0Xf7ch8mt/90xpMNPb8o1M7tPB5QL/wLMb2dmkIls
	 2fcggwlUSKqy7e4MF8f7VBOF7OkA4V6yh4k0OgUJOJuQjEDAdbL3H9VvDZyoUZaD/pQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=207.54.77.171
Received: from esa4.hc555-34.eu.iphmx.com (esa4.hc555-34.eu.iphmx.com [207.54.77.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F3C60A2618;
	Thu, 19 Nov 2026 17:51:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85F3C60A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1795110712; x=1826646712;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=L7G8bdD9wp+VJx4bnBPXDO6O3hytAVV8cw1v6jTr0PA=;
  b=PbCu881Mh4+Otz2MznkISUvEzfLBfXti29wOhu7m69vL1NL8/KogC6Ui
   qtV+xdx+myUzJd4vhqt4gbduUMbNpM/h0Oz/fhUEEXKqEV9tZgn8MdIcs
   0sgB3KOAATecjP6LcGBisJ+9mkr9wa+kb43Yffw6RL3AE+IpuCAsNRsbS
   7IdHPdCKOTfzVq8/z9R/WcsjlXhfkbdJVHk12ddDc1WDVt10BBMGcQLNe
   Td9CrQ8BUxlvDRE3P2a7jvbq/f3De01RBlujvNK7Fxs1GrSYHXZdlUAGB
   QKWHDe9JVl6P990H9BYey23L8lRewH0xY9v4pURmD7OmeLI/qq3GEHd+w
   g==;
X-CSE-ConnectionGUID: BQEgh7P3RNS5g6MzTVOYDA==
X-CSE-MsgGUID: zyYqJ1ClTeyj2XiO/Q49CA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces04_data.me-crop.lan) ([146.255.191.134])
  by esa4.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 19:51:40 +0200
X-CSE-ConnectionGUID: zePeCnaBSnuCurSiN3xmsw==
X-CSE-MsgGUID: TgesIyceQZm3mT7ScHrYig==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.3])
  by ces04_data.me-crop.lan with SMTP; 19 Nov 2026 19:59:47 +0200
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Thu, 19 Nov 2026 19:51:31 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Date: Thu, 19 Nov 2026 19:51:27 +0200
Subject: [PATCH v3 1/7] mips: {cm,cpc}: Make cm_core_lock, cpc_core_lock
 raw spinlocks
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
Message-Id: <20261119-i6500-cm3-pmu-v3-1-c86410934b51@mobileye.com>
References: <20261119-i6500-cm3-pmu-v3-0-c86410934b51@mobileye.com>
In-Reply-To: <20261119-i6500-cm3-pmu-v3-0-c86410934b51@mobileye.com>
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
 linux-perf-users@vger.kernel.org, linux-hardening@vger.kernel.org, 
 Paul Burton <paulburton@kernel.org>
X-Mailer: b4 0.16.0

From: Paul Burton <paul.burton@mips.com>

cm_core_lock and cpc_core_lock are used to protect access to a CPU's
core-other/redirect CM and CPC register blocks. Since each CPU sees
its own copy of this block, we need to ensure that critical sections
holding a cm_core_lock run on one CPU - ie. we need to disable
preemption.

Use raw_spinlock_t to implement cm_core_lock and cpc_core_lock in
order to provide the guarantees we need on PREEMPT_RT systems.

Signed-off-by: Paul Burton <paul.burton@mips.com>
[added CPC part]
Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
---
 arch/mips/kernel/mips-cm.c  | 20 ++++++++++----------
 arch/mips/kernel/mips-cpc.c | 12 ++++++------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
index 7c9c5dc38823..3bfe85e86a9a 100644
--- a/arch/mips/kernel/mips-cm.c
+++ b/arch/mips/kernel/mips-cm.c
@@ -179,7 +179,7 @@ static char *cm3_causes[32] = {
 	"0x19", "0x1a", "0x1b", "0x1c", "0x1d", "0x1e", "0x1f"
 };
 
-static DEFINE_PER_CPU_ALIGNED(spinlock_t, cm_core_lock);
+static DEFINE_PER_CPU_ALIGNED(raw_spinlock_t, cm_core_lock);
 static DEFINE_PER_CPU_ALIGNED(unsigned long, cm_core_lock_flags);
 
 phys_addr_t __weak mips_cm_phys_base(void)
@@ -309,7 +309,7 @@ int mips_cm_probe(void)
 	mips_cm_is64 = IS_ENABLED(CONFIG_64BIT) && (mips_cm_revision() >= CM_REV_CM3);
 
 	for_each_possible_cpu(cpu)
-		spin_lock_init(&per_cpu(cm_core_lock, cpu));
+		raw_spin_lock_init(&per_cpu(cm_core_lock, cpu));
 
 	return 0;
 }
@@ -347,8 +347,8 @@ void mips_cm_lock_other(unsigned int cluster, unsigned int core,
 		 * mips_cm_lock_other() leading to a deadlock or a nice warning
 		 * with lockdep enabled.
 		 */
-		spin_lock_irqsave(this_cpu_ptr(&cm_core_lock),
-				  *this_cpu_ptr(&cm_core_lock_flags));
+		raw_spin_lock_irqsave(this_cpu_ptr(&cm_core_lock),
+				      *this_cpu_ptr(&cm_core_lock_flags));
 	} else {
 		WARN_ON(cluster != 0);
 		WARN_ON(block != CM_GCR_Cx_OTHER_BLOCK_LOCAL);
@@ -359,8 +359,8 @@ void mips_cm_lock_other(unsigned int cluster, unsigned int core,
 		 * race with us.
 		 */
 		curr_core = cpu_core(&current_cpu_data);
-		spin_lock_irqsave(&per_cpu(cm_core_lock, curr_core),
-				  per_cpu(cm_core_lock_flags, curr_core));
+		raw_spin_lock_irqsave(&per_cpu(cm_core_lock, curr_core),
+				      per_cpu(cm_core_lock_flags, curr_core));
 
 		val = FIELD_PREP(CM_GCR_Cx_OTHER_CORENUM, core);
 	}
@@ -380,11 +380,11 @@ void mips_cm_unlock_other(void)
 
 	if (mips_cm_revision() < CM_REV_CM3) {
 		curr_core = cpu_core(&current_cpu_data);
-		spin_unlock_irqrestore(&per_cpu(cm_core_lock, curr_core),
-				       per_cpu(cm_core_lock_flags, curr_core));
+		raw_spin_unlock_irqrestore(&per_cpu(cm_core_lock, curr_core),
+					   per_cpu(cm_core_lock_flags, curr_core));
 	} else {
-		spin_unlock_irqrestore(this_cpu_ptr(&cm_core_lock),
-				       *this_cpu_ptr(&cm_core_lock_flags));
+		raw_spin_unlock_irqrestore(this_cpu_ptr(&cm_core_lock),
+					   *this_cpu_ptr(&cm_core_lock_flags));
 	}
 
 	preempt_enable();
diff --git a/arch/mips/kernel/mips-cpc.c b/arch/mips/kernel/mips-cpc.c
index 3e386f7e1545..4b50c58628dc 100644
--- a/arch/mips/kernel/mips-cpc.c
+++ b/arch/mips/kernel/mips-cpc.c
@@ -15,7 +15,7 @@
 
 void __iomem *mips_cpc_base;
 
-static DEFINE_PER_CPU_ALIGNED(spinlock_t, cpc_core_lock);
+static DEFINE_PER_CPU_ALIGNED(raw_spinlock_t, cpc_core_lock);
 
 static DEFINE_PER_CPU_ALIGNED(unsigned long, cpc_core_lock_flags);
 
@@ -74,7 +74,7 @@ int mips_cpc_probe(void)
 	unsigned int cpu;
 
 	for_each_possible_cpu(cpu)
-		spin_lock_init(&per_cpu(cpc_core_lock, cpu));
+		raw_spin_lock_init(&per_cpu(cpc_core_lock, cpu));
 
 	addr = mips_cpc_phys_base();
 	if (!addr)
@@ -97,8 +97,8 @@ void mips_cpc_lock_other(unsigned int core)
 
 	preempt_disable();
 	curr_core = cpu_core(&current_cpu_data);
-	spin_lock_irqsave(&per_cpu(cpc_core_lock, curr_core),
-			  per_cpu(cpc_core_lock_flags, curr_core));
+	raw_spin_lock_irqsave(&per_cpu(cpc_core_lock, curr_core),
+			      per_cpu(cpc_core_lock_flags, curr_core));
 	write_cpc_cl_other(FIELD_PREP(CPC_Cx_OTHER_CORENUM, core));
 
 	/*
@@ -117,7 +117,7 @@ void mips_cpc_unlock_other(void)
 		return;
 
 	curr_core = cpu_core(&current_cpu_data);
-	spin_unlock_irqrestore(&per_cpu(cpc_core_lock, curr_core),
-			       per_cpu(cpc_core_lock_flags, curr_core));
+	raw_spin_unlock_irqrestore(&per_cpu(cpc_core_lock, curr_core),
+				   per_cpu(cpc_core_lock_flags, curr_core));
 	preempt_enable();
 }

-- 
2.43.0

