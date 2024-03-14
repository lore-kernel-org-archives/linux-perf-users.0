Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6994D50A66
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Mar 2024 06:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710396008; cv=none; b=Eob7JKWx1WmHyC1PlYzGXKxkYbxOCdAUuyMD/aZn9KZiBSzjU6OZuSVSvtGt1rWgX1nMLlvfFD7zTu/7jfRICks7tsFhUyfkAtWX6k5+/7FvJ5fjTF7W4SjAaNYZCGRnc0G39S0l51QAc77fzZ8PPn5VxrG76An0fOg6ZfQ3VNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710396008; c=relaxed/simple;
	bh=gFhzpwFPHEzHqdpqsWr4rp9QKQBu1kI7PFwIsR9IC/k=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=SaPP/pe9gnrfFzxzkU7YszpPA/wXSnV/RCRDz53nzP+hZDIdtSvAxfjZGt1CMOuhX9PCiFMgFaOD0uTwKEY7oj43ZNtVsl/KyVbHi8S5SS5M8QLuU6aM0IkWIOBD1eu08xZvh1QJScbwr+aLHr/zT4k0IJHPbuKKyDNTzzPzkzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RRrESQjJ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RRrESQjJ"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-609fe434210so11148177b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Mar 2024 23:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710396006; x=1711000806; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W7vxajjjO2isWih1cYJ4Ij+u5GgCOj0Bgjw8R4VQYtk=;
        b=RRrESQjJ9NzRSA125Ua5W/OWa91CyFKJIrEyXF6GSv7Fu5Hxcb3RGndZXm44dwTt7P
         HfqyTJKPOozeRjGUqHOcDKPpkeI5Ze7c/0SbSVyYVzk89iETYNHf/OTaxUDTOTf4AsMD
         CARkAn/CN2S39WaVaYK1tzn1oSPAbMjkO438AwQ5qpUxDnX9/PqStDaMNnD8uaAvQPZY
         Kvu7XK2I0PMmkK9dzqFnCZ1vhRMGyIEMTDDv0CE/D2PxQE1y96Sa5wHsPxrwz+5FRhBC
         0HXpJ88V2gZ1TI67jdJMSt8SSYkP4afyw5dnwAxAZRPAlBy6KPpzC9BwEljmp5nkjURA
         xnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710396006; x=1711000806;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W7vxajjjO2isWih1cYJ4Ij+u5GgCOj0Bgjw8R4VQYtk=;
        b=TEg2Me0s6cKTlK24zD3OBX9UA72KhedqySwcd6HtbhC1rhz57yCRucW3cMmiGwinT2
         SrTr+QdrzmYSYZNT0dFM4a3Um37oivRigortbBJpIzfphHrrBBn5c3Y9uKxElprMPqiv
         C42mMN23iVGZ4qbU+j6V0L2hztTg83ukmhKGnoNQNA3SASKguxRtAxhPi/X6u5zmG/4Q
         q0QORFtlUYU6G74e5Z5lVWsjB9RvQ5u05taVuK5Z6+ZtAB63khaPOhJKbTC57EHrWo7n
         Kr5nUWQrbz/qCFjdUaUgiDMM5NQyHuUZyNec2fCSTZPVJNZV0QJqvWdWrDYCcLd6SJVI
         e2dA==
X-Forwarded-Encrypted: i=1; AJvYcCVnERf1G8QsbLQApQ9UpeF0g835Wo26olht6R+jPHgq+mb3yGnF8UKoITKJ5rOKxmCbrWejAKRSTZYbc00i3fRiYt/MGlsKbkc4kssQeVkcfA==
X-Gm-Message-State: AOJu0YxZpZAN2OPJig57ZcTq1AoNJUJ5GY2FktqnERf/LNUf/eLZ/Pu4
	y7HKCRQ2xRSPm4D5SQfS7SXbdAnmCmkPcuX6J8NXFQWzpmHs9bCFtczAG+IZ1KA6MAFKwgLZ2IJ
	DsAkeqw==
X-Google-Smtp-Source: AGHT+IHNwiqaYfw65s265xd7PnGQZUyDGWFCZKVZD5ioEDmzy049uZNTjUPtWKfxBg9etYsZdXej7arVN+2D
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:e09:b0:dbd:73bd:e55a with SMTP id
 df9-20020a0569020e0900b00dbd73bde55amr27878ybb.4.1710396006451; Wed, 13 Mar
 2024 23:00:06 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:59:13 -0700
In-Reply-To: <20240314055919.1979781-1-irogers@google.com>
Message-Id: <20240314055919.1979781-15-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055919.1979781-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 14/20] perf jevents: Add Miss Level Parallelism (MLP)
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
index da97a1781be7..6a864c0b863a 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -595,6 +595,20 @@ def IntelL2() -> Optional[MetricGroup]:
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
   pipeline_events = json.load(open(f"{_args.events_path}/x86/{_args.model}/pipeline.json"))
 
@@ -796,6 +810,7 @@ def main() -> None:
       IntelIlp(),
       IntelL2(),
       IntelLdSt(),
+      IntelMlp(),
       IntelPorts(),
       IntelSwpf(),
   ])
-- 
2.44.0.278.ge034bb2e1d-goog

