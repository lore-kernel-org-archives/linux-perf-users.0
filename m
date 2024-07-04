Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D8D1AED57;
	Thu,  4 Jul 2024 12:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720097058; cv=none; b=BpocZ7BQYmEkXtDvHos2cwVGyFqwGPWING8C3khXcKDMozoqXUV+IElokjO8ixYHd/PCLqMkgrnJOHU41gP/wab48BxyS+h9X1NRTqKH5bWjr9bJWCrAdoJiCyl8HXvM9fgpJysRp9vc4A5XEhte1PNkVXsUicn3b9iiDtL894g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720097058; c=relaxed/simple;
	bh=GYaWPgJnVdGEdrYxINBzc2b+yUlQf/YFbIz/YORO0bI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ret6jGdwjzmiylzzL2KTzNHvdgl6ZRIOsMIGZaCbgceZwbwuiWTOIDgiILWYSRFgBLn2GLqI1931emNJ/C+9YAnWT1dXJuhXTeZlqk+U+LAO2FLzaNiJ0ZVP1arZautr64a9fTQOvP46qQqWT/GqZ2fF15Nv5d1xY/1vvzEd3Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d122Y4kg; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d122Y4kg"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-706627ff48dso397051b3a.1;
        Thu, 04 Jul 2024 05:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720097056; x=1720701856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COoMomlM0SOTNQJK5GTR3BCGqXeYbavr39Ox6xrITDg=;
        b=d122Y4kg8gGyr2GmRYO25sS714brc202+IdD6ZdgDAGgfHdc4BASo0jdfTB4rCOSJt
         sASBiJvAbaVGeEOamH+EFi/yaJmxLKlX4BOf+w+hR4NTJljzRKmKXl2MLdUMqgvYQGJw
         aohkUi48cRbo+gagbhlfXeyPuXe0YhPu4bxzR4/PYKkgoi2aT3lOKU1hnMf2Iz25laZI
         ReHFRvqPhKS91kV4vIUOEiX2r/E5S0M5AP556hOKf2S9iL1bzq4S0Xvt2jYzXLuAh5Ac
         w4G1RJEpxsR2HIIUx61Bu6XRwztSAtLqy3jGFqg6KAKuGFeto52O35FbuS5642pUYrjP
         Q0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720097056; x=1720701856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=COoMomlM0SOTNQJK5GTR3BCGqXeYbavr39Ox6xrITDg=;
        b=mmaxJbtZmgbg627kzatfmVfE2pPv+hxmhIvA51Uu5XBBMAmFNC176yALa7m8FiW0k1
         g7RdLdfirvx8U8yYXAFO29OI1n1RkMIpwZbUCjxjJqI+RCDn3frlDNXGGp2AqWRDh4gN
         EE+w7voT+PqsRsVe7npWkoKnMyf+7bA90NO6BmueVamRGLC9gSR9wCqRMjfx/aM2fmnd
         SmzNlIRvBsCLZGR4i+755Kt0rTagwpTzpfz61DFZnuRcwVaIOMxwjE8FiTRDRlP4Gvr4
         3yGD3cVteXnStMhGiryf45i/ss8IxdixOnh/kfNeNZCoDyKMVGnY8/+jCkaOcQVLdSbT
         0pkg==
X-Forwarded-Encrypted: i=1; AJvYcCWlnb6XxgNcESpo7grm1bBMULeDL/uGDGrFtf1tGmDLOszyF1YrRUvoracccjQSUrzoASOlXtN0waeVCHOhuZrJ+2PJUS40pGOpEvlXwqUf95kE8it/VsRCDX/6CgXWlybbXCjwG1YmRILYMntfOA==
X-Gm-Message-State: AOJu0YyrfsruQ6MzoiSftYts4wVPdlemtcYq0HSHLSu+NNBUvHg9xNgs
	HrkNCoyp7FWRTiX+RahA3yACbzCFt+wJsYUkBbl47n6l8GsJ6RMfPGEATF7BP+Q=
X-Google-Smtp-Source: AGHT+IFQKgu+wE8acHvTPhfDz1Xb562Yu0edit1U29RFHANHUK9OrNBXiWreTsVbs9cHTDSLSZW3UQ==
X-Received: by 2002:a05:6a20:6a0d:b0:1bd:2215:923e with SMTP id adf61e73a8af0-1c0cc758353mr1673327637.4.1720097056057;
        Thu, 04 Jul 2024 05:44:16 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1598d35sm121578245ad.285.2024.07.04.05.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 05:44:15 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: adrian.hunter@intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	namhyung@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v4 5/8] perf test: Add landlock workload
