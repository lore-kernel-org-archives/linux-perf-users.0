Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8B9381AE2
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Jul 2026 05:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784782808; cv=none; b=Txvm4poO8PhbrPzqvS2xE5vRkJbLi5EjEGj0kibPuRzUNSpEvfn10gCHNa+/GKyJjLQS0NcsZ+JP1Ne0wnk+i7vdN3rMOXs2mfqNjX2GHTIe7dLwnb2xx4sLfscM1mkVzUhLClWI9VrFHl3tlY3ROKkD2Rftsx6HOYBGS+ydHUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784782808; c=relaxed/simple;
	bh=j3RyNGJQm6/v+IqvksTWDcljilmfSjd3LPLSfoQI6YQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ksiXDtrXkvjynLlNkRahYBM23Lr0yvhMIaStdMF/C/RxK+XS2AwYFIgAb33qZWul9z8tm5D9skjGdWa+dJKpAcQPpdMsc/KfRmiTQ42TihFVUjRQxuyTLMdbHXdHHBiN2FPrCKpm9S0Xr1sVgqaB3wLPXLiXjsIhYyBoSNhMa+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bw5U6mJD; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bw5U6mJD"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-381abcccbf4so266906a91.3
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2026 22:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784782802; x=1785387602; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sy1dwP6iLFsv4/zr7giqLZJWbJhcgJGpvJeI7JuRXnA=;
        b=Bw5U6mJDS/QeQSMHcn7CKz2/88/p1sQ2iL68HVy8oOuNYon2liU2tq99jz/i4w6CVF
         chh5gl1DyZIOjI93Gdp0Topm0PEkkkF3rp81DeAPY2fV2nJ7jQ2Uj5nGw055668QHPQP
         QUkXzYvnT/86cN4GvHGvbK9SjfZqXPQyUCs3/pasJNM9VSh8qB/u75yAHzb7pg7Q5IpR
         RG0/2bQchCazDd0ExotZDnHnsjygBXrDw2A+L/CDBBHutojPVAXJ4fyzEMXncnClUbQy
         Y/AFji8aIVQCJC7y3rI+Vez0slfJn3n5dYYCG64UzmieOfYZ+rPRIb5SEwam4H9QBCiz
         F9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784782802; x=1785387602;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sy1dwP6iLFsv4/zr7giqLZJWbJhcgJGpvJeI7JuRXnA=;
        b=FyXH5/1EpWtPajbFTs4JmfaG6i4X/IlA19LR4qdmUm0z8zrSrRKQg4tjGY2gCQG/el
         JocwKxJogBS4ODBnumNYzXIvFJMtLqRmywbHL6VjSlvhwsd60jUj9AE4y1MwhLCbY+7s
         CvNejaMCw/tcOzAwMg41+lgg4MbtM2Kfs9eyfV+Xcah4QWfB7z8wnH/biN6OLTkaKc1s
         rhU+g+DI8ZXQEl3zlsCSEMma2BpoWxn8Sbu/prApzJUAXFQEfi6afBXxSyjCK5sNVUR5
         ScdKmTRjNTkdQEMhhbZ2PiYGJYbqEpZSYReXV5dPJAvB+ixeHrd8aETPE9FT/i2LRm3c
         AHbg==
X-Forwarded-Encrypted: i=1; AHgh+Ropj5v8Kr8Grd8AhPcde7i34EoN/vSE/PQBYAJjgnQlu5N4RIP1aj24K3DOVyPGZunMBvPTqAS5PG+Sk5JpegkT@vger.kernel.org
X-Gm-Message-State: AOJu0YxWaQ21AVGYtr9EXcVe6yYhiAKA6/EEOzFMzCYH5IjRfAYGsnmf
	g3jJatPZPW6vYST2sABoPWuu+heSNR/4Sn6Rn7aWxgvnVRvobuUNWBHEldhHsc9viiTV1+gu4uA
	i0v9ISI2GgQ==
X-Received: from dldz20-n2.prod.google.com ([2002:a05:701b:4194:20b0:13c:ce0f:370f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d52:b0:387:e0db:bc26
 with SMTP id 98e67ed59e1d1-38ec6600a76mr1485243a91.38.1784782802112; Wed, 22
 Jul 2026 22:00:02 -0700 (PDT)
Date: Wed, 22 Jul 2026 21:59:47 -0700
In-Reply-To: <20260723045949.988740-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260716072351.560311-1-irogers@google.com> <20260723045949.988740-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260723045949.988740-5-irogers@google.com>
Subject: [PATCH v7 4/6] perf ui hists: Fix dso_filter reference leak and exit
 zoom cleanup
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
states for dso, thread, and symbols upon exit to guarantee immaculate,
uncorrupted state across browser tab switching.

Closes: https://lore.kernel.org/linux-perf-users/20260709170834.52F1A1F000E9@smtp.kernel.org/
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>

# Conflicts:
#	tools/perf/ui/browsers/hists.c
---
 tools/perf/ui/browsers/hists.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 684df550ba49..39d83f15f23c 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2651,13 +2651,14 @@ static int hists_browser__zoom_map(struct hist_browser *browser, struct map *map
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
@@ -3025,7 +3026,7 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 	struct branch_info *bi = NULL;
 #define MAX_OPTIONS  32
 	char *options[MAX_OPTIONS];
-	struct popup_action actions[MAX_OPTIONS];
+	struct popup_action actions[MAX_OPTIONS], hotkey_act;
 	int nr_options = 0;
 	int key = -1;
 	char buf[128];
@@ -3498,6 +3499,13 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 out_free_stack:
 	pstack__delete(browser->pstack);
 	free_popup_actions(actions, MAX_OPTIONS);
+	thread__zput(hists->thread_filter);
+	dso__put((struct dso *)hists->dso_filter);
+	hists->dso_filter = NULL;
+	perf_hpp__set_elide(HISTC_DSO, false);
+	perf_hpp__set_elide(HISTC_THREAD, false);
+	hists__filter_by_dso(hists);
+	hists__filter_by_thread(hists);
 out:
 	hist_browser__delete(browser);
 	free_popup_options(options, MAX_OPTIONS);
-- 
2.55.0.229.g6434b31f56-goog

