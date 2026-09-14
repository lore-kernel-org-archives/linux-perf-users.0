Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D453447D474;
	Mon, 14 Sep 2026 12:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789390521; cv=none; b=dCrcZBkdtXFIQM+rh9Q8Wkq3IMrCTjvlo8s3bZSf/7/8DQMhEPZCCbchzDtI+jURvnxZu6vl1gBM0GBj0RsE17Pi/0k2U6ZSrSNL3EgC9sMw9LBTMhF8BBx5Sj0TXFEKIZd/XMP+NHoyAJfGqrlug1gRS2RfYlQlOAvgtJkeqbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789390521; c=relaxed/simple;
	bh=LD44ceqeITQpbtntVg3pm1whLRB9tUKm10aR4jYBJN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mid5zi4RUKMGavHnCxFqNEuX6lfS/+vLjvWCgr8xOPyduHfjXDRQ6oG87DisauhQI5B5l6RcD109oJv8U/DwT9hq/aanPLvkIOnEMUERcVK1FndCvuGrqYLqC7aT/gjObcAt057Rn2nmGrBHUoGZUT0v50wRaHtRnjjIXPrmLqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iROyhkA9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iROyhkA9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2E71F000FF;
	Mon, 14 Sep 2026 12:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789390519;
	bh=DAmmexN09NZh2SAdn0o7GQKbbFwny4ZHYv/wL/UNfNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iROyhkA9SVjcxjkFaqh9oIaMeB2YTTI2x0jPdc6vuxbNR5ocNlubMfbSwY0s5Kod6
	 o40+PD3eTD7jCAx6lq2wbTTiwv2cqEfSRrcKn8Zja/MZ/dghy3ka6cI6dDIBc/jBYg
	 iJs01frbMz4wQGOlOVK3yz5I3oZMpgcLa0x044+eY/SqGimQBGky8NwcIiatp+qloA
	 98BsRreWmpXM7x3glG4EVpD3DL38Ta90ljujC9CtUu4rknDFozacLMG4yKTtBBkn59
	 /x2Walbgz5TiS64MkwBJTzjigJhO/RzY/S81ua7Ln5XmTUTE0Tc7H32vyLxKffFj64
	 CMp5sH3iOs6Cg==
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
Subject: [PATCH 4/9] perf annotate-data: Show the sample count in the data-type browser
Date: Mon, 14 Sep 2026 09:54:44 -0300
Message-ID: <20260914125451.2045-5-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260914125451.2045-1-acme@kernel.org>
References: <20260914125451.2045-1-acme@kernel.org>
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
index aa8c89fe2e82c1c5..1080ed1a40d2609a 100644
--- a/tools/perf/ui/browsers/annotate-data.c
+++ b/tools/perf/ui/browsers/annotate-data.c
@@ -370,7 +370,7 @@ static void browser__write_overhead(struct ui_browser *uib,
 	u64 period = hist->period;
 	double percent = total->period ? (100.0 * period / total->period) : 0;
 	bool current = ui_browser__is_current_entry(uib, row);
-	int nr_samples = 0;
+	int nr_samples = hist->nr_samples;
 
 	ui_browser__set_percent_color(uib, percent, current);
 
-- 
2.55.0

