Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC10E3D333B;
	Fri,  5 Jun 2026 23:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780702747; cv=none; b=p7vaGKoJo9tigyFQnbXpYWhJibvqeZREcWODtwv471ziA98mRERforbYnUbdWZhRqyUUTao5xO1IGvC4GDRWezGSTupjo4ccW4HctqbmzhQRRD8KDQPScxA/4AxQGaJ17ULO8VArG0idyjQwaqRZ5UdQsQVfkd4iZeBfTlJ56mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780702747; c=relaxed/simple;
	bh=wsh4JuGgIqUgiXKRo7BowkB0a41LNv4Yvy0huKtHVyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gR9kGNAS0lPmgoWJPBzpNK/QqnPSruajA7hAY1yBg1yRtzhZJjb4BnJk2qyGX5dBE6VEgOYblGsTfTnPfS3ExrApHYF11qhT4TsvfjMyNVyMFrSk++/VV4gUPNa4HF7JCMhQ8eZhkITd5GMbi1z7++Twy1Nr/Jutyu7HTZI/dL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIosFTEp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIosFTEp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 802F71F00893;
	Fri,  5 Jun 2026 23:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780702746;
	bh=K2oueR5mEBrYT6l9sk1hoSDKCiu+04BmUJFrhby1NZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kIosFTEpF+jYlDxQ7KOcgxyi8/gJOdbDe+qEiVtHgW277TtfhG0kAnNeGrCR1TLfq
	 COe0G9M0pT0XGWj9LwxXR90eJ5Gaf2NjJI3exxx95CCz77JFQSVpHkJlXQWZkbog7+
	 T1bPlQn9gPk/aBnKkVoItPH+mlBDPkdhthrxxiE93lmb6gBWL4IfGRQGDGuYWytrkN
	 uiiH5TOGIteZYaM3OuuhPladDtQpSYNfbyqF0mNNskLywDdPw7xOA1ifsg1EfuTO5T
	 7mea9h2FrBTyqTjLHJVOQ9oEBnPxU3L/T6u0HLPLDsR8RlJ2gr6wGsrXNWr/PT1Ldg
	 Ugo39Os5IwIOQ==
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
Subject: [PATCH 4/9] perf c2c: Bounds-check CPU IDs in setup_nodes() topology loop
Date: Fri,  5 Jun 2026 20:38:32 -0300
Message-ID: <20260605233837.1773732-5-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605233837.1773732-1-acme@kernel.org>
References: <20260605233837.1773732-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

setup_nodes() iterates CPU maps from the perf.data topology header and
uses cpu.cpu directly as an array index into cpu2node[] (allocated with
c2c.cpus_cnt = env->nr_cpus_avail entries) and __set_bit(cpu.cpu, set)
(bitmap also sized to c2c.cpus_cnt).

A crafted perf.data with topology CPU IDs exceeding nr_cpus_avail causes
out-of-bounds heap writes into both the cpu2node array and the per-node
bitmap.

Add a bounds check to skip CPU IDs that fall outside the valid range.

Fixes: 1e181b92a2da ("perf c2c report: Add 'node' sort key")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index f060dfbe11c285bf..cfc1ebe8c0af74dc 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2371,6 +2371,10 @@ static int setup_nodes(struct perf_session *session)
 		nodes[node] = set;
 
 		perf_cpu_map__for_each_cpu_skip_any(cpu, idx, map) {
+			/* topology CPU IDs from perf.data may exceed nr_cpus_avail */
+			if (cpu.cpu < 0 || cpu.cpu >= c2c.cpus_cnt)
+				continue;
+
 			__set_bit(cpu.cpu, set);
 
 			if (WARN_ONCE(cpu2node[cpu.cpu] != -1, "node/cpu topology bug"))
-- 
2.54.0

