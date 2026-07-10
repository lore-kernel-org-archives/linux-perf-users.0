Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14AA31F9B1
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 02:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783651810; cv=none; b=NaR0PUjgaCzOPb4C9AOZHX64TP5JcTfR0mVtl0nkqG7mkYtJ1hwJ6B3YA6KrEs/JOwAjIioTSIFMxoFKjpiLhjG+zA1rva0SSDYymD+jI4LehU/1qJD/Pb1hRW5rw1nsRzjR/FqSU8fPYBAi2jINzWdC62Qe/czHsplKfFyBjKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783651810; c=relaxed/simple;
	bh=J/WAjM4T7uHEs6XPshQ9cey2jVcGpBYqBPb3ET1dZao=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RweNec9z95URVoQXS+djK2q+uDsHZ65lAnwjMmQ4vKw+46WCTehOku5dMPHzOyasNBSIxJZKTshhdzYRED+qyan58jMqZBkBAfsWPu7oM7T34ft/ZYBGO+4bi6Dhl+4sid/hZyATXJa3FrVGeBZwcl+0KqihP/XHXFbw4GT7H8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WuHOuzKM; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WuHOuzKM"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c9667280edeso709628a12.2
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jul 2026 19:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783651807; x=1784256607; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Msvps8u4Exs31W4moeqD2kBAj5mse78bpQTpQrgt/LM=;
        b=WuHOuzKMNbo1zyft/blQmE2tBGjevMfx5386NHc/yf9PZC+tpKouaaTmaAj1J28Ruf
         jcXP5+ZKEGcWZLdnozFXd6W+Fh6TFJXjmBNxTdTtViKvT7gZNJVTi+ZWdnvtHcP1uXVH
         +cjJce4p227CR0h56ymdTx0FWHCQuTzpG1w9ZBh1KQqvmPzF9LbvzskhFIRqcMmviohj
         J9+vyiIIPjLZEDWEApZTcF/RdSJidRYoCZ8AS0pLdPFzAhb9gUM11KFi8kDSJtSt7WSD
         tfD6H/CAau4uXcsjl2hHUy2cGmMm4XSqhR76ZSRBFVNwcNwTXAXZJG91vrc+nGtU25NN
         VpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783651807; x=1784256607;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Msvps8u4Exs31W4moeqD2kBAj5mse78bpQTpQrgt/LM=;
        b=c5R0wFwtV4XfyLMQREZLoWsbLPYFwv/TYxhO0YWV5G7HdmMYDhIHonsgLfJv1tjQUP
         LTizbFTTqCwj1sdCqyxKR+t0XFO2JALmqio58H0pYCS/4ZZYrPK+EwkcQ0AB5a91X6a7
         qAS4r+PGcekyYq1JAlOlAsp/C5R49jEb7I8qf+76dswWR+LVU1snWdWIxHH3NQi7GzCG
         AydGl3dB5zwEMnfIyDuPpoyJ/8z7T4SsU0KoxJrIj1R7maHnMssoqvyJZwnY27+p9QGS
         uYIdO3vT1QKq4d+ziA/VOEwIM4lUarsAzmkZCoplXYpNaWjfIYL14G7HVIWk8mssBIKi
         pTPg==
X-Forwarded-Encrypted: i=1; AHgh+RrvMNUEq+mqM7moWZUO8QYv6Ti/W9favB+YwaupEPZ/OfVVVbv9d4hiT/TEKITzvb+NnTfG8oa4zboP6HdFNQQB@vger.kernel.org
X-Gm-Message-State: AOJu0YzWeYMCOdc1+kYkVFxWT4pfLbRm2e+j7mlmP8Oc+shM0NTDI840
	szdsjWkJwqO9uYphWWPfXjiczxPKcD3aEjvMRhTzXoOyVUHYlGhRlarB26ezmy8RcxfR4Nhig0e
	8O/5IDl/xDg==
X-Received: from dlf19.prod.google.com ([2002:a05:7022:413:b0:13b:2d46:494d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7343:b0:3bf:76d5:cc2b
 with SMTP id adf61e73a8af0-3c0bcec1928mr10932457637.22.1783651806280; Thu, 09
 Jul 2026 19:50:06 -0700 (PDT)
Date: Thu,  9 Jul 2026 19:49:47 -0700
In-Reply-To: <20260710024952.1668911-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709165220.1411149-1-irogers@google.com> <20260710024952.1668911-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260710024952.1668911-4-irogers@google.com>
Subject: [PATCH v4 4/9] perf ui hists: Fix uninitialized stack memory free on
 pstack allocation failure
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, jistone@redhat.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tianyou.li@intel.com, sashiko-bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

In evsel__hists_browse(), if browser->pstack allocation fails, the
function jumps to the 'out:' cleanup label which invokes
free_popup_options(options, MAX_OPTIONS). Because the options array is
allocated on the stack and wasn't initialized until after the pstack
check, this passes uninitialized stack pointers to free(), causing heap
corruption.

Fix it by moving the memset() of options and actions to the beginning of
the setup sequence, before the first potential error bailout.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-perf-users/20260709035230.6DBEE1F000E9@smtp.kernel.org/
Fixes: f2b487db45f2 ("perf hists browser: Fix possible memory leak")
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/browsers/hists.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 6edea27f4f30..7842f228435d 100644
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

