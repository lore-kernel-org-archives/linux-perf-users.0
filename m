Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE89742067
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Mar 2024 18:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709319410; cv=none; b=VgIsbtBIyMZ1jUVAsGDPmIbEN5kieqijNPOh8Wtml0Ybl+hHVyamvaj+Kn3iNwuXfaZvzRhbwmqAVvOHkjfdp6i6Ilawhi3/bHseVjOPQr3XQzWgDXc2RHXHoXuInztyQ7EHOg2RMYrMU4hupJkJVjmj4GRrUWPu6vevohInqdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709319410; c=relaxed/simple;
	bh=ioqKuJWewNQmhIwOmTO7CGCh23AwMW0/VlYh24IVFkw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=GmCGVc6toxoyjqmtZAQtptH4j3/gsYaa9nRtj4M+0n+LkCiwgEMP1NSMD9YEBDkr4zg4eF52gb5O47KOIziZZncZ4DI+rvtfcFaOUASDcPwhZ88DY2p8hVmhdd6TZWbXMao+Ry1v3KeqEA8FGH7xzHASl7PM5psh2QcI9eUVkGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ytYvK3rB; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ytYvK3rB"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60832a48684so34388587b3.1
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Mar 2024 10:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709319408; x=1709924208; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j29r0+uRis6oMNX35QsnEUIN73H3JiunuyPnByIi9hc=;
        b=ytYvK3rBsX0Y2xqWdG6ypjs6MFmehN1zGOP61V9132ZQxdSB+NqJWqzQ9MquNI40cJ
         43EFc0wrRcvUy591bRGSYM//rGz6O81MeEea8sTehq67xfZo83qac3ISFzCYlDO/6BNm
         mKlYjzWUxrav2GqG7eaMf+mrwv9Sk5VYxfrw5nDGmEa0TQD0ahJkYLFtSshMjB2JcNkF
         3Cv+G0IgNKYv4gMILjDoyPv+VantE5Bp2YGu/SnBRWW+HYz1Ho2fSwpWC9grALa7sBsx
         oEBv8ODNAp84NlTflDKLW+zh0bpsbjvMEM4eBSkL8iitjtE+B8B04x8e54/kDzFIzISH
         S7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709319408; x=1709924208;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j29r0+uRis6oMNX35QsnEUIN73H3JiunuyPnByIi9hc=;
        b=eleIsWK7ekk55uaSL7YoMLGmjuvM+zPF1DR5wEq9HWXdT0sf7I6ny3e6pglzaIavjH
         cxfbTToQr0zaW0ZRLd5w2y6GxIHn1yh86tcCRp0F0I9LQiotuTWFwvxPt8AP9wXnCx3s
         yn1IdmF3lHW6MOzNjOsJK3ZGiUlNer7lhWNJGlAE4Ccr5ecrdKxGSK4jNtLgpK3913KC
         cgajecGpWDVQPtqwXYf86k8Cu7/nseTP/8J16LMeYCTiVu4vMw2jXAqXuIlaRgZ1EwfJ
         U3qFR5H1UjEFP+CycQnTZX7IKUMhsYcRl1RC7kSdHpHrea6nIFwUzDCqd7qRJP8E+p3k
         J9og==
X-Forwarded-Encrypted: i=1; AJvYcCXJCeqeE6DHTwXOvlE71/mTeYJkCIxLg9N4YC6wZtIWNcFIFYt0edv+tBIHon3D8M6FQnp5+dI5cbhkD+c/+IYxgA2mPY3DgZAwmV1D9qNJ6A==
X-Gm-Message-State: AOJu0YwyJYRK7/UMHtdV9tF0+Dl22jbkIgWNiuXKY8Bc3kcZ5JMeV+uc
	KZzJlplDbPzKOnN7cV63DMHmkmyfITOh9N398B1LCKRSlgoN6+ogk278fDNlkExwmpexMHvmqMa
	+Tc1Q/g==
X-Google-Smtp-Source: AGHT+IGKC95PVGcc/vbSVyPdG7qyY7ADCiD3b2UKPwJGOqVAXiZwP3VxyaDvT3c8w7YXBOBh4uN1Nw4liePH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a81:9950:0:b0:609:4d6f:7c0b with SMTP id
 q77-20020a819950000000b006094d6f7c0bmr473405ywg.4.1709319408201; Fri, 01 Mar
 2024 10:56:48 -0800 (PST)
Date: Fri,  1 Mar 2024 10:55:53 -0800
In-Reply-To: <20240301185559.2661241-1-irogers@google.com>
Message-Id: <20240301185559.2661241-15-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301185559.2661241-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 14/20] perf jevents: Add Miss Level Parallelism (MLP)
 metric for Intel
From: Ian Rogers <irogers@google.com>
To: Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@arm.com>, John Garry <john.g.garry@oracle.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Number of outstanding load misses per cycle.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 6f18d5fd9f95..2cd30c557a59 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -601,6 +601,20 @@ def IntelL2() -> Optional[MetricGroup]:
   ], description = "L2 data cache analysis")
 
 
+def IntelMlp() -> Optional[Metric]:
+  try:
+    l1d = Event("L1D_PEND_MISS.PENDING")
+    l1dc = Event("L1D_PEND_MISS.PENDING_CYCLES")
+  except:
+    return None
+
+  l1dc = Select(l1dc / 2, Literal("#smt_on"), l1dc)
+  ml = d_ratio(l1d, l1dc)
+  return Metric("mlp",
+                "Miss level parallelism - number of outstanding load misses per cycle (higher is better)",
+                ml, "load_miss_pending/cycle")
+
+
 def IntelPorts() -> Optional[MetricGroup]:
   pipeline_events = json.load(open(f"{os.path.dirname(os.path.realpath(__file__))}"
                                    f"/arch/x86/{args.model}/pipeline.json"))
@@ -781,6 +795,7 @@ all_metrics = MetricGroup("", [
     IntelIlp(),
     IntelL2(),
     IntelLdSt(),
+    IntelMlp(),
     IntelPorts(),
     IntelSwpf(),
 ])
-- 
2.44.0.278.ge034bb2e1d-goog

