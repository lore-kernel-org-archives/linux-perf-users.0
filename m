Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8863D337BAA
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 18:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539579; cv=none; b=JdT8oSdTwSIq4yU30xcK+PmpSHutptKY6wQ4FBJjKNFJLLtoye1xzqLm0zTUSCs30m8prGIxZOBMX6gpo9ABmaimRWjOJLzzD1QOhvCre7P7KQBjVJ7067P4+bTN6DIa/P7cJ9kNmoaIFUzcA/rLIroVPdz3xJVcihz2deeyRPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539579; c=relaxed/simple;
	bh=Ox8xoIEvHlXmb3ZnV7uUMcH4VYIJguTr3dOQXPYocWo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Fzcm5FTE3eSoNiEECLDLx1LwrHJsH4tgog3ZhddjWKeDaon1vgD16R0q4U34dhOJAYcSg7aRITs8hulFOgnCwNGi9sIQ1h2Um3vazUePeLiLIlSzROEKIKp1Y/meS2ng+9BuCmglNEmcrWy77frAg4hgqoEx8VGx/UzRhMpupNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yla9DBmf; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yla9DBmf"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b70d8095daso5754371eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 10:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769539576; x=1770144376; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZEKSewz96VX4s1GwXYzsYujeSp/AMjDx+PpNSoy8VmI=;
        b=yla9DBmfwY9RowwoKhTDXHQ46IJQOtKstAe94wIDZWg5EWSkp0dkGq8r+ZgM6sWk9V
         hv7RGQ0/t1BACq4sCTjmk39+q8XkAuwjzLR9Od46HLlct8oUsAQ8g4D0KWlmTRb7Xlst
         lfnaqTFVUyTwpZWB2uKJI48DSpsSULm96dMc+V7ky7F4qOHv4dtkwRPLkyv+/Kz3bRNa
         2imri5PrJ+rS/7UUAKV24JHDJbk90iCpAm4trbxvuG2yXTY4a4LqQoRGV91gXq1MkX3t
         CYY5rGldrj/Y4o2s7d0FukjiC9eNLtAnaVI7ueu+ieEbog/Ul+NUduyuQQJyRWgv2nqd
         Fbrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769539576; x=1770144376;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEKSewz96VX4s1GwXYzsYujeSp/AMjDx+PpNSoy8VmI=;
        b=eoKAhpsWg98/4D219yqpXNvJzztO1rG973EezcqpY8z2KPIrnbAoYxDzd7HIt5X0j5
         bJPN/dBlvgZO8VqennRH0Bt1DPwHmoMfE8diwHcocRwGjR4Pb1z9bqN3U7vATnMzvBrs
         9KYg8JMXKGleov4JHoYeYZs4lU8ubAqsKUug9GtUHnJpPLDa3Jv9hz/b1oy0Llpq7/hq
         ehTHfz88DeAELf+s4Hso2JSePnFUSvT5j1ax3oYXemSHipIDFDkEjGvSDl5XX2+8fdjJ
         6hm74tNictSjWTOz7XEi9Ev9BqQ3E2QFAg/ilhpBQfAPnzLlVfTrd9/zBOrklYAbA2sP
         ofeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwJ1gBTfLsy4n+usgsyaUVzFQ/0Uv2VOw7bgTbn62NJ0Gitafz9I99aPoZdCDhNbizyjDFZcWw3RtHgm5+s3/f@vger.kernel.org
X-Gm-Message-State: AOJu0YzVDnzgGuBTcTdemJXGbOtKu1fbI0KNBe2dExq3yM3lebPJS8I3
	mXvly3UERz8nzsUARY6suDNyQzolGjs+5poA9aP13fmZRJVYK0XURTyLt5QhTadw99cnjcqty2I
	5JsHXW2pNLw==
X-Received: from dlg19.prod.google.com ([2002:a05:7022:793:b0:11f:3f33:f0a5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:eb56:10b0:11b:fe75:d03
 with SMTP id a92af1059eb24-124a005f2f6mr1144597c88.8.1769539576417; Tue, 27
 Jan 2026 10:46:16 -0800 (PST)
Date: Tue, 27 Jan 2026 10:44:57 -0800
In-Reply-To: <20260127184506.3059493-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260127184506.3059493-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260127184506.3059493-27-irogers@google.com>
Subject: [PATCH v11 26/35] perf jevents: Add Miss Level Parallelism (MLP)
 metric for Intel
From: Ian Rogers <irogers@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Benjamin Gray <bgray@linux.ibm.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>, 
	James Clark <james.clark@linaro.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Garry <john.g.garry@oracle.com>, Leo Yan <leo.yan@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, Perry Taylor <perry.taylor@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Sandipan Das <sandipan.das@amd.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Number of outstanding load misses per cycle.

Tested-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 77b8e10194db..dddeae35e4b4 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -624,6 +624,20 @@ def IntelL2() -> Optional[MetricGroup]:
     ], description="L2 data cache analysis")
 
 
+def IntelMlp() -> Optional[Metric]:
+    try:
+        l1d = Event("L1D_PEND_MISS.PENDING")
+        l1dc = Event("L1D_PEND_MISS.PENDING_CYCLES")
+    except:
+        return None
+
+    l1dc = Select(l1dc / 2, Literal("#smt_on"), l1dc)
+    ml = d_ratio(l1d, l1dc)
+    return Metric("lpm_mlp",
+                  "Miss level parallelism - number of outstanding load misses per cycle (higher is better)",
+                  ml, "load_miss_pending/cycle")
+
+
 def IntelPorts() -> Optional[MetricGroup]:
     pipeline_events = json.load(
         open(f"{_args.events_path}/x86/{_args.model}/pipeline.json"))
@@ -836,6 +850,7 @@ def main() -> None:
         IntelIlp(),
         IntelL2(),
         IntelLdSt(),
+        IntelMlp(),
         IntelPorts(),
         IntelSwpf(),
     ])
-- 
2.52.0.457.g6b5491de43-goog

