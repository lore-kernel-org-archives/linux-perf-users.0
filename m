From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/19] tools include powerpc: Update arch/powerpc/include/uapi/asm/unistd.h copy to get 'rseq' syscall
Date: Mon, 25 Jun 2018 14:40:35 -0300
Message-ID: <20180625174045.25765-10-acme@kernel.org>
References: <20180625174045.25765-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180625174045.25765-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Boqun Feng <boqun.feng@gmail.com>, David Ahern <dsahern@gmail.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Jiri Olsa <jolsa@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Michael Ellerman <mpe@ellerman.id.au>, Namhyung Kim <namhyung@kernel.org>, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

This updates the tools/perf/ copy of the powerpc file used to generate
the syscall table file used to make 'perf trace' become aware of the new
'rseq' syscall, no matter in which system it gets built, i.e. older
systems where the syscalls are not available in the running kernel (via
tracefs) or in the system headers will still be aware of these
syscalls/.

From this commit:

  bb862b021d75 ("powerpc: Wire up restartable sequences system call")

Silencing this tools/perf build warning:

  Warning: Kernel ABI header at 'tools/arch/powerpc/include/uapi/asm/unistd.h' differs from latest version at 'arch/powerpc/include/uapi/asm/unistd.h'

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-adtgz6u3apd76tghiu9w0k19@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/powerpc/include/uapi/asm/unistd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/arch/powerpc/include/uapi/asm/unistd.h b/tools/arch/powerpc/include/uapi/asm/unistd.h
index 389c36fd8299..ac5ba55066dd 100644
--- a/tools/arch/powerpc/include/uapi/asm/unistd.h
+++ b/tools/arch/powerpc/include/uapi/asm/unistd.h
@@ -398,5 +398,6 @@
 #define __NR_pkey_alloc		384
 #define __NR_pkey_free		385
 #define __NR_pkey_mprotect	386
+#define __NR_rseq		387
 
 #endif /* _UAPI_ASM_POWERPC_UNISTD_H_ */
-- 
2.14.3
