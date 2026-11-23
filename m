Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795418377;
	b=0VvSnQU6ekkl5dFpErpZjoTr2VJRxdhvhh7K+IANBmB/5P3LDT3xz44xydroX/jpErHa
	 P8iZXcdYsE1M4Jo7Xez86CoOynb7uBmjkTK4Tlo8FDHcKpvq6x1sg4xCmjyiRHRtEvTYv
	 YOjK/3M7C8lMurKRuzbijeX9dXzYybifWgJQKQIZltRpEOZnAyATlccXtsaTUcomTglOI
	 8v7uWhKfI8Odr7EOkj4MBbbQFh+XqmoeTJOXZVE6bwajjER6ibDiZp11G0pjMEL4TVRsz
	 A1G47NABKaE9QkBKa5ekPjqPy6Gc2tepdrhl3vquqiCIqYUvPWxHAh7ueYmtpFGkyMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795418377;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=IMd33jYcNZqKzcubrxm3ZjVIehLYL/REobXhw2TBdkc=;
	b=HI3pS4SjxnrXQ5CqcPYSc0eNL/AFAUYGIcNUrPA8T7T+lfIg9sGBu8Sy8ZK2Bycg6Xx3
	 1/T9zgogZqwMgTXFbvQv0HMeWrcxcavFu6oGeYnxYHVIjjs/okmtaK/9aXdFZPLQZGrI9
	 njY720LC71y8eVvFARFe4ps7eXzC33IxPfXL7Q2VWhqE3wNb6hlvhrAylqHjuFQq2L1jF
	 AnPv7BcaFGsbBH16dtqu87bxuP9JUNvNZG//ETBhfKhwsMG8Q7ZTJPtCa5sJogyzZu3ic
	 sz8c0uLOoXve81w7q+1xu0UaUd2HipkbwhBMso38m/kRS+AbZkB+lbv/sLkKj13nZ4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EHNqtqVX;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EC2606A31F
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 07:19:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3EC2606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EHNqtqVX
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3b421417c3cso2486118a91.0
        for <linux-perf-users@vger.kernel.org>; Sun, 22 Nov 2026 23:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795418376; x=1796023176; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IMd33jYcNZqKzcubrxm3ZjVIehLYL/REobXhw2TBdkc=;
        b=EHNqtqVX924a3sJc8UV+EMhdnAvjiJWuS4zowCnFH2JyG4pP/ljl47bjKQjpo7rOUT
         ZFQomX+RGXRmx0QtaKPIrvQgYHfIObJ/kxbLRkHJTBAGc/8qLzqe9V603QoLvU9eDAB/
         32maiYjrS0skMqmHVIQInu5+ZfhVVpaKJEFnFyljW0muVsuEyfsYKs9rDhw77bAOIqiZ
         tGaTVx/stPgcb82KxkuSKRQLPp8fT82n+8/fYqcjshDIlYm0ARx1ndc3RmaFgX2AVv3r
         lMIlt3BiSzao7BVlpt309ZGu/fPye67XZV3unWw9FSJY+rHuAjUKLjNKVYRAVSsFDwd8
         V0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795418376; x=1796023176;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IMd33jYcNZqKzcubrxm3ZjVIehLYL/REobXhw2TBdkc=;
        b=h7rH5QKZMLZ1GHWmFTenrb3RbbWxLG+MJTd5U0d4q93JpP16VcXvS+wKs7quCmWJUH
         xY9Czw+d4t9YxzsKqkyB1WoTkogTaElVqtnHP8oCiRL+KqtyFXrDAWjVLhwojDPcbhF0
         39Rj2B1/r3Aedk48ef9ycah1kT8zHOBCyWtGPKvc4FT0YcKi9Rhr/i4TFok4PtXV90xz
         /zKjwVIBx7TEd6OZ2369oSkbcRiRzwgkvIQMGkLLp+ouWRg1hxvmxmVZL9GJJmMU2F7n
         RTDucYkPRYk4M+IK/GPn8H0s8fcYPGPZPfF+1JvUO0+6Ov7qtNKzYFL+msPkSWyHB4n2
         tqgA==
X-Forwarded-Encrypted: i=1; AL+hErF4idM6PGbf8FndgEJnilWdbFuOxQHY4m8mahnaMfzZGTi2TedmpsHAUABxdLd+ZP5LSzJxwAz7DetttoIbmf0B@vger.kernel.org
X-Gm-Message-State: APuU4Z86LtyjfNRRLCvNOXpilUU4btFOwnaDn7xI8xm9G65JrNt1OVdN
	TmejVse8rTCbqWoMmhLykjlnSJ965hXHL5PszpmaULYPis3FzUo3hfVhTSdmVdhM37vfQas8sFU
	DL6A5PTAQgA==
X-Received: from pjbiz18.prod.google.com ([2002:a17:90a:e792:b0:3b4:23bc:9fe5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:442c:b0:3ac:a203:e0a1
 with SMTP id 98e67ed59e1d1-3b41c92a902mr9665930a91.37.1795418376056; Sun, 22
 Nov 2026 23:19:36 -0800 (PST)
Date: Sun, 22 Nov 2026 23:19:03 -0800
In-Reply-To: <20261123071913.653315-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261123071913.653315-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261123071913.653315-4-irogers@google.com>
Subject: [PATCH v1 03/13] libperf evlist: Recompute CPU map when an evsel goes
 system wide
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: Howard Chu <howardchu95@gmail.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Song Liu <songliubraving@fb.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

perf_evlist__go_system_wide() marks the evsel as system wide and then
propagates the evlist's maps to it. __perf_evlist__propagate_maps()
only assigns the PMU CPUs to evsel->cpus if the map is empty, but an
evsel added after the evlist's maps were created already has the user
requested CPUs propagated (e.g. the "any CPU" map of -1 in per-thread
or workload mode). Going system wide then leaves the evsel opened on
the wrong CPUs.

Drop the existing CPU map before propagating so the evsel is given all
of its PMU's CPUs, as is expected for a system wide event. Propagate the
maps of all evsels, rather than just the one going system wide, so that
evlist->all_cpus is rebuilt. Otherwise the evsel's previous CPUs, such
as the "any CPU" -1, remain in evlist->all_cpus and may cause per-thread
rather than per-CPU mmaps to be used.

Fixes: 811082e4b668 ("perf parse-events: Support user CPUs mixed with threads/processes")
Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/evlist.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index c1c5b0684eed..c6ce56b46ac1 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -835,7 +835,15 @@ void perf_evlist__go_system_wide(struct perf_evlist *evlist, struct perf_evsel *
 {
 	if (!evsel->system_wide) {
 		evsel->system_wide = true;
-		if (evlist->needs_map_propagation)
-			__perf_evlist__propagate_maps(evlist, evsel);
+		if (evlist->needs_map_propagation) {
+			perf_cpu_map__put(evsel->cpus);
+			evsel->cpus = NULL;
+			/*
+			 * Propagate the maps of all evsels, rather than just
+			 * this one, so that evlist->all_cpus is rebuilt and
+			 * doesn't retain this evsel's previous CPUs.
+			 */
+			perf_evlist__propagate_maps(evlist);
+		}
 	}
 }
-- 
2.56.1.750.gf70dc682cf-goog

