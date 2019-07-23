From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/10] perf script: Fix off by one in brstackinsn IPC computation
Date: Tue, 23 Jul 2019 17:05:23 -0300
Message-ID: <20190723200530.14090-4-acme@kernel.org>
References: <20190723200530.14090-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190723200530.14090-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Denis Bakhvalov <denis.bakhvalov@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

When we hit the end of a program block, need to count the last
instruction too for the IPC computation. This caused large errors for
small blocks.

  % perf script -b ls / > /dev/null

Before:

  % perf script -F +brstackinsn --xed
  ...
        00007f94c9ac70d8                        jz 0x7f94c9ac70e3                       # PRED 3 cycles [36] 4.33 IPC
        00007f94c9ac70e3                        testb  $0x20, 0x31d(%rbx)
        00007f94c9ac70ea                        jnz 0x7f94c9ac70b0
        00007f94c9ac70ec                        testb  $0x8, 0x205ad(%rip)
        00007f94c9ac70f3                        jz 0x7f94c9ac6ff0               # PRED 1 cycles [37] 3.00 IPC

After:

  % perf script -F +brstackinsn --xed
  ...
        00007f94c9ac70d8                        jz 0x7f94c9ac70e3                       # PRED 3 cycles [15] 4.67 IPC
        00007f94c9ac70e3                        testb  $0x20, 0x31d(%rbx)
        00007f94c9ac70ea                        jnz 0x7f94c9ac70b0
        00007f94c9ac70ec                        testb  $0x8, 0x205ad(%rip)
        00007f94c9ac70f3                        jz 0x7f94c9ac6ff0               # PRED 1 cycles [16] 4.00 IPC

Suggested-by: Denis Bakhvalov <denis.bakhvalov@intel.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190711181922.18765-2-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 8f24865596af..0140ddb8dd0b 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1059,7 +1059,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 
 			printed += ip__fprintf_sym(ip, thread, x.cpumode, x.cpu, &lastsym, attr, fp);
 			if (ip == end) {
-				printed += ip__fprintf_jump(ip, &br->entries[i], &x, buffer + off, len - off, insn, fp,
+				printed += ip__fprintf_jump(ip, &br->entries[i], &x, buffer + off, len - off, ++insn, fp,
 							    &total_cycles);
 				if (PRINT_FIELD(SRCCODE))
 					printed += print_srccode(thread, x.cpumode, ip);
-- 
2.21.0
