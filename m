From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/53] perf powerpc: Add missing headers to skip-callchain-idx.c
Date: Wed,  6 Feb 2019 15:48:11 -0300
Message-ID: <20190206184903.24054-2-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Maynard Johnson <maynard@us.ibm.com>, "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, Sandipan Das <sandipan@linux.ibm.com>, Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

It uses several structs but don't explicitely includes the headers where
they are defined, getting them by sheer luck from one of the headers it
includes, since those are being streamlined to avoid unnecessary
rebuilds when changes are made to a random header, they will break, fix
them now so that they continue to build.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Maynard Johnson <maynard@us.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Sandipan Das <sandipan@linux.ibm.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Link: https://lkml.kernel.org/n/tip-j1nyksegpnz36wi3qx2p46i1@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/util/skip-callchain-idx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/arch/powerpc/util/skip-callchain-idx.c b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
index 7c6eeb4633fe..2918bb16c892 100644
--- a/tools/perf/arch/powerpc/util/skip-callchain-idx.c
+++ b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
@@ -16,6 +16,9 @@
 #include "util/thread.h"
 #include "util/callchain.h"
 #include "util/debug.h"
+#include "util/dso.h"
+#include "util/map.h"
+#include "util/symbol.h"
 
 /*
  * When saving the callchain on Power, the kernel conservatively saves
-- 
2.20.1
