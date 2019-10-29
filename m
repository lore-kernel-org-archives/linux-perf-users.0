From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH] Fixes issue when debugging debug builds of Perf.
Date: Tue, 29 Oct 2019 11:26:47 -0300
Message-ID: <20191029142647.GD4922@kernel.org>
References: <20191028113340.4282-1-james.clark@arm.com>
 <20191029140052.GB4922@kernel.org>
 <20191029141852.GC4922@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191029141852.GC4922@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: James Clark <James.Clark@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, nd <nd@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Namhyung Kim <namhyung@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

Em Tue, Oct 29, 2019 at 11:18:52AM -0300, Arnaldo Carvalho de Melo escreveu:
> And here is the first patch out of your larger one, I changed the
> subject line to reflect that this is not tools/perf specific, as
> tools/objtool/ also uses libsubcmd, added Josh, objtool's maintainer so
> that he is made aware.

And the second patch:


commit d0381449fd9ab733ec2daf527263da9f73f1e94e
Author: James Clark <James.Clark@arm.com>
Date:   Mon Oct 28 11:34:01 2019 +0000

    libsubcmd: Use -O0 with DEBUG=1
    
    When a 'make DEBUG=1' build is done, the command parser is still built
    with -O6 and is hard to step through, fix it making it use -O0 in that
    case.
    
    Signed-off-by: James Clark <james.clark@arm.com>
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Ian Rogers <irogers@google.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Josh Poimboeuf <jpoimboe@redhat.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: nd <nd@arm.com>
    Link: http://lore.kernel.org/lkml/20191028113340.4282-1-james.clark@arm.com
    [ split from a larger patch ]
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/lib/subcmd/Makefile b/tools/lib/subcmd/Makefile
index 352c6062deba..1c777a72bb39 100644
--- a/tools/lib/subcmd/Makefile
+++ b/tools/lib/subcmd/Makefile
@@ -27,7 +27,9 @@ ifeq ($(DEBUG),0)
   endif
 endif
 
-ifeq ($(CC_NO_CLANG), 0)
+ifeq ($(DEBUG),1)
+  CFLAGS += -O0
+else ifeq ($(CC_NO_CLANG), 0)
   CFLAGS += -O3
 else
   CFLAGS += -O6
