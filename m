Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7F4156643
	for <linux-perf-users@vger.kernel.org>; Thu, 25 Apr 2024 22:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714084462; cv=none; b=dfJ00BEkuiYlWcN2xRfnM3iqdFH7kR/H/gfhFKjv1cgyBVCrJDRS+SkNWvTWFzSS5Sz7PRaE7yH0ZaOSjduk4ewUXAXpTrlhPawfpobdZX/f5mpijrTp3Vnm0teV7kyhMrpX22LlGnzN1jBeTlF1VfB6FzqnV+5mKRfe2bAYv2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714084462; c=relaxed/simple;
	bh=I9bPx3CpgQjyYg4yvV6AX9jEdWGmf4GwcXNlAYSkiQ8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=hOjvDMzc4lzOqkG8bFbzjFr79Zy8G62SjBwSfFEUg4rK4o5rjGYkVY6aNFRAeOUkbn0hujy8Eqixs+z1v5hlqpmF+3hBWVjlVMqeOQfRlixpZ3bRbVE5bTZ31rIpacZUjQqdt1dhKErDlSFKOGTKOs3nMu/UhBJ6SBcPZAoofuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A/sDqGfm; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A/sDqGfm"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26783b4so2340230276.0
        for <linux-perf-users@vger.kernel.org>; Thu, 25 Apr 2024 15:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714084460; x=1714689260; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iMziqDCWwYpfU4+ULKZj6dbG7cOmBAdk/cZ8+rgWz6E=;
        b=A/sDqGfmWPt54/X/4DTwR9kdCtrwde957iPGp4sR0EPNr+qv6MEeL64vtns5pBPMS7
         pFJMuvMc9ZJvYZA4aHE593QCSHsaaBbh0vK+FbJ6UvOwVU+8wAjm4H4WLCCU42mYXiDz
         /TABuUheGLDX1WMQIEGoMmkuNQbjKk6HbbwindrCae28hUxoquwWtsvaRAVE7h0mOruB
         5k+/XSj2iHwTfEiQ5V4UcjTdndndRIqDXZEvZsUp7nRe10LUBZ+u7yrwppa2qBGx+nz7
         xWE34IAg4j+7O+CuPVPJZQzytFa/46MsVSvGFGcZveOPiT3RKX7YoxaQfher6QzrAwPi
         TDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714084460; x=1714689260;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iMziqDCWwYpfU4+ULKZj6dbG7cOmBAdk/cZ8+rgWz6E=;
        b=l0/ngaWMoRYQPZ9piL6ZypSVXEiKFQzIgmTidnPu3uaHMx4WT6NNYM3kQnq/A2Je3A
         2vC3RWEcCVHfqbgMOeaJa4uysUdj7CeRfY+ltIgVTBhf4cCjfCwRXiJUBV1JWYd/iaXX
         0453hdwgM7fqL4CxYLU/QpA1xdleCQbfA/C0vN1RqsqzCnFKrfANITwFoaSKu5zG5MTE
         HcmITe0YI2Qtn/wYbVco1e+TOtgMjhoEieA1FCXmx41DGTBrvMv0QPERJpzSHG8rSPbI
         GxcNbuMbFrWVbBRh5oR7R6pwmteHeCp068tcTVUIfplYMt8a9jaN/6jpfnn8Px8jYHse
         XxXA==
X-Forwarded-Encrypted: i=1; AJvYcCXLyueAm4+foxqknjKSzJAbV0YkR6ICgt4t88tJE2NgYBzaNvF2tX05orWW2PMmWSSNtxNF6sZYkQICh10ijo7Qfp/wa0vf5OkPKwC7euuf/Q==
X-Gm-Message-State: AOJu0YyX+kaKheWAoS/EqZ5R22186IHejsIG9pM6VSbVLpwQKrv/Ih9U
	8o76/KoNXOdSkEHpasZFQ9cgY+6gAdum1p7n9OiZ0p+2sONDZ72VEqDqOyzqU8DRyVaa0stP73u
	vCktyiQ==
