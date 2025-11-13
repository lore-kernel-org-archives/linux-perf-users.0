Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7B22FF17F
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 03:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004068; cv=none; b=nEFqmYSTVnSSiRZRPn4e1z3Dn3Qcueu1N8Q9Fpl8KkLQwgpxmHp4o2mVlOHq3B7bCa9dDFVpym2xXgeMT8IoNkXt+HSz4SfIoheWHz9q24dETEBaSVy+nhGVflXyu/MH81s7qA5WhOlqtzrp2Oidvaa5r9cgdAQ3/rRhm15cdGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004068; c=relaxed/simple;
	bh=ZVqmyB6OSryveZQXvh1Xn2qAe2+tRfiieZ2LkO2RQZ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=QrpjTDG+y9JQubrPIipKYJFnLpcAP2lZXErbJsho45b/MNjoAfVX78TLg5wlWX5IZUto2RytqlJcmV7gLSyaPmixGrM+576TGAOH8kC+KS7dUGjxRtN7hEvx/WcveNfFB75LmNLjWxz8sgNy+2c3e5iRWy9bHgjMK1PhYLHGans=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tco07iOb; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tco07iOb"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-298535ef0ccso4198155ad.3
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 19:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004066; x=1763608866; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HZtMwfOFV/dtSsF90vpb0DLWSRxMS8PqbqLlwx+J+Pg=;
        b=tco07iObFyGIviRj5DZVYVfgjqmgP6dkyo6jOBqtcbI3J1cExxD6ojGpBGxh74E6Qd
         jI/vgkcIvBWCi1fttUzb7mnJFj7bhVBwROUGzYX3TxO9wI6/71buw0Tfev1SWVKrdRZy
         LXvLrVfj2+uy/EQXFkNAPoDZwRODlU/TQfVGZ9eewWPhWPp34pJgDAa56kNSlrt9Z4/I
         oEA+Xjh2yrK+jKAvDHQ3h9yKklTWxrQ2dERE5hJjUuVe5rn55LiEQ2qJFngCfVb0C6Bg
         lKokffvFPtWk0pzuRmB72fAwkNqXLaXkxzidivbJJpQPJ6EV7rjRcEhK2WD4MzbOZ9Bl
         ZYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004066; x=1763608866;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HZtMwfOFV/dtSsF90vpb0DLWSRxMS8PqbqLlwx+J+Pg=;
        b=L4PzrDV4NKq+rCrRj4QRBGHcj0+EILp74C6W4k6YYbaUoM56oj+I8vsEFoBcRJ9lXg
         qPvL7pZDh1MprSzAGzO/wXf0FDT8pFhLiUi7etTsCbp0xhuntaJdXtwshfznOAEA481w
         3uaoOM9fp9sZV12dFYNGiKhs9XXbvo0xHwwd4O45ZZ8C3KkdVXSHG16afIxtrTx/7z/6
         O95WSxchYk1Y/A5RiMAaNrpRcgYWMTnn3tF9U9o92bbcjpM++xMb0vAnrR8kjJANvvdZ
         I6/uEumTKO2Tc2WLsxDe4UqeavzuSA1rfeKQdF01t9yN46p1oM9UOuVTGo52YW6teZTq
         rYPw==
X-Forwarded-Encrypted: i=1; AJvYcCWJGmvd728lEE7psRNX+FhK+e8SmaRS67tmhwMOOAhinVQXZzBywQ4Cu1xmhCga23xdF7Ec8bm+a3TTb8JJ1xrt@vger.kernel.org
X-Gm-Message-State: AOJu0YzYsuvXnK2xGAw8PfW2umqBFWujjLETouHyHxcio+vtsESZ8JOl
	9tgZytph2GVCFP+9n4CnTMC5umWt31JBkSnQEqM5Jp1kEFiTC6BhSW+u8Fkp3B17EdtmqNw2csw
	rJ1ZYKF4nxA==
X-Google-Smtp-Source: AGHT+IGzfXPPP0XRZIc++oBFeMBvFwsuQtL64YrTHwxXng9XAgKCleeZUqQdWE8DaNvnw3K6l1Acy5B4Jc7l
X-Received: from dykh11.prod.google.com ([2002:a05:7300:570b:b0:2a4:7587:4d39])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d54c:b0:295:56da:62a4
 with SMTP id d9443c01a7336-2984ee03b56mr65760445ad.45.1763004066230; Wed, 12
 Nov 2025 19:21:06 -0800 (PST)
Date: Wed, 12 Nov 2025 19:19:54 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-7-irogers@google.com>
Subject: [PATCH v8 06/52] perf jevents: Allow metric groups not to be named
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

It can be convenient to have unnamed metric groups for the sake of
organizing other metrics and metric groups. An unspecified name
shouldn't contribute to the MetricGroup json value, so don't record
it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 1de4fb72c75e..847b614d40d5 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -455,7 +455,8 @@ class Metric:
 
   def AddToMetricGroup(self, group):
     """Callback used when being added to a MetricGroup."""
-    self.groups.add(group.name)
+    if group.name:
+      self.groups.add(group.name)
 
   def Flatten(self) -> Set['Metric']:
     """Return a leaf metric."""
-- 
2.51.2.1041.gc1ab5b90ca-goog

