Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A80238C2C0;
	Fri,  7 Aug 2026 15:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786116883; cv=none; b=jJmxLLqHxvmO00fHlgEJgkKDcO3Sw/n34uZgdjO9OlYME0Rez7wS83EzVVKouv+j4KZqBekVbXrmRH4PBO22B/yJJUcJKZxiouKHhpr4jm/ZLUGjzgwgS7kvL6OoMgrYeqtUlxjB2OjNJKmnpSUiT4/idWJ0/u92auvWPqQ8680=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786116883; c=relaxed/simple;
	bh=I7keiJZxhcvIqTtelDYJ8wxvYd490JzlGO3twFAP748=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NoFy8cVxQbNppennzZ4Cv2pA36N4K5lDHX+irZIyp3CgG48r7MUtyn7pCS1DFwp8qHe3eh6xT6/kZOkvd3p1HrBZB3CfbaW8ZMQBNGcpTyhtLAoqmydZE/9jU+fHBFkCRejeWIBfBQeZ1fFk1qGoAeEMjNfFZLwLgC1efkZTITM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dtg4n+C+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dtg4n+C+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BCCD1F00A3A;
	Fri,  7 Aug 2026 15:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786116882;
	bh=icx33MI5IDl0NsRVCwveXp/YypYWce4cJoFEH1DIJLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dtg4n+C+Ybe9DG2DUOFU/2FMSlwaOVKlqTnkF1r4ggyP4JNW8YTNE9j2GsHx1PuEN
	 2YHjs1itGTA9MbdhT3bz6DUNLEaOiiSe8KKCBcVfF6Gh7jndUAj0QhqEWoF1eV3V5I
	 SJShoJGu4100ERVZhvTZ6RhM+j3V3ysyYp9A+4b0ZYQAt2PgFC14ZM4X70xDnR4kpm
	 oBJf3Iuj4LyMZdMvFIYa/6NiOlP44xptIILv6+RccnoNI8kieCGvFTPaeJB5ozkRbq
	 9dfYEuLfFu/h+1P+JzwIylALaaesc6P4kBApzU/2tkaGBHxMNo4TFB/HAenwdNHKn2
	 9YLN2p5JKtXkQ==
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
Subject: [PATCH v12 07/11] selftests: tracing: Add syntax testcase for wprobe
Date: Sat,  8 Aug 2026 00:34:36 +0900
Message-ID: <178611687621.237811.798396860126902241.stgit@devnote2>
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

Add "wprobe_syntax_errors.tc" testcase for testing syntax errors
of the watch probe events.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v12:
  - Add NO_ARG_BODY error case.
 Changes in v11:
  - Add WPROBE_NO_MAXACT syntax error case.
---
 .../test.d/dynevent/wprobes_syntax_errors.tc       |   22 ++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/wprobes_syntax_errors.tc

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/wprobes_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/wprobes_syntax_errors.tc
new file mode 100644
index 000000000000..c279bea8d8b9
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/wprobes_syntax_errors.tc
@@ -0,0 +1,22 @@
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
+check_error 'w w@jiffies^+offset'	# BAD_ACCESS_ADDR
+check_error 'w w@jiffies:^100'		# BAD_ACCESS_LEN
+check_error 'w w@jiffies ^$arg1'	# BAD_VAR
+check_error 'w w@jiffies ^$retval'	# BAD_VAR
+check_error 'w w@jiffies ^$stack'	# BAD_VAR
+check_error 'w w@jiffies ^%ax'		# BAD_VAR
+
+exit 0

