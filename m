Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9CA148858;
	Fri,  5 Jul 2024 09:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720172597; cv=none; b=AZJ+n/2mdQ8tpaJKaWJbO0RAJqxuF4VOI8HAFg+wEiGGxIEqKDjYfI+egzo3B3lyxbGvFTeonqv95ZsbUQrZu1JhmSeh5oNPLhLQLcSn/yitfpXdFM5A+8nGYUYAWE0DYSxA6d238JlYUb0jyfTqT8RqfutCb+FaT0DUJRCiefA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720172597; c=relaxed/simple;
	bh=lEdgG0ZTYJexChkBRMuE04MIvYbrZH3QypaCc3wVyQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b3ruyoROikiCQyuMOLaxolDanAXOYD6LK+aFTvmk5Km+9xLpDjyRfcy22BwSERbMsvAud1NgF943Ekt2Uvpi/kNwaMRvLNOWdd24cvwzbu3OTnO4bm1qumEal+/RT4pRGqIK5WFUO2HX4kmXOOXRd7tGMXVDHpqxFJv2h85Xs4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCtHNtK/; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCtHNtK/"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-761e0f371f5so782444a12.1;
        Fri, 05 Jul 2024 02:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720172595; x=1720777395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8OqZCgqHPZ3fH019qRYJYUerKLq5729V+3ETr9F91k=;
        b=GCtHNtK/kk0cqtQX/3oR9i1CayGjDLc7Oyz4twQbB4Rf7+WhWlw0XT+iuyEmv2fQht
         ixgAvZmSZZku3yUy78v2x01uZrzBIGEls3HbIiW/KArbtkez5C9H/UVxnT0mFEJZrVUa
         DstiAqXIToGXih8G4OjyhFbWeB6NMT00IDM19Z2Ztb9qmUI0kUExdT9VXD6z/balKWWu
         C+QekSjInUrNIKmpYNCNx8MIQeAXaCMjyyVWoYEztarO3u0lmN6Jh88jYBYaUhjDnwqz
         Q1X4mr9X5IGLWz+iMQdWmPncy908nTcXcJFHD+0Pqu4bbvpt2J35Jmg36dX16ekzLRUo
         FpQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720172595; x=1720777395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c8OqZCgqHPZ3fH019qRYJYUerKLq5729V+3ETr9F91k=;
        b=LQVdzUKtNQs+jtlURfRMlrvLz3qT2kmAZYl9EepXpooTIe0IypXypAY+e19eRhV33T
         fZt/9YZwtKwa43fABXLaeJqWJRn8UOXasAHc2AdpkMnU6ivvvDblnEV/1tEAewZ1w94x
         Mj2iNQ+QIMhVEfEIWdpBbur3inyVvFTBWC01bLily8bEvQAxjwTkA+ONXF2HgasPGpCp
         gj0qt4sAIvE//pKvL0jxD5qp5zdZRrNJV0Anf6lTi3tTmpqlSJsOrAPutBHIrMk2wp9m
         olvbHI6NVH1R2zDlnR4/BABbRe2Nym+TPFT45S2TpLvFIW3doFYawo/vBlnnGPWVFo2q
         2tMw==
X-Forwarded-Encrypted: i=1; AJvYcCXDFWbbnhHLGRp++FttoXQyRc1O8zQa87GVisSSMk24/vAQoTtiAVHe8hW66sSSPNmF70/u2LVUR8gVRRSRcvElGXJnFU8KAyPpQUEK6aBAVBgWYuoxZzqksdUQoE7FCyD62v2dt2em5W/xBM6L3A==
X-Gm-Message-State: AOJu0YxrHAuSR1VqjlFXVhxbUxBdRCH3gDk+sVL5RbdzrTjsbMHB3GG2
	qSeEa1psMmgXaNcZx5h0tTqZMfG54vxtLL2+EXisahQpdRLL3zJN
X-Google-Smtp-Source: AGHT+IFN6hxQR4EGBW2FAHG5WSp9JhH/71knYV6MuFQG8TmxJpzZ8yEA/L9xMYiubVP5DcAjV0HOxA==
X-Received: by 2002:a17:90b:90f:b0:2c3:34f4:5154 with SMTP id 98e67ed59e1d1-2c99f2f43b1mr5646660a91.1.1720172594483;
        Fri, 05 Jul 2024 02:43:14 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a9cd133sm2958138a91.38.2024.07.05.02.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 02:43:14 -0700 (PDT)
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
Date: Fri,  5 Jul 2024 17:42:57 +0800
Message-ID: <20240705094300.585156-6-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240705094300.585156-1-howardchu95@gmail.com>
References: <20240705094300.585156-1-howardchu95@gmail.com>
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

