From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 68/83] perf inject: Document missing options
Date: Fri, 17 Nov 2017 17:15:46 -0300
Message-ID: <20171117201601.24110-69-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932508AbdKQUT6 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:19:58 -0500
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Sihyeon Jang <uneedsihyeon@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Sihyeon Jang <uneedsihyeon@gmail.com>

Add the missing --force option to the man page.

Signed-off-by: Sihyeon Jang <uneedsihyeon@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/1510842367-11011-1-git-send-email-uneedsihyeon@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-inject.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/Documentation/perf-inject.txt b/tools/perf/Documentation/perf-inject.txt
index 87b2588d1cbd..a64d6588470e 100644
--- a/tools/perf/Documentation/perf-inject.txt
+++ b/tools/perf/Documentation/perf-inject.txt
@@ -60,6 +60,10 @@ include::itrace.txt[]
 	found in the jitdumps files captured in the input perf.data file. Use this option
 	if you are monitoring environment using JIT runtimes, such as Java, DART or V8.
 
+-f::
+--force::
+	Don't complain, do it.
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-report[1], linkperf:perf-archive[1]
-- 
2.13.6
