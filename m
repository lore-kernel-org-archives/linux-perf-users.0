From: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf docu: Add description for stderr
Date: Mon, 13 May 2019 10:02:20 +0200
Message-ID: <20190513080220.91966-1-tmricht@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

Perf report displays recorded data on the screen and emits
warnings and debug messages in the status line (last one on screen).
Perf also supports the possibility to write all debug messages
to stderr (instead of writing them to the status line).
This is achieved with the following command:

 # ./perf --debug stderr=1 report -vvvvv -i ~/fast.data 2>/tmp/2
 # ll /tmp/2
 -rw-rw-r-- 1 tmricht tmricht 5420835 May  7 13:46 /tmp/2
 #

The usage of variable stderr=1 is not documented, so add it
to the perf man page.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/Documentation/perf.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/Documentation/perf.txt b/tools/perf/Documentation/perf.txt
index 864e37597252..401f0ed67439 100644
--- a/tools/perf/Documentation/perf.txt
+++ b/tools/perf/Documentation/perf.txt
@@ -22,6 +22,8 @@ OPTIONS
 	  verbose          - general debug messages
 	  ordered-events   - ordered events object debug messages
 	  data-convert     - data convert command debug messages
+	  stderr           - write debug output (option -v) to stderr
+	                     in browser mode
 
 --buildid-dir::
 	Setup buildid cache directory. It has higher priority than
-- 
2.19.1
