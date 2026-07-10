Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF4035A38C
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 02:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783651804; cv=none; b=Yke3UPUhSJMcPWIerwDhAAGEIsdIuQsvSmaCKGpdpWnll728B5dd4YbTHDhfF+oqHOcRVSUt5CgEq4V1i79cqClTuRMfkNkk0oMvj7W0Nghrw01X8M+THy7CDmQZBpguHnUloxQxVwe7dmSomyiKxfW2Bv4dWxeBtsfOfamNfXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783651804; c=relaxed/simple;
	bh=IqknZSNIESiClPyUKG+XM7izvJ+UhdzmScQvF7+IwMQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U2XiqHMxS3kGdOhl//8IbQrls+s8cDd3Lb0ijdPrPvToT/qYpeigOeF20zvrROMMGEPqMdYBwdS/PSMXPen6oJVejaEQ+Fn+M5O09+912rqaB4/GCg3aEKQOhw+/qHuBvn2pWm/umxhoFnRAjGOIuDYcQqCDbngh/PKV0ZjQsT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jzQ0bzRx; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jzQ0bzRx"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8895156101so816302a12.1
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jul 2026 19:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783651803; x=1784256603; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NIrFAvTZk0vE/gCD5TjPieqCknw/UUGjvHNHj4XvZbI=;
        b=jzQ0bzRx76e9WRDMP2p5ItHrnjO9xAsffgpCICQgfsexWLd6+GoSp3jV3yc5HP/OzJ
         tBvE8mv1d1Kl8g/J8T2kWFNNi/1S3UnnRU3cuX3ZRFbApHcDqPV5R+uDDOt5dsf2MnzI
         L538L48nQt3FfBakYBI4i7pGBhJwQDgUwtKUGRy8TNr3UmdOi8OxAQDClkzQLAzCBpiY
         eHgiB4uOYTcnA06dmtz0LzJXmbbWBxhhiPJwhCwvACKZQeLB3Nc+arnoJQysPHQ6ovkj
         DxnPCX+KrkwO2Nh7EtwAiBZxVt0C3kZhXVn4zLfCXI8o4ce7CmXYcdoCNkCPBBzc27ov
         UDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783651803; x=1784256603;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NIrFAvTZk0vE/gCD5TjPieqCknw/UUGjvHNHj4XvZbI=;
        b=G5/WdD9L9yf2kzBLCmYmUxWOXDQ35VeBoR5NkrO/O1hqcY4nYPrW1mF3+GKXkZuLBS
         bk7rZdEWq1CnV7gSmdOleB3oqSAMtf9nGGY1KWh3LhGlTaNOGK2g5eYCLhwN6YsJdrFP
         SXDogAtc0RD9NL0eXPvWlsKEDsm8nRggCckRmPK2R6e+uXG3mH/pxhQneUbRIdv+5UPQ
         djCWqEfDtt53IL5XBuX5mnKIPYN7b/Yh7nhDO7B1jKWnYEjykXrHQgKZMWegNF9QuCFx
         mx/+bt4/Z/8aEcwsLFAR7Ujztz4qkk2QC2STsGMVfpvocxN26MkH19Vge3foQK1hv3ET
         +9vQ==
X-Forwarded-Encrypted: i=1; AHgh+RpAkOvG7gdUL/YVHhHuN67Hx6lWLbYmfDbCiGpA11ke4LsvAzyC1wj3kxEE4h1ZGvMI9CEG93F8ceNPpdyucgyz@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5yBPPO2Sg4MbBGdPMz1knIRjxfnDpxS0VadP8bQmXrWYDuVWj
	nEd7VuKrZB8Mx03GFfxDBQ/Be/osLHvMuJs3Bn9JLKIayOapC3Jb03uoT6TMtCY+l526YX13cZc
	0u3SukoEp/Q==
X-Received: from dybme4.prod.google.com ([2002:a05:7301:1884:b0:30c:a5af:7269])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:12d2:b0:3bf:7fa5:8922
 with SMTP id adf61e73a8af0-3c0bcf48fa9mr12314515637.2.1783651802717; Thu, 09
 Jul 2026 19:50:02 -0700 (PDT)
Date: Thu,  9 Jul 2026 19:49:45 -0700
In-Reply-To: <20260710024952.1668911-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709165220.1411149-1-irogers@google.com> <20260710024952.1668911-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260710024952.1668911-2-irogers@google.com>
Subject: [PATCH v4 2/9] perf ui hists: In report UI ensure thread is set
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, jistone@redhat.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tianyou.li@intel.com
Content-Type: text/plain; charset="UTF-8"

This commit populates the map_symbol thread in the UI code to fix the
e_machine lookup for cross-platform disassembly when using the annotate
action.

(Note regarding ui/browsers/hists.c: For the popup_action array, we
intentionally do NOT use thread__get() or map__get() when assigning to
ms.thread and ms.map. The actions array has a strictly bounded lifecycle
that does not outlive the menu loop, making raw pointers safe. If we
took references, we would have to clean them up (e.g., via
map_symbol__exit()), which if erroneously applied to raw pointers would
incorrectly drop references owned by the caller and lead to a use-after-
free.)

Fixes: 0e26ba5a8774 ("perf disasm: Refactor arch__find and initialization of arch structs")
Reported-by: Josh Stone <jistone@redhat.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/browsers/hists.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 6163cc3ace27..6edea27f4f30 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3155,10 +3155,12 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 						continue;
 
 					actions->ms.sym = symbol__new_unresolved(bi->to.al_addr, bi->to.ms.map);
+					actions->ms.thread = bi->to.ms.thread;
 					actions->ms.map = bi->to.ms.map;
 				} else {
 					actions->ms.sym = symbol__new_unresolved(browser->he_selection->ip,
 										 browser->selection->map);
+					actions->ms.thread = browser->selection->thread;
 					actions->ms.map = browser->selection->map;
 				}
 
@@ -3173,6 +3175,7 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 					continue;
 				}
 
+				actions->ms.thread = browser->selection->thread;
 				actions->ms.map = browser->selection->map;
 				actions->ms.sym = browser->selection->sym;
 			}
-- 
2.55.0.795.g602f6c329a-goog

