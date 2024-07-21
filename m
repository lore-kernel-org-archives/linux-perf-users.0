Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002C5168C20;
	Sun, 21 Jul 2024 20:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721593301; cv=none; b=feeiBrLbiZ6ThhrFIR4bCfG1AW8AS13QirB04vsvfTsluUGF+a/pP4LfuWZgLwpKeepBqItxlf7IKD+gGAoGQK6GGEeJEkIVpWRO9Z7n4nfDMmNPqXqUBgPR1m9RXmiWs1Mdxhx9yCbWhPtH4T/ogO8XNrlhj08SsCG6Bn1Wfjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721593301; c=relaxed/simple;
	bh=i96Z+mFuJ7vzCKLXbS4G8Xej6yPSF4jk6n1ht4RFpSI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AzWNeo68VWAOS7iWLAFjVM8GGNnB/cPSvPouWt6uc8o1dFUyl+oLfqu4ma61HvY5VW6q/xvRMwwG/4CHFEm6brKT9+c4/Mz3ZkUw0QE3A2Hp/TirWWkpIlvrSx0TXCpMgKnG2GB982zDSKkurY3oSLCmEb94OXRk/lTnjtb1XM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3B3A12FC;
	Sun, 21 Jul 2024 13:22:03 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DAE0B3F73F;
	Sun, 21 Jul 2024 13:21:35 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 3/6] perf auxtrace s390: Set the 'auxtrace' flag for AUX events
Date: Sun, 21 Jul 2024 21:21:10 +0100
Message-Id: <20240721202113.380750-4-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240721202113.380750-1-leo.yan@arm.com>
References: <20240721202113.380750-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set the 'auxtrace' flag for AUX events on s390.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/arch/s390/util/auxtrace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/arch/s390/util/auxtrace.c b/tools/perf/arch/s390/util/auxtrace.c
index 5068baa3e092..d7e72413b262 100644
--- a/tools/perf/arch/s390/util/auxtrace.c
+++ b/tools/perf/arch/s390/util/auxtrace.c
@@ -99,6 +99,7 @@ struct auxtrace_record *auxtrace_record__init(struct evlist *evlist,
 		if (pos->core.attr.config == PERF_EVENT_CPUM_SF_DIAG) {
 			diagnose = 1;
 			pos->needs_auxtrace_mmap = true;
+			pos->pmu->auxtrace = true;
 			break;
 		}
 	}
-- 
2.34.1

