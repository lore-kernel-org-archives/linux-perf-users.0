Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4859F385D68
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 06:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780296878; cv=none; b=R/o6ic8+3nBkZ4lN6RnX5/YKiTKr7yGsmMhgNey7BT/NE5hFQYVadjmWVSlqZpJXyLVttoTlDKWDozwnYrYmTuBXA/9oqWnyVvTm0xqQgsF+LWRTTJ9O0m0939M5NZQHPLI/UQkkTlfnAcZKmjWR+ELzsNyjCCuzR3DYktZkNTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780296878; c=relaxed/simple;
	bh=byA4iiiItOzrCIc40YhkXBiIapb+JQVAmtrP03YEzGE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ulk1wvX9paC9xQ8Da15Wal28niFOBIVo/eZGrk7KQ0Ho4iujTJ+FwBtZANNGZeV5E2iRaHcoANuUk/u7UnXFJpjt9m5xYTYRzjkncldDyJBG+GNZBJiF+quI2uOrOGYlK0QMJ8KsYbm2kfH7vCL+I9L9421REc+nWfYHVxRjHz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RAbfKXEU; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RAbfKXEU"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-137d4309062so2555885c88.0
        for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 23:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780296875; x=1780901675; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tY794Th1Kf4p0/W+HEvStNmZU5/pHa8B5HzKhPU3Ew0=;
        b=RAbfKXEUWhb+vPWbmJcRpCS5wDCuhyfejIxJ3ypHBRsjs2vyCAKtfOStxzDUGQmvY5
         YwT2/JK6OWkxmDlyqcDnBx4E9+lmDy2UzPtd0h8fL9ntexLEljKcMc9xGGdYPujjdE58
         Cz+Fpv2Gexaf8etagf/HwIV3C8TRaaFpjF8fEXF7+nwkFlHbhXThNu6/zzfJc2HHJVVR
         MMTXOAVh8KcJELD51ZxdxRzCJ3F7nPfkw16gHZdkRnj+arIl9qfqm8FzYb7R5YqnlSqW
         Iy8yXlKAtWu8Bg6Dd2Spf1nThpNmwqfiHfBX3QVtWF1rDBqgfEsm0oXjSIRK06v8slS9
         iEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780296875; x=1780901675;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tY794Th1Kf4p0/W+HEvStNmZU5/pHa8B5HzKhPU3Ew0=;
        b=K+fNybunft/B+qBh1hbJKtq+3YszS/+skrXOu1mxCuoCWvNb1+VZXVITllTc/AD6yt
         pekaewlVdqZT35cXICc7GTEJK2IGurRskFDEZauet1yuJucDykhof30iBXzWOFRV8zMJ
         1/0f/9GH0pBbD8ZT9DZP4kmy6c14xOdiYpkihyQErlQ9SM1AE/URITuylxTmYsXvdbuU
         uZaD3tEggjDkG246fZ9f1PQGUt528G0ys1SaXcy6eAuRit/lrrqMuhRmxpso8LwQunFj
         mthVKG5dk07iFNVwnykwXbgemriIvkweZJjgn/miIgbK/gcvWfMth/4mqzv0C05GuPYb
         6wkw==
X-Forwarded-Encrypted: i=1; AFNElJ96YY2j9NjIKLFOrgf1uWVMe0cxeonw9X93psIR8pmd2GPbQImam2wESmTSiuKSOWaXnyTP3Dnj384aVAS4g0Hj@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2K9jlOmJGRhg/jfJqBKzYlfJ4dOR5zuJ0LSmT+e5QdyRI7aw6
	J5rjZTCUND0TjuBmv6DApKKXwVIUu9Q13A5Q1L6nQ6hm/oULFILTwjBj1po+r3Zrf6RpfEN+Yqf
	5EHtICkC+gw==
X-Received: from dlak23.prod.google.com ([2002:a05:701b:2917:b0:130:592b:1b03])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:41a4:b0:136:e639:9c17
 with SMTP id a92af1059eb24-137d42615b3mr3994750c88.23.1780296875217; Sun, 31
 May 2026 23:54:35 -0700 (PDT)
Date: Sun, 31 May 2026 23:54:00 -0700
In-Reply-To: <20260601065407.1597927-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260503002248.1040791-1-irogers@google.com> <20260601065407.1597927-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601065407.1597927-12-irogers@google.com>
Subject: [PATCH v10 11/18] perf header: In print_pmu_caps use perf_env e_machine
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Switch from arch to e_machine in print_pmu_caps.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/header.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 220e7720fbdb..ecdac427d9c4 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2461,15 +2461,16 @@ static void print_cpu_pmu_caps(struct feat_fd *ff, FILE *fp)
 static void print_pmu_caps(struct feat_fd *ff, FILE *fp)
 {
 	struct perf_env *env = &ff->ph->env;
-	struct pmu_caps *pmu_caps;
+	uint16_t e_machine = perf_env__e_machine(env, /*e_flags=*/NULL);
 
 	for (int i = 0; i < env->nr_pmus_with_caps; i++) {
-		pmu_caps = &env->pmu_caps[i];
+		struct pmu_caps *pmu_caps = &env->pmu_caps[i];
+
 		__print_pmu_caps(fp, pmu_caps->nr_caps, pmu_caps->caps,
 				 pmu_caps->pmu_name);
 	}
 
-	if (strcmp(perf_env__arch(env), "x86") == 0 &&
+	if ((e_machine == EM_X86_64 || e_machine == EM_386) &&
 	    perf_env__has_pmu_mapping(env, "ibs_op")) {
 		char *max_precise = perf_env__find_pmu_cap(env, "cpu", "max_precise");
 
-- 
2.54.0.823.g6e5bcc1fc9-goog

