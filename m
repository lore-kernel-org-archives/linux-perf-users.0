Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DCC5787F
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Feb 2024 00:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165929; cv=none; b=mwtyZiSh8E5U6WboqBdf90GFJzCYeOppRaf3VKdcP4V6eN/OthdKeCj9W1WMaXGYGjjGQ3HbD3ExQuy6o61ZhwKDJ63B8bnZ7wIRlGrli18Gx98zIT6xb4KfLXfS0jO1T+NucfGivInBgAzXi5MlLqKrtO1eSpnt0By+9D1HW3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165929; c=relaxed/simple;
	bh=Eq3tg/JsCmJvAD5Ui2Tzj2WmM5yVtYEVdiyfvstEmk8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Gm+s9cVwAHHYtuWk5T4Ru9kfRwP3Na1F7dms7+8avxGowAGMVretzox0xJKGQcQbD7lcH0iIDgZb2dkXuAzDviCCqSyxZhjzX4+kxd5cUw3wOAwZbTEKpp5mDy3CoBDORnCVAAXz7r8Ew6saCK+6jfNLL5jwFdInSvE8cMi4Xh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JwOhs7Na; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JwOhs7Na"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcf22e5b70bso630424276.1
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 16:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165927; x=1709770727; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+NpctYLw69wVy2quG2Men4l4HVGKm57XDegIiPRKOj4=;
        b=JwOhs7NaUhl30dz4ea8HQ4nJwqr1dnNIWDyLMceO5eosq2kg29iQGPYnkt4ab7P136
         2aUeUpj/k+bsDxzwZwiEze4A7tde9cXx3OaZhAOvAtK5B3yRA5aa8qtW1GVKTCaXkkSg
         KwUnexhgrvhUudDiQQd3hRowvMuGU2zpqIookx4gFingryVGwryOA3YhRLZQuY4ejKhW
         bvw78y5jEhBRDZsIVOJTI/PVW8pNQJ1Ig/jpJ2lsj2XOSvPFO5KeTJ1ywwjJFRTwfxxW
         /+7TwkWCat7WHdZWQoBLIUXbIpP14u//8bKG8lfv413X0U1EluD+LYycppNSbC4+TJs+
         HAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165927; x=1709770727;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+NpctYLw69wVy2quG2Men4l4HVGKm57XDegIiPRKOj4=;
        b=GPkYdOxCszx5+7x9XshQPk0G1FPf3mCFZ/4eUo1z53R8ylvjrbXOjbS+mpB8yfGM9z
         ChHwK3cQ/PobPprxkRdgOOR8/RGdy0sWkKE75CZ7oMmbbaj+YURBV2xx4Fci9j/0oBHe
         40Q9S1MvnLsvdNeBkpGy8gphn0xMWUp/tD4bvfOcJ5lebqH8uQgpsoFhejuBkJMLwhkc
         /Q+XpL7cGyAyDSU7xaVu1hZ9NhlmNdDv5NLVOtF7i0jJ3mZ9u8mAUd29AJX3s44aFCmt
         zlutVjInReeyUbwKfS3Ae0wh0XKOhug+1p8bgO8mut7Boq9bwq84bK3cZL92nTZmFOZG
         Gn/A==
X-Forwarded-Encrypted: i=1; AJvYcCUhb3PE8tThC7sYr93sI9XJCRWJPwBsaWSHbXJxmMlffYBlzWE37fPVphDbURUJyOXsVdtuLn+D/J0wkJ3E7/3rwAd3yv/J04s9BHOCowM03w==
X-Gm-Message-State: AOJu0YyGdPoh9EGa9YRE+WO60dJhHzhnWCobLjo6oQgKJ0aLyYXvUjz+
	Sjnn8K68FJLEroLyKGYGxkBcmqGtw+pNKlHJqkVxTvuLHSJ2wnEiOaVnKvbOXHQe86I4oTKWzQc
	Wn1R3HA==
X-Google-Smtp-Source: AGHT+IFN5KukWzHp4RywVFGqtouZzsR9PWwnvecj3o4ERkM6SW+nBdl+7mQnDNoZHqOXyjmT3Vbg08GMm/t7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:1244:b0:dc6:e20f:80cb with SMTP
 id t4-20020a056902124400b00dc6e20f80cbmr44031ybu.3.1709165926883; Wed, 28 Feb
 2024 16:18:46 -0800 (PST)
Date: Wed, 28 Feb 2024 16:17:55 -0800
In-Reply-To: <20240229001806.4158429-1-irogers@google.com>
Message-Id: <20240229001806.4158429-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229001806.4158429-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 10/20] perf jevents: Add ILP metrics for Intel
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

Use the counter mask (cmask) to see how many cycles an instruction
takes to retire. Present as a set of ILP metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 30 ++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 0035e2441d6b..0ca72aeec1ea 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -271,6 +271,35 @@ def IntelBr():
                      description="breakdown of retired branch instructions")
 
 
+def IntelIlp() -> MetricGroup:
+    tsc = Event("msr/tsc/")
+    c0 = Event("msr/mperf/")
+    low = tsc - c0
+    inst_ret = Event("INST_RETIRED.ANY_P")
+    inst_ret_c = [Event(f"{inst_ret.name}/cmask={x}/") for x in range(1, 6)]
+    ilp = [d_ratio(max(inst_ret_c[x] - inst_ret_c[x + 1], 0), core_cycles) for x in range(0, 4)]
+    ilp.append(d_ratio(inst_ret_c[4], core_cycles))
+    ilp0 = 1
+    for x in ilp:
+        ilp0 -= x
+    return MetricGroup("ilp", [
+        Metric("ilp_idle", "Lower power cycles as a percentage of all cycles",
+               d_ratio(low, tsc), "100%"),
+        Metric("ilp_inst_ret_0", "Instructions retired in 0 cycles as a percentage of all cycles",
+               ilp0, "100%"),
+        Metric("ilp_inst_ret_1", "Instructions retired in 1 cycles as a percentage of all cycles",
+               ilp[0], "100%"),
+        Metric("ilp_inst_ret_2", "Instructions retired in 2 cycles as a percentage of all cycles",
+               ilp[1], "100%"),
+        Metric("ilp_inst_ret_3", "Instructions retired in 3 cycles as a percentage of all cycles",
+               ilp[2], "100%"),
+        Metric("ilp_inst_ret_4", "Instructions retired in 4 cycles as a percentage of all cycles",
+               ilp[3], "100%"),
+        Metric("ilp_inst_ret_5", "Instructions retired in 5 or more cycles as a percentage of all cycles",
+               ilp[4], "100%"),
+    ])
+
+
 def IntelL2() -> Optional[MetricGroup]:
   try:
     DC_HIT = Event("L2_RQSTS.DEMAND_DATA_RD_HIT")
@@ -603,6 +632,7 @@ all_metrics = MetricGroup("", [
     Smi(),
     Tsx(),
     IntelBr(),
+    IntelIlp(),
     IntelL2(),
     IntelLdSt(),
     IntelPorts(),
-- 
2.44.0.278.ge034bb2e1d-goog

