From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/37] perf symbols: Set PLT entry/header sizes properly on Sparc
Date: Thu, 25 Oct 2018 08:09:58 -0300
Message-ID: <20181025111031.3440-5-acme@kernel.org>
References: <20181025111031.3440-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181025111031.3440-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, David Miller <davem@davemloft.net>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexis Berlemont <alexis.berlemont@gmail.com>, David Tolnay <dtolnay@gmail.com>, Hanjun Guo <guohanjun@huawei.com>, Hemant Kumar <hemant@linux.vnet.ibm.com>, Li Bin <huawei.libin@huawei.com>, Masami Hiramatsu <mhiramat@kernel.org>, Milian Wolff <milian.wolff@kdab.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>, zhangmengting@huawei.com, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: David Miller <davem@davemloft.net>

Using the sh_entsize for both values isn't correct.  It happens to be
correct on x86...

For both 32-bit and 64-bit sparc, there are four PLT entries in the PLT
section.

Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexis Berlemont <alexis.berlemont@gmail.com>
Cc: David Tolnay <dtolnay@gmail.com>
Cc: Hanjun Guo <guohanjun@huawei.com>
Cc: Hemant Kumar <hemant@linux.vnet.ibm.com>
Cc: Li Bin <huawei.libin@huawei.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Milian Wolff <milian.wolff@kdab.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: zhangmengting@huawei.com
Fixes: b2f7605076d6 ("perf symbols: Fix plt entry calculation for ARM and AARCH64")
Link: http://lkml.kernel.org/r/20181017.120859.2268840244308635255.davem@davemloft.net
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol-elf.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 29770ea61768..6e70cc00c161 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -324,7 +324,17 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 			plt_entry_size = 16;
 			break;
 
-		default: /* FIXME: s390/alpha/mips/parisc/poperpc/sh/sparc/xtensa need to be checked */
+		case EM_SPARC:
+			plt_header_size = 48;
+			plt_entry_size = 12;
+			break;
+
+		case EM_SPARCV9:
+			plt_header_size = 128;
+			plt_entry_size = 32;
+			break;
+
+		default: /* FIXME: s390/alpha/mips/parisc/poperpc/sh/xtensa need to be checked */
 			plt_header_size = shdr_plt.sh_entsize;
 			plt_entry_size = shdr_plt.sh_entsize;
 			break;
-- 
2.14.4
