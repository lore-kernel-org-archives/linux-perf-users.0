Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29582372;
	Mon, 17 Feb 2025 19:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739822362; cv=none; b=ledGFj/TMR583UHdJDyJ8mCEPu6DuMN+saePuZSXA13m3VC4aPMsJx87So3PPDz2tBUf6RovldZlkSaC6OzglQ02vREsrsjtoZrREdFIuB1GOa4UuedtqZvV8o77NyiLUoiB9NhRmUYhdCtvcnjWJmWTnQjuHXGdn/VRMgt3is4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739822362; c=relaxed/simple;
	bh=/FB9xW4xmGAuBydm8LSZD2N1F+Rk1w6CtwENqiaNurU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U72lZJg9DPnaQp2k4pwJONgKGqZZIeUJplb2SXgq1wisczuayfIb/fl6wXArwSAnxsqr3LgtMg5NO/E9Ij02fsIDO/FNSpDcST8pCecXHZ8rW27D02jLE1oE+gTsk3gpGjhXqb9hUT7z+Rpuswf+lmwQ6lUzY6gkfHwmzseXMlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A53E152B;
	Mon, 17 Feb 2025 11:59:37 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D3BA53F6A8;
	Mon, 17 Feb 2025 11:59:15 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Will Deacon <will@kernel.org>,
	Graham Woodward <graham.woodward@arm.com>,
	Paschalis.Mpeis@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v3 00/12] perf script: Refactor branch flags for Arm SPE
Date: Mon, 17 Feb 2025 19:58:56 +0000
Message-Id: <20250217195908.176207-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series refactors branch flags for support Arm SPE.  The patch
set is divided into two parts, the first part is for refactoring common
code and the second part is for enabling Arm SPE.

For refactoring branch flags, the sample flaghs are classified as branch
types and events.  A program branch type can be conditional branch,
function call, return or expection taken.  A branch event happens when
taking a branch.  This series combines branch types and the associated
events to present a sample flag.

The second part is to enable Arm SPE's sample flags for expressing
branch types and events, and support branch stack.

Patches 01 - 03 are to refactor branch types and branch events.
Patches 04, 05 extend to support not-taken event.

Patch 06 is to fix a bug for parsing ldst operations.  Without this fix,
the seqential changes will cause breaking for memory samples.

Patches 07 - 10 enables branch flags in Arm SPE.  This allows to print
out sample flags for samples.

Patch 11 supports branch stack for Arm SPE.  Patch 12 is an enhancement
for PBT feature.

Changes from v2:
- Added a new patch 06 for fixing the ldst operation bug (James).
- Added James' review tags (except the new added patch 06).
- Removed a wrong output result in the last patch's commit log.

Changes from v1:
- For patch 05, changed to append the 'not_taken' bit in the branch_flags.
  This can avoid altering bit layout and cause breakage.
- Added Ian's review tags.


Leo Yan (12):
  perf script: Make printing flags reliable
  perf script: Refactor sample_flags_to_name() function
  perf script: Separate events from branch types
  perf script: Add not taken event for branches
  perf script: Add not taken event for branch stack
  perf arm-spe: Fix load-store operation checking
  perf arm-spe: Extend branch operations
  perf arm-spe: Decode transactional event
  perf arm-spe: Fill branch operations and events to record
  perf arm-spe: Set sample flags with supplement info
  perf arm-spe: Add branch stack
  perf arm-spe: Support previous branch target (PBT) address

 tools/perf/builtin-script.c                   |  30 ++--
 .../util/arm-spe-decoder/arm-spe-decoder.c    |  23 ++-
 .../util/arm-spe-decoder/arm-spe-decoder.h    |  11 +-
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     |  14 +-
 .../arm-spe-decoder/arm-spe-pkt-decoder.h     |  12 +-
 tools/perf/util/arm-spe.c                     | 143 +++++++++++++++++-
 tools/perf/util/branch.h                      |   3 +-
 tools/perf/util/event.h                       |  12 +-
 tools/perf/util/trace-event-scripting.c       | 116 ++++++++++----
 tools/perf/util/trace-event.h                 |   2 +
 10 files changed, 314 insertions(+), 52 deletions(-)

-- 
2.34.1

