From: Leonardo Boquillon <leonardo.boquillon@tallertechnologies.com>
Subject: Ability for classifying of measurements
Date: Tue, 19 Apr 2016 17:51:57 -0300
Message-ID: <1461099117-21401-1-git-send-email-leonardo.boquillon@tallertechnologies.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:34261 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753527AbcDSUwE (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 19 Apr 2016 16:52:04 -0400
Received: by mail-qg0-f44.google.com with SMTP id c6so17157448qga.1
        for <linux-perf-users@vger.kernel.org>; Tue, 19 Apr 2016 13:52:03 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org, daniel.gutson@tallertechnologies.com

Hi,

When profiling an application, grouping measurements according to specific
criteria can provide valuable information for the developer. For instance, 
suppose there is a variable in the application whose value represents the
current state of an internal state machine. We might want to classify the
sampled data depending on the current state. The decision of what constitutes an
adequate classification criteria depends on the application developer. 

The idea proposed here is to have a mechanism to let perf_events know the data
used to annotate the samples, either via a callback implemented by the 
application developer or by the application itself telling perf_events the data
used to classify the measurements.

The sample annotation would be a struct, whose size is specified before samples 
are recorded.

As an experiment, this patch implements the second approach, where the
annotation is a 64 bit integer that is located at a fixed memory address. The
samples are annotated using the value at that address. The value is assumed to
be in a fixed location, specified by the application being profiled through a 
new perf_ioctl subcommand.

In no way we intend this patch to be committed; we just want to show the idea 
and start a discussion instead, focusing on the idea first rather than on the 
design & code.

Thanks

---
 include/uapi/linux/perf_event.h |  1 +
 kernel/events/core.c            | 16 +++++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 1afe962..f4f2a32 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -401,6 +401,7 @@ struct perf_event_attr {
 #define PERF_EVENT_IOC_SET_FILTER	_IOW('$', 6, char *)
 #define PERF_EVENT_IOC_ID		_IOR('$', 7, __u64 *)
 #define PERF_EVENT_IOC_SET_BPF		_IOW('$', 8, __u32)
+#define PERF_EVENT_IOC_SET_WATCHED  _IOW('$', 9, __u64 *)
 
 enum perf_event_ioc_flags {
 	PERF_IOC_FLAG_GROUP		= 1U << 0,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 52bedc5..cf148b8 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -49,6 +49,8 @@
 
 #include <asm/irq_regs.h>
 
+static __u64 *watched_data;
+
 typedef int (*remote_function_f)(void *);
 
 struct remote_function_call {
@@ -4079,10 +4081,12 @@ static int perf_read_one(struct perf_event *event,
 				 u64 read_format, char __user *buf)
 {
 	u64 enabled, running;
-	u64 values[4];
+	u64 values[5];
 	int n = 0;
 
 	values[n++] = perf_event_read_value(event, &enabled, &running);
+	if (watched_data != NULL)
+		values[n++] = *((__u64 *)watched_data);
 	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
 		values[n++] = enabled;
 	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
@@ -4295,6 +4299,7 @@ static int perf_event_set_output(struct perf_event *event,
 				 struct perf_event *output_event);
 static int perf_event_set_filter(struct perf_event *event, void __user *arg);
 static int perf_event_set_bpf_prog(struct perf_event *event, u32 prog_fd);
+static int perf_event_set_watched(__u64* watched);
 
 static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned long arg)
 {
@@ -4351,6 +4356,9 @@ static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned lon
 	case PERF_EVENT_IOC_SET_BPF:
 		return perf_event_set_bpf_prog(event, arg);
 
+	case PERF_EVENT_IOC_SET_WATCHED:
+		return perf_event_set_watched((void __user *)arg);
+
 	default:
 		return -ENOTTY;
 	}
@@ -4628,6 +4636,12 @@ static void ring_buffer_wakeup(struct perf_event *event)
 	rcu_read_unlock();
 }
 
+static int perf_event_set_watched(__u64 *watched)
+{
+	watched_data = watched;
+	return 0;
+}
+
 struct ring_buffer *ring_buffer_get(struct perf_event *event)
 {
 	struct ring_buffer *rb;
-- 
1.9.1
