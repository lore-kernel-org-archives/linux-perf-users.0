Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3563002C4;
	Wed, 15 Oct 2025 17:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760549741; cv=none; b=YXUqUzmivbusl4l7ip9ejfQyQdJPULk9+/71beZ4FF8eXXR3ImJgb0UaIALTX/ewkXRArF4H7ZLsMRYgN2muD6TagDyVhpb4H3lOCLrt+Sa4nyffcUSvjyOwSAWJgWnB5jtqx24+lbN5CV5wTgyASP2brPE5OLF14r3wvWGXNTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760549741; c=relaxed/simple;
	bh=HgWjGrxuZxBQhqbXI9NZLYJboP7dLOz69gDCXcD2BCo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=A0pm2VO4lfO5bq65G9/KMxffnPDkYvYY/LQ1jdryfLES4NDK1JFMkVIZedAD9j0hFHjkstWnOVPzhBuxAUq7J5YY24ynmGa1yrcOsf39UyfxFfr+M5CHQADewIVA7qOwOzvCfvv7DwG7n5Y48z7iHvoMY8R0wvLkDuJvN1O5SFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6kJIW2Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6kJIW2Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218DEC4AF0B;
	Wed, 15 Oct 2025 17:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760549741;
	bh=HgWjGrxuZxBQhqbXI9NZLYJboP7dLOz69gDCXcD2BCo=;
	h=Date:From:To:Cc:Subject:References:From;
	b=i6kJIW2Q9kaOkcBhsDUQFl6hSA2WHo5Ub7X6qzIFNSIFx6F3MGfIu38mg2FLIvSRa
	 8+Lv+6r9BUYYTEBZilkpaOB9oqooYEEE41NWt6R+FBcBU1pqjbnjlPe4Kc3uRH9BxX
	 iG/UxdkiG5K7ZYZw0cSHXhPSGUoSyVt0oXz+qPxYHud95YR4CfVZwvhHTttb1GmM7P
	 BekXja4UKL050eUpiN38B8qgmfdTQo+++H/c3esje2wZJnRBMVjrmY2kPT/TEnUa2r
	 Da7YLd0FryNKg7mZirohf3alugS6SjlbIJ8cbHrhCRXfWtwuKQS65pUJGbhVgzfZ4S
	 180Jjgcv4naNg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v95Ph-000000011zO-2vWK;
	Wed, 15 Oct 2025 13:35:49 -0400
Message-ID: <20251015173549.546664170@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 15 Oct 2025 13:32:23 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Takaya Saeki <takayas@google.com>,
 Tom Zanussi <zanussi@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ian Rogers <irogers@google.com>,
 Douglas Raillard <douglas.raillard@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v3 09/13] tracing: Show printable characters in syscall arrays
References: <20251015173214.760495866@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

When displaying the contents of the user space data passed to the kernel,
instead of just showing the array values, also print any printable
content.

Instead of just:

  bash-1113    [003] .....  3433.290654: sys_write(fd: 2, buf: 0x555a8deeddb0 (72:6f:6f:74:40:64:65:62:69:61:6e:2d:78:38:36:2d:36:34:3a:7e:23:20), count: 0x16)

Display:

  bash-1113    [003] .....  3433.290654: sys_write(fd: 2, buf: 0x555a8deeddb0 (72:6f:6f:74:40:64:65:62:69:61:6e:2d:78:38:36:2d:36:34:3a:7e:23:20) "root@debian-x86-64:~# ", count: 0x16)

This only affects tracing and does not affect perf, as this only updates
the output from the kernel. The output from perf is via user space. This
may change by an update to libtraceevent that will then update perf to
have this as well.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_syscalls.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 35c314de8d79..3617e5487b8d 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -155,6 +155,8 @@ print_syscall_enter(struct trace_iterator *iter, int flags,
 	trace_seq_printf(s, "%s(", entry->name);
 
 	for (i = 0; i < entry->nb_args; i++) {
+		bool printable = false;
+		char *str;
 
 		if (trace_seq_has_overflowed(s))
 			goto end;
@@ -193,8 +195,11 @@ print_syscall_enter(struct trace_iterator *iter, int flags,
 
 		val = trace->args[entry->user_arg_size];
 
+		str = ptr;
 		trace_seq_puts(s, " (");
 		for (int x = 0; x < len; x++, ptr++) {
+			if (isascii(*ptr) && isprint(*ptr))
+				printable = true;
 			if (x)
 				trace_seq_putc(s, ':');
 			trace_seq_printf(s, "%02x", *ptr);
@@ -203,6 +208,22 @@ print_syscall_enter(struct trace_iterator *iter, int flags,
 			trace_seq_printf(s, ", %s", EXTRA);
 
 		trace_seq_putc(s, ')');
+
+		/* If nothing is printable, don't bother printing anything */
+		if (!printable)
+			continue;
+
+		trace_seq_puts(s, " \"");
+		for (int x = 0; x < len; x++) {
+			if (isascii(str[x]) && isprint(str[x]))
+				trace_seq_putc(s, str[x]);
+			else
+				trace_seq_putc(s, '.');
+		}
+		if (len < val)
+			trace_seq_printf(s, "\"%s", EXTRA);
+		else
+			trace_seq_putc(s, '"');
 	}
 
 	trace_seq_putc(s, ')');
-- 
2.51.0


