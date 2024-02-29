Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B7C605D8
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Feb 2024 00:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165953; cv=none; b=ZAcd77ql+iiBUVbVQZuk+oDf+iBhl0fn1m4KVCw46sfheTHrukOy5cTAjvDXdb9tyIsrzT/WJnxj/kZ5EDXs5Q6lpxTWIY5IhOqLd+bWvj9qyh2u7CR+RUm4PhGVlxVxymleKH3MfWChzOadQe5VZfSJQzSCNay/6/pvXeRgLD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165953; c=relaxed/simple;
	bh=McUJMeln2Z6sLdD8gh2mpJJERcOGFKDfTLUUixwws6c=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=rUs9IrJ1NjOAVrDQo0Y01jNrJYp6mgDYp11teIJrmmvstHKQsLluckRF9ndY2JbOx1V0GYBtHgBF8ioJ6w4Z3fwfbynYJ8PX0w6Byz0Mxgznd4zQkMp1kh1hycc4daEtF04wTSaPMCuC1KpJJb7zKdPhZ8nwXRtwrhe5vT38KoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tnh4PLt2; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tnh4PLt2"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60957b52eecso6560267b3.2
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 16:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165951; x=1709770751; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GARAKFSHROUeCUO/36ulyyjpscEMXnihleFvvHQNW7U=;
        b=Tnh4PLt2imeNpvK40JbRWZqzMn+X6PKolkVTyPqjJDdebpx+4e8mhHSAA2dMA+1+7i
         xkyzhHKK0lBRonO0/ULJsFnjdY08e/ZIqQTxqDUneUsljhtV/MrkoUe14qbN7LctzoGR
         Gzk0P4+TaI2gyCwKjCFAv4RQbvn/0r0Ri2kHvB8Aa87pwp4S2neHxtLDm8z0nBH0EoXp
         10Iww2+sufYcnq38Q9c6btRNbFRI3mlFzZF/9GdPcGfH1sjnIP4LT7wJr4QqkMjPR+Sx
         3+lz5tyPlUOk5UtgCjLLSwhRIxnJcXSbDWFd9TQLRaV7u40P53rUY9l97Dk2pO+R86HA
         tKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165951; x=1709770751;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GARAKFSHROUeCUO/36ulyyjpscEMXnihleFvvHQNW7U=;
        b=bs+9uRyD93tNuVz/wvPlPJ9Om2Z2xA1XXG/9er6BzWlzeHHZZJgc4M6Z3TlDma3gnD
         IcXPwpuOSnR+R9AhaMNA+0/JhxuFiqHjzwcTQI4895ayIIqlJithLqSNdey0LQLaOvK/
         BqToWIFANG8qKzPHdCADcnvIVQGnW2YxeXXMmsrNFXozP5AK0GCjTjc1mkg9RrolL7hM
         9owlNYToi0H6ZnMSlylLvOdgplSttrES/I9C6cAOgmOUskE3PzpM7LC4+m6wwGHTgPgS
         cO7TuflDlWEHGqnNSaKD/ImD+NSQ9kyNeGGOd2dC5+tSlfOigQ2+Bci5u1H2gPHYwJZD
         AKDg==
X-Forwarded-Encrypted: i=1; AJvYcCVTdcS+Is56TQlyV56wcPovEPEXbjUkizeiOgkXsRbg3vgq21h3uy/tQ8YOOmjIh+3giiM1UAfmOxdvooWcxzUcgKBHVmWNz++yCS3dwAi0tQ==
X-Gm-Message-State: AOJu0Yx1ipoy+W6FvGIqo55QloQJ0Wxm3+DwSX1pr6Gjys0DRUifJqHS
	WVBFMTaIBr3cCq6UmCjROXVEQSuRr0yGPHcB8SC62Izvht38ZELp01OjMSrS0RlVaiGEFRKS1xy
	5neRCtQ==
X-Google-Smtp-Source: AGHT+IEe7DD9zwn8ZOiGTYeSJUGCNvgxC5HKVgz1SIYEVj/NzumYBIuhM3sz8942xIHDOWjoqqfTLqiPZoUq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:1244:b0:dc6:e20f:80cb with SMTP
 id t4-20020a056902124400b00dc6e20f80cbmr44036ybu.3.1709165950813; Wed, 28 Feb
 2024 16:19:10 -0800 (PST)
Date: Wed, 28 Feb 2024 16:18:05 -0800
In-Reply-To: <20240229001806.4158429-1-irogers@google.com>
Message-Id: <20240229001806.4158429-21-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229001806.4158429-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 20/20] perf jevents: Add upi_bw metric for Intel
From: Ian Rogers <irogers@google.com>
To: Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Break down UPI read and write bandwidth using uncore_upi counters.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index cdeb58e17c5e..219541a30450 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -1006,6 +1006,27 @@ def UncoreMemBw() -> Optional[MetricGroup]:
   ], description = "Memory Bandwidth")
 
 
+def UncoreUpiBw() -> Optional[MetricGroup]:
+  try:
+    upi_rds = Event("UNC_UPI_RxL_FLITS.ALL_DATA")
+    upi_wrs = Event("UNC_UPI_TxL_FLITS.ALL_DATA")
+  except:
+    return None
+
+  upi_total = upi_rds + upi_wrs
+
+  # From "Uncore Performance Monitoring": When measuring the amount of
+  # bandwidth consumed by transmission of the data (i.e. NOT including
+  # the header), it should be .ALL_DATA / 9 * 64B.
+  scale = (64 / 9) / 1_000_000
+  return MetricGroup("upi_bw", [
+      Metric("upi_bw_read", "UPI read bandwidth",
+             d_ratio(upi_rds, interval_sec), f"{scale}MB/s"),
+      Metric("upi_bw_write", "DDR memory write bandwidth",
+             d_ratio(upi_wrs, interval_sec), f"{scale}MB/s"),
+  ], description = "UPI Bandwidth")
+
+
 all_metrics = MetricGroup("", [
     Cycles(),
     Idle(),
@@ -1026,6 +1047,7 @@ all_metrics = MetricGroup("", [
     UncoreDir(),
     UncoreMem(),
     UncoreMemBw(),
+    UncoreUpiBw(),
 ])
 
 if args.metricgroups:
-- 
2.44.0.278.ge034bb2e1d-goog

