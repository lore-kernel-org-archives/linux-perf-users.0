Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D591D798E;
	Tue, 23 Sep 2025 01:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758590297; cv=none; b=GNi5ZQ79DYNr6q6kmrOLIQHuoC1bfhRABPtjWL1b6aoLhawVAJOin3omCAEM7wx2yzy+oVVB/q7GxevNJQ+Jxu7l24bG/30AP/RdWwcsxrPzI5XV2kVuRCptK1k9nfmyEHT9hCcs4ZHTj4XWH4D9GGWswwf6F0DAtTWb+RQz86s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758590297; c=relaxed/simple;
	bh=yWrgfH6o6tBojpygb/3hwUZPMazgwgCEKyJzb90YtAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lpoyQcRAMFo/Qu/zvHQVOshE5m7Cye9rFscJJlgBR6MAfAgF9k6sRtLembTkedTuyhALugWuxkZH7UJhphf2I78V80q66SLc5k+UkfGHlJuIGadYO/YdZAIUb0AovrFcT8x9V8g7sbkcHQ3ylCnrGsifWn0zwRbLtoWoJh6QCS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKZGvtEC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKZGvtEC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510D4C4CEF0;
	Tue, 23 Sep 2025 01:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758590296;
	bh=yWrgfH6o6tBojpygb/3hwUZPMazgwgCEKyJzb90YtAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UKZGvtECgMz333UnPKEQKvTJc3iuycFS/3PpSOaVp/zNr60F7bywnA4nIdc2YmrCa
	 5LULhTFJsVfuuvGwyKZfN8hulyl3gwr4/NSTdoWf/W2aJTiSEivCs+ViQCkXspF2w1
	 8bjmqx7i/QLOjJQO31bA1HTzfi768lMz8CafthFsiWW7ytzUSXTOypfocXnsJFF1OC
	 ErXxERsnYge+aWE+K5Pox+Tu90aFIsyKQMYygK3pj3WTZb14z7XbcdJ65zqf2dvshh
	 eqIM6UP+aogJTLxY6P7whl1DCmAgJeoPtgRHvvgmhJTSMRpw6KkjsUEroF8dTDWj4A
	 l/z+ns0CCVCag==
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
Subject: [PATCH v5 8/8] selftests: ftrace: Add wprobe trigger testcase
Date: Tue, 23 Sep 2025 10:18:09 +0900
Message-ID: <175859028948.374439.13079482023691271097.stgit@devnote2>
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

