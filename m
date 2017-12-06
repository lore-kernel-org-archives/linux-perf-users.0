From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/36] perf buildid-cache: Document for Node.js USDT
Date: Wed,  6 Dec 2017 11:40:45 -0300
Message-ID: <20171206144115.15097-7-acme@kernel.org>
References: <20171206144115.15097-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752682AbdLFOl5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 6 Dec 2017 09:41:57 -0500
In-Reply-To: <20171206144115.15097-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Hansuk Hong <flavono123@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Hansuk Hong <flavono123@gmail.com>

Add a tip for Node.js USDT(User-Level Statically Defined Tracing) probes
in tips.txt

Signed-off-by: Hansuk Hong <flavono123@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20171123160546.9722-1-flavono123@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/tips.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/Documentation/tips.txt b/tools/perf/Documentation/tips.txt
index db0ca3063eae..3dd1dbe28407 100644
--- a/tools/perf/Documentation/tips.txt
+++ b/tools/perf/Documentation/tips.txt
@@ -32,3 +32,4 @@ Order by the overhead of source file name and line number: perf report -s srclin
 System-wide collection from all CPUs: perf record -a
 Show current config key-value pairs: perf config --list
 Show user configuration overrides: perf config --user --list
+To add Node.js USDT(User-Level Statically Defined Tracing): perf buildid-cache --add `which node`
-- 
2.13.6
