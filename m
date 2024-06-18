Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2A513E409;
	Tue, 18 Jun 2024 09:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718701440; cv=none; b=o/Yvcuvx9syRI6GSi5x6NCmwFCvU3EGGW/GaabIFYVaH01wpTdPlwHkRyKHyjtLbFZvATuj5DzZ4tiIrZ3gEkOLasKyZMnArbbxSp3OqGnvIPDU0OAkmdjRSRxMz5SRsPdw0iXKFlrck3+eCHUJxNyygCSuQIaB/dRYZnGEb6fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718701440; c=relaxed/simple;
	bh=vefXbGeJdPIvENDyRQo17aQ8NCFLYyc/5GKpV7uIpYI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c93Ve7YM3uSFJpBJw24SVVogXSrjn73c5QxGABiJpjigyOyZfS85H5TqbhvKuuPMhZ7hT+7TGpNum3pffeojpqY6+Dtc4StXLZ79PeMkRdZeIdtnAzuFAVaLBIqztJcBcmqQxveXGJCdQrmOSF3lBuWaQoaPiUm4bZ8vX4R+NrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=aHeM5v2l; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="aHeM5v2l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718701439; x=1750237439;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bNDTRFEKlbYQFPQMd1+UosdGEs67m2Vv8F+NJg42PvI=;
  b=aHeM5v2ltMP0WlQsynDcFvPOY3W3Sapikl2hP5/M2nflJ1cKFcnVI6bY
   mNd5823s+g3l90HyCLhDiCNTm5PSzlxxdpzOGdbef+R6LFfj7tcUoeaBn
   b/1Su/ScXvIy7+2vJWWJQRD13Pp16yATb1eGz7LHD4CY69axhMq1qdDpP
   c=;
X-IronPort-AV: E=Sophos;i="6.08,247,1712620800"; 
   d="scan'208";a="302914693"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 09:03:53 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.43.254:39172]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.7.69:2525] with esmtp (Farcaster)
 id bc0d0a33-86a4-49f1-a45c-94677853709e; Tue, 18 Jun 2024 09:03:52 +0000 (UTC)
X-Farcaster-Flow-ID: bc0d0a33-86a4-49f1-a45c-94677853709e
Received: from EX19D003EUB001.ant.amazon.com (10.252.51.97) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 18 Jun 2024 09:03:51 +0000
Received: from dev-dsk-sieberf-metal-1a-7543e84d.eu-west-1.amazon.com
 (172.19.116.227) by EX19D003EUB001.ant.amazon.com (10.252.51.97) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 18 Jun
 2024 09:03:49 +0000
From: Fernand Sieber <sieberf@amazon.com>
To:
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Fernand Sieber <sieberf@amazon.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Madadi Vineeth Reddy
	<vineethr@linux.ibm.com>
Subject: [PATCH v2] perf: Timehist account sch delay for scheduled out running
Date: Tue, 18 Jun 2024 11:03:39 +0200
Message-ID: <20240618090339.87482-1-sieberf@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB004.ant.amazon.com (10.13.139.134) To
 EX19D003EUB001.ant.amazon.com (10.252.51.97)

When using perf timehist, sch delay is only computed for a waking task,
not for a pre empted task. This patches changes sch delay to account for
both. This makes sense as testing scheduling policy need to consider the
effect of scheduling delay globally, not only for waking tasks.

Example of `perf timehist` report before the patch for `stress` task
competing with each other.

First column is wait time, second column sch delay, third column
runtime.

1.492060 [0000]  s    stress[81]                          1.999      0.000      2.000      R  next: stress[83]
1.494060 [0000]  s    stress[83]                          2.000      0.000      2.000      R  next: stress[81]
1.496060 [0000]  s    stress[81]                          2.000      0.000      2.000      R  next: stress[83]
1.498060 [0000]  s    stress[83]                          2.000      0.000      1.999      R  next: stress[81]

After the patch, it looks like this (note that all wait time is not zero
anymore):

1.492060 [0000]  s    stress[81]                          1.999      1.999      2.000      R  next: stress[83]
1.494060 [0000]  s    stress[83]                          2.000      2.000      2.000      R  next: stress[81]
1.496060 [0000]  s    stress[81]                          2.000      2.000      2.000      R  next: stress[83]
1.498060 [0000]  s    stress[83]                          2.000      2.000      1.999      R  next: stress[81]

Signed-off-by: Fernand Sieber <sieberf@amazon.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
---
 tools/perf/Documentation/perf-sched.txt | 4 ++--
 tools/perf/builtin-sched.c              | 5 ++++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
index a216d2991b19..74c812f7a4a4 100644
--- a/tools/perf/Documentation/perf-sched.txt
+++ b/tools/perf/Documentation/perf-sched.txt
@@ -64,8 +64,8 @@ There are several variants of 'perf sched':
     
    By default it shows the individual schedule events, including the wait
    time (time between sched-out and next sched-in events for the task), the
-   task scheduling delay (time between wakeup and actually running) and run
-   time for the task:
+   task scheduling delay (time between runnable and actually running) and
+   run time for the task:
     
                 time    cpu  task name             wait time  sch delay   run time
                              [tid/pid]                (msec)     (msec)     (msec)
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

