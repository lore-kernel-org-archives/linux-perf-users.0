Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2622F1A5BBF;
	Thu, 11 Sep 2025 00:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757551414; cv=none; b=U8F6LwfnyttE/l+P2pFdSykMKxsrd5PATFOwrh3caxBaMa0j9P0L/2XcOZ/D82k3F10ryAIbpptzRAN+lsRafX+f1Zq1G0cW895tNoA0FHwT6fuYL9hnUyce8q3RaE0S3wRDcLkcbhdBCgS9lUAm5i08VF99BhtCgYHpx5CZ9bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757551414; c=relaxed/simple;
	bh=reVuS9zhTFmkX8jA2nOh2kSTCPa25rqxfdxv2B2YT/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EmXPJSCA4kv/Zi0zGqL3GEybaUgyokFoCLESY5c5mQ+agR5NaN+cudotUlfAB4K3efpv6jUcmeUFxpUcLQ6Ua57Vw3N5brFy55rCJNX+ymL2ZZrRZpFs5oHVF8B3FqBIgfeW6aZzfcKemg6+EaXhEa8e0T/RuaFoqe2D3+ZOi1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMj1ErZD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMj1ErZD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA87AC4CEF8;
	Thu, 11 Sep 2025 00:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757551413;
	bh=reVuS9zhTFmkX8jA2nOh2kSTCPa25rqxfdxv2B2YT/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mMj1ErZDYMrUAbiVv2v/TtrB/uj/pbMRualwLOD4m0MRP3yEkcsmjDKckEGiV7IBh
	 drxorM2WBbqq3rKPxfTskrbDcXni0m05i554Mvp06gmjTFPhAk/0u2SG6OrYMUrsep
	 5aGxc08KTzRfOeA1DU7tNLWUIRzHixf6DQxppbeAzis2trg9mNTw+m4VC3z+1VWNQP
	 IcMOxoM/qqDiV9qVvYwb7TEpNHsQ9h7RDFl0+6E42TVA958IlefmzQVys0/JF56DSj
	 aCiqAGXZzS3jgnvK6PYk3npbIfUOOv1emP63Gh9ZAKD4tQTSr831A9V2exlgzzYNuh
	 cKj6pxjpS4G7A==
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
Subject: [PATCH v3 5/7] selftests: tracing: Add a basic testcase for wprobe
Date: Thu, 11 Sep 2025 09:43:27 +0900
Message-ID: <175755140737.153203.1335190638803609179.stgit@devnote2>
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

