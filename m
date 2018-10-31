From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/28] perf trace: Consider syscall aliases too
Date: Wed, 31 Oct 2018 13:44:47 -0300
Message-ID: <20181031164508.4784-8-acme@kernel.org>
References: <20181031164508.4784-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181031164508.4784-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Benjamin Peterson <benjamin@python.org>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When trying to trace the 'umount' syscall on x86_64 I noticed that it
was failing:

  # trace -e umount umount /mnt
  event syntax error: 'umount'
                       \___ parser error
  Run 'perf list' for a list of valid events

   Usage: perf trace [<options>] [<command>]
      or: perf trace [<options>] -- <command> [<options>]
      or: perf trace record [<options>] [<command>]
      or: perf trace record [<options>] -- <command> [<options>]

      -e, --event <event>   event/syscall selector. use 'perf list' to list available events
  #

This is because in the x86-64 we have it just as 'umount2':

  $ grep umount arch/x86/entry/syscalls/syscall_64.tbl
  166	common	umount2			__x64_sys_umount
  $

So if the syscall name fails, try fallbacking to looking at the aliases
we have in the syscall_fmts table to then re-lookup, now:

  # trace -e umount umount -f /mnt
  umount: /mnt: not mounted.
     1.759 ( 0.004 ms): umount/18365 umount2(name: 0x55fbfcbc4480, flags: 1) = -1 EINVAL Invalid argument
  #

Time to beautify the flags arg :-)

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Benjamin Peterson <benjamin@python.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-ukweodgzbmjd25lfkgryeft1@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 76c14c0129fc..db8711061ca3 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -862,6 +862,18 @@ static struct syscall_fmt *syscall_fmt__find(const char *name)
 	return bsearch(name, syscall_fmts, nmemb, sizeof(struct syscall_fmt), syscall_fmt__cmp);
 }
 
+static struct syscall_fmt *syscall_fmt__find_by_alias(const char *alias)
+{
+	int i, nmemb = ARRAY_SIZE(syscall_fmts);
+
+	for (i = 0; i < nmemb; ++i) {
+		if (syscall_fmts[i].alias && strcmp(syscall_fmts[i].alias, alias) == 0)
+			return &syscall_fmts[i];
+	}
+
+	return NULL;
+}
+
 /*
  * is_exit: is this "exit" or "exit_group"?
  * is_open: is this "open" or "openat"? To associate the fd returned in sys_exit with the pathname in sys_enter.
@@ -3195,6 +3207,7 @@ static int trace__parse_events_option(const struct option *opt, const char *str,
 	int len = strlen(str) + 1, err = -1, list, idx;
 	char *strace_groups_dir = system_path(STRACE_GROUPS_DIR);
 	char group_name[PATH_MAX];
+	struct syscall_fmt *fmt;
 
 	if (strace_groups_dir == NULL)
 		return -1;
@@ -3212,12 +3225,19 @@ static int trace__parse_events_option(const struct option *opt, const char *str,
 		if (syscalltbl__id(trace->sctbl, s) >= 0 ||
 		    syscalltbl__strglobmatch_first(trace->sctbl, s, &idx) >= 0) {
 			list = 1;
+			goto do_concat;
+		}
+
+		fmt = syscall_fmt__find_by_alias(s);
+		if (fmt != NULL) {
+			list = 1;
+			s = fmt->name;
 		} else {
 			path__join(group_name, sizeof(group_name), strace_groups_dir, s);
 			if (access(group_name, R_OK) == 0)
 				list = 1;
 		}
-
+do_concat:
 		if (lists[list]) {
 			sprintf(lists[list] + strlen(lists[list]), ",%s", s);
 		} else {
-- 
2.14.4
