From: Al Grant <al.grant@foss.arm.com>
Subject: [PATCH] perf: correct SNOOPX field offset
Date: Mon, 24 Aug 2020 10:28:34 +0100
Message-ID: <9974f2d0-bf7f-518e-d9f7-4520e5ff1bb0@foss.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, ak@linux.intel.com, acme@redhat.com
List-Id: linux-perf-users.vger.kernel.org

perf_event.h has macros that define the field offsets in the
data_src bitmask in perf records. The SNOOPX and REMOTE offsets
were both 37. These are distinct fields, and the bitfield layout
in perf_mem_data_src confirms that SNOOPX should be at offset 38.

From: Al Grant <al.grant@arm.com>

  include/uapi/linux/perf_event.h       | 2 +-
  tools/include/uapi/linux/perf_event.h | 2 +-
  2 files changed, 2 insertions(+), 2 deletions(-)

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
diff --git a/tools/include/uapi/linux/perf_event.h 
b/tools/include/uapi/linux/perf_event.h
index 077e7ee69e3d..3e5dcdd48a49 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -1196,7 +1196,7 @@ union perf_mem_data_src {

  #define PERF_MEM_SNOOPX_FWD    0x01 /* forward */
  /* 1 free */
-#define PERF_MEM_SNOOPX_SHIFT  37
+#define PERF_MEM_SNOOPX_SHIFT  38

  /* locked instruction */
  #define PERF_MEM_LOCK_NA       0x01 /* not available */
