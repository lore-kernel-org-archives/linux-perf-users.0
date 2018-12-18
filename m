From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 39/63] perf trace: Allow configuring default for perf_event_attr.inherit
Date: Tue, 18 Dec 2018 19:07:09 -0300
Message-ID: <20181218220733.15839-40-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

I.f. if children should inherit the parent perf_event configuration,
i.e. if we should trace children as well or just the parent.

The default is to follow children, to disable this and have a behaviour
similar to strace, set this config option or use the --no_inherit 'perf
trace' option.

E.g.:

Default:

  # perf config trace.no_inherit
  # trace -e clone,*sleep time sleep 1
     0.000 time/21107 clone(clone_flags: CHILD_CLEARTID|CHILD_SETTID|0x11, newsp: 0, child_tidptr: 0x7f7b8f9ae810) = 21108 (time)
         ? time/21108  ... [continued]: clone()
     0.691 sleep/21108 nanosleep(rqtp: 0x7ffed01d0540, rmtp: 0                               ) = 0
  0.00user 0.00system 0:01.00elapsed 0%CPU (0avgtext+0avgdata 1988maxresident)k
  0inputs+0outputs (0major+76minor)pagefaults 0swaps
  #

Disable it:

  # trace -e clone,*sleep time sleep 1
     0.000 clone(clone_flags: CHILD_CLEARTID|CHILD_SETTID|0x11, newsp: 0, child_tidptr: 0x7ff41e100810) = 21414 (time)
  0.00user 0.00system 0:01.00elapsed 0%CPU (0avgtext+0avgdata 1964maxresident)k
  0inputs+0outputs (0major+76minor)pagefaults 0swaps
  #

Notice that since there is just one thread, the "comm/TID" column is
suppressed.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-thd8s16pagyza71ufi5vjlan@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-config.txt | 3 +++
 tools/perf/builtin-trace.c               | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 0d641b0d15ae..cd9bf12fb255 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -529,6 +529,9 @@ trace.*::
 		activate the 'perf trace' logic that looks for syscall
 		pointer contents after the normal tracepoint payload.
 
+	trace.no_inherit::
+		Do not follow children threads.
+
 	trace.show_duration::
 		Show syscall duration.
 
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 4355dadad232..a4e2290e57e0 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3542,6 +3542,8 @@ static int trace__config(const char *var, const char *value, void *arg)
 		trace->show_duration = perf_config_bool(var, value);
 	} else if (!strcmp(var, "trace.show_zeros")) {
 		trace->show_zeros = perf_config_bool(var, value);
+	} else if (!strcmp(var, "trace.no_inherit")) {
+		trace->opts.no_inherit = perf_config_bool(var, value);
 	}
 
 	return err;
-- 
2.19.2
