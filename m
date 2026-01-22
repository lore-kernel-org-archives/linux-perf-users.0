Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D834F3C088D
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 21:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769117743; cv=none; b=aIDr9D8tTfC5918QWaNkh4YcVYbnT0WU+2WcS5N7nhsevzSNoMkniEkdVzhQBVxquOfglPQubmOBUNmhslGwF7FcOR1qqYmaKvjR5VoH40LGpYWkwwnufw/K7ywSUA2e78e+gmoKckcHy2z4useNZWcOV6f796lldWTnIhZUT1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769117743; c=relaxed/simple;
	bh=WqOiFcX/heg3IGph3C/ogbRzFLpcL0diaA21e5ry5lo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=EaWnrY5ZMZazzuWJhFuGtbyIQFAwR2rO6mE1K/ARcOFiW8OKm2DgNWQeyt3Q4c9FcRf/pVkGIzjlcSTlgIUCMKUVLiGKG/ZuhFsP9iLdVKM+b5Wd+lN/KAPfnDk6QTLBSLiyOYcPd3SacycYSy81QCBmzpkUPUp7kTjJMZSVQgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1Y8nq/S7; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1Y8nq/S7"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b71c5826fbso1481507eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 13:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769117729; x=1769722529; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DnbHjkP7sr2MY8dvLIuI6wPgadGKGFiX6WTYohRo5Kw=;
        b=1Y8nq/S7wN0VV3NB0L8PwHjj08D3Y9JAraVXXMj6G/a76O2pZxgMPKygDo7kVYZOHj
         JgkWrADou6WXqOvhWxo3jf0iSbLAJaLH8F7jmRmMXL9wLICY2H/3+BkgFHwTnnf4gzF9
         DpBbtiRxiB47KT3qNFvFt7bTvVmITCnZVHRNjfonbwiSNeRs8pqvuHkSIeiX7eFvi0Vw
         yZlvsjOVqJZ1oAVBZLO6ltwjY1N4yUoD0bbeLoAo/A/EsSV0Zu9zBYjGgqnJqgTjOSq5
         6qX7pZxUDZJd/3JbvKFrB/w05O381VUMhDmxgBSzBCuA+imfuhgEp58v3u9mujeL5mo1
         NRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769117729; x=1769722529;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DnbHjkP7sr2MY8dvLIuI6wPgadGKGFiX6WTYohRo5Kw=;
        b=crqr6tWGrc92ULKQ5Abd/XapHOu1518iIQXL9m7xgSKA9A3Ifruc21DHIjlLJ27SPx
         GxuXVVuNW74dHpasGuTKy5SGrs2lCiXU6BwyUpxnU9WhGjXGiZcxNR47Ln+dO5TvFqd9
         C1JIOiLU4CkXEk6leNWDVk8w0Y2LPKzzH/O0/CHoLanaJh0KfQ7YSaUFerYqMNynCsP5
         4e4CkF5FlOhk/Jr7N1B5LsM6FAqEp1tsEnyTBfdyWbPlXvs1jYT5d6zen6cduUjidOpt
         IV+IXP99Sk6fOHmvsAlW4P0i12odchFSJUZGlWfyF9fDUFv5B8dmY3kgPd5v20B3zkqc
         hunw==
X-Forwarded-Encrypted: i=1; AJvYcCXr7s4kHj24apL7NBFjPbhnJYiw+V5sqZJNuHYs2NNzwBGqnu71OxpcxluKTNNtkv9L/9w5juSrTittjm+7smA2@vger.kernel.org
X-Gm-Message-State: AOJu0YxEXPhLWSpZ0YDOen/NEcMAFsZzwmp0T4O3KeRGiC5f6Y3YnH1t
	uBcogMnIctapEwE6nt51tPIUCp6Ry5kW2vv+7oICT9CKAqTI7SWlTewG+Aqs7xMNlV3leins5Ua
	+vBOy+Atm9A==
X-Received: from dycok8.prod.google.com ([2002:a05:7301:db08:b0:2ac:32e7:3ccd])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:4084:b0:2b7:2263:3d3c
 with SMTP id 5a478bee46e88-2b739b6d29fmr262486eec.24.1769117728705; Thu, 22
 Jan 2026 13:35:28 -0800 (PST)
Date: Thu, 22 Jan 2026 13:35:07 -0800
In-Reply-To: <20260122213516.671089-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260122213516.671089-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260122213516.671089-4-irogers@google.com>
Subject: [PATCH v3 03/12] perf maps: Fix reference count leak in maps__find_ams
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Zecheng Li <zecheng@google.com>, 
	Tianyou Li <tianyou.li@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Suchit Karunakaran <suchitkarunakaran@gmail.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Aditya Bodkhe <aditya.b1@linux.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Shimin Guo <shimin.guo@skydio.com>, 
	Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

ams and so ams->ms.map is an in argument, however, it is also
overwritten. As a map is reference counted, ensure a map__put is done
before overwriting it.

Signed-off-by: Ian Rogers <irogers@google.com>
Fixes: 42fd623b58db ("perf maps: Get map before returning in maps__find")
---
 tools/perf/util/maps.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 8ccc46d515b6..4092211cff62 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -708,6 +708,7 @@ int maps__find_ams(struct maps *maps, struct addr_map_symbol *ams)
 	if (ams->addr < map__start(ams->ms.map) || ams->addr >= map__end(ams->ms.map)) {
 		if (maps == NULL)
 			return -1;
+		map__put(ams->ms.map);
 		ams->ms.map = maps__find(maps, ams->addr);
 		if (ams->ms.map == NULL)
 			return -1;
-- 
2.52.0.457.g6b5491de43-goog

