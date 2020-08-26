From: Al Grant <al.grant@foss.arm.com>
Subject: [PATCH] perf inject: correct event attribute sizes
Date: Wed, 26 Aug 2020 10:42:04 +0100
Message-ID: <b5f9e19c-6adb-ccdd-3dbd-df8e1b82ee93@foss.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com
List-Id: linux-perf-users.vger.kernel.org

When perf inject reads a perf.data file from an older version of perf,
it writes event attributes into the output with the original size field,
but lays them out as if they had the size currently used. Readers see
a corrupt file. Update the size field to match the layout.

From: Denis Nikitin <denik@google.com>
Signed-off-by: Al Grant <al.grant@foss.arm.com>

  tools/perf/util/header.c | 8 ++++++++
  1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 9cf4efdcbbbd..762eb94bd532 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3326,6 +3326,14 @@ int perf_session__write_header(struct
perf_session *session,
         attr_offset = lseek(ff.fd, 0, SEEK_CUR);

         evlist__for_each_entry(evlist, evsel) {
+               if (evsel->core.attr.size < sizeof(evsel->core.attr)) {
+                       /*
+                        * We are likely in "perf inject" and have read 
+                        * from an older file. Update attr size so that
+                        * reader gets the right offset to the ids.
+                        */
+                       evsel->core.attr.size = sizeof(evsel->core.attr);
+               }
                 f_attr = (struct perf_file_attr){
                         .attr = evsel->core.attr,
                         .ids  = {
