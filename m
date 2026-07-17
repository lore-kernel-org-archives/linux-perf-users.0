Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25ADF3FBEBC
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 13:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784293415; cv=none; b=iRgKMf64O6w2evtHU3v8cUiDN6KutmZnhLO2wC4VjmXBuyt+6lbQHTUDc5cpUkDazNG1Ph0lLVFI3OxBNNk+CFqDqdlDVoped3YQ+YaL/Q8ecr9llTGjkwOsmEl+C7OPqKrfniChYxIf5a1frxTsr6yP9xc/urNV1QjtoN3HVcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784293415; c=relaxed/simple;
	bh=BE0O/mKap0ViHNplNVUpYAszwuhBBa7mfDYWdw1MMxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vDz1HpMGO/jrV35eOG8dgRrfdmdbTZmuhGMuiIyzboGYhoG+cxlfwKqp3+teKNumQ34nnjnRYWsanS+1+M+2QnHszOJ241v+6dVu6LzzLHeMs/gcH/ZhLHsyHdsFUvJpW3w7jOl2D2l0ZwNvkfKAFZ8VZ8T4F5LZKnQJDYgyTIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VcjSTiw4; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcjSTiw4"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-383adaa461fso3191806a91.3
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 06:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784293413; x=1784898213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=usfqleQl6zep7nG+d2WvhlRN371v3Tz2fhzwYC0DlME=;
        b=VcjSTiw45OYWBy2CgheicZB67Fu4KqTB4zgTPyE8gGyA/pnOoAUbF/V7MA9QSLwh68
         trA4/OEbiCCi6Wu6XzXbLPHeRkW3otkukuKh3juosybOnzkg42Y2GnNJvAYtiYe6MHtD
         gnbly7PvGLhLIHKGJLEFGvEDF8fFKmom7l890cs3bbFxvxLZcj0qacoGQjLI7ORJ/HPT
         L99oPKBDAj25wGnV7piRDTYZceYSiLAoZ1nS8nZjOBjIjkHQH0ZSWQJzobZ9D5ATfnuj
         4c0adUd08fKG5BakDyT0Pnn4mlii6zv5AaTtOT18OCmXXFN51lHqbj+bl4sSP8axq517
         Eu0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784293413; x=1784898213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=usfqleQl6zep7nG+d2WvhlRN371v3Tz2fhzwYC0DlME=;
        b=OgtuqsjLmasNx/4dKi2psmeY2n/q8cs3jW7VZYsfF57bdOW6tVp9+PZvY9aQMimjTP
         UvFnFXDr9Mz5z/raFT67dbpMcj9DOWf4noDSorPVjPWdHHr3heZhnGBl5DHlQdgPzpuT
         RwJMv7Ytq/S4xfMDyf/CeloTgrqt2N9qXr+yIuHOjnxF0XczgRFhLwoFplffLjMGAtTA
         xSCrsA5nXShxP4oBWvSmAzZeV9F7DbjYwVepoOFYznectkBrxjxZ2otU/8p4pP98ZBgc
         cUSkTrjAX+d4/iKNZQ4SkiiblXNL8PaJ+MlkOZJg2WQCVe72SzTTj1FmBtA0xjfDDWkC
         adEw==
X-Forwarded-Encrypted: i=1; AHgh+RqSJl8HZ8rm8wFXGuWpAmvaGNydyYI0LgIkeYl146SzevOAOZDU3R/oqjFpdN+SprWhSp5bQg04+7QIagR7d2b8@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi2vQfMysukLw56Y+Xjx5GFUKEHw5Ln8sfvvgvOftZtlqqMR62
	HK/OWREoemVip3s20CE4FyYfayuP/bA5h4aH5s2mkPnptmUJhjEUD78e
X-Gm-Gg: AfdE7cn+KFyRVElnoONmMV9Wws3k924B3TzzknjTdquOD9Mu7Ag+1AtWge6lcWoKPFg
	n26QFPrU9612I4rDPb5lvvaJv9p8zlJD3SNrYDkPaTxMg0JeIipiJWi5ChqYb1lAW6DXAu1LHPg
	8nlKVRyz+ne6wWdntjCT47Xbcaw5K9wENqhT0h4+X/WvbMnRXxCylWHcxy0z4mxulXrap6sPsnT
	zw3EmEP8kZ2r28yAfEEA41B7ySYa+7jPtyW+YpcJHLHMpThG28noSmupW5y8DUCv+abQLKi6TDk
	fpl8Yp+IPiLvuyjx0SaVBAh8tXVwu2LQQbA2sM+v83hUB5bONBZk9jWdsEsFPaEKzUg8typ6+0s
	Qa4mmP2bjYXTFoswOOCbVY7qiHbchoA658fEIKRO1epGknN4ypARdncVMY5dX1lM24QjLWbgYtY
	CqWQ==
