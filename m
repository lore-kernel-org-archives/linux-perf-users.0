Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B49471252;
	Fri,  7 Aug 2026 15:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786116861; cv=none; b=V/4qhnbZcE5dQHiP9aHqNc9cD+YJ72iKM6zvWwef8CpWU1f5FsM0X7jUWUD3M4cHShdyWxIwtOxaMBYRLqjHL1m1Fpbs9LV7FZLa/9LElZVst6fftWbiED63kMYii85FXhnnewZT9x0cCjZAd6XFJCz458EnbjKezuJGCoQtwkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786116861; c=relaxed/simple;
	bh=UQmY+k5YWaVCDo6SuSbSCaeodphPvgVFa1uiBOXOPKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ub2kjju/lj4QSGr3LxR4rw1CnayOx8tI5UnkszRsBtI6caIxOcYq6cWil37G00HzxvKXqeZnMRTtVomGu5Hjk33tYtXrzvZW+soU1fW1fUSZ5FSFS74NvfmnoUjDdZgk8fhBQXi/AsdHrKX3GLPTRx5MQI0ktHLj5RFwW1t+3kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QL53oSPt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QL53oSPt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 163281F000E9;
	Fri,  7 Aug 2026 15:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786116859;
	bh=VYR+OU0Dn6REQfZ5dvoGwVChYT/u8V3bDeY73u8gbsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QL53oSPtxyJV6cmSuhb+QviHLD8eaX+FboF92vWyRovTdzumw/S4dXN0UdWuSe73e
	 +Ivt58sB9HeTm2XzI08+YYnNLyvtIHSxhwR3n84WCmXFOb4l8lcnjkc3GMVEIjpomw
	 F2/rGI3XgeuqtzjMaGt1M9Vpqm4q9RCQCnZmdUV65G8piKu0J+WrxGf6+0VSwguiTx
	 qnrhYdhSQNZhI53/h9PGX9T76QYw0ye/mV1LNr/brWIMTvVMS1HaU8jEZyQv6kI5jX
	 bhO6Qbdc7iJhdvZtVh1WSedKgfFlNiwKpTi17WYJfOnGgEEzsGsgSA42J2uv2Lcm0e
	 IoNob7KYyRghg==
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
Subject: [PATCH v12 05/11] x86: hw_breakpoint: Add a kconfig to clarify when a breakpoint fires
Date: Sat,  8 Aug 2026 00:34:14 +0900
Message-ID: <178611685388.237811.14452013458905879452.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178611679753.237811.10190793347982785419.stgit@devnote2>
References: <178611679753.237811.10190793347982785419.stgit@devnote2>
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
 Changes in v11:
  - Move select to alphabetically sorted place.
---
 arch/Kconfig         |   10 ++++++++++
 arch/x86/Kconfig     |    1 +
 kernel/trace/Kconfig |    1 +
 3 files changed, 12 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index bea383408e32..a096952987a8 100644
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
 config HAVE_MODIFY_LOCAL_HW_BREAKPOINT_ADDR
 	bool
 	depends on HAVE_HW_BREAKPOINT
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 33908103d9a0..533010ab29a9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -287,6 +287,7 @@ config X86
 	select MMU_GATHER_RCU_TABLE_FREE
 	select MMU_GATHER_MERGE_VMAS
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
+	select HAVE_POST_BREAKPOINT_HOOK
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE		if UNWINDER_ORC || STACK_VALIDATION
 	select HAVE_FUNCTION_ARG_ACCESS_API
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

