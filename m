Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A847E1AE84C;
	Thu, 29 Aug 2024 14:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724943102; cv=none; b=IxmIsYRWW3rFwxdm/J7Ap0SsW9mnr+s/NGnv5rO5/Q7n70SRWm79dwzaHwI6qhvp8/RBT89AmbAou4fPCCnTJJZMGBJEOrTOEDg4lVYx8nj6T2fhYNnCp5CYJRxu0Rtj3GSg2DA/6JIxA9x0U5Xta6jJbxqGnss59WFSiKALQkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724943102; c=relaxed/simple;
	bh=qTnDyzEcne5+cOMjbnWs7xjxVNKWuYlyKpsjIOtxtCE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=e4roMDBLsbAJVcI+z6a5dYPX3Ha1G/zSDtWFMbCWt2q9TBFjOBJt7TZAlYnaBgtfK0HFPHcLyG1YwJN57ydX+IeaaxNvkO6dcoyL/mIXOrwt3GVcU/MnzkBETQKLZ3bk8MHQwOnRpvXPa4u0hLW65wxKu1ANwWHTUzLZldt4pRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzEBG0Bc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzEBG0Bc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4CD2C4CEC1;
	Thu, 29 Aug 2024 14:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724943101;
	bh=qTnDyzEcne5+cOMjbnWs7xjxVNKWuYlyKpsjIOtxtCE=;
	h=Date:From:To:Cc:Subject:From;
	b=BzEBG0BclTNaB7UAV8QmAdVBBvyaQaK8vIxq3n28+2MDof1iGFB+DpWXh5FMwehAH
	 DkjngAQAUNFz7FKNvn/Fndpmfbdb83B7lcg5E1vVWXF4qt0vZ40t6+O4irNDj8dxsE
	 cJfSPF4qdKPLgUxy9vQQyMYg3kohx9Ve6+oSu5HVwwiwarE38PxgIYQQBw6AEwQMKs
	 M3kyq46fNryvilaOVAU0c1tIzidO9oxZOKRpCrZWcLaTmnMRD7cNCJwlOlcfuyfBie
	 j7UuH+aFyEn+VamWi9vg2AKs2KJ71egkIXeXobmfKQU0m7An5USwrgkQl+t3H2jm4I
	 PpB36CdnDhNRw==
Date: Thu, 29 Aug 2024 11:51:37 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] Revert "tools build: Remove leftover libcap tests that
 prevents fast path feature detection from working"
Message-ID: <ZtCK-WIpBaUM8-q3@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Ian pointed out that the libcap feature test is also used by bpftool, so
we can't remove it just because perf stopped using it, revert the
removal of the feature test.

Since both perf and libcap uses the fast path feature detection
(tools/build/feature/test-all.c), probably the best thing is to keep
libcap-devel when building perf even it not being used there.

This reverts commit 47b3b6435e4bfb61ae8ffc63a11bd3c310f69acf.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/feature/Makefile      |  6 +++++-
 tools/build/feature/test-libcap.c | 20 ++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)
 create mode 100644 tools/build/feature/test-libcap.c

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index b873fc58804e2f38..12796808f07a8c0d 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -25,6 +25,7 @@ FILES=                                          \
          test-libbfd-liberty-z.bin              \
          test-cplus-demangle.bin                \
          test-cxa-demangle.bin                  \
+         test-libcap.bin			\
          test-libelf.bin                        \
          test-libelf-getphdrnum.bin             \
          test-libelf-gelf_getnote.bin           \
@@ -111,7 +112,7 @@ all: $(FILES)
 __BUILD = $(CC) $(CFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.c,$(@F)) $(LDFLAGS)
   BUILD = $(__BUILD) > $(@:.bin=.make.output) 2>&1
   BUILD_BFD = $(BUILD) -DPACKAGE='"perf"' -lbfd -ldl
-  BUILD_ALL = $(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=2 -ldw -lelf -lnuma -lelf -lslang $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) -DPACKAGE='"perf"' -lbfd -ldl -lz -llzma -lzstd
+  BUILD_ALL = $(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=2 -ldw -lelf -lnuma -lelf -lslang $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) -DPACKAGE='"perf"' -lbfd -ldl -lz -llzma -lzstd -lcap
 
 __BUILDXX = $(CXX) $(CXXFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.cpp,$(@F)) $(LDFLAGS)
   BUILDXX = $(__BUILDXX) > $(@:.bin=.make.output) 2>&1
@@ -139,6 +140,9 @@ $(OUTPUT)test-fortify-source.bin:
 $(OUTPUT)test-bionic.bin:
 	$(BUILD)
 
+$(OUTPUT)test-libcap.bin:
+	$(BUILD) -lcap
+
 $(OUTPUT)test-libelf.bin:
 	$(BUILD) -lelf
 
diff --git a/tools/build/feature/test-libcap.c b/tools/build/feature/test-libcap.c
new file mode 100644
index 0000000000000000..d2a2e152195f976b
--- /dev/null
+++ b/tools/build/feature/test-libcap.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <sys/capability.h>
+#include <linux/capability.h>
+
+int main(void)
+{
+	cap_flag_value_t val;
+	cap_t caps = cap_get_proc();
+
+	if (!caps)
+		return 1;
+
+	if (cap_get_flag(caps, CAP_SYS_ADMIN, CAP_EFFECTIVE, &val) != 0)
+		return 1;
+
+	if (cap_free(caps) != 0)
+		return 1;
+
+	return 0;
+}
-- 
2.46.0

