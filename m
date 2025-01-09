Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C766921481E
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jan 2025 07:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736409081; cv=none; b=MZA85EiskiBhgeNiaYVSP0c4YJVWesOeWpa2gtWNAVF+hpqmbo8t/igCE+rMQ7f/1V0ONjl7Gj6DHoLXeFy6eM0+Mp9ZUKsbjFpFQiWedJcVpPahAlR3sw08H5wPPrmf1HzlTPY9zO6JTG8E23yfPH6eJq+5Zmx0XnEgzB7uNaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736409081; c=relaxed/simple;
	bh=q5bMp7PJSGnNgxEfef9drZZDGV2cNpjnTsQPTbdE+eE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=sDJTQvgtz0ndrEH0SXYvMowfZfPJrVVNiwa1HnAf9jAYNodz3AxEp1YlCFLMMuRKZ37kyeipWwIkEwenKb/pbVqQsCulxIEKLQlYYCnc8dmn1PJ2Va+t8dldTqsIJXshVUrOPKoZxQEgJNRR4da46oPE+fRdXECNUg3j5qivMQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=noB7anb4; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="noB7anb4"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e3c61a11a40so1476996276.2
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Jan 2025 23:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736409079; x=1737013879; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BfOiQa/L9OiEEGjP9sXMi3rlBfHgK084BGp4CIjcSjs=;
        b=noB7anb4kVm8UcHMkZ3ho4ACYz6M01TGB9znVdUPA+SvRVipwC9t00M2gsn5ElCzU0
         EPvD/i+8Wf+o0XAF1yhbbLdzW1z+oQrQ/C0fy02QGEHAj3S/XLKc8kMyPOkps6WwGlR1
         X7+LIVDEmLzr8TVwD9fWY4uyIj4c/fB74JyMfIe5D0xovVk0Bn3b6b0vjJ+LNIfZ2GRd
         15hrVx4+9NmyIYGevb+sq1/ZK1GHxvfWiznp6RPZd0fM8xgmpCB48gw9vTNA0RAUYhtb
         T4UiOuoECJfcIjJT7ivE/F+JratwZgEAJlRJf1fUIV8CKgBxXe64qWgB+htTeUfCTCVk
         0EFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736409079; x=1737013879;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BfOiQa/L9OiEEGjP9sXMi3rlBfHgK084BGp4CIjcSjs=;
        b=MmTXon3ch6WlI+xp0SsAZUESdoC1rDl5/ydy2t/20GP1hFLH6+f1dQ26gED1rb/vTD
         VOxamXkz96D1I7klJYlekbvcSvopSL92ZzQMj9VziifOI7yosKVUGQ0G458vPKh0mY2V
         4KMPgKSR1Vcw84wLhIQOyhZxwr2uMQ0yKIHNvFFpSUcC6MIN3uGwUIU+IKrM+N6+r3vE
         DUO67WZLpTapH1U29nNI5R0A4ub59z6zMaRkhpRhUC8jZCGW6y/5+IL08+RVutaRTTM1
         cYBQFIofy9tK4h1+h+XDwRikN76Bwwi+MA7/nrV5htqFQtMYMe1VeIO42rF3FNfv94GI
         uShg==
X-Forwarded-Encrypted: i=1; AJvYcCVkBKiTDbfTgbePIRw3exbLwtFgQ4QNzgAknjxsq90cbdUzI32L8kw4bz+3Y1oTzLfjk+xSlWKz+fnpGUVd5HBA@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6REXlxaKvY9TPkBso2o5CP1ahZgS0iUfJZUzbjXNCsPFsp3AT
	LFbF/53deOAGlyN9EMRw2BUIouweh0OQiWmB4xhAFVFjlx7APor1rtKVnUdRckB+9PhJJLF7z2K
	ViszzXQ==
X-Google-Smtp-Source: AGHT+IHJ+xoP/OiRHl2NwVopvadefTgrOROW0d1nGwF4MhrqP/RTesuhzD45oXRxdaLTiZ5qawBd8auXYm7X
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:f801:f788:c7e5:c181])
 (user=irogers job=sendgmr) by 2002:a25:30d5:0:b0:e4a:8f5b:179a with SMTP id
 3f1490d57ef6-e54ee276297mr14040276.9.1736409078576; Wed, 08 Jan 2025 23:51:18
 -0800 (PST)
Date: Wed,  8 Jan 2025 23:50:58 -0800
In-Reply-To: <20250109075108.7651-1-irogers@google.com>
Message-Id: <20250109075108.7651-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250109075108.7651-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1 01/11] perf debug: Avoid stack overflow in recursive error message
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In debug_file, pr_warning_once is called on error. As that function
calls debug_file the function will yield a stack overflow. Switch the
location of the call so the recursion is avoided.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index 995f6bb05b5f..f9ef7d045c92 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -46,8 +46,8 @@ int debug_type_profile;
 FILE *debug_file(void)
 {
 	if (!_debug_file) {
-		pr_warning_once("debug_file not set");
 		debug_set_file(stderr);
+		pr_warning_once("debug_file not set");
 	}
 	return _debug_file;
 }
-- 
2.47.1.613.gc27f4b7a9f-goog

