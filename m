Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194333B4EA3;
	Sun, 30 Aug 2026 14:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788100135; cv=none; b=bkf1ZN+H29Rm6oq6GdBs3VuiYG+J5oKOyoupGjmW8DKCiyYa0dS48s/Pb1ubDi5ZvDMizb3vA2Gj9PrilEm7CEDBns8nH4r9E+K/ybcX8pIANHzipIMQ40AFM+tvl2G2YurMcwDdCWV4zdUmeA4LUhHUMo6O7hsuDQSJfcWLEiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788100135; c=relaxed/simple;
	bh=w/fxHVNtA+8suk/aVIjfFU697JVRJgCgDhdycK2gkzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LWw4ebu/3LbSvNcfKIysfAvJPGSDk4jip6pwFramGKLmN2pKNOKbcxqVs+KG+vt4ofo1CVOv20tMCxGaPP6LJPcd+S3qxl7SgvhidcLCRctu0+mS/2nwKmSH9PhHnVLRkXdgry0AsRhLuM3Ab42czHbu3WXAVCbNZ40aSuTa9jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYU3Y53J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYU3Y53J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6718B1F000E9;
	Sun, 30 Aug 2026 14:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788100127;
	bh=o0qMmOfhKF4hfQTENoYGXCxXEOkOcEeucQ2rUqmquDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oYU3Y53JPq2g3bQbKNq/25M5b2xPo/WrtfOhBXu4BdMQkf7MWSaxS12915eDM/Lau
	 Ux7cxU0l3vQk83ER6qtVN04/GnVYl6Rp9KTi4F/T9Ys5NjeX+vaiR0+C2pPmHCEVEe
	 RRWLeCXqo+GaF7JTCUJkdGEEXehC0ocxNos3/t+RbZw8YOzPYpxaV8qeXpapTs3ij/
	 e1Np4UOtVfgyCitT9flXYLipAqKDRzl019q62105kgJctjMWFYwkR040GeJpyGMwa7
	 WTnBlB4wjB1L9qUBoApEQkzQMChi9Iqg82eJ+DvitGQhAVtKtNHDfK9WYII4jxMOKe
	 VBSUwMd9ZeBVw==
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
Subject: [PATCH v14 10/14] selftests: tracing: Add syntax testcase for wprobe
Date: Sun, 30 Aug 2026 23:28:41 +0900
Message-ID: <178810012113.64882.5058142196886031547.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178810001186.64882.2161016469449127450.stgit@devnote2>
References: <178810001186.64882.2161016469449127450.stgit@devnote2>
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
Changes in v14:
 - Update comment for invalid offset syntax check to BAD_PROBE_ADDR.
 - Add testcase for invalid address 0 error check (BAD_ACCESS_ADDR).
Changes in v12:
 - Add NO_ARG_BODY error case.
Changes in v11:
 - Add WPROBE_NO_MAXACT syntax error case.
---
 .../test.d/dynevent/wprobes_syntax_errors.tc       |   23 ++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/wprobes_syntax_errors.tc

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/wprobes_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/wprobes_syntax_errors.tc
new file mode 100644
index 000000000000..e0df58fe7aa3
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/wprobes_syntax_errors.tc
@@ -0,0 +1,23 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Watch probe event parser error log check
+# requires: dynamic_events "w[:[<group>/][<event>]] [r|w|rw]@<addr>[:<len>]":README
+
+check_error() { # command-with-error-pos-by-^
+    ftrace_errlog_check 'wprobe' "$1" 'dynamic_events'
+}
+
+check_error '^w'			# NO_ARG_BODY
+check_error 'w^10 w@jiffies'		# WPROBE_NO_MAXACT
+check_error 'w ^symbol'			# BAD_ACCESS_FMT
+check_error 'w ^a@symbol'		# BAD_ACCESS_TYPE
+check_error 'w w@^symbol'		# BAD_ACCESS_ADDR
+check_error 'w w@^0:4'			# BAD_ACCESS_ADDR
+check_error 'w w@jiffies^+offset'	# BAD_PROBE_ADDR
+check_error 'w w@jiffies:^100'		# BAD_ACCESS_LEN
+check_error 'w w@jiffies ^$arg1'	# BAD_VAR
+check_error 'w w@jiffies ^$retval'	# BAD_VAR
+check_error 'w w@jiffies ^$stack'	# BAD_VAR
+check_error 'w w@jiffies ^%ax'		# BAD_VAR
+
+exit 0

