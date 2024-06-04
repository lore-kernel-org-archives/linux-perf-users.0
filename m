Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2DD1459EA;
	Tue,  4 Jun 2024 09:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717493572; cv=none; b=KlgimZqJXPGBt5sIQCdsCUovQ3B9jkJma0lDzZ3saZgu5EPF3FlRS8cusyq3z/Bq1g2u6newgNfZCYs+C2sUbGKf6NQPYW0sKuqdJrt6BAe1G4V2IodU0VMxj4txg2/VehXrv0GOMelLeEviQxrvTYC2KZTynW09LttJ0RrT56I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717493572; c=relaxed/simple;
	bh=N+BgYVByzMrgGeiS8IAeDM2+IOiN9MtSfjmOFc+R2H8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uGRM6wVL46PHKKKwQnSDQjiBJ/cGexsastSJBM5e6JeHan2Xmh9iY3P/3PhfLARzcI6m05/CBH2iF8UH8YR1LdaCmnicjXXnK/dx62MB5VpCMUBetjxbTJEQRZpAfKhPYAIZg6y1rKWXxksexK3JHzDpEEZlJuASoChfI0WfPjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 538ED1063;
	Tue,  4 Jun 2024 02:33:15 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 46F0F3F762;
	Tue,  4 Jun 2024 02:32:49 -0700 (PDT)
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
Subject: [PATCH v1 6/6] perf: build: Link lib 'zstd' for static build
Date: Tue,  4 Jun 2024 10:32:23 +0100
Message-Id: <20240604093223.1934236-7-leo.yan@arm.com>
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

When build static perf, Makefile reports the error:

  Makefile.config:480: No libdw DWARF unwind found, Please install
  elfutils-devel/libdw-dev >= 0.158 and/or set LIBDW_DIR

The libdw has been installed on the system, but the build system fails
to build the feature detecting binary 'test-libdw-dwarf-unwind'. The
failure is caused by missing to link the lib 'zstd'.

Link lib 'zstd' for the static build, in the end, the dwarf feature can
be enabled in the static perf.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/build/feature/Makefile | 2 +-
 tools/perf/Makefile.config   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 18aa6e654804..80c237890a06 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -159,7 +159,7 @@ $(OUTPUT)test-libopencsd.bin:
 
 DWARFLIBS := -ldw
 ifeq ($(findstring -static,${LDFLAGS}),-static)
-  DWARFLIBS += -lelf -lz -llzma -lbz2
+  DWARFLIBS += -lelf -lz -llzma -lbz2 -lzstd
 
   LIBDW_VERSION := $(shell $(PKG_CONFIG) --modversion libdw)
   LIBDW_VERSION_1 := $(word 1, $(subst ., ,$(LIBDW_VERSION)))
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index e8d3713b081c..acd405bc46de 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -152,7 +152,7 @@ ifdef LIBDW_DIR
 endif
 DWARFLIBS := -ldw
 ifeq ($(findstring -static,${LDFLAGS}),-static)
-  DWARFLIBS += -lelf -ldl -lz -llzma -lbz2
+  DWARFLIBS += -lelf -ldl -lz -llzma -lbz2 -lzstd
 
   LIBDW_VERSION := $(shell $(PKG_CONFIG) --modversion libdw)
   LIBDW_VERSION_1 := $(word 1, $(subst ., ,$(LIBDW_VERSION)))
-- 
2.34.1

