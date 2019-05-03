From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/11] tools build: Add -ldl to the disassembler-four-args feature test
Date: Thu,  2 May 2019 20:25:31 -0400
Message-ID: <20190503002533.29359-10-acme@kernel.org>
References: <20190503002533.29359-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190503002533.29359-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Thomas Backlund <tmb@mageia.org>, Adrian Hunter <adrian.hunter@intel.com>, Song Liu <songliubraving@fb.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Thomas Backlund reported that the perf build was failing on the Mageia 7
distro, that is because it uses:

  cat /tmp/build/perf/feature/test-disassembler-four-args.make.output
  /usr/bin/ld: /usr/lib64/libbfd.a(plugin.o): in function `try_load_plugin':
  /home/iurt/rpmbuild/BUILD/binutils-2.32/objs/bfd/../../bfd/plugin.c:243:
  undefined reference to `dlopen'
  /usr/bin/ld:
  /home/iurt/rpmbuild/BUILD/binutils-2.32/objs/bfd/../../bfd/plugin.c:271:
  undefined reference to `dlsym'
  /usr/bin/ld:
  /home/iurt/rpmbuild/BUILD/binutils-2.32/objs/bfd/../../bfd/plugin.c:256:
  undefined reference to `dlclose'
  /usr/bin/ld:
  /home/iurt/rpmbuild/BUILD/binutils-2.32/objs/bfd/../../bfd/plugin.c:246:
  undefined reference to `dlerror'
  as we allow dynamic linking and loading

Mageia 7 uses these linker flags:
  $ rpm --eval %ldflags
    -Wl,--as-needed -Wl,--no-undefined -Wl,-z,relro -Wl,-O1 -Wl,--build-id -Wl,--enable-new-dtags

So add -ldl to this feature LDFLAGS.

Reported-by: Thomas Backlund <tmb@mageia.org>
Tested-by: Thomas Backlund <tmb@mageia.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Link: https://lkml.kernel.org/r/20190501173158.GC21436@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index fe3f97e342fa..6d65874e16c3 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -227,7 +227,7 @@ FEATURE_CHECK_LDFLAGS-libpython-version := $(PYTHON_EMBED_LDOPTS)
 
 FEATURE_CHECK_LDFLAGS-libaio = -lrt
 
-FEATURE_CHECK_LDFLAGS-disassembler-four-args = -lbfd -lopcodes
+FEATURE_CHECK_LDFLAGS-disassembler-four-args = -lbfd -lopcodes -ldl
 
 CFLAGS += -fno-omit-frame-pointer
 CFLAGS += -ggdb3
-- 
2.20.1
