From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 4/7] tools headers uapi: Synchronize i915_drm.h
Date: Wed, 21 Nov 2018 11:25:02 -0300
Message-ID: <20181121142505.27379-5-acme@kernel.org>
References: <20181121142505.27379-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181121142505.27379-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Chris Wilson <chris@chris-wilson.co.uk>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick up the changes in:

  900ccf30f9e1 ("drm/i915: Only force GGTT coherency w/a on required chipsets")

No changes are required in tools/ nor does anything gets automatically
generated to be used in the 'perf trace' syscall arg beautifiers.

This silences this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/drm/i915_drm.h' differs from latest version at 'include/uapi/drm/i915_drm.h'
  diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_drm.h

Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-t2vor2wegv41gt5n49095kly@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/drm/i915_drm.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/include/uapi/drm/i915_drm.h b/tools/include/uapi/drm/i915_drm.h
index 7f5634ce8e88..a4446f452040 100644
--- a/tools/include/uapi/drm/i915_drm.h
+++ b/tools/include/uapi/drm/i915_drm.h
@@ -529,6 +529,28 @@ typedef struct drm_i915_irq_wait {
  */
 #define I915_PARAM_CS_TIMESTAMP_FREQUENCY 51
 
+/*
+ * Once upon a time we supposed that writes through the GGTT would be
+ * immediately in physical memory (once flushed out of the CPU path). However,
+ * on a few different processors and chipsets, this is not necessarily the case
+ * as the writes appear to be buffered internally. Thus a read of the backing
+ * storage (physical memory) via a different path (with different physical tags
+ * to the indirect write via the GGTT) will see stale values from before
+ * the GGTT write. Inside the kernel, we can for the most part keep track of
+ * the different read/write domains in use (e.g. set-domain), but the assumption
+ * of coherency is baked into the ABI, hence reporting its true state in this
+ * parameter.
+ *
+ * Reports true when writes via mmap_gtt are immediately visible following an
+ * lfence to flush the WCB.
+ *
+ * Reports false when writes via mmap_gtt are indeterminately delayed in an in
+ * internal buffer and are _not_ immediately visible to third parties accessing
+ * directly via mmap_cpu/mmap_wc. Use of mmap_gtt as part of an IPC
+ * communications channel when reporting false is strongly disadvised.
+ */
+#define I915_PARAM_MMAP_GTT_COHERENT	52
+
 typedef struct drm_i915_getparam {
 	__s32 param;
 	/*
-- 
2.14.5
