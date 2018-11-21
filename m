From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 6/7] tools uapi asm-generic: Synchronize ioctls.h
Date: Wed, 21 Nov 2018 11:25:04 -0300
Message-ID: <20181121142505.27379-7-acme@kernel.org>
References: <20181121142505.27379-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181121142505.27379-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick up the changes in:

  ad8c0eaa0a41 ("tty/serial_core: add ISO7816 infrastructure")

That is a change that imply a change to be made in tools/perf/trace/beauty/ioctl.c to
make 'perf trace' ioctl syscall argument beautifier to support these new
commands:  TIOCGISO7816 and TIOCSISO7816.

This is not yet done automatically by a script like is done for some
other headers, for instance:

  $ tools/perf/trace/beauty/drm_ioctl.sh | head
  #ifndef DRM_COMMAND_BASE
  #define DRM_COMMAND_BASE                0x40
  #endif
  static const char *drm_ioctl_cmds[] = {
	[0x00] = "VERSION",
	[0x01] = "GET_UNIQUE",
	[0x02] = "GET_MAGIC",
	[0x03] = "IRQ_BUSID",
	[0x04] = "GET_MAP",
	[0x05] = "GET_CLIENT",
  $

So we will need to change tools/perf/trace/beauty/ioctl.c in a follow up
patch until we switch to a generator script.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-zin76fe6iykqsilvo6u47f9o@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/asm-generic/ioctls.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/uapi/asm-generic/ioctls.h b/tools/include/uapi/asm-generic/ioctls.h
index 040651735662..cdc9f4ca8c27 100644
--- a/tools/include/uapi/asm-generic/ioctls.h
+++ b/tools/include/uapi/asm-generic/ioctls.h
@@ -79,6 +79,8 @@
 #define TIOCGPTLCK	_IOR('T', 0x39, int) /* Get Pty lock state */
 #define TIOCGEXCL	_IOR('T', 0x40, int) /* Get exclusive mode state */
 #define TIOCGPTPEER	_IO('T', 0x41) /* Safely open the slave */
+#define TIOCGISO7816	_IOR('T', 0x42, struct serial_iso7816)
+#define TIOCSISO7816	_IOWR('T', 0x43, struct serial_iso7816)
 
 #define FIONCLEX	0x5450
 #define FIOCLEX		0x5451
-- 
2.14.5
