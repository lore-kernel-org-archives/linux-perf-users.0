From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 20/25] perf trace: Fixup pointer arithmetic when consuming augmented syscall args
Date: Fri, 21 Jun 2019 14:38:26 -0300
Message-ID: <20190621173831.13780-21-acme@kernel.org>
References: <20190621173831.13780-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190621173831.13780-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Brendan Gregg <brendan.d.gregg@gmail.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We can't just add the consumed bytes to the arg->augmented.args member,
as it is not void *, so it will access (consumed * sizeof(struct augmented_arg))
in the next augmented arg, totally wrong, cast the member to void pointe
before adding the number of bytes consumed, duh.

With this and hardcoding handling the 'renameat' and 'renameat2'
syscalls in the tools/perf/examples/bpf/augmented_raw_syscalls.c eBPF
proggie, we get:

	mv/24388 renameat2(AT_FDCWD, "/tmp/build/perf/util/.bpf-event.o.tmp", AT_FDCWD, "/tmp/build/perf/util/.bpf-event.o.cmd", RENAME_NOREPLACE) = 0
	mv/24394 renameat2(AT_FDCWD, "/tmp/build/perf/util/.perf-hooks.o.tmp", AT_FDCWD, "/tmp/build/perf/util/.perf-hooks.o.cmd", RENAME_NOREPLACE) = 0
	mv/24398 renameat2(AT_FDCWD, "/tmp/build/perf/util/.pmu-bison.o.tmp", AT_FDCWD, "/tmp/build/perf/util/.pmu-bison.o.cmd", RENAME_NOREPLACE) = 0
	mv/24401 renameat2(AT_FDCWD, "/tmp/build/perf/util/.expr-bison.o.tmp", AT_FDCWD, "/tmp/build/perf/util/.expr-bison.o.cmd", RENAME_NOREPLACE) = 0
	mv/24406 renameat2(AT_FDCWD, "/tmp/build/perf/util/.pmu.o.tmp", AT_FDCWD, "/tmp/build/perf/util/.pmu.o.cmd", RENAME_NOREPLACE) = 0
	mv/24407 renameat2(AT_FDCWD, "/tmp/build/perf/util/.pmu-flex.o.tmp", AT_FDCWD, "/tmp/build/perf/util/.pmu-flex.o.cmd", RENAME_NOREPLACE) = 0
	mv/24416 renameat2(AT_FDCWD, "/tmp/build/perf/util/.parse-events-flex.o.tmp", AT_FDCWD, "/tmp/build/perf/util/.parse-events-flex.o.cmd", RENAME_NOREPLACE) = 0

I.e. it works with two string args in the same syscall.

Now back to taming the verifier...

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: 8195168e8779 ("perf trace: Consume the augmented_raw_syscalls payload")
Link: https://lkml.kernel.org/n/tip-n1w59lpxks6m1le7fpo6rmyw@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d5b2e4d8bf41..f3532b081b31 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1239,7 +1239,7 @@ static size_t syscall_arg__scnprintf_augmented_string(struct syscall_arg *arg, c
 	 */
 	int consumed = sizeof(*augmented_arg) + augmented_arg->size;
 
-	arg->augmented.args += consumed;
+	arg->augmented.args = ((void *)arg->augmented.args) + consumed;
 	arg->augmented.size -= consumed;
 
 	return printed;
-- 
2.20.1
