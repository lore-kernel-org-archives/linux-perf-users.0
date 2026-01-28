Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8D5239E60;
	Wed, 28 Jan 2026 14:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769609389; cv=none; b=WFtJjjyFcK5CMY7WzI/iawyT6tFVBa4c3XP5TOt91EPSkvLojT1niqYfnVJmsPIClaMV6k3j1VisFqkpO0o/GgnfJM/mwf4ywbE2LVwwqJXSQMwMvI9gsgn+p9fHfAMgR4PWzoE6lxiY4Tv/vTJiqn5i1uNbtR8AkZ8iZunUi3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769609389; c=relaxed/simple;
	bh=RnKOHNBPmj3Cu03w5U04I8JGBqtXnIak2+AQjeku/RI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dVdqiErg5xaAdRMGq8lVXOEQ45yO//1lZr7FnaifF5ABDFQt6VhJbd85WbRgRjtNmPfwX75PMqI/nrb8oOhUaoDc0v3AKQg/fhcDGUQ7eCMq0iFaljc1HZsXiLOtkwIIfj3fNJ4vUMdHJq5UabdP1fOsqsMKexgMcuktk5uyMkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJZ/858X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJZ/858X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2442C4CEF1;
	Wed, 28 Jan 2026 14:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769609389;
	bh=RnKOHNBPmj3Cu03w5U04I8JGBqtXnIak2+AQjeku/RI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UJZ/858XNjPXIQa1OYYs61qFzFkQfhz5tjfJSoLwHrv+Ln9To+fLU1LqRjSCIkSbz
	 hAMeyTUjIQyxUskoAaoTTfZYEKFOTLbRACCYES3/DnlsRgHOr895wtErI/cZD5PbkL
	 vbQrBwwMVtlXyvgoG1aJk+rqStVNU4lY4Tz1RL/UGwZVkmAyTMSY+KDxFqb6vuqxON
	 RGeTg+ie/vuw5HfFjLH51854oYXFgaMNnP7k4Oj1BZTMyv8QA9nUdzfV+8ygt3i8yN
	 3pFKWSGBe4u/XuHInmOTbabuMuOWOBZumTvh45yeyIEGZsR7nyVTR0EKDIKzDoddNV
	 Y2UyOKME1kD3A==
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
Subject: [PATCH v6 04/11] selftests: tracing: Add syntax testcase for wprobe
Date: Wed, 28 Jan 2026 23:09:43 +0900
Message-ID: <176960938340.182525.7033743309632028932.stgit@devnote2>
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

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add "wprobe_syntax_errors.tc" testcase for testing syntax errors
of the watch probe events.

Link: https://lore.kernel.org/all/175859027842.374439.6402700780945714048.stgit@devnote2/

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
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

