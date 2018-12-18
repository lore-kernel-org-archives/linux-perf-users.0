From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 15/63] perf header: Fix up argument to ctime()
Date: Tue, 18 Dec 2018 19:06:45 -0300
Message-ID: <20181218220733.15839-16-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Reducing this noise when cross building to the Android NDK:

  util/header.c: In function 'perf_header__fprintf_info':
  util/header.c:2710:45: warning: pointer targets in passing argument 1 of 'ctime' differ in signedness [-Wpointer-sign]
    fprintf(fp, "# captured on    : %s", ctime(&st.st_ctime));
                                               ^
  In file included from util/../perf.h:5:0,
                   from util/evlist.h:11,
                   from util/header.c:22:
  /opt/android-ndk-r15c/platforms/android-26/arch-arm/usr/include/time.h:81:14: note: expected 'const time_t *' but argument is of type 'long unsigned int *'
   extern char* ctime(const time_t*) __LIBC_ABI_PUBLIC__;
                ^

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-6bz74zp080yhmtiwb36enso9@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 1171d8400bf4..dec6d218c31c 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2698,6 +2698,7 @@ int perf_header__fprintf_info(struct perf_session *session, FILE *fp, bool full)
 	struct perf_header *header = &session->header;
 	int fd = perf_data__fd(session->data);
 	struct stat st;
+	time_t stctime;
 	int ret, bit;
 
 	hd.fp = fp;
@@ -2707,7 +2708,8 @@ int perf_header__fprintf_info(struct perf_session *session, FILE *fp, bool full)
 	if (ret == -1)
 		return -1;
 
-	fprintf(fp, "# captured on    : %s", ctime(&st.st_ctime));
+	stctime = st.st_ctime;
+	fprintf(fp, "# captured on    : %s", ctime(&stctime));
 
 	fprintf(fp, "# header version : %u\n", header->version);
 	fprintf(fp, "# data offset    : %" PRIu64 "\n", header->data_offset);
-- 
2.19.2
