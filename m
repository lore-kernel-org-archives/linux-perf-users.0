Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C36125C9
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Mar 2024 05:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395491; cv=none; b=WsOsuOy2qyLeXfHvB5V56Pm7/nRLsiLIJx6dAFpEk2ubtaJOUziOy2E7dd5uWMVMibMjKKAX/vyyufBSnbLCmVYf/gXM/E+Cu95bxer4nETRuvcwuiaLy28JoDzIrcR9K78Ei5LExdhv0EwiOkuKcpZCGqyjDiWYv3+FBhVWdKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395491; c=relaxed/simple;
	bh=j1Uteud1mWr9qwRDjsafkmahAN/I9mDRvh5Ckh8gIQo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=rXWgk632JR0J3mLN6SnzB4vG0bRBXeWS8+kxbI3bhHnYcbDBb7Y7fbzb/11wfvSjIwWoKPQ1uhYyIAvaMnKbgI0a4VzTW0cfMdROgOAL3Y8Pe2BfSNelIRWNaKe1IJFSghRW99zq4Z2yazSp3/E43uRdNVRhySQSndB6dyyoD1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ixsn8cOj; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ixsn8cOj"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc4563611cso745501276.3
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Mar 2024 22:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395488; x=1711000288; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bBWDWJvSshoSjEVW3Suakt0O9q+vGDdTpywx5NXn+PM=;
        b=Ixsn8cOjAx0Rphql+mkLr1x8nVu2ueFwRt+a3RdTaOW2qUU/TJ+BbOkkTsy+4EQSFQ
         BtdlFAYWBeyyeFV9JQbRqZ3CEsrs8PYqLvP124lAVVSWGC7yoqjFhff4fC1FkaYj+Sfq
         BztnyPoC8qS1mgcSoWLMZxoFr4OPmqa2X9hRPrxg0YXseeTtUw1wU9R2WaXRYWt+SpRO
         hj37wu4yLs2rufBQcmD4nH989PKU2bx1Q05Q8HPcZGAcTLgIqLu5IUFW9aMEv/uGKaaa
         Eeu3oWPXHkjZb/cUybS2wfHZ0X/FdKaoJuk4mOVj80o98twVMT1EWPIVzZXY50dRFPOQ
         zCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395488; x=1711000288;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bBWDWJvSshoSjEVW3Suakt0O9q+vGDdTpywx5NXn+PM=;
        b=ADD/TemwoQ8braRo0MQzv6u3z6bEN7nBlhZx+K57sUEPjjVsPu3rG19pxuC0HMBHv0
         WdSxZC+ZwqWKdGjFVoLoofdj83ddm1x0rcBSr7Kb3ctY+lVHC6SUyWeCFd2u2vbgxY+G
         A9osewcseB0WJaU/N+CZuThs3u8VacPVXNtiAlWpKcBSCToM1c4y8smPfAn1r0fANeUS
         AQpdmjuc0ks6Ar25PyTufrDWXDANkc6DXlafzUhYRHLpjwgjW37PYdvKDrwOY4g4Q1AZ
         ILLxq4eAwProl72iF1XVKKT/Fp2SPRU82gk1ffkuoOS8T3kux3EcXaxW6T9F6KfiZK24
         Eb1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVXSpZUGES070lnuLImmMtpJGX26jokYdVkXsUxTsm/rQzgH65nQ68L+NwjpBi93C13kaujmB4761Qvo9d3QR8YBDJ7Q+fE7Wg/UXyP8WmT8g==
X-Gm-Message-State: AOJu0YwUV0yPaqmKo4gZddmK3PQDB6aQSPpZDEuJpzS/iNlCEBB83Itt
	51XnlcHchjU0NDWbQ/ZwkoeFn293HAGwDwU82Q2WmsGvd7RDlVX14PtkcKYAs2euAedVrXiABke
	wfz3fCw==
X-Google-Smtp-Source: AGHT+IFa7AP3IAGDDTK1TeUY6o785EBxZQfo4Yqw/fB+vYDzS43SHEh9iogU9Y+RZYdamDFOvOpYMXb0Ud1v
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:e09:b0:dcb:abcc:62be with SMTP id
 df9-20020a0569020e0900b00dcbabcc62bemr260520ybb.6.1710395488045; Wed, 13 Mar
 2024 22:51:28 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:50:44 -0700
In-Reply-To: <20240314055051.1960527-1-irogers@google.com>
Message-Id: <20240314055051.1960527-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055051.1960527-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 05/12] perf jevents: Support parsing negative exponents
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

