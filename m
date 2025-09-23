Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1212BF010
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 04:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758601170; cv=none; b=JInysv1q1abuGkGg4WagEbLGr0/V2RDSTsrX40u7U7p5gEkd1Pw7/3vAAOlgElekeVPnimtwhGvXlYEdZ1uaLeKxDs+dwKCkwqOInRJ+nNizmFTSRD0f6ep0z3Pup31eu86wlW4tT28LD4eGCGPak7GwEqTGQxYdCxuLUXcBa/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758601170; c=relaxed/simple;
	bh=9O0SNp6qNzDy9oFmBjqIkwm4W7+WsJXlTJVpqO78PTM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=FP+AqZ1C+vhyE8syMmFt+8bglF2VodGy4pQojo1QzKOq7HlJ5A02qWWFGMp9ao2EO2eb3OJeiaq/GCA4iwBH6xM7QIZfJM2SFFBSfOHoNoRKHpUBlWUfYTMGV8egN8hm81QZZXFzXHjvVi2DX8DIF7PTFHGhTMGJDBIBH0sLJTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ry3BU6z1; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ry3BU6z1"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-77f3998c607so2520910b3a.1
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Sep 2025 21:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758601168; x=1759205968; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I0JHoX72jOJKlox/FmxfaLo+8gSeVEW25ROCTEI3UNc=;
        b=Ry3BU6z1AWEESr/Tw2Zd4VC8ocFZVfV7UZwGJXTI3BedZffaNcI5tQV9mTyzmaHEaL
         2jdq4xE2xfL7jr4uNDXRNyyEHJhKtOmgj/17fhqk76V0s7Ex0KU+w1zzFFvMhLDCzdZD
         4jZPuPY0SQGeGEN+hRkpZR0M5Z+809RrZAYUBPYYGWrjMDDFsxoW/PeyW43+u9DCvJkE
         o5x3TqalpihIqV51K/hqdvSboFM29poArdj4p8u5L/Jbm8Y2wnTL8y7GRLp4JP+jnuJp
         Cs9ng5zbQy2BCLHibQJmbKVQPCTcmRDjIjGdDc3uQyEoPW5wGBnq7C+oXsXP73rQX2Xt
         g8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758601168; x=1759205968;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I0JHoX72jOJKlox/FmxfaLo+8gSeVEW25ROCTEI3UNc=;
        b=QMq4TqJ5A6Jd/2pyRhMQv7ARkKGeVghV1XWIs+MxnIGf0y1Q6G+AjLSCznw2lqZAd0
         xdjRph+HKwyiEvicFBT90Ev2FKv7rFDQZq/p5YXdkzMyQzNwiIpONBzUs8KEtnWT4bXB
         pEqg4OmDQlkQIrBPRobWO/q9fPneCwCKi4A1ljhDHrv+kBu6Dj+64fh/klb0u5aFTVb1
         R5xlYJB/53upVeqgXCoVM7ZU6c4Y2vSHLSvUq05CoMDMG81PIL3yABszVoPzK2fd0/WP
         SA8ZrUMStsl0BUbtNeH/ITaXa+BPjDk9UdfqwLYpWn7D/XYxeKBlEyiHMNmOHA21eJmC
         /aCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWI+PfHk+zbpoF9OYu5vT/ND5n3z/kYLNOseSBmFUwuWF17vH9SgdUuAysqrQUwND8YU9ONqMrLiZ2IwIReGqh+@vger.kernel.org
X-Gm-Message-State: AOJu0Yww3bjHW/kDmHRLTLk05cvLCUyvSz7dJNgipEPUnadKxZZdimjc
	SA5289eLba2wKXb92lUcdg36P5KZ4bUGHue8HBMXu7DF39d+Qj1gJcrOKGCtRFcZy+u4JqoxXwy
	kYp0a9bxAZA==
X-Google-Smtp-Source: AGHT+IGvRDv7iYQ4DuiY0lWhYKuV9AopBcB3rCWURZmJh46SLp5NMcg+FG/Da2UNrd8kbLv4JhV9QEWZyBx/
X-Received: from pgco29.prod.google.com ([2002:a63:731d:0:b0:b54:fe45:6acf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:430f:b0:2c4:dbc:6ad6
 with SMTP id adf61e73a8af0-2d01f344d5cmr2004981637.58.1758601167900; Mon, 22
 Sep 2025 21:19:27 -0700 (PDT)
Date: Mon, 22 Sep 2025 21:18:37 -0700
In-Reply-To: <20250923041844.400164-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923041844.400164-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923041844.400164-19-irogers@google.com>
Subject: [PATCH v5 18/25] perf top: Use evlist__new_default when no events specified
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

Rather than distributing the code doing similar things to
evlist__new_default, use the one implementation so that paranoia and
wildcard scanning can be optimized.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-top.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index a11f629c7d76..710604c4f6f6 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1695,11 +1695,13 @@ int cmd_top(int argc, const char **argv)
 		goto out_delete_evlist;
 
 	if (!top.evlist->core.nr_entries) {
-		bool can_profile_kernel = perf_event_paranoid_check(1);
-		int err = parse_event(top.evlist, can_profile_kernel ? "cycles:P" : "cycles:Pu");
+		struct evlist *def_evlist = evlist__new_default();
 
-		if (err)
+		if (!def_evlist)
 			goto out_delete_evlist;
+
+		evlist__splice_list_tail(top.evlist, &def_evlist->core.entries);
+		evlist__delete(def_evlist);
 	}
 
 	status = evswitch__init(&top.evswitch, top.evlist, stderr);
-- 
2.51.0.534.gc79095c0ca-goog

