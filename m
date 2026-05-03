Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF251FF7C8
	for <linux-perf-users@vger.kernel.org>; Sun,  3 May 2026 00:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777768570; cv=none; b=sNmtHZ5FteOghOxE/VMz4N8DShQT7r4r0Q35AI/CYXYQFBKIMRUCsjLqwif3zZ+RWkHRIfOihwnEGtaGGzUomZRy4gu8RV0UOJbCsH5JsKKlvWRHepi2zdyhX3tOqJFkFUbNKTSFt7HB1csQJw1U4gpaZ7NQi36F1ydRD/5G9EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777768570; c=relaxed/simple;
	bh=aejM4DU7JRkliTqft/Llsk1zUeLQIbJRjWsEykxh2ys=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sL1WgJZOdH3cDqHemig4hNt+5QJ3eYu0+FQEW+dlr3tnDsBdbIjs7s49l8y+sphRpPtp9i4/b97eUSJQiCNwc1fxeqdP/hxDplYjYL/CI1mGVJwxejGdcxoghoCvUMxHWpg7qivmZq1xWBqd2tsuvXw9GCQUffe+02CZw/9Kj6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ikZbg2jP; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ikZbg2jP"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-126e8ee6227so4914089c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 02 May 2026 17:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777768568; x=1778373368; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cQmVm0Mk8S8yIw6NN5Lf29gNVzq8HKFVdhFBj2+c9Uw=;
        b=ikZbg2jPz4ColB+ubHRp7G4XwDH7MV9R/1EIIW0I31G9ec2zjnxyKmBI0IDEvxOjZ+
         sbPXMnK8QqjcPdvjsAI/GDHIi4jFiRdJvtnoNko39DCodxAlXb+9t1uKxoCGq7TBUO7c
         hjRw9Ytf/nMVfZNW10D4IyO4a9vnFkNKWEjSs9gmeejuyShShxnUVAnh2U5pS/3le4DU
         lXKJForSUW3G5ycykMDrGRVzfl8UqJLkQbHx11LcwKnPNg3QSXPc8Ytc5LOMzY1Ik954
         NxYWrBQqnPdLt2zTjdwv8lFKjco5eOVIRqlwRiLQHvVDFbt76HikD5Zb9kjyM2jBIcQH
         b/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777768568; x=1778373368;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cQmVm0Mk8S8yIw6NN5Lf29gNVzq8HKFVdhFBj2+c9Uw=;
        b=NCvNpL5GWMzfydjNnKz06bYCoo5xBaOFE8C+ta3tPM5YZ6xCtTgsay9syxg8ctraNq
         uc/a3eoeqx1SM7BNzNtcCXum8P+W0wN0baxtjM9dTBSnrhat3YHOiqz1aDOblCHsYg+k
         tSE5p5UKayD2TLDJ0gDHmKoqgQpGZrbq8+FXoNsd+7FT+Q4MCDUonn4qvPq9xVK/telO
         icancAjO7T+e+8x6DjAHU3OkDFXUkzU0moVnTEIeJviJt1u34teNh15jjXTIxIF3nwNd
         nfY8/L3yMA8yL7OlSRr+3etsYaLYyUMvNcsrJeYmFiEXJBua5hiS71ITwjkg1yLeO3Wg
         z4Wg==
X-Forwarded-Encrypted: i=1; AFNElJ9IS7358SC+kCFQUOKT/cxPpNQ9dYplyOA1emGxbKLJCaUMA2vbU+L3tRqzRODui8ZvK/W3zHXlPofFK/8z3jPn@vger.kernel.org
X-Gm-Message-State: AOJu0YwulEANPHsD8NbPpIEV2E6EK/ytbzd8i0Vk3o/y5gMQYNBU9oVD
	4n6tO3yctgsW1y5gPb28OmxQINrLF2rUmaOu/1B3s7jT7tpOeB0PeNXwSjgqxHlr7iFlfyHkLg3
	hv11frzJBKQ==
X-Received: from dlbpt10.prod.google.com ([2002:a05:7022:e80a:b0:12d:bf5c:266])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:69a9:b0:12d:c3fb:14ac
 with SMTP id a92af1059eb24-12dfd7fd8d4mr1828491c88.19.1777768568329; Sat, 02
 May 2026 17:36:08 -0700 (PDT)
Date: Sat,  2 May 2026 17:35:52 -0700
In-Reply-To: <20260503003552.1063540-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260503003552.1063540-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260503003552.1063540-7-irogers@google.com>
Subject: [PATCH v3 6/6] perf debuginfo: Fix libdw API contract violations
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Zecheng Li <zli94@ncsu.edu>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Check return value of `dwfl_report_end` during offline initialization.
Validate `dwfl_module_relocation_info` result before passing to `strcmp`
to avoid potential segmentation faults.

Fixes: 6f1b6291cf73 ("perf tools: Add util/debuginfo.[ch] files")
Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/debuginfo.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/debuginfo.c b/tools/perf/util/debuginfo.c
index 0e35c13abd04..49cb7f9b715d 100644
--- a/tools/perf/util/debuginfo.c
+++ b/tools/perf/util/debuginfo.c
@@ -62,7 +62,8 @@ static int debuginfo__init_offline_dwarf(struct debuginfo *dbg,
 
 	dwfl_module_build_id(dbg->mod, &dbg->build_id, &dummy);
 
-	dwfl_report_end(dbg->dwfl, NULL, NULL);
+	if (dwfl_report_end(dbg->dwfl, NULL, NULL) != 0)
+		goto error;
 
 	return 0;
 error:
@@ -167,7 +168,7 @@ int debuginfo__get_text_offset(struct debuginfo *dbg, Dwarf_Addr *offs,
 	/* Search the relocation related .text section */
 	for (i = 0; i < n; i++) {
 		p = dwfl_module_relocation_info(dbg->mod, i, &shndx);
-		if (strcmp(p, ".text") == 0) {
+		if (p && strcmp(p, ".text") == 0) {
 			/* OK, get the section header */
 			scn = elf_getscn(elf, shndx);
 			if (!scn)
-- 
2.54.0.545.g6539524ca2-goog

