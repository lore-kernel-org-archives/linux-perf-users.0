From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 20/21] perf data: Document missing --force option
Date: Tue,  6 Feb 2018 13:53:49 -0300
Message-ID: <20180206165350.2570-21-acme@kernel.org>
References: <20180206165350.2570-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753199AbeBFQy5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 6 Feb 2018 11:54:57 -0500
In-Reply-To: <20180206165350.2570-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Sangwon Hong <qpakzk@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Taeung Song <treeze.taeung@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Sangwon Hong <qpakzk@gmail.com>

Add the --force option to the man page.

Signed-off-by: Sangwon Hong <qpakzk@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Taeung Song <treeze.taeung@gmail.com>
Link: http://lkml.kernel.org/r/1517831315-31490-1-git-send-email-qpakzk@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-data.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/Documentation/perf-data.txt b/tools/perf/Documentation/perf-data.txt
index f0796a47dfa3..90bb4aabe4f8 100644
--- a/tools/perf/Documentation/perf-data.txt
+++ b/tools/perf/Documentation/perf-data.txt
@@ -30,6 +30,10 @@ OPTIONS for 'convert'
 -i::
 	Specify input perf data file path.
 
+-f::
+--force::
+	Don't complain, do it.
+
 -v::
 --verbose::
         Be more verbose (show counter open errors, etc).
-- 
2.14.3
