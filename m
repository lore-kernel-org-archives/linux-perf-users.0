Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084A74334DD;
	Wed, 22 Jul 2026 23:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784761379; cv=none; b=WqBjg2NzaRH+QwNrAsbxVExHO/Ei+B+R7NmemATeFipTo24ml2JjbbVYb5T03fvrG22gooRwBgCPfBuuKYdsuvGKnmj/g/uKnA3vAnkcXZ+ASqHWP/VkaSTE60zpQUF7WJu4Uzk8qk40tcynRazWzsYYc1SVcHic9BhqtFiIBkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784761379; c=relaxed/simple;
	bh=BFbZh+ntuWHBtFTy0Ki3TzUY5YSGmIRu5fpRYKoG3v0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=unYXxzwxPVCbDuzHgdP0pPMaGbaiXuvqxwjhJsNkXJnokC5t+QoaAZW3kvWTcLUZ5xPk6glyl8UBO93firc74uPxPqpJHRKVnLtZ6Fo49QvX+XLALdiXzZoxAYjaCQYEGC0ySuPBBmNAaJ/aclOxTAWnO+vR602Mq4Ge5bir5Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2Ew1NhW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2Ew1NhW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A50A1F00A3D;
	Wed, 22 Jul 2026 23:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784761377;
	bh=M+9gUWXB1JxNkcnC7x8wAJsFruNd1Q8F6mv3i+BG7A4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l2Ew1NhW8BvPbCUxOI0TqnvMQ2FnuffaeETmW95njXV5E6+Sp77MNht1YV9MZjC1L
	 NE0/n8ZzY4UE7QRB1Vz9zu256OkeQuKiYI1FbXaABrEtha9Wut57LpQPS51c6VjKrf
	 AikzsJU3viFRTO9p01fhQ814xfGKBzPEEwIi4QPuorz/hKjU+RCOydXsH3/Y18wria
	 dE3luMfVPCCUYD1ZWpOR86WgKYoOSVjwU8/qgLDc4ArmgAmwgWv4iyIptIOmiRVXFp
	 Lp7I6BA/3FPE+Sj0zJWRTgz0dHzZiAsW7pVTptjBQPxvUnJF20L0sqWs1n39uCyT0t
	 wJw59aupNV37Q==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	x86@kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v10 02/11] x86: hw_breakpoint: Add a kconfig to clarify when a breakpoint fires
Date: Thu, 23 Jul 2026 08:02:51 +0900
Message-ID: <178476137184.26117.2239692963036759209.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178476134787.26117.10094977293012760490.stgit@devnote2>
References: <178476134787.26117.10094977293012760490.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add CONFIG_HAVE_POST_BREAKPOINT_HOOK which indicates the hw_breakpoint
on that architecture fires after the target memory has been modified.
This is currently x86 only behavior.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 arch/Kconfig         |   10 ++++++++++
 arch/x86/Kconfig     |    1 +
 kernel/trace/Kconfig |    1 +
 3 files changed, 12 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index fa7507ac8e13..959aee9568ff 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -457,6 +457,16 @@ config HAVE_MIXED_BREAKPOINTS_REGS
 	  Select this option if your arch implements breakpoints under the
 	  latter fashion.
 
+config HAVE_POST_BREAKPOINT_HOOK
+	bool
+	depends on HAVE_HW_BREAKPOINT
+	help
+	  Depending on the arch implementation of hardware breakpoints,
+	  some of them provide breakpoint hook after the target memory
+	  is modified.
+	  Select this option if your arch implements breakpoints overflow
+	  handler hooks after the target memory is modified.
+
 config HAVE_USER_RETURN_NOTIFIER
 	bool
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index bdad90f210e4..6b7e14ef8cfb 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -246,6 +246,7 @@ config X86
 	select HAVE_FUNCTION_TRACER
 	select HAVE_GCC_PLUGINS
 	select HAVE_HW_BREAKPOINT
+	select HAVE_POST_BREAKPOINT_HOOK
 	select HAVE_IOREMAP_PROT
 	select HAVE_IRQ_EXIT_ON_IRQ_STACK	if X86_64
 	select HAVE_IRQ_TIME_ACCOUNTING
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index b58c2565024f..d9b6fa5c35d9 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -866,6 +866,7 @@ config WPROBE_EVENTS
 	bool "Enable wprobe-based dynamic events"
 	depends on TRACING
 	depends on HAVE_HW_BREAKPOINT
+	depends on HAVE_POST_BREAKPOINT_HOOK
 	select PROBE_EVENTS
 	select DYNAMIC_EVENTS
 	help

