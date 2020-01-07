From: Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 2/9] perf/core: Add PERF_SAMPLE_CGROUP feature
Date: Tue,  7 Jan 2020 22:34:54 +0900
Message-ID: <20200107133501.327117-3-namhyung@kernel.org>
References: <20200107133501.327117-1-namhyung@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200107133501.327117-1-namhyung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Stephane Eranian <eranian@google.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>
List-Id: linux-perf-users.vger.kernel.org

The PERF_SAMPLE_CGROUP bit is to save (perf_event) cgroup information
in the sample.  It will add a 64-bit id to identify current cgroup and
it's the file handle in the cgroup file system.  Userspace should use
this information with PERF_RECORD_CGROUP event to match which cgroup
it belongs.

I put it before PERF_SAMPLE_AUX for simplicity since it just needs a
64-bit word.  But if we want bigger samples, I can work on that
direction too.

Cc: Tejun Heo <tj@kernel.org>
Cc: Li Zefan <lizefan@huawei.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 include/linux/perf_event.h      |  1 +
 include/uapi/linux/perf_event.h |  3 ++-
 init/Kconfig                    |  3 ++-
 kernel/events/core.c            | 22 ++++++++++++++++++++++
 4 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 6d4c22aee384..17b5bff045a6 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1001,6 +1001,7 @@ struct perf_sample_data {
 	u64				stack_user_size;
 
 	u64				phys_addr;
+	u64				cgroup;
 } ____cacheline_aligned;
 
 /* default value for data source */
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index de2ab87ca92c..3a81e9806cb1 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -142,8 +142,9 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_REGS_INTR			= 1U << 18,
 	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
 	PERF_SAMPLE_AUX				= 1U << 20,
+	PERF_SAMPLE_CGROUP			= 1U << 21,
 
-	PERF_SAMPLE_MAX = 1U << 21,		/* non-ABI */
+	PERF_SAMPLE_MAX = 1U << 22,		/* non-ABI */
 
 	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
 };
diff --git a/init/Kconfig b/init/Kconfig
index a34064a031a5..403ed2448b22 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1026,7 +1026,8 @@ config CGROUP_PERF
 	help
 	  This option extends the perf per-cpu mode to restrict monitoring
 	  to threads which belong to the cgroup specified and run on the
-	  designated cpu.
+	  designated cpu.  Or this can be used to have cgroup ID in samples
+	  so that it can monitor performance events among cgroups.
 
 	  Say N if unsure.
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index dbc46b884505..773480527194 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1754,6 +1754,9 @@ static void __perf_event_header_size(struct perf_event *event, u64 sample_type)
 	if (sample_type & PERF_SAMPLE_PHYS_ADDR)
 		size += sizeof(data->phys_addr);
 
+	if (sample_type & PERF_SAMPLE_CGROUP)
+		size += sizeof(data->cgroup);
+
 	event->header_size = size;
 }
 
@@ -6699,6 +6702,9 @@ void perf_output_sample(struct perf_output_handle *handle,
 	if (sample_type & PERF_SAMPLE_PHYS_ADDR)
 		perf_output_put(handle, data->phys_addr);
 
+	if (sample_type & PERF_SAMPLE_CGROUP)
+		perf_output_put(handle, data->cgroup);
+
 	if (sample_type & PERF_SAMPLE_AUX) {
 		perf_output_put(handle, data->aux_size);
 
@@ -6895,6 +6901,16 @@ void perf_prepare_sample(struct perf_event_header *header,
 	if (sample_type & PERF_SAMPLE_PHYS_ADDR)
 		data->phys_addr = perf_virt_to_phys(data->addr);
 
+#ifdef CONFIG_CGROUP_PERF
+	if (sample_type & PERF_SAMPLE_CGROUP) {
+		struct cgroup *cgrp;
+
+		/* protected by RCU */
+		cgrp = task_css_check(current, perf_event_cgrp_id, 1)->cgroup;
+		data->cgroup = cgroup_id(cgrp);
+	}
+#endif
+
 	if (sample_type & PERF_SAMPLE_AUX) {
 		u64 size;
 
@@ -11090,6 +11106,12 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 
 	if (attr->sample_type & PERF_SAMPLE_REGS_INTR)
 		ret = perf_reg_validate(attr->sample_regs_intr);
+
+#ifndef CONFIG_CGROUP_PERF
+	if (attr->sample_type & PERF_SAMPLE_CGROUP)
+		return -EINVAL;
+#endif
+
 out:
 	return ret;
 
-- 
2.24.1.735.g03f4e72817-goog
