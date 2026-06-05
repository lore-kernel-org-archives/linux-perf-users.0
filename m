Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33383B7769;
	Fri,  5 Jun 2026 20:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780691638; cv=none; b=koN/ypajMyvTay34LkU2Z8YL5klV39ZBKEjgMTU4MOJNlsF6WAGqrV0uFi7xzp3evQYV/mh9S/K5SadaR2eZOFM/6YpiKWuXd877ZPdTP5ESO1TP9xrKqEXoczgXR/LGKm1oZVyYuj4CiUwzrj4pxjf3s9nBKVs4QHgXfJVuI3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780691638; c=relaxed/simple;
	bh=Wmj909kKRpel5f3kMWhTPHtDbOoQDSXyGxEK4cvZGMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V26nfMIwo2bmPLDR5tonmYShzfz2yT1Jl4gf4Nhw4WjyV5I/Ml8r7N1aQxEXb1AipPhkGrMrdL3jUovXsyX6UA9TWn5r+LWEHl26sG5bC+U5xNvO6j50So/F8kp9SZtRA/WGNSY5AoAcoRAUYHNdv1+dQxYB8cst6cd4WjFgRiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFhQ/Zjl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFhQ/Zjl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DBA51F00893;
	Fri,  5 Jun 2026 20:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780691637;
	bh=AzHRciR+fZp4kINwoY3eSWSWvXjjxsj3wz+XPt8kJM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dFhQ/ZjlAK2mpc7EBjmReCsEhCSyPVdQM/KW/92DF9xsWGw7Sax8jeLKtTneEDybt
	 1e82pQvauF90I1NnHBSKhvWQM2qfuYSvUpW8pHsJixjBAcYi/Z8+C0p7sX0uUyzxbT
	 IB5zik7hVgdz7T+NmR2TlWmUHG05Xdh+oZ2hWct6hZMJNDd5kekO3E6blbMfPh7OC0
	 O9F6Cqre69csJcz/KU9hz7/GX1dQe2ILAal5sptfBlXfePOFoIJ5i7VjytwsDZCdHo
	 75pcMwy3Si1J2aPJfTqe0kMWYcT+PWRA9dCLrw/gBQki7XgMAJtkn9Y/tI3tqbdGqe
	 Dk897aOKsPPmA==
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
	David Ahern <dsahern@gmail.com>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 6/8] perf sched: Fix thread reference leak in idle hist processing
Date: Fri,  5 Jun 2026 17:33:14 -0300
Message-ID: <20260605203316.1758661-7-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605203316.1758661-1-acme@kernel.org>
References: <20260605203316.1758661-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

timehist_sched_change_event() sets itr->last_thread to NULL at the end
of idle hist processing without calling thread__put() first.  The
thread reference was acquired via thread__get() in timehist_get_thread()
(line 2581), so every idle context switch leaks a thread reference when
--idle-hist is active.

Use thread__zput() to properly release the reference before clearing
the pointer.

Fixes: 5d8f17fb5822 ("perf sched timehist: Add -I/--idle-hist option")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index e4378cc9ab3ed48b..af6322ffaaa6eb1d 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2934,7 +2934,7 @@ static int timehist_sched_change_event(const struct perf_tool *tool,
 			if (itr->cursor.nr)
 				callchain_append(&itr->callchain, &itr->cursor, t - tprev);
 
-			itr->last_thread = NULL;
+			thread__zput(itr->last_thread);
 		}
 
 		if (!sched->summary_only)
-- 
2.54.0

