Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56532D0C9D
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 17:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764697901; cv=none; b=pKfZZva1N6nDIkLLLTtja9rZkgbXaZ0kii7VWCUsS/VaDfaEgfRinicGnEgp3KdbPovi4jdWhVvhjzyp4CZbZtYuP6DRoaW3H8dNk1svsl3h9yJx/1OX04ExzqTvUdzJY/snAy8MkeI51PK2egCoJibjPDkrg4XbOhG9etCCW0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764697901; c=relaxed/simple;
	bh=jDM2keAq6JzZV0xeWQw8r6/oNg7uOTPVE1rsKGWrjvM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=tT+MNUXfvBHMHNWfaJc1sKMukNR0UhYbVfwWoa7c+3mLrDfYL9ergLoOz68sITU7ku1gbTqsSKuMLc4CvWPGWQeXjaMB6GchR9TVSkb3+h9bOS7Cpt3w7F1MXBDb8s+ryP96Cej3agKtmpPA199vURcK/aPZQV6mRA0tpPJwyIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zF16tJMT; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zF16tJMT"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b99dc8f439bso9411309a12.2
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 09:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764697899; x=1765302699; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X8m+1Rep2c6fy/eFqYgnfb5iZa+BxpCo5oTQZvaCNcw=;
        b=zF16tJMTN0oCMoW6r5dsZ5zVylpgzoFn1uWFKolyD4dR8WmOVrm0MlEI1SRWkOV3F7
         DNpS9lnwuf0vzb0xHxTprYjejfY4pXRaQ2LFgFsl2+u3xini6A+Be1I5nPSQE5n/QZcC
         M3rolm5yNnG8OHL/BuW6HppNOvHGx36gZ0mQuyhX0eAyEXDcy/xwM0N5LxQHoHO2M/Ss
         udXy4A1+Jhy0X62hWg2kkQ9nEzsPWCTVr8hzOC5cie36P87mewLgFc5RIteTlvEubbSE
         cC9GTd8KW1DNWEMwYsxNWgX089irpOGc8WKCkhRM8yyQBFn56Ru3eXWAiWVj4zAV5VJP
         etjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764697899; x=1765302699;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X8m+1Rep2c6fy/eFqYgnfb5iZa+BxpCo5oTQZvaCNcw=;
        b=p63yEX9FNkr8qlHdIxfxf+hhAnyoc/FBSzbR6LdnLQX+okhvg1nCtQbspOvseOG0Zg
         l5MTVwdnzQDCN6ww11/2FHUTuiHqN3oJiR8CE9lf1peQUYmt9Rs0e2CLOTvseEibvnbq
         i4rLDpd0VYk8AVaO3RoH+pdofP0/V2pDC202rNKcw2IgeCDNLU5J+Qm2/+DAOiyiv1Tb
         G0uRXouPt4uM5KZvLGllzfGREducoY7YO3EmTJtBNCwVBO/uuuQjHsualzUK0RdD+3ZA
         M8a+pq/YTa+RLf9rkYi2KNXg2lt8VWmE8wI7AA9EY/cQqePZwqw7PI4a5isyAtciaXyd
         ZvVw==
X-Forwarded-Encrypted: i=1; AJvYcCV7RRR46OgBErHUWI1zZuXe0cgRLz1b6pj0ZASL7ImeayXndPdpGuiQcUWg4r5/C2okKLELV5H7KNmlGPc81oll@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm0DaRTIQph+GKERTSgurWsn1beXue/cf8vrTUhs8bRj2Qs1KK
	RI+gfQsTJ+TJ0PLNTNb0VZKXFk1IRG7dmKLaRXH95uULsPr925i8MY+DISVtbs1LIBRLvEmsvWa
	o+L8OQ2YQMw==
X-Google-Smtp-Source: AGHT+IFkCd9N6NIhwzGIwZmLg4mlvjlGzmjd171cvG4Dxf6lfWAM/Po6Fh7WLEOOcKuLpJDmX8ZrpKBrYGmJ
X-Received: from dyer27.prod.google.com ([2002:a05:7300:231b:b0:2a4:6899:e5f0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:db04:b0:2a7:27d:66e3
 with SMTP id 5a478bee46e88-2a7190739f4mr21115142eec.2.1764697898880; Tue, 02
 Dec 2025 09:51:38 -0800 (PST)
Date: Tue,  2 Dec 2025 09:50:03 -0800
In-Reply-To: <20251202175043.623597-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202175043.623597-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202175043.623597-9-irogers@google.com>
Subject: [PATCH v9 08/48] perf jevents: Term list fix in event parsing
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

Fix events seemingly broken apart at a comma.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
---
 tools/perf/pmu-events/metric.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 31eea2f45152..0f4e67e5cfea 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -568,6 +568,12 @@ def ParsePerfJson(orig: str) -> Expression:
               r'Event(r"\1")', py)
   # If it started with a # it should have been a literal, rather than an event name
   py = re.sub(r'#Event\(r"([^"]*)"\)', r'Literal("#\1")', py)
+  # Fix events wrongly broken at a ','
+  while True:
+    prev_py = py
+    py = re.sub(r'Event\(r"([^"]*)"\),Event\(r"([^"]*)"\)', r'Event(r"\1,\2")', py)
+    if py == prev_py:
+      break
   # Convert accidentally converted hex constants ("0Event(r"xDEADBEEF)"") back to a constant,
   # but keep it wrapped in Event(), otherwise Python drops the 0x prefix and it gets interpreted as
   # a double by the Bison parser
@@ -586,7 +592,6 @@ def ParsePerfJson(orig: str) -> Expression:
   parsed = ast.fix_missing_locations(parsed)
   return _Constify(eval(compile(parsed, orig, 'eval')))
 
-
 def RewriteMetricsInTermsOfOthers(metrics: List[Tuple[str, str, Expression]]
                                   )-> Dict[Tuple[str, str], Expression]:
   """Shorten metrics by rewriting in terms of others.
-- 
2.52.0.158.g65b55ccf14-goog

