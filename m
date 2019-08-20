From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/17] perf tools: tools/include should come before tools/uapi/include
Date: Tue, 20 Aug 2019 16:27:18 -0300
Message-ID: <20190820192733.19180-3-acme@kernel.org>
References: <20190820192733.19180-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190820192733.19180-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The next cset will grap const.h copies from the kernel to keep bits.h
in sync as it started to use linux/const.h, that in turn includes
uapi/linux/const.h.

So now we have a file with the same name in tools/include and
tools/uapi/include, and one includes the other, we need to have
tools/include/uapi/ after tools/include/ for this to work, fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-qzjqxa1wdrt51kwadyqawnuj@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 9a06787fedc6..bf8caa7d17f6 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -280,9 +280,9 @@ endif
 INC_FLAGS += -I$(src-perf)/lib/include
 INC_FLAGS += -I$(src-perf)/util/include
 INC_FLAGS += -I$(src-perf)/arch/$(SRCARCH)/include
-INC_FLAGS += -I$(srctree)/tools/include/uapi
 INC_FLAGS += -I$(srctree)/tools/include/
 INC_FLAGS += -I$(srctree)/tools/arch/$(SRCARCH)/include/uapi
+INC_FLAGS += -I$(srctree)/tools/include/uapi
 INC_FLAGS += -I$(srctree)/tools/arch/$(SRCARCH)/include/
 INC_FLAGS += -I$(srctree)/tools/arch/$(SRCARCH)/
 
-- 
2.21.0
