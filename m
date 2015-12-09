From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: [PATCH perf/core 17/22] perf: Fix __machine__addnew_vdso to put dso
 after add to dsos
Date: Wed, 09 Dec 2015 11:11:25 +0900
Message-ID: <20151209021125.10245.54213.stgit@localhost.localdomain>
References: <20151209021047.10245.8918.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151209021047.10245.8918.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

Fix __machine__addnew_vdso to put dso after add to dsos because
the dso is already gotten by the dsos via __dsos__add().

This function is called finally from machine__findnew_vdso()
which locks machine->dsos.lock. And before unlock it, the
function gets the dso's refcnt. Thus we can ensure that the
dso is not removed from the machine while this operation,
and we don't need to get the dso except for the machine->dsos.

refcnt debugger shows:
  -----
  $ ./perf top --stdio -v	(note: run by non-root user)
  [...]
  ==== [3] ====
  Unreclaimed dso@0x27a0a30
  Refcount +1 => 1 at
    ./perf(dso__new+0x2bc) [0x4a778c]
    ./perf(machine__findnew_vdso+0x272) [0x4e8792]
    ./perf(map__new+0x2db) [0x4bfb4b]
    ./perf(machine__process_mmap2_event+0xf3) [0x4bda33]
    ./perf(perf_event__synthesize_mmap_events+0x364) [0x484e74]
    ./perf(perf_event__synthesize_threads+0x3ee) [0x48583e]
    ./perf(cmd_top+0xdc2) [0x43cfb2]
    ./perf() [0x47ba35]
    ./perf(main+0x617) [0x4225b7]
    /lib64/libc.so.6(__libc_start_main+0xf5) [0x7f2b01387af5]
    ./perf() [0x42272d]
  Refcount +1 => 2 at
    ./perf(machine__findnew_vdso+0x289) [0x4e87a9]
    ./perf(map__new+0x2db) [0x4bfb4b]
    ./perf(machine__process_mmap2_event+0xf3) [0x4bda33]
    ./perf(perf_event__synthesize_mmap_events+0x364) [0x484e74]
    ./perf(perf_event__synthesize_threads+0x3ee) [0x48583e]
    ./perf(cmd_top+0xdc2) [0x43cfb2]
    ./perf() [0x47ba35]
    ./perf(main+0x617) [0x4225b7]
    /lib64/libc.so.6(__libc_start_main+0xf5) [0x7f2b01387af5]
    ./perf() [0x42272d]
  Refcount +1 => 3 at
    ./perf(dso__get+0x32) [0x4a7b52]
    ./perf(machine__findnew_vdso+0xc1) [0x4e85e1]
    ./perf(map__new+0x2db) [0x4bfb4b]
    ./perf(machine__process_mmap2_event+0xf3) [0x4bda33]
    ./perf(perf_event__synthesize_mmap_events+0x364) [0x484e74]
    ./perf(perf_event__synthesize_threads+0x3ee) [0x48583e]
    ./perf(cmd_top+0xdc2) [0x43cfb2]
    ./perf() [0x47ba35]
    ./perf(main+0x617) [0x4225b7]
    /lib64/libc.so.6(__libc_start_main+0xf5) [0x7f2b01387af5]
    ./perf() [0x42272d]
  [...]
  -----

The log shows that the machine__findnew_vdso gets a dso
so many unnaturally. I've traced the code and found this
bug.

Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
---
 tools/perf/util/vdso.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/vdso.c b/tools/perf/util/vdso.c
index 44d440d..fea0d18 100644
--- a/tools/perf/util/vdso.c
+++ b/tools/perf/util/vdso.c
@@ -130,6 +130,8 @@ static struct dso *__machine__addnew_vdso(struct machine *machine, const char *s
 		__dsos__add(&machine->dsos, dso);
 		dso__set_long_name(dso, long_name, false);
 	}
+	/* Put the dso here because it is already gotten by __dsos__add */
+	dso__put(dso);
 
 	return dso;
 }
