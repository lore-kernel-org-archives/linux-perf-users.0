Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4ED40F741;
	Wed, 22 Jul 2026 23:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784761402; cv=none; b=Z6ECrlFiPZT4llgwPl61WGHnHPvMU1W/vb8jRIsElelX5eUsVJqZryVHtIAUfCA1Gf8N47DphyNkLUHRZIHASRDUA3dHnj7+aJfP5coEYgYQC9S92xdrZHYj0oFqmspWmdbP9zn+C1L5nyroXdYkFj74VGakKVR013gQLtYb2/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784761402; c=relaxed/simple;
	bh=/GDpLwCp6U1Ku9QJ2Bw/kiCwGNM1+f60U5r2L5O74b4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a8ac3XxmfR0NwMuQGzGAa+3VC4P58yFOkXuFtrfR8IkJLuRdRSJ5gFRBzGFKUftnHaqPnOw5NFF2EkSxR1ZuavgI2FZfGbeHMlmTedvFKUGd8yKhV2CNflO5SDJ+iKEeNZ//K7bAcIsegPRKJP7dcIkaUX/3Mac1NXogjHhtHXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5mFqg/x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5mFqg/x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49DD81F000E9;
	Wed, 22 Jul 2026 23:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784761401;
	bh=2GPvDkPlcGd0G2tgY251xb8gLbxa/1LKbQFbwC9Otko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a5mFqg/xezxe9wywBEUpSypEH+95XGjW0Yv3MUIYdFoDMOQ85RpUwTcF7macZM/do
	 zzJzsygtElVPNgbxQaTnuIhOqGDODMTu79taTHf2G7qVZrnPM9N+mf2yh7RdkMyIh0
	 JrutV9j7QbZHqHv3VCrIGTIknU3Hy7HzE5grQcPoRpxrdkde6Jx/PsKBFtJ3uCSxFP
	 aXYbB/mfZvD0AvBp/lta+souKOz48RKnTWq57U2MLE3LFSdAzhdgFskVKq/g6ql+LE
	 9kdxHX0nChz3wTZZS9w8i2inFmqDVBPCJ6/1Uf5Luj8321ntJ2dSqc9DNYPpwk4Tnr
	 ox1C9TJbDkgOg==
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
Subject: [PATCH v10 04/11] selftests: tracing: Add syntax testcase for wprobe
Date: Thu, 23 Jul 2026 08:03:14 +0900
Message-ID: <178476139478.26117.5732496077126807233.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178476134787.26117.10094977293012760490.stgit@devnote2>
References: <178476134787.26117.10094977293012760490.stgit@devnote2>
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

