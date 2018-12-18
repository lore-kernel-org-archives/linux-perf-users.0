From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 58/63] perf beauty mmap: Print mmap's 'offset' arg in hexadecimal
Date: Tue, 18 Dec 2018 19:07:28 -0300
Message-ID: <20181218220733.15839-59-acme@kernel.org>
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

Also to make it match 'strace' output, for regression testing.

Both now produce this option, when 'perf trace' uses a .perfconfig
asking for the strace like output:

  mmap(0x7faf66e6a000, 1363968, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x22000) = 0x7faf66e6a000

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-27qhouo1kaac2iyl85nfnsf5@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 2cc62ca75b2e..ebde59e61133 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -756,7 +756,8 @@ static struct syscall_fmt {
 	.alias = "old_mmap",
 #endif
 	  .arg = { [2] = { .scnprintf = SCA_MMAP_PROT,	/* prot */ },
-		   [3] = { .scnprintf = SCA_MMAP_FLAGS,	/* flags */ }, }, },
+		   [3] = { .scnprintf = SCA_MMAP_FLAGS,	/* flags */ },
+		   [5] = { .scnprintf = SCA_HEX,	/* offset */ }, }, },
 	{ .name	    = "mount",
 	  .arg = { [0] = { .scnprintf = SCA_FILENAME, /* dev_name */ },
 		   [3] = { .scnprintf = SCA_MOUNT_FLAGS, /* flags */
-- 
2.19.2
