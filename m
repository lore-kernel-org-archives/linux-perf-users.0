Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD26823BCF7;
	Wed, 28 Jan 2026 14:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769609468; cv=none; b=HEOjLsmrGC4vFuruEhI/raFZ8uWKYHkf/uFeDIpHzg7AXKZ6jeiNpEJJWazqC08qP5tqWAZRkJgB1oIwshb/sVpAtSAq28fn9owF+WMHCiwxK9uooKQWyH7HHNOzxeiHBzs5A1JZHPyh6MKwwnqVW67jwcQ5Ir5LriF92DuDIbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769609468; c=relaxed/simple;
	bh=yWrgfH6o6tBojpygb/3hwUZPMazgwgCEKyJzb90YtAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cJFhilBS0w8OZUiFM21+TJ/molS3xcVxedytVp/FtFNEdOcijFl1V8ac03+RDqyRR6x8inesTkYRomfXEVgoE2WcZg8mG7W7Ee/tMP9I5x7EMx4uQFfbUFUiRHTBs8yk6HRXNWoq3mjXLDfP/9OlUVABOeaRdPwGyB1VaIlG34w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Do9ekvyP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Do9ekvyP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDA2C4CEF1;
	Wed, 28 Jan 2026 14:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769609468;
	bh=yWrgfH6o6tBojpygb/3hwUZPMazgwgCEKyJzb90YtAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Do9ekvyPPRR+MUe8JFC7mtz4WDI25l3g4kCbWKpqWUTxN1BN1l6tGaoNfnJnddSHQ
	 nVoREhI0BQvBJDNo9y8GVTtIouS9Bc/M/M8b1/zhqn+4+1HWj67MirSljh/Fizk4y5
	 xU0fukBPOVxK8Kje/Yb2q6MliloylkKMf4ndeXu+m2JXMfrcwRiLuhcVQjskXNJqkF
	 ILfkK0zNTvREJVMZFx3WosFcSUOAOJ042vrL4uBaZfc9/2FMyxBLsTxXAiANqmCjzN
	 XHXs5oeKYQoUymM3BDusLWmdMwaB1wiaz6bnFgMretADIfW2pxU2XFrp+Pvy9MjFcj
	 snNBDQqkz5tvg==
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
Subject: [PATCH v6 11/11] selftests: ftrace: Add wprobe trigger testcase
Date: Wed, 28 Jan 2026 23:11:02 +0900
Message-ID: <176960946223.182525.2450061066358568551.stgit@devnote2>
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

Add a testcase for checking wprobe trigger. This sets set_wprobe and
clear_wprobe triggers on fprobe events to watch dentry access.
So this depends on both wprobe and fprobe.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
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
index 000000000000..a012f7b92405
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
+echo 'f:dentry_kill __dentry_kill dentry=$arg1' >> dynamic_events
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
\ No newline at end of file

