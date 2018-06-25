From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/19] tools headers uapi: Synchronize drm/drm.h
Date: Mon, 25 Jun 2018 14:40:33 -0300
Message-ID: <20180625174045.25765-8-acme@kernel.org>
References: <20180625174045.25765-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180625174045.25765-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Ankit Nautiyal <ankit.k.nautiyal@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick up the new ioctls added in these csets:

  7595bda2fb43 ("drm: Add DRM client cap for aspect-ratio")

The DRM caps are not yet being decoded in 'perf trace', so this sync
doesn't incur in any change in behaviour in any tools, just silencing
this tools/perf/ build warning:

	Warning: Kernel ABI header at 'tools/include/uapi/drm/drm.h' differs from latest version at 'include/uapi/drm/drm.h'

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-atwz0arwanq1npu8pptwkoxt@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/drm/drm.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/include/uapi/drm/drm.h b/tools/include/uapi/drm/drm.h
index 6fdff5945c8a..9c660e1688ab 100644
--- a/tools/include/uapi/drm/drm.h
+++ b/tools/include/uapi/drm/drm.h
@@ -680,6 +680,13 @@ struct drm_get_cap {
  */
 #define DRM_CLIENT_CAP_ATOMIC	3
 
+/**
+ * DRM_CLIENT_CAP_ASPECT_RATIO
+ *
+ * If set to 1, the DRM core will provide aspect ratio information in modes.
+ */
+#define DRM_CLIENT_CAP_ASPECT_RATIO    4
+
 /** DRM_IOCTL_SET_CLIENT_CAP ioctl argument type */
 struct drm_set_client_cap {
 	__u64 capability;
-- 
2.14.3
