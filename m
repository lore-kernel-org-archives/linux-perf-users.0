From: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf docu: Update section on cpu description
Date: Mon, 28 May 2018 09:49:03 +0200
Message-ID: <20180528074903.21781-1-tmricht@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

Fix the section HEADER_CPUDESC so the documentation
matches code.  Swap the two members of struct nr_cpus.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/Documentation/perf.data-file-format.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index d00f0d51cab8..16e2da0b674c 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -111,8 +111,8 @@ A perf_header_string with the CPU architecture (uname -m)
 A structure defining the number of CPUs.
 
 struct nr_cpus {
-       uint32_t nr_cpus_online;
        uint32_t nr_cpus_available; /* CPUs not yet onlined */
+       uint32_t nr_cpus_online;
 };
 
 	HEADER_CPUDESC = 8,
-- 
2.14.3
