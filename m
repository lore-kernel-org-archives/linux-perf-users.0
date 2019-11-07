From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/63] perf llvm: Make .o saving a debug message, not an info one
Date: Thu,  7 Nov 2019 15:59:15 -0300
Message-ID: <20191107190011.23924-8-acme@kernel.org>
References: <20191107190011.23924-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191107190011.23924-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Daniel Bristot de Oliveira <bristot@redhat.com>, David Ahern <dsahern@gmail.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Its a bit annoying to have that message, better make it a debug one.

I.e. now this message will only appear when using '-v':

  [root@quaco tracebuffer]# trace -e bristot.c
  LLVM: dumping bristot.o
  ^C[root@quaco tracebuffer]#

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-o7jd4i7s66kosec5torubqps@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/llvm-utils.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
index 8b14e4a7f1dc..eae47c2509eb 100644
--- a/tools/perf/util/llvm-utils.c
+++ b/tools/perf/util/llvm-utils.c
@@ -418,10 +418,9 @@ void llvm__dump_obj(const char *path, void *obj_buf, size_t size)
 		goto out;
 	}
 
-	pr_info("LLVM: dumping %s\n", obj_path);
+	pr_debug("LLVM: dumping %s\n", obj_path);
 	if (fwrite(obj_buf, size, 1, fp) != 1)
-		pr_warning("WARNING: failed to write to file '%s': %s, skip object dumping\n",
-			   obj_path, strerror(errno));
+		pr_debug("WARNING: failed to write to file '%s': %s, skip object dumping\n", obj_path, strerror(errno));
 	fclose(fp);
 out:
 	free(obj_path);
-- 
2.21.0
