Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA10312829;
	Mon,  1 Sep 2025 14:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756737946; cv=none; b=VK2kBkegb1e9uHGuw18ImrZHrCc1GchPK84Ye+PgimTHkynVBMXQmwN4r3N81clDV7rDDIippaNWGKUnfwrtY4GtZ5THKsVlYzGSAwcJBqEXxFPqJ2VZj/YVxNH/lHwOBDw7X5KLeDwILtLMvtkH8VQp3Jz+lGv6oDkfBUvOhOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756737946; c=relaxed/simple;
	bh=YmnJaLz0IT7+Cz6HPZlkjrX2bTrODXvTpLb48ZgINCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C+n755Gwe8boj41pS0hsmWOY0dCkOr7fpvFeEo7sOA47faXczYH1/YhlnuD8U/1I7WKJlKZm8KxZE7TiePiv9SH8AWSDbz792pG6gh8cHhMrG2AsV5Sxxkg1gCrHrvZW1Mmqkx3v7UhfPwO9ihv6A8+6p5zhlLbh5+lMtHTAzY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCuGXSHv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCuGXSHv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B034CC4CEF0;
	Mon,  1 Sep 2025 14:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756737946;
	bh=YmnJaLz0IT7+Cz6HPZlkjrX2bTrODXvTpLb48ZgINCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HCuGXSHvYAzt6neAHx0pqfdu7w7Q4WQL8pzQ2hvP0sDDYklnt4SybkM9yzVsk/l83
	 4+R74o9ETGWaT8uuM36uWqlNb2hDlUnqtcLNXSahPYY81cUQMEyIRCXa5ky9KgswJ9
	 TZ0/fQ51320iZtgNF5R8nW3/DZgtmGnoMTseeHdlHul53S58B4IZh1V0tDsrBhS7iC
	 80YmAzRJoQjQDA1gbocpvkJWDsw7T3Mdr+a1W7edKtr1FmDLSJmw33YcrPdp4qWZMU
	 gPIl0Wac6K+3Pi1LYAkoYaGykz8/vHIesyob5vRE2xuoNd14NUcLV/k5kzFeeRW2O5
	 EptlfmifWQmIg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	x86@kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
Subject: [RFC PATCH 6/6] selftests: tracing: Add syntax testcase for wprobe
Date: Mon,  1 Sep 2025 23:45:40 +0900
Message-ID: <175673794034.478080.9788390554653757444.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <175673787502.478080.3342912952394010967.stgit@devnote2>
References: <175673787502.478080.3342912952394010967.stgit@devnote2>
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
 .../test.d/dynevent/wprobes_syntax_errors.tc       |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/wprobes_syntax_errors.tc

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/wprobes_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/wprobes_syntax_errors.tc
new file mode 100644
index 000000000000..82a273d9efb4
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/wprobes_syntax_errors.tc
@@ -0,0 +1,20 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Watch probe event parser error log check
+# requires: dynamic_events "w[:[<group>/][<event>]] [r|w|rw]@<addr>[:<len>]":README
+
+check_error() { # command-with-error-pos-by-^
+    ftrace_errlog_check 'event_probe' "$1" 'dynamic_events'
+}
+
+check_error 'w ^symbol'			# BAD_ACCESS_FMT
+check_error 'w ^a@symbol'		# BAD_ACCESS_TYPE
+check_error 'w w@^symbol'		# BAD_ACCESS_ADDR
+check_error 'w w@^jiffies+offset'	# BAD_ACCESS_ADDR
+check_error 'w w@jiffies:^100'		# BAD_ACCESS_LEN
+check_error 'w w@jiffies ^$arg1'	# BAD_VAR
+check_error 'w w@jiffies ^$retval'	# BAD_VAR
+check_error 'w w@jiffies ^$stack'	# BAD_VAR
+check_error 'w w@jiffies ^%ax'		# BAD_VAR
+
+exit 0

