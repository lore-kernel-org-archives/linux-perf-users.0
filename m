From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/85] perf record: Allow mixing --user-regs with --call-graph=dwarf
Date: Tue, 11 Jun 2019 15:57:52 -0300
Message-ID: <20190611185911.11645-7-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexey Budankov <alexey.budankov@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-perf-users.vger.kernel.org

From: Alexey Budankov <alexey.budankov@linux.intel.com>

When DWARF stacks were requested and at the same time that the user
specifies a register set using the --user-regs option the full register
context was being captured on samples:

  $ perf record -g --call-graph dwarf,1024 --user-regs=IP,SP,BP -- stack_test2.g.O3

  188143843893585 0x6b48 [0x4f8]: PERF_RECORD_SAMPLE(IP, 0x4002): 23828/23828: 0x401236 period: 1363819 addr: 0x7ffedbdd51ac
  ... FP chain: nr:0
  ... user regs: mask 0xff0fff ABI 64-bit
  .... AX    0x53b
  .... BX    0x7ffedbdd3cc0
  .... CX    0xffffffff
  .... DX    0x33d3a
  .... SI    0x7f09b74c38d0
  .... DI    0x0
  .... BP    0x401260
  .... SP    0x7ffedbdd3cc0
  .... IP    0x401236
  .... FLAGS 0x20a
  .... CS    0x33
  .... SS    0x2b
  .... R8    0x7f09b74c3800
  .... R9    0x7f09b74c2da0
  .... R10   0xfffffffffffff3ce
  .... R11   0x246
  .... R12   0x401070
  .... R13   0x7ffedbdd5db0
  .... R14   0x0
  .... R15   0x0
  ... ustack: size 1024, offset 0xe0
   . data_src: 0x5080021
   ... thread: stack_test2.g.O:23828
   ...... dso: /root/abudanko/stacks/stack_test2.g.O3

I.e. the --user-regs=IP,SP,BP was being ignored, being overridden by the
needs of --call-graph=dwarf.

After applying the change in this patch the sample data contains the
user specified register, but making sure that at least the minimal set
of register needed for DWARF unwinding (DWARF_MINIMAL_REGS) is
requested.

The user is warned that DWARF unwinding may not work if extra registers
end up being needed.

  -g call-graph dwarf,K                         full_regs
  --user-regs=user_regs                         user_regs
  -g call-graph dwarf,K --user-regs=user_regs	user_regs + DWARF_MINIMAL_REGS

  $ perf record -g --call-graph dwarf,1024 --user-regs=BP -- ls
  WARNING: The use of --call-graph=dwarf may require all the user registers, specifying a subset with --user-regs may render DWARF unwinding unreliable, so the minimal registers set (IP, SP) is explicitly forced.
  arch   COPYING	Documentation  include	Kbuild	 lbuild    MAINTAINERS	modules.builtin		 Module.symvers  perf.data.old	scripts   System.map  virt
  block  CREDITS	drivers        init	Kconfig  lib	   Makefile	modules.builtin.modinfo  net		 README		security  tools       vmlinux
  certs  crypto	fs	       ipc	kernel	 LICENSES  mm		modules.order		 perf.data	 samples	sound	  usr	      vmlinux.o
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.030 MB perf.data (10 samples) ]

  188368474305373 0x5e40 [0x470]: PERF_RECORD_SAMPLE(IP, 0x4002): 23839/23839: 0x401236 period: 1260507 addr: 0x7ffd3d85e96c
  ... FP chain: nr:0
  ... user regs: mask 0x1c0 ABI 64-bit
  .... BP    0x401260
  .... SP    0x7ffd3d85cc20
  .... IP    0x401236
  ... ustack: size 1024, offset 0x58
   . data_src: 0x5080021

Committer notes:

Detected build failures on arches where PERF_REGS_ is not available,
such as debian:experimental-x-{mips,mips64,mipsel}, fedora 24 and 30 for
ARC uClibc and glibc, reported to Alexey that provided a patch moving
the DWARF_MINIMAL_REGS from evsel.c to util/perf_regs.h, where it is
guarded by an HAVE_PERF_REGS_SUPPORT ifdef.

