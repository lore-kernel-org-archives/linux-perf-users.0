From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 5/7] perf tools: Fix syscalltbl build failure
Date: Fri, 29 Sep 2017 13:00:15 -0300
Message-ID: <20170929160017.29335-6-acme@kernel.org>
References: <20170929160017.29335-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170929160017.29335-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Akemi Yagi <amyagi@gmail.com>, Akemi Yagi <toracat@elrepo.org>, Alan Bartlett <ajb@elrepo.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Akemi Yagi <amyagi@gmail.com>

The build of kernel v4.14-rc1 for i686 fails on RHEL 6 with the error
in tools/perf:

  util/syscalltbl.c:157: error: expected ';', ',' or ')' before '__maybe_unused'
  mv: cannot stat `util/.syscalltbl.o.tmp': No such file or directory

Fix it by placing/moving:

  #include <linux/compiler.h>

  outside of #ifdef HAVE_SYSCALL_TABLE block.

Signed-off-by: Akemi Yagi <toracat@elrepo.org>
Cc: Alan Bartlett <ajb@elrepo.org>
Link: http://lkml.kernel.org/r/oq41r8$1v9$1@blaine.gmane.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/syscalltbl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
index 19e5db90394c..6eea7cff3d4e 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -15,9 +15,9 @@
 
 #include "syscalltbl.h"
 #include <stdlib.h>
+#include <linux/compiler.h>
 
 #ifdef HAVE_SYSCALL_TABLE
-#include <linux/compiler.h>
 #include <string.h>
 #include "string2.h"
 #include "util.h"
-- 
2.13.5
