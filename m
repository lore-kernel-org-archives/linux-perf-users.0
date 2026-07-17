Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA53B3FB7DE;
	Fri, 17 Jul 2026 14:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784298024; cv=none; b=p8VQg5KW7g+kfUkrL+Jx+hspmGdffOsFZbFln+3e/97+/qTqjA6ylJNPn0xbU8PuODGOB9aprqOcDVJqVluMf3wz3UO+dStQvFeQ3c4Ih7vmvNM8hjhjyibWp2NQBT4wsodiSh605RHO0X+NBu1o7DgcC7aVBTDM4lAjpOfK8i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784298024; c=relaxed/simple;
	bh=/GDpLwCp6U1Ku9QJ2Bw/kiCwGNM1+f60U5r2L5O74b4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LD+s391W6bwlxdpZdMmJRzdJEfZwXptxxSRlkq7rolQ+3csgd2OXqTJN2HSj+G+WuIHBOzTZjGuQZ0Uhn20dvDdvRbnAdKoaXZaCNoeXzwZepUgp+lnz8mFUXQBRJUibrdlDqKM3ZM1RKiXwSwDrZqpL3BRjK5s1ZBs38EPm/+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XButz61n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XButz61n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62AB31F000E9;
	Fri, 17 Jul 2026 14:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784298023;
	bh=2GPvDkPlcGd0G2tgY251xb8gLbxa/1LKbQFbwC9Otko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XButz61nRjCvO/n0jZQpAVDDU10DQIbOoISQEgLNWFbquU8NG2eV4r9ljpGnGZClO
	 v6nTwR+rfHh78bvOW8YVrRdx+Z+E64zk2mUj/mFv3ue2rlOZx3mIQWsxVl7t7s7uOT
	 WbJojdG1VUCyEZ/omPxV/xEV9RUKeHXqQjI1qLbtvqeFe7eBf6z5dCnKUqeJPvzoF/
	 ItqZoh42ZdeOzRfvADZyPfD9cZa79uiNbrhcHDoqrwG+TB+S6gf+IY9KN7U9ebKC1D
	 fqNV4NIMOdjVNmR3nTcpOTJQwJ9uuI7CEBfOSarX9Vfk0o+8nJou8QyjIY7lvwTpZF
	 jU2O/djDfIF2w==
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
Subject: [PATCH v9 04/10] selftests: tracing: Add syntax testcase for wprobe
Date: Fri, 17 Jul 2026 23:20:17 +0900
Message-ID: <178429801706.157981.6651912401461436303.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178429796992.157981.3393977217853767915.stgit@devnote2>
References: <178429796992.157981.3393977217853767915.stgit@devnote2>
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

