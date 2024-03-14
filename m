Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912B817C60
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Mar 2024 05:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395501; cv=none; b=tveJaZN1TmEFTBEh9xNIEyjCTuysCOGpswUzdVzTPUBwLY+qo2IqnJsSddmi2bt+LbzIBnzmq7EGr2AHzoFcBBBvks+Y6BRWdRnGYhxxCeCAYpqKQPIYsv0pZeBD7oKyY36lcbTdpAQQRSvyi2tFtpXuqMiXQj0Tnh59iF7f6vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395501; c=relaxed/simple;
	bh=gNv29+h0IhWRsa2qydUVk3E45fI6zH8amlK1YqhsJZ8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=btOTKEViTDkVuV1+fS+FqReYGGlSvBTCalrqqgVj3vBmWK1zoNgfHpu4JgMIC6XecDTX66oNU7K65GzdgxZXBmMYTA178rzzbx1Tx1G6uKOOALFHu7axfTB5m7AEtHN6DABWxWirXRvPtbcMICGrjrGMfGUgnpjS8IUSqTuMIko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rYyViSrD; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rYyViSrD"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a08eb0956so9903067b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Mar 2024 22:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395499; x=1711000299; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gGG+6HzWesnJ1eAogyUwc6CZn4obQaKW0ElKvKW4EMk=;
        b=rYyViSrDpKKNMMGJ8bjP6bqb3Tbwe+tVJm2kn+qnbD49/uyfV53ltlm0UQFYRGsKTs
         bjLxNMyGNxf76f04v9vXg5nuM4hDNqiLAhiqf4w5vjZTXmWV8EZ244KqP/UutZsXWpw9
         7AA6C63KMiiSFuh7LKOOq2j1Wz0Y0nPMECuuOXXO8kNyeDIW/2qhkVpOnSNwohOAppFS
         MX+cDPPwNseaJsPlolq2W1AVedORiPDJzxt7BrRmmlkWe9AwciN/CH3EdmcwmKpRcbZv
         eCTZuhiR8EPPjduJ4j8bsVh4ejxS7v1leNSAvUlv6cd0AMGREbKkI8y96u+cbeCMbs8s
         W3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395499; x=1711000299;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gGG+6HzWesnJ1eAogyUwc6CZn4obQaKW0ElKvKW4EMk=;
        b=jKks4uezNjUL905OUwormm29JyjA0R92s+8Icx+CscS0pk80dznbUl2gd0lZpzJNrX
         sBQxpk1HS8AwYAA99TrqLXXHYk4Rv3I1TCiokc9f4BfXCNShIUKchulxohuVs8QbF9jO
         EoTb4E2Rp33yygK3E6RsSUItBayJ72QRGD6nozax6jbPlxFUsuoUiU3oMZEBBqEbzdg8
         gJpCBbTmgGIjD0yrLSIW+6ZjS2xgQnZG7POpuAA7Jyhe2J1pvfZQv+TYoxumdkcLmi+n
         zBJ+F8fi6ZmwUI6d5jGVFyBvxZ90icnc16Xx8BDeHE6V9S3oYPtobzbN9+XGtGi6RvQd
         sAAQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4cmFbob398bASJYXGEjLsg6eGixEfW3N/qyZ7dfmBQkhEuV6CSbYdn4pjaEFFQwOy3f4vcrCfy4Kh2F6dRc8O+EEtTVP12aEPsr8V0A1tTg==
X-Gm-Message-State: AOJu0Ywsc6j2YvYf3i8kDgVmNWWr7xHpsPNR4s3flokspqXGcrOxvyxk
	6Yy7+llMD/BdEY00V2KhLMaOP8Ey3F/AuRGbRcqRgfX6PnohdO7ghJYcSRCWOZyKqq9coOMf2Nz
	YvS3yKA==
X-Google-Smtp-Source: AGHT+IEja1wmZDBHKsl/XJi/skgaumi6X/bo/V6oGWcJkhbKkYCs0Yuuo9kxFl8375k/lLdaOYPUHsEYJmOt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:248c:b0:dcc:41ad:fb3b with SMTP
 id ds12-20020a056902248c00b00dcc41adfb3bmr34206ybb.10.1710395498856; Wed, 13
 Mar 2024 22:51:38 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:50:49 -0700
In-Reply-To: <20240314055051.1960527-1-irogers@google.com>
Message-Id: <20240314055051.1960527-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055051.1960527-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 10/12] perf jevents: Skip optional metrics in metric group list
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

For metric groups, skip metrics in the list that are None. This allows
functions to better optionally return metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index b39189182608..dd8fd06940e6 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -493,13 +493,15 @@ class MetricGroup:
   """
 
   def __init__(self, name: str,
-               metric_list: List[Union[Metric, 'MetricGroup']],
+               metric_list: List[Union[Optional[Metric], Optional['MetricGroup']]],
                description: Optional[str] = None):
     self.name = name
-    self.metric_list = metric_list
+    self.metric_list = []
     self.description = description
     for metric in metric_list:
-      metric.AddToMetricGroup(self)
+      if metric:
+        self.metric_list.append(metric)
+        metric.AddToMetricGroup(self)
 
   def AddToMetricGroup(self, group):
     """Callback used when a MetricGroup is added into another."""
-- 
2.44.0.278.ge034bb2e1d-goog

