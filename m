Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75919160873
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 17:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709143006; cv=none; b=iADW34TKrude4EBVCDCrEDO+2rZjfW9+CrthCGPN/QYhHTSJJQiEmcCqghBOmNrFaXLoe1ip43WB3otp1ZeH6TZXTgZ0G1cIWUBh/7U3ziM3XKVsPVWXKi0PNNpz72oE1dCUQaUZgWupgpwxlcD9lGwLhcyuT58ACsGYvVAFKd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709143006; c=relaxed/simple;
	bh=GN4Y68feIoyK84NORTnkVtG7K1dAvlvEPxB9mo8klN0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Lcn//vSCz4lpE/StUf8lszbZXXriPZ6h3B840KNcuU8issKT83A7VoDDd60juvci1cyPCqRsA9vbrb2av87XSo5MgXzeoXFeoeQAFDrc23IG4qWYhOXMPMk11PhQ7TKnks1MEwcAVYxBpgecVAQdDvwjlzmxDj3/ETHC/mODNIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xtJY0am5; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xtJY0am5"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcbfe1a42a4so83464276.2
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 09:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709143003; x=1709747803; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cnw+7frKkpFIuv39tcYmSQZnvJ8fkaJfcm6LBjLqiJc=;
        b=xtJY0am5bmBpdnyEI0PbfJXCt8vf5YwbIwTlCjN8KrC7blauI8P4yuzNOnfj26AWFw
         cl82RgHLUUAfnP/B88Pcbfh4MaidKvhYHImYyH7HIzBmfpgBGNIfzxoTzTGdMig/7DfJ
         4qe65cNanrFGAJQTzPEolYEuRKwRwPoGyNp1GcZDMqrhaarP/1xdzh1kigzCef5Fq9wW
         bqg743asA7hIAZLC50z2asXsQnbqUGH14VJo7FCuHY/TRa/kbE9pEFNLT2rgSlEe5Y+Y
         o2lV+qFy/9iGKaH4dOsHbP+pb3zxAHVX/lov5KWffYeRC7653EYx6W5/HZTrc2m93Qo9
         CMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709143003; x=1709747803;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cnw+7frKkpFIuv39tcYmSQZnvJ8fkaJfcm6LBjLqiJc=;
        b=kEMTo+CWPYtNMEeCzrHFGAAgMVncWQuWmqp6wPVZQXY8RuyVUtL8v2Vp3mjau5i4m4
         itU0GPg7RHnTRDGOETqfHTp/i/sllAA1ESg0y3LUtlDI2pG19BLLpDAz2gaDJ9tpaBeT
         GbUh1R/X7WG4egUThU2ZezcGsgXe9xkxe+gWNCeQBI+FoFyDXjph+ZlxieM7hsg2fqTv
         fbmKpbI/0TMkWthpuWtdmHCEpqkx5KDDhySVKWAgtN9e5jdErKIKKqdoilZblKUWhRrl
         ERIoEPd9WgnQQZyhmiX0EbzowKNaP4dWkLrG2qp5u4tsneyb/khSMCbNezxJD9aqNV4k
         PS2g==
X-Forwarded-Encrypted: i=1; AJvYcCVVbZUcMc0KCZ7Y6J6XcFD9lL/X2HKMAAbjp9IJKmmL3coge6bZ8LSGsvD6vliWcirAowrn3g8K75pvVI1yJub9ux97Zwt3hcW6b9NhG19xJw==
X-Gm-Message-State: AOJu0YzIWwVpI6F16JGfoIjxotbA7aBE2sEtPwjreDXl81IJte7hcWdh
	7VgqiHEWzovxzcuRBnmQFmqTT6ytBETBc8lzymG2mcZU+ncEilKvRGd1Lg/jKGRPAdw4af5fx+B
	IAevHRQ==
X-Google-Smtp-Source: AGHT+IFjrtNDeWnvtWG+hFLz1BVbIHglv6/Izl+y8nYTIxy5JYqi9xl96j5v2z4/0v34Qi4Bomn9Q5bX5VjW
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:1204:b0:dc6:e1ed:bd1a with SMTP
 id s4-20020a056902120400b00dc6e1edbd1amr3766ybu.2.1709143003509; Wed, 28 Feb
 2024 09:56:43 -0800 (PST)
Date: Wed, 28 Feb 2024 09:56:08 -0800
In-Reply-To: <20240228175617.4049201-1-irogers@google.com>
Message-Id: <20240228175617.4049201-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228175617.4049201-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 03/12] perf jevents: Add descriptions to metricgroup abstraction
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

