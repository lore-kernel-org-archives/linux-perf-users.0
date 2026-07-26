Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D43B385D9B
	for <linux-perf-users@vger.kernel.org>; Sun, 26 Jul 2026 12:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785068614; cv=none; b=qSuVN6KdDfZ8IxMNl6N2A8eg55N8nVUxsxg8uDjjmPZUVG5C8Cp0HvpeojIO1kZo+HrjSV8AD2h44797/vTk9qVnWZp7MlPVEjpW4yxqR+6/r6LaAHqfByw+WDJKIOLZhBcjKyiZhe0pexn+kwah08r9uXe/pY8XngVgA0XrYOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785068614; c=relaxed/simple;
	bh=ccoLxXcVCAekN8O5gMgLDn7JdMt0YqOZNIb3h7ismYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mne0Z1EE9z4UuK5dYZ0VzXIURIJNktP3UHa2JCnYNGD4fC+LkZAU4geDQNP1EhOKbK2mqvHQl7gADwEbNkUciTpmTE++eKtPuEWZ8gyIkLmAZg9TVW9ZD3n0zIy7ewHgZmgOV9SbnXGgigpWqP2NnxFhGCCCm0sgvBfuiSHKjKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7ruABK1; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7ruABK1"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7ee4399c3abso1405129a34.2
        for <linux-perf-users@vger.kernel.org>; Sun, 26 Jul 2026 05:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785068612; x=1785673412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0oVEf5/gSaD+al9Pequ5m2rnhtlrO+HvKfH1QE9WEkQ=;
        b=f7ruABK1b9LOdLMLX0hoUbdnicYBAG40by648S0h3Hw6n65j2AtAsT5gvosd66eOgc
         HUbPfC498tJGg4NKwggeU0T1EK1632mv5rhSCb51w6eX6hUj5BAg1POhbwpwTlt3KO4T
         C+ZKFAx06jrRgi7SOI/RdpTO+253hTAEWSPJjpK6FYtinl5fUM/UOOwu4W5VcfH9HzG6
         W8AZSOq+vmvvAtBKNBeO///i/v+iOaT4aisXjgP1iy/vXYxK25mYJhUn2lMTm6vZDS+d
         ciNLVJMpXPGKh0NdhHc1BATFKEZ06wv7S0SER1aCi2p8gILw8mgiI9n5JSBKoDu1c5c4
         rLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785068612; x=1785673412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0oVEf5/gSaD+al9Pequ5m2rnhtlrO+HvKfH1QE9WEkQ=;
        b=Kd3fdWQlkpBtwdobIO0kWkvVgNOga7yk2WUf2nwtMNIxtRklx91+s11Zxm9tOm7/od
         0mOP8btETVvM2aAAEyLxX9WIOUIwrVgoeQAN9NH1fUdv1+U9NvpFxLXgwrPBbThkoBSD
         QzwXradLGVK61Xu8d3a+lOKzO10zJRTm5VYCY67+sPO8N+WFV9ODdxCydNCnnZ6ylO07
         nONyiRGRvM9L4fSW27i6VJpPfciFsw1L+o11KcJB8nk8HoIjVzMsegZ0RCfTn0RwnCln
         AqVOIloOKquq835ANOCSyFgItbaI4xrKSTeTxET33/DGQHwMP7hmgc+jd3V1uA6g/qje
         O2Bw==
X-Forwarded-Encrypted: i=1; AHgh+RpaP+EdPFrxmV5R3BVNEIoq+1x+E/vawTeKqNMXXaQ6MBqECNr7N2DD4ImQOYrluG+DettsZt9ivX7AuJ+n/h45@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2m+IwCxV35jO8yJuHm2pPoWERy3rn8tQzKZ6QuFAMQhfFKrAY
	abfqMeqp8Ka+l6np/F1DIjkr26OmguhbG/Y9lhx7pF7uwC83TQw3FxykngyR+M8vefU=
X-Gm-Gg: AR+sD11/dH6WwBdjbbs0Uu9EJUB0BvIqRUFlUcPrzElyf5C13P9sIAHY/4FFejxzXd6
	ETWUNvX9dkmc1nlemxJ7i5vqpQAo+LqeAC40rm8D8U1ic8gjTzQNuMAdNEvUg/H0VhimouXWFzc
	DVr/GaR5h72L2f14I6CZl+DI3iXkF+SaD6jHiNs8SEsQl1nMpf/GAG6w83E7wiwGzeozkIrpvuv
	k+chAXdDDLs3R/iU17Tp3Gt0BRrzaxxlQIPw5nJFXwigBrU1HSXDTeHOHW4HW0+CEBuqFQEq7l8
	yL2/vNaeJy4PQ3JVa8Vwep7nD3jDU3R34ncRtLL4FPKGaDlci2Ocs3tzSgZT9XX5VY7LDfBO2b7
	BSny1l70xCtjakFid/lrT0you7wO5P3WhcTTjl8aeSBc5XO3eG19n62e8sINER+9ekL5CcFFACS
	ET+w==
X-Received: by 2002:a05:6830:2692:b0:7e9:e808:e9c1 with SMTP id 46e09a7af769-7ee78c42561mr4564556a34.8.1785068611885;
        Sun, 26 Jul 2026 05:23:31 -0700 (PDT)
