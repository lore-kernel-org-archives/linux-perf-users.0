Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5F4372060;
	Sun,  2 Aug 2026 08:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785658791; cv=none; b=KQEvLXRGNKS21vkz2uHIG6oa3uzrxCDrxeSSNFUF35DiB8/V4lFQqtnPk/V6SPtAYSXkSJVPc+wGtC8q3OuxMC6gP/QQNhIyJ6zAXwkM0ckR8xKxxOI0JpLjwbKTesMujeUvf0wJ9fanl/ZkRdAkVkCoX2DsRo/9pAR4UEmmHM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785658791; c=relaxed/simple;
	bh=gEgmSpStBMZorNeU4tZqjEjYmKuJkXWpgxUYlYZRTSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BebP7XGinPKlxLcPX3dR+o8kN/skDiLsax2fgqtPraTfmtNtC60PxPAgooamPPRPxQNNfKkcqJyh37p5KpSmHsLA/xDhRsJQT8YoRcDbPalIzIj+qxlRg6tx/jbHwSBToj9gOu+wJYD0Park0ae3DQ9PBnRmEvw4Mz4nBA1kuJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GBNYH10Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBNYH10Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD5591F00ACA;
	Sun,  2 Aug 2026 08:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785658790;
	bh=r5VSCYmjb1sSxE5B+t4GSEeK+I37cQkuG1xiJPIv+a0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GBNYH10ZMqRPJCMAlMJAv1Z2EVHm57x9Eg46Add14s5xrN5W044073bQPIxn0pUtv
	 xw6DWFT+RXjDs/sRnzh/mt4/ORWt370dzUfDfT9WjIfFIDitfoWyv+oJu0OgdqrTWa
	 ZuEK7cFe7280FHANQq/+EnQsJO9lmZYKyJ8x3qFpHasGiZWoUVvWHgX9r6F8udpRbU
	 y+Em8CUc1xwjx2ZkAcGQLrciYgIbDgOOwIhE2hxZYuWpwzqHkAVGMJiSFGAfB45MSc
	 RlOXXvvo+w2zE3GeBoni13DimXCPQBDNZDIAndA1PKjzUZNQo8ftXBxQPhM1nDWdJt
	 HonYBl5JmUVtA==
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
Subject: [PATCH v11 07/11] selftests: tracing: Add syntax testcase for wprobe
Date: Sun,  2 Aug 2026 17:19:44 +0900
Message-ID: <178565878464.714490.14020174891147519416.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178565870538.714490.11309825813968306287.stgit@devnote2>
References: <178565870538.714490.11309825813968306287.stgit@devnote2>
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
 Changes in v11:
  - Add WPROBE_NO_MAXACT syntax error case.
---
 .../test.d/dynevent/wprobes_syntax_errors.tc       |   21 ++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/wprobes_syntax_errors.tc

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/wprobes_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/wprobes_syntax_errors.tc
new file mode 100644
index 000000000000..9180b71001ec
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/wprobes_syntax_errors.tc
@@ -0,0 +1,21 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Watch probe event parser error log check
+# requires: dynamic_events "w[:[<group>/][<event>]] [r|w|rw]@<addr>[:<len>]":README
+
+check_error() { # command-with-error-pos-by-^
+    ftrace_errlog_check 'wprobe' "$1" 'dynamic_events'
+}
+
+check_error 'w^10 w@jiffies'		# WPROBE_NO_MAXACT
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

