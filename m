Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87464854E5;
	Mon, 19 Oct 2026 05:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792389226; cv=none; b=EefHUqWkQ8MwgohiRue5PbWChvhNaE6rHD+KCdZSieqdUFq/04Z3JnsvhxtlRlNbS+aQlRxlupjDK32Vurh4LjGB9hq55lEixmtYgOE0IUwIcRiwAiE3avoUiaCi4BIeYxzASvT+nDhnjcA0xkh+/2VwoHD3Pjrt2WvPbNbnvAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792389226; c=relaxed/simple;
	bh=5aId3F6b0GAPzCpRxRvAfa27XALtGWwjTQhLXbYTqkE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X/GPEdl2X4MMJiRj60GmOW5nwTqdZZarS/H2hed66AF3365fb7eT2rObIdzup38xmawcun9xe6BkrNU7Tnqx6Dyq9PDMil0R+9TDRXy/vy4DrL4XT9ihe/eMa6Viy9+qElr2oam9aVp4gVuy18t1eianraM8dTAForPQE0VwujE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEPQoMbc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEPQoMbc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C809B1F000C9;
	Mon, 19 Oct 2026 05:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792389133;
	bh=6MnFLK/mAlYjyC1skyY/FpWzi4j/hD/otXoK13kY6Hk=;
	h=From:To:Cc:Subject:Date;
	b=bEPQoMbckDr2Ykw3HzgiEItACQx0G/NV3XtUd9pGIxh67GJM3gzVif6QiJICzAZdL
	 kPhJblwQP0Qb0MIDcd9IfJg4qMty49047Ubyznwb73XPQLBZX5+WpHzO0SnBOlwe43
	 XcYbsAvdoW2GtliNmdkbJyxgQOk7pvr6/yeC3AgW4WuC0o/4rjLG+mJcdjO4+dH0hD
	 DSqTUHsCCieB3Ok3VLfEpyPKmiVPPuI+csi55/KAloqOT09b51LaKQx0BsolZLin6T
	 zAMePS6u0dTX68ByilRkaH01CKtUBZIK8J42Og/7B0s+CJCinoQlpVxa6V2Hi5nAqQ
	 ei2ORMKVL9Aog==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 0/5] perf tools: Random fixes for the symbol code
Date: Sun, 18 Oct 2026 22:52:02 -0700
Message-ID: <20261019055207.39325-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

These are assorted random fixes found by Sashiko review during the last
perf dso/symbol code rework.

v2 changes)

 * add perf_env for completeness in the maps tests
 * convert to bfd_arch_bits_per_address for PE files

Thanks,
Namhyung


Namhyung Kim (5):
  perf test: Fix a memory leak in PE file parsing test
  perf test: Make sure maps to have a machine
  perf tools: Remove NULL check for maps__machine()
  perf symbol: Check result when reading section headers
  perf symbol: Ensure dso__set_is_64_bit() for libbfd

 tools/perf/tests/maps.c            | 30 +++++++++++++++++++++++++-----
 tools/perf/tests/pe-file-parsing.c | 13 ++++++++++---
 tools/perf/util/dlfilter.c         |  3 +--
 tools/perf/util/event.c            |  3 ---
 tools/perf/util/libbfd.c           |  1 +
 tools/perf/util/map.c              |  9 +++------
 tools/perf/util/python.c           |  2 +-
 tools/perf/util/symbol-elf.c       |  4 +++-
 8 files changed, 44 insertions(+), 21 deletions(-)

-- 
2.56.0

