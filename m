Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353F223816D;
	Tue, 30 Sep 2025 16:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759251324; cv=none; b=dN28iOhBn25StQ58+YK7F9UADKo8y9LSeiE2lhwBTxUAoFX+f8csVYNvFHkWgqDHWMJClUuLAF/xDqeWE2lW7JivQSpx0l3Cd65rUaKwmaBmkEmRc/OGeXbVnt98tXOj6PYVzp07STLUJsHU5+e7MhsMmzK5LVlOL46HWdvAF/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759251324; c=relaxed/simple;
	bh=m3SmlzRsMKVpO74OXfiVE3r/DuuiN/mWjDes/0cwih0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uB/AKJZYb6jkfFjLNJwuYx86KhMVDALgTtqxkgPE7ofYnIucsGJ0VKiSsl742M05b/Le48jqK/Yv/fRd+ritZ9ubLpALizDuFp3XUSwH5FUwSj8cENp2XPBq+qC2AOLiEpO7CbNqYxhFs+NJ+cviuetuhrJbq4dIqKtLh/iNv/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DA6A2008;
	Tue, 30 Sep 2025 09:55:14 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B9DB3F59E;
	Tue, 30 Sep 2025 09:55:20 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 30 Sep 2025 17:54:51 +0100
Subject: [PATCH v2 3/8] perf: build: Correct CROSS_ARCH for clang
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-perf_build_android_ndk-v2-3-2ea440b7ef01@arm.com>
References: <20250930-perf_build_android_ndk-v2-0-2ea440b7ef01@arm.com>
In-Reply-To: <20250930-perf_build_android_ndk-v2-0-2ea440b7ef01@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, James Clark <james.clark@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 llvm@lists.linux.dev, linux-riscv@lists.infradead.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759251311; l=1923;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=m3SmlzRsMKVpO74OXfiVE3r/DuuiN/mWjDes/0cwih0=;
 b=qUc6vL977vzutRPctHwk1sckCH+1J1T6H7bOBO7DYTmLBmUjwij5vDGLB3/y7XbyFMRL7bm1h
 LqO51kVR3eMAVhrO7d+2ZKDZqEN6w1OzCZrAWr9lUOxhTmkvAWy1Mc3
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Clang's -dumpmachine outputs "aarch64-unknown-linux-gnu", which does not
match the MultiArch convention. This prevents the build system from
detecting installed packages.

Fix by stripping the trailing '-' from CROSS_COMPILE when setting
CROSS_ARCH.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/build/feature/Makefile | 2 +-
 tools/perf/Makefile.perf     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index bd615a708a0aa89ddbe87401f04bd736e384a9c4..214ccaee69181cce1f8e736b85c8dc940efa6c19 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -94,7 +94,7 @@ else
   # paths are used instead.
   ifdef CROSS_COMPILE
     ifeq ($(PKG_CONFIG_LIBDIR)$(PKG_CONFIG_PATH)$(PKG_CONFIG_SYSROOT_DIR),)
-      CROSS_ARCH = $(shell $(CC) -dumpmachine)
+      CROSS_ARCH = $(notdir $(CROSS_COMPILE:%-=%))
       PKG_CONFIG_LIBDIR := /usr/local/$(CROSS_ARCH)/lib/pkgconfig/
       PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/local/lib/$(CROSS_ARCH)/pkgconfig/
       PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/lib/$(CROSS_ARCH)/pkgconfig/
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index e2150acc2c13325f93a2d5cd4a60b4a6bfeedc94..47bc9d8a91df90535408c427909bcb3f7cd50970 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -194,7 +194,7 @@ else
   # paths are used instead.
   ifdef CROSS_COMPILE
     ifeq ($(PKG_CONFIG_LIBDIR)$(PKG_CONFIG_PATH)$(PKG_CONFIG_SYSROOT_DIR),)
-      CROSS_ARCH = $(shell $(CC) -dumpmachine)
+      CROSS_ARCH = $(notdir $(CROSS_COMPILE:%-=%))
       PKG_CONFIG_LIBDIR := /usr/local/$(CROSS_ARCH)/lib/pkgconfig/
       PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/local/lib/$(CROSS_ARCH)/pkgconfig/
       PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/lib/$(CROSS_ARCH)/pkgconfig/

-- 
2.34.1

