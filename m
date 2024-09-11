Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C495A18454F;
	Wed, 11 Sep 2024 12:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726057166; cv=none; b=UrjNhNP2EZXYW0HW2lCEwCjIXqNuQCL7NbEZp+o3TGrLLrCEkE97zDoZmDyS335//0aXuKUy3NYwo7/L9WnraEMMrl2cElOO5izknlTDpzqfhHXIhttpybWtIBODjY++gOVoiDcC3lsihUdZmTdDSXcD8NAsa0sR4Pe4RICSlQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726057166; c=relaxed/simple;
	bh=+OwFnHjNQ9ghP66JWb7ErG9rfEmCVgN5NAIZSo2G5JU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ua9WlvJMFWq9WFhNvC4SZYj3NY6P1lraUpJUhTUj+YQf2FDfZ16QVmlnxe69CrQOPK9gn8JY3RoCka7BTsgku9SSfMjiQ1lHkQ7TC7crpJS7yIqizLqoXGnvFLkGsevoEG+NZL13E3YsyEtaHfcAa/KLaUrJ5ZNTVTyiokSsFY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 720FE1007;
	Wed, 11 Sep 2024 05:19:53 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CA9DB3F66E;
	Wed, 11 Sep 2024 05:19:21 -0700 (PDT)
From: Levi Yun <yeoreum.yun@arm.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	james.clark@linaro.org,
	irogers@google.com,
	asmadeus@codewreck.org
Cc: nd@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Levi Yun <yeoreum.yun@arm.com>
Subject: [PATCH RESEND 0/2] Minor fixes error handling of perf stat
Date: Wed, 11 Sep 2024 13:19:17 +0100
Message-Id: <20240911121919.4167483-1-yeoreum.yun@arm.com>
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


Levi Yun (2):
  perf stat: Close cork_fd when create_perf_stat_counter() failed
  perf stat: Stop repeating when ref_perf_stat() returns -1

 tools/perf/builtin-stat.c | 11 ++++++++++-
 tools/perf/util/evlist.c  | 14 +++++++++++++-
 tools/perf/util/evlist.h  |  1 +
 3 files changed, 24 insertions(+), 2 deletions(-)

--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

