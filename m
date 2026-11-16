Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794806840;
	b=QBTjSM1AvK4mCZvZ+HPXGb/9h5UU9vH2OnvYVEUrPh+6D/sZBkyAdCEX+RyIpz4qeZPR
	 GKIUZA75PHQ2CfxK4CZ7I+dIdtjfnNq5UqmFx4JzGywGSn67DsMe139S+lJkmLqozhkfl
	 TIPZPmJmCyjDtANxrd9pts78guHuXFb11kSonB1nP9V41RJLWMeCc2KfzEOh+UF0Wzo4E
	 xfj/ZeE6wPVO40xMs0WJUKd2dSEWeJm4ACKqzN/4SX2Tb160JrkcfPm6aYMfcOarr9uIg
	 Np/8CxKFHsvCTYwfpGXWpzZPG8nbZ+a/LLF0NSoXNdbR0Wl1cp2BaWjjz0GsEutctAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794806840;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=0kKL4MCl3Q2cnstbHaKC3Eixk3Oh/6nwsOpRNAfpXHg=;
	b=DLBM5JiWssXOEO3EuslNpYn1I050g7kc0tyBudUkBsYKeJl6nNFPLVYIizd0JK59GgcF
	 ij8ARpKq/yiGlKBkjb7O/wX5bGbRDZvVWYFkmpOqKiH6efoD3BzSRhdTptgI8m5RZWDaf
	 3Ee+6emMH0q/IEvES3qio2S6hoReXBIQX7VLb9gmGkY41ApHvh0HDBUJTqxwAhU8WB+6W
	 pNG//HJQu7ljm/5n3oEScftoqw/7tAdh3T0sZ1XaeNlLM8h42m80Cf5HKSTdBj3dNEq9t
	 ruZu3HPsbOLTGHx+OHKRar4JpXsneSH66QeFhfencupdj8YVZTHNIRasIhMkV1U27Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h+Fn9XXd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A05606A31C;
	Mon, 16 Nov 2026 05:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h+Fn9XXd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0A31F000C4;
	Mon, 16 Nov 2026 05:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794806839;
	bh=0kKL4MCl3Q2cnstbHaKC3Eixk3Oh/6nwsOpRNAfpXHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h+Fn9XXdEdEBSoAcyScy25PtTSMz8CVYeDsGjbtfJ6sWN22Kk0LZPd1LyAH2VXgTe
	 tEKEnmSCxUzjhZqKwjhVZMGucdydPXojA5IkjWX0ufGPEcXm/CIBS8WUEcsLXbO/g1
	 WWFNZocyWB3zzSqR3iFX15hDk/ReZHBZFD6Q/OPAHKa+D6Me9B+mQ/OTv/Qyf+K8Iv
	 A6RNQt30amYaDLJcfaJrdqTO6J1bfL3JB5U70wPNcT7OO4J+bicaLE7oSNlCvX3kYL
	 RRC7g1l6xeliPsZl3wdXtZ5NNozBkc1ihqJ3ya7/x+jrh6ilSqWyAsXnmYwWT3i6Uy
	 S332JUJ64u1+w==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
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
	x86@kernel.org
Subject: [PATCH v20 07/11] selftests: tracing: Add syntax testcase for wprobe
Date: Mon, 16 Nov 2026 14:27:13 +0900
Message-ID: <179480683347.38065.11389672080760832332.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179480675130.38065.3086970856119381693.stgit@devnote2>
References: <179480675130.38065.3086970856119381693.stgit@devnote2>
User-Agent: StGit/0.19
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add "wprobe_syntax_errors.tc" testcase for testing syntax errors
of the watch probe events.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v20:
 - Add error_log to requires line in wprobes_syntax_errors.tc.
 - Add testcases for unaligned address (BAD_ACCESS_ADDR) and sibling
   wprobe rejection (WPROBE_NO_SIBLING).
Changes in v14:
 - Update comment for invalid offset syntax check to BAD_PROBE_ADDR.
 - Add testcase for invalid address 0 error check (BAD_ACCESS_ADDR).
Changes in v12:
 - Add NO_ARG_BODY error case.
Changes in v11:
 - Add WPROBE_NO_MAXACT syntax error case.
---
 .../test.d/dynevent/wprobes_syntax_errors.tc       |   28 ++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/wprobes_syntax_errors.tc

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/wprobes_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/wprobes_syntax_errors.tc
new file mode 100644
index 000000000000..1f8ffeb57fd2
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/wprobes_syntax_errors.tc
@@ -0,0 +1,28 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Watch probe event parser error log check
+# requires: dynamic_events error_log "w[:[<group>/][<event>]] [r|w|rw]@<addr>[:<len>]":README
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
+check_error 'w w@^jiffies+1:4'		# BAD_ACCESS_ADDR (unaligned)
+check_error 'w w@jiffies^+offset'	# BAD_PROBE_ADDR
+check_error 'w w@jiffies:^100'		# BAD_ACCESS_LEN
+check_error 'w w@jiffies ^$arg1'	# BAD_VAR
+check_error 'w w@jiffies ^$retval'	# BAD_VAR
+check_error 'w w@jiffies ^$stack'	# BAD_VAR
+check_error 'w w@jiffies ^%ax'		# BAD_VAR
+
+echo 'w:test_wprobe w@jiffies:4' >> dynamic_events
+check_error '^w:test_wprobe r@jiffies:4'	# WPROBE_NO_SIBLING
+echo '-:test_wprobe' >> dynamic_events
+
+exit 0

