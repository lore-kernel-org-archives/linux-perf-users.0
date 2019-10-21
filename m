From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 57/57] perf trace: Use STUL_STRARRAY_FLAGS with mmap
Date: Mon, 21 Oct 2019 10:38:34 -0300
Message-ID: <20191021133834.25998-58-acme@kernel.org>
References: <20191021133834.25998-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Brendan Gregg <brendan.d.gregg@gmail.com>, David Ahern <dsahern@gmail.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The 'mmap' syscall has special needs so it doesn't use
SCA_STRARRAY_FLAGS, see its implementation in
syscall_arg__scnprintf_mmap_flags(), related to special handling of
MAP_ANONYMOUS, so set ->parm to the strarray__mmap_flags and hook up
with strarray__strtoul_flags manually, now we can filter by those or-ed
string expressions:

  # perf trace -e syscalls:sys_enter_mmap sleep 1
     0.000 syscalls:sys_enter_mmap(addr: NULL, len: 134346, prot: READ, flags: PRIVATE, fd: 3, off: 0)
     0.026 syscalls:sys_enter_mmap(addr: NULL, len: 8192, prot: READ|WRITE, flags: PRIVATE|ANONYMOUS)
     0.036 syscalls:sys_enter_mmap(addr: NULL, len: 1857472, prot: READ, flags: PRIVATE|DENYWRITE, fd: 3, off: 0)
     0.046 syscalls:sys_enter_mmap(addr: 0x7fae003d9000, len: 1363968, prot: READ|EXEC, flags: PRIVATE|FIXED|DENYWRITE, fd: 3, off: 0x22000)
     0.052 syscalls:sys_enter_mmap(addr: 0x7fae00526000, len: 311296, prot: READ, flags: PRIVATE|FIXED|DENYWRITE, fd: 3, off: 0x16f000)
     0.055 syscalls:sys_enter_mmap(addr: 0x7fae00573000, len: 24576, prot: READ|WRITE, flags: PRIVATE|FIXED|DENYWRITE, fd: 3, off: 0x1bb000)
     0.062 syscalls:sys_enter_mmap(addr: 0x7fae00579000, len: 14272, prot: READ|WRITE, flags: PRIVATE|FIXED|ANONYMOUS)
     0.253 syscalls:sys_enter_mmap(addr: NULL, len: 217750512, prot: READ, flags: PRIVATE, fd: 3, off: 0)
  #

  # perf trace -e syscalls:sys_enter_mmap --filter="flags==PRIVATE|FIXED|DENYWRITE" sleep 1
     0.000 syscalls:sys_enter_mmap(addr: 0x7f6ab3dcb000, len: 1363968, prot: READ|EXEC, flags: PRIVATE|FIXED|DENYWRITE, fd: 3, off: 0x22000)
     0.010 syscalls:sys_enter_mmap(addr: 0x7f6ab3f18000, len: 311296, prot: READ, flags: PRIVATE|FIXED|DENYWRITE, fd: 3, off: 0x16f000)
     0.014 syscalls:sys_enter_mmap(addr: 0x7f6ab3f65000, len: 24576, prot: READ|WRITE, flags: PRIVATE|FIXED|DENYWRITE, fd: 3, off: 0x1bb000)
  # perf trace -e syscalls:sys_enter_mmap --filter="flags==PRIVATE|ANONYMOUS" sleep 1
     0.000 syscalls:sys_enter_mmap(addr: NULL, len: 8192, prot: READ|WRITE, flags: PRIVATE|ANONYMOUS)
  #

  # perf trace -v -e syscalls:sys_enter_mmap --filter="flags==PRIVATE|ANONYMOUS" sleep 1 |& grep "New filter"
  New filter for syscalls:sys_enter_mmap: flags==0x22
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-czw754b7m9rp9ibq2f6be2o1@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 7bb84c4a8f29..43c05eae1768 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1015,7 +1015,9 @@ static struct syscall_fmt syscall_fmts[] = {
 	.alias = "old_mmap",
 #endif
 	  .arg = { [2] = { .scnprintf = SCA_MMAP_PROT,	/* prot */ },
-		   [3] = { .scnprintf = SCA_MMAP_FLAGS,	/* flags */ },
+		   [3] = { .scnprintf = SCA_MMAP_FLAGS,	/* flags */
+			   .strtoul   = STUL_STRARRAY_FLAGS,
+			   .parm      = &strarray__mmap_flags, },
 		   [5] = { .scnprintf = SCA_HEX,	/* offset */ }, }, },
 	{ .name	    = "mount",
 	  .arg = { [0] = { .scnprintf = SCA_FILENAME, /* dev_name */ },
-- 
2.21.0
