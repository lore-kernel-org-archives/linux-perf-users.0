Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205E3230BE9
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Aug 2025 03:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756436860; cv=none; b=OCgeugn3TgFY2+dkaZBmreGIZtY8kXVCrju9VTd2aAOSLDsT+z5n1KNCc03wZPaikssUPyQtA5o2u/WxUN/4dVXtkcqBHbxnPGqRMSriEqPPJ0B6zGWZvonJEyrsCkYew2ZKkW9aw1NIclWIuRk+P0xUEU0WI8Dtp4IGA0VZrxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756436860; c=relaxed/simple;
	bh=2SPnKIFCU+FQBYmrghSz9B73YgOF3w87PVycTgRd918=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=iUJt06dKgwjhG8//ecJZNaqxFYppvAKdyhtpUTUjp18pJZl1BHLI0ydRt7Sn8s8sZkGjtLi7oNve5XIkOO5VG8gOjUrt21kSMM09WD06Pvjqig5kGlf+nUvTd/yZIMLPzSqDFjV/gL9sSaaogUrp6OCoezRJq5VuLl7jdUSkYQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E7QxjNIC; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E7QxjNIC"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76e395107e2so1640888b3a.3
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 20:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756436857; x=1757041657; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wF9CmQztZ8m+ClwavvS0RwKzE4shCD55tHGvz6T3N3U=;
        b=E7QxjNICA3TGuUks7yjnoMKY8MPqj8J5SDks4QfTZzo8BGnqjUHYm8NL/PxjEHLy0i
         /FFmn+e7xz0lO186z1H1iv2xUuOM4ElZqDYRvQlaWPyhNvW/CyqGYu2Lz611E0h/7wpm
         FFZNTLtjbUSenM52L3ZaoyUhZYlEpjyycP9XgDIpirJsf3930jNgST61nSvmL8eHkDx9
         C3vGUJJ5u+z3lz3RaWVInpRDCLG9rSbQy+dpUQ+lZ6lDj9Q1Ev9ViuB8Pi4OmTil+0U2
         Rb+JDE1IQpUl0Xi50S1xNKjSJ5bkHdSsiakANXeuRkv1m+eyEZl7WwcbWjPBzNFEfcVh
         SniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756436857; x=1757041657;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wF9CmQztZ8m+ClwavvS0RwKzE4shCD55tHGvz6T3N3U=;
        b=BbK0AMmejveeop1xOBCbbGL8N+ooxd3OxfkEFL8qRb9HHFxESTDj2/sGYgCcNFJYBr
         jzZJDHKorELoPnHLtoPMcuolVDNNTUBQJ/eQYcwpIhWVIK1RPsiQRdtHIQxcm/rAG1Pm
         vAs+ekg58R8vBB75jDIP15wcgXJvyuDjsvAlOe+XyRe4wW+6c70jBp1+3ZNolGXxevdm
         0nQTbNaDr5BQb9D2Y2GV7vgudw+dU5miWB0SfjF4rbECIJlxHJiFP/Hm6nsyXFMKnV7S
         w2II6xedhXoucdlmN85lmeSrAnlDkdIFq30tdQELxx4YjOACsoZiNgxGjxx2VbxYxOss
         jk8w==
X-Forwarded-Encrypted: i=1; AJvYcCUExHQ7lX4a6OdkJWTloDk5dHb2SjZy4HxZZNirTzwMKAliX8xrE+h90glNahRPLuTvoe5OuS/XoN3WSbI6DxX1@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Ah43NhlbAptPMmb3KTNGT63rtnO/XSSmJF4ZVKFB05NgT9XF
	2nWgReV+x8safP9/+8sNcAPnMoCkrYMVpodLKzuHHlIwVcTtwFk8qdZwujXlynVLVGHuVkEdlTh
	YaiDop8nNsw==
X-Google-Smtp-Source: AGHT+IELgHMT+riRT6ooQjHoRr7Egdxg8DnVNOmmHcV20ZKxJTX+CwreDH0HXsKO/ZJVtC9CnbSyJrVGPJgH
X-Received: from pjbnc7.prod.google.com ([2002:a17:90b:37c7:b0:31e:d618:a29c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a03:b0:243:b20d:5df8
 with SMTP id adf61e73a8af0-243b20d61bemr6950671637.10.1756436857397; Thu, 28
 Aug 2025 20:07:37 -0700 (PDT)
Date: Thu, 28 Aug 2025 20:07:17 -0700
In-Reply-To: <20250829030727.4159703-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829030727.4159703-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829030727.4159703-4-irogers@google.com>
Subject: [PATCH v5 03/12] perf jevents: Add descriptions to metricgroup abstraction
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
2.51.0.318.gd7df087d1a-goog

