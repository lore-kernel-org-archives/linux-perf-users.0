From: Andrew Vagin <avagin@openvz.org>
Subject: [PATCH 1/6] perf: use event_name() to get an event name
Date: Wed,  7 Dec 2011 16:55:56 +0300
Message-ID: <1323266161-394927-2-git-send-email-avagin@openvz.org>
References: <1323266161-394927-1-git-send-email-avagin@openvz.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mailhub.sw.ru ([195.214.232.25]:9427 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756177Ab1LGN6G (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 7 Dec 2011 08:58:06 -0500
In-Reply-To: <1323266161-394927-1-git-send-email-avagin@openvz.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: acme@ghostprotocols.net
Cc: linux-kernel@vger.kernel.org, a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu, asharma@fb.com, devel@openvz.org, dsahern@gmail.com, linux-perf-users@vger.kernel.org

perf_evsel.name may be not initialized

Signed-off-by: Andrew Vagin <avagin@openvz.org>
---
 tools/perf/util/header.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 9272f3a..5b01449 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -388,7 +388,7 @@ static int write_event_desc(int fd, struct perf_header *h __used,
 		/*
 		 * write event string as passed on cmdline
 		 */
-		ret = do_write_string(fd, attr->name);
+		ret = do_write_string(fd, event_name(attr));
 		if (ret < 0)
 			return ret;
 		/*
-- 
1.7.1
