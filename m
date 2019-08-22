From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 20/25] perf x86 kvm-stat: Add missing string.h header
Date: Thu, 22 Aug 2019 18:00:55 -0300
Message-ID: <20190822210100.3461-21-acme@kernel.org>
References: <20190822210100.3461-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190822210100.3461-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

It uses strcmp(), strstr() and was getting the required string.h header
by luck, from evsel.h -> cpumap.h -> debug.h -> string.h, add the
missing header.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-qrz8hhvrhwnmt5ocfwk4br5d@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/util/kvm-stat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/arch/x86/util/kvm-stat.c b/tools/perf/arch/x86/util/kvm-stat.c
index 81b531a707bf..c0775c39227f 100644
--- a/tools/perf/arch/x86/util/kvm-stat.c
+++ b/tools/perf/arch/x86/util/kvm-stat.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
+#include <string.h>
 #include "../../../util/kvm-stat.h"
 #include "../../../util/evsel.h"
 #include <asm/svm.h>
-- 
2.21.0
