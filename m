From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 021/107] perf trace beauty: Beautify bind's sockaddr arg
Date: Mon, 29 Jul 2019 23:54:44 -0300
Message-ID: <20190730025610.22603-22-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

By reusing the "connect" BPF collector.

Testing it system wide and stopping/starting sshd:

  # perf trace -e bind
  LLVM: dumping /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
  DNS Res~er #18/15132 bind(243, { .family: PF_NETLINK }, 12)  = 0
  DNS Res~er #19/4833 bind(247, { .family: PF_NETLINK }, 12)  = 0
  DNS Res~er #19/4833 bind(238, { .family: PF_NETLINK }, 12)  = 0
  DNS Res~er #18/15132 bind(243, { .family: PF_NETLINK }, 12)  = 0
  DNS Res~er #18/10327 bind(258, { .family: PF_NETLINK }, 12)  = 0
  :6507/6507 bind(24, { .family: PF_NETLINK }, 12)   = 0
  DNS Res~er #19/4833 bind(238, { .family: PF_NETLINK }, 12)  = 0
  DNS Res~er #18/15132 bind(242, { .family: PF_NETLINK }, 12)  = 0
  sshd/6514 bind(3, { .family: PF_NETLINK }, 12)    = 0
  sshd/6514 bind(5, { .family: PF_INET, port: 22, addr: 0.0.0.0 }, 16) = 0
  sshd/6514 bind(7, { .family: PF_INET6, port: 22, addr: :: }, 28) = 0
  DNS Res~er #18/10327 bind(229, { .family: PF_NETLINK }, 12)  = 0
  DNS Res~er #18/15132 bind(231, { .family: PF_NETLINK }, 12)  = 0
  DNS Res~er #19/4833 bind(229, { .family: PF_NETLINK }, 12)  = 0
  ^C#

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-m2hmxqrckxxw2ciki0tu889u@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 010aa9e9a561..d403b09812d1 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -710,8 +710,10 @@ static struct syscall_fmt {
 	  .arg = { [0] = { .scnprintf = SCA_X86_ARCH_PRCTL_CODE, /* code */ },
 		   [1] = { .scnprintf = SCA_PTR, /* arg2 */ }, }, },
 	{ .name	    = "bind",
+	  .bpf_prog_name = { .sys_enter = "!syscalls:sys_enter_connect", },
 	  .arg = { [0] = { .scnprintf = SCA_INT, /* fd */ },
-		   [1] = { .scnprintf = SCA_SOCKADDR, /* umyaddr */ }, }, },
+		   [1] = { .scnprintf = SCA_SOCKADDR, /* umyaddr */ },
+		   [2] = { .scnprintf = SCA_INT, /* addrlen */ }, }, },
 	{ .name	    = "bpf",
 	  .arg = { [0] = STRARRAY(cmd, bpf_cmd), }, },
 	{ .name	    = "brk",	    .hexret = true,
-- 
2.21.0
