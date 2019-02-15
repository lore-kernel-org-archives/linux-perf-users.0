From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 17/43] tools build: Add -lrt to FEATURE_CHECK_LDFLAGS-libaio
Date: Thu, 14 Feb 2019 21:45:13 -0300
Message-ID: <20190215004539.23571-18-acme@kernel.org>
References: <20190215004539.23571-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Since we need it to resolve the AIO symbols, otherwise we fail with:

  $ cat /tmp/build/perf/feature/test-all.make.output
  /usr/bin/ld: /tmp/ccEqrj36.o: undefined reference to symbol 'aio_return64@@GLIBC_2.2.5'
  /usr/bin/ld: //usr/lib64/librt.so.1: error adding symbols: DSO missing from command line
  collect2: error: ld returned 1 exit status
  $

When we added the aio support in 'perf record' only the test-libaio.bin
target got the -lrt, i.e. the feature detection slow path. Fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: 2a07d814747b ("tools build feature: Check if libaio is available")
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index b441c88cafa1..e6360d47e73a 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -218,6 +218,8 @@ FEATURE_CHECK_LDFLAGS-libpython := $(PYTHON_EMBED_LDOPTS)
 FEATURE_CHECK_CFLAGS-libpython-version := $(PYTHON_EMBED_CCOPTS)
 FEATURE_CHECK_LDFLAGS-libpython-version := $(PYTHON_EMBED_LDOPTS)
 
+FEATURE_CHECK_LDFLAGS-libaio = -lrt
+
 CFLAGS += -fno-omit-frame-pointer
 CFLAGS += -ggdb3
 CFLAGS += -funwind-tables
-- 
2.19.1
