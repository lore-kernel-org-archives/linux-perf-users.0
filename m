Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B3521423C;
	Thu, 11 Dec 2025 22:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765491484; cv=none; b=NHZnE1fBD9CAc3CkKTlXijHRCTYXu1Hdnmf9NuTr2ffHsEUHic4/1NMU1mgweXDY0ots4sm3aJ9DxiXEDnGLrAlKndq+Af5N8u8HtG3eKcbaLBseSqzQkFSLp6i8dYcOkepA7gJ2ZBsNefOMVO8YjTm8N8VXlAdoH/KKKRklDuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765491484; c=relaxed/simple;
	bh=bglisfQ5M0p8P4TyhdFrFkNQ67lbuMp8yZ10K6coGH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fJ7h83BLy29FY0lxwD5erRAAgbKTJPTDdte4zIdnm2e4WcEv1SRCSVDJV4zeFGuCof/BU4o//G7igcWk8dFH7ru82Lpc3qJD+TA+zZG5ulbcI4M9sQQyTqFxRXwOASgHmGIuQkyDBLwh8lxLlFGcWK9f3uFhw5FIIMU0BhywySs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/gEthFo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/gEthFo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53EB5C19421;
	Thu, 11 Dec 2025 22:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765491484;
	bh=bglisfQ5M0p8P4TyhdFrFkNQ67lbuMp8yZ10K6coGH0=;
	h=From:To:Cc:Subject:Date:From;
	b=g/gEthFoG7ilCKacULtJE+h/D+JLUzY1KHSlA3jG5cRqk1kTWgGXdXL5FmBrJKrVX
	 ylXdNLJpuIozId7wqT+RbUW66XfgIlwkkmpPs5xpiryBtofa+oFDDfUJWTdbJLNA4T
	 Hokur0N7UdePKQZ3M6+FqOpYkLpfBS8CLLql91EVXp+0Qsn/5KGhpevslpZpj87T/K
	 quZxe/TUuLhpTQn/sNYQUy5Qll5qXmK6ZirFgAZk1txto691a94KVFgPeeRUDZ+Hvp
	 meXwp1tnBpYCnl+/FvuRXObHLA+qnUeta3Cts1WgKFo13q7Rk/+bg0hW7hTxj6qp0Q
	 KepSTpS6w2jXA==
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
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH perf-next 0/4] glibc str functions const return fixes
Date: Thu, 11 Dec 2025 19:17:52 -0300
Message-ID: <20251211221756.96294-1-acme@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

	While building with Fedora 44 I noticed so interesting warnings
about touching const memory, fix some of them in this series,

- Arnaldo

Arnaldo Carvalho de Melo (4):
  perf list: Remove unused 'sep' variable
  perf diff: Constify strchr() return variables
  perf tools: Use const for variables receiving str{str,r?chr}() returns
  perf trace: Don't change const char strings

 tools/perf/builtin-diff.c       | 12 +++++-------
 tools/perf/builtin-list.c       |  4 ++--
 tools/perf/builtin-trace.c      | 11 +++++++----
 tools/perf/jvmti/libjvmti.c     |  2 +-
 tools/perf/tests/parse-events.c |  4 ++--
 tools/perf/util/evlist.c        |  3 ++-
 6 files changed, 19 insertions(+), 17 deletions(-)

-- 
2.52.0

