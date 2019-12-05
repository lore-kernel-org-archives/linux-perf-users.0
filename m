From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 6/6] tools headers UAPI: Update tools's copy of drm.h headers
Date: Thu,  5 Dec 2019 16:32:24 -0300
Message-ID: <20191205193224.24629-7-acme@kernel.org>
References: <20191205193224.24629-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191205193224.24629-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Chunming Zhou <david1.zhou@amd.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Picking the changes from:

  2093dea3def9 ("drm/syncobj: extend syncobj query ability v3")

Which doesn't affect tooling, just silences this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/drm/drm.h' differs from latest version at 'include/uapi/drm/drm.h'
  diff -u tools/include/uapi/drm/drm.h include/uapi/drm/drm.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Chunming Zhou <david1.zhou@amd.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-t1xqmjffo4rxdw395dsnu34j@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/drm/drm.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/drm/drm.h b/tools/include/uapi/drm/drm.h
index 8a5b2f8f8eb9..868bf7996c0f 100644
--- a/tools/include/uapi/drm/drm.h
+++ b/tools/include/uapi/drm/drm.h
@@ -778,11 +778,12 @@ struct drm_syncobj_array {
 	__u32 pad;
 };
 
+#define DRM_SYNCOBJ_QUERY_FLAGS_LAST_SUBMITTED (1 << 0) /* last available point on timeline syncobj */
 struct drm_syncobj_timeline_array {
 	__u64 handles;
 	__u64 points;
 	__u32 count_handles;
-	__u32 pad;
+	__u32 flags;
 };
 
 
-- 
2.21.0
