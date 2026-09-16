Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD48E4CA779
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 23:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602438; cv=none; b=Sbxvvpe/bMb38pP1uRACL/1ypyI+ey3WcLtWV0N1pMTOB3IEOiL/OfwGoWyf74+iH3Y1QVkmQWktJv2QoT0+pk4tw+MsuCkxioBV5DzcqBqyaC4alz+hzbbmiym91QWJrz+KmK2Fn27e1zqWLm2dMNtjqezjzSkH0hIjjXKSSfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602438; c=relaxed/simple;
	bh=B70u4XR/u4bWLXwrT+O9TY/BXXytfR5Z9wno3IAJ7xc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Wx3L7/MhdLWh8Li4TIOeKvXDBt3bzwc8h5PIksPYOdR5T7kBTtYw5xT4vw5pnDOpu5ptkhhQHI4jGgUpVncCuhI/xum+6gjNWOG5Zs+Z4p6Wod0XkBhLMZlzgudufiUp+W2jhmUSP02A7v7CrNEFGiHjwT8GCtSTDTdLndJ+2VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GfHIIzfJ; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GfHIIzfJ"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1cade6b71so185570a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 16:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789602436; x=1790207236; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AUMujXU7xT8HywyfxATwqV+1Kl/xa26YBCifxmUb964=;
        b=GfHIIzfJcmchdgRI6X14ixBENPV/aZz2tK80mw8wfgobHjMlXZ0azQ0WEHn7/Lwfgk
         9FKhfTaCmDoCq6RFK0NfVdJvVNUs0f7rZ7UzoE2LcmjfwlDRk5anS3b+fZa4tUd70SIj
         nlyIcAPQM3yVlpkVy9aM/66BN89e/4CFo8z/fD63J5XMEmaN01xV/Ztu9bVDd97rAnfY
         MPaqyhHgOomHsSSUuskfBJKHt4LMt8D6S+kF3sNb0DvvdFbSVjFJjsNsyZvXCoxDr4cQ
         evvWIM/jG8DuD2QjEuwsIvKQnCJruIoex+opqoNA+0uwzS4Nk4t3Lly9qnTMPMBYjf/D
         rFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789602436; x=1790207236;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AUMujXU7xT8HywyfxATwqV+1Kl/xa26YBCifxmUb964=;
        b=szOep4qa4B7vxmkEwgKyfzNNkS3QF5xSRJCALr3g36IKeNSTxHin8fyU3eIOwMpfl5
         VJVF38+mMSEbDHo4PrAUHx3hjz7MjfJN/CHvZaJPnqXmPrioElodV4MLaarsXyhk/deB
         +YOEppglL+QDsjVuapVC0XQNnO35l8G7uiXMtuMDlw8B+U79e/2D7X/vYeSzf45BQpxn
         Byg7ZfFzNNDUU/TyvEb5Q/AyMkSJgImZds8NNEQPegoRLVMiV+czbrtDYFc7I6E48/c3
         +E+ejgM2Uk9Rpl2gKtYpjf3kPrx2XhYPtj4od4oSyIJefpoeivqafzv/WckPu0ZlqypW
         4Nag==
X-Forwarded-Encrypted: i=1; AKwUvBzKURmMG2uCTz9xvMd9+9o8DbHXoTPoEqRegW0plQbSd26NEjc7bExvpOk8qhjYr8Krn49hjawNgQhTFmVtr3pl@vger.kernel.org
X-Gm-Message-State: AFuF++k+YcEsBUI5we5Ru4jNqR/SDprV2kW/k2WxIeq81W4jXDzp5XdF
	0ZY8/r/7DyRMNRZksYB1+jE3U/mUbAdsuy9KXz4yDn93mVmm5oZXCjQJ8/vW31RcTPJp7N7MOhO
	jfEN82sPFiQ==
X-Received: from pgbfm6.prod.google.com ([2002:a05:6a02:4986:b0:cc4:c02d:3b42])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9192:b0:3b3:a66e:3911
 with SMTP id adf61e73a8af0-3dd726822e4mr2090641637.19.1789602436197; Wed, 16
 Sep 2026 16:47:16 -0700 (PDT)
Date: Wed, 16 Sep 2026 16:46:49 -0700
In-Reply-To: <20260916234652.439778-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916065248.3153556-1-irogers@google.com> <20260916234652.439778-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260916234652.439778-7-irogers@google.com>
Subject: [PATCH v3 6/9] perf tools: Add TUI hints for --hybrid-merge
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

