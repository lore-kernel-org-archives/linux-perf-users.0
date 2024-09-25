Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD626F305;
	Wed, 25 Sep 2024 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727270431; cv=none; b=OpZSyFhZ1CdFy++2MFsKg2haZS7EpJW7ZNmCYsjTwV25vJH6IjY2F/eOW1BIEdG9SfTZVupH6ab+V44ZK+AiXYuwEXHs9lAun1EpXAcFbt9QvMc+zqhOAy1Ob6pW8+O9X7WQXyGPO/jQRI8AQgnQNg2vjVfC1HN1AlHrV3ejJMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727270431; c=relaxed/simple;
	bh=yz2csuK2v8xHJsf/k6UwCYcezp5+d6uX82IxmF6QiOU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hy2Q7WdggC46oVP0BXHeAuMibJDxk2ufdVNjfGqZUFumLxUnSojJtMh8kBbr6SukyK4cUCHQ8D/p5hp735nKFoKbg0aWwQXsIQgAbN9QciOyPz+vAErS3JplWtrfI06iFv8lzNFHoM+Mvw2SZooLtYlSytxrUiomm4fS5v4QNLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B1ED150C;
	Wed, 25 Sep 2024 06:20:56 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 01FF13F64C;
	Wed, 25 Sep 2024 06:20:24 -0700 (PDT)
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
Subject: [PATCH v6 0/2] Minor fixes error handling of perf stat
Date: Wed, 25 Sep 2024 14:20:20 +0100
Message-Id: <20240925132022.2650180-1-yeoreum.yun@arm.com>
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
v6:
  - check cork_fd with >= 0

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

