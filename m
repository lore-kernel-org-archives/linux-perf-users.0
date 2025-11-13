Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1477D303A03
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 03:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004077; cv=none; b=DugOJ701OV/L2Pwfo2Ay3FM8KqnydRzKIqT8HE4sG4BUU1SqEHs/9Qh2lW8QjbPWsXISnH72Bf6ApY/9+LAMR+yUp+OPelW4jATNcwZ1HqUPlxjjAFLz/CXzihx46oQh2gJqLvMR4C+xa0Wv+JS6rFeOPOP0NxiqHddE+BnhpZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004077; c=relaxed/simple;
	bh=yDeXFZG51yzDlxaPVRiCkHMuq6NwJWFuqov57GFMzno=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Raf697Z4+WIn1gbQ2ftwjHraOgorOJN8nNv9oIK56jrzuDh7/4IpeMY2GbiyM66euudV4m1RcTkfNbHCW6fzonoh0VzRrEo28wV4hBYK+I4E6dphcoa9wSr+0mW/AiClqPH7yOWgqsV8ct8U9dr68pI8Ei1Gr5QuS5zN5FBbOUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ExjPsz2z; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ExjPsz2z"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b6ce25bea3eso359587a12.2
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 19:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004075; x=1763608875; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FwhHtQMJyZJae9JuQsiwiPN95qwIsp6WdrpruedYQdo=;
        b=ExjPsz2zXBmSBoJBgdTof4wrf+wn7Oht4BB+H8VqQmrW1dNGePxJ42i8xbPHH/QD+P
         jVc+iT58jkGpNHWFKeodicpOZKNH31aYHDKb8+me3Ntxi+QQt/5AHc+m14MHMmq8JHbG
         tY0+Ky9eB06JXvcW2qgRRgfKBOzOXySqwdgKe/asDVb9Z7dc7r0P3Etqy84eOY3Z92X7
         oRzD/KWErTMC9VOkPEEG35OaB/IEdoYyi3FX7hgA3ntYjMmHidJFv/W2iplMRFvH3PRs
         p4pSRB4xclsKD5qiQjoM/rGeV13SuyW8c2/1jkD5NrCgHRORftCWBtM+HPOU11etctb9
         BMXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004075; x=1763608875;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FwhHtQMJyZJae9JuQsiwiPN95qwIsp6WdrpruedYQdo=;
        b=FOkOszfeSXXXpNUcsC62CQ0IlO5/rtWbxnXd46yQI6ja80ofFQb5y5FOH0mWZ7cNMQ
         OcLQZKIcWDVNJua0caWqPCKFxLNNOi4TcDrxFowomYeffSj2PEAjRHuigkTMt7Ps019j
         ok8J3o/vc4nO4bRIblDnsYco6VVmTMolSvdgc/SHHNervZcisNCmeZmoSc0uF2PBeZOD
         zORRjkm6BIZLbNA3U1S4SX86TReQjWa0NIVHD687d/KFbAzAYtjhJiHHwg4xx2FKtr6J
         1+QwB2Wgl4TGU/LazrvGFXMT5/3HRIOn1Mnp25zBFaSqMCocZrxpq+yQh+e/onJBB1KW
         7kOA==
X-Forwarded-Encrypted: i=1; AJvYcCVTRKOeaXDnRitmniCmz2ISpsaAIxVusdztPPbrGhFtdfCSTx1i1WeS2O+nhd+cXNDiUTjVd4DVzh/vGEL9af3N@vger.kernel.org
X-Gm-Message-State: AOJu0YzrcCVSA1emrDvP8S4gQmR9GHoaS5w3DCbT/HCcIk9iZlsA+1hj
	JFIlr1uPdPgy1l/PNU/wKN/BDd6WbzAyUDXeLLH5oCSDwlcEutnqS0g/sXhvbNllGbjngG6k2H2
	MYsKtvlr9SA==
X-Google-Smtp-Source: AGHT+IFwGIj1+cj2yhJQvQD1NnIhcTtMbXbLThWbNJ5a3cK+/tc4OzYkLuHsnwjeFVX6nS8eP1CgcwePVkNW
X-Received: from dlqq42.prod.google.com ([2002:a05:7022:63aa:b0:119:c6ec:cc42])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f88:b0:274:5030:2906
 with SMTP id d9443c01a7336-2984edcd3a1mr68096335ad.46.1763004075336; Wed, 12
 Nov 2025 19:21:15 -0800 (PST)
Date: Wed, 12 Nov 2025 19:19:59 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-12-irogers@google.com>
Subject: [PATCH v8 11/52] perf jevents: Drop duplicate pending metrics
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

Drop adding a pending metric if there is an existing one. Ensure the
PMUs differ for hybrid systems.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 03f5ad262eb5..3a1bcdcdc685 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -501,7 +501,8 @@ def add_events_table_entries(item: os.DirEntry, topic: str) -> None:
   for e in read_json_events(item.path, topic):
     if e.name:
       _pending_events.append(e)
-    if e.metric_name:
+    if e.metric_name and not any(e.metric_name == x.metric_name and
+                                 e.pmu == x.pmu for x in _pending_metrics):
       _pending_metrics.append(e)
 
 
-- 
2.51.2.1041.gc1ab5b90ca-goog

