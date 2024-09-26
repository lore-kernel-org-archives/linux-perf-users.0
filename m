Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B7A183CBC
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 17:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727372493; cv=none; b=jnyFP2Op9Q27EDnBmoy0o0o1rR97wc9sIOvHMELi0KiNAub+cbFP8sl+QCan5qKxKJ0nBRgQvY5kz3Ru5S8ZwXlS4RDXcJcA0+T/SQc7P+9DZF+0PrKSDZyM/qOefIBfuTVJV3kj+wLsu7q1MzYcWaHDvFvLsoOkwxKCGguFGfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727372493; c=relaxed/simple;
	bh=wxD4M1wPspGNj1qN0DEx2BRkbiGnY9hTYJu4rALfML4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=u1V3hheOoO0H4JaMC9kja4GETqziykQADtCTrKNFUb26RnkcjlRIJLbMMFHJ65bsd7d11RxFAgwOy9+gea2nO81zfm/YPcwpmweSGg1weFDWDpDD9l+LSA0cB0oFzGVRK9U9plNI82NQIn2R9KpNAwGVc66DIZBI04H8II1Uikk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gaB6eSBg; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gaB6eSBg"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e25cc76cae1so1325959276.0
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 10:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727372490; x=1727977290; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jDTPq4kmT2pQ8DOcWhgozy3EZjkzPK6ybUm5utWhT9Y=;
        b=gaB6eSBguKaZJ5/IAoJKoLpUrMoYMqbUew8+g42/qgAW6q92ZaAZrqrO1fbZQ4JoXm
         7qVXeqGBq0kkmbPQd7wHKREgUdApuhiRFYSk5Xvkn6OlcVxOsl/WI03LgrhF4A7o4DdP
         WzUEVQEZsXjcp+YBaoZgQ/Jh9z0ibfd0yp9omZOEdgsz0N1fVWIA8VsLA0O3QGv2RSuk
         DG8366mbCVk+wWWJsOJnMDqZikgBYqHRnCfoKuOVVyFBY58VtwIHZ7L9j1/bD5Kfy3PK
         caKQ533qTBUcfd0wZV8bgsoZO1Pagiqvwzdqlv/Dk7kyYZwiJ47PEtkDNg02nzwP1Wtq
         tZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727372490; x=1727977290;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jDTPq4kmT2pQ8DOcWhgozy3EZjkzPK6ybUm5utWhT9Y=;
        b=hKUcG5Wh/opq9IrnJQvw6BBLeawqSPBokcaSxiTH8GnegCKrOm0atrtiVpf9pbruN1
         dZ4oi71NScdKvNvl9znKlfeRxNcyXj0j7dJS/E7+cdnzyBgKMfMqJl+P8VQIwkJCVi8/
         5kRQQXZ2SdNypyF0lfWL8uAjwWjjOnxiEp4ijQc/DS8WIfjhrKj46ZsrLcGFSAxnd3xO
         CZ8bFJMd1V3WgwSEZ7TnfYuh9BiTj/sXFqFImqksoiOUg+B8KCUtY/Ek0JUenwURmWoX
         jw4blZ8sOd4C8U6sc3Wn5/7PePA0IUceI3lu4TSheEJhv3QAYkTDcR+2oqu5gX+5iajA
         mdKg==
X-Forwarded-Encrypted: i=1; AJvYcCV8FaXXjy49SJWH5WJtfE5F24ioQxfMn1rsqDqjqT0sU2tNJEv1v9FFNuJIQkGGeR4KR/iqkrNMsCc+TXQeqRdz@vger.kernel.org
X-Gm-Message-State: AOJu0YyvLCMzQhs1mM8X1HlyQffblbCaeCi+3O+xWm9bDDf0BdjYae9c
	nf0TSm42tHl32pBSapXiX+Md8NyvdLPc+G+FV4zG8eHGGvaYm4Icu2BefD9U6Q2SJdq14UYtIoV
	nZ46B/g==
X-Google-Smtp-Source: AGHT+IFvUuajtOumWhVZBRqwt3ETVpuf6+/75RE11AuIl6HqgI7V9ZkjPH3FWJbB232qX6+AiGM0F2y6e1Ra
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8872:3585:18ed:a056])
 (user=irogers job=sendgmr) by 2002:a25:a283:0:b0:e24:b971:c4cb with SMTP id
 3f1490d57ef6-e25e4c0eb81mr9080276.2.1727372489479; Thu, 26 Sep 2024 10:41:29
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:40:58 -0700
In-Reply-To: <20240926174101.406874-1-irogers@google.com>
Message-Id: <20240926174101.406874-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926174101.406874-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 09/12] perf jevents: Add uncore l3 metric group for AMD
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Metrics use the amd_l3 PMU for access/miss/hit information.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 7fd2139766f9..af99da14d946 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -466,6 +466,22 @@ def Rapl() -> MetricGroup:
   return MetricGroup("cpu_power", metrics,
                      description="Processor socket power consumption estimates")
 
+def UncoreL3():
+  acc = Event("l3_lookup_state.all_coherent_accesses_to_l3",
+              "l3_lookup_state.all_l3_req_typs")
+  miss = Event("l3_lookup_state.l3_miss",
+               "l3_comb_clstr_state.request_miss")
+  acc = max(acc, miss)
+  hits = acc - miss
+
+  return MetricGroup("l3", [
+      Metric("l3_accesses", "L3 victim cache accesses",
+             d_ratio(acc, interval_sec), "accesses/sec"),
+      Metric("l3_hits", "L3 victim cache hit rate", d_ratio(hits, acc), "100%"),
+      Metric("l3_miss", "L3 victim cache miss rate", d_ratio(miss, acc),
+             "100%"),
+  ], description="L3 cache breakdown per CCX")
+
 
 def main() -> None:
   global _args
@@ -501,6 +517,7 @@ def main() -> None:
       AmdUpc(),
       Idle(),
       Rapl(),
+      UncoreL3(),
   ])
 
   if _args.metricgroups:
-- 
2.46.1.824.gd892dcdcdd-goog

