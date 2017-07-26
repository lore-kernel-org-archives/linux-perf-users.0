From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 23/40] perf report: Fix kernel symbol adjustment for s390x
Date: Wed, 26 Jul 2017 11:17:13 -0300
Message-ID: <20170726141730.30750-24-acme@kernel.org>
References: <20170726141730.30750-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726141730.30750-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Thomas Richter <tmricht@linux.vnet.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Thomas Richter <tmricht@linux.vnet.ibm.com>

On s390x the kernel text segment starts at address 0x0.  When perf
report reads kernel symbols from vmlinux file it adds an offset of
0x1000.

For example see symbol set_reset_devices:

  [root@s8360047 linux-devel]# nm -A vmlinux| fgrep set_reset_devices
  vmlinux:0000000001379000 t set_reset_devices
  [root@s8360047 linux-devel]#

  [root@s8360047 linux-devel]# fgrep set_reset_devices /proc/kallsyms
  0000000001379000 t set_reset_devices
  [root@s8360047 linux-devel]#

The kernel symbol table and the vmlinux file have the same address for
symbol set_reset_devices namely 1379000.

When perf report reads this symbols it displays it with address
symbol__new: set_reset_devices 0x137a000-0x137a018

There is a difference between perf report and vmlinux of 0x1000.

The reason for the difference is at kernel symbol load time in function
dso__load_sym(). The vmlinux file is investigated with its ELF header.
Command readelf shows this:

  Section Headers:
  [Nr] Name              Type             Address           Offset
       Size              EntSize          Flags  Link  Info  Align
  [ 0]                   NULL             0000000000000000  00000000
       0000000000000000  0000000000000000           0     0     0
  [ 1] .text             PROGBITS         0000000000000000  00001000
       0000000000b0e0c2  0000000000000000  AX       0     0     128

This leads to an invalid calculation of the symbol start address, see
file utit/symbol-elf.c line 974:

        /* Adjust symbol to map to file offset */
        if (adjust_kernel_syms)
                sym.st_value -= shdr.sh_addr - shdr.sh_offset;

With shdr.sh_addr set to 0x0 and shdr.sh_offset set to 0x1000 as read
from the ELF .text section 0x1000 is added to the symbol address.

I would like to fix this by introducing an archticture specific function
named elf__needs_adjust_symbols(). This is the same approach as done by
PowerPC.  The function currently does not exist for s390x and the
default weak one is used.  The s390x specific one returns false when
symsrc_init() is invoked for kernel symbols and results in variable
adjust_kernel_syms being false.  This omits the adjustment and the
correct address is displayed (when symbol resolvement does not work).

The s390x specific function returns false for kernel symbol adjustment
and returns true for kernel modules, processes and shared libraries.

Signed-off-by: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
LPU-Reference: 20170713130252.6167-1-tmricht@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/s390/util/Build          |  1 +
 tools/perf/arch/s390/util/sym-handling.c | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)
 create mode 100644 tools/perf/arch/s390/util/sym-handling.c

diff --git a/tools/perf/arch/s390/util/Build b/tools/perf/arch/s390/util/Build
index 5bd7b9260cc0..bd518b623d7a 100644
--- a/tools/perf/arch/s390/util/Build
+++ b/tools/perf/arch/s390/util/Build
@@ -1,4 +1,5 @@
 libperf-y += header.o
+libperf-y += sym-handling.o
 libperf-y += kvm-stat.o
 
 libperf-$(CONFIG_DWARF) += dwarf-regs.o
diff --git a/tools/perf/arch/s390/util/sym-handling.c b/tools/perf/arch/s390/util/sym-handling.c
new file mode 100644
index 000000000000..b6cd056ccf71
--- /dev/null
+++ b/tools/perf/arch/s390/util/sym-handling.c
@@ -0,0 +1,22 @@
+/*
+ * Architecture specific ELF symbol handling and relocation mapping.
+ *
+ * Copyright 2017 IBM Corp.
+ * Author(s): Thomas Richter <tmricht@linux.vnet.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License (version 2 only)
+ * as published by the Free Software Foundation.
+ */
+
+#include "symbol.h"
+
+#ifdef HAVE_LIBELF_SUPPORT
+bool elf__needs_adjust_symbols(GElf_Ehdr ehdr)
+{
+	if (ehdr.e_type == ET_EXEC)
+		return false;
+	return ehdr.e_type == ET_REL || ehdr.e_type == ET_DYN;
+}
+
+#endif
-- 
2.9.4
