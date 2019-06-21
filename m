From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 22/25] perf tools: Don't hardcode host include path for libslang
Date: Fri, 21 Jun 2019 14:38:28 -0300
Message-ID: <20190621173831.13780-23-acme@kernel.org>
References: <20190621173831.13780-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190621173831.13780-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, bcm-kernel-feedback-list@broadcom.com, Jakub Kicinski <jakub.kicinski@netronome.com>, Jiri Olsa <jolsa@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Quentin Monnet <quentin.monnet@netronome.com>, Stanislav Fomichev <sdf@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

Hardcoding /usr/include/slang is fundamentally incompatible with cross
compilation and will lead to the inability for a cross-compiled
environment to properly detect whether slang is available or not.

If /usr/include/slang is necessary that is a distribution specific
knowledge that could be solved with either a standard pkg-config .pc
file (which slang has) or simply overriding CFLAGS accordingly, but the
default perf Makefile should be clean of all of that.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Quentin Monnet <quentin.monnet@netronome.com>
Cc: Stanislav Fomichev <sdf@google.com>
Fixes: ef7b93a11904 ("perf report: Librarize the annotation code and use it in the newt browser")
Link: http://lkml.kernel.org/r/20190614183949.5588-1-f.fainelli@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/feature/Makefile | 2 +-
 tools/perf/Makefile.config   | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 523ee42db0c8..7ef7cf04a292 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -182,7 +182,7 @@ $(OUTPUT)test-libaudit.bin:
 	$(BUILD) -laudit
 
 $(OUTPUT)test-libslang.bin:
-	$(BUILD) -I/usr/include/slang -lslang
+	$(BUILD) -lslang
 
 $(OUTPUT)test-libcrypto.bin:
 	$(BUILD) -lcrypto
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 5f16a20cae86..e04b7a81d221 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -648,7 +648,6 @@ ifndef NO_SLANG
     NO_SLANG := 1
   else
     # Fedora has /usr/include/slang/slang.h, but ubuntu /usr/include/slang.h
-    CFLAGS += -I/usr/include/slang
     CFLAGS += -DHAVE_SLANG_SUPPORT
     EXTLIBS += -lslang
     $(call detected,CONFIG_SLANG)
-- 
2.20.1
