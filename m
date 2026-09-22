Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D4F3EB0FF;
	Tue, 22 Sep 2026 04:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790051199; cv=none; b=Avx+vSpG5ePUw2fqu5hWWIuXCSzZXaceaUw2rOqkBf6qcoFMFI2V6/9djG1KhxyTxV4qavBHzcH6KTjKnJ24jVarZkD3ZRzzADwEeJMT/8En4KycNf2IxKWxgJw7HpM3pXAhy6ZP7mhuwTewIS7j9Dj0WKcwZfKb+ijuILh2iMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790051199; c=relaxed/simple;
	bh=w/fxHVNtA+8suk/aVIjfFU697JVRJgCgDhdycK2gkzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DtuhVr/jW/iD2Crz25Hu0iIAGH30XXdKLH0K50jY1fK43UA298sXtE4WOC9ewDT6cYI5aHS/llKzD3u0wL2LYCwn5mYeZ0AF+Ep8Oi7hLbGzOGYlBJxwRdZtFlkEo5+kGt030K9rSrhyJ6mGctuHP8KUpwKY1jcL1cWlAyoitXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lU4X4hxk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lU4X4hxk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A091F000FF;
	Tue, 22 Sep 2026 04:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790051197;
	bh=o0qMmOfhKF4hfQTENoYGXCxXEOkOcEeucQ2rUqmquDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lU4X4hxkOH1axShMDRRGb5Re7i+gAOO24wBquUgmdCckJ/HBIoOixc4OIyPgiwPlV
	 O+/MgiVQGQ6wNBBAUwUKecGXt5pmRdIvN7HywaK61hDgP4mcaAyyCg+C249KCB93FS
	 8EDD/IqJfMZIJFlVxOQIyJrpdwsP9yAflH3osOPd8f3WUARqAgXwrN/moaZfjJSZ9a
	 k+6uKimiiGS4pGis25FZnGQKEcVuQLkIOm1ARy6AcpqAlmXVf5su8wZlOs622qymJn
	 d2kMedEFYoRn0T6bkOAf8VZUuBuHwusVLrVNV+hAGVTAf21jRXJfx4pkTUFtUMRZmt
	 5FCZ2r/bZO37A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Sean Christopherson <seanjc@google.com>
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
	linux-perf-users@vger.kernel.org,
	x86@kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Subject: [PATCH v17 09/13] selftests: tracing: Add syntax testcase for wprobe
Date: Tue, 22 Sep 2026 13:26:30 +0900
Message-ID: <179005119078.388919.13826248487433752738.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179005108298.388919.4535333252892590932.stgit@devnote2>
References: <179005108298.388919.4535333252892590932.stgit@devnote2>
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

