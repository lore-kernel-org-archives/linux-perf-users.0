Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394271E0E08
	for <linux-perf-users@vger.kernel.org>; Sun,  5 Oct 2025 18:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759688718; cv=none; b=Wf62Cz2DUiraFI1em3a+ZGVkhoTNAN9v8LLBXStPmMucLvgfdzA0kPCf4BVLk4qDLJFlA/H4HzK4du/ux6Nc8lV9UP+cNQYwCxEdXKRn2o/NGZC2lLLM8uFAj6pZq8fV/rd/rmfvk4LHrtaKiaoVXqtzeoOCzVHDFj1S2YlI+eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759688718; c=relaxed/simple;
	bh=HLWlGuKKGsxbZ/VlexXCASHgD2Zqo2tv4jU6pHirNCU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qroYuq6F6Qno3NdJ6Vl+q1e3LWBcpEEp+Ook0qZQHq/+gdeNT+XnPaHsvJSejL3MPnLqNMTFvTG6FLF9WBYw/mEb2Pjp2MYJ2IfXtyjM4r0JmgGSiZKNG4cXUyYxX9UXD2naBtiTQii9TCu0WPWGd+ETjuiYp+COAc8Otn7zFJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cb1k0Uo0; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cb1k0Uo0"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-27ee214108cso92232445ad.0
        for <linux-perf-users@vger.kernel.org>; Sun, 05 Oct 2025 11:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759688715; x=1760293515; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pGrB9wpoGRw4wb/VV8boqf4ZZbV8ujvZqQy8douNpFU=;
        b=Cb1k0Uo0It61gCSPdDMfP+80+oc9l/oFL8Z/yuHo3YwGYXQocWh0z3oXdmYh3LtHig
         uJTIBAZMoLwLRPcHcs1hoAaSApB4zQSfx0/UOcHAL7zjvRp/dJV+Hx56ARLLfrUG1xjc
         247QLjg3B9JybhSxyDvF38p2F9VJEiaYXbe05tI8jdnNBbuwZAarEEvR4O+2obyk9KP6
         /VaY05tH+4pvo4/9hlxUxNqlSNkCWWqWSoJ1ly3f7xMp5BLjXFn3Rn25blHRA+fTCjQ+
         mDj2wgAB2+2UdzULR9QFuWguwBifei30ZnyynG1JumQZOYf2LUkn2NvmzB+CG5yKoGCi
         2sFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759688715; x=1760293515;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pGrB9wpoGRw4wb/VV8boqf4ZZbV8ujvZqQy8douNpFU=;
        b=Vs8YGj4azh512wxZidvcG3as581h15YVXmutGq7iPwkVPnN4bU8UB4951WWfHK5QYo
         3WQR1VjHQoELo94ShsCKmLNm1UD3qtAP97jpfGqfKT7QGZVeZo27I9DVjZuPgdFtHXGw
         5m/AhDvZBz8GKLWg1mRBc1CvCb9HugxdqxE9hPm5K0GC8vhiZIyaSAyvIVJhFV2p8ujk
         T76MIgcSSGLE6T89y7OgXS7RGc/ynwqLmJsPKBI6LkH4oAbkOfVeyQ6RdM9MTr1kyv8Y
         fzYqlHZoRAgBjcJJRJG/MVukoXho2TqzGM1z6lwFPpX+U5lRukQOxI4kmyi4Dr0ORzU2
         Hl/w==
X-Forwarded-Encrypted: i=1; AJvYcCXXFAoVwgfPvGzDETDZE/3izNiD1PuFgVlQr/0U9BRpIMhAi3O5L+LclnK0wyQaDudTBD/T1YPdsk0ppSWeGcWB@vger.kernel.org
X-Gm-Message-State: AOJu0YzeQHSjDQEX96TO/22v60REcmblOodiHdmN+Gyw8J3v31Vw6A1z
	BSMHSnEYp+Y5JYCkLB/ZFXk1ixWK45Mdof+WGPgtmtntYDGkzRQ6H84YHyWj+ZNqgsaTofzUpuL
	tpfHIqlXkpw==
X-Google-Smtp-Source: AGHT+IHuTTRLk6nyHFo3u33c5lPkL63Gcmyz1jzNBU2q5+TfJ2opM10Z3AmlL82Ky7TkElo3bLnq5800X+qZ
X-Received: from plbkn4.prod.google.com ([2002:a17:903:784:b0:267:e964:bc69])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3d07:b0:268:500:5ec7
 with SMTP id d9443c01a7336-28e9a5b9441mr127956365ad.2.1759688715580; Sun, 05
 Oct 2025 11:25:15 -0700 (PDT)
Date: Sun,  5 Oct 2025 11:24:22 -0700
In-Reply-To: <20251005182430.2791371-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251005182430.2791371-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251005182430.2791371-20-irogers@google.com>
Subject: [PATCH v7 19/27] perf evlist: Avoid scanning all PMUs for evlist__new_default
From: Ian Rogers <irogers@google.com>
To: James Clark <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Cc: Ian Rogers <irogers@google.com>
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
2.51.0.618.g983fd99d29-goog

