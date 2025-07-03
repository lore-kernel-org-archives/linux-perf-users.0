Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B4D372;
	Thu,  3 Jul 2025 01:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751507383; cv=none; b=fZe+1hGsOMhZGbbETr7uB5jdUpN9mK/ItFu4JN+hcGEkT2qaD04hoI06OW/4eZ1ulr0ZUnSk482Mtk7VugARiiBRavc/deyWTmUEksUKshtKLMplBj4AKmoSOpVs4O65nkioOuwkobGAqA8d927CTPIZHuBYEP7JDtLM/1xSEjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751507383; c=relaxed/simple;
	bh=cxMgjOrSVmz0Kezmos+F09bpBrgtNx3UL8/GPad7cbw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N1fJvh6fdb3Qh8fgNsrhJC8q7HPFF4M9cS/7fvsifEt3EsUl4xmYDVtBRHlZCSxnlWV2XhzP6mLiMZ2AYRSr27dpcUZkyajmlQvT5+XJ8zTpntl/0XEUuU2IFh0eIFkxoO5ykC1bs8F0Eg6wuvYoNq3+eb9/gNoV4nMEmfEyMko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvLFguuw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvLFguuw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B01C4CEE7;
	Thu,  3 Jul 2025 01:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751507383;
	bh=cxMgjOrSVmz0Kezmos+F09bpBrgtNx3UL8/GPad7cbw=;
	h=From:To:Cc:Subject:Date:From;
	b=gvLFguuwBY9ywUUqoxdKyHeR0LQdSC/oiFLvxV7IisWNbjW83TyEwATcKKxJ1T7Pu
	 YiUwiyHgqwx5RsR+J38A15j4Yo02PGRuF6C7BpiwvrGj3vGFAXW1lmszh8cAiJQTSt
	 H5wj25gfZbNvYdtQgCum9bFtAvn4fmc0QwUMU7UUvKVyg8VAGdcz02q+93PiFY9OXb
	 RomvRE5t2bSZd0CSqQBTLPsHzCheRKUjV9sCetlC7KrC+Ak/1gyaDUPEIsnKImB1MB
	 rBvHS7Sm6G0Aj+Xl19rhAcIsC02+oIUibs0jRXte4Ig2f5dKSQRG+FpF6nVZXw2mXc
	 JvcUkhF7/EBiA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCHSET 0/8] perf sched: Fix various memory leaks
Date: Wed,  2 Jul 2025 18:49:34 -0700
Message-ID: <20250703014942.1369397-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

While running the new perf sched test with ASAN, it fails due to
memory leaks.  They comes mostly from missing thread__put() but
sometimes it needs to release other data structures.

Fix those leaks and add more subcommands to the test.

Thanks,
Namhyung


Namhyung Kim (8):
  perf sched: Make sure it frees the usage string
  perf sched: Free thread->priv using priv_destructor
  perf sched: Fix memory leaks in 'perf sched map'
  perf sched: Fix thread leaks in 'perf sched timehist'
  perf sched: Fix memory leaks for evsel->priv in timehist
  perf sched: Use RC_CHK_EQUAL() to compare pointers
  perf sched: Fix memory leaks in 'perf sched latency'
  perf test: Add more test cases to sched test

 tools/perf/builtin-sched.c      | 147 +++++++++++++++++++++++---------
 tools/perf/tests/shell/sched.sh |  39 +++++++--
 tools/perf/util/evsel.c         |  11 +++
 tools/perf/util/evsel.h         |   2 +
 4 files changed, 153 insertions(+), 46 deletions(-)

-- 
2.50.0.727.gbf7dc18ff4-goog

