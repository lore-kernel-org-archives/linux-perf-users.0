From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 1/9] perf kallsyms: Fix the usage on the man page
Date: Tue,  6 Mar 2018 14:23:35 -0300
Message-ID: <20180306172343.16546-2-acme@kernel.org>
References: <20180306172343.16546-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180306172343.16546-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Sangwon Hong <qpakzk@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Taeung Song <treeze.taeung@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Sangwon Hong <qpakzk@gmail.com>

First, all man pages highlight only perf and subcommands except 'perf
kallsyms', which includes the full usage. Fix it for commands to
monopolize underlines.

Second, options can be ommited when executing 'perf kallsyms', so add
square brackets between <option>.

Signed-off-by: Sangwon Hong <qpakzk@gmail.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Taeung Song <treeze.taeung@gmail.com>
Link: http://lkml.kernel.org/r/1518377864-20353-1-git-send-email-qpakzk@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-kallsyms.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-kallsyms.txt b/tools/perf/Documentation/perf-kallsyms.txt
index 954ea9e21236..cf9f4040ea5c 100644
--- a/tools/perf/Documentation/perf-kallsyms.txt
+++ b/tools/perf/Documentation/perf-kallsyms.txt
@@ -8,7 +8,7 @@ perf-kallsyms - Searches running kernel for symbols
 SYNOPSIS
 --------
 [verse]
-'perf kallsyms <options> symbol_name[,symbol_name...]'
+'perf kallsyms' [<options>] symbol_name[,symbol_name...]
 
 DESCRIPTION
 -----------
-- 
2.14.3
