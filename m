From: Al Grant <al.grant@foss.arm.com>
Subject: [PATCH] perf: correct SNOOPX field offset
Date: Mon, 21 Sep 2020 21:46:37 +0100
Message-ID: <4ac9f5cc-4388-b34a-9999-418a4099415d@foss.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-GB
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

perf_event.h has macros that define the field offsets in the
data_src bitmask in perf records. The SNOOPX and REMOTE offsets
were both 37. These are distinct fields, and the bitfield layout
in perf_mem_data_src confirms that SNOOPX should be at offset 38.

Fixes: 52839e653b5629bd ("perf tools: Add support for printing new 
mem_info encodings")
Signed-off-by: Al Grant <al.grant@foss.arm.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
  include/uapi/linux/perf_event.h | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/perf_event.h 
b/include/uapi/linux/perf_event.h
index 077e7ee69e3d..3e5dcdd48a49 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1196,7 +1196,7 @@ union perf_mem_data_src {

  #define PERF_MEM_SNOOPX_FWD    0x01 /* forward */
  /* 1 free */
-#define PERF_MEM_SNOOPX_SHIFT  37
+#define PERF_MEM_SNOOPX_SHIFT  38

  /* locked instruction */
  #define PERF_MEM_LOCK_NA       0x01 /* not available */
