Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F31E414DFA;
	Fri, 25 Sep 2026 11:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790334769; cv=none; b=LxzeLzr28X5i0RVPpuiugGUPNZ/NU++wQ2Rvyb+9aAt/xI2NJvxpB2RzRkGiC/ZYZYkGhvBylh9KfMe4EJ7qiWwZTqhRfFPCtcyAMr9jx/IKdBHT5F7IBCdMuAIjAIFd8kq/kc3QXHQYPYQ8NUOIG/tvygyFz5ZhUcxt81XIPR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790334769; c=relaxed/simple;
	bh=w/fxHVNtA+8suk/aVIjfFU697JVRJgCgDhdycK2gkzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jP7huFDT2zrvfc/mKdrnURfP4PxPF7ysNhDoPlqRMojlQOm+1Xk6l85hkDH+aFf2vi4pYL/qEiVjyG364SDy8RD7w+cb5HgdBhUIy+G3Ys3B8YrNK//tb22Xhb2hovJJdRqceRR0zbr4wxb873M38Zaepmk77yqdcju7dK2s+uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMT/JdBU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMT/JdBU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541E91F000FF;
	Fri, 25 Sep 2026 11:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790334768;
	bh=o0qMmOfhKF4hfQTENoYGXCxXEOkOcEeucQ2rUqmquDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EMT/JdBUA8K9TIFHxVpab/Ems7lttg15RERsMiOMITn5pvZXQuKCmTkKZ7Z0d/n0i
	 yyCdgbAIlDAKA5e2Yhe2ZN2KABFP9BfKb/51qecxSAcYD8tDpgqQBZYmQ2H3q8tP0C
	 OZ32jA2h2CSzk+58ULd6ZtpjyF9jMkRPbxsLyJWTnfQzMTeOExu11oJwsRHDp69N6h
	 KAUHxXIGqtRnmk6PCx/4DLgqGp9uNmbGPDsyvvY66k8/u9UNtXsFegmW06BME9T2hj
	 oskgFl/4I05Da7mDS4mjquR/mdDvXKmKNgn7vmHxbPnS2vXRKhdHEyvtexAd26Ynx4
	 rTk3Y0u+C1ntQ==
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
Subject: [PATCH v18 07/11] selftests: tracing: Add syntax testcase for wprobe
Date: Fri, 25 Sep 2026 20:12:37 +0900
Message-ID: <179033475719.136630.10416788731925582864.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179033464327.136630.864883694296882051.stgit@devnote2>
References: <179033464327.136630.864883694296882051.stgit@devnote2>
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

Add "wprobe_syntax_errors.tc" testcase for testing syntax errors
of the watch probe events.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v14:
 - Update comment for invalid offset syntax check to BAD_PROBE_ADDR.
 - Add testcase for invalid address 0 error check (BAD_ACCESS_ADDR).
Changes in v12:
 - Add NO_ARG_BODY error case.
Changes in v11:
 - Add WPROBE_NO_MAXACT syntax error case.
---
 .../test.d/dynevent/wprobes_syntax_errors.tc       |   23 ++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/wprobes_syntax_errors.tc

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/wprobes_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/wprobes_syntax_errors.tc
new file mode 100644
index 000000000000..e0df58fe7aa3
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/wprobes_syntax_errors.tc
@@ -0,0 +1,23 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Watch probe event parser error log check
+# requires: dynamic_events "w[:[<group>/][<event>]] [r|w|rw]@<addr>[:<len>]":README
+
+check_error() { # command-with-error-pos-by-^
+    ftrace_errlog_check 'wprobe' "$1" 'dynamic_events'
+}
+
+check_error '^w'			# NO_ARG_BODY
+check_error 'w^10 w@jiffies'		# WPROBE_NO_MAXACT
+check_error 'w ^symbol'			# BAD_ACCESS_FMT
+check_error 'w ^a@symbol'		# BAD_ACCESS_TYPE
+check_error 'w w@^symbol'		# BAD_ACCESS_ADDR
+check_error 'w w@^0:4'			# BAD_ACCESS_ADDR
+check_error 'w w@jiffies^+offset'	# BAD_PROBE_ADDR
+check_error 'w w@jiffies:^100'		# BAD_ACCESS_LEN
+check_error 'w w@jiffies ^$arg1'	# BAD_VAR
+check_error 'w w@jiffies ^$retval'	# BAD_VAR
+check_error 'w w@jiffies ^$stack'	# BAD_VAR
+check_error 'w w@jiffies ^%ax'		# BAD_VAR
+
+exit 0

