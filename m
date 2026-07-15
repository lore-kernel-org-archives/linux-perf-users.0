Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44578265621;
	Wed, 15 Jul 2026 01:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784079962; cv=none; b=q/JqeYGUzFz8GdaoX0ZApN70K/u0DhI0fYicLTXWAiOGBZL9JMigPwBJwMxau5dr6Vp1Rzph1I7tLJrmj0jC3zybQ5Z9JnKR/e1PlQjSJoBGrD2yPY7SUGvvHNbzgaEJVXKpJ3fc+rjL447UF2yOYGBA0QG0lA9/cKvchRKOIfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784079962; c=relaxed/simple;
	bh=rVJjGKr3S17TbNUAdbL+4V5+FKj6xNfm6cz6+ooptS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ff64+Bbcxt/k/eOqTi5ZP7009Uy+sS26971BBLQFtFFTG9l9SXW5PXBV45nrR17zLFvIkPN4LHUuRqfTon6e6O8dhvxFkfEeTENI640L5KOahB+rdsJ8FH6XftIQd6kaz/Zz5NFlNOVidb3K9huwnF+cOMwqTKeyHBE4ExR3Bt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmwpOsy4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmwpOsy4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C54D1F000E9;
	Wed, 15 Jul 2026 01:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784079961;
	bh=O7i/gpCoexgVrVsCcRbivjoHnZ4LRYbdacut/L4Lst4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cmwpOsy44aG3Yj3AQwXEKwkYlCzcvBxaWAAnWnkKWhDpMpWLfKZG1OE/PBUMcNgGS
	 /AzaPSPmdgls84UvQvv6P260IGZZkS6j6m3vuhzB8Pggv6juQwdgU8iwxQfaDwL+uP
	 Y90yZ8v1NtYwYuU2RhFE0ImJ6HylpEjT8V9cgPaF/cT4oHAwWStPUdqNiKlFJV3paW
	 98Dk5iQq7vjbLMF6B3RVRWrgTXXHnvubaiyPIica7/1HR3sHPK3HHOrEDBf4+/JvSC
	 lfozewtPkfvVh2cTvWxAdzG6zn7zTCcDhEsZWSUsPYl5iCWvPbzHDd8U5ymkeZ7trw
	 YddTrXQMaQkYg==
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
Subject: [PATCH v7 10/10] selftests: ftrace: Add wprobe trigger testcase
Date: Wed, 15 Jul 2026 10:45:55 +0900
Message-ID: <178407995495.95826.11582585035165074036.stgit@devnote2>
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

Add a testcase for checking wprobe trigger. This sets set_wprobe and
clear_wprobe triggers on fprobe events to watch dentry access.
So this depends on both wprobe and fprobe.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v7:
  - Add a newline at the end of file.(style fix)
  - Use dentry_kill instead of __dentry_kill.
 Changes in v5:
  - Enable CONFIG_WPROBE_TRIGGERS in the config for ftrace test.
 Changes in v3:
  - Newly added.
---
 tools/testing/selftests/ftrace/config              |    1 
 .../ftrace/test.d/trigger/trigger-wprobe.tc        |   48 ++++++++++++++++++++
 2 files changed, 49 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe.tc

diff --git a/tools/testing/selftests/ftrace/config b/tools/testing/selftests/ftrace/config
index d2f503722020..ecdee77f360f 100644
--- a/tools/testing/selftests/ftrace/config
+++ b/tools/testing/selftests/ftrace/config
@@ -28,3 +28,4 @@ CONFIG_TRACER_SNAPSHOT=y
 CONFIG_UPROBES=y
 CONFIG_UPROBE_EVENTS=y
 CONFIG_WPROBE_EVENTS=y
+CONFIG_WPROBE_TRIGGERS=y
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe.tc
new file mode 100644
index 000000000000..cc7a0532d7ff
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe.tc
@@ -0,0 +1,48 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: event trigger - test wprobe trigger
+# requires: dynamic_events "w[:[<group>/][<event>]] [r|w|rw]@<addr>[:<len>]":README events/sched/sched_process_fork/trigger
+
+echo 0 > tracing_on
+
+:;: "Add a wprobe event used by trigger" ;:
+echo 'w:watch rw@0:8 address=$addr value=+0($addr)' > dynamic_events
+
+:;: "Add events for triggering wprobe" ;:
+echo 'f:truncate do_truncate dentry=$arg2' >> dynamic_events
+echo 'f:dentry_kill dentry_kill dentry=$arg1' >> dynamic_events
+
+:;: "Add wprobe triggers" ;:
+echo 'set_wprobe:watch:dentry' >> events/fprobes/truncate/trigger
+echo 'clear_wprobe:watch:dentry' >> events/fprobes/dentry_kill/trigger
+cat events/fprobes/truncate/trigger | grep ^set_wprobe
+cat events/fprobes/dentry_kill/trigger | grep ^clear_wprobe
+
+:;: "Ensure wprobe is still disabled" ;:
+cat events/wprobes/watch/enable | grep 0
+
+:;: "Enable events for triggers" ;:
+echo 1 >> events/fprobes/truncate/enable
+echo 1 >> events/fprobes/dentry_kill/enable
+
+:;: "Start test workload" ;:
+echo 1 >> tracing_on
+
+echo aaa > /tmp/hoge
+echo bbb > /tmp/hoge
+echo ccc > /tmp/hoge
+rm /tmp/hoge
+
+:;: "Check trace results" ;:
+cat trace | grep watch
+
+:;: "Ensure wprobe becomes disabled again" ;:
+cat events/wprobes/watch/enable | grep 0
+
+:;: "Remove wprobe triggers" ;:
+echo '!set_wprobe:watch:dentry' >> events/fprobes/truncate/trigger
+echo '!clear_wprobe:watch' >> events/fprobes/dentry_kill/trigger
+! grep ^set_wprobe events/fprobes/truncate/trigger
+! grep ^clear_wprobe events/fprobes/dentry_kill/trigger
+
+exit 0

