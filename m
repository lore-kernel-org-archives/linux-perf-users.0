Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD2C1DB34C;
	Sun, 14 Sep 2025 14:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757859047; cv=none; b=u4PMxTd9YObkIqT34B82q/I+FuNSdKP4g44gcX6Yls27OaFFNmqZ3XibZPDziFUgMcUnGTKv/cRZyc/3zOAca0Zma1Pl532ucKjp3uFINb4ap9BYK/uuaZbvBCoskXdFG1H8bfqoYaZm05KgA/pTrkKveSy1vFMwFhL5tNL0yvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757859047; c=relaxed/simple;
	bh=reVuS9zhTFmkX8jA2nOh2kSTCPa25rqxfdxv2B2YT/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MTzXEWtmEc37wAzAJR0w2KoRJuGneeJ0H0oryTkzMHSDmY3P7kB+2pt4n+pbmEOayL/DzyOZ9IdYlROABWz8h+vurEoNBV38G78CAL9XLKnaqFrNlqTWceDKx3dygxIQSf/oJW665J5rCNlMjh5WSfE48iamDRojUlpw4sb9zP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9Aq15L+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9Aq15L+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73CEC4CEF5;
	Sun, 14 Sep 2025 14:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757859047;
	bh=reVuS9zhTFmkX8jA2nOh2kSTCPa25rqxfdxv2B2YT/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e9Aq15L+zcY7byHJ+D1Vq82cWjPcn2RrLIx8UlDucJ1aoh/ds4c+xkgMnMtkwiGOu
	 wFQ15Cdbw+8BguNrFPO90lLd/7yyJ/J4CuGh3c/nB3MhweiQFI3dKFNLLBM8JMGaBK
	 xHR0bQBzrqogRZXnTtaBRWJs7UWufy5BFRnvworYlX62NaJJuU3Nf3VxBuMEHWqpz3
	 rZtyOZu364vFNZt7r6bEFg/5f7uywD/IRM/Y4BXMcYhiluw/4XsPLMykWLxU+rPADz
	 NDu10TT0LnEJ2YtcolsG4jh7QzdZx1+NUITzOSadKxTUySsNJpQnfQliSN+v56+c8k
	 u9didFbG7Ua2Q==
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
Subject: [PATCH v4 6/8] selftests: tracing: Add a basic testcase for wprobe
Date: Sun, 14 Sep 2025 23:10:41 +0900
Message-ID: <175785904139.234168.15542340470028767790.stgit@devnote2>
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

Add 'add_remove_wprobe.tc' testcase for testing wprobe event that
tests adding and removing operations of the wprobe event.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../ftrace/test.d/dynevent/add_remove_wprobe.tc    |   68 ++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_wprobe.tc

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_wprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_wprobe.tc
new file mode 100644
index 000000000000..20774c7f69f8
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_wprobe.tc
@@ -0,0 +1,68 @@
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
+if !grep -q my_wprobe trace; then
+    echo "wprobe event was not triggered"
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

