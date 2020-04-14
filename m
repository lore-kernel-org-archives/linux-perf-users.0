From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/15] tools headers UAPI: Sync drm/i915_drm.h with the kernel sources
Date: Tue, 14 Apr 2020 13:48:51 -0300
Message-ID: <20200414164854.26026-13-acme@kernel.org>
References: <20200414164854.26026-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200414164854.26026-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Chris Wilson <chris@chris-wilson.co.uk>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick the change in:

  88be76cdafc7 ("drm/i915: Allow userspace to specify ringsize on construction")

That don't result in any changes in tooling, just silences this perf
build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/drm/i915_drm.h' differs from latest version at 'include/uapi/drm/i915_drm.h'
  diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_drm.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/drm/i915_drm.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/include/uapi/drm/i915_drm.h b/tools/include/uapi/drm/i915_drm.h
index 829c0a48577f..2813e579b480 100644
--- a/tools/include/uapi/drm/i915_drm.h
+++ b/tools/include/uapi/drm/i915_drm.h
@@ -1619,6 +1619,27 @@ struct drm_i915_gem_context_param {
  * By default, new contexts allow persistence.
  */
 #define I915_CONTEXT_PARAM_PERSISTENCE	0xb
+
+/*
+ * I915_CONTEXT_PARAM_RINGSIZE:
+ *
+ * Sets the size of the CS ringbuffer to use for logical ring contexts. This
+ * applies a limit of how many batches can be queued to HW before the caller
+ * is blocked due to lack of space for more commands.
+ *
+ * Only reliably possible to be set prior to first use, i.e. during
+ * construction. At any later point, the current execution must be flushed as
+ * the ring can only be changed while the context is idle. Note, the ringsize
+ * can be specified as a constructor property, see
+ * I915_CONTEXT_CREATE_EXT_SETPARAM, but can also be set later if required.
+ *
+ * Only applies to the current set of engine and lost when those engines
+ * are replaced by a new mapping (see I915_CONTEXT_PARAM_ENGINES).
+ *
+ * Must be between 4 - 512 KiB, in intervals of page size [4 KiB].
+ * Default is 16 KiB.
+ */
+#define I915_CONTEXT_PARAM_RINGSIZE	0xc
 /* Must be kept compact -- no holes and well documented */
 
 	__u64 value;
-- 
2.21.1
