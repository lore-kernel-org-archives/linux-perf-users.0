Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E538D1A255C;
	Thu,  3 Jul 2025 01:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751507385; cv=none; b=XCiFOJy/o0r2xTuaQYfkjY9ifa80f3JXrnRjKlqYnjWrFC2Y/qNXQVH5CA9XEIyTIBJiyC4rS8iv04dZl47VHwSXwMyu+QbN2+RnhV1RhIZhh+uxy/KI1UzfpNSvodxdY4AVgXVnlM/uIRvO57vPdKv+39ccQkDkZchYD1zz2KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751507385; c=relaxed/simple;
	bh=tF5hq04ITDCTuA5/QUZgiNjxB2wr7fs/oP92CaOXSEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dvWUAIcz8DNsFWnVxZA0JyNGQpIw5fBHmpygzLtEBgWlJpeSjr9dQNFsrmHfn6QQqSQEH+88k5nrX3+/qcAsK9YdvcRgDUm7OJZSpsQ7d+KWBevIlE19WZG264C2+GMeW+a4h/hRNFQI1yzUQRXBdVx9SCQBszBar8JPfJFtuJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKXOnDRO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKXOnDRO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A55C4CEF0;
	Thu,  3 Jul 2025 01:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751507384;
	bh=tF5hq04ITDCTuA5/QUZgiNjxB2wr7fs/oP92CaOXSEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WKXOnDROfbEjWtUEfguclljF1Ll1Ud59MujWqY0kGvMdnFueJFoWvOKc6CLkLmC2+
	 +2L00ca7fzYrgXrpbN8HYJeI/BYMGoWJjd/JDit8CMKK2dGv97O5lfiz297MxwwB19
	 pwc85eWHB9YeVihCopWyhfydrvpRe2DNRYA9DYey+taA9Qo8fNxLDdu0m44RyKYmdP
	 eGXy5qDyrO4On9IaAdqLmz5TfplyhOhwxFUYCY1Kkf1sFW3C/v5CPN1cuHnKn8yAC8
	 4FYTMteVf2iv/nLW+eupuYVlLp1nC5qJM2uKSo7MRHk5y4vnbWXpwokTQ16gQZacoX
	 UtEy8kceWXP2w==
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
Subject: [PATCH 2/8] perf sched: Free thread->priv using priv_destructor
Date: Wed,  2 Jul 2025 18:49:36 -0700
Message-ID: <20250703014942.1369397-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250703014942.1369397-1-namhyung@kernel.org>
References: <20250703014942.1369397-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In many perf sched subcommand saves priv data structure in the thread
but it forgot to free them.  As it's an opaque type with 'void *', it
needs to register that knows how to free the data.  In this case, just
regular 'free()' is fine.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-sched.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index b7bbfad0ed600eee..fa4052e040201105 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3898,6 +3898,8 @@ int cmd_sched(int argc, const char **argv)
 	if (!argc)
 		usage_with_options(sched_usage, sched_options);
 
+	thread__set_priv_destructor(free);
+
 	/*
 	 * Aliased to 'perf script' for now:
 	 */
-- 
2.50.0.727.gbf7dc18ff4-goog

