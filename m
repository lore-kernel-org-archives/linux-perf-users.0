Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20684476693;
	Mon, 14 Sep 2026 12:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789390268; cv=none; b=IiIFr/H679bI8KTWGSkKWagdDPG+HErHk3w1bdVXkhpiOYnnX/ogV255mfDcZco6Zb05fp/oEPQm74o9mA+xTCpSeIVLoZ3ORry5QP+moujncGULlynSt37uTnQrC5tbmytFLf4jG66g0XBpr+kkk5+DyZilccOLmbxbcTUWe6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789390268; c=relaxed/simple;
	bh=vFJelAs6RkUEfep9+zWnllKBieB5TLqkKRYzQduYJEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eGcXwuVZXkFtN1W/tcLJiwRkk1odYRIPOKN5RkPZXKxenG6oLQ8ArO097/U2Z1HJGTZWbLyWykbAMIEoJqML2/d8+BlaEMPFfApgRFbeiprpkDmSG4MdVP1FiI85jWkDRb+BlsWhNDfuxly69hFKQn8EW+eZpP9EwzUx4lQvhBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QcDQ+A7t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QcDQ+A7t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF5D1F000FF;
	Mon, 14 Sep 2026 12:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789390266;
	bh=DVcGk6Bv8eEUx8YBEhCPRwunKrlLmLX0y57ylhq+Cto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QcDQ+A7tqCMUS0ixaNrT8LieZOFSbLlc/jC34ELrPeQEU5cxwp4GZ3AkAt9y0fbmt
	 cloagCfaVu/5zCrSBZU8++mQWYrJVztmJ+nUqW3PcxbMlgZGQjF6mXh15hYiQEvamt
	 K1pijKFVwD6sKfApjjbb0ZXYpTKmCocr3R82cQY3fheSfDOZoh4EtkmZVCubgYvCeh
	 yQL+IBnkweWOxGeE4naK3fLFVu5ofANfamPWXQnWphJy25PeNYLeThdhlRSggcTASj
	 sgeVpZjlLqcvjBLebCnta+8pe5+rOvQgfJBw8zX/GSlHVe/4xjy7kMNRpvYnMTN5mU
	 y2If5MXTgG5Rg==
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
	linux-perf-users@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Subject: [PATCH v16 07/13] x86: hw_breakpoint: Add a kconfig to clarify when a breakpoint fires
Date: Mon, 14 Sep 2026 21:50:59 +0900
Message-ID: <178939025972.94750.16829369548375355435.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178939017565.94750.9431053336761330458.stgit@devnote2>
References: <178939017565.94750.9431053336761330458.stgit@devnote2>
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

