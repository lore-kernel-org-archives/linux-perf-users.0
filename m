Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004472EBDC0;
	Thu,  4 Dec 2025 16:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764867241; cv=none; b=HS1c41RmjmfFOLbKjEii+3f5oAEbVDNschcdOxqKRcGBeV/hpbnd3D5K/PdIJYNn3h1bVs5PYwPmOwlV1LyyKUrvewhyIrvi3Bm5TI6cO8JVPvhhSrZqADO5W+EKaJIVGy75gG77dY26z8cyjEJR5XzZzXNHHljvJ2wDpbFvAnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764867241; c=relaxed/simple;
	bh=N5SCa+zc/Mf6WCzoend7lFCy6F6BWHMyZXrzAGp75IM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nD4fG11NvWXhO7rd9SESeKOJ1Id2TcVd8sAtMmcNzlBWd/JuDWLALNe3YVGlwXwhazP/LIdPfqx40eMDDGXa24XPOiKM/73ccXOx9AGS+6PWbxf0e2ekR4g6WUKMGmmJIcXHoR769vuPrgFERcmbzQVEuVqgOKHOq5bTUCGk+YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08306176A;
	Thu,  4 Dec 2025 08:53:51 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0DBE3F59E;
	Thu,  4 Dec 2025 08:53:56 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 04 Dec 2025 16:53:42 +0000
Subject: [PATCH 2/2] Revert "perf tools: Fix arm64 build by generating
 unistd_64.h"
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-perf_fix_syscall_header-v1-2-b8e27f74ed6a@arm.com>
References: <20251204-perf_fix_syscall_header-v1-0-b8e27f74ed6a@arm.com>
In-Reply-To: <20251204-perf_fix_syscall_header-v1-0-b8e27f74ed6a@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764867233; l=2519;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=N5SCa+zc/Mf6WCzoend7lFCy6F6BWHMyZXrzAGp75IM=;
 b=IrGXuUjuAZLVjk84Lda/5d7q/JKAc3h6sZZetQYWrd7Ct3o5rZ4mLaAoLmjKOCQFk9EFYjEC5
 de8ZPm2Pg99BXcgdEob75z56Rby/6Pbi4CJLUOibir24Jjcx4OrOOg+
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
index 6b62fea21a0ad1caf99d75d06fc29d2b05007931..b1e39fe0cf40ce1419b19a11daccc18853d5cfe6 100644
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

