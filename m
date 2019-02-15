From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 22/43] perf build: Add missing FEATURE_CHECK_LDFLAGS-libcrypto
Date: Thu, 14 Feb 2019 21:45:18 -0300
Message-ID: <20190215004539.23571-23-acme@kernel.org>
References: <20190215004539.23571-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Carl Love <cel@us.ibm.com>, David Ahern <dsahern@gmail.com>, John McCutchan <johnmccutchan@google.com>, Pawel Moll <pawel.moll@arm.com>, Peter Zijlstra <peterz@infradead.org>, Sonny Rao <sonnyrao@chromium.org>, Stephane Eranian <eranian@google.com>, Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When the libcrypto feature test was added we forgot to add its
FEATURE_CHECK_LDFLAGS pointing to the library needed to link with the
test-all.bin feature test fast path binary, so even when it was
introduced we got this:

  $ cat /tmp/build/perf/feature/test-all.make.output
  /usr/bin/ld: /tmp/ccjKeJJU.o: in function `main_test_libcrypto':
  /home/acme/git/perf/tools/build/feature/test-libcrypto.c:10: undefined reference to `MD5_Init'
  /usr/bin/ld: /home/acme/git/perf/tools/build/feature/test-libcrypto.c:11: undefined reference to `MD5_Update'
  /usr/bin/ld: /home/acme/git/perf/tools/build/feature/test-libcrypto.c:12: undefined reference to `MD5_Final'
  /usr/bin/ld: /home/acme/git/perf/tools/build/feature/test-libcrypto.c:14: undefined reference to `SHA1'
  collect2: error: ld returned 1 exit status
  $ cat /tmp/build/perf/feature/test-libcrypto.
  test-libcrypto.bin          test-libcrypto.d            test-libcrypto.make.output
  $ cat /tmp/build/perf/feature/test-libcrypto.make.output
  $

Fix it, so that we keep the fast path, which, at this point, will fail
with the unwind-ARCH feature tests, that will be fixed in a followup
patch:

  $ make -C tools/perf O=/tmp/build/perf
  ...                     libcrypto: [ on  ]
   <SNIP>
  $ cat /tmp/build/perf/feature/test-all.make.output
  $ ldd /tmp/build/perf/feature/test-all.bin | grep libcrypto
	libcrypto.so.1.1 => /lib64/libcrypto.so.1.1 (0x00007f9892805000)
  $
  $ grep libcrypto /tmp/build/perf/FEATURE-DUMP
  feature-libcrypto=1
  $

With the unwind-ARCH tests fixed, we now finally manage to get
test-all.bin built and linked with the features it tests, among them the
ones fixed in this patchkit:

  $ ldd /tmp/build/perf/feature/test-all.bin  | egrep 'unwind|crypto'
	libcrypto.so.1.1 => /lib64/libcrypto.so.1.1 (0x00007f95cf2b8000)
	libunwind-x86_64.so.8 => /lib64/libunwind-x86_64.so.8 (0x00007f95cf294000)
	libunwind.so.8 => /lib64/libunwind.so.8 (0x00007f95cf278000)
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Carl Love <cel@us.ibm.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: John McCutchan <johnmccutchan@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sonny Rao <sonnyrao@chromium.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Fixes: 8ee4646038e4 ("perf build: Add libcrypto feature detection")
Link: https://lkml.kernel.org/n/tip-rexc248jorf5b4l3qjn888cz@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 4b735042cad7..0f11d5891301 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -114,6 +114,8 @@ FEATURE_CHECK_LDFLAGS-libunwind-aarch64 = -lunwind -lunwind-aarch64
 FEATURE_CHECK_LDFLAGS-libunwind-x86 = -lunwind -llzma -lunwind-x86
 FEATURE_CHECK_LDFLAGS-libunwind-x86_64 = -lunwind -llzma -lunwind-x86_64
 
+FEATURE_CHECK_LDFLAGS-libcrypto = -lcrypto
+
 ifdef CSINCLUDES
   LIBOPENCSD_CFLAGS := -I$(CSINCLUDES)
 endif
-- 
2.19.1
