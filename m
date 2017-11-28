From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 26/30] tools headers: Synchronize drm/i915_drm.h
Date: Tue, 28 Nov 2017 12:02:16 -0300
Message-ID: <20171128150220.5064-27-acme@kernel.org>
References: <20171128150220.5064-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753749AbdK1PDp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Nov 2017 10:03:45 -0500
In-Reply-To: <20171128150220.5064-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Chris Wilson <chris@chris-wilson.co.uk>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick up the changes from these csets:

  bf64e0b00e1f ("drm/i915: Expand I915_PARAM_HAS_SCHEDULER into a capability bitmask")
  ac14fbd460d0 ("drm/i915/scheduler: Support user-defined priorities")
  822a4b673284 ("drm/i915: Don't use BIT() in UAPI section")
  3fd3a6ffe279 ("drm/i915: Simplify i915_reg_read_ioctl")

None of them affects how the tools are built, this os done just to
silence this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/drm/i915_drm.h' differs from latest version at 'include/uapi/drm/i915_drm.h'

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-d2gor8brpcowe7bcxovjhqwm@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/drm/i915_drm.h | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/tools/include/uapi/drm/i915_drm.h b/tools/include/uapi/drm/i915_drm.h
index 9816590d3ad2..ac3c6503ca27 100644
--- a/tools/include/uapi/drm/i915_drm.h
+++ b/tools/include/uapi/drm/i915_drm.h
@@ -397,10 +397,20 @@ typedef struct drm_i915_irq_wait {
 #define I915_PARAM_MIN_EU_IN_POOL	 39
 #define I915_PARAM_MMAP_GTT_VERSION	 40
 
-/* Query whether DRM_I915_GEM_EXECBUFFER2 supports user defined execution
+/*
+ * Query whether DRM_I915_GEM_EXECBUFFER2 supports user defined execution
  * priorities and the driver will attempt to execute batches in priority order.
+ * The param returns a capability bitmask, nonzero implies that the scheduler
+ * is enabled, with different features present according to the mask.
+ *
+ * The initial priority for each batch is supplied by the context and is
+ * controlled via I915_CONTEXT_PARAM_PRIORITY.
  */
 #define I915_PARAM_HAS_SCHEDULER	 41
+#define   I915_SCHEDULER_CAP_ENABLED	(1ul << 0)
+#define   I915_SCHEDULER_CAP_PRIORITY	(1ul << 1)
+#define   I915_SCHEDULER_CAP_PREEMPTION	(1ul << 2)
+
 #define I915_PARAM_HUC_STATUS		 42
 
 /* Query whether DRM_I915_GEM_EXECBUFFER2 supports the ability to opt-out of
@@ -1309,14 +1319,16 @@ struct drm_i915_reg_read {
 	 * be specified
 	 */
 	__u64 offset;
+#define I915_REG_READ_8B_WA (1ul << 0)
+
 	__u64 val; /* Return value */
 };
 /* Known registers:
  *
  * Render engine timestamp - 0x2358 + 64bit - gen7+
  * - Note this register returns an invalid value if using the default
- *   single instruction 8byte read, in order to workaround that use
- *   offset (0x2538 | 1) instead.
+ *   single instruction 8byte read, in order to workaround that pass
+ *   flag I915_REG_READ_8B_WA in offset field.
  *
  */
 
@@ -1359,6 +1371,10 @@ struct drm_i915_gem_context_param {
 #define I915_CONTEXT_PARAM_GTT_SIZE	0x3
 #define I915_CONTEXT_PARAM_NO_ERROR_CAPTURE	0x4
 #define I915_CONTEXT_PARAM_BANNABLE	0x5
+#define I915_CONTEXT_PARAM_PRIORITY	0x6
+#define   I915_CONTEXT_MAX_USER_PRIORITY	1023 /* inclusive */
+#define   I915_CONTEXT_DEFAULT_PRIORITY		0
+#define   I915_CONTEXT_MIN_USER_PRIORITY	-1023 /* inclusive */
 	__u64 value;
 };
 
@@ -1510,9 +1526,14 @@ struct drm_i915_perf_oa_config {
 	__u32 n_boolean_regs;
 	__u32 n_flex_regs;
 
-	__u64 __user mux_regs_ptr;
-	__u64 __user boolean_regs_ptr;
-	__u64 __user flex_regs_ptr;
+	/*
+	 * These fields are pointers to tuples of u32 values (register
+	 * address, value). For example the expected length of the buffer
+	 * pointed by mux_regs_ptr is (2 * sizeof(u32) * n_mux_regs).
+	 */
+	__u64 mux_regs_ptr;
+	__u64 boolean_regs_ptr;
+	__u64 flex_regs_ptr;
 };
 
 #if defined(__cplusplus)
-- 
2.13.6
