Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FEC39BFE1
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jul 2026 16:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783615954; cv=none; b=rl2GqyAbPX0okgLQKwRpSXuAOOUThm8sNiJzZL/vBnnCCx8PAsM9lDEIoO55wZVgiofUSQzspCW3QRxQXSe1i9EoYc/ku6eUVQo901gU7q/olv5ut6c+oF5Vg6kLP0zTAw5bbC6EBpvbWUIeKlt/S4DDXNdI0m5jjEwyemNh+lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783615954; c=relaxed/simple;
	bh=G62J4nv3/Zutx3SxywykI98291W0RHWM6MTTzWCUNh8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MLJ7OkTj8bVnVChXoh0/DyS1bv2sDJC+WMHY6CaSaTcJH/a0I2kwWtgHUd/gc+/AqqTinzdVrFsjQvgzr6kLrNwfqevcUq+qKmeowb5XMyF+WitC+u9ScGwv84Fh+731E74v2OMK7V2Bgv07lPfrjpZ3JcTJJ971c5Cxl6FNBRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FDRfDsmN; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FDRfDsmN"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-38001e788d6so146464a91.3
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jul 2026 09:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783615952; x=1784220752; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tJ7llITzFALx+eWvqnt8croLB4hHth0QUA76ZM4bz6M=;
        b=FDRfDsmNE/skH1H6Ssfr18q9qHNT9GxFhiRto6WHjszM1Wl6aZhy11x97MEjM9bTEk
         Y4c/B6yn+zvKhH1zmkch+8/4UvfSsFNmfQd5gLt6GQWGPuqGrh1lCylmC0QLaCWhrbWZ
         hD2Isax9bt0FvFSkoeVH2rl9NblT7Qthv/TMb5xeeQ0kZJBerpDTm2ION/9TxguiBwVM
         Sxh4DoNZxHA6eFrTC3wfPIE7Jfdpm4hAPE13VMe4ANO6s4Q/ifiL4e/VYe/6rDNsn2TZ
         +l+8oEtM+/AJMraHc+f2daiiXG4cXprGlG/xDg0lb+4xjlx6e6RkRWNTFPMfF+SDj9jA
         bf7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783615952; x=1784220752;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tJ7llITzFALx+eWvqnt8croLB4hHth0QUA76ZM4bz6M=;
        b=AoowMvutUXFtnbDhFUBC64Gr3wFli2fTv3XDCY6PMiFPX3byH+/0rnyoN8LYwesEzs
         wS5LX/kyQuq9A7pmvcPNV+YpIbxRJFd+YK/tlIUTuUarbPWigTa5Qro25T1D4nhYwf7G
         BEXvIQTwKsxaJr3sLf99HdvQmh/VZ0AtjFtgX5/zjX1r2zYk61ot8UY4T8HyewyHvEU8
         zxx7s0zCKjNWtFJcNfFr/AprXKU9EaI/A5cLo6dQec0g1ATBIX0iZPMuNOZ9jS6I0+Rw
         UdL3L30Cc6IDg3xy54oxccCiJjq8GLS7Zb/ztfIokRYMFNIlpP9/Wz2LSHE8LNpiKnn1
         KnAw==
X-Forwarded-Encrypted: i=1; AHgh+RqTSmmVWJHR26UnMh4POzFUH2BUzQE/NuGJFEDmwO+Y4mzJyc4641qY52Kv2tbZuYXBaIkBnRqvlg+UV8eMYEp/@vger.kernel.org
X-Gm-Message-State: AOJu0YxoUPmBhwvDYpw1uFBV3u3nE9YYY7rQSEmtRuiwbxjLWPAhNZzp
	cxE/EMstRMZg+4/hHo2ZRdnVkz9BMmLGgqcuNKoR5In6lgobr/gHgDyS4I1TPB/g6Xt2INi8sSQ
	zyWbSQzIn4A==
X-Received: from dycnr4-n2.prod.google.com ([2002:a05:7300:e9c4:20b0:30b:f31f:872b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2dcc:b0:389:8f6c:4d70
 with SMTP id 98e67ed59e1d1-3898f6c5005mr6804434a91.28.1783615952208; Thu, 09
 Jul 2026 09:52:32 -0700 (PDT)
Date: Thu,  9 Jul 2026 09:52:20 -0700
In-Reply-To: <20260709165220.1411149-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709033701.1117943-1-irogers@google.com> <20260709165220.1411149-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709165220.1411149-4-irogers@google.com>
Subject: [PATCH v3 4/4] perf hists browser: Increase MAX_OPTIONS to prevent
 stack buffer overflow
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, jistone@redhat.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tianyou.li@intel.com, sashiko-bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

In evsel__hists_browse(), the 'options' and 'actions' arrays are
statically allocated on the stack with a size of MAX_OPTIONS
(16). Further down, the function sequentially calls several
add_*_opt() functions, which increment nr_options without bounds
checking.

Depending on the context (e.g., branch mode, scripting, annotations),
the sum of added options can theoretically exceed 16 (potentially
reaching up to ~19).  This could lead to a stack buffer overflow.

Increase MAX_OPTIONS to 32 to accommodate the maximum possible number
of options without risking an overflow.

Sashiko also caught an existing bug where uninitialized memory could
be read on an error path. Move the memsets to avoid this.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-perf-users/20260708235834.3FB771F00A3A@smtp.kernel.org/
Fixes: f2b487db45f2 ("perf hists browser: Fix possible memory leak")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/browsers/hists.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index c032068568d5..3bd84a35df41 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3002,7 +3002,7 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 	struct hists *hists = evsel__hists(evsel);
 	struct hist_browser *browser = perf_evsel_browser__new(evsel, hbt, env);
 	struct branch_info *bi = NULL;
-#define MAX_OPTIONS  16
+#define MAX_OPTIONS  32
 	char *options[MAX_OPTIONS];
 	struct popup_action actions[MAX_OPTIONS];
 	int nr_options = 0;
@@ -3063,15 +3063,15 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 		browser->min_pcnt = min_pcnt;
 	hist_browser__update_nr_entries(browser);
 
+	memset(options, 0, sizeof(options));
+	memset(actions, 0, sizeof(actions));
+
 	browser->pstack = pstack__new(3);
 	if (browser->pstack == NULL)
 		goto out;
 
 	ui_helpline__push(helpline);
 
-	memset(options, 0, sizeof(options));
-	memset(actions, 0, sizeof(actions));
-
 	if (symbol_conf.col_width_list_str)
 		perf_hpp__set_user_width(symbol_conf.col_width_list_str);
 
-- 
2.55.0.795.g602f6c329a-goog

