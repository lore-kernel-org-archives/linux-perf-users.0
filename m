From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [BUGFIX PATCH] tracing/kprobes: Fix to check notrace function with correct range
Date: Tue, 21 Aug 2018 22:04:57 +0900
Message-ID: <153485669706.16611.17726752296213785504.stgit@devbox>
References: <20180821212448.d20ea26fa998b206adf4ece6@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180821212448.d20ea26fa998b206adf4ece6@kernel.org>
In-Reply-To: <20180821212448.d20ea26fa998b206adf4ece6@kernel.org>
References: <20180821212448.d20ea26fa998b206adf4ece6@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rostedt@goodmis.org
Cc: Francis Deslauriers <francis.deslauriers@efficios.com>, peterz@infradead.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org, Michael Rodin <michael@rodin.online>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

Fix within_notrace_func() to check notrace function correctly.

Since the ftrace_location_range(start, end) function checks
the range inclusively (start <= ftrace-loc <= end), the end
address must not include the entry address of next function.

However, within_notrace_func() uses kallsyms_lookup_size_offset()
to get the function size and calculate the end address from
adding the size to the entry address. This means the end address
is the entry address of the next function.

In the result, within_notrace_func() fails to find notrace
function if the next function of the target function is
ftraced.

Let's subtract 1 from the end address so that ftrace_location_range()
can check it correctly.

Fixes: commit 45408c4f9250 ("tracing: kprobes: Prohibit probing on notrace function")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reported-by: Michael Rodin <michael@rodin.online>
---
 kernel/trace/trace_kprobe.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 65a4157af851..ad384b31fe01 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -513,7 +513,14 @@ static bool within_notrace_func(struct trace_kprobe *tk)
 	if (!addr || !kallsyms_lookup_size_offset(addr, &size, &offset))
 		return false;
 
-	return !ftrace_location_range(addr - offset, addr - offset + size);
+	/* Get the entry address of the target function */
+	addr -= offset;
+
+	/*
+	 * Since ftrace_location_range() does inclusive range check, we need
+	 * to subtract 1 byte from the end address.
+	 */
+	return !ftrace_location_range(addr, addr + size - 1);
 }
 #else
 #define within_notrace_func(tk)	(false)
