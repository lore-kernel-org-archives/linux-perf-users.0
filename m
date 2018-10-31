From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/28] perf trace: Beautify the umount's 'name' argument
Date: Wed, 31 Oct 2018 13:44:48 -0300
Message-ID: <20181031164508.4784-9-acme@kernel.org>
References: <20181031164508.4784-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181031164508.4784-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Benjamin Peterson <benjamin@python.org>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

By using the SCA_FILENAME beautifier, that works when either the
probe:vfs_getname probe is in place or with the eBPF program
tools/perf/examples/bpf/augmented_syscalls.c:

  # perf probe -l
  probe:vfs_getname (on getname_flags:73@acme/git/linux/fs/namei.c with pathname)
  # perf trace -e umount
  9630.332 ( 9.521 ms): umount/8082 umount2(name: /mnt) = 0
  #

The augmented syscalls one will be done in the next patch.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Benjamin Peterson <benjamin@python.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-hegbzlpd2nrn584l5jxn7sy2@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index db8711061ca3..d286f73ef2e5 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -838,7 +838,8 @@ static struct syscall_fmt {
 	  .arg = { [2] = { .scnprintf = SCA_SIGNUM, /* sig */ }, }, },
 	{ .name	    = "tkill",
 	  .arg = { [1] = { .scnprintf = SCA_SIGNUM, /* sig */ }, }, },
-	{ .name     = "umount2", .alias = "umount", },
+	{ .name     = "umount2", .alias = "umount",
+	  .arg = { [0] = { .scnprintf = SCA_FILENAME, /* name */ }, }, },
 	{ .name	    = "uname", .alias = "newuname", },
 	{ .name	    = "unlinkat",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* dfd */ }, }, },
-- 
2.14.4
