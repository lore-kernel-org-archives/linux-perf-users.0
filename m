Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3209F40851
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 17:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709143012; cv=none; b=BJeA3luvXlmg6O4sjxIX3UJWpXYKXVsAU4YBG524pYQByedBnpkw6dFvkGH1kpbNWlW8ICABnad9lg0/e7/YVcJpxY26iWXv+LCHkJpsfHMuCcXdjgdD5N88gP+Ok7f3x42M2QAMSPrIZJ1cSedWDEEhTjMCBLkjJZtWONcAMms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709143012; c=relaxed/simple;
	bh=oswX3i20yiaJHjTAeWqAXOG6a2/1Ta4qOMh9xoJeXu4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=l3S1gwTAYX9nYE0DI+n96pctmK4zvNyM4LLtDA5MQe27ZA/dyanSUddBAG/54+AVt9cLHOp3uIDvUZf/mOEjcxB0TlisGCAvgamRBhbK1Pq4OtpPXwZ1VB+GiS2xZ7HrA/YL74eXnne6V+o+RGnN1lxzQym2i0FRRchGRNdVxk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mo4dovHL; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mo4dovHL"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6093c69afafso166667b3.2
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 09:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709143010; x=1709747810; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F9W2L65moWfkRODZWtj1+8FpZZOCQB/UnzNIcvAZEKE=;
        b=Mo4dovHLzLPnNjH5JMPjEhGZR2zlA3+5r75EZpz4t4Vz54EwPUE7nHqecGOVdZrHMy
         jsnPCkzD35HgpUs5OVi+8N9OJppcfWB/2TrzGyXyCeeIs+3Z5hE67jzTNNX53ikv0BeB
         y1Ldh8/jm3PEveljvHE2fTKHKwWAVZEmKXozYT2Gs2Ip/GVcE44TmQG+6gS9MhukWRjv
         6QCCuzM1YG4sVW4IsUsROjcUjGbILb6KUTuJSQ+K4VfX0ldXRjc4e0m8PCcGgbd/aX1M
         bsBXQZbNt2UKkYsVoXdMMZjj5N5TSX41EnCEyfotKb+6kQ1ya7JHnrMJlo2yGpBX2XkZ
         pz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709143010; x=1709747810;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F9W2L65moWfkRODZWtj1+8FpZZOCQB/UnzNIcvAZEKE=;
        b=vMni8EMObkASv+daN31elis7EUiuOacoAJ/dn9Naby65cQZT51HKp634XRRnIbmBmA
         MSbRURFIdL7UH3mEzxEvHBUdjvUDPJ+ryViYeUSc+hmLz/FfV8knGjjPvDeffAL15lXa
         F+SYNYjTk+eu7r8uFptNv/5qmwiizsC69iLoS7FOcY5N6gxqWYGtgBFAekZg+/KFHj2I
         /l6IX4A6/PebJEvNUuqKoiV/3YBPPiGBhsjJNC46JnHX39vr/X4JfbOLhOEkaRShqWkS
         uFQ5FmOSMDxN2zX888XS87sL7wpxLMRbrRJ/hgcuXT4fXidivAfQ7AT5Eb06Hh6yPq2U
         nfkw==
X-Forwarded-Encrypted: i=1; AJvYcCU+y21j6r3OMO/4IY8NQRrwSoGfW+7CDjoscESay7Mg7dV98FArtTIavg/XI5Tn4Cua+2Scz2pkndUTux4gZN9Yi3rU+UMmantArfzcfVgAzQ==
X-Gm-Message-State: AOJu0YyY8Bi7vxCEBYqe9VgHm4OgdWHRzlmnHBrHiQhP9FvWTLVgj/nA
	A/KiOzEeG8K6ST59qoE347WQdwh4p3Me0FnHd+KkFq1sEnJcQRghFQzqM42jFnH/AzeJCA2o/iH
	CqGPSyw==
X-Google-Smtp-Source: AGHT+IFK7ed1s37v8d9+WzWQvasaNbBnItoNK8ZzS86+qfX0MjynhAXyDQcXB0qSLmTwvkMIIX0ZKAhS4rls
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a81:7985:0:b0:609:4293:23eb with SMTP id
 u127-20020a817985000000b00609429323ebmr338609ywc.10.1709143010454; Wed, 28
 Feb 2024 09:56:50 -0800 (PST)
Date: Wed, 28 Feb 2024 09:56:11 -0800
In-Reply-To: <20240228175617.4049201-1-irogers@google.com>
Message-Id: <20240228175617.4049201-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228175617.4049201-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 06/12] perf jevents: Term list fix in event parsing
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

Fix events seemingly broken apart at a comma.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 31eea2f45152..0f4e67e5cfea 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -568,6 +568,12 @@ def ParsePerfJson(orig: str) -> Expression:
               r'Event(r"\1")', py)
   # If it started with a # it should have been a literal, rather than an event name
   py = re.sub(r'#Event\(r"([^"]*)"\)', r'Literal("#\1")', py)
+  # Fix events wrongly broken at a ','
+  while True:
+    prev_py = py
+    py = re.sub(r'Event\(r"([^"]*)"\),Event\(r"([^"]*)"\)', r'Event(r"\1,\2")', py)
+    if py == prev_py:
+      break
   # Convert accidentally converted hex constants ("0Event(r"xDEADBEEF)"") back to a constant,
   # but keep it wrapped in Event(), otherwise Python drops the 0x prefix and it gets interpreted as
   # a double by the Bison parser
@@ -586,7 +592,6 @@ def ParsePerfJson(orig: str) -> Expression:
   parsed = ast.fix_missing_locations(parsed)
   return _Constify(eval(compile(parsed, orig, 'eval')))
 
-
 def RewriteMetricsInTermsOfOthers(metrics: List[Tuple[str, str, Expression]]
                                   )-> Dict[Tuple[str, str], Expression]:
   """Shorten metrics by rewriting in terms of others.
-- 
2.44.0.278.ge034bb2e1d-goog

