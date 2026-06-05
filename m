Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DDC3C1F24;
	Fri,  5 Jun 2026 23:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780702753; cv=none; b=cw4p5sbKy6Bqixc7TV5yIhhxPu6gPxHGBuSFH9y9qiD6eCDtkwfmlE6xpGccrulMpeJ+QTyalXa6N66YIwiVeLSuczyuDFkKMv4Z93HGaThFMmJlmtFKurlwmDYt+65OU2M2sYo2x3gTEy976fsZjt/IuUYVqzCrpnFis/ravl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780702753; c=relaxed/simple;
	bh=uhxftI9WmsUrBDfnoqZy0tuVYE1n1UQaoDsc0yoOhJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XaAXAvitsvxcD/Ks+PZ5E6oyYZCfUsCw7r4i4MmUuQ1/RixXXTIIetQhwKCXfCgmbzBGaaC6IehQL6oVxnDI/kT9mOMbwNYfFZWRl5etgirG/pyR6uRz1ljd8pVhFUgF16ZPmWYiFoCU7/pj7MDI/gLdvLmkts+DrqeUUdyyu84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KlK3oPLt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KlK3oPLt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FFDC1F00898;
	Fri,  5 Jun 2026 23:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780702752;
	bh=IXy4NLgeuZa5Txig+iDrTM/ihMQrKWz9XknvMb5CkSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KlK3oPLtJuyb0lWd1+n+AkKliBmT49iAbmkhPi6F09gr0kxWgsVN8Fiy9H9OSfnQb
	 IzAWCddNERADyXKOzCBZYYNFFxY52m/fORJt28eDSY24T5S0mXiRMs0vQrPNRQnC5/
	 PYDoJ8+dJT6iSa8f307vzbzj0oBV2rZyCIAJj/ihSStBvSBviTmHVl44AlOHqQbvlK
	 oareP2UxNtG8Jr2hJELsDiLHxG+RxkOrAmogM1w14vNDKidb350ICVTRnLeQCdcDib
	 CF+au0GEFbjOtTvTibUv77dEPawirVh9HPbb36GiOFxEW+RVNIYJwOFojaLKGbZH5L
	 ZRb/eQ0z9oCyA==
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
Subject: [PATCH 5/9] perf sched: Clean up idle_threads entry on init failure
Date: Fri,  5 Jun 2026 20:38:33 -0300
Message-ID: <20260605233837.1773732-6-acme@kernel.org>
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

get_idle_thread() allocates a thread via thread__new() and stores it in
idle_threads[cpu], then calls init_idle_thread() to set up the private
data.  If init_idle_thread() fails (e.g. OOM for the idle_thread_runtime
struct), the function returns NULL but leaves the partially initialized
thread in idle_threads[cpu].

On subsequent calls for the same CPU, get_idle_thread() finds a non-NULL
idle_threads[cpu], skips allocation, and returns thread__get() on a
thread that has no priv data.  Callers then get a thread whose
thread__priv() returns NULL, leading to unexpected behavior.

Release the thread and reset the slot to NULL on init failure so the
entry doesn't persist in a corrupted state.

Fixes: 49394a2a24c7 ("perf sched timehist: Introduce timehist command")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-sched.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 21fb820b625b43e1..e4378cc9ab3ed48b 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2514,8 +2514,11 @@ static struct thread *get_idle_thread(int cpu)
 		idle_threads[cpu] = thread__new(0, 0);
 
 		if (idle_threads[cpu]) {
-			if (init_idle_thread(idle_threads[cpu]) < 0)
+			if (init_idle_thread(idle_threads[cpu]) < 0) {
+				/* clean up so next call doesn't find a half-initialized thread */
+				thread__zput(idle_threads[cpu]);
 				return NULL;
+			}
 		}
 	}
 
-- 
2.54.0

