From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 8/8] perf arch powerpc: Sync powerpc syscall.tbl with the kernel sources
Date: Thu, 20 Feb 2020 22:53:10 -0300
Message-ID: <20200221015310.16914-9-acme@kernel.org>
References: <20200221015310.16914-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200221015310.16914-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Adrian Hunter <adrian.hunter@intel.com>, Aleksa Sarai <cyphar@cyphar.com>, Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <christian.brauner@ubuntu.com>, "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Sargun Dhillon <sargun@sargun.me>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Copy over powerpc syscall.tbl to grab changes from the below commits

  fddb5d430ad9 ("open: introduce openat2(2) syscall")
  9a2cef09c801 ("arch: wire up pidfd_getfd syscall")

Now 'perf trace' on powerpc will be able to map from those syscall
strings to the right syscall numbers, i.e.

  perf trace -e pidfd*

Will include 'pidfd_getfd' as well as:

  perf trace open*

Will cover all 'open' variants.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reviewed-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Sargun Dhillon <sargun@sargun.me>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
index 43f736ed47f2..35b61bfc1b1a 100644
--- a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
@@ -517,3 +517,5 @@
 433	common	fspick				sys_fspick
 434	common	pidfd_open			sys_pidfd_open
 435	nospu	clone3				ppc_clone3
+437	common	openat2				sys_openat2
+438	common	pidfd_getfd			sys_pidfd_getfd
-- 
2.21.1