Received: from localhost ([144.24.58.22])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ee29db0d23sm9853507a34.1.2026.07.26.05.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 05:23:31 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	x86@kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-edac@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH 3/3] HWBP: Add modify_local_hw_breakpoint_addr() API
Date: Sun, 26 Jul 2026 20:22:32 +0800
Message-ID: <f9c49dfa49bdc57ba8c0574bc9981c1e581acf92.1785067572.git.wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1785067572.git.wangjinchao600@gmail.com>
References: <178476143000.26117.9810509272687580410.stgit@devnote2> <cover.1785067572.git.wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

Add modify_local_hw_breakpoint_addr() to update only the watched
address of an installed hardware breakpoint on the local CPU without
releasing and reserving its hardware slot. This is available when the
architecture selects CONFIG_HAVE_MODIFY_LOCAL_HW_BREAKPOINT_ADDR.

The caller must provide an installed local event and a valid address,
and update other CPUs separately.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 arch/Kconfig                  |  8 ++++++++
 arch/x86/Kconfig              |  1 +
 include/linux/hw_breakpoint.h |  6 ++++++
 kernel/events/hw_breakpoint.c | 30 ++++++++++++++++++++++++++++++
 4 files changed, 45 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index fa7507ac8e13..bea383408e32 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -457,6 +457,14 @@ config HAVE_MIXED_BREAKPOINTS_REGS
 	  Select this option if your arch implements breakpoints under the
 	  latter fashion.
 
+config HAVE_MODIFY_LOCAL_HW_BREAKPOINT_ADDR
+	bool
+	depends on HAVE_HW_BREAKPOINT
+	help
+	  Select this if the architecture can modify the address of an
+	  installed hardware breakpoint on the local CPU without releasing
+	  and reserving its hardware slot.
+
 config HAVE_USER_RETURN_NOTIFIER
 	bool
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index bdad90f210e4..09e599f2d0dd 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -246,6 +246,7 @@ config X86
 	select HAVE_FUNCTION_TRACER
 	select HAVE_GCC_PLUGINS
 	select HAVE_HW_BREAKPOINT
+	select HAVE_MODIFY_LOCAL_HW_BREAKPOINT_ADDR
 	select HAVE_IOREMAP_PROT
 	select HAVE_IRQ_EXIT_ON_IRQ_STACK	if X86_64
 	select HAVE_IRQ_TIME_ACCOUNTING
diff --git a/include/linux/hw_breakpoint.h b/include/linux/hw_breakpoint.h
index db199d653dd1..bf65c7fffd99 100644
--- a/include/linux/hw_breakpoint.h
+++ b/include/linux/hw_breakpoint.h
@@ -81,6 +81,9 @@ register_wide_hw_breakpoint(struct perf_event_attr *attr,
 			    perf_overflow_handler_t triggered,
 			    void *context);
 
+int modify_local_hw_breakpoint_addr(struct perf_event *bp,
+				    unsigned long addr);
+
 extern int register_perf_hw_breakpoint(struct perf_event *bp);
 extern void unregister_hw_breakpoint(struct perf_event *bp);
 extern void unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events);
@@ -124,6 +127,9 @@ register_wide_hw_breakpoint(struct perf_event_attr *attr,
 			    perf_overflow_handler_t triggered,
 			    void *context)		{ return NULL; }
 static inline int
+modify_local_hw_breakpoint_addr(struct perf_event *bp,
+				unsigned long addr) { return -EOPNOTSUPP; }
+static inline int
 register_perf_hw_breakpoint(struct perf_event *bp)	{ return -ENOSYS; }
 static inline void unregister_hw_breakpoint(struct perf_event *bp)	{ }
 static inline void
diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 789add0c185a..0b1fc01f1934 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -888,6 +888,36 @@ void unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events)
 }
 EXPORT_SYMBOL_GPL(unregister_wide_hw_breakpoint);
 
+/**
+ * modify_local_hw_breakpoint_addr - update a local breakpoint address
+ * @bp: the hwbp perf event for this CPU
+ * @addr: the new address for @bp
+ *
+ * Update only the address of an installed breakpoint on the local CPU without
+ * releasing and reserving its hardware slot. The caller must update other CPUs.
+ * Return 0, or -EOPNOTSUPP if the architecture does not support this operation.
+ */
+#ifdef CONFIG_HAVE_MODIFY_LOCAL_HW_BREAKPOINT_ADDR
+int modify_local_hw_breakpoint_addr(struct perf_event *bp,
+				    unsigned long addr)
+{
+	lockdep_assert_irqs_disabled();
+
+	counter_arch_bp(bp)->address = addr;
+	bp->attr.bp_addr = addr;
+	arch_modify_local_hw_breakpoint_addr(bp, addr);
+
+	return 0;
+}
+#else
+int modify_local_hw_breakpoint_addr(struct perf_event *bp,
+				    unsigned long addr)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+EXPORT_SYMBOL_GPL(modify_local_hw_breakpoint_addr);
+
 /**
  * hw_breakpoint_is_used - check if breakpoints are currently used
  *
-- 
2.53.0

