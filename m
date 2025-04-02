Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5C91C7009
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Apr 2025 18:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743619092; cv=none; b=aOROuDUY0BikLCxKGHL2QgF/RP0rEUTr7hX0DX0WhqYxYtUzQe0IVl6Nhq0JBTunDy9iJlSmxEMxXchpkK+u3JAFGsNt3OV42TQropXDYNvAmq6zeNNDLZ9UmpCJ+UA2fNJDjRkIhgOy0i4LHdOFBjgUD9w6SuUHVLtatzlG+vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743619092; c=relaxed/simple;
	bh=VJyj37G2ghu3v+1dV+6u3ScdAsa+4NlD+2+lGM0OC58=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=WGw47wErCn75+IKQdbX3eOTWRYEiC2lqJSs3cpKRX7cdm5JU3Rrkyk24I5KPEcLotxwxzYflNJfvOBBr87DYkMvDHE+ptFWeNwkiZLW4rLId4MY4cCCFWmLN5j7DHVhUcAEnMiazx57OK59kPV8kII021XBHAIWAmqQondcMMWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aIC9IzgW; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aIC9IzgW"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2242f3fd213so1016885ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Apr 2025 11:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743619090; x=1744223890; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iukw0jX+Qwid2MdJvGeNWnJ44BFv0T/trdIHKxCNDOA=;
        b=aIC9IzgWvsBv0jHfkGDlYZmtmJyIgu2w9dvNF/ml3ScCQb6820F2jOYTYOArkMaEjN
         Hy1xYR6Ranf0PkS9k0Ah3IKSMrjmTa0vT9zoeieb3QcwRRtjSissB9B13NmVthJlsSFI
         HhefUnqEt0WOCyq8TNK2vOoeqn5RbN0zxIfwwQ3QvmUF6AlKIteuM85NObrGihwCYqLb
         Fpu48RtoeC7cTDaYM+qLdfgn1+aEeP0+8gKwBAWgpMJXIY0PKSUqOroxqkbk3ATV1EXm
         +OftvjpXgrkVqLyfAhVvdj3DEgE9P66bgiyqaCEDVW36OTtTuWtpMaIKTsp01Ww4OS3/
         T0xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743619090; x=1744223890;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iukw0jX+Qwid2MdJvGeNWnJ44BFv0T/trdIHKxCNDOA=;
        b=ClpVUvkZXUaA14o8OOIp8FodiXy7zMuLMXg1zMpHj+bL9cTh4EeATCRLXCfmI3Wt1T
         ffuuFtjJSFBsB/5QtojXz6GuEtyg1Hje16i9T9sVlVhsgh0754eTiF0QS42B/T5FUjif
         7Pv/ZM4w7RsNYj0iYPTplyUkr36K6+NwoavtaSxSnf6b2r20EyV0iEcFreqfeAE+BFms
         fL+skaR/RPMhWUMm0zxB8q5eZYRKZXQ4O2hvOmGPrBQbm19G1O40JyEmMRr+d9Ic74U2
         po8QyubusswR3ZhTL/CaMg27Utf6mze20Y6FjfG+BaM5vGzMb4clCC6hDBUumv6KLfVY
         xQsQ==
X-Forwarded-Encrypted: i=1; AJvYcCV34YIJ3pqfKWLcZxXWUoeI5d6GAKgUFPr3S8k4ngZi5kEwQd50S8UlDRw7wC/AEcQoDyYd8easn6x0x0IerU6w@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs1LnxZSYtfTPjKSnFbT/NiqHJMEn+I4L8L9mo8GqnhWNe7OI8
	Bdv1+E/nUcqtb8e7C7VgkVAJSFpEDrI9gm0lJF0TTgKGK9/USTmaQHoRcgN+OXtqUHnlTMyO+lV
	SSmqxVQ==
X-Google-Smtp-Source: AGHT+IEAXrJH6hD+Ax+iKnsw/CNHugWggT1Ix+hdQDi4HVV9sKef5JZgdaPVNmvLFbPUA7h7mHG7Ilohncb1
X-Received: from plck11.prod.google.com ([2002:a17:902:f28b:b0:223:501f:f398])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ecd0:b0:224:f12:3735
 with SMTP id d9443c01a7336-2292f9889edmr253447075ad.31.1743619089981; Wed, 02
 Apr 2025 11:38:09 -0700 (PDT)
Date: Wed,  2 Apr 2025 11:38:06 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250402183806.3947021-1-irogers@google.com>
Subject: [PATCH v1] perf jevents: Allow duplicate metrics with different PMUs
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Xu Yang <xu.yang_2@nxp.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Falcon <thomas.falcon@intel.com>, Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"

On hybrid machines the same metric may appear for cpu_atom and
cpu_core as well as being referenced from other metrics. The same
named metrics are required but on differing PMUs are required. Update
the jevents.py to handle this.

On (hybrid) Alderlake before:
```
$ perf stat -M tma_fp_divider -a sleep 1
event syntax error: '.._ACTIVE!3/,tma_core_bound/metric-id=tma_core_bound/,tma_backend_bound/metric-id=tma_..'
                                  \___ Bad event or PMU
```

After:
```
$ perf stat -M tma_fp_divider -a sleep 1

 Performance counter stats for 'system wide':

     1,257,833,472      cpu_core/TOPDOWN.SLOTS/          #      0.0 %  tma_fp_divider
            45,870      cpu_core/ARITH.FPDIV_ACTIVE/
       187,096,541      cpu_core/topdown-retiring/
       199,533,380      cpu_core/topdown-mem-bound/
       107,164,806      cpu_core/topdown-bad-spec/
       214,281,782      cpu_core/CPU_CLK_UNHALTED.THREAD/
         1,588,539      cpu_core/ARITH.DIV_ACTIVE/
       538,842,818      cpu_core/topdown-fe-bound/
       431,005,264      cpu_core/topdown-be-bound/
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 36a5e5fa2a54..89f1ace2a697 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -481,7 +481,8 @@ def add_events_table_entries(item: os.DirEntry, topic: str) -> None:
   for e in read_json_events(item.path, topic):
     if e.name:
       _pending_events.append(e)
-    if e.metric_name and not any(e.metric_name == x.metric_name for x in _pending_metrics):
+    if e.metric_name and not any(e.metric_name == x.metric_name and
+                                 e.pmu == x.pmu for x in _pending_metrics):
       _pending_metrics.append(e)
 
 
-- 
2.49.0.504.g3bcea36a83-goog

