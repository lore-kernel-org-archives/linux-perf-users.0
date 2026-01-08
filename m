Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33F93358B0
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2026 19:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767899544; cv=none; b=puphEzvUHoIbBVhkwgemoAD3E0jGMqr1pwUo0zneS9pJrjAGQc8b1nfCosgpH2n8IssfUyUIUon4sJAZ/NHoFK8mYjqFrYezbHnJCy6medZoC23iPRi+QKcsFcgJkTeX+splSGGvKMDxYSC/thTxFyXS5oCQyzWrQKBtGgvMz14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767899544; c=relaxed/simple;
	bh=Sr+0utK0tNOs2nzfxd6UaoFEVfN9d6C1I9sdXtbKpqg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=cbQ/5btlPlEwjP+8Ya+FTXwf9FAWi4eKbYfYSgJAlnxFqfR4b04RzDOFBrW+cDE7GrP3byRT26y3jt9pGj6e136F4y8oBrbU9sWMhwd51IyXi7GZHE6CKAdDA+kfaeqq+ZDLiEsoaP3EztEA9G1UA/I8fQWXkR4RlAfL3rFTDiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0/lYTG5o; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0/lYTG5o"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-11f3d181ef2so14829877c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jan 2026 11:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767899541; x=1768504341; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yAo1MILhGnqZNbLlgKzWKgNCypTb5sxkZ5UVUsguhwU=;
        b=0/lYTG5oqa3H5V4jRhmYh4aehuFHMJyg3iRXuZiO783mafOTswnlQTGGTMYrCibdoV
         yBrkk2Um+5gBxiZtkJ+MchchCN7cTaZJj8Wa8kBCnippb2rnNavEtQvohhWS1n2VeGGs
         rKNpUCei0OUjEcZDUKTRaklnIU5x3KHLXKNiUucwgdZgwPRny7A46TIb6PbIDSB6RpI5
         6dqfK0Vfl480Wt0LnI4q9JoCQcZtf23jE9AGYoVUC+7w337p1ip2tUxQNy99K8vSeS8X
         D3ZpELI7gsp5m9ZPDRCXcJdyOQU+W0hrZbyAgys8d4xJNpdBDplPRqAMwcMnqtnkPoNF
         4PXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767899541; x=1768504341;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yAo1MILhGnqZNbLlgKzWKgNCypTb5sxkZ5UVUsguhwU=;
        b=eX/Gkls6SIlhVfepnDf66ofcM4szrJBE89ij2WqhEsj3x3eZKhl132BCqiLjFoS53q
         lstQvvBZfKZPcNzTf+JF7lGTqmeeHBFTfsOuilCUvLcslgrAOTZ0a8GJRe0ETWJ7DiGt
         Dfq6gUePJQimcNcK/KEdg362RfrTyxEpHCHP7Sw3W5y5N2wZMKJt8rNZZhyxc30ALzFG
         qa3wR75hdEzp4WvmzWNwoMIy0YkuGqM9LsQjVdhpDTG2ybCRjsz+FG/MsLbQOnobym09
         jLj4o8aF3OopCAA2zgdPBGjIDIod40tiCLeq2cgnXDaCQblTpYaaqtuxs4LMlxa3yIwZ
         S0DQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2GplnAe68FpRZa+ITf2liZrdHprkDXsa2ewVbJRuD6gfyr78+/PZWPlaCImg4lu/lTC12G9NxfsOWBUtZWzr5@vger.kernel.org
X-Gm-Message-State: AOJu0YwoIdJdayalhAlTLYCrd6yHZD5vAiAmx8gSHHKS/+Fi6rqq2THY
	0I2hbVMdygb5vi+v0adIP27cnekqPQsxD50EqqOLkeEKy+A6rqzqaaPXq7wxcmZIIMgpLiza9yZ
	p6tscjfoWMA==
X-Google-Smtp-Source: AGHT+IHADtKBzmaJfGZE2ZC8SLeEnddqoBpOOdUcgbZLPOu11ukMCQntJgnojrBY5MD75XcpS2lbM7IfSVI+
X-Received: from dlbtz3.prod.google.com ([2002:a05:7022:eac3:b0:119:9f33:34a6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2207:b0:11b:9386:a3c1
 with SMTP id a92af1059eb24-121f8b750d4mr4494873c88.44.1767899540778; Thu, 08
 Jan 2026 11:12:20 -0800 (PST)
Date: Thu,  8 Jan 2026 11:10:59 -0800
In-Reply-To: <20260108191105.695131-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260108191105.695131-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260108191105.695131-30-irogers@google.com>
Subject: [PATCH v10 29/35] perf jevents: Add dir breakdown metrics for Intel
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

Breakdown directory hit, misses and requests. The implementation uses
the M2M and CHA PMUs present in server models broadwellde, broadwellx
cascadelakex, emeraldrapids, icelakex, sapphirerapids and skylakex.

Tested-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 36 ++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 983e5021f3d3..24ceb7f8719b 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -815,6 +815,41 @@ def IntelLdSt() -> Optional[MetricGroup]:
     ], description="Breakdown of load/store instructions")
 
 
+def UncoreDir() -> Optional[MetricGroup]:
+    try:
+        m2m_upd = Event("UNC_M2M_DIRECTORY_UPDATE.ANY")
+        m2m_hits = Event("UNC_M2M_DIRECTORY_HIT.DIRTY_I")
+        # Turn the umask into a ANY rather than DIRTY_I filter.
+        m2m_hits.name += "/umask=0xFF,name=UNC_M2M_DIRECTORY_HIT.ANY/"
+        m2m_miss = Event("UNC_M2M_DIRECTORY_MISS.DIRTY_I")
+        # Turn the umask into a ANY rather than DIRTY_I filter.
+        m2m_miss.name += "/umask=0xFF,name=UNC_M2M_DIRECTORY_MISS.ANY/"
+        cha_upd = Event("UNC_CHA_DIR_UPDATE.HA")
+        # Turn the umask into a ANY rather than HA filter.
+        cha_upd.name += "/umask=3,name=UNC_CHA_DIR_UPDATE.ANY/"
+    except:
+        return None
+
+    m2m_total = m2m_hits + m2m_miss
+    upd = m2m_upd + cha_upd  # in cache lines
+    upd_r = upd / interval_sec
+    look_r = m2m_total / interval_sec
+
+    scale = 64 / 1_000_000  # Cache lines to MB
+    return MetricGroup("lpm_dir", [
+        Metric("lpm_dir_lookup_rate", "",
+               d_ratio(m2m_total, interval_sec), "requests/s"),
+        Metric("lpm_dir_lookup_hits", "",
+               d_ratio(m2m_hits, m2m_total), "100%"),
+        Metric("lpm_dir_lookup_misses", "",
+               d_ratio(m2m_miss, m2m_total), "100%"),
+        Metric("lpm_dir_update_requests", "",
+               d_ratio(m2m_upd + cha_upd, interval_sec), "requests/s"),
+        Metric("lpm_dir_update_bw", "",
+               d_ratio(m2m_upd + cha_upd, interval_sec), f"{scale}MB/s"),
+    ])
+
+
 def UncoreMem() -> Optional[MetricGroup]:
     try:
         loc_rds = Event("UNC_CHA_REQUESTS.READS_LOCAL",
@@ -944,6 +979,7 @@ def main() -> None:
         IntelMlp(),
         IntelPorts(),
         IntelSwpf(),
+        UncoreDir(),
         UncoreMem(),
         UncoreMemBw(),
     ])
-- 
2.52.0.457.g6b5491de43-goog