Date: Thu,  4 Jul 2024 20:43:51 +0800
Message-ID: <20240704124354.904540-6-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704124354.904540-1-howardchu95@gmail.com>
References: <20240704124354.904540-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We'll use it to add a regression test for the BTF augmentation of enum
arguments for tracepoints in 'perf trace':

  root@x1:~# perf trace -e landlock_add_rule perf test -w landlock
       0.000 ( 0.009 ms): perf/747160 landlock_add_rule(ruleset_fd: 11, rule_type: LANDLOCK_RULE_PATH_BENEATH, rule_attr: 0x7ffd8e258594, flags: 45) = -1 EINVAL (Invalid argument)
       0.011 ( 0.002 ms): perf/747160 landlock_add_rule(ruleset_fd: 11, rule_type: LANDLOCK_RULE_NET_PORT, rule_attr: 0x7ffd8e2585a0, flags: 45) = -1 EINVAL (Invalid argument)
  root@x1:~#

Committer notes:

It was agreed on the discussion (see Link1 below) to shorten then name of
the workload from 'landlock_add_rule' to 'landlock', and I moved it to a
separate patch.

Howard fixed the build error found by Namhyung (see Link2 below),
changing the landlock.h header to the one in source tree, and including
syscall.h for the '__NR_landlock_add_rule' syscall number.

However, there is another problem. Because of this line in Makefile.config:
INC_FLAGS += -I$(srctree)/tools/arch/$(SRCARCH)/include/uapi ,
we'll include 'tools/arch/x86/include/uapi/asm/unistd_64.h' in the source
tree. But what we want is '/usr/include/asm/unistd_64.h'.
This hardcoded unistd_64.h in the source tree is not cool for the landlock
workload because it is a simplified list of syscall numbers for particular
use cases, we need to discard this search path if we want the
__NR_landlock_add_rule macro. To solve this problem, Howard added a
CFLAGS_REMOVE_landlock.o to remove the flag of
-I$(srctree)/tools/arch/$(SRCARCH)/include/uapi.

The problem above will not occur in some arch, say arm64
and riscv because they include asm-generic/unistd.h instead. The arch
that it really affects is the ones that include asm/unistd_32.h and
asm/unistd_64.h.

linux $ find . -regex './arch/.*/include/uapi/asm/unistd.h' | xargs grep -H --color=auto 'include <asm'
./arch/x86/include/uapi/asm/unistd.h:#  include <asm/unistd_32.h>
./arch/x86/include/uapi/asm/unistd.h:#  include <asm/unistd_x32.h>
./arch/x86/include/uapi/asm/unistd.h:#  include <asm/unistd_64.h>
./arch/parisc/include/uapi/asm/unistd.h:#include <asm/unistd_64.h>
./arch/parisc/include/uapi/asm/unistd.h:#include <asm/unistd_32.h>
./arch/nios2/include/uapi/asm/unistd.h:#include <asm-generic/unistd.h>
./arch/mips/include/uapi/asm/unistd.h:#include <asm/sgidefs.h>
./arch/mips/include/uapi/asm/unistd.h:#include <asm/unistd_o32.h>
./arch/mips/include/uapi/asm/unistd.h:#include <asm/unistd_n64.h>
./arch/mips/include/uapi/asm/unistd.h:#include <asm/unistd_n32.h>
./arch/s390/include/uapi/asm/unistd.h:#include <asm/unistd_64.h>
./arch/s390/include/uapi/asm/unistd.h:#include <asm/unistd_32.h>
./arch/arm64/include/uapi/asm/unistd.h:#include <asm-generic/unistd.h>
./arch/riscv/include/uapi/asm/unistd.h:#include <asm-generic/unistd.h>
./arch/sparc/include/uapi/asm/unistd.h:#include <asm/unistd_64.h>
./arch/sparc/include/uapi/asm/unistd.h:#include <asm/unistd_32.h>
./arch/xtensa/include/uapi/asm/unistd.h:#include <asm/unistd_32.h>
./arch/hexagon/include/uapi/asm/unistd.h:#include <asm-generic/unistd.h>
./arch/openrisc/include/uapi/asm/unistd.h:#include <asm-generic/unistd.h>
./arch/arm/include/uapi/asm/unistd.h:#include <asm/unistd-eabi.h>
./arch/arm/include/uapi/asm/unistd.h:#include <asm/unistd-oabi.h>
./arch/alpha/include/uapi/asm/unistd.h:#include <asm/unistd_32.h>
./arch/sh/include/uapi/asm/unistd.h:#include <asm/unistd_32.h>
./arch/m68k/include/uapi/asm/unistd.h:#include <asm/unistd_32.h>
./arch/microblaze/include/uapi/asm/unistd.h:#include <asm/unistd_32.h>
./arch/arc/include/uapi/asm/unistd.h:#include <asm-generic/unistd.h>
./arch/powerpc/include/uapi/asm/unistd.h:#include <asm/unistd_32.h>
./arch/powerpc/include/uapi/asm/unistd.h:#include <asm/unistd_64.h>
./arch/csky/include/uapi/asm/unistd.h:#include <asm-generic/unistd.h>
./arch/loongarch/include/uapi/asm/unistd.h:#include <asm-generic/unistd.h>

