Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8721649CC
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 17:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709143010; cv=none; b=AUKLnKr509JE9y0KlQ6IOX1kRu3x+woMjuqd+RsHyEjWpdW2+CVyoGxMbXLgT5q8CBDULphPLifP3DzjyzuntUdwjt8X1QETramFZnFBU77A/eXMjuN1FbnPKJmMEOjbDWTSub8ghfM6G2plYZSxd6X9MnhebysHjutdk298n0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709143010; c=relaxed/simple;
	bh=j1Uteud1mWr9qwRDjsafkmahAN/I9mDRvh5Ckh8gIQo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=GOz5lb7tpic774pLlG4r8egCcM6rkBTBpGIGs9C1iPt477mJXEpjmiN3I8sdOXkBe8+35GSGw5p0VrMQ9bphYV8PS9MAogrCZjfVEq9HVuzicOI329qpUwt4x3/Fd1l61E/x0qBRULAp199+HoU54E6UVAFPuE4EfsNop1tFWhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3k6CA1bp; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3k6CA1bp"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcd1779adbeso82095276.3
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 09:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709143008; x=1709747808; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bBWDWJvSshoSjEVW3Suakt0O9q+vGDdTpywx5NXn+PM=;
        b=3k6CA1bpfOmxIZqZ6XVv7CzRmNKcgV9+xxZd4QbyRuFL9qbfZA7fBUXbWRxg58O75y
         Y0zcONqYc1lMfvmjKr0M838/ae0DDkiJXZ0VpJcYnikcsxGsvXymJz4xk+3c5+BVYwHf
         Hy/Y+PufKcI6gpn8jER++lq/YzUFT+XPz1eeDIrCTr2oKPCd/tnDhVFXQRYkyJLlPI7s
         yAJcfjOwQY2qFKtNrzQS69UOHLLmxKAgT/jGjGBkGsRhXVmfTn2Y3wmw0CaB2QRqkU/C
         JmFJ0FK2BGk93+m5PZqQ6bI634ToCmTVZgr/HmSfFwqFSJitJeU3zcf7DqMTt/ZM1KM+
         Tacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709143008; x=1709747808;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bBWDWJvSshoSjEVW3Suakt0O9q+vGDdTpywx5NXn+PM=;
        b=gHR4LIzhKoDMYtZK1QRYTf/KD94KBWcfGZd/pS9lysk89RYT9BQxg5C+r0WMo2XMkF
         OQumGK8w846ziUZC81fynQVBjxx3uo6Tlp1Sl2+7SH7OwbCUOW1QlBj/V7+xrg6Gmg28
         ou6/mWjLnUIOtmlRhbNhPhpVA41ZnQfDlTxmrx+6YBILXPDjD6Xsgv6VEa4y10p8XBQZ
         3DivOrCfsPBGLzUb5WUlUhFKZcEbv+HjUSaqyVsa8wiTMvXx5ICaIxGY5albLqTwuidX
         xU8nwIQjxG8qc5KAZhzWJaqfijUsnPJf05z4MmGKjZ1TGOSE6cuu43DPEpGcwjgBjNtJ
         PlhA==
X-Forwarded-Encrypted: i=1; AJvYcCVX4nmlWClqReRu3YECi7wMx5rD4d2ow/cij08ys/tD6/9g5UXKHYi4G1ZwB84J3F21lycaP2Aoh0rPX+yAsDa2xOa4A/DzNUjbSpj72xS0iQ==
X-Gm-Message-State: AOJu0Yw5eYffZWuFeqaFTQLdRN6igV1t0YLUn0JQtnru3XIyTK7aPgGd
	THmtGwSt+QEjjeltSs7t8qEnqTvNYVMbvVnVP3n23fkIT6/R6oZR4niD85ABCOHnBSH+qbyxfpg
	DsJ0zsQ==
X-Google-Smtp-Source: AGHT+IEf5pbaOTj+BAf1Szc3Oud3EmH2Oy7RUtwaeh5m1O0lJB/DpXaEfNw54//biDSGEwGhu6rWyJH8EWlx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:1142:b0:dc7:9218:df47 with SMTP
 id p2-20020a056902114200b00dc79218df47mr2908ybu.5.1709143007864; Wed, 28 Feb
 2024 09:56:47 -0800 (PST)
Date: Wed, 28 Feb 2024 09:56:10 -0800
In-Reply-To: <20240228175617.4049201-1-irogers@google.com>
Message-Id: <20240228175617.4049201-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228175617.4049201-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 05/12] perf jevents: Support parsing negative exponents
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