Committer testing:

  # perf record --user-regs=bp,ax -a sleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 1.955 MB perf.data (1773 samples) ]
  # perf script -F+uregs | grep AX: | head -5
     perf 1719 [000] 181.272398:    1 cycles: ffffffffba06a7c4 native_write_msr+0x4 (/lib/modules/5.2.0-rc1+/build/vmlinux) ABI:2 AX:0xffffffffffffffda BP:0x7ffef828fb00
     perf 1719 [000] 181.272402:    1 cycles: ffffffffba06a7c4 native_write_msr+0x4 (/lib/modules/5.2.0-rc1+/build/vmlinux) ABI:2 AX:0xffffffffffffffda BP:0x7ffef828fb00
     perf 1719 [000] 181.272403:    8 cycles: ffffffffba06a7c4 native_write_msr+0x4 (/lib/modules/5.2.0-rc1+/build/vmlinux) ABI:2 AX:0xffffffffffffffda BP:0x7ffef828fb00
     perf 1719 [000] 181.272405:  181 cycles: ffffffffba06a7c6 native_write_msr+0x6 (/lib/modules/5.2.0-rc1+/build/vmlinux) ABI:2 AX:0xffffffffffffffda BP:0x7ffef828fb00
     perf 1719 [000] 181.272406: 4405 cycles: ffffffffba06a7c4 native_write_msr+0x4 (/lib/modules/5.2.0-rc1+/build/vmlinux) ABI:2 AX:0xffffffffffffffda BP:0x7ffef828fb00
  # perf record --call-graph=dwarf --user-regs=bp,ax -a sleep 1
  WARNING: The use of --call-graph=dwarf may require all the user registers, specifying a subset with --user-regs may render DWARF unwinding unreliable, so the minimal registers set (IP, SP) is explicitly forced.
  [ perf record: Woken up 55 times to write data ]
  [ perf record: Captured and wrote 24.184 MB perf.data (2841 samples) ]
  [root@quaco ~]# perf script --hide-call-graph -F+uregs | grep AX: | head -5
     perf 1729 [000] 211.268006:    1 cycles: ffffffffba06a7c4 native_write_msr+0x4 (/lib/modules/5.2.0-rc1+/build/vmlinux) ABI:2 AX:0xffffffffffffffda BP:0x7ffc8679abb0 SP:0x7ffc8679ab78 IP:0x7fa75223a0db
     perf 1729 [000] 211.268014:    1 cycles: ffffffffba06a7c4 native_write_msr+0x4 (/lib/modules/5.2.0-rc1+/build/vmlinux) ABI:2 AX:0xffffffffffffffda BP:0x7ffc8679abb0 SP:0x7ffc8679ab78 IP:0x7fa75223a0db
     perf 1729 [000] 211.268017:    5 cycles: ffffffffba06a7c4 native_write_msr+0x4 (/lib/modules/5.2.0-rc1+/build/vmlinux) ABI:2 AX:0xffffffffffffffda BP:0x7ffc8679abb0 SP:0x7ffc8679ab78 IP:0x7fa75223a0db
     perf 1729 [000] 211.268020:   48 cycles: ffffffffba06a7c6 native_write_msr+0x6 (/lib/modules/5.2.0-rc1+/build/vmlinux) ABI:2 AX:0xffffffffffffffda BP:0x7ffc8679abb0 SP:0x7ffc8679ab78 IP:0x7fa75223a0db
     perf 1729 [000] 211.268024:  490 cycles: ffffffffba00e471 intel_bts_enable_local+0x21 (/lib/modules/5.2.0-rc1+/build/vmlinux) ABI:2 AX:0xffffffffffffffda BP:0x7ffc8679abb0 SP:0x7ffc8679ab78 IP:0x7fa75223a0db
  #

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/e7fd37b1-af22-0d94-a0dc-5895e803bbfe@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c     | 9 ++++++++-
 tools/perf/util/perf_regs.h | 4 ++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index a6f572a40deb..cc6e7a0dda92 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -702,7 +702,14 @@ static void __perf_evsel__config_callchain(struct perf_evsel *evsel,
 		if (!function) {
 			perf_evsel__set_sample_bit(evsel, REGS_USER);
 			perf_evsel__set_sample_bit(evsel, STACK_USER);
-			attr->sample_regs_user |= PERF_REGS_MASK;
+			if (opts->sample_user_regs && DWARF_MINIMAL_REGS != PERF_REGS_MASK) {
+				attr->sample_regs_user |= DWARF_MINIMAL_REGS;
+				pr_warning("WARNING: The use of --call-graph=dwarf may require all the user registers, "
+					   "specifying a subset with --user-regs may render DWARF unwinding unreliable, "
+					   "so the minimal registers set (IP, SP) is explicitly forced.\n");
+			} else {
+				attr->sample_regs_user |= PERF_REGS_MASK;
+			}
 			attr->sample_stack_user = param->dump_size;
 			attr->exclude_callchain_user = 1;
 		} else {
diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
index cb9c246c8962..47fe34e5f7d5 100644
--- a/tools/perf/util/perf_regs.h
+++ b/tools/perf/util/perf_regs.h
@@ -29,12 +29,16 @@ uint64_t arch__user_reg_mask(void);
 #ifdef HAVE_PERF_REGS_SUPPORT
 #include <perf_regs.h>
 
+#define DWARF_MINIMAL_REGS ((1ULL << PERF_REG_IP) | (1ULL << PERF_REG_SP))
+
 int perf_reg_value(u64 *valp, struct regs_dump *regs, int id);
 
 #else
 #define PERF_REGS_MASK	0
 #define PERF_REGS_MAX	0
 
+#define DWARF_MINIMAL_REGS PERF_REGS_MASK
+
 static inline const char *perf_reg_name(int id __maybe_unused)
 {
 	return NULL;
-- 
2.20.1
