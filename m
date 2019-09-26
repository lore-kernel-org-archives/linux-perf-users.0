From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 14/66] tools: Add missing stdio.h include to asm/bug.h header
Date: Wed, 25 Sep 2019 21:31:52 -0300
Message-ID: <20190926003244.13962-15-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

We have a direct fprintf() call in the header, so we need stdio.h
include, otherwise it could fail compilation if there's no prior stdio.h
include directive.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/n/tip-8hvjgh24olfsa4non0a3ohnq@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/asm/bug.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/asm/bug.h b/tools/include/asm/bug.h
index bbd75ac8b202..550223f0a6e6 100644
--- a/tools/include/asm/bug.h
+++ b/tools/include/asm/bug.h
@@ -3,6 +3,7 @@
 #define _TOOLS_ASM_BUG_H
 
 #include <linux/compiler.h>
+#include <stdio.h>
 
 #define __WARN_printf(arg...)	do { fprintf(stderr, arg); } while (0)
 
-- 
2.21.0
