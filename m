From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 22/40] perf annotate stdio: Fix --show-total-period
Date: Wed, 26 Jul 2017 11:17:12 -0300
Message-ID: <20170726141730.30750-23-acme@kernel.org>
References: <20170726141730.30750-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751844AbdGZOTu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 26 Jul 2017 10:19:50 -0400
In-Reply-To: <20170726141730.30750-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Taeung Song <treeze.taeung@gmail.com>, Jiri Olsa <jolsa@redhat.com>, =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>, Milian Wolff <milian.wolff@kdab.com>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Taeung Song <treeze.taeung@gmail.com>

We were showing the total number of samples, not the total period as
asked by the user, fix it.

Reported-by: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Martin Liška <mliska@suse.cz>
Cc: Milian Wolff <milian.wolff@kdab.com>
Link: http://lkml.kernel.org/n/tip-lh2nh89rtqn5x5vbfthw6qml@git.kernel.org
Fixes: 0c4a5bcea460 ("perf annotate: Display total number of samples with --show-total-period")
[ split from a larger patch ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 00e085fc945b..004072f82511 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1143,7 +1143,7 @@ static int disasm_line__print(struct disasm_line *dl, struct symbol *sym, u64 st
 
 			if (symbol_conf.show_total_period)
 				color_fprintf(stdout, color, " %7" PRIu64,
-					      sample.nr_samples);
+					      sample.period);
 			else
 				color_fprintf(stdout, color, " %7.2f", percent);
 		}
-- 
2.9.4
