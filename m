From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 17/26] perf python: Check if clang supports -fno-semantic-interposition
Date: Mon, 13 Apr 2020 13:51:54 -0300
Message-ID: <20200413165203.1816-18-acme@kernel.org>
References: <20200413165203.1816-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200413165203.1816-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The set of C compiler options used by distros to build python bindings
may include options that are unknown to clang, we check for a variety of
such options, add -fno-semantic-interposition to that mix:

This fixes the build on, among others, Manjaro Linux:

    GEN      /tmp/build/perf/python/perf.so
  clang-9: error: unknown argument: '-fno-semantic-interposition'
  error: command 'clang' failed with exit status 1
  make: Leaving directory '/git/perf/tools/perf'

  [perfbuilder@602aed1c266d ~]$ gcc -v
  Using built-in specs.
  COLLECT_GCC=gcc
  COLLECT_LTO_WRAPPER=/usr/lib/gcc/x86_64-pc-linux-gnu/9.3.0/lto-wrapper
  Target: x86_64-pc-linux-gnu
  Configured with: /build/gcc/src/gcc/configure --prefix=/usr --libdir=/usr/lib --libexecdir=/usr/lib --mandir=/usr/share/man --infodir=/usr/share/info --with-pkgversion='Arch Linux 9.3.0-1' --with-bugurl=https://bugs.archlinux.org/ --enable-languages=c,c++,ada,fortran,go,lto,objc,obj-c++,d --enable-shared --enable-threads=posix --with-system-zlib --with-isl --enable-__cxa_atexit --disable-libunwind-exceptions --enable-clocale=gnu --disable-libstdcxx-pch --disable-libssp --enable-gnu-unique-object --enable-linker-build-id --enable-lto --enable-plugin --enable-install-libiberty --with-linker-hash-style=gnu --enable-gnu-indirect-function --enable-multilib --disable-werror --enable-checking=release --enable-default-pie --enable-default-ssp --enable-cet=auto gdc_include_dir=/usr/include/dlang/
 gdc
  Thread model: posix
  gcc version 9.3.0 (Arch Linux 9.3.0-1)
  [perfbuilder@602aed1c266d ~]$

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/setup.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 347b2c0789e4..c5e3e9a68162 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -21,6 +21,8 @@ if cc_is_clang:
             vars[var] = sub("-fstack-clash-protection", "", vars[var])
         if not clang_has_option("-fstack-protector-strong"):
             vars[var] = sub("-fstack-protector-strong", "", vars[var])
+        if not clang_has_option("-fno-semantic-interposition"):
+            vars[var] = sub("-fno-semantic-interposition", "", vars[var])
 
 from distutils.core import setup, Extension
 
-- 
2.21.1
