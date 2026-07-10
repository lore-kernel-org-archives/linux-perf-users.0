Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1691A35F60B
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 02:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783651816; cv=none; b=s7+S+mE6eUKq6MBP1RyGoxTRwL8iEDjPdStUlPyIH0cl1xpDzr56VWWImiQvrSfzgHhkQH2XZ62WWU8bPunTiVRRNJaHCxzzJs7ZuD+AgACkcsxPSESRCJ96CjLWaW7oV+/9mHq3HliIXjDLpY2r9Tenx0hmQTE2j6rIPAYjYOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783651816; c=relaxed/simple;
	bh=AgXLxl8PW1BnONZuaWiqVmOOr42lZgRvNS6FvV9eXsA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y24uhazeqaUb5dLwfLjqqdObtpfAsJJee4e3UeCKxzOVvTzC2k0xJLlA3EGv0RjAbSZE/pgFEUrcfW9cLuq1rlTtEEtljvULSM8Ck26eo6JLlZR4ranW5ZOVmOF1+3i4UijxZpfjb8597SCr9doHA73LMK3OE8Vinr0ur5HwEDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z0CNqK31; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z0CNqK31"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c88cfe287e1so470811a12.1
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jul 2026 19:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783651811; x=1784256611; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0C4b9wNx86J+gxHS0Ikya9C+nYyb9M130nL7lqmMkZs=;
        b=Z0CNqK31pot5JNRTEvITBAI631K8HuhPTSNYE821g7TlzPYEQKXCAsDNuapI9JOluu
         9KAB/3vCgIRNDJx++fg4j2RvTNcYCgH+WB7jK59St4urE72Xf6fzqKUMPh+mOicYiBDp
         /CekVz8jCK0UVbR5mlaT1lltb/2T1vW3iO4bxS+o9J5P4T+zmFQwBZD60Z69MDcf9Vdk
         xmNyVR3DmzVTxJnY5JTx+GvZCRyUW0Ftizu4gAUDczUJGrpYO0cZSqVH55eEEYy5vg9y
         nD7wEkCf4Qa0pkjR2iyrDYOERHmiPs6n1bmxca1t++UzSWz2q/n8Xbqbqqv2H/TEnVPg
         YLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783651811; x=1784256611;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0C4b9wNx86J+gxHS0Ikya9C+nYyb9M130nL7lqmMkZs=;
        b=ADyXnRXesuvmUdu7AYsAIfIGJ5roXG0OIem7uWAd/V15dJ+uT8W33S4pnsKg604e06
         160u3VMjCDj6YtKU2ImP2LUOlmkHzdRdEWNr3XAHhGeSZVd2rtvMNGT7W5mJsa+LvCLU
         QkZgUmOs+d5EZf/ynH9wGQiC+kAs2BFZSag119X6sHMERM2QiYZhOW/hzBf+wUtwMhBv
         q0N5GZt+sAklRw/rTKIeC9+fJULdNMkKS1GUjTT66CpS6nQn+g24qEjJOsrnyctI9lCF
         6fjutImnfZK2oO6+XuRsn+y0UnzE/QXJF00jLTA1BOG5w5MdIM5uf6khl7bcikdN4Tz2
         EV6g==
X-Forwarded-Encrypted: i=1; AHgh+Rraz93SLGQkwFPfMcWcaIb0pNPppzgMYctr2GSi4dxKRmahP5IsjbDpp4LlX5KZIKvUsUimRxvindWpV+JFpEAV@vger.kernel.org
X-Gm-Message-State: AOJu0YyymgS+SmQA7h9eu8IyEwILLyNbDy3kNTMxxuabOfnJpB9pYpvq
	sQIjdB4TDpMOU9tQYTPORunbtRUKspdI/KxR2OvNyk7DSuhZhUjYKwjaam/xiqwcYgsdLyVeC4+
	DpeG96HkNrg==
X-Received: from dlbcm27.prod.google.com ([2002:a05:7022:689b:b0:13b:340f:d011])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c996:b0:39f:2dd0:65d5
 with SMTP id adf61e73a8af0-3c0bcb7f203mr12201178637.39.1783651811161; Thu, 09
 Jul 2026 19:50:11 -0700 (PDT)
Date: Thu,  9 Jul 2026 19:49:49 -0700
In-Reply-To: <20260710024952.1668911-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709165220.1411149-1-irogers@google.com> <20260710024952.1668911-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260710024952.1668911-6-irogers@google.com>
Subject: [PATCH v4 6/9] perf ui hists: Fix dso_filter reference leak and exit cleanup
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, jistone@redhat.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tianyou.li@intel.com, sashiko-bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

In hists_browser__zoom_map(), the active dso is assigned as a raw
pointer to hists->dso_filter without acquiring a reference using
dso__get(). This creates a potential use-after-free defect if the
underlying dso is released while the filter remains active.

Fix it by properly acquiring a reference via dso__get() when assigning
the filter, and releasing it with dso__put() when clearing it.
Additionally, ensure that both hists->thread_filter and
hists->dso_filter are safely cleared and dropped upon exiting the
browser in evsel__hists_browse() to prevent leaking active references.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-perf-users/20260709170834.52F1A1F000E9@smtp.kernel.org/
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/browsers/hists.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 70f8a820d0a0..316db603bf25 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2640,13 +2640,14 @@ static int hists_browser__zoom_map(struct hist_browser *browser, struct map *map
 	if (browser->hists->dso_filter) {
 		pstack__remove(browser->pstack, &browser->hists->dso_filter);
 		perf_hpp__set_elide(HISTC_DSO, false);
+		dso__put((struct dso *)browser->hists->dso_filter);
 		browser->hists->dso_filter = NULL;
 		ui_helpline__pop();
 	} else {
 		struct dso *dso = map__dso(map);
 		ui_helpline__fpush("To zoom out press ESC or ENTER + \"Zoom out of %s DSO\"",
 				   __map__is_kernel(map) ? "the Kernel" : dso__short_name(dso));
-		browser->hists->dso_filter = dso;
+		browser->hists->dso_filter = dso__get(dso);
 		perf_hpp__set_elide(HISTC_DSO, true);
 		pstack__push(browser->pstack, &browser->hists->dso_filter);
 	}
@@ -3450,6 +3451,9 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 	}
 out_free_stack:
 	pstack__delete(browser->pstack);
+	thread__zput(hists->thread_filter);
+	dso__put((struct dso *)hists->dso_filter);
+	hists->dso_filter = NULL;
 out:
 	hist_browser__delete(browser);
 	free_popup_options(options, MAX_OPTIONS);
-- 
2.55.0.795.g602f6c329a-goog

