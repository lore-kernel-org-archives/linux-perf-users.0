From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 15/23] tools headers UAPI: Sync drm/i915_drm.h with the kernel sources
Date: Fri, 14 Feb 2020 16:10:49 -0300
Message-ID: <20200214191057.26266-16-acme@kernel.org>
References: <20200214191057.26266-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200214191057.26266-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Abdiel Janulgue <abdiel.janulgue@linux.intel.com>, Adrian Hunter <adrian.hunter@intel.com>, Chris Wilson <chris@chris-wilson.co.uk>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick the change in:

  cc662126b413 ("drm/i915: Introduce DRM_I915_GEM_MMAP_OFFSET")

That don't result in any changes in tooling, just silences this perf
build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/drm/i915_drm.h' differs from latest version at 'include/uapi/drm/i915_drm.h'
  diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_drm.h

Cc: Abdiel Janulgue <abdiel.janulgue@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/drm/i915_drm.h | 32 +++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/include/uapi/drm/i915_drm.h b/tools/include/uapi/drm/i915_drm.h
index 5400d7e057f1..829c0a48577f 100644
--- a/tools/include/uapi/drm/i915_drm.h
+++ b/tools/include/uapi/drm/i915_drm.h
@@ -395,6 +395,7 @@ typedef struct _drm_i915_sarea {
 #define DRM_IOCTL_I915_GEM_PWRITE	DRM_IOW (DRM_COMMAND_BASE + DRM_I915_GEM_PWRITE, struct drm_i915_gem_pwrite)
 #define DRM_IOCTL_I915_GEM_MMAP		DRM_IOWR(DRM_COMMAND_BASE + DRM_I915_GEM_MMAP, struct drm_i915_gem_mmap)
 #define DRM_IOCTL_I915_GEM_MMAP_GTT	DRM_IOWR(DRM_COMMAND_BASE + DRM_I915_GEM_MMAP_GTT, struct drm_i915_gem_mmap_gtt)
+#define DRM_IOCTL_I915_GEM_MMAP_OFFSET	DRM_IOWR(DRM_COMMAND_BASE + DRM_I915_GEM_MMAP_GTT, struct drm_i915_gem_mmap_offset)
 #define DRM_IOCTL_I915_GEM_SET_DOMAIN	DRM_IOW (DRM_COMMAND_BASE + DRM_I915_GEM_SET_DOMAIN, struct drm_i915_gem_set_domain)
 #define DRM_IOCTL_I915_GEM_SW_FINISH	DRM_IOW (DRM_COMMAND_BASE + DRM_I915_GEM_SW_FINISH, struct drm_i915_gem_sw_finish)
 #define DRM_IOCTL_I915_GEM_SET_TILING	DRM_IOWR (DRM_COMMAND_BASE + DRM_I915_GEM_SET_TILING, struct drm_i915_gem_set_tiling)
@@ -793,6 +794,37 @@ struct drm_i915_gem_mmap_gtt {
 	__u64 offset;
 };
 
+struct drm_i915_gem_mmap_offset {
+	/** Handle for the object being mapped. */
+	__u32 handle;
+	__u32 pad;
+	/**
+	 * Fake offset to use for subsequent mmap call
+	 *
+	 * This is a fixed-size type for 32/64 compatibility.
+	 */
+	__u64 offset;
+
+	/**
+	 * Flags for extended behaviour.
+	 *
+	 * It is mandatory that one of the MMAP_OFFSET types
+	 * (GTT, WC, WB, UC, etc) should be included.
+	 */
+	__u64 flags;
+#define I915_MMAP_OFFSET_GTT 0
+#define I915_MMAP_OFFSET_WC  1
+#define I915_MMAP_OFFSET_WB  2
+#define I915_MMAP_OFFSET_UC  3
+
+	/*
+	 * Zero-terminated chain of extensions.
+	 *
+	 * No current extensions defined; mbz.
+	 */
+	__u64 extensions;
+};
+
 struct drm_i915_gem_set_domain {
 	/** Handle for the object */
 	__u32 handle;
-- 
2.21.1
