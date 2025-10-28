Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC15E36B961;
	Tue, 28 Oct 2025 23:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761693069; cv=none; b=eTj0lL7OjmUTt/3+ZhzK6WK6kPwQS31Aayv3re94B3VGlH0VE5BPBX5B4towe74aI8ta6oZdturWBg+8pZQZwheZjwR1YoIPjDyy5SnYpIfgEl2jcWubumdaHIQ8+/0Vvmman0E1JENDOhkZ5Td1Aadf4zlDGBVK1nCejTBa75w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761693069; c=relaxed/simple;
	bh=uN+l80Ab7ApPK9S87261XX0pIHui/zk9ztMMRsEW41c=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=GcdSVN8LWfJ7JP9mfmhIhwJZH/1bdHHi9xCQ5hN2sssgUnUJwlB+5vemD7pqqTg+P66xM91TeXc6VzPVWEavMkxDJscPiZ8QnWplp0MB9BSFxKi6kEdapRGQcHgyhM3Kj+ONK+lHV9J3NMjhi9QGOIrGFL+ljji2m4FDY/P+yRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vANUJpgh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vANUJpgh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC602C4CEE7;
	Tue, 28 Oct 2025 23:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761693068;
	bh=uN+l80Ab7ApPK9S87261XX0pIHui/zk9ztMMRsEW41c=;
	h=Date:From:To:Cc:Subject:References:From;
	b=vANUJpghhlwC/Fl10kmkH/KXl/4cZNjj1jx6gMYBP01H6EN7Rvv54fAtl8aDZl6iy
	 0tTeKxeL2m8kwmHdPOfFLeWQUVz39wHdg7uyMk0HYZ2Qdj7IGHXgMPCFjZfwtjqls7
	 UwB9tfZNpl7H+3kHflK/vxZ8qjr+cPw+joMswYJiHh/KCVYaGRfrVTVKr8VpR0wuSN
	 HDTV5ns7hDu2BCQ1/H2cCmsqnRHgYHoxgTP8ZsrnKJT01/uD8FrbOUPh+rSHCdBiFq
	 WJi0BR76RnTihaiFwLEdX6VVnJLydNjP4y9nWlgbU7wX2KvMOqdFY24B1PE5kP/+tP
	 7dW+i8LfKWlcw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vDsqy-00000004qrf-0Jqi;
	Tue, 28 Oct 2025 19:11:48 -0400
Message-ID: <20251028231147.930550359@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 28 Oct 2025 19:11:20 -0400
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
Subject: [PATCH v5 06/13] tracing: Display some syscall arrays as strings
References: <20251028231114.820213884@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Some of the system calls that read a fixed length of memory from the user
space address are not arrays but strings. Take a bit away from the nb_args
field in the syscall meta data to use as a flag to denote that the system
call's user_arg_size is being used as a string. The nb_args should never
be more than 6, so 7 bits is plenty to hold that number. When the
user_arg_is_str flag that, when set, will display the data array from the
user space address as a string and not an array.

This will allow the output to look like this:

  sys_sethostname(name: 0x5584310eb2a0 "debian", len: 6)

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v4: https://lore.kernel.org/20251021005233.251192796@kernel.org

- Use #ifdef __NR_kexec_file_load instead to hide that value

 include/trace/syscall.h       |  4 +++-
 kernel/trace/trace_syscalls.c | 22 +++++++++++++++++++---
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/include/trace/syscall.h b/include/trace/syscall.h
index 9413c139da66..0dd7f2b33431 100644
--- a/include/trace/syscall.h
+++ b/include/trace/syscall.h
@@ -16,6 +16,7 @@
  * @name: name of the syscall
  * @syscall_nr: number of the syscall
  * @nb_args: number of parameters it takes
+ * @user_arg_is_str: set if the arg for @user_arg_size is a string
  * @user_arg_size: holds @arg that has size of the user space to read
  * @user_mask: mask of @args that will read user space
  * @types: list of types as strings
@@ -27,7 +28,8 @@
 struct syscall_metadata {
 	const char	*name;
 	int		syscall_nr;
-	u8		nb_args;
+	u8		nb_args:7;
+	u8		user_arg_is_str:1;
 	s8		user_arg_size;
 	short		user_mask;
 	const char	**types;
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 3f3cdfc9958e..b8e9774a8abd 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -184,7 +184,7 @@ print_syscall_enter(struct trace_iterator *iter, int flags,
 		ptr = (void *)ent + (val & 0xffff);
 		len = val >> 16;
 
-		if (entry->user_arg_size < 0) {
+		if (entry->user_arg_size < 0 || entry->user_arg_is_str) {
 			trace_seq_printf(s, " \"%.*s\"", len, ptr);
 			continue;
 		}
@@ -249,6 +249,7 @@ print_syscall_exit(struct trace_iterator *iter, int flags,
 static int __init
 __set_enter_print_fmt(struct syscall_metadata *entry, char *buf, int len)
 {
+	bool is_string = entry->user_arg_is_str;
 	int i;
 	int pos = 0;
 
@@ -266,7 +267,7 @@ __set_enter_print_fmt(struct syscall_metadata *entry, char *buf, int len)
 			continue;
 
 		/* Add the format for the user space string or array */
-		if (entry->user_arg_size < 0)
+		if (entry->user_arg_size < 0 || is_string)
 			pos += snprintf(buf + pos, LEN_OR_ZERO, " \\\"%%s\\\"");
 		else
 			pos += snprintf(buf + pos, LEN_OR_ZERO, " (%%s)");
@@ -279,7 +280,7 @@ __set_enter_print_fmt(struct syscall_metadata *entry, char *buf, int len)
 		if (!(BIT(i) & entry->user_mask))
 			continue;
 		/* The user space data for arg has name __<arg>_val */
-		if (entry->user_arg_size < 0) {
+		if (entry->user_arg_size < 0 || is_string) {
 			pos += snprintf(buf + pos, LEN_OR_ZERO, ", __get_str(__%s_val)",
 					entry->args[i]);
 		} else {
@@ -781,6 +782,21 @@ static void check_faultable_syscall(struct trace_event_call *call, int nr)
 		sys_data->user_mask = BIT(1);
 		sys_data->user_arg_size = 2;
 		break;
+	/* user arg 0 with size arg at 1 as string */
+	case __NR_setdomainname:
+	case __NR_sethostname:
+		sys_data->user_mask = BIT(0);
+		sys_data->user_arg_size = 1;
+		sys_data->user_arg_is_str = 1;
+		break;
+#ifdef __NR_kexec_file_load
+	/* user arg 4 with size arg at 3 as string */
+	case __NR_kexec_file_load:
+		sys_data->user_mask = BIT(4);
+		sys_data->user_arg_size = 3;
+		sys_data->user_arg_is_str = 1;
+		break;
+#endif
 	/* user arg at position 0 */
 #ifdef __NR_access
 	case __NR_access:
-- 
2.51.0


