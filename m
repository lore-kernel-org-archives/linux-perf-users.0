Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA465154456;
	Fri,  5 Jul 2024 13:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720185664; cv=none; b=e226vEivsB1auaa+k0gtAi/gCLLCP3TidDxHceqgnAgSA+PQcai03L/TPPkzNeOMQcQDcrZIN/2Pi2h2j8joCjbn/CafNQ9FvpsbJ3Nw+yL5PoCN9OQNDy73dvtVP/s3HWuSlV75ke5ujhb8jbVIPqqt3GNscr/9N3juQAyWx9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720185664; c=relaxed/simple;
	bh=lEdgG0ZTYJexChkBRMuE04MIvYbrZH3QypaCc3wVyQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AcjLAaqeYHUGl5SjZcf5cqyxtRASYM3XwzH6qSrKYZCCrbmNVOzix1XB8qAT+gzq1OIKRLiT/XiKkbMLiU+9s2nhtugHFlK3LS016XlCAPIg1F+AlwgHqwT9RAxyfX+RcO/cSrIMDfsAQXiTUw2SpwyjaX3sxKX3I4qVTjLV1mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVTxqZS/; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVTxqZS/"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2c983d8bdc7so1214161a91.0;
        Fri, 05 Jul 2024 06:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720185662; x=1720790462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8OqZCgqHPZ3fH019qRYJYUerKLq5729V+3ETr9F91k=;
        b=XVTxqZS/C7BZtWgbOuro7Klf8bKr+vU73oOJxfXTQf1GrBCvHsTUdRxfAyMCHSfroz
         zMqG4YmrJmOqM3UB+3rtt4mvHx9yrI4Gq4qOOiEEYj2l/yd5a8eorOUohSBgW3o9jm0Z
         gXqv5NXtvENSD3tKSAUdlPCWPo7DfOd+2YnZT5y+dZhsCI4smI4CFn3lXuyN87oDY2Ts
         RdSGSitTOUidv6fIpbAvKybhydIN5CccPVEj73hHPen9cT+SAjvmYCnekBUSNsRHRqAO
         unLRlH9uwS5ppxv3wTxwXWxGRj203X7KDrfUSt3RmJzM5yiavFYK2X9Z2+caO/6v7NlY
         ngNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720185662; x=1720790462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c8OqZCgqHPZ3fH019qRYJYUerKLq5729V+3ETr9F91k=;
        b=UE9RFABeNj5LcgTVJn0aaneRx4xewL+pVcbgB9yIzO3pUIL7PcYxLU8ppQX7eaXaDO
         LuVeFKYqrgoFQNKsw4TDX7WF09VmuIgPFtVDsljrugCaHrDoJJ/hpzzNly9nDthymKK7
         0dMidfjHqF39BHi0zB3S1kMwOyQ6rjat7fMo2395mBm6VkR6bDqYX/4M47Q3c46PiuvJ
         ZxeRu9Jz6/NbZx56kjzSnA4zHhuYcr/fy6SJx92YhSH85JCrbXSmxIVshN+e6HHEPQDL
         YfQuPEbb3bhSSGOL3xuDaxIIt1gIYczw15sQU8AKeeOgkLF6wVqPRlAhQ5diI8DCohRX
         0THg==
X-Forwarded-Encrypted: i=1; AJvYcCUhjF75J9yBl3p67IAkj61PtVyXv/YwmrgZ1mJK0zD4k+IAfBhwK4KM4ygjljnNslFvytF+mtfPWE4iZGYEJP5BoVTMLsOUjX6aDXhbuATyZrlLIYFfVlkbJtrMJPKcIAEFsWTOceQKlLjTefYg+Q==
X-Gm-Message-State: AOJu0Yw4J2UBWSaGNLe1J6ZAb4a7M3Hw/q8Zg4ATOUg1N/tZ8tTHjY6B
	kE4bwPSF8aj/Q1eoR/Ysab9yd82TSfchlQETEvLId/5qD65djUqcPheKVzWX
