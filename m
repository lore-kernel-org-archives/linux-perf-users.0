Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7292330C14C
	for <linux-perf-users@vger.kernel.org>; Sun, 26 Jul 2026 12:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785068599; cv=none; b=p5mWH4YUAgc5ZTYtcoRBq4VRnaU2CjpaF8dCm6j02WbpKQ2nfdlaxtqGXPe3u1R4utbXZTYTIG0iNUAuWKCe8S8CTVL6GJkbHgVnntbCzVgfR3rOfNLpq4osCeajIWXgWcxXioCX0PT+GESZsNhM6ChN9UcqTkpC+25Z5pDpauU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785068599; c=relaxed/simple;
	bh=9TRu9Q4LwBRql71odhvuw1OhgUcZ5BnFekHOedMS968=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P2Nlq9nmsRCzHUja+yRMRUt8B14/HV8464o+P8rpEM4CzEpfIIYiazbLfgtQviWXxEOXjXv3QaE+Mf7mZ9OPbBU2e5lPmyO1mZv5lYNuTH0tQplito9K8zWU7OpoeIrZ7lIvbsJI2esms8rw+nYuocF+YbejmjAH9kNoeuwsGJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUUlswz7; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUUlswz7"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7ee37dc91f5so996242a34.3
        for <linux-perf-users@vger.kernel.org>; Sun, 26 Jul 2026 05:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785068597; x=1785673397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uVtWee8zloihupxojDwrCEq5aoRBKaK6smjn2VfvwR4=;
        b=HUUlswz7It/qUg9RMzY3/dsC87Hq++LN4erbo3UcENowdxckqGLJHhX1nB6BQkl9da
         gLHScj1wRZHAYu7uYnrA2nUV6/wOPSHZQPfCv6PKLMir4mEKXhU9ePJEIZ1cqESICz41
         eefzNdPRMu2+joii2pXpDRSe4SemT+5YG67FWXVwCF0ojmH8O5f4rVo2x2R3xXfLqgqM
         QyhxBuAhmfhRJtv8y9Pi/QN+vY4qFczn+iUC51h47OXk4hsSMbOL4zt3rmkWRW/HtqBr
         f5qJsimx4+zIo7+YK4ZzyQ/fIrSTcrGq4LwCFLL7dxQDRuaI7dPdLbQy8qq7vUUrSwMR
         g1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785068597; x=1785673397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uVtWee8zloihupxojDwrCEq5aoRBKaK6smjn2VfvwR4=;
        b=DFRpiobFu8tcPppCD5GykXjFhOf9G9o2nNehfQ1uPqGtFepuqZxJ2TVNP3WVXWyVKP
         xov36zFLWnnGOVHWMkR0y2r8GTQQasmVK0frbdNLAq3LvK+qnYVws6uref1KvmXNYH/f
         uutCtaGO7wFA2AF4D/+VVkf3rSoCd/TxRTTE2xlNYVbw/2+zA5Fuijp0KBBFw1g/kzf4
         dTmGtCHta3MO9SM3SHpvSYIjLSriieTT1RyA0ky5miVsw9ZfIKd92Vy9EJ4Sgzt5/FO2
         IocLCf1Hp2mJcaSJy4KMhXjR418rMrVOOmiNuPVE/eqMMYf/6uzVvKRBdwEMoXmdhlGM
         cICQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq9Fo+KINJKYvPanb2mZ9yBFPZBs4bwf9ezqtKQ7rgIBiZjWiNyaRc6SjUT18fOw9omJnwUnp3/d2Ymi3hXb9SV@vger.kernel.org
X-Gm-Message-State: AOJu0YyfMMuwhno/zcrd771BILtZ/mykf2VaIcTu5Qncj0PW+azFdl74
	6ZncM8vBAB6c8rOCME5AU++CiSPJ6B08Cp4y8H8vnRiSCO8JiJn7LzZr
