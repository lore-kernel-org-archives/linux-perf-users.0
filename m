Received: from mail-lf1-f73.google.com (mail-lf1-f73.google.com [209.85.167.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8862A24B221
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jan 2025 18:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736534943; cv=none; b=Il93I1WzroHfwn6fXWNukN4Z6gxENt9uywnoYDPSn48ZKiM5MZev/Jx/daKme4s8ck02RDDGeFsET7bOXyGsOYhLzldsy8SExrHkaxcoPNKXoswygT/fGrruJ9OnF/3FfN1ekivcFehhWah9ZbKgPrL38XGaejPv72Kcn/uUN+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736534943; c=relaxed/simple;
	bh=gGBo/k79fltK/LiW8yEcfC3C6FkuDBayaBiJeug/v8c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UF/DVPIA0YL31rKS5HONd6pIIkr5KHjlcnJN4JPPS6356ue9ZAgSvltuDPYu6XT27BjEpLqo2uKUV6JvVt6EcxWtL27cQN9s5knz8DnbMkJtQUcpZrUjLrU8SMffOONz/Xv+uXAN0wNBKed5yecWDX13kxEDiEcSJymbNmGHE0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NcGegh+n; arc=none smtp.client-ip=209.85.167.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NcGegh+n"
Received: by mail-lf1-f73.google.com with SMTP id 2adb3069b0e04-5400e88b7a4so1812375e87.3
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Jan 2025 10:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736534940; x=1737139740; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=49F9KmkByYRspQkaSYzsGBFq+GnQYA+RnfOGnAD1TNs=;
        b=NcGegh+nxW/XBA8Eogkzs2o4xWMfVK8mDthr1vIHkKn2i8Tb2XbZxWnjD/w99k0a6Z
         cTGPo1trpAtrKoRTY2gF9I/zV9Yl/IUM9tMPCqVKif+ZD9tDgxcO5ainUhOG9Num6W3l
         7S1Cu87IwpqFkU2E3wMudcXtHZB4vl2wdAdNRyUvouFsBx6wp4IIvo9h7qvirhzjGOFy
         MAGwhHGWcc6iNaGsoyXexwJdM2CawW/eIcs5AZn2AqRYEWw7jfxgf9n4GczjDZqX439v
         8eqxzwxjUVe4t7UPedYLHWpxsf6mqSunoT74mfqeUMkJ1jYKGMsPNbZH4fKG8lPtw3Fz
         HLeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736534940; x=1737139740;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=49F9KmkByYRspQkaSYzsGBFq+GnQYA+RnfOGnAD1TNs=;
        b=Xg1j+7H8gJhXY+khNlBVBjLUieXdSGIA//b7p/hLwknKTCcR83tJYrEqCCCV1XAezt
         l58zoA+XZQaAKTiIkQHs9zW6PaivVPs8aVNs+q4166npNDnzoC5IvIW04Z9o5Cp9RkUM
         8G5AJnu0EiMiWaqBKUc7Y+srtYsyGeCkfjHet2BFxblZKwPxFVu3Phs0JTOPzVWXKw9t
         qJvYgbQVulFDMjKxQ3XImz7g/nPL1gk/X8AFHqT5yGvxTdAA6DSEeDZMQ4zaAOzeFoJi
         qki4tU9plLhnZwhReZpQ9x9oVq6MLTbj2OCUk0BjFxRv+bemVYIvQZYon7KSrLYyLD/N
         21Qg==
X-Forwarded-Encrypted: i=1; AJvYcCXwgknShkvRtb0pY6biKnXKrD1vtP03AZYTNPaxFJdlPVBGcV8kf9lSOfYLt2Eiqu6EWgW9jvcliNvCeOeuV1jH@vger.kernel.org
X-Gm-Message-State: AOJu0YzJYnss/3kPTFr2zA9R47LX4tsB/F5us+fRHnf67WKSPnNN4C66
	B6gFTvKNdqyPHD6x19qqnHEMnHvfO0RuGYRwtcyeEw814s4hedH/dVRk28Qnms18yyfNgdCwTAh
	/VF+/yYPAsA==
X-Google-Smtp-Source: AGHT+IFKWz0raFavEVPdqLi0m3c/SgK/uJNRKjAz6M2EuA2Ei6coxzOA0we1XFhGSIskVPMsumh+r4On/rf0kg==
X-Received: from wmrn35.prod.google.com ([2002:a05:600c:5023:b0:434:f2eb:aa72])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d07:b0:434:fa73:a907 with SMTP id 5b1f17b1804b1-436e269a5f5mr112362055e9.13.1736534508901;
 Fri, 10 Jan 2025 10:41:48 -0800 (PST)
Date: Fri, 10 Jan 2025 18:40:54 +0000
In-Reply-To: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250110-asi-rfc-v2-v2-28-8419288bc805@google.com>
Subject: [PATCH RFC v2 28/29] x86/pti: Disable PTI when ASI is on
From: Brendan Jackman <jackmanb@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Chris Zankel <chris@zankel.net>, 
	Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mike Rapoport <rppt@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	kvm@vger.kernel.org, linux-efi@vger.kernel.org, 
	Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

Now that ASI has support for sandboxing userspace, although userspace
now has much more mapped than it would under KPTI, in theory none of
that data is important to protect.

Note that one particular impact of this is it makes locally defeating
KASLR easier. I don't think this is a great loss given [1] etc.

Why do we pass in an argument instead of just having
pti_check_boottime_disable() check boot_cpu_has(X86_FEATURE_ASI)? Just
for clarity: I wanted it to be at least _sort of_ visible that it would
break if you reordered asi_check_boottime_disable() afterwards.

[1]:  https://gruss.cc/files/prefetch.pdf
      and https://dl.acm.org/doi/pdf/10.1145/3623652.3623669

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/include/asm/pti.h |  6 ++++--
 arch/x86/mm/init.c         |  2 +-
 arch/x86/mm/pti.c          | 14 +++++++++++++-
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/pti.h b/arch/x86/include/asm/pti.h
index ab167c96b9ab474b33d778453db0bb550f42b0ac..79b9ba927db9b76ac3cc72cdda6f8b5fc413d352 100644
--- a/arch/x86/include/asm/pti.h
+++ b/arch/x86/include/asm/pti.h
@@ -3,12 +3,14 @@
 #define _ASM_X86_PTI_H
 #ifndef __ASSEMBLY__
 
+#include <linux/types.h>
+
 #ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 extern void pti_init(void);
-extern void pti_check_boottime_disable(void);
+extern void pti_check_boottime_disable(bool asi_enabled);
 extern void pti_finalize(void);
 #else
-static inline void pti_check_boottime_disable(void) { }
+static inline void pti_check_boottime_disable(bool asi_enabled) { }
 #endif
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index ded3a47f2a9c1f554824d4ad19f3b48bce271274..4ccf6d60705652805342abefc5e71cd00c563207 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -754,8 +754,8 @@ void __init init_mem_mapping(void)
 {
 	unsigned long end;
 
-	pti_check_boottime_disable();
 	asi_check_boottime_disable();
+	pti_check_boottime_disable(boot_cpu_has(X86_FEATURE_ASI));
 	probe_page_size_mask();
 	setup_pcid();
 
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 851ec8f1363a8b389ea4579cc68bf3300a4df27c..b7132080d3c9b6962a0252383190335e171bafa6 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -76,7 +76,7 @@ static enum pti_mode {
 	PTI_FORCE_ON
 } pti_mode;
 
-void __init pti_check_boottime_disable(void)
+void __init pti_check_boottime_disable(bool asi_enabled)
 {
 	if (hypervisor_is_type(X86_HYPER_XEN_PV)) {
 		pti_mode = PTI_FORCE_OFF;
@@ -91,6 +91,18 @@ void __init pti_check_boottime_disable(void)
 		return;
 	}
 
+	if (asi_enabled) {
+		/*
+		 * Having both ASI and PTI enabled is not a totally ridiculous
+		 * thing to do; if you want ASI but you are not confident in the
+		 * sensitivity annotations then it provides useful
+		 * defence-in-depth. But, the implementation doesn't support it.
+		 */
+		if (pti_mode != PTI_FORCE_OFF)
+			pti_print_if_insecure("disabled by ASI");
+		return;
+	}
+
 	if (pti_mode == PTI_FORCE_ON)
 		pti_print_if_secure("force enabled on command line.");
 

-- 
2.47.1.613.gc27f4b7a9f-goog

