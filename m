Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FF5AD5D
	for <linux-perf-users@vger.kernel.org>; Sun, 28 Apr 2024 05:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714282587; cv=none; b=JFleqcFOlmXETlLCMBurNw1OY9185YWzHJZfvTgd/8W7sHBcj72GMoAKEVdiSIbQa9zkHpx/CrFcfAlGcG7bulAsx6wdI6h3MmLiUt8VngVervlJHNoSRJ+ePE8djb61azs9szqFjQkdYZx0/b9i9nmfayrM3usEIPW+ND680Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714282587; c=relaxed/simple;
	bh=XYz7PiZeKaJrW6wdr56WN27ZHPHIxfeYIzS3CYO6Ldo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=GzaZQ2Lg/PpWGehtuCQwpV+C0WnjUYUzXAaYElLnVkvvH8jpRN/bbe6SZG2jysG2iExGhDWuxcGHgkc0/KmilHrhvFkhDUaxe2MW3cp+emWoOlarOxun6U93oyg6TquVea7BKcWacfYofWErcYslhv/kYM7W8BKthlXcuUR0GsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pRc/TvfU; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pRc/TvfU"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de51daf900cso6698872276.1
        for <linux-perf-users@vger.kernel.org>; Sat, 27 Apr 2024 22:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714282585; x=1714887385; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=krs4YntHEU9iOHeaFDkbJHHtOvC7kECGCvfxGbSfmkQ=;
        b=pRc/TvfUX5nUHQRhbtdMv8DyWtfQYzTFrb3VgrtJkmsnbZUb8QFzBImeYDTPY5K1Y8
         S8+FtQsLPBROi/t/LdMbRBSQAxS0m5eK28kRqDAKeXJuhpbZJQXh9aCyPXogv9xDbMXx
         2KnM5rZSl6Emzy/1btrOAm4M6I1eHdiMjfQo6xB/MMBTtiaDseqdMVD5cKqFBgDnFVHt
         bqQPzktKo8umaiZ+RKz2MrhyzkBJgFyopaFeJ5+AFPaozv1n91mJJebWN19H+1m8eyRd
         dtCW8rC1Rn3e0FH7C2rgbXIc4q0y2DSvOCl0QBgWPkhUZUmxeINIMQ+8pdEYVvs6UnsD
         TEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714282585; x=1714887385;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=krs4YntHEU9iOHeaFDkbJHHtOvC7kECGCvfxGbSfmkQ=;
        b=vSeoahbIxYCnnIxeys5D3mXcjLCNkB3gCpmFgV9J0FqIiHcMowQbmEm3GR7KpATalV
         0CA1RLBIFtGWRfC1EpagX1RwL4Oxw6JViuotLMQCLuDuHyZ0D0OHhV9S+QdYHN8m7etQ
         EwNfg+pQ+w/pNQRgLPPH4oXw0JvRoGjNS0GMweHEVvVrzH9JW5WPOzQPPd1oPyVVX0AO
         uYs6wW9UkDT6Ui4LQJ6ob6qZSO7raA+3LAhCAKuLlqgh2XmktLw9xJ6O8PNjHcveQeG6
         vV2e9Tv5VIUS7m4SR7C0QAk/ONuYgGAYopzf0qzRNOQ7IeVuzMhMTJtghYcI3+4iU1I9
         v6cA==
X-Forwarded-Encrypted: i=1; AJvYcCUowsJYZ0TId0irFnLZ9ae+KiOYBQngGALnrXQAtR5LLi1G/mJwm6hPVbgeF0+ZhKPhXj25JvxnGHfvr8rktCJIgHwkOppzA1wnLQzR7K30Nw==
X-Gm-Message-State: AOJu0YyZEwqgdRTeLK/cwHnHWPzK8GGqrZGyZ3tPDy8/633uLx11wZRM
	aWIHHDDgTbB1oefRKCpiXvE5QWZQ2658rvIxzXTs8XsoQhUyRkoQRSz/nDgsx/eKMaPJATkM0vh
	wKUOJyg==
X-Google-Smtp-Source: AGHT+IFL313crM7366bdymB8A9NsEt7dBWM+iKAnI9tjkhRPwwhupbcJhMxyu2niAAkb9SN6FztymMqhiq8Q
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:eaaa:2f79:c83c:9def])
 (user=irogers job=sendgmr) by 2002:a25:4ac1:0:b0:ddd:7581:1380 with SMTP id
 x184-20020a254ac1000000b00ddd75811380mr2092963yba.11.1714282585305; Sat, 27
 Apr 2024 22:36:25 -0700 (PDT)
Date: Sat, 27 Apr 2024 22:36:14 -0700
In-Reply-To: <20240428053616.1125891-1-irogers@google.com>
Message-Id: <20240428053616.1125891-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240428053616.1125891-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Subject: [RFC PATCH v2 2/3] perf parse-events: Add a retirement latency modifier
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

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.h        | 1 +
 tools/perf/util/parse-events.c | 2 ++
 tools/perf/util/parse-events.h | 1 +
 tools/perf/util/parse-events.l | 3 ++-
 4 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 43f6fd1dcb4d..bd8e84954e34 100644
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

