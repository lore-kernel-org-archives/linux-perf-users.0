Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A7E2F3612
	for <linux-perf-users@vger.kernel.org>; Sat, 22 Nov 2025 08:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763799589; cv=none; b=E8/3ajnbEZOBN3STn+hbtxzAAVlXmqzEk3RejkVsIk/Dy2eA9ewq/RqFwBArhO2FWe0FnpjS6lUc/T/+p9seSRd+T7Ghf6PbLiKr8VN51bOoDB+z99qROfaHn6FoVdfKgVuWqDkzzRg3oMRiNjtbCCJjNwlHOT6qZdijvbfFj2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763799589; c=relaxed/simple;
	bh=sHKG3KyTM2rdRuv8FSfOH5UBdv+1780KO0TZqhE2tcg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=YHTvwQSTPuifgFH3yccPCRK5KJ8N4i0zAHYnZuZ1mt46TUo2voeQ/2nsk/zCp1bnc+uuyNLTlCwh3vt2FLL5YPK3PKK0FYLcrVgCz+pzkXM7HXcXog1loYzZe/SWmPYoPUR+hoPFyfFGdQphHyh7GJIB2HAlT958e/DOEmcZ7GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xG022jIr; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xG022jIr"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-343fb64cea6so6729824a91.3
        for <linux-perf-users@vger.kernel.org>; Sat, 22 Nov 2025 00:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763799588; x=1764404388; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pU7jorvKH/B/DumRMaJiv0i3+cPKkaeMOA/l8hLedSQ=;
        b=xG022jIrhO/cbKl70aZ3klihLQJB68CKu+WDSXrBLOlrwAOa5gPlRcLh7xRd9/s9nm
         +XCI7/47T1keznYUJ5p+dN42/cj7vjunOTksoepIjwZ857oTJQps4ABxG4TZ+01QB5PJ
         cZ6aVu1CmrJ3N9XKcibOuld8IQ0aneYThJTDdduBYmH7RYLBuB/2E567d9tJlcGN304T
         eQ9i5pS5z6L10VKT72jzJmR9tij+4EDINU0DwybCCZeqI2ElDs76zlXG0TRcXc5aCnC2
         rZzwLLZTEvpiDcmeSKKa+iFFDJ59jwg1ABTxJHCK7t3x8oc630LwVSO3wUzonEExNY/o
         lYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763799588; x=1764404388;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pU7jorvKH/B/DumRMaJiv0i3+cPKkaeMOA/l8hLedSQ=;
        b=DBvQRoUX0gaF1/OUTLfwUl900XFZ2TFGrYNAnAlZlEj4YwYp/m4JQ5P4QzqpKvNMpb
         nc/YC9LD3n4JP7S6MyDiatBTs2ABFb4yYSK1KA17+gzQvOMXoLBVvfeov2mZlM/+E/Dd
         8d0FyZG4+6Td01Eb904BUd3r/cOyaJ5Uq8EDMxA5qvLmKHA0QbFxMMhr4skXf3Vs09sd
         jpvpQP3j4M0Ue33mMB+H5ln746/sEd1xBwguxnB88xq0nh1MBRdSU6SPYrSavUM/xMQK
         wiwbE1/MNQEn1iCZYl5YFfKYLBKniRUwm+emeb051LaIjzHTRnYKcS4OezClPteqJOyU
         RoKg==
X-Forwarded-Encrypted: i=1; AJvYcCWWSbLr19Jq0IGK2/T3l+sa43YYM8O8jQSfyK4DmoLFDdHvyzwT0IrmqKHnQqsMYlpVRuaHfShL8zViRlFuVhWl@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg2rY/TK5MkTtd142D3N4rmff9Ai2Sj3jpCFKn4yfjN9Yi3p7u
	fEycg/LPzOmaZNj9nS6/L3CgvVJBbR0Kid47ckzAuvpSCeS7Ey1NB4pJ36qRzQ6bZ8b4Iood0iI
	M5bJFni+QKA==
X-Google-Smtp-Source: AGHT+IFjO96/R4U6ugHv+3ezv1kQspZfyJ5b/DhvvEcqfJL+zGtCjF4A9hxjRkofq7lWxpbDhpWovcfXgkbP
X-Received: from dlbqy6.prod.google.com ([2002:a05:7022:ef06:b0:11b:65e:f6a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2393:b0:119:e569:f279
 with SMTP id a92af1059eb24-11c9d865659mr2657208c88.34.1763799587506; Sat, 22
 Nov 2025 00:19:47 -0800 (PST)
Date: Sat, 22 Nov 2025 00:19:18 -0800
In-Reply-To: <20251122081929.7588-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251122081929.7588-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251122081929.7588-7-irogers@google.com>
Subject: [PATCH v1 06/17] perf hist: In init, ensure mem_info is put on error paths
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Collin Funk <collin.funk1@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Leo Yan <leo.yan@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Haibo Xu <haibo1.xu@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Rather than exit the internal map_symbols directly, put the mem-info
that does this and also lowers the reference count on the mem-info
itself otherwise the mem-info is being leaked.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/hist.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 64ff427040c3..ef4b569f7df4 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -608,10 +608,8 @@ static int hist_entry__init(struct hist_entry *he,
 		map_symbol__exit(&he->branch_info->to.ms);
 		zfree(&he->branch_info);
 	}
-	if (he->mem_info) {
-		map_symbol__exit(&mem_info__iaddr(he->mem_info)->ms);
-		map_symbol__exit(&mem_info__daddr(he->mem_info)->ms);
-	}
+	if (he->mem_info)
+		mem_info__zput(he->mem_info);
 err:
 	map_symbol__exit(&he->ms);
 	zfree(&he->stat_acc);
-- 
2.52.0.rc2.455.g230fcf2819-goog

