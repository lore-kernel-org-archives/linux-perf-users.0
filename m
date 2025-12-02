Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F7E2E1F02
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 17:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764698061; cv=none; b=ewRujdxoKpNJxCaZ0CY2TLMWugMkk1vKDVThmzd+YXLAHF6aJ2NTGOkSNcRsRMKWpxC6bxpg+ZUCdG4VIplC1SR5u/pnvvSBJT6qNXHzzO3MBvSk3bzy8z/ZVhusUNuBFBF9JzItrcWctOHYV67sUvKyW3qXTmkoO2SBSBTauj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764698061; c=relaxed/simple;
	bh=lLp/EwIiJ3Y6eXBIRPPl4UiGnFa58wWzARMPVyIpvWM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=gTLKY0cxfFgUQzuxsN5GsH3znbLFSeUS1dJIAJXwnCTFhZ7paCnnnHnczHbxB3yWnEIN0XMGILLr/IHRz4CFp9wIUaYFxuW0uZGZtzQnkekLCJc+lug2xkCMW59FGrU4tUjDNFopuNQ9KV8T9vv6pwno9OwRgSOVnjxFG3kalvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y0n+110R; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y0n+110R"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2a45fea6efbso110639eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 09:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764698059; x=1765302859; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eo8IjqCLzHuyj+yQT0mVIYMzmIbtnJUBm5VjOqIDOeQ=;
        b=Y0n+110RS2d+a4b785LkQj4CoPfHftLCqmRwJVJOdO+7Fi7d3Gvx87C2rZdOJuVmk3
         utjL82MwXuRspKwur6tDzY9JFtSKMDLNMVwMl0EpoACEVc//5G0SVOKiNNshV3I/X9sO
         bzqaNGKqEbnWW8m73FEEVBQ2xoBBHfOyN3ymGaQsciD5WCMYyOEE90CUl0wqG7PYDo0Q
         sb5RjRMTUs5jZFDU48BK+B5iC0yEI/PGyPhR6DsM99olsq7qNJbhTCdLX+bahwK5qHiG
         GU6Z09104UZtaW80bTcaYo4d8TYZOUCpB2rP4Pbvn/loBqAgW4mHyIZEV5aGuz2Ipctc
         Im9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764698059; x=1765302859;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eo8IjqCLzHuyj+yQT0mVIYMzmIbtnJUBm5VjOqIDOeQ=;
        b=SCltzBKEHOGvLVy7UMHQxuIbETRI2boTVgEJLQfDsI212g7276S2N/GsBHiXgb4ZjZ
         9p1yZ735y7cGMmAuZigxdRgo2H/eTVEG7phVY5fhIirDwGdiRcPReXxI/UFCVYIZ27VI
         gC2pKEczyznZV8TNO7ZrP3yYj2uxFeBUX5sa6p6aaMML6N1OEt11UQKKldjSYGMyO06s
         IqAETTYFCTx5o7XSz6KRlKY56oCtQH56x8atUlCtjX6CN4+GvoZw8X28t6MjW+svd5VT
         eUyM4lOY822qe+QSB+Bpg8lcU3RTTVKVu443fHI0wvsPvTq9FCbm0VUOAXmjRkB6Daaj
         qzdQ==
X-Forwarded-Encrypted: i=1; AJvYcCW77datmk6igoRT+MWK010rUDZYYvd0NJHqvQChP3Uf4cxg9v69OLhWVZL6VkhAkgv4Rh2BYZs5+vNnxllof+e5@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ4R4W2MCc4+H1qiVbSTxhM9F7k+bkqtBRiLMO+oS92NLPIVXR
	8eMAPwJfkgX57SMs+wk/u+wMWmBoAH+ZfU6svFiOSEjYBpIfeIXpWRSempJte3pYjRtq9lDRQbF
	ezpXoSJxwww==
X-Google-Smtp-Source: AGHT+IG3aNHAV7LVpknlOYG26QsNocN8RKgb0p5KNXDq476LkdKzA0OODR+GBHsKxCbJCJiNL0EAGlzaQ6DZ
X-Received: from dlnn14.prod.google.com ([2002:a05:7022:618e:b0:119:49ca:6ba1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2604:b0:11c:9c9:224a
 with SMTP id a92af1059eb24-11de939c494mr2159155c88.1.1764698058663; Tue, 02
 Dec 2025 09:54:18 -0800 (PST)
Date: Tue,  2 Dec 2025 09:50:33 -0800
In-Reply-To: <20251202175043.623597-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202175043.623597-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202175043.623597-39-irogers@google.com>
Subject: [PATCH v9 38/48] perf jevents: Add Miss Level Parallelism (MLP)
 metric for Intel
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

Number of outstanding load misses per cycle.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
---
 tools/perf/pmu-events/intel_metrics.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 77b8e10194db..dddeae35e4b4 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -624,6 +624,20 @@ def IntelL2() -> Optional[MetricGroup]:
     ], description="L2 data cache analysis")
 
 
+def IntelMlp() -> Optional[Metric]:
+    try:
+        l1d = Event("L1D_PEND_MISS.PENDING")
+        l1dc = Event("L1D_PEND_MISS.PENDING_CYCLES")
+    except:
+        return None
+
+    l1dc = Select(l1dc / 2, Literal("#smt_on"), l1dc)
+    ml = d_ratio(l1d, l1dc)
+    return Metric("lpm_mlp",
+                  "Miss level parallelism - number of outstanding load misses per cycle (higher is better)",
+                  ml, "load_miss_pending/cycle")
+
+
 def IntelPorts() -> Optional[MetricGroup]:
     pipeline_events = json.load(
         open(f"{_args.events_path}/x86/{_args.model}/pipeline.json"))
@@ -836,6 +850,7 @@ def main() -> None:
         IntelIlp(),
         IntelL2(),
         IntelLdSt(),
+        IntelMlp(),
         IntelPorts(),
         IntelSwpf(),
     ])
-- 
2.52.0.158.g65b55ccf14-goog

