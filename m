Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3636837F8C4;
	Wed, 15 Jul 2026 01:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784079893; cv=none; b=r1f4DuYXGhcBGgFbnwJUx8b3awgJQXSpJrnFMlKFUyCf8uxkNn7jwjx1ipiDxUeD5hiySpzzzEKcqzfBhefBF4XzsDnuWqao1jsDUzzBxz4EoqpjqdbjOgzLfhZ63BXM0Sn3lDYsuW8BirjSxA4mQG3NIRUxQZvK4Sw1c2pT+Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784079893; c=relaxed/simple;
	bh=RnKOHNBPmj3Cu03w5U04I8JGBqtXnIak2+AQjeku/RI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lpeTJ/haO6PYTl0qoV1Ttf8sv47mlailUTFQ2wjA5VVT+xBtX8Pb3RjM1lxcdk3aSFCizC0ZpldgNmHOsZDXLgq9fao751prwBLO82vuj32Sn8dgtKRR8hKoBO9J2a2L07RTLdnYDXEhKITGvjm64xcbRJgTZ/6eUPj7OVPoU04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fE2qLOSq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fE2qLOSq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79741F000E9;
	Wed, 15 Jul 2026 01:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784079891;
	bh=bVuoFZz9XzNae8H4PardShx2MzQLtMk5zbZKcfpef8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fE2qLOSqOU57v0pb+utlxItCp8SlK8kX1XoZzwlHoM6cYsQ0ck1IIfqUmLMuB8B+l
	 lZSLy5f3Hg4r+ulpu8Ok9y2IB3yu3vbXVKFIxwuypHsKyoHewSfDmbpjlTHB6lWy1G
	 ibEzqeStBenOnAtMMdM59Ru8MO1MTi66qrBMTgMs1Fjg/idjeww0eLXU7mmlypCjD3
	 1bWqgVbX0gos8RVhStD5q0UKNPep00BDDGvr055R3F08Q8atgQ06neN9HE/9tU1BGw
	 lov2i8DAzBbPt6wlbLYVG7b7KSsgfSQEacqBVOxJ7P34vu2CAxB7bBdzHFZKUA1ZTT
	 Qrr49iINpcMLw==
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
Subject: [PATCH v7 04/10] selftests: tracing: Add syntax testcase for wprobe
Date: Wed, 15 Jul 2026 10:44:45 +0900
Message-ID: <178407988551.95826.11515149189701096855.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178407983818.95826.12714571928538799781.stgit@devnote2>
References: <178407983818.95826.12714571928538799781.stgit@devnote2>
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

