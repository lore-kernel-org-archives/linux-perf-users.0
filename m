From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 19/29] tools thermal tmon: Allow overriding CFLAGS assignments
Date: Thu,  3 Jan 2019 09:45:59 -0300
Message-ID: <20190103124609.29672-20-acme@kernel.org>
References: <20190103124609.29672-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190103124609.29672-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Brian Norris <computersforpeace@gmail.com>, Herton Krzesinski <herton@redhat.com>, Markus Mayer <mmayer@broadcom.com>, Zhang Rui <rui.zhang@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

So that the user can provide, e.g. distro package alternative values.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Brian Norris <computersforpeace@gmail.com>
Cc: Herton Krzesinski  <herton@redhat.com>
Cc: Markus Mayer <mmayer@broadcom.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Link: http://lkml.kernel.org/r/20181212102537.25902-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/thermal/tmon/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/thermal/tmon/Makefile b/tools/thermal/tmon/Makefile
index 735a510230c3..89a2444c1df2 100644
--- a/tools/thermal/tmon/Makefile
+++ b/tools/thermal/tmon/Makefile
@@ -6,13 +6,13 @@ VERSION = 1.0
 
 BINDIR=usr/bin
 WARNFLAGS=-Wall -Wshadow -W -Wformat -Wimplicit-function-declaration -Wimplicit-int
-CFLAGS+= -O1 ${WARNFLAGS}
+override CFLAGS+= -O1 ${WARNFLAGS}
 # Add "-fstack-protector" only if toolchain supports it.
-CFLAGS+= $(call cc-option,-fstack-protector)
+override CFLAGS+= $(call cc-option,-fstack-protector-strong)
 CC?= $(CROSS_COMPILE)gcc
 PKG_CONFIG?= pkg-config
 
-CFLAGS+=-D VERSION=\"$(VERSION)\"
+override CFLAGS+=-D VERSION=\"$(VERSION)\"
 LDFLAGS+=
 TARGET=tmon
 
@@ -29,7 +29,7 @@ TMON_LIBS += $(shell $(PKG_CONFIG) --libs $(STATIC) panelw ncursesw 2> /dev/null
 		     $(PKG_CONFIG) --libs $(STATIC) panel ncurses 2> /dev/null || \
 		     echo -lpanel -lncurses)
 
-CFLAGS    += $(shell $(PKG_CONFIG) --cflags $(STATIC) panelw ncursesw 2> /dev/null || \
+override CFLAGS += $(shell $(PKG_CONFIG) --cflags $(STATIC) panelw ncursesw 2> /dev/null || \
 		     $(PKG_CONFIG) --cflags $(STATIC) panel ncurses 2> /dev/null)
 
 OBJS = tmon.o tui.o sysfs.o pid.o
-- 
2.19.2
