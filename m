Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ljFipjXP"
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C70D51
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Dec 2023 21:04:48 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db9612b8997so724957276.2
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Dec 2023 21:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701925487; x=1702530287; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gJ09ILS0FKw69nllEGHZTddJyQyifMD6obVQZgpi4Qw=;
        b=ljFipjXPu2ocEJjGS5+bo4ZvUR5mU9WkFW6EY0cXddnbdqCN7uxP4VpZYVQaSh+bN2
         CZUTGz6UU5H0lp1cXq91jVlmEXpsne41KYWUCiZDhNp2Mr8XyAxdrUqY8R1lMeOAe6ae
         O+XT+QLgm5NShAQcqAdRq8fhTOrhiDufhvsM7lIfHKdZQ09xG6APHhuyotWzh2SkGZDs
         tonIxluC68vbr8xowwfdA3vDmRmPp9/K/ZOZcFGI6QZnFoqirJdEQQYHb7HEZZxvnT5w
         GIP2XIRqHKCSLDzZDX/8XYAt9pIF+8bLljLI/UmMB0YDm0NZaBbB2tWrtLXzQH9+G475
         vhEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701925487; x=1702530287;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gJ09ILS0FKw69nllEGHZTddJyQyifMD6obVQZgpi4Qw=;
        b=NCKIq99nv2aPsR+2GpWC0C+Fj28hWxKTePfYUi6zXTN0zRMGOJM/aTYgApsCmBY68Z
         E6jMgrpV3koam1uUoF5YM+GqZUXodYkBaIV2fmfk2xTpqMmGzMQ0avX9lzwObfz2nO78
         GQBVEK9TZH+85rZgdGLmtNUYMjOANlOf8uM9I84FOATzNffMJ7hhyKDBxn8k8uWRe3mK
         VjDrlBKHt84akiGj8YqZItsuEky9JqCJZ9+YlFFq4MbYXy+E28kAolOr94Oad6VIUQl4
         FAe94vmxvWKxvx8VC/QuGcxQAoPJE6w5WYJqlCCyNLIZGq4xCGlh14eM2uRMgcB3HcKz
         /HSg==
X-Gm-Message-State: AOJu0Ywoo4OC4AqWLUlnbBUp+81ZEJ1bcVuZInn3o4pRVzzN1bFoKL7I
	uuobKaad7E7jx9yuC3N4ZSmHoClo2LEI
X-Google-Smtp-Source: AGHT+IE25ICHr+L0rrthsfiMJT9vor7826Id8YRj/BihCnqEuwJ+wuOTJjyX1ATd/qisp8dd7xqJkTPlrH7E
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a25:d144:0:b0:db7:dce9:76cd with SMTP id
 i65-20020a25d144000000b00db7dce976cdmr24086ybg.9.1701925487528; Wed, 06 Dec
 2023 21:04:47 -0800 (PST)
Date: Wed,  6 Dec 2023 21:04:28 -0800
In-Reply-To: <20231207050433.1426834-1-irogers@google.com>
Message-Id: <20231207050433.1426834-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231207050433.1426834-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v1 1/6] tools build: Add a feature test for getdents64
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Thomas Richter <tmricht@linux.ibm.com>, Quentin Monnet <quentin@isovalent.com>, 
	Fangrui Song <maskray@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yanteng Si <siyanteng@loongson.cn>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Artem Savkov <asavkov@redhat.com>, James Clark <james.clark@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

getdents64 may be missing from certain libcs, add a feature test to
determine when such a libc is being used.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/Makefile.feature          |  1 +
 tools/build/feature/Makefile          |  4 ++++
 tools/build/feature/test-all.c        |  5 +++++
 tools/build/feature/test-getdents64.c | 12 ++++++++++++
 4 files changed, 22 insertions(+)
 create mode 100644 tools/build/feature/test-getdents64.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 64df118376df..f051d4d8c71c 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -58,6 +58,7 @@ FEATURE_TESTS_BASIC :=                  \
         pthread-attr-setaffinity-np     \
         pthread-barrier     		\
         reallocarray                    \
+        getdents64                      \
         stackprotector-all              \
         timerfd                         \
         libdw-dwarf-unwind              \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 37722e509eb9..5efe89c3b0a6 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -21,6 +21,7 @@ FILES=                                          \
          test-disassembler-four-args.bin        \
          test-disassembler-init-styled.bin	\
          test-reallocarray.bin			\
+         test-getdents64.bin			\
          test-libbfd-liberty.bin                \
          test-libbfd-liberty-z.bin              \
          test-cplus-demangle.bin                \
@@ -262,6 +263,9 @@ $(OUTPUT)test-disassembler-init-styled.bin:
 $(OUTPUT)test-reallocarray.bin:
 	$(BUILD)
 
+$(OUTPUT)test-getdents64.bin:
+	$(BUILD)
+
 $(OUTPUT)test-libbfd-liberty.bin:
 	$(CC) $(CFLAGS) -Wall -Werror -o $@ test-libbfd.c -DPACKAGE='"perf"' $(LDFLAGS) -lbfd -ldl -liberty
 
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 6f4bf386a3b5..c65096f75032 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -166,6 +166,10 @@
 # include "test-reallocarray.c"
 #undef main
 
+#define main main_test_getdents64
+# include "test-getdents64.c"
+#undef main
+
 #define main main_test_disassembler_four_args
 # include "test-disassembler-four-args.c"
 #undef main
@@ -216,6 +220,7 @@ int main(int argc, char *argv[])
 	main_test_setns();
 	main_test_libaio();
 	main_test_reallocarray();
+	main_test_getdents64();
 	main_test_disassembler_four_args();
 	main_test_libzstd();
 
diff --git a/tools/build/feature/test-getdents64.c b/tools/build/feature/test-getdents64.c
new file mode 100644
index 000000000000..f7c9df1e2f05
--- /dev/null
+++ b/tools/build/feature/test-getdents64.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stddef.h>
+#define _GNU_SOURCE
+#include <dirent.h>
+
+int main(void)
+{
+	char buf[128];
+	return (int)getdents64(0, buf, sizeof(buf));
+}
+
+#undef _GNU_SOURCE
-- 
2.43.0.rc2.451.g8631bc7472-goog

