Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012813BFAE8
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 05:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789621659; cv=none; b=fOqpQJoG94+NM95jwCJE7/U8UkF+pJH7KlsI2LF4x6mAhuvAtp9LSuL58ECTU6aGnVQSfZuAhJKtBdPhpeCPyg/peTzcGuAP858wj2MvSKw+i3yg0KF3ceZk8I9U0LXymPDgP+j96cjAcKZJCN04lqXeAFLUYY5DV5zvaZw3Eyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789621659; c=relaxed/simple;
	bh=B70u4XR/u4bWLXwrT+O9TY/BXXytfR5Z9wno3IAJ7xc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ic/ZRmrVFsnSvo+MHWNA8LPUIu1SGmAS4K5zy4PF6R9XO0aoJ7xsK2Og6K72gBH9R5sLmmAR1asAatEHcPe8VsWs/rKkjvl+J0128uVxy04ixUVzq1OPPVi3cMA4XhwP8rm0sdGQlMjnOK7vriorb8G4F/cKZHIYse9pTGLAyvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SrDTmwVh; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SrDTmwVh"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-398dc3d8f0fso460563a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 22:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789621657; x=1790226457; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AUMujXU7xT8HywyfxATwqV+1Kl/xa26YBCifxmUb964=;
        b=SrDTmwVhVWjlzjyAMKfQ4E2cLIkf06XCijaK4u+SH3+XSCJO3bRAVt6gNghTD7LBSq
         aULdBpVxSRo7pG2BiNltx3LP1OIB0tFzVP3sKwr39pzD5up+fYdTtAtLCcq7SKl6gTbu
         EvEJmorDelXKxh5fg8cEjj++r5GBySHbxA/dwjzZG6RFcstnHc3BAh+ksdNmHUhZn1Ub
         mebby0UKedjT6WGv9KsIOa/sj/9unprH8WfBZfM/yuYvchSJXuSxHYpNYfo9gyzhI1LU
         cxQqqkSS1q27CeIRccj/P8CvQdelp5IoqJcb5BKgkAwPOehx98/HXHaLFyCwzouUGZvV
         kAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789621657; x=1790226457;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AUMujXU7xT8HywyfxATwqV+1Kl/xa26YBCifxmUb964=;
        b=dEDGb6aSKsfKVLEOs/MbkjScshQ9s6s0S/uK8zugzvi4OBtZSgX8hza/YzAtJQdL1L
         FXxUEqT5JAhBYYY94XE5L3KfHmQgCdGCKHg8cJqJeKP9w1g9yaodKob3p2qvofscVlLB
         XLX/uogmV9V4jeT0GslwRfTrv8aNt/POdz6CetpRkS6ibTXcsL8B0wVD72PHD8fYADlP
         D2DzxycdEwfozX/P9q1dXakhPkpzCPjWkW/BQjbLoAp4nZQw1kzAmENoJebCtOiN0evC
         fotYzudL3Gf0jtVztUOtv2A5+30tMCr5qTUO5OwKoMnc/rJ+h3cgFY2TTwfrt6UiVG0H
         Hy6Q==
X-Forwarded-Encrypted: i=1; AKwUvBzFuXC4WMWvsKuMmQrEDe4Z6PTuSIXzsyBsZc68GYY6JCl4sF/2B2w4DO2KFf204fnwoBYlZbdJ74/bbhf7U1EL@vger.kernel.org
X-Gm-Message-State: AFuF++nvq1d3Zt8SYMjtv3DkVrNAVS2lB8FK3NA4GduKSvE/Mehg83aH
	ER4WFhaPpv4u2h1wj20FGKZq/QA9cK2qqynvTlakVhYTUigCURNiUqhzPHGo5hysxV8BJ8pm2Xa
	blZjQyCKlvg==
X-Received: from dleb1-n2.prod.google.com ([2002:a05:701b:4241:20b0:144:4896:d41])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5743:b0:39e:4343:857e
 with SMTP id 98e67ed59e1d1-39e43438715mr129146a91.15.1789621656998; Wed, 16
 Sep 2026 22:07:36 -0700 (PDT)
Date: Wed, 16 Sep 2026 22:07:05 -0700
In-Reply-To: <20260917050708.704702-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916234652.439778-1-irogers@google.com> <20260917050708.704702-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260917050708.704702-7-irogers@google.com>
Subject: [PATCH v4 6/9] perf tools: Add TUI hints for --hybrid-merge
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: ak@kernel.org, ak@linux.intel.com, andi@firstfloor.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add dynamic TUI hints prompting users to restart with --hybrid-merge
when heterogeneous core PMU events are populated in the sample view.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.1-pro
---
 tools/perf/Documentation/tips.txt | 1 +
 tools/perf/ui/browsers/hists.c    | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/tips.txt b/tools/perf/Documentation/tips.txt
index 1c7b309fe6e8..eb6d56d4d8ba 100644
--- a/tools/perf/Documentation/tips.txt
+++ b/tools/perf/Documentation/tips.txt
@@ -67,3 +67,4 @@ For parallelism histogram, try: perf report --hierarchy --sort latency,paralleli
 To analyze particular parallelism levels, try: perf report --latency --parallelism=32-64
 To see how parallelism changes over time, try: perf report -F time,latency,parallelism --time-quantum=1s
 When merging events like cycles, different core frequencies and instructions per cycle mean the counts may not fairly reflect time spent in a function.
+Use --hybrid-merge to merge matching events from hybrid cores into one view
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index f62cb2d534ed..593e1fd5759d 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3580,9 +3580,12 @@ static int perf_evsel_menu__run(struct evsel_menu *menu,
 	const char *title = "Available samples";
 	int delay_secs = hbt ? hbt->refresh : 0;
 	int key;
+	const char *help_text = "ESC: exit, ENTER|->: Browse histograms";
 
-	if (ui_browser__show(&menu->b, title,
-			     "ESC: exit, ENTER|->: Browse histograms") < 0)
+	if (!symbol_conf.hybrid_merge && evlist__can_merge_hybrid(evlist, menu->env))
+		help_text = "ESC: exit, ENTER|->: Browse. Try --hybrid-merge to combine events.";
+
+	if (ui_browser__show(&menu->b, title, help_text) < 0)
 		return -1;
 
 	while (1) {
-- 
2.55.0.1082.g2b9226bbc0-goog

