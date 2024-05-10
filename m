Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A18148FE3;
	Fri, 10 May 2024 02:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715309266; cv=none; b=Xg71uwCh9k5jlvk3565fZRyM6sAaWUpe4gha4HE/pBWhH8ENIgGL9jLz17kPHabSgRFuHsa9LNLVX2ZTTDYEWMG6VkrgGrXg/+4rJn/sHsnGMjC76l1/kxqMK4W0MXMYspXaMIQpdzp6gy3hhizb9GApfEOwyjH8zdMOCXXnhNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715309266; c=relaxed/simple;
	bh=317oeRBx4Rum6zrlv0IJtX4WWwXaDaWmD1szVz3miaU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d10eue+JmtdpnK1QgVPihMShLXVgbzdh+cQzzL2sH/9L9jb/lcngSyGtobJAncYT2bdPk8rNjyIER6KtZGEH1oWKJVoTzyIuX1IOlcSMIUL53E5YfEV979zdm9jo61oXRFrvVrcp5xWzbKA07hDXjJD7gc6Rhba9p+JwR90uVyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3953C106F;
	Thu,  9 May 2024 19:48:08 -0700 (PDT)
Received: from entos-yitian-01.shanghai.arm.com (entos-yitian-01.shanghai.arm.com [10.169.206.117])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0E7703F762;
	Thu,  9 May 2024 19:47:38 -0700 (PDT)
From: Jia He <justin.he@arm.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@arm.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jia He <justin.he@arm.com>
Subject: [PATCH 0/2] Fix num_events calculation in lazy loading
Date: Fri, 10 May 2024 02:47:27 +0000
Message-Id: <20240510024729.1075732-1-justin.he@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I noticed "perf list" reported the error as follows on an Armv8 Neoverse
N2 server:
Unexpected event smmuv3_pmcg_3f062/smmuv3_pmcg_3f062/transaction//

The root cause is due to the incorrect calculation in
perf_pmu__num_events().

Jia He (2):
  perf pmu: Allow finishing loading json events when !events_table
  perf pmu: Fix num_events calculation

 tools/perf/util/pmu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.34.1

