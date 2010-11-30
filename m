From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: [PATCH] perf-tools: Don't assume there's no attr info if no sample ids is provided
Date: Tue, 30 Nov 2010 12:50:14 +0100
Message-ID: <m3mxor6nex.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48904 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751178Ab0K3LuW (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 30 Nov 2010 06:50:22 -0500
Received: by wwa36 with SMTP id 36so5963848wwa.1
        for <linux-perf-users@vger.kernel.org>; Tue, 30 Nov 2010 03:50:21 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

From: Franck Bui-Huu <fbuihuu@gmail.com>

This primarily fixes perf-report, which didn't report the correct type
of event if perf-record was called to record one event different from
'cycles':

  $ perf record -e instructions true
    [ perf record: Woken up 1 times to write data ]
    [ perf record: Captured and wrote 0.007 MB perf.data (~295 samples) ]

  $ perf report | head -n1
    # Events: 7  cycles

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 tools/perf/util/header.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index d7e67b1..64a85ba 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -946,11 +946,16 @@ perf_header__find_attr(u64 id, struct perf_header *header)
 
 	/*
 	 * We set id to -1 if the data file doesn't contain sample
-	 * ids. Check for this and avoid walking through the entire
-	 * list of ids which may be large.
+	 * ids. This can happen when the data file contains one type
+	 * of event and in that case, the header can still store the
+	 * event attribute information. Check for this and avoid
+	 * walking through the entire list of ids which may be large.
 	 */
-	if (id == -1ULL)
+	if (id == -1ULL) {
+		if (header->attrs > 0)
+			return &header->attr[0]->attr;
 		return NULL;
+	}
 
 	for (i = 0; i < header->attrs; i++) {
 		struct perf_header_attr *attr = header->attr[i];
-- 
1.7.3.2
