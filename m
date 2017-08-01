From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/18] tools include uapi: Grab a copy of asm-generic/ioctls.h
Date: Tue,  1 Aug 2017 16:56:32 -0300
Message-ID: <20170801195645.16986-6-acme@kernel.org>
References: <20170801195645.16986-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170801195645.16986-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So that we can build on older systems where otherwise we would end up
with:

    CC       /tmp/build/perf/trace/beauty/ioctl.o
  trace/beauty/ioctl.c: In function 'ioctl__scnprintf_tty_cmd':
  trace/beauty/ioctl.c:25:17: error: 'TIOCGEXCL' undeclared (first use in this function)
  trace/beauty/ioctl.c:25:17: note: each undeclared identifier is reported only once for each function it appears in
  trace/beauty/ioctl.c:25:2: error: array index in initializer not of integer type
  trace/beauty/ioctl.c:25:2: error: (near initialization for 'ioctl_tty_cmd')

This way we can build a tool on an older system and it will still be
capable of processing perf.data files generated on newer systems.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-8qvkv6txwuzua6d0yvt65wl3@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/asm-generic/ioctls.h | 118 ++++++++++++++++++++++++++++++++
 tools/perf/MANIFEST                     |   1 +
 tools/perf/check-headers.sh             |   1 +
 3 files changed, 120 insertions(+)
 create mode 100644 tools/include/uapi/asm-generic/ioctls.h

