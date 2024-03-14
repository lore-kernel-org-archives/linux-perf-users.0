Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7992D179AA
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Mar 2024 05:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395498; cv=none; b=IVB9EJzwPtsP4QsY/zM8D1oFn95ajPecxbqZtmreA9XT1vpIxP8NnSOsInuEQW788DtJDKofSAlB2t7ZGMPC7i1seQSnY9KMxbNe42U8+ni5qspOxlN4q2ULiByuTvSSj0zTheiGBOYQ2cs28vt8IBsKGIeqnWVijmv5SmRAbmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395498; c=relaxed/simple;
	bh=m3oJ0mXN32pvFxa3HNuzQht4jUNMZshZlST6PBRItUc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=RUlKhu4Qda+b8XOTNOZcslseAuROebqVMReR4uXp1Y8dV2WtvhTc0IyG+8o95vgUqc7VN5aRnsQdvIj9MjshkjoFsGf6CttwtcCkjrRlshMFP5cnXuYbDQWxsLIYUC338ivNr0RMMVgZ3Zfx9gx600y8gRtlFeRDlGRV8+bZy14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wlMR0Pop; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wlMR0Pop"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a61b31993so11435627b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Mar 2024 22:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395496; x=1711000296; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zYw1KIQafOm2w25j3LEBCqeBTh5wSLQ0jlgOzqEYYIQ=;
        b=wlMR0Pop1j8JYxBfzSXjMMvy+j7dluxnoLdwqXqpBrtWlEaYyszYe3EGcQ23DAgb6V
         ODBx6FIjIR1hYFnnkwECpl+eTu6ErVVXrA3chzOJjp/XJQkA8PhSRYnuOt7/V/Scw6nB
         J+vARhXe0CxMZkzWtHobBmMl9+7Z4aM6jXW22CUfbaBWbia5eKdUM3YVZJGIihV07nJG
         Y9I5rSt6wVacnABY+wKiHMIQUkioN82xePZnPxy9wEoU3u3QXb0qADfvhhWPIbVBi87J
         0CMTmLGiFtAwJcRi3Wk8fFy+8dg0BY1di3wLkBJ80lWTF39VJRNS6E8Ezg/iM8KnwFpB
         hqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395496; x=1711000296;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zYw1KIQafOm2w25j3LEBCqeBTh5wSLQ0jlgOzqEYYIQ=;
        b=JHZI+x24EwWM0EpLFUHL4jtopyoXiSX1me5WqTuke0NqKpanv9ayV2nMQYS0Gw1CRF
         kHEqozD3iaQBxFVXTxy0X59i77dpop92RL8Nt7MImGhkU6I7SyG6qPBnU4SWJz3pP+h+
         UF7EdDtZRcEeUZ484i4T/9Y3uFW917RFGAMZV76F+/GM61nkjjr/j1ogdObtzYi9bAbk
         d/QkpK3P0mLrHhZCrcQw/kY5K+XbhcH3Wx0O1INzaK/LUKrAKe0b4D3QmXWJFXH8bDjv
         Av4x/wu0mIsZufBm2I0qNsFtF1jtLCk/8BrVsWNPbRa/ZujDmmIMspKzJYlb84WsEhZT
         XJFA==
X-Forwarded-Encrypted: i=1; AJvYcCXPVYye2/UFCAmOxTSIDnkZv9JdidO0a0esGBAhqeu1rFktA9/G+31VmXPHuWl4ZwzeaBIvS4wm9tQQbMoTQpXqnVJUudDfKIU/JXUAdNr72Q==
X-Gm-Message-State: AOJu0YzDvzaARPJO0zOMExqFZijLqaZ5wV6AoE6cYSxgdTgdf74cI7Gv
	uANifIHKVnBm10Mqd3+pOhGGYF68jZUg3Pl7AEiqXnCay5lh6xc3gnCNmewWZvhNQUZGfUeC/DX
	Nxhi5Cg==
X-Google-Smtp-Source: AGHT+IHufyxlOBu5xph3k0/I1Hku98LKXxQohgESnL4gnpB414LdzU0/xLhN44SUjZnXQdXfOyq0giwBG1f7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a81:848c:0:b0:60a:e67:2ed0 with SMTP id
 u134-20020a81848c000000b0060a0e672ed0mr178750ywf.9.1710395496481; Wed, 13 Mar
 2024 22:51:36 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:50:48 -0700
In-Reply-To: <20240314055051.1960527-1-irogers@google.com>
Message-Id: <20240314055051.1960527-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055051.1960527-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 09/12] perf jevents: Drop duplicate pending metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Sandipan Das <sandipan.das@amd.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Drop adding a pending metric if there is an existing one.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index f68b0a60cdef..23f9809b3850 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -473,7 +473,7 @@ def add_events_table_entries(item: os.DirEntry, topic: str) -> None:
   for e in read_json_events(item.path, topic):
     if e.name:
       _pending_events.append(e)
-    if e.metric_name:
+    if e.metric_name and not any(e.metric_name == x.metric_name for x in _pending_metrics):
       _pending_metrics.append(e)
 
 
-- 
2.44.0.278.ge034bb2e1d-goog

