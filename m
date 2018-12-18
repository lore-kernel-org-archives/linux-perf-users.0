From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/63] perf dso: Export data_file_size() method there are no symbols
Date: Tue, 18 Dec 2018 19:06:31 -0300
Message-ID: <20181218220733.15839-2-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Will be used outside dso.c in a followup patch, so rename it and make it
non-static.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20181127084634.12469-1-adrian.hunter@intel.com
[ split from a larger patch ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 6 +++---
 tools/perf/util/dso.h | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index cee717a3794f..62c8cf622607 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -894,7 +894,7 @@ static ssize_t cached_read(struct dso *dso, struct machine *machine,
 	return r;
 }
 
-static int data_file_size(struct dso *dso, struct machine *machine)
+int dso__data_file_size(struct dso *dso, struct machine *machine)
 {
 	int ret = 0;
 	struct stat st;
@@ -943,7 +943,7 @@ static int data_file_size(struct dso *dso, struct machine *machine)
  */
 off_t dso__data_size(struct dso *dso, struct machine *machine)
 {
-	if (data_file_size(dso, machine))
+	if (dso__data_file_size(dso, machine))
 		return -1;
 
 	/* For now just estimate dso data size is close to file size */
@@ -953,7 +953,7 @@ off_t dso__data_size(struct dso *dso, struct machine *machine)
 static ssize_t data_read_offset(struct dso *dso, struct machine *machine,
 				u64 offset, u8 *data, ssize_t size)
 {
-	if (data_file_size(dso, machine))
+	if (dso__data_file_size(dso, machine))
 		return -1;
 
 	/* Check the offset sanity. */
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index c5380500bed4..8c8a7abe809d 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -322,6 +322,7 @@ int dso__data_get_fd(struct dso *dso, struct machine *machine);
 void dso__data_put_fd(struct dso *dso);
 void dso__data_close(struct dso *dso);
 
+int dso__data_file_size(struct dso *dso, struct machine *machine);
 off_t dso__data_size(struct dso *dso, struct machine *machine);
 ssize_t dso__data_read_offset(struct dso *dso, struct machine *machine,
 			      u64 offset, u8 *data, ssize_t size);
-- 
2.19.2
