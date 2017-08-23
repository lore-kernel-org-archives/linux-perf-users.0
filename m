From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/15] perf tools: Really install manpages via 'make install-man'
Date: Wed, 23 Aug 2017 16:36:11 -0300
Message-ID: <20170823193614.20394-13-acme@kernel.org>
References: <20170823193614.20394-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170823193614.20394-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Borislav Petkov <borislav.petkov@amd.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Target install-man builds them but forget to install.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Borislav Petkov <borislav.petkov@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: af3df2cf17f5 ("perf tools: Try to build Documentation when installing")
Link: http://lkml.kernel.org/r/150322915300.129715.13645857235229756834.stgit@buzz
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/Makefile b/tools/perf/Documentation/Makefile
index 098cfb9ca8f0..db11478e30b4 100644
--- a/tools/perf/Documentation/Makefile
+++ b/tools/perf/Documentation/Makefile
@@ -192,7 +192,7 @@ do-install-man: man
 #		$(INSTALL) -m 644 $(DOC_MAN5) $(DESTDIR)$(man5dir); \
 #		$(INSTALL) -m 644 $(DOC_MAN7) $(DESTDIR)$(man7dir)
 
-install-man: check-man-tools man
+install-man: check-man-tools man do-install-man
 
 ifdef missing_tools
   DO_INSTALL_MAN = $(warning Please install $(missing_tools) to have the man pages installed)
-- 
2.13.5
