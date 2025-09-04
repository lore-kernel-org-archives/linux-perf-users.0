Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56A223D7E2
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Sep 2025 04:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756960341; cv=none; b=CR72pfL5TRs6ohIlkONgAmAIhTOYV9fdOWF64nhttGsbzuaK4i3JFQU+JnV/V4e+yZ/8YJhmII75hi00XCPAAEDhrAP9CcvLuqM/ASU7gZgrEf+q3RzFFCV01SD5GR6L+uTeh7E9TUa61Aqvrb3xeBDxnCxrRZVzYsQU0uN/KYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756960341; c=relaxed/simple;
	bh=sJpAsx8mv13dx5/WPM3rBOP4a+4Z8onR4PgYsxydnM4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=GmlgcMBJ9VJ6mhR+VoxRo4RU0CT1gQnUdMhQ//RfLdyK3dXLuMBiBs1PONVzfkxQKN+LTPxLSHNNyh4sEmOA7savyYzH2yTYImj9b1OFr0Vioerp+fP4waUNuvDaTPnFZh9u0gZedIQHIXZU9wnbQMi8hlzkIrnebDk7dw0Yc4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XVZbuCnb; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XVZbuCnb"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24cba71c71fso4874495ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Sep 2025 21:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756960339; x=1757565139; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i4KblLTIcCyuYf67LpT+wj9Bc/JO2zogWh7Nn9T00cU=;
        b=XVZbuCnbFirnqmbTJpolKXBKNAKWTAgMvKf52GV9KHElorgKJV6TrMfJ+dkyHkmgIT
         Hxekgt35aVX39UtcpP3ETsmMsuC+6b648RFpOmQ6qMy1wLYhdgFEgB1mB8zocupdyTmR
         w0qMr5gVrFzzHEoaVzvJREek8mW0ddoQ3WVOtQiKxD88je9ckgIEFd8A/HrSmIRNiaaz
         HIA9auLKmEpu47G7PEbC43eOy08/9i55FBTzgd/EzhmcEB1KxkznmkRV3Hi53aqtEY85
         hZZRDhW7VM4fNrxYKVXFAeyLCx+e3358UR/bSdwOnSGdASONiGiU8v6Ed7j38Jd39Sc4
         BGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756960339; x=1757565139;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i4KblLTIcCyuYf67LpT+wj9Bc/JO2zogWh7Nn9T00cU=;
        b=llGMQQdiOw0usTE0zhsikgpZW+UK+pv1SM/+6+07YJyBR14zSIC9gAtZIrGHh+0uAj
         QMP5omkuOHn5Vsg/6RUdqvUHIHRP+o6isiXczqlUxvPNWGsVT0kp22daHvG5V3alEpYV
         pt3QRJR0DUzXGtr1FKX1QNY9NKccKlmiV2kjZlz+kyPSJQfG7P+aY9R2bTHJPEW5svPB
         D1joq87vi0+NCnBOR6BBnw6x0stHBGcTw5wkn3uI6aK+9T4drgpeoQpPGsvSHaPwiWvZ
         SsaFvGUGd3WVqsjmycopxt2F5C53SYwKs2x84YXa15sd5Ke6/LT3z6MlICBf4lnZmzEh
         6jYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWq5UgoGqaRwKDn+E46y3N6pAx6FM+zynVi/A7O51V/T6YYfHf1cs4bmzqxAuAfJhPww4E1fbSeg8ZySRl1IspW@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7M2Od/xYF94oDqX/sJsCOYwGA1gxAmzPR0+s2LdzhDuWbyy3H
	QDd44RD/BH6xeTbOocjkT6Hd/0iPGgHaYfJOh2txqvJrGOhQaE3Z637SRPBZ0VEFCZoaKX9hfJH
	xc/AS2kBvpQ==
X-Google-Smtp-Source: AGHT+IGxW7TBij4TdZWKoXUnYmxnIDkSyPeGRhAu0ENkJ9eeD7HNZ2OHN/FfNe5z9vzdeahi2zHg8J7OT5Dm
X-Received: from plnr5.prod.google.com ([2002:a17:903:1905:b0:24a:a3ce:a5d3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cf09:b0:248:df64:ec6a
 with SMTP id d9443c01a7336-24944a27103mr206219885ad.15.1756960339205; Wed, 03
 Sep 2025 21:32:19 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:31:59 -0700
In-Reply-To: <20250904043208.995243-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904043208.995243-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904043208.995243-5-irogers@google.com>
Subject: [PATCH v6 04/12] perf jevents: Allow metric groups not to be named
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

It can be convenient to have unnamed metric groups for the sake of
organizing other metrics and metric groups. An unspecified name
shouldn't contribute to the MetricGroup json value, so don't record
it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 1de4fb72c75e..847b614d40d5 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -455,7 +455,8 @@ class Metric:
 
   def AddToMetricGroup(self, group):
     """Callback used when being added to a MetricGroup."""
-    self.groups.add(group.name)
+    if group.name:
+      self.groups.add(group.name)
 
   def Flatten(self) -> Set['Metric']:
     """Return a leaf metric."""
-- 
2.51.0.338.gd7d06c2dae-goog

