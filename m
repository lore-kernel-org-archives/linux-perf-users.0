From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 30/36] perf c2c: Add a tip about cacheline events
Date: Wed,  6 Dec 2017 11:41:09 -0300
Message-ID: <20171206144115.15097-31-acme@kernel.org>
References: <20171206144115.15097-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752498AbdLFOn1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 6 Dec 2017 09:43:27 -0500
In-Reply-To: <20171206144115.15097-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Sangwon Hong <qpakzk@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Sangwon Hong <qpakzk@gmail.com>

Signed-off-by: Sangwon Hong <qpakzk@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/1512188201-14109-1-git-send-email-qpakzk@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/tips.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/Documentation/tips.txt b/tools/perf/Documentation/tips.txt
index 3dd1dbe28407..849599f39c5e 100644
--- a/tools/perf/Documentation/tips.txt
+++ b/tools/perf/Documentation/tips.txt
@@ -33,3 +33,4 @@ System-wide collection from all CPUs: perf record -a
 Show current config key-value pairs: perf config --list
 Show user configuration overrides: perf config --user --list
 To add Node.js USDT(User-Level Statically Defined Tracing): perf buildid-cache --add `which node`
+To report cacheline events from previous recording: perf c2c report
-- 
2.13.6
