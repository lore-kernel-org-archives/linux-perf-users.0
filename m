Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB142301477
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 03:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004072; cv=none; b=Nuhq5QtZeqCoKCgCjOb6Lv+WywKY4eT0d++o+q4+0lx39x2TXAXW+ZQB0+YgfCvXFtTED2ZfmFXHYI8vajBZjo/rKA00HDjq1ZridOHJkweFfCFu5DizmZl7JhzFS56rW6ld87w/btMMV8lk/ztElVabi2Q3FBzqhIMs8D5xrrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004072; c=relaxed/simple;
	bh=IuI0DBDwoxo5ySbCWplL1dPTgS4OKxYpJaT94wcANoU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=WnFvUsYEx3owLNSoqJd2QvceDFVmMticzr17QqA93eGxz7Psu12Y6KpAIuCtUD97UxNMaESSYdIc86ZpnJSANdOHq2jqiy2uRym401QEn+WR4FbtQ4L/YGi2J4PvTbKFbQKGHNDMNQ4hwsH5S3r41dg6kyCNp9Jcng9DYyxWtwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gP3D0K1R; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gP3D0K1R"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b99f6516262so917190a12.3
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 19:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004070; x=1763608870; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y5goI1b2CVDlVAFfDby5CniqVJA/yvNmGYJuLu24zbE=;
        b=gP3D0K1RB4oLkf6kuiuf4y8xwhOmiLAVDNQ5+tmUcL2g/Va+FmRbQmnXp/IwIPGxtd
         ZOKvvpHYPs2ePhFUXSSQRL7kBt0fGUSrF7Vm6wSuB7BCGL46elxlUIIq7D6gNIiqrY9r
         gIP+7XwREV+al+8TIXPyLNyvS2iqZObOt6dyen/jxwnBc9Nc6rcN7A7fIYVwGyJf9ZO2
         klsaziWYbJQJk1lAiUK6ZUDVQaZJ0Nlonw66q9EEmFpcGh6SHDqYxKBBxwouCfUczNhu
         EeKDKPl2tiOtIASjtm5hIgoe6l01LhuGoxfL5UyJi5qPeJsIlZkwrmmw69UvFDntbvOk
         BcIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004070; x=1763608870;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y5goI1b2CVDlVAFfDby5CniqVJA/yvNmGYJuLu24zbE=;
        b=qu86TMGyLCFcZzVDk2D/tgu0Vaq1++Rjy7iB/0bJ4VJwJuIsJq9MXoWItcY7dy+X2Y
         JU2kp37PZR3WgG7CRbSYqQGdrdq2BKGIS8o93B16xLXzdzfn3DKpRvgtgzeuEBs3wxX1
         /m9xhRlp/5NErzPVd91A4EoXT0hxmbMRLmOTHyO5RUuaTcZIyujGi/CRNMnaZ/2zprln
         OVYjsA6q3WzHOxvs44ZiTn2vFPi5sN+OpDFwe7JJgRW9FpiR4MP7Rp1nfz/B2YCV6kVY
         vOeqOzNwK7vPzozsXa8xf7ZLOLONUdtHf6UAEQawN2F82HnMRS5z4juub70hQarkQRN3
         cuTA==
X-Forwarded-Encrypted: i=1; AJvYcCU7TZDM2RyT6+iJo4sq13vFBKsB9mVmJ0ARE7/H9TmLYXE5M7goqLZcEMQfPlaqvM5Gf3+bISWI2JHu+s6iQjg3@vger.kernel.org
X-Gm-Message-State: AOJu0YxXiiQkiP7uqT9ez29ci+tSYYg/7WRKA7uE1c1lDr/7ZMkfkhha
	jxHcbuYjsCd6YWysg8NVEC+IG4+sPNAcZY0DLHGC+t5vUB+5pLuXuDc5tyosrWyMkkHgkaDFBbP
	zI3rpUJSt2g==
X-Google-Smtp-Source: AGHT+IFzScfXqjEwErWjXv1s4AzfZSABbYxXa0s96vKLlASb+dEtIhbvJSQOMZbQgHT6eoxz6akNYvCtVbyU
X-Received: from dycnb15.prod.google.com ([2002:a05:7301:b0f:b0:2a4:4f7b:275d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fc84:b0:297:dfc8:8fd
 with SMTP id d9443c01a7336-2984edefeeamr69482385ad.51.1763004069976; Wed, 12
 Nov 2025 19:21:09 -0800 (PST)
Date: Wed, 12 Nov 2025 19:19:56 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-9-irogers@google.com>
Subject: [PATCH v8 08/52] perf jevents: Term list fix in event parsing
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
2.51.2.1041.gc1ab5b90ca-goog

