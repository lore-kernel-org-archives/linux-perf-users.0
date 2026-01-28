Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D978628E571;
	Wed, 28 Jan 2026 14:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769609434; cv=none; b=ZXjVrAOYiFeRK/1gHrH6wEjV/4/e31APNF4Q4naNb9Y4fhd9EjeHOlWDLlGCrR9H7EsHHqpQT88euRvOLv28DgfZKrT4J8Sj/u+F+WSiQOeFlAvHf0eOXKEaiP+Mts/u7ZTaEGegbVg2jYNHvAdaElJb2z3qF5GM+3uMiGCieXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769609434; c=relaxed/simple;
	bh=2fcSX4kIwFIDKw76TQlcptyp8280Ha4c+S8Uiz27Pus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hQBQm928pcgxX23muTKuiLSkh3jihEahNVjfhjsC4V53jPL39yf+zSHlmbcCkGBeA1WwkL6WyuP+vdH052lFmvRkWuDXt1874ngTmK8kzXvG78WI3FfTBYPEF6XVcgMjfxhwDWd6efr7RktZwsb+uzil6T2MwepaaYKFmG57VnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9jSmVOE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9jSmVOE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E212EC4CEF1;
	Wed, 28 Jan 2026 14:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769609434;
	bh=2fcSX4kIwFIDKw76TQlcptyp8280Ha4c+S8Uiz27Pus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S9jSmVOEXNPzRwPP7S+cOYeUwneflBkacqlSmASiIjlD2x0oxBFcveuEmSf9IP3VC
	 1ZjS0P4Ye3AApJKg7aqhxgU0OfskLJv6yT2bQ8yQDaoGppDn8AcXlUgv7QRP69M6/b
	 ggsEJ/NUjATvcgW89m6HtlbKZkc3Hg6PVSLER+0Cu2D2GDgVDtVH3H2VrHbMNffcKK
	 HqXvFyBYzrb7/BPTDdvLxrrZIAprJ3424TOWXpwBCfIhEM2J6UIvPWuxHNdf+A67Mc
	 ZrjW+KXAj5qsLnX5oGpxoPeewo7CBTFQtuJPuiJ5UgwB0VeACqFK8VoAK7RXrWsh+z
	 ZvrNsUctaqpaw==
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
Subject: [PATCH v6 08/11] x86/hw_breakpoint: Add arch_reinstall_hw_breakpoint
Date: Wed, 28 Jan 2026 23:10:28 +0900
Message-ID: <176960942877.182525.17095859955520882013.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <176960933881.182525.11984731584313026309.stgit@devnote2>
References: <176960933881.182525.11984731584313026309.stgit@devnote2>
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
index 877509539300..9af8d81075db 100644
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
@@ -188,6 +192,11 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
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

