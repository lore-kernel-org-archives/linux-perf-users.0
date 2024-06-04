Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97EA1448F6;
	Tue,  4 Jun 2024 09:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717493565; cv=none; b=azZYyvZ3o1Rtiyce09EWlVsg4A2NZNJmNyP2xYGwV0Kb5+h7Vs3x7+b5PVRe2s4fAqxXL9czFLci9GAiALmgUyQgdWvMiqfrkqBF/xxZi9a9r7nA9q0WasoZwJFHDuExlVRNgiUkPQ/8Zbuomgrg2jSPZFyu/6hvNuJLewaPf/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717493565; c=relaxed/simple;
	bh=3bxksl8Ny84wUjMLk6cosHjxG9kquj8690iMjEdPc24=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=stZGSnt3ExBf2YdMUNSGVtABSMNiQXNaFs9vW1v7UB9v1UlhBaZ6uy1TviP2T0/rjyJPgXS0RvXEiSlW8yp6GFqk220SvkD9H+FbggP0wdWdWk2Ehr4yk0tgl2s16yPOGBE5Kwl4jqfHThT1fT88Di8OaPTIFphNS3ic/lowxPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 994161474;
	Tue,  4 Jun 2024 02:33:07 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8C6DE3F762;
	Tue,  4 Jun 2024 02:32:41 -0700 (PDT)
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
Subject: [PATCH v1 2/6] perf: build: Append libtraceevent path in PKG_CONFIG_LIBDIR
Date: Tue,  4 Jun 2024 10:32:19 +0100
Message-Id: <20240604093223.1934236-3-leo.yan@arm.com>
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

When a user specifies the path for libtraceevent, it means a self-built
package is being used instead of the distro package. This commit appends
the specified path in the variable 'PKG_CONFIG_LIBDIR', so that later
pkg-config can retrieve version info from the self-built folder.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/Makefile.config | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 7f1e016a9253..f545e0c3c176 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1181,7 +1181,10 @@ ifneq ($(NO_LIBTRACEEVENT),1)
     CFLAGS += -DHAVE_LIBTRACEEVENT $(LIBTRACEEVENT_CFLAGS)
     LDFLAGS += $(LIBTRACEEVENT_LDFLAGS)
     EXTLIBS += ${TRACEEVENTLIBS}
-    LIBTRACEEVENT_VERSION := $(shell PKG_CONFIG_PATH=$(LIBTRACEEVENT_DIR) $(PKG_CONFIG) --modversion libtraceevent)
+    ifdef LIBTRACEEVENT_DIR
+      PKG_CONFIG_LIBDIR := $(LIBTRACEEVENT_DIR):$(PKG_CONFIG_LIBDIR)
+    endif
+    LIBTRACEEVENT_VERSION := $(shell $(PKG_CONFIG) --modversion libtraceevent)
     LIBTRACEEVENT_VERSION_1 := $(word 1, $(subst ., ,$(LIBTRACEEVENT_VERSION)))
     LIBTRACEEVENT_VERSION_2 := $(word 2, $(subst ., ,$(LIBTRACEEVENT_VERSION)))
     LIBTRACEEVENT_VERSION_3 := $(word 3, $(subst ., ,$(LIBTRACEEVENT_VERSION)))
-- 
2.34.1

