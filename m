Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE4E1946C5;
	Mon, 17 Jun 2024 13:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718631874; cv=none; b=Z4H92YbyokF2KUklX2DMHZxfi+Vmd8ZjAlsBRCPNqZeOfpycWBvWWkszFSNmL8FDt1ZQlVE9/ITcmx4k2yL0nLEEOoyn2yQDwKq+DGMKDF03+iRjJOv89o15DW7bT+36vbJwSRGZc4NMUyHHLg+bOqq0X/al+qxnyBKwEMWAzcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718631874; c=relaxed/simple;
	bh=Kt2p9L055uS4d4mSNaB2fD/vpxF99FDXHqMlFtBwKyw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RQjZv03h7L8v5CLmKy0yMVnRrSypMsHae1pCX2B5/zmBGoA3p+damtY9kLP5bxGCMn/MfrplLmDZodET+FQdPX9CawvoUEfmTqfobFkC6E2+PdiZ1/07jFdBdRmJD5r2r1NpEmngjKZu2+AGAHW/+E7wgtkGpN1zI8w6g/IQa80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04BEDDA7;
	Mon, 17 Jun 2024 06:44:56 -0700 (PDT)
Received: from e127643.broadband (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 21A6D3F64C;
	Mon, 17 Jun 2024 06:44:27 -0700 (PDT)
From: James Clark <james.clark@arm.com>
To: linux-perf-users@vger.kernel.org,
	irogers@google.com,
	robin.murphy@arm.com
Cc: James Clark <james.clark@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] perf pmu: Event parsing and listing fixes
Date: Mon, 17 Jun 2024 14:43:43 +0100
Message-Id: <20240617134348.208241-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The second fix is related to the discussion here [1].

The first fix is unrelated but I just noticed it while fixing the
listing issue.

[1]: https://lore.kernel.org/all/ce31a50b-53db-4c6f-9cb1-242280b0951c@arm.com/

James Clark (2):
  perf pmu: Restore full PMU name wildcard support
  perf pmu: Don't de-duplicate core PMUs

 tools/perf/tests/pmu.c | 78 ++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/pmu.c  | 26 ++++++++++----
 2 files changed, 97 insertions(+), 7 deletions(-)

-- 
2.34.1

