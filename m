Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B0014B940;
	Thu, 13 Jun 2024 18:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718305167; cv=none; b=AvnxkFMveDetvtLYmn80DA2dAlv+1zzHPJxAjuqGJ6QW3jIauM7qWvBZTrbTJW0TfjtWe+i8oe8VGM9aKaroHl4GxZ4vIOYXqkmiqfkeuHd9UIgKLfbZ7lKGSzOfLhyy6vTjfF4VS5ZM3sAKHKxKCL9QgS9gbaVh2TyeDztFHr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718305167; c=relaxed/simple;
	bh=vPLJ9VO2OwjePKfm/RD1Jf4UJD2pe+98eneais0GIgM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ExcaiF55QqEC30/IB6MVSYu8TCfb4qstohedhXvCa8r/2yrnkWz9zIHXshAyZIgQBHgAvxxgU/Ep7qVNUNcaQk+0kseycg4YSM3Bu0V9w9RaDt1Te4qNgJQUytmmWe1kNOtNf/bBc/xnfBJoPrGOTs39+qOyiQtjKrF6wghOe78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=pT0NWzDp; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="pT0NWzDp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718305166; x=1749841166;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O8KMWSJ8KFtSG9+awbHITiDt2oVfvJpz5b5eMcJmEkc=;
  b=pT0NWzDpLlmbL2zQN5mWTkK4s/5q5qzo0W3h3feiQptt0iDmkwRt5qeF
   wECGDBJ8oJXMS0zPaVLrjlnkc0WrRsTtv7itUxeaRrcrwDRO0mvr293nM
   BCUfO3OlvFJlRYVRDC7Phbweg5UhlVSJUCjd4oEir+fxIg1NVQzieqRjt
   s=;
X-IronPort-AV: E=Sophos;i="6.08,236,1712620800"; 
   d="scan'208";a="732753327"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 18:59:19 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.43.254:33168]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.1.254:2525] with esmtp (Farcaster)
 id cc8e812a-640b-47f3-927b-820ea38c403f; Thu, 13 Jun 2024 18:59:17 +0000 (UTC)
X-Farcaster-Flow-ID: cc8e812a-640b-47f3-927b-820ea38c403f
Received: from EX19D003EUB001.ant.amazon.com (10.252.51.97) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 13 Jun 2024 18:59:17 +0000
Received: from dev-dsk-sieberf-metal-1a-7543e84d.eu-west-1.amazon.com
 (172.19.116.227) by EX19D003EUB001.ant.amazon.com (10.252.51.97) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 13 Jun
 2024 18:59:15 +0000
From: Fernand Sieber <sieberf@amazon.com>
To:
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Fernand Sieber <sieberf@amazon.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH] perf: Timehist account sch delay for scheduled out running
Date: Thu, 13 Jun 2024 20:59:06 +0200
Message-ID: <20240613185906.31082-1-sieberf@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB002.ant.amazon.com (10.13.139.179) To
 EX19D003EUB001.ant.amazon.com (10.252.51.97)

When using perf timehist, sch delay is only computed for a waking task,
not for a pre empted task. This patches addresses this problem.

Example of `perf timehist` report before the patch for `stress` task
competing with each other.

First column is wait time, second column sch delay, third column
runtime.
```
       1.492060 [0000]  s    stress[81]                          1.999      0.000      2.000      R  next: stress[83]
       1.494060 [0000]  s    stress[83]                          2.000      0.000      2.000      R  next: stress[81]
       1.496060 [0000]  s    stress[81]                          2.000      0.000      2.000      R  next: stress[83]
       1.498060 [0000]  s    stress[83]                          2.000      0.000      1.999      R  next: stress[81]
```

After the patch, it looks like this (note that all wait time is now sch
delay instead of zero):
```
1.492060 [0000]  s    stress[81]                          1.999      1.999      2.000      R  next: stress[83]
1.494060 [0000]  s    stress[83]                          2.000      2.000      2.000      R  next: stress[81]
1.496060 [0000]  s    stress[81]                          2.000      2.000      2.000      R  next: stress[83]
1.498060 [0000]  s    stress[83]                          2.000      2.000      1.999      R  next: stress[81]
```

In timehist:
* wait time represents the duration waiting for any system resource
* sch delay represents the duration waiting for cpu system resources

This is based on perf comments (dt_wait = wait time, dt_delay = sch
delay):
```
/*
 * Explanation of delta-time stats:
 *
 *            t = time of current schedule out event
 *        tprev = time of previous sched out event
 *                also time of schedule-in event for current task
 *    last_time = time of last sched change event for current task
 *                (i.e, time process was last scheduled out)
 * ready_to_run = time of wakeup for current task
 *
 * -----|------------|------------|------------|------
 *    last         ready        tprev          t
 *    time         to run
 *
 *      |-------- dt_wait --------|
 *                   |- dt_delay -|-- dt_run --|
 *
 *   dt_run = run time of current task
 *  dt_wait = time between last schedule out event for task and tprev
 *            represents time spent off the cpu
 * dt_delay = time between wakeup and schedule-in of task
 */
 ```

The problem with the current logic is that last time is only set when
waking a task. Therefore it is not set for a pre empted task. To fix
this, we set last time to the current sample time if a scheduled out
task (on the switch tracepoint) is in state running.

Signed-off-by: Fernand Sieber <sieberf@amazon.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 tools/perf/builtin-sched.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 5977c49ae2c7..7422c930abaf 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2659,7 +2659,10 @@ static int timehist_sched_change_event(struct perf_tool *tool,
 		tr->last_state = state;
 
 		/* sched out event for task so reset ready to run time */
-		tr->ready_to_run = 0;
+		if (state == 'R')
+			tr->ready_to_run = t;
+		else
+			tr->ready_to_run = 0;
 	}
 
 	evsel__save_time(evsel, sample->time, sample->cpu);
-- 
2.40.1

