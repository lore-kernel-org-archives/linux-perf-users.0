Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B13413D518;
	Wed, 27 Nov 2024 21:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732742816; cv=none; b=Yt8wZ3HdGkYZQswafN5e5h1YeIyo4lfV7zAlrci+fen3L38sk+j+nXYyugWBq99QWNQYYtXOYj1jCbS2hP5/Lzj8OrsvbpawREFvwgXmN2azLfgngud4PrSVtjyL0Sl1b6nMLdqX2tmoAA78rA8sVaKFrfJflr1Z9BNlYgkfPEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732742816; c=relaxed/simple;
	bh=jbC/jCJS+84tqIbSsE35AlGW1kuXaj5wEHCWYqF4OVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lTZY0Z0x5SMN/9rpoEB6QJleI9UqHPPmt/6Uu/QO9PbBnm1t9/msWsCGVsNvUZV3rjhVlHcqgaWlIQ2cHeotuiNn5qiFde1pP3HxuVG64jLRI0s/OmyQuMJ3xhfvio7t24oZfMm3TQijILGdPxex9lPzGsBnasci0VPKiVvJI4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAnwYckq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAnwYckq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E41EDC4CECC;
	Wed, 27 Nov 2024 21:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732742816;
	bh=jbC/jCJS+84tqIbSsE35AlGW1kuXaj5wEHCWYqF4OVk=;
	h=From:To:Cc:Subject:Date:From;
	b=VAnwYckq/SXsefbJ3d64IEic5tkRfSJA3lNI30aXFTdXyH3sZqHxjB4LspcqTUVy3
	 sp9uZiSnqkIGnB6XfOaGtXWmVjLDt+JeNnmb4HbCTGhjocCg86VA0UPrSreC+X+Uzi
	 3KVXK8CMLOd+RVk9Sez8pzPcPUrtBVA6qGDqNZr7OvUKiFYkr5G6jI1bBATF69dNJO
	 lcGQNV+3vWiFL/4BRmOQINU4wR9euzXGDaVBmcF0ILnom+C1KPFdjDI1mTs+J4aLCa
	 iRasUFtaJr8ZkopmAQppaLWlVDfrbMGdnqS2RqCYE22mM7p+kM1aEPP4trydxfVsyB
	 /KuEKekVKG0sQ==
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
Subject: [PATCH] perf tools: Avoid unaligned pointer operations
Date: Wed, 27 Nov 2024 13:26:55 -0800
Message-ID: <20241127212655.922196-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sample data is 64-bit aligned basically but raw data starts with
32-bit length field and data follows.  In perf_event__synthesize_sample
it treats the sample data as a 64-bit array.  And it needs some trick
to update the raw data properly.

But it seems some compilers are not happy with this and the program dies
siliently.  I found the sample parsing test failed without any messages
on affected systems.

Let's update the code to use a 32-bit pointer directly and make sure the
result is 64-bit aligned again.  No functional changes intended.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/synthetic-events.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index a58444c4aed1f1ea..385383ef6cf1edaf 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1686,12 +1686,16 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_fo
 	}
 
 	if (type & PERF_SAMPLE_RAW) {
-		u.val32[0] = sample->raw_size;
-		*array = u.val64;
-		array = (void *)array + sizeof(u32);
+		u32 *array32 = (void *)array;
+
+		*array32 = sample->raw_size;
+		array32++;
+
+		memcpy(array32, sample->raw_data, sample->raw_size);
+		array = (void *)(array32 + (sample->raw_size / sizeof(u32)));
 
-		memcpy(array, sample->raw_data, sample->raw_size);
-		array = (void *)array + sample->raw_size;
+		/* make sure the array is 64-bit aligned */
+		BUG_ON(((long)array) / sizeof(u64));
 	}
 
 	if (type & PERF_SAMPLE_BRANCH_STACK) {
-- 
2.47.0.338.g60cca15819-goog

