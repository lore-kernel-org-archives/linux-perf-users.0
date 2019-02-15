From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 16/43] perf beauty waitid options: Fix up prefix showing logic
Date: Thu, 14 Feb 2019 21:45:12 -0300
Message-ID: <20190215004539.23571-17-acme@kernel.org>
References: <20190215004539.23571-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When introducing the possibility for selecting if the common prefix to
options such as the waitid ones, i.e. all 'waitid' options start with
'W', so, to make it make it more compact if configured to suppress it,
'perf trace' will do so, other examples include mmap's PROT_ prefix for
its 'prot' argument, etc, which, when showing the syscall argument name
ends up producing duplicated info that clutters the screen, i.e.:

  # perf trace -e mmap --max-events 2 sleep 1
     0.000 ( 0.014 ms): sleep/20886 mmap(len: 112595, prot: PROT_READ, flags: MAP_PRIVATE, fd: 3) = 0x7f3e986d2000
     0.041 ( 0.005 ms): sleep/20886 mmap(len: 8192, prot: PROT_READ|PROT_WRITE, flags: MAP_PRIVATE|MAP_ANONYMOUS) = 0x7f3e986d0000
  #

So it is possible to suppress that and make it more compact by having
this in your ~/.perfconfig:

  # cat ~/.perfconfig
  [trace]
	show_prefix = no
  #

  # perf trace -e mmap --max-events 2 sleep 1
     0.000 ( 0.014 ms): sleep/8009 mmap(len: 112595, prot: READ, flags: PRIVATE, fd: 3) = 0x7ff2373de000
     0.040 ( 0.005 ms): sleep/8009 mmap(len: 8192, prot: READ|WRITE, flags: PRIVATE|ANONYMOUS) = 0x7ff2373dc000
  #

To have it look more like strace's output, we instead want to suppress
the arg name and show the prefix, so use:

  # cat ~/.perfconfig
  [trace]
	show_prefix = yes
	show_arg_names = no
  #
  # perf trace -e mmap --max-events 2 sleep 1
     0.000 ( 0.006 ms): sleep/15513 mmap(NULL, 112595, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7f7a9b6d3000
     0.020 ( 0.002 ms): sleep/15513 mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS) = 0x7f7a9b6d1000
  #

When this logic was introduced a bug came with it when processing the
waitid 'option' arg that ended up expecting 3 strings when just two were
being provided, fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: c65c83ffe904 ("perf trace: Allow asking for not suppressing common string prefixes")
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/waitid_options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/waitid_options.c b/tools/perf/trace/beauty/waitid_options.c
index 6897fab40dcc..d4d10b33ba0e 100644
--- a/tools/perf/trace/beauty/waitid_options.c
+++ b/tools/perf/trace/beauty/waitid_options.c
@@ -11,7 +11,7 @@ static size_t syscall_arg__scnprintf_waitid_options(char *bf, size_t size,
 
 #define	P_OPTION(n) \
 	if (options & W##n) { \
-		printed += scnprintf(bf + printed, size - printed, "%s%s%s", printed ? "|" : "", show_prefix ? prefix : #n); \
+		printed += scnprintf(bf + printed, size - printed, "%s%s%s", printed ? "|" : "", show_prefix ? prefix : "",  #n); \
 		options &= ~W##n; \
 	}
 
-- 
2.19.1
