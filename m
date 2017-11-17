From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 37/83] tools headers: Synchronize kernel ABI headers wrt SPDX tags
Date: Fri, 17 Nov 2017 17:15:15 -0300
Message-ID: <20171117201601.24110-38-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161726AbdKQUSV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:18:21 -0500
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>

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
