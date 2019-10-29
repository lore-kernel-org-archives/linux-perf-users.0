From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH] Fixes issue when debugging debug builds of Perf.
Date: Tue, 29 Oct 2019 11:18:52 -0300
Message-ID: <20191029141852.GC4922@kernel.org>
References: <20191028113340.4282-1-james.clark@arm.com>
 <20191029140052.GB4922@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191029140052.GB4922@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: James Clark <James.Clark@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, nd <nd@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, Ian Rogers <irogers@google.com>, James Clark <james.clark@arm.com>, Jiri Olsa <jolsa@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Namhyung Kim <namhyung@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

Em Tue, Oct 29, 2019 at 11:00:52AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Oct 28, 2019 at 11:34:01AM +0000, James Clark escreveu:
> > When a 'make DEBUG=1' build is done, the command parser
> > is still built with -O6 and is hard to step through.
> > 
> > This change also moves EXTRA_WARNINGS and EXTRA_FLAGS to
> > the end of the compilation line, otherwise they cannot be
> > used to override the default values.
> 
> The patch came mangled, so I'm applying by hand, and separating it into
> two patches, the first for the first paragraph and the other for the
> second, ok?

So, this is what I mean by mangled:

diff --git a/tools/lib/subcmd/Makefile b/tools/lib/subcmd/Makefile
index 5b2cd5e58df0..1c777a72bb39 100644
--- a/tools/lib/subcmd/Makefile
+++ b/tools/lib/subcmd/Makefile
@@ -19,8 +19,7 @@ MAKEFLAGS +=3D --no-print-directory
=20
 LIBFILE =3D $(OUTPUT)libsubcmd.a
=20
-CFLAGS :=3D $(EXTRA_WARNINGS) $(EXTRA_CFLAGS)
-CFLAGS +=3D -ggdb3 -Wall -Wextra -std=3Dgnu99 -fPIC
+CFLAGS :=3D -ggdb3 -Wall -Wextra -std=3Dgnu99 -fPIC
=20
 ifeq ($(DEBUG),0)
   ifeq ($(feature-fortify-source), 1)
@@ -28,7 +27,9 @@ ifeq ($(DEBUG),0)
   endif
 endif
=20
-ifeq ($(CC_NO_CLANG), 0)


--------------------

And here is the first patch out of your larger one, I changed the
subject line to reflect that this is not tools/perf specific, as
tools/objtool/ also uses libsubcmd, added Josh, objtool's maintainer so
that he is made aware.

Thanks,

- Arnaldo

commit a554275abf9f13054595d3155b835668dab74bf9
Author: James Clark <James.Clark@arm.com>
Date:   Mon Oct 28 11:34:01 2019 +0000

    libsubcmd: Move EXTRA_FLAGS to the end to allow overriding existing flags
    
    Move EXTRA_WARNINGS and EXTRA_FLAGS to the end of the compilation line,
    otherwise they cannot be used to override the default values.
    
    Signed-off-by: James Clark <james.clark@arm.com>
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Ian Rogers <irogers@google.com>
    Cc: James Clark <james.clark@arm.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Josh Poimboeuf <jpoimboe@redhat.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: nd <nd@arm.com>
    Link: http://lore.kernel.org/lkml/20191028113340.4282-1-james.clark@arm.com
    [ split from a larger patch ]
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/lib/subcmd/Makefile b/tools/lib/subcmd/Makefile
index 5b2cd5e58df0..352c6062deba 100644
--- a/tools/lib/subcmd/Makefile
+++ b/tools/lib/subcmd/Makefile
@@ -19,8 +19,7 @@ MAKEFLAGS += --no-print-directory
 
 LIBFILE = $(OUTPUT)libsubcmd.a
 
-CFLAGS := $(EXTRA_WARNINGS) $(EXTRA_CFLAGS)
-CFLAGS += -ggdb3 -Wall -Wextra -std=gnu99 -fPIC
+CFLAGS := -ggdb3 -Wall -Wextra -std=gnu99 -fPIC
 
 ifeq ($(DEBUG),0)
   ifeq ($(feature-fortify-source), 1)
@@ -43,6 +42,8 @@ CFLAGS += -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE
 
 CFLAGS += -I$(srctree)/tools/include/
 
+CFLAGS += $(EXTRA_WARNINGS) $(EXTRA_CFLAGS)
+
 SUBCMD_IN := $(OUTPUT)libsubcmd-in.o
 
 all:
