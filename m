From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 014/107] perf trace: Look for default name for entries in the syscalls prog array
Date: Mon, 29 Jul 2019 23:54:37 -0300
Message-ID: <20190730025610.22603-15-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

I.e. just look for "!syscalls:sys_enter_" or "exit_" plus the syscall
name, that way we need just to add entries to the
augmented_raw_syscalls.c BPF source to add handlers.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-6xavwddruokp6ohs7tf4qilb@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index c64f7c99db15..5258399a1c94 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -830,13 +830,11 @@ static struct syscall_fmt {
 	{ .name	    = "newfstatat",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* dfd */ }, }, },
 	{ .name	    = "open",
-	  .bpf_prog_name = { .sys_enter = "!syscalls:sys_enter_open", },
 	  .arg = { [1] = { .scnprintf = SCA_OPEN_FLAGS, /* flags */ }, }, },
 	{ .name	    = "open_by_handle_at",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT,	/* dfd */ },
 		   [2] = { .scnprintf = SCA_OPEN_FLAGS, /* flags */ }, }, },
 	{ .name	    = "openat",
-	  .bpf_prog_name = { .sys_enter = "!syscalls:sys_enter_openat", },
 	  .arg = { [0] = { .scnprintf = SCA_FDAT,	/* dfd */ },
 		   [2] = { .scnprintf = SCA_OPEN_FLAGS, /* flags */ }, }, },
 	{ .name	    = "perf_event_open",
@@ -873,7 +871,6 @@ static struct syscall_fmt {
 	{ .name	    = "recvmsg",
 	  .arg = { [2] = { .scnprintf = SCA_MSG_FLAGS, /* flags */ }, }, },
 	{ .name	    = "renameat",
-	  .bpf_prog_name = { .sys_enter = "!syscalls:sys_enter_renameat", },
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* olddirfd */ },
 		   [2] = { .scnprintf = SCA_FDAT, /* newdirfd */ }, }, },
 	{ .name	    = "renameat2",
@@ -2778,12 +2775,27 @@ static struct bpf_program *trace__find_syscall_bpf_prog(struct trace *trace, str
 {
 	struct bpf_program *prog;
 
-	if (prog_name == NULL)
+	if (prog_name == NULL) {
+		char default_prog_name[256];
+		scnprintf(default_prog_name, sizeof(default_prog_name), "!syscalls:sys_%s_%s", type, sc->name);
+		prog = trace__find_bpf_program_by_title(trace, default_prog_name);
+		if (prog != NULL)
+			goto out_found;
+		if (sc->fmt && sc->fmt->alias) {
+			scnprintf(default_prog_name, sizeof(default_prog_name), "!syscalls:sys_%s_%s", type, sc->fmt->alias);
+			prog = trace__find_bpf_program_by_title(trace, default_prog_name);
+			if (prog != NULL)
+				goto out_found;
+		}
 		goto out_unaugmented;
+	}
 
 	prog = trace__find_bpf_program_by_title(trace, prog_name);
-	if (prog != NULL)
+
+	if (prog != NULL) {
+out_found:
 		return prog;
+	}
 
 	pr_debug("Couldn't find BPF prog \"%s\" to associate with syscalls:sys_%s_%s, not augmenting it\n",
 		 prog_name, type, sc->name);
@@ -2798,12 +2810,8 @@ static void trace__init_syscall_bpf_progs(struct trace *trace, int id)
 	if (sc == NULL)
 		return;
 
-	if (sc->fmt != NULL) {
-		sc->bpf_prog.sys_enter = trace__find_syscall_bpf_prog(trace, sc, sc->fmt->bpf_prog_name.sys_enter, "enter");
-		sc->bpf_prog.sys_exit  = trace__find_syscall_bpf_prog(trace, sc, sc->fmt->bpf_prog_name.sys_exit,  "exit");
-	} else {
-		sc->bpf_prog.sys_enter = sc->bpf_prog.sys_exit = trace->syscalls.unaugmented_prog;
-	}
+	sc->bpf_prog.sys_enter = trace__find_syscall_bpf_prog(trace, sc, sc->fmt ? sc->fmt->bpf_prog_name.sys_enter : NULL, "enter");
+	sc->bpf_prog.sys_exit  = trace__find_syscall_bpf_prog(trace, sc, sc->fmt ? sc->fmt->bpf_prog_name.sys_exit  : NULL,  "exit");
 }
 
 static int trace__bpf_prog_sys_enter_fd(struct trace *trace, int id)
-- 
2.21.0
