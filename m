From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/29] perf beauty ioctl: Add generator for USBDEVFS_ ioctl commands
Date: Thu,  3 Jan 2019 09:45:52 -0300
Message-ID: <20190103124609.29672-13-acme@kernel.org>
References: <20190103124609.29672-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190103124609.29672-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Will be associated with fds with the right device major.

  $ tools/perf/trace/beauty/usbdevfs_ioctl.sh
  static const char *usbdevfs_ioctl_cmds[] = {
	[0] = "CONTROL",
	[10] = "SUBMITURB",
	[11] = "DISCARDURB",
	[12] = "REAPURB",
	[13] = "REAPURBNDELAY",
	[14] = "DISCSIGNAL",
	[15] = "CLAIMINTERFACE",
	[16] = "RELEASEINTERFACE",
	[17] = "CONNECTINFO",
	[18] = "IOCTL",
	[19] = "HUB_PORTINFO",
	[20] = "RESET",
	[21] = "CLEAR_HALT",
	[22] = "DISCONNECT",
	[23] = "CONNECT",
	[24] = "CLAIM_PORT",
	[25] = "RELEASE_PORT",
	[26] = "GET_CAPABILITIES",
	[27] = "DISCONNECT_CLAIM",
	[28] = "ALLOC_STREAMS",
	[29] = "FREE_STREAMS",
	[2] = "BULK",
	[30] = "DROP_PRIVILEGES",
	[31] = "GET_SPEED",
	[3] = "RESETEP",
	[4] = "SETINTERFACE",
	[5] = "SETCONFIGURATION",
	[8] = "GETDRIVER",
  };

  #if 0
  static const char *usbdevfs_ioctl_32_cmds[] = {
	[0] = "CONTROL32",
	[10] = "SUBMITURB32",
	[12] = "REAPURB32",
	[13] = "REAPURBNDELAY32",
	[14] = "DISCSIGNAL32",
	[18] = "IOCTL32",
	[2] = "BULK32",
  };
  #endif
  $

Leaving the '32' variants commented, later we can try to support those
as well, from some other hint (maybe something about the thread issuing
the ioctls) and from the _IOC_SIZE(cmd).

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-neq1lrji5k4ku0rktn7ytnri@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/usbdevfs_ioctl.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100755 tools/perf/trace/beauty/usbdevfs_ioctl.sh

diff --git a/tools/perf/trace/beauty/usbdevfs_ioctl.sh b/tools/perf/trace/beauty/usbdevfs_ioctl.sh
new file mode 100755
index 000000000000..930b80f422e8
--- /dev/null
+++ b/tools/perf/trace/beauty/usbdevfs_ioctl.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+# SPDX-License-Identifier: LGPL-2.1
+
+[ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/linux/
+
+printf "static const char *usbdevfs_ioctl_cmds[] = {\n"
+regex="^#[[:space:]]*define[[:space:]]+USBDEVFS_(\w+)[[:space:]]+_IO[WR]{0,2}\([[:space:]]*'U'[[:space:]]*,[[:space:]]*([[:digit:]]+).*"
+egrep $regex ${header_dir}/usbdevice_fs.h | egrep -v 'USBDEVFS_\w+32[[:space:]]' | \
+	sed -r "s/$regex/\2 \1/g"	| \
+	sort | xargs printf "\t[%s] = \"%s\",\n"
+printf "};\n\n"
+printf "#if 0\n"
+printf "static const char *usbdevfs_ioctl_32_cmds[] = {\n"
+regex="^#[[:space:]]*define[[:space:]]+USBDEVFS_(\w+)[[:space:]]+_IO[WR]{0,2}\([[:space:]]*'U'[[:space:]]*,[[:space:]]*([[:digit:]]+).*"
+egrep $regex ${header_dir}/usbdevice_fs.h | egrep 'USBDEVFS_\w+32[[:space:]]' | \
+	sed -r "s/$regex/\2 \1/g"	| \
+	sort | xargs printf "\t[%s] = \"%s\",\n"
+printf "};\n"
+printf "#endif\n"
-- 
2.19.2
