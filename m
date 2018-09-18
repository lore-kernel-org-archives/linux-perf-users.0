From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 2/2] perf Documentation: Fix out-of-tree asciidoctor man page generation
Date: Tue, 18 Sep 2018 12:37:25 -0300
Message-ID: <20180918153725.7022-3-acme@kernel.org>
References: <20180918153725.7022-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180918153725.7022-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Ben Hutchings <ben@decadent.org.uk>

The dependency for the man page rule using asciidoctor incorrectly
specifies a source file in $(OUTPUT).  When building out-of-tree, the
source file is not found, resulting in a fall-back to the following rule
which uses xmlto.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180916151704.GF4765@decadent.org.uk
Fixes: ffef80ecf89f ("perf Documentation: Support for asciidoctor")
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/Makefile b/tools/perf/Documentation/Makefile
index 42261a9b280e..ac841bc5c35b 100644
--- a/tools/perf/Documentation/Makefile
+++ b/tools/perf/Documentation/Makefile
@@ -280,7 +280,7 @@ $(MAN_HTML): $(OUTPUT)%.html : %.txt
 	mv $@+ $@
 
 ifdef USE_ASCIIDOCTOR
-$(OUTPUT)%.1 $(OUTPUT)%.5 $(OUTPUT)%.7 : $(OUTPUT)%.txt
+$(OUTPUT)%.1 $(OUTPUT)%.5 $(OUTPUT)%.7 : %.txt
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
 	$(ASCIIDOC) -b manpage -d manpage \
 		$(ASCIIDOC_EXTRA) -aperf_version=$(PERF_VERSION) -o $@+ $< && \
-- 
2.14.4
