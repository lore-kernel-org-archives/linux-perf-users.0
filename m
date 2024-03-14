Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D911B5B1
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Mar 2024 05:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395951; cv=none; b=IGcdQnLDusa/Z2PvHmdzDQMoVK+b4ABpCcNFjwh08ZLLQrTwaWnvb/xslMFsz5ICK7rc/NFq7pq4ct4iADPCxojeimGfJro9m5CgxN85VqRFN2ozRqiryn0PMHFaiHzidb2sEflCCI1DTSZaFvYxz1vPbGoqBLa0g3qWJW8MWD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395951; c=relaxed/simple;
	bh=1kQ5uW3vdTVEojW2lkh4TbCqUKQ9kwqg/lZBltsOY3w=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=AN00/ZhjDNMXiVmvMdeLdB9Vw82ng0/7Y4cwLkH/iL0bmB1c0rqhzRAOs6GB+2K9WTRG+OKHe8BvjuyFUhRFjSfHZBVqT2trCosFl5pbrtO9xyc1C6ENvd47x5/Iy66Mq0EVcOBWu5MpwqnZLDjXGLcgYr+PS0n+nTSX4ZNMMm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sf7uJGJb; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sf7uJGJb"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-608e4171382so10438227b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Mar 2024 22:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395949; x=1711000749; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d57tF9Q2XhdTDIJ4za9SIwSfvP/kj9N7wv6tDaN1ld0=;
        b=Sf7uJGJb5qj5SnQfJIGpUhuch/c2YmI4CwpzOatHSR7iG21KzSx8BHwQFIWKyWWQQG
         RxF1nIXD6SSkCxOWjfppnw7705lDS3xnzolDVL8S+ekkuKQm1yHz+fV/plOSTMrUZjDo
         1ASPwbYccVFS4qc9bZWStY/t4MHsDz8LZp1lsRRbrUNU7Yj68PKDZXOYuJ5WYOc84Ovi
         KF0gtOo5Q9nag8vwJ5oWRQk6uMC0d5T26LLZH+mEPajL+pOJPlgYcNI7QF4amqikciUJ
         NMOldEQKsWn6oKermX7e/MfCzkqd/a6poyspMM/Fct04V0pKwVl2/TViaYQrF7B2rwfB
         m3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395949; x=1711000749;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d57tF9Q2XhdTDIJ4za9SIwSfvP/kj9N7wv6tDaN1ld0=;
        b=lw9kJRTkL1a16jYlI9IEx3qfoivKNwyZ4uvbWTcDIbCTHY+MiZQxY4KEhSQz1jmPSG
         QQDIpdzYIO1yX788uGo1BO5NAFrrPI0VcpFXb52a49biilljBUqnvg2966bHRycE9lGQ
         A5tyy+v4HQvKcCFhELZgtHPr7EoeTt1y1RcTy+WheXqtK/34xr4+jGBaiJJaNuK9Vb+D
         X4V2jaCKYfIQVjEU5c8818hd7ch+3ZAVSGUsugDcp0r+oZsXog7ru3CjU4Ow0uH0nNWd
         Q6KDbfRMUVrsH82/+tMiYFEddpL9iXkWPcc41HfMp317+Grik9q1NbI42euWw6YxLgyS
         DGGA==
X-Forwarded-Encrypted: i=1; AJvYcCUfElThCmmQBjeR1+7Bt1Dpv+gjj1euz6MpDSxYxwnFJj4fTKwSOkkm1lTVbxV1l3k25r7lIMCVqJJmS+NciL3Yx3VY74rK4DjMLmbaTXUAqQ==
X-Gm-Message-State: AOJu0Yx1QnuIChs/RNaW8NK6D5dZsnCCzLIuaEKEp9AXMeLfrr5Eja+O
	keQudXGaUXMa/vK57X1zlnJ1zDQLcCzpQyGRhFvGSQnpifKwqIqw1Cw6aYe15k2bMgQM75FUMAf
	lp9eLRQ==
X-Google-Smtp-Source: AGHT+IHpTzwZVr+evwz6fT+xaE9J2vpkhCCxsBfF/HuodCT82E805zezsyLrev/LIjgH/VuabifvcDBWF3bV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a81:4995:0:b0:609:4c74:5cab with SMTP id
 w143-20020a814995000000b006094c745cabmr153105ywa.2.1710395948788; Wed, 13 Mar
 2024 22:59:08 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:58:38 -0700
In-Reply-To: <20240314055839.1975063-1-irogers@google.com>
Message-Id: <20240314055839.1975063-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055839.1975063-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 11/12] perf jevents: Add ILP metrics for AMD
From: Ian Rogers <irogers@google.com>
To: Sandipan Das <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
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
 tools/perf/pmu-events/amd_metrics.py | 30 ++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 2fc8064e4fc0..bf5c4ffa53e9 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -120,6 +120,35 @@ def AmdBr():
                      description="breakdown of retired branch instructions")
 
 
+def AmdIlp() -> MetricGroup:
+    tsc = Event("msr/tsc/")
+    c0 = Event("msr/mperf/")
+    low = tsc - c0
+    inst_ret = Event("ex_ret_instr")
+    inst_ret_c = [Event(f"{inst_ret.name}/cmask={x}/") for x in range(1, 6)]
+    ilp = [d_ratio(max(inst_ret_c[x] - inst_ret_c[x + 1], 0), cycles) for x in range(0, 4)]
+    ilp.append(d_ratio(inst_ret_c[4], cycles))
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
 def AmdDtlb() -> Optional[MetricGroup]:
   global _zen_model
   if _zen_model >= 4:
@@ -584,6 +613,7 @@ def main() -> None:
 
   all_metrics = MetricGroup("", [
       AmdBr(),
+      AmdIlp(),
       AmdDtlb(),
       AmdItlb(),
       AmdLdSt(),
-- 
2.44.0.278.ge034bb2e1d-goog