Reported-by: Namhyung Kim <namhyung@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202406250302.E4WaX9Ud-lkp@intel.com/
Closes: https://lore.kernel.org/linux-perf-users/Zn8TfuQi0iq7bMVD@google.com/
Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
Tested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link1: https://lore.kernel.org/lkml/CAH0uvohaypdTV6Z7O5QSK+va_qnhZ6BP6oSJ89s1c1E0CjgxDA@mail.gmail.com
Link2: https://lore.kernel.org/linux-perf-users/Zn8TfuQi0iq7bMVD@google.com/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/builtin-test.c       |  1 +
 tools/perf/tests/tests.h              |  1 +
 tools/perf/tests/workloads/Build      |  2 ++
 tools/perf/tests/workloads/landlock.c | 38 +++++++++++++++++++++++++++
 4 files changed, 42 insertions(+)
 create mode 100644 tools/perf/tests/workloads/landlock.c

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index c3d84b67ca8e..470a9709427d 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -152,6 +152,7 @@ static struct test_workload *workloads[] = {
 	&workload__sqrtloop,
 	&workload__brstack,
 	&workload__datasym,
+	&workload__landlock,
 };
 
 static int num_subtests(const struct test_suite *t)
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 3aa7701ee0e9..6ea2be86b7bf 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -205,6 +205,7 @@ DECLARE_WORKLOAD(leafloop);
 DECLARE_WORKLOAD(sqrtloop);
 DECLARE_WORKLOAD(brstack);
 DECLARE_WORKLOAD(datasym);
+DECLARE_WORKLOAD(landlock);
 
 extern const char *dso_to_test;
 extern const char *test_objdump_path;
diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
index 48bf0d3b0f3d..e132d5d95983 100644
--- a/tools/perf/tests/workloads/Build
+++ b/tools/perf/tests/workloads/Build
@@ -6,8 +6,10 @@ perf-test-y += leafloop.o
 perf-test-y += sqrtloop.o
 perf-test-y += brstack.o
 perf-test-y += datasym.o
+perf-test-y += landlock.o
 
 CFLAGS_sqrtloop.o         = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_leafloop.o         = -g -O0 -fno-inline -fno-omit-frame-pointer -U_FORTIFY_SOURCE
 CFLAGS_brstack.o          = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_datasym.o          = -g -O0 -fno-inline -U_FORTIFY_SOURCE
+CFLAGS_REMOVE_landlock.o  = -I$(srctree)/tools/arch/$(SRCARCH)/include/uapi
diff --git a/tools/perf/tests/workloads/landlock.c b/tools/perf/tests/workloads/landlock.c
new file mode 100644
index 000000000000..c4f29b17f2a7
--- /dev/null
+++ b/tools/perf/tests/workloads/landlock.c
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <sys/syscall.h> // for __NR_landlock_add_rule
+#include <linux/compiler.h>
+#include <unistd.h>
+#include "../tests.h"
+#ifdef __NR_landlock_add_rule
+#include "../../../../include/uapi/linux/landlock.h"
+#endif
+
+/* This workload is used only to test enum augmentation with BTF in perf trace */
+static int landlock(int argc __maybe_unused, const char **argv __maybe_unused)
+{
+#if defined(__NR_landlock_add_rule) && defined(HAVE_LIBBPF_SUPPORT)
+	int fd = 11, flags = 45;
+
+	struct landlock_path_beneath_attr path_beneath_attr = {
+		.allowed_access = LANDLOCK_ACCESS_FS_READ_FILE,
+		.parent_fd = 14,
+	};
+
+	struct landlock_net_port_attr net_port_attr = {
+		.port = 19,
+		.allowed_access = LANDLOCK_ACCESS_NET_CONNECT_TCP,
+	};
+
+	syscall(__NR_landlock_add_rule, fd, LANDLOCK_RULE_PATH_BENEATH,
+		&path_beneath_attr, flags);
+
+	syscall(__NR_landlock_add_rule, fd, LANDLOCK_RULE_NET_PORT,
+		&net_port_attr, flags);
+
+	return 0;
+#else
+	return 2;
+#endif
+}
+
+DEFINE_WORKLOAD(landlock);
-- 
2.45.2

