Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E33937EFF0;
	Tue, 23 Jun 2026 19:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782242081; cv=none; b=nZshOzjzxe14KEumO9qBTZij613XDaSQRdn2PkyUUIy6BpKxTTrR7k421gbH/siIdQ+jhoNZSuxVhU6EEvoYACKWVfdivPWrRoDh8MqFA46sX4+BLu9p1/R1FAtHpshBILHTTfsPLUcm9Nfen+AfDYjpowScK3z6O3aBRj1+RBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782242081; c=relaxed/simple;
	bh=FoVP1UwMcXlE0UIF6gca1UPFATEm+SlEMGysoAJQF0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dqv/whKmRge5vdQ+xJo28ioTLcJMqurWOxGjaw2bTIFfVZkRDpyAb4t1BgPHNDPaJq1l6z4/zwbEW9mC5K8l3J4KLpPv3krweYsIGLBw2dkHNslTyuWb24CYbzUf1zvDrAiVt7FonRoXYuzDwCukXm+Nk0CI4jc1DsfTkPHodFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mw64nJjj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mw64nJjj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B521F000E9;
	Tue, 23 Jun 2026 19:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782242079;
	bh=rZdu3atYldYl4B/1KS5FOhURk2QVdugDNKl+H+ryrRw=;
	h=From:To:Cc:Subject:Date;
	b=mw64nJjjuCNI+xAtDCVNkv8LBJnAxOL5wt9dz70+2DAZVzgnFgZgxfrr8eLz1oL4T
	 XoRVoIc6X9Swe3qYP5+JlgY3cjnixGpfkCx1TKy51/7T9H8RlXfCWfWMGomuQzjerX
	 IM/WJOtEUrA7B40CbMp33+TeclORL/D/lhuOfbNNdXwXu5ELmf4Uu+QU0x3nv+tbZU
	 dZoprp8S01TqsheSeoREWTD4JlgPdDSxXMlZRUyXMM1KRQFnY1Gqzey8FylN40q4C2
	 QgvKwjvAo8b4CBMDL03QC+ENb0F1V2pwBh9B5k/8HsIJJxV01CuT14T9UREIwx+e8z
	 HGP8i7Y6w/OnA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 0/6] perf kvm: A small update in the default arch event
Date: Tue, 23 Jun 2026 12:14:33 -0700
Message-ID: <20260623191439.3621593-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Ian said there's an issue in the perf kvm record command line option parsing.
This is my attempt to address the issue, simplify the code and fix memory leaks.

v2 changes)
 * handle kvm top subcommand  (Sashiko)
 * handle other arch/condition for the default events  (Sashiko)
 * add <stdlib.h> for musl compatibility  (Sashiko)
 * fix some memory leaks

Thanks,
Namhyung


Namhyung Kim (6):
  perf kvm: Factor out kvm_need_default_arch_event()
  perf kvm: Check kvm_need_default_arch_event() early
  perf kvm: Kill STRDUP_FAIL_EXIT()
  perf kvm: Do not copy filename string
  perf kvm: Fix a memory leak in the usage string
  perf test: Simplify perf kvm record/report tests

 tools/perf/builtin-kvm.c                      | 105 ++++++++----------
 tools/perf/tests/shell/kvm.sh                 |   8 +-
 .../util/kvm-stat-arch/kvm-stat-powerpc.c     |  31 +-----
 tools/perf/util/kvm-stat-arch/kvm-stat-x86.c  |  37 +-----
 tools/perf/util/kvm-stat.c                    |  41 +++++++
 tools/perf/util/kvm-stat.h                    |  18 ++-
 6 files changed, 109 insertions(+), 131 deletions(-)

-- 
2.55.0.rc0.799.gd6f94ed593-goog

