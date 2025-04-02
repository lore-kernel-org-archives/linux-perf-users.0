Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EF51F3B8D
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Apr 2025 20:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743624984; cv=none; b=JZshz9i1hfIbIR8hN7JP6j7Lap61/0MxN3/Df3+CwwR5b3cGw8wYnmdI0LgDsndQJ6zA3lRT7UOh4A636yWHtgZmZlZ7PP3/FuvC/OGOgghtmBneKBY9EBkXM03Kkw47r7eS7+P3ZewvB5ZiG23Fg1APTbi/3+nkPfJhtot5S7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743624984; c=relaxed/simple;
	bh=WStuIdPt8lRJg1FWf8KPFEILp1PnsGADoTb7+XPTPCo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ilycsZTzyp5aizjJn0c7SrodbAT+5h4v9L0fgZzuKWE2ztaO+lqJjf2/j9KUMqZPgbZ5mqsaO6XpPoHGUQxczU/VHuawyaZKyEjQZzBVmf/A/r+XYU9h6pRKvpKBbSHW3o87W4vddO3gl2z7huYR9pl/G0p9gJ4R9nSekixugQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZcX2JdaF; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZcX2JdaF"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-229668c8659so1477365ad.3
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Apr 2025 13:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743624982; x=1744229782; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3tDmbLrtoU9NWl61/Y1ycLMfPN40NbRlPLTERdTcD4c=;
        b=ZcX2JdaFK797Fd6wlJs0yu/IEeo4JQOLQzzFfk6L3La+glK+BVZJmPYLQ3bBCseKE1
         mqtUrgbxgA0EWcEdYFbUxdzFd7MU5aUL/PTlRFO1Z0Bmj44MBOoIXJtjF4WTzCMW7d9Y
         jRMPV0idDeTqVtGMSHIxeYzsnetKIw6N1jerS1o1c+xKigQwtdRzkiS2CM3uFOhthdlU
         IlIL9HhSedN8i5ZWqh9vCn5Qvx0UR8hPgXYb7tRI+EGMMiPg66lNfE8CIouRJZCtHdUK
         dTiM8JwTScXqfuhiuzsKPjz/p/1+NP6ClW+OKEiAORrH+Go8vO2ReRHwe+0gwrm+8p5e
         CmBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743624982; x=1744229782;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3tDmbLrtoU9NWl61/Y1ycLMfPN40NbRlPLTERdTcD4c=;
        b=i5A0wvvHybH7mLTjXCEx8WR30o910NEZqTnhPfFsosadYLwPcXNcz7SL429wi/bBV+
         aO8wlkL7VxgcKrFijH+mSC8/p+h5heIqf6XEnxX7TDw5XKE9eTwe/OQjVo7ZPITWSsjm
         JoAj5BImnvpQLbm8v7h1q6b9VhB3Kqy0Sk8+v+d8q4bLn0cG7bzqnYutWsOMiaiOdxaD
         okFdQB71bThZoH7owUwSyqJbS5kAFJ375aJyMlYix3i5FjKM61Fj8N8jlNuw6H3isZXR
         XO802dKqAbIcyVazHiEBA87Kwj6+Ju3/nKDYn8IZNuZwBRsx+fF9VcVXOM6pnhefTRg6
         q0zQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlCU34Z7OK3CjyE2i94kT9X5ZQ8UWOyuGJWgM24fR4m2Q5NI4Ec59vkk4OMDcUO9VUfuA+2qIDnclYu3DVSUIj@vger.kernel.org
X-Gm-Message-State: AOJu0YyFpHOrGDWtPyVLki/DuSpCzY4GaZYEDCeUiVB2/JbEJBeJihPw
	s9Ex8tAfOEK+ygW2qKbngy2wXNB0Kc+3cEPtyiI0/Yj2inLEk+5BwVWcqwYvSMxqUb7mc2LSw2e
	XpX/FNQ==
X-Google-Smtp-Source: AGHT+IFPE0DDi1RjFCqnrb0Hi7HSJbP/alBx968X4Vig8llhyMTnMqG2kWgh2WhFFwFKqa7GG5ipt79Ci8Zq
X-Received: from pleu12.prod.google.com ([2002:a17:903:41cc:b0:220:c367:eb6d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ebd1:b0:223:3630:cd32
 with SMTP id d9443c01a7336-2292fa162abmr287207785ad.53.1743624981872; Wed, 02
 Apr 2025 13:16:21 -0700 (PDT)
Date: Wed,  2 Apr 2025 13:15:48 -0700
In-Reply-To: <20250402201549.4090305-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250402201549.4090305-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250402201549.4090305-5-irogers@google.com>
Subject: [PATCH v3 4/5] perf evlist: Add groups to evlist__format_evsels
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Andi Kleen <ak@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Weilin Wang <weilin.wang@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Make groups visible in output:

Before:
{cycles,instructions} ->
cpu_atom/cycles/,cpu_atom/instructions/,cpu_core/cycles/,cpu_core/instructions/

After:
{cycles,instructions} ->
{cpu_atom/cycles/,cpu_atom/instructions/},{cpu_core/cycles/,cpu_core/instructions/}

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evlist.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index ffb5be41a465..6ebe0795e1c9 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -2471,13 +2471,18 @@ struct evsel *evlist__find_evsel(struct evlist *evlist, int idx)
 
 void evlist__format_evsels(struct evlist *evlist, struct strbuf *sb, size_t max_length)
 {
-	struct evsel *evsel;
+	struct evsel *evsel, *leader = NULL;
 	bool first = true;
 
 	evlist__for_each_entry(evlist, evsel) {
+		struct evsel *new_leader = evsel__leader(evsel);
+
 		if (evsel__is_dummy_event(evsel))
 			continue;
 
+		if (leader != new_leader && leader && leader->core.nr_members > 1)
+			strbuf_addch(sb, '}');
+
 		if (!first)
 			strbuf_addch(sb, ',');
 
@@ -2485,9 +2490,15 @@ void evlist__format_evsels(struct evlist *evlist, struct strbuf *sb, size_t max_
 			strbuf_addstr(sb, "...");
 			return;
 		}
+		if (leader != new_leader && new_leader->core.nr_members > 1)
+			strbuf_addch(sb, '{');
+
 		strbuf_addstr(sb, evsel__name(evsel));
 		first = false;
+		leader = new_leader;
 	}
+	if (leader && leader->core.nr_members > 1)
+		strbuf_addch(sb, '}');
 }
 
 void evlist__check_mem_load_aux(struct evlist *evlist)
-- 
2.49.0.504.g3bcea36a83-goog

