Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194D930D3FD;
	Thu, 16 Jul 2026 02:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784170385; cv=none; b=Fz1dHzwIeWtFTbuidpQXr2hhS5wUHFFaL0hZODHdIbG4/aGST47iAMlu7E8bXCbIxyh570u0/lmHcNhIwCk+Z78YmyryCZe738v8m74V9uNakQ6vJti2s8AZLpHH6nAf2AQ6W/QqTZfKke3RKOgcUDr7tc7sxT0/u8BaeUzbnFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784170385; c=relaxed/simple;
	bh=/GDpLwCp6U1Ku9QJ2Bw/kiCwGNM1+f60U5r2L5O74b4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=euGw/6/PKp/70quEZ+AdrIW8erhPv6l5ITpmLbrZD+A1yfMjRZXlo39VpEOHNq61WCFNTrVJdu8pjRtqUGBURv+XrRnwd+D7Uxb+jID/SJedrhkluJp1iW/GTx/Td8lfYHkOIQwPkfYTlKOxDZj0Pt0+RJPP1oJW+Ju4DeON+Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AT4cfpdU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AT4cfpdU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B19E1F000E9;
	Thu, 16 Jul 2026 02:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784170383;
	bh=2GPvDkPlcGd0G2tgY251xb8gLbxa/1LKbQFbwC9Otko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AT4cfpdUeK6kd0lt4UpMU7PgcOGjkGjiK11r6lXgxJQi3GYeBiPn8S7haaGoMS3Wd
	 MDShYaiXGv1PpRuFc/mOf7FJx5z9zIWiqSLXJDOg9D1x9iP87LWfV0qq/STAVuOfUY
	 omPbTjyaQRKz9dUiD4Fns5eVnPPXSQbsmNVo0lJPhRToaEJG0kxqLtm95zKPU189NI
	 tvzi3MxVrM2jAbuFGhGdq3+5U40/C9sZtFj5OtpuQoDfIneEWu8vJ9Ax7PGC8PX6gQ
	 NgSjVfrOlfA/jPzrCXiMogR3nt9xlYEFwH1OdLU/GoXKZw154H18PgspkR+BWkthYb
	 K2PpUDPy8OEzQ==
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
Subject: [PATCH v8 4/9] selftests: tracing: Add syntax testcase for wprobe
Date: Thu, 16 Jul 2026 11:52:57 +0900
Message-ID: <178417037719.209165.16282406318188544857.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178417033089.209165.16717079876036408877.stgit@devnote2>
References: <178417033089.209165.16717079876036408877.stgit@devnote2>
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

