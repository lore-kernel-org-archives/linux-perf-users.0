From: Thomas Renninger <trenn@suse.de>
Subject: Re: Perf ABI versioning
Date: Mon, 24 Jan 2011 17:18:25 +0100
Message-ID: <201101241718.25627.trenn@suse.de>
References: <201101241704.01021.trenn@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:46556 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752918Ab1AXQS1 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 24 Jan 2011 11:18:27 -0500
In-Reply-To: <201101241704.01021.trenn@suse.de>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: tardyp@gmail.com
Cc: jean.pihet@newoldbits.com, acme@ghostprotocols.net, fweisbec@gmail.com, linux-perf-users@vger.kernel.org, mathieu.desnoyers@efficios.com, linux-trace-users@vger.kernel.org

and the tiny (untested) patch which should
add a version on top of /sys/kernel/debug/trace:

---
 Documentation/trace/events.changes |    6 ++++++
 kernel/trace/trace.c               |    1 +
 kernel/trace/trace.h               |    2 ++
 3 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/Documentation/trace/events.changes b/Documentation/trace/events.changes
new file mode 100644
index 0000000..bd29abc
--- /dev/null
+++ b/Documentation/trace/events.changes
@@ -0,0 +1,6 @@
+Version 2:
+<Modifications are tracked here>
+
+Version 1:
+Initial version.
+Available events and their formats:
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index dc53ecb..602885a 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2043,6 +2043,7 @@ void trace_default_header(struct seq_file *m)
 {
 	struct trace_iterator *iter = m->private;
 
+	seq_puts(m, "# Perf ABI Version %d\n", PERF_ABI_VERSION);
 	if (iter->iter_flags & TRACE_FILE_LAT_FMT) {
 		/* print nothing if the buffers are empty */
 		if (trace_empty(iter))
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 9021f8c..c23a7a2 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -13,6 +13,8 @@
 #include <linux/trace_seq.h>
 #include <linux/ftrace_event.h>
 
+#define PERF_ABI_VERSION 1
+
 enum trace_type {
 	__TRACE_FIRST_TYPE = 0,
 
