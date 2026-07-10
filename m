Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B5735E93C
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 02:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783651811; cv=none; b=r474ya2neWdimieSVfSRh+pRPVTWT0EU9gkJ0v1iJ5ywJYyGofK08KU8lZex896SZnhKd161TAZROB3w/jGecACkeMQMmsrOvYufxUrJwdckvayocrOJzUAch9Yof448T9eqii9+gA4zF7Pm9KeT4vEJnsazrc+mteJRIcd0rH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783651811; c=relaxed/simple;
	bh=aLrdUsKBPkxe8W7XKnlq71dE7qoZhDxHoTRdz7WsJx4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r3b57zaXM9G4ZrCs9WBp8kXZar7E9RGgbjGKwwJpqx76NAPpiPgQtWy+yLg7ZDrqXU+dZb+nbzsfFlSQiXCvfZ1sCLp6DD4N9IDZ6jojhfAe+l9HmquS0MXQQVUyrZNxhgcVuRg54HUd1alva8ofdMraqpRBQCPMDIR1K/bRyMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fzcVHcVQ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fzcVHcVQ"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2caf4173b1cso8812595ad.3
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jul 2026 19:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783651808; x=1784256608; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=amPCAuEE9m1ixtKlRwPJk8F3gqJm8SAyTVo7KgjKg44=;
        b=fzcVHcVQTFoI1vH8Vy9ySU/TrSYi8Mbe+PNk76IfBbZbINqRCpUwcua0M7CrQsXTdt
         OfGiL9T2xvPew0BkweSQuCPr0Xw2yDkwKmRVPCfE+6RH5OGTd422BXRFyjzF+rGBi1vS
         FyErKeO6hgxVye+A7OcJ7XiywgHudEtL7G4t7JNloRZMv4I8VZhL/zgZk74/jwqQMmGV
         vmdLIO9A1e7jlV85Hle4e7oJOEjMTn5pBir1tqueTX/pwtqHp5jQe6j3FtDK8goDOBRi
         LvwHmYqRlSg/mxoX/duu9N3F2YqKOCeMel4evhsc9InHpHaRnBRqA+ZXahI+G5L1eUY5
         ZGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783651808; x=1784256608;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=amPCAuEE9m1ixtKlRwPJk8F3gqJm8SAyTVo7KgjKg44=;
        b=nWTM5vqoSAPE41xjgNWwsDliSD7HSDdZwpFwNRyeDDFrVnp3NHBlBx7RkwfPBGuFOL
         GpB63VOsV8IfN7R0NJhciQ3rLa37Y3p50h5DdfkwjEIuxA+pqa/PsIcKdkA6NWpLAQb4
         vAoG6KqB9fugIqr0tnoc/ZtWslvQS7qg/cRz9KJQc3iCfCI0lcVy89Z02UNkxfdJWFg0
         XzcBxHuDFYFv1d0YJHIi2BPAnalxEnkxvcidP2+vjGdvjnFQZvrL3V9kJsTP5Do0LYbh
         NOm8frjHetasNhhdQRt+T5+aEKnV7g8qVnz0+gfFIAcjWr1zq3hJkdQn1SfrVNuD0jAR
         JRHA==
X-Forwarded-Encrypted: i=1; AHgh+Ro14IfRydVMoCccZQkwKvC84CyJAfTvaPR2gOlepwfWd2AcJyRrYHrF3G98oR663PCMtwDhfTyvND4/6EHhkdkz@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+91LEaN8I+JSgiUypXSqJnQm0MmGYGt2tHIiw+cxX3sBoWTnq
	gbJkp5V3l/pNx1ADqBKZmE1u7yq5uT2dz7Kcmwa2y0ZWWHCrL3Wzgf9JsbHvQBUj72b0zsjHTHt
	M/3pohJXQ5Q==
X-Received: from dynm24.prod.google.com ([2002:a05:7300:2a98:b0:30f:1b33:c790])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3f4f:b0:387:e0db:3fad
 with SMTP id 98e67ed59e1d1-38942799755mr9799346a91.38.1783651808268; Thu, 09
 Jul 2026 19:50:08 -0700 (PDT)
Date: Thu,  9 Jul 2026 19:49:48 -0700
In-Reply-To: <20260710024952.1668911-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709165220.1411149-1-irogers@google.com> <20260710024952.1668911-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260710024952.1668911-5-irogers@google.com>
Subject: [PATCH v4 5/9] perf ui hists: Fix memory leak in evsel__hists_browse()
 interactive loop
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, jistone@redhat.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tianyou.li@intel.com, sashiko-bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

In the evsel__hists_browse() interactive loop, the options array is
filled with strings dynamically allocated via asprintf() and displayed
in a popup menu. However, if the user picks a hotkey or triggers another
menu iteration, nr_options is reset to 0 without freeing the prior
strings, leaving them abandoned in the array and leaking memory on every
menu event.

Fix it by invoking free_popup_options(options, MAX_OPTIONS) at the
beginning of each menu iteration (covering both the while(1) start and
the 'do_hotkey:' label).

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-perf-users/20260709170834.52F1A1F000E9@smtp.kernel.org/
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/browsers/hists.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 7842f228435d..70f8a820d0a0 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3087,6 +3087,7 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 
 		key = 0; // reset key
 do_hotkey:		 // key came straight from options ui__popup_menu()
+		free_popup_options(options, MAX_OPTIONS);
 		choice = nr_options = 0;
 		key = hist_browser__run(browser, helpline, warn_lost_event, key);
 
-- 
2.55.0.795.g602f6c329a-goog

