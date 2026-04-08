Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC763D3D06;
	Wed,  8 Apr 2026 17:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775669367; cv=none; b=pN2LvhsKsDQ/XBOxGJK+khsOT0Gl7kcj9zA6okPVhoXqk+Q9TPgxMYRlLDm8JIEo1BgXEbYRvydYPrUixvB6FHeaBkn9ijyg815SKtpipcY4+AzZapcQp2CCkBCi5980vZGYcJYztclXBIvheMZtx00RoGpR6jjvCXvheI66n2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775669367; c=relaxed/simple;
	bh=orlL54mCmEorzqNfVbLNSd1ScbzcBuEP0XD1vjtyr4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XuaJ+jLnGaGGmU3jXsIa5Byu5XPA7QfX9g8NlOXJC+ueMgGeFBiyoa+ptju1uF6X7nDJnhLbkeTJ737lzNZL4ymHuS+lkjeAjITsjA1Q4gXfc7ZoLPxGOCYE4SP1r8rL4kIzsISJFA8/bsJSpKXYxDSNutaNfC6xpeP6XotQkCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0tp3CbH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0tp3CbH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963DDC19421;
	Wed,  8 Apr 2026 17:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775669366;
	bh=orlL54mCmEorzqNfVbLNSd1ScbzcBuEP0XD1vjtyr4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p0tp3CbHvp+xViPdx9pBSlGI3r4M65h7VwH9xJCzxwYjjsvz0lE0/qbUzHOoF9e7M
	 2kYGknaahzszA4YvAauyFBa5EhyDsGIKUeW+KfS/KqoHdv4GGP73SyGbcraOmD2Ups
	 bFD0RSs1Wydgi1q6sdUtsS9K8gnmvj4x2qflt8xkj4/I9c5grfHvOgzuYUke2cR3pb
	 C6sLBOBCOBC2Zm+BLWnCKcU35sS8OHwxXceHtlkcytKgweYyYBGVJv4HPyyl4kab6f
	 X+kUNSeefB/sfraokoNj85NBmbc2Q+X9OTipKz/eCetCJbRiufTjyDrn9ESNW0D4eb
	 cxUA5/js0dpCw==
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
Subject: [PATCH 6/8] perf header: Do validation of perf.data HEADER_CPU_DOMAIN_INFO
Date: Wed,  8 Apr 2026 14:28:44 -0300
Message-ID: <20260408172846.96360-7-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408172846.96360-1-acme@kernel.org>
References: <20260408172846.96360-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

As suggested in an unrelated sashiko review:

  https://sashiko.dev/#/patchset/20260407195145.2372104-1-acme%40kernel.org

"
Could a malformed perf.data file provide out-of-bounds values for cpu and
domain?
These variables are read directly from the file and used as indices for
cd_map and cd_map[cpu]->domains without any validation against
env->nr_cpus_avail or max_sched_domains.
Similar to the issue above, this is an existing lack of validation that
becomes apparent when looking at the allocation boundaries.
"

Validate it.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index a18f216f77c27430..4925e33778b91313 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3717,6 +3717,11 @@ static int process_cpu_domain_info(struct feat_fd *ff, void *data __maybe_unused
 		if (do_read_u32(ff, &cpu))
 			return -1;
 
+		if (cpu >= nra) {
+			pr_err("Invalid HEADER_CPU_DOMAIN_INFO: cpu %d >= nr_cpus_avail (%d)\n", cpu, nra);
+			return -1;
+		}
+
 		cd_map[cpu] = zalloc(sizeof(*cd_map[cpu]));
 		if (!cd_map[cpu])
 			return -1;
@@ -3736,6 +3741,12 @@ static int process_cpu_domain_info(struct feat_fd *ff, void *data __maybe_unused
 			if (do_read_u32(ff, &domain))
 				return -1;
 
+			if (domain >= max_sched_domains) {
+				pr_err("Invalid HEADER_CPU_DOMAIN_INFO: domain %d >= max_sched_domains (%d)\n",
+				       domain, max_sched_domains);
+				return -1;
+			}
+
 			d_info = zalloc(sizeof(*d_info));
 			if (!d_info)
 				return -1;
-- 
2.53.0

