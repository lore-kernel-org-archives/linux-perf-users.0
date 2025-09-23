Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06011386B4;
	Tue, 23 Sep 2025 01:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758590240; cv=none; b=afPsy5GmZDweCFy8wDBrU/9TUHpHKoTP6yyKiMjERWXFJqV+LtsmuvTy9/hxQY8BypsRIUrVoyivQkZyuE939hAt50sxGUe+hYvxBk38t5cmVpQRpeQEUe1jhaMxL2PrCphFdCbg0sHxuEuch7/C0spW6MR5OkmxAXGNItj+joc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758590240; c=relaxed/simple;
	bh=HMBQRx7JyB5v7TgDveyCx2NTj+Btta/jIE/kq7ocmdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=itphCc3niqKcS+PhAHMaTsTjMqc2/BWlF2Hib+veY/9enUruwjYMUWkTMRMmUwNn+NcIycD+HT+9qaOYnjvlNhAGRT7a+/LUNMGcgIZFxynkyaAGN59rHOMzlCO4fVT98e/s9tm9AqnFIQ02HIfEJJmt75UKg9jnCzmsj5mRBcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxVUSzZ0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxVUSzZ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349BFC4CEF0;
	Tue, 23 Sep 2025 01:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758590239;
	bh=HMBQRx7JyB5v7TgDveyCx2NTj+Btta/jIE/kq7ocmdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jxVUSzZ0ncxTgjTj/YASEBweBpReVs4t0GVLN7COUeKqS+9gtxlTOEg5rFrP/HWJI
	 w296ZL4XTMcf+7y5VktExL03FESbRhLqz9pIAwpUJiMRONyrFJryawm8dkW6LvptUl
	 iOtA94zsZhjb475mSmbB9PylNYcD6r4+OpIDa4JMwNk99UZ7SyFfYm0KJkB2MKpb8n
	 aB+IBRqemzjA3MF/0nvt9xLSc3wCTbHNxHoPCg3J7TZ4+drohervQfYMtPFskiObAm
	 h9T1vAN5IsUGINdHR6XNpT57llETtCgZ7M9quwhX+8pBMWCAKm1x2rngJYFDjizhs2
	 zwieM1L6KmUrg==
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
Subject: [PATCH v5 3/8] x86/hw_breakpoint: Add arch_reinstall_hw_breakpoint
Date: Tue, 23 Sep 2025 10:17:14 +0900
Message-ID: <175859023408.374439.9096230357672772249.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <175859019940.374439.7398451124225791618.stgit@devnote2>
References: <175859019940.374439.7398451124225791618.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Jinchao Wang <wangjinchao600@gmail.com>

The new arch_reinstall_hw_breakpoint() function can be used in an
atomic context, unlike the more expensive free and re-allocation path.
This allows callers to efficiently re-establish an existing breakpoint.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 arch/x86/include/asm/hw_breakpoint.h |    2 ++
 arch/x86/kernel/hw_breakpoint.c      |    9 +++++++++
 2 files changed, 11 insertions(+)

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
index 3658ace4bd8d..29c9369264d4 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -99,6 +99,10 @@ static int manage_bp_slot(struct perf_event *bp, enum bp_slot_action action)
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
@@ -187,6 +191,11 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
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

