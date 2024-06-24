Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9021A08A8;
	Mon, 24 Jun 2024 18:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719252745; cv=none; b=cpfYUnwh7jUmAia6FqhnM/2xOEhzZGfpZ8sqs9DSE/ZD2UjSg2HeAHKNq/t5stVU+Zkz6WPLuEgnvOpGU7kE57tFVu3fhhTS5KkH+j5ov6K598QOlPDnRWYd6frgintVfQnyIggUA0Jwp4VKHQYb6e7Kf5DRCslffSdUXIBuHCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719252745; c=relaxed/simple;
	bh=Xxu2cF1DYbOothRmHz4eQa19j0TXjNAHN20rKPtH7v8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UKLFtxMevrgdK9ZqhXBmjky+5RfhnPuBpMp0a/GlfbQWg0qzGxWs5tTE1ORQmCtIFWJ/hdd0FzqBNqN+IZfbDaG3pdFRlnLMgS8M0h5zU8XaNC6CL2mYTHrYT3wo54mtqHNe3cVDgYbiaut4AdjhPOyYE7hJMbgbpI6vv+t+YsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NoiSsye2; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NoiSsye2"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-706738c209bso1147400b3a.3;
        Mon, 24 Jun 2024 11:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719252743; x=1719857543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3AUz69t4q5Dyd9Jj2leluDE0X4TKCDyQHDmDKxMG9Q=;
        b=NoiSsye2krW5ASIkskHhhtAW8F71DReQOs+pdxFcyKQxblNITdp5VgQ0k6n6Lbs7OX
         oTF+FEUWqsRI5cHiwnzQzdSUbp4R+M5D/2eoZKAvyV+s2M9fuvt1QIhAhPrIcSW6cVzz
         yNbYEBQe67XMZJKtsgYJGjSMyM7lGUgZCyN/JIdjm0wBJUQO9XvzE9lLkR6UJ0o2g3Ln
         rozVd+3pX+QmJqipYvi0wRAqHX8+K9JqIl24bMxd0ylY4utxu6C/VBaaNYHB2/9es7J4
         OyTimegU3hy43ClhyRBBSsv+j+RegaE0rF8ljojBBcOWSXnRK6VlQQA7W59ABO8KFZu5
         IG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719252743; x=1719857543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y3AUz69t4q5Dyd9Jj2leluDE0X4TKCDyQHDmDKxMG9Q=;
        b=XxmjSmXdOVWpDwlw4iXhX5+WsFGkJoL1KA/SOIljMQYiwuwCzki1UHIBf0GVK3wLbF
         stkGn9Hf2v1uxYwaf3dmc1MH16vvV02rmSdgXIjZfQS4JoFcYv9t9HurQUdKtWT6kR5m
         Eilq3fdFbuwwLgMhJw2KX3vyaKm0KMnOKt8ciKPqQFfXJ7iqkcaNxyliWxj1F+AWDKg9
         F8esnGp7U3yf/b/F2KVVtAz56q8e0J8Yo7UoZGUlSSzomV7nBAnBVouondUV8g4zdVi7
         5vq2gccYQe9E82LQ0EmvTZw87JnEam4l8tbu3DOLGL/x5LCzyFUcwS4dTh/AQEHEvuTS
         D/kQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4j0t6K3ZTZVsxwqgsVvjoVcO+OO6ZgrLCVNRGYzsLcH3QkrZJ0XN65aQViSIJxguYNDZnyk33/SVbkLdSq4kLTpEMCV8k0gsQcaX3pdg8bsAzCVWi8PCNiScYwwoHrubGIKGb/x3hyXWuwUoajg==
X-Gm-Message-State: AOJu0YxK4slTfL5tvN4w9ovCoxMJqfbTo9zOJCr8/YdYHUtSK9y/fw+q
	wR4DdFOx/8TiSRnoLSLFjNwtcwVmDPFjSs5sp66lVvelPKXjB+ZQ
X-Google-Smtp-Source: AGHT+IFK4472nMsShIiuGhiBpceHsqJysW4TWrwb21FB1ql+3SBsjlvv+8J8BparUTpRQ/sCUy94MQ==
X-Received: by 2002:a05:6a00:c8e:b0:704:2811:62 with SMTP id d2e1a72fcca58-706745be4c5mr6286194b3a.13.1719252743330;
        Mon, 24 Jun 2024 11:12:23 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.45])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70651290157sm6525157b3a.150.2024.06.24.11.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 11:12:23 -0700 (PDT)
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
Subject: [PATCH v3 5/8] perf test: Add landlock workload
Date: Tue, 25 Jun 2024 02:13:42 +0800
Message-ID: <20240624181345.124764-6-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240624181345.124764-1-howardchu95@gmail.com>
References: <20240624181345.124764-1-howardchu95@gmail.com>
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

Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
Tested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/CAH0uvohaypdTV6Z7O5QSK+va_qnhZ6BP6oSJ89s1c1E0CjgxDA@mail.gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/builtin-test.c       |  1 +
 tools/perf/tests/tests.h              |  1 +
 tools/perf/tests/workloads/Build      |  1 +
 tools/perf/tests/workloads/landlock.c | 39 +++++++++++++++++++++++++++
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
index a1f34d5861e3..cc5cbf5909ea 100644
--- a/tools/perf/tests/workloads/Build
+++ b/tools/perf/tests/workloads/Build
@@ -6,6 +6,7 @@ perf-y += leafloop.o
 perf-y += sqrtloop.o
 perf-y += brstack.o
 perf-y += datasym.o
+perf-y += landlock.o
 
 CFLAGS_sqrtloop.o         = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_leafloop.o         = -g -O0 -fno-inline -fno-omit-frame-pointer -U_FORTIFY_SOURCE
diff --git a/tools/perf/tests/workloads/landlock.c b/tools/perf/tests/workloads/landlock.c
new file mode 100644
index 000000000000..35df2389155a
--- /dev/null
+++ b/tools/perf/tests/workloads/landlock.c
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/compiler.h>
+#include <uapi/asm-generic/unistd.h> // for __NR_landlock_add_rule
+#include <unistd.h>
+#include "../tests.h"
+#include <stdlib.h>
+#ifdef __NR_landlock_add_rule
+#include <linux/landlock.h>
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

