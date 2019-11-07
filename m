From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/63] perf data: Move perf_dir_version into data.h
Date: Thu,  7 Nov 2019 15:59:10 -0300
Message-ID: <20191107190011.23924-3-acme@kernel.org>
References: <20191107190011.23924-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191107190011.23924-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

perf_dir_version belongs to struct perf_data which is declared in data.h.
To allow its use in inline perf_data functions, move perf_dir_version to
data.h

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lore.kernel.org/lkml/20191004083121.12182-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/data.h   | 4 ++++
 tools/perf/util/header.h | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
index 259868a39019..218fe9a16801 100644
--- a/tools/perf/util/data.h
+++ b/tools/perf/util/data.h
@@ -9,6 +9,10 @@ enum perf_data_mode {
 	PERF_DATA_MODE_READ,
 };
 
+enum perf_dir_version {
+	PERF_DIR_VERSION	= 1,
+};
+
 struct perf_data_file {
 	char		*path;
 	int		 fd;
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index ca53a929e9fd..840f95cee349 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -52,10 +52,6 @@ enum perf_header_version {
 	PERF_HEADER_VERSION_2,
 };
 
-enum perf_dir_version {
-	PERF_DIR_VERSION	= 1,
-};
-
 struct perf_file_section {
 	u64 offset;
 	u64 size;
-- 
2.21.0
