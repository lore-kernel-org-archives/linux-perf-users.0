Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19679293B50;
	Thu, 24 Apr 2025 19:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745522658; cv=none; b=KbTrl/0UK3JAXjIyovO3sDACwNK77D+E7mtfY1pzDDiezmbROw4UB56h3Wol4uz0AgZ8Pk2N7jWe5AoxYzfjy9n2M04sGHIycIf3mm4ZjHXmvVvCEMISOqAjMFRhKQr2FEPAb3tkVgccZ1gziI/jD1nlzgUx73fpWFCK3SVTLI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745522658; c=relaxed/simple;
	bh=BG0zUEBPIwP0oa+bn506OOY7CMuENYzp2nHa7OnXsQA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=S8LOnWO58LUtkGi8yV6EM4efNQbGA5ohVFPy5i6Ph59i50XbiKCGuYXOe8Ve9a/DYZdD0lT8mnl3iJ4nYSwpD1MgwGiT97pd5zsV1+faixInrvqKhE/toVmWp22DF5yizCdTw9MCUdZSQBNYCLw+EoSbvSxCwhIw3OL7jh7JMf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91BD7C4AF13;
	Thu, 24 Apr 2025 19:24:17 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1u82D7-0000000H2SA-3Yej;
	Thu, 24 Apr 2025 15:26:13 -0400
Message-ID: <20250424192613.695828192@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 24 Apr 2025 15:25:04 -0400
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
Subject: [PATCH v5 8/9] tracing: Have deferred user space stacktrace show file offsets
References: <20250424192456.851953422@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Instead of showing the IP address of the user space stack trace, which is
where ever it was mapped by the kernel, show the offsets of where it would
be in the file.

Instead of:

       trace-cmd-1066    [007] .....    67.770256: <user stack unwind>
cookie=7000000000009
 =>  <00007fdbd0d421ca>
 =>  <00007fdbd0f3be27>
 =>  <00005635ece557e7>
 =>  <00005635ece559d3>
 =>  <00005635ece56523>
 =>  <00005635ece6479d>
 =>  <00005635ece64b01>
 =>  <00005635ece64bc0>
 =>  <00005635ece53b7e>
 =>  <00007fdbd0c6bca8>

Which is the addresses of the functions in the virtual address space of
the process. Have it record:

       trace-cmd-1090    [003] .....   180.779876: <user stack unwind>
cookie=3000000000009
 =>  <00000000001001ca>
 =>  <000000000000ae27>
 =>  <00000000000107e7>
 =>  <00000000000109d3>
 =>  <0000000000011523>
 =>  <000000000001f79d>
 =>  <000000000001fb01>
 =>  <000000000001fbc0>
 =>  <000000000000eb7e>
 =>  <0000000000029ca8>

Which is the offset from code where it was mapped at. To find this
address, the mmap_read_lock is taken and the vma is searched for the
addresses. Then what is recorded is simply:

  (addr - vma->vm_start) + (vma->vm_pgoff << PAGE_SHIFT);

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 71340207321e..f9eb0f7d649c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3085,18 +3085,27 @@ static void trace_user_unwind_callback(struct unwind_work *unwind,
 	struct trace_buffer *buffer = tr->array_buffer.buffer;
 	struct userunwind_stack_entry *entry;
 	struct ring_buffer_event *event;
+	struct mm_struct *mm = current->mm;
 	unsigned int trace_ctx;
+	struct vm_area_struct *vma = NULL;
 	unsigned long *caller;
 	unsigned int offset;
 	int len;
 	int i;
 
+	/* This should never happen */
+	if (!mm)
+		return;
+
 	if (!(tr->trace_flags & TRACE_ITER_USERSTACKTRACE_DELAY))
 		return;
 
 	len = trace->nr * sizeof(unsigned long) + sizeof(*entry);
 
 	trace_ctx = tracing_gen_ctx();
+
+	guard(mmap_read_lock)(mm);
+
 	event = __trace_buffer_lock_reserve(buffer, TRACE_USER_UNWIND_STACK,
 					    len, trace_ctx);
 	if (!event)
@@ -3113,7 +3122,16 @@ static void trace_user_unwind_callback(struct unwind_work *unwind,
 	caller = (void *)entry + offset;
 
 	for (i = 0; i < trace->nr; i++) {
-		caller[i] = trace->entries[i];
+		unsigned long addr = trace->entries[i];
+
+		if (!vma || addr < vma->vm_start || addr >= vma->vm_end)
+			vma = vma_lookup(mm, addr);
+
+		if (!vma) {
+			caller[i] = addr;
+			continue;
+		}
+		caller[i] = (addr - vma->vm_start) + (vma->vm_pgoff << PAGE_SHIFT);
 	}
 
 	__buffer_unlock_commit(buffer, event);
-- 
2.47.2


