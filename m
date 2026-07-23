Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB9B345ED4
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Jul 2026 05:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784782810; cv=none; b=lkSxitMJLWr01dEGdVsfMz6w010w+nZlqlCdtfgPacC5+tygxWKcS99dIPXSJGscfooL9RHJrgIg8KlXuzw1R7ES/Q42QQFBRVb/Q1nMPLpvVHx6NUoVbrvUSbF/4YTitGVGcy3YdL2wc9v5tU5BFmcSiVuI+zyHgNHCVjoqJsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784782810; c=relaxed/simple;
	bh=RzionsZBC4nGIpNtaWh0rkqJMx56hR2GsoejTa1KkSg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YiQ6I52JsjKqMJJyTSdGtWet8m9yzt0ey8KfXcFRYxu7BeDhBJNrl6r4XO9GnyzJHcM7pgr83vtvjohhmLeRcZf7vFaqiXZ65CNCLmOlC3u5+DQd0pKz87lRU/Nw438AYLFzq10Rrw63eA+tpz+R6JUvQxCRl0Reu1m7dVnVQUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FL/mGxRd; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FL/mGxRd"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc5faecf01so8364165ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2026 22:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784782806; x=1785387606; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nunO8+EI5kPvayGER/zHbSlU+wwbYV/SYd2Npga2rpI=;
        b=FL/mGxRdP4CKIfPylgpWTQSMgSDcucAImIQePEu7pIFsm6GaZ9J6ujY3xtYg9JAYWB
         4xmvBLJ/JuhvF3bswpYvIEq9BVA2Pw6PVgxn6cprL/vB0ED9RxhpYPNRJxky+0QVamP2
         lURPBSU34tIbA4a/h4z2ZrJ+CSQtMPbS/p4dsMFl9ed8XWUp67lQ/pkFDONFcwh7E2R1
         0cr9KrwahTiJhCJgbhOo3IvlfnPSZGJXQ/ObFkqIv8yBk2A42PAI8pgNVrXj9DIDR6NQ
         VKzjg/iQdrDYLpQ1U7XwzxcFJiIJEGGKyTD7XzxZ5kM25nNyerxaNklRar9BEzNMXfJz
         BeLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784782806; x=1785387606;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nunO8+EI5kPvayGER/zHbSlU+wwbYV/SYd2Npga2rpI=;
        b=dr+xm/S7odJGTo9st+IQ4dGv/djsGDda98NEgPwOiU2R5vSYqTDCKywxAICg57sZct
         ibapebKWDHqLn0KjfEsiwAJh9Ye8gB3BX2uMxcpCWjNDRtkVybZgj16yneWlSrbOMkwl
         NW7xrPKUOJmKuIG8Tg0nuFyC0n4IOp1+t9odD6XgnJNZXx8KA+8MNgxrEHtJ0YgmYWNH
         8lGQo59t4ROUSVTqtBFtgf1Np5gY3HPifoCvHkhWFNM6ggEGcgOalnV9QGYk9DrhuOXz
         oqJ0LUxgLXXpnpFS3pwLJSGH7c7qMBtfbWEI5RK9Y4AaM9qhZIoxs1dOLLCyFFLNqcso
         8jLA==
X-Forwarded-Encrypted: i=1; AHgh+RpybXn7kCUvxCoYwRXaS2X9lrXHtH4zjBpjO3qOV8fSM4FfVMyLOiqpwYrggji2S2tBjsDWRHl/1/WJ1lSD6Mz/@vger.kernel.org
X-Gm-Message-State: AOJu0YxycqMSxDSeC8QsP9HFTIulrDzsCjKBa/42/HfGquiOivyRnwsu
	TBUSqJIRQ88tTrbtyKYfF4SM/RlYbHSkzo8Wzx1e/4FzCTMXTRPnfeNoSR8pnSOS+9jE3ZzBFoq
	aoxg5qmmZtA==
X-Received: from dycam20.prod.google.com ([2002:a05:7300:fc14:b0:30f:3f53:35d3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f54c:b0:2c7:f4bd:91b5
 with SMTP id d9443c01a7336-2cfa6b7aa7emr19683085ad.0.1784782806110; Wed, 22
 Jul 2026 22:00:06 -0700 (PDT)
Date: Wed, 22 Jul 2026 21:59:49 -0700
In-Reply-To: <20260723045949.988740-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260716072351.560311-1-irogers@google.com> <20260723045949.988740-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260723045949.988740-7-irogers@google.com>
Subject: [PATCH v7 6/6] perf ui hists: Remove duplicated thread in popup_action
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, jistone@redhat.com, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tianyou.li@intel.com
Content-Type: text/plain; charset="UTF-8"

struct popup_action has a thread but this is duplicated in the
map_symbol. Remove the non-map_symbol version so that there's only ever
1 thread with a popup_action.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/browsers/hists.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 39d83f15f23c..c15874a491b4 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2359,7 +2359,6 @@ static int hists_browser__scnprintf_title(struct hist_browser *browser, char *bf
 
 struct popup_action {
 	unsigned long		time;
-	struct thread		*thread;
 	int (*fn)(struct hist_browser *browser, struct popup_action *act);
 	struct map_symbol	ms;
 	int			socket;
-- 
2.55.0.229.g6434b31f56-goog

