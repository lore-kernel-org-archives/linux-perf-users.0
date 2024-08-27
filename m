Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795E01D2780;
	Tue, 27 Aug 2024 16:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724777515; cv=none; b=LgAMgLhjR9vywYb6b9UoiIQv7m+N3v1Ctka6y6772YGUZ3yvf9gn6tzmHs8YXAH/ft+Tr/07BLKPAWyukw7PPhgvkuH+Gvo5oNNr937K6sBRfN6rKcJIQZqeNgGdHG2wGe2oFCV7bsJ8P/f4jeJ4q74Ci/MQhsCUxVjy1wUfkno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724777515; c=relaxed/simple;
	bh=Kd/i2gZry2WEW8wv2NszqVqm1OqNe/FcH1Tf9M/w09M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KXRLZr5zzKOcb4JPZYxQxBc6ZEIavoyTgsAVBbPw/926mekwcErS0OG7/tea/1jBdiZ2D3LDhI5m/Ku2zwURAvaaFV7GwPYVtgFlQo0mo0zH7PZ/fJYbU19jap+8f9X+o6rjsJiHzJrXqMntBXTLMuicftz6uzizu8kq6XrK7E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17DC713D5;
	Tue, 27 Aug 2024 09:52:20 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D97E23F66E;
	Tue, 27 Aug 2024 09:51:51 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 5/7] perf arm-spe: Remove the unused 'midr' field
Date: Tue, 27 Aug 2024 17:51:23 +0100
Message-Id: <20240827165125.3311306-6-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827165125.3311306-1-leo.yan@arm.com>
References: <20240827165125.3311306-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'midr' field is replaced by the MIDR values stored in metadata (per
CPU wise). Remove the 'midr' field as it is no longer used.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 600b8b031539..f7bc39043a23 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -46,7 +46,6 @@ struct arm_spe {
 	u32				auxtrace_type;
 	struct perf_session		*session;
 	struct machine			*machine;
-	u64				midr;
 
 	struct perf_tsc_conversion	tc;
 
@@ -1409,8 +1408,6 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 	struct perf_record_auxtrace_info *auxtrace_info = &event->auxtrace_info;
 	size_t min_sz;
 	struct perf_record_time_conv *tc = &session->time_conv;
-	const char *cpuid = perf_env__cpuid(session->evlist->env);
-	u64 midr = strtol(cpuid, NULL, 16);
 	struct arm_spe *spe;
 	u64 *ptr = NULL;
 	u64 **metadata = NULL;
@@ -1467,7 +1464,6 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 	spe->session = session;
 	spe->machine = &session->machines.host; /* No kvm support */
 	spe->auxtrace_type = auxtrace_info->type;
-	spe->midr = midr;
 	spe->metadata = metadata;
 	spe->metadata_ver = metadata_ver;
 	spe->metadata_num_cpu = num_cpu;
-- 
2.34.1

