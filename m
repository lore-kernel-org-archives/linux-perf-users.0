From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/29] perf beauty mmap: PROT_WRITE should come before PROT_EXEC
Date: Thu,  3 Jan 2019 09:45:42 -0300
Message-ID: <20190103124609.29672-3-acme@kernel.org>
References: <20190103124609.29672-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190103124609.29672-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To match strace output:

  # cat mmap.c
  #include <sys/mman.h>

  int main(void)
  {
	  mmap(0, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
	  return 0;
  }
  # strace -e mmap ./mmap |& grep -v ^+++
  mmap(NULL, 103484, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7f5bae400000
  mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f5bae3fe000
  mmap(NULL, 3889792, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f5bade40000
  mmap(0x7f5bae1ec000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1ac000) = 0x7f5bae1ec000
  mmap(0x7f5bae1f2000, 14976, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7f5bae1f2000
  mmap(NULL, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f5bae419000
  # trace -e mmap ./mmap |& grep -v ^+++
  mmap(NULL, 103484, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7f6646c25000
  mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS) = 0x7f6646c23000
  mmap(NULL, 3889792, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f6646665000
  mmap(0x7f6646a11000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1ac000) = 0x7f6646a11000
  mmap(0x7f6646a17000, 14976, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS) = 0x7f6646a17000
  mmap(NULL, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANONYMOUS) = 0x7f6646c3e000
  #

Reported-by: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-nt49d6iqle80cw8f529ovaqi@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/mmap.c b/tools/perf/trace/beauty/mmap.c
index eb31089790e3..859a8a9db2c6 100644
--- a/tools/perf/trace/beauty/mmap.c
+++ b/tools/perf/trace/beauty/mmap.c
@@ -18,8 +18,8 @@ static size_t syscall_arg__scnprintf_mmap_prot(char *bf, size_t size,
 	}
 
 	P_MMAP_PROT(READ);
-	P_MMAP_PROT(EXEC);
 	P_MMAP_PROT(WRITE);
+	P_MMAP_PROT(EXEC);
 	P_MMAP_PROT(SEM);
 	P_MMAP_PROT(GROWSDOWN);
 	P_MMAP_PROT(GROWSUP);
-- 
2.19.2
