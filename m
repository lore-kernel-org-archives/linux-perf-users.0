Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5C3293B5A;
	Thu, 24 Apr 2025 19:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745522658; cv=none; b=SBOeinVxqnjUCyQodjtwx6rE8oOfVaPGZbMq7p2zoBR+T+5MHZlY9u/HlQwAr8tS/cvJ8zSs256trV3Qih5gLgCXOSAjf82IhfSsoDqRdTjiw4x5HeR6FIQExLpWKru5slHlXg5b+E5m9lBuvj4d47VtkjiNBBaSZ966+msPSAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745522658; c=relaxed/simple;
	bh=kJdHyyr5g9cwZZEEx8rTPCm7ZWJNtMxA7FZ5ZyNruPY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=K+5RmGcVv4awthZqKsS4ExcwdH4wZYvOVyHWJUkvf6sT7cRTOZSUJZjwwUoSMrFxgDd/27djBMNOLZq5O2uHMEKvNRzx11TBnwkYsVsDwoN50rTHgKL3537bc7oeS8KLPeulcIkI0vOHYxocU4QLZskW+GgP+aqA25hSQ2wm44Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C660DC4AF14;
	Thu, 24 Apr 2025 19:24:17 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1u82D8-0000000H2Sf-04ZF;
	Thu, 24 Apr 2025 15:26:14 -0400
Message-ID: <20250424192613.869730948@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 24 Apr 2025 15:25:05 -0400
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
Subject: [PATCH v5 9/9] tracing: Show inode and device major:minor in deferred user space
 stacktrace
References: <20250424192456.851953422@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The deferred user space stacktrace event already does a lookup of the vma
for each address in the trace to get the file offset for those addresses,
it can also report the file itself.

Add two more arrays to the user space stacktrace event. One for the inode
number, and the other to store the device major:minor number. Now the
output looks like this:

       trace-cmd-1108    [007] .....   240.253487: <user stack unwind>
cookie=7000000000009
 =>  <00000000001001ca> : 1340007 : 254:3
 =>  <000000000000ae27> : 1308548 : 254:3
 =>  <00000000000107e7> : 1440347 : 254:3
 =>  <00000000000109d3> : 1440347 : 254:3
 =>  <0000000000011523> : 1440347 : 254:3
 =>  <000000000001f79d> : 1440347 : 254:3
 =>  <000000000001fb01> : 1440347 : 254:3
 =>  <000000000001fbc0> : 1440347 : 254:3
 =>  <000000000000eb7e> : 1440347 : 254:3
 =>  <0000000000029ca8> : 1340007 : 254:3

