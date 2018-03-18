From: Martin Vuille <jpmv27@aim.com>
Subject: [PATCH RESEND] perf unwind: Report error from dwfl_attach_state
Date: Sun, 18 Mar 2018 13:50:53 -0400
Message-ID: <20180318175053.4222-1-jpmv27@aim.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Martin Vuille <jpmv27@aim.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

In verbose level 2, errors returned by libdw are reported in most cases,
but not when calling dwfl_attach_state.

Since elfutils v 0.160 (2014), dwfl_attach_state sets the error code to
report failure cause. On failure, log the reported error.

Signed-off-by: Martin Vuille <jpmv27@aim.com>
---
 tools/perf/util/unwind-libdw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index 8e969f28cc59..7bdd239c795c 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -236,7 +236,8 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
 	if (err)
 		goto out;
 
-	if (!dwfl_attach_state(ui->dwfl, EM_NONE, thread->tid, &callbacks, ui))
+	err = !dwfl_attach_state(ui->dwfl, EM_NONE, thread->tid, &callbacks, ui);
+	if (err)
 		goto out;
 
 	err = dwfl_getthread_frames(ui->dwfl, thread->tid, frame_callback, ui);
-- 
2.13.6
