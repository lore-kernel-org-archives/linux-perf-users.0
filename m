Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AE0FC09
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Mar 2024 05:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395486; cv=none; b=PuglDpNTZulRpooOitjmsy8IkZh4adM8M3a6CvBfQpS0ZfEAuRLcwdkl5MxCcvqevt1YtGMxTUNB1FGadxnT0l8CbBCwEohipnGvZ1mmseZiQeIbBuVa+iO0crKbIOJ5i2O0cuD88wmP7qMw/Nr+S/hY9oeFDvVWysb75j+xihQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395486; c=relaxed/simple;
	bh=GN4Y68feIoyK84NORTnkVtG7K1dAvlvEPxB9mo8klN0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=sdXDP8GTtjcpx4EV6UQ7l+GW/L3nbi1LMy8eAddcRNaVZGJppO1mX86xCWy/KFcBBCqi+lE0hPB40p9nwgL0cShq2am2QDm+i2cNVcq2doXgPxtQcwt1nmFe254yaNPmAfBCqiSPlVolBr88jhAp8UUbEi9dVyMv0fMiZTtzJQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r/br7fOA; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r/br7fOA"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a55cd262aso11674837b3.2
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Mar 2024 22:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395484; x=1711000284; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cnw+7frKkpFIuv39tcYmSQZnvJ8fkaJfcm6LBjLqiJc=;
        b=r/br7fOAkQIniuUdpruKaK5brvGPEbh6x+MG5zdOSLmXtIVUPRF0BKma8RoHivK1d8
         iyIVQbLynDywRHyG+4g8BTqFCiyl3XQICcTBfUAhYF5Qf976302JG4h5zuXlEDxJymMv
         WnhA/moikRgEGQWCFMeNpHWN1OOJYdFffYZgqxL2fFzItdx3LWJ6cr4z7pGUAcjvRWqL
         NDLb/VhnKD+7Go+9hmaxbdjkJ/hNZsd+ZbcBbUCCjbzOrl1jrqSx0WGRDisaMZ9dEb/S
         IllSSBkM1eHRspfZOc3G/LCaUvzhqh9symfoACOEQyz19tVbIExxsWeue1JM2XJTBlO0
         4+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395484; x=1711000284;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cnw+7frKkpFIuv39tcYmSQZnvJ8fkaJfcm6LBjLqiJc=;
        b=cuc16uDszsP8rPto8WBlpcUAdht8b6BhstdZTS6Tac8fUD3joPELq/piJNKKmQGNnm
         0KWRTcoIg8FzcSKF7KtZ7BhjQpgMEPMfBw3Q5KzvsKcOeI0c7yQc/LNFjRKODGIlHzBY
         CP/ocidjmYC+5hUC+1nCzy33MrEYciBRMzGYT18rukqe6f8+uZqGNW55t8QNjgbOZdjU
         /vEv6D5tYTPfmftk9/vlYomMbq6iUaO0bzGMi2yFr8tkQFp6F5ljVqgk7JSzdA+AwE6o
         zjgaUN/qcvAj4n2OTmheU2Ho96gKFXphFLSTqOeF1DII1gHameJy7JgO1+JwdnpmRpMR
         iTXw==
X-Forwarded-Encrypted: i=1; AJvYcCV+6DOtqrIadhIlEO+RdZvR0CQbxQNFio/96mg1UCcOJntF4OpCWvI9yaJziX+KhONiusIAOhwARBUWsTXOLAEzTUJW5wwCJwEy21mCURm7iA==
X-Gm-Message-State: AOJu0Yys7sUlTCY3mFSExvGEFN+FrWBViyP+ul2UcjiGTRMLNVo3wHe1
	oUHwmUzrvh7uL0En7xzXK2+4Zkqsb11MCd3no4SR6KXgzvUkpWsndmmCJim4MPaWK8uhVjlHtGv
	HEAZyuw==
X-Google-Smtp-Source: AGHT+IEefVp2QC5OaHOxVr60zApScmAZ36NzCqADLg2CL6GAfBmQEcSr+9+qOERum4cvJPHr1mGvB2mN3KA+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:2206:b0:dc6:207e:e8b1 with SMTP
 id dm6-20020a056902220600b00dc6207ee8b1mr252265ybb.2.1710395483764; Wed, 13
 Mar 2024 22:51:23 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:50:42 -0700
In-Reply-To: <20240314055051.1960527-1-irogers@google.com>
Message-Id: <20240314055051.1960527-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055051.1960527-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 03/12] perf jevents: Add descriptions to metricgroup abstraction
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Sandipan Das <sandipan.das@amd.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a function to recursively generate metric group descriptions.

Signed-off-by: Ian Rogers <irogers@google.com>
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
2.44.0.278.ge034bb2e1d-goog

