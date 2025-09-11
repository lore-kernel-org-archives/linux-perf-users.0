Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A201A0BFA;
	Thu, 11 Sep 2025 00:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757551426; cv=none; b=QcC2v43+mvx7IvQvZWwUHeZ1AxI1KbxlEvIHgZS14ydYnqYsGIyJIYMwxrD2J3KxFGXdv8tLLyfF1aATwhyfW5A7Vn6Fj458xvnFzpPXE0pFK/AHtGiGth8+hzm9YXOATFR+hjviQIbsLEHdUwbh7QizQKFXSvkUUspQO/MKwt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757551426; c=relaxed/simple;
	bh=V1sZe++I+DX8D0azwJCk2OhQOYC8K8WNEARBLQqqCJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=txgYeWMgt2K1VnaBS0ahLWcQA4GqNU5EHPL4a1O8SUOFnD1edM7dEqfAJCkJw7Hq0BylrqH1q9xJrTeMenCXIvdqmXSRr15TuzFUSeKzFaf/enej0AQV6OfNPBWErvmLyhbAcMIuRdiPkQQ04gTMdRM8ZFdEbpZbppjDmV1nudg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pfW5dBYT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pfW5dBYT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 944B0C4CEEB;
	Thu, 11 Sep 2025 00:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757551425;
	bh=V1sZe++I+DX8D0azwJCk2OhQOYC8K8WNEARBLQqqCJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pfW5dBYTkJfNoHwY1shCQc04X9qc3mEENdsEpY1BR7aGMEvShkF/LblraRVHCZCiY
	 yZW3nBCHRhOoeChQwbAJSj8rZVl41AfoXoP3sgP/ziUbO7vWnZmioyQLFMeViKOE3p
	 s2SdqJlyR1FDozLFuDm6DdtGMWgFHFWYq5fOwnH2gaPZGQbwkMF9yan46OBMU3Y3gH
	 iYRcYMULG1ZKHid8cCscqGCzkM04S15DnckhX6Y7lG4mJtluzOUZb/a+P4A8qBKMgp
	 ytC6wGR4vcnpvWCNWMum3wp38smDb56pHr0GdQ0r+REUFSPEazH6yMsT26jXqYdcpi
	 0LXkcuBlUuVng==
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
Subject: [PATCH v3 6/7] selftests: tracing: Add syntax testcase for wprobe
Date: Thu, 11 Sep 2025 09:43:39 +0900
Message-ID: <175755141905.153203.17941292631870145067.stgit@devnote2>
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

Add "wprobe_syntax_errors.tc" testcase for testing syntax errors
of the watch probe events.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
  - Fix to use "wprobe" prefix for detecting error log.
  - Fix an error place with wrong offset.
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

