Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5365E2DC79E;
	Sun, 14 Sep 2025 14:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757859069; cv=none; b=ketxIoZBFcdqCz5hlukHO4G4/niGKXF97c8aEbU1UijP4jQO1yeFuXa+Rt9Ryv1d54IkJXklxjF6+ZnTBAR4Yx1SL8Lqd0wSoVf2nYLipcCCPlvKgjXwzNPuCRnQuVCEIFw6Tm8VjTYupcgsWWVvTSoigHa/tFswcIl61FdaNnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757859069; c=relaxed/simple;
	bh=m69jGOlntb9/ZRVib7FhJd3yxy+9Df6z1XbbJ40c8VI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IoWwRCCQEr9jXVHfrrTPm4MF750D836Bbbi8Ej+Rm/DUWF6STY12XOS3763sf4OThYdo+cn3QfvhX3kU8x0k3preIYLlECwmIVUVBYTQ9ObLQvfDeM05ZJg0gN4g3sFEuna+ZjbR064QSJSaJgWCO1/MttSWYidmt7B0pDqbAHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diHKnLdt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diHKnLdt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57760C4CEF0;
	Sun, 14 Sep 2025 14:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757859068;
	bh=m69jGOlntb9/ZRVib7FhJd3yxy+9Df6z1XbbJ40c8VI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=diHKnLdtPdYzNPDUbrrZw8v7p5946f9O7we6PoAzqBo+N033LxL6tW8KzS8S+qzjF
	 JMAWMuhvuUqvLqqnCVTHQR9WLzt115QnuG1hd+rNsbcTjhfnJCw+svqtUM4uAFF+UG
	 3gimHHGfOCIUkZGj33soecqBB39mwXWbXXlJF3H4Gz6DvfkrMKvMubGXEGiYhuNj7m
	 BGHyHJW/bU//ceHvI5Guf7ddMesOpCa/EJorZ1lZk6Ht51GLCjbKBtOzO93iw8GuwJ
	 JF7jiaDaOy8BlRsZxIgHwKxQcemZDH+uuzu9cgyAXrfc5r22wAQPBMhbqIsCr1Xvsp
	 61m5Br666yKOQ==
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
Subject: [PATCH v4 8/8] selftests: ftrace: Add wprobe trigger testcase
Date: Sun, 14 Sep 2025 23:11:03 +0900
Message-ID: <175785906300.234168.2360997300021717365.stgit@devnote2>
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

Add a testcase for checking wprobe trigger. This sets set_wprobe and
clear_wprobe triggers on fprobe events to watch dentry access.
So this depends on both wprobe and fprobe.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
  - Newly added.
---
 .../ftrace/test.d/trigger/trigger-wprobe.tc        |   48 ++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe.tc

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

