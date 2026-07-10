Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0A0386C17
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 05:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783661798; cv=none; b=Igs5MPhx0HzDnOozLjAavKkYP6Yy6F9nJwL45AhAHOcaeixPZcz76BMRIqeocP1tSfTTeO19hr2XTa7wIDKfogyCFvWSMO4G20cPM0yONNQvTjkRhFjS1xEGVGNjJtswqex7NFxYUYEV2O35Dp/ZTD0R5buqZY5K8DBn/mPD+rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783661798; c=relaxed/simple;
	bh=JkKoZayvpYIlK9kemDXjmnW2M9csge76MrSCjJH+mTU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TKLwisA9Wwyh1crL0EiumtMSmv5tvFdvaiMAqKJMIL7xnUoaptDVS+qMAWM/EDXt2ub7WXhfgEm/T5YYxt7ngjJ/gj4NRz2VZidLIoePKaogjF9C1lr1j7hmOhzqZUCjtHSm0qMSLliWZgSbUZHKagFeZVLHW02RPIMKljM8gaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s+65DBwr; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s+65DBwr"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c96b4f58ddcso652377a12.3
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jul 2026 22:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783661797; x=1784266597; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Yc0Za9F3rQCP8FJtmdxBZAxX1p7juKt/mlWutSEsy4=;
        b=s+65DBwrfNoVp8Acy52R5GtBI5nNYmgn7MSYJqlaiXV/I9HLWCtawHlrFhdOjs4xSB
         RSVq9SpRx9DXWj220dc0TahoeplBczEfzKGjs9xSmucP537kN/c1hQoEuMAhr/5p3jyW
         ckHB4rfSiYcMNUz5TUMaDLwp/ppIHFsvJE7dwRcz5o8WSGAcBsTbnZbC1Lxfchwfny8r
         Ff+TCYbBGt3GEP3aGWinIpABsyzphC5dGP0vq9AffXE43I5NycEJfkOSZB+UP0zysijp
         ivjdDiIJNpN5VjEFvHjYUXq/IDElwqYltrv3Zh+GVpTaMisy5nk+hklTQcxVOR2VPvhY
         VuKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783661797; x=1784266597;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Yc0Za9F3rQCP8FJtmdxBZAxX1p7juKt/mlWutSEsy4=;
        b=bO/0NMUCra6Pn6sKDUwKg88YfwLhFkDWFDAfDq+n2H+Ofhk6FzhLLeEiqn3NzSLbj5
         gEZ5TnVO78W8Yp/vx/eA6AfGJCDDoNnpU6kCgCIjP4Kue88N72mJf9uX7pmQG0IjVuMG
         TMPg2w+SEk6vgVTI1lmAYjB5xpBV29NZR+jBtMq8+MeIZ2DFH/vsrsmLOXhp2k9ufSN1
         A7yypXoZXUhzc/uCyVUOAMilctSvPk1ajT/B8QKrDxMnruwti+H4SCR2RkrjpnPILjbv
         b3rpZEhHASh86Pb9iUliQVdTasbduD/rNLxxDsJomZjTPEQS9w8sXfL1Bq1YnKvQXwqG
         uUwg==
X-Forwarded-Encrypted: i=1; AHgh+RoDsuJB1z5pq8fAMNcVBl4Sg30jK5KuyX4YSR2jAKMz4ojeJo02P/ppoPQzP5dmsKbPkOiJdp+fC1dzpeh+dv7g@vger.kernel.org
X-Gm-Message-State: AOJu0YxhL960MChrZgAgVAChFvqfiuIYbMvSfaXF72xVzI4TrR2GLgOw
	Mnnl34UIYeKPdsAOYL9JK+kdG8uil9WyCDHrGvYSMb/HKff95lNIqJ8jTiHduQc6W78AWWVF1uc
	qwuXJPouTkQ==
X-Received: from dldyq20-n1.prod.google.com ([2002:a05:701b:4554:10b0:139:f590:1d58])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:d84:b0:39b:a997:9e40
 with SMTP id adf61e73a8af0-3c0bd17034emr11664157637.46.1783661796575; Thu, 09
 Jul 2026 22:36:36 -0700 (PDT)
Date: Thu,  9 Jul 2026 22:36:20 -0700
In-Reply-To: <20260710053628.1861645-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260710024952.1668911-1-irogers@google.com> <20260710053628.1861645-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260710053628.1861645-2-irogers@google.com>
Subject: [PATCH v5 02/10] perf ui hists: Fix uninitialized stack memory free
 on pstack allocation failure
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, jistone@redhat.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tianyou.li@intel.com, sashiko-bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Fixes heap corruption by initializing the options and actions arrays before
the pstack allocation check, preventing an uninitialized stack pointer from
being passed to free_popup_options() if the allocation fails.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-perf-users/20260709035230.6DBEE1F000E9@smtp.kernel.org/
Fixes: f2b487db45f2 ("perf hists browser: Fix possible memory leak")
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/browsers/hists.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 6163cc3ace27..319c3d6c0375 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3064,15 +3064,15 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
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

