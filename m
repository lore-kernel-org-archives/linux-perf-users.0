Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4F03EB7FD;
	Mon,  8 Jun 2026 20:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780949901; cv=none; b=LDDr5J2sHU9oPu6J0ZEARFFBmzelxiUhyv16YsM789guaY3qOaPolpunMKv2kM4uHWUZHtg5i+1qQTvjaApKnaieGg3jtl6ajwfK0BpM2Tmzi7bXh7JRb9amSGW4RuYjiLAKYz82DL/CYoOsHxukP0hzDu4Q95Wo1bCEa4d3YxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780949901; c=relaxed/simple;
	bh=uE/y55Y4wO9VpI0s7KbodScVan8Bdc0fQaM+gMPhY5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AFYVASw/kYNb3ksWBz0exXuB0+fwFr7G3x9tdTNL/nOL7bAJJqDvdofy53ZPajl1et/OKH7zFrIo936N1zqZZXkPSyKZNuSL4wMdpkAGez+Z6aMbgxia6O5iCFH1j9Q3BPuT3O3ipC77kZeDh7S3nMlD08mKyOZLY5IyGKC3OZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwzcYhrC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwzcYhrC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385A11F00898;
	Mon,  8 Jun 2026 20:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780949899;
	bh=T4MMV1Jcr0EJugKy/vIYVVm9jYSiXjL1itCdJjdxmSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MwzcYhrCBWqEntt0U+epJft5ZTpQYPHG3Z+lRRkyadjTmZ0SZi+BrA8zOrMCOQf2j
	 pK1NZuLMS2LxAC5ErRpZcPCdnlKiGKBHQCQG0+OrpdvF++A/RJWaQ0XRUzQIQlkDIa
	 a+gc2TF+XdkMXvzxAFbDk6l2P7XopQnS4hxrstPqTpv5NHk9lwmtGtSnebWz08LNmD
	 uYuknZRrfqpOXCyvrOJiAWSzZIuu4NXGtoqChNmquz65OKNBZVmmi0gz9nqfo1X7e0
	 7gjQCqS6V8cQFaS2sZOLjv1KlrO4saO7m6vi8iycgGDx+GGXJlSmHWW22cait5thaS
	 yQP6Ibf6nAMqQ==
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
Date: Mon,  8 Jun 2026 17:17:45 -0300
Message-ID: <20260608201753.1979464-6-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608201753.1979464-1-acme@kernel.org>
References: <20260608201753.1979464-1-acme@kernel.org>
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

