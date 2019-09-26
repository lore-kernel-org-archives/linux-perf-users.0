From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 65/66] perf build: Add detection of java-11-openjdk-devel package
Date: Wed, 25 Sep 2019 21:32:43 -0300
Message-ID: <20190926003244.13962-66-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Thomas Richter <tmricht@linux.ibm.com>, Andreas Krebbel <krebbel@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Hendrik Brueckner <brueckner@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

With Java 11 there is no seperate JRE anymore.

Details:

  https://coderanch.com/t/701603/java/JRE-JDK

Therefore the detection of the JRE needs to be adapted.

This change works for s390 and x86.  I have not tested other platforms.

Committer testing:

Continues to work with the OpenJDK 8:

  $ rm -f ~acme/lib64/libperf-jvmti.so
  $ rpm -qa | grep jdk-devel
  java-1.8.0-openjdk-devel-1.8.0.222.b10-0.fc30.x86_64
  $ git log --oneline -1
  a51937170f33 (HEAD -> perf/core) perf build: Add detection of java-11-openjdk-devel package
  $ rm -rf /tmp/build/perf ; mkdir -p /tmp/build/perf ; make -C tools/perf O=/tmp/build/perf install > /dev/null 2>1
  $ ls -la ~acme/lib64/libperf-jvmti.so
  -rwxr-xr-x. 1 acme acme 230744 Sep 24 16:46 /home/acme/lib64/libperf-jvmti.so
  $

Suggested-by: Andreas Krebbel <krebbel@linux.ibm.com>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Link: http://lore.kernel.org/lkml/20190909114116.50469-4-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index a269d78456b6..46f7fba2306c 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -924,7 +924,7 @@ ifndef NO_JVMTI
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
