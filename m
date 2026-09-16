Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B330049EC43;
	Wed, 16 Sep 2026 11:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789559314; cv=none; b=AorHfdUY43BV49GUCGrKznCHvCEPKdQI3zurwX3auomG8/GK4a+tPRxL9a7cXVVGWeH1rKmqAFlO1E7r1vWoxH0P5ViTCAHFzqm4imjEaRdlEWqjqT8tYtIZgi9XwE8Sz0IAPBV1zaxXCJ2YDbPk52y3PpnJgJxXiRjqPxoyVy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789559314; c=relaxed/simple;
	bh=At7oBjSNcvDQlvvRq1BgPl2RLuY/tLADR4FG8ryJ/g0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eD+LPMbDoaTt+lswPCA8MtYt0uPYBZ25yfu76RJgz2893HU+oeg48AMLnAUHEggN478qHhQZo0Zj+JnYDO+SOSZRClPtjagmyiJDvoI1wD4eSxa5EbnLpAMQXsX+Q/dFImYIjjBi/g7qWZhg37yoakSTX9bKFgs5bll2LvDpmVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CF5SkooW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CF5SkooW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275751F000FF;
	Wed, 16 Sep 2026 11:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789559303;
	bh=Cjfek0rxsBOdtdMp82BYpYtHD12YRU8CM/arsX/6JOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CF5SkooWcziVg7QnVp1HY9I9y3iMMfaMUl3TE4gFu5QUWHr4p5yMIvVLmsqPMk50j
	 FjYVdxQXCMmbTpLzC8pI5ISvP7fzr454xikbCaS6ZYhPTIlyqiqOBgQzIsA3rC03wt
	 PwPlX0v78AFs7vQlFfFbSFhMm/drBscdZS6OtWYhLCAUaFrVysxp8UKCxYf202BRiT
	 q3IOGVIZYxi3R/epVu/6dWjH6ggPFFfAZnh/bmhMkTxNLMehsQ7oneWKZbSiZids97
	 WPojwW3l5Qx+RnwGhKRuX+mNOhIMgyuHo8uQsrtNdU+C/gnFPVVHz/w6QZfcyykKIT
	 s5Heq4NYKojpw==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 07/12] perf annotate-data: Show the sample count in the data-type browser
Date: Wed, 16 Sep 2026 08:47:34 -0300
Message-ID: <20260916114740.48230-8-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916114740.48230-1-acme@kernel.org>
References: <20260916114740.48230-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The data-type browser has a samples view, selected with -n (or with
annotate.show_nr_samples), in which browser__write_overhead() prints a
local nr_samples variable that is initialized to zero and never
updated, so every member is listed as having no samples while the
period and percent columns for the same entry are filled in.

Print the histogram entry's own count instead.

This predates the load/store counter split, so fix it ahead of that
patch: the split then only has to adapt a line that is already correct,
and this fix can be picked on its own.

Fixes: d001c7a7f4736743 ("perf annotate-data: Add hist_entry__annotate_data_tui()")
Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate-data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/annotate-data.c b/tools/perf/ui/browsers/annotate-data.c
index c6e07a9b64089ab5..a15608f6ee53335f 100644
--- a/tools/perf/ui/browsers/annotate-data.c
+++ b/tools/perf/ui/browsers/annotate-data.c
@@ -374,7 +374,7 @@ static void browser__write_overhead(struct ui_browser *uib,
 	u64 period = hist->period;
 	double percent = total->period ? (100.0 * period / total->period) : 0;
 	bool current = ui_browser__is_current_entry(uib, row);
-	int nr_samples = 0;
+	int nr_samples = hist->nr_samples;
 
 	ui_browser__set_percent_color(uib, percent, current);
 
-- 
2.55.0

