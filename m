Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BCF3DE43F;
	Fri,  5 Jun 2026 23:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780702764; cv=none; b=GlQm+VV7W3sgpeuXSzE+UqWGrwMvnLwqBiwAPRb5EVL65f+b7B2bt2AtZ8rqT+zUYNBMq/BxiF1nihBeTL2qu4zcVM814jcKaB/HMqjv/qoKCmpK7QDT90Gq95M4Ft6WyJpfj3IijD55QbpA505Mt19IIe3mBdQppN0q9VCu2E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780702764; c=relaxed/simple;
	bh=NHgzWvSjJ7xclTBwzWp6Bjk2yNLkkyNWXdXWAEEC5dA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OLvw6yNgzW62QkN3Zl5Een6Iv2Oekx2XsKvuvthcyMx2qcI8nx0kSvZNFC1emW5oKTPEclWI1RruW5v3d6WlHcEPTIZtGcJucbusVM5Eavg0IWdLQRiWLEHuTcupI/GhDXDjz2toBhLFYY4aNBdEviP5oFENun7F8ay869aJry8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gk4x27nQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gk4x27nQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0FA11F00898;
	Fri,  5 Jun 2026 23:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780702763;
	bh=hYBNmm3RVgxIwHwUN8g4kAEEgIyPRkbd7WM1Q4vJyW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gk4x27nQn7oKDn/Q3uY9WNnxP2uywUxGjxhu+sDvXIhAvaWbgvhpdrzGg6voQWN2r
	 TvwHCk1xMmX9Kjgo7UgGsfQqsvZWdONPedSx2cPm/FPy4qeSINwsMOPYbyJ3uvCy0U
	 XzV4S0xGiFKIfszopuIwbBn68PzoW01FfVoM2HRBrpfLcLBynEx+FV5h3NXzAjXTNA
	 tesn5YRSS6PAX2/RGiUwaM1yPBtoGxl9Fuxh6pIhsBQPj2DgdGm4VOKuERzPBZnqb2
	 IYJa+seh4mjahmnk0ogf6Wi8M4Abojnx4q5haavw1DWEThJIA4itc7+DUTusiBE9fx
	 Q9u/JSq5wqI6g==
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
Subject: [PATCH 7/9] perf sched: Fix thread reference leak in idle hist processing
Date: Fri,  5 Jun 2026 20:38:35 -0300
Message-ID: <20260605233837.1773732-8-acme@kernel.org>
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
index 4600d70b486104dd..c0cd3cbb602aa4c0 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2940,7 +2940,7 @@ static int timehist_sched_change_event(const struct perf_tool *tool,
 			if (itr->cursor.nr)
 				callchain_append(&itr->callchain, &itr->cursor, t - tprev);
 
-			itr->last_thread = NULL;
+			thread__zput(itr->last_thread);
 		}
 
 		if (!sched->summary_only)
-- 
2.54.0

