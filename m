Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ED418045
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Mar 2024 05:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395946; cv=none; b=WyBi88aqwCPkI1UwjaDRJaZKrc9GeBbTy7gV5H9QYHf888otSB53/7Qy9ZRTowtMDBd//7ytdplVe6EO8vz5SwXs+t9Y6f6sNsvEJM9QIdGU5nktzkXMTYTuleE0ASsBDC6vA65OkFub7n6gK9PRXy5OzucEJILktlFGajMQzRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395946; c=relaxed/simple;
	bh=A3qe7dMEX2lXbNeL+sr2/wlfhIFe+L9DGvZJP6pwk94=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=eJ+LAf1JK6mC/CDWSvWOUretD6w5PAS53Htqm9nKNUdgewOjd76y27v7OJLy0cGcGjAi+O5KodLbFhZOTBOEUy6i0infzwUChsUs3vajWOATgOf3uaWEfGD8jmto91/r4PKzMg5h8c+sUZQ6jbGJB/NPXocYYSWF64Mh1P+XoOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Si15N7Sq; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Si15N7Sq"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcf22e5b70bso864539276.1
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Mar 2024 22:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395944; x=1711000744; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NROLFT4HVfPyZQ7YdAuPbGl5r8e13yqyBFaFho3+nMQ=;
        b=Si15N7SqefEE20XoTlFaR+2ST7S2GuTXRS697CZw3NBndnHgZdUWYzTh6V5H6TDr4m
         YnmRJmf0eqK3hFrzhUoE6sqe1Z757jRa0kE78o+Ea3At+EqeFyayi6yFRRRPtoig/Miu
         3ZepVv4Zr30tG/DPGk1WX8xm1Zax32msi7dkoAz7W2tz1LeImnn5I5x0wIzFc0idkOxV
         fTMoljj4vPpct677E3M8xKzbi39MpOjwJfFVbl9vlnnnOsyCMbABMG2Xx7liwVJzLQkh
         IpChl4SbtNub26spUzKQR0xcsQOylJ1C5UGEY3v+aQB5+OBmntkXZnVBj3iJiStgk5mS
         u/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395944; x=1711000744;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NROLFT4HVfPyZQ7YdAuPbGl5r8e13yqyBFaFho3+nMQ=;
        b=mTHBIstIXxW29kU0MjQ1+5OH10M9NIaH+PvLMJ/siXd0y7oUwDMZJcjb8825Uujjbk
         7ORkO6IdhvbvpfDXSw8p9VVayh+LbTELZw9EEz7nLpfgVbqCtllnE7ZIxz0jPxKvc9jQ
         QH5JxyW6NuHlG+6q8B2oL2oYe4ueoJt38y94gpY+GCMmxODuXe/bnRbIO9keb0u30SSk
         TWke0v10UeohLedEjjiw8vedSeJGvYFSXV0779BJKiEMHTw5HBPlh6Wx+f3ORawsR8Nh
         zFOtEpMqAEX1fcq5vbZtayplLi2H3CHINgjvc+gje6zav7sLxxkVX6uuHKkLH47tn4eL
         yMAw==
X-Forwarded-Encrypted: i=1; AJvYcCUWME4yjtqJ05WdwIUkQKdx/3e1G7h38Uv8FCVcE+uxi0AJW9M4nDJkrXC8ufYaKk9JM9qLl3hKDjLk53mKrGX7Tpahq/fW8d5a0rT9nDmL3A==
X-Gm-Message-State: AOJu0Yy5oEho6k57z+usFjx+141PNfVbGY/xURMy8ToDmXia2b/ViIl4
	+YV5sB7OeVk2aNBGj1h3Dae6LQdRxQkTof5Wm6G1i5s4hTpMr5BMjUvZcaC81fNSTSDctByySO1
	yVgohoA==
X-Google-Smtp-Source: AGHT+IEkB6E/HmiiV6NChvaNoFf1Ne5N34wILtWGVdfafUgNW4vqbhRifL/71foolCMM/EeILiEhRu1XtVrP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:1004:b0:dc6:44d4:bee0 with SMTP
 id w4-20020a056902100400b00dc644d4bee0mr27734ybt.7.1710395944447; Wed, 13 Mar
 2024 22:59:04 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:58:36 -0700
In-Reply-To: <20240314055839.1975063-1-irogers@google.com>
Message-Id: <20240314055839.1975063-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055839.1975063-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 09/12] perf jevents: Add uncore l3 metric group for AMD
From: Ian Rogers <irogers@google.com>
To: Sandipan Das <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Metrics use the amd_l3 PMU for access/miss/hit information.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 1bddfb939597..79312e33c2d0 100755
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
2.44.0.278.ge034bb2e1d-goog

