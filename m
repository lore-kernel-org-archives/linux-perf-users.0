Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B81134574B
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 05:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782192934; cv=none; b=kr4V1c01rdmun2WCzkSU2db/mPFT/edYzCt3LKUwjd55xj6HDudbRcmSSAibsghmcCP8h5tCir7N2ma9Oa8sPoXwPdGQ73u76PeVQRLh35STmBJBGIKhoSPWTGew3n8AsS1QAgOE96SK5TqHg036nAFms9nkG+AQ8Bm8lXSRkLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782192934; c=relaxed/simple;
	bh=kVbXSxUgeh08xpCiGjmKR+LrV2gzXfourUU1Od1AmX8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iMgcLmar7YrFJ5tbL0VU3hCzlH7+lqS/FVKSdt6AywAHH7zltw0IiuHgurabngexSz9fKpicG/m+JSXHe2klGr6qb7/5+1doZl7t8nrBlUTOdlaegxz0MjPvFuvT0gTGk0zSWKcP2fyqTmFXm2e568VIoeiwzrspwe23aWthhRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dl062++F; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dl062++F"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-30c108c19d4so4274670eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jun 2026 22:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782192932; x=1782797732; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p1ZpqTMTRdxTsIix/V4KtIwx/1oCfwPadaOnk8jHa14=;
        b=dl062++FctRF7kfxMQMLikCnPX7vF234vPTyU473UB2s50LOlLHBfsoWBULUYHkkbt
         20Cz9yKWuSl2GZC7Jyjtmf1WEm1d0Zf+Z0hajXLOB/J6QxfcuV7p6Ql1PRhDjyQnzdcn
         K2MEfoFqpCb+tSeWWSXwfaHTLTr0ZHCttOo8ybgf9++jYqnbZgUbgARPeJt+jixRDKRH
         0Te4cnSQg9ZNqayk0wLNrRErCMCIUviZSGiHXfNKbE+08iEHZiuVSrAsXaNT1ssHI+Ek
         3tudNaDqCshFphrJHGQ5JyMI6jwzkMysSTfjho+23T+l9BMOV05PpGYjSG/jPZcknJWQ
         BzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782192932; x=1782797732;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p1ZpqTMTRdxTsIix/V4KtIwx/1oCfwPadaOnk8jHa14=;
        b=sA+rdcgY2JAselawp67l4I7ybOmDCnHEOx5W/5UPbJXtPCDeZ8zSH3xZ9X4bpzOj/c
         IL/Umg2xaNSGgSNuF/tqeeB7PyMYMlSEgmlIlNWLH8UQq8GjRAjtECMGXzVNm1p5bB9h
         zqJD/BZGOP+U+FP4OfxZ48wS2FvWTm4VCkdh1U21VhA4+JhHDEFIixifdj5M33LQu49m
         DKvVxveNJYzrsNkJ9AGkuenvs80ntT6xk+Efe0y1JrDYr9DPFuC6JqjO6vaemONO3Qq0
         +NDG3TCvVPmmdsqqYLjUOboBDfQCctOrTkVl+d7BXnuR3kJrNK9GCf49GQCPLpYP72Tx
         bR+w==
X-Forwarded-Encrypted: i=1; AFNElJ/oRxOLM5WVrTJxEr6gP64uNsyYBOeDl20Akl51fONbee7vI+1sns4U2eCNV7nA0d3JpU28RSg1BxZXYdnGg5Iq@vger.kernel.org
X-Gm-Message-State: AOJu0YwAxCfsCuhhRoIN/YqZdeEfsTrsRhfFwgA4a00MHI46CqnbybM+
	q9IMASyqh1aMnpzWWabk7/rwsexkPHIVTt5cYGKxLA6/WxXrzpfYBonBaOQISP0AAHkgAijiH3r
	UQP5gUPxfPA==
X-Received: from dlbuj9.prod.google.com ([2002:a05:7022:3d89:b0:135:38fe:4472])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:410:b0:137:5b9d:cf87
 with SMTP id a92af1059eb24-139a35390a0mr9283464c88.0.1782192931789; Mon, 22
 Jun 2026 22:35:31 -0700 (PDT)
Date: Mon, 22 Jun 2026 22:35:03 -0700
In-Reply-To: <20260623053515.2677888-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260623053515.2677888-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260623053515.2677888-2-irogers@google.com>
Subject: [PATCH v1 01/13] perf script: Fix metric_evlist leak in script_find_metrics
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix a memory leak in script_find_metrics() where metric_evlist is leaked
when returning early on error paths.

Assisted-by: Antigravity:gemini-3.1-pro
Fixes: 3622990efaab ("perf script: Change metric format to use json metrics")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-script.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 47afd8cdc2b7..6b69e982ba62 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2275,8 +2275,8 @@ static int script_find_metrics(const struct pmu_metric *pm,
 	}
 	pr_debug("Found metric '%s' whose evsels match those of in the perf data\n",
 		 pm->metric_name);
-	evlist__put(metric_evlist);
 out:
+	evlist__put(metric_evlist);
 	return 0;
 }
 
-- 
2.55.0.rc0.786.g65d90a0328-goog

