From: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf build: Build error in libbpf with EXTRA_CFLAGS="-Wp,-D_FORTIFY_SOURCE=2 -O2"
Date: Mon, 23 Jul 2018 15:45:01 +0200
Message-ID: <20180723134501.11180-1-tmricht@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org, wangnan0@huawei.com
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

commit a5b8bd47dcc57 ("bpf tools: Collect eBPF programs from their own sections")

cause a compiler error when building the perf tool in the linux-next tree.
I compile it using a FEDORA 28 installation, my gcc compiler version:
gcc (GCC) 8.0.1 20180324 (Red Hat 8.0.1-0.20)

Here is the error message:

[root@p23lp27] # make V=1 EXTRA_CFLAGS="-Wp,-D_FORTIFY_SOURCE=2 -O2"
[...]
make -f /home6/tmricht/linux-next/tools/build/Makefile.build
	dir=./util/scripting-engines obj=libperf
libbpf.c: In function ‘bpf_object__elf_collect’:
libbpf.c:811:15: error: ignoring return value of ‘strerror_r’,
		declared with attribute warn_unused_result [-Werror=unused-result]
     strerror_r(-err, errmsg, sizeof(errmsg));
               ^
cc1: all warnings being treated as errors
mv: cannot stat './.libbpf.o.tmp': No such file or directory
/home6/tmricht/linux-next/tools/build/Makefile.build:96: recipe for target 'libbpf.o' failed

Fix this by using strerror_r return value in pr_warning statement.
Also fixes a possible initialization issue.

Cc: Wang Nan <wangnan0@huawei.com>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/lib/bpf/libbpf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 955f8eafbf41..c70785ea903c 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -808,9 +808,9 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 			if (err) {
 				char errmsg[STRERR_BUFSIZE];
 
-				strerror_r(-err, errmsg, sizeof(errmsg));
 				pr_warning("failed to alloc program %s (%s): %s",
-					   name, obj->path, errmsg);
+					   name, obj->path,
+					   strerror_r(-err, errmsg, sizeof(errmsg)));
 			}
 		} else if (sh.sh_type == SHT_REL) {
 			void *reloc = obj->efile.reloc;
@@ -2334,7 +2334,7 @@ bpf_perf_event_read_simple(void *mem, unsigned long size,
 	__u64 data_tail = header->data_tail;
 	__u64 data_head = header->data_head;
 	void *base, *begin, *end;
-	int ret;
+	int ret = 0;
 
 	asm volatile("" ::: "memory"); /* in real code it should be smp_rmb() */
 	if (data_head == data_tail)
-- 
2.16.4
