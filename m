Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD3B290F;
	Sun,  4 May 2025 19:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746387274; cv=none; b=JOcyLHlnd4njGgUSDsIhpYYc54N5Lkq1sWN9p3fC0voiC74K9+uVjXNtKt0L+2yj7BwyrcxFX9pqSmCLThgys3UaXJmVQ96XDAR5ZfI4lGpTFQFpTg6uPcq3rdypEmMMxuOk2kQr9InGlE6ODoesdRb+ikbcdgsIv2LA3ijQO8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746387274; c=relaxed/simple;
	bh=DV+C+ocx0IPJCvSxnWssBbag9ANT94rIE0gCr6WbnAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PEHpZ1//FixQXin6F7gpXfSinZw/0W4VALdmBNdHNutWdBSrAi+h1NPKumahf07y9+5t0ltZYokDPoZCU9j7QqgKxyzYPWd90oIS0tXxkQOk/rKtuY1u2y+irTNDrPRMVMlR0UYy6b1Xz4KyzrHYZPvtotqCFmzJrH75QGaoDgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QAleEZJt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QAleEZJt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F90C4CEE7;
	Sun,  4 May 2025 19:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746387273;
	bh=DV+C+ocx0IPJCvSxnWssBbag9ANT94rIE0gCr6WbnAM=;
	h=From:To:Cc:Subject:Date:From;
	b=QAleEZJt7jjqi+DLreJ362YU+9neFfpA9iBnA4l9SFXekbegBGesA7bDEqRHpXyZZ
	 WDzvtzyeNy9bzI9li2Isp+6BZ/KgiL7lrjdkNq6IDll3B0vK+5rgK5/L8ampQwjxqF
	 xcfmFAFRD1lEJSSsaSTn8rm+IBpvzjGIeqq5B9bjwt5ntA0wz9rD60SSBFE5uWWWCS
	 B2eLedm9VvYPDOqznYos4vMI0Vsd+HNEQ2/mks77J0PNmI2jX9HNi0/WY24UdsaabK
	 EDNiezzuMo+x9zZCMnHKSE0zMO2AfLfJVUH/ouqrbT4dZx9+L7k9/NAW30xA6AWcih
	 ZddmLa9OmEUuQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [GIT PULL] perf-tools fixes for v6.15-rc5
Date: Sun,  4 May 2025 12:34:28 -0700
Message-ID: <20250504193428.1295124-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please consider pulling the following changes in perf tools for v6.15.

Thanks,
Namhyung


The following changes since commit 9c32cda43eb78f78c73aee4aa344b777714e259b:

  Linux 6.15-rc3 (2025-04-20 13:43:47 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.15-2025-05-04

for you to fetch changes up to 8988c4b91945173a6b5505764915d470f0238fdc:

  perf tools: Fix in-source libperf build (2025-04-29 12:32:31 -0700)

----------------------------------------------------------------
perf tools fixes for v6.15-rc5

Just a couple of build fixes on ARM64.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>

----------------------------------------------------------------
James Clark (2):
      perf tools: Fix arm64 build by generating unistd_64.h
      perf tools: Fix in-source libperf build

 tools/lib/perf/Makefile    | 14 ++++++++++++--
 tools/perf/Makefile.config |  1 +
 2 files changed, 13 insertions(+), 2 deletions(-)
