Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A2E33291D;
	Mon, 22 Dec 2025 18:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766426835; cv=none; b=Vqjsr2tEkSqLKMAo961By9oxlZ4IOY8l1Oow90o5Nm14rRcoqpCTa+amAth1Q9nBEU6n49WpJhdz7CTjw97n1Whilt0F4PX4X/pXXmZiQDE6KN5KRUredvklW31fnQrvcykeJKF9OziLZxCjvQZzqf5aS01NR7Nn4t3ey9uB0E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766426835; c=relaxed/simple;
	bh=rFUtwguG5/wwZfFnpFmopp4L9YEp1dSeOPOmek71TRY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c/uUo756jXWLeZrtM8FsbPj4Ox+KdGID4eBRWM6WCJZlQdM1QJpoI8oX9azGzGfkZjfsQyrk7QYNNoF+49zko+Xcv00kMDaS0KOQI1X4Enx4kTTZb5Zq3t2jiWn041IJGD06Vd8wiLTIDG2Ergd7OivZMjQH8Mr8mdYxa4w0FiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDCED1515;
	Mon, 22 Dec 2025 10:07:05 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 821583F73F;
	Mon, 22 Dec 2025 10:07:11 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 22 Dec 2025 18:06:47 +0000
Subject: [PATCH v3 2/3] Revert "perf tools: Fix arm64 build by generating
 unistd_64.h"
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-perf_fix_syscall_header-v3-2-eb4a8b9dfe66@arm.com>
References: <20251222-perf_fix_syscall_header-v3-0-eb4a8b9dfe66@arm.com>
In-Reply-To: <20251222-perf_fix_syscall_header-v3-0-eb4a8b9dfe66@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766426828; l=2519;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=rFUtwguG5/wwZfFnpFmopp4L9YEp1dSeOPOmek71TRY=;
 b=Kz3V3KwO5XtMSpSsCGAsB89Ci63hM1fPUxgMacUi8RgPSOACytRwp/NvI1Jwfk9CoiPCCwnoW
 6k2Dt3csJvDCR8QXi3GakkzAEZlh6OxF66jXi+QUOxop7nn/FpIvlCc
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

This reverts:

commit 8988c4b91945 ("perf tools: Fix in-source libperf build")
commit bfb713ea53c7 ("perf tools: Fix arm64 build by generating unistd_64.h")

Since we now have a static unistd_64.h for the arm64 build, there is no
need to generate unistd_64.h in libperf.  Revert all patches related to
generating unistd_64.h.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/lib/perf/Makefile    | 14 ++------------
 tools/perf/Makefile.config |  1 -
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
index 7fbb50b74c00b3b99ac538821124e04bfbc6da6a..ffcfd777c45181960afc7505ef8f85d0b7ea7e8d 100644
--- a/tools/lib/perf/Makefile
+++ b/tools/lib/perf/Makefile
@@ -42,7 +42,6 @@ libdir_relative_SQ = $(subst ','\'',$(libdir_relative))
 TEST_ARGS := $(if $(V),-v)
 
 INCLUDES = \
--I$(OUTPUT)arch/$(SRCARCH)/include/generated/uapi \
 -I$(srctree)/tools/lib/perf/include \
 -I$(srctree)/tools/lib/ \
 -I$(srctree)/tools/include \
@@ -100,16 +99,7 @@ $(LIBAPI)-clean:
 	$(call QUIET_CLEAN, libapi)
 	$(Q)$(MAKE) -C $(LIB_DIR) O=$(OUTPUT) clean >/dev/null
 
-uapi-asm := $(OUTPUT)arch/$(SRCARCH)/include/generated/uapi/asm
-ifeq ($(SRCARCH),arm64)
-	syscall-y := $(uapi-asm)/unistd_64.h
-endif
-uapi-asm-generic:
-	$(if $(syscall-y),\
-		$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.asm-headers obj=$(uapi-asm) \
-		generic=include/uapi/asm-generic $(syscall-y),)
-
-$(LIBPERF_IN): uapi-asm-generic FORCE
+$(LIBPERF_IN): FORCE
 	$(Q)$(MAKE) $(build)=libperf
 
 $(LIBPERF_A): $(LIBPERF_IN)
@@ -130,7 +120,7 @@ all: fixdep
 clean: $(LIBAPI)-clean
 	$(call QUIET_CLEAN, libperf) $(RM) $(LIBPERF_A) \
                 *.o *~ *.a *.so *.so.$(VERSION) *.so.$(LIBPERF_VERSION) .*.d .*.cmd tests/*.o LIBPERF-CFLAGS $(LIBPERF_PC) \
-                $(TESTS_STATIC) $(TESTS_SHARED) $(syscall-y)
+                $(TESTS_STATIC) $(TESTS_SHARED)
 
 TESTS_IN = tests-in.o
 
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index bd9f4804d56babeeefd0c02758bebf1ff0c040dd..c97ed1190ea097c41ca83f2ace06c008cd7f0ca9 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -64,7 +64,6 @@ include $(srctree)/tools/scripts/Makefile.arch
 $(call detected_var,SRCARCH)
 
 CFLAGS += -I$(OUTPUT)arch/$(SRCARCH)/include/generated
-CFLAGS += -I$(OUTPUT)libperf/arch/$(SRCARCH)/include/generated/uapi
 
 # Additional ARCH settings for ppc
 ifeq ($(SRCARCH),powerpc)

-- 
2.34.1

