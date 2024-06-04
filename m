Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DB6145327;
	Tue,  4 Jun 2024 09:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717493569; cv=none; b=uLHv9gZIQQc8IMxoQ4acGbT9wZ0lSY2K8pl+oDFHAl87Xf+Y0AH3eQvnVx7tZE0UO2O2Coe/aNMnJzEmfDdp8HMXWGEDSyuDmqnRpWfgOC0cAOJYpLqfykVTngBC19C5VBdZQc4I8ITYEcxtE85Ggyvo8SL4EGIF0vuz+zNP8iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717493569; c=relaxed/simple;
	bh=f5zCnqc+nOgXNE3aBYf6+yyhziHuGJt+sO5UjVnaqZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q5HgJFumh+uhHEAK5iVkapQE5a+tEOI8sKGT8+/U/Y+HiBT22NgoQXDQBeOHGL238ydcbI8IZowHh3o1SAXH2D/sgeUZ70CpFxKSEMh8KWOCQf4mZ/TbisH3P5VWdFiz+mrzAIjFKA4SUIqKifUNiNIfOIThowzxtRMqYOL2lRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 762751516;
	Tue,  4 Jun 2024 02:33:11 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 697483F762;
	Tue,  4 Jun 2024 02:32:45 -0700 (PDT)
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
Subject: [PATCH v1 4/6] perf: build: Only link libebl.a for old libdw
Date: Tue,  4 Jun 2024 10:32:21 +0100
Message-Id: <20240604093223.1934236-5-leo.yan@arm.com>
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

Since libdw version 0.177, elfutils has merged libebl.a into libdw (see
the commit "libebl: Don't install libebl.a, libebl.h and remove backends
from spec." in the elfutils repository).

As a result, libebl.a does not exist on Debian Bullseye and newer
releases, causing static perf builds to fail on these distributions.

This commit checks the libdw version and only links libebl.a if it
detects that the libdw version is older than 0.177.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/build/feature/Makefile | 12 +++++++++++-
 tools/perf/Makefile.config   | 12 +++++++++++-
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 6f52f892f9a3..2f4cfb7b8c14 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -159,7 +159,17 @@ $(OUTPUT)test-libopencsd.bin:
 
 DWARFLIBS := -ldw
 ifeq ($(findstring -static,${LDFLAGS}),-static)
-DWARFLIBS += -lelf -lebl -lz -llzma -lbz2
+  DWARFLIBS += -lelf -lz -llzma -lbz2
+
+  LIBDW_VERSION := $(shell $(PKG_CONFIG) --modversion libdw)
+  LIBDW_VERSION_1 := $(word 1, $(subst ., ,$(LIBDW_VERSION)))
+  LIBDW_VERSION_2 := $(word 2, $(subst ., ,$(LIBDW_VERSION)))
+
+  # Elfutils merged libebl.a into libdw.a starting from version 0.177,
+  # Link libebl.a only if libdw is older than this version.
+  ifeq ($(shell test $(LIBDW_VERSION_2) -lt 177; echo $$?),0)
+    DWARFLIBS += -lebl
+  endif
 endif
 
 $(OUTPUT)test-dwarf.bin:
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 646e5af0ed51..e8d3713b081c 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -152,7 +152,17 @@ ifdef LIBDW_DIR
 endif
 DWARFLIBS := -ldw
 ifeq ($(findstring -static,${LDFLAGS}),-static)
-  DWARFLIBS += -lelf -lebl -ldl -lz -llzma -lbz2
+  DWARFLIBS += -lelf -ldl -lz -llzma -lbz2
+
+  LIBDW_VERSION := $(shell $(PKG_CONFIG) --modversion libdw)
+  LIBDW_VERSION_1 := $(word 1, $(subst ., ,$(LIBDW_VERSION)))
+  LIBDW_VERSION_2 := $(word 2, $(subst ., ,$(LIBDW_VERSION)))
+
+  # Elfutils merged libebl.a into libdw.a starting from version 0.177,
+  # Link libebl.a only if libdw is older than this version.
+  ifeq ($(shell test $(LIBDW_VERSION_2) -lt 177; echo $$?),0)
+    DWARFLIBS += -lebl
+  endif
 endif
 FEATURE_CHECK_CFLAGS-libdw-dwarf-unwind := $(LIBDW_CFLAGS)
 FEATURE_CHECK_LDFLAGS-libdw-dwarf-unwind := $(LIBDW_LDFLAGS) $(DWARFLIBS)
-- 
2.34.1

