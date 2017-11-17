From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 66/83] perf lock: Document missing options
Date: Fri, 17 Nov 2017 17:15:44 -0300
Message-ID: <20171117201601.24110-67-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753198AbdKQUTu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:19:50 -0500
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Sihyeon Jang <uneedsihyeon@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Sihyeon Jang <uneedsihyeon@gmail.com>

Add man page entry for --force.

Signed-off-by: Sihyeon Jang <uneedsihyeon@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/1510837609-6277-1-git-send-email-uneedsihyeon@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-lock.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
index ab25be28c9dc..74d774592196 100644
--- a/tools/perf/Documentation/perf-lock.txt
+++ b/tools/perf/Documentation/perf-lock.txt
@@ -42,6 +42,10 @@ COMMON OPTIONS
 --dump-raw-trace::
         Dump raw trace in ASCII.
 
+-f::
+--force::
+	Don't complan, do it.
+
 REPORT OPTIONS
 --------------
 
-- 
2.13.6
