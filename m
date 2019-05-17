From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/73] tools pci: Do not delete pcitest.sh in 'make clean'
Date: Fri, 17 May 2019 16:35:07 -0300
Message-ID: <20190517193611.4974-10-acme@kernel.org>
References: <20190517193611.4974-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190517193611.4974-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Kishon Vijay Abraham I <kishon@ti.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When running 'make -C tools clean' I noticed that a revision controlled
file was being deleted:

  $ git diff
  diff --git a/tools/pci/pcitest.sh b/tools/pci/pcitest.sh
  deleted file mode 100644
  index 75ed48ff2990..000000000000
  --- a/tools/pci/pcitest.sh
  +++ /dev/null
  @@ -1,72 +0,0 @@
  -#!/bin/sh
  -# SPDX-License-Identifier: GPL-2.0
  -
  -echo "BAR tests"
  -echo
  <SNIP>

So I changed the make variables to fix that, testing it should produce
the same intended result while not deleting revision controlled files.

  $ make O=/tmp/build/pci -C tools/pci install
  make: Entering directory '/home/acme/git/perf/tools/pci'
  make -f /home/acme/git/perf/tools/build/Makefile.build dir=. obj=pcitest
  install -d -m 755 /usr/bin;		\
  for program in /tmp/build/pci/pcitest pcitest.sh; do	\
  	install $program /usr/bin;	\
  done
  install: cannot change permissions of ‘/usr/bin’: Operation not permitted
  install: cannot create regular file '/usr/bin/pcitest': Permission denied
  install: cannot create regular file '/usr/bin/pcitest.sh': Permission denied
  make: *** [Makefile:46: install] Error 1
  make: Leaving directory '/home/acme/git/perf/tools/pci'
  $ ls -la /tmp/build/pci/pcitest
  -rwxrwxr-x. 1 acme acme 27152 May 13 13:52 /tmp/build/pci/pcitest
  $ /tmp/build/pci/pcitest
  can't open PCI Endpoint Test device: No such file or directory
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: 1ce78ce09430 ("tools: PCI: Change pcitest compiling process")
Link: https://lkml.kernel.org/n/tip-9re6bd7eh9epi3koslkv3ocn@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/pci/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/pci/Makefile b/tools/pci/Makefile
index 46e4c2f318c9..f64da817bc03 100644
--- a/tools/pci/Makefile
+++ b/tools/pci/Makefile
@@ -14,7 +14,7 @@ MAKEFLAGS += -r
 
 CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
 
-ALL_TARGETS := pcitest pcitest.sh
+ALL_TARGETS := pcitest
 ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
 
 all: $(ALL_PROGRAMS)
@@ -44,7 +44,7 @@ clean:
 
 install: $(ALL_PROGRAMS)
 	install -d -m 755 $(DESTDIR)$(bindir);		\
-	for program in $(ALL_PROGRAMS); do		\
+	for program in $(ALL_PROGRAMS) pcitest.sh; do	\
 		install $$program $(DESTDIR)$(bindir);	\
 	done
 
-- 
2.20.1
