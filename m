Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE702F6931;
	Wed, 22 Jul 2026 23:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784761461; cv=none; b=OxazTs+jKIb/NYvVLGK/FJm3Q8QWO6igd6/Bz8Ql6UlBd+S6SjJV/eC+klRTUwSWcinhTVbV4+KJYRytvI5344SBSIz7o/RBkQsLN9EFMB0ENR03msVXRAvRdAkoljuMj9/OQ6dyJ7upwVvaSdu9sy4coAoSIrII2weE9LY45mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784761461; c=relaxed/simple;
	bh=czg/9d+D847aI9xV8AclvcAnNwtePW+A4Kp7ItsErfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f8YQ25IDH23vi/176cfZuliy1xoSgULcqpnWpgHkzdZzYWNQWpheLZ86E9oZ0w3x6IdYbElQ/2YN4htVRFx4XumsBV193p8a47si8/apACjO4xPscpZ8FewttM+WdyTkw2OwqDbU0uGnLwQIFTslFOe55+tzMCx1VeQFRo1WnjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPCYk6bv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPCYk6bv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4591F000E9;
	Wed, 22 Jul 2026 23:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784761459;
	bh=IXNNT+2caPXqZF2SGll0FRjuXEGwWvzO8xCQh5lGDKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GPCYk6bv7hQqMStlA9+iOfUxgofxdikzckI68/PNJeKWLbs8MvDf+AjgkvFnWEbVw
	 9UY5cgROYvw0PFwyKRpwQ1kVZGfz9TshGBbsIBBUzka4zy1Q0WbUNyxXY0CGZoldNt
	 YQ5DUCxL/hizZeLmaN3fVJ/woVY7vM0Z/m3xiQSKSFClI9++Lxeaw0ArJbDva0Ntnw
	 EXhRcOsHMY0GaNA/s3KNfj6Qazum7BhxwrEvXJdjxfG1wxvRmRRrXoWT/rm+lXR1ZN
	 dq+0iOSCh7OVmEBznAIMXtBr89CfVLYDuga9YBnREa0w/bPFjbNaVxZ2sADDC2/v4A
	 vSu0qeaipxB5w==
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
Subject: [PATCH v10 09/11] selftests: ftrace: Add wprobe trigger testcase
Date: Thu, 23 Jul 2026 08:04:13 +0900
Message-ID: <178476145365.26117.17416572855784144092.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178476134787.26117.10094977293012760490.stgit@devnote2>
References: <178476134787.26117.10094977293012760490.stgit@devnote2>
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
 Changes in v9:
  - Drop dentry cache after removing tempfile for on-disk
    filesystem.
 Changes in v8:
  - Use TMPDIR for making a test file.
  - Ensure the fprobe and target functions exists, if not, exit
    with UNRESOLVED (== skip).
 Changes in v7:
  - Add a newline at the end of file.(style fix)
  - Use dentry_kill instead of __dentry_kill.
 Changes in v5:
  - Enable CONFIG_WPROBE_TRIGGERS in the config for ftrace test.
 Changes in v3:
  - Newly added.
---
 tools/testing/selftests/ftrace/config              |    1 
 .../ftrace/test.d/trigger/trigger-wprobe.tc        |   70 ++++++++++++++++++++
 2 files changed, 71 insertions(+)
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
index 000000000000..0634259e2c65
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe.tc
@@ -0,0 +1,70 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: event trigger - test wprobe trigger
+# requires: dynamic_events "w[:[<group>/][<event>]] [r|w|rw]@<addr>[:<len>]":README events/sched/sched_process_fork/trigger
+
+echo 0 > tracing_on
+rm -f $TMPDIR/hoge
+
+:;: "Add a wprobe event used by trigger" ;:
+echo 'w:watch rw@0:8 address=$addr value=+0($addr)' > dynamic_events
+
+# we will skip this test if fprobe is not supported.
+if ! grep -Fq "f[:[<group>/][<event>]] <func-name>[%return] [<args>]" README; then
+    echo "UNRESOLVED: fprobe is not supported"
+    exit_unresolved
+fi
+
+# we will skip this test if the target function does not exist.
+if ! grep -wq "do_truncate" /proc/kallsyms; then
+    echo "UNRESOLVED: do_truncate not found"
+    exit_unresolved
+fi
+if ! grep -wq "dentry_kill" /proc/kallsyms; then
+    echo "UNRESOLVED: dentry_kill not found"
+    exit_unresolved
+fi
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
+echo aaa > $TMPDIR/hoge
+echo bbb > $TMPDIR/hoge
+echo ccc > $TMPDIR/hoge
+rm $TMPDIR/hoge
+
+:;: "Drop dentry caches (for dentry_kill)" ;:
+# Use append (>>) to avoid calling do_truncate again.
+sync && echo 2 >> /proc/sys/vm/drop_caches
+
+:;: "Check trace results" ;:
+cat trace | grep watch
+
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

