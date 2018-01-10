From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 24/27] perf trace: Beautify 'gettid' syscall result
Date: Wed, 10 Jan 2018 18:28:41 -0300
Message-ID: <20180110212844.12441-25-acme@kernel.org>
References: <20180110212844.12441-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753877AbeAJVaG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 Jan 2018 16:30:06 -0500
In-Reply-To: <20180110212844.12441-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Before:

  # trace -a -e gettid sleep 0.01
<SNIP>
     4.863 ( 0.005 ms): Chrome_ChildIO/26241 gettid() = 26241
     4.931 ( 0.004 ms): Chrome_IOThrea/26154 gettid() = 26154
     4.942 ( 0.001 ms): Chrome_IOThrea/26154 gettid() = 26154
     4.946 ( 0.001 ms): Chrome_IOThrea/26154 gettid() = 26154
     4.970 ( 0.002 ms): Chrome_IOThrea/26154 gettid() = 26154
  #

After:

  # trace -a -e gettid sleep 0.01
     0.000 ( 0.009 ms): Chrome_IOThrea/26154 gettid() = 26154 (Chrome_IOThread)
<SNIP>
     3.416 ( 0.002 ms): Chrome_ChildIO/26241 gettid() = 26241 (Chrome_ChildIOT)
     3.424 ( 0.001 ms): Chrome_ChildIO/26241 gettid() = 26241 (Chrome_ChildIOT)
     3.343 ( 0.002 ms): chrome/26116 gettid() = 26116 (chrome)
     3.386 ( 0.002 ms): Chrome_IOThrea/26154 gettid() = 26154 (Chrome_IOThread)
     4.003 ( 0.003 ms): Chrome_ChildIO/26241 gettid() = 26241 (Chrome_ChildIOT)
     4.031 ( 0.002 ms): Chrome_IOThrea/26154 gettid() = 26154 (Chrome_IOThread)
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-kyg4gz2yy0vkrrh2vtq29u71@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 7c57898095ea..71e64bdca86f 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -622,6 +622,7 @@ static struct syscall_fmt {
 	  .arg = { [2] = { .scnprintf = SCA_GETRANDOM_FLAGS, /* flags */ }, }, },
 	{ .name	    = "getrlimit",
 	  .arg = { [0] = STRARRAY(resource, rlimit_resources), }, },
+	{ .name	    = "gettid",	    .errpid = true, },
 	{ .name	    = "ioctl",
 	  .arg = {
 #if defined(__i386__) || defined(__x86_64__)
-- 
2.14.3
