Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686B02C11E6
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 04:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758601172; cv=none; b=eq8V8U8X54xGCx4eev1uYFi5vAN+6nychkFjG9Zn52JdDUrDTnfRQl1MT19Iy69xu+6xeUbH9TSzQZ3gqxRMnTIW2CrYBjRhJIs+s4TUQdgIClIjay+hgCfBwaJH6kAzsmtje6xGDc9Sy9bI5nzRctdR8qEY5/jMrAfVt980wbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758601172; c=relaxed/simple;
	bh=42iBM+j6OaHjeb87rjIgQvbVIu0m2YAxZp+bcUWwqIk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=iT39pVWPHSOmmjTKqY6wq1FaNO8jQMlbfFv8gKmZTMt6ikjW6eaaD3cRPJpNZZlIFmNznUmadpxOX7uMLWWgHHMjgV2AK8t5mDzKPMcfgUrzgdnEUnC1i0T5yfhMQPsCY383JrCTS8L6TjFDvEMb62pm/ZeKeL5ZgGu6mDOwIaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hKvZoDtc; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hKvZoDtc"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-77f2d29dc2aso1501485b3a.0
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Sep 2025 21:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758601170; x=1759205970; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RMlKXhObDH6+v/xxS2IL1R5qtxgnEu4dYtMPfrzR6FE=;
        b=hKvZoDtcdwBPAan5T2DrEj4d+X8aBKozt49vTB5XfjoYt2zvcuXegWnc9LuQ0t8JKn
         u1nDpUfC/1Jmc+gkhhxqzq8xZq2FOKWHTRDE5229D2Fb09puCIPtFER2xnZ1ajE07rxp
         lNvd10t8Lo+fFp8UbNsCFKaZJwGB9fQIu6hTxqOSaxlO19SMfUETs5p0IZV9KVMxP+wh
         2AraBYn1XWjrN+2z4v7pQGS0qLXa2a4UMrjzPOlYxLGb5KZnDtuCEOFoz7HpPJF4c3Fg
         oz9rxJgQ97W0ufq/Utfc7qKyA1Kk1fCgN6P9KqUdlWTadOijIF/os1w1iKMrw3Fz9VYf
         QNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758601170; x=1759205970;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RMlKXhObDH6+v/xxS2IL1R5qtxgnEu4dYtMPfrzR6FE=;
        b=I0dLLLLOanuean+mfjFGA4yx00roEfSH+YAm49U2EtEHXBKFwVeHBBlJLe8DdvUMrS
         VB2Cl9QuZKi7FBO6MERrcNmp95R9+78rKTmwEUx7zzFzftcaKlpiGFoRNzSYOwlL6mEy
         1rLPPKwZv1JdAd58Z8KKeg3JWQpHp1mT9WneqNwCb5SDgt7eVS0R66J/HesngDqYv9TO
         xOvi+SINn1344YvP+Uu75o8AMASoskBmz+IHgubQo2UjUEPIAdKYKKa23ewSBw40lQf2
         d1lGLnKgOFrWBNiGpfNyrV89lK9X8Sk5z3ljuLpp8dmd9BxfXQGWWDvduV9XP7VCuTrw
         BGyg==
X-Forwarded-Encrypted: i=1; AJvYcCVwc3WoFmEzUX3xuY8W+z+K8g+TPZphP9kQnMmQmVoNAl6T5anmJLjtNPBc7MmEBS472ETwqJY/paGQN3BPjS9r@vger.kernel.org
X-Gm-Message-State: AOJu0YxCEtzMDLRKzJkBOKHzX6iLc7FAJ5uOn/g9nMHMr2U3KOHLdVAG
	z7JJm/nTGfog+Av2EBgCyZLzZIvsfzzwlmiPRHokX3YiMx84Od3T5V6jLHI0uNT4wMEnx0pQsDd
	5+kbwX38Nsw==
X-Google-Smtp-Source: AGHT+IF0UoFkxTH6FU00wEtyjymwn+KsC7TsbR+8Lhcdy4noVLIgU/fBCTXNE1X42uS8iAeiRcTzZy4xoEKs
X-Received: from pjbsb16.prod.google.com ([2002:a17:90b:50d0:b0:323:25d2:22db])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:748e:b0:2b7:e136:1f30
 with SMTP id adf61e73a8af0-2cff213742cmr1861087637.55.1758601169838; Mon, 22
 Sep 2025 21:19:29 -0700 (PDT)
Date: Mon, 22 Sep 2025 21:18:38 -0700
In-Reply-To: <20250923041844.400164-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923041844.400164-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923041844.400164-20-irogers@google.com>
Subject: [PATCH v5 19/25] perf evlist: Avoid scanning all PMUs for evlist__new_default
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"

Rather than wildcard matching the cycles event specify only the core
PMUs. This avoids potentially loading unnecessary uncore PMUs.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evlist.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 80d8387e6b97..e8217efdda53 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -101,16 +101,24 @@ struct evlist *evlist__new_default(void)
 {
 	struct evlist *evlist = evlist__new();
 	bool can_profile_kernel;
-	int err;
+	struct perf_pmu *pmu = NULL;
 
 	if (!evlist)
 		return NULL;
 
 	can_profile_kernel = perf_event_paranoid_check(1);
-	err = parse_event(evlist, can_profile_kernel ? "cycles:P" : "cycles:Pu");
-	if (err) {
-		evlist__delete(evlist);
-		return NULL;
+
+	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+		char buf[256];
+		int err;
+
+		snprintf(buf, sizeof(buf), "%s/cycles/%s", pmu->name,
+			 can_profile_kernel ? "P" : "Pu");
+		err = parse_event(evlist, buf);
+		if (err) {
+			evlist__delete(evlist);
+			return NULL;
+		}
 	}
 
 	if (evlist->core.nr_entries > 1) {
-- 
2.51.0.534.gc79095c0ca-goog

