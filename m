Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF0E1D416E;
	Mon, 31 Mar 2025 07:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743406644; cv=none; b=QT4NP5p9S5wd8ywSwLwMKXOqQ960gzHs+iEdtuwKjib4HO9nZ9qtODLXGb86mrBAA4SARHgGNsWvid3WeIZFA0/Hr1H87ogIUCRoERD7HpKPD+C/jWuUqtl2hF4kTRCppWDwL7yS94JXR0SXz1J14ozST2rL1BGYLyr4JexgXWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743406644; c=relaxed/simple;
	bh=Rj073L9NGIPpw7qZbc0krqGkxraO1TRJZLZphGoiFok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cefvnttEeqIqFtPgvUZu+cTu0KtF9ISMwgzkekUlpmYtTZsTmKvZgbmB1UPaXlYzokJ6yE48K2moHBoaGwX/ZFFHuq0ILMrGSaf0NyWdDSltDnB5GXeFrVVUu8IpITC2u+9WoE/V6v9hRIYL8SOAjuJ5K6Io9gFK2Ub+zaHAwfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTOry2U7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTOry2U7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0367C4CEE5;
	Mon, 31 Mar 2025 07:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743406644;
	bh=Rj073L9NGIPpw7qZbc0krqGkxraO1TRJZLZphGoiFok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cTOry2U7xVtdG+UvKurRJTEBU1X0OA2gBXRAPuYfoQMWcpz529yi3QV1zv9/GB91s
	 e3m5cgarexbJnGmw5+gL+HY5pnlS4qdetEdNANsMByXzxM1opC/7AP8OKw6rlmvS29
	 VPWmGJA5bovQ2U2UdpMudutJB57yG3NyZ1AjCyvGmhSfm/DESJt3tQvsF9ND7fFMG3
	 /i/6Ob0XA9V+un5Tm0zZ4jtVT6j5weCpYJFhPVWi2pcZn3xHF9cczAF0jcaAdqbTmc
	 vs+/QWxX/zgLgg2zPabIyDQ/CNFBKqEGYaZd8RkDI3vyBYLXj700N9quIRyptBMjrA
	 4s1FSktUsNO4g==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 2/4] perf hist: Remove formats in hierarchy when cancel latency
Date: Mon, 31 Mar 2025 00:37:20 -0700
Message-ID: <20250331073722.4695-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331073722.4695-1-namhyung@kernel.org>
References: <20250331073722.4695-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Likewise, it should remove latency output fields in hierarchy list.
Pass evlist to perf_hpp__cancel_latency() to handle them properly.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-report.c |  2 +-
 tools/perf/ui/hist.c        | 15 ++++++++++++++-
 tools/perf/util/hist.h      |  2 +-
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index c9138e1379808097..c207aaed7ae5fc2b 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1088,7 +1088,7 @@ static int __cmd_report(struct report *rep)
 	/* Don't show Latency column for non-parallel profiles by default. */
 	if (!symbol_conf.prefer_latency && rep->total_samples &&
 		rep->singlethreaded_samples * 100 / rep->total_samples >= 99)
-		perf_hpp__cancel_latency();
+		perf_hpp__cancel_latency(session->evlist);
 
 	evlist__check_mem_load_aux(session->evlist);
 
diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index 1d3f944ed35ed152..3ffce69fc823e0bf 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -739,9 +739,10 @@ void perf_hpp__cancel_cumulate(struct evlist *evlist)
 	}
 }
 
-void perf_hpp__cancel_latency(void)
+void perf_hpp__cancel_latency(struct evlist *evlist)
 {
 	struct perf_hpp_fmt *fmt, *lat, *acc, *tmp;
+	struct evsel *evsel;
 
 	if (is_strict_order(field_order))
 		return;
@@ -755,6 +756,18 @@ void perf_hpp__cancel_latency(void)
 		if (fmt_equal(lat, fmt) || fmt_equal(acc, fmt))
 			perf_hpp__column_unregister(fmt);
 	}
+
+	evlist__for_each_entry(evlist, evsel) {
+		struct hists *hists = evsel__hists(evsel);
+		struct perf_hpp_list_node *node;
+
+		list_for_each_entry(node, &hists->hpp_formats, list) {
+			perf_hpp_list__for_each_format_safe(&node->hpp, fmt, tmp) {
+				if (fmt_equal(lat, fmt) || fmt_equal(acc, fmt))
+					perf_hpp__column_unregister(fmt);
+			}
+		}
+	}
 }
 
 void perf_hpp__setup_output_field(struct perf_hpp_list *list)
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 8cc94928fcb35a5b..76efd8952507a561 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -582,7 +582,7 @@ enum {
 
 void perf_hpp__init(void);
 void perf_hpp__cancel_cumulate(struct evlist *evlist);
-void perf_hpp__cancel_latency(void);
+void perf_hpp__cancel_latency(struct evlist *evlist);
 void perf_hpp__setup_output_field(struct perf_hpp_list *list);
 void perf_hpp__reset_output_field(struct perf_hpp_list *list);
 void perf_hpp__append_sort_keys(struct perf_hpp_list *list);
-- 
2.49.0

