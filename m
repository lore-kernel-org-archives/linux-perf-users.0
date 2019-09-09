From: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 0/3] perf/java: Add s390 support for jitted JAVA
Date: Mon,  9 Sep 2019 13:41:13 +0200
Message-ID: <20190909114116.50469-1-tmricht@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: brueckner@linux.ibm.com, gor@linux.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

This patch set adds support for jitted JAVA and requires the following
packages (The java-8 version is not sufficient for s390):

- java-11-openjdk-11.0.2.7-7.fc30.s390x
- java-11-openjdk-headless-11.0.2.7-7.fc30.s390x
- java-11-openjdk-devel-11.0.2.7-7.fc30.s390x

and this patch series:
Patch 1 (perf jvmti): Compile jvmti/* and generate a loadable
   libperf-jvmti.so
Patch 2 (perf): Include JVMTI into the s390 build
Patch 3 (perf/java): Add detection of java-11-openjdk-devel package

Thomas Richter (3):
  perf jvmti: Link against tools/lib/string.h to have weak strlcpy()
  perf: Include JVMTI support for s390
  perf/java: Add detection of java-11-openjdk-devel package

 tools/perf/Makefile.config    |  2 +-
 tools/perf/arch/s390/Makefile |  1 +
 tools/perf/jvmti/Build        | 13 +++++++++++++
 tools/perf/util/genelf.h      |  3 +++
 4 files changed, 18 insertions(+), 1 deletion(-)

-- 
2.21.0
