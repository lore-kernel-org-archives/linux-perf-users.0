Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327ED376BC1;
	Sun, 13 Sep 2026 02:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789266925; cv=none; b=ba4Hz5HCHu6wc1x8KT64Fx7t0qPGy0PPFNMPNBPLHTTlS+/nw9fUH/17/3Xd0tFLvUDBdIopdPXuQZAntkuUb3Hryd9we+LhdtfCpBrm+gOvyctRlUhCjRsFMVHiUxC/iBfT7qTbZmHqZwil2wL9D+iVlhmk3D4BbiLtMDg8H1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789266925; c=relaxed/simple;
	bh=LD44ceqeITQpbtntVg3pm1whLRB9tUKm10aR4jYBJN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sLmu2gxYSmaFQPUlIK9lsnAC9t1ZjkhMY+APze9tif9uPj808A0F9F66WSDVaV8ch96qYo4d6wB1LE+/rKNBZKKfEWJCER7R72EkhPpaKdqdmb3qMAiaGOrZt2xiwld/wqX6YMrxlo/8GO/AuKK2f3XJuj1iEvN9k41a9xmK53E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8U994tj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8U994tj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA47C1F000FF;
	Sun, 13 Sep 2026 02:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789266923;
	bh=DAmmexN09NZh2SAdn0o7GQKbbFwny4ZHYv/wL/UNfNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S8U994tjKtV8kbS57HigAeSXEbzpxWrEpHnhY4Tn++BC4ppYlrMOke0PGpZbM+qmL
	 wAZi7EPdkbGS6sNkIHUw7dGhiPOtSgWQ7Qa02EvUPCx6+Sz+pwBlHdwYGJdmHQMUp/
	 i+xHwUwWWm8GEKF84rCb6gFMtfh+8aG4zJr7F1e+4DxvoYJ/FXXX/2hYKupP5oHMlf
	 sxPWHOuT7mEnUU8Y6Reh9zI9GNT4WCTXSTPQUIhvUtKOnxleu5yhEPd7YRke3rvKd8
	 DtlyyfbCPYf05DOc1nYssp6T98U8vQ0GCENLABr+d5ku9YvveXCkiThxFjnX2SHso4
	 q0jBdeUBO+4uw==
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
Subject: [PATCH v1 4/8] perf annotate-data: Show the sample count in the data-type browser
Date: Sat, 12 Sep 2026 23:34:55 -0300
Message-ID: <20260913023459.112654-5-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260913023459.112654-1-acme@kernel.org>
References: <20260913023459.112654-1-acme@kernel.org>
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

