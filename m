From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/11] perf tools: Fix use of alternatives to find JDIR
Date: Wed, 17 Oct 2018 19:54:56 -0300
Message-ID: <20181017225501.32150-7-acme@kernel.org>
References: <20181017225501.32150-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181017225501.32150-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jarod Wilson <jarod@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, William Cohen <wcohen@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jarod Wilson <jarod@redhat.com>

When a build is run from something like a cron job, the user's $PATH is
rather minimal, of note, not including /usr/sbin in my own case. Because
of that, an automated rpm package build ultimately fails to find
libperf-jvmti.so, because somewhere within the build, this happens...

  /bin/sh: alternatives: command not found
  /bin/sh: alternatives: command not found
  Makefile.config:849: No openjdk development package found, please install
  JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel

...and while the build continues, libperf-jvmti.so isn't built, and
things fall down when rpm tries to find all the %files specified. Exact
same system builds everything just fine when the job is launched from a
login shell instead of a cron job, since alternatives is in $PATH, so
openjdk is actually found.

The test required to get into this section of code actually specifies
the full path, as does a block just above it, so let's do that here too.

Signed-off-by: Jarod Wilson <jarod@redhat.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: William Cohen <wcohen@redhat.com>
Fixes: d4dfdf00d43e ("perf jvmti: Plug compilation into perf build")
Link: http://lkml.kernel.org/r/20180906221812.11167-1-jarod@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index f6d1a03c7523..e30d20fb482d 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -833,7 +833,7 @@ ifndef NO_JVMTI
     JDIR=$(shell /usr/sbin/update-java-alternatives -l | head -1 | awk '{print $$3}')
   else
     ifneq (,$(wildcard /usr/sbin/alternatives))
-      JDIR=$(shell alternatives --display java | tail -1 | cut -d' ' -f 5 | sed 's%/jre/bin/java.%%g')
+      JDIR=$(shell /usr/sbin/alternatives --display java | tail -1 | cut -d' ' -f 5 | sed 's%/jre/bin/java.%%g')
     endif
   endif
   ifndef JDIR
-- 
2.14.4
