Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1541884A3E;
	Sun, 14 Sep 2025 14:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757859015; cv=none; b=OpBtH/dh+OBTcS4akdSUUKFD6nRxMuBKIKbs3aaS3BDmiBSq4kalbNzZBDQDqEGuofa7FtBB2cb2tNBhhrusrV/Dvf/Y//ztpbEh2or9YcLMYKkGNLVF981NKZLZASLvMajnLhOgIeZAMkYYPQaaodrkzdLrZXo8QZMw9NDa7NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757859015; c=relaxed/simple;
	bh=HMBQRx7JyB5v7TgDveyCx2NTj+Btta/jIE/kq7ocmdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NZjoHMsnhrWUwDKf1TRH4AogT4/pkWh9GDhcV4FgWd7Ijv6hTQTX6UvU4zxSH6ujvsgfbtFczpd4/k6h83HehTJKjdihIqoH/lpwphddVBi/yWYYuhkdGAZc49pqeZDK6QRun0lhN+i7WrLcEtQPyBJ6+nlOq/FZWoyNIMT4dHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/MDOG1g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/MDOG1g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D783C4CEF0;
	Sun, 14 Sep 2025 14:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757859014;
	bh=HMBQRx7JyB5v7TgDveyCx2NTj+Btta/jIE/kq7ocmdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I/MDOG1gpEqo9fLkFiJzHX1h2jZnL1CSF18i1Eh2Dcuq9dbXxnQnuPHIJhVlxgZuZ
	 Dnx3T8SK3LmKYPk7FnSD62Z0WSM7SqPWjApEXzodO6W/xFRgTmpXheSaH05+hF40vD
	 BZU/297t/lzMsXywMuHM4oH4kfwsvuTWJUMcnL9Egt8TeqGNURggg6IOHYqpgI7t5e
	 Fgkxl7mtSwUyEhjk3m7BvtQj/WzzFXODIRxxVrx6MHQ5S6gMpku9YBPSD2sBlyqGkp
	 bTJ3PIcmHJUuDZ29JGDk63PD679dlG47hmXat9DWuhCpT5/pumQTp/cOBpKEEk0bVu
	 BuN1QebWN0z4A==
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
Subject: [PATCH v4 3/8] x86/hw_breakpoint: Add arch_reinstall_hw_breakpoint
Date: Sun, 14 Sep 2025 23:10:08 +0900
Message-ID: <175785900886.234168.4223927561031767856.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <175785897434.234168.6798590787777427098.stgit@devnote2>
References: <175785897434.234168.6798590787777427098.stgit@devnote2>
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

