From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/23] tools headers UAPI: Sync prctl.h with the kernel sources
Date: Fri, 14 Feb 2020 16:10:44 -0300
Message-ID: <20200214191057.26266-11-acme@kernel.org>
References: <20200214191057.26266-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200214191057.26266-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Christian Brauner <christian.brauner@ubuntu.com>, Mike Christie <mchristi@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get the changes in:

  8d19f1c8e193 ("prctl: PR_{G,S}ET_IO_FLUSHER to support controlling memory reclaim")

Which ends up having this effect in tooling, i.e. the addition of the
support to those prctl's options:

  $ tools/perf/trace/beauty/prctl_option.sh > before
  $ cp include/uapi/linux/prctl.h tools/include/uapi/linux/prctl.h
  $ git diff
  diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prctl.h
  index 7da1b37b27aa..07b4f8131e36 100644
  --- a/tools/include/uapi/linux/prctl.h
  +++ b/tools/include/uapi/linux/prctl.h
  @@ -234,4 +234,8 @@ struct prctl_mm_map {
   #define PR_GET_TAGGED_ADDR_CTRL                56
   # define PR_TAGGED_ADDR_ENABLE         (1UL << 0)

  +/* Control reclaim behavior when allocating memory */
  +#define PR_SET_IO_FLUSHER              57
  +#define PR_GET_IO_FLUSHER              58
  +
   #endif /* _LINUX_PRCTL_H */
  $ tools/perf/trace/beauty/prctl_option.sh > after
  $ diff -u before after
  --- before	2020-02-11 15:24:35.339289912 -0300
  +++ after	2020-02-11 15:24:56.319711315 -0300
  @@ -51,6 +51,8 @@
   	[54] = "PAC_RESET_KEYS",
   	[55] = "SET_TAGGED_ADDR_CTRL",
   	[56] = "GET_TAGGED_ADDR_CTRL",
  +	[57] = "SET_IO_FLUSHER",
  +	[58] = "GET_IO_FLUSHER",
   };
   static const char *prctl_set_mm_options[] = {
   	[1] = "START_CODE",
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mike Christie <mchristi@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/prctl.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prctl.h
index 7da1b37b27aa..07b4f8131e36 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -234,4 +234,8 @@ struct prctl_mm_map {
 #define PR_GET_TAGGED_ADDR_CTRL		56
 # define PR_TAGGED_ADDR_ENABLE		(1UL << 0)
 
+/* Control reclaim behavior when allocating memory */
+#define PR_SET_IO_FLUSHER		57
+#define PR_GET_IO_FLUSHER		58
+
 #endif /* _LINUX_PRCTL_H */
-- 
2.21.1