diff --git a/tools/include/uapi/asm-generic/ioctls.h b/tools/include/uapi/asm-generic/ioctls.h
new file mode 100644
index 000000000000..14baf9f23a14
--- /dev/null
+++ b/tools/include/uapi/asm-generic/ioctls.h
@@ -0,0 +1,118 @@
+#ifndef __ASM_GENERIC_IOCTLS_H
+#define __ASM_GENERIC_IOCTLS_H
+
+#include <linux/ioctl.h>
+
+/*
+ * These are the most common definitions for tty ioctl numbers.
+ * Most of them do not use the recommended _IOC(), but there is
+ * probably some source code out there hardcoding the number,
+ * so we might as well use them for all new platforms.
+ *
+ * The architectures that use different values here typically
+ * try to be compatible with some Unix variants for the same
+ * architecture.
+ */
+
+/* 0x54 is just a magic number to make these relatively unique ('T') */
+
+#define TCGETS		0x5401
+#define TCSETS		0x5402
+#define TCSETSW		0x5403
+#define TCSETSF		0x5404
+#define TCGETA		0x5405
+#define TCSETA		0x5406
+#define TCSETAW		0x5407
+#define TCSETAF		0x5408
+#define TCSBRK		0x5409
+#define TCXONC		0x540A
+#define TCFLSH		0x540B
+#define TIOCEXCL	0x540C
+#define TIOCNXCL	0x540D
+#define TIOCSCTTY	0x540E
+#define TIOCGPGRP	0x540F
+#define TIOCSPGRP	0x5410
+#define TIOCOUTQ	0x5411
+#define TIOCSTI		0x5412
+#define TIOCGWINSZ	0x5413
+#define TIOCSWINSZ	0x5414
+#define TIOCMGET	0x5415
+#define TIOCMBIS	0x5416
+#define TIOCMBIC	0x5417
+#define TIOCMSET	0x5418
+#define TIOCGSOFTCAR	0x5419
+#define TIOCSSOFTCAR	0x541A
+#define FIONREAD	0x541B
+#define TIOCINQ		FIONREAD
+#define TIOCLINUX	0x541C
+#define TIOCCONS	0x541D
+#define TIOCGSERIAL	0x541E
+#define TIOCSSERIAL	0x541F
+#define TIOCPKT		0x5420
+#define FIONBIO		0x5421
+#define TIOCNOTTY	0x5422
+#define TIOCSETD	0x5423
+#define TIOCGETD	0x5424
+#define TCSBRKP		0x5425	/* Needed for POSIX tcsendbreak() */
+#define TIOCSBRK	0x5427  /* BSD compatibility */
+#define TIOCCBRK	0x5428  /* BSD compatibility */
+#define TIOCGSID	0x5429  /* Return the session ID of FD */
+#define TCGETS2		_IOR('T', 0x2A, struct termios2)
+#define TCSETS2		_IOW('T', 0x2B, struct termios2)
+#define TCSETSW2	_IOW('T', 0x2C, struct termios2)
+#define TCSETSF2	_IOW('T', 0x2D, struct termios2)
+#define TIOCGRS485	0x542E
+#ifndef TIOCSRS485
+#define TIOCSRS485	0x542F
+#endif
+#define TIOCGPTN	_IOR('T', 0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
+#define TIOCSPTLCK	_IOW('T', 0x31, int)  /* Lock/unlock Pty */
+#define TIOCGDEV	_IOR('T', 0x32, unsigned int) /* Get primary device node of /dev/console */
+#define TCGETX		0x5432 /* SYS5 TCGETX compatibility */
+#define TCSETX		0x5433
+#define TCSETXF		0x5434
+#define TCSETXW		0x5435
+#define TIOCSIG		_IOW('T', 0x36, int)  /* pty: generate signal */
+#define TIOCVHANGUP	0x5437
+#define TIOCGPKT	_IOR('T', 0x38, int) /* Get packet mode state */
+#define TIOCGPTLCK	_IOR('T', 0x39, int) /* Get Pty lock state */
+#define TIOCGEXCL	_IOR('T', 0x40, int) /* Get exclusive mode state */
+#define TIOCGPTPEER	_IO('T', 0x41) /* Safely open the slave */
+
+#define FIONCLEX	0x5450
+#define FIOCLEX		0x5451
+#define FIOASYNC	0x5452
+#define TIOCSERCONFIG	0x5453
+#define TIOCSERGWILD	0x5454
+#define TIOCSERSWILD	0x5455
+#define TIOCGLCKTRMIOS	0x5456
+#define TIOCSLCKTRMIOS	0x5457
+#define TIOCSERGSTRUCT	0x5458 /* For debugging only */
+#define TIOCSERGETLSR   0x5459 /* Get line status register */
+#define TIOCSERGETMULTI 0x545A /* Get multiport config  */
+#define TIOCSERSETMULTI 0x545B /* Set multiport config */
+
+#define TIOCMIWAIT	0x545C	/* wait for a change on serial input line(s) */
+#define TIOCGICOUNT	0x545D	/* read serial port inline interrupt counts */
+
+/*
+ * Some arches already define FIOQSIZE due to a historical
+ * conflict with a Hayes modem-specific ioctl value.
+ */
+#ifndef FIOQSIZE
+# define FIOQSIZE	0x5460
+#endif
+
+/* Used for packet mode */
+#define TIOCPKT_DATA		 0
+#define TIOCPKT_FLUSHREAD	 1
+#define TIOCPKT_FLUSHWRITE	 2
+#define TIOCPKT_STOP		 4
+#define TIOCPKT_START		 8
+#define TIOCPKT_NOSTOP		16
+#define TIOCPKT_DOSTOP		32
+#define TIOCPKT_IOCTL		64
+
+#define TIOCSER_TEMT	0x01	/* Transmitter physically empty */
+
+#endif /* __ASM_GENERIC_IOCTLS_H */
diff --git a/tools/perf/MANIFEST b/tools/perf/MANIFEST
index 705bdb147e73..2ee433c52130 100644
--- a/tools/perf/MANIFEST
+++ b/tools/perf/MANIFEST
@@ -71,6 +71,7 @@ tools/include/linux/kernel.h
 tools/include/linux/list.h
 tools/include/linux/log2.h
 tools/include/uapi/asm-generic/fcntl.h
+tools/include/uapi/asm-generic/ioctls.h
 tools/include/uapi/asm-generic/mman-common.h
 tools/include/uapi/asm-generic/mman.h
 tools/include/uapi/linux/bpf.h
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index d87bc6af0ac2..ff0a5fabf055 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -31,6 +31,7 @@ include/asm-generic/bitops/__fls.h
 include/asm-generic/bitops/fls.h
 include/asm-generic/bitops/fls64.h
 include/linux/coresight-pmu.h
+include/uapi/asm-generic/ioctls.h
 include/uapi/asm-generic/mman-common.h
 '
 
-- 
2.9.4
