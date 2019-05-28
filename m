From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/14] tools headers UAPI: Sync drm/drm.h with the kernel
Date: Tue, 28 May 2019 14:50:14 -0300
Message-ID: <20190528175020.13343-9-acme@kernel.org>
References: <20190528175020.13343-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190528175020.13343-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Lionel Landwerlin <lionel.g.landwerlin@intel.com>, Adrian Hunter <adrian.hunter@intel.com>, Brendan Gregg <brendan.d.gregg@gmail.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Chunming Zhou <david1.zhou@amd.com>, Dave Airlie <airlied@redhat.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick up the changes in these csets:

  060cebb20cdb ("drm: introduce a capability flag for syncobj timeline support")
  50d1ebef79ef ("drm/syncobj: add timeline signal ioctl for syncobj v5")
  ea569910cbab ("drm/syncobj: add transition iotcls between binary and timeline v2")
  27b575a9aa2f ("drm/syncobj: add timeline payload query ioctl v6")
  01d6c3578379 ("drm/syncobj: add support for timeline point wait v8")
  783195ec1cad ("drm/syncobj: disable the timeline UAPI for now v2")
  48197bc564c7 ("drm: add syncobj timeline support v9")

Which automagically results in the following new ioctls being recognized
by the 'perf trace' ioctl cmd arg beautifier:

  $ tools/perf/trace/beauty/drm_ioctl.sh > /tmp/before
  $ cp include/uapi/drm/drm.h tools/include/uapi/drm/drm.h
  $ tools/perf/trace/beauty/drm_ioctl.sh > /tmp/after
  $ diff -u /tmp/before /tmp/after
  --- /tmp/before	2019-05-22 10:25:31.443151182 -0300
  +++ /tmp/after	2019-05-22 10:25:46.449354819 -0300
  @@ -103,6 +103,10 @@
   	[0xC7] = "MODE_LIST_LESSEES",
   	[0xC8] = "MODE_GET_LEASE",
   	[0xC9] = "MODE_REVOKE_LEASE",
  +	[0xCA] = "SYNCOBJ_TIMELINE_WAIT",
  +	[0xCB] = "SYNCOBJ_QUERY",
  +	[0xCC] = "SYNCOBJ_TRANSFER",
  +	[0xCD] = "SYNCOBJ_TIMELINE_SIGNAL",
   	[DRM_COMMAND_BASE + 0x00] = "I915_INIT",
   	[DRM_COMMAND_BASE + 0x01] = "I915_FLUSH",
   	[DRM_COMMAND_BASE + 0x02] = "I915_FLIP",
    $

I.e. the strace like raw_tracepoint:sys_enter handler in 'perf trace'
will get the cmd integer value and map it to the string.

At some point it should be possible to translate from string to integer
and use to filter using expressions such as:

   # perf trace -e ioctl/cmd==DRM_IOCTL_SYNCOBJ*/

Or some more suitable syntax to express that only these ioctls when
acting on DRM fds should be shown.

Acked-by: Lionel Landwerlin <lionel.g.landwerlin@intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Chunming Zhou <david1.zhou@amd.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-jrc9ogw33w4zgqc3pu7o1l3g@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/drm/drm.h | 37 ++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/include/uapi/drm/drm.h b/tools/include/uapi/drm/drm.h
index 300f336633f2..661d73f9a919 100644
--- a/tools/include/uapi/drm/drm.h
+++ b/tools/include/uapi/drm/drm.h
@@ -649,6 +649,7 @@ struct drm_gem_open {
 #define DRM_CAP_PAGE_FLIP_TARGET	0x11
 #define DRM_CAP_CRTC_IN_VBLANK_EVENT	0x12
 #define DRM_CAP_SYNCOBJ		0x13
+#define DRM_CAP_SYNCOBJ_TIMELINE	0x14
 
 /** DRM_IOCTL_GET_CAP ioctl argument type */
 struct drm_get_cap {
@@ -735,8 +736,18 @@ struct drm_syncobj_handle {
 	__u32 pad;
 };
 
+struct drm_syncobj_transfer {
+	__u32 src_handle;
+	__u32 dst_handle;
+	__u64 src_point;
+	__u64 dst_point;
+	__u32 flags;
+	__u32 pad;
+};
+
 #define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL (1 << 0)
 #define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT (1 << 1)
+#define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE (1 << 2) /* wait for time point to become available */
 struct drm_syncobj_wait {
 	__u64 handles;
 	/* absolute timeout */
@@ -747,12 +758,33 @@ struct drm_syncobj_wait {
 	__u32 pad;
 };
 
+struct drm_syncobj_timeline_wait {
+	__u64 handles;
+	/* wait on specific timeline point for every handles*/
+	__u64 points;
+	/* absolute timeout */
+	__s64 timeout_nsec;
+	__u32 count_handles;
+	__u32 flags;
+	__u32 first_signaled; /* only valid when not waiting all */
+	__u32 pad;
+};
+
+
 struct drm_syncobj_array {
 	__u64 handles;
 	__u32 count_handles;
 	__u32 pad;
 };
 
+struct drm_syncobj_timeline_array {
+	__u64 handles;
+	__u64 points;
+	__u32 count_handles;
+	__u32 pad;
+};
+
+
 /* Query current scanout sequence number */
 struct drm_crtc_get_sequence {
 	__u32 crtc_id;		/* requested crtc_id */
@@ -909,6 +941,11 @@ extern "C" {
 #define DRM_IOCTL_MODE_GET_LEASE	DRM_IOWR(0xC8, struct drm_mode_get_lease)
 #define DRM_IOCTL_MODE_REVOKE_LEASE	DRM_IOWR(0xC9, struct drm_mode_revoke_lease)
 
+#define DRM_IOCTL_SYNCOBJ_TIMELINE_WAIT	DRM_IOWR(0xCA, struct drm_syncobj_timeline_wait)
+#define DRM_IOCTL_SYNCOBJ_QUERY		DRM_IOWR(0xCB, struct drm_syncobj_timeline_array)
+#define DRM_IOCTL_SYNCOBJ_TRANSFER	DRM_IOWR(0xCC, struct drm_syncobj_transfer)
+#define DRM_IOCTL_SYNCOBJ_TIMELINE_SIGNAL	DRM_IOWR(0xCD, struct drm_syncobj_timeline_array)
+
 /**
  * Device specific ioctls should only be in their respective headers
  * The device specific ioctl range is from 0x40 to 0x9f.
-- 
2.20.1
