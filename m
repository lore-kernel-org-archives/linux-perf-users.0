Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B82335A5;
	Wed, 25 Sep 2024 11:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727262499; cv=none; b=FxiFfNqcl5IsLt3bU2Setwktd8KRyR4xx60z1Xd5qOKayo7ir/3JxwYPWPshCaagmf3aTjP3hYyxtQVUp0RXtOqt3eYNXdqxeAkITOxffPMvn7C5gfeklR0ezHC98vaHfDFpHxV166bb7leQ0OSKFXLwg6lgVD1WcshUBK6DbqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727262499; c=relaxed/simple;
	bh=qPpS8JaDrI2BiJpimLrTOCzQqjYvaKA8HdYzyMyJU7c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XqA3SMEdb5sywBwDT1eDg1GS9RavYGsquqQwrBm5UY6CMvMNt0McqyZmiMwboHIttkpBRWWF9T0gRGhRZyAeHO23xbe13CQgFK87ExhSqzgBw2NTgRQh2WlU9qTY30oMVD8iCTn2oAqcKmPf0qtmp2nmfiz0RBng4PZDTuqHGCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A116F12FC;
	Wed, 25 Sep 2024 04:08:40 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 525C73F6A8;
	Wed, 25 Sep 2024 04:08:09 -0700 (PDT)
From: Levi Yun <yeoreum.yun@arm.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	howardchu95@gmail.com
Cc: nd@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Levi Yun <yeoreum.yun@arm.com>
Subject: [PATCH v5 0/2] Minor fixes error handling of perf stat
Date: Wed, 25 Sep 2024 12:08:00 +0100
Message-Id: <20240925110802.2620613-1-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset fixes two issues that were seen when running
  "perf stat -r" with perf_event_paranoid=3

   1. failed with Too many open files.
     $ perf stat -r 1044 -- false
     ...
     failed to create 'go' pipe: Too many open files
     failed to prepare workload: Too many open files
     ...

   2. repating error message
     $ perf stat -r 1044 -- false
     Error:
     Access to performance monitoring and observability operations is limited.
     ...
     (repating with same error message 1044 times).
v5:
  - add error handling label.

v4:
  - Move comments to run_perf_stat().

v3:
  - Fix comments.

v2:
  - Add some comments.

Levi Yun (2):
  perf stat: Close cork_fd when create_perf_stat_counter() failed
  perf stat: Stop repeating when ref_perf_stat() returns -1

 tools/perf/builtin-stat.c | 11 ++++++++++-
 tools/perf/util/evlist.c  | 14 +++++++++++++-
 tools/perf/util/evlist.h  |  1 +
 3 files changed, 24 insertions(+), 2 deletions(-)

--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

