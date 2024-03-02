Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E12510A1A
	for <linux-perf-users@vger.kernel.org>; Sat,  2 Mar 2024 01:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709341212; cv=none; b=hGDypSnWNRlwFxPPBTgSOAI5G7d/B6UlR6c/ZfiVQ1lCPsvPzrMEctlFQO7TVEtMovQ+K5Yw1SfF2Z7ChQ7euO8vZ/JsyRf2UZcSmKzzGGBuYWDqY5YNjuD3yaTu9cNUCIXjUUSDEHbp6HBYbbO16T3IMHf1a+K7VC+cr6jmUUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709341212; c=relaxed/simple;
	bh=j1Uteud1mWr9qwRDjsafkmahAN/I9mDRvh5Ckh8gIQo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=QJ5xowguVym3KsardYe4oLkYkHxo5jPnouqQRFcQlhft94rsIFLjcpfeV3yoNWk6Nr/PKmVjIMdgHUltDlFktvfGBzPAi7t92Dw/fmVFCCHSKbbGxKlz27IMUKGo3WRHjLQxX+zRoJujD9ujHu6lqyBMD2zTDCCHNp2Wcg6tFRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sao89wZT; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sao89wZT"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dce775fa8adso4859654276.1
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Mar 2024 17:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709341210; x=1709946010; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bBWDWJvSshoSjEVW3Suakt0O9q+vGDdTpywx5NXn+PM=;
        b=sao89wZTY/KDVvh69F/w/NIM2DGgIH5hpEanldAlBkfnbUUwcaODWWGmvCAK+oe9oq
         tqu5ByTR/EGnpwH90MmYHFLKQpYDRwhLDIzOUJXHBQ/4NeCdmO6+9WzhmXY7yHKU0Sh9
         o0Qoh7Q7BL+UjYc4+8SNjBRJuagJ+Fk8GEtQk0uokganZTvatbrrwFvP5F+JbIfKkhl3
         EI5rPaxnpG7zvW7XfCVu8sLfe0hLjhKVcLU6ps7/W9cdqpeFZLHgR0pkTK/iWYGd2/Lx
         jobjo9K47qaeD8sVmhHBr7/AwailPdR3pwWA3iavnk8xk0ByoBaD/8IZel0It8809U4+
         QJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709341210; x=1709946010;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bBWDWJvSshoSjEVW3Suakt0O9q+vGDdTpywx5NXn+PM=;
        b=LqCLKwCwYdyjBDEyer2cr1I2ieiC3sfDSLioWXPpoJzNXFnaSqdHXFoebvktRp82uQ
         kx+JMNXU4XlgPilGqv5LVBAfVaAv6bDDWE22eYX5jfNMDmxwA2S3tVYdJ3eMqckJaDKY
         VGindOLt+z9F+Sem6OCk6TBMckeAmu2881q4HKtyIGPe/YaS6Kh8hFm71VjNJCa9tMuo
         Xrc0q/gF6C+wtjzTvyRZzDbxRWdDbUOeJef539eJfvbVXdthNL9mSLiGwLJSxUNGz00o
         434iXBTeHWKaTNr4w1oI/atSu3Z+ScaIksFXhMpfIvvPvE66UAgVoutZ7hty/rOSPJlI
         BE2g==
X-Forwarded-Encrypted: i=1; AJvYcCWH2zBwgSq3rYN7N2acHCipUjyPbnswaXbdZWPIaSaIVg/q310dboLnSTfIkUVgN8d2O1bk1Rlmy0ef3FQsg8JyBzU3HkhQa30AHJ/qGz1iVA==
X-Gm-Message-State: AOJu0YySqYKIrHScu24GNPeBFKP+4bLpfdoudE7t1onKDZtlKqM1hUbe
	iGUjIYBFJLDCuLHmOfs4lQg11z/IwYK8HR47/h/n5YYBzQVi/fU20bJWyREFSQyC5Jmg7asECVS
	R9EF0/A==
X-Google-Smtp-Source: AGHT+IGo9ikATikHZ84fMbX5tniwY5SQp1oK/Dis/YYeok7/lK6jKFF77bld3uJMRdNW83gei2dwCmWVYsID
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:aba7:66c5:3365:7114])
 (user=irogers job=sendgmr) by 2002:a25:dbc9:0:b0:dc6:dfc6:4207 with SMTP id
 g192-20020a25dbc9000000b00dc6dfc64207mr714766ybf.10.1709341209852; Fri, 01
 Mar 2024 17:00:09 -0800 (PST)
Date: Fri,  1 Mar 2024 16:59:43 -0800
In-Reply-To: <20240302005950.2847058-1-irogers@google.com>
Message-Id: <20240302005950.2847058-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240302005950.2847058-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 05/12] perf jevents: Support parsing negative exponents
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
2.44.0.278.ge034bb2e1d-goog

