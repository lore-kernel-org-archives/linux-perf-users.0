Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304181B87E8;
	Thu, 11 Sep 2025 00:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757551437; cv=none; b=uNOeWUgT6iHSWdfngxiUdr1hZ0ZHNDO+eoPNULzomV+ooOKKhFYIZeRnu0gm7vYFVSsytkRXoLqePZyIW0Hf36CtGPq9G1pk5xvI9oR/i5uH6DE3pMGEqDbClntdU59FsXY0fFyBI1cckl8+b1EQjrBEjR6UWo5cw4gd1YFNt8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757551437; c=relaxed/simple;
	bh=m69jGOlntb9/ZRVib7FhJd3yxy+9Df6z1XbbJ40c8VI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=evSEzISB4B2N/e2GdrRzUJeSu+7TSwhVB3ZsG8Gzez6DHFbSHRSE3iaBkNcHmuQ2H7aNYmOUxOdqrWLQ0eV/XSGpBByoitSOGjbsl2GDnyt62Vodzc2qy5qd3r2/WckmEbMWpn7r7LM1ARp2hwi5yAquh8Lpftq9Lhx6Y4IjPTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIW34KYT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIW34KYT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B39DC4CEEB;
	Thu, 11 Sep 2025 00:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757551437;
	bh=m69jGOlntb9/ZRVib7FhJd3yxy+9Df6z1XbbJ40c8VI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vIW34KYT06pHPAj2FOhAqv0Nx94bpHPOnJY6/xKIK4hQdPm9UA8oXeXYlOh5JPsyu
	 T0/Ycqo0F7jyugKr2k0to8Cvcq7SxE/dQZjKnoCqHHb7fS43XCRXKviX1BLKNamUyP
	 MtCbP06sGeIF9AcLZfcTEUcOD3uz0bLD/LNbhwhOH+2CtHIYIzo3YoIt1HzvC+djcI
	 /eY1ZOtrvh8eia78hFTgXyeOqE4kQQfmwIXdO8s8w1bn2jETMuntrdatgmCUsb++dE
	 qLFJ6AlX9CTCYNIKwIilBcYofgGo3Ptafzfq+S2jnoNnQnCsKuBWAe8k1Cks8Lf5qd
	 nmscdJSMH26WQ==
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
Subject: [PATCH v3 7/7] selftests: ftrace: Add wprobe trigger testcase
Date: Thu, 11 Sep 2025 09:43:50 +0900
Message-ID: <175755143081.153203.6292299604126182907.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <175755135002.153203.324836519360617091.stgit@devnote2>
References: <175755135002.153203.324836519360617091.stgit@devnote2>
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

