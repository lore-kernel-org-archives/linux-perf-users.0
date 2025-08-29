Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9E023D7EC
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Aug 2025 03:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756436865; cv=none; b=UrSiP38lHx/UnpIpusD/pHzJg66Wpqx+aPmlUxqRlSReenzGi3QGc+JUvCIkMIAn5+iGH9VSRLcBkRpzGdDi2wESuH0dYas0BnCzwhSZa+vfCwv2h4JYJ+Jzd1SKMnHtP40MLMPUegfnmV8Iesy7j1Yx2UVtE6BrlfRatmcIvvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756436865; c=relaxed/simple;
	bh=vTlO2/C8HAs4GVTBSdFmOVDic3vZeo0uYSBYeJMOGbc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ovv9dac+2xRrLAkE8btDE33UKbif5w+6CH0fgqr6KwV6ntSwT4nbbAHimDt93ccradRa1AvhUYCMXLxp0u4gOI4jSGgCx8ngAogUiGqMgR4F8etkNnqg+Y4/vk8L7LQ8m/5+dgCGMtdtN2a7jZsp7lJoeNifbZTf6Wvg9LAPBMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IK1Y2BLi; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IK1Y2BLi"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e931cb403daso2059871276.1
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 20:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756436863; x=1757041663; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rdj/Vu7Opnsxqusyddu5GlS1bLdJY2vFgx703YA4bB8=;
        b=IK1Y2BLiX9JB5em6e9SysxSxQZ7zZuOHkaRwIPTH+Y6EzxBxrGD8n5aYqQ8EgoqKtf
         l+IJwR+qhvnnv7mL80I2rb9JB6GXy0RW5v+8DQoDNrjiFNpbmlqsRTfIMaGxsxH/cZfh
         XQbGM1bwE5+/Oz9eUtD3hgF3+RQQr6Qo+tiuKdMX7Et55DURY7WEbh/wxD417DigLYus
         dgQZnGjovaVM8Ml3AEVOJljSsRxxdA3RpQ0Nshu4cHg1HCIQV0NjInT+m08nK7EvQH/o
         Pb5+p5XCX7YSOdfuIkUWn3x6UKIhO6jhT8R0Rlmq8fULS4w9NM89LcIFLe8ovPcAzpQ1
         Fmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756436863; x=1757041663;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rdj/Vu7Opnsxqusyddu5GlS1bLdJY2vFgx703YA4bB8=;
        b=fTlMSAEphRDpC2RsKvQS6XSoRCgmdnDORR2t0JGVjhReTFJn425G+Uk+M+ADBrYqVi
         qVAcLc4XKzFx8wvr3Ey9ZSmOlS3wOoyL8BKsoNjbnXjPCnkGvywkigOnHB0015hE5q7e
         DHPdStFJq+KXhBqYisNkwWRh997jn40xYcPAy7kvzmEFZPKiO7mTTNOUiiOLjLjbrtm7
         p7XLx8EXShtWiHKK5x6r/aCXAuAEd/gRkvD4r6GuA6aMmmn3N2l8YKnJ4xi34f8g0Qyt
         C+TTQ2mD+uWk6jS2rt29kW2MZiN2ktUov9txytkgFOdj9Cz+/28+Eu/+fxhyh/1G5Cbh
         aALw==
X-Forwarded-Encrypted: i=1; AJvYcCXZluaGM81NQ9D+haIie489ZhuM4NsNoNZKNuIPKuyoL2+RaPJmM7TNA8eqaLEPnv3iBlFACE614SpJX94IO94y@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvcqhu9RwMeb7wNBps7L6pEnMRJOym5hCA4NdbdjT0Pd3f8M7W
	IgOFUnKVJa51H530d1sKkI9e9wB/KyWWXpZrSiTpF9PUjH/RPI3vJxwEzacdgeEA7ZkeNdRVC5L
	ZF2NmuYESKQ==
X-Google-Smtp-Source: AGHT+IEXYuffvoKEoilxW0f/OEuGZiRnHOaE1V6OQNTnjuayen0x0X7m7NRfydjSOoHuuU2VH3qfDaINIf0b
X-Received: from ybbfq15.prod.google.com ([2002:a05:6902:2d8f:b0:e96:e420:30df])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6902:630b:b0:e97:9b6a:daaf
 with SMTP id 3f1490d57ef6-e979b6ae17fmr2460307276.21.1756436862973; Thu, 28
 Aug 2025 20:07:42 -0700 (PDT)
Date: Thu, 28 Aug 2025 20:07:20 -0700
In-Reply-To: <20250829030727.4159703-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829030727.4159703-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829030727.4159703-7-irogers@google.com>
Subject: [PATCH v5 06/12] perf jevents: Term list fix in event parsing
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
2.51.0.318.gd7df087d1a-goog

