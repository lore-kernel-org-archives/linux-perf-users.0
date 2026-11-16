Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794806816;
	b=hSzxnYE9igSdaC/2yDUaPw68Zd9G/PaQM15DbOudKwsrfrIZ+Yn4imb8ub2g3Uh+mr5A
	 CRnof4KRdJwwxQa4ex48VoaZydPbJq+CusjUzQ1MQyr0OJyYxRpr+pRMRMlz5+ExTp7NK
	 +ScDs8aE4jDkK9zE3VvHTcBJHMOeiFAL1vfaePEQ8NJfVK9KAgvJa4xYhYjXVRNWft7ts
	 /vVDpjCwnqoQy9srlT+kuDX0C2OXBcuE1QBxYUIOk6ubDtB/LotD8Mpyp7f+z5N3RUk9B
	 0+YOT+vRTNOW5EVF/nAlAZDNnoLiAbpniGRNaD4LyIiRpg2Ech8/6WKHT3WU4Q99bLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794806816;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=FyS8t9GNSznpC+RFNkXr0aPcazqwtOsN6IdjkdqtAV4=;
	b=5DdDj+EjckbQVbUU4C6XH/rc1ZsdBEctwkxJyFXd+cjFfDMgS38sh2WKosT3iZ7cuvYR
	 PpXJPasMxFw7/CQ7WCq7pgk9tqmc15L6MOuTC/go570W1jt3E4WJ0SHtFcr+Ru9Rag9kS
	 m22PkPCq3EGtMrMxuD3VIDxO+fB8PfjbFA03EGujHNlCO/Gap3Lse5TV73ywkrLuJoI5F
	 mir2wCM3GKP6QvFH9/RUhyj6VTyrASAQXjlYvNtONpt66QpAxjJEZc2OLMuSsdiOUQTJm
	 j2KTR3YSVunq+QIvOHiPCFY4bCD7dPbWB6vIHUrpu1Yz90kiabDTxssjGLn3nWgJuKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mXH6FoWu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C07606A323;
	Mon, 16 Nov 2026 05:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mXH6FoWu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D121F000C4;
	Mon, 16 Nov 2026 05:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794806816;
	bh=FyS8t9GNSznpC+RFNkXr0aPcazqwtOsN6IdjkdqtAV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mXH6FoWuilKDHQ+OPKYik313sL/zTA2fd8hoHWE1IwgIFn4738PkXhx8urPV6+rzM
	 ndkG2sEooM/S98JNhcduzK/q+7mvhJCeRQbyOoCIDXdkq96e/nAxbFPXcR9NBDioWD
	 5APY40e7noQy1zZ7P7QPbLVr02CRHuS3288/C40wpBZZrJjHf2hgZWDLezfiAZFkDf
	 irHnFJtp+UgRB2gSW8UL/J2A51ajcH1sIViv2OuaWybjtQ8KCiLg7V4hl18pZMU9YM
	 ktAJvLmSZfaUsduOLNrk3cKziqsbsVpFl/G0IaVrMmT3MMMpnqSu94mG8erXwHT8pu
	 9rkGDAfxrGKCQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
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
	linux-perf-users@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v20 05/11] x86: hw_breakpoint: Add a kconfig to clarify when a breakpoint fires
Date: Mon, 16 Nov 2026 14:26:50 +0900
Message-ID: <179480681023.38065.9381486145352859573.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179480675130.38065.3086970856119381693.stgit@devnote2>
References: <179480675130.38065.3086970856119381693.stgit@devnote2>
User-Agent: StGit/0.19
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
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add CONFIG_HAVE_POST_BREAKPOINT_HOOK which indicates the hw_breakpoint
on that architecture fires after the target memory has been modified.
This is currently x86 only behavior.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 Changes in v11:
  - Move select to alphabetically sorted place.
---
 arch/Kconfig         |   10 ++++++++++
 arch/x86/Kconfig     |    1 +
 kernel/trace/Kconfig |    1 +
 3 files changed, 12 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index ce6fe06838ea..740ba1eb2663 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -474,6 +474,16 @@ config HAVE_MIXED_BREAKPOINTS_REGS
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
 config HAVE_MODIFY_LOCAL_HW_BREAKPOINT_ADDR
 	bool
 	depends on HAVE_HW_BREAKPOINT
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3c50d5a7e0e8..6536e661995c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -287,6 +287,7 @@ config X86
 	select ASYNC_KERNEL_PGTABLE_FREE	if IOMMU_SVA
 	select MMU_GATHER_MERGE_VMAS
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
+	select HAVE_POST_BREAKPOINT_HOOK
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE		if UNWINDER_ORC || STACK_VALIDATION
 	select HAVE_FUNCTION_ARG_ACCESS_API
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 6200c3ea4cc5..5e2015d1d3b6 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -874,6 +874,7 @@ config WPROBE_EVENTS
 	bool "Enable wprobe-based dynamic events"
 	depends on TRACING
 	depends on HAVE_HW_BREAKPOINT
+	depends on HAVE_POST_BREAKPOINT_HOOK
 	select PROBE_EVENTS
 	select DYNAMIC_EVENTS
 	help

