Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A031821ADDB;
	Fri, 28 Mar 2025 12:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743164822; cv=none; b=GNW+vvKDyD4etgcMNkZSZcqrp5ezQixcrbJhdPPOvymBQbDeiVdMQG9hKYPt9b8daZFKDrkVSivyBjEWvhMlymGQDvkHJTSV09C4GK3b9nqS4HYWSlEERujPamn1uB444ckig65v63/CRZAfivyFEBa8tp6oxfbkd4MsGdYkmFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743164822; c=relaxed/simple;
	bh=CruxC/xsSTEzFBp8L6SAO6AV9QnFFngDv9wAPsJ2Uq0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ONnvJbBwAuMeDTYs9qQFN081OFsjWXzEpewPitu1osKyZG6JesaiLZtri+tXplXiq9oCI13gN/8c2zTtUqHYrd7EL3nHBmHolzSbscOdM9KKeyjKFnYMou9qXG1ClfuHeqRqwc55/CQRDOr8BsLbpI07bNspoXvwFIAAImYt888=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD7331691;
	Fri, 28 Mar 2025 05:27:04 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 79FD83F58B;
	Fri, 28 Mar 2025 05:26:58 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH 1/2] perf build: Remove unused LIBPERF_CLFAGS
Date: Fri, 28 Mar 2025 12:26:43 +0000
Message-Id: <20250328122644.2383698-2-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250328122644.2383698-1-leo.yan@arm.com>
References: <20250328122644.2383698-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 91009a3a9913 ("perf build: Install libperf locally when
building"), the LIBPERF_CFLAGS flag is never populated to libperf.

As the flag is not used anymore, remove it.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/Makefile.config | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index eea95c6c0c71..94dfc18c2741 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -389,8 +389,6 @@ CORE_CFLAGS += -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE
 CFLAGS   += $(CORE_CFLAGS) $(INC_FLAGS)
 CXXFLAGS += $(INC_FLAGS)
 
-LIBPERF_CFLAGS := $(CORE_CFLAGS) $(EXTRA_CFLAGS)
-
 ifeq ($(feature-pthread-attr-setaffinity-np), 1)
   CFLAGS += -DHAVE_PTHREAD_ATTR_SETAFFINITY_NP
 endif
-- 
2.34.1

