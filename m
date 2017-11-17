From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 73/83] perf buildid-cache: Document missing --force option
Date: Fri, 17 Nov 2017 17:15:51 -0300
Message-ID: <20171117201601.24110-74-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161761AbdKQUUO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:20:14 -0500
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Sihyeon Jang <uneedsihyeon@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Sihyeon Jang <uneedsihyeon@gmail.com>

Add --force to the man page.

Signed-off-by: Sihyeon Jang <uneedsihyeon@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/1510842367-11011-6-git-send-email-uneedsihyeon@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-buildid-cache.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/Documentation/perf-buildid-cache.txt b/tools/perf/Documentation/perf-buildid-cache.txt
index 84681007f80f..73c2650bd0db 100644
--- a/tools/perf/Documentation/perf-buildid-cache.txt
+++ b/tools/perf/Documentation/perf-buildid-cache.txt
@@ -24,6 +24,9 @@ OPTIONS
 -a::
 --add=::
         Add specified file to the cache.
+-f::
+--force::
+	Don't complain, do it.
 -k::
 --kcore::
         Add specified kcore file to the cache. For the current host that is
-- 
2.13.6
