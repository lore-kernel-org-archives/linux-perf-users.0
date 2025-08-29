Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EE2238145
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Aug 2025 03:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756436863; cv=none; b=LteKnZ7fiOzSiRT9XL881+EhayE60gIiXjihOdNiX4Mn3umJu4XbjKkO/o9HzCVnc5qvuL4mvQ4KYEjFo0LBNsniNiPh+qMptzRfIxzRJq1WyEWUI92Sjb1El3K7Qdlf5E+hrpkRkHxVps/ijVpdVwUom1Pd25vzjeW1bL0rS/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756436863; c=relaxed/simple;
	bh=WEaVVhSK/6Kzfwt0tio2m5fgLf4Kjhprd+htTRjdV5A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=VFRIjub6y5kMJowRYurnF/tAM5WUmlgTPXE8P5Vh8fxRhpKPfMuWk75Hj1SVBRTwdPLe3I9pgqONJ5TYs4d/c/4/BLUS6VsGox0qGQjKsXHSrDV1iiOtdnXVBkMhfChsxEUkFMTkxT9YNuc19bIJX84vkIiZEoF6tlTWLDg39bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2LxhrLpH; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2LxhrLpH"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-248d9301475so20778675ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 20:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756436861; x=1757041661; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OvBU2ACyciLuXu2F8DfOv8SJAwYRyI89UgDkHEBBKZ8=;
        b=2LxhrLpHgalt7Akro+UCkUB1AVxt3d/wAQM2h+2iLti2fLutqnrWM9msrhvyi3POcI
         wmtemXS46JVF440JcQQtKxVReRswNXQwc+R7grMwNrKsLwUJvKY5g11FlVAr9WcGJyXI
         cYjsWjykGi96gjWv1puPCfwP+wE/f6pKcT+1UwXcMPjW00hkZ4Lk1weSpNM/aDQXSJ3/
         l0+UFbBz5vW2OcrexrMowwSesktpqmVnslu7eieutcneYeSIWnRlq3z+r2rfcWEf/Gbp
         1FyZ/aNfnf30XkQZhGbNxp1FV/wxYIFrWH+2aXHLcps2XZ3yGlxa6xMWrDwgGF1HZ+/z
         kczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756436861; x=1757041661;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OvBU2ACyciLuXu2F8DfOv8SJAwYRyI89UgDkHEBBKZ8=;
        b=gV6fPwUB2IyKDGpiJHey82kzurs1cJ3yJrtjnjz+g7nQ/zChtLZISSEZiOULNDwy2v
         9/KgJj8GWQOCyiyrhZBCWLR8n2ylNVuv07EdeChONwi9olCG30idzMiS6HdceolIyN5U
         BPXjobPQkaJazaws4lGuki7awFNX+VXQo15gCg2CYTPbG+wtQMs8I4XU1KxTsE2FiGpQ
         kgu1qI8L3stTJk9AerHKoMjZrdBobBB0yG3W+HQjhzatCNN9rEiwFE522MjJMlgi4fpQ
         zlJfSckIz7ZZF5E0Eh1yVO52OMhNCk1AfqMe9pltbDOYFYS7m4E69/GWcBJaTxO43kqK
         SwNA==
X-Forwarded-Encrypted: i=1; AJvYcCWhzPGTMWA/CjmGRs6xe9r+A/VfEmlXdv/b8Xj/UWMD2mnq2plyrfax/Vdv9bLrvsQFgLROjAioBCyNFEftiCPv@vger.kernel.org
X-Gm-Message-State: AOJu0YzFQzdr7DuVDecfGroAjbF6oDqerd6j3fMFrVHgRrSxfCy29zlj
	vzwVomrEVvuRdjdgAV6BKA984cLQAt6hMArZbrEzeT7aOvHYD7/cT268BVNczOr4q271BnTMEVQ
	wO5nr9kzs8A==
X-Google-Smtp-Source: AGHT+IHba7bj3xJQLnoAbns1ymqnpb7bf2P0DkwLSlskvstOEnoDpXVS8KhuocUtjzKfuHN3Kpixn1JcklXc
X-Received: from plqs24.prod.google.com ([2002:a17:902:a518:b0:248:a265:c642])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1ae6:b0:248:84eb:74ba
 with SMTP id d9443c01a7336-24884eb7babmr151051685ad.50.1756436860874; Thu, 28
 Aug 2025 20:07:40 -0700 (PDT)
Date: Thu, 28 Aug 2025 20:07:19 -0700
In-Reply-To: <20250829030727.4159703-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829030727.4159703-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829030727.4159703-6-irogers@google.com>
Subject: [PATCH v5 05/12] perf jevents: Support parsing negative exponents
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

Support negative exponents when parsing from a json metric string by
making the numbers after the 'e' optional in the 'Event' insertion fix
up.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py      | 2 +-
 tools/perf/pmu-events/metric_test.py | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 847b614d40d5..31eea2f45152 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -573,7 +573,7 @@ def ParsePerfJson(orig: str) -> Expression:
   # a double by the Bison parser
   py = re.sub(r'0Event\(r"[xX]([0-9a-fA-F]*)"\)', r'Event("0x\1")', py)
   # Convert accidentally converted scientific notation constants back
-  py = re.sub(r'([0-9]+)Event\(r"(e[0-9]+)"\)', r'\1\2', py)
+  py = re.sub(r'([0-9]+)Event\(r"(e[0-9]*)"\)', r'\1\2', py)
   # Convert all the known keywords back from events to just the keyword
   keywords = ['if', 'else', 'min', 'max', 'd_ratio', 'source_count', 'has_event', 'strcmp_cpuid_str']
   for kw in keywords:
diff --git a/tools/perf/pmu-events/metric_test.py b/tools/perf/pmu-events/metric_test.py
index ee22ff43ddd7..8acfe4652b55 100755
--- a/tools/perf/pmu-events/metric_test.py
+++ b/tools/perf/pmu-events/metric_test.py
@@ -61,6 +61,10 @@ class TestMetricExpressions(unittest.TestCase):
     after = before
     self.assertEqual(ParsePerfJson(before).ToPerfJson(), after)
 
+    before = r'a + 3e-12 + b'
+    after = before
+    self.assertEqual(ParsePerfJson(before).ToPerfJson(), after)
+
   def test_IfElseTests(self):
     # if-else needs rewriting to Select and back.
     before = r'Event1 if #smt_on else Event2'
-- 
2.51.0.318.gd7df087d1a-goog

