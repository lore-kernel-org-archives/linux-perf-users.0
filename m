Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E4631F98F;
	Sun,  7 Jun 2026 23:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780875012; cv=none; b=lhiKsIc4MM1jALdqsiaZTkN/BbNoox4kjzDtodqO+GN/Oo7+0DDKYGBeN5kLJZr2wcuAeVG1jyV29AyBmWd2kq84L4m6wYuiiNXC5iPYJ1l/eugDdKTRXZ4MYwxdwJ51cADhv9i8LoWZr5YrVdCVXaE/GUdw9IH08wfSFslqjE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780875012; c=relaxed/simple;
	bh=HpQyWQ+UnFEqqpHy4QJpFYj93F/lyOC9DzS+oCAWqHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PMImPSYukM9rHaGPm6krceoxPKsnW2fJcg4B+FDPyrJhN0tP/ULjBqJrAv4sRtEtoG6+kgtjF2czpBA7wi8OkNQZ66k1Wq8HFCxIe09RaJdE5/4ZqzDGSCdvv/4GSNjOcCK2nAFYv9P5M4j4vlE//iMhfJKIMa/qDiF2Jzu7LQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UoCjyM3F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UoCjyM3F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A2A91F00893;
	Sun,  7 Jun 2026 23:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780875011;
	bh=f8CRcOiVG8vX1Rqqzs4HSfI/1uXARmOJjaKvMNmyGcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UoCjyM3FAgEzfBHlJd7PoWaNfxwGJ8P0XMDqBmWti670hzYptfrLjkRcBEb5R0Fn4
	 C/hJiR5C8Eh35Yvciz68LwaHNUCCn5pulA2BaBkBNf6tLTtUf6bQjGXaRUHn/cixOn
	 EcW63HW2LC68h00WeKHIFEZx0qblHfwNNsgjZ9SZJF5clQPvn4gRyEJyGcI9WcdMrB
	 j8B1TayK/141R9NTZVGV4Wj6RNXZDf2b+5majpbid6ZoTYIUMF6lKIVzHezPyRIiQ1
	 0fSaN5sIA0ive+29nZere1jCTUEpEzHr0i559xzcOb+t+3U84eYbYXCbBAwh72x2pX
	 KyjNecm3NMZbw==
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
Subject: [PATCH 06/11] perf sched: Bounds-check prio before test_bit() in timehist
Date: Sun,  7 Jun 2026 20:29:19 -0300
Message-ID: <20260607232925.1935819-7-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607232925.1935819-1-acme@kernel.org>
References: <20260607232925.1935819-1-acme@kernel.org>
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
 tools/lib/perf/TODO        | 7 +++++++
 tools/perf/builtin-sched.c | 4 +++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/lib/perf/TODO b/tools/lib/perf/TODO
index 486dd95dc57208a8..1a3644aa1f38dde4 100644
--- a/tools/lib/perf/TODO
+++ b/tools/lib/perf/TODO
@@ -11,6 +11,13 @@ together.
      (x86_64 max is 8192, arm64 is 4096), but NR_CPUS limits keep
      growing.  perf clamps to INT16_MAX in set_max_cpu_num() as a
      safety net.
+   - Code simplification: the int16_t forces defensive truncation
+     checks at every boundary where a wider CPU index (int from
+     sample->cpu, al->cpu, etc.) is narrowed into struct perf_cpu.
+     Without these checks, values > 32767 silently wrap to small
+     positive numbers, bypassing bounds validation.  Widening to int
+     eliminates this entire class of silent truncation bugs and
+     removes the need for the INT16_MAX clamp in set_max_cpu_num().
    - Scope: struct perf_cpu is embedded everywhere — perf_cpu_map__cpu(),
      perf_cpu_map__min(), perf_cpu_map__max(), perf_cpu_map__has(), the
      for_each_cpu macros, and all internal callers.  The perf_cpu_map
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 1ff01f03d2ad1ad3..5f3510f9ca249132 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2645,7 +2645,9 @@ static bool timehist_skip_sample(struct perf_sched *sched,
 		else if (evsel__name_is(sample->evsel, "sched:sched_switch"))
 			prio = perf_sample__intval(sample, "prev_prio");
 
-		if (prio != -1 && !test_bit(prio, sched->prio_bitmap)) {
+		/* prio comes from untrusted tracepoint data — skip invalid values */
+		if (prio < 0 || prio >= MAX_PRIO ||
+		    !test_bit(prio, sched->prio_bitmap)) {
 			rc = true;
 			sched->skipped_samples++;
 		}
-- 
2.54.0

