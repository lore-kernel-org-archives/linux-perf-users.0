From: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 3/3] perf/java: Add detection of java-11-openjdk-devel package
Date: Mon,  9 Sep 2019 13:41:16 +0200
Message-ID: <20190909114116.50469-4-tmricht@linux.ibm.com>
References: <20190909114116.50469-1-tmricht@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190909114116.50469-1-tmricht@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: brueckner@linux.ibm.com, gor@linux.ibm.com, heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

With Java 11 there is no seperate JRE anymore.
Details: https://coderanch.com/t/701603/java/JRE-JDK
Therefore the detection of the JRE needs to be adapted.

This change works for s390 and x86.
I have not tested other platforms.

Suggested-by: Andreas Krebbel <krebbel@linux.ibm.com>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/Makefile.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 89ac5a1f1550..3da374911852 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -908,7 +908,7 @@ ifndef NO_JVMTI
     JDIR=$(shell /usr/sbin/update-java-alternatives -l | head -1 | awk '{print $$3}')
   else
     ifneq (,$(wildcard /usr/sbin/alternatives))
-      JDIR=$(shell /usr/sbin/alternatives --display java | tail -1 | cut -d' ' -f 5 | sed 's%/jre/bin/java.%%g')
+      JDIR=$(shell /usr/sbin/alternatives --display java | tail -1 | cut -d' ' -f 5 | sed -e 's%/jre/bin/java.%%g' -e 's%/bin/java.%%g')
     endif
   endif
   ifndef JDIR
-- 
2.21.0
