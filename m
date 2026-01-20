Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BC73A4ACB;
	Tue, 20 Jan 2026 22:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768947077; cv=none; b=ez6A37tXMwKuGa9Ipyv2LybBEcNkNc5jBjaqp1dk676aqf5XdN4HKFs2os4Cx+k1RgCp6Y354z6ffkToEgvXNF2cb4BmsG1mGeY1M52L6Nf7XC11cPUmMp3IvKlbQZrNJlijy119q6VnN5ilgCdZnD3OQTLfkbuvqsN7ezbqexg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768947077; c=relaxed/simple;
	bh=O/k3DVs0BGaLNR34AKBzHjFKzvWiuY34s1jVP7TTY0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lUXO/keBWLnRGOmsZjblKmp1OCctpyGrf/AKuVfAebFDwM7qD/iRSwIr9fIIdeczPhDSRHdqRyeL5XBxFX16aKtMef26VZcYSKKUM4ZbsYFbmcYJc9uYvUtOnc/IDj5QZAOTRz5QmvTNG1JhkbpKGvToLNBmG5mwGVaDOb19cZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXDIIxPS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXDIIxPS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A60C16AAE;
	Tue, 20 Jan 2026 22:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768947074;
	bh=O/k3DVs0BGaLNR34AKBzHjFKzvWiuY34s1jVP7TTY0M=;
	h=From:To:Cc:Subject:Date:From;
	b=DXDIIxPShHohLoiaEPSs8Z/+3OxvxEw7pftT+I2byUCCszQI781GLe4PqXXhaVF+g
	 agu6rXwsGZ3LCLTqjuR1k25MAld3crUhRXs7h4Lox0qiLA4QYSp/VLkx/vxWxeLI9P
	 7lmgF27AhIZ2zBa/msu0/vur7505ImihtyJu9yVrr0tS0hVQIDmZIY3FADhNLej24z
	 NXew0QSnu8zMwm93Nc/gVRk0FfRTUGevBj9QfWxIXJARaDf49PI0GbP9ScTuKnyecn
	 mXDQVNo7ZcQzY3ou6bQN7FjFe0K9jrG9evreDubeGD8YUUBdmiAOlCBcOmhFouue7/
	 2vBE7B1v7+jmA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 0/4] Fixes for gcc 16.0.1
Date: Tue, 20 Jan 2026 19:08:56 -0300
Message-ID: <20260120220900.366451-1-acme@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Hi,

	A bunch of fixes for recent gcc versions,

- Arnaldo

Arnaldo Carvalho de Melo (4):
  perf tests sw-clock: Mark the volatile tmp variable as __maybe_unused
  perf trace: Deal with compiler const checks
  perf list: Don't write to const memory
  perf list: Signal changing const memory is ok

 tools/perf/builtin-trace.c     |  2 +-
 tools/perf/tests/sw-clock.c    |  3 ++-
 tools/perf/util/print-events.c | 15 ++++++---------
 3 files changed, 9 insertions(+), 11 deletions(-)

-- 
2.52.0

