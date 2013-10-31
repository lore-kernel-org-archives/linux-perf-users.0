From: David Ahern <dsahern@gmail.com>
Subject: Re: Information regarding the perf tool
Date: Thu, 31 Oct 2013 12:22:29 -0600
Message-ID: <52729FE5.3090109@gmail.com>
References: <5266A57F.2000201@bsc.es> <87y55krw6f.fsf@tassilo.jf.intel.com> <52727B0C.5040402@bsc.es> <527287A7.3050908@gmail.com> <5272922E.20007@bsc.es>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010109070601050601070105"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:36414 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752728Ab3JaSWd (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 31 Oct 2013 14:22:33 -0400
Received: by mail-pd0-f170.google.com with SMTP id v10so2832014pde.1
        for <linux-perf-users@vger.kernel.org>; Thu, 31 Oct 2013 11:22:33 -0700 (PDT)
In-Reply-To: <5272922E.20007@bsc.es>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Harald Servat <harald.servat@bsc.es>, Andi Kleen <andi@firstfloor.org>
Cc: linux-perf-users@vger.kernel.org

This is a multi-part message in MIME format.
--------------010109070601050601070105
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 10/31/13, 11:23 AM, Harald Servat wrote:
> Which is the relation between perf_clock() (or local_clock()) and
> clock_gettime (CLOCK_MONOTONIC, ). Are they the same? If not, is there a
> way to correlate them? Or alternatively, is it possible to call
> local_clock() from the userland?

We still do not have a means of correlating perf_clock to time-of-day, 
monotonic or any other clock source. Still trying.

Pawell Moll has a couple of patches posted -- one uses an ioctl to get 
perf_clock timestamps the other makes perf_clock accessible through 
clock_gettime. See attached.

David

--------------010109070601050601070105
Content-Type: text/plain; charset=UTF-8; x-mac-type="0"; x-mac-creator="0";
 name="0001-perf-POSIX-CLOCK_PERF-to-report-current-time-value.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-perf-POSIX-CLOCK_PERF-to-report-current-time-value.patc";
 filename*1="h"

From 5e2d4c81b9e4a82090ec44a24e84223e00a4c5fd Mon Sep 17 00:00:00 2001
From: David Ahern <dsahern@gmail.com>
Date: Wed, 23 Oct 2013 16:53:05 +0100
Subject: [PATCH] perf: POSIX CLOCK_PERF to report current time value

To co-relate user space events with the perf events stream
a current (as in: "what time(stamp) is it now?") time value
must be made available.

This patch adds a POSIX clock returning the perf_clock()
value and accesible from userspace:

    #include <time.h>

    struct timespec ts;

    clock_gettime(CLOCK_PERF, &ts);

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
Signed-off-by: David Ahern <dsahern@gmail.com>
---
 include/uapi/linux/time.h |  1 +
 kernel/events/core.c      | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/uapi/linux/time.h b/include/uapi/linux/time.h
index e75e1b6ff27f..9066bf02c867 100644
--- a/include/uapi/linux/time.h
+++ b/include/uapi/linux/time.h
@@ -56,6 +56,7 @@ struct itimerval {
 #define CLOCK_BOOTTIME_ALARM		9
 #define CLOCK_SGI_CYCLE			10	/* Hardware specific */
 #define CLOCK_TAI			11
+#define CLOCK_PERF			12
 
 #define MAX_CLOCKS			16
 #define CLOCKS_MASK			(CLOCK_REALTIME | CLOCK_MONOTONIC)
diff --git a/kernel/events/core.c b/kernel/events/core.c
index b073975af05a..98c26fb1d9fd 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -39,6 +39,7 @@
 #include <linux/hw_breakpoint.h>
 #include <linux/mm_types.h>
 #include <linux/cgroup.h>
+#include <linux/posix-timers.h>
 
 #include "internal.h"
 
@@ -303,6 +304,19 @@ static inline u64 perf_clock(void)
 }
 #endif
 
+static int perf_posix_clock_getres(const clockid_t which_clock,
+		struct timespec *tp)
+{
+	*tp = ns_to_timespec(TICK_NSEC);
+	return 0;
+}
+
+static int perf_posix_clock_get(clockid_t which_clock, struct timespec *tp)
+{
+	*tp = ns_to_timespec(perf_clock());
+	return 0;
+}
+
 static inline struct perf_cpu_context *
 __get_cpu_context(struct perf_event_context *ctx)
 {
@@ -7878,6 +7892,10 @@ perf_cpu_notify(struct notifier_block *self, unsigned long action, void *hcpu)
 
 void __init perf_event_init(void)
 {
+	struct k_clock perf_posix_clock = {
+		.clock_getres = perf_posix_clock_getres,
+		.clock_get = perf_posix_clock_get,
+	};
 	int ret;
 
 	idr_init(&pmu_idr);
@@ -7894,6 +7912,8 @@ void __init perf_event_init(void)
 	ret = init_hw_breakpoint();
 	WARN(ret, "hw_breakpoint initialization failed with: %d", ret);
 
+	posix_timers_register_clock(CLOCK_PERF, &perf_posix_clock);
+
 	/* do not patch jump label more than once per second */
 	jump_label_rate_limit(&perf_sched_events, HZ);
 
-- 
1.8.3.4 (Apple Git-47)


--------------010109070601050601070105
Content-Type: text/plain; charset=UTF-8; x-mac-type="0"; x-mac-creator="0";
 name="perf-Add-ioctl-to-return-perf_clock.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="perf-Add-ioctl-to-return-perf_clock.patch"

From 3601ad205e74a0af22de4421f12a5f0ee0559057 Mon Sep 17 00:00:00 2001
From: Pawel Moll <pawel.moll@arm.com>
Date: Fri, 1 Feb 2013 14:03:56 +0000
Subject: [PATCH 16/45] perf: Add ioctl to return current time value

To co-relate user space events with the perf events stream
a current (as in: "what time(stamp) is it now?") time value
must be made available.

This patch adds a perf ioctl that makes this possible.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 include/uapi/linux/perf_event.h |    1 +
 kernel/events/core.c            |    8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 0b1df41..41cb39e 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -321,6 +321,7 @@ struct perf_event_attr {
 #define PERF_EVENT_IOC_PERIOD		_IOW('$', 4, __u64)
 #define PERF_EVENT_IOC_SET_OUTPUT	_IO ('$', 5)
 #define PERF_EVENT_IOC_SET_FILTER	_IOW('$', 6, char *)
+#define PERF_EVENT_IOC_GET_TIME		_IOR('$', 7, __u64)
 
 enum perf_event_ioc_flags {
 	PERF_IOC_FLAG_GROUP		= 1U << 0,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1833bc5..62a44d9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3543,6 +3543,14 @@ static long perf_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case PERF_EVENT_IOC_SET_FILTER:
 		return perf_event_set_filter(event, (void __user *)arg);
 
+	case PERF_EVENT_IOC_GET_TIME:
+	{
+		u64 time = perf_clock();
+		if (copy_to_user((void __user *)arg, &time, sizeof(time)))
+			return -EFAULT;
+		return 0;
+	}
+
 	default:
 		return -ENOTTY;
 	}
-- 
1.7.10.1


--------------010109070601050601070105--
