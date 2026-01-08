Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BA6338935
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2026 21:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767907639; cv=none; b=qhn6VIyFZAMGYvndi92HnE3E5bqcv91nil1hBqyZFWhMeRdVFArZog1ABpvNnk/KgzDVWxAEsKLSTZExU27NaP5+Yj5XNWVLB4aqy31u+ZGFB5gmI3zbzcdYNEqvy9wkRmLv80lWB92xYvGfVDCiqagSCNT5I+I7HykXRGH+Xg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767907639; c=relaxed/simple;
	bh=gij9HVFo+8YcRc2A29tLhsb/VSjGl5q57WrozqE/p1Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=uPEAGkXEqpK4zGPlyySF5fJYh40GG0dt+jMjOBi97jIs1ZfMmL0hMSWqCyuo+tkk3twOiT2arqLQsGwOYOLJEBaMBlBWVlQZLDwh4bXq7XD/DWqTYsVlFuyOyaWD2iMVZxEqkQWcN7FodYaLB3tbwkmYTFAELr8y4PIDz4NX15o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UCrOpSXg; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UCrOpSXg"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-11b94abc09dso4342919c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jan 2026 13:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767907637; x=1768512437; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JJOaT7VWATb5931yVIrXVJY+gMVDezHuu16jYMmARaA=;
        b=UCrOpSXgqwAsUkAgqDurT+7VYRIqgEbFbUOTDI6pOnKlEUlbTA3m2fDAn5QbGG012S
         RLn8cgcU92fJZviNUpKhhFwxd27xutyZE2w/xfqMJ30TTOovnaaN0WKT18JVZNb6qhV8
         8kJ2pde9h//k7u1es3Twkvl8kt+ZSR6hnCldt1OivhsHSzI2RcsCYQqlQKSg3+QromiR
         GM3CM7w2kBrcfvwW78N/qtIDy/KTO/8bgc9Da/w8w8ih8Z1/DBXx7EIF1bV0Q77ERfZa
         lvwhdyLAminjl861NUryJ597GUH3/hLHwKg9MdAny3leqEnCRInfybYwaPXX06mi9qfT
         +QyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767907637; x=1768512437;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JJOaT7VWATb5931yVIrXVJY+gMVDezHuu16jYMmARaA=;
        b=JCSvghzQ9fC6rqCiAt2KM4zU8ixrA6LOF4flxgPLJy+fJfp862TgZC99nc0JpyDHmu
         v6P8XD+XNp53Cc/CZU2Go/3+nD/Py1eqsl1Po6qftpHHuKZgtxf//0uy+8WSR2UpPo7Q
         GP9fiVD4rI71FGrxu+6tEiVEMoY/pBiuYkwHVUlt0icHYngCBzAtvNrYIGZ6fCMKArpq
         O8wBq5NX3O+pXYcJffgC/jEHRlYPyhV+lSYrf7vgfwz8v2OqYlGwizj5w6At/ip6qm12
         aUXTGIkKw2E07XrqTcI1tfRtfsr8Mb7AsDWooBUXK96EV3G8RUpDYGPAtVEBXgKQtBcQ
         mZxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlcy5yb9NkTMaQ16BdcmkHzN24ksx1K65PJB3V6VNeIH0RCjpAnGim28ZNl+OFu6D/iJXl3B9geqnBpkL+l27b@vger.kernel.org
X-Gm-Message-State: AOJu0YzPqhIxF3hjA1iVnGKuZgQ6aFzLKAOZCCcbvxnu3X7vmxRvpvHB
	1Vf/Pco+mGQaMLvLt//wShk+vL65rQ6K27tE8yx9VIFeD7W2gGilQX9hHEJ+5FZxxNhOeB1wQiN
	zLsthC6Iqtw==
X-Google-Smtp-Source: AGHT+IFz3KgK5j6u4eklj/8Bl9SBNLi5PlkGJkS2SZG1fYowmsCYCqslh5e1ENtRqxQ9ZP9/Pnu5lyK/YAWa
X-Received: from dlbqi2.prod.google.com ([2002:a05:7022:ebc2:b0:120:5def:9544])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:fe08:b0:122:1d4:28ff
 with SMTP id a92af1059eb24-12201d42ac2mr2248712c88.26.1767907636815; Thu, 08
 Jan 2026 13:27:16 -0800 (PST)
Date: Thu,  8 Jan 2026 13:26:50 -0800
In-Reply-To: <20260108212652.768875-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260108212652.768875-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260108212652.768875-2-irogers@google.com>
Subject: [PATCH v6 1/3] perf evlist: Missing TPEBS close in evlist__close
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Yang Li <yang.lee@linux.alibaba.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

The libperf evsel close won't close TPEBS events properly. Add a test
to do this. The libperf close routine is used in evlist__close for
affinity reasons.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evlist.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 649519628541..bb042d89e6a0 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1356,6 +1356,8 @@ void evlist__close(struct evlist *evlist)
 		return;
 
 	evlist__for_each_cpu(evlist_cpu_itr, evlist, &affinity) {
+		if (evlist_cpu_itr.cpu_map_idx == 0 && evsel__is_retire_lat(evlist_cpu_itr.evsel))
+			evsel__tpebs_close(evlist_cpu_itr.evsel);
 		perf_evsel__close_cpu(&evlist_cpu_itr.evsel->core,
 				      evlist_cpu_itr.cpu_map_idx);
 	}
-- 
2.52.0.457.g6b5491de43-goog

