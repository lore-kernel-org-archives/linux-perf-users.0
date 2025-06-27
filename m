Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77762ECE8C
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 19:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751052280; cv=none; b=HSc7DdF8YN9wyvsLwCZoNq5cjP4J6WpXh/q+AT/NaQH+ltZvwJEhRPI2EWVi50d26v0G8PKlzprQjk4Fadlu1AIrJ4WjpXeqP1EKz71Bnm7Fq778gWh3pdAbOeuQqv0xeLsm9pShoeRFif53IJIp6E0jNalf0ElRyhHtuMhy0wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751052280; c=relaxed/simple;
	bh=W/Bgi88P7ofhS46Nff6nKg74LxXfuxahRJerKgQn9dE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=emukxQWVQE/P5TUADBWswBaEnr2eI3u/j3h/NT3UIjWZOZd6t9MZK3j6IQTo9QOgW7HFI7CikCePq7KGGBW7Yd3WV78GDWWbLbEeShtIqIrrXp1ORxdYwI41+7TDq62nfoSWXpdVBP+eO5fpy2cjbwogZod0klZgGFiDnXSxOcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1KbZQtfn; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1KbZQtfn"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b321087b1cdso414327a12.2
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 12:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751052277; x=1751657077; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8wGh4hX39HaAnm9ZkRFU2LxfzpD4g1EXGGa3gXUj2fU=;
        b=1KbZQtfn53TgxgwD7EYZ/Tq2rUHaR8SHVWvdInGNQXD4ycOwUkjLI5cERb8uRzSe+U
         JQ8/baFUqQPbhIy69TEcrbC3AXfaIWcZ3qcQSiP1ZJ/RVG3Ts/2TydBCZ5dKQFenzqkn
         TBQ4NCGxrjzrexYehYBn57Ps5unlNFXB9aMu7DIut0koz2LRjcM7PkM8qdiTUqL8bDPd
         Pyt/qtNfrc47Juw7f1jfiq7afmRsWV0lsEueVqX5VHzWndxnkmDpnNvNp7S+weWXArtS
         7hwyGBN0+wEn9U5sfvRM2ZkGaCyXXbrd0Lov6o5/xbrhu4iiqQtCHPtiJGL/aVebFYMr
         nrnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751052277; x=1751657077;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8wGh4hX39HaAnm9ZkRFU2LxfzpD4g1EXGGa3gXUj2fU=;
        b=tI3iPYCwC4+txwqButD4nDEwX7uJBeLPRO4AuqX3x5iSCzSbDJSK/LQXxeM/DhrbSh
         LyjrruvpmEG09bMihLN0imQpMp5r0oZzU3UI2BxVKWu+YjEAkSnnLqAER1RD6/qe7SGq
         bwBSrI8cFBOAZzs3QmFgdeP9CzmiLrhsKVR54YltOyJyIItwoCXK8y9/cUG6B+qAIc9V
         QbQ+vKKp+JZIY7mkngAoguoKw7HfbHLfWLvv1BVN0pmsSRavAcP1KppU/OJVOvz4o+rg
         WSXxN4XNywKGXBUDzrRus++bad7zLpTrEkXOyTsvDgtpPMOMVGHfcE3uC8EfcJqSzg2k
         PF1A==
X-Forwarded-Encrypted: i=1; AJvYcCUPNvW4Srmso1uaSBSXaQ5eatzdbpmsrSVH92MV8llj/c2BjSD7TCLaLA1BDMET2Pq/GAE/Skl0wFoFXPafkqzO@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3YdXZtcmJjlgqrIfyvnd/mY5YsrDhJhTqB4XF3ZXFqsVEep1C
	afA2GtNCIzpZ2bEcKOu87Qb5pG9EaDstxwJWQ6MnwuvQFu5ieup4sV23rGe1zBLeTEPiSTGGIZe
	aU5sZo4oDdg==
X-Google-Smtp-Source: AGHT+IEZpbwsDnk4xblx0rI3Vgl53NcXt0AkOZrWxv3lkOu/3ULvVG1OsFbztyxBw/CpwMw10ECrUDqJtF6b
X-Received: from pjbsg10.prod.google.com ([2002:a17:90b:520a:b0:30a:31eb:ec8e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d0d:b0:311:df4b:4b94
 with SMTP id 98e67ed59e1d1-318c8eccfd1mr5463074a91.4.1751052277148; Fri, 27
 Jun 2025 12:24:37 -0700 (PDT)
Date: Fri, 27 Jun 2025 12:24:13 -0700
In-Reply-To: <20250627192417.1157736-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250627192417.1157736-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250627192417.1157736-9-irogers@google.com>
Subject: [PATCH v1 08/12] perf evsel: Use libperf perf_evsel__exit
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ben Gainey <ben.gainey@arm.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Blake Jones <blakejones@google.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Anubhav Shelat <ashelat@redhat.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Song Liu <song@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Avoid the duplicated code and better enable perf_evsel to change.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 8caee925bd4c..1169aa60c5fc 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1669,9 +1669,7 @@ void evsel__exit(struct evsel *evsel)
 	perf_evsel__free_id(&evsel->core);
 	evsel__free_config_terms(evsel);
 	cgroup__put(evsel->cgrp);
-	perf_cpu_map__put(evsel->core.cpus);
-	perf_cpu_map__put(evsel->core.pmu_cpus);
-	perf_thread_map__put(evsel->core.threads);
+	perf_evsel__exit(&evsel->core);
 	zfree(&evsel->group_name);
 	zfree(&evsel->name);
 #ifdef HAVE_LIBTRACEEVENT
-- 
2.50.0.727.gbf7dc18ff4-goog

