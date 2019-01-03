From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 20/29] tools power turbostat: Override CFLAGS assignments and add LDFLAGS to build command
Date: Thu,  3 Jan 2019 09:46:00 -0300
Message-ID: <20190103124609.29672-21-acme@kernel.org>
References: <20190103124609.29672-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190103124609.29672-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Herton Krzesinski <herton@redhat.com>, Len Brown <len.brown@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

So that the user can specify outside CFLAGS/LDFLAGS values.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Herton Krzesinski <herton@redhat.com>
Cc: Len Brown <len.brown@intel.com>
Link: http://lkml.kernel.org/r/20181212102537.25902-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/power/x86/turbostat/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/power/x86/turbostat/Makefile b/tools/power/x86/turbostat/Makefile
index 2ab25aa38263..1598b4fa0b11 100644
--- a/tools/power/x86/turbostat/Makefile
+++ b/tools/power/x86/turbostat/Makefile
@@ -9,13 +9,13 @@ ifeq ("$(origin O)", "command line")
 endif
 
 turbostat : turbostat.c
-CFLAGS +=	-Wall
-CFLAGS +=	-DMSRHEADER='"../../../../arch/x86/include/asm/msr-index.h"'
-CFLAGS +=	-DINTEL_FAMILY_HEADER='"../../../../arch/x86/include/asm/intel-family.h"'
+override CFLAGS +=	-Wall
+override CFLAGS +=	-DMSRHEADER='"../../../../arch/x86/include/asm/msr-index.h"'
+override CFLAGS +=	-DINTEL_FAMILY_HEADER='"../../../../arch/x86/include/asm/intel-family.h"'
 
 %: %.c
 	@mkdir -p $(BUILD_OUTPUT)
-	$(CC) $(CFLAGS) $< -o $(BUILD_OUTPUT)/$@
+	$(CC) $(CFLAGS) $< -o $(BUILD_OUTPUT)/$@ $(LDFLAGS)
 
 .PHONY : clean
 clean :
-- 
2.19.2
