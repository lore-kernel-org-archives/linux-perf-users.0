From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 25/30] tools headers uapi: Synchronize drm/drm.h
Date: Tue, 28 Nov 2017 12:02:15 -0300
Message-ID: <20171128150220.5064-26-acme@kernel.org>
References: <20171128150220.5064-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171128150220.5064-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Dave Airlie <airlied@redhat.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Keith Packard <keithp@keithp.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick up the new ioctls added in these csets:

  3064abfa932b ("drm: Add CRTC_GET_SEQUENCE and CRTC_QUEUE_SEQUENCE ioctls [v3]")
  62884cd386b8 ("drm: Add four ioctls for managing drm mode object leases [v7]")

That will be automatically decoded (the ioctl cmd parameter, the structs
will be supported when we start using eBPF for that, which is in the
works).

This silences this warning when building tools/perf:

  Warning: Kernel ABI header at 'tools/include/uapi/drm/drm.h' differs from latest version at 'include/uapi/drm/drm.h'

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Keith Packard <keithp@keithp.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-bivwf1pkfmi1ugpswbsxd9e9@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/drm/drm.h | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/include/uapi/drm/drm.h b/tools/include/uapi/drm/drm.h
index 97677cd6964d..6fdff5945c8a 100644
--- a/tools/include/uapi/drm/drm.h
+++ b/tools/include/uapi/drm/drm.h
@@ -737,6 +737,28 @@ struct drm_syncobj_array {
 	__u32 pad;
 };
 
+/* Query current scanout sequence number */
+struct drm_crtc_get_sequence {
+	__u32 crtc_id;		/* requested crtc_id */
+	__u32 active;		/* return: crtc output is active */
+	__u64 sequence;		/* return: most recent vblank sequence */
+	__s64 sequence_ns;	/* return: most recent time of first pixel out */
+};
+
+/* Queue event to be delivered at specified sequence. Time stamp marks
+ * when the first pixel of the refresh cycle leaves the display engine
+ * for the display
+ */
+#define DRM_CRTC_SEQUENCE_RELATIVE		0x00000001	/* sequence is relative to current */
+#define DRM_CRTC_SEQUENCE_NEXT_ON_MISS		0x00000002	/* Use next sequence if we've missed */
+
+struct drm_crtc_queue_sequence {
+	__u32 crtc_id;
+	__u32 flags;
+	__u64 sequence;		/* on input, target sequence. on output, actual sequence */
+	__u64 user_data;	/* user data passed to event */
+};
+
 #if defined(__cplusplus)
 }
 #endif
@@ -819,6 +841,9 @@ extern "C" {
 
 #define DRM_IOCTL_WAIT_VBLANK		DRM_IOWR(0x3a, union drm_wait_vblank)
 
+#define DRM_IOCTL_CRTC_GET_SEQUENCE	DRM_IOWR(0x3b, struct drm_crtc_get_sequence)
+#define DRM_IOCTL_CRTC_QUEUE_SEQUENCE	DRM_IOWR(0x3c, struct drm_crtc_queue_sequence)
+
 #define DRM_IOCTL_UPDATE_DRAW		DRM_IOW(0x3f, struct drm_update_draw)
 
 #define DRM_IOCTL_MODE_GETRESOURCES	DRM_IOWR(0xA0, struct drm_mode_card_res)
@@ -863,6 +888,11 @@ extern "C" {
 #define DRM_IOCTL_SYNCOBJ_RESET		DRM_IOWR(0xC4, struct drm_syncobj_array)
 #define DRM_IOCTL_SYNCOBJ_SIGNAL	DRM_IOWR(0xC5, struct drm_syncobj_array)
 
+#define DRM_IOCTL_MODE_CREATE_LEASE	DRM_IOWR(0xC6, struct drm_mode_create_lease)
+#define DRM_IOCTL_MODE_LIST_LESSEES	DRM_IOWR(0xC7, struct drm_mode_list_lessees)
+#define DRM_IOCTL_MODE_GET_LEASE	DRM_IOWR(0xC8, struct drm_mode_get_lease)
+#define DRM_IOCTL_MODE_REVOKE_LEASE	DRM_IOWR(0xC9, struct drm_mode_revoke_lease)
+
 /**
  * Device specific ioctls should only be in their respective headers
  * The device specific ioctl range is from 0x40 to 0x9f.
@@ -893,6 +923,7 @@ struct drm_event {
 
 #define DRM_EVENT_VBLANK 0x01
 #define DRM_EVENT_FLIP_COMPLETE 0x02
+#define DRM_EVENT_CRTC_SEQUENCE	0x03
 
 struct drm_event_vblank {
 	struct drm_event base;
@@ -903,6 +934,16 @@ struct drm_event_vblank {
 	__u32 crtc_id; /* 0 on older kernels that do not support this */
 };
 
+/* Event delivered at sequence. Time stamp marks when the first pixel
+ * of the refresh cycle leaves the display engine for the display
+ */
+struct drm_event_crtc_sequence {
+	struct drm_event	base;
+	__u64			user_data;
+	__s64			time_ns;
+	__u64			sequence;
+};
+
 /* typedef area */
 #ifndef __KERNEL__
 typedef struct drm_clip_rect drm_clip_rect_t;
-- 
2.13.6
