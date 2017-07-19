From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 25/86] perf trace beauty fcntl: Augment the return of F_DUPFD(_CLOEXEC)
Date: Wed, 19 Jul 2017 11:28:49 -0300
Message-ID: <20170719142950.3747-26-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753174AbdGSOcW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 Jul 2017 10:32:22 -0400
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Using the existing 'fd' beautifier, now we can see the path for the just
dup'ed fd:

 18031.338 ( 0.009 ms): gnome-terminal/2472 fcntl(fd: 55, cmd: DUPFD_CLOEXEC) = 56</memfd:gdk-wayland (deleted)>

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-z0ggo126p2eobfwnjw9z16tw@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/fcntl.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/fcntl.c b/tools/perf/trace/beauty/fcntl.c
index 9de80a7eddfa..254ae435780d 100644
--- a/tools/perf/trace/beauty/fcntl.c
+++ b/tools/perf/trace/beauty/fcntl.c
@@ -30,6 +30,10 @@ size_t syscall_arg__scnprintf_fcntl_cmd(char *bf, size_t size, struct syscall_ar
 		syscall_arg__set_ret_scnprintf(arg, syscall_arg__scnprintf_fcntl_getfd);
 		goto mask_arg;
 	}
+	if (arg->val == F_DUPFD_CLOEXEC || arg->val == F_DUPFD) {
+		syscall_arg__set_ret_scnprintf(arg, syscall_arg__scnprintf_fd);
+		goto out;
+	}
 	/*
 	 * Some commands ignore the third fcntl argument, "arg", so mask it
 	 */
@@ -38,7 +42,7 @@ size_t syscall_arg__scnprintf_fcntl_cmd(char *bf, size_t size, struct syscall_ar
 mask_arg:
 		arg->mask |= (1 << 2);
 	}
-
+out:
 	return syscall_arg__scnprintf_strarrays(bf, size, arg);
 }
 
-- 
2.9.4
