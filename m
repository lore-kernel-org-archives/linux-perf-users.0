Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587791EE7B7;
	Mon,  8 Jun 2026 01:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780882312; cv=none; b=Ow5rXZPDVAf1f2zB8+xqc97Zvy7sEbuMzoCZ/k6coN4KaMvM3p4GDVVimeE9msiem4HRHFow5O5AnmugyRFQ7HcaNGJlwk8oLY8ufpRbO5Yu6kVpSbthFHLdFR5DMa7CD/VArAv4KwNGPjHBbYqGxskUPKXTAbRCt+vW5gB4r3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780882312; c=relaxed/simple;
	bh=qhpSzTUfr2WSNk9SxgeFUVJPjncBg9uJYUKWVkl83uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L+ePVUrEH1O/UkJ8A7Nz77b91goPIZFUDgtGNWG0fuXgGQN7G6Wa2c5MsI/1Q2RYyfyShxRzXxGIRP8UhzUOds0cMTHIjTtNl7q8lT+R3nqndlHS/cgmiVeNtEOzWdaUjLT7yCHDCxNQJeWIMR9s1c+bo2Wt8Tq68xhYULnPrwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtJJ1A4q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtJJ1A4q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10C41F00893;
	Mon,  8 Jun 2026 01:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780882310;
	bh=icuMweHg4yiYHwVQmznZP7hOig5bW5Sk7HaFwrdrijw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PtJJ1A4qLDfI6wvyGHd/qwlDbv01ogCD3tenIb7o/sbH7O7ftx1UEMzRZvkjq//9d
	 FKykZhaVZhQ6ITAWyRskIWBH9+RAhSwuhTUuw1tvmPmti5re/+ACLRGeOWUBPJ3WAy
	 RgX4YP2kc/cpUtXeJp7DoKC4wzRh7YoBAuunBObxwtneWVh/dJo7oI1j16MHiMlBPV
	 o6FQ7G9qhkV+DqBzEs6P5UOYIr5XXAf+Pg+VcUPJfxHA9Xz8Xret0UNVY/I9EzGZb4
	 hn8wQVFazsWWkf4l07PW1RbByy0OrY2BNxrgc8UHCxVsj4hAJ2mqbeEpys+uhDaBkf
	 OmEHeme01r+VA==
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
Date: Sun,  7 Jun 2026 22:30:50 -0300
Message-ID: <20260608013057.1942953-7-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608013057.1942953-1-acme@kernel.org>
References: <20260608013057.1942953-1-acme@kernel.org>
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