X-Received: by 2002:a17:90a:ec88:b0:38d:adae:4866 with SMTP id 98e67ed59e1d1-38e4b516544mr2632403a91.21.1784293413065;
        Fri, 17 Jul 2026 06:03:33 -0700 (PDT)
Received: from localhost ([144.24.58.22])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1dde81sm13705289eec.21.2026.07.17.06.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 06:03:31 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Matthew Wilcox <willy@infradead.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Randy Dunlap <rdunlap@infradead.org>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [RFC PATCH v2 03/13] x86/hw_breakpoint: Add arch_reinstall_hw_breakpoint
Date: Fri, 17 Jul 2026 09:03:15 -0400
Message-ID: <20260717130315.1901903-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260717125023.1895892-1-wangjinchao600@gmail.com>
References: <20260717125023.1895892-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new arch_reinstall_hw_breakpoint() function can be used in an
atomic context, unlike the more expensive free and re-allocation path.
This allows callers to efficiently re-establish an existing breakpoint,
and x86 advertises the capability via HAVE_REINSTALL_HW_BREAKPOINT.

Since a REINSTALL may change bp_len, setup_hwbp() must clear the
slot's stale len/type and enable bits in DR7 before re-encoding:
OR-merging the new encoding over the old one would keep the CPU
watching with the stale width (verified in QEMU by reading DR7 after
re-arming watch_len=1 over a len8 breakpoint: 0x999906aa merged
without the clearing, 0x199906aa with it).

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 arch/x86/Kconfig                     |  1 +
 arch/x86/include/asm/hw_breakpoint.h |  2 ++
 arch/x86/kernel/hw_breakpoint.c      | 16 ++++++++++++++--
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index bdad90f210e4..5be698db0241 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -246,6 +246,7 @@ config X86
 	select HAVE_FUNCTION_TRACER
 	select HAVE_GCC_PLUGINS
 	select HAVE_HW_BREAKPOINT
+	select HAVE_REINSTALL_HW_BREAKPOINT
 	select HAVE_IOREMAP_PROT
 	select HAVE_IRQ_EXIT_ON_IRQ_STACK	if X86_64
 	select HAVE_IRQ_TIME_ACCOUNTING
diff --git a/arch/x86/include/asm/hw_breakpoint.h b/arch/x86/include/asm/hw_breakpoint.h
index aa6adac6c3a2..c22cc4e87fc5 100644
--- a/arch/x86/include/asm/hw_breakpoint.h
+++ b/arch/x86/include/asm/hw_breakpoint.h
@@ -21,6 +21,7 @@ struct arch_hw_breakpoint {
 
 enum bp_slot_action {
 	BP_SLOT_ACTION_INSTALL,
+	BP_SLOT_ACTION_REINSTALL,
 	BP_SLOT_ACTION_UNINSTALL,
 };
 
@@ -65,6 +66,7 @@ extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 
 
 int arch_install_hw_breakpoint(struct perf_event *bp);
+int arch_reinstall_hw_breakpoint(struct perf_event *bp);
 void arch_uninstall_hw_breakpoint(struct perf_event *bp);
 void hw_breakpoint_pmu_read(struct perf_event *bp);
 void hw_breakpoint_pmu_unthrottle(struct perf_event *bp);
diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index 76886467708b..e2dbd43d8e39 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -100,6 +100,10 @@ static int manage_bp_slot(struct perf_event *bp, enum bp_slot_action action)
 		old_bp = NULL;
 		new_bp = bp;
 		break;
+	case BP_SLOT_ACTION_REINSTALL:
+		old_bp = bp;
+		new_bp = bp;
+		break;
 	case BP_SLOT_ACTION_UNINSTALL:
 		old_bp = bp;
 		new_bp = NULL;
@@ -134,10 +138,13 @@ static void setup_hwbp(struct arch_hw_breakpoint *info, int slot, bool enable)
 	__this_cpu_write(cpu_debugreg[slot], info->address);
 
 	dr7 = this_cpu_read(cpu_dr7);
+	/*
+	 * Clear the slot's stale len/type and enable bits first: a REINSTALL
+	 * with a different bp_len would otherwise OR-merge both encodings.
+	 */
+	dr7 &= ~__encode_dr7(slot, 0xf, 0);
 	if (enable)
 		dr7 |= encode_dr7(slot, info->len, info->type);
-	else
-		dr7 &= ~__encode_dr7(slot, info->len, info->type);
 
 	/*
 	 * Enabling:
@@ -198,6 +205,11 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
 	return arch_manage_bp(bp, BP_SLOT_ACTION_INSTALL);
 }
 
+int arch_reinstall_hw_breakpoint(struct perf_event *bp)
+{
+	return arch_manage_bp(bp, BP_SLOT_ACTION_REINSTALL);
+}
+
 void arch_uninstall_hw_breakpoint(struct perf_event *bp)
 {
 	arch_manage_bp(bp, BP_SLOT_ACTION_UNINSTALL);
-- 
2.53.0