X-Gm-Gg: AR+sD13ICqUM2HaVY0oW+nmFosQ1umcRnwuEgZIRa2ALt8UBZwThrRGGVgpbGoMG6mN
	PsNP9f0VyI+HERkubLCGm8lxhpLwMUGb5PJrTb342LnUGJLGDHjkt234ydE+BtEi3iIU9x3N51M
	nTpyCpH/hl5JQsc4SbteDW11Uvsl7aoWQG68CEkAyLNETdLLQ3TiyijqpBj8ZLFS7mAhJzvo5uo
	Ikq/7KjN6ut6e12VruhHa3d7+dHE0RhddwRIW7VbKJVgs2phn/2OKQSosJxJbVqVLnWEWXtU6NZ
	htMOiWY5lVOgyVfXujzFCH0ky/SOpjwHQH0yYeJqNwP+sCFB8wudZVKATmQvQlW7N+lPNpovcDM
	lFnSef+VJ8t/+dH/4bWisoETw4+rLK+LSZ0CJxNf0RPMps+RrhZ/W207fBNGeJLeQZ5EFKsXe4O
	JFSnWTzMBYE45O
X-Received: by 2002:a05:6820:1a05:b0:6a3:1dc5:356e with SMTP id 006d021491bc7-6aaffa6232fmr3807138eaf.36.1785068597387;
        Sun, 26 Jul 2026 05:23:17 -0700 (PDT)
Received: from localhost ([144.24.58.22])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-457673d267dsm13112356fac.11.2026.07.26.05.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 05:23:17 -0700 (PDT)
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
Subject: [PATCH 2/3] x86/hw_breakpoints: Add arch_modify_local_hw_breakpoint_addr() API
Date: Sun, 26 Jul 2026 20:22:31 +0800
Message-ID: <59637b96946653393a7ad3c7de094094796b39c2.1785067572.git.wangjinchao600@gmail.com>
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

Wprobe needs to move an active per-CPU watchpoint without releasing and
reserving its hardware slot.

Add arch_modify_local_hw_breakpoint_addr() to find the installed local
slot and update only its address shadow and hardware debug address
register. Publish the shadow first so hw_breakpoint_restore() observes
the new address if an NMI interrupts the update.

The caller must provide an installed local event and a valid address.
Slot ownership, breakpoint type, length, mask and DR7 remain unchanged.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 arch/x86/include/asm/hw_breakpoint.h |  2 ++
 arch/x86/kernel/hw_breakpoint.c      | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/x86/include/asm/hw_breakpoint.h b/arch/x86/include/asm/hw_breakpoint.h
index 0bc931cd0698..a1ecce536074 100644
--- a/arch/x86/include/asm/hw_breakpoint.h
+++ b/arch/x86/include/asm/hw_breakpoint.h
@@ -59,6 +59,8 @@ extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 
 
 int arch_install_hw_breakpoint(struct perf_event *bp);
+void arch_modify_local_hw_breakpoint_addr(struct perf_event *bp,
+					  unsigned long addr);
 void arch_uninstall_hw_breakpoint(struct perf_event *bp);
 void hw_breakpoint_pmu_read(struct perf_event *bp);
 void hw_breakpoint_pmu_unthrottle(struct perf_event *bp);
diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index 9ef24b55737f..ff1b9b78f78c 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -128,6 +128,26 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
 	return 0;
 }
 
+void arch_modify_local_hw_breakpoint_addr(struct perf_event *bp,
+					  unsigned long addr)
+{
+	int i;
+
+	lockdep_assert_irqs_disabled();
+
+	for (i = 0; i < HBP_NUM; i++) {
+		if (this_cpu_read(bp_per_reg[i]) == bp)
+			break;
+	}
+
+	if (WARN_ONCE(i == HBP_NUM, "Can't find any breakpoint slot"))
+		return;
+
+	this_cpu_write(cpu_debugreg[i], addr);
+	barrier();
+	set_debugreg(addr, i);
+}
+
 /*
  * Uninstall the breakpoint contained in the given counter.
  *
-- 
2.53.0