X-Google-Smtp-Source: AGHT+IHtc16sNAH9Y5DvoUb7goP0WugggB/EOiDtg9m48a61YuDx7t/1HnK4DzRMMl4fFIm0pCWoco8lKYJj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8708:517d:aade:8c87])
 (user=irogers job=sendgmr) by 2002:a05:6902:1028:b0:de5:3003:4b64 with SMTP
 id x8-20020a056902102800b00de530034b64mr120121ybt.1.1714084459954; Thu, 25
 Apr 2024 15:34:19 -0700 (PDT)
Date: Thu, 25 Apr 2024 15:34:05 -0700
In-Reply-To: <20240425223406.471120-1-irogers@google.com>
Message-Id: <20240425223406.471120-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240425223406.471120-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Subject: [RFC PATCH v1 2/3] perf parse-events: Add a retirement latency modifier
From: Ian Rogers <irogers@google.com>
To: weilin.wang@intel.com, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ze Gao <zegao2021@gmail.com>, 
	Leo Yan <leo.yan@linux.dev>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Song Liu <song@kernel.org>, 
	James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Retirement latency is a separate sampled count used on newer Intel
CPUs.
---
 tools/perf/util/evsel.h        | 1 +
 tools/perf/util/parse-events.c | 2 ++
 tools/perf/util/parse-events.h | 1 +
 tools/perf/util/parse-events.l | 3 ++-
 4 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 517cff431de2..e6726587e1bc 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -98,6 +98,7 @@ struct evsel {
 		bool			bpf_counter;
 		bool			use_config_name;
 		bool			skippable;
+		bool			retire_lat;
 		int			bpf_fd;
 		struct bpf_object	*bpf_obj;
 		struct list_head	config_terms;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 0f308b4db2b9..9c2a76ec8c99 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1818,6 +1818,8 @@ static int parse_events__modifier_list(struct parse_events_state *parse_state,
 			evsel->weak_group = true;
 		if (mod.bpf)
 			evsel->bpf_counter = true;
+		if (mod.retire_lat)
+			evsel->retire_lat = true;
 	}
 	return 0;
 }
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 5695308efab9..eb94d1247dae 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -201,6 +201,7 @@ struct parse_events_modifier {
 	bool hypervisor : 1;	/* 'h' */
 	bool guest : 1;		/* 'G' */
 	bool host : 1;		/* 'H' */
+	bool retire_lat : 1;	/* 'R' */
 };
 
 int parse_events__modifier_event(struct parse_events_state *parse_state, void *loc,
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 08ea2d845dc3..85015f080240 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -209,6 +209,7 @@ static int modifiers(struct parse_events_state *parse_state, yyscan_t scanner)
 		CASE('W', weak);
 		CASE('e', exclusive);
 		CASE('b', bpf);
+		CASE('R', retire_lat);
 		default:
 			return PE_ERROR;
 		}
@@ -250,7 +251,7 @@ drv_cfg_term	[a-zA-Z0-9_\.]+(=[a-zA-Z0-9_*?\.:]+)?
  * If you add a modifier you need to update check_modifier().
  * Also, the letters in modifier_event must not be in modifier_bp.
  */
-modifier_event	[ukhpPGHSDIWeb]{1,15}
+modifier_event	[ukhpPGHSDIWebR]{1,16}
 modifier_bp	[rwx]{1,3}
 lc_type 	(L1-dcache|l1-d|l1d|L1-data|L1-icache|l1-i|l1i|L1-instruction|LLC|L2|dTLB|d-tlb|Data-TLB|iTLB|i-tlb|Instruction-TLB|branch|branches|bpu|btb|bpc|node)
 lc_op_result	(load|loads|read|store|stores|write|prefetch|prefetches|speculative-read|speculative-load|refs|Reference|ops|access|misses|miss)
-- 
2.44.0.769.g3c40516874-goog

