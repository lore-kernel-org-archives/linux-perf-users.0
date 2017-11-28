From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 23/30] tools headers: Synchronize kernel ABI headers wrt SPDX tags
Date: Tue, 28 Nov 2017 12:02:13 -0300
Message-ID: <20171128150220.5064-24-acme@kernel.org>
References: <20171128150220.5064-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171128150220.5064-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Two more, that were just in perf/core and thus weren't covered by Ingo's
latest headers synch, kcmp.h and prctl.h, silencing this:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/kcmp.h' differs from latest version at 'include/uapi/linux/kcmp.h'
  Warning: Kernel ABI header at 'tools/include/uapi/linux/prctl.h' differs from latest version at 'include/uapi/linux/prctl.h'

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-2a0r7iybyqpkftllyy5t9hfk@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/kcmp.h  | 1 +
 tools/include/uapi/linux/prctl.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/include/uapi/linux/kcmp.h b/tools/include/uapi/linux/kcmp.h
index 481e103da78e..ef1305010925 100644
--- a/tools/include/uapi/linux/kcmp.h
+++ b/tools/include/uapi/linux/kcmp.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 #ifndef _UAPI_LINUX_KCMP_H
 #define _UAPI_LINUX_KCMP_H
 
diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prctl.h
index a8d0759a9e40..b640071421f7 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 #ifndef _LINUX_PRCTL_H
 #define _LINUX_PRCTL_H
 
-- 
2.13.6
