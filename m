Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C24B3EC6BE
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 06:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541587; cv=none; b=CzsTf4VV6JQ0JY8Z+nKsaXDSPkzNgnHPQo5SSBcSqM8tLlXPQiPaIm2a/6R2V+kv6QwJnFJt1HDfFZE5Mw0cJjVx5s4pBYxBWL3z4b/LUr6kqO2UEIaJWkjsTVJM4uttWclOYDg32w83Rc+iyVmRw9/61xaA1mBRBBlkKOzCX9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541587; c=relaxed/simple;
	bh=0nFryRP/dhViH1GF3BUul5YBztZgmkNpwdwSSaMD81k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AEfCmaWfvDHQSlw/1sYDOBV6E1YLMaEsIiB2YNCTLho4xXnFhPdItLaTycEd7arQHEll2blq9gugn87ta5MEufFhc/njnarc3/hqa4wVGt9VEEGjr1JzXLEFSs2SiUcCws0BbADB2NOD1w2T5GfBHvlkznBWNjq93OTN4qKz31k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gxZNKgoH; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gxZNKgoH"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38dbf293831so11648939a91.3
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 23:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789541585; x=1790146385; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dS6VSmsS6q3MQ8U+5yDSLoCKYs2PDu6l2CB09vOGj54=;
        b=gxZNKgoHdzBMGraDbt1YYnnSPn4GwxBnQE6yxSbpfKVBKlDFEMFatQoYvt6NNwvGU/
         N0x9NS3VCe4Gyz0uax4VWFLbisjk5vPIXBpLdKAa763os9f3kxy2I/rdnQhhIX5FgW6P
         3VFYECglWmXu+OXHrn2qR73tLJkCwW8Kx5v6oZlyAhaBM2Tpfz4/n56MKYOYZiKZhDbQ
         s5Oo3gNY2NBKzcVluEWDSAJ7zZex64y+Y8edbxFD/yYwOGdhok/zHNsNv8p05zL+ME5S
         sEkTZcpCvEA6kIjV0pGAdKTSHJhbc68sRHRQiDDL1hITuzF87msbxJttosIUJdyvNv9M
         5HrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789541585; x=1790146385;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dS6VSmsS6q3MQ8U+5yDSLoCKYs2PDu6l2CB09vOGj54=;
        b=O04XVpJd6YvohakFJ/G3QGYH/Ee5il515Lt2arQzt0TFzweDzV15IRiv9nYlK7b7Ly
         fcXUIogReVVT9mFcJIVmIqH0U7Tz2OA9uDf4opi1Siz9wkVNWKj19j1IekovnVMd0DKW
         k4/nbUDqjJZbvzriVm2dAdxKqhvvEUizUBwOi/2j0OC/0cBZSmgtrpEtG1LKOEH5982N
         J5CqdwwExD4xbb6a8tzl8E+7KmOnKaVJ1uEvo5of7zjPJonNtiUlcHjC4c0vUmKnMB9l
         gayiQ8T3tUEur+bVvC50xsCaD+X65xB/vBFzNbriBNODAD6lQXllKVezHOdeVpMoBJCJ
         NCUA==
X-Gm-Message-State: AFuF++lNI1uvNsn3l1aV2d87bRSZW+6tm51DyV9o5Nxsjqtj4CcnxIV4
	QyhFvQMQPGsraXpeCYCJvjbQY1cClmzQYC1Cv/lIS5oiXZHmLq4tbWGkPZNBMqwFoQNigToKJs7
	kYRW7EGaedg==
X-Received: from dlbqq3.prod.google.com ([2002:a05:7022:ed03:b0:143:5dff:1bf6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5803:b0:39e:1329:7816
 with SMTP id 98e67ed59e1d1-39e1e484be6mr3590959a91.15.1789541585249; Tue, 15
 Sep 2026 23:53:05 -0700 (PDT)
Date: Tue, 15 Sep 2026 23:52:45 -0700
In-Reply-To: <20260916065248.3153556-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916065248.3153556-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260916065248.3153556-7-irogers@google.com>
Subject: [PATCH v2 6/9] perf tools: Add TUI hints for --hybrid-merge
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, ak@kernel.org, ak@linux.intel.com, 
	andi@firstfloor.org, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org
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
2.55.0.1032.g73a4cd73de-goog

