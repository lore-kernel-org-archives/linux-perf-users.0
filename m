Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA8A4EBAD9;
	Wed, 16 Sep 2026 18:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583584; cv=none; b=o9jIt5o/Erospq2juA9Gl79f9KZCpgBYBgRW+RzQMQO7IHDR3QBqHykU7AQ9Bzhppvz9xAwJTdj/t4kZyQFrcF4BlDDP9Agpl0vuRkEg1RxYL3Gjd16OMAEAQh9FLvuc6u7/EShKn7JQhUcBAOzNcDJ2XhR1AhOYoLYCC+zIkYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583584; c=relaxed/simple;
	bh=At7oBjSNcvDQlvvRq1BgPl2RLuY/tLADR4FG8ryJ/g0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kItpJKORUMzKVWzzlQq3BEISva4paGMKOVVoqN/EuPqwvlKOQCC/z0nu+O2iJMr7B/WtRroL80AQdPWymrRyZTfbm1zWWF3GjUGt9wkOf4JZPE50eefT2q5Ct/65UjEmtGW0vZxsjAlmKD8HoQtnH9DmyWOeD7kId7UWvjf1yXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNmYOAVu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNmYOAVu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 688811F0089D;
	Wed, 16 Sep 2026 18:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789583565;
	bh=Cjfek0rxsBOdtdMp82BYpYtHD12YRU8CM/arsX/6JOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZNmYOAVuo4QMh4WANlyyv1oI4oq8Jjid1nlFYoAN77Fva0nlZC2YX2GdQ9wUSROSg
	 FsBqyCoN/iUA6Fsf5ACD1gNd9+oJ8yhH5H0gydHaSU07iYXepZh+pfFgLfES796Awe
	 5IGzninNAWpSN675UfkNWErJHgM5QfIU460NwVsV3+FQuzs9UB161VLfCL0TZnwlUc
	 ICV/wi/0PQz5ItGL/FVaQ34DetknLRQHE25ciOgJAQ6+bS/5zRfDsxQ9knbsmNn4fy
	 L1jTdvVw/1WfAF1RkqN9TgbJ9BgKQoZcLTdB6kMd523isbE/1xP5UunoT4M7RSDwB6
	 irjYsmrLse/lw==
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
Date: Wed, 16 Sep 2026 15:32:08 -0300
Message-ID: <20260916183215.54305-8-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916183215.54305-1-acme@kernel.org>
References: <20260916183215.54305-1-acme@kernel.org>
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

