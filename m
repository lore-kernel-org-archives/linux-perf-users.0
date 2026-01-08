Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223CB33374B
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2026 19:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767899537; cv=none; b=k657C6rU0DK6rjuxQxvTaqt+Z3wuxDD0NFow/ymnv5ZgG/IARFhRJGHdg5CQ7zKnWMFicO2Er3PF9v4WfW46sZOovOpPpn7KK1nYXsf1o/v9peRwBAWTZu2tHiNCPnfI6ApSw4AE5ikcgaMx0HOujfwi0Myc64cmsPwWTGu+TEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767899537; c=relaxed/simple;
	bh=Ox8xoIEvHlXmb3ZnV7uUMcH4VYIJguTr3dOQXPYocWo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=LapbkdaissXjPnPasosCJQlHDJDnZ0RyVQM4SzklgmSj/2swTDYr3YoeyR4c97XJXc99DWLEvPAsO4oRt/u5tu+mYjhPfuJE3DUCAppGhro6ap3ljbDGCb05RXL4QwS2qXPQGrTxmOnKwRUAa8NEmDjSO93KJmXfWB0pUJhMMIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L41gueMr; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L41gueMr"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-121b1cb8377so4583237c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jan 2026 11:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767899535; x=1768504335; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZEKSewz96VX4s1GwXYzsYujeSp/AMjDx+PpNSoy8VmI=;
        b=L41gueMrUqGw5FHtgNDc0YMt7JJD+HXrowPrFKkCxM7knKv79QZmhPYZ5NqkBi3Avt
         iV6iF+IoC46XUsBQVHFoav/D05zcwe8KgsZN3EB8Ehwt3wtLt0pZ3IefV40H/+kapOga
         YznCmSvPcXiBTg+IGKmtwLKhGHwByIKrDl4caZRtax/VzpcDSXT3Wxp4rEt6LlCK+Vyz
         ShW2rc3p28/qJ5WxZVf0d2rs4iZJYoq9M46ucfRd4BWXtUCwVbKGm8vNQe4x9IvufKcH
         ZgOVjN6DOg60AgrlRLk2Zf/99oSpK35nceLYw3Ns776IjMu2WYY0PY11e12YALsHU9kD
         TB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767899535; x=1768504335;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEKSewz96VX4s1GwXYzsYujeSp/AMjDx+PpNSoy8VmI=;
        b=QmyzFLBXHlhO5VM4r8+jh65fHDczDppTd0WaA4PLVnnpDH4GQvAOocZ6G9LtUEnOUC
         +qwprhhMasphVfvfUu2CnNeck8pT5LipCUGBBrcIujg32Z8+vsG7L7mjskRvPdAYUE/o
         IAvKQNxNxi9JuxRNJHMgDu+7VAYWoeFxgLnR0I4ZxSm4WJavzRadbsl4CiCu5lbk/qcc
         CYa2P5mY76Ro/ki/L94JTovGpKlBtZya0U+1NgsaqJvvr8pa3JDsAPyU7Nh16B6f5DOE
         L9g5GeFegowJXp7+YdezKScXaB0il0EEgqt998smKK7nQA1AevdmTgOyBxn8XhPiD6CU
         eVCw==
X-Forwarded-Encrypted: i=1; AJvYcCUDtQuW4FaZcJVRK3Fj6TM9n645Ihmk4/xgTz6tqUG7Slvl4JeGxjAdWdRBCMNxW9qaJ6heAQ6n4XgqNi5Xh+LS@vger.kernel.org
X-Gm-Message-State: AOJu0YzA2Z1bv1PJNq9NTpSFSBqGCxtjxCSkhrSDRIVkcN6a9rSMAkzf
	IaWl5VyNmRpIwXQeY89RsUH5Ru2+paTHWnLs24nAhWggQ4DFsPC7KtlHCggOqh8pfzIjTZrAWH+
	zXpq+Wl/HGA==
X-Google-Smtp-Source: AGHT+IFJQw4mIH9r8PO9nIoVY0oCIzPRdJNCpXuN812RCYs2Bq/ZHIm9n3ktTBtVUfFy3JztEhiargkupqPE
X-Received: from dlbdd42.prod.google.com ([2002:a05:7022:aaa:b0:11f:3e3f:a2f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:619d:b0:119:e55a:9be4
 with SMTP id a92af1059eb24-121f8a63cf3mr6459120c88.0.1767899535295; Thu, 08
 Jan 2026 11:12:15 -0800 (PST)
Date: Thu,  8 Jan 2026 11:10:56 -0800
In-Reply-To: <20260108191105.695131-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260108191105.695131-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260108191105.695131-27-irogers@google.com>
Subject: [PATCH v10 26/35] perf jevents: Add Miss Level Parallelism (MLP)
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
	Peter Zijlstra <peterz@infradead.org>, Samantha Alt <samantha.alt@intel.com>, 
	Sandipan Das <sandipan.das@amd.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
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

