Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F73A13FFA
	for <linux-perf-users@vger.kernel.org>; Sat,  2 Mar 2024 01:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709341216; cv=none; b=iJ9YJHqTiGDX2TYMpOlk2ZHSdRYBgb3bGHB0XNVj4VOO5nGYCbLfpaR80UX7/whR1jpbtER5TsfFBntKnHWp42A77f5acc7+Js3V1Qkj9hKzSl6mgxhIA2dBNoTQH7EEoQZouiRzhvjLmjo1mRH4nS5FH/vTzz8jjikfSV5eaZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709341216; c=relaxed/simple;
	bh=ZXVWxGkn7pnCvmd8l6DV72SPICzKi/Gva//TpBe7PFE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=heKl2RWsRAptuJ2C0ULAM7AxVglnxjad6FdjbaDlbEh7Xkzl35LUcN5BLTjHpraXl9dIvNqXeiPiFwjv5H1U6DTQO5YDsK1IB/kpAgaF/ohC5eTJ3AmZ2Qq5EX1y03z+U12COaTVOnvtD65J3VIEJDC/FFFPyNwPADQrQwZly9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qI0xfJRj; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qI0xfJRj"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc64f63d768so4911678276.2
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Mar 2024 17:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709341214; x=1709946014; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/C1Fptl7F9oJgqV/SnZtPnw4T5ATAHSmXZQvuFpHbZA=;
        b=qI0xfJRjpEdE3s+OWFK/wud9k0lVmfMm3Y19P85FmaYk2SVEokv8w2UtiFTB0o479D
         gyRES8/ofoCKLPMJkk6sR9qQConnJNRRkLTOBs59Y2MsUQ1StCcM5RpJKkl7S70jyPro
         DcZUhNWiMF47sQDGMFeXWnTHSesrnIKonsJecsfa97D84lPCmZJgs5X0jVLAv33koySJ
         jUg087JU2ftUyI3R4y2lRfeHJkULZARZvFz3Zaa6wiPv8ppAceeQBSmhPAx8hb2Z6Zej
         ZXC8ikBoy+eks3S/cM5fxOmp78Deo0ZMPReQFXWQmeOIECpoOmH8jsEf6VUX0EAgIln7
         DS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709341214; x=1709946014;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/C1Fptl7F9oJgqV/SnZtPnw4T5ATAHSmXZQvuFpHbZA=;
        b=B9YP0gikAd4JpXBAUDVBRv/Hi6ZvMWPIvbMJ0Zn866MvuUXlTZUsFGGGhhF/2Cv2rv
         VgE34EIneh6wKBhOiHZM6JKsBmx9QbEVaPYH8RES5lU6AsoiThApg9ypbIQ/JlJfYZiH
         b87wbgcfnHgJaOkg5VJpqGGuCntejwYv6mm4X5meSoCLkXFQHiAQj5WvD2nI7aeMfQW1
         E4Uv7qdYS4J7Lf02Xi3xeAuWufViNn0ocaYVuSEAZGKgSbxxJ65EdIVZYqdJVC5C3w4Z
         qNMVnqbqb2paWTXfTJyoPSM77hezRq/otqCZcookvwjGlYfYGR4te/9wVBHFLFXWPp3S
         VfSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJCl5UrrdP1WagpNyzjhxc4u5Web27kA+36z00bDXdQLZMdTUR3tpN3smdvMqozpf0EHplxyF8XgOtY4uZ9UMYknVshO4eSDSeIB+kiqTYtg==
X-Gm-Message-State: AOJu0Yyaed8nj616kCdKvwFHUQCTFA6Q9w9F+C2RVKJAtugPPDq9GMMf
	9XONTfSXC6Hu4ZUtC5McOwfWPsYfhcff9INV1oWg/d/9pXaGcHGhC5F4upPO0FhH+F1E7S5U0mV
	Se910fA==
X-Google-Smtp-Source: AGHT+IEcLROtrXlhR1p1wHqfQliwAasWDluSReL729q0MZhBdDo3jfqmp3mw4G6E+PWld0UnHXf6WNfZUUQr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:aba7:66c5:3365:7114])
 (user=irogers job=sendgmr) by 2002:a05:6902:210b:b0:dcc:50ca:e153 with SMTP
 id dk11-20020a056902210b00b00dcc50cae153mr766214ybb.7.1709341214783; Fri, 01
 Mar 2024 17:00:14 -0800 (PST)
Date: Fri,  1 Mar 2024 16:59:45 -0800
In-Reply-To: <20240302005950.2847058-1-irogers@google.com>
Message-Id: <20240302005950.2847058-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240302005950.2847058-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 07/12] perf jevents: Add threshold expressions to Metric
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

Allow threshold expressions for metrics to be generated.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 0f4e67e5cfea..e81fed2e29b5 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -430,13 +430,15 @@ class Metric:
   expr: Expression
   scale_unit: str
   constraint: MetricConstraint
+  threshold: Optional[Expression]
 
   def __init__(self,
                name: str,
                description: str,
                expr: Expression,
                scale_unit: str,
-               constraint: MetricConstraint = MetricConstraint.GROUPED_EVENTS):
+               constraint: MetricConstraint = MetricConstraint.GROUPED_EVENTS,
+               threshold: Optional[Expression] = None):
     self.name = name
     self.description = description
     self.expr = expr.Simplify()
@@ -447,6 +449,7 @@ class Metric:
     else:
       self.scale_unit = f'1{scale_unit}'
     self.constraint = constraint
+    self.threshold = threshold
     self.groups = set()
 
   def __lt__(self, other):
@@ -473,6 +476,8 @@ class Metric:
     }
     if self.constraint != MetricConstraint.GROUPED_EVENTS:
       result['MetricConstraint'] = self.constraint.name
+    if self.threshold:
+      result['MetricThreshold'] = self.threshold.ToPerfJson()
 
     return result
 
-- 
2.44.0.278.ge034bb2e1d-goog

