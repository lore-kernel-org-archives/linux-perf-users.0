From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/28] perf trace: Beautify mount's first pathname arg
Date: Wed, 31 Oct 2018 13:44:49 -0300
Message-ID: <20181031164508.4784-10-acme@kernel.org>
References: <20181031164508.4784-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181031164508.4784-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Benjamin Peterson <benjamin@python.org>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The pathname beautifiers so far support just one augmented pathname per
syscall, so do it just for mount's first arg, later this will get fixed.

With:

  # perf probe -l
  probe:vfs_getname    (on getname_flags:73@acme/git/linux/fs/namei.c with pathname)
  #

Later this will get added to augmented_syscalls.c (eBPF):

In one xterm:

  # perf trace -e mount,umount
  2687.331 ( 3.544 ms): mount/8892 mount(dev_name: /mnt, dir_name: 0x561f9ac184a0, type: 0x561f9ac1b170, flags: BIND) = 0
  3912.126 ( 8.807 ms): umount/8895 umount2(name: /mnt) = 0
  ^C#

In the other:

  $ sudo mount --bind /proc /mnt
  $ sudo umount /mnt

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Benjamin Peterson <benjamin@python.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-qsvhrm2es635cl4zicqjeth2@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d286f73ef2e5..dc8a6c4986ce 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -727,7 +727,8 @@ static struct syscall_fmt {
 		   [2] = { .scnprintf = SCA_MMAP_PROT,	/* prot */ },
 		   [3] = { .scnprintf = SCA_MMAP_FLAGS,	/* flags */ }, }, },
 	{ .name	    = "mount",
-	  .arg = { [3] = { .scnprintf = SCA_MOUNT_FLAGS, /* flags */
+	  .arg = { [0] = { .scnprintf = SCA_FILENAME, /* dev_name */ },
+		   [3] = { .scnprintf = SCA_MOUNT_FLAGS, /* flags */
 			   .mask_val  = SCAMV_MOUNT_FLAGS, /* flags */ }, }, },
 	{ .name	    = "mprotect",
 	  .arg = { [0] = { .scnprintf = SCA_HEX,	/* start */ },
-- 
2.14.4