X-Google-Smtp-Source: AGHT+IEQUkwiQuH7QJvMroMjpFR26sJW0bDHyitpkMpJFH0EGn+AI9nZfdyPVs64YRchH2tuAUhRgA==
X-Received: by 2002:a17:90a:eac4:b0:2c8:e43b:4015 with SMTP id 98e67ed59e1d1-2c99c506536mr3651533a91.6.1720185662155;
        Fri, 05 Jul 2024 06:21:02 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a956260sm3328974a91.19.2024.07.05.06.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 06:21:01 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: adrian.hunter@intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	namhyung@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v5 5/8] perf test: Add landlock workload
Date: Fri,  5 Jul 2024 21:20:55 +0800
Message-ID: <20240705132059.853205-6-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240705132059.853205-1-howardchu95@gmail.com>
References: <20240705132059.853205-1-howardchu95@gmail.com>
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

It was agreed on the discussion (see Link below) to shorten then name of
the workload from 'landlock_add_rule' to 'landlock', and I moved it to a
separate patch.

Also, to address a build failure from Namhyung, I stopped loading
linux/landlock.h and instead added the used defines, enums and types to
make this build in older systems. All we want is to emit the syscall and
intercept it.

We also need to add a "CFLAGS_landlock.o         = -Wno-attributes" line
to cope with those landlock struct packed structs when building on
32-bit architectures.

Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
Tested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/CAH0uvohaypdTV6Z7O5QSK+va_qnhZ6BP6oSJ89s1c1E0CjgxDA@mail.gmail.com
Link: https://lore.kernel.org/r/20240624181345.124764-1-howardchu95@gmail.com
Link: https://lore.kernel.org/r/20240624181345.124764-6-howardchu95@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/builtin-test.c       |  1 +
 tools/perf/tests/tests.h              |  1 +
 tools/perf/tests/workloads/Build      |  2 +
 tools/perf/tests/workloads/landlock.c | 66 +++++++++++++++++++++++++++
 4 files changed, 70 insertions(+)
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
index 48bf0d3b0f3d..3fe97e68d105 100644
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
+CFLAGS_landlock.o         = -Wno-attributes
diff --git a/tools/perf/tests/workloads/landlock.c b/tools/perf/tests/workloads/landlock.c
new file mode 100644
index 000000000000..0c2bcdaf2263
--- /dev/null
+++ b/tools/perf/tests/workloads/landlock.c
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/compiler.h>
+#include <linux/types.h>
+#include <unistd.h>
+#include "../tests.h"
+
+/* This workload was initially added to test enum augmentation with BTF in perf
+ * trace because its the only syscall that has an enum argument. Since it is
+ * a recent addition to the Linux kernel (at the time of the introduction of this
+ * 'perf test' workload) we just add the required types and defines here instead
+ * of including linux/landlock, that isn't available in older systems.
+ *
+ * We are not interested in the the result of the syscall, just in intercepting
+ * its arguments.
+ */
+
+#ifndef __NR_landlock_add_rule
+#define __NR_landlock_add_rule 445
+#endif
+
+#ifndef LANDLOCK_ACCESS_FS_READ_FILE
+#define LANDLOCK_ACCESS_FS_READ_FILE	(1ULL << 2)
+
+#define LANDLOCK_RULE_PATH_BENEATH	1
+
+struct landlock_path_beneath_attr {
+        __u64 allowed_access;
+        __s32 parent_fd;
+} __attribute__((packed));
+#endif
+
+#ifndef LANDLOCK_ACCESS_NET_CONNECT_TCP
+#define LANDLOCK_ACCESS_NET_CONNECT_TCP	(1ULL << 1)
+
+#define LANDLOCK_RULE_NET_PORT		2
+
+struct landlock_net_port_attr {
+	__u64 allowed_access;
+	__u64 port;
+};
+#endif
+
+static int landlock(int argc __maybe_unused, const char **argv __maybe_unused)
+{
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
+}
+
+DEFINE_WORKLOAD(landlock);
-- 
2.45.2

