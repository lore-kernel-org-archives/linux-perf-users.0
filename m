Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC7F14659D;
	Fri, 14 Jun 2024 07:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718350538; cv=none; b=GHfVqSARLbI6ciY6hrr3r+hE1EgBYyH2mwnHd8AMJHp34zYWA4sUW65dWFVA5hC0t8AIWcEgoRPJ/9zd5R+5K43bzVT4MvwRL7810iLh8DkkLMenDx/Bf83EKDecqSQAFz37Stpjr6M9EzEXYd7DUFE20gFPJ4pkxr+MTQaLL7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718350538; c=relaxed/simple;
	bh=zzbz9Wanpkr35AX5R0+HsXH0pco4+GUM0zXv7LOp2R0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cyixTf9V0gH1bSG5kjn2E9ldgl3t7NQsXyC4o6+67IRyCkgR/Amz1JJRo88HZXoKV2rcGSykcoCvFWvmzCdGLHZgSQwzlOviFgWiXubARt43Sx4XAx1a6d4p5TzQwm/2jMy4ZDGTvP5FwGMYHpz+aI35/HFJu/W3wHlnD+aX2Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=mQoUF+6C; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mQoUF+6C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718350538; x=1749886538;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=P7p3pFfy9IomOWnf8uMXjciduYMrQ/Z31QJee1iffv4=;
  b=mQoUF+6CXvTY47t23t19UvwgiJCiHc7PP5wCzKAL3hd9nWNECBsyDFmj
   ejQ3GKu92mUaqWmZRa0KYTBrA1q9XIqZVIAyoOmS8PKfTpjBP05oWGmEQ
   V3rWfB4+ohWEYJj46SWK3LRMYjdvDndHB4IbSyR6uB4ijpXlI5+2nsuzi
   o=;
X-IronPort-AV: E=Sophos;i="6.08,237,1712620800"; 
   d="scan'208";a="413389174"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 07:35:35 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.10.100:45130]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.7.69:2525] with esmtp (Farcaster)
 id 6930515c-e5e5-4621-a4ba-ecf3e8a0f2ba; Fri, 14 Jun 2024 07:35:33 +0000 (UTC)
X-Farcaster-Flow-ID: 6930515c-e5e5-4621-a4ba-ecf3e8a0f2ba
Received: from EX19D003EUB001.ant.amazon.com (10.252.51.97) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 14 Jun 2024 07:35:33 +0000
Received: from dev-dsk-sieberf-metal-1a-7543e84d.eu-west-1.amazon.com
 (172.19.116.227) by EX19D003EUB001.ant.amazon.com (10.252.51.97) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Fri, 14 Jun
 2024 07:35:30 +0000
From: Fernand Sieber <sieberf@amazon.com>
To:
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Fernand Sieber <sieberf@amazon.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH] perf: sched map skips redundant lines with cpu filters
Date: Fri, 14 Jun 2024 09:35:17 +0200
Message-ID: <20240614073517.94974-1-sieberf@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC001.ant.amazon.com (10.13.139.213) To
 EX19D003EUB001.ant.amazon.com (10.252.51.97)

perf sched map supports cpu filter.
However, even with cpu filters active, any context switch currently
corresponds to a separate line.
As result, context switches on irrelevant cpus result to redundant lines,
which makes the output particlularly difficult to read on wide
architectures.

Fix it by skipping printing for irrelevant CPUs.

Example snippet of output before fix:

  *B0       1.461147 secs
   B0
   B0
   B0
  *G0       1.517139 secs

After fix:

  *B0       1.461147 secs
  *G0       1.517139 secs

Signed-off-by: Fernand Sieber <sieberf@amazon.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 tools/perf/builtin-sched.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 7422c930abaf..aa59f763ca46 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -1594,8 +1594,6 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 
 	sched->curr_thread[this_cpu.cpu] = thread__get(sched_in);
 
-	printf("  ");
-
 	new_shortname = 0;
 	if (!tr->shortname[0]) {
 		if (!strcmp(thread__comm_str(sched_in), "swapper")) {
@@ -1622,6 +1620,11 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 		new_shortname = 1;
 	}
 
+	if (sched->map.cpus && !perf_cpu_map__has(sched->map.cpus, this_cpu))
+		goto out;
+
+	printf("  ");
+
 	for (i = 0; i < cpus_nr; i++) {
 		struct perf_cpu cpu = {
 			.cpu = sched->map.comp ? sched->map.comp_cpus[i].cpu : i,
@@ -1656,9 +1659,6 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 			color_fprintf(stdout, color, "   ");
 	}
 
-	if (sched->map.cpus && !perf_cpu_map__has(sched->map.cpus, this_cpu))
-		goto out;
-
 	timestamp__scnprintf_usec(timestamp, stimestamp, sizeof(stimestamp));
 	color_fprintf(stdout, color, "  %12s secs ", stimestamp);
 	if (new_shortname || tr->comm_changed || (verbose > 0 && thread__tid(sched_in))) {
@@ -1675,9 +1675,9 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 	if (sched->map.comp && new_cpu)
 		color_fprintf(stdout, color, " (CPU %d)", this_cpu);
 
-out:
 	color_fprintf(stdout, color, "\n");
 
+out:
 	thread__put(sched_in);
 
 	return 0;
-- 
2.40.1