Use space tooling can use this information to get the actual functions
from the files.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c         | 25 ++++++++++++++++++++++++-
 kernel/trace/trace_entries.h |  8 ++++++--
 kernel/trace/trace_output.c  | 27 +++++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f9eb0f7d649c..cb0255106b7f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3089,6 +3089,8 @@ static void trace_user_unwind_callback(struct unwind_work *unwind,
 	unsigned int trace_ctx;
 	struct vm_area_struct *vma = NULL;
 	unsigned long *caller;
+	unsigned long *inodes;
+	unsigned int *devs;
 	unsigned int offset;
 	int len;
 	int i;
@@ -3100,7 +3102,8 @@ static void trace_user_unwind_callback(struct unwind_work *unwind,
 	if (!(tr->trace_flags & TRACE_ITER_USERSTACKTRACE_DELAY))
 		return;
 
-	len = trace->nr * sizeof(unsigned long) + sizeof(*entry);
+	len = trace->nr * (sizeof(unsigned long) * 2 + sizeof(unsigned int))
+			   + sizeof(*entry);
 
 	trace_ctx = tracing_gen_ctx();
 
@@ -3121,6 +3124,15 @@ static void trace_user_unwind_callback(struct unwind_work *unwind,
 	entry->__data_loc_stack = offset | (len << 16);
 	caller = (void *)entry + offset;
 
+	offset += len;
+	entry->__data_loc_inodes = offset | (len << 16);
+	inodes = (void *)entry + offset;
+
+	offset += len;
+	len = sizeof(unsigned int) * trace->nr;
+	entry->__data_loc_dev = offset | (len << 16);
+	devs = (void *)entry + offset;
+
 	for (i = 0; i < trace->nr; i++) {
 		unsigned long addr = trace->entries[i];
 
@@ -3129,9 +3141,20 @@ static void trace_user_unwind_callback(struct unwind_work *unwind,
 
 		if (!vma) {
 			caller[i] = addr;
+			inodes[i] = 0;
+			devs[i] = 0;
 			continue;
 		}
+
 		caller[i] = (addr - vma->vm_start) + (vma->vm_pgoff << PAGE_SHIFT);
+
+		if (vma->vm_file && vma->vm_file->f_inode) {
+			inodes[i] = vma->vm_file->f_inode->i_ino;
+			devs[i] = vma->vm_file->f_inode->i_sb->s_dev;
+		} else {
+			inodes[i] = 0;
+			devs[i] = 0;
+		}
 	}
 
 	__buffer_unlock_commit(buffer, event);
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index 752a99296c95..f2dc09405128 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -256,10 +256,14 @@ FTRACE_ENTRY(user_unwind_stack, userunwind_stack_entry,
 	F_STRUCT(
 		__field(		u64,		cookie	)
 		__dynamic_array(	unsigned long,	stack	)
+		__dynamic_array(	unsigned long,	inodes	)
+		__dynamic_array(	unsigned int,	dev	)
 	),
 
-	F_printk("cookie=%lld\n%s", __entry->cookie,
-		 __print_dynamic_array(stack, sizeof(unsigned long)))
+	F_printk("cookie=%lld\n%s%s%s", __entry->cookie,
+		 __print_dynamic_array(stack, sizeof(unsigned long)),
+		 __print_dynamic_array(inodes, sizeof(unsigned long)),
+		 __print_dynamic_array(dev, sizeof(unsigned long)))
 );
 
 FTRACE_ENTRY(user_unwind_cookie, userunwind_cookie_entry,
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index e11911e5f7d0..4bdbc6c48cdb 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1380,9 +1380,13 @@ static enum print_line_t trace_user_unwind_stack_print(struct trace_iterator *it
 	struct userunwind_stack_entry *field;
 	struct trace_seq *s = &iter->seq;
 	unsigned long *caller;
+	unsigned long *inodes;
+	unsigned int *devs;
 	unsigned int offset;
 	unsigned int len;
 	unsigned int caller_cnt;
+	unsigned int inode_cnt;
+	unsigned int dev_cnt;
 	unsigned int i;
 
 	trace_assign_type(field, iter->ent);
@@ -1399,6 +1403,21 @@ static enum print_line_t trace_user_unwind_stack_print(struct trace_iterator *it
 
 	caller = (void *)iter->ent + offset;
 
+	/* The inodes and devices are also dynamic pointers */
+	offset = field->__data_loc_inodes;
+	len = offset >> 16;
+	offset = offset & 0xffff;
+	inode_cnt = len / sizeof(*inodes);
+
+	inodes = (void *)iter->ent + offset;
+
+	offset = field->__data_loc_dev;
+	len = offset >> 16;
+	offset = offset & 0xffff;
+	dev_cnt = len / sizeof(*devs);
+
+	devs = (void *)iter->ent + offset;
+
 	for (i = 0; i < caller_cnt; i++) {
 		unsigned long ip = caller[i];
 
@@ -1407,6 +1426,14 @@ static enum print_line_t trace_user_unwind_stack_print(struct trace_iterator *it
 
 		trace_seq_puts(s, " => ");
 		seq_print_user_ip(s, NULL, ip, flags);
+
+		if (i < inode_cnt) {
+			trace_seq_printf(s, " : %ld", inodes[i]);
+			if (i < dev_cnt) {
+				trace_seq_printf(s, " : %d:%d",
+						 MAJOR(devs[i]), MINOR(devs[i]));
+			}
+		}
 		trace_seq_putc(s, '\n');
 	}
 
-- 
2.47.2


