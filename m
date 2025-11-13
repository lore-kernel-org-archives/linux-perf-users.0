Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDFD3128A2
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 03:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004107; cv=none; b=rdyR/CFwcz3yU9XhDL/FoIgeC6GnnWT74sLtpfl4eO3Xvlj8goF1X+t6usqoInbUl809VLdK2zmvWg9xSzGJh54apokgLkWWS5woQEkjt0riOTcdxLyFElM2rIkc+Ffh4stZhyC+1S9d4sz1dhfp4YD+z4wDwyrLoqh5x5KXouo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004107; c=relaxed/simple;
	bh=Rmc9Mk2TJjPkxXKIysWO7v4RwsuKdTzi2KzZQqaQhXk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=tC1W8abpI9lH4nWcBfFzqiEXy3+yk3Gln2CHYokwFfs//XaUI1LqQLH25priKER26WxouSXdSipXaarhhgGJd2hcFTslBUUYy0j6NOleQ2Q//ITiRU5GpxIALAkM6c+py49pDbQAp/jBttKmfnswR1INE4lacegfO2CzIkANv9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V3NpyqWD; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V3NpyqWD"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-297dfae179bso9355165ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 19:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004106; x=1763608906; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e0W7qHWjzgq/3SCrJVDITzZnKeDXcVKJLkbQQBm9xDY=;
        b=V3NpyqWDgk3sQDGiu1wpMWcQODOcr0XOZ6w/1GcalLYdWEYkTZ6Cc4f0hJAhyFTo0w
         mwYbxO3b5+uSy2DkgolVZnWNEE4faCsmQBRtn23zCPqlvdVqrUbuhxf/OLi4K+KuSGDg
         QZu13y+wlAmSIphJMGV06FlyYv4jgnmgVv40p4Wbdd9UN6N7w1aKQqGT3upLQbMgsBMe
         1m64l1Zo8DAu6GcStIznslPGpF/VbvMYDLwzR0h96fVE3LZaEpT6gJk8P4efFhEezHbb
         F61Vf0CVhE58xafp5JwFTskon/lOWZaO8twkN9pIiXchB/mhsnTCFVHhkW4CzZ54qbit
         KchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004106; x=1763608906;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e0W7qHWjzgq/3SCrJVDITzZnKeDXcVKJLkbQQBm9xDY=;
        b=amg4oAZ//YPIvbK15xo43wQr819p5Ixmq/av5Y/msuwQDmLbSVDR4nLCcjM4pooYyA
         hqWIr8lMHGbZlBMKu3p0xqZjtXj3lqEt5IW1l/KWPSq2+bYWZUkeQAoQavjLvIrf7gq6
         qOp9Xw9PmhAh5r4iaA20eYDly4dy8dWqDrlX8DQSfsRY3owOKFyC8Iq3rCkciCFY5p8h
         FG212t6NvlECu045S2A3t2bNX+z8hxs3XKfAqeG/nLD3/nkcF5jVjoxxckTO/iRb1jS3
         Z6LWapSbaPacQQIJM5K569Xy6GNHmLvEVUIa35SYl9Vh8RjDrrPkFZf3zZoRyAJxB6Yp
         DGEw==
X-Forwarded-Encrypted: i=1; AJvYcCWUJD3IoP4wyL51/y4H35fcPqRGMeTeT3NQ5e1g6xVEuMNE1K9WIdAoWb+5QMBKiHVOaeV4cvTuVt3z3/EOdr7y@vger.kernel.org
X-Gm-Message-State: AOJu0YzA2kv++jwhleuMK1ooItKjUUQyBA1ZPIkA/370XdQbdRbK1Rmu
	BHizxPgFGVAhSypGRwmiTpnVffzzZoiUgjEgvLjUwZkUkKvAogeSg5ggOh2/cj+cv4HzJxtPXft
	ytT/HZC0bJw==
X-Google-Smtp-Source: AGHT+IG5cvHQFAflj/H8F7q4YKM+/R9l4w5HKkSJGiLnEJH7d4s/It9+n5wruHokl7Doy4p99h6ZlWrh64Je
X-Received: from dlaj11.prod.google.com ([2002:a05:701b:280b:b0:119:96ef:3b41])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4b07:b0:298:3892:3275
 with SMTP id d9443c01a7336-2984ede9997mr68944055ad.54.1763004105623; Wed, 12
 Nov 2025 19:21:45 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:15 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-28-irogers@google.com>
Subject: [PATCH v8 27/52] perf jevents: Add uop cache hit/miss rates for AMD
From: Ian Rogers <irogers@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Benjamin Gray <bgray@linux.ibm.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>, 
	James Clark <james.clark@linaro.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Garry <john.g.garry@oracle.com>, Leo Yan <leo.yan@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, Perry Taylor <perry.taylor@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Samantha Alt <samantha.alt@intel.com>, 
	Sandipan Das <sandipan.das@amd.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add metrics giving ratio of uop cache hits to misses.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index da50337557f5..b2e3e2883022 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -584,6 +584,23 @@ def AmdSwpf() -> Optional[MetricGroup]:
                        description="Software prefetch breakdown (CCX L3 = L3 of current thread, Loc CCX = CCX cache on some socket)")
 
 
+def AmdUopCache() -> Optional[MetricGroup]:
+    try:
+        op_cache_hit = Event("op_cache_hit_miss.op_cache_hit")
+        op_cache_miss = Event("op_cache_hit_miss.op_cache_miss")
+    except:
+        return None
+    op_cache_total = op_cache_hit + op_cache_miss
+    return MetricGroup("lpm_uop_cache", [
+        Metric("lpm_uop_cache_hit_ratio", "Uop cache full or partial hits rate",
+               d_ratio(op_cache_hit, op_cache_total),
+               "100%"),
+        Metric("lpm_uop_cache_miss_ratio", "Uop cache misses rate",
+               d_ratio(op_cache_miss, op_cache_total),
+               "100%"),
+    ], description="Micro-op (uop) hit and miss rates.")
+
+
 def AmdUpc() -> Metric:
     ops = Event("ex_ret_ops", "ex_ret_cops")
     upc = d_ratio(ops, smt_cycles)
@@ -675,6 +692,7 @@ def main() -> None:
         AmdLdSt(),
         AmdHwpf(),
         AmdSwpf(),
+        AmdUopCache(),
         AmdUpc(),
         Idle(),
         Rapl(),
-- 
2.51.2.1041.gc1ab5b90ca-goog

