Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37E22B9BA;
	Fri,  5 Jun 2026 12:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780661736; cv=none; b=LWqbRPkrI2cX4/TWDmmYeR12RUd8kHWIwvbDDgvN2eXR5WiAzrqHxfGDiGDXSpCw1zc5SxvitZDVLx48CILphjMXVpA7p+5LcxP5ktyM4CVkS7afnbOW2+7kUGpgOi1dDLWhdG8K/kyYH9mkcLtJvXbhC1laFBHvvd0FQcegUW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780661736; c=relaxed/simple;
	bh=WUEkOw3pfnwRIHaep6MaTEoJAV7XUy6UEOuZbM88XO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r3KHLvcxLByRTB3RhQkJ4OdB0XNNWW+lTRxociEW4aE7z60XzvHVb4A33xlCVUTSG9O7ys6UHc4J4U8BFV+ICiCWWPw5E/drpxhmz+XHxBhH44DG9Owf+NHKs/37GuVfyFNvxhrlZ2pr2kA2Z1elu6sp3HBP4ekLLuc5hZCUKCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHIbIxLo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHIbIxLo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2E11F00893;
	Fri,  5 Jun 2026 12:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780661735;
	bh=J4DKtdsgMH/xkJGYr3nWsu2C2qlTNkAXDeNikNsk5L8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZHIbIxLofz9RhrQ1Rkdn53zo+SKMZTsnpp7AlEawM5gW9NWsUuqeqQ6YpPh7o0E5b
	 m2P4qGbEtjW5hMV1oDd+ApzFGwdU97lnmQlDuUjJRJWb7bsoa7h5UFEdYbnl4EgGnO
	 /gOYyLRBCJTqeiskQ2vWVWYwYwvOUjnN88j6uFSKAnS3bZIrXdq0FeHHDi2bfF67nu
	 Mcuyo0PPhbBfasP6xDXKbhRyd4PrxK8WCgs6ZPr44RvdC0gDXGFlYl7zROB0kU2nkV
	 Z3dtNuX5J2o+cfkEXqDXSv8EpjxDjoiwl/5Cj6ZoPplVM5dz0tATSwbAhVVTPfmtYJ
	 9TH63QFHFBcpQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 2/5] perf tools: Add bounds check to cpu__get_node()
Date: Fri,  5 Jun 2026 09:15:11 -0300
Message-ID: <20260605121515.1725549-3-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605121515.1725549-1-acme@kernel.org>
References: <20260605121515.1725549-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

cpu__get_node() accesses cpunode_map[cpu.cpu] without checking against
max_cpu_num, the allocation size of cpunode_map.  Callers such as
builtin-kmem.c:evsel__process_alloc_event() pass sample->cpu from
perf.data events, which may exceed the host's CPU count when analyzing
cross-machine recordings.

Add a bounds check against max_cpu_num before indexing, returning -1
for out-of-range values.  This is a central fix that protects all
callers.

Fixes: 86895b480a2f ("perf stat: Add --per-node agregation support")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cpumap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index b1e5c29c6e3ec8df..d3432622b2adc994 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -576,6 +576,10 @@ int cpu__get_node(struct perf_cpu cpu)
 		return -1;
 	}
 
+	/* cpunode_map allocated for max_cpu_num entries; input may be untrusted */
+	if (cpu.cpu < 0 || cpu.cpu >= max_cpu_num.cpu)
+		return -1;
+
 	return cpunode_map[cpu.cpu];
 }
 
-- 
2.54.0

