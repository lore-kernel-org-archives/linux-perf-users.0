From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 3/7] tools headers uapi: Update tools's copy of drm/drm.h
Date: Wed, 12 Sep 2018 15:55:05 -0300
Message-ID: <20180912185509.32187-4-acme@kernel.org>
References: <20180912185509.32187-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180912185509.32187-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Brian Starkey <brian.starkey@arm.com>, David Ahern <dsahern@gmail.com>, Eric Anholt <eric@anholt.net>, Jiri Olsa <jolsa@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Sean Paul <seanpaul@chromium.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get the changes in:

	d67b6a206507 ("drm: writeback: Add client capability for exposing writeback connectors")

This is for an argument to a DRM ioctl, which is not being prettyfied in
the 'perf trace' DRM ioctl beautifier, but will now that syscalls are
starting to have pointer arguments augmented via BPF.

This time around this just cures the following warning during perf's
build:

	Warning: Kernel ABI header at 'tools/include/uapi/drm/drm.h' differs from latest version at 'include/uapi/drm/drm.h'
	diff -u tools/include/uapi/drm/drm.h include/uapi/drm/drm.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Brian Starkey <brian.starkey@arm.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Eric Anholt <eric@anholt.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sean Paul <seanpaul@chromium.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-n7qib1bac6mc6w9oke7r4qdc@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/drm/drm.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/include/uapi/drm/drm.h b/tools/include/uapi/drm/drm.h
index 9c660e1688ab..300f336633f2 100644
--- a/tools/include/uapi/drm/drm.h
+++ b/tools/include/uapi/drm/drm.h
@@ -687,6 +687,15 @@ struct drm_get_cap {
  */
 #define DRM_CLIENT_CAP_ASPECT_RATIO    4
 
+/**
+ * DRM_CLIENT_CAP_WRITEBACK_CONNECTORS
+ *
+ * If set to 1, the DRM core will expose special connectors to be used for
+ * writing back to memory the scene setup in the commit. Depends on client
+ * also supporting DRM_CLIENT_CAP_ATOMIC
+ */
+#define DRM_CLIENT_CAP_WRITEBACK_CONNECTORS	5
+
 /** DRM_IOCTL_SET_CLIENT_CAP ioctl argument type */
 struct drm_set_client_cap {
 	__u64 capability;
-- 
2.14.4
