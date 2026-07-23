Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8108E2E7BB6
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Jul 2026 04:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784782802; cv=none; b=f9ZspgvXqDaU5B76WmdqPT4Y8YbC3LNuptTjkwJ6YVQEBW754OCcrkdsgDuGGWAk54nT2dtHX+/so7QklXMF+qB0mWGd35YAsTAdgs/XHx7hpmBhudr6VNtlFWB35mcCvnOZY1/4z3jh6RdBo657jFp8go2/Ssuh9ZmKT271w3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784782802; c=relaxed/simple;
	bh=pID4/alJYNG0QOaOzBgne03+sPbT/nEX+vME0pae7N8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NBrr/c6zo6SPF6c9BhdOYTR6rLYoZRdb9Twt2JSwAkq8FKhxYzBsgsZKYD6BzLiF1Ew8eaM/6vs8g3BPH111UCDh+JYxZwloPjI/2Qv5nO5Z7bzlY5rb4EV/EL26F4OTZdXW0brfW/2lzFT+mCGJL4TI9uO1tUnvoPEDrYabY+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s6rZlfaI; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s6rZlfaI"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38ec0f510a9so632242a91.2
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2026 21:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784782796; x=1785387596; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Ve2zmIa6pxnua96cTXgBtsg/co1g9aZD4YRJ0W7aCc=;
        b=s6rZlfaIyl68jcxGMqbfMq+9A7kPk9Vd2d75F1BdbrveLhTVRnpPdz4oTn9TXQp7n9
         yIBj7yhhH8/o9nknakPqL+AZHNNYFlrbGtqy+M5Fm9O68icYiDMx7a4BvyWK95Nbk4Vk
         mSaW1s/gbyyYdLXDMzdn6+JZ/qDId+DI8k5we39fvVZM+acw+O/6xhEWLY0s6g+NG27W
         +jJ1+zO1f94lRoRGhue+qCDkM3bM4YREsxjv/GiQ4ZTsj7AgrFkVlsuGbG1+pywEZnyV
         CRrtIDO8Tr0D14zTUnpclHs32cfJsSm+uIFMzf3iPuQZ2rmymJx/wPmnrNUAIO9XHxIX
         Terg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784782796; x=1785387596;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5Ve2zmIa6pxnua96cTXgBtsg/co1g9aZD4YRJ0W7aCc=;
        b=LmH7uNb7AD80xz+dzsJyglAXv55TySGZPz0R9pPgnrS2+6Xq3YAa76DFUAugWZ3wwd
         IQcqsU9e7+qQkOphiCfRStNaktG090YtpUDo7uB7lhD6sFJfJXI4gg3jOFSDZImoQNuE
         hzzODu/J+yHJfiiLOVLwt6t3Y0Nm6V/IjpEME6dU5/wg9QjfNongdGjxNY+aFJCbzUYc
         wJCzZ5aDi8viREMHRVNeGwMJYWNXUcNtGGDbljxpKBTkaAq0NFkBRYmal03ikO4wCFlm
         qF8wpG3oFGhwc0n55arg8ghBEK+1abm0nAvzd2vgKCFic/FD8xAguTk169eMOJa2qLW4
         CNFw==
X-Forwarded-Encrypted: i=1; AHgh+Rrv8bjcCFCV8svTZLcZej/ClKvsYDV5yoH/2rj+RmVy4Xdj53cZxCwM5Wiu8/awAk0uM17MqB0LEA6Y53W7+HkL@vger.kernel.org
X-Gm-Message-State: AOJu0YxfZE3A5ym4298IfqZCYJ1RthL9fxp8WY2OldCoiOEVVwlmv4Io
	iUrVg4Z+uj9JM+UbGPONR6bmVCMolOCXvKg3odDEhvzM3r+Feicm9O8Vf4j7GqsTA/eO2QRXG7l
	dKibtrksxsQ==
X-Received: from dlbut13.prod.google.com ([2002:a05:7022:7e0d:b0:13b:8034:c3ce])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:134d:b0:38e:bbf1:de34
 with SMTP id 98e67ed59e1d1-38ec653883bmr1691770a91.7.1784782796226; Wed, 22
 Jul 2026 21:59:56 -0700 (PDT)
Date: Wed, 22 Jul 2026 21:59:44 -0700
In-Reply-To: <20260723045949.988740-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260716072351.560311-1-irogers@google.com> <20260723045949.988740-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260723045949.988740-2-irogers@google.com>
Subject: [PATCH v7 1/6] perf ui hists: Fix stack use-after-return in symbol_filter_str
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, jistone@redhat.com, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tianyou.li@intel.com
Content-Type: text/plain; charset="UTF-8"

In evsel__hists_browse(), the local stack array 'buf' is assigned
directly to the persistent 'hists->symbol_filter_str' pointer. When the
browser returns or is exited, this dangling pointer remains active in
the 'hists' struct and is read asynchronously by the perf top background
timer, triggering a stack use-after-return.

Fix it by properly duplicating the input string using strdup(), safely
invoking zfree() to prevent memory leaks when overwriting, and cleanly
resetting and freeing the symbol filter string upon exiting the browser.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-report.c    | 7 +++++--
 tools/perf/ui/browsers/hists.c | 5 ++++-
 tools/perf/util/hist.c         | 1 +
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 10db1e5f1e6c..60d1f166629e 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -726,8 +726,11 @@ static int report__collapse_hists(struct report *rep)
 	evlist__for_each_entry(rep->session->evlist, pos) {
 		struct hists *hists = evsel__hists(pos);
 
-		if (pos->core.idx == 0)
-			hists->symbol_filter_str = rep->symbol_filter_str;
+		if (pos->core.idx == 0) {
+			hists->symbol_filter_str =
+				rep->symbol_filter_str ?
+				strdup(rep->symbol_filter_str) : NULL;
+		}
 
 		hists->socket_filter = rep->socket_filter;
 
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index b6002724bc3a..be8a6b169722 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3220,7 +3220,10 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 					"To remove the filter later, press / + ENTER.",
 					buf, "ENTER: OK, ESC: Cancel",
 					delay_secs * 2) == K_ENTER) {
-				hists->symbol_filter_str = *buf ? buf : NULL;
+				char *new_filter = *buf ? strdup(buf) : NULL;
+
+				zfree(&hists->symbol_filter_str);
+				hists->symbol_filter_str = new_filter;
 				hists__filter_by_symbol(hists);
 				hist_browser__reset(browser);
 			}
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index c93915625ee7..443694926f1a 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -3056,6 +3056,7 @@ static void hists_evsel__exit(struct evsel *evsel)
 	struct perf_hpp_list_node *node, *tmp;
 
 	hists__delete_all_entries(hists);
+	zfree(&hists->symbol_filter_str);
 	zfree(&hists->mem_stat_types);
 	zfree(&hists->mem_stat_total);
 
-- 
2.55.0.229.g6434b31f56-goog

