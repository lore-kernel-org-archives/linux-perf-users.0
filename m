From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/86] perf trace: Only build tools/perf/trace/beauty/ when building 'perf trace'
Date: Wed, 19 Jul 2017 10:55:58 -0300
Message-ID: <20170719135717.1285-8-acme@kernel.org>
References: <20170719135717.1285-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753095AbdGSOBa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 Jul 2017 10:01:30 -0400
In-Reply-To: <20170719135717.1285-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>

From: Arnaldo Carvalho de Melo <acme@redhat.com>

As it calls functions in builtin-trace.c.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-bt3lhw1rvy3jzbsp2fvvegb0@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Build b/tools/perf/Build
index bd8eeb60533c..b48ca40fccf9 100644
--- a/tools/perf/Build
+++ b/tools/perf/Build
@@ -50,6 +50,6 @@ libperf-y += util/
 libperf-y += arch/
 libperf-y += ui/
 libperf-y += scripts/
-libperf-y += trace/beauty/
+libperf-$(CONFIG_AUDIT) += trace/beauty/
 
 gtk-y += ui/gtk/
-- 
2.9.4
