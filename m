Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807D71386B4;
	Tue, 23 Sep 2025 01:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758590284; cv=none; b=aRoaD9vGrXzgYrn8u8N/Ud8BBrXRHMT0T24ga4g/Cf5DWMQPQbx+EFgaVOTRD+WLDTGSeurBOOKAHmdst4HS+ijgoQVW2B64m51jZPwy6bjixQt6xYxIpmwv+pkf34XqNd44l44WP/9ufvzwxP5NFP6nyBq9zc+mpAvI29jNCkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758590284; c=relaxed/simple;
	bh=V1sZe++I+DX8D0azwJCk2OhQOYC8K8WNEARBLQqqCJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JhcvcQe49mf4FIWAflyM/bT6fCKlVZMaVMQ20/ptF/3I9VX6a97szCFgiMmL8n8whMVNrhVq5whRUwFQ5jlOF1J6/lx98oSry4RvGac8jdoHab0aRDWgd+1TsmfYxuJWa9EzjyzQxQsZUMlfAjNxt9J0XYFgWCXZYjHqYfvj7qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrNhvTiq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrNhvTiq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92D2C4CEF0;
	Tue, 23 Sep 2025 01:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758590284;
	bh=V1sZe++I+DX8D0azwJCk2OhQOYC8K8WNEARBLQqqCJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BrNhvTiq7nszs8awxzt7Kc4KDsbekneTJWNu/b/HUZQk8jY7O00KP0GvLxGFLRt9i
	 ++V/aDSgJIf1+VM1/2m0OjQjc7RCFgYWxe92gaGSwahouMwoYJEaX3zJH3kFPJhfkG
	 nC9ZbcnSZpuS9MOhTWFpONyF1gCwsCVAik6GMnnwREeKbWRe+Hcx++Eq0NIfjuZRGx
	 71aeuD0AwzfGqGmqazvvz4GRIJ79vGQdTuEeSuxSHC7SatogUfWeYdFg6yKsIqegJD
	 3J/kU7m84EPxWskNd1jp1Vuw9lwnqdylyIqgV6L76+XAHCuyYhW8NBCyVoxq7//nEp
	 +TS8FsGIEYXWQ==
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
Subject: [PATCH v5 7/8] selftests: tracing: Add syntax testcase for wprobe
Date: Tue, 23 Sep 2025 10:17:58 +0900
Message-ID: <175859027842.374439.6402700780945714048.stgit@devnote2>
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

