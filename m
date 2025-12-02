Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53FF2D0601
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 17:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764697883; cv=none; b=dU/WMj7bDyIz3bCn8vyv0wwOHi40MJAxSrjD2OFY80ZO87k1ZciAPgCKLxhZY0frVWhKM9LfUOCiLpYXKz3muHkLHoNKpWqQDPybjuj9+QEGKqAwVVfDcCDIXy+flOBMMclx/Q9o8hk/ZkiDQr88NlsOBeLqah5KazCT7LCeHhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764697883; c=relaxed/simple;
	bh=vwxaZkM3LBAu55vgpCR4qV7SddK8e04I8IvB0hGoBfU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Vb5KC1FZ1EHBXN/oWmekpyHcR1HZIag+6Vg6nQKtwafpyDfAAUvUMQ5+gB9NuRu/nk0EPMo2Bhq+4GWTOiLgpmyUKqV1PpoLKzuTMA8wL5nY3VfQIbyis7MmFB5H+hB98X3fI3TcooVP0Ef0r/stA2PZ9ZtQc9/XHy14Bgevgj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vxHkB4K+; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vxHkB4K+"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7b6b194cf71so8219483b3a.3
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 09:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764697881; x=1765302681; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4eBuhL77TFL2fSnXXmgwBIbmmZ7aXIBI5vM+VUiCEJ0=;
        b=vxHkB4K+lzs6qbByHJz6+9oQVt5/C8Ya9Sx9q3/RwboEktw4uIloJ1FAaPcBAcKotm
         j/R1YthDoWeZAYs9pX/AJJW3vA9vprMHPR51lRdbRUn6rc20n44ck96bFnDVJm9KUySk
         YWX6kKs/qw5+el3vFAhl4GXCp53S18pjHHYJyAVRaLcqklPLtsM/9S7bXx0uwebMRQ1h
         kNDH3hH8pw7aEIsycHHJH3wO69asp2NMghtCOaGv8c5fMb0XEnAMgfT3FTkNNOsEoQYS
         oeoI/YckrGGsDh2ASoDPQz94MwtxRNJJOCuEJ7HSPNKPrAgWoyw49zAbv+3HLLz9bzmr
         4VmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764697881; x=1765302681;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4eBuhL77TFL2fSnXXmgwBIbmmZ7aXIBI5vM+VUiCEJ0=;
        b=FgL4+DkdSoOAonAzgWBlOIpdAfFuffSpc4JTogCTWVgc2YTMcP4rkpI4p2fk1Vt45g
         n8mJU8Cvs+k8Xi98s0k6fxqNZo/aCWg2zkBkSw+3JJI4Tjwic6KySzuCfgazVaMH2URG
         gcARQRZSEK0py4HNRrTHmOAbH3Ac3ZDVPqYJ9K7HMGcrq5JDtZohHW3/2TX9M/TsyVbM
         LSYrGlv+Ae5q8qxipA1ULPY1HIPwJydHB2lUP+ZyYn3fwJ2cy+SeIOZ/IKJTdiNZ4EmS
         PGnfcfN5PVLDnMCUOEoMvg7+1hJqX0SxwXyInQSfbt/dppf+ugM35xnGknqT8Bo+lqnM
         9inQ==
X-Forwarded-Encrypted: i=1; AJvYcCWl36oZvt3NbhjGv0gt+pU6IfQrYFuhlATd+P8JnMQlvO+lRzLGb3b04wCL9RaOf+2Gx1RFARnPer+SpeW7ODcH@vger.kernel.org
X-Gm-Message-State: AOJu0YyTN4J7c66H40xnBI+wU1KaZ/VBmB6unyELGAd0s7c2IKxtOsGd
	c1KASDaR+O45NTGeaAYRpJnbfQCCoHGjwlwuHm46e+JAztN3fVHftkEigcekawXTUv7QuwhtETX
	ysi5+LF2yKQ==
X-Google-Smtp-Source: AGHT+IFpPPMC8C+B7mNoVMCero6QU+UEKyvKRKDZtS8SLABIWE/LpQ3VkrqrcNR6ZV/Sqev0I4QBjmsZCyNy
X-Received: from dlqq34.prod.google.com ([2002:a05:7022:63a2:b0:119:49ca:6b8b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ea48:10b0:11a:e426:911a
 with SMTP id a92af1059eb24-11defca8b3fmr140040c88.15.1764697881004; Tue, 02
 Dec 2025 09:51:21 -0800 (PST)
Date: Tue,  2 Dec 2025 09:50:00 -0800
In-Reply-To: <20251202175043.623597-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202175043.623597-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202175043.623597-6-irogers@google.com>
Subject: [PATCH v9 05/48] perf jevents: Add descriptions to metricgroup abstraction
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

Add a function to recursively generate metric group descriptions.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
---
 tools/perf/pmu-events/metric.py | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 8a718dd4b1fe..1de4fb72c75e 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -475,6 +475,8 @@ class Metric:
 
     return result
 
+  def ToMetricGroupDescriptions(self, root: bool = True) -> Dict[str, str]:
+    return {}
 
 class _MetricJsonEncoder(json.JSONEncoder):
   """Special handling for Metric objects."""
@@ -493,10 +495,12 @@ class MetricGroup:
   which can facilitate arrangements similar to trees.
   """
 
-  def __init__(self, name: str, metric_list: List[Union[Metric,
-                                                        'MetricGroup']]):
+  def __init__(self, name: str,
+               metric_list: List[Union[Metric, 'MetricGroup']],
+               description: Optional[str] = None):
     self.name = name
     self.metric_list = metric_list
+    self.description = description
     for metric in metric_list:
       metric.AddToMetricGroup(self)
 
@@ -516,6 +520,12 @@ class MetricGroup:
   def ToPerfJson(self) -> str:
     return json.dumps(sorted(self.Flatten()), indent=2, cls=_MetricJsonEncoder)
 
+  def ToMetricGroupDescriptions(self, root: bool = True) -> Dict[str, str]:
+    result = {self.name: self.description} if self.description else {}
+    for x in self.metric_list:
+      result.update(x.ToMetricGroupDescriptions(False))
+    return result
+
   def __str__(self) -> str:
     return self.ToPerfJson()
 
-- 
2.52.0.158.g65b55ccf14-goog

