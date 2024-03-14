Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A749A55784
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Mar 2024 06:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710396017; cv=none; b=MdYdlowkOOv8bgOarWbbEF+fnp90fRojZWVBtNwYN2nwWMojytYslGeJyTO7jSlSuKssroAxYmzFsMGtnQEZuWJGMa93oPl+waVuhIKwbvlgAlN4iB0yKeC4++uAv0elCZOfje0DZT2vfIyGdXa9BskYbvIfBnQUIdee5gU5P7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710396017; c=relaxed/simple;
	bh=n0hCKJOhlUlJCmdcwDN2VdNUYO/G7CQ1TA0ZpP6Z6tw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=aVEip91uZAJLXcZpXonTb3Jp2xegsqv4oqB1BxrYHXv3vVTqgAaNl2Pir8pcfa9YWyUHIkUofqQBPdBAGmun37uMPKzfWlW8r/U0wo8OwV/cJlneCgBRUbpdaWvGWPVFcrEv/kd/d5ENiJkLZKL3qaDQIvIGiEuinYjaTCP6DWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0intQ5lb; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0intQ5lb"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6dbdcfd39so993845276.2
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Mar 2024 23:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710396014; x=1711000814; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QZF+lDg+x+4lYSQ25pqZOkUZnj+qYtfQQOFRuHTcEG8=;
        b=0intQ5lbE69xDg2IYnFPkyvGhd2ZJ0cwPAP3p6rnzeV8yfPN+EBh/QODXk1qunfjPn
         cOgI/bFJPcqdnXL1790b+UDypKzsae54tgOklwBR8YEhiAxCD6+Oi7FLlnO18ziD0f/Y
         LwYxm4/BdniW1B1ceu5pztsQFTns7HnqosYbL68tezt7FZTJACIgMxFfVKyR5ZRNE0wm
         AqwJ3VL7bTrHHIAAye3ZDu7cEb26ydR38EwSlLWKic0YNR1AUBFzGe9pZUajxmsNlhrb
         gAYoQtY9n5iL/Wcx4nJ00jLa23CTrRFp3f655guMhOS2bAFw6/tVxUvwLH1FRFpNN0rg
         QQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710396014; x=1711000814;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QZF+lDg+x+4lYSQ25pqZOkUZnj+qYtfQQOFRuHTcEG8=;
        b=maOFkK9hqQBl2bIBetzmVUVYidJYALrbCGH8S17UhPsiGhCmA7dcuUmtvH6VARVOPD
         VzZEBiIagNne1JdW+Nqj/crEt+QAzozW6nzlyXDWTILgwSbzvs94KCubR++HQCdzMtIh
         aB9XLeeRGIcGUZ7GSEuWmOClKLUX9GUHLWaPN6z3Ay5e/+CLRgt0DXXz+G+IWiV6ADlL
         vImXYyz9Lyr4h3Hc0wENx21XdZgyKNrHFF6BQiQz14w985PEPfPsAItU37U0TIIjNv4w
         VGBnPumZCqYARBg3RDy6FqdlUcw9Rim0Iq89H5Y9Q0mQE+MYgF1BtAU3os11K7CTF2Fh
         qC/w==
X-Forwarded-Encrypted: i=1; AJvYcCUQUhETPiupjTwslRRtoN1oeNxHUM0TKq7jM15ItQxTrCGTEXdq0PgnP4TK+cpAtf7GOT79l2HOLgKBZGQC/H3rPwy0TBxbXzo+DM+rR3blOg==
X-Gm-Message-State: AOJu0Yym3WgNZB3GNxnckp3P/EUi4gqJ9oo+tKfhitE22tmKfEkPHHT7
	cjk1N6SrK6UOfqsJsHTn08UJGPY0Gnkjk4NZvv/OYEjhAA1rRbF+ndStexmfeHcBlZLybkdG6zM
	kTOVoiA==
X-Google-Smtp-Source: AGHT+IGTzCPvzNe1FzIzgXs6Q9kbuqyr1aub5IHA6aYENEtw3/TaCG98nTpP+peSoQ96AcjfAYyOdeKlFtDE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:218e:b0:dc2:398d:a671 with SMTP
 id dl14-20020a056902218e00b00dc2398da671mr258706ybb.10.1710396014754; Wed, 13
 Mar 2024 23:00:14 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:59:17 -0700
In-Reply-To: <20240314055919.1979781-1-irogers@google.com>
Message-Id: <20240314055919.1979781-19-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055919.1979781-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 18/20] perf jevents: Add C-State metrics from the PCU PMU
 for Intel
From: Ian Rogers <irogers@google.com>
To: Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@arm.com>, John Garry <john.g.garry@oracle.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Use occupancy events fixed in:
https://lore.kernel.org/lkml/20240226201517.3540187-1-irogers@google.com/

Metrics are at the socket level referring to cores, not hyperthreads.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 0e3ead0fa0b1..6fd45350395f 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -777,6 +777,32 @@ def IntelLdSt() -> Optional[MetricGroup]:
   ], description = "Breakdown of load/store instructions")
 
 
+def UncoreCState() -> Optional[MetricGroup]:
+  try:
+    pcu_ticks = Event("UNC_P_CLOCKTICKS")
+    c0 = Event("UNC_P_POWER_STATE_OCCUPANCY.CORES_C0")
+    c3 = Event("UNC_P_POWER_STATE_OCCUPANCY.CORES_C3")
+    c6 = Event("UNC_P_POWER_STATE_OCCUPANCY.CORES_C6")
+  except:
+    return None
+
+  num_cores = Literal("#num_cores") / Literal("#num_packages")
+
+  max_cycles   = pcu_ticks * num_cores;
+  total_cycles = c0 + c3 + c6
+
+  # remove fused-off cores which show up in C6/C7.
+  c6 = Select(max(c6 - (total_cycles - max_cycles), 0),
+              total_cycles > max_cycles,
+              c6)
+
+  return MetricGroup("cstate", [
+      Metric("cstate_c0", "C-State cores in C0/C1", d_ratio(c0, pcu_ticks), "cores"),
+      Metric("cstate_c3", "C-State cores in C3", d_ratio(c3, pcu_ticks), "cores"),
+      Metric("cstate_c6", "C-State cores in C6/C7", d_ratio(c6, pcu_ticks), "cores"),
+  ])
+
+
 def UncoreDir() -> Optional[MetricGroup]:
   try:
     m2m_upd = Event("UNC_M2M_DIRECTORY_UPDATE.ANY")
@@ -935,6 +961,7 @@ def main() -> None:
       IntelMlp(),
       IntelPorts(),
       IntelSwpf(),
+      UncoreCState(),
       UncoreDir(),
       UncoreMem(),
       UncoreMemBw(),
-- 
2.44.0.278.ge034bb2e1d-goog

