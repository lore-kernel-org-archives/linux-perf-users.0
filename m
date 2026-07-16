Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DD2345CA3
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 07:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784186648; cv=none; b=P53NBiqQNn1tgImdvXq5VR4q2wzsspW+rZNij33QcindYTiYRainMYBcR1Y0J4XalT9bcM1HXyT4by1fsTK8jKbP69EHVbw88f9Y3b/+3uBuH+MVrwaYoGiIg/WcRSoB+COSfwWliMJ3LYE6r5PF75O7WCzUN+eFmGDvcjeuvlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784186648; c=relaxed/simple;
	bh=V3CKY655jvssuX5wbgLMKNRXpIhsZ/RQAR7Ea+aV3dc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LyxJUugud1sGDGYIIQC2zaVf87mEeH7Gpsa3/4rb6YUKY/lMZFk9z362kKCRQDmKe4fle3Rbic99nMylcGzRCS2n7sPIdsFE8bbV1wO3fsd56gtpP+vEZebL+q+MDdBmDBcEK7wLbwo+HWTXM9occYMWW+bXnPKM25cL8qMTXdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dluSy+Qj; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dluSy+Qj"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c88da04b719so2801342a12.2
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 00:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784186641; x=1784791441; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dpkr39l7sOTtT3gomIyyA2FswdcfqqwWFusHQlL4atk=;
        b=dluSy+Qjk9+CI0oar3CN6VKSZnXh0OzKo4sTiQJEoBpd1IIgARAkEnQDDWm8UYKDah
         RjL1ZS0aDZMPKqTQvd/QUB84AWo+PwJkYZJiKEhnjLTrK5hu9n9/g1X3RJ/BjC4kanWS
         c1XGlGpdwEU3Fm36X9C93ACbTBei8cdXB7B+GfjQwRfeKTHQHngLVgdiVgMkFwIoq7nb
         Zw1X55k9XGhUct6Webe9oPDMnNB1/zWXLApgTtbK/WwAgaEPOegXNudM/P8T869Lk6FE
         oiBC0aUXFhk96A6b1RYbYHOekDpZeRs6QyEZWf/YSGya8nVPju30gPx4Y2JP1KDKLfcG
         athQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784186641; x=1784791441;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dpkr39l7sOTtT3gomIyyA2FswdcfqqwWFusHQlL4atk=;
        b=B21a/QPDrePzk97DDBRGsYG8QfCCas3JO6fblSsy7KqFVlwML+sDbAw958Lt6F8zs0
         62H7YYNoi9scW0Mf7JPokkvD5e29j1QenK61CtPe1V+r1I7B+e4N3q8v/H0UW5pVkkDr
         psKpI/GkEtSJ3lnLm0JrbZCyTeD94l8mqPmzEjPDu1zIfaR/fZR8/2wmBXOBPeVoPQI5
         ze+YCMyhARTgMJ9onmezZ59iPkt4Ez8lYKunGFMG0psTpZtT0+h+WHsLAQ3zTyVsliwy
         adWd+Taf9EOhW1pqF212kl/6QroCUwGs9crH0jax9uHYcPG90xY7mrATlCA8bg+Lczv5
         sKAg==
X-Forwarded-Encrypted: i=1; AHgh+RoUBZGQmlg3gHv8NkslzgY5qqtt6DyVt1cinUBXaUCPZ3DtABeSShYMwjIVHw70m1BKIgLb+F8yxXuMvPa6RBc0@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx6QPTi2JU4v+cmi/h3aDrj5PNVGwb08HadkF6FrPxki0u6EpM
	tdBE+T45Gu3mipam0uUBF0XoYhA3OCtDqGdoBi40XrF5MAA+kWxyrLAvZ5+ApY5ippsQEk7d2e7
	NYlBbERlcDg==
X-Received: from dlbsw11.prod.google.com ([2002:a05:7022:3a8b:b0:13b:9f1a:204])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:6bdc:b0:3c3:731d:546a
 with SMTP id adf61e73a8af0-3c3733bda0cmr4978220637.43.1784186640883; Thu, 16
 Jul 2026 00:24:00 -0700 (PDT)
Date: Thu, 16 Jul 2026 00:23:45 -0700
In-Reply-To: <20260716072351.560311-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260710053628.1861645-1-irogers@google.com> <20260716072351.560311-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260716072351.560311-4-irogers@google.com>
Subject: [PATCH v6 04/10] perf ui hists: Fix stack use-after-return in symbol_filter_str
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
 tools/perf/ui/browsers/hists.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 9a3844dc3246..675910893644 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3213,7 +3213,10 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
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
@@ -3447,6 +3450,8 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 	}
 out_free_stack:
 	pstack__delete(browser->pstack);
+	zfree(&hists->symbol_filter_str);
+	hists__filter_by_symbol(hists);
 out:
 	hist_browser__delete(browser);
 	free_popup_options(options, MAX_OPTIONS);
-- 
2.55.0.141.g00534a21ce-goog

