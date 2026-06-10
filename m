Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E1032AAA0;
	Wed, 10 Jun 2026 16:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781110364; cv=none; b=shZGtYiGnGt7+NTPAfCcMswwLts+tB/yUgBhsDVQXR+kk91GTjujgd6UrtLaljnVtXsOSbmb7LRLuZswJcG36Lz3vbVWi41CbDN1k/STGszGa9UJw4ub1VS/VbYZ/fEpcIFSkHDZEOU3wSNHSaZV0cU6ZcPFovFV/dDB6Z3jGBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781110364; c=relaxed/simple;
	bh=gbgEmj5FnGqeb+jNcaD67i/sun09ZZMcr9X58zFNznI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cCHbPygsRALc9dmhY/nSoSX5EcOoOeVUNnYkkLnghqZrxy+WZFsJBA/pNo6no4rhthgO956rj9stBZvSZYxOj4YePEkvHAKRHIAhCWceEhK3zF9w79UrICL1THyv+lu5k8OZTnkWDRK1eQ/+FIgecIF7Y1dlWdNkeUVRGLRLFBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKP+Ss7w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKP+Ss7w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682111F00898;
	Wed, 10 Jun 2026 16:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781110363;
	bh=RuXvQfclts5+/mbpQrY7sM5dcxkV1xcc9yoYhr43l9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YKP+Ss7wZeH2IfHdmT3bDdda+iOsBJyMebsuKHQO7EZlT/5c9FR4jt8alIwwxIACn
	 rPoSsgjxsSgJWxK5q9ivpGk/ccipuaaS2NKuVIjroHAVyhJcDmbyhkCXddNgPykScb
	 Wv0k/5Kk+8bHvsMQ2EGk6LnptTgiRT2Bewnnf9dNXcmfnI+Z+lGgmP5pE28spKlMAa
	 Ok8ANrlDm0JQCDi9O+X71hNOY4ahcTZlvy67t6ETX33Oxt5NsDpkdpfgiq897L4+ob
	 jte+yq2WazLRghX8cFvwKsw1LhjX2gEoqis5OWNJQ/8BCvpSh3BSjM1vHkaNpDCZCB
	 sFrDRU1FUc+wA==
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
	Yang Jihong <yangjihong@bytedance.com>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 05/11] perf sched: Bounds-check prio before test_bit() in timehist
Date: Wed, 10 Jun 2026 13:51:59 -0300
Message-ID: <20260610165207.2077258-6-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610165207.2077258-1-acme@kernel.org>
References: <20260610165207.2077258-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

timehist_skip_sample() reads prio from untrusted tracepoint data via
perf_sample__intval(sample, "prev_prio") without bounds validation.
A crafted perf.data with prev_prio >= MAX_PRIO (140) causes test_bit()
to read past the end of the prio_bitmap, which is only MAX_PRIO bits.

Add a prio >= 0 && prio < MAX_PRIO check before the test_bit() call.
This also makes the != -1 sentinel check explicit as >= 0.

Fixes: 9b3a48bbe20d9692 ("perf sched timehist: Add --prio option")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Reviewed-by: Ian Rogers <irogers@google.com>
Cc: Yang Jihong <yangjihong@bytedance.com>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-sched.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 1ff01f03d2ad1ad3..ded511d8518803a0 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2645,7 +2645,9 @@ static bool timehist_skip_sample(struct perf_sched *sched,
 		else if (evsel__name_is(sample->evsel, "sched:sched_switch"))
 			prio = perf_sample__intval(sample, "prev_prio");
 
-		if (prio != -1 && !test_bit(prio, sched->prio_bitmap)) {
+		/* prio comes from untrusted tracepoint data — bounds-check before test_bit */
+		if (prio >= 0 &&
+		    (prio >= MAX_PRIO || !test_bit(prio, sched->prio_bitmap))) {
 			rc = true;
 			sched->skipped_samples++;
 		}
-- 
2.54.0

