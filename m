Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E2D2FF17F
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 03:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004070; cv=none; b=jUHgqQdUpUmFjGiFt956fXpSolpsHf9FduGsVBfr0OB6efm18nt09pr96uAelCGvHeZA/YhrPwu5TAOqRU5OJ1/mWK/trLhJDsyb+cnxxZBQwiPiD4MnpQqlQ7SfauBUg+w0n55OPJY6PoNhLbuAXt1ueo7ma9u+vhLYx3TbIu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004070; c=relaxed/simple;
	bh=T+Bc4OsVOS3h+Fg86cIAtcZE/zq9BYJ0yLEN5fPA08o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=iRyL5r1KgC2nIRozt0GXOVbgPINEYfurk/Zv3hQwmpClchltmEIceTN5nkwIyNiWSt3IUPZ/WMEZWq1uFPhBvSLWxKazI5rdspjCl/Yy9nIUtD/vsxUcz6GB71Y1OLKc7Sty3m7z9H5cPmFmmcS3yKtPlILuKTI2gnLZGXc6KzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lkAxgWDQ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lkAxgWDQ"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2982b47ce35so3990165ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 19:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004068; x=1763608868; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gBfDq6eqFsQT5D4yMoogLb7F1RwV4rQJFP30ACTlIWs=;
        b=lkAxgWDQ8EhiEbUc6P7gFLt/SEiyjOisnIrt/UQMH8aK74ZJk69/xqgBRCPM72FYhQ
         cw/ZlEgKMWxcOu9gwtvpJT/X+t0DEBwt4uoazZILGK9JrnVLqoTlj/o2IbC5oMwfj4wQ
         1F8xR2UsXQmrIbTIkL4zV0c0RidKuiZk0AM6BejDUkA7cmRUfzzn+fj6TlPTAKcHLsOC
         mZPjB5dQs8bCWdkPNxHGqBBoMDtjTv9q77NKcmNZohiKIweCsRGhsZDplLscElhyomzD
         zwfSN57kZGadxAwtsajNx+1eU5tqsTYHIhkanU9Go6xp/RUoF2sV2ZACIIVAv/KqprEv
         7f4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004068; x=1763608868;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gBfDq6eqFsQT5D4yMoogLb7F1RwV4rQJFP30ACTlIWs=;
        b=Wo92haJCPY8vplxxpU/EQXWGDLTtvzi4UtZbXW8/LnJYnpL2HfRyHikL2U46yKZ4w0
         xB/vnDacQOQJVeCL9xSqPWjVVr3p8AYG0KpORr4yQLJl3d5mpsxVDO4pnxDyX1TTSVIP
         3lqjtdxHVt0FPWbRCw/VrESu9xVsl1T71ItfyCluGTuwwobi9jWdas3zDx9xUC0yzFxM
         TW982x38dstl9o1RYbZn6ceWg+uw3VzvG5lFx6KZ4fk2NF1lxJZrQKAsi3TzJMPi2dDA
         OxthLYlTbQQ6J1wrgdMouDscxjYJMOGpYzd5hNrORg8fLjepS3L5i2MTlnyLdZZyNHXg
         WLrw==
X-Forwarded-Encrypted: i=1; AJvYcCXV9qTklL6o3frGC5/6Be/6Lrxr6T6dPJqC/jHhZAlea9AQhaohUnIDaY5DHFGlfTlVMzrL7rP7HHKTxAGunwkS@vger.kernel.org
X-Gm-Message-State: AOJu0YxKrK5eFqz/RoKGVGy5aQseJoPoO5riuHvc5ckFUCaF9GtDQLrt
	3YYyilNOrLNJ0Id01SPsbMgM7HwAlkq6G3jRxSvvZ0bw7kbV14eCGYMN0syJGCcfPgpKpTXeddn
	Tnv3FMzUOmg==
X-Google-Smtp-Source: AGHT+IGICDwsioyeKBJpVyDXuXAso+fW9k0PVPWo+9oPf8S/CudYtjVap1hns6KrAFAPbrKTqY7lRdaY2/JJ
X-Received: from dycpw12.prod.google.com ([2002:a05:7300:de4c:b0:2a4:61a6:6c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:286:b0:295:fbc7:d282
 with SMTP id d9443c01a7336-2984ed494aamr69919175ad.27.1763004068058; Wed, 12
 Nov 2025 19:21:08 -0800 (PST)
Date: Wed, 12 Nov 2025 19:19:55 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-8-irogers@google.com>
Subject: [PATCH v8 07/52] perf jevents: Support parsing negative exponents
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
2.51.2.1041.gc1ab5b90ca-goog

