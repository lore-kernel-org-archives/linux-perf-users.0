Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB79E4DAFA4;
	Mon, 21 Sep 2026 16:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790009348; cv=none; b=PpQuO7E0OWDGjWSYBV1GZ4umxZeVNfZFbIR5KS9CPeEWuw0HtdOJxTCBAhCXqRKGycQQx2p+uvFxGYV5Pt9NLJ9GriI2TWsiKFREabpR3K7nNrKKm9+ND6Rpszm2PWSNoqKmDrxWQ48YSW/623SWEMWibm3sPtnd++ol6HRhix0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790009348; c=relaxed/simple;
	bh=3cDhoN7P/1XTUwvA8WkOrFA9S1haHivtyk6o/1zsDr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OCw4vllHevQrjZsJXWN/kqhczkLbSTNOZqXcLwsfvFT7k2pwp57n29O4GnHNqmRP7aEd4mPHyuAJyQWhsckQIbilZrWfaMv8piJV1c+750WFdY4g1JsoJ2/2o8ESyXqhNYGNcsN2kzdNRM3+AwR9tfiEPDCzzFTPgNtdHJ+otsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uo6yZ6dv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uo6yZ6dv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D731F000FF;
	Mon, 21 Sep 2026 16:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790009346;
	bh=ut/tiruf2HnofkU7Adqr3g/phrfuZNzP9oxtyKMjlx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Uo6yZ6dv/bTTxHJlGxBFOy+zl2sR/dobbceErquYzJtRd2NhTush1a+1GPrEJ4rRb
	 FoQo01zvzGZWTfp4NymEJIQktuvzESOS+K6rZlU24I19Ad19DxSIcSAToUyM22G3g4
	 BSGbNgBy2huBZsN0rp0l58+hksF6VXlnlvlzS86S0Kag+uPmh0pkf18E+sgCMlYvRg
	 pQXA2HRQd5r95iAj9oZIF1RRVoRpydTYcS3840nCS60J10vZq3U34SCSsUKvNMbZ/d
	 nXi6g/vaCGQPLiZEnRD9u7qOCsoF3rxPaTopinrKhqTw5M1aKN4EKqwzctkdrxMEsi
	 rtq7PQqRxj2RA==
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
Subject: [PATCH 5/7] perf annotate-data: Show the sample count in the data-type browser
Date: Mon, 21 Sep 2026 18:48:11 +0200
Message-ID: <20260921164813.6727-6-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260921164813.6727-1-acme@kernel.org>
References: <20260921164813.6727-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The samples view (-n, annotate.show_nr_samples) prints a local
nr_samples variable that is initialized to zero and never updated, so
every member is listed as having no samples while the period and percent
columns for the same entry are filled in.  Print the histogram entry's
own count instead.

Fixes: d001c7a7f4736743 ("perf annotate-data: Add hist_entry__annotate_data_tui()")
Acked-by: Namhyung Kim <namhyung@kernel.org>
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
2.53.0

