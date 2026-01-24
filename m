Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB90EADC
	for <linux-perf-users@vger.kernel.org>; Sat, 24 Jan 2026 00:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769213785; cv=none; b=RFDGaehtr0SKipa0H4HsaTK/tZoAeMRDyCtsPBN2Hfs7DpgTx4q86dWNsSQoD3EvnUK7eJtKp9VwBBEgUaSeFlAZXQUbpxvf4HOEBIVmATD4O3x/QmxhqUkSlKwEG5ZlpyE9/fy2oWCqQTS3FAoo4l8QCXPUhM6nGUwsSWCW5z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769213785; c=relaxed/simple;
	bh=WWbTmbdSLorrseRj7mprNfnA5YwkHHLrYNGP7YB9W+A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=N3rV+cYQ0gbc853VHYEE5egu/EsR3Ue+qBWK/1jSHBBD2I+xOSB06IWXwPdj0UNxdX+nGo9H5NtqmhcuxH6oIdGOvCUcS5fgcmdYhGwTiYb2hwXEvsNgY0w9CJNIMdC61y3M3sQqclufl2WvPDbCPiRoHHqxpWj3B2WnwSPwnD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VyphcaEH; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VyphcaEH"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b74766fae7so939591eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jan 2026 16:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769213783; x=1769818583; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hsppo8YRwJ65Q6pcz9zCc1oZe5VMY/WbrSPn1MsLzfk=;
        b=VyphcaEHqNg8eypULshX/PW/OboFx616JpyqJMIBq2lQSfYzPxIsr8LBerEk4DnOEz
         GWnaAsWxiJIBcs3/aARmI1wcolUJ6q92JdE/jFsUdUD/VSVNuqSVExNYqlY838xAuXuP
         1hcwKr+fMeTV1QW6KHInzmES/t5q7yqukINjGPa7E5v8J808SWpG00AumfZMJdcxGqDP
         shUQg3ZkSz1ikwh9chOA+AovEnm6DXZOKI85c8bZZkOfB5dgfapmOaE8adDhFuYmGzs2
         O64Vgs/tTi6IvXyDVMYVI8jj5h3X5wHGhDWsjXLeHXP9NoA1fwgsklv7yw2lVQF+hh4y
         pwLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769213783; x=1769818583;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hsppo8YRwJ65Q6pcz9zCc1oZe5VMY/WbrSPn1MsLzfk=;
        b=hCywhO9MOpLMbcLmMM5EODHqHgPkxPgVXMF3tYNjQ/rru80sitkuu3MdLILNWUiJrQ
         ZSxcvGtsx5EE6qon9ILI6LU3pPn0sKirn2mYGso4Qht5affGFObFYGyUYOKob82SRBDt
         NWMmcg7ltB6/80tHsC+LYIWYTNX+IhDikL/maX/wXWsX9YlJJiV2tqMnY2Ek/upi1bMo
         YoE2bImSiC8DBYLLvLmlunhOxuIn8tjL1S9Vj0S5lW90zEE6SifVkNQhENvdDPgG+qAp
         Gj/4fZbEJToOhbTzYhSDHEnCYQpgzBpteS72ERJ/u+HgO3pMvnk9SmHBhKa776BmWO8e
         ykAg==
X-Forwarded-Encrypted: i=1; AJvYcCUdvzjtTUd+1Yc4p5+1Ze5GsmPTZAP1OEHDkdTGYalHqxdETajusTdF0I4Uv6BuwA7CErBplk3Sw2xJSYavuGWL@vger.kernel.org
X-Gm-Message-State: AOJu0YzhUcYkpEnsj2tMIiI1OY33TzlciE7a1Uxk8LjRwpYYadAAR8dJ
	ykwSSowyZ4Ua4OloWxcIt1T3DzyS/MMSE3tCGbbf9Vt+zd4nfajVkmYgsGwEeN/EThmPjBae4bW
	oB4GlumMfQw==
X-Received: from dybpt23.prod.google.com ([2002:a05:7301:4097:b0:2b6:f58c:f252])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:fa84:b0:2b7:98d:7b54
 with SMTP id 5a478bee46e88-2b739992976mr2667626eec.14.1769213783002; Fri, 23
 Jan 2026 16:16:23 -0800 (PST)
Date: Fri, 23 Jan 2026 16:16:11 -0800
In-Reply-To: <20260124001611.1332019-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260124001611.1332019-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260124001611.1332019-4-irogers@google.com>
Subject: [PATCH v1 3/3] perf thread-stack: Switch thread_stack__init to use e_machine
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Shimin Guo <shimin.guo@skydio.com>, 
	Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@arm.com>, Yujie Liu <yujie.liu@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The architecture type is used to set the retpoline state. Rather than
use the arch string switch to using the ELF machine that's readily
available within the thread.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/thread-stack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index c6a0a27b12c2..dac76d03f741 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -157,10 +157,10 @@ static int thread_stack__init(struct thread_stack *ts, struct thread *thread,
 
 	if (thread__maps(thread) && maps__machine(thread__maps(thread))) {
 		struct machine *machine = maps__machine(thread__maps(thread));
-		const char *arch = perf_env__arch(machine->env);
+		uint16_t e_machine = thread__e_machine(thread, machine);
 
 		ts->kernel_start = machine__kernel_start(machine);
-		if (!strcmp(arch, "x86"))
+		if (e_machine == EM_X86_64 || e_machine == EM_386)
 			ts->rstate = X86_RETPOLINE_POSSIBLE;
 	} else {
 		ts->kernel_start = 1ULL << 63;
-- 
2.52.0.457.g6b5491de43-goog

