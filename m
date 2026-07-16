Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9223139EF0B
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 07:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784186658; cv=none; b=Y4eB15tfWjS3oUfbiGVv/MfFsDlZkIUk07/q1Zm3ORYVJ3gZaAcTZho+5Bdoz637hW2XBf18e8PniDwFSJ96NrfCuxLoa50iE3iHl2JANSHm6OYA4atpGDWtKWItRHOQhyx8k4Swh3EeoqMYWmsQRxuljHGedihDGjLLNfeaTWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784186658; c=relaxed/simple;
	bh=gYrVoGGZr3jUGzOtWjx2hb3N/ciwODKwc1OVcAxoEVg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P7MJRqwG3HTBebEuM5o+qiWxKbWB7vXQjlQ9DxElSABLpeAcjvFeISEvzYLm/HP9NT95wIQIxZeBSmuB3KXoKgWEhYe4DcwL3Vy04uJhW7JeWwPJb0x4M79SXn4XEch1X+KkS6mZtEFGHlf8+hPJm60bbWG1fP8ABJRV4A25vC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d4TC3zpP; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d4TC3zpP"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ce8a76df2dso111115375ad.2
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 00:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784186651; x=1784791451; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KEIbPrmbNyBENuD37d8Iz+SBXgesj55Xw4ZDnPL8sLM=;
        b=d4TC3zpPTX9U7YQjecdB0XLOvBkkkGdGhG/V7SUHStXjCSFBrJ56l3lnAOJ+bNZc+/
         4EqsDp10bSqJodYADkWd14mObZTVUaaIL8Ih9mfL1oCGBe9imv3cN5fWBHGIJFRaO9Lt
         UO2WJ+RrndfrN67eYRS4zF0S6GzQtdwN6iO64egIE41/2gaeAteo2J8rm0t7M5kWbJd/
         6JfNtHUXH7nD92H6YrqCRq4PnAUtywoW0vGKIyu1uKk9NzywuD+HCbAC8p3Ksi52UT+a
         JTbJhkr5uTW9dw5EUW3BSqQp+G2NC7uXTuRrLfWwV1bYG4zW4fBGWBTiC56vefV8mKMA
         aU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784186651; x=1784791451;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KEIbPrmbNyBENuD37d8Iz+SBXgesj55Xw4ZDnPL8sLM=;
        b=KXoMzMxqY+bWTfd/5RwR7SCk4MkorTEDOIr51RtLiKxff9TgndRtMmjYdaHzo1ByJD
         j0Zs90HC7BDzLBCK3q3XbaebT28TNS5gPB8LOTAKGGFpOhMknMJ8/FtNy7SsFS413Z/E
         8wx7YRDsNvcBbnj/wT61D1nbW+1RgEArZFscOxCD9vCyTqLBeqOm4fWtTkSvwTC/we4g
         i22MdDLzYHLsCtYQGVe0JEk4sBMao8WoAUFK+xRalaK4ZfC3eMzK2/cRM51IJe6Dvdtf
         ciqMO5lqSevWCAYdfZTOcCDBHoh7j0KPuVTlKkF02/JdG/KvhDNRMxJjy34hI4iMizIb
         gwyw==
X-Forwarded-Encrypted: i=1; AHgh+Rr0zA5oSSe4Fl9o51vvQfcrZAz9zJwGwQ+hJc0wMvZa5DuGM45+HDGWkgmywXG1lpUg0eeY8hHEF2zEEkOliSdb@vger.kernel.org
X-Gm-Message-State: AOJu0YxViqqVzItetltH/WfMyq36JBQXoE+S9L0v7nz7a6OS4vYkHneB
	UxoM9w5WhQDBfnkY2qTzh8nNPWlB8UjluF0fDXMcHZOAb/SgwRVXCTMaXLXxGQ42FXE9RSm3h7p
	kXQ7uzKSXQA==
X-Received: from pjrn3.prod.google.com ([2002:a17:90a:b803:b0:381:c4e1:61f9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5610:b0:381:fa5:521f
 with SMTP id 98e67ed59e1d1-38e1ae5f652mr7708111a91.3.1784186650934; Thu, 16
 Jul 2026 00:24:10 -0700 (PDT)
Date: Thu, 16 Jul 2026 00:23:50 -0700
In-Reply-To: <20260716072351.560311-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260710053628.1861645-1-irogers@google.com> <20260716072351.560311-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260716072351.560311-9-irogers@google.com>
Subject: [PATCH v6 09/10] perf ui hists: Fix dso_filter reference leak and
 exit zoom cleanup
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, jistone@redhat.com, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tianyou.li@intel.com
Content-Type: text/plain; charset="UTF-8"

In hists_browser__zoom_map(), the active dso is assigned as a raw
pointer to hists->dso_filter without acquiring a reference using
dso__get(). This creates a potential use-after-free defect if the
underlying dso is released while the filter remains active.

Fix it by properly acquiring a reference via dso__get() when assigning
the filter, and releasing it with dso__put() when clearing it.
Additionally, since the browser stack relies on pstack__new() and deletes
it completely upon exiting, we must fully reset the persistent hists
structure by un-eliding columns and recalculating histogram filter
states for dso, thread, socket, and symbols upon exit to guarantee
 immaculate, uncorrupted state across browser tab switching.

Closes: https://lore.kernel.org/linux-perf-users/20260709170834.52F1A1F000E9@smtp.kernel.org/
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/browsers/hists.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 55dd1af9c81f..570d1c07ca23 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2648,13 +2648,14 @@ static int hists_browser__zoom_map(struct hist_browser *browser, struct map *map
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
@@ -3491,6 +3492,16 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 out_free_stack:
 	pstack__delete(browser->pstack);
 	free_popup_actions(actions, MAX_OPTIONS);
+	thread__zput(hists->thread_filter);
+	dso__put((struct dso *)hists->dso_filter);
+	hists->dso_filter = NULL;
+	hists->socket_filter = -1;
+	perf_hpp__set_elide(HISTC_DSO, false);
+	perf_hpp__set_elide(HISTC_THREAD, false);
+	perf_hpp__set_elide(HISTC_SOCKET, false);
+	hists__filter_by_dso(hists);
+	hists__filter_by_thread(hists);
+	hists__filter_by_socket(hists);
 	zfree(&hists->symbol_filter_str);
 	hists__filter_by_symbol(hists);
 out:
-- 
2.55.0.141.g00534a21ce-goog

