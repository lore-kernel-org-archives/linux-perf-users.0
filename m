Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBB12918C2;
	Thu, 24 Apr 2025 19:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745522657; cv=none; b=TgU+KQmFhRfdYz62N1WwaUY1KnAMuPwl8Tl0NpgTIqBASxlyaeYKF9cTmeIgdJCwXUZ95iJcLsxVZ07mkKTF5WVlvL6RQZj1Wug3cagQI3N4BL5W+W3HrZvQZQUIyF6h7HPoPw5evVkSDXaCkG8jF0tv5wHySTCwVZAvA39gxR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745522657; c=relaxed/simple;
	bh=dywbzU05uYdtOAPyIPR7737vlANMjFHBgRmD6TWEHjs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=A5YhmHz6Qy9c/BjUS+GP3XLmJcl5nEr1v5wgMnAvmzbuGk5aqg8KmDFxSTZX8HzJayjti+YDQ6jJuyzpQBY5hXqkY//CcS2iT8zLOMkgFJypyGxZyNa7jcX9sjY3yky9E35Dz8Efz3Jq2rWcHs4bL8H7U6P5M0DJgv3yunFSruc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA519C4CEED;
	Thu, 24 Apr 2025 19:24:16 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1u82D7-0000000H2QC-0gGT;
	Thu, 24 Apr 2025 15:26:13 -0400
Message-ID: <20250424192613.014380756@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 24 Apr 2025 15:25:00 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org,
 Mark Brown <broonie@kernel.org>,
 linux-toolchains@vger.kernel.org,
 Jordan Rome <jordalgo@meta.com>,
 Sam James <sam@gentoo.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Jens Remus <jremus@linux.ibm.com>,
 Florian Weimer <fweimer@redhat.com>,
 Andy Lutomirski <luto@kernel.org>,
 Weinan Liu <wnliu@google.com>,
 Blake Jones <blakejones@google.com>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Alexander Aring <aahringo@redhat.com>
Subject: [PATCH v5 4/9] tracing: Do not bother getting user space stacktraces for kernel
 threads
References: <20250424192456.851953422@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

If a user space stacktrace is requested when running a kernel thread, just
return, as there's no point trying to get the user space stacktrace as
there is no user space.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8ddf6b17215c..523e98cd121d 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3087,6 +3087,10 @@ ftrace_trace_userstack(struct trace_array *tr,
 	if (!(tr->trace_flags & TRACE_ITER_USERSTACKTRACE))
 		return;
 
+	/* No point doing user space stacktraces on kernel threads */
+	if (current->flags & PF_KTHREAD)
+		return;
+
 	/*
 	 * NMIs can not handle page faults, even with fix ups.
 	 * The save user stack can (and often does) fault.
-- 
2.47.2


