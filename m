From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/30] perf help: Fix a bug during strstart() conversion
Date: Tue, 28 Nov 2017 12:01:58 -0300
Message-ID: <20171128150220.5064-9-acme@kernel.org>
References: <20171128150220.5064-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753086AbdK1PC5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Nov 2017 10:02:57 -0500
In-Reply-To: <20171128150220.5064-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Sihyeon Jang <uneedsihyeon@gmail.com>, kernel-team@lge.com, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Namhyung Kim <namhyung@kernel.org>

The commit 8e99b6d4533c changed prefixcmp() to strstart() but missed to
change the return value in some place.  It makes perf help print
annoying output even for sane config items like below:

  $ perf help
  '.root': unsupported man viewer sub key.
  ...

Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Taeung Song <treeze.taeung@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Sihyeon Jang <uneedsihyeon@gmail.com>
Cc: kernel-team@lge.com
Link: http://lkml.kernel.org/r/20171114001542.GA16464@sejong
Fixes: 8e99b6d4533c ("tools include: Adopt strstarts() from the kernel")
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-help.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-help.c b/tools/perf/builtin-help.c
index bd1fedef3d1c..a0f7ed2b869b 100644
--- a/tools/perf/builtin-help.c
+++ b/tools/perf/builtin-help.c
@@ -284,7 +284,7 @@ static int perf_help_config(const char *var, const char *value, void *cb)
 		add_man_viewer(value);
 		return 0;
 	}
-	if (!strstarts(var, "man."))
+	if (strstarts(var, "man."))
 		return add_man_viewer_info(var, value);
 
 	return 0;
@@ -314,7 +314,7 @@ static const char *cmd_to_page(const char *perf_cmd)
 
 	if (!perf_cmd)
 		return "perf";
-	else if (!strstarts(perf_cmd, "perf"))
+	else if (strstarts(perf_cmd, "perf"))
 		return perf_cmd;
 
 	return asprintf(&s, "perf-%s", perf_cmd) < 0 ? NULL : s;
-- 
2.13.6
