Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D8314EC4B;
	Wed, 25 Sep 2024 19:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727294040; cv=none; b=IM5hwuWgIKoXddI6tmn1ZWFWtkm13leYAwPr3duyqC3DGsg8arNLXuoqXKPSOObCSftN+GVWNHZwEz7ZTzt5/jSi4NupRoQFvoNNVuZuU9aVNEn4I5g7CS7tLdZWLpW8w0xA2stA1QuwpJfr+mWYmZ8aWtf9QcsSpJS1n9AmIGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727294040; c=relaxed/simple;
	bh=DoemBfODLc0dawppKg7pBI/hDNePdWLlFYwV99vZgeM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ejp9FBD37aLMHX1D5pXGEIDcK/+NvazgQN7coQDiTaQC3JgMosJmCgMfzgKkqNRaP71Wxls1VJXKLziZG6vxmr3KR+Sm94kaaDHsz2+R/mDZR9X8vqUHvC3onARHp6CLGzG8GyVwXjvP2MMjf6f91sF0IqOBBB47zFKjCdxYfxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B492B1576;
	Wed, 25 Sep 2024 12:54:27 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6BFFC3F64C;
	Wed, 25 Sep 2024 12:53:56 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 3/5] perf cpumap: Update CPU map merging test
Date: Wed, 25 Sep 2024 20:53:23 +0100
Message-Id: <20240925195325.426533-4-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240925195325.426533-1-leo.yan@arm.com>
References: <20240925195325.426533-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the semantics of perf_cpu_map__merge() have changed, the two
arguments will not been released automatically in the function.

Update the test to release all CPU maps.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/tests/cpumap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
index 2f0168b2a5a9..ed07ef6d7e33 100644
--- a/tools/perf/tests/cpumap.c
+++ b/tools/perf/tests/cpumap.c
@@ -166,6 +166,7 @@ static int test__cpu_map_merge(struct test_suite *test __maybe_unused, int subte
 	TEST_ASSERT_VAL("failed to merge map: bad nr", perf_cpu_map__nr(c) == 5);
 	cpu_map__snprint(c, buf, sizeof(buf));
 	TEST_ASSERT_VAL("failed to merge map: bad result", !strcmp(buf, "1-2,4-5,7"));
+	perf_cpu_map__put(a);
 	perf_cpu_map__put(b);
 	perf_cpu_map__put(c);
 	return 0;
-- 
2.34.1

