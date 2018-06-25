From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/19] perf report powerpc: Fix crash if callchain is empty
Date: Mon, 25 Jun 2018 14:40:29 -0300
Message-ID: <20180625174045.25765-4-acme@kernel.org>
References: <20180625174045.25765-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180625174045.25765-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Sandipan Das <sandipan@linux.ibm.com>, Jiri Olsa <jolsa@redhat.com>, "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>, Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Sandipan Das <sandipan@linux.ibm.com>

For some cases, the callchain provided by the kernel may be empty. So,
the callchain ip filtering code will cause a crash if we do not check
whether the struct ip_callchain pointer is NULL before accessing any
members.

This can be observed on a powerpc64le system running Fedora 27 as shown
below.

  # perf record -b -e cycles:u ls

Before:

  # perf report --branch-history

  perf: Segmentation fault
  -------- backtrace --------
  perf[0x1027615c]
  linux-vdso64.so.1(__kernel_sigtramp_rt64+0x0)[0x7fff856304d8]
  perf(arch_skip_callchain_idx+0x44)[0x10257c58]
  perf[0x1017f2e4]
  perf(thread__resolve_callchain+0x124)[0x1017ff5c]
  perf(sample__resolve_callchain+0xf0)[0x10172788]
  ...

After:

  # perf report --branch-history

  Samples: 25  of event 'cycles:u', Event count (approx.): 2306870
    Overhead  Source:Line            Symbol                   Shared Object
  +   11.60%  _init+35736            [.] _init                ls
  +    9.84%  strcoll_l.c:137        [.] __strcoll_l          libc-2.26.so
  +    9.16%  memcpy.S:175           [.] __memcpy_power7      libc-2.26.so
  +    9.01%  gconv_charset.h:54     [.] _nl_find_locale      libc-2.26.so
  +    8.87%  dl-addr.c:52           [.] _dl_addr             libc-2.26.so
  +    8.83%  _init+236              [.] _init                ls
  ...

Reported-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
Acked-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20180611104049.11048-1-sandipan@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/util/skip-callchain-idx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/powerpc/util/skip-callchain-idx.c b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
index 3598b8b75d27..ef5d59a5742e 100644
--- a/tools/perf/arch/powerpc/util/skip-callchain-idx.c
+++ b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
@@ -243,7 +243,7 @@ int arch_skip_callchain_idx(struct thread *thread, struct ip_callchain *chain)
 	u64 ip;
 	u64 skip_slot = -1;
 
-	if (chain->nr < 3)
+	if (!chain || chain->nr < 3)
 		return skip_slot;
 
 	ip = chain->ips[2];
-- 
2.14.3
