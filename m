Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5AA2D47EE
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 17:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764697923; cv=none; b=mYkMEnCDg7rdmknfoYHhHEvPcsSaAXpQIPx+jzh/+VXKnniUXDAYCxLEJcleeuP5U+5Oebf11CVl7v78SG1eZFQvhVDkVAUoJ0QUkxVoZRsRQ8C+CSILAOyilNmfF2qXdYrTMAGYY0AJZwGuiYsHtMBgQ5W7NhZljMPoPWgbiMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764697923; c=relaxed/simple;
	bh=IcQE33lXjfPpknRvMrGb82o9KD6o/Bm0xpa0LZXKGxg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=YUrswy5iz283adaIT1Lu3gCv7ZngvyFE1qwu7VfFkDthgaYMY+MwJOKdE9cTOHdrtOjat21fAwGYg3Vn7SmIhfBSoZL7t3jMOHrpCKwu+bseDYBPfZuVRqYBuXPNOlhX8h56VWx0OStk3roshJqmY1O6Y28QbeD6AVnenm21cQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TRP5wrr0; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TRP5wrr0"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7bb2303fe94so5606022b3a.3
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 09:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764697922; x=1765302722; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+ANYUwQ4vRnr8Tfeed0nEXZFt9sI8XctpT0STC6xRp8=;
        b=TRP5wrr0aFdZkUiN3AkHoZqCZ+p5Uyc8i7i7kz/W5PuN+PybiHcc6zpn/Rhd0TxJgA
         aqY83W7bHB42hsxOM0hephovJtG/HjbEQPdh+yg4lote9LVJkAFZq+LE7tuFB6fIHtaG
         7tztinVa/5fsGQ/TLv1q4H3X/DqjfBMQ8qE1dM9h7jccyJCpBrpZaUScSJJiRSKYDGkm
         7bct5fYDLF0tFlQN0ifDhXRRck+OcLqw/WYl0jVImbWxzBMmRH9nJ9IeoPiC+0sIMqgY
         GAbhxnNljXuNT7XVMpNA7LkksPWMMFGT87+CYGIDDnS3+2a3fhb0ghdEBiWOsm4ogXio
         emxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764697922; x=1765302722;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ANYUwQ4vRnr8Tfeed0nEXZFt9sI8XctpT0STC6xRp8=;
        b=YDIcINp5GULdt/zy75FsIFeJFgRT7zN0DPuVMr2zMYdzYzEZ40xnnnQ5ZxS3f2zluD
         aWfbrXsWyRwidYAgMuI94j1newdtN2rZo/2CMpAGCIOdn5xnWsXZGShbb1k4vDMh5yFs
         XJTmmcPS8O2HVfdD456uQSl+Z2CZzNVXM3XjBMqhvoXoU9asi4ZbIvn7i5q4B8FJ4p8V
         3mdF/Ac2RsL+vLOfBIYRMXX/HXZOj6nfhby/r2egQpqFEObOQH95ze2OUWKhAn+Sp3dj
         4FMx7uw8BNh7mdx+q7gJ50I1mqOAZenb8peQ01OTVFjbIpX78YuLtXdcSe8YmE/24ewW
         OIXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUq0+H3QrXTZxQyJ+ujb8mAu8maOHTEeZ3ITpRuw7fpV+EFgczjYIKlWJ6Sk5oPVjUGNO0HqGko5I029BRmjPe4@vger.kernel.org
X-Gm-Message-State: AOJu0YwHLrhe8BRqZYENu1NYjFfunZH7grWmS2QqW5kxzwOyOCEx0Zp4
	Ai5TSpQHGwYa838atTgnOjcy11ToV6pLvrN4Sp0rMDr4BXwGTfZST459kucD3DzXNEhE4p6gO4T
	F3zAc3mPu4Q==
X-Google-Smtp-Source: AGHT+IF+DOJx23D3lIKPsLM9PwfUaC1iydcEBsjdhnTa5mfDQHg7tgKGyPQBcl3Uj78bLyMSGQEXYzT5e5tS
X-Received: from pfmm22.prod.google.com ([2002:a05:6a00:2496:b0:7dd:8bba:63a7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:939f:b0:35e:9b66:9376
 with SMTP id adf61e73a8af0-363f3a37c24mr419509637.60.1764697921400; Tue, 02
 Dec 2025 09:52:01 -0800 (PST)
Date: Tue,  2 Dec 2025 09:50:07 -0800
In-Reply-To: <20251202175043.623597-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202175043.623597-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202175043.623597-13-irogers@google.com>
Subject: [PATCH v9 12/48] perf jevents: Skip optional metrics in metric group list
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

For metric groups, skip metrics in the list that are None. This allows
functions to better optionally return metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
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
2.52.0.158.g65b55ccf14-goog

