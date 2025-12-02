Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728A02D0637
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 17:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764697888; cv=none; b=Qcz5LyJmNXsVin8eXHX/T01/lzP72ymsUSxAiiF/RMPh8lOinbiQ4rnIWUCC8vanc6LeLCEBr8ii0Yhv6pVE6qbyJSOVlxuOyyJ82PwkztZhuFCHmArXb9OXSs8NCYxz9KKX1yMmwfJvTd64soVo4hTnOQYwqeNYjgHH7UxnHzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764697888; c=relaxed/simple;
	bh=jd+f/2HDR7Yv2ofQrQteGkOCEZEv0T7jdJ3f6k+9zHE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=SJQWssoA/5X7SkboeNwHBtQQWV+UxbpLnk3vYAUuNbLIx4qNEHQDdb/bRR3y5bUd5xMVjyqtuBNVMwcewAOSMrFfPQ55wNrnpCbxnGT7MGHnxmaE3WvM6ZyrCfR06vzDKAN4KP2Fz8F+nqa+HI0KEC6/EO8dTNP6KS6dVX2Gpio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j0AxZygn; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j0AxZygn"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-bddf9ce4935so4543857a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 09:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764697887; x=1765302687; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EbMmwWSw3365Ms5mX/vunge3ckeTzfHYCxhgJpyRXsk=;
        b=j0AxZygnZLthDhYO/ibHXcPruO8jG7gg+XDla5P/Hyw5uhpP1HV/zjMK208tXunoXp
         jHmkkYuzMTtu6DYEINZ9WdTq/zN23bAdNDQT4b6eq3jutpVir4FtGgnA0hdFWGKl3wtj
         7/htWlN7XIHlCMEcCOLsCq+0RWapQrjVG/7fIwWwWZhfEGZRnwXMTXRUg0mlxW0TdGK6
         AZJopDLRHZ6N6rCdN3psv3nJqnMOefrErvoDn0oonBJznC4tX0RZkOQv89GWcOqODypI
         QtKe2HO46sTyzf2waQ0YBPQsUekWExq+pNjq46+IMdrwn/xETH/4YEx3AsNDFx7lDUa6
         lLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764697887; x=1765302687;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EbMmwWSw3365Ms5mX/vunge3ckeTzfHYCxhgJpyRXsk=;
        b=IFkiIrwc546m4w1Jn0Jq0WdqQ9bStAEu9iyIgftxp+X9IRPUKRURja6fiSqv9Fbx7y
         1cZoxkrnBc7QvNzmbPDIaIzplC1v4KPTWlXK5wBHY0b9cts/X+8V/4rzg9dTQH7qB/YV
         okqQSZKvMAzHVbsVBt/nI8iniL+hrwsx87aMQ4T6azKygwOjydhqTo4lzc3KECXOu4do
         wm07GfwxVZFFSBtG2wZsXbedgBPRJtVes/own2CJyREipdT+BoXG6mMuT/Jbtyv9eeVY
         D3iG2OSh3bV+13JfYFLj5zOckgWkauAWc7aY9ptnloNhl5MTythFCCbgyTlulnr+1bv+
         luRw==
X-Forwarded-Encrypted: i=1; AJvYcCUqoyugVDq5ijafNltMt23cws0wRGGviBhva7p+0zN0fbWumOa4a4ExzeffSDBBAwUe3xCBSf7lqoeLo9qkErTo@vger.kernel.org
X-Gm-Message-State: AOJu0YwG22bhNQ6kXwZciNhLNG7tBj7kLoMPjrCqTL3jd/b9GgYijL/B
	D9T2GncEt6yb4vDROPs+cPHrNnGc6cZU5WMRrVZzBg4wMTTL7vZB+8OvBFz2w7o5JCTkLqaPy+s
	fqZSt4id+Ng==
X-Google-Smtp-Source: AGHT+IEPCJbe4xhivSD4VOVmkKDqSSL5N19KSaMH5pXp+sDwmhKRdM9bRebMPbLDdbbE22jyUXyW79hXKRjo
X-Received: from dyng12.prod.google.com ([2002:a05:7300:7f0c:b0:2a2:3f59:eef5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:cf88:b0:2a4:3593:4686
 with SMTP id 5a478bee46e88-2a9418bc574mr13696140eec.34.1764697886637; Tue, 02
 Dec 2025 09:51:26 -0800 (PST)
Date: Tue,  2 Dec 2025 09:50:01 -0800
In-Reply-To: <20251202175043.623597-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202175043.623597-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202175043.623597-7-irogers@google.com>
Subject: [PATCH v9 06/48] perf jevents: Allow metric groups not to be named
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

It can be convenient to have unnamed metric groups for the sake of
organizing other metrics and metric groups. An unspecified name
shouldn't contribute to the MetricGroup json value, so don't record
it.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
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
2.52.0.158.g65b55ccf14-goog

