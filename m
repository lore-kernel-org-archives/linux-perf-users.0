Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880E1385D8B
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 05:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783661796; cv=none; b=aSaaEjvANsR4U+TjiKW/4B+6N2B0TsvkRQiycHzmgqbUgkh2B87zCdbuC3batrW8tXO+DH6FN0uE5oQaNmXwDYeYuB+0nhrp23Ne8ytGd4dZkbzXWwnMDsoxrxZJ1E1GtoN++Hc5zmSV8Kseb4WYt/h9Pfs9OnI4mcHiOoa6qbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783661796; c=relaxed/simple;
	bh=S6gwytXujPZnfbkKBwX82Qv7tlR4dRPaI/IvahTTyeo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ofmfMy6K4icy0NH5/A3TUIq2LwmEhSMjgOzI85r4kgK7na4oxGYL6ZF5hiF8GAFLYUk4r8pLYDlH3gNnqWsX0kk71+Yu5t6vmnnviWmABc4RFAJIRYKrNXxmDLuRwg2FGxCMKDFYtNH8qEb4BQWko2uDsALxG/7EBbkfoaLFjbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jOGYAGnW; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jOGYAGnW"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-ca8aee88725so697958a12.3
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jul 2026 22:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783661795; x=1784266595; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lnVCrg8JHp4P5DBlPV06OCsrtn/Z3va+gJWdTCdUHl4=;
        b=jOGYAGnWM16sH+u2lGIA8ooyQkIMQqHWz7l+7VjzjdmwdYVL4KllmpmzDnNeAF7G1E
         1QiN3BGPq1vWMPzLcnYcq+RNnJojrjd4bIXFECODccUvQ488AcaHQO5o+3Wfkphl4rHW
         01nXPCIGi1i7Z91eZjDQ+91NP9E5y0eC/80Dhw2UvkQEG1PjiFBGMUYlwW7wouOGlKNz
         0zcreXDPgXmLGl6MwYd2BYS8bKc9/JH/8oXtxike+1PNewPPjgfmTRkYM80ffhYgkSui
         m/4SAOLMDbGKpDFmlJqosO7upte/snexikycHRYcizySNQDRlnDF5KyyMnttumuoOMRn
         E74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783661795; x=1784266595;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lnVCrg8JHp4P5DBlPV06OCsrtn/Z3va+gJWdTCdUHl4=;
        b=EAsB7EXN3/Gnw+y4rumgrTRcKcU7UyTHFYT40hoxwyEDIp6yOos/89xmtUNdIbZGNJ
         68aPusNbdJt1sEAXMOyiPteax/fLe1WTRdNNBu/fxTrqHAWzfCiy4IMvswG+HBzISPpX
         0p6XCriZZqiihA+UylGeEfssEI7Nshxq5JewAvKFukU8uKfu2vuA5fKhuc4Tmim7aF3C
         iIWtbs/wT6T4OZwAT10WMp935225mBsXtOMJlQ+IWBDPSks+F1+v7XHzH9kBx2ZBsEq6
         Zny4fKHbO4N0qO/Tr9x69PxN6mdt8nswsVN+NTjWeeHaWIASRMeVvMYNRsnwzjKpRq5b
         rI4w==
X-Forwarded-Encrypted: i=1; AHgh+Rrp1C9Fk7gRUL+gFjJj0MsDU1VUtYcSacpQTfn2I3sLJRH7I2tPKqmKxn68aZNoCKWbQ5xgYmGdwnVjP3+vLn/F@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjn3Ff/c2hXnZ8dkKEdYWnWHrkJdsKUnCRAN/Y0mgQutfk1ax9
	/yP0qeQC7yGsLLEUbJkm7YtEyyzZRp37nliohwIte+iBJ8mwZasjwDVBewb7NVqbXOn5fj+EKlr
	XA3joNtv7Lg==
X-Received: from dli7-n1.prod.google.com ([2002:a05:7022:287:10b0:13b:848c:abaf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:394b:b0:3aa:c964:3c27
 with SMTP id adf61e73a8af0-3c0bcbbfb4cmr12175650637.46.1783661794695; Thu, 09
 Jul 2026 22:36:34 -0700 (PDT)
Date: Thu,  9 Jul 2026 22:36:19 -0700
In-Reply-To: <20260710024952.1668911-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260710024952.1668911-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260710053628.1861645-1-irogers@google.com>
Subject: [PATCH v5 01/10] perf hists browser: Increase MAX_OPTIONS to prevent
 stack buffer overflow
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, jistone@redhat.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tianyou.li@intel.com
Content-Type: text/plain; charset="UTF-8"

In evsel__hists_browse(), the 'options' and 'actions' arrays are
statically allocated on the stack with a size of MAX_OPTIONS (16).
Further down, the function sequentially calls several add_*_opt()
functions, which increment nr_options without bounds checking.

Depending on the context (e.g., branch mode, scripting, annotations),
the sum of added options can theoretically exceed 16 (potentially
reaching up to ~19). This could lead to a stack buffer overflow.

Increase MAX_OPTIONS to 32 to safely accommodate the maximum possible
number of options without risking an overflow.

Closes: https://lore.kernel.org/linux-perf-users/20260708235834.3FB771F00A3A@smtp.kernel.org/
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/browsers/hists.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index da7cc195b9f4..6163cc3ace27 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3003,7 +3003,7 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 	struct hists *hists = evsel__hists(evsel);
 	struct hist_browser *browser = perf_evsel_browser__new(evsel, hbt, env);
 	struct branch_info *bi = NULL;
-#define MAX_OPTIONS  16
+#define MAX_OPTIONS  32
 	char *options[MAX_OPTIONS];
 	struct popup_action actions[MAX_OPTIONS];
 	int nr_options = 0;
-- 
2.55.0.795.g602f6c329a-goog

