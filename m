From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 41/83] perf tools: Use shell function for perl cflags retrieval
Date: Fri, 17 Nov 2017 17:15:19 -0300
Message-ID: <20171117201601.24110-42-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753211AbdKQUSb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:18:31 -0500
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Jiri Olsa <jolsa@kernel.org>

Using the shell function for perl CFLAGS retrieval instead of back
quotes (``). Both execute shell with the command, but the latter is more
explicit and seems to be the preferred way.

Also we don't have any other use of the back quotes in perf Makefiles.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20171108102739.30338-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 63f534a0902f..f6786fa2419f 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -579,7 +579,7 @@ else
   PERL_EMBED_LDOPTS = $(shell perl -MExtUtils::Embed -e ldopts 2>/dev/null)
   PERL_EMBED_LDFLAGS = $(call strip-libs,$(PERL_EMBED_LDOPTS))
   PERL_EMBED_LIBADD = $(call grep-libs,$(PERL_EMBED_LDOPTS))
-  PERL_EMBED_CCOPTS = `perl -MExtUtils::Embed -e ccopts 2>/dev/null`
+  PERL_EMBED_CCOPTS = $(shell perl -MExtUtils::Embed -e ccopts 2>/dev/null)
   FLAGS_PERL_EMBED=$(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS)
 
   ifneq ($(feature-libperl), 1)
-- 
2.13.6
