From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/37] perf bpf: Do not attach a BPF prog to a tracepoint if its name starts with !
Date: Mon, 22 Jul 2019 14:38:04 -0300
Message-ID: <20190722173839.22898-3-acme@kernel.org>
References: <20190722173839.22898-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722173839.22898-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

With BPF_MAP_TYPE_PROG_ARRAY + bpf_tail_call() we want to have BPF
programs, i.e. functions in a object file that perf's BPF loader
shouldn't try to attach to anything, i.e. "!syscalls:sys_enter_open"
should just stay there, not be attached to a tracepoint with that name,
it'll be used by, for instance, 'perf trace' to associate with syscalls
that copy, in addition to the syscall raw args, a filename pointed by
the first arg, i.e. multiple syscalls that need copying the same pointer
arg in the same way, as a filename, for instance, will share the same
BPF program/function.

Right now when perf's BPF loader sees a function with a name
"sys:name" it'll look for a tracepoint and will associate that BPF
program with it, say:

  SEC("raw_syscalls:sys_enter")
  int sys_enter(struct syscall_enter_args *args)
  {
     //SNIP
  }

Will crate a perf_evsel tracepoint event and then associate with it that
BPF program.

This convention at some point will switch to the one used by the BPF
loader in libbpf, but to experiment with BPF_MAP_TYPE_PROG_ARRAY in
'perf trace' lets do this, that will not require changing too much
stuff.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-lk6dasjr1yf9rtvl292b2hpc@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-events.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 371ff3aee769..fac6b32ef94a 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -639,6 +639,15 @@ static int add_bpf_event(const char *group, const char *event, int fd,
 	struct list_head *list = param->list;
 	struct perf_evsel *pos;
 	int err;
+	/*
+	 * Check if we should add the event, i.e. if it is a TP but starts with a '!',
+	 * then don't add the tracepoint, this will be used for something else, like
+	 * adding to a BPF_MAP_TYPE_PROG_ARRAY.
+	 *
+	 * See tools/perf/examples/bpf/augmented_raw_syscalls.c
+	 */
+	if (group[0] == '!')
+		return 0;
 
 	pr_debug("add bpf event %s:%s and attach bpf program %d\n",
 		 group, event, fd);
-- 
2.21.0
