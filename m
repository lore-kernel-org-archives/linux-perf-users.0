Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C471037F8BC;
	Sat, 22 Aug 2026 09:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787390665; cv=none; b=BUJXRhzP4Mi+IKQgxTg2dW0apnOjOTrBZ7xIJWtbmn9cUB3dBbkMexUtdgGWWwl9BMvX/PoSh6Cmtsf+Dmk4lYXhuVkhZriScjp7m4jlhHCWiReXEGKM53iGDPTJ+keug9uvwW4nxyqeJS63w+4t2ylOyiiIVY/OnO3Dsifeln0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787390665; c=relaxed/simple;
	bh=k6pKUae6rMqy1c+9ya58K0hA0NGmnLitLP3hUTlBo3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pS/eBdvA5v58dda0ZQeqh+zsjoqzRG6RDfM0/CWDLn852g0d1eDLj6mAah47HBJu0qhRbtXVPm+3z4LPDVCqF45BrpB7y/VsR6IfW4wpBAFr9DWb5TsDrUI0l6NI0odlM+woXgXkbwLmb7mnzN1z5s7sVJRSkKwVZdlXx12r4zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUpEj2J9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUpEj2J9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1CFA1F000E9;
	Sat, 22 Aug 2026 09:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787390664;
	bh=hNGoniOG4ylDf5LgHhpZIho7vMOVlzqzOg9K0p9p3Rc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mUpEj2J9NWoKVUfRDT+Na6Al+gImK9GiqDt6Bok4rc5Kzmrfw1uE7gzgw18KqO0Sf
	 Ilag+A2ootnYplVO1zTbwKd/YrzBQjtOsxSE7+6EItpnoKEtsVy/Ybjic3AeHChp1g
	 VL4ESF5QbbFr00AJmvhaaaL0zQWHTDlELt/dXd57jergykGmSMNglpcvfAsrL3dDkv
	 BP4L3k9D/XBYUbwlUdZryP85GYxZMIkBodYVmySM9uN2b6NTfSL8OCTX8weaMEtJGP
	 eKlIjTYXNwcXH+Wl3iZ0f9nicsax3PyKl5QLqfwnySIbXYPdeaBm6ffEZHJQg4nNIE
	 /jbVnbDmkDntw==
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
Subject: [PATCH v13 06/12] x86: hw_breakpoint: Add a kconfig to clarify when a breakpoint fires
Date: Sat, 22 Aug 2026 18:24:18 +0900
Message-ID: <178739065859.1520941.7359422308748763102.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178739053919.1520941.17662338993878200834.stgit@devnote2>
References: <178739053919.1520941.17662338993878200834.stgit@devnote2>
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

