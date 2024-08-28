Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147E7165F06;
	Wed, 28 Aug 2024 22:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724883088; cv=none; b=HKtJbilJ5/k8GeynAfHveJMU84plY6L/d3uvkOPTafn6IEQ9YoHC6/7e2B/0dFlGo4lYu+3PMkAtyPL13nmLorVda4rpcdEqIfCih2T2iRYZq4332pCRlJfWcHrY0UPANOgoT5fR0hLgPw+0KqTtfziCAGFHitmFi8QRf1LnRpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724883088; c=relaxed/simple;
	bh=fh179UhoVkPuCbOgo1TC+lsXV+5KHEvIdYxU8lFYcgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ras5qn0K5QzI98MBTV6PxVfPrNm52cVYpOCX2PXMIQgUZTuwzp2L/IW4OvvuuVLhAhnqIlbrbANUh+KoCFtlAhC8JGGd/6xR5W7ktFpF491cYybZiaAnFN12iSYt7c5RXEFyFQKul/XyItvY2SuIACxs+GFWwhzkfrZKsbnsj1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7FRl0r1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7FRl0r1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CCA1C4CEC0;
	Wed, 28 Aug 2024 22:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724883087;
	bh=fh179UhoVkPuCbOgo1TC+lsXV+5KHEvIdYxU8lFYcgQ=;
	h=Date:From:To:Cc:Subject:From;
	b=i7FRl0r1hpdn6v6FaTQzw3O93tmXNQrwzD/7OVdUZuNoiZuYvw3nRpKVVJXK++RE3
	 4WbvdcBCQbEs93ssC/pZlqUGQjTRII1WI6HZIsMySoVL+PN0HWz6xChVGp92XSd3ML
	 Wl4E4Q+JTClnxbE7ufA9csl4brjrTy4X7vQnDD5ft7w5sHopHQK28Y38KyOGWqS598
	 qScJxrZdnFFadeadK9CXLE4nUipEgBUmm9wgrgOVc7/wpoBjz9IAls4D7yMIHIdNBE
	 EkHiEny7mwQTIwFyumfe0DbTl9lUvGbFlo85Q69n+U6KYWQec84Eg8T4ve0Hw/UhSS
	 ZJQlbI1cFrkTw==
Date: Wed, 28 Aug 2024 19:11:24 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] tools build: Remove leftover libcap tests that prevents
 fast path feature detection from working
Message-ID: <Zs-gjOGFWtAvIZit@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I noticed that the fast path feature detection was failing:

  $ cat /tmp/build/perf-tools-next/feature/test-all.make.output
  /usr/bin/ld: cannot find -lcap: No such file or directory
  collect2: error: ld returned 1 exit status
  $

The patch removing the dependency (Fixes tag below) didn't remove the
detection of libcap, and as the fast path feature detection (test-all.c)
had -lcap in its Makefile link list of libraries to link, it was failing
when libcap-devel is not available, fix it by removing those leftover
files.

Fixes: e25ebda78e230283 ("perf cap: Tidy up and improve capability testing")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/feature/Makefile      |  6 +-----
 tools/build/feature/test-libcap.c | 20 --------------------
 2 files changed, 1 insertion(+), 25 deletions(-)
 delete mode 100644 tools/build/feature/test-libcap.c

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 12796808f07a8c0d..b873fc58804e2f38 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -25,7 +25,6 @@ FILES=                                          \
          test-libbfd-liberty-z.bin              \
          test-cplus-demangle.bin                \
          test-cxa-demangle.bin                  \
-         test-libcap.bin			\
          test-libelf.bin                        \
          test-libelf-getphdrnum.bin             \
          test-libelf-gelf_getnote.bin           \
@@ -112,7 +111,7 @@ all: $(FILES)
 __BUILD = $(CC) $(CFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.c,$(@F)) $(LDFLAGS)
   BUILD = $(__BUILD) > $(@:.bin=.make.output) 2>&1
   BUILD_BFD = $(BUILD) -DPACKAGE='"perf"' -lbfd -ldl
-  BUILD_ALL = $(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=2 -ldw -lelf -lnuma -lelf -lslang $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) -DPACKAGE='"perf"' -lbfd -ldl -lz -llzma -lzstd -lcap
+  BUILD_ALL = $(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=2 -ldw -lelf -lnuma -lelf -lslang $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) -DPACKAGE='"perf"' -lbfd -ldl -lz -llzma -lzstd
 
 __BUILDXX = $(CXX) $(CXXFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.cpp,$(@F)) $(LDFLAGS)
   BUILDXX = $(__BUILDXX) > $(@:.bin=.make.output) 2>&1
@@ -140,9 +139,6 @@ $(OUTPUT)test-fortify-source.bin:
 $(OUTPUT)test-bionic.bin:
 	$(BUILD)
 
-$(OUTPUT)test-libcap.bin:
-	$(BUILD) -lcap
-
 $(OUTPUT)test-libelf.bin:
 	$(BUILD) -lelf
 
diff --git a/tools/build/feature/test-libcap.c b/tools/build/feature/test-libcap.c
deleted file mode 100644
index d2a2e152195f976b..0000000000000000
--- a/tools/build/feature/test-libcap.c
+++ /dev/null
@@ -1,20 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <sys/capability.h>
-#include <linux/capability.h>
-
-int main(void)
-{
-	cap_flag_value_t val;
-	cap_t caps = cap_get_proc();
-
-	if (!caps)
-		return 1;
-
-	if (cap_get_flag(caps, CAP_SYS_ADMIN, CAP_EFFECTIVE, &val) != 0)
-		return 1;
-
-	if (cap_free(caps) != 0)
-		return 1;
-
-	return 0;
-}
-- 
2.46.0

