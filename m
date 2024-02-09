Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41580179BA
	for <linux-perf-users@vger.kernel.org>; Fri,  9 Feb 2024 20:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707511818; cv=none; b=Vb/07/LqtxrGAKjB8t9VlJs+0ucMW8UzJgGFooz1Lm9yb+ufT2uyb0b5LhwVoAyLPOaIsAwacZcO8ndO4tECkphnY/U7ja+3gfW6LLPApSPJ+dYc+NK7VkI9uLJppgI2DOCXuiAbyte3fLLFEKqUkIOPozs5V9McIJzs172x6Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707511818; c=relaxed/simple;
	bh=FN1xH7txpWYfGe8oXzu7wp0Df0lMgRHZJT67LPNIglU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ZMfOa6UcHNfYV87tymwYchQmZZ5KMWqE+QqVy4YLRwgk7LH4JLkBoLxytg9xW0GdOgG+BYVsOdEE1eDR5wO0sJdTzuzAekCw3pC5F8HwjhZ3ri1Em22clTa/TISLJwQnRLrm6vdkk3/e8+XSb0r5nZ5UlknNG4zfAu9VmSRMsAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LewBizmV; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LewBizmV"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b5d1899eso3253616276.0
        for <linux-perf-users@vger.kernel.org>; Fri, 09 Feb 2024 12:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707511816; x=1708116616; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oBdjorgQB0gt1zgRALPto7TpPrhqP+5PDX20bu5pfxU=;
        b=LewBizmV3f85bnm5XnNTMrsb6wd4bKnUbo2UeCWJCHCqbmnGvOxlAZ15l0DIYFxFl/
         CPBIGBzRno0n6DJz+9eFK6I02sBVwueMzR0I3qH59KT54tFalKPz31ylLZm4jqVcFW8S
         6VOB+oEHsP30+eJAFq0L3QePhh2nn1MngvbtHS6ddGzK3NXW3i3E9fUiHq3iPsmokuwk
         uLLM+TF7F03qEPMWNrY6S+JWezAOGxj6Qf+T6wyVBQQzPtUg4mu4soULBTGUPNax41qx
         eRhl+g86T24DbNfaqKv6E1uv4YIByunJdfzT5BuZ1GjlZP9xqsWopZyCvGidgixHVCZw
         Bauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707511816; x=1708116616;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oBdjorgQB0gt1zgRALPto7TpPrhqP+5PDX20bu5pfxU=;
        b=ERoY4l4T6EKDfwEnzh9pzniziAhE48hjK0ftuwAswqZ79BvVduON4gcizbiTdyPBMx
         4vAvbWHsIVpN1ZqXEn55wv1ONlxYejw7JgS9se89wrOm//3XlAHRrf51Sg8fBY+Vh18u
         gKcknNkO0sRt4soU1Ve7X2FXSOoKD8nvcycdqGv6gfQboEvTrvdY7ycLf6s5pA9fL/Yn
         i1V4BfYwfdeVu/pBM507J3/S83dWhoHy+8Pd1RwkIS2UjcqUtLJSUvgvrW2JpN+Mhs73
         QHlEbrOe8pYHuVF3V+R83f1ZCcbVyvv9uSLIoeYFq5dDo46AtRKWbT/PDZ62YqpSOoyU
         zz5A==
X-Gm-Message-State: AOJu0YyWiL8OYsN7bTc+pOuXwBj9e1sm4ir4W3TYDGy6DpXdLEDxpWYt
	BZnJWPt2D14hMu/D5iPV1WwQDZAzHLECgm/MkgzNqcQVu1peNCGpiJCCaDT75NaDuhVFBYVEgck
	ChxZ6aQ==
X-Google-Smtp-Source: AGHT+IGCVCKuACIOU1FX0kOaK8wcfhbRrM75EuyLpzkhf7rKyVv1U4leJ8uARRH2YSaI56YeXEYjmx0YsVza
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:877:241d:8c35:1c5b])
 (user=irogers job=sendgmr) by 2002:a25:ae03:0:b0:dc7:463a:46d2 with SMTP id
 a3-20020a25ae03000000b00dc7463a46d2mr421048ybj.0.1707511816316; Fri, 09 Feb
 2024 12:50:16 -0800 (PST)
Date: Fri,  9 Feb 2024 12:49:46 -0800
In-Reply-To: <20240209204947.3873294-1-irogers@google.com>
Message-Id: <20240209204947.3873294-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209204947.3873294-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v1 3/4] perf stat: Avoid metric-only segv
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Kaige Ye <ye@kaige.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Cycles is recognized as part of a hard coded metric in stat-shadow.c,
it may call print_metric_only with a NULL fmt string leading to a
segfault. Handle the NULL fmt explicitly.

Fixes: 088519f318be ("perf stat: Move the display functions to stat-display.c")
Signed-off-by: Ian Rogers <irogers@google.com>
---
Note, the fixes tag is to a refactor that moved the function. The bug
existed before this.
---
 tools/perf/util/stat-display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 8c61f8627ebc..b7d00a538d70 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -560,7 +560,7 @@ static void print_metric_only(struct perf_stat_config *config,
 	if (color)
 		mlen += strlen(color) + sizeof(PERF_COLOR_RESET) - 1;
 
-	color_snprintf(str, sizeof(str), color ?: "", fmt, val);
+	color_snprintf(str, sizeof(str), color ?: "", fmt ?: "", val);
 	fprintf(out, "%*s ", mlen, str);
 	os->first = false;
 }
-- 
2.43.0.687.g38aa6559b0-goog

