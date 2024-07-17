Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833313839C;
	Wed, 17 Jul 2024 08:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721204584; cv=none; b=N758Op1oQNY4s5tIfvQPdy6AAe+KMjO+cTz36a7CtXpEf08xU/3nD6gcX0yqCy8zHi3/wdcG6cT0UH4uJD69R84ksLqSGTAhvxg+8nqXPKkSTXhbThkrHk5v5THbeSHM+uViyakYcEbt4MuCU83n12jDF/snTQkSqVqxGSt6gyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721204584; c=relaxed/simple;
	bh=fc88uOJRhVMj3xvkGkwo8FFwVo0Vrw2VDh0HPHWQs4M=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Psbxam6YU8sP8iLBkSswuKD8qB720Ap93DsJUA75O8lQj/EFdj7sww8XoibPCnouDvd3jZm/CpHfcAuLMLokeFCGjdUxqyI9tyj+m8ODSv5GZT0xg62xpbUnIuWBVIiNXAItBKKDViMruT1EbD1M21AA46CNdm420rhKv+6c8B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 004AC1480;
	Wed, 17 Jul 2024 01:23:27 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CCBF23F762;
	Wed, 17 Jul 2024 01:22:59 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Leo Yan <leo.yan@arm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	James Clark <james.clark@linaro.org>,
	amadio@gentoo.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v5 2/6] perf: build: Set Python configuration for cross compilation
Date: Wed, 17 Jul 2024 09:22:07 +0100
Message-Id: <20240717082211.524826-3-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240717082211.524826-1-leo.yan@arm.com>
References: <20240717082211.524826-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Python configuration has dedicated folders for different architectures.
For example, Python 3.11 has two folders as shown below, one for Arm64
and another for x86_64:

  /usr/lib/python3.11/config-3.11-aarch64-linux-gnu/
  /usr/lib/python3.11/config-3.11-x86_64-linux-gnu/

This commit updates the Python configuration path based on the
compiler's machine type, guiding the compiler to find the correct path
for Python libraries. It also renames the generated .so file name to
match the machine name.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/Makefile.config | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 7f1e016a9253..755fb78be76a 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -303,6 +303,11 @@ endif
 
 ifdef PYTHON_CONFIG
   PYTHON_EMBED_LDOPTS := $(shell $(PYTHON_CONFIG_SQ) $(PYTHON_CONFIG_LDFLAGS) 2>/dev/null)
+  # Update the python flags for cross compilation
+  ifdef CROSS_COMPILE
+    PYTHON_NATIVE := $(shell echo $(PYTHON_EMBED_LDOPTS) | sed 's/\(-L.*\/\)\(.*-linux-gnu\).*/\2/')
+    PYTHON_EMBED_LDOPTS := $(subst $(PYTHON_NATIVE),$(shell $(CC) -dumpmachine),$(PYTHON_EMBED_LDOPTS))
+  endif
   PYTHON_EMBED_LDFLAGS := $(call strip-libs,$(PYTHON_EMBED_LDOPTS))
   PYTHON_EMBED_LIBADD := $(call grep-libs,$(PYTHON_EMBED_LDOPTS)) -lutil
   PYTHON_EMBED_CCOPTS := $(shell $(PYTHON_CONFIG_SQ) --includes 2>/dev/null)
@@ -904,6 +909,9 @@ else
          PYTHON_SETUPTOOLS_INSTALLED := $(shell $(PYTHON) -c 'import setuptools;' 2> /dev/null && echo "yes" || echo "no")
          ifeq ($(PYTHON_SETUPTOOLS_INSTALLED), yes)
            PYTHON_EXTENSION_SUFFIX := $(shell $(PYTHON) -c 'from importlib import machinery; print(machinery.EXTENSION_SUFFIXES[0])')
+           ifdef CROSS_COMPILE
+             PYTHON_EXTENSION_SUFFIX := $(subst $(PYTHON_NATIVE),$(shell $(CC) -dumpmachine),$(PYTHON_EXTENSION_SUFFIX))
+           endif
            LANG_BINDINGS += $(obj-perf)python/perf$(PYTHON_EXTENSION_SUFFIX)
 	 else
            $(warning Missing python setuptools, the python binding won't be built, please install python3-setuptools or equivalent)
-- 
2.34.1

