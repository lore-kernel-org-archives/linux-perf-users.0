Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C429B144D24;
	Tue,  4 Jun 2024 09:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717493567; cv=none; b=B1u7XnkZqhLewd+L4TN08Oqd9nXa8J6AQzo5PHnoO51bC3dxMgLfbd7TDt+v0zErEepSFi8H/JA2QNPC7RVgywehSAGEoLinVLNfOHA30CnYj1OJsPuq/wsAGegMlQD65vGieKHTwVG5KvJgJxEUo59itrng1FgBjyCHfmhMUOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717493567; c=relaxed/simple;
	bh=v6eX51MtO/kHVdP5FiWoLf+U6ElkFVAWKVYKBl9e4Hg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NRHusfMH5eUXNZnaX1HeYfSyNOjltbBmLI7carsmE6Ommu23+6lR/vcAGl+9pNa8lIlVUtHpnP2ORkf6drJ3KCGSiS82Vf54oeYB2CXuT0qxXk7PDXlhNpAc0+NxGGDLBgZiOMqNsGk1Jjvn20oTWWehz59Y0IVGt51D8agGqJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87BAF1515;
	Tue,  4 Jun 2024 02:33:09 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7AE6A3F762;
	Tue,  4 Jun 2024 02:32:43 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@arm.com>,
	Ian Rogers <irogers@google.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Nick Terrell <terrelln@fb.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Changbin Du <changbin.du@huawei.com>,
	Fangrui Song <maskray@google.com>,
	"Mateusz Kowalczyk" <fuuzetsu@fuuzetsu.co.uk>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 3/6] perf: build: Set Python configuration for cross compilation
Date: Tue,  4 Jun 2024 10:32:20 +0100
Message-Id: <20240604093223.1934236-4-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240604093223.1934236-1-leo.yan@arm.com>
References: <20240604093223.1934236-1-leo.yan@arm.com>
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
index f545e0c3c176..646e5af0ed51 100644
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

