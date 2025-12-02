Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144822C375E
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 17:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764697912; cv=none; b=PmjVg53Lz+3r5Ov7rOPvUVM+TSZOANsamcRWp2kOGlcbWL35HY7F4cx6Zp0MBs2TEtliGfVBzzhwYtYpCTPb2rl89ki4an6dEhSqEW/Th0bTFjae8438x+/wYjfiXA25w8OE736bv4iixFeb0BewcaGfsCMYdpxR07iKZXgLEjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764697912; c=relaxed/simple;
	bh=XLsJTgjagka2dsiamNyAZTU9RaBavEfkkTGJy4uPs7U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=LbUTJ2NI/cNMuxYBN7vd0w2rM2pdbB501qNPSjmhSAzYfxq7yoHF3kOTzJbhwlGk/bjT94/mQD9Ask3sxGQhJwT1uj3y8HzBLZW5kCLH9SqiVqbS4U6otI/BbWfO7LjgHqQEh2n+PpsqzFg2T/o9t7mo9CGrFFqWRcUidI9Z7TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x4xkHrKV; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x4xkHrKV"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7b9ef46df43so5610163b3a.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 09:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764697910; x=1765302710; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BEKPKSXJVqEyBo5v+XF1vkq0zQUQV06pYRMl8tmk8ts=;
        b=x4xkHrKVhIztLfD/7I9ESPYOa78Ot9D3Lcc8q7gxQD9TvCffZT8IAr13ZoiY8SvpvX
         jv5BWKVQDoBr77lKCOpvstiyYWb95HjWGIgo1TF5pwhhRYDppY2+DIXugDTiJfIcPdic
         KTf6yB8XLUkxJV/uxTqY52nfsQHZ+Kf3GCE3XrBtzohZsSS1mkX6iRfWi450mbQHjvvW
         jW4c3asvpG/YQlqFpkVWvhxq4CtbXPce0imCeEH4sVK2H7YSb90oLHty3jnV8PXueLQu
         ghfEUVvXAOkqjaAtOKhdAMza1sFNoR3fRJyb41xMIvB5RaePBh4v4sosEKi+/5djPNGp
         sHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764697910; x=1765302710;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BEKPKSXJVqEyBo5v+XF1vkq0zQUQV06pYRMl8tmk8ts=;
        b=u2ufdQp1A0c+GTnlwS8ofZtEXgy8HQ07uKtT8h2qaZci9Zw2SbC8GRmib/OcHk802k
         dC6kgJ6Qk9j3ujqcVMDCr/kLzgaaGb3b6naHHKsvQ7cFyMA/PgdGPQe/C8qNlHBj5pAY
         TFI7mwWWzy7YkJ1NShdZi1aBxCf1uRswO9tvvhIkQY7h5TEmypIRFXZsCCKEETwdtg/a
         TqU0iL7ehu2HoOx9WVKAynHpJCGh0jkFn8msMIbeXU0UDPjRe7LFXFDqy0EtLvYek+2H
         mb6+MIV/LCbpVNQ5KyeKGghBMlxuzvLYXDfMhaXMF+O6prDqqaalNaJRGrdnNrxz9Irg
         R3Bw==
X-Forwarded-Encrypted: i=1; AJvYcCUCaVEO8Es5rQvZI1LGHHK3nhNRjwXl0Vg3eZbo7LAqeqjDj1ODqs8J8qwmokjf3IzjWom13g73AhzV8UhaOWih@vger.kernel.org
X-Gm-Message-State: AOJu0Yz18yb9qVcusSWqENEXuCSGm9hAOAOnLOTkpB7LrXyrQpDRFVZj
	SsB55Rkb3U/8D8jHZYCofuMg2kwSij4tnRFJcNw2rTq2zNZQ73I/iITu03zB5DuengQGOpWun5J
	o4Q4pRZ4uNg==
X-Google-Smtp-Source: AGHT+IHLhgeIjP3E8w1A3UKCxPJWw8wcYDNmWLJmWTgrvrXbVIWvAt263kx6nbrqRlfiJN7YfVnDcqL9+if3
X-Received: from pfbmy26-n2.prod.google.com ([2002:a05:6a00:6d5a:20b0:7ba:3994:c73f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:728e:b0:35f:6e12:1851
 with SMTP id adf61e73a8af0-3637dafd94emr31725961637.16.1764697909980; Tue, 02
 Dec 2025 09:51:49 -0800 (PST)
Date: Tue,  2 Dec 2025 09:50:05 -0800
In-Reply-To: <20251202175043.623597-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202175043.623597-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202175043.623597-11-irogers@google.com>
Subject: [PATCH v9 10/48] perf jevents: Move json encoding to its own functions
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

Have dedicated encode functions rather than having them embedded in
MetricGroup. This is to provide some uniformity in the Metric ToXXX
routines.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
---
 tools/perf/pmu-events/metric.py | 34 +++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index e81fed2e29b5..b39189182608 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -484,15 +484,6 @@ class Metric:
   def ToMetricGroupDescriptions(self, root: bool = True) -> Dict[str, str]:
     return {}
 
-class _MetricJsonEncoder(json.JSONEncoder):
-  """Special handling for Metric objects."""
-
-  def default(self, o):
-    if isinstance(o, Metric):
-      return o.ToPerfJson()
-    return json.JSONEncoder.default(self, o)
-
-
 class MetricGroup:
   """A group of metrics.
 
@@ -523,8 +514,11 @@ class MetricGroup:
 
     return result
 
-  def ToPerfJson(self) -> str:
-    return json.dumps(sorted(self.Flatten()), indent=2, cls=_MetricJsonEncoder)
+  def ToPerfJson(self) -> List[Dict[str, str]]:
+    result = []
+    for x in sorted(self.Flatten()):
+      result.append(x.ToPerfJson())
+    return result
 
   def ToMetricGroupDescriptions(self, root: bool = True) -> Dict[str, str]:
     result = {self.name: self.description} if self.description else {}
@@ -533,7 +527,23 @@ class MetricGroup:
     return result
 
   def __str__(self) -> str:
-    return self.ToPerfJson()
+    return str(self.ToPerfJson())
+
+
+def JsonEncodeMetric(x: MetricGroup):
+  class MetricJsonEncoder(json.JSONEncoder):
+    """Special handling for Metric objects."""
+
+    def default(self, o):
+      if isinstance(o, Metric) or isinstance(o, MetricGroup):
+        return o.ToPerfJson()
+      return json.JSONEncoder.default(self, o)
+
+  return json.dumps(x, indent=2, cls=MetricJsonEncoder)
+
+
+def JsonEncodeMetricGroupDescriptions(x: MetricGroup):
+  return json.dumps(x.ToMetricGroupDescriptions(), indent=2)
 
 
 class _RewriteIfExpToSelect(ast.NodeTransformer):
-- 
2.52.0.158.g65b55ccf14-goog

