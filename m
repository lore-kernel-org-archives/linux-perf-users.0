From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/13] perf test powerpc: Fix 'Object code reading' test
Date: Mon,  4 Sep 2017 11:00:35 -0300
Message-ID: <20170904140044.22912-5-acme@kernel.org>
References: <20170904140044.22912-1-acme@kernel.org>
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20170904140044.22912-1-acme@kernel.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-kernel@vger.kernel.org, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-perf-users.vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>

'Object code reading' test always fails on powerpc guest. Two reasons
for the failure are:

1. When elf section is too big (size beyond 'unsigned int' max value).
objdump fails to disassemble from such section. This was fixed with
commit 0f6329bd7fc ("binutils/objdump: Fix disassemble for huge elf
sections") in binutils.

2. When the sample is from hypervisor. Hypervisor symbols can not be
resolved within guest and thus thread__find_addr_map() fails for such
symbols. Fix this by ignoring hypervisor symbols in the test.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/1504170896-7876-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/code-reading.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 761c5a448c56..466a462b26d1 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -237,6 +237,11 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 
 	thread__find_addr_map(thread, cpumode, MAP__FUNCTION, addr, &al);
 	if (!al.map || !al.map->dso) {
+		if (cpumode == PERF_RECORD_MISC_HYPERVISOR) {
+			pr_debug("Hypervisor address can not be resolved - skipping\n");
+			return 0;
+		}
+
 		pr_debug("thread__find_addr_map failed\n");
 		return -1;
 	}
-- 
2.13.5
