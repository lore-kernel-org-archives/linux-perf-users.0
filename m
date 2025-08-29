Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A803E2222B4
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Aug 2025 03:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756436872; cv=none; b=GdWfAMlD9vSWihMbAPVav6Hkeuyt/f/W86uYO/DU2TDgWxoDB0L79Fs4iyKqoH0iK0WzxBmr6Qt0vHXUJDiaWOCI+2jUxWoy592Mk63YcrdGpsfgiWlLqe61A+ReQxalv0DvFgHDIb8hdGmp6q+n+gpj4jsg4TboixFILjHWLG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756436872; c=relaxed/simple;
	bh=vPT4VQvFRG2eLzpiomf4pL9pOT2iHADuHZfUC5NZtbk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=VDiHpZDLq0y8tk+IrlfY1XM2k1wQyBKaTsv9GEPmvrDTKcw3KxaSep9oAhY41rDI8aOiZkhOk44yD7gKc2YW0GWAJPOlIFTQrJiABQ4LX1+fjgv1LA3TssN9/VqS6tdbq4XoO2+S026IyfcTCGNyPGtMvPAQUxBBwDiOKvpksb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2QkEsJEg; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2QkEsJEg"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e94dfb23622so2051428276.3
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 20:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756436869; x=1757041669; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8HQ9OhIA434ZXQq0lhegQ9wYn9PPiz6by3gG/UF8TfU=;
        b=2QkEsJEgJ2QQgd0UBSgHuG0KOD9XoEWK1QTE9oXO5Quq79qyhrlYnaed3cVjZHIxHQ
         SGeRdRpkZRAg8phj7qHyjkQtrHvsqW/Ph+a3PlBxgDf4gfaqa8bf37Rz+2Cxjq9YVrXG
         fBky+vMW1EaFECsFCqJGhIIgh7MorCX0SRACquDF4LQPTLS9ZdkorXH24Mzgmv4DOJf9
         ymizpVXzFbYPvjeZMJ5cPgUBJO6w0fgdh2Y7E//bh60zwTdyj7g3E3A2K6qtP1r9LGCc
         IwsIfMLP9rlwcAC4nbLwtQZcngMsB3KJ2EbO7wFusF3h+I4fruZ4umXXzF3qN5mmen7D
         +hOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756436869; x=1757041669;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8HQ9OhIA434ZXQq0lhegQ9wYn9PPiz6by3gG/UF8TfU=;
        b=JvqxPc7QCHFnGeW4Fg/V08o3a/BodFQ9iekbvhiRiF2h9KN9/5sGoP1fV9UgyBn8XY
         OoryV8Ufz/QyjztJsIE9ZKHUXOf4M6BAtzTEv1HunHQIB1IKdMbG7qMeiGF4NslhQ2J+
         RnQfkVHYZWoJCMiz6eVsry4YvPT+8RdNFFaNkir+XyfH9lhSwwZHzFx20/shVMfQ0/zp
         mrOKBMTeB3+Ey4M38tMDMSw2cHHJahl7c78HbdK7hlsfkMqW0Y/oQsFXM6N+McDaNvX7
         2oi1OrWhdW0C2tyvAaZ5LNl9QZpa0bEMEPs9qgLsXJLt2xioSCyf59b/LqbuVpVKJl55
         EcLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaB/L+TZjCqO1daVN8F6y4CMgIuxHxgmMt+HYChBpsmyMnc5uvF2Vh/5qAfgm6lfM8YeHZ11MNvJYhURM8Y2NJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx50IR7vAEGMQSWv7X4oeN5qIToTpUnsXvk1oQSA/t9bZTzYNaW
	o+sVruMW1YGOjvPURpbXeTdS+N5LYF21oapv2TRjf3TzwSLM91rQnmYP4xt+nHUblLy3WqaYuXb
	XIay9LfVXHw==
X-Google-Smtp-Source: AGHT+IGdzjHIa0BbGqS0yZ9Tt3V+4NRLwYmzIEe6Qk7aryOvtgBfXEMbMlaQBPpL6a2bVgBwK4ll1x4z/3MX
X-Received: from ybdq11.prod.google.com ([2002:a25:f40b:0:b0:e93:3801:f5e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6902:1506:b0:e87:b880:7dee
 with SMTP id 3f1490d57ef6-e951c22463dmr33733875276.12.1756436869532; Thu, 28
 Aug 2025 20:07:49 -0700 (PDT)
Date: Thu, 28 Aug 2025 20:07:24 -0700
In-Reply-To: <20250829030727.4159703-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829030727.4159703-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829030727.4159703-11-irogers@google.com>
Subject: [PATCH v5 10/12] perf jevents: Skip optional metrics in metric group list
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

For metric groups, skip metrics in the list that are None. This allows
functions to better optionally return metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index b39189182608..dd8fd06940e6 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -493,13 +493,15 @@ class MetricGroup:
   """
 
   def __init__(self, name: str,
-               metric_list: List[Union[Metric, 'MetricGroup']],
+               metric_list: List[Union[Optional[Metric], Optional['MetricGroup']]],
                description: Optional[str] = None):
     self.name = name
-    self.metric_list = metric_list
+    self.metric_list = []
     self.description = description
     for metric in metric_list:
-      metric.AddToMetricGroup(self)
+      if metric:
+        self.metric_list.append(metric)
+        metric.AddToMetricGroup(self)
 
   def AddToMetricGroup(self, group):
     """Callback used when a MetricGroup is added into another."""
-- 
2.51.0.318.gd7df087d1a-goog

