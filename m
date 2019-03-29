From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/13] tools headers uapi: Update drm/i915_drm.h
Date: Fri, 29 Mar 2019 10:37:55 -0300
Message-ID: <20190329133801.21004-8-acme@kernel.org>
References: <20190329133801.21004-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190329133801.21004-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Tvrtko Ursulin <tvrtko.ursulin@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get the changes in:

  e46c2e99f600 ("drm/i915: Expose RPCS (SSEU) configuration to userspace (Gen11 only)")

That don't cause changes in the generated perf binaries.

To silence this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/drm/i915_drm.h' differs from latest version at 'include/uapi/drm/i915_drm.h'
  diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_drm.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Link: https://lkml.kernel.org/n/tip-h6bspm1nomjnpr90333rrx7q@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/drm/i915_drm.h | 64 +++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/tools/include/uapi/drm/i915_drm.h b/tools/include/uapi/drm/i915_drm.h
index 298b2e197744..397810fa2d33 100644
--- a/tools/include/uapi/drm/i915_drm.h
+++ b/tools/include/uapi/drm/i915_drm.h
@@ -1486,9 +1486,73 @@ struct drm_i915_gem_context_param {
 #define   I915_CONTEXT_MAX_USER_PRIORITY	1023 /* inclusive */
 #define   I915_CONTEXT_DEFAULT_PRIORITY		0
 #define   I915_CONTEXT_MIN_USER_PRIORITY	-1023 /* inclusive */
+	/*
+	 * When using the following param, value should be a pointer to
+	 * drm_i915_gem_context_param_sseu.
+	 */
+#define I915_CONTEXT_PARAM_SSEU		0x7
 	__u64 value;
 };
 
+/**
+ * Context SSEU programming
+ *
+ * It may be necessary for either functional or performance reason to configure
+ * a context to run with a reduced number of SSEU (where SSEU stands for Slice/
+ * Sub-slice/EU).
+ *
+ * This is done by configuring SSEU configuration using the below
+ * @struct drm_i915_gem_context_param_sseu for every supported engine which
+ * userspace intends to use.
+ *
+ * Not all GPUs or engines support this functionality in which case an error
+ * code -ENODEV will be returned.
+ *
+ * Also, flexibility of possible SSEU configuration permutations varies between
+ * GPU generations and software imposed limitations. Requesting such a
+ * combination will return an error code of -EINVAL.
+ *
+ * NOTE: When perf/OA is active the context's SSEU configuration is ignored in
+ * favour of a single global setting.
+ */
+struct drm_i915_gem_context_param_sseu {
+	/*
+	 * Engine class & instance to be configured or queried.
+	 */
+	__u16 engine_class;
+	__u16 engine_instance;
+
+	/*
+	 * Unused for now. Must be cleared to zero.
+	 */
+	__u32 flags;
+
+	/*
+	 * Mask of slices to enable for the context. Valid values are a subset
+	 * of the bitmask value returned for I915_PARAM_SLICE_MASK.
+	 */
+	__u64 slice_mask;
+
+	/*
+	 * Mask of subslices to enable for the context. Valid values are a
+	 * subset of the bitmask value return by I915_PARAM_SUBSLICE_MASK.
+	 */
+	__u64 subslice_mask;
+
+	/*
+	 * Minimum/Maximum number of EUs to enable per subslice for the
+	 * context. min_eus_per_subslice must be inferior or equal to
+	 * max_eus_per_subslice.
+	 */
+	__u16 min_eus_per_subslice;
+	__u16 max_eus_per_subslice;
+
+	/*
+	 * Unused for now. Must be cleared to zero.
+	 */
+	__u32 rsvd;
+};
+
 enum drm_i915_oa_format {
 	I915_OA_FORMAT_A13 = 1,	    /* HSW only */
 	I915_OA_FORMAT_A29,	    /* HSW only */
-- 
2.20.1
