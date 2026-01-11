Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD8F22AE5D
	for <linux-perf-users@vger.kernel.org>; Sun, 11 Jan 2026 04:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768104840; cv=none; b=Fh3hl1lG4C8gEhCa+VW8aWUElt3+wogBMo2yf7xlCsCSdYb1zZVkwE4RpJF22eNsutMdU/ngJa4P0YySaoapwF3U37PN5S5MHqpBhb80KyihVhFkrcdCs4c0T1kAmRIDuJCMf3na9TlNLu6wtqCPlC6vEH5MaifTxAmcqTGOUYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768104840; c=relaxed/simple;
	bh=8YxkvOf7iZLK/BeDOIUdVZ3lYPXO263sBiceaqqTHTI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=PTWEdzYCpWejXRWy15FqgKBYG6FxlitJ7QiAfbk8wuBTC82PNzBLLe6mpwZFoYLwkVLew0b8u3bX+/IGmZomC6AaE4F/ITBAzorUEi7ccO4InNQ2omTOS9UdxLmryAmV8PyCwmVH+7U7/4QWW1hr7hcYj1f+aZOV8ozkLnXQEoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rd9nDtWm; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rd9nDtWm"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2b04f8c5e84so5623444eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 10 Jan 2026 20:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768104833; x=1768709633; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5BNHEFhnGGjed5J/YPDOkQnS/Jo2dAvhTiC7ye+dE4c=;
        b=Rd9nDtWmyE464BjjZcFJiK8Z4DS+jtqaNLPQUKVfKibIv0gGbUtYBZd253pAg0awLt
         27BC0gypPxsWb5kM9cKFIxmR3fr+87/knrgXfbSi8GfskH9HT8/8SziMFTP6D2kvz5lc
         cMOifWM5CuAPk+/6DyP2dhKuqZovJdbZx+ow0Z4Hpk/6WSOsTMxiSLHfrFDVCl8fdWs8
         0Pg2CW788RbeZx0vIg9+MNKMNwsfX5+yQgDVhpC7ybanPoPTOJDAwRuB6ud7GkeZx7HB
         SpziN4+reFUav4HbN4/92Mne3H2ioDiUZKJW3MoR39wqBcTBXQ+yNqz9wyvvaIpb34dR
         5Xjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768104833; x=1768709633;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5BNHEFhnGGjed5J/YPDOkQnS/Jo2dAvhTiC7ye+dE4c=;
        b=hMyypuNEwnJcgAwCea3JwD/lx+W06HQUSrEOazS2feNZKswv9s1pT/f5P3EG4JXkQr
         5eP2EhZqsBrgJWCOaIbL50exhd0or2adwS0Z6D2zLzQXdt7cLY6chG7wq7iSkd0ZO8rF
         +5WMM6js4/IepdSxwrkTUZHOMdlbzwJitEv2o2noj5tqdbE6YVTtxMZq/g0Q8Zmd2TLK
         XHFsw+TR0WJnuf9bY2VpWLSvsQwGTgNXYYXejdyqIMEHktMcP5bMS0HaF4gGQx87H4VI
         fZI3yoMfmfh7kb5A3QIMEKEv6F7CQCTprle1prDB6lFlwK8+F6V+5bbUP/ghI5oIb3LK
         eVYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxD4n+dHzzZjgodFIfFqVe59/+FUDByGxI6X6bWfZz133vAMAdIwxShnJEDZuaLNyDsDjnew09lRufICMZgwZf@vger.kernel.org
X-Gm-Message-State: AOJu0YyWuI3pQICxNXadGbMI/Pco8eGzO1ki/gWtaKRsLLqKJdI7up84
	X6z03dYmzDm8o1rLWujTbWS0K0+GtrDbUh9h84M94cKBgXBBVFonJS2O772AbBmVPMXVoP3i5cY
	LPFRoH8xoVw==
X-Google-Smtp-Source: AGHT+IG3oJQa/osDAx4C4yoEYcgK5DMss7382VSjjjmLSJIiUVO5dapkoO2JxUJjE0I+441HEDp++UOmFH6O
X-Received: from dybhf13.prod.google.com ([2002:a05:7301:2a0d:b0:2b0:4a35:713f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1e8f:b0:2ae:5d3b:e1c6
 with SMTP id 5a478bee46e88-2b17d31c5a3mr17709461eec.21.1768104832844; Sat, 10
 Jan 2026 20:13:52 -0800 (PST)
Date: Sat, 10 Jan 2026 20:13:36 -0800
In-Reply-To: <20260111041338.1817056-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260111041338.1817056-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260111041338.1817056-6-irogers@google.com>
Subject: [PATCH v3 5/7] perf callchain: Fix srcline printing with inlines
From: Ian Rogers <irogers@google.com>
To: Tony Jones <tonyj@suse.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

sample__fprintf_callchain was using map__fprintf_srcline which won't
report inline line numbers. Fix by using the srcline from the
callchain and falling back to the map variant.

Signed-off-by: Ian Rogers <irogers@google.com>
Fixes: 25da4fab5f66 ("perf evsel: Move fprintf methods to separate source file")
---
 tools/perf/util/evsel_fprintf.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
index 10f1a03c2860..5521d00bff2c 100644
--- a/tools/perf/util/evsel_fprintf.c
+++ b/tools/perf/util/evsel_fprintf.c
@@ -185,8 +185,12 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 			if (print_dso && (!sym || !sym->inlined))
 				printed += map__fprintf_dsoname_dsoff(map, print_dsoff, addr, fp);
 
-			if (print_srcline)
-				printed += map__fprintf_srcline(map, addr, "\n  ", fp);
+			if (print_srcline) {
+				if (node->srcline)
+					printed += fprintf(fp, "\n  %s", node->srcline);
+				else
+					printed += map__fprintf_srcline(map, addr, "\n  ", fp);
+			}
 
 			if (sym && sym->inlined)
 				printed += fprintf(fp, " (inlined)");
-- 
2.52.0.457.g6b5491de43-goog

