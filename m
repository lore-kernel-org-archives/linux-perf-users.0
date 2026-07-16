Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8442AE8D;
	Thu, 16 Jul 2026 02:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784170373; cv=none; b=A6G6xdyzh+cwtVIuEhcY9vIUpfPX1JZAqs0RGnrxfcokhdh5HXBEJLC6s4lcKQy7NfdnKWcvO44xqDw+8wQJop1eTwjTIXeoNlAHdE9KwX85dHGU5rAo3G8u68m+wPBMxvO9y6MGUCBWcWcGEQr3OANIhioFMlKiTe2B/t5fnkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784170373; c=relaxed/simple;
	bh=i/WSzwHQ8ihS65wmoBRcp/ZvnZ3KnJqyA0MA3Bj5QUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q0k6YAovbaEnne2omAySdBONSetZEBDpaSobJT19CaM3kDDQKwKVRjiieTlwlTFy1IcloTgwLFlNl7ZhrXuWZBZLrHt0Iecn4vA/vBoyFpjgljJvBn/JRNXLW307JnWPgYZCkDIl6J7CV0ZYnbNketDDfEavdnYFw1R5u01VdEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipinfB9N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipinfB9N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15B21F000E9;
	Thu, 16 Jul 2026 02:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784170371;
	bh=8rr8PZkjYXw50rlscdjz0lwvKSKWgfaKffWFM5e+qQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ipinfB9NQNM5I1qLkHNo1GUYYi6MCc02LwF5zNiZASuESyzAtBpu4IK9wDBUeZFCl
	 rByoqv7ahT6RijsPbj3Bm3FerVInMknOqz+dodJI9VrFXSIYPeoTx2bNsCqoyZsGZn
	 BO3cZ1BfKgsZ8fDc275spiJckF6IyOIVxbzKj84QvaNfonfDbEBEQRj7Dr84QSCe0r
	 R/mdW2gUNTkIrkWhrbwsqJuh7n+8d3sb6q2lVf5TuZKHMNuhhyV2RDGCEkvQ+KiBYx
	 iSW4H25XH3jLH2cKhWHHmfuHDnlsg0U3gDMvTKYk6Nl05dvBpvpXuD7tpBraVb7I0i
	 nngclEmAKu6xQ==
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
Subject: [PATCH v8 3/9] selftests: tracing: Add a basic testcase for wprobe
Date: Thu, 16 Jul 2026 11:52:45 +0900
Message-ID: <178417036552.209165.10709545532621528052.stgit@devnote2>
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

Add 'add_remove_wprobe.tc' testcase for testing wprobe event that
tests adding and removing operations of the wprobe event.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v8:
  - Fixed silently test failure path.
---
 tools/testing/selftests/ftrace/config              |    1 
 .../ftrace/test.d/dynevent/add_remove_wprobe.tc    |   69 ++++++++++++++++++++
 2 files changed, 70 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_wprobe.tc

diff --git a/tools/testing/selftests/ftrace/config b/tools/testing/selftests/ftrace/config
index 544de0db5f58..d2f503722020 100644
--- a/tools/testing/selftests/ftrace/config
+++ b/tools/testing/selftests/ftrace/config
@@ -27,3 +27,4 @@ CONFIG_STACK_TRACER=y
 CONFIG_TRACER_SNAPSHOT=y
 CONFIG_UPROBES=y
 CONFIG_UPROBE_EVENTS=y
+CONFIG_WPROBE_EVENTS=y
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_wprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_wprobe.tc
new file mode 100644
index 000000000000..5ddf28ddd2c4
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_wprobe.tc
@@ -0,0 +1,69 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Generic dynamic event - add/remove wprobe events
+# requires: dynamic_events "w[:[<group>/][<event>]] [r|w|rw]@<addr>[:<len>]":README
+
+echo 0 > events/enable
+echo > dynamic_events
+
+# Use jiffies as a variable that is frequently written to.
+TARGET=jiffies
+
+echo "w:my_wprobe w@$TARGET" >> dynamic_events
+
+grep -q my_wprobe dynamic_events
+if [ $? -ne 0 ]; then
+    echo "Failed to create wprobe event"
+    exit_fail
+fi
+
+test -d events/wprobes/my_wprobe
+if [ $? -ne 0 ]; then
+    echo "Failed to create wprobe event directory"
+    exit_fail
+fi
+
+echo 1 > events/wprobes/my_wprobe/enable
+
+# Check if the event is enabled
+cat events/wprobes/my_wprobe/enable | grep -q 1
+if [ $? -ne 0 ]; then
+    echo "Failed to enable wprobe event"
+    exit_fail
+fi
+
+# Let some time pass to trigger the breakpoint
+sleep 1
+
+# Check if we got any trace output
+if ! grep -q my_wprobe trace; then
+    echo "wprobe event was not triggered"
+    exit_fail
+fi
+
+echo 0 > events/wprobes/my_wprobe/enable
+
+# Check if the event is disabled
+cat events/wprobes/my_wprobe/enable | grep -q 0
+if [ $? -ne 0 ]; then
+    echo "Failed to disable wprobe event"
+    exit_fail
+fi
+
+echo "-:my_wprobe" >> dynamic_events
+
+! grep -q my_wprobe dynamic_events
+if [ $? -ne 0 ]; then
+    echo "Failed to remove wprobe event"
+    exit_fail
+fi
+
+! test -d events/wprobes/my_wprobe
+if [ $? -ne 0 ]; then
+    echo "Failed to remove wprobe event directory"
+    exit_fail
+fi
+
+clear_trace
+
+exit 0

