Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEE71C695;
	Sun, 14 Sep 2025 14:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757859058; cv=none; b=HHHR4idvA0oqw6KSuzXnhcs4JV9LpyyIG3aXQ297k7HOwVm+cIUFFwybVoXEvMnvL6lNW8uRQU03dgsHZAU7h1bVyP+/trhDt6Wv5r2bKD+uehdpZkFP1fm6nt38l7OD3MP0R2Pv1fCeGVkCyVZubBa6LOBjIVbHIzglqsVxZe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757859058; c=relaxed/simple;
	bh=V1sZe++I+DX8D0azwJCk2OhQOYC8K8WNEARBLQqqCJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KhPJ4OzWtCGzkUVrw9vvp7MkGtBhcrANV/mH2F5A7LacfiP52c2f2Kx/E7ip9AxYwzZwcqW1zvEMLha5etOTwC58ygEOvY6IlAdPOKoxOxMrSzNzZ2QzUmPjPK+jH6jFwyO48j45K77Gu82TuclrFpLR9PYioIcARFB6gM/C5VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYE+nvf9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYE+nvf9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD266C4CEF0;
	Sun, 14 Sep 2025 14:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757859057;
	bh=V1sZe++I+DX8D0azwJCk2OhQOYC8K8WNEARBLQqqCJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IYE+nvf9ibsAXzXzqQz3GZDcJGOCb+olrUVu9h40124V94IO1w1IESPGrOcedWgkp
	 LAcIokgjt0JgPiJZsIwsHowwChaJyMar2mV3b9ccwUt1f9wSicXVqN9SzZcOkTb9/Q
	 gVqOubKqSpZmtoudLoHFCjsBG3/ktif5AjvrZij4083lyGAt6bx89ltLf9+nhtFIuW
	 naBT41aLAJXrVa5LTj9ZNtSzr9lq0ZljM3qsq1dSjdXk88JUzkxSM3BEo/VCqRxM4W
	 aovIG4+3dWSKkpyjpV6Qhte/cWZ/275kE0q0uG+zo5daYony6Uc6mwYfLksLb1mFVJ
	 Pvl2pFXZiQO/g==
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
Subject: [PATCH v4 7/8] selftests: tracing: Add syntax testcase for wprobe
Date: Sun, 14 Sep 2025 23:10:52 +0900
Message-ID: <175785905217.234168.11065155638485207058.stgit@devnote2>
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

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add "wprobe_syntax_errors.tc" testcase for testing syntax errors
of the watch probe events.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
  - Fix to use "wprobe" prefix for detecting error log.
  - Fix an error place with wrong offset.
---
 .../test.d/dynevent/wprobes_syntax_errors.tc       |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/wprobes_syntax_errors.tc

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/wprobes_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/wprobes_syntax_errors.tc
new file mode 100644
index 000000000000..56ac579d60ae
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/wprobes_syntax_errors.tc
@@ -0,0 +1,20 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Watch probe event parser error log check
+# requires: dynamic_events "w[:[<group>/][<event>]] [r|w|rw]@<addr>[:<len>]":README
+
+check_error() { # command-with-error-pos-by-^
+    ftrace_errlog_check 'wprobe' "$1" 'dynamic_events'
+}
+
+check_error 'w ^symbol'			# BAD_ACCESS_FMT
+check_error 'w ^a@symbol'		# BAD_ACCESS_TYPE
+check_error 'w w@^symbol'		# BAD_ACCESS_ADDR
+check_error 'w w@jiffies^+offset'	# BAD_ACCESS_ADDR
+check_error 'w w@jiffies:^100'		# BAD_ACCESS_LEN
+check_error 'w w@jiffies ^$arg1'	# BAD_VAR
+check_error 'w w@jiffies ^$retval'	# BAD_VAR
+check_error 'w w@jiffies ^$stack'	# BAD_VAR
+check_error 'w w@jiffies ^%ax'		# BAD_VAR
+
+exit 0

