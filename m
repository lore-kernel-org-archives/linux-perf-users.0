Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDE618800D
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 17:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727373086; cv=none; b=uIbmGVWzf9Cuw35aj9wUGRlpvEATMVTxhhJ0ts2EQdQXTgIZ1Z10ohv5xhuzHoPL5AohNrnrweFnRnDk6LKGBRYuLrb4B+8gXC3iLuFWvJ016hh3jsppy7ePDHULKCn1UaPT4Lfpe1DtmyU1KlLBNtzmNjS6SAkw4jcoCItDYfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727373086; c=relaxed/simple;
	bh=Ja2DmHI25B4SJifinN5naZfFGFDDeIK+XJQbVOAGpIs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=V0UYzMhAM31lrxnFSQuQEMDy2av/QfzPukI1WhJkwstrCv+cmMtI5vQYG+/9eWzUx0yPDvysEJinVJr+m5S9nF29sXP+ojb4vzYREl1g2xX6volKTZIToQ0lBJ3lZLY7y5ulUk6zDsRYZFSAhQxBcCiYvoL7pGKG4pIpyl7bM0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s7VLfzl0; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s7VLfzl0"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e26046ed465so202052276.3
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 10:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727373084; x=1727977884; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Wve0BtpKf/TpCDN5qJUP94Mify/RE170fRIWW474VU=;
        b=s7VLfzl005ncal6Pa9ebx+EcfPYWXi++vjP9yYkLv6qvqvstR8ylEQsizOh2yBQh3j
         Fqs0iD2JVxoturfZ2gUV4vzVolGtVJ44BmSVAL6IgEersS4YsFuoR2HrwboUFOkmoBP2
         31Y8xW98dW3LwhRkB9ROGpdBNb9S1bq5fZY7Cj5LtsILCDmzAh0ANPq1Cnmprl7XzA/4
         sU8MA+qjchlt47MbJiWu/kMV7nnC112z+CoSo3Mnz2w8hechPQXVP5ppU7HGBvjL6XSX
         5ioEYHEhoWt4lxNpLaXdc0dYFMhvAkgiABvQ81X/MBgTMMI+V28S2Z+G/PxMo1OODXhO
         qWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727373084; x=1727977884;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Wve0BtpKf/TpCDN5qJUP94Mify/RE170fRIWW474VU=;
        b=kjd3J52oDMfm36TkNpTA+k5qPnKJ2r23LaozIUY6wM8selXG/nu3HSxagRxJeoNp7Z
         aS1AUK0KhczE9BXcFSEiqa0QXVz2KzX/+3jH32RTn3uq54OMgaeMHzyhrXuxdrxSpZvx
         7V2/P4F7lUrvQAFmoVHsTgLloqFEXSqeW8J79GVwL8ghLh+uGXRbAvjFgPNwV5y7gy/D
         OOaREtGsRmKD2ac1rJyr7lCRDZleS3829dM7PxwQWP3teh/dp8Z7HK5t1XhSivt/KjdM
         P9CzdFM9qQb39fR/MEMiU/W2DMfHtApAFmatyrEROZlPzws3r5x4H4uoykpX1nx5IrV/
         RjWw==
X-Forwarded-Encrypted: i=1; AJvYcCUXFga6yC6rt5vgQiVSCBAld4wNJz0KrRqjXEwdOwmpZPjuXNB/jKLNYfSPx2MNzKp/5lJG34AAt/i/eUmQzAxv@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwys0nFvYCzKj5EGv8NTyTJlfbQ36o3oItC32cYfB/RBXPsc6M
	FrVKPGMMVWkbKA+tW2C0/MeaYuzXQt7dMJSedCywXIiDvHSa9EL00efgSke7IgRL1XmGsFW5AtO
	qg82wFw==
X-Google-Smtp-Source: AGHT+IE1Gv5y9c/B3fBfhwAMuJqsvxzd1RQmjNTDlZb618mzSvSLdap0FRQAF2UFnh6RjRWvcTwH//EzSumY
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6894:6d8b:d227:e5d2])
 (user=irogers job=sendgmr) by 2002:a25:8082:0:b0:e1a:70ed:6ec9 with SMTP id
 3f1490d57ef6-e2604b1a3fcmr295276.2.1727373083866; Thu, 26 Sep 2024 10:51:23
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:50:30 -0700
In-Reply-To: <20240926175035.408668-1-irogers@google.com>
Message-Id: <20240926175035.408668-18-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926175035.408668-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 17/22] perf jevents: Add local/remote "mem" breakdown
 metrics for Intel
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"

Breakdown local and remote memory bandwidth, read and writes. The
implementation uses the HA and CHA PMUs present in server models
broadwellde, broadwellx cascadelakex, emeraldrapids, haswellx,
icelakex, ivytown, sapphirerapids and skylakex.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 05e803286f29..62d504036ba0 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -781,6 +781,32 @@ def IntelLdSt() -> Optional[MetricGroup]:
   ], description = "Breakdown of load/store instructions")
 
 
+def UncoreMem() -> Optional[MetricGroup]:
+  try:
+    loc_rds = Event("UNC_CHA_REQUESTS.READS_LOCAL", "UNC_H_REQUESTS.READS_LOCAL")
+    rem_rds = Event("UNC_CHA_REQUESTS.READS_REMOTE", "UNC_H_REQUESTS.READS_REMOTE")
+    loc_wrs = Event("UNC_CHA_REQUESTS.WRITES_LOCAL", "UNC_H_REQUESTS.WRITES_LOCAL")
+    rem_wrs = Event("UNC_CHA_REQUESTS.WRITES_REMOTE", "UNC_H_REQUESTS.WRITES_REMOTE")
+  except:
+    return None
+
+  scale = 64 / 1_000_000
+  return MetricGroup("mem", [
+      MetricGroup("mem_local", [
+          Metric("mem_local_read", "Local memory read bandwidth not including directory updates",
+                 d_ratio(loc_rds, interval_sec), f"{scale}MB/s"),
+          Metric("mem_local_write", "Local memory write bandwidth not including directory updates",
+                 d_ratio(loc_wrs, interval_sec), f"{scale}MB/s"),
+      ]),
+      MetricGroup("mem_remote", [
+          Metric("mem_remote_read", "Remote memory read bandwidth not including directory updates",
+                 d_ratio(rem_rds, interval_sec), f"{scale}MB/s"),
+          Metric("mem_remote_write", "Remote memory write bandwidth not including directory updates",
+                 d_ratio(rem_wrs, interval_sec), f"{scale}MB/s"),
+      ]),
+  ], description = "Memory Bandwidth breakdown local vs. remote (remote requests in). directory updates not included")
+
+
 def UncoreMemBw() -> Optional[MetricGroup]:
   mem_events = []
   try:
@@ -878,6 +904,7 @@ def main() -> None:
       IntelMlp(),
       IntelPorts(),
       IntelSwpf(),
+      UncoreMem(),
       UncoreMemBw(),
   ])
 
-- 
2.46.1.824.gd892dcdcdd-goog

