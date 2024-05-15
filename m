Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D8C1581E2;
	Wed, 15 May 2024 21:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715807468; cv=none; b=cGHTUBSFDUyG+JQRAqP6mtrN3xJHaGXSYl/Bq8LtFidgQ1wDjMdEBuDKgZBUtLhba/E8HFF1C87E2F3D1lGQMSJqV2awh8Y1t5bO1OJY6JnY1gWvOMzX05fo8S8ddm/bfyppC+PqABCEP6zEwtCtu6Z5b94Gbb2/spWg7EIz5cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715807468; c=relaxed/simple;
	bh=cLwxtMm8r2GhQ994afjM2kPtSmB+IUYXXOxywWbJ1Ok=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=udWXs9NHiXcABz5HQFjb1jO/IRrrqGS+Qtn7rBE4fLQtoitEpOH7ltY2H5s9yE1OOZBfKEJGtRGvX4go3omC39HPcJqkKpExfkngnw5bl2A/3Cd/FO/JtX2BQ273/h54sYysf0P7EQmP2rSWlLBOYZOPrOve9aRYTDNkoHZHgy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81FF8DA7;
	Wed, 15 May 2024 14:11:28 -0700 (PDT)
Received: from PF4Q20KV.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E21F93F7A6;
	Wed, 15 May 2024 14:11:00 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2 0/2] perf maps: Improve the kcore maps merging
Date: Wed, 15 May 2024 22:10:43 +0100
Message-Id: <20240515211045.377080-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series follows up on the patch [1] to improve the sorting and
merging of kcore maps.

Since the kcore maps are not sorted, merging them into the kernel maps
causes difficulty, e.g. some kcore maps might be ignored. This is why
the dso__load_kcore() function handles the kernel text section
particularly for replacement a complete kernel section.

This patch sorts the kcore maps and ensures the subset region is placed
ahead of the superset region in the list. With this change, merging
these maps becomes easier - no need the special handling for the kernel
text section.

This patch series is based on the latest acme's perf-tool-next branch
and tested on Arm64 Hikey960 board.

[1] https://lore.kernel.org/linux-perf-users/438f8725-ef3f-462f-90e2-840cab478ee5@arm.com/T/#m7c86a69d43103cd0cb446b0993e47c36df0f40f2

Leo Yan (2):
  perf maps: Sort kcore maps
  perf maps: Remove the replacement of kernel map

 tools/perf/util/symbol.c | 117 +++++++++++++++++++--------------------
 1 file changed, 57 insertions(+), 60 deletions(-)

-- 
2.34.1

