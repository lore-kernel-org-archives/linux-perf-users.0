Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A7F3E44E7;
	Tue, 22 Sep 2026 04:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790051175; cv=none; b=b8C2Pz7puYB5oi5OHE9HJQYOZ3G2MoJpkRDY4GA1btXPjPF4fRNVLCZei6euz4OYvDn4LFuLzXNLoYpZLdjvklss3UKAbjuvZLhv50FFnnCrCW5ffwrucgnCQjowRrDWisV0aiJmrk0KIqsW3VKPQB+exMxth1K02CIezeRBvE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790051175; c=relaxed/simple;
	bh=vFJelAs6RkUEfep9+zWnllKBieB5TLqkKRYzQduYJEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ejNoFETKe7kAsY5bP8K63Z0evTTge32qRXl7gdk/wbbTYellC7/fgzOSflZkQdKZJECt/xcc3NTSW1IxD9myGdT9mWc10g4fzkOChNdmh1AhZOXyEncRNoY5E1dA6byRyZP4eMrzO2pjz1s9apYN7zsymJfDHFRTliN9al5jaTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhAgZO8M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhAgZO8M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB171F000FF;
	Tue, 22 Sep 2026 04:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790051173;
	bh=DVcGk6Bv8eEUx8YBEhCPRwunKrlLmLX0y57ylhq+Cto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mhAgZO8MPq8kW7LF4IWpMyjwzM7ORHCA7N8ePzFGO7fTTPUuAWKOQ2aALR5O8QhxZ
	 q33Bh3oYcEWXfucMwow5mlmBegu7ZZzK8pf8Lu98mKtjcBNht0hKzpWe1qpKuiGG7s
	 5lrjX9jD8d3oDp/+674Nox7us0PvkjAOHQl8vcJv23tybnG7acIpZNzSVAkbeVj8wj
	 zyNKZ66Pz7C8w80N5G95TyKpKQc0QzFyK4/X0ZWXkqx9qGrWyoMlp/tuqbtGQxmCTG
	 owg2VN/3aO/PqJVQy8hO0roo9ERMQTGe+sDmgQX6C3R2uI9vPTfuqifhBWN9JAzDTb
	 MbF+fwMjUpKww==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Sean Christopherson <seanjc@google.com>
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
	x86@kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Subject: [PATCH v17 07/13] x86: hw_breakpoint: Add a kconfig to clarify when a breakpoint fires
Date: Tue, 22 Sep 2026 13:26:07 +0900
Message-ID: <179005116728.388919.1381770935956884195.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179005108298.388919.4535333252892590932.stgit@devnote2>
References: <179005108298.388919.4535333252892590932.stgit@devnote2>
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
index d021bc31ef14..5292bd05d5d4 100644
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
index 38e29e465022..e4eaf0b607d3 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -289,6 +289,7 @@ config X86
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

