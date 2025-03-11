Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83495360;
	Tue, 11 Mar 2025 00:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741651458; cv=none; b=kfBzDJR9TbeHpM0G6LY+Vks9SRPhGk5QYYcWcSl7N557sIck3g7ZcqB/j5g07dZ4IGcEHhHN7CyXce76RJsSbaF4qhuuj8LfV1Jj5VPYxqkq66dpTL0T5cGikvETSE6/0TyETQAbBi8GtR2Z3cwLxUz6MG0sZ1PUGAKeNs1lu40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741651458; c=relaxed/simple;
	bh=+V8XkjwMNZECAlP3eoWn4pmYdoCXLcxMDNGLphlTtoM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WgVDKkGOIXt58ShKukgrYSAhbnYPqR6qzmEp0vZhywI02+i4EUGKuMHS/rYdcMG5K7Qa3Qgrgdupym8KRKJD15YLoY/vFmkYaT8qrIagPMGPPU6phD5TJU4joXPO71qGExCTbldl3+yjSclsLRngJX2jnJ67v84emdUVOuPnm+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHX8JHDQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHX8JHDQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE1BC4CEE5;
	Tue, 11 Mar 2025 00:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741651457;
	bh=+V8XkjwMNZECAlP3eoWn4pmYdoCXLcxMDNGLphlTtoM=;
	h=From:To:Cc:Subject:Date:From;
	b=sHX8JHDQYj1uSZJPZXtKVaw9dZ0Hadn1yeoz9+8lJwjOXbVv1UP1s4i7jM25bmKXM
	 rqdD05Gm5nRtBkCm1+hOZzyNSRx3KZub084a+Wo47SmKKN8IskBsfq5L1TMGZ1Vwp/
	 hp+aXdHlZTQeAl/zHDCM8hfj750hw36pbLHt6aSG5IVZ77bsxlGL/ZU1ElkXZa3MJP
	 Xmvj82/TaHFrD5D0UBYCfcoVdK4F4SqS6zPHHC18txZZHq/n6nWDNnosM8Rw6qGrdo
	 TXUB7Y8sOeI3EauVJt4l/AgY2u3idJ+n2V3/2d7n2x05GbG52yJQQspYa6Z6rI2UXY
	 GBA/xIg65Y8jw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>
Subject: [PATCH] perf report: Fix a memory leak for perf_env on AMD
Date: Mon, 10 Mar 2025 17:04:16 -0700
Message-ID: <20250311000416.817631-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The env.pmu_mapping can be leaked when it reads data from a pipe on AMD.
For a pipe data, it reads the header data including pmu_mapping from
PERF_RECORD_HEADER_FEATURE runtime.  But it's already set in:

  perf_session__new()
    __perf_session__new()
      evlist__init_trace_event_sample_raw()
        evlist__has_amd_ibs()
          perf_env__nr_pmu_mappings()

Then it'll overwrite that when it processes the HEADER_FEATURE record.
Here's a report from address sanitizer.

  Direct leak of 2689 byte(s) in 1 object(s) allocated from:
    #0 0x7fed8f814596 in realloc ../../../../src/libsanitizer/lsan/lsan_interceptors.cpp:98
    #1 0x5595a7d416b1 in strbuf_grow util/strbuf.c:64
    #2 0x5595a7d414ef in strbuf_init util/strbuf.c:25
    #3 0x5595a7d0f4b7 in perf_env__read_pmu_mappings util/env.c:362
    #4 0x5595a7d12ab7 in perf_env__nr_pmu_mappings util/env.c:517
    #5 0x5595a7d89d2f in evlist__has_amd_ibs util/amd-sample-raw.c:315
    #6 0x5595a7d87fb2 in evlist__init_trace_event_sample_raw util/sample-raw.c:23
    #7 0x5595a7d7f893 in __perf_session__new util/session.c:179
    #8 0x5595a7b79572 in perf_session__new util/session.h:115
    #9 0x5595a7b7e9dc in cmd_report builtin-report.c:1603
    #10 0x5595a7c019eb in run_builtin perf.c:351
    #11 0x5595a7c01c92 in handle_internal_command perf.c:404
    #12 0x5595a7c01deb in run_argv perf.c:448
    #13 0x5595a7c02134 in main perf.c:556
    #14 0x7fed85833d67 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58

Let's free the existing pmu_mapping data if any.

Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/header.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 1900965f87527948..e3cdc3b7b4ab2409 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2770,6 +2770,8 @@ static int process_pmu_mappings(struct feat_fd *ff, void *data __maybe_unused)
 		free(name);
 		pmu_num--;
 	}
+	/* AMD may set it by evlist__has_amd_ibs() from perf_session__new() */
+	free(ff->ph->env.pmu_mappings);
 	ff->ph->env.pmu_mappings = strbuf_detach(&sb, NULL);
 	return 0;
 
-- 
2.49.0.rc0.332.g42c0ae87b1-goog

